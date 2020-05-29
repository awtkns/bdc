---
title: Early Detection of Breast and Prostate Cancer in Countries with Varying levels of Development
subtitle: STEM Fellowship Big Data Challenge 2020
authors:
    - Fedrigo, R,&nbsp;
    - Haid, E,&nbsp; 
    - Watkins, A,&nbsp;
    - Winata, H
affiliations:
    - University of British Columbia
    - Simon Fraser University
    - BC Cancer Research Centre
date: May 29, 2020
---

## Abstract
This paper aims to investigate how availability of early detection procedures for breast and
prostate cancer impact countries with different
stages of development. Despite being one of the
most prevalent types of cancer globally, the epidemiology of breast and prostate cancer varies
greatly between low- and high-income countries.
Datasets are obtained from gapminder and the
World Health Organization (WHO) databases.
Countries are initially categorized based on their
development stage, which is then correlated with
the availability of screening or early diagnostic
procedures.

Keywords: Cancer, Early Dection, Public Health

<chart slug="2" />

## 1. Introduction
As the life expectancy of the world population
increases, complex and chronic diseases such
as diabetes, heart disease, mental illness, autoimmune disorders and cancer become more
prevalent. The demographics of certain countries, such as Canada, Japan, and BLANK, have
shifted towards older populations, and thus cancer becomes a greater health burden every year.
In 2018, the cancer mortality rate was estimated
to be approximately 9.6 million globally, with
approximately 70% of deaths occurring in low
to middle income countries [1].

In addition to the high mortality rate associated with cancer, these diseases also pose a significant burden to health care systems and the
economy. In 2015, the direct cost of treating
cancer in the United States, which devotes significant resources towards treating the disease,
was estimated to be $80.2 billion [2]. In contrast,
developing countries are historically adapted towards treating infectious and parasitic diseases,
and thus are not as well-equipped to treat diseases such as cancer, which requires extensive
and long-term interventions [3].

While evaluating the effects of cancer, it is critical to acknowledge that the term is used to broadly refer to over 200
distinct and heterogeneous diseases [cite]. Some types of cancer are associated with poor prognosis and low rates of 
survival, while others are slow-growing and easily treatable, if detected early.

Most developed countries have adapted various methods of prevention, screening, and providing early diagnosis of cancer. Prevention
focuses on limiting risk factors such as smoking, radiation, and carcinogens. For example,
many governments have implemented vaccinations to limit the spread of human pappillomavirus (HPV), a virus directly linked to cervical cancer [4]. Meanwhile, screening and early
diagnosis are part of the early detection strategy, shown to have increased the 5-year survival
rate in the U.S. between 1970-77 and 2007-13
[5]. Screening procedures involve applying simple tests on general population so that diseases
can be identified before symptoms manifest. At
the very least, screening procedures aim to diagnose individuals with cancer at earlier stages,
and improve the likelihood that the cancer is
treatable. Overall, screening measures involves
educating the public to recognize early cancer
symptoms, and provide the diagnostic procedures and technology to confirm cases.

Breast and prostate cancer are the most
prevalent cancer diagnosis for females and
males respectively, and contribute significantly
to cancer-related deaths of each sex, following
lung and colorectal cancer [5] [6] [7]. Breast
cancer can be screened using mammograms,
while prostate cancer is detected by measuring
prostate-specific antigen (PSA) in urine. Survival rates of these cancer depend significantly
on time of diagnosis as response to treatment
inversely correlated with disease progression [7].

..continues

## 2. Methods
pick cancers that benefit most from early
detection and have a fairly easy screening
method 1. categorize countries based on level
of development based on gdp and income per
capita. 2. separate countires with cancer prevention policies, screening and early detection 3.
compare incidence and mortality rate between
countries
The datasets used in this paper were obtained
from the gapminder and the Global Health
Observatory (GHO) database, provided by the
World Health Organization (WHO). Data sets
were selected to provide insight on development
level of each country, the availability of screening and early diagnosis measures, and cancer
statistics.
The Human Development Index (HDI) was
used as a proxy measure for development. [8]
and economic growth, extrapolated from Gross
Domestic Product (GDP) and Gross National
Income (GNI) per capita [8]. These datasets are
used to categorize countries into levels of development.
1. Plot HDI vs GNI/GDP per capita to ensure
correlation
3
2. plot GDP and GNI percapita vs countries
and calculate mean, median, SD, 95% CI
3. categorize countries
Availability of screening and early diagnosis
procedures in each country is investigated differently for breast and prostate cancer. Existence
of national screening program for breast cancer
[9] and number of labs providing genetic testing
for disease markers [10] are used to track availability for breast cancer screening. For prostate
cancer, the number of imaging technology (MRI,
PET, SPECT, etc.) per capita [11] are obtained
for each country as a measure of the availability
for early diagnosis.
1. Plot HDI/GNI/GDP to various screening
methods
2. plot number of labs to medical devices
3. plot diagnostic/treatment devices –> infer
country priority/approach on cancer
4. categorize countries further
The number of new cases and deaths for females and males in each country are obtained
for breast and prostate cancer respectively [8].
1. Plot mortality/incidence over time
2. plot average m/i for countries with different
econ category
3. plot average m/i vs diagnostic/treatment -
negative correlation means more diagnostic
= better survival, vice versa
This is where you talk about the methods used
to carry out the study. Be as concise and tothe-point as possible, and remember - do not
justify your methods here! You simply need
to state what you did. You can (and probably
should) mention the purpose of using a certain
computational tool within the context of what
you set out to achieve, but mentioning things
like ’it’s particularly efficient at this and better
than all competing computational tools’ is unnecessary in the methods section. However, you
can definitely talk about all of this in the discussion, and talk about why your methods are,
say, the most effective ones for the task.
Think of this section as a technical manual
of sorts, that another team of researchers could
read and easily follow in order to replicate what
you did to carry out this study.
Because of the straightforward nature of the
methods section, this might be the one your
team wants to write first. It’s essentially you
just documenting what your team has already
done, which should be no problem to write, since
you will already have an established workflow by
this point

## 3. Results
more formatting to do...

<script>
    import Chart from "../components/Chart";
    export default {
        components: {Chart}
    }
</script>
