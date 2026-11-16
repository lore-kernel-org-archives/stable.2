Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794837046;
	b=qFR56MOogjzflGCQMB9lbACkqr1K/45b/0YBPKySWJgubxwagRmF8CnlC3YKoLi3GCb8
	 DzZ7fW4aTYKv4ZI0hzNSpqElKPifh+LFSrLY9F7Cs5jF0lbpvYyQ108uV4xOJc3EjbcPR
	 R465us6AsR6hi8hY+Lm24k02fN9fhl5QrqeVy1iQ0EikRd9fJrsGc9m0K4OhR89QwIMwv
	 GIxS+7UAb67K/Xfnjx6H8r7t0P7DpB6iKbObzsYPLsXvZ2YxcwR00ayLB01EZb7ti2/Y1
	 ObBB/f0rkBGgKmxZZCWk3aPDcUMjeGUpsTCmhK56+VrtL1be/mykHapncUTYbz2Ghsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837046;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=i7PvEL50DB4zsMyJWTI1yh5Wc4DVj1sntUbGWGamxxk=;
	b=WSquvkclXxj0RHV9Lrz3vqkJGgOQeyKgMqm8+2MLOSe8xn49hbC2VwmaQ8+7qcxeNuwT
	 B8Jtanrtfxbd6dwHBgH/xMP5fWBExVeDWdETfiKxdIAWCnTLCYnswWLlfD8LAwhi1Xl79
	 dT+H4Zc8kJZNAP32VW2pfdo06vexH8hwcnV7t+UqXRMF7534tzVZKSw36cjGixmrvFTb1
	 E8Wvls2x57Y8057lsh9DvGTU4jz/FIufWZTjyY2ubKMaUFgfe6h8CGvapAK0KQN+xtnIz
	 ZuoWY8Y2lhLF3DJ40I9Qt33+sCD2kUIakwTue4RiGSDODaqx42XSKrd01jaafaYoRQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=RfVlJbGo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89063606A8A6;
	Mon, 16 Nov 2026 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=RfVlJbGo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794837046;
	b=TBHYeh4SlHt1Rl57g7V84hybch2EgZBD+MhoMYfbaarYf4opH8XraZBIx7XyBdkdkgfD
	 59sgomIEzhN9kYbi6biNlQAgkiLzwVRbq7zLQsdgk6d4bGz6d23qc/cgjY4Or98C2oy/T
	 NWfPn2srhaid5OniuU6PdaQKMEkNuOeJ0HgIJv3FqhdO9lsaQ8HRnPbQz3gBF+PIOdcAE
	 DPwleUnxH9xZ3cwGantvPr/DaSMvVZ5ErG8DS8407eIFz5lvEi2fA7UsINaruHfTjOghb
	 o1euwoAsTJnfpIBe8y1pvnpohHsoUYBe+ZU+F2lvqsy+y5f9XHgDWhSePKVETKQ7NRA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837046;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=i7PvEL50DB4zsMyJWTI1yh5Wc4DVj1sntUbGWGamxxk=;
	b=C57arwm5HcVG4sYpnVUUBKUb/yyjhTcyHoxCT+xBsF2Ac4qad2J+AMF6gkqMkSBlxcad
	 4Hwmij6zioFCIONlj77dTt63f01TZs7BJwot9G/PahKH+8gCx08TwjUTTIMr2RkEhmboP
	 mqrPCiIai9lrne/6+XAdJAhvtTHRBwF4KzqnPudaNnHyo5f9HH4ErkGBUuer50KQ8omyc
	 /b3rAWMqHZ2mak1DOYVKmJbJfEFF1GFZ4Wx010zvWRTgHe7E0ayJnAUWlgSDV03I0Ir/V
	 uiLwIuRRiUTp0cirqK22/Hu82S1H0TnfbJnNEuQniG1TYon1c7gcle2cNQlHHBLL3Tg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8766E1F000C6;
	Mon, 16 Nov 2026 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794837046; bh=i7PvEL50DB4zsMyJWTI1yh5Wc4DVj1sntUbGWGamxxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RfVlJbGo6U1pnJDyytf9vl5iB3I9EwUmSMKQzhjNM2n2edBE+2ZECdAuFalEpJ1ho
	 W0q1zyjZdSp2p2Ry1Izg3rJVgbUyhMecy3+9dlVWCbA4paFY5BUypp+RIfvMAPZY3j
	 5scfZy8lsuQow8ZmpGWW/vElz7M+aBHk6S4+9uFk=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1E7954A4A3;
	Mon, 16 Nov 2026 13:50:44 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Mon, 16 Nov 2026 14:50:26 +0100
Subject: [PATCH v4 5/8] media: i2c: ov9282: add refresh of additional
 ranges on a mode change
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
Message-Id: <20261116-ov9282-fixes-v4-5-f78e5d415c6f@linux.dev>
References: <20261116-ov9282-fixes-v4-0-f78e5d415c6f@linux.dev>
In-Reply-To: <20261116-ov9282-fixes-v4-0-f78e5d415c6f@linux.dev>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Daniele Alessandrelli <daniele.alessandrelli@gmail.com>, 
 "Paul J. Murphy" <paul.j.murphy@intel.com>, 
 Martina Krasteva <martinax.krasteva@intel.com>, 
 Richard Leitner <richard.leitner@linux.dev>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, 
 Jacopo Mondi <jacopo@jmondi.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Gyula Kelemen <gyula.kelemen@advasolutions.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794837042; l=2624;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=19i3mXRY4OPZMcWqP5Atkb/EaIzksmT9Fb3ItOX1MCE=;
 b=W93NFu6Hl2s9eyQlET+Vf75MR+AIiVHWVxqtWuCTt1hghbav11ugdEfYKQuiNnfUdmN8E6mtn
 EDtDRBqfIlHDspsOdWCcA9fE6ajfoLaf02OPcn6QRC31SOhnK1qm10W
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=8hZNyyyQFqZ5ruVJsSGBSPIrmJpfDm5HwHU4QVOP1Pk=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20250225
 with auth_id=350

ov9282_update_controls() updates the pixel rate, hblank and vblank, but
currently misses the exposure range and flash_duration.

Refresh both, and commit cur_mode and code in ov9282_set_pad_format()
before the call so the refresh and any nested s_ctrl see the incoming
format.

Fixes: 14ea315bbeb75 ("media: i2c: Add ov9282 camera sensor driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/media/i2c/ov9282.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index df38ca6de4124..d13a1adc35e85 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -548,6 +548,7 @@ static int ov9282_update_controls(struct ov9282 *ov9282,
 {
 	u32 hblank_min;
 	s64 pixel_rate;
+	u32 lpfr;
 	int ret;
 
 	ret = __v4l2_ctrl_s_ctrl(ov9282->link_freq_ctrl, mode->link_freq_idx);
@@ -568,8 +569,20 @@ static int ov9282_update_controls(struct ov9282 *ov9282,
 	if (ret)
 		return ret;
 
-	return __v4l2_ctrl_modify_range(ov9282->vblank_ctrl, mode->vblank_min,
-					mode->vblank_max, 1, mode->vblank);
+	ret = __v4l2_ctrl_modify_range(ov9282->vblank_ctrl, mode->vblank_min,
+				       mode->vblank_max, 1, mode->vblank);
+	if (ret)
+		return ret;
+
+	lpfr = ov9282->vblank_ctrl->val + mode->height;
+	ret = __v4l2_ctrl_modify_range(ov9282->exp_ctrl, OV9282_EXPOSURE_MIN,
+				       lpfr - OV9282_EXPOSURE_OFFSET,
+				       OV9282_EXPOSURE_STEP,
+				       OV9282_EXPOSURE_DEFAULT);
+	if (ret)
+		return ret;
+
+	return ov9282_update_ctrl_flash_duration(ov9282);
 }
 
 /**
@@ -833,10 +846,23 @@ static int ov9282_set_pad_format(struct v4l2_subdev *sd,
 		framefmt = v4l2_subdev_state_get_format(sd_state, fmt->pad);
 		*framefmt = fmt->format;
 	} else {
+		const struct ov9282_mode *old_mode = ov9282->cur_mode;
+		u32 old_code = ov9282->code;
+
+		/*
+		 * Commit before refreshing the ranges. ov9282_update_controls()
+		 * and the nested ov9282_set_ctrl() calls it triggers derive the
+		 * frame length and the line time from cur_mode and code, so
+		 * they have to describe the incoming format, not the outgoing
+		 * one.
+		 */
+		ov9282->cur_mode = mode;
+		ov9282->code = code;
+
 		ret = ov9282_update_controls(ov9282, mode, fmt);
-		if (!ret) {
-			ov9282->cur_mode = mode;
-			ov9282->code = code;
+		if (ret) {
+			ov9282->cur_mode = old_mode;
+			ov9282->code = old_code;
 		}
 	}
 

-- 
2.53.0


