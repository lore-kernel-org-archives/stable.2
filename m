Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744042;
	b=Z3U9qR30DzNQyyM4MR8ywcv+Z+al618bP6w1vuR6LLLzSulNx8l46WKqdumlcXygCa1S
	 qq5i3LbZS60l41SmX4HZlk1C/NoMQnOsE8xdM+xuDljSlxpDufaI80hM0XtYuVAOKw6yj
	 1EcZw665klZKenYnFEv+aDjxtkm3S1nL242zz8nnZESIYQkOM5CJzipZLvKNAYK54OHEV
	 4+kfagTQsKFI0o2BefGg2Am+DfNnnATzoWJRNxT3B3nWLFLL2JHV+TVAVOT+lX7I8n7Hu
	 5IDZOroxZg2NDvZCz0GsXOJkDQrWWxm31Fq+ZUvTKemXeMENXRs7IPnqh0u7/Syj/5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744042;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jadIZSIrpTyEi91i+IYQ4URvG2pbKwAmmA1d2i8PeOI=;
	b=4tjS9BHTsRN+AyUEGnHP/xszBfle6UN1Ow3UQWXJ8pKibBE2cy9fWKO+nT1BwGUkEByo
	 ziZCb7Utnw1xAK+HKdl1HssCRAGq8xVwxn2LEQs4wuPWNbCyIo4JsmBP0O1psbkf63FAS
	 E0EUBrOh4+1fKsPHABMYoHNti/uO/u45PVJjGdfRPdi3lbu252w3/sgjs08K2Xe9jXqDK
	 XuDLo5gGqKPiHpN8NfLL0T+aH4ZrptLo7hpgJ1Mytlm0o6yzmx7FdiG81FmL7F3Z3mxDb
	 F9nbqn0Z4o/8cUoY0gZPJ0UAjmEq8XSu997uHSnAZOXMfiePFf+LHjO78M/HdiAop8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XawVo2YX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IggzBypk;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEA6606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DEA6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XawVo2YX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IggzBypk
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FT3P2650369
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jadIZSIrpTy
	Ei91i+IYQ4URvG2pbKwAmmA1d2i8PeOI=; b=XawVo2YXFQFboj35M5h60fviKVu
	p9L4cwM3gFiphmhLSviZG4VLgApLJf4A/kAjwmRwpMPCknl+Ldcecp7S4Ttaco7W
	UVBqELmQbfchJ9oKXppuaCRrHmFmCkrRPOW9ZBApRdYfYA2HBrCzBiLsHU70v6al
	gWxyiJ7Lnp1e5MSAuJmiBlixNFGrJjZDxNn2iySOr6/QzSu28PR+jy1lwM99mWRg
	ktRN7eGI/3a0K19W2iQuZX8QNYQvVnyEVSY9RLAWubYdj73yZBvtXsCQgmsDmnTC
	pYw80FNJAs3z/t1uBXWJnfjx3LGkJNTjyDFURWY2NFu3OJXapcnBfn2a7mA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjas2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:21 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d5dbso609545a91.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792744040; x=1793348840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jadIZSIrpTyEi91i+IYQ4URvG2pbKwAmmA1d2i8PeOI=;
        b=IggzBypkXrB+Dwt4GuWjvaGan5dXUogLdtt3X+9v0js+vDdlLKaphi7bHo7eAde0vV
         j4tCWe1fnBVqb+H+mAWYTwu7FdQAOOLn2tIc3r1O70NHGj7TwexYH5PNEPHPY5eLyURs
         YjYvW48yQRLTKaaycMU8xEz0x8VvKGsbv3esghnwxpyO/gavvdbWpckt/TwMIQtubg13
         pKbPIqSMI6DpsJjyGRryI9kcc1CNSFlSsMyp+Ku82489nzsXVUVkgz0URPCNvzuvhyFL
         Ss0HpwhzB7LyLXm5ZR2btvADnBxVO56JFkqXvKaM8jk97wcw7+3TiuCSdH1asPId20WM
         5qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792744040; x=1793348840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jadIZSIrpTyEi91i+IYQ4URvG2pbKwAmmA1d2i8PeOI=;
        b=yQTDacmULsLovtjcbtX1SMeoIKh4pz+OCUbFhaCaMXFR1F9yOOMOyCCUqy61d8rzYg
         XaN5h5RCVKlR7gnAhZmYvRdel1F3lEjufeIGi2u+7Cw5jTz1Ln3LP1CEAzfgj0dggZuq
         KY91oGVo17AZyJhosNmZolB3Q7bTpJe0exRg5jZgNQO4CItJlwsqPX6zk2E2Weo9JyKj
         wZ14RrEEP41R+FdTSB6FVAr0bJScptVGsOJOoC89QGHiseQeEnZPIKvkPhGilCFcbGF8
         ckKhR2hsG/tFpE0nkCuqWZJm6An/XjuVoSqMIPij9AzK9u07wcl8u26hJB5gXbvk6Cjz
         2Xug==
X-Forwarded-Encrypted: i=1; AKwUvBy+k29sM/zrKeCTI4112rQK25pA8Ey3hYtWYLeUY8ymeMESRiX4ooTLv1oifP4sJmmWH0AgeCA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmvaX5We1CEPtKMLzW4thephfxFskbP4IUq8L8cg4nunS2CuvW
	BH5lQJtg5OhLhyYo+CgV328Eo3/xfEn7rF+2/YHqkx/rTZebktTRm/g7aimsCdWwz/oGl0eN5D5
	wqi0RFvVBs6Si4S0fS23suzEwnKkfh6JFUYHJJ/p4vkFuPBoq/M6J22OgUkc=
X-Gm-Gg: AYBFou3a+92MlFdqz9U2E+6uut60HNub6GODQN5n3YJ+KkD6CkDTLxKsLcXJbVo+4Ib
	rkx54KAui2cXwnBlcRJrhhqSlore41kBvOJ9FV9RrWHRIVOib1wtRjDFr0kf9lpUireFbfEuTvZ
	4aBcVu7zlkDbLGV5QIuor3z5b9dSTYxNIlQQ9hsX/CPbGy9tnzkuygfvph82NTfKzKSNs4eMOO9
	mHNve5b21kQakUy9IRXPlEx6RUdX6TSyf425Ae7i5bRnOQDQJvbmNA+1fQDrnjfOxDiAhb5J5Y+
	OhXeY0qf/OvoH202rhvHZpNac8774GgsBW5SBC2qIrodQsduJoOiLJkusPApweCi+qXFbADTie2
	bwuVwyY8QW9NZGNN3d9FAZA4jrTKhuUW3JA==
X-Received: by 2002:a17:90b:1c04:b0:3a0:9fe0:3aaf with SMTP id 98e67ed59e1d1-3adce08aa21mr1222229a91.48.1792744039889;
        Fri, 23 Oct 2026 01:27:19 -0700 (PDT)
X-Received: by 2002:a17:90b:1c04:b0:3a0:9fe0:3aaf with SMTP id 98e67ed59e1d1-3adce08aa21mr1222206a91.48.1792744039232;
        Fri, 23 Oct 2026 01:27:19 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb0a27basm2692616a91.6.2026.10.23.01.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:27:18 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: fastrpc.upstream@qti.qualcomm.com
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        ekansh.gupta@oss.qualcomm.com, quic_bkumar@quicinc.com,
        stable@vger.kernel.org
Subject: [PATCH v2 2/6] arm64: dts: qcom: monaco: Remove FastRPC compute CB9 entry
Date: Fri, 23 Oct 2026 13:57:00 +0530
Message-Id: <20261023082704.2859978-3-abhinav.parihar@oss.qualcomm.com>
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
X-Proofpoint-GUID: gh-Rsy0L2uPAxj06sDk8sgfb60LJ1g0S
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb1a69 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=tob_Kch83G3grsM8gxYA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX61q4RTTjKiyP
 E2WTQWxFW9Px7fTnyIEoVhv60i6OnqE+ZXurStJplSOlAvz3rgu0+5AyCYNK0HWPR4X5fGhK59Z
 UC6oei+SiQeUVVrQ7mMF+byC8sARAsE=
X-Proofpoint-ORIG-GUID: gh-Rsy0L2uPAxj06sDk8sgfb60LJ1g0S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfXzlg9ySTynVT5
 iP6NX9WFbgCbydVH0LOQOR+ojnokihhBHsJOVPUiL2hv4B/cGsZf4HCgnEh/zu+RIdgRmaqfUSU
 Z5YWQfiJPDOg0119NTezgRA0ixpnwjD5v2OttcilItwva2Y6DhfhaOvX8Emrzy5Lcmat0ZF7bxl
 7eu0sdiUyBrLEhg5e/YEE6xEGEBv7GoKgeoNhsHjYi3Rr3OsGZusgA3bLAxbt/ZYyCQv0C9khbO
 YH6dZD0sSVK+zo3teYTuiXlkq2/UCKWIDc6QWbAPunds13GclmW4gCbQp4QsVJDzYGtPlDt5aFt
 gw3qQM+RzTAO9T+xqR0Y1IrwGJZCt1JR4CPokP9WLmxaiMwYDfWghMGFAHi2dPxR3aa6yD+5NAt
 WOQQNgybHFc426cBwZH3nOvUIQvr8aOhgfsXJK/UuThk6y18844n7gtBG3RDlctRpMdpJQ8/ckh
 Uh3JiGbzyE2MF2WK5cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230033

Remove the compute-cb@9 nodes from Monaco device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: af0d19ea5a31 ("arm64: dts: monaco: extend fastrpc compute cb")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index cfe39f923224..e73a735f2f13 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -7822,13 +7822,6 @@ compute-cb@8 {
 						dma-coherent;
 					};
 
-					compute-cb@9 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <9>;
-						iommus = <&apps_smmu 0x19c9 0x0400>;
-						dma-coherent;
-					};
-
 					compute-cb@11 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <0xb>;
-- 
2.34.1

