Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4038B489866
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312553; cv=none; b=rFnxO26TUjg8D2oqr6TdlJnghQvmdHhUTjv2clWMqxbG5rVP/V7pVWS1dTOvqSlI5MBHedkgeE3SwHVkder6ErIrYwwFvbfjUx5p7ZmyPdJxahBJYyhuaeoK/zPLwmLyDotlGdEIUM/KMbmFSKllf3K+6dC0rtwpfC3pnRxiS5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312553; c=relaxed/simple;
	bh=NIU7Sq7oLaNDjKTgp8yxgJcyHFfZx+ZAPkEAQ7ttYL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUGse2AaF9/EZ7ZtZQR75e+x6bOpNehca6EpYn6Y4cE2yqOx9EKsMOL1vEylkd2CFif0spzt5teGYG8oY5hTlunB6fEQAD6ef8hDJFsC5gBkny4cPlIJ83DHovy8xco5uy30DA+AtAbkI8iZb4lOQKP4onzUcQrJnpnnEy/26Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dIiHrkTi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DpqtGvVc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dIiHrkTi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DpqtGvVc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9LlVj2539627
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Oh9SGcJoUiskZKX4r4ZOUupP
	C4HusVwgeUCpZ4i0z2g=; b=dIiHrkTie97NjxVm4NvU2TiTEPat6N9VWVR5IIA2
	RhkfBrap9NoBtwZeXf84BAFAvVqDmeUEEBvzztw6grOX+S36Aah6OQKe33ZrZhj+
	IQUgKQ8o0BiJOn2Jx761e3/gJcHAjbEg0SDLZ7ZCNjGn/u9gzb4R5hXN7n+9nqVZ
	QGRYA89WYA0/kMgPqzGdns4lDCPLwQmN+Bt/35DOV1DFLVLdr4Bp02FWo4/EkgNt
	MNCqVVGTiHHDjxxxZ1Q7yxqzfCfBUWr6xzYIYYQ24/B/k+ePz6/3Xoxfas9PWnmG
	UCmHB6WAWGlYEXM9Yd+WTwz8LeHPhNHji2REd4PtzfIpGA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fuhhdbk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:42:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5276aa86d00so9258611cf.2
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 04:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787312549; x=1787917349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oh9SGcJoUiskZKX4r4ZOUupPC4HusVwgeUCpZ4i0z2g=;
        b=DpqtGvVcQV1N4mBYz5WAAg4+6YXoJQHaJQgCbTisgaOdFlyU7k0hSYXw2OXK2wakWh
         bNbTkMSdkNF3pSOoHYBGWPE6vHnU0vNsY6g0wsZexc/H+GDZJxHTRg/YYJOE5KTf8fxu
         35YdrEwfGNsKyS54dO433miWb0fqVi1YVSNUThJ6qannNlRm5kIFk9+apZyRlS7Xj68I
         fOROqVaurQCU6RL8OX2p2YYx67wF7gdMLAal+8HXx789B48xCWM7ul5mpQCrYeHJ+YnG
         s1eFpibwiynSZ9T1rivGbKAnno007/VIS2p1UyqRN4sVmtOFSyzupzM6jgi/TPLBw+xA
         K4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312549; x=1787917349;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oh9SGcJoUiskZKX4r4ZOUupPC4HusVwgeUCpZ4i0z2g=;
        b=AcvdlPc+gZgDodA0NPPeOymQxdDqrOiVP/r85ZWoc3bz5rerCtAvyzWpkqTHZyf/7v
         P+Hhnxwo0dhFvR8qZn8iCTW+uzAiTJdkslwhuUJqjHQKVjiX7TbaXJ94mJ7ZMGA0OvUl
         CPvsNFouYQj4TiMyE9lLLc4ncLMbVZJcTJFKbXjuKL36WV3VpBj4l2rln4MsQAqPAS9T
         K2TAyillu8rFJyfHprt5Yq1S/YweIVcwR7HWLfafKjQAb24Mt9RTdR2OSIhfUzYnl+mg
         RUJPDzLgZYA1BzADPX9xoAwNiOf8Q7rf9kYCiaDvEh8exjcPaT0uL8C1j3e98WU26+Un
         hXJg==
X-Forwarded-Encrypted: i=1; AHgh+RpPV0sNkAbW6DJNPZiQFIFXnKZExq2iDN8IE+VqJy866tZCJnAllibNXyc7TSvNuVBFd8uRZrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Gr3TzE8DAexVQ0MB7rAeb7wlJMHpaLFMa7s2SPfyyKUnNszl
	ffLezBi87hQGlSpOpdqFOzu9XZFzBpyoXDLbY9DWlPWFBgMbTvo4JY1l1WELmMrOdXemeAaXxJA
	8bUwnX8hsr3MwB/ohFCsSAu1FYDVg2WVN8V8WZOzVATW/uMuNQ4bBS+E/yxM=
X-Gm-Gg: AR+sD106ExuYs0djogmiAwX0fGbnKYG6VIOJdKQQkW14NPGqO3Ld154bNST5+3cdBbi
	qSl9M/BnNXr8Xu54WKPYU1rbPxxDeI1XA6Ih5p9BM9FkPO2cysWzzVP8MaicX/VmOloehFX732F
	OgBLPYSgcNB5AAIg2h1VZ3M6dgFO98V89XrJ9nz4rUU9Y5Vhwutruh6JK4rXYsl4CWxVK4i0aBY
	v0MvQPzq5I9Y3rUUhs72eKjhQD4jT60Xrx9QrSM9xpX+SsnV1u9bgbkauqxY90m9VYaw+0hCaMm
	IYnlbA/x2sPHrJeVmOmTQtHMz/r9ZLAWXNTTo1HSN0SOPMqhV7hEZ5yiYyn8X/23N8Y/B8Lm0F+
	GXuINRpxPQKvRiDg=
X-Received: by 2002:a05:622a:283:b0:52d:89f8:4f8 with SMTP id d75a77b69052e-52df56e491bmr49499911cf.5.1787312549398;
        Fri, 21 Aug 2026 04:42:29 -0700 (PDT)
X-Received: by 2002:a05:622a:283:b0:52d:89f8:4f8 with SMTP id d75a77b69052e-52df56e491bmr49499401cf.5.1787312548864;
        Fri, 21 Aug 2026 04:42:28 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df293sm474840366b.45.2026.08.21.04.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:42:27 -0700 (PDT)
Date: Fri, 21 Aug 2026 14:42:26 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] pmdomain: airoha: fix unselectable AIROHA_CPU_PM_DOMAIN
 kconfig
Message-ID: <7hlarbdpln2y5ckt3i6nz4gskcxl6e6rher6rvsgmwop6bj7jc@exu2d7paa5iz>
References: <20260821085222.140633-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821085222.140633-1-ansuelsmth@gmail.com>
X-Proofpoint-ORIG-GUID: 2nOOzxUed4YAvIRfHo5Nig_aYlxMrrcU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4OSBTYWx0ZWRfX48Avfx6sGed2
 oK1+2nRrSs9RIiroOhxgL+3k30r+KtuhqHbFroxJvOS48TVOczhP7OSkLsK58jD5Uv35u1DfeXR
 FMpuF26NNLAyiRC6pthOKIc5tGKC5w4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4OSBTYWx0ZWRfX0mvYT6YbtaiK
 5P2iDLcgl3P4TSgyY+yp/fS6xc+2s42FI59svaqITsbIG1i3dIIeI47vXUU0D/bj00yKsuq7LCN
 Ls5mpX1Mx9/QMscHsQWltkMNrYGBe3ICvY3jlwj6pTmyPw7bDpf/wTSulyinGarZg3UpT1in96t
 U/b06cE/uPZw2zae4shogg5nt8EZpG2TpCTekFYboH+BIoy4YeVtqops7z/hYSIZLlZbzvVipRw
 U0ZeyMovEsqZCx3qgkihgBvnNVEcsEqz8poHu5j/b7N32h58ErQ0FfYVCGwlnt8l7213DDEhf3W
 +DBuUqMpT/gnekoaUtO3lGItmZbqSoTvHHUE+eHsz/Nu5QvwJbMpn0yzNxHrnMEIepb07qvbGzk
 kg6lZzmbUKtBDK5NynIqzVxYcNzRtKDQoV1+ha9lCeeeRuEenAllDu1lfy0O8OuOiE7b/GZMaK5
 eofBd41pMsCQwbZeWNQ==
X-Proofpoint-GUID: 2nOOzxUed4YAvIRfHo5Nig_aYlxMrrcU
X-Authority-Analysis: v=2.4 cv=UtFT8ewB c=1 sm=1 tr=0 ts=6a8839a6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8jWgAth1d_VLo0Q-LswA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210089

On 26-08-21 10:52:15, Christian Marangi wrote:
> The AIROHA_CPU_PM_DOMAIN config was wrongly guarded under the Mediatek PM
> Domains menu and was unselectable.
> 
> Move it outside the menu so it's now visible and correctly selectable by
> default on Airoha SoC.
> 
> Cc: stable@vger.kernel.org
> Fixes: 82e703dd438b ("pmdomain: airoha: Add Airoha CPU PM Domain support")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

This looks OK to me, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
