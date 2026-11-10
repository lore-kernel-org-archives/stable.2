Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794316223;
	b=qrPjieuJUDff3jXV461QXax1TOf/ulSKDyYSqNI3jPRBHzyCqlBUH7q0pyV/tbnQqOjU
	 XZi0toRN+TvGRmBtaZk+SsC493RsPtSidhb9jGGnaUpc9OcBzjb8X+wewMt88ZrwOqjPH
	 DO6O8HOorMlMR9b6sWcWaerUzZrCljVmn728EzhaO8l0bMTsayyUcFVPPPrgI5wdQQF5u
	 1dSoySQ3c6xHCAp0GTXAy6DrJ49v19dL0VhZ2z9QzqffLdmyDjYKh0p4mQvK7Ebg4yN+l
	 JYzuiImYerrsLkbs/sgTmS/cGcKVkbhbmAwDhDMhoxYhNkUsLiNvU9DtV4M2/f2YMSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316223;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=1r/a1h1am+Aib0DfCNKogn2RxPvlFMShjUY42jM3Gz0=;
	b=W1UromZVT8V6IJhJuwQA5w/ebgbTW83XMh9NlkBMQdKoxQhvGwwg4zOiIz9v+PSxP08S
	 qOV3KxsqB4B1fTP7ar74Xa1Q037eJtpQw/giuSGRjzdJhmKNq5yLhljc1zAJoSouMoTwV
	 a1tilBHYm3SBEeEDaLvOrKzv/0aJqd3Lj0EkY7ooQ5fsebt+RwVLQcMOQEN0qP7jOBupo
	 JjEFr0s7yKtcVRSjVxxjgFU1wKmAEG6Sdm/KFcqTtM7NZDsEuCfTHj28U+0ZeHHCVB1wZ
	 /b1BVo/gt4WNDJxlWMBQCTl6u/Wh/aGOola16oW62ufcsFNuDloaGitaumevKUeZ7MA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=vkOcC0yL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4193F606A761;
	Tue, 10 Nov 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=vkOcC0yL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794316223;
	b=VyEXpYhT4MWVUKaivdpc4Vpp0z9wYSaSBBdnRCKGnP6lDQtLeErlAS0sbIylc8M1l7NC
	 U17EOv44466qK327o7ojWgp01IoHs6ICnJPKY2mlBLl6iJsjFgKC4i3MrurSUOnpp/ZvI
	 m33CLoTqJ4qqP4SYl7JboUXslDpagVlIKKBORqMPMh1swX4UVmm+iom4Vv1CBufT3+L1y
	 VN5Y8hRFlpqvdCJLLybR/mPSFz1eAsrdAp6yaySe7AkTrpYX8YkQRGbD38G1s+JyZsttN
	 o24cbRYVHt3Ifd7E90n8MCPvNdVodvB2Y9nqb8O71qrjQnU5BRrv8Di/gGMPLdD1Cng==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316223;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=1r/a1h1am+Aib0DfCNKogn2RxPvlFMShjUY42jM3Gz0=;
	b=jVnT6IgKwM69idTWQggGqz8C72lBS1rZKIKEansZ95TGj/CDN8wpW/zWvMyAEEcwlb44
	 iBemIuSdIpjejVdBJ1SamLm0ytx+C1YvSWN3Y+RFse1tF3cJxmcyegvKhBC64I1ODIZVi
	 4be2ZSoEEYuzlBrVcj7wXUd90kORLm/WppB5R9mprhJQ7B89qunTz1QtpabBH4zOnp1L9
	 e0hW2mqoOBOJOitYJywP5RmTzngO9rser1LBzCdaE9uDcjqjxyJhsd9m2hDnbcFOjJijC
	 6sBvtMWZaScfXYkKHb/b7zQmcNJJ0hxIQEG7Xm1nzO9me/V+TNJzY7fEGojvxqEkMRQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5FCA11F008A1;
	Tue, 10 Nov 2026 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794316223; bh=1r/a1h1am+Aib0DfCNKogn2RxPvlFMShjUY42jM3Gz0=;
	h=From:Subject:Date:To:Cc;
	b=vkOcC0yLfjjOVOY/BNuU7H04NBBkSge9LFkGQLc8ZtenOOO6wlaCxhCrjjS2FjnLj
	 oDDemOe62Dz+KtDpyzcfvCfvpbBnyFoMCWjFOE6YZga+HwESnLJCEM5dz2wT/X4AVg
	 73Z61AhpcHpGFQzf9A1vaNXq3Rsu1D4SofzMDsLg=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CF2FF48B66;
	Tue, 10 Nov 2026 13:10:20 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Subject: [PATCH v3 0/8] media: i2c: ov9282: fix strobe timing and control
 handling
Date: Tue, 10 Nov 2026 14:10:09 +0100
Message-Id: <20261110-ov9282-fixes-v3-0-cb6df80cbc22@linux.dev>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ7CIBBFr9KwFgODrcWV9zAuoAwWY1oDLalpe
 nehGqNx+TL/vZlJQO8wkEMxE4/RBdd3CcSmIE2rugtSZxITYFAxySTto4QaqHUTBmqUrCujdAO
 iJkm5e1wPyTidXxxGfcVmyI28aF0Yev9Y/0Wed+803/2mI6eM2hKYsqU0luvjzXXjtDUYSU5H+
 Mic/cmQZKG12Fem1lzJb3lZliexsXmD9wAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794316220; l=3822;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=+e5OdsGJqLLD8RjhIkfi2sD+B0gtjHN2GH3eK5G8NuU=;
 b=EZomxBc0VN1D4myCyqFdKxU5EedMoJuBgaxKUFFqM+rldOug6TP0yYA9yO8vA2eKnF+uNdp7f
 ZHymsBHwAIxBe7oMgla5VB592Y8n6p+DespbFSAEzxbAvOgXGtfbTF+
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
Changes in v3:
- Adapt commit texts for 4/8 and 5/8
- Thanks to Dave the review!
- Link to v2: https://patch.msgid.link/20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev

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
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20260909-ov9282-fixes-da986dabc238

Best regards,
--  
Richard Leitner <richard.leitner@linux.dev>


