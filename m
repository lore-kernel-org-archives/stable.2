Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA034334C4
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926355; cv=none; b=PEYPmfO4r/cIO8YvYZpqiJr83fL3YLR3UWImO2X1/j9xduZcGqW0OnerFq2ApeLSCZmrQizyBHq3hGcpOpCVMDU1cu5QC22fLsgNelNQTv/nU+Hm/Cq9uVM/cVrUHuK+R+QMu8omH00Gtmjm3WLzauzE8XkqfDSaXnt23tENT3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926355; c=relaxed/simple;
	bh=SHxFqh3KKGoWhw+nZUAOqRVbbm4gWkR3/f9tFNiz5P0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OnmK+HAeAtsid18arsVT4H+pl5I4uCx/nMhSOU351jou/CtDSTJTusvlF6bZVfW5OlLFgdhLx8ynyibRRchUBqSCNEdpNZe5bxad0sIe4L6ny0BOn13Ym5bRit+RHn9YnIE/3jsORZoNARjM04RTxkyb/Vf2ktlxwJFwBk9scCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fP7okPJJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BZ9bYRTe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fP7okPJJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BZ9bYRTe"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6925jEvU1068088
	for <stable@vger.kernel.org>; Fri, 2 Oct 2026 07:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IWtuB6bAcJMUnuKNd0QkWFAs6+jCv3PnTXcHMb6ywZ4=; b=fP7okPJJVBcQ4mF1
	3eeM/ewB9X79lsunlyHvPn8QuHvzrEiYdPCXqUdVxXCSB9yy4i3VeIXkI+wDzKnS
	ajNWwQu9RF1JZFCks7NebQpAkvEFNCT7B2J8WR1UQNK2V9X5G0j92IxAoT44kaOz
	iZbbzD3yJKj4UaH+Q4nLVQ+qi5V6Rd5iLMFxXLEnCOGBcFH4PeC9oa8AD/JFWlJM
	BySHyLKz1Bzj2m7mem8n5PE/yKGXbnLBqWo3JNBP+DNKVpCQf5SSJorax0VTVZef
	K94YhD9/m3k9pS8jctGFkh3Lczf4p70o2R/2qCb3mwtRNV03S/CiDkpQqGIMU+FG
	B+QxZA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1qukbt33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Oct 2026 07:32:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so11322615eec.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 00:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790926347; x=1791531147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IWtuB6bAcJMUnuKNd0QkWFAs6+jCv3PnTXcHMb6ywZ4=;
        b=BZ9bYRTeoqZrM/BjeIOkDOu/G97mk2jaW58ERCxr58TBGwuqLexj6/ISdetw6eWxr1
         8ZhcH9XnE5zQxAZ1TPaUceeX7DH2OTHqq1Ft5Pp0X6zDvzhMB0v2XfUWCZn8Yc/j/W2B
         cAFvz0zWODdWnf1EeHoGXa9T4Y+KYeChE20HhWQQi7wafiCUivz/OWEZBMjiQwckfOwb
         R4KK+2Jjoa1LK6Df+g/xteSn8TyZ8tyzejrlKspI26i+CgiUbyKmn3J1TgfDQ64vzWgE
         YkfgoG8PDNk1Us+ngHGiq5/FPrDQpXBvBhjelOt8eAGm4lhpedXeMZQfzxSJKf4bcWSL
         A6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790926347; x=1791531147;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IWtuB6bAcJMUnuKNd0QkWFAs6+jCv3PnTXcHMb6ywZ4=;
        b=pZuz5e/qO9JwHvXnfLszziEvkxZSVUlMWc+CxAYiefo278qbJyOo2uzzM2Wuc/hPpd
         tDylhOYKempbpOexAnhP94suZhH4y+3hYiUVQhV9ctdAg+mE3RcZs6x4i6or+LG4UjGg
         Bws5ad2BQc6KauiDAr4nmlQEpEwSGR7OKr8CyqIWS3p8x0dgWt6epnOgglmKOWjmnPcd
         vw4TrzGF3XQx8Ieb7hJ6rUOPDrFpcHmIWeIH9BXthX2xILv+mqEJAkSIRc0aoQl+4F/j
         abqm44v8giAwGtfTG9EQDR4g38lSMmz44EJHK03eoq8gryqL/kKUqNK8VLjnetobD4Xj
         NFaw==
X-Forwarded-Encrypted: i=1; AKwUvBz55EwskAjLFwS/xJKKe0d85e9H2Clfes2fuBGESg7QE+DIhAgFkUnx5imVGhj91ikJFMDscs0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnu6ATlvf94XzEegMFWEuVBl+TRxGfeJe/ePtD4jMes4rXvt7T
	pm1/H6YwLZP3TJOj5MSPptKiOSUqkvTgYbMZF+Ty34+3GLTISwPQbPh0vDMN2Obv2/FRJY1YAaI
	EJqPrCfUwPise001H9tgy3W9fKUbox51l8Kn41irydopNRBUP5l4wycGmKis=
X-Gm-Gg: AYBFou3OqBS50cFWJi8akJ0LkanSFdna9ONvFuPGukbMx3v3yPWfOowU80sAErQt3Dv
	61qfIrF0gUmMmnJA4ummpGtEJXs0WBj9GFvJfEZNwcORtqIgoc+CjRbg1hb+yYyzkD59J1JLWyF
	4ofCJFAipZJtZT/ApkK3PzYFc6cq6oRxLMWS2djwhzF6XRsrtsw11Xl3sd94f4oDkS7O7pU5lcp
	5ciN9jHp/JZClDn97OCHQmrFTNxcIxocAWPZ8UJfYk4R0/ylnC1vgjFFW0em4AwyyWAbUGxmxhd
	/3J5mli2i/wbaDyjzc/dM5qGptcOmPQe7SqxK597iXqRtl4Aq5uwwIep7YtESb0HQd/iohczwFA
	iHptjt2z+/nZVWWevK3pWOSAzcXh8on8=
X-Received: by 2002:a05:7300:f3c5:b0:341:2466:2d68 with SMTP id 5a478bee46e88-34f219a4eb6mr1916566eec.38.1790926346709;
        Fri, 02 Oct 2026 00:32:26 -0700 (PDT)
X-Received: by 2002:a05:7300:f3c5:b0:341:2466:2d68 with SMTP id 5a478bee46e88-34f219a4eb6mr1916497eec.38.1790926345054;
        Fri, 02 Oct 2026 00:32:25 -0700 (PDT)
Received: from [192.168.1.8] ([122.177.246.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3510850f86bsm950862eec.11.2026.10.02.00.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 00:32:24 -0700 (PDT)
Message-ID: <004c0fef-d5fd-42a6-b2e4-bcd62b8260fa@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 13:02:18 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Prevent GDSC power down on suspend
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
References: <20260128-genpd_fix-v1-1-cd45a249d12f@oss.qualcomm.com>
 <zfs6krk2whthgdjl2s2w4o5pjwimzw37afoiyrqllykrk6jugt@4ijk5iqplohr>
 <6osboej6luxekrw4okhlbf3irednx7gduhmqbzqkkgd3ldm2cn@esalet4ruwcb>
 <fd578600-d9a7-44a5-9131-8771262f82dc@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fd578600-d9a7-44a5-9131-8771262f82dc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyOSBTYWx0ZWRfXxiYsaE7lHHZQ
 ije/V4JKLA2NrN7irK6EVBpK6nPfI0bDuoYQgnnRDJbfHTVh4fKarVpv20yc2SzKjnOKtp6pL/g
 VxY9H6cYrjwruP9apt+5gE6qPfag+Lg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyOSBTYWx0ZWRfX1gqzuLq7krAS
 TSfP3VFpBgG4vJLJU4uBlzHsLF6KkuKfOI56gezxagv3HYpxeGCebTDcPIo42bzdGUaLSFf39R5
 QwLZEiWkVkjkan/IPow4VflWml2JARnOwuBG9Qz+jnFNmwJHPrGC7p66h4I8lqhs9SkVcsnAhiF
 Omh4YcFspL5TBJEfjitQv6P84uQxUOiSAPEbVJY8Y2QGhj7vkvf1l27HIqVTarl2AHB1NP8yvkm
 shV5gAu9EMVNcbFOLqmn30UtjXTivrcdZo4PWsC9N7t9iYpL838Q5gDf0vsmCBkuFOcQkuagFPx
 f7axvCE4wf0a5v20SEnxb+O2U6SoeM21e0AufgjJizDcYnaW2MRnVl3I051bDCCj38jBG/xJCdu
 ClxYXJAkRIAEOe6Dy+mLJFVngtsz7wqnHZXZ9Kh6ElbqEu91jO1jL/0QpmV7I3PlFT1qf4bghtE
 W+WhacWUbiqxN0Zd4pg==
X-Proofpoint-GUID: yImwnd3HvV51_S4A6e_xZBRa-R_sQNZh
X-Authority-Analysis: v=2.4 cv=TdADJhQh c=1 sm=1 tr=0 ts=6abf5e0c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=XPAAo6YaPT+rQjuZRm73pw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=0KhZnx37WpUrVoX56sMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: yImwnd3HvV51_S4A6e_xZBRa-R_sQNZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020029



On 9/25/2026 10:29 AM, Jagadeesh Kona wrote:
> 
> 
> On 2/18/2026 6:03 PM, Manivannan Sadhasivam wrote:
>> On Wed, Jan 28, 2026 at 08:13:48AM -0600, Bjorn Andersson wrote:
>>> On Wed, Jan 28, 2026 at 05:52:42PM +0530, Krishna Chaitanya Chundru wrote:
>>>> Currently, the driver expects the devices to remain in D0 across system
>>>> suspend, but the genpd framework may still power down the associated
>>>> GDSC during suspend. When that happens, the PCIe link goes down and
>>>> cannot be recovered on resume.
>>>>
>>>
>>> The GDSC is a child of CX, so by keeping it always-on, you effectively
>>> put an always-on vote on CX, forever preventing CXPC.
>>>
>>> In fact, this is one of the reasons why the PCIe GDSCs on most targets
>>> is marked PWRSTS_RET_ON (in the clock driver) so that the "off state"
>>> doesn't actually turn off the GDSC, but it relinquishes the inherited
>>> vote on CX.
>>>
>>
> 
> Hi Bjorn,
> 
> USB host-mode and PCIe non-D3cold use cases require their respective GDSCs
> to remain enabled during system suspend. This requirement exists on multiple
> targets and is expected to apply to additional targets as well.
> 
> The affected GDSCs currently use PWRSTS_RET_ON flag. However, this prevents
> the GDSC driver from disabling the GDSC hardware after the first enable, even
> when all consumers have become inactive. As a result, the GDSC remains powered
> ON unnecessarily.
> 
> We propose using the GenPD synced_poweroff flag instead. When synced_poweroff
> is set, the GDSC can be disabled during suspend. When it is not set, the GDSC
> remains enabled to support consumers that require it across suspend. Consumer
> drivers can set this flag using dev_pm_genpd_synced_poweroff() based on their
> usecase.
> 
> For the affected USB and PCIe GDSCs, this could be implemented using a poweroff
> callback as below in gdsc driver:
> 
> int gdsc_synced_poweroff_disable(struct generic_pm_domain *domain)
>  {
>          struct gdsc *sc = domain_to_gdsc(domain);
> 
>          /* Disable GDSC when synced_poweroff is set */
>          if (domain->synced_poweroff)
>                  return gdsc_toggle_logic(sc, GDSC_OFF, false);
> 
>          /* Dont disable GDSC in HW when synced_poweroff is not set */
>          if (sc->rsupply)
>                  return regulator_disable(sc->rsupply);
> 
>          return 0;
>  }
> 
> This would allow the GDSC to remain enabled only when required, while permitting
> it to be powered down for other use cases.
> 
> Please let us know your comments and suggestions on this approach.
> 

Adding some more details on the GenPD synced_poweroff flag and the corresponding consumer
driver changes with this approach.

The GenPD framework automatically clears GenPD's synced_poweroff flag on every GenPD
power-on operation [1].

Consumer drivers (e.g. PCIe/USB) can invoke dev_pm_genpd_synced_poweroff(dev) in their
suspend path when the GDSC needs to be turned off in hardware. In that case, the GDSC
driver will proceed with disabling the GDSC.

If a consumer driver requires the GDSC to remain on across suspend, it can simply avoid
calling dev_pm_genpd_synced_poweroff() in its suspend path. The GDSC driver will then
keep the GDSC enabled in hardware while still allowing the parent CX rail to enter CXPC.

This approach provides more flexibility to consumer drivers, allowing them to keep the
GDSC enabled only when required and power it off when it is not needed.

Please find the example code in PCIE consumer driver below with this new approach:

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ee63a6ec99de..25ff8651fe91 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -27,6 +27,7 @@
 #include <linux/pci-ecam.h>
 #include <linux/pci-pwrctrl.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/phy/pcie.h>
@@ -2436,6 +2437,8 @@ static int qcom_pcie_suspend_noirq(struct device *dev)


         if (pcie->pci->suspended) {
                 ret = icc_disable(pcie->icc_mem);
                 if (ret)
                         dev_err(dev, "Failed to disable PCIe-MEM interconnect path: %d\n", ret);

                 ret = icc_disable(pcie->icc_cpu);
                 if (ret)
                         dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
                 
                 if (pcie->use_pm_opp)
                        dev_pm_opp_set_opp(pcie->pci->dev, NULL);
+
+               dev_pm_genpd_synced_poweroff(dev); /* Invoke GenPD synced poweroff to disable GDSC in HW */
        } else {

Please let us know your feedback or require any additional information.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/pmdomain/core.c#n919

Thanks,
Jagadeesh                                             






