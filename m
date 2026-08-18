Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE427FD74
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029627; cv=none; b=lmrSeqItO/luH33mH+vqp6tec7BQTJRgH4C5qULmSu7NAZYsiLZDEh/TYXvAZ4amFLfDF48liSbGjbJJ0LyN/DMdfB48q8ejZh2WAiRlPesUMo5XoR/SAWH+Nq0gFMHebpHCVdMJgNxfgUWQA1QZCo+vDyIJ3oBDnIgvKO3vQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029627; c=relaxed/simple;
	bh=mdu//a0Msa9i1GDiaeUzEd6ZcjMTI+PpLfvTOGgn0J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pt7P+YCW3K4SEiBI2VVURCdkf3ptQheFfFOy2drgHJISayfFzdZuCAJSybljdG8CJ/QP6J+Ikkou5/ufm18geqIoaAg+qli384gcvaOpIkdFVO2rYnONzyXSeBVqGV/6RDCOrkJ/GT9f8OYPpDoZJfXNHZH5Djaobgy1NUgQLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PJ/ovc61; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ln81m2WY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PJ/ovc61";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ln81m2WY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I25AHC3603497
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=N7HGS+js9AQ3WFgzMDszCKky
	Dss9f629sxI3gpvij1g=; b=PJ/ovc61iT8zGIRSevkAb7H2Uu2MtBok7dpcghQn
	w68b6TKfFcXYbLJrbQlL30w5jK5f6Xu5qg8N3Sg/3Tc/Jdx2PU5BQk1aOX5olvUW
	d1j5dYKS1uBLDQl/kin/hL/YtMvQOGE3a26caBamwqk6iNPWMCA9Fbg4iufmopXd
	xt6jPLB32XWutsHmXBPN/5cFPM5kxA7kRyVQI7HyVMI5grTJcVHAL7eDf8D6d1R4
	AwIzv6Qoa222HCZXvZlFLz+6YDFe40gmwDEQYoawzYn8Sd4UgIQ48GiyJPEkFgsT
	aZhShp8PxkGcGdzDzOT9HuuPCK1LDrf3AnBDe+DvAlovbw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ea2gpch-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:07:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9368f2b7b2bso422624685a.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 22:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787029625; x=1787634425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N7HGS+js9AQ3WFgzMDszCKkyDss9f629sxI3gpvij1g=;
        b=Ln81m2WYjc1+Atl0tvPkA1vI/2BHNTuhtJoikfxx1aJqBdJV0Zh01ppA2LegUuOlq6
         FNm82PwQAHVSfrj6hQ7Id3tRodzZ3AsY3cZw5JywD3JLjM5YG2T3X3Ozl46SIHbiT1Tn
         h7Z09E/b2zwXMYtW/SVLQ9FFlbNrF9LkPZRA5svHpRyaYU2GtTq1EpamsCsfXEE+td0S
         LEK9xUdmCtNxvzu91v7Dw1QF5tUipy226V3oE/8RsfkWNWlYrUNFyezBoCJXcOaG3cQI
         +7JLOG4BOdjXm4pajz2kteLuWNJ/Mg2T2ttdswc9rO7dhctxMkxmm1C3s/2fPRIxoI58
         rhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787029625; x=1787634425;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7HGS+js9AQ3WFgzMDszCKkyDss9f629sxI3gpvij1g=;
        b=e55Q/W1lWBeZJTm0XIGo0AhezMoygToS+DQkFLTeiIXFQ2oghxY1EjbazfomvEF312
         7q6FArwg3Lb9rFEhOsT0d4miLJOsyNxasdsLHmpfNYV2deNv1Z0hD5ddZlCRkMLsrJf9
         aMoaofK2UNbwYt1DGS02ekhWJ/OSqzhqciq85iYsYQuV+h43CsmhUWtIXTdD19zQvYcs
         1UMMU3nxeZoIkAz+BhpL/a57IaGeMR35RHhffeezxbLeOXuuveMz7tyyDkMXEU8mMb0t
         uhk5y1zAY4LWEJqj48bhoWceOkocQY8hXOc+Ls9ko7GP76IlgfRZhmjBAREsv39nr4i4
         hTUA==
X-Forwarded-Encrypted: i=1; AHgh+RoV3C7b1I2PSko8Hw6D817PvbM5DhJPtl77TGfmbCPfFlI2V4a820URRFmjbIkhq+vKWDSo2sI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymz3OAX5diUnBw/rsVtDxQcP1caD4S8LvpCMYGco39toO35FVs
	SO2sMTjN/qbmSxR2hREB8SeVad1vG5jUf+aIghezKHRGSijdIhgv68jz3jTzOx+8YxYUk67/0qi
	avdr2EnLyFZwINrggB+T9bcNXu89mKjWW9eetcNjaYtrvZm4dGZCsczb8n2U=
X-Gm-Gg: AR+sD11Qiv38raE098NN3X6LkzP0pG01WFT+S7L2Zh/jfbve3s+KnrcxFVrFHvEv2Nz
	bs57xbgmDuGOkfrsZcjKtRg78MDr+j7J4zh2Bxav3HO1mXDljE29E87K1+nyZg1YBmZGrhHmog2
	RgDSyo36jLPmX8jfqFLGWufWp6Xhu88GEV8fMkfoT4GQi22qzsAhH6WizGYRGMebzHNOIJNATGG
	HEpEHPqyXpOQuz+PvPTqJt925Lc7UHE79945CY3A6/LLVgi3SvZpy2JrHeaVG35FP03S6hbLMG9
	MHhIdjqHtuqzhgSDT3+A/iHAu5OoDiC+c0O7qQGRXaa2U5Fv7ohSSSB+ibeUHYDePm/JoSXTlDp
	IqtMUh0isLXYARhGB5xJsd7QQMkjkNMKGFrp4fAgpE3ee6Y0Z0RciihrQ/sIcqGuN3iv5ZK2yeU
	3umjEKVdzRffeM
X-Received: by 2002:a05:620a:319b:b0:936:9fd5:4fa0 with SMTP id af79cd13be357-93704bdff4cmr553673585a.45.1787029624692;
        Mon, 17 Aug 2026 22:07:04 -0700 (PDT)
X-Received: by 2002:a05:620a:319b:b0:936:9fd5:4fa0 with SMTP id af79cd13be357-93704bdff4cmr553671685a.45.1787029624245;
        Mon, 17 Aug 2026 22:07:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b204389sm9696581fa.42.2026.08.17.22.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 22:07:02 -0700 (PDT)
Date: Tue, 18 Aug 2026 08:07:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org,
        quic_akdwived@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: Fix off-by-one error in
 regulator error cleanup
Message-ID: <54zzrehjmurnpx5nv7f3vmq47y2elsns3cfsjdae2khr6oy6om@by6wtlwb3zd4>
References: <20260710194638.1502-1-saileshnandanavanam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710194638.1502-1-saileshnandanavanam@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzNiBTYWx0ZWRfX4Hh1AuT01I/h
 RFV9Qf9hMumP9P4q5eBwyryvwk61nzw8acdPCQ1N+s5mLxW2vl2kBN/LC5AvHeCVowI4jtPDvOR
 D99QTS07yl/Uw0VnkSDZI15ntQ2WmOcnQi3k816b5vREowBluDk1J5UOaDVpjiSfRiC5gA+FAPz
 t4S15x7Y6bkotX3m/8GegslmERe1c3AXdy7FyFOu79lwGc0ucUowSYnPoK5e4l4urbimlhHvND9
 eNiUgYpSo1D/5MnH7+eKc0WyCBlI9nPaxWVMypsSZULXlHBWh7MaiUpU/ytQok/o6ZzCihrtKAo
 MPDqavMQZbm9XEDkgTth6tsJaVRFGrZnStM61Mzrfq7IdFVKoxNeBggnZkWta50KgxoRmlypAGw
 5mVqxli2HGTrjMoZTABxXVT5rAt3qOm7Pgh/DuD23uMg7hBVQtC5S1a5N+IPeWUlg9m4LwWplNR
 aS5E2+WYeucp3GRE0Ww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzNiBTYWx0ZWRfX8lwTzkc++m3T
 Vdq2KJsXBXOlu/f6uqgWSQcg3kRELpMFlrDRRudYqhpcvCb0oIoXjKRG2OBdAXPFXNaNu3RJeJu
 DEaRK4zKAKYwi3qwfmUmE3LEAAZoWp8=
X-Authority-Analysis: v=2.4 cv=XtfK/1F9 c=1 sm=1 tr=0 ts=6a83e879 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hI5qLSgjwfH9RGL9AckA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: ZkjNoqGjnFf0hYpAAXhiDzxfLjfliUQt
X-Proofpoint-GUID: ZkjNoqGjnFf0hYpAAXhiDzxfLjfliUQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180036

On Sat, Jul 11, 2026 at 01:16:38AM +0530, Sailesh Nandanavanam wrote:
> In q6v5_regulator_enable(), when any operation fails for regulator at
> index 'i', the error cleanup path unconditionally calls
> regulator_disable() starting from index 'i'. However, regulator 'i'
> was never successfully enabled at this point, resulting in an
> unbalanced disable.
> 
> There are three distinct failure points:
> - regulator_set_voltage() failure: voltage was never set, load was
> never set, regulator was never enabled.
> - regulator_set_load() failure: voltage was set, but regulator was
> never enabled.
> - regulator_enable() failure: voltage and load were set, but
> regulator was never enabled.
> 
> Fix this by introducing three separate error labels to handle each
> failure point correctly. For the failing regulator at index 'i',
> only reset the resources that were actually configured, without
> calling regulator_disable(). Then roll back all previously enabled
> regulators using 'i--' in the for loop initializer to skip the
> never-enabled regulator.
> 
> Fixes: 19f902b53b47 ("remoteproc: qcom: Initialize and enable proxy and active regulators.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
