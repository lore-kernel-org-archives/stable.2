Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0380B43C7DF
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115852; cv=none; b=Z542gp6Yw/EdjkjXK8LgVPWWaFFjtLC+vaKhMKvV4MhyUB8PVfEhpIiIHDwZG8NubqfuOIEK+OGBEFGC2Y+pSYMIZJMK2FdBEzL0NAWcd7j7WidsjCK/6NDgLPFJ7+xhxxGoB+RDpK5NCWiDGCllm9RM6Gtd98lU1wokvd85vKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115852; c=relaxed/simple;
	bh=fMzfDJMKQUZ03KS16inXaqdjVjmByxXsgM2IAEum4ps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ffwW6926s9JR+HvpEIXvejo0FEzs+/15xjXwSzlNMANwvmwo5tYAqSkbery/rEPreN0TVLlKpZGRS5zfk4cVMwJkFpudIxcUTALDQcod07sL4sc6wLh3d3ihC1RFuyoGLHO78A5R9SOZ73ksLQAQP2ZwWhTd5XNPNg5cNPeZgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Oc/Q8lS2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Oc/Q8lS2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493f6de72faso11026555e9.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 04:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1784115848; x=1784720648; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t9uTLI4PNn7Iu3pBhUskUo84883YLgKy0z27USpVPmo=;
        b=Oc/Q8lS2xXFaLx2JwKJAc9ZNK4NgrN2JjJUzcuHCgBoisZpbQsZdV+LcqJy+qz/5EF
         afxFKKWaQNjALmRPu1e4pCWdB0nvlibbSYs58zXdLPFAPCGVF9nFbz4yI6vlHN7OdOR4
         rciv0PUx585ibd1YW3dnxqn9QMesNdpQ7xYey0TsGwpIm71Ozfc6s5IXGT/Q6nBLKd1+
         ZGMS+cA76lXIrEqUDLl2m+fEQRud0p0by8nyv/z8ZWI4hcauJCJJ2t8w6Cy5oyrcXFrr
         aDHeVrcwwU6BC8nbWREVQpNBED2+G1M/S3W7u/NKDOe1Es5VWwHwKINVKqYJU/zpfxB2
         mP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784115848; x=1784720648;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t9uTLI4PNn7Iu3pBhUskUo84883YLgKy0z27USpVPmo=;
        b=Cweq2TUE1aeUtlOK+PIoUwpoP2yMgh9I1Irt6UxW/DzkYFOJ2dJHjfziB2OmOeFEHg
         D4VE3Tbbfzraf39m2AqJHodvJ7bXnnqGP+AXM0r0oLzsCXge8joWYkh+tKv74slyD10i
         JJony8c8OXGi27khcDNkyZ+FtNMDwuvFFxZGyfO3+XgtYgkRl1v5iNu9HSCrwn9+yfty
         GojFESp5rkRuZOrFRsS26tzSvPyoDnQb328Zubk6R6kIpmGuWjAMnBq8i4qpXyD60xJF
         NEhxnW95t6Roe7NZftfokqtvWzn4UQKCB/qo0ETULLQPFCc8yaZ44W9PdEqIJRIrUktl
         A7+A==
X-Forwarded-Encrypted: i=1; AHgh+RrsfCBjFHIQInzTyNA+ZG+bVtUPql9A6sm5jjtFcQR4wSw15lCmYGTbX6sILLXA8fWCSbIl2FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXC8oC5oWenFk0rT2p8+2oz+puOwOy6nf/JAn38b8vf715IBLe
	AD8cjKJ0DIeNZkOzTUXEHNQsAODutb3Y+wxigRBXdxj1zoFC/PlH6YLeuapFmNwlvhw=
X-Gm-Gg: AfdE7cl5jKbO8lAT264EV1+1LxOURvKpqyRh/FRoL0aVMOzFELmV/WL+aC9HRVl8eiA
	/aQDJJ0vUI/3sbVuT5TIpujpMMX5RlemJYT3H70fU7QB3sHECIhTtefjWe9QFrxobHpldEjptyX
	vROKUzIzwx7ZVoLJc+dLoCYEwt4gpKmu2O+1r849u3ZkC0d0BZwb0CpoSHEV4JazU52fBUR1XgC
	j4n9jhQKpJk5wNXWAyH2zJ+TWh7UM46MAQHX0VTDefh+NeZ3KcsRSzltRD3HvAWNExU6ZD/u77e
	dVh56YKBR22bjOEc0k2YFk3dEIG3ppeRuTzyjzhvPh/h6gi9XMusOK1vH4pMSEV0qZBH89w58q0
	ZuY8VGfCa9A0OQfj5XL+kvdJO2vwruwr9RdVuk9GB8Bislp1tMW/hR/U8JCyrSpEVYIx2I8EB03
	QcV5VPNUbe+unmfoKREDHbhxBlN5ZPTmgYvzZucKdD22knDB22lk4hLUwncdA4JI7U
X-Received: by 2002:a05:600c:2244:b0:493:e543:1dd9 with SMTP id 5b1f17b1804b1-493f2ab7772mr176681565e9.9.1784115848112;
        Wed, 15 Jul 2026 04:44:08 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f4829896asm14005425f8f.23.2026.07.15.04.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 04:44:07 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH v4 00/21] media/imx355: General code cleanups, and adding
 support for 2 lane operation
Date: Wed, 15 Jul 2026 12:43:13 +0100
Message-Id: <20260715-media-imx355-v4-0-f7f966fb9ffd@raspberrypi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFJyV2oC/23OQW7DIBAF0KtYrEs1MAzYWfUeVRdgxg0Lxy64V
 qLIdy91Fq0iL/+X5s2/i8I5cRGn5i4yr6mk6VKDeWlEf/aXT5Yp1iw0aAsEVo4ck5dpvCKR9Ag
 DBcbI0Yt6Mmce0nXn3j8eOfPXd1WXRymCLyz7aRzTcmo0mcF0Fg2zst6hUs5E7RlN6AlCpMEQ1
 1r8WudUlinf9qWr2rHjUauSIK0F2xIgGKK37MscOOfbnF7r751b9R/hwD0RuhLKtsg9uNB27pj
 A/0T7RGAlujhga73VGA+Ibdt+AMPZ1YuAAQAA
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Acayan <mailingradian@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, devicetree@vger.kernel.org, 
 stable@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.1

This series came about as we had a customer ask about using imx355,
so I had a look at what was going on.

There was significant duplication between the various mode register lists,
unused parameters around, and no support for advertising the crop
rectangles through get_selection. It also wasn't using V4L2_CCI so
had all the boilerplate for writing registers.
The customer also wanted to run the sensor over only 2 CSI2 data lanes
which required some rework of the clock setup so that the MIPI link
frequency could be run at 445MHz instead of the 360MHz used for 4 lane
mode.

V2 has some fairly substantial differences to V1 as I obtained a datasheet.
Whilst some things worked perfectly, the datasheet declared them as
prohibited. This was largely using dual PLL mode in 2 lane mode, and
LLP is restricted to specific values. Link frequencies are therefore now
derived from the PLL configuration, and pixel rate is computed from that.

Being able to refer against the datasheet, I've pulled an updated version
of David Heidelberg's patch for 24MHz clock support into this series.

I've tried to keep it that the earlier patches are largely cleanups or
minor improvements, and then we get adding 2 lane support, and converting
to using subdev state as they are larger patches.

---
Changes in v4:
- Added patch to avoid regulator/clock imbalance. Also means autosuspend is enabled
  before first _idle call in _probe. (Sakari and Sashiko)
- Lock state through the whole of imx355_set_stream so mutex is held in calling
  __v4l2_ctrl_grab (Sashiko)
- Fixed leak of media entity pads if v4l2_subdev_init_finalize failed (Sashiko)
- Sashiko flagged a pre-existing issue that pm_runtime_get_if_in_use returns
  -EINVAL if disabled, but imx355_set_ctrl (in common with ALL other sensor
  drivers) checks !pm_runtime_get_if_in_use. Not addressed here as it appears to
  be a widespread issue, and has more significant implications (have to assume
  the sensor IS powered, but then not call pm_runtime_put), and this isn't going
  to be the only place that needs consideration.
- Fixed build break in the middle of the set.
- Link to v3: https://lore.kernel.org/r/20260708-media-imx355-v3-0-9df386a623d7@raspberrypi.com

Changes in v3:
- Fixed a number of issues picked up by sashiko-bot
  - Unintentionally dropped writing reg 0x030b, which is at the default value anyway.
  - Swapped len and val in intermediate patches adding imx355_write_reg before converting
    to cci_write
  - Initialise colorspace in _open for try_fmt.
  - IMX355_REG_TEST_PATTERN is a 16 bit register, but was defined as 8 bit.
  - Call pm_runtime_dont_use_autosuspend on remove / probe error
  - Missed subdev_lock in set_stream.
  - Not addressed the pre-existing issues of double power_off in _probe error path, nor
    potential for VBLANK update on mode change not calling s_ctrl if the new value happens
    to be the same and therefore exposure range being incorrect. I'll look at them as
    separate fixes.
- Variable definition for format and state in imx355_set_ctrl got pushed into the wrong patch 
- Collected Krzysztof's R-b tag for the binding patch.
- Link to v2: https://lore.kernel.org/r/20260707-media-imx355-v2-0-1683ec07b897@raspberrypi.com

Changes in v2:
- Collected Jacopo's R-b tags and implement his review comments.
- Add patches to switch to using the subdev state, clean up colorspace
  (sets RAW), use a define for the exposure offset.
- Added DT binding update to permit 2 CSI2 data lanes.
- Link to v1: https://lore.kernel.org/r/20260506-media-imx355-v1-0-660685030455@raspberrypi.com

---
Dave Stevenson (20):
      media: imx355: Avoid calling imx355_power_off twice in error path
      dt-bindings: media: imx355: Allow 2 CSI2 data lane output
      media: imx355: Remove duplicated registers from the mode tables
      media: imx355: Remove setting FRM_LENGTH_LINES in the mode regs
      media: imx355: Programmatically set the crop parameters for each mode
      media: imx355: Set register LINE_LENGTH_PCK programmatically
      media: imx355: Set binning mode registers programmatically
      media: imx355: Remove link_freq_index from each mode as ununsed
      media: imx355: pixel_rate never changes, so don't recompute
      media: imx355: Remove redundant fll_min, and implement fixed offset
      media: imx355: Add support for get_selection
      media: imx355: Use pm_runtime autosuspend_delay
      media: imx355: Convert to new CCI register access helpers
      media: imx355: Set the colorspace in the format
      media: imx355: Define the exposure offset, and use that define
      media: imx355: Use NULL ctrl_ops for HBLANK as it is a read-only control
      media: imx355: Compute link frequency from PLL setup
      media: imx355: Support 2 lane readout
      media: imx355: Switch to using the subdev state
      media: imx355: Remove storing cur_mode in the state

David Heidelberg (1):
      media: i2c: imx355: Add support for 24 MHz external clock

 .../devicetree/bindings/media/i2c/sony,imx355.yaml |   11 +-
 drivers/media/i2c/Kconfig                          |    1 +
 drivers/media/i2c/imx355.c                         | 1522 +++++++-------------
 3 files changed, 503 insertions(+), 1031 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260506-media-imx355-a30f5be3deda

Best regards,
-- 
Dave Stevenson <dave.stevenson@raspberrypi.com>

