Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774783EE1D4
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339305; cv=none; b=V6rtjfEK8MRFQX9tTcvs+yNZRHS26KWuvwDMbcmDW62AS0UB2UIC+0dl5PEsUldXBoai8IxaQfAzp09IjkXcTf0NuPCSzqpST6owKLKB8/YJj2ughbF7iOAYgDFOV9CPhIdRnEd2dukXPgpe7nJGgUXNOfb6P3t2XPpQxw00mIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339305; c=relaxed/simple;
	bh=8ZsuMNcUVZm7mjhEqLDBiWrZTq0eM385R2TFVoGgUt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QH48Hoss0kzeB/3YodY+/HHGujRJrwQyTFeikAVm0MVBimFQmUnl9cHdUsKzRgRUQWUp5hHJToOPBV6+Po+0wuR7xL3Ib6Liu2hw+XHYFH+LSbcAqqNFDIuSgd4ltaJzxNelw2WSgQXc66wwyvO9s88vzX1DGvhpxkf5eKjTxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZuEYGAW5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JfiztdPP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZuEYGAW5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JfiztdPP"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826W70N1205594
	for <stable@vger.kernel.org>; Wed, 2 Sep 2026 08:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NUtxacGWOyKrAPoUx9C+oFwy
	O6QG1COqD5H2J13aHfo=; b=ZuEYGAW5iJmO6dipQxvLvliAOw+tAc83D7b50ul2
	NBJ9LlOIqAwZhveXSqh6YcChyvJEIq3hLXpS1l8/RozKrKI9+94p30tahKiu6/wc
	U8MUIXRCIE8CmjjzCCIRH9rJ5kXbBd4EqIXt7l6Dem7JLcWPOqCOIYhrsOES8jyA
	+SqmupwzzYthypqe5mB1AbcROr9/9E/c4z2d4xSOpT5diqgdhIDUf/JxeGW3T+rC
	IqFLAIDC9een6UljZbd+HlScGizZfg3xA1YlL/jv7cXNbtAS4Tgvn7GhKSmuTeIr
	zFG5H72i+fzzKUlrWEPFZ6cXnAlJ3H5Sii9xkbJatbreGQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdynt4c79-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 02 Sep 2026 08:55:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93918756165so227026785a.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 01:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788339302; x=1788944102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NUtxacGWOyKrAPoUx9C+oFwyO6QG1COqD5H2J13aHfo=;
        b=JfiztdPPaJvPHVqP6vBxXzovlO56WjcR158M2ICw+3aGOT01VCKQM7lGtH1sYDpS+3
         P3VrzLnL8wDGJCsK7Mrpm+6skVp2z+4/5Om6kSclReQcl75lP1+DG1w/oVBqOV9Vw0Xu
         BJi7kUvDF0vqdsZuwB1Xt+e1bG/TC1GBEMoXS9kdxtRb1E0SSOB2rsenXr+eRurLQW4s
         MWX2IU7BVwQ+cg/UqHTzDrYVr4v55sK4zTIpn6Jrr9tQJ63SlLNRfnlWkHE88uQrySnr
         1pdEzwM7yan2+7sUboyqKSFvgIB4ppJoODEkmNupTHOO2LJEFRWIhQf60dwb57knwopc
         yIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788339302; x=1788944102;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUtxacGWOyKrAPoUx9C+oFwyO6QG1COqD5H2J13aHfo=;
        b=o3QkVO5Oag8ToGqvOG0aIPKLDKkaF2ofm5NPaw3txSUUkKhPUL3j2YyKAb9gyQ43he
         vJ8SmRLojfydLtVVuvRAIi9v7WUzte0E4yipH7dnccl7InHdKIKYN/LsqvCT5tu+OV/m
         JrvKeBCwR6Y+T5n3qjWGT8UGyRqs1ZjGCzmzEm1Qlrpkv8iGkuaekTb05kHY644hrsU7
         Kzzu0dEhMmSwCQ5PjV4KebmSpeCJa/eyu6uburODB2YL+2eU9MB4vAROFXZe2kHP8yZP
         BiGAPNQ06MeoEYKrbG7AzZf4JeJz7A6CoZlftA96WYyZLf+76kYl6APdyClT4w/pT1C+
         lcIQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRGU7cm7EGQdd4FcjNBphbZqMpKFBWO+Cd7LwmtCsTdL2gP7bMhjKKI8GwLRSwE3XBaD18nRc=@vger.kernel.org
X-Gm-Message-State: AFuF++lhKrGCBN+0GMnI8vp8YQp/bA9qaLsJN4pN6Zd4B/I0U3Ydtyai
	qys1OjfhzT1zSTclj2dySVKbh3fsP5xIpZDOsipYch0+EjAWaCuTVisJtq/Nc3UVKP6ljJEIAuQ
	j2X1gl+G9pCPBALNu2SAoPg/e4z/nz40TAb8MNfDGzO2TDGIV7o0KYwD5lGk=
X-Gm-Gg: AR+sD135DOs2jvP4ATeDY92xH7rjljy1P/Ad3y8d03JaOsCuFSlqs0RIYw0RgHVHz2F
	X89Z+AUt4YuMG5pPTxuMabDibuJ3bKr9xfi3j8SWnZn+tREY4ohJcLIQnK8NpT3/mtyqs2hV/TL
	Ng8huDnsjXHID6t+2pHmqkSzShbiNnznNKgLhi2hc/Gvikqa169CpqNElKp62Nh+XXfBQyB6u9U
	leKi4ZG727NT6x3DgeGSB80iw6Ecvsv2UN9J6bbGKmgp4MRyNc3h12BUr+5RuuYDTAJd3HiJnNo
	yv4k2ax3q07mmRv+0XMd1lZMjKeWCzZz0sWTc+FpDfAcfeCeV2lVKqlkmRoivXn53IubxS6v5y3
	Uhume+oSVYoqVosg=
X-Received: by 2002:a05:620a:2259:20b0:939:5c74:5dd3 with SMTP id af79cd13be357-93960cb15dfmr284865485a.9.1788339302019;
        Wed, 02 Sep 2026 01:55:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2259:20b0:939:5c74:5dd3 with SMTP id af79cd13be357-93960cb15dfmr284862685a.9.1788339301509;
        Wed, 02 Sep 2026 01:55:01 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce45f4f93sm52361235e9.0.2026.09.02.01.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:55:00 -0700 (PDT)
Date: Wed, 2 Sep 2026 11:54:58 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: jens.glathe@oldschoolsolutions.biz
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
        "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: x1: disable ps883x USB4 capability
Message-ID: <ox4rfazd43csfv6jkn3shorhg3qkgnol2lyoxs34dhj7zxileo@2hirnxvga4sf>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <20260718-ps883x-disable-usb4-v1-5-cec86d0b909e@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718-ps883x-disable-usb4-v1-5-cec86d0b909e@oldschoolsolutions.biz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA3OCBTYWx0ZWRfXykNZDsl00tFp
 aOIqi3WghxK2m9OD49lmOzLDvNuq++I8mqoKijr2uls/6c73E8sif1isQ01cqJpV7gMZnMa+Zog
 EtjItR8EXRXZnQffPKG5yMln8eI/IGjsRMxlFzYHwutS5ZpECkSAiSpb0sqCd2x3FkPiPXLqTb5
 b7Xygt+t/pMmLvgI8DrVon8gF16SlpiNRfptyJjhKaQl+b3hS832dd5tPFNUwn5HoitBdOPLfWk
 a3o5dgoNLrM3bxnMGct7MkQQxv5kWCC/AAHmHo5Wh6OxicmssHp6pVv0BdIZGxmQ/BPzO6CdiW9
 vp1DkH1797TpcpUZa8fKatISptsUhXsBo/9JBD7UrLW4h3BTWst7i5dms7Yzsy6lVTuH5zyDOgF
 xL0IF4KCksSn40/CZltwk1nQO16tfLYrkVubZhNdhdYM5mprAwvzQbT3YH125HwifVUz5LKyzPX
 NqwQpPUWHFoTjFe5D4g==
X-Proofpoint-ORIG-GUID: 6NuRQQ-ufGC4OkDJt6IPjOvmX11mI8bP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA3OCBTYWx0ZWRfX9817TgzAWasx
 Hl+I8ETntg9uZL6eDKovlc+OZz6cv63raNGys43hAcGWyZZOBF0aSqWnxDM3aqB0iAZOnDLZnQr
 09w+BB41IwAlJWO5yMuZ8Ave1FEAacQ=
X-Authority-Analysis: v=2.4 cv=LfkMLDfi c=1 sm=1 tr=0 ts=6a97e466 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=G5ilVN+faPP2Ze1SHB4iFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=gxl3bz0cAAAA:8 a=EUspDBNiAAAA:8 a=bQQhJZEDtjE2e6HM2JoA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-GUID: 6NuRQQ-ufGC4OkDJt6IPjOvmX11mI8bP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020078

On 26-07-18 19:06:33, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> Add the "parade,disable-usb4" property to the PS883x node so that the
> retimer driver treats USB4 as USB3. This allows the combo PHY to remain
> in a DP-capable mode, restoring working DisplayPort output over the
> dock while keeping USB functional.
> 
> This is a temporary platform workaround until proper USB4 DP tunneling
> support is available.
> 
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Assuming the bindings get accepted, this looks OK to me:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
