Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618445517C;
	Wed, 29 Jul 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339741; cv=none; b=gPTccA60CFzP8MSbQ6gJDgS+yJ+1chvXx18PsngGXpEapvdKJ7JYx+sDTZov+2o+/ye6uujjOi6RtyC2z3C133Pf/dEtoumpAJLSq4ah2ErmOnPPybDwHIqdK3VebMwyoPegCP7kH3QIfwpTFl286jA5BfeWE71EAMLoMLPFLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339741; c=relaxed/simple;
	bh=Y3uNYn//sSm5A/Oam6XpZAcEQcLgmBc1HidW9aTrOs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y08gPTYs3oltnnLlWm7kAZCnbd9FMkwtfm3LIHm7Tq/hNOJECcP+YjhjbZ70s39IYoPIn11FEvALFjEVl4o00cspxHbY6lmCnh2H2R2R7zE5uL9fHH0J1pKYVPpM73r7U8TlfET5SpkpPhonaJGffFCiCGkdp5kQstcIPPTpW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berg.pm; spf=pass smtp.mailfrom=berg.pm; dkim=pass (2048-bit key) header.d=berg.pm header.i=@berg.pm header.b=O688odYT; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berg.pm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berg.pm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berg.pm header.i=@berg.pm header.b="O688odYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berg.pm;
	s=protonmail; t=1785339733; x=1785598933;
	bh=vtcVqEct+HLAha9NvEEM/Cyf3LHLMy7OlASN2hNB0Cw=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=O688odYTljNPqfRWw2Y6ArD3v+uFRPFWWvWaFjqzvM7jV67S5z/m6h49YaG9Phjhf
	 eeYbeaOHFeHA/8uaNUtds6/aJxSvTweh47kOrx1XIjJN/BMejj9i3hIPRLBYpNYr+T
	 3/dFXEdE9Ix+wc3riQP52ZbEfz3JahLsZMZ9U3MOkUOTG9kKuBgtEsGtB38HNBvXjw
	 LRVjapw1sG8d5hF1CxepPkS559osiHlnOdjP3wUod3NZt5aWFsu9aUSm54WZ2Z2Ole
	 hMPIyVOSRALsob5FZoWxQ5AeDv8qX2smZbne5LX7O5ARcqbORz+LCw2s9KRowkzE8q
	 JUVI1pyA5jSMQ==
X-Pm-Submission-Id: 4h9GmL73DHz2Sd5C
From: Jakob Berg Jespersen <dev@berg.pm>
Date: Wed, 29 Jul 2026 17:41:26 +0200
Subject: [PATCH v2 2/2] media: i2c: ov5693: fix horizontal flip polarity
 and Bayer phase
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sp7plus-ov-flips-v2-2-91884b81a8f5@berg.pm>
References: <20260729-sp7plus-ov-flips-v2-0-91884b81a8f5@berg.pm>
In-Reply-To: <20260729-sp7plus-ov-flips-v2-0-91884b81a8f5@berg.pm>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 =?utf-8?q?K=C3=A9vin_L=27h=C3=B4pital?= <kevin.lhopital@bootlin.com>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Scally <djrscally@gmail.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Tooraj Taraz <tooraj.taraz@yahoo.com>, 
 "Joseph V. Lavigne" <jlavig88@gmail.com>, stable@vger.kernel.org, 
 Fernando Rimoli <fernandorimoli11@gmail.com>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>, 
 Jakob Berg Jespersen <dev@berg.pm>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785339726; l=2046;
 i=dev@berg.pm; s=20260719; h=from:subject:message-id;
 bh=Y3uNYn//sSm5A/Oam6XpZAcEQcLgmBc1HidW9aTrOs0=;
 b=AeBHctB44yunrhB3afdwm5DT+fLVOJUCbDjxG0zpMpiPwQdkc6vLXGnPHUpvbdr7/5/Us/oYp
 GNKV/QOyvesBgsZs0se/GZHn8HOJO34/b4fJuGOJ+1vjqzHQvNxOYeX
X-Developer-Key: i=dev@berg.pm; a=ed25519;
 pk=b1r+eoJThwSQ/r5DjO7jrcosyrIsyhlOuKk9CBdvBxs=

The sensor's native readout is horizontally mirrored and the FORMAT2
FLIP_HORZ bits (reg 0x3821) un-mirror it; the init table sets them by
default (0x3821 = 0x1e). The driver sets those bits for V4L2_CID_HFLIP=1,
so the control is inverted: HFLIP=1 yields the un-mirrored image and
HFLIP=0 the mirrored one. Invert the polarity so HFLIP=0 yields the
unflipped image.

Clearing the bits also shifts the Bayer phase one column off the fixed
SBGGR10 mbus code the driver reports, giving wrong colors in the HFLIP=1
state. Compensate by offsetting the output window (reg 0x3810) one column
in that state; the crop has a spare column since crop end = crop start +
width (inclusive).

Found on the Surface Pro 7+ front camera (180 degree mount); geometry and
colors verified correct in both flip states.

Fixes: 89aef879cb53 ("media: i2c: Add support for ov5693 sensor")
Cc: stable@vger.kernel.org
Tested-by: Fernando Rimoli <fernandorimoli11@gmail.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Jakob Berg Jespersen <dev@berg.pm>
---
 drivers/media/i2c/ov5693.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index 4cc796bbee92..4b016822d561 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -375,8 +375,18 @@ static int ov5693_flip_horz_configure(struct ov5693_device *ov5693,
 		  OV5693_FORMAT2_FLIP_HORZ_SENSOR_EN;
 	int ret;
 
+	/* HFLIP is inverted on this sensor: the FLIP_HORZ bits un-mirror the readout. */
 	ret = cci_update_bits(ov5693->regmap, OV5693_FORMAT2_REG, bits,
-			      enable ? bits : 0, NULL);
+			      enable ? 0 : bits, NULL);
+	if (ret)
+		return ret;
+
+	/*
+	 * Clearing the bits shifts the Bayer phase one column off the
+	 * reported SBGGR10; offset the output window to compensate.
+	 */
+	ret = cci_write(ov5693->regmap, OV5693_OFFSET_START_X_REG,
+			enable ? 1 : 0, NULL);
 	if (ret)
 		return ret;
 

-- 
2.55.0

