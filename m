Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3404014B2;
	Tue, 11 Aug 2026 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433449; cv=none; b=PunlZSKiLJa07GnJMDVmjmi8CwlEu199/ObemH/VSWoVSBWl8MnW7/ijCjkS9jn6/8fLP77sd0mclLaeQu0s9Fa01ehxifO+pon8GDafsg34R/KtMGE5x0YCh1WhwMX71a6iC4qpHQ5P4D8G3CmPj0e7SpeOMKdXfVr68nFabzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433449; c=relaxed/simple;
	bh=CZnncWzaQ4MFOAFjyT5OvShoUJaBRdoKFAPyTSx98Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uVrc/r1tjb88BUddX3s0mGpG1pbXCEZB4NHNUulSv0kSlFFP9cPngUk3sebcc1NRweKrWjE0KJ/suz4b+rhPuVaeuMDYObOT1247rHM+vBrpMB+hXM5bsPr5AEcUkCoseap6l6ZdeDoCbcJ2ZAJ4VCn3y0nKesC7Zc3hT8yKZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmtB1WYR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmtB1WYR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40827C2BCC7;
	Tue, 11 Aug 2026 07:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786433448;
	bh=CZnncWzaQ4MFOAFjyT5OvShoUJaBRdoKFAPyTSx98Lc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VmtB1WYR8gGy8Syr0a5qxvGfmD0aBP6ZUVWZrhpHw1K4Z3w+I++kp+6BDchHtvyjd
	 MsXvPHUzGMKXS3iy1WERBvd5ZJL+gR3uhUEQiD4U3bKujQcXA46nSz6ksFSD9Hd3s8
	 RvCqh413rRzsgO+y/XqU6Izhl2VLgUQGG44G+q6iAoij6OFXW6BbSj+FhDAXNuk+zu
	 Gv6QNtzp75kqJU0zBjimBwBJvNpCGJER5ioBw6DhUIE55Sx/v+7oHAas3AfzQjjgUf
	 cqABiEOkyb5JHAktB9b0rxPbf25Y6yDr6RlmziIxc6YRwMsomjlLv/WrA6C4HrMK7z
	 3ei/+0mKx9CAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0F9C5B574;
	Tue, 11 Aug 2026 07:30:48 +0000 (UTC)
From: Jason Yang via B4 Relay <devnull+jason98166.gmail.com@kernel.org>
Date: Tue, 11 Aug 2026 15:30:47 +0800
Subject: [PATCH v3] media: ov5640: select the MIPI lane mode from the
 endpoint lane count
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-ov5640-1lane-v1-v3-1-ae476eaf5024@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKbPemoC/4WNQQqDMBBFryKzbkommqhd9R6li6ijDqgpSQkt4
 t0bXXVTCrN5H96bFQJ5pgCXbAVPkQO7JUF+yqAd7TKQ4C4xKKmMrBCFi9oUUuBkFxIRRSN7yku
 yTdFVkKyHp55fR/F2TzxyeDr/Ph5E3NffrXQoytrUdaHLljC/DrPl6dy6GfZWVH98lXyjldSWK
 tNT8+1v2/YBCFWAou4AAAA=
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jason Yang <jason98166@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786433447; l=3864;
 i=jason98166@gmail.com; s=20260721; h=from:subject:message-id;
 bh=0SA/AIlg/Z0lKWih8DrLRCwQ6Z4t+cGPFTNQJ7jEZVU=;
 b=/fb6ShcyPccXfubnLXWYPth+Dnj+jIVTkja3O3UThssTjN0qnD4niIKZksM9POWYQ1LmQ00zv
 MSfJLL4CDwYBjOLssoV8xErfJOcBBJaPSuWZ+ClTcMb++dSFmqUHGtv
X-Developer-Key: i=jason98166@gmail.com; a=ed25519;
 pk=xQmD001Q/ooHl39PxyQtusbUQmgbOsSfpFryRVWZ/k4=
X-Endpoint-Received: by B4 Relay for jason98166@gmail.com/20260721 with
 auth_id=887
X-Original-From: Jason Yang <jason98166@gmail.com>
Reply-To: jason98166@gmail.com

From: Jason Yang <jason98166@gmail.com>

ov5640_set_stream_mipi() always programs IO_MIPI_CTRL00 with 0x45,
which selects the two data lane mode: the number of data lanes
described in the devicetree endpoint only feeds the sensor's clock
tree computations, so a module wired with one data lane starts
streaming in two lane mode and the receiver never assembles a
frame.

Take the lane mode from the endpoint instead. The field encodes
the lane count directly - 001 for one lane, 010 for two - per the
current sensor manual (version 2.33). The 2.03 manual documented
000/001 for one/two lanes; OmniVision corrected the table in
version 2.1, which is why the long-standing comment here found 001
unusable for two lanes and validated 010 instead.

The power-up path also programs a two data lane mode, but that
value is overwritten when streaming starts, so it is left alone.

Tested with a single data lane module on an i.MX8MP board
(imx-mipi-csis receiver), where the unpatched value produces no
frames at all, and on an RK3588 board.

Fixes: 19a81c1426c1 ("[media] add Omnivision OV5640 sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Yang <jason98166@gmail.com>
Assisted-by: Claude:claude-opus-5
---
Changes in v3:
- Inline the lane count in the write instead of going through a
  local variable (Sakari Ailus).
- Link to v2: https://lore.kernel.org/r/20260811-ov5640-1lane-v1-v2-1-65205ae86feb@gmail.com

Changes in v2:
- Compute the register value from the lane count in the single
  write instead of branching on it (Sakari Ailus), with the count
  in a local variable to stay within 80 columns; the programmed
  values are unchanged, 0x25 for one lane and 0x45 for two.
- Request a normal stable backport rather than opting out of
  AUTOSEL (Sakari Ailus).
- Drop the quotes around the function name in the reference from
  ov5640_set_power_mipi() (Sakari Ailus).
- Link to v1: https://lore.kernel.org/r/20260811-ov5640-1lane-v1-v1-1-79699457ce13@gmail.com
---
 drivers/media/i2c/ov5640.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 8deb5f5501fa..18c3bb5498f8 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1831,22 +1831,16 @@ static int ov5640_set_stream_mipi(struct ov5640_dev *sensor, bool on)
 	/*
 	 * Enable/disable the MIPI interface
 	 *
-	 * 0x300e = on ? 0x45 : 0x40
-	 *
-	 * FIXME: the sensor manual (version 2.03) reports
-	 * [7:5] = 000  : 1 data lane mode
-	 * [7:5] = 001  : 2 data lanes mode
-	 * But this settings do not work, while the following ones
-	 * have been validated for 2 data lanes mode.
-	 *
-	 * [7:5] = 010	: 2 data lanes mode
+	 * [7:5]	: data lane count, 001 for one lane and 010 for two,
+	 *		  per version 2.33 of the sensor manual
 	 * [4] = 0	: Power up MIPI HS Tx
 	 * [3] = 0	: Power up MIPI LS Rx
 	 * [2] = 1/0	: MIPI interface enable/disable
 	 * [1:0] = 01/00: FIXME: 'debug'
 	 */
 	ret = ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00,
-			       on ? 0x45 : 0x40);
+			       on ? 0x5 | sensor->ep.bus.mipi_csi2.num_data_lanes << 5 :
+			       0x40);
 	if (ret)
 		return ret;
 
@@ -2535,8 +2529,8 @@ static int ov5640_set_power_mipi(struct ov5640_dev *sensor, bool on)
 	 * Power up MIPI HS Tx and LS Rx; 2 data lanes mode
 	 *
 	 * 0x300e = 0x40
-	 * [7:5] = 010	: 2 data lanes mode (see FIXME note in
-	 *		  "ov5640_set_stream_mipi()")
+	 * [7:5] = 010	: 2 data lanes mode (see the note in
+	 *		  ov5640_set_stream_mipi())
 	 * [4] = 0	: Power up MIPI HS Tx
 	 * [3] = 0	: Power up MIPI LS Rx
 	 * [2] = 1	: MIPI interface enabled

---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260811-ov5640-1lane-v1-b0fe37eab4d8

Best regards,
-- 
Jason Yang <jason98166@gmail.com>


