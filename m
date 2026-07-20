Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359131AF1B;
	Mon, 20 Jul 2026 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572268; cv=none; b=WWOdncHwdgQfiDxdgjiVCqpS1Xsvqe1safNs3XsAi6s+OG9xMsfeIF7657DIcbAiD/UCJRmpA4DD5mjng84nMcx84mKBlFZEpJ0WycmRDHSpgthmTN2OMTo6dA5r2WaxV5Z5FiYwNCOQjDhsoZQgB2gXhbyWcWsfDs/oB1P+2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572268; c=relaxed/simple;
	bh=TF1Va7Kvd78gB/+nDw6b3xVkllExwoPZb7OdeLW7OqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RgvsDflODCICTAvuV7uy53tVpGIaXBfnSUmqMJTguTF0m0JNtgelxyb4bsFIDqF5m0FUZ+mLEvZ5uLkiuO6lYW+AB9PK6rdMMjazG88OOTZw4xsUU4GTXZBCnr6japrCnE6scDuu3Q7cFwVW6UEALf4RQ/HxyjxFH6vJpknwM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T35RMJx2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T35RMJx2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2521BC2BCB8;
	Mon, 20 Jul 2026 18:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1784572268; bh=TF1Va7Kvd78gB/+nDw6b3xVkllExwoPZb7OdeLW7OqU=;
	h=From:Date:Subject:To:Cc:From;
	b=T35RMJx2s95t1w01oNw8Mpn7xxr+HduAGfVGsojWeywFSxVcCxSKnBG+Yk7t/zvqa
	 UxDVRazX2iVqJZuZJjum61UsTyTP1CRKmHf59JM71YQXrE2mh+DyBbqDT9cSldbEyZ
	 4a/hFBP7rixIlhmx25CEPYS3H1bFw38p2Y2Y7fZE=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA974C44515;
	Mon, 20 Jul 2026 18:31:07 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Mon, 20 Jul 2026 20:31:00 +0200
Subject: [PATCH] media: i2c: ov9282: restore flash duration calculation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-ov9282-fix-v1-1-0145062ec9f1@linux.dev>
X-B4-Tracking: v=1; b=H4sIAGNpXmoC/yXMQQ5AMBCF4as0s9aknQjlKmJBDcYCaWkkjbsrl
 t9L3h/Bk2PyUIsIjgJ73tYEnQmwc7dOJHlIBlRYqBKV3EKFBuXIlyRLRa4HW3bGQDrsjtL8xZr
 2tz/7hezxFuC+H7SMldVuAAAA
X-Change-ID: 20260720-ov9282-fix-ece641dc7a88
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tarang Raval <tarang.raval@siliconsignals.io>, 
 Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Richard Leitner <richard.leitner@linux.dev>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784572267; l=1494;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=TF1Va7Kvd78gB/+nDw6b3xVkllExwoPZb7OdeLW7OqU=;
 b=tC0eEjcpW4RTuCluO4nHRi8JlMSZv3R8zhKpzfRiYD3RhCTPTAA+NABjr6oFhGRNtFhGs1VtH
 MqF77ZkKbBpBNTPtQppVIPuPBiYFuoXSgQ4SEgLCQM1gJwv0k7w5Qb9
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=8hZNyyyQFqZ5ruVJsSGBSPIrmJpfDm5HwHU4QVOP1Pk=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20250225
 with auth_id=350

The migration to CCI helpers made V4L2_CID_FLASH_DURATION write the
requested duration directly to OV9282_REG_STROBE_FRAME_SPAN, dropping
the conversion from microseconds to the register value.

This made flash strobes too long and produced overly bright frames.
Restore the missing calculation so flash duration is programmed
correctly again.

Fixes: 273f52f3cbec ("media: i2c: ov9282: Convert to CCI register access helpers")
Cc: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: stable@vger.kernel.org
Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/media/i2c/ov9282.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index 5b6f897a74fcd..5abe51d21f89c 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -648,7 +648,8 @@ static int ov9282_set_ctrl(struct v4l2_ctrl *ctrl)
 				      ctrl->val ? OV9282_OUTPUT_ENABLE6_STROBE : 0, NULL);
 		break;
 	case V4L2_CID_FLASH_DURATION:
-		ret = cci_write(ov9282->regmap, OV9282_REG_STROBE_FRAME_SPAN, ctrl->val, NULL);
+		ret = cci_write(ov9282->regmap, OV9282_REG_STROBE_FRAME_SPAN,
+				ov9282_us_to_flash_duration(ov9282, ctrl->val), NULL);
 		break;
 	default:
 		dev_err(ov9282->dev, "Invalid control %d", ctrl->id);

---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260720-ov9282-fix-ece641dc7a88

Best regards,
--  
Richard Leitner <richard.leitner@linux.dev>


