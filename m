Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794316224;
	b=Av3tZ4oTCAyFj6mFalhTtSQ2A0+R94syETabhV+z/a8rT3KMwdsHbQV6ERkYqTYa/IwD
	 OYcBR+7YrlC8JH1SHyskqMXOlasJOaOcXI7JCx7IXI7pWE0iLY0BS4XXy5e8zVJXpjueZ
	 +xDYaYoAft3c3RPps5RFqLafBujeCFqilpaJyTPYljmS0G5ESyPj1yoBTrGacbH+MMfcS
	 ozrcfw4efzZbAbPd+ioloONDU44oD18WjnP0cVANQ7lnvn91rh6Lx+QjgG+QzFfwkLxId
	 5yBQvuAqsNTYUBlRlPIOiAsyfsyFjm3HygXZgwR3l7bdYja6YcEwRO3vjUz5YfcaPMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316224;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=G3R/+bQfagRGfMHqxue5mdawADwSItlFmbqUUKSLb84=;
	b=CLQTE34cv17pBjNw3fOgGEWix1v9XabWt542h6fjIqtgSwKIepdYmRUzeFago5ZloA64
	 wdXn3sKl1mo0RdHKpna6P/XBHXifR7RxPNk2e8ofNbCcXwieFBemTozH9p1+eiiZ2HRyu
	 Qp4P40Qfk/lrvz5bVWJzuCVVDbJpO98kCeMVBjX16oZigIERbauTNy6YzDRujTliZ9l3o
	 Kgmht2WbrlxPL/aV1vRiXv33aGKx3aNjQk+7icrtr/sgkyJBCOaKkwHGd5GTDXFFrvzZ8
	 EXzLsnn6MtOqcxefZaVGonk8uZ/KXdS4s5f0+KWgozsUIvNm0HWbQTlmizmAh9zcqQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=Q6bEe9Nt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D40606B2EB;
	Tue, 10 Nov 2026 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=Q6bEe9Nt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794316224;
	b=RvrRMEspAwj9vcdhTal5B4qJS91laPMABixMiiM3hAEt7RjgJkfKyWRHVyqTuO8aI18s
	 mhkHf8grWlxEo58/GunWUkQmKGsMVXyYrJGDRYQpHU+U+BlwmRpG8d7ljF5SUyGbypBki
	 1Z9XxUmJdHJb09/5mcLSA4ZCl6Dp1wrOHh76MnFzeteYlD5WrubtKvJabURVMdpbbuz7F
	 ea0PBcEDyip1jeM8LfzuKjtKwKoydUDYVmkH7OBtYFDDszFLSGjmQIKohsSHu7fb68ByP
	 qGmxwPqdYUmwJpuGQv3nA2amO9ZqjzeI2p+0AkiuTHlcXVTaBkza9xD86sESwNjeWXw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316224;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=G3R/+bQfagRGfMHqxue5mdawADwSItlFmbqUUKSLb84=;
	b=DtoI0mXVU/WvNP1cQzUFSNGL9kdgNhm+iEaIBdyCKLfjjFb0oNDytdRuHBd3cPoR5ld1
	 067XLN8fHL2gSyYGBmiNhCezBknoHxfan/GoudYuzbeTvVJQqd4LbvgiHMhpSw9FP+3PS
	 TpZj5Tt+p6kkOQW2ToY01Ia8j8+SVdFR6SXPJjYsYztyBWbfIjgYJ1pfr6g/m/C9NT84z
	 8iV6ex7M2TXjzMrqB/OJzUv2sIaagu+reEa76TnIxdrg2sUeK0AxoMgCuPk3jLSYOgMhh
	 pELtpb9oJ8zCt7x1+4vP+j44hDcl1oC8PJ9cLKmQhoTd+ZFkT/RUh0LlwKWbOBN3NIw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 93CF31F008A7;
	Tue, 10 Nov 2026 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794316224; bh=G3R/+bQfagRGfMHqxue5mdawADwSItlFmbqUUKSLb84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q6bEe9NtljHrXrgWcb2BN0dhKVng1B0NsRYjxa3UlPCIwIUYwERwZcW9Ndyf1G0Dn
	 gDnoKp3pHip4X2rAWe/uxVWMLE3G5oB0IZYFxmtak0BiMTBDsawu2ov8P7gXpnsGVM
	 LhpTyHfeeMh8iBdK12Glfe7BuMZILnoa1tlOKokk=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4B42748B7A;
	Tue, 10 Nov 2026 13:10:21 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Tue, 10 Nov 2026 14:10:15 +0100
Subject: [PATCH v3 6/8] media: i2c: ov9282: recalculate strobe span on
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
Message-Id: <20261110-ov9282-fixes-v3-6-cb6df80cbc22@linux.dev>
References: <20261110-ov9282-fixes-v3-0-cb6df80cbc22@linux.dev>
In-Reply-To: <20261110-ov9282-fixes-v3-0-cb6df80cbc22@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794316220; l=2105;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=aEXFKd4H0rtz083Rmv0Q+bUCytF9i8FMlVC3eFTyuXo=;
 b=ng3sMIzgTZ33yLAAxK+7F90zNKiiJLdpeWuspr+xzjnNG2r6ha/0kVDwDui/1VDUzyWmBXcPb
 3sWbb/bx5CIAxiY65TiFsG+/iccg8YpbyWh6vztwHycVP/35QNnw8xD
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
index 86a62ccd68654..e46695d1377ed 100644
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


