Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F03B1EEE
	for <stable@vger.kernel.org>; Sat, 30 May 2026 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780148091; cv=none; b=JCsolpd0xVMQI7P7B6mF3GT40KmceihYKcR4RhsUR6Dqixz+9EAw+BGr9EwDqVDNtDVskpczaPSC3mFejxOrqqB151OzL6IjtQjd+lDL0Ho1yERf+E7G7gnTQclx/Bp82U1Ih5MNhQ9N29+5XO2Vcxu2H08KX/2bZQzlWIWsFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780148091; c=relaxed/simple;
	bh=nZm7/KrAFnUmw0HLeCbq5IVzJNNGM1ZDj6512w4P8Y8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lshjyqk7bGVOC/DBAg0xc6zdd9/1koKKEi6jLKPibmzmKWi+dhYzqJ3ZUmTCwqYcHL9T1l9MUeuHSBXT/PMyovy48TMRvVzrAfVzMBDALdYcewRnbEpBVGKCCrCx/F7lV5N6xG2u8iGIcLGpbfyJYVt/H2LyrnJytyrnFq88cZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CJk4ZQAw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZYlsJ6DY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CJk4ZQAw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZYlsJ6DY"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64U2YHtW1401725
	for <stable@vger.kernel.org>; Sat, 30 May 2026 13:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vZoiK8MxIGVbxIKBU/zLhqCKZIIFuB7l/xTg1Y+vmAc=; b=CJk4ZQAwCqxaXy3r
	L2HLKZg9u9DRzbofSzp0fLi+FRrJG350s7E78UPm9VzTvligyzWOUzAj6ef0VKP+
	I9pKrRDQs/e3HDhpl7l5bOFe2NE5MoT2nWM6QJS9zW0gUHB0sQQQbVfbRCr3vcMW
	znMCDkJDeCwYusRp/DvZTQXMMn+4DSz608FBT9gnWulhfuHUT1/hlMBCpTdua9HW
	LfS4Kbvz8z0y1hiN8OWnONUwPVHDoZKyZw0iMpPk1P6I7JdFOxGHuWmOHEaKL22D
	xUgyR/H1xF7XY3xmN9sUeyGnaxsjnP0eAfYd7CgSauGF4NZxRzQSRErUmrAqEADV
	9VDH5A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7f9572-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 30 May 2026 13:34:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-516d09e77e6so185122231cf.3
        for <stable@vger.kernel.org>; Sat, 30 May 2026 06:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780148088; x=1780752888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vZoiK8MxIGVbxIKBU/zLhqCKZIIFuB7l/xTg1Y+vmAc=;
        b=ZYlsJ6DYJKiykTHVfesJ/D34RApF97+DhNyv4as7iNwWp2muTAw1kC4LOHeEuNmSsf
         RESKzKgBG0YFK2cd39gjOEtcrdoxdWPjac+gFtli9Cfhcl+hdYF5VK8NVCt1m+uip7FH
         O2cQDsm0EpN5RhJXBPq++Biu1oimi0mOhUsRjR0K+iPjUZV7993zIFyTVaHDPIiPlOBP
         rqWxtc/hLUDMAOnBmnK/X+cXEGKCJ4IKED7Yg+QcP05FBClehakMsb+8klorIRmhKEPk
         hfkCUS8AMbW5tRkRf+BM93pQ/SgL3x2bd5p8zf6qIvx/R6PVr2K/8nVy7i7AWKSlK+CN
         9RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780148088; x=1780752888;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZoiK8MxIGVbxIKBU/zLhqCKZIIFuB7l/xTg1Y+vmAc=;
        b=Uj499CoS8Wg+jEhvYmkKRsmjbDyMAuHfkynp567xYzdLUZdt+/xeGbb+6FheL/JoDO
         BkDgw+R3Xzzfc2fmtC+QuYgSIlW3fknoDS6zIFOxAuPKtCUgEumk6WBECmw45oIzwbOI
         a4Uz8FbYMispSr8j2Dg5Uad/lVSMEQvstB0H1GdD7zTRyGlScguTQm+8ivNSUA9QKRQx
         nk3F0oM1300bslGNiW1PqrtY3CO0pY3QfZkZW1yzxeg/EpO8Jjs80lsLeq+x2MDHL2Qw
         e6ZtGOJ2GwVAjtqfcepUEkoBhwBg3kD1cc1aIKz2t79NHe5G+iaJX4WdUOUszU2J9fYm
         v+bQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MFK0msze22cVAVvUEbTcsjKuotbXVhdjhN+bTvqwzjmFaiyIptkGZ87C62MFaa9TsWGeaJLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeyYQeGiCShQBEMP/c94D68CqVuNVMsE/16KdqaD3I5Ng7k8zh
	C/WQbPrPhRibDFPb1O77RkOMLzHayuMW2CpVIXVb0CYbgcza9omiY6starwYu02GGE3oI59YkgB
	p+kx4nXWXZTYrurz/ZiUqrmvcXFXGAIlWC3P+Wr5M25Y9rhJ4CTwLnhnAYP4=
X-Gm-Gg: Acq92OG+Dop6vcr8ac6pj39pdOFBf09J9OtWF22U4ts1DSGQiP5Xd/u0pBVfIf+1bct
	SnOeaTRB2V6/hVwXtODr8P4O678Q+51mdKtd7gXhDnb8Vn3RlqsnEeOyZ+wiiX99XYlYzogAAx1
	oaS4KG+RkCs4r/eZwptKU9bVnFzVhqsM/Xe/lCd75gzcaFdZAbUAilJW5ewe2I5OIz+XayfLX58
	1iL7UIL7/vjRLrXScQYhwAwSRzVi5aHsm3Hj3Q4paQByhu5fZEvONasImS73WroJvYE3poRhqgf
	zhZSE3rw760/7FQn4F8bmYnPuEuS3mTumDr6W6EFxaCBFWGL1WbaVTqDROZWVt6XVaeIgi2puYW
	t6Oc89FRHD/eHhXOIvSLs+/q4IUv0st7Iyp5O8rJ7FfEF527U7byMECgFLCqLBorvqY0Lo/wvrN
	4e9P7gvSTa1ZfTBRLLOMvZJgdjyNnEsssjZRrOb6o30I1Nm7MkZxmIb6MmnBEA19qflyfH2nrJg
	Hn6X+LC/SuA6mflpt/C50MgVIc=
X-Received: by 2002:a05:622a:4c8c:b0:516:dcbd:aab9 with SMTP id d75a77b69052e-5173a67adb7mr54009821cf.16.1780148088265;
        Sat, 30 May 2026 06:34:48 -0700 (PDT)
X-Received: by 2002:a05:622a:4c8c:b0:516:dcbd:aab9 with SMTP id d75a77b69052e-5173a67adb7mr54009351cf.16.1780148087807;
        Sat, 30 May 2026 06:34:47 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-beb4356b901sm38478066b.9.2026.05.30.06.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 06:34:46 -0700 (PDT)
Message-ID: <8503d297-68ca-4bfe-bbdf-537a85890d86@oss.qualcomm.com>
Date: Sat, 30 May 2026 15:34:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
To: John Veness <john-linux@pelago.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Nick <nick@kousu.ca>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        todd.e.brandt@linux.intel.com, xi.pardee@linux.intel.com,
        platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
References: <E2OXET.4X5GTP37VTNC3@kousu.ca>
 <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com>
 <bc9d5258-d4df-46a1-bba9-de3486f722ab@pelago.org.uk>
Content-Language: en-US, nl
In-Reply-To: <bc9d5258-d4df-46a1-bba9-de3486f722ab@pelago.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AEEDswmX6ZjABfHrJvr2ECuv1DQ6Dnlv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE0NiBTYWx0ZWRfX4Ot90cx1VAr0
 kcGBzXHW4++gNommH64fnNwcIxv9huVjCpJNZFjKZzPRyCmEZtoeSXJs0YFuEtHXSdvU6LVHLAg
 8o7UrkrF9yIwMVbsZslMWrg1rJQEYZMJTJgVvPUXsImnn19g4Ao61/fGOLGTYxjnIV2DANWY2Y/
 9XOWWyWKUQUZ7UfdpGucb+cw3HrJjYwj+ekM6xQHx9Gm+XgGpZ/7XOlfz1BRcrD66PA61Mr2vlq
 mM09qHmFp5J+BdZb3LgKF1k+0XK34ZIGvEBGBupAr1szEuPqDPBzNYTEpWCIqFzRGPobiouqVyJ
 amAYx8s51iisF9RxKmUQqGQ48ZW0WAARnH5e6eo7BcdKUzeT5cz7NCT9r0feO89u0brGUB06BY4
 K9oI9w7DknLvKmdd9fu7sh+CnDgpK0pDj9UazpdSoD0m3XvDfl7sh42u2jagWVn6+4qBWmWDvyh
 Zf2iKGz88/ElAEZyb6Q==
X-Proofpoint-GUID: AEEDswmX6ZjABfHrJvr2ECuv1DQ6Dnlv
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1ae778 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=jmGAqP9c4pEhswuVvyEA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605300146

Hi John,

On 30-May-26 14:19, John Veness wrote:
> On 19/05/2026 15:08, Rafael J. Wysocki wrote:
>> Thanks for reporting!
>>
>> I think that the problem is acpi_setup_gpe_for_wake() doing too much,
>> I'll send you a patch to test later today.
> 
> Hi, can you release the test patch publicly? I'd like to test it here,
> as I have several Toshiba laptops whose Fn+keys don't work (apart from
> vol+/vol-).

In case you've not seen it yet, Rafael send out the test patch
publicly later that day in another email in this thread:

https://lore.kernel.org/linux-acpi/12896447.O9o76ZdvQC@rafael.j.wysocki/

Regards,

Hans


