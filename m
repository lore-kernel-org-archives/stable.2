Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF254611CC;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960588; cv=none; b=XDlKJpjT0efHyWAfvXCU7eSuLCe/lTDS2a76SHl9wusmWXi6tSmWX4574SD0ODQ8CKtlPu/aViUY85sksa+V//eUpsN6oi/rH6FMjOFXiTZYtk5B2kLjWWxgCzB2Fw6Gy9gLl+ipP/KLL67RwHNDilkKyp8yTBQXszP+hFqLG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960588; c=relaxed/simple;
	bh=RaqTqtfe3/XJITKAlRg0Aa8tUIhzoGo6oQeT0YiRJXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIGvE2c75ovazpQD8BSbNlnVIK308yZUx69/M4UJQr3XfMLECGOqcAH+ub0Bf5iCRBEibfY42TVMMY57uB6yZPTaKNMobML8dB6fY87e1xLe0NLegbkRfmqZuBa7SHu4PlmneOOdNDG/S6+zk9zHBnwdaHnEQaSb+1EhGHB5mJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qNubBpkY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qNubBpkY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DED7C2BD01;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1791960588; bh=RaqTqtfe3/XJITKAlRg0Aa8tUIhzoGo6oQeT0YiRJXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qNubBpkYr2NhvPA33XWXUPm5bvUhnrGdNxrKYDIt3T4ZTuXgehA7cyf+8WQXcF0Rq
	 7RUxC0eW3jBJTX2+4SWHXSH4+TUXdQFY0G8u6aTolLemiqub2IQs3zN5c3AW4ZF3cE
	 zVDf3yKVhnyQO5xAZ+G8YVbRyD/yjt92z8F6xmVA=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C358CC6B28;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Wed, 14 Oct 2026 08:49:12 +0200
Subject: [PATCH v2 5/8] media: i2c: ov9282: add refresh of additional
 ranges on a mode change
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ov9282-fixes-v2-5-3bb376d8b1a9@linux.dev>
References: <20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev>
In-Reply-To: <20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791960586; l=2625;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=RaqTqtfe3/XJITKAlRg0Aa8tUIhzoGo6oQeT0YiRJXs=;
 b=ta/NUN9m4LWJ+IbPsV5lCkgdqkKgGTpskdbzmgirRnxSmqjZ0Cdw/iy+/tW+nJmqt+t3R6xbH
 EYBgJlhQjSiD81S1g8pZVTvmlXAy3CVpdqKCf4CYS4TAkDtoJ+tyMGW
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=8hZNyyyQFqZ5ruVJsSGBSPIrmJpfDm5HwHU4QVOP1Pk=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20250225
 with auth_id=350

ov9282_update_controls() updates the pixel rate, hblank and vblank, but
currently misses the exposure range and flash_duration, which are
dependent on the frame height and therefore vblank.

Refresh both, and commit cur_mode and code in ov9282_set_pad_format()
before the call so the refresh and any nested s_ctrl see the incoming
format.

Fixes: 14ea315bbeb75 ("media: i2c: Add ov9282 camera sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/media/i2c/ov9282.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index e6920e18b7818..b48c959b9c908 100644
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
@@ -832,10 +845,23 @@ static int ov9282_set_pad_format(struct v4l2_subdev *sd,
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


