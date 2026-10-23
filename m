Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746214;
	b=c/x2lIm2fxhPyR66A554CiVgbc4MlqO1nNawJjLItK/Z+yaqBXKZ5Tbre7i0atopOgG2
	 UgRxssw6KqntzfURonxWFPZWQLBEijFWYPsctXca/plbcvnaCWLaQDRxQ52jGPh4b9uJa
	 I0folIyl/5c7hKlqA7tfVvN62YEyEUO3TXoZC1Se+5JqXnHbYwD0wSKnTn3uDCIulR9hL
	 G3hqwhi5xKLjYi2olmai4QL3lPPxmUF9u9ReX5qffeknrdTbDrGvL5DsqUHzoh74F1a/R
	 zbdlZX+6PTcJv49L3aJU/qFsM0Z1YqgJygyuf0R7WY7OPB4s/IZuxB2YjiKaqXCWxGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746214;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zizJUYpF90Icu7Caq4ljSkAipD1RKR/iCocUSeqdLk0=;
	b=LNyVP1ym+vs/bVIwTsYR0qM+3Kv0M/zpeJadONZYaEKQWwdzmjSa77E//NbMhoxKd3pG
	 5dkP/A0UHSb+5wrak6YFcXTnh1atzLY6lFfR87L3lz1okpG6vBiLPWrJljb7yZj1DwSXU
	 Lr+K9VR+SXfeTfSLqS3sr12W3UdpT961kYYstfTl4hLk1E0uCRACMzl2Y1gin6u9KImzU
	 tf+r+JKKp3ROXz2E4UwuV9wqB5iLRBIDa07QVDTROGa8DWqSwypgJQv2R3pBWw7mq+EsN
	 fPZa6mtl2UDkSWVZgqPdC7wAXaQKwqTpaK+QyOnEQ3vHhnTfCVrx5JoPN0QPvdKbytQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="hJ/LqxFH";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=km6f9JYe;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5E360A2602
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA5E360A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hJ/LqxFH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=km6f9JYe
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F5Rf1200734
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zizJUYpF90I
	cu7Caq4ljSkAipD1RKR/iCocUSeqdLk0=; b=hJ/LqxFHflNTHadd//qNX5plcNF
	qo+hG3Jl0Hv2usG9aarPvOGXDkQS7QbJjC29isFGxQTMGuDurPIOM2X0zyil74fq
	G82o6puo5002gvp7InM5G9aKCVpou5uL4CVJtOmzQfjIOqzoik8nLlcWvpewIHkc
	bMw6wQJBLOy/glPuKuvO08FIUytOQc4LMwzHBrHdpEuSola/UZyWNVUjejm17hjS
	zx3kwHB11uU6qV60qM7pd5vhHI+yPx9gBidMnn5xVHJcTy4xjXwEyMfFs2+Re+aX
	CTahl/YpUyxOSQg+se2V+hLKTuQaDNG137LZHJxWf7kFU6qc74rpQl+zyXA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms2ubh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:03:33 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd652c0385bso382364a12.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792746212; x=1793351012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zizJUYpF90Icu7Caq4ljSkAipD1RKR/iCocUSeqdLk0=;
        b=km6f9JYeKqUfE1bcKSAFQIquIjtXfqbs+/JUeq00uvY1peM26NCXF+5jbX0ibUc9uN
         eZCxcn6jhBrLQQZPyxR+4cxPfZbC9ChSjdBBWJEH1obcRD163RVgees3DtQbZWP4PbYP
         X4ONsPFoHlqDeDuUttWqzSx+bMMTSxOU3vj5RaBiIQNsqLO8NtMA5irb7NhAnvfW27j9
         p/SLxwQsGRotprr+lN8LvYDfT5kbc2eEj/hMG44W9ponHYgmvoVxsqp1ycx9086KxSRm
         vFSJbp6eMmNYhbxbL1FdeBJFZHESaS1zxRzjED+9fnR6gH72BvgYSssVkGS7amrITY/a
         +xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746212; x=1793351012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zizJUYpF90Icu7Caq4ljSkAipD1RKR/iCocUSeqdLk0=;
        b=J/I6SWijYYVkqLgK7t2lij2mkU2og5C17g3xc0VJV0cyuoafLzYtiZWHhmkkZ/SG2Q
         8p55Q9hLPQqn+36jpI7mv+HMJBuwkhWHcSMA4grNbbAz7uPTFCMY77d25excqKb1DYks
         atBtMyLjuACf/BTdjEQg1K19M6MG1zk/txGV44yVnsHNsZdjszXEQXxmvF3mlTzK+sFC
         stv/DKy7BUfXPjRgi6q1KX4ui2SgyoYQIwjpiNIBCJ+0gD5l6sb2xtgCwl8qH8H3Rjca
         Z/PVEmXKxyFrn154fRFgwt6l6F5pnxAm278vLUoFsGotmBagGYFTGE1TWPntgQr4vdS+
         G6iw==
X-Forwarded-Encrypted: i=1; AKwUvBxa9koMxUGOXqt79hb5j+zcbNbhoiFmpXJJWvzzmogM+m2mbIQ3wzXHYZrHh70zS+rqDx0oxlA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7fuc9fs0a058UNDyaXZKxo9vdxs22KBRCnSRzM9hFPaMrtQFw
	YA+euYSEuTiY1T0bM1LndD1XdefVrzqRlER64fRWjN1lyBwM0pqaeTeKTfCl883c+6zkNHHYlbW
	k0GX8eLlfSJiesQjCW7V/BwUo4Kn1juJtvp6Wug+zIc0aIQBLOhuGtyYB2Fo=
X-Gm-Gg: AYBFou3jdOj4AExX7LFfq6U66/ns6Am8sJD+Rg8kjuuPZ3mf8mDZiJjF9Owhjo4LCep
	/3+VJwCHvgfB3Hf2zhc786cggPkjHRamYXvu0QukYdyqqx+o0/wfcllv+dSF5M93zsUXAR+S1DP
	QXTZRe2hIDfOD0N2Y1wSu+joTbYlxTuWqBfYEAWnIEzwHkDjbqi4bjl548BOHu+o0DdV6/k4ku+
	cVeq7QyW7wgCuV0Mx5wqX36h3YPiFqoKbaooW1jLGL6E33O2NfE9AcLIu3EzBg8DBuuo3bnY8rh
	4pkRFiwmj+/psHP15eIqwXIvTMieas6MBEamGSz6JYOx0H0+5lOs5ZJKLd5tSUM/s0cWgPJ8BEi
	Ls40cErRMpBPZlYMqzeHlDq/n6lzj0foGsw==
X-Received: by 2002:a05:6300:618d:b0:3e2:91f1:3878 with SMTP id adf61e73a8af0-3e359a416efmr1359343637.10.1792746212351;
        Fri, 23 Oct 2026 02:03:32 -0700 (PDT)
X-Received: by 2002:a05:6300:618d:b0:3e2:91f1:3878 with SMTP id adf61e73a8af0-3e359a416efmr1359311637.10.1792746211896;
        Fri, 23 Oct 2026 02:03:31 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba69ca4dsm586273a12.0.2026.10.23.02.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:03:31 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@vger.kernel.org
Subject: [PATCH v2 3/6] arm64: dts: qcom: sc8280xp: Remove FastRPC compute CB9 entry
Date: Fri, 23 Oct 2026 14:33:05 +0530
Message-Id: <20261023090308.2898683-4-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX0Egw/NvzMAJG
 P5fNWmVjhhRXHeOTtZlfhVihVDmBcLnhiKhgXfqFnE432bSU0ycH6IUHzipxnzYGMZfQC+RSNUj
 12f/7Itm4b7dpb9bGbV4VDFZHa3hsrf6F0bIQlkjGDBv2Gf+a7JhFPn6nrkE4FrY8M8x5MCoVwf
 CbiTMAWue3/vRWYlmQZiUeyXhE5fEvO611Y8rMTCvMpXyoyzIUT9ujFBu48xQKXLee8qB7ir9Wh
 v6O2AyYz3MMFhtVFLWYgrdCEXsArcB0dd4jHAu1pQ02Qr0CUoJPnLPZpgNMGCPmTIykuF7LBdhJ
 GGaXpO1yrTSJKhdBNRxPjgNrXt+ZZZecgIBhCU9cB2BIUpOGp/3u+tLLZv9FZuIPKEX6lbxl/LN
 5totVZKtEK6xSLaJoKJrEZy83d+7S/TxIKt+rupfAPMQIOEiY0kKlhPyBd0cVsLZ/bVo15X+/VJ
 utv9bPYPENtsdYp/08w==
X-Proofpoint-GUID: GrR2R8_D9MfLkD09Z5xwiUOibS537AJP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX1wC48U+AhwNG
 2ehtjXWDFgHJUDLli1izeo/ZAxs6TYqoMerciXJTtHqCQxO66psrHW0hlUyJkd1afkQhYDJJWEJ
 AaER3d7ITs7bPrW7p/IEAQgMMqYok9U=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb22e5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PKVKsYk1ooiKBYXMgQMA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: GrR2R8_D9MfLkD09Z5xwiUOibS537AJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230035

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

