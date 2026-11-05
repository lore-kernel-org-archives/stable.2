Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874546;
	b=rfG0i6e2c1JeqoO91dxRekS014j7hwfcbuCzPt9K87/MrVOzCa0FeRsxPgdcObwZJPFa
	 FUcavX/xE/5fmIYZNNe+u4HHvgzFE9EMqZI22SD2iY2Mx8SluIrY918kQ/JcGgdWOpyE2
	 JnOnOoYiv3yZBNI/4aNpJUspDM8wR2wddMr+/MwWCMpyPRAbVBtETLOe8X3PWlrMAa/EU
	 cpT/BouierqpUJwqdpP9jHruXnYsWWW3oHERWdnKz/x9MBVWiET8XkWULxJkhL6HAl5zO
	 H+sOsjNmULStwmuIYfVhzumMJ5TURC7SmkSpAkFOGrZaz2NVH8sgt+b470gbJQ1rK/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=kuiqWlPXMfPHzXfjavSlArdOnzZ4gKQLgR8XLdjD/d4=;
	b=sUM2FCS2xSmXMiHc2HSYtTdPYmM7iZU5XEP60K62cr6iwUrTrq+JiHmIhDkNbpPRGBaD
	 94Dx1Dd2z9wKNziIgK4G7jZ0+gFxQQkNkbYFBYhEcUgGjFV7pDfIfMSfbZGnrT+MowL9v
	 Hq+poyfL8I5o46wQcfJx6lILW/4MBsLKwZUwS6Cge+NRV5s5WBlPtX31d1m6LlAUsEbIJ
	 PXn/LvXSpm3bBx8O2N0SmvHJopPijhOPP5928I5fvgYgh6x943RM7MRFTUMH5D74Sbgoo
	 /MNAq6gxQayJP77gbYy7IPPuaRC3CcBEI6mWJ6HO1OZvFngVWXHSw5kvWu0ZGirOVkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=rpkKo2tu;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB790606D818
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 10:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB790606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=rpkKo2tu
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b56c428212so1353488a12.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 02:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1793874543; x=1794479343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kuiqWlPXMfPHzXfjavSlArdOnzZ4gKQLgR8XLdjD/d4=;
        b=rpkKo2tu99qcrPys0C/XByLVaqgRKyDLy5hwXBlYwnlBUw0XJxAh+YlCeFNWURR4yX
         xMChmFQXpXPOddaoUiW761WyIUnxA3ArhlFo6+qFdXLHmlzgfqHMnUVTLIg3RTeQEx+F
         lQBe1Jp7OZmyzKDJ00S7moxP2Y0oo7kIuWVB6tnYunZ/Z3kovCbpSCn5AgIhDs0M9VtS
         7sEvNZhSNvp000PLpA8FINskroYfLgCzDEfKqDo1dBN7cylbtWs/E0LZWYcA9iH5h+Tp
         OvYg0x8H78RaH+xwjeZUjlBJ15wIEYThQ111qfiUJTFQkU0wLG4RKghL3WbgBV5ySE8X
         5XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793874543; x=1794479343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kuiqWlPXMfPHzXfjavSlArdOnzZ4gKQLgR8XLdjD/d4=;
        b=sT19y/gYzQOFD7FdL4mnKbfSKitC7t+nN0b601enp8/ngMaZqTWNysz5JUOSSMkUUs
         ZCrg+KfdBPbSkztGxkyQZXWdgh28GgrxIghVmCnyW89C4BV7Nztmo7jjI4fQNzkaxs2n
         K4EQNe8R61zyk0bRvT/wJoVkTsol5x8VwjzMZZQCUdF3OZn/bmYScHsqTsAjY1Mib9L4
         OoACoBTe3cX1IOwlkaLdnkzVaan8nRtzIDch6AWwrLaHGCxBaDpHrpDCmUsPT10ALW06
         7uf7UlocXxivQb9XvP0JBh+SNl7nXJhH6pGnmC7IssnvAOjw3bs8/4O/iU8ng93rbt2o
         jXsg==
X-Forwarded-Encrypted: i=1; AKwUvBwEDadGvYUhmihFqGrFq4zibxNNjp7LJ7MFqpaLLPgHROCiGuPls5qklbys/DquX7uW/MG7Yos=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PAtWCC5/fpEnUna1XJoQLN6sHopIMk5kmazvWM1D2cCqbYcrB
	SHXXCiqbwHFQd0eWpfSQPxPkBvEtpgnxW2N1fzmq6yfpQV7J4dW7LN9w7XFOKEpA0HE=
X-Gm-Gg: AYBFou1hqFH4vpeHaAj5DhVDF96U+6ZycTxEJ7onDMuOvIxkE0TaMiFlc1NZ7aLvaUO
	wKKNLCCwJnz0jJbdVw49A9SuVcqSiTKYXodbTn93F1fSNwpS8af0M3uUP+cynx94AJxu73XmbZ3
	psTi6xuNcGWRtxZbY06LnEviroHgeQuxtXmw7HVMb73jI000rv1EBkPGdZ2BziJ0FWXZc7wWl1c
	GddYHQaRYaDs7IxiJh+oYVPfa7eKs2tiZ+pdHcdRIQ17N7tCKED1FB+94nk2vT5lOsvs56TyNWG
	aH4gAq8DWJcoLwpabRRJ3dl91MtPuK46CLxPlLVgN3qUUhNDz9b5io2+RtcZBthylMOIRTVAeSt
	znKFyCDDu2C55J9c5Zh+ba02fSabHu7CdTqcQe9d10+M1L1yl5af/BoJShmNcHbNVbNTijYTiYn
	3PAl5tr8PGpSczFY8vi/JROfuMX18cVQXG+kMSJ7ZbPdHjVXQofvUfeW8Q/PZ3erX4fJxQIM9XI
	JZL7K+M2VnNNjtnhttrrV9Qpku9RoVzjD1TRwP880xGeU6kRnmp6jzswGteyNH/6wB2nu76TU/3
	wXAg/Oem5yA5Vlg3M7Ve7g/RsgB6VeWc74i4aoROU6QfEYWTnMotwjj8zeo8SINGx1An9ywnLbL
	NpwaNImlSqtS7p+hclagJzW3C+chGZHSI
X-Received: by 2002:a05:6402:1f45:b0:6b1:cea1:a023 with SMTP id 4fb4d7f45d1cf-6b4d4c6f85amr15321879a12.19.1793874543256;
        Thu, 05 Nov 2026 02:29:03 -0800 (PST)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b5864a87c1sm278665a12.2.2026.11.05.02.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:29:03 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 05 Nov 2026 11:29:01 +0100
Subject: [PATCH v3 2/3] media: i2c: dw9719: Update DW9800K driver
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-dw9800k_cleanup-v3-2-6850ee6a5a5a@fairphone.com>
References: <20261105-b4-dw9800k_cleanup-v3-0-6850ee6a5a5a@fairphone.com>
In-Reply-To: <20261105-b4-dw9800k_cleanup-v3-0-6850ee6a5a5a@fairphone.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 stable@vger.kernel.org, Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793874541; l=4806;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=vIdVuZXzskHp6BB4VyvbfPYAsFbE+ScV5dXe5s5BsrI=;
 b=6+AAeHghITHv//1oWnkYUBCUdUedB1RP6RwrpnwU99n2tT+uf1GomnfMlKYV19Tc5Y/NU8ycr
 vFJN8EdB3hvD8BvCbxnsAeHP+8ErbZ1tN5JXFFUg7bL6D3on6uj6zrc
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

The previous DW9800K driver code was created without access to a
datasheet for the part, now that we have one we can clean up some
misunderstandings and add some features for further expandability.

More specifically:

Previously we were blindly writing registers to their downstream values,
Now we know what the correct default values of SAC and SACT, and write
to the correct bits as specified from the datasheet.

We found that the device does indeed have an ID, and add it to the
switch statement when setting up the default device properties.

The largest change would be the implementation of "Ringing," this is
actually an internal switch bit used to differentiate whether the SAC
(smart actuator control) modes are enabled. if the "ringing" bit is
zero, then actuator modes DIRECT and LSC are available(based on the
value written to the Mode register). If the bit is 1, SAC2-SAC5 are
available.

For the devices we tested this driver on, no new values are being
written, but now the option for further use of the DW9800k is available
to others if they wish to do so.

Fixes: 083f7f0dce16 ("media: i2c: dw9719: Add DW9800K support")
Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 drivers/media/i2c/dw9719.c | 65 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/dw9719.c b/drivers/media/i2c/dw9719.c
index 3b7ba88fd67c044ef9005a0aac6a5d26ab939a90..3b99c5492522c33e0aeadb9fe7e9b49f777b9470 100644
--- a/drivers/media/i2c/dw9719.c
+++ b/drivers/media/i2c/dw9719.c
@@ -68,9 +68,18 @@
 #define DW9761_VCM_PRELOAD		CCI_REG8(8)
 #define DW9761_DEFAULT_VCM_PRELOAD	0x73
 
-#define DW9800K_DEFAULT_SAC		1
+#define DW9800K_ID			0xEB
+#define DW9800K_DEFAULT_SAC		3
 #define DW9800K_MODE_SAC_SHIFT		6
-#define DW9800K_DEFAULT_VCM_FREQ		0x10
+
+#define DW9800K_RESONANCE		CCI_REG8(7)
+
+#define DW9800K_DEFAULT_DIV		0x01
+#define DW9800K_DIV_SHIFT		6
+#define DW9800K_DIV_LOW_SHIFT		2
+
+#define DW9800K_DEFAULT_SACT		0x20
+
 
 #define to_dw9719_device(x) container_of(x, struct dw9719_device, sd)
 
@@ -90,6 +99,7 @@ struct dw9719_device {
 	u32 mode_low_bits;
 	u32 sac_mode;
 	u32 vcm_freq;
+	u32 sac_time;
 
 	struct dw9719_v4l2_ctrls {
 		struct v4l2_ctrl_handler handler;
@@ -140,10 +150,6 @@ static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
 			dw9719->sac_mode = DW9718S_DEFAULT_SAC;
 			dw9719->vcm_freq = DW9718S_DEFAULT_VCM_FREQ;
 			goto props;
-		case DW9800K:
-			dw9719->sac_mode = DW9800K_DEFAULT_SAC;
-			dw9719->vcm_freq = DW9800K_DEFAULT_VCM_FREQ;
-			goto props;
 		default:
 			break;
 		}
@@ -165,6 +171,11 @@ static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
 			dw9719->sac_mode = DW9761_DEFAULT_SAC;
 			dw9719->vcm_freq = DW9761_DEFAULT_VCM_FREQ;
 			break;
+		case DW9800K_ID:
+			dw9719->sac_mode = DW9800K_DEFAULT_SAC;
+			dw9719->vcm_freq = DW9800K_DEFAULT_DIV;
+			dw9719->sac_time = DW9800K_DEFAULT_SACT;
+			break;
 		default:
 			dev_err(dw9719->dev,
 				"Error unknown device id 0x%02llx\n", val);
@@ -185,14 +196,50 @@ static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
 		/* Optional indication of VCM prescale */
 		device_property_read_u32(dw9719->dev, "dongwoon,vcm-prescale",
 					 &dw9719->vcm_freq);
+
+		/* Optional indication of SAC timing */
+		device_property_read_u32(dw9719->dev, "dongwoon,timing-control",
+					 &dw9719->sac_time);
 	}
 
 	switch (dw9719->model) {
 	case DW9800K:
-		cci_write(dw9719->regmap, DW9719_CONTROL, DW9719_ENABLE_RINGING, &ret);
+		int ring, sac;
+
+		/*
+		 * Enable ringing for SAC3-SAC5
+		 *
+		 * sac_mode	reg	Mode
+		 * ===========================
+		 *	0	0X	Direct
+		 *	1	1X	LSC
+		 *	2	00	SAC2
+		 *	3	01	SAC3
+		 *	4	10	SAC4
+		 *	5	11	SAC5
+		 */
+		switch (dw9719->sac_mode) {
+		case 0:
+			ring = 0;
+			sac = 0;
+			break;
+		case 1:
+			ring = 0;
+			sac = 2;
+			break;
+		default:
+			ring = DW9719_ENABLE_RINGING;
+			sac = dw9719->sac_mode - 2;
+			break;
+		}
+		cci_write(dw9719->regmap, DW9719_CONTROL, ring, &ret);
+		/* DIV is 3 bits split over the bottom bit in reg 6 and the top 2 bits in reg 7 */
 		cci_write(dw9719->regmap, DW9719_MODE,
-			  dw9719->sac_mode << DW9800K_MODE_SAC_SHIFT, &ret);
-		cci_write(dw9719->regmap, DW9719_VCM_FREQ, dw9719->vcm_freq, &ret);
+			  (sac << DW9800K_MODE_SAC_SHIFT) |
+			  (dw9719->vcm_freq >> DW9800K_DIV_LOW_SHIFT), &ret);
+		cci_write(dw9719->regmap, DW9800K_RESONANCE,
+			  (dw9719->vcm_freq << DW9800K_DIV_SHIFT) |
+			  dw9719->sac_time, &ret);
 		break;
 	case DW9718S:
 		/* Datasheet says [OCP/UVLO] should be disabled below 2.5V */

-- 
2.43.0

