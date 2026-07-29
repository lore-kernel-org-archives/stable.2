Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5DC3B059C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338649; cv=none; b=kIsGlKWxYqm5CMmSdq4zqOoKAHFgGkC7vStcVMuX0SWrgLNJzyMoq4mvNfDfmZSfrCZba7yS4+wBW+B7U5MFosApPSRRVcv17U70DPzTylEWO2a9TmT9OGJMDxhWRJC2Y/o7J/vK2xH5IzFq5UwTP8BC8n+a0H6KP5rFTsd2BJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338649; c=relaxed/simple;
	bh=IF3mvxGJ0MO2sFrQjf9weWMiNXHfJPGDAZw23KD0uvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sXEulLdAqqgXpGz5BXQNnHtRhdVBpdEyrGfIV2YRu84xW9pUX4/PFotPPQtIgZW8ajkDCw6LN0i1BKWP+EwNxIo3t2F/c+iYSXuSzAgU8TfGglQFfeeVHtJ0SYzVgvjqcvwzJ2KNCEV0u1hhGJq1Qwf9LMc0lPr+Drg8DjBPoO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JNiKFw7S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jRc5vjvh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JNiKFw7S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jRc5vjvh"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF2QE91961578
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QutVvloV8VQHn81ETmUh0x
	rjJt+7iIZspS+kx/oCaGM=; b=JNiKFw7Sqp0y9Owx1pNHYCKUqmrpEagD8Rx1Xz
	kpY2p5aPDUc2IYTplP+kJWj2N1KpA95VKfieKxZPp5EGI/3wH2YYjnV5DsVz8MJA
	rhp437e4+08Se1gMp1Drof2gOe0VO/d3J1SAAsKWhR3aAi7TpWyNAX5v6gYqn6e/
	6uAaUHNIH4XgmpxAqN9JfceVjmaaD/Q7k4Oxeb1kAetCtOJbXABM9Qlz9e8abGOd
	fmXizXnkJzGX4+FXOGA8z9GOZ3JGiVLcy7Bfsb4vOKfjEXIuOBzpxE0gRtj8UMfz
	xWJG8Vg+sBBiiAViNUdRwQ7afMi8h75bGhauHI6yjWYOgVaA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgy9130t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:24:07 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81f8ba7885eso37035877b3.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785338646; x=1785943446; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QutVvloV8VQHn81ETmUh0xrjJt+7iIZspS+kx/oCaGM=;
        b=jRc5vjvhbFb7ifpHuuj8l5SFLWidBz4z4/9vlGJWWYxd0EB1ZsmG+Q942JOOkx0CMB
         ZJbeSQBjwBFpk9xYS0HAqu4X/nKLNBzrQAiM3CebALj57LSVC26NNGUmTrU/Hs7Lb4YF
         wutFkQMmzY2KkkfQ19a2swAS/YR4m9cfo/xyhfd4ixEq/Fuei4u7iTMeW4ouIGBFc3fX
         7mRYBT82EvjUlnlGK3doH25ZJYkarxp59Gdf8Kmhatc7oMt2k4GNPqqJe2T1oThHHcW2
         5dVjgmobWXM6CcknEnBTHKdmz6/vhG1HAXhoFRtppo8pLPj9CrLWXbHHeeMa0s6Z88vG
         KBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338646; x=1785943446;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QutVvloV8VQHn81ETmUh0xrjJt+7iIZspS+kx/oCaGM=;
        b=Bp4qslOIzvu8jKkJUbxDVcsdBP4OS8u+1TZIVTc+/SepLAvr0g1P2PFlyhDs52INg0
         j2mixpecybvhu5TRgjFIeZJCN2+F6v5EF5XgYredvoPWUFGz0TbXzFZ9A5MnA6frb4HU
         C7gJXt1M543D0IZmLW/VHXs5OQH8njoie2yzjLTHhr8mxhXUtRJjyALOaxuzVLhr7Osx
         F6TuYjVYBuuNXW8ESsiMMaziVZVLNkGx3ecV7coe5dZ29WgO+aU+UdtrnI86YBvBiuG6
         eRNCfRCilyOWW4fyOJF1ypgOsmQuNUcshbXOweP4P+hdR7zLlEh2B9/qQgawVTIJezE1
         oDfw==
X-Forwarded-Encrypted: i=1; AHgh+RoTKsL/WnxNmTI44jT/aanJfwfFx6eiwEinv9F0ijClgYH8829e6CTb4kWMWoFhSbazzmMS3ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCSkm7Tbi6accOYRKiGXOvWeh07Ux9pe8qOu4FjynMAzFeHGJg
	e4E5SWy8J2CCOQLIotMgxEmOdbgdLijdrczVXLpeFIbzAiYP2YxvTZKEQjlF+r1qn6UiAhzRhha
	BVi6issXhXZln2Mx6mbq6ic36C9E1LxwVJHytRymujjWOqfhRqSB2aDHi/Lc=
X-Gm-Gg: AR+sD12R5BVfEh1x4cHnyUvjTleP9M6bdDhWdmE4TuSNuc2O/t4B6CiMu9E66GB0v5w
	J89AcW4bRpCcyjP4/9a4gqqYDb0K5idfYo/MPHtj/uwPWPpjulOvEiW2JxUE7NyMO6rwa+ZFE8P
	/wIFZPPa7O9WFicIfzZ9W2vxczHRm7QpSDFrJ/tYgfsI0FfdlvI9l5roCZWe6HX1njCGhuzK/kp
	yZyyKcMivr6uOAFun9cauIEP0oqvDv/wktL2Cjbe2RN4zeMeVWDu4GDcBAHYfNGITVtfQuLQZVc
	PJkddAo7SDRc/DAXhoPIM0VVJWn1GYhU60idCSu7xkwZCsG6jx4NRIezYlwHXdQN244dfzBHPjJ
	ZnR2h0fBKViT+nGpXMx+0GHUjznjk9Jw=
X-Received: by 2002:a05:690c:6309:b0:81e:edfb:3194 with SMTP id 00721157ae682-81f9928e45dmr31850717b3.59.1785338646195;
        Wed, 29 Jul 2026 08:24:06 -0700 (PDT)
X-Received: by 2002:a05:690c:6309:b0:81e:edfb:3194 with SMTP id 00721157ae682-81f9928e45dmr31850377b3.59.1785338645539;
        Wed, 29 Jul 2026 08:24:05 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa27592f6sm20198977b3.9.2026.07.29.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:24:05 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 20:53:47 +0530
Subject: [PATCH] clk: qcom: Fix test_ctl_hi field for DEFAULT_EVO PLLs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-pll-test-ctrl-fixup-v1-1-246d79589380@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAIbamoC/x2MQQqAIBAAvyJ7biEVCvtKdCjbakFK1CIQ/550H
 IaZDJECU4RBZAj0cOTrrCAbAfaYz52Q18qgWtW1vTLoncNEMaFNweHG7+2xM6S1kT0tykItfaA
 q/us4lfIBEQY1a2UAAAA=
X-Change-ID: 20260729-pll-test-ctrl-fixup-69e33917eb2c
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Iskren Chernev <me@iskren.info>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNCBTYWx0ZWRfX2/JJPoC7Qc9R
 DHWMuVuLKRaWfdb6t/706o0241+WVYznvsfoLmd870ErzamjVpi4jO64+13o7LaVxDL8YmEDBps
 7KQDZcPY8MqqUgAKqPKj3QuLxto3XrA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNCBTYWx0ZWRfX3spB3PU/IsK5
 HXzmT9Es/yc0xeUfgR/4/giWLsshHTfnCw55z9PbJoXB6FNH228Bz1s0V+6seCihxb9K8ky51/k
 WJq1NQicK3InggITqMLI9ubBINMD0m6PRpB3I+OldgrZYHirxlbUN2tgaugGegJ5Lpu8t27Pgs0
 ZL/1swqIJ+OQSBcEn2biqX+IlwUo5JEkYGCcoXoGOiQceIqta6Gmq8vc66tnSy9YMFXo3+rJ5tj
 6TIOoAMbW/WCUS4uAWGhrQ5iXQ0N9Ke1GhdkTzwZAIPJ4DYobiNRyFoS+nIYjRv6CE7HaR4B6g2
 lTXbwmy2U4mgwY8acisNfFdGxuRnRr1cFZwUj8rnJnOG6YRSXBbSWoqetgbayLE6EULKBep3VIa
 r9I4TeNXNKKF4FLLzM3jD0DY/wpjo9VVQjBKVMG2n/faNw8FhR8nG+mF0tqWqAYlD3+4yQhC0w8
 opbaqAWnAW6I0fIIpyA==
X-Authority-Analysis: v=2.4 cv=LtKiDHdc c=1 sm=1 tr=0 ts=6a6a1b17 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZfmlxCiM9nxkjRjWVfQA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: R-0--gK9tnxqhz_QH_YILCVyrOVAb4U8
X-Proofpoint-ORIG-GUID: R-0--gK9tnxqhz_QH_YILCVyrOVAb4U8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290124

CLK_ALPHA_PLL_TYPE_DEFAULT_EVO type PLLs do not have the PLL_TEST_CTL_U1
register, so clk_alpha_pll_configure() does not program test_ctl_hi1_val
for this PLL type.

The GCC PLL configurations for QCM2290, Shikra and SM6115 wrongly use
test_ctl_hi1_val instead of test_ctl_hi_val, deviating from the hardware
recommended settings. Fix them to use test_ctl_hi_val.

Fixes: 496d1a13d405 ("clk: qcom: Add Global Clock Controller driver for QCM2290")
Fixes: 01cf3e27824d ("clk: qcom: Add Global clock controller support on Qualcomm Shikra SoC")
Fixes: e88c533d8a2a ("clk: qcom: gcc-sm6115: Add missing PLL config properties")
Cc: stable@vger.kernel.org
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-qcm2290.c | 6 +++---
 drivers/clk/qcom/gcc-shikra.c  | 6 +++---
 drivers/clk/qcom/gcc-sm6115.c  | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/gcc-qcm2290.c b/drivers/clk/qcom/gcc-qcm2290.c
index 6684cab63ae1160848631d1f8cd3c9cb691ff4ec..690f23793af6b55b205341112b478bf34cf71722 100644
--- a/drivers/clk/qcom/gcc-qcm2290.c
+++ b/drivers/clk/qcom/gcc-qcm2290.c
@@ -116,7 +116,7 @@ static const struct alpha_pll_config gpll10_config = {
 	.vco_mask = GENMASK(21, 20),
 	.main_output_mask = BIT(0),
 	.config_ctl_val = 0x4001055B,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 };
 
 static struct clk_alpha_pll gpll10 = {
@@ -148,7 +148,7 @@ static const struct alpha_pll_config gpll11_config = {
 	.vco_mask = GENMASK(21, 20),
 	.main_output_mask = BIT(0),
 	.config_ctl_val = 0x4001055B,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 };
 
 static struct clk_alpha_pll gpll11 = {
@@ -309,7 +309,7 @@ static const struct alpha_pll_config gpll8_config = {
 	.post_div_val = 0x1 << 8,
 	.post_div_mask = GENMASK(11, 8),
 	.config_ctl_val = 0x4001055B,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 };
 
 static struct clk_alpha_pll gpll8 = {
diff --git a/drivers/clk/qcom/gcc-shikra.c b/drivers/clk/qcom/gcc-shikra.c
index d5222756f214c356214039f95a93a28fc542801b..4974bb64af98167db83f852c124c014a81cd6da8 100644
--- a/drivers/clk/qcom/gcc-shikra.c
+++ b/drivers/clk/qcom/gcc-shikra.c
@@ -123,7 +123,7 @@ static const struct alpha_pll_config gpll10_config = {
 	.vco_mask = GENMASK(21, 20),
 	.main_output_mask = BIT(0),
 	.config_ctl_val = 0x4001055b,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 };
 
 static struct clk_alpha_pll gpll10 = {
@@ -156,7 +156,7 @@ static const struct alpha_pll_config gpll11_config = {
 	.vco_mask = GENMASK(21, 20),
 	.main_output_mask = BIT(0),
 	.config_ctl_val = 0x4001055b,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 };
 
 static struct clk_alpha_pll gpll11 = {
@@ -361,7 +361,7 @@ static const struct alpha_pll_config gpll8_config = {
 	.post_div_val = BIT(8),
 	.post_div_mask = GENMASK(11, 8),
 	.config_ctl_val = 0x4001055b,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 };
 
 static struct clk_alpha_pll gpll8 = {
diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index c5251aff98864c539f5feec3ffe9adcd2cbddb20..a3c9dbe3a48af130499a722bee7dcf1243b548dd 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -120,7 +120,7 @@ static const struct alpha_pll_config gpll10_config = {
 	.vco_mask = GENMASK(21, 20),
 	.main_output_mask = BIT(0),
 	.config_ctl_val = 0x4001055b,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 	.test_ctl_hi_mask = 0x1,
 };
 
@@ -173,7 +173,7 @@ static const struct alpha_pll_config gpll11_config = {
 	.vco_val = 0x2 << 20,
 	.vco_mask = GENMASK(21, 20),
 	.config_ctl_val = 0x4001055b,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 	.test_ctl_hi_mask = 0x1,
 };
 
@@ -367,7 +367,7 @@ static const struct alpha_pll_config gpll8_config = {
 	.post_div_val = 0x1 << 8,
 	.post_div_mask = GENMASK(11, 8),
 	.config_ctl_val = 0x4001055b,
-	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_val = 0x1,
 	.test_ctl_hi_mask = 0x1,
 };
 

---
base-commit: 3652b49adac266a3d27cb41cdfdb7d8790fc3633
change-id: 20260729-pll-test-ctrl-fixup-69e33917eb2c

Best regards,
-- 
Imran Shaik <imran.shaik@oss.qualcomm.com>

