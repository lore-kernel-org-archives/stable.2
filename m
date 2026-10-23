Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744046;
	b=aSbUPJMrENBizPV4XoNBytVkQm8a80Cwfpaqlo7N0HokXHX/Cd4FxyKJhNCnkiRUvw3L
	 NNd4MLvvWhu4QyZMGu0pm7OIBWYTzJ+85FNvu7a3MGOkzwDtwH3D493YTodUIEVIvFbFj
	 vePqWpAn7FP8Vuyq8YveuEDEGrmPNtSspECYFDXMIMs4LqpMd86DV+52M/TA7z2gy8v5Y
	 kUbNiTj0XEQYu1vuOQEgxyTKjGs7SV//eZHrEPvY+JVDxyje/EOEp4zcTl984bAw2uoGF
	 lb+vW2CslilVXH9O2s2Ehbh1hNVDVidaks8pxRm3TRWfT7bvaaYu06PiUfLvRGurzkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744046;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zizJUYpF90Icu7Caq4ljSkAipD1RKR/iCocUSeqdLk0=;
	b=A/m2qqkvzgeHRbTRtQmZx8TezJ3cajoI+2s77X0fi/fsDncpG1ScqN5XTEr+K4B1Mfyp
	 67veQhaQPovs9rHOimWoTczQpJrDkp+yoTt/hjrGcrVHwiIJXVnAyz76jJMusF2OIy0cC
	 FmffDaOGVRXoFkwi564j1VfKM+NVaTdARHF0hgivxgAadyP1ZdfSh7bOWqyTunKa6SSuZ
	 QhQeHxp7DQTlRB/Z7m7FK4d3tOalwuphPqbQHRZeIrN748+CZljnsWXxxUv3q6XnfnSOA
	 I84npaswkt39sZ/YrZ1HDKjE0VICbBnZfJpsyCkCVHZ49UMpN467dkf0eoNJvWJ1SoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="mH/fK2OD";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YwBQvAEA;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2F606A32A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4A2F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mH/fK2OD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YwBQvAEA
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F9sC2067802
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zizJUYpF90I
	cu7Caq4ljSkAipD1RKR/iCocUSeqdLk0=; b=mH/fK2ODLMx0NaJy8SAVUy+8O41
	sf/g5DDIvBGy+KRo4bRX/KrXkDMsZ7ny6Fmio98mwWlc4TwYpTAqNGD5K5kxm0uI
	fvDqvWT2uBQIr+un6z85DymnjI8lKMSAcBKvYSzVa0ogqCqcxhSuDvuPRnFISMkq
	V/UL4nMbNppJA7nIgWBmLW8a6a9Y3ZRhARnRbXRaS6nKtU0b/TorCQFXBQczcduQ
	GxK6ufzKsFVbxzAzzggp4o6wqMKqrSdZEMDMFBkPb/J6FZlFznw60XIhNAoc6AxG
	ygrQqLQTt68r/Y9Og3S1VxFJIdpbehKbtF/UZkAdPSYPSATXyp4NPysZAKw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw37xx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a46f0f158dso1066707a91.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792744044; x=1793348844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zizJUYpF90Icu7Caq4ljSkAipD1RKR/iCocUSeqdLk0=;
        b=YwBQvAEAcqF0a8VJ/u1dGsLO+vnnCtCn1uCtOHCdSf6AIHmRbfNYtJdXLgf2sqWzHu
         reody0q8nEeTx3CDWWXHy8EXpHr8itwMCZp9+td/g58gJcmR8Qg6eA/IvGo+ew8aLGHW
         OawAvwWnH08RqOM6u2vSVWVkz0Tsxn0slnQ/JOMq+QSnaA4ukcaOZzRvuqr5ZtV4wXAP
         1r2WCk2NKBm+P47W8qJ5hQyduUaAoyGqwK9U2aQH91sjhqLJ+LobyZ/QU/9Gor+DaqM7
         FVWFLAsR+kEgnCfxzh1+wwAJtPlOuEHRVc0ddg/vUExUZyQBGevPU17fb2mGNTs49HkB
         wk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792744044; x=1793348844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zizJUYpF90Icu7Caq4ljSkAipD1RKR/iCocUSeqdLk0=;
        b=CQ6fcUly+PDy5zfMj44T4jeu1zf4Bl9iXuqjHCL/xMK+sBNN9r208Mwwo9BU5fDOFe
         x7S2J7esPmot2eyuLo3eKc0OSpXXEsabaSTNXZdlbWVVKws1Jmf4f+FFnuYhzMiwcOO/
         QRrLu+4p2tPdEGjI2C7FlBniO/Pk3sRI1QG6FlH5HP4K9lTNKMxG8uV0/lUGG+sOQIvd
         BQOJbWfcQtpXKqviCVTB4OinXh/088Ug9b8djzLm7SBkDE5c/zjFokn+fjZexKcZOw52
         4kY5MKPpf+wwmuyUgMkOyG3QBY/XoQhcmvOwqronoda5htdUrVGGUXbf4JalPcsX7H3X
         oBTQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMR3NJJMlPPd6fIeczfqAQC/XACcYbgkOCp6andCColZmU7uIDLO5bmazBLG5biGXmYW7FuIY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqezV+ZoPRBkXziptOGvVFIRmP08ubJCsfdtwn5oXr+okjSFTp
	l1hCgW8WtC//0JTOZUOZ6NjyRjI8AZc8RA75Fpr6DppC+/we2FT/xwaaN4zcGkJM2LSciSWB9MD
	w0YUCy/DtEUIPmAWQo4e6WTeZ2dj2w09O3SljtcOQLmkESidV4rFJd7EQPpw=
X-Gm-Gg: AYBFou3opgt5Sr1Ah2WKWKJj9wBm//9fT9s/KCngz22FLharRTLXDKHSdl1tc8+ACdV
	OZshkkMhYL5HNdvrPYNO9HSp96YDW6ZC0kvChJciiZoGRmc48vZgg3Xy5C+g8tRsyu3VRp35Kwa
	igzSODDm54CxPhCMq0UnUCn5layWUDjaeLmS4060iw5aZZ2dcl2y2dkV0DIa/qih1q3PFo7g5Vt
	Ct7oXSBrub4U3Ddcm5/I5iTgTh0lyWLO5zhU7pNxyurHxDpptEBz/PrCteaJkbLmOvHnt4ia/L5
	5XKcT/KbUZkk7HhOlmiACWkbjrpKy//gL5S8utmQNEiCGxdCnMiu2bIHslKiQ6VPmK6vDof/wuG
	ZH6CyiUzjzmF5bt59CW/DVWmUkyDY04z59A==
X-Received: by 2002:a17:90a:d40c:b0:3ac:8b67:185b with SMTP id 98e67ed59e1d1-3adce7a5628mr853302a91.26.1792744043673;
        Fri, 23 Oct 2026 01:27:23 -0700 (PDT)
X-Received: by 2002:a17:90a:d40c:b0:3ac:8b67:185b with SMTP id 98e67ed59e1d1-3adce7a5628mr853288a91.26.1792744043055;
        Fri, 23 Oct 2026 01:27:23 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb0a27basm2692616a91.6.2026.10.23.01.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:27:22 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: fastrpc.upstream@qti.qualcomm.com
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        ekansh.gupta@oss.qualcomm.com, quic_bkumar@quicinc.com,
        stable@vger.kernel.org
Subject: [PATCH v2 3/6] arm64: dts: qcom: sc8280xp: Remove FastRPC compute CB9 entry
Date: Fri, 23 Oct 2026 13:57:01 +0530
Message-Id: <20261023082704.2859978-4-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023082704.2859978-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023082704.2859978-1-abhinav.parihar@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DTPkZtJpewKgLA_4kF1k1XXKDN1dz7Tu
X-Proofpoint-ORIG-GUID: DTPkZtJpewKgLA_4kF1k1XXKDN1dz7Tu
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb1a6c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PKVKsYk1ooiKBYXMgQMA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX/T0pTPf4IQRY
 7bVeJd0B18mYBvVH7t3u3FOlB2fKRUcpcNHpoSTFbv5VVQ4//IEzRAdW/zGstzxKdhjUWKK+nTy
 7giFk4OV8iT1grV8zKuEj27QT7wu6lo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX3u7qlG7YJm8E
 IY7/fRsr6WF/zvvCH5j76WUjUi1pWz9o38QmxhgGC01UrYbBn/V8ylL/iODBFwI1N4pVpLozn5+
 WOVzj7MAcLro/aPVz1MHqMphsVogqfVru5MUgSDOZiVCwl8lenFTX+YBXM/ZUFjOpQiXXcsRkV6
 7OwJmi4UQ9AkE6XkcJVYDs5d+AVDeh4x9TXXBaj51hc7XRT+2HtGEbNOTfxv+8nG2LSPCy/xBmo
 NiVfzf2NzjTCrS4EzKqyuYZHl5RZDImlq+NJh2ZGZjVJM/BNH7d0xrZNQwibijRHtQn8iGYfY2P
 6KRV91qfMUanZ7g5S5kbAY+YwnrFT5Y1Nbutzghl23E4A+lXQadmYmZ1REV8qaPk1hwulghMNGm
 e+pBxx/U2+QEpxK8GrR/8JV5pnCEwI5vf5oX5ihNicBl9J7w4cFXQG2r/I+Sv6Evi1KEvP+lP4O
 8fD2tNG7/Me8vYi1vOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230033

Remove the compute-cb@9 nodes from sc8280xp device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index fbcfd3883bbb..3a26377aac5c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -6279,12 +6279,6 @@ compute-cb@8 {
 						iommus = <&apps_smmu 0x3188 0x0420>;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&apps_smmu 0x318b 0x0420>;
-					};
-
 					compute-cb@10 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <10>;
-- 
2.34.1

