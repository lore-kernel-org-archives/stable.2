Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007A40F749
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912993; cv=none; b=L8ROqVZVLDl0kt8tHSiGz3Z6o3EWMpNRBJYx4IZ8ZaNXkTsDNLwftoo16NGJH68X/rumNhCrmcJuI6BW70Sh5TqumT0mdA1fw72iLfcoMmyPV6mvDyuasVmQQ3SuBpEp+mf9PRJnMjzduU4Sy3Xv2Lda281/gh0JRMYsm0jzduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912993; c=relaxed/simple;
	bh=I7wMMzUOTxXy59XXrAAdXEH/cY4Bv2uQCN82eMYlt3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gkMlAkmFohU5Ep5huQVIBAnqBJtrRIU1gfdX7ZpiVr7nTAK2X8cU4eq/eZf/YPdOBK7QyZZYeA9bj8JJi9Nqs1eUxucP0evXEx3LT1c1xuwg6bZdAebeFvbK98X586xqXuNvK35jF/eD9tg1/bxJgSL3o9Drjz1j3NnL8gC5X7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Whj49Yq3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mcisa7MK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Whj49Yq3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mcisa7MK"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SA7cB42744774
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 10:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6AZ4KHj4RIWnDS4nK6Js8M
	IOlqKDXq/pyeIEXZbRqBE=; b=Whj49Yq3jIAE0BX6cHJ4erISo00PeGlSUujgwT
	TX9KRNnOqmCB0qau0p/T9Kom2C4KeBiBy+A3ROCQel4jIq6lgUe4dL2oV2v7m2fz
	VARlgjHdRdwhCA4qfD2xckCUvQPEUCEqIof1XeNcgac+nsFrDzfYcXkRWx+hgzpu
	qpwAA4mMISg4MoFxHQFIDGfr2gcIR12DvGO29TgmtRZ4MLhwkjo4CTBLZBhz+DWp
	SE5gXfDdtl9T3lDmGHNIpOV38OYZQAMGvwJRuxN6V6PPEbgVt8ntRXevcPIVVSK7
	0QalaDhYRFRRCCFhn/QvWNlgug7J6hYEVKZBjKIn2bcCdOsg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mxsaj4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 10:29:49 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso989082a12.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 03:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787912988; x=1788517788; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6AZ4KHj4RIWnDS4nK6Js8MIOlqKDXq/pyeIEXZbRqBE=;
        b=Mcisa7MKcPRcDDah75mEcs7CeVEvx1EepdF6B15PAPYYvEqCVcEToHVEUwj83Cbex8
         HZoyLP7GaO61HEHFFNcYDe60i5E0VdrMOv1TeYMmqv+jCs0MTKJxKlBKM3eE80cw+m8p
         1iCFWCelL3Kl1TXBUATEfSaJco/4/kGJucThccUibmghFjc+s1RYXelKWzv3dXVj3H6/
         YVoHCaNtL1vgqzqZMMF1tBVA66NL9ctcZiY1kGwTDkxG3YVKdRO6f6bsh7UYLZpC1l6g
         eD45TZsT8DLAna7Xg+dPCze6IhPkZ97Ts28WMC5qoZwSnFs/s535au+NuexfkWTmf7gG
         71Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787912988; x=1788517788;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6AZ4KHj4RIWnDS4nK6Js8MIOlqKDXq/pyeIEXZbRqBE=;
        b=Szt41JQPo/e4qMNnVRUazFbLcf9Vk62mD4DogJvnWarnnExkiUozlTcvrnK0Y0AOR9
         54o11UCGF6Pto8d9DKsH7qf2/Z2dR6TMM3YrqGNPDZqzE4S7qrETiakrewmGGhJRlCff
         KM13Vqdd3Eb4N7v3iegAq6NHBRiaTJE8RaH1eLk8hfmYLWREaCLg5U03yaA5a4MXuHpa
         ngeQmScj9j4NR5pymGlpZ4m8WJZON1jfx8vIUn7sr2UmsIEnEkj1hECl1OufX0xc3YFY
         pnX/zwZlyZso1FQRj5Yf0nbecSLrZELKPgqzk75NCeWYqll/WjipX6H/2szvuScfxxzd
         hySw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/kMvmmMk6EeWK/8wKcUJaiv56BdfTCU57i4o7M7+K8bxuYS1OR23Pp1PAmPDtF8OpPGKDC3I=@vger.kernel.org
X-Gm-Message-State: AFuF++k+W7nzhHNTHTrYTyfQ8xzVy5f4UBqVX6q8GjupziUYyGvbQkFR
	+jpaust2PMZ1GoP3fC6e0QPUjpBSpipNz1PuHELuiTNHG5BAXbY5CkkaD9uUVzncReGY/8BFgax
	4DvvbOZrJTYX3Q5SA0QEEstjVK6hoDxhGhfhV0JHMl430D9frei6N1YW+4sM=
X-Gm-Gg: AR+sD11CJc9c7/gym8GdTO92RKs68/4Atvo+cquNmipNLOE/iHbEuGzWM47RVTbS+dk
	/0LbRig6gZHyR+qmp3PWKWet93skv7sWayjt0lbBsmC+6Sc5YSGm1si27//hPs7stS/q/jHB50j
	/eQLkd9HR8C4JUXvSy5X4khkgP4OnM65NH97rOHGnwZrdYvZb3drWLoxhIbZUsq8YlkhW3hBgOe
	z1IlFJBY/XkOjQBP4+djXOhvV2R0sxz2IgWmp8XUAQUGkecslXxeDu5jQbcwfB0i/QVLQZ7SH05
	Iiv08zZ49eIZQiYaDgQUCxTcn0kQeqPax4St1KQJdTaAWgfCQ5mfireO5IYSGLmJNSbdQ3sP8dh
	YusQvfk4Sm5vlGO/5xUpkR7RKYMomA0R7O7qK
X-Received: by 2002:a17:90b:440d:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-396d0e5e891mr11062395a91.2.1787912988100;
        Fri, 28 Aug 2026 03:29:48 -0700 (PDT)
X-Received: by 2002:a17:90b:440d:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-396d0e5e891mr11062322a91.2.1787912987665;
        Fri, 28 Aug 2026 03:29:47 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f783c57sm5267301eec.4.2026.08.28.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 03:29:47 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 15:59:32 +0530
Subject: [PATCH] i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-i2c-fix-se-clk-conf-v1-1-9adc72308f2d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAxjkWoC/yXMywqDQAyF4VeRrA2MI3h7leJCY0ajMpZJKwXx3
 Tvq8oNz/gOUg7BCkxwQeBeVzUdkaQI0dX5klCEarLGFqUyJYgmd/FAZaV2QNu+wql3hajvkZd5
 BfL4Dx8ldfbWP9dvPTJ8rBef5BxS9ICJ3AAAA
X-Change-ID: 20260807-i2c-fix-se-clk-conf-89f6f92d373a
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, Wolfram Sang <wsa@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787912983; l=4220;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=I7wMMzUOTxXy59XXrAAdXEH/cY4Bv2uQCN82eMYlt3I=;
 b=ullmR2ZMP/fubY++Q5rSlO4oCU7BktzJl0erJgJQFGdI8C6Gphm50UBLmKgrNi0FY2YsQQ9po
 vMCMO3C/RafAfGPNSHu22kvWLZ3ZPYBHww8X+LjJiALWLviBoQhz6Hn
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4OSBTYWx0ZWRfX89fcIO1u1A7b
 +VRw5HoFR8Rlmx4fuy1WCOv5M3JVdmZ1UBflw1IJ7JAj8B8V4/2tYlg8K6m9KwsRqfd9yDqAjQ+
 QojlQSUGCd7eGoc0QpHJI9zs2wC2rldFbLej/ay9O0MKRFsJQ8iTb/TzTlB+jg1wYDFndOETivZ
 NplssEdPGUEpdKBDyRcl1Y4rZr1+DQOTcpLfWEc4FJ8+/AyimqSS2FJvh2yQ+ypsbEwK5/OqoPi
 px9VU43tvuI5X1PbJ8NuLimmH+lYVyIlVVQsvBaMW1I1VTa2wg4TMByp/9bUXfpmwbUOOZs5RZX
 k9IZdPrM+ZNIi8fKLr6QUG6ZrCshIPQruZOc3Dab+RAWcCfUJHptwFdKrLF8x6D005M8yjyGRlb
 Go7TAcggJoaGZe2LZvntwbmUjlPcQR2pxrZn1t7eKcPrKrHWuI68jpVLWx46kmsHphR69sqcoUo
 l7ca31oYdUNLMw1lvKQ==
X-Authority-Analysis: v=2.4 cv=MONQXsZl c=1 sm=1 tr=0 ts=6a91631d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JoU330fbb_3TrnOeRF4A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4OSBTYWx0ZWRfX4Fwd0KeObSho
 7qdAC2mTbzZ+VD6GDdO62PoA2Hapw3tf8WKsiuFKL+jcrfR+Qr6FGlAzGpVuSbQftElJDl7oxbK
 Oz9zbN0OXHJEJEStkTGXA9AFJ8HJDss=
X-Proofpoint-ORIG-GUID: 6mOov7ktlf6VMEPdR1fXhRdrq_5_kqNa
X-Proofpoint-GUID: 6mOov7ktlf6VMEPdR1fXhRdrq_5_kqNa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280089

qcom_geni_i2c_conf() writes a hardcoded 0 to SE_GENI_CLK_SEL, which
selects an index from the hardware clock performance table. This always
picks the first table entry regardless of the actual source clock
configuration. On platforms where the matching entry is not at index 0,
the wrong source clock divider is active and the I2C bus runs at an
incorrect frequency.

Use geni_se_clk_freq_match() in geni_i2c_clk_map_idx() to find the
performance table index for the source clock (32 MHz or 19.2 MHz). Store
the resolved index in a new clk_idx field in geni_i2c_dev and write it
to SE_GENI_CLK_SEL instead of the hardcoded 0.

Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..a83297b5fb0a 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -82,6 +82,9 @@ enum geni_i2c_err_code {
 #define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
+#define GENI_SE_CLK_32MHZ	(32 * HZ_PER_MHZ)
+#define GENI_SE_CLK_19P2MHZ	19200000UL
+
 struct geni_i2c_desc {
 	bool no_dma_support;
 	unsigned int tx_fifo_depth;
@@ -127,6 +130,7 @@ struct geni_i2c_dev {
 	spinlock_t lock;
 	u32 clk_freq_out;
 	const struct geni_i2c_clk_fld *clk_fld;
+	u32 clk_idx;
 	void *dma_buf;
 	size_t xfer_len;
 	dma_addr_t dma_addr;
@@ -197,19 +201,42 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
 static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 {
 	const struct geni_i2c_clk_fld *itr;
+	unsigned long res_freq;
 
-	if (clk_get_rate(gi2c->se.clk) == 32 * HZ_PER_MHZ)
+	/*
+	 * Counter tables are calibrated for a specific source clock frequency
+	 * and are not valid for any multiple of it (e.g. 64 MHz, 128 MHz).
+	 * Use exact=true and verify res_freq matches req_freq literally to
+	 * reject harmonics: a 64 MHz clock that divides evenly to 32 MHz
+	 * would pass exact matching but produce double the intended I2C
+	 * frequency with these counter values.
+	 */
+	if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_32MHZ,
+				    &gi2c->clk_idx, &res_freq, true) &&
+	    res_freq == GENI_SE_CLK_32MHZ) {
 		itr = geni_i2c_clk_map_32mhz;
-	else
+	} else if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_19P2MHZ,
+					   &gi2c->clk_idx, &res_freq, true) &&
+		   res_freq == GENI_SE_CLK_19P2MHZ) {
 		itr = geni_i2c_clk_map_19p2mhz;
+	} else {
+		dev_err(gi2c->se.dev,
+			"Unsupported SE source clock: must be exactly 32 MHz or 19.2 MHz\n");
+		return -EINVAL;
+	}
 
 	while (itr->clk_freq_out != 0) {
 		if (itr->clk_freq_out == gi2c->clk_freq_out) {
 			gi2c->clk_fld = itr;
+			dev_dbg(gi2c->se.dev,
+				"I2C clk selected: freq: %u Hz, clk_idx: %u\n",
+				gi2c->clk_freq_out, gi2c->clk_idx);
 			return 0;
 		}
 		itr++;
 	}
+
+	dev_err(gi2c->se.dev, "Unsupported I2C output frequency %u Hz\n", gi2c->clk_freq_out);
 	return -EINVAL;
 }
 
@@ -219,7 +246,7 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
 	u32 val;
 
-	writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
+	writel_relaxed(gi2c->clk_idx, gi2c->se.base + SE_GENI_CLK_SEL);
 
 	val = (itr->clk_div << CLK_DIV_SHFT) | SER_CLK_EN;
 	writel_relaxed(val, gi2c->se.base + GENI_SER_M_CLK_CFG);
@@ -1111,8 +1138,7 @@ static int geni_i2c_resources_init(struct geni_se *se)
 
 	ret = geni_i2c_clk_map_idx(gi2c);
 	if (ret)
-		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
-				     gi2c->clk_freq_out);
+		return ret;
 
 	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
 				  Bps_to_icc(gi2c->clk_freq_out));

---
base-commit: 3d83758432b5e6ed9507500a57efb0f3af41ee7d
change-id: 20260807-i2c-fix-se-clk-conf-89f6f92d373a

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

