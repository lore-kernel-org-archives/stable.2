Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97132E141;
	Wed, 29 Jul 2026 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339744; cv=none; b=B2jHetru7bsROzYPDZR5TtpQ50VyGseFVIteIfSc2vHFAlnw/D0fIvwdku4x7s7qPPNnqors6iIHwqGW/anl1zCUCKwXRAVHQZOs/uVh7Y7bONg1U5Z6VvRFavqC6h8MzlGMKQl4BxeLKevWpOiOaDQN8nO1RTV0ZTMnAQWeDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339744; c=relaxed/simple;
	bh=V1ojd/4yveY2PmeTWOZMsJP2TupBCu8ztBebLvQqEzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TURvUrs0CeScr6m3WxNUrxT1ntJWSy2WkcHm9qCvLwXAYtQiC9GwVO6pfFRsBTPHBMyBdurx4zTcBki/BoMdlX/YTVcexFn/7fPGsjf4/elIZ1qPFVTdo5uYD09Haob4zRH1sZYjYLGvD581bdX35vobu+F6V8vcetwgCcbrS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berg.pm; spf=pass smtp.mailfrom=berg.pm; dkim=pass (2048-bit key) header.d=berg.pm header.i=@berg.pm header.b=bkuuS+Wg; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berg.pm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berg.pm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berg.pm header.i=@berg.pm header.b="bkuuS+Wg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berg.pm;
	s=protonmail; t=1785339731; x=1785598931;
	bh=LYStA+2zmysDnxsvcdoPSc3hKPcnNLjoaGp8ziw+rKQ=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bkuuS+Wgxr8PA4cfPqLjY27HnHWWvVmYd73/6fyluTKAcbpMXfxiz7cgnoD1zo3kI
	 SsVQ/L2+Grc2GRCjBw6cX3dhzX2ijaczC+y8xoUwRiT/0FKLBsI3gkXD5JxFOUHTgM
	 4gqlhFx9hMJGWuJgCZTRXv11NTcXTTf3hPfMhFEKBQPLL6ZVuCTfpy+G5OEOc4hKCj
	 bzRqt2CtiUKC2SRi5jiIavAkQ/B9fVQ0BMJgqT1nVnuaLzRz3/9U+ZoQp9D7N0YTMb
	 8QmdjzH3/Dnr+Q+FVT0ZL9nPHP5+F/jkQ6+AKQ4+I5JBSjjwJrqxvE/grMu99OO95/
	 dBvhYQtwPmyEg==
X-Pm-Submission-Id: 4h9GmJ5SJSz2ScqT
From: Jakob Berg Jespersen <dev@berg.pm>
Date: Wed, 29 Jul 2026 17:41:25 +0200
Subject: [PATCH v2 1/2] media: i2c: ov8865: fix horizontal flip control
 polarity
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sp7plus-ov-flips-v2-1-91884b81a8f5@berg.pm>
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
 Hans de Goede <johannes.goede@oss.qualcomm.com>, 
 Jakob Berg Jespersen <dev@berg.pm>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785339726; l=1439;
 i=dev@berg.pm; s=20260719; h=from:subject:message-id;
 bh=V1ojd/4yveY2PmeTWOZMsJP2TupBCu8ztBebLvQqEzY=;
 b=+GnsGCZ4IJ7AHjsi2Rv//VhFYPRdNbHUvRC4GUkDOpOwABbzx0xI21PMsZKG/Nxx3ROS8gYBD
 njNENALsjeNAt81MPs2/ZTo5XP+L5wxlmHpN1nWbamqAMbz6wz+DfzR
X-Developer-Key: i=dev@berg.pm; a=ed25519;
 pk=b1r+eoJThwSQ/r5DjO7jrcosyrIsyhlOuKk9CBdvBxs=

The sensor's native readout is horizontally mirrored and the FORMAT2
FLIP_HORZ bits (reg 0x3821) un-mirror it. The driver sets those bits for
V4L2_CID_HFLIP=1, so the control is inverted: HFLIP=1 yields the
un-mirrored image and HFLIP=0 the mirrored one, the opposite of what is
requested.

Invert the polarity so HFLIP=0 yields the unflipped image.

Found on the Surface Pro 7+ rear camera (180 degree mount), where
libcamera's HFLIP=1+VFLIP=1 correction otherwise produces a mirrored
image.

Fixes: 11c0d8fdccc5 ("media: i2c: Add support for the OV8865 image sensor")
Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Jakob Berg Jespersen <dev@berg.pm>
---
 drivers/media/i2c/ov8865.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
index c6d53c3d55ca..ccda33839246 100644
--- a/drivers/media/i2c/ov8865.c
+++ b/drivers/media/i2c/ov8865.c
@@ -2204,8 +2204,9 @@ static int ov8865_flip_horz_configure(struct ov8865_sensor *sensor, bool enable)
 	u8 bits = OV8865_FORMAT2_FLIP_HORZ_ISP_EN |
 		  OV8865_FORMAT2_FLIP_HORZ_SENSOR_EN;
 
+	/* HFLIP is inverted on this sensor: the FLIP_HORZ bits un-mirror the readout. */
 	return ov8865_update_bits(sensor, OV8865_FORMAT2_REG, bits,
-				  enable ? bits : 0);
+				  enable ? 0 : bits);
 }
 
 /* Test Pattern */

-- 
2.55.0

