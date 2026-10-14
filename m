Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC56448BB7;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960588; cv=none; b=Ay2jiJ6B+Fns1tF7b4baGaYfiQDU5SYPOJZBh/oq84WIVIeoMsuby9OGtnVpVVcThurC3gK6DzyNJX4VYMX3TU6lRMD652hhxyVq1lK+2U9Uz1F7RHq1WM8UGjos6ijCtWGWUOBBN3IK1wBWPSCAGeW5mH4Gwdccve7y1twxGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960588; c=relaxed/simple;
	bh=fPoVaBChIFHd+yHZ4HnyWeijFq2EFmam/UDpQxJIVkc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OMl90UIeVdocjjAKK1qHyeeexBjB93zLRhuncZlzXbHxXtdmQAJvUoFR+lcx6DD5F8lO4R34F1032HFXRYNinOmFO6M8oPaWmeOIR+EMbGFEBXvpwaHudC4Dvq5jt9vkdad44nSTb/Lr/TjLlUTc2Z9kvnboHhHN2eOXFY/vsJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=apUVhXI4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="apUVhXI4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D9B4C2BCF7;
	Wed, 14 Oct 2026 06:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1791960588; bh=fPoVaBChIFHd+yHZ4HnyWeijFq2EFmam/UDpQxJIVkc=;
	h=From:Subject:Date:To:Cc:From;
	b=apUVhXI4lIyTHXhqAgOEXWGgr+LRNmsxDRr5bytGSjEkjbypcZyV9NzJVuTzHrVjf
	 /689eUU/IXWoPbSvpzNoHF7I0cdt5liGPYd5wb7WlWYgOoXSEXqfy1vktQA7qXSuN0
	 MHoBfcBiG2N93bALiv+xU3Za9S7EXjl9vVsaezK8=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC23CC6B20;
	Wed, 14 Oct 2026 06:49:47 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Subject: [PATCH v2 0/8] media: i2c: ov9282: fix strobe timing and control
 handling
Date: Wed, 14 Oct 2026 08:49:07 +0200
Message-Id: <20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNwQ6CMBBEf4Xs2Zp2FUI9+R+GQ2m3ssaAaaHBE
 P7dgl48vszMmwUiBaYIl2KBQIkjD30GPBRgO9PfSbDLDCixklpqMSSNNQrPM0XhjK4rZ1qLpxr
 y5BVoD/Li1nw5Tu2D7Lg5tkbHcRzCe/9Lauv91Or8r05KSOFLlMaX2nnVXp/cT/PRUYJmXdcP6
 DYXJ7oAAAA=
X-Change-ID: 20260909-ov9282-fixes-da986dabc238
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791960586; l=3646;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=fPoVaBChIFHd+yHZ4HnyWeijFq2EFmam/UDpQxJIVkc=;
 b=7ZCjtz7ib4MZq7iON48g/9AhjNMFoJZJAYWE66GPm3YLbt8H1IhKKWt41XSyGKRaMvpeXQZ4j
 0aLnNHtdlQXA8OwJrLLNhyqkZd/uhjL9+tVJEGxFax3I/mwWtVB3Hsq
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=8hZNyyyQFqZ5ruVJsSGBSPIrmJpfDm5HwHU4QVOP1Pk=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20250225
 with auth_id=350

This series fixes a set of related issues in the OV9282 strobe timing
and control handling code.

The driver updated exposure- and flash duration-related control ranges
in several places, but some of those updates used an incorrect timebase
or were triggered too late, which could leave the controls clamped
against stale values.

The series:
- checks the return value of the exposure range update
- drops the redundant vblank field
- converts probe error messages to dev_err_probe()
- fixes the 8-bit pixel rate (192 MHz instead of 200 MHz) and the
  corresponding line time calculation
- treats the strobe frame span as a line count and converts the flash
  duration accordingly
- fixes the flash duration range (min/max/default) and refreshes it on
  HBLANK changes, independent of the sensor power state
- refreshes the exposure and flash duration ranges on mode changes
- reprograms the strobe span when HBLANK changes

This series was tested with an ov9282 sensor on a vision components camera
module attached to an i.MX8MP mainboard in a defined (dark) environment
with a custom made LED flash pcb.

Any feedback is warmly welcome.

Thanks!

---
Changes in v2:
- New patch: fix the 8-bit pixel rate.
- New patch: re-write strobe span and HTS in s_ctrl when HBLANK changes
- Calculate line time in ns using 64-bit math instead of 32-bit µs
- Treat the strobe frame span as a line count and reuse the helpers of the
  exposure -> drop OV9282_STROBE_SPAN_FACTOR
- Flash duration range: min is 1 line, max is S32_MAX instead of the
  current exposure time, default is converted from the register default
- Refresh the flash duration range on HBLANK changes instead of on
  exposure/gain writes, so it is also correct while the sensor is idle
- Add missing "\n" to dev_err_probe() messages
- Add Fixes: and Cc: stable tags where applicable
- Reorder patches to keep non-fixes at the end
- Reword commit messages and subjects
- Thanks to Dave, Bryan and Sakari for the review!
- Link to v1: https://patch.msgid.link/20260914-ov9282-fixes-v1-0-f520af59df1b@linux.dev

To: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Daniele Alessandrelli <daniele.alessandrelli@gmail.com>
To: Paul J. Murphy <paul.j.murphy@intel.com>
To: Martina Krasteva <martinax.krasteva@intel.com>
To: Richard Leitner <richard.leitner@linux.dev>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
To: Bryan O'Donoghue <bod@kernel.org>
To: Jacopo Mondi <jacopo@jmondi.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Gyula Kelemen <gyula.kelemen@advasolutions.com>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Richard Leitner (8):
      media: i2c: ov9282: handle error from exposure range update
      media: i2c: ov9282: fix pixel rate and line time calculation
      media: i2c: ov9282: fix flash duration to/from microseconds conversion
      media: i2c: ov9282: fix flash duration range calculation
      media: i2c: ov9282: add refresh of additional ranges on a mode change
      media: i2c: ov9282: recalculate strobe span on HBLANK change
      media: i2c: ov9282: drop redundant vblank field
      media: i2c: ov9282: harmonize dev_err_probe usage

 drivers/media/i2c/ov9282.c | 236 +++++++++++++++++++++++++++------------------
 1 file changed, 144 insertions(+), 92 deletions(-)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20260909-ov9282-fixes-da986dabc238

Best regards,
--  
Richard Leitner <richard.leitner@linux.dev>


