Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986651;
	b=esHGq6KgsahMhojM3CIVBkl8AiK6R1GXHRoI03nrJBL+6tibJ9oIGiW0eLqGJF3fj02f
	 WOjbDJlW1uDD5jPrFSXt8wk5aoj6Ee0YiWt8CZTiwJgUcJ67bCiv4VSlPGpc5Nvbr3Tfz
	 ++EKlkxwOkwTwXrYLxfYqu0YGVt9+4Cp8mqd3H7ClXhRMT8msq9eMgPdIC9ssa+9jG77h
	 Cx/F03d2YptYKQrM2MM2uV0U+fjuYu5cLmNIkAiseIhZdvSvor8JUMgoGYBAeo254rNu4
	 isvQmvHuCMsYnHx+8FmQKJsOGiA7W2kvC6yRZ/RnkCl1CwWjsoRpfE3+IQWmzSm+pxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986651;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vfcUvvZkx9v8w0lzqLbCBLBuOKdNBnroc0QPMFVOYVc=;
	b=KSy3euCIWyjvPHVGGgcI+gmoDr1t3uuIP7wz4xM0CPgLoUMmESVDj6Y917//YZWluXQG
	 cnG/YCuD2p3IEdyG3Udfyo5SVYtSMLCdZwXUOzSzJT5g5G3odzHS+WcD+3zvy5IxLvqTz
	 dj4IZkNA6Vpw2vmLNJioagwBdROTSQXi4EztwOXloFIBsiUk7yKegzoth1dV6eX98Oax6
	 lNoFFemR+A2YWD1QL14OZ16Yh4Y+d6ghiBfiYD2jyocQ9zR168NUN76YzHwIB+eMByeRr
	 8gBxnt8tlRd237J/YQ+U49VM21/UpAL20ERtbulFXuZ9qcCS9O/LpAk7z4KMlVvJsTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fo0N9uhF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fstgmRUI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F7606A334
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 298F7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fo0N9uhF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fstgmRUI
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6ExnLb3324685
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 17:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vfcUvvZkx9v8w0lzqLbCBLBuOKdNBnroc0Q
	PMFVOYVc=; b=Fo0N9uhFYfLY6usSQURyUGdNlg7cDLWV+qqLg/8kQMViadKA/ED
	rReBf2trqAb4kGxF0976H/t/Xl/sT9MtaiU36y504gbdtmJOPCS0ZnVOyKemSm4z
	c39fZ59DRp1rXFXduwvUrsnF31oVDIAmC8QH3lswOhTGGJE3ECEj12PgN6nTYWCC
	h5On/4v961yZtJ3Xjp5b0D8hvCn637velKIbfujeCny8Vc5cEv/YP88wqOcb0m83
	06epewpsvbBPY5k4V42cXM4DDxhxoglL9FPfUFxHo/qw0W1CwAxbzP6+PzBDp5gc
	Jj/dXrCzO3SWCzleiPH2Nf8iBbqSlKsRajQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9byyt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 17:37:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2005ce21so171022285a.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793986648; x=1794591448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vfcUvvZkx9v8w0lzqLbCBLBuOKdNBnroc0QPMFVOYVc=;
        b=fstgmRUIAd+AEsyHKFv8vqkbX57OCzJ+RQdTRcFVT5zPB8RFr0wa9217dSVe44Jxwr
         NCLn77ecZRFZ9DLVRqgbJ3h1Fa+6R/AWmY2JzalmWC6d/WMcDHNRZ0qPA+i7hDiXDwSR
         9lsgs+MNRMuDIOsvCLJTvtvFOAFcqodg03o2I2eXxLEDYrHIsWn/wNMfhusR0LmuuO/I
         ua6Fqy0zz8tumMy2wSmQGO9JypZCXcQGqsym5lFoB3DyvR58tp808SmGF4AzgQMLFubb
         J/B2NQMQWuGuPjVMYp2YFBb0cZQNW+c4VLwbG10/9eDtE/rA45/QWBzaNJpIe0fStAgn
         ZBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986648; x=1794591448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vfcUvvZkx9v8w0lzqLbCBLBuOKdNBnroc0QPMFVOYVc=;
        b=JCiHj4xwyuQFT9EG4vAJDd+v3EEqOanzT/hZciMaVWSwHqDX1B4AezAIrggPIcO4h6
         6aZ0p5v+dHdb5JKKaktVjNGPGVUuSkFznlTYfPNxKdPJHtRyJiRkI9gBaTc/WAEqS82g
         77yf/g5Gu2Mtp3wK+t3h1B4v1WK/iJT6k4dJz53RdSjUY207Mq/MuMBWSAFcLkaWNi95
         gsnYw2YpQ5LBp+GWo13EmnS9x0BoRUa+lPDK+0/RMrGDBc2swLiEa68xz1jaN0qcOHcV
         PRRN7xckJBAVjVpQ5FPB1j2bfho/3QWtl9jDCucWynCWWsj0oTqWv7Ck/RrdwgyBbDGr
         1UiA==
X-Forwarded-Encrypted: i=1; AKwUvByXxyEqvp+k/tawgDFDTu5cZQQoa2DA1za6QVYl1e0VnWCcoLvCIv7EA2VBn4N6zpJYGkoOJ7g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8URLT4JUcvWJ37joJpmzWftGtGjMnr6jQc2rCkw9ibe/f0dBCb
	EdZfTXBdh5h9lGMpFBLQ7HLa0x1gKlo+xmDGpps+pvO4gRHgFeWUZ780iTrbZCgzv2DzRK4iqey
	6hraCHwwCHKyHrUos4qN+TYAby0GssArKUrMJiHiap5zByV6c6hkgBNJIkCQ=
X-Gm-Gg: AYBFou2WuZFlVlIa9JQdkm59Lgdtt/n1GgZCTZTkyrDt99zXpIQum4aIAtF3txnp8bT
	N0CQm5wz9FyEBllRKXV2/BuOGcPp0gtIlpdT7maSekvKYVA/iBdH+WSzuZY1FYhoapGq/3vM865
	iAiP1V+kyneTMIViIO/m95zESKrquhSkAdRsuACfULZjN563J1ZaP8tfAtzpmuVBK3+cQRIUBI/
	IFNpcZ9IHfwkc/bSn1MQ4qwZbnIpAZFcV2w5GOYd5oCwwUqwSgQQ+sUmDYyP1/8eUr4zCttKsuL
	RjXISfmc3RLV+zaHm9ekYw00/vpQQTFpxDgo9uWXO7LJ3eGjEYbGHs9oCVP6KbA1bFEurfVMUIS
	iCXBv65HcOVZaiJH2W4bsLPSZNkGFDLQPDstLmdIH+7SIkwqMZBLPMYPwtQ8BIQ==
X-Received: by 2002:a05:620a:3194:b0:92e:bc28:5479 with SMTP id af79cd13be357-945f32a3da3mr493258285a.2.1793986648273;
        Fri, 06 Nov 2026 09:37:28 -0800 (PST)
X-Received: by 2002:a05:620a:3194:b0:92e:bc28:5479 with SMTP id af79cd13be357-945f32a3da3mr493253885a.2.1793986647771;
        Fri, 06 Nov 2026 09:37:27 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6af5f0c63sm84256135e9.6.2026.11.06.09.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:37:26 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
        Dang Huynh <danct12@riseup.net>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: msm8937: Fix CPU4 thermal trip point type
Date: Fri,  6 Nov 2026 18:37:20 +0100
Message-ID: <20261106173719.276668-3-krzysztof.kozlowski@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq7hBQCZUMPp9KYItNyPqEg4img3WYZELzqxUP4
 mos81WLoI2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCau4QUAAKCRDBN2bmhouD
 1zicEACP59pIrSjdTgQicn3Mt0vt/PWdfrht2zlzS6Vd1+kwt56M5FphY8nJtURhhnOrdc1ERay
 hEMM0TkQj7O1CRFab956TZCz6pFX+MD1cvNO9cPvDvPKHgCcWZR3rHfEt+IMS9/UYh8y2aGNK8w
 4ElvNM2pc7UF83jvIp/oZ4bF/55/3H2FENQMxhtAu3vx234GgH6lUvrEarOg9PnO9sGdMfFwH0C
 sxT5l5PdKeTAk6M1nD9uu3sv9+cpVJD5Wyh5P1ygY90M7RJWB+ZqmsWZ+NfT+PxlE7orTTVzwlX
 4DxqcDOGZASECO6k4dGh0tG1xWv77WE0hj6Sj5Avbpj+kVe4oo//ci9R4b9N9nNkpor/RP6CVA3
 nLI+5vn8kqF89BE2o4RlF+NkXddvi7rv4bP1w0ro+VzmZ77oyTt7UBsIKU+PceDLEQdmg8MF4EJ
 hgo3E+IK7kRzSacPincswBkv+JnnPHHAbcvvIvybX680zvp/6fQ0TMXt8XThqfBGGsq790smjxq
 MVcsa9t0N8SeAMhhKQsfnUpm/RJ5IcSfDMjXeSGGVdrSPBZODCFAiREKjQB92Z7GC9vP9Get5x1
 q0qx/ZlI4/f4zz6iNAAVjjYrSaG9jfbXhMCXngiZT40PRUgh8Hdj3wvnEXRjUqxfs+zkVQRsPUq 3xWYWqwjDKTu6fw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HdL7OgKr6JMrwIWwclONaAkY_03kBbe2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX/wc9QbcFXSYd
 4K6BGo9Nq2x15CKKNoTScwXaoEiavBbBJkYCUiU5nJXhPUTu5Xzho878OYe0jaalDFjyjbeUnhl
 kphQ1ehqcRQDXRFme1gFYc2ICHfZrWYUNhMS17Pk4kntiguXIOV1ooEgYtAfK3Jej6x52nXMYlC
 hvvh/2gJpSukI2+CioGkWMs3CerAhqB8VCxwLXmyKR+mujFGPgxxQas3HbNK0e6JD/5m/eeLEfv
 3Bm1L5ndtt0+guMlqe9T3GVyhlBWsivwgdCKH245bjXYVnY7HzIVyYTDDSU7tIyLk7/hVCRgc/K
 kB1qQvV76UyR0pjF6SDma3eZZSq3eyenGd126lflUUXB76MUe8bkAgxjwFnepXEdJXovRGmH9MV
 RNyFfRIg+QhAvr8NTTgNhS2RMVgFYtEGzaX5rO+lcABcdMel0njQWPT8U1/uPg9SYZbbLhhSskP
 k70CrFhhpKqWhUplXpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX9j+UaeNyRShx
 zeoSSzPtVei9a+TbpnambJMcOSdoilM8K1Up2Ip4SzuSHRWzTR3yc9Pqknnm6FVaKlTa67T+eB8
 5u0myOHntPtgyY2pogSP/Do8J+RDmgc=
X-Authority-Analysis: v=2.4 cv=WMzqzXsR c=1 sm=1 tr=0 ts=6aee1059 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uPNVP4c7M2W6CD1-7SQA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: HdL7OgKr6JMrwIWwclONaAkY_03kBbe2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060070

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

