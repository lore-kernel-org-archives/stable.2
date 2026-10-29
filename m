Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280562;
	b=Pv2g5PrEAyLJcEyOXLJCDmFi55hZKPRf218DPMUbBSjNnLxi2cVCa+bOsHbz0cvzdK9N
	 yPOeknDbgI7IfEc3cl20f8tV9hNG5ygmCpoN7tYYRgE39Nez/jSgxEBkh3bPNNd2FZUNB
	 9PJvGsm1DZnAQHBAXoE+E8crlht4+BW6avHpGnNuSgZH+LX5seZqp0ZegP+KR+BcFKQjP
	 li14NW5qFilagRyoatzlxkjbWQUr14mHBrcNoy8VRNYamukCpwr1j2lzgI44yzqwnc5tH
	 FWVsaJpZiZguzZ5AgVQ+r4WM0QtYUqubeWF8zbnfM8gT17zWPx1PZD/KfnEo8ZAb9tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280562;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hdNAv1DWvXXl8AhO5BI1RSsKl6nrZ5HKBAmEionbXos=;
	b=q571BwqBeJnnropBmOcTOHG7JT3vL5aXZmgNpJ+iwjjvJjrT3+1YkSoAi4EY3+FC5xVL
	 SdD2zkbDjd8BheiEG1OvVE6vfAOnnUDI8PED21oJizlVA8xWbBI+XgtRFG/scVr7V7vuT
	 w2HaYs8VePkt64JvpeNV7tVYXYpK343wqlJjo0Z3joEVj3ObKPlOpQ8Sxn28hJUI1fBZn
	 /++pL76Wi/0kQqfaLVbLHxrYURL6RU7xZd9Xl2AE1iDoCQbnkTJLegKbQsS/5mDctKvVo
	 FHvCbugWRLr/i+oQ31b2mMjsEwqjnVlXXblwSD0ATEBKwzsujAQ4ANaXudpcE+0RMCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oRuQK3BQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N4SQHm+V;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79DA606A325
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B79DA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oRuQK3BQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N4SQHm+V
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCePa43215076
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hdNAv1DWvXXl8AhO5BI1RSsK
	l6nrZ5HKBAmEionbXos=; b=oRuQK3BQXyzkGuOzxHBHr2ppzqgCEJD9XPLxut42
	jjOCo6h0q2c2DFNDa4hevb6u7QefiUicMYsGvkBXfyyTjOxGABnJrrJ891jpvkM1
	rojqN5G8A3YjgKjV5fkK729I9ZD7ef+MYbUf0w9K6ctPZ6SVDGkpESGaoBs9rYIp
	ZkpINwDT3vaFzak0hLqAOUwc5v5cOd3Ca6qcG/2gUO6MnpjEUmId4YYINe4AzQXI
	pHCt+jOWsAMALyr4RqPIxiUwK7heHmRM63xmhSnRZqLptZWeboFoSCcM74wO+Msu
	hHqFhtghPFFPkoGlH4A8a5/8ie+noqbAaq42ZeVcEZx6/A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5s9vj7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:29:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e832c03576so31713565ad.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793280560; x=1793885360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hdNAv1DWvXXl8AhO5BI1RSsKl6nrZ5HKBAmEionbXos=;
        b=N4SQHm+VXzeW4REvj+4AtK1iawDIxgPHVm8sDOafNEVDEyf0byi4UmWMztzXCXzhzh
         82gGwT1B1wsFVstr2rv49/Re73NO5c0cmK1cDpmTviuI2YJb/A3V2uldAl68MbAHYFBX
         9atKPq7+TrCiIcY8wjm5JTZCSdH4g+q/dF0PRvhjHVVtgVWscX35nWHTbwJP20Xzw/C1
         Mes5B4rHFPnSDoEafbb+askF7Jq2pjVhW3N0MzO5fO+gVa9A+Zv9xwdcGfsfzhciTXoD
         j22TYuLUu082Qtgm4pLQb4jpibrTVqjLq/jD7ys5wwV5Ka1w75AOfKkohOwBTvOOS3W+
         +oKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793280560; x=1793885360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hdNAv1DWvXXl8AhO5BI1RSsKl6nrZ5HKBAmEionbXos=;
        b=0sIVgNMvknnuvXDFYh2yi8aSzXmdOldfiX12o8kofobzPWcIBzSydyzpHE2GMwuSnL
         +fu3w4Kq1Bwc4XqUQV9njQbaUzpA4FlENC0DXxTfgjeXLrtRQthFkcd4Nm1KZdCPtF2w
         ISO4qJwMLY/GqwCisvSjvKKKRucNQTHlzhIv5DernxVvJtS/OrntsNJbosqIpWrqd3ak
         hfNX4vj8XWVCNVCsAVoP2LN4CtpiOk2u6Ek2UhhrhDIMRU32iJaeIu72FY4zM43y6grF
         fgWkQgQSvZnXSK7Ehq5JLBx6LmVYQxc45GFCmU3POWQrvA+t6cwBn1+x0MMst1dIsvIz
         cpHQ==
X-Gm-Message-State: AFq9FYKwcUzP7L43adm5ezxtulJXy/AILbjTyvHiCx/Pl/wsJj4u406J
	0FJo28kFB2ZjmJ1uyRT+NsKMiFBEWlPs1Ag/C/9tJS5dRPIae+XAsatBq/bo4oXsJ1pIUUu+Xu6
	uChlKQOOkrDf0XXup0fsvgFKXFpiIk1HkJ0v/uTv6ex4/Y8I7qxT8IDvOH94=
X-Gm-Gg: AYBFou3Hy4KDAAe4Ua3GOsl4q0FkPys8nsuhNLpKCrtGkcA7CtHv79uClGuKDvt66pj
	/MexCM2mteSBe439PcJ86VJjBJaasn7W8IDu806+TrGUssekAC4SRVrexERvKGhWXmxNL397WNl
	woweK6/aRikMRO8kaqnFuZoaS6sn6NirVSRMnUZOebYMUxbD8VJI5ETjiS75AOrPhWhC3zG1tMx
	cA0n0mZ/rj4Z1O6oCRJ5L0xbtQdn6R6puZwRQtMCLtofBvxVD9Uf0Fu6WAacS1m9Wbjy282OYqh
	Vh8b/DQ3mLwFE+E3opSzCxyNl2fASuEYqByaqEM459gWFtnBoiYGugUXW/qmP2bNNYRHLs/DeoQ
	BQFjp54Uj9VNudi1UynbIPuNNG/TRJ1zvN3kQIqtnwHQzdaOZ8ZMYGEKZGTwfm9KLju/NZ0dAKv
	vLbGWHfPDnhy10ANM=
X-Received: by 2002:a17:902:e886:b0:2eb:1ef1:f055 with SMTP id d9443c01a7336-2eb1ef1fca0mr22399145ad.46.1793280559766;
        Thu, 29 Oct 2026 06:29:19 -0700 (PDT)
X-Received: by 2002:a17:902:e886:b0:2eb:1ef1:f055 with SMTP id d9443c01a7336-2eb1ef1fca0mr22398775ad.46.1793280559240;
        Thu, 29 Oct 2026 06:29:19 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6453e90sm34035495ad.1.2026.10.29.06.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:29:18 -0700 (PDT)
Date: Thu, 29 Oct 2026 21:29:11 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Yingying Tang <yingying.tang@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavankumar Nandeshwar <pavankumar.nandeshwar@oss.qualcomm.com>,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH 7.3.y] wifi: ath12k: Increase RXDMA buffer ring size for
 default memory profile
Message-ID: <auNKJ88kK1_QTPTi@QCOM-aGQu4IUr3Y>
References: <20261029095541.685879-1-shengchao.guo@oss.qualcomm.com>
 <2026102919-confound-remnant-f133@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026102919-confound-remnant-f133@gregkh>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MiBTYWx0ZWRfX93g+PQJrlAv+
 vQmYLv0fBpp467sx4gfWHOKtBRaHXcw6oGs6VwX4Fb4IHOPfBo0SI6ARpiC9OMp12mYke8YZXh7
 M56fe2XFpiWeEuViJghCZYja76PEDZ0O4ZUgYR4Yc4TwKQR2J7KmlEOQWBtV9VQMnldzkrz1WRH
 bcG8VEBEkl4MMPiwNLVqaZPkeNOoWvoR8Qn30ABflop93MFp4loYywI9QflPdt7dnPOlKsUXIin
 ihwu/IqEo6t4oTklJxW8W2WX+9axt1ITVELkR9bdZBTU/nuhr3SElbJ/cJMfNyt2mVsXUk4Z7oM
 oN2I6os5JtVXaj5e6xld85uzHNeLt7/m9BzJcwNiPOCfKLfW2ezLtauGTkYddYJLkaQ9kjRT/N/
 BSHOiyp23YdkwX/3Ovi9ytigiONVNhOckWvYGv0fbRW987Sfi2UcdGC0g3I1jEHSbBq86mRzAvD
 ++GKCh3UWlDWyk2HY/A==
X-Proofpoint-ORIG-GUID: Feqi3COay3M6XDJjkRj7MfbdpQF5Dt_R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MiBTYWx0ZWRfX4mxaxpxbXe30
 P/tULQfFM7nhAoxWy4cIUCECCYVzPQEqT5Fdbk1cOqvSzbwfEBu7kxsSTN3wr3nLfsV2vWD3aVk
 NE9FQL+reb8tWc05/ZiKQBEHCPAlvq4=
X-Proofpoint-GUID: Feqi3COay3M6XDJjkRj7MfbdpQF5Dt_R
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae34a30 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MGbNdRo_2CZBHlq_cxEA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290052

On Thu, Oct 29, 2026 at 11:14:27AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Oct 29, 2026 at 05:55:41PM +0800, Shawn Guo wrote:
> > From: Pavankumar Nandeshwar <pavankumar.nandeshwar@oss.qualcomm.com>
> > 
> > commit 15f7603b69a83a0acc7fcc8992ecbea6110f9424 upstream.
> > commit 643f0bf936176c114d5631da7547e991b5d99f10 upstream.
> 
> Huh?

Hi Greg,

These two commits landed on upstream as a series [1], which doesn't
apply to 7.3.y, due to missing prerequisite changes below.

  wifi: ath12k: convert DP_RX_RELEASE_RING_SIZE to inline helper
  wifi: ath12k: convert ATH12K_RX_DESC_COUNT to inline helper
  wifi: ath12k: convert ATH12K_NUM_POOL_TX_DESC to inline helper
  wifi: ath12k: convert DP_RXDMA_MONITOR_DST_RING_SIZE to inline helper
  wifi: ath12k: convert DP_RXDMA_MONITOR_BUF_RING_SIZE to inline helper
  wifi: ath12k: convert DP_TX_COMP_RING_SIZE to inline helper
  wifi: ath12k: move dp_profile_params to dp.h

So I adapted them into one backporting commit. I'm open to suggestions
how this should be handled.

Shawn

[1] https://lore.kernel.org/all/20261007-mpp_ws-v1-0-739b1fb87d24@oss.qualcomm.com/
