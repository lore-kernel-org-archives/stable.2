Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485274;
	b=aBu6ArU8uUIiWdhIqe38d1PBAeENRC1AXwNMyufO03mrV/lpmwB05Yd2FkP9GNHaMmY4
	 +piiOj3RD+RLnMZYiCweLvETGFEErKaMF+8O/TF06WiDQTdCV9eVh+xlb5xlK4n5vQMey
	 t7thrOVYS/Sg8VAJ5mG+LgjE3nhKRSrSD7ZAoVVkWm4sWujjBFKORlMZDD1udcQylJT0A
	 KicTx10RU5N0Vdui44mme4IfTTroAX/pvUfkiYFwtJyb03Z9qTRhhk66EtExI3PsGzoPq
	 ZcC4gV08xNP5hHkIIR4nOD9rh1mvVISRu6M59fJXxu+5ADBBwAml2Th3MD0PKvxZr6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485274;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vfcUvvZkx9v8w0lzqLbCBLBuOKdNBnroc0QPMFVOYVc=;
	b=bBmoaLSNYQ2UNNPV22MktoXsGP+ZoNo5FFAuXhZj/VHlRBrptf97sD4aS7nUQAysDzCT
	 D4tZgluVfYrw+vSF8Pl77B9QEr0ThWfj34L4d7Q4ehsEkxOOr1sgM2I+X4Yq2LlLAf3Aq
	 Ix0q7FCBthsKfGNvzs5OT+AbU4k5GkTNrNFr/wx8PpbETgLAqKY0lH1IQlmuQs/S6GktI
	 pGU9C5Iw2FHywwZnI4g8TGy8xbAxYmn1kAuqJXOYY3U0km1A5qR3/JAZNttkkrlX3vtP2
	 JoO7RDOD/v8MR156hYskTXYAxmCrD4c/YEBHDbWjg1rRVfMK6Wqndlq5qRczm4qlYwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iblHBCxN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K+yAPB2n;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49202606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49202606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iblHBCxN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K+yAPB2n
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACBSbfL3893521
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vfcUvvZkx9v8w0lzqLbCBLBuOKdNBnroc0Q
	PMFVOYVc=; b=iblHBCxN1q+nX8Q5rEl+KY0CkQSEziVPM2bZed6qkxrOeBvszvy
	LG1CBO3zE+hhU2S4PEP03iGIoGzUT0UO1mXTUoSyFynBLhwEKrkZhIhZ43HqfzXW
	Qez030EgIwwW2FOZ6PZg36CGJIsZmzPdIW6pmadO9aOvld/pE7ymQ9D5OGsNKEF+
	PZ1xxSRVKByTYDNwzCHH5UvQLHBiba6obAKK/1QzFDXuahQFfKWoK+n6J7QLG9u4
	9PJ8zkhs06piHeHTdhpPMu3BL0PgB4G5FCYKpEfYiXtgbKqyZlrSYAkRWb8HDYhC
	WJVsIgU2BG64TbljHpqkwogiLcNvNfMDVnw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6re1g6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:07:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36d1353fdcdso2522942eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794485273; x=1795090073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vfcUvvZkx9v8w0lzqLbCBLBuOKdNBnroc0QPMFVOYVc=;
        b=K+yAPB2nraFuKPhqLgjv3xBt2GUl+1jdtSgzP/WSyk5wv1Z8Nx59eSxl/EtH4uEwir
         DctOfAQOeNgZDegrPswQgJYtXdS9qm8doDojE547q7/f/lq67HKSkjFgN9+HpbL7Qn5W
         WUAWx1Vxqr4XyGTPGL7SWUqMyqn/J7UXMmK87OtTBFbFjlMA9ybI3wrHFlv60xXBL/+N
         ZtdltPtgPayFFpikw27PQVrH6AD+c9bWt2+QDCzcgAnRWo3d+rO3QwsIzw9YioqHOCGa
         YS+lCGpzj+4/2m26uyYgXDBL3RIXujuJERwtUMYrc/2MtsFfRWDmJEC/1gThdBcdwA9a
         EU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794485273; x=1795090073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vfcUvvZkx9v8w0lzqLbCBLBuOKdNBnroc0QPMFVOYVc=;
        b=RMPKYysYotz+Jl2fn/WmYchcOUkAQ5zriADznMKeQwG8NpilvoZ0WXnYbp163bimqJ
         kZ6dmdNqHO5djcsoVqGDZPf9gJE2CwsPZIrRAIIutOxm85hNZyugr/zHPYorjNEZ/NSq
         np2taKG+nQstwxVRG6hCLlBGxpWEQjkHhQdJRi+zjrBPK3Bkbg1FxHWsRiGL0LLsYMW0
         ORMbb0HxzTnVRGsNuRtE8XbA8MO/WKmW+9gYdZtYQfNj57CjLP10F/Q8O63NtxbREtbN
         jqiEymnYyZiUzNK0TH4vsXDig3zOFnZCIaimRJuPe43jSr4LdKVvjCP+fKuanYwEne6V
         binQ==
X-Forwarded-Encrypted: i=1; AL+hErFkoRdIofr1ZB7o1frZ2W0JFBxAUJlDWM9TflEeC6wWS7bKxSov5m7e04882K3xIM4ZJQfRtdg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NXmb04+xR4mSzuGkKxuDnnIEkrpfy6OioBywETQxS5pbrPwlN
	28m35FPYRktlGva6r4l4Zy7B8guRtMKVujEilgb2GLwzBJg98LTDuUGQFDnPnYF+jyUCD7G9hSv
	q2n46B5X9zHdX7B4Y+GvNtfB9WrBmVe1GaBJQMzeKKUHF7bXNVzRnK/WgstI=
X-Gm-Gg: AYBFou1stl0S7bBPoQ80o5Jn0A/BJXU4h0yoKcJ73SOljlt9MYNFwI+c3rmr7qFWpSX
	jHZzzcFp7gZ5/mKaxnTPzrXB0+MvGKVLZeWIgGo8OO1zEd0gBUNoS6i4WqISOuvN6OX9RMoWOq3
	pRsgfy2MzB1YiUl+D3fnL1gNX+WJMAkRRt0SUGwhnRKRiEfUPsPA/ZEf/fArNHfr3BYYxJsHRiq
	9BraSjECWCo4BCi/N0id/BW2ZSTGeq57OQfPyYbjneqJklDnV8rORKoaPJPyC1v5c4/vjpVH5Nb
	ZiO1iA+ouAaJa4+C7rJzJSnmq5uLxJyE0vHazW5qXv7Vuhm4UfI+/MEyd0RnuqD9+EN6Yq0PlzT
	83qkdo9k5C/C2ERxd6WSwPL8Spi1LRnwsn3vpEvgD+yrpjFh4vfYFTVvg2jx4mw==
X-Received: by 2002:a05:620a:6cc1:b0:93f:ca9:3ee7 with SMTP id af79cd13be357-947b0003c1dmr923369485a.57.1794484837709;
        Thu, 12 Nov 2026 04:00:37 -0800 (PST)
X-Received: by 2002:a05:620a:6cc1:b0:93f:ca9:3ee7 with SMTP id af79cd13be357-947b0003c1dmr923358185a.57.1794484836804;
        Thu, 12 Nov 2026 04:00:36 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm16682052f8f.10.2026.11.12.04.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:00:35 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Dang Huynh <danct12@riseup.net>,
        =?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: qcom: msm8937: Fix CPU4 thermal trip point type
Date: Thu, 12 Nov 2026 13:00:31 +0100
Message-ID: <20261112120030.99510-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=cWi/sRCq4/psEC0lzvEToo4ZOL2Ky8kWa/kBXNHZ8aA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq9apeCZUMPp9KYItNyPqEg4img3WYZELzqxUP4
 mos81WLoI2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavWqXgAKCRDBN2bmhouD
 10FsD/91XeAAZdi+maVqqS1kOkQpZLVYrCPv1cUXxg1W6knma0UjDS6y3iZlAl5qWuoCH2LzHFK
 IimlGhq8qw8RuPJHZhuRR6N+qo4oHn9zN3TcxvS6JqSkVgQDguXW0PGsSsm2YYaChNdX0UZQMBG
 S9RiOoaxFuauq2Rzy7F8EPw0ANrLOGZvnOyQPdB0c0mmU3D7XvR3tvJLFljRL0PXXHTfeZt6hxL
 AwDJsVQR59rbSVpZTGynJNLOzCn6xIFVJ0sQwF1yr4KEBOqrYlnGas9mzrJazkCuhq4F09mUFfp
 uaSOEQSBZU1y4iy6NtCGdjV0W1tozo2fTz2RjGfsJicd5BNAaERT8LgKlp3giAUfZqKXe9xDj1Z
 hb0sOLBKBKCX7Es+nfqGPtmJBSv+sWaIyAKhLQd0dDJlOtHr0Km3p4SAirk9aSQD5bZkfF9h9Hl
 vOPCM70ZmwfAlNXQ+I4j7WzQtMBokLvgzMLS0c0zAXSdoTEIjE4Ctq5/Mhv/Dt1hAGwIt0MFk+g
 mzYBHLgop1WBVOu6sAyB10MGZ9jFXAeohuGRhtjRWQWl4GG+ujVH4ax0LnU700tlukV6tu4RqlZ
 9U4kDgqiHj/XB92/0bZgrB9KH2xKCLfscR+nOzPLJMMSoKbi+zFGe2J90tVWnkHNUfQS1v3nHgB nOO/frJtkHF2kNw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: px9kvGDoq1xP72AuNDn0N7g8fyhQjlZc
X-Proofpoint-GUID: px9kvGDoq1xP72AuNDn0N7g8fyhQjlZc
X-Authority-Analysis: v=2.4 cv=NJhAaE6g c=1 sm=1 tr=0 ts=6af5ac19 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uPNVP4c7M2W6CD1-7SQA:9
 a=scEy_gLbYbu1JhEsrz4S:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfXxCgPvBCARHi4
 R7gM9QDMLphZX3vngX+LL6cqmgVvkpVLBH8w5a7x7KJnqSNTvRdnUfBieGbqSsz9MByLT4GlKiK
 0LKE0zRXan9Q6toaNx1Smf9oTcTo7R8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX3nAKsnBxRNZ8
 FKd6rKWB5ot8jRH03/cR8qI5JNQBrJGgsWWqfGol5aNqj0NgzauqAGiQcaoudS2cVdZYX+OvY/l
 n3evGkGTgj3oVXECnWBOfEXBOgic7b+NbH6c4u9Pu6aG3OkjWUixq6p5uGGyrCxcfuhi4T3pLrp
 DyfzVdIggs3lU1Ce8aM9vKAkIW9JsppGWEx5u2Ro3+79IQLOG2FPmDg97DxX10os3LFOkPkmhoR
 N+kYubKAjuMDV46/JwprEqMU/vrmXdEgsWiE8A0fL6inW/GKsAOlLXsxpyLQLNMrMZl1d026+au
 CkbGF2Vn1nhenYHY0DYoVMvxbMAf9eXjsq2EUZ49MSic3HW//SB+O9sOk67J7aFCt+RMtCsENOS
 IWewQ+x9GcUWPzLilzBYdSbWq6ntY287a7PjxX/fJ3TFSOGXdzCuRPo7H1FNjjJ2+1LvTVrcdsj
 8a6g7tF4jKurnpNFpPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120048

CPU4 thermal zone, unlike the rest CPU5-7, has reversed types for
75 and 85 *C trips: the "passive", not "hot" should be used for alert
triggering cooling device.  Wrong types could cause missing thermal
throttling of CPU4.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-3ae74c01-648b-445f-9a65-114b2d3b2ac6
Fixes: a829f6f2e8a7 ("arm64: dts: qcom: Add initial support for MSM8937")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/msm8937.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8937.dtsi b/arch/arm64/boot/dts/qcom/msm8937.dtsi
index 7de6447de48f..6729b39c3f2e 100644
--- a/arch/arm64/boot/dts/qcom/msm8937.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8937.dtsi
@@ -1942,13 +1942,13 @@ trips {
 				cpu4_alert0: trip-point0 {
 					temperature = <75000>;
 					hysteresis = <2000>;
-					type = "passive";
+					type = "hot";
 				};
 
 				cpu4_alert1: trip-point1 {
 					temperature = <85000>;
 					hysteresis = <2000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				cpu4_crit: cpu-crit {
-- 
2.53.0

