Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794837046;
	b=GB32Av8INi95sLIOX/E6Shqf/yxLlm44yAr4B3l9pCZP+k/rNU6+BlXHRm1YPkMbZyDg
	 9qz4nvNDKgtALxThQUB/MiCSqaxe4UAbycwt1M2dL9lMMosBnIdV0c87ei8pIatBCcuWP
	 stt+SRh0EFOUQpSHCNJ5jUzt7TzkUJk/VXNPdSsdvDy6RURAsC38WBwY3iimpFTEJN57U
	 by0gWbAWqjiELup9HjH5W4iFwku+epqdO4b7ax/anpZUty5kUjzA7LUZxWrzqdXFKL6vI
	 XDKa9eTbGyOKczl0hDM4kYewyWMaPhjwx1UfKNvMGyed9LBftZ9svDZwavKaUOW9Tag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837046;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=20IET9pgYdDyW8Su9jrMv2OSIeV4Re/A8yVm8spud4E=;
	b=WP0fSSdLwmtI3zIUKBlezH9Vmge0pZVptyoB5kFH9e59yCpwj7/CtaeGoKzGUuZqUUt2
	 BDMszv3iA2hc8GfJJl9f3W1XWEzd2ErwjMpTQOEvxMD9UvIC7OQcYyHUiKkREGMoXsEsO
	 0Jfk0deDEbdCYH0bz0ubcKWn1gIf0BaBMJnttA3a9Udq/PWVBpdR7epZSfs/izTXSwD7y
	 GoQGItifSAGunH6mGBKGpHICP4HWv3PuGRzSHmVkuUTnkgNRncYRhkGFNLuK9208Wn15i
	 adUW/Mak/6XhjEKQKhoXdl4Dw27k6aYkOa9+F+mSqrAj9V5iAPDhY2B2zw4GEKOyhkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=vNwEJVkD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBEC60A2623;
	Mon, 16 Nov 2026 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=vNwEJVkD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794837046;
	b=vqm0O8VuL0OPsCXF/sdUDAVraVWZWPDDKY8UJWJgfffFhommCumt6AZNKCVGNXRg0ssP
	 GOD9Q/yLMEK5ZLAxCkZkwbcWyNMnWk0zc29H/AbCLgd4UO8Z7A3fg1F5UK2DwrR6CyLuW
	 nCtzraY5hSU7GKIs83HqIHn3GwlQYuOZw6jJ5lKohiGJEaDZ0FYvXmQOvHhHUvShJY3Ub
	 nsm380fcNpdh5Crw73i4+XjyIW6wlJ2Pe8ge248IGUYnUwMXrTJdJ2Q3GhvGVznsKzR/z
	 POee8YQ0A6YjEJL2gE4VGGrfMfHEC+K8ef4fIRFXaWdSUKIkAUNyzfqNNUdiIpn2J2Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837046;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=20IET9pgYdDyW8Su9jrMv2OSIeV4Re/A8yVm8spud4E=;
	b=YKCoDOMmxsuWUSIo0IKhAhuDcrMlCNhBqWL8sUXKSJLfMlORUTQFNSY1O85QYe3OnJ2L
	 LF00uY9iY7FcwfkX/og9DOqtO7RVqyK7n/VsVDyUHTE6clHH5cepsqJ01i4UGm62oiYlU
	 0MTH3O0t6YpMKbkn9JRLF6u/7DsEBBtS5CFt6PO03mf887nnzDhH8bWzYR9dpyNtl5lzi
	 fIPMEk2ZKsp8GnY9T+GY2JxN02FNpTAqG2kWLLMZEQDmJO7LwyjPcg9aPYS3CroUjrr23
	 4RAQC8+c8NnLiz29xZWCgAeoeYNMKWwqgGfYRY//BTSwftzW8FERi9ySkW2X17BwA6w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8B4191F000CA;
	Mon, 16 Nov 2026 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794837046; bh=20IET9pgYdDyW8Su9jrMv2OSIeV4Re/A8yVm8spud4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=vNwEJVkDTnP+5xPtBo05xr5T4atuk+Q/bYXQERiGe+dxjgVpwTwfCqw9KzvaqH9L8
	 Gj/t+ZsLoKIjezz1YAJYZhDHE1NUdngBvsYaKsyY0dzfh3+PjJ4YvOaKYkDRMxdpJv
	 wA1AnKtNmFjpovoKYDOLxYMEQWumaDogcm+ocYmM=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 340674A4A7;
	Mon, 16 Nov 2026 13:50:44 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Mon, 16 Nov 2026 14:50:27 +0100
Subject: [PATCH v4 6/8] media: i2c: ov9282: recalculate strobe span on
 HBLANK change
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ov9282-fixes-v4-6-f78e5d415c6f@linux.dev>
References: <20261116-ov9282-fixes-v4-0-f78e5d415c6f@linux.dev>
In-Reply-To: <20261116-ov9282-fixes-v4-0-f78e5d415c6f@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794837042; l=2105;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=/l5WuxKbk3bXJ+Xikq+YkzOd91d/fG0BrABoO/lILgA=;
 b=Cy4yJ7dROacvOoCnvd5M+6Mxr8Pl2KmVoLxOli8WAMGqyQRBEtkIL7sIGPr05UPMz/I5K/bxZ
 VPM/kIq7MAPB7FNZf2PR8VcgZWRFC3Fw0HgOfsGL6JR/HRZ0UqtfPsN
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
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/media/i2c/ov9282.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index d13a1adc35e85..d18fee6730990 100644
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


