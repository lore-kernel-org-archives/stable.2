Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A65384CE5
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614900; cv=none; b=IUt27PAFmxZPYpmsiBeALbg4tbUyqQKgvQQ3n2SqdtgcCfxSt2q/yeS1tvbVDan/Fqfl4d810oM7Gp0ua36jpN02ZExMKj55tKSu6KFYhAhkOLUwi0RVPtsIZPo2uclwgb7hwtQJVzK4vA8rIgFWLbzr50z+5ovRc5ASvjJwbSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614900; c=relaxed/simple;
	bh=YdH+rcUUwQG4jTDbECCNSQbx1lQSLf+Jy7CGiJvJn8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N40TRU1kIh57HoyuMgyjOwRxXvfO1aGtMqnsALn+3AQHjULrG18CGKOH8UTRMW7EoI8tzEVcurvJ3kPCCf9QysWwRhy9SJwao1XXbZP76Q/v5uOJUxYyNq8bOrQ2S5CFw5ZXlOOp+NiIBFYnibHjpb1cUXV7bZAdZHCC/YeU70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JZgBUrtP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IAWCa1Sn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JZgBUrtP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IAWCa1Sn"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GMmIUu3107042
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hocXG8IEOu26x3uoW/8TyWIU
	kuS1tUtxSAPk96bBQFY=; b=JZgBUrtP7mjYA/2c+XdWjFStdwCF3IGdcTGKxh1w
	u7QnHdvUH9+pSM/ZnwOrTtxJFnSPk8eEf/JRSJS/PrQbPLEhkgwt7TJ2lBacKkl1
	uIvfBt/aJHdceqkqZPNdBR2OvtFIuBApHaCMsdA6dfNkFIB9cZyxTcpvI0PL8tea
	s4OI2J82YYimlmiL79aPywhwsRyOVIWWc5uipDUyU+4gRGWU9oBtBjBDr4BDn81o
	OeMcLN2WiSp2GJf3TfhFqU5NruuSb8OmD1pnMKPAfsc8+RhPbhjc5n7bZwIZSb0A
	4LtYTDN7iHYDfWmtdmoOhlGrsqNGi1rQ9DclJqDM5GmhEA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquw2u5mq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:14:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b8088203so354079a12.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789614897; x=1790219697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hocXG8IEOu26x3uoW/8TyWIUkuS1tUtxSAPk96bBQFY=;
        b=IAWCa1Sn/wlvZT3fuFndrivmiBBmCyj2kQ/5cuMQA4KU2fvabrNF62wmR6QOMIG8D5
         5KA1BJfrxjwz+c2DfStICHbXg1itqlFwSBd4E+dr7klaJfhYW5yx4/9TirLJ9E3gAbFN
         fIORsj5B96mMPPYNqTo7Q2lMRPVIEBDQ9QMESaQVleWrLx4xjr5x82Ul0Cc6ubRMVHjp
         utr7b8exYLBZDAmz0zC71rTNmkF26FbnuoYLK/wuD0HaLtTSwGs/BbgRZRJ013zPt7+T
         BqdWGyb956D0hI+9AcrDAqGGzAld+Yj9Ts6f3Z8U6FSXoPPx5NkWVebAbxbdf4BL/oEF
         WTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789614897; x=1790219697;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hocXG8IEOu26x3uoW/8TyWIUkuS1tUtxSAPk96bBQFY=;
        b=f0F6H51W8o+n6+nPV8SYU3RfhaaKQaBXpjQ+Z1mJg5LhVittDtrup9tEsnWlZ9FOfR
         ryH6QRWOXyVtQrNAWmHNOtCFWj8+gGHEzE95SlyfGl9Te6q3AWA8tni+O0KOcqtpr60C
         B9fUg7aOmDWx0fRMqe9arp9m0c0uKO8uqadKef3bC9QNRkqU1vTZ+ETvv7lyV4KJPxE+
         m4gqK4N/1NxMATY/ZVwW1ZhlEAcGkp8BvZmOznFJvxVgP6CSaOGToetjI37//ZBMwdMc
         0eZy9h5kP3LaiCiCdJ43zxDSDpt9FCH0BbEX/IUAT/E7afsOJj/4h0bBPGnGdw/J3x3r
         Rfsw==
X-Forwarded-Encrypted: i=1; AKwUvBz25/BRFrKLeFnK4TJIVKP+5vw+7PLJQdj0vnNkrEv8bmI/44bhaq6FnxD1oEVh4kQAC+bvl+g=@vger.kernel.org
X-Gm-Message-State: AFuF++kdf8gHOXi+qMOZ1Uo1SBGncbwBai1+fT+N5GF3uTLCi3pr7p4b
	C1LaSiOWf+OCliXx8RQiEDqK1IUS+okJBw5uzTs8xXXFn6mesfHoRWkOzm3VPjVjSrOc30HxZDZ
	rdW/obKf4QNhLF2yFYKjMtAcxkGy9+5goo0Rp2sAtYcpoZzyBHqohg1aWVjA=
X-Gm-Gg: AYBFou1drNBVhCEFguAl0TF+dkqfpeekdVUXWOxx+7IAkYiCioCR2njKA3QggtzIoDS
	OFo3z+pYqEoK6QSzP52GVseCIY0X7Kzt/2fR6WXRVJ5X3DlVvNT9lrkfVE4ULVjF6oTXa5D86vJ
	TJGVL3OX6Z5mdBuZKv+Vq5cfhxBWYvzMrezBRfAt5cEy6MR6dkTcCyO1VOQ+gh1Kya0dWOK0yCG
	NRZEJUkaL1MrajuCApLnA/jJkMmJmVRo6ZKyX6L56xEJlD0AI0TVq82bxtD9tXplN5/+QxZ8RJK
	aZaqND/GyNUPFOifUirRublFBQpm2XrzYPBMAFamwoBqnmE/DBEaw08oz2QyuptFiXK/CsP3aSr
	AyJqpH3s9O1k8t9NNgKv009AHohF8qbmxNgNuydLJb7c=
X-Received: by 2002:a05:6a21:3315:b0:3d0:9590:7148 with SMTP id adf61e73a8af0-3dd5f5d86a1mr13812187637.17.1789614897256;
        Wed, 16 Sep 2026 20:14:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:3315:b0:3d0:9590:7148 with SMTP id adf61e73a8af0-3dd5f5d86a1mr13812119637.17.1789614896794;
        Wed, 16 Sep 2026 20:14:56 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395cacce6sm9963228c88.1.2026.09.16.20.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 20:14:56 -0700 (PDT)
Date: Thu, 17 Sep 2026 11:14:50 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Cc: linusw@kernel.org, andersson@kernel.org, brgl@kernel.org,
        pankaj.patil@oss.qualcomm.com, maulik.shah@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: nord: fix GPIO interrupt target width
Message-ID: <aqtbKlBVxoFqohsN@QCOM-aGQu4IUr3Y>
References: <20260916085720.771498-1-zhangfei.gao@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916085720.771498-1-zhangfei.gao@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDAzOSBTYWx0ZWRfX/DXnKgcyj/hk
 O60/LVuyLNrY20tvZ+ZbyoQPPruvqlS8ZuvJ24Qxm2jXaB9p/klPYIKivV0zIRY5DDxZBo4jxLr
 ubydVu6SuRC7mWnePIlMxV8B1naqbkc=
X-Proofpoint-GUID: uQ9g5Ce5DvGnC4oJAvWcanShu4BF9Qda
X-Authority-Analysis: v=2.4 cv=N4m8hG9B c=1 sm=1 tr=0 ts=6aab5b32 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=NCczGnymYEpDLu10qSUA:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: uQ9g5Ce5DvGnC4oJAvWcanShu4BF9Qda
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDAzOSBTYWx0ZWRfXxIpuoEuoKrEP
 ajamEVtBsjUa0mbhI2SvXS2TUjfXdyF/TdKpd2R1rgheRvJ52LmahXa8OWTcj+LNhE0aUxlsprq
 lVfqvHWNP1WcdLhgyc9V+Gu3KsbI9+hlqqKbUwFaY8Vx/i3B9RCKWJGerhyilcy3bz+hGIXfeY3
 3N4xPx1CiQYruWWgX4FHsKp2L8Sb87MgMs0EIl0PMYC54TsRmg7WuliOooop6vdVQInVFuYo33e
 tilVVrC4JNDSZ/xI/0KMKlpyJfZWNAezrSbNWP1kWY28dFBeVywxA+0ugLb6bgbQxsDRoS4cwEM
 mT76Ewf3NMPIhR18vbTyzgUVealGGtc3qDb/lL284jdIIibmccX86K33mkKjGEC1rJvupAnJtCH
 sjb1KIY188msUfNPTQro09+fBaFxF8484Vt7dknQs5mJjZqN4a79/7kLX3gcu+MKVbTPkJwJ0PC
 i1cK/ZRitldKae599NQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170039

On Wed, Sep 16, 2026 at 04:57:20PM +0800, Zhangfei Gao wrote:
> The TARGET_PROC field in the Nord GPIO_INTR_CFG registers occupies bits
> 11:8. Describe it as four bits wide so the common Qualcomm pinctrl code
> clears the complete field before routing an interrupt to the application
> processor.
> 
> Without intr_target_width, the common code uses its three-bit default
> mask. Since GPIO_INTR_CFG resets with TARGET_PROC set to 0xf (NONE), bit
> 11 remains set when the driver programs HMSS target 3. The resulting
> target is 0xb (HPASS_DSP_1), observed as an interrupt configuration value
> of 0xb1b instead of 0x31b.
> 
> The GPIO interrupt status is consequently latched, but the HMSS TLMM
> summary interrupt at GIC SPI 208 is never asserted. This affects all Nord
> GPIO interrupts using the TLMM summary path, including the Ethernet PHY
> interrupts on GPIO55 and GPIO141.
> 
> Fixes: c24dd0826f06 ("pinctrl: qcom: add the TLMM driver for the Nord platforms")
> Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>

Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
