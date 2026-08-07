Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F70477295
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117153; cv=none; b=NandMucxNXZchGJN9k08uAW3k/ui805BtW565jIk49wgSSEGxhZg6+Suy7iiaYxzynVCuyyjnt9s8VYNqAkVFCrIsMt/cXrSLy2TOspfgVQ4hjHNtI/Q/QFxUaaYGf+wjPRMwLEPd0o8p8pc0SZeN6fM4TDRXC+snlCnLj0UJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117153; c=relaxed/simple;
	bh=g99+9R86yENKOxMWC/+p9emmD/F2G0i/FdzRfr3/FAs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rCxnnrZCtl3MlU/gUlSQJDCBYfqzV5BQsDqKimuAXnaZQrVYzllgCAUk2UvQgVVU1alRTfL57K6na9IJT6SMUQA+TzY8L2g9urxMrcTXNIu1NaDKbHRrtQ9jktFZDI+utUDOvPRNndHRscTHR/9CcPSQIQZYzxXRu0mJev/H2L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea7pAlmX; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea7pAlmX"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4a40bcc8d69so2244341b6e.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786117149; x=1786721949; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VbFL1A0jNYqmUoipY6MPyQje52bmNUS3I6T9M1FZoRI=;
        b=Ea7pAlmXbsFbYg7rZqE8nx1ixNVYc/JMURnjhgNYqginGJ9DtdsZqJYxhal+oqde4/
         7KTH3j7zWZ6GwXXW4pcNP/HlZQ7VODNZMXpXMOqB/lTSW/EEVuNXzLrDV/oRv/vWD3cK
         5ck1+fgh6QSiZbhVL7qUmZ9vUePD0mrSP7wbFQHUuklMNRiJgoO9eges695RkUEwPsOF
         JPo4L9t9e1un1Zxh21exp41YAI8EQPFS5/+5kzvgS2QjHz2I5UebvNEeNCICirCe517l
         TD+tWDxrnGYVwWh9qhhdovq07Y1WZappgAMZc/3tgB6DBJFrCpGtLAmWjO84dr2XKWVS
         aUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117149; x=1786721949;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VbFL1A0jNYqmUoipY6MPyQje52bmNUS3I6T9M1FZoRI=;
        b=p7SQt6Eujz+K0w1rb0sKWw1cyZipH4NfEdvqr7RgGPjRsqIPzNKQlYUb6xQCTBe1JJ
         J2rs9GMUBLwkHd6kQ2Hk2I2lwGfBRmPLyHgQC8YP69LI2I7XlvKu3ySjtPfyO1fLvDjb
         76R8+63jOLBvxKHJkTnA/8j97c1KNOqdhl7nUUNbY85Wg604QWeG3m60uXrv6pGIW7GL
         RNybsCV7YLbTQYek6rGN4BqaO3VXfIEqiNqLVeJ+6z0VyPCPY8G8OTWdTyuDMunWBVcS
         gLy2aFZrKLfFVCuhntBriUHIh5icxemhJzCYu1o72HIY/27Fu77uJtyJ0BK3R9TdOVmL
         t0hg==
X-Forwarded-Encrypted: i=1; AHgh+RrNMoYP97enObLVDrBJ5txIKRt20qK5xMfY8F1uu9/VEZU1IK/Jonadgl93VhpP31Pfoh/2vNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPdTDNpUtoFhiicgvYeum5fcby1Aj8glCuLr3acBzZxKZd2MlV
	MJbimSloLXRG6bBZjNiTjXRjq+z2HwkmplJgim3CTnjhMtvXJ7vPKCRG
X-Gm-Gg: AR+sD13mEl5Gv9sNsc1GzOtAJ5tusuTqU/hJIK/zKAPZid48GwTsqVklMX1MFsDyu8P
	DLvJKjkmVyA0VR9JCjHhZATFbkXwgEDejJuLZt4ArKoFwXbTlIgbzzu6yZ4Y7SZIOs4Rr3+w1Zk
	huXA6zBKqJpsjeR5WmwZEyGFHwIQzBDmoMhnr1g4jlhzvzxqtZBWZ7FLDN8ejHOU+c5Cf9jB3mw
	RB2MyqSAIBHdFbHvJGJkOH+chuhgCwMMNdZ58QaOUHYM9oHA0XDi/Gg0iIKtoTwddbu+soZ4HK1
	BzCDFE08lxpZS/Tm7Rv84gkPfbUQYe8mjPIekLhl/r9w5sKQDVItG+1mzJDZcqLgQLjoRHewA/0
	B6OqkVk+8Ms9A8usLqBpadJrqLUKWLtwjUHTNCJ/GHAKYxPrGFbuSQd+q0Nnjzjgy/MItJaSrRc
	9jKyQftvCOQW6eLEamvS0q2cz3nFL+xzMs+vs0uaRjKMCzFx/du+SsuPrU5QF5ukMuHAu59+dqJ
	G/XYmlDVv0lVoS5NEB4KPeVQ6KXQ7KgKBRM1l3UuAnmufbyoiTfquExiIfu7Gd2evfs4uszPzUm
	qVRueykb2yG0i6llXPs21VAGxGAE0wy9u1ug0ZL3ZIHQF1MF+kPZzr/gyJKnMeTSvjv47QY8S+i
	/rBy3DEl6gofYdofG
X-Received: by 2002:a05:6808:1910:b0:495:f519:70f0 with SMTP id 5614622812f47-4afae01bf6emr13779508b6e.19.1786117149136;
        Fri, 07 Aug 2026 08:39:09 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae706cd5sm7353485b6e.11.2026.08.07.08.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:39:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v3 0/3] mtd: rawnand: sunxi: fix H6/H616 controller timings
Date: Fri, 07 Aug 2026 09:38:58 -0600
Message-Id: <20260807-submit-sunxi-nand-h6-h616-timings-v3-0-91287b543f41@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOQQqDMBBFryKz7pRkqgl21XsUF6mmOqWJJUnFI
 t690Z6gMPB58Hl/Fog2sI1wLhYIduLIo89wOhTQDsb3FrnLDCRICS01xvfNccrhZ0ZvfIeDyic
 VJnbs+4i6Lg3VdUlKd5A9r2DvPO8b1+bHWfKwbdrEW2PgmMbw2Z+YaOv9szcRCiSqKllJoVUpL
 r0z/Dy2o4NmXdcvhh8QOuQAAAA=
X-Change-ID: 20260717-submit-sunxi-nand-h6-h616-timings-794a2994267d
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Richard Genoud <richard.genoud@bootlin.com>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The sunxi NAND timing solver currently applies the original A10 NDFC
timing characteristics to every supported controller. The H6/H616 NDFC
uses two internal cycles for several setup and hold intervals and has
different delay-field encodings, so the resulting clock and timing
register values do not match the hardware.

Prepare for per-controller timing data in two behaviorally focused
patches, then add and select the H616 characteristics in the final fix.
Legacy controllers retain their existing setup-cycle behavior and delay
encodings.

Tested on an H616 board with Toshiba TC58NVG1S3H NAND.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split legacy timing setup from the H616 fix  (suggested by Miquel)
  - Move tADL/tWHR encodings to a separate patch  (suggested by Miquel)
  - Keep the timing lookup helper unchanged  (suggested by Miquel)
  - Drop the minimum-period helper  (suggested by Miquel)
  - Align H616 timing-data and capability names  (suggested by Miquel)
  - Add Cc: stable to all three patches  (suggested by Miquel)

Changes v2 -> v3:
  - Rebase onto current nand/next
  - Fix strict checkpatch diagnostics  (suggested by Miquel)
  - Add Fixes tags to the two stable preparatory patches
- Link to v2: https://patch.msgid.link/20260717-submit-sunxi-nand-h6-h616-timings-v2-0-225515107640@gmail.com

To: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
To: Vignesh Raghavendra <vigneshr@ti.com>
To: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

---
James Hilliard (3):
      mtd: rawnand: sunxi: group controller delay tables
      mtd: rawnand: sunxi: describe tADL and tWHR delays
      mtd: rawnand: sunxi: fix H6/H616 controller timings

 drivers/mtd/nand/raw/sunxi_nand.c | 119 +++++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 33 deletions(-)
---
base-commit: f97bdc8ec1dc7b33781a702eeba55326c206be56
change-id: 20260717-submit-sunxi-nand-h6-h616-timings-794a2994267d

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

