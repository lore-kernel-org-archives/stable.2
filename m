Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1E4734FC;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960589; cv=none; b=Lhy8vTgs8xiAhe15GLc6EVv9AU+71Pf+96X6cmvaNkcFwUXNgLEhQRw3yLYVJ0Q51f6MTuynoiSBDyYNvfqi/mV2wFmHN7J7c3m9p/CRj3FeQfIJFJxzdH2jimeDUUbkK9Yl4xROMDg3vNsvgj16L0knZSmi2CWpKdfCP7ZKcrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960589; c=relaxed/simple;
	bh=/8aCB8InGPf7oWbj3PBJDIqHWuBXL5wzuxlJ0asuDZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5WInI1KII8MgKljh4e9UXP6NcUTAchE6Vl5syxU/U3KOgLTFKAkejU6ay+y3uNoy/AnaSHq07cLGe4qhedgmHMWPXbIixVPmWfBnADgY8dmozCXtBqP8DFI1pxFh8jVBtE8zHt1PxTX8Rvd39gqhKpcJUwlStxLehTtvZ8hIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G/Czbiba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G/Czbiba"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86BF3C2BCFC;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1791960588; bh=/8aCB8InGPf7oWbj3PBJDIqHWuBXL5wzuxlJ0asuDZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G/CzbibayyvNTi7qR5Dwa/Qa8BxD9d6Bga2jGC06GY8yYVBwZE1XKg0rcSOAvK9ZV
	 M61jCLMoUwYBEeHsi2sDXzipdtJZ5p9Ure4EruaEESBoNKeJHWdJsfQQWfX5eTyNQB
	 6rARatWmsmAN+MBcxlYWE0NB84UhGejfiOJmG3zU=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AE0CC6B24;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Wed, 14 Oct 2026 08:49:13 +0200
Subject: [PATCH v2 6/8] media: i2c: ov9282: recalculate strobe span on
 HBLANK change
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ov9282-fixes-v2-6-3bb376d8b1a9@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791960586; l=2043;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=/8aCB8InGPf7oWbj3PBJDIqHWuBXL5wzuxlJ0asuDZs=;
 b=JJINLnGzvY7c8vlM95QwHgeq1N+deUVyntB15s6yJykmSD+DO2eIsBYrLVMsOAYAQMRMlKEUp
 rtiRnCqUkYRCg/MYnTtKekOjRl+bjdh5wxp/4tewcS1KtlTY3pdmM2l
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=8hZNyyyQFqZ5ruVJsSGBSPIrmJpfDm5HwHU4QVOP1Pk=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20250225
 with auth_id=350

When HBLANK changes the line time changes. This means the time base for
the strobe duration calculation changed. This results in the v4l2
strobe_duration control value and the strobe_span register value being
out of sync.

Fix this by recalculating the strobe_span register value on HBLANK
writes using the currently configured strobe_duration. This results in
the strobe_duration configured by userspace being kept, but the
underlying register value being changed. To ensure the values are
applied on the same frame guard the writes with OV9282_REG_HOLD.

Fixes: 84ec7597ae1af ("media: i2c: ov9282: add strobe_duration v4l2 control")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/media/i2c/ov9282.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index b48c959b9c908..5114fbf28a26c 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -625,6 +625,7 @@ static int ov9282_set_ctrl(struct v4l2_ctrl *ctrl)
 	u32 exposure;
 	u32 lpfr;
 	int ret;
+	int ret_hold;
 
 	switch (ctrl->id) {
 	case V4L2_CID_VBLANK:
@@ -677,8 +678,14 @@ static int ov9282_set_ctrl(struct v4l2_ctrl *ctrl)
 				      OV9282_FLIP_BIT, ctrl->val ? OV9282_FLIP_BIT : 0, NULL);
 		break;
 	case V4L2_CID_HBLANK:
-		ret = cci_write(ov9282->regmap, OV9282_REG_TIMING_HTS,
-				(ctrl->val + ov9282->cur_mode->width) >> 1, NULL);
+		ret = cci_write(ov9282->regmap, OV9282_REG_HOLD, 0x01, NULL);
+		cci_write(ov9282->regmap, OV9282_REG_TIMING_HTS,
+			  (ctrl->val + ov9282->cur_mode->width) >> 1, &ret);
+		cci_write(ov9282->regmap, OV9282_REG_STROBE_FRAME_SPAN,
+			  ov9282_us_to_lines(ov9282, ov9282->flash_duration->cur.val),
+			  &ret);
+		ret_hold = cci_write(ov9282->regmap, OV9282_REG_HOLD, 0, NULL);
+		ret = ret ? ret : ret_hold;
 		break;
 	case V4L2_CID_FLASH_STROBE_OE:
 		ret = cci_update_bits(ov9282->regmap, OV9282_REG_OUTPUT_ENABLE6,

-- 
2.53.0


