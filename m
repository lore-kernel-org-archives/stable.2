Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F838E8BB
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429987; cv=none; b=O5wKP/yEVg8XSvqlrDRon/gnVzHSDdTa70aciSvqwe7dLcFGaODH5PhvztMCcsz0jFL+jBwgAxZm8r6azHkjMA33nKQAlQ5/hlY+70pH0y5fPcCkYL3AAYlqhL/Gsfu4FlXCoa0MgyvDmxBexbPtWUKs7IPPXtpBQ7s+2PFk7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429987; c=relaxed/simple;
	bh=IAI5fPC8kUOmVOXpbjJOoXS/9005rgomTstYB1sbH1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7EIsI0F1+AvbNSfUeFO+DS9qpJuUGv326Kodku0fmm7RUOM356eEglLOGLnzSryWLYRRX2bvboIvCcbkq+/erc9/t1Q/VbjzKl3bQL4AQhNEt1LSCySb/l7pXlFQy99a8ltzIOef2D3BHmSGISFu371bX4zDTOei9aD+nQrvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ipmUR5tl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SE2OUat7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ipmUR5tl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SE2OUat7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGWp4p1238746
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	41bv1bQPLiy8a8DyzT5YhAkpHkoFIBS2fv2LzdT9CjM=; b=ipmUR5tld1IyruPP
	gLTAvhy5UXbBEOd/bHHBUvy61Ek7rWw+V3LY4Tf3rWescP7bFORUy41PS7fj5Kep
	jtTqQOvktgowmxUHVdIF8PsuO+bLpk6EVfk5LQ++oVw/iWOGACKvRrvwM/tK89eS
	C8C4WVMXWyfjwh2vQ7rYxPXv1104hLdjN63CVIh+Z06zJrnKJSlQ+NJB09/PhNSm
	pe30Z9avESrmQzHn6rRTkohbdv/1VIr11gxjzmdeb9RW6W3oiKEwCsRFhwYyOym2
	mkRNmta4Jspk0/Rm/I7P8D3UPUFL9PSMVY9FS9xqqPH7DkkNFwKU9UGQ0Fvo8NiK
	SHUyYg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8n38naa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:46:24 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97752c2acb7so26919241.3
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785429983; x=1786034783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41bv1bQPLiy8a8DyzT5YhAkpHkoFIBS2fv2LzdT9CjM=;
        b=SE2OUat7QMj6vC66qAEkRVBqThKcQ3/66WzYmUqxTUJqGr0y9Wei3zolWRUv4XMN+q
         sJyJMdxlO8T71zonZflLotl8La7BHx3gFJaACJ7mqdsf17oi1yeOrgDNcfIhRRmVkP7i
         TEgYTjeqQxjiPl2E7O3mramKD+cWP5MQbMgZh+Mqguhy/YwW0mxULKcSM/HuJC8nK1Et
         a/X9ZCUH46d3CtxI7NMYWMCW6RQFPM8IR43wmqxhWt2lDwVzM9zzjwhcyJePqxKZfjFL
         k6k5/QPXF/XDvGjbv1nk2G3xF8PmUgSewikVRXdOm9mryJfn9hNXEe4FJ97dn2eu7pHA
         mSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785429983; x=1786034783;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=41bv1bQPLiy8a8DyzT5YhAkpHkoFIBS2fv2LzdT9CjM=;
        b=e7LCQj9q6N00p5RsE5AOZMzZHAyrAazXUMh6DrrHethkCa+X7nyGvzRZD7d/IQEu3g
         nPvwiJh0BOQwDUOTbWNq0IqkLgcl5UI9gEsZwcYNAozbGhFbjrvFQb5qiVmswhgfMPj6
         WCVbms+FeVFMEEaVD2snuPbXg2NYb+THStG4izW0nKQTaXDCOwnQCH5xaF5P05Opcm9e
         f7VH4QWsXdad9ssT4q15xS+GY9Hp8v/QXlBZGHqdIQwePoAqxkOzdV4sdyHxu7AL/hsn
         Uns1bFa/Pyn0lQRr4oBMQ/Hvdm1XiYdvcMMAHrqXP3dLOb/1hABAfp2aiAlNA5GwRbij
         Szqw==
X-Forwarded-Encrypted: i=1; AHgh+Rrl9pIYJPuTsVMNp41Kn6W2OciDu5xdbBF1v4eT12dX1TWthZEiomsClq7C5+QcvityA8GfDk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+REljiQNEUcVAhN329rC3++ponYpnCHxYAl4KAr/o6Q28PYmp
	Bo5oBQBQXo7/CXNa7+lmjzJvsKhM150I+BIyYWlXdzpC9mLKHDh3wcV6qvFvqunp57waI9KJaNz
	afIBjpKEU5q1+NU1CzHj6gRuObNP2g3sgSZVd5cCnUeBaabAEC6eROWlMKfPc+YvDAsU=
X-Gm-Gg: AR+sD13iNokbEXmD46hPi9y8tX99gS/MYeSC246F96nsLerllHvQrsYTpc4Z2deBhQ0
	hkGhbqRq3p5KAWlB+1UVvLWLOaDSffcD3WD1OI0vCwOr3ZYAMPMMMqa3gI8WoaXj0AULXH/Ymfk
	vPU8E6okHS5Wk0YAKgV8qV1RBBjmD+Xc7QEbXRs1LK4Iw1ctVnzZ//op+mohs+IHdsaCehxOEw4
	/LcILOg5ZgP9LdSRJODhhOghn6hNYQ4zjt2p+CfSyX/V76TQpf3zSsbdjpr4fM6lV2am9euYup5
	i+MAdvSDGmLMeMWrNQENOBFyjdshsabU/taoFhcOt0yBwdpOHdAc2NQ+sksR9uk0gd1KxjG5VPI
	gIQaMLRXqfAvBj5etdoBcdQIq
X-Received: by 2002:a05:6102:8090:b0:756:32ba:1a83 with SMTP id ada2fe7eead31-758407c7a45mr602059137.2.1785429983602;
        Thu, 30 Jul 2026 09:46:23 -0700 (PDT)
X-Received: by 2002:a05:6102:8090:b0:756:32ba:1a83 with SMTP id ada2fe7eead31-758407c7a45mr602044137.2.1785429983191;
        Thu, 30 Jul 2026 09:46:23 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa851b322sm91019666b.7.2026.07.30.09.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:46:22 -0700 (PDT)
Message-ID: <1bcd1a68-a1b8-4604-8a2d-ece01ccabc00@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:46:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] usb: typec: mux: ps883x: refactor DP altmode handling
 and support TYPEC_DP_STATE_F
To: jens.glathe@oldschoolsolutions.biz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <20260718-ps883x-disable-usb4-v1-3-cec86d0b909e@oldschoolsolutions.biz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260718-ps883x-disable-usb4-v1-3-cec86d0b909e@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ar/eGu9P c=1 sm=1 tr=0 ts=6a6b7fe0 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gxl3bz0cAAAA:8 a=Xqxl2qIfDM1Vn1vrR_wA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-GUID: A-LFHlbxPljQeWRbv7BEsdyV12gFLjqB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyNiBTYWx0ZWRfX23Vzm6Fc3wdv
 hHrUuHJQ16/893ahefx3EV2qYZczfyYvuLqTlXZzLo7r0U1WWjJyz0E971ickaQiVxFWjIyWp1f
 WTRV4NLy8gS/FASWRbqSwP3hrL9hzgz5r/YpYF1akh1dzJzLhIw3sAC76lHTbK4U1qRqK/IzOpk
 qEjsauDDLOROnqG4XHOygU2qDXcFqPi/0Gqrk532bo2RsNxiGdOVv//ndDKxIZNIdP/a6/bmBU2
 k+rnRb2PSqiN/L/sYJulfGTK0f8082YdgzvXGDDPToPwSfx+JHEQz933k8P78cum+6n7jaTqMX6
 mVEq7xI+QrvKgGK/TyVA8v4W02eHPTtIqq+84m1hFwedwVQVm/z81NzsNqJFZyRMeoO4YEo6sc0
 6KYELJhkKknRKUXG5TclXk6bIdu6++2xF03it0+9+Q9zImdHO7ufQd0xe+LxEy2iXeD4fs6t7C/
 yAJvGkslBElMwfWJp5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyNiBTYWx0ZWRfX1p/GfR2hSDec
 efWODgfgJxKW5VD+Il8dVAnu1utHRRmN0T89jBZQ1wLvF01KGTtTvi2UBulYrA560Q89iGlCepL
 cZI/QgjCnuqPxVK8xwziQcByLb/41PQ=
X-Proofpoint-ORIG-GUID: A-LFHlbxPljQeWRbv7BEsdyV12gFLjqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300126

On 7/18/26 7:06 PM, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> Several docks, including the Lenovo 40B0 and SSK SC220, still send the
> legacy TYPEC_DP_STATE_F mode request (deprecated since DisplayPort Alt
> Mode spec version 1.0b). Treat it as USB3 + DP altmode (same as
> TYPEC_DP_STATE_D) so that DP altmode works correctly, especially on
> the 40B0 in Type-C fallback mode.
> 
> Extract the state handling into ps883x_apply_dp_altmode() (modelled
> after qmp-combo-phy) for consistency.
> 
> Assisted-by: Grok(xAI):4.3
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---

I'd say just add a oneliner `case STATE_F` here instead

Konrad
