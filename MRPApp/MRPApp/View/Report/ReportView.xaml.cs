using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace MRPApp.View.Report
{
    /// <summary>
    /// MyAccount.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class ReportView : Page
    {
        public ReportView()
        {
            InitializeComponent();
        }

        private void DisplayChart(List<Model.Report> list)
        {
            int[] schAmounts = list.Select(a => (int)a.SchAmount).ToArray();
            int[] prcOKAmounts = list.Select(a => (int)a.PrcOKAmount).ToArray();
            int[] PrcFailAmounts = list.Select(a => (int)a.PrcFailAmount).ToArray();

            var series1 = new LiveCharts.Wpf.ColumnSeries
            {
                Title = "계획수량",
                Fill = new SolidColorBrush(Colors.Green),
                Values = new LiveCharts.ChartValues<int>(schAmounts)
            };
            var series2 = new LiveCharts.Wpf.ColumnSeries
            {
                Title = "성공수량",
                Fill = new SolidColorBrush(Colors.Blue),
                Values = new LiveCharts.ChartValues<int>(prcOKAmounts)
            };
            var series3 = new LiveCharts.Wpf.ColumnSeries
            {
                Title = "실패수량",
                Fill = new SolidColorBrush(Colors.Red),
                Values = new LiveCharts.ChartValues<int>(PrcFailAmounts)
            };

            // 차트 할당
            ChtReport.Series.Clear();
            ChtReport.Series.Add(series1);
            ChtReport.Series.Add(series2);
            ChtReport.Series.Add(series3);
            ChtReport.AxisX.First().Labels = list.Select(a => a.PrcDate.ToString("yyyy-MM-dd")).ToList();
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                InitControl();
            }
            catch (Exception ex)
            {
                Commons.LOGGER.Error($"예외발생 ReportView Loaded : {ex}");
                throw ex;
            }
        }

        private void InitControl()
        {
            DtpSearchStartDate.SelectedDate = DateTime.Now.AddDays(-7);
            DtpSearchEndDate.SelectedDate = DateTime.Now;
        }

        private void BtnSearch_Click(object sender, RoutedEventArgs e)
        {
            if (IsValidInputs())
            {
                var startDate = ((DateTime)DtpSearchStartDate.SelectedDate).ToString("yyyy-MM-dd");
                var endDate = ((DateTime)DtpSearchEndDate.SelectedDate).ToString("yyyy-MM-dd");
                var searchResult = Logic.DataAccess.GetReportData(startDate, endDate, Commons.PLANTCODE);
                
                DisplayChart(searchResult);
            }
        }

        private bool IsValidInputs()
        {
            var result = true;

            if (DtpSearchStartDate.SelectedDate==null||DtpSearchEndDate.SelectedDate==null)
            {
                Commons.ShowMessageAsync("검색", "검색할 일자를 선택하세요.");
                result = false;
            }

            if (DtpSearchStartDate.SelectedDate > DtpSearchEndDate.SelectedDate)
            {
                Commons.ShowMessageAsync("검색", "시작 일자가 종료 일자보다 최신일수 없습니다.");
                result = false;
            }

            return result;
        }
    }
}
