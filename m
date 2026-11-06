Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950351;
	b=bg7lc/6a6/9OxRCV/l8wM6SSF9YFhYSFPtcZFtoFKn03teGyQ/6Dl4brPU43N5dyEPIA
	 1viFAoTcZbuodEFj03CTMZO9Wf1d89d+NYTNVO045Eatvp1KsarXoGS7WxM86GmJKTXDf
	 nIef/ad6IoiGkBVVZMIybrK4cXtEXy3uJJDlqFfwG9nQSiBqjKPFbuJga7WkA7HNeRxeG
	 7duF/QFyYZmK339mTTsFHXTGwAzDIdoaXBpqz9WlL7o2k1P7a+t72RJk9Tuc1cN8BRbkJ
	 hRb8IvORTKhsq+T79cg9wymQvxIiWI6f73ADV7lmMdR2H7Spi8qIXR3wrOaj6Licdfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950351;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8OWq4nrNh9pGQOaeGEaLvyJtUrGq9ldLwsWQSLax044=;
	b=JgVmI2AwrCHds9hIlke0e+qdvXvI6gzsLyI5CZb6HPF649lRLWWCNqvfD2k/I+OKl40H
	 VcUE1BA+19wI/G0ou1NAhriUIlGrgrB2O3t6vZ0J8zcNyWMGkceeJZ+yRUIxfgDZRd+rD
	 EA3/cZasWxNmg9xiHzaKIVuulFSs1hW/HSzGgZkHgolwJgeLp0MTy27/xc3RKShn78liP
	 Zs060EJxk9hrIcGec29mV3pPEN3+cwjmLPy94uNW85n7E/1n4HmVyfv7q2NxQdhhsvayr
	 OAfLQ8TDSORor5xGe7ItEYdqn8B3Eua4cODl8z+iGgg6VHg9nHWx/FfAWyrY68NtxJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p7rgPCqY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ih9++FCZ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E1E606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 07:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64E1E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p7rgPCqY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ih9++FCZ
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67R6aM3243860
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 07:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8OWq4nrNh9pGQOaeGEaLvyJtUrGq9ldLwsW
	QSLax044=; b=p7rgPCqYB+odh+avUO4albsGPZy6z/7BfbD6Kteey/ab9VcrANm
	5+CRN75zF5/ejoRfGvjAjmXTieKue1+9B6y55QJmgFOMnUzEQ8pyEU6Qv1auAjCJ
	KiZxI0/gwrHEMwyuOj9vtpXXxdqKeB65C6ApdtFssJbEPvw0bnVnQ4uxScj7/zVh
	r4fVa2M2uplH5IPaTeUz9MB/wtPmPiH8dwNdx+w7DTRVknfy6cUwFOpmD8fJg4DM
	h8It700mwRdQVB8Pnym8XjfDleYNsYQcJsUjh3jBawqDbNq0PI/Qp2gMjqwBDsGP
	QQMpgXk7RtRnBFLO7WqyMD9w29HHBf3ZjGQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa1kh4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 07:32:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f32050e72so119384385a.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 23:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793950349; x=1794555149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OWq4nrNh9pGQOaeGEaLvyJtUrGq9ldLwsWQSLax044=;
        b=ih9++FCZxaFaxuxWsDX7zmGOzP0FZl5enoQiiSjgpXI8Z2JaET8rc1Dalx0Qf627m2
         GNJl2kOJBz60lrKhzOxpEA1Z5kRvxPWOe1ozWE2EbB8rUq9gGasDEDa1Yva/VAPlQk8c
         5Btl320Oh4sMTInOqQuD950ciit9Ikd1G2q3XOpWC5M+tpFl+JGLzKTh19/ZVwfK+l2k
         ZAuXVSRm/dKO4IkdzWWrpnuBSOn/FJtOQn7AEJ+eST56S5MKkCxO3uTJelagJ4Vp3ZgJ
         y/SyGHbwHj1kV0YBSZb53VhUDqrGoyXwu6KHLUB3YLhx+oAk2/6TYdgOEY4imsjFxcC5
         EPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793950349; x=1794555149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OWq4nrNh9pGQOaeGEaLvyJtUrGq9ldLwsWQSLax044=;
        b=qMRAuKDz13RPC+ldGkqt9bmhndSxv37k47Vq46XTH2c7UGlhhRTWiZkduyVUhBBI3G
         x6QUYUV53bRQXUAGKFqSPUQYZW3MSmppTnAWmPiBfic1CU14I6aLJXua/BkYA1Z6EeHs
         EGqakuGSk8uraZITKa7L68ONMzKrfjsXqHE7mkQH4Bl+T3TA2FLkJit3OCu/OqGuuaO6
         AWcWlpbMYbmjdEOq0lR0AF1/+lsJ03nISkw0oUgXXCoKkHqTmcj83q2zOrwFzv7XLLLP
         7eeoLogL4MXcZ5/dIjeA59Nl7ZznfOESBwFsftHaBhThvQDulIlyzZT6X+1N1DbIPPOU
         VyUA==
X-Forwarded-Encrypted: i=1; AKwUvBzz0lSA4nVYZdCO7Jz+0jdqv6VnAIN7t4oVSgpEp4vcrxIbdlNmoqarFXzCV06Xqmg3BUC/US8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vAdwJ+GFBm2eucJn+wFr3ucLM5mIylBd7COKW4603+FYdD5vs
	zMzcX+vYXgHOdOBFKuYKlxHN80zftnR09mBz25USsVQxW/51N64dbL3okYa+DbQsY+OlpOQwAXT
	nZgXq5IoPms8ORuZKJgq6TG3FPGA97xbCJkLULWOCQ4sqW+CDlwJEkLEcAxQ=
X-Gm-Gg: AYBFou1EidfsjrwG9n3yoKK09w3O/50/npSMPZpR6lXa7iUR2Fgmqty0PmWGtV6TRnq
	hksVRtdP8wqSpWFiPntitSSfc4sGbhAxx7Jg927PVVLlNfCyqdgj3QDW6Uz+Fq7OfOGM5cazrhu
	XVD6PRw32cDZxVPNwIXfokQlaNM0hSQ23SBb8op3ES706khHhIDHak0Fj8534mYwvbXSjT+tKi+
	hPzE04WzpP/0M+6I0vZr4dqSPg31zEnIs+9/cQ0eB0SFWv/K8/aPUtTRTWul4AKBnBV4UFfVRtG
	u2mwRQjWkjrAmjdkq29eYUEL2M7hMc4Aa042psJd1HQ+q28e9yNoekArKflXBQLYpx74i5HrcWN
	i1tGP6vFOjxm58dzWLxsv4CAOGBNlpazTwl9FUtB12ZrW75dqYyuvMPUSEcmsRQ==
X-Received: by 2002:a05:620a:63c7:b0:93b:ef24:bc8c with SMTP id af79cd13be357-945f3556183mr233350785a.47.1793950348506;
        Thu, 05 Nov 2026 23:32:28 -0800 (PST)
X-Received: by 2002:a05:620a:63c7:b0:93b:ef24:bc8c with SMTP id af79cd13be357-945f3556183mr233347985a.47.1793950347960;
        Thu, 05 Nov 2026 23:32:27 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b73b97d62bsm17070775e9.0.2026.11.05.23.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 23:32:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mithil Bavishi <bavishimithil@gmail.com>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] ARM: dts: ti: omap: espresso-common: Fix magnetometer interrupts
Date: Fri,  6 Nov 2026 08:32:20 +0100
Message-ID: <20261106073219.59785-2-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=8RJTDipAJ01nFwlCTlBHgfjxxf2dxBYM6NOhCug9thE=;
 b=owEBbAKT/ZANAwAKAcE3ZuaGi4PXAcsmYgBq7YKEd7E3fFMNJDfyGX/aXcMtTxYLfHhdXD1Y0
 y1/6eXdqt+JAjIEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCau2ChAAKCRDBN2bmhouD
 18EOD/iu3p6fbMbT7YESIgQYYP3hQKINbqqvypfRaCCJqgJnC3WVinnFkZhCyks950A/hL/Yl4v
 tKNRfOBpKstUXzbhditzVtRNh6pdVtJCwqIpDgUly8DT5rnO5NkadxA412P/bf7E1USIHZddBHQ
 cUXeyFy8Mf+aucVD0h0p6kuENk1lq84r7MbcFHUDsXgTDiYYRuYpTruO8yjhp14KrRs3dhuzwiV
 EWBslFSG5quj8dF9fFmHF4PlcPe6llcW3Q8/IasqbV+8Dy6BNFO3gh+f+ReFPfKaMnRHXWtSRH5
 6ffD/WtTuwJ7ifXP2NEMeJotyZ7mrL9Da6PEssKENC6AP7PXqKUbU+ySnvEVVikNrAKGhaQKm+J
 1eH8ifvsTqtKaUNK9+kHd2PzDBnOSg/0lEv0gwrbhq8L7xfy8kdDuAh3MhTcVQZeJucbTfFLsvI
 1NyA4zq9FrbO+/Rx8ibjpm9jG5IL0Qj04Eah8VOsTfBaxNqL9N4PKs3/BiHeotJy7n+DkT/EpGp
 U558FKOL+nKyL7osnzMcgdqrqRKCtY5K8d6LHkjCB0T+1cQoX6FeSsxflAN3r1arHhuf9cMVN1v
 +8jD8EPIMP6sXordQOhN1zNiIgoGnJOe5eF/m75qidqN2PfnUdJ6SgHckC2KtGW8+0USYujIukO bwIzSNGNhnZ5y
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aed828d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lsuncF9k1chNw8iTKPUA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyOSBTYWx0ZWRfX9jIlk4M3WPye
 1k66CDTL/069PLB4dLrzcrzV39WWYsoGBV+4pywyEoIMSmnj80EX9FJks5ex97sWN249AIvI1r/
 RqMdgvUcW/6UzPWgDfK1G8NB7V22zU0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyOSBTYWx0ZWRfX2WQOeOfmpRfp
 kywjqEgG6x1j6qZTPeswMYsygn5NHtyjUm5kppFFS6I94hGDYfcl+mxxj1nLPdwbELvVeevU75M
 +qRvuFrEuYWUBveCpdFBwEPiyQtHfWjkfbT5pcaodjbjhfmZZoTAKylNQuBjTY8K6TIFEBauaeZ
 hxvHDjy5ikICN+Z8tKIUysHNJPvUgqnNA5wboe2+rndewGtuvc34sxGaQF6YVqIC+MH27+jVhmq
 Nr/SHPrrpgl2pYyFfo0zpveXNfBeWUsvzZ8D1nmKhKliGPZsZ0JaPttju4LVXXNXH58N/u4Kn34
 s9oaqDapdTNDguQuaBHZvhUArfu2pS9mufN91gaA4LNavZQk1Yy5b7cNYobflwbBPPmdxPBUBdG
 YqnUTm7V3DmxumfczHEoZDX1nZvanZBnVpCOEWCLQV2eVHXnG1+WLHRlZliXnVO9392hkgmuKHs
 U9Tzj7/rEybMi3ho2bg==
X-Proofpoint-GUID: SA3EBQ7-S8c_p9yMI3KmBRKU_CRt_3CF
X-Proofpoint-ORIG-GUID: SA3EBQ7-S8c_p9yMI3KmBRKU_CRt_3CF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060029

Interrupts property takes a number, not a phandle.  Passing the gpio
controller phandle made most likely the interrupt as broken, which could
affect magnetometer driver operation.

Cc: <stable@vger.kernel.org>
Fixes: f768d54723d1 ("ARM: dts: ti: omap: espresso-common: Add common device tree for Samsung Galaxy Tab 2 series")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
index 07c76a80cfff..881580eebf4b 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
@@ -632,7 +632,8 @@ magnetometer@2e {
 		vdd-supply = <&ldo4>;
 		iovdd-supply = <&ldo5>;
 		reset-gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;
-		interrupts = <&gpio6 10 IRQ_TYPE_EDGE_RISING>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <10 IRQ_TYPE_EDGE_RISING>;
 	};
 
 	light-sensor@44 {
-- 
2.53.0

