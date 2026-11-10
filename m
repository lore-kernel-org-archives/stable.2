Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794316223;
	b=R1xIVd+Ipn9iNH4eYlaC7eMpq0vHEU7RgL+bIfQMd4joTf2YkfPaq78yzn24mdvlzYVT
	 WcRXrtIa4PhFAKXQEtj7baROT5ifLwMYunBc9Q+XRXt1nNzGWygRwk3ZOu4qGSpAjQsj4
	 X8l0pp/wOhor2RUbaaIQbUmEOUoi2ZyT90Sd21NcN5/fI+4e4PV8WVhJvsQzquK/OblkT
	 nCDwPbloiSZEFIoCjBTu6c1qxHIAlDQS+T1jnyH83B4liJ/G9D9UpIvjF0cmZ4zU7L66w
	 BznHlwWWLiwdcFuKfpSF10UuAuf2aOKqdDVGD4RlEFV4WMf7AZmIg+ph4heS5cxuUFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316223;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=ju8+MM+5dKoEd9ClnV+4W+CQCs5K842oU0A3nTNIAbY=;
	b=4HlbTZzDjMEPSKjJB8lIg25fXKHU2QegzymiphDUWNbvjW0tsZKUEp9aIGNSdVzVs1g5
	 1WDsptHZaNJLjWrhMjSw0NCJpo/bEeKLFF+yn07X+/IHTBZuhNZsKFzPxknZYTIV5njdm
	 2rRpDyRNX/ZPsYwZQA5HPfRJaQSZig6/5UFKSTwGwzXvkoF+bV2fAd6FSeOyr9GA5BtCo
	 JcYqfgMRvfmoN0Zn3QW3CgnH/TQdA0Gp2PZ8hhMuwNF+FXJVOPyZ1VmzJQh8ehM1dbJor
	 7XqxeHH6JIfK9Y7hkOlkzOoPhUdJCaGW2jYG85bi7TqxrQvsz6OCua1LklWsIdLJSpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=Xh9kG03Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94F606A768;
	Tue, 10 Nov 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=Xh9kG03Z
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794316223;
	b=ngjMYgJaYfptYPKVeQhP34h01Sgo1DPIcosSX3XuZafqVlzWcrWkIREpz7SUKqVP0cwe
	 dPBWMfXEzErJ0AXKgtxigOV0ikIaSRBi1RwBci2eInC3UNvpVH7U2F4YLJNHd5W2xbj1L
	 QzsQdiCrECljgr2pQ6WJFp+DmZeqDcc+8QbxTGmk/eByl2xnZgu7MWkiVO/D+XOEYIRja
	 1qFE1bWD+Gh6CTBebktmRIfWXCbwCmsCtG+0X+6DM0oKRD27rPQbCHqu29v38i+k4yrQw
	 bmT5D92NBT04+JH7KekOsHZlR5vNbzOtmDjx62GvcPc7oCKci4mhum0VOhI5Y3USPoA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316223;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=ju8+MM+5dKoEd9ClnV+4W+CQCs5K842oU0A3nTNIAbY=;
	b=BsFk8u5MQOd+B9QeWNbM3wt6HLvrAQT3X4jXVUwwrcN4IuFnvRH/rAsZ2tulcAmbTZTK
	 xphfny/faBCF7NqHQFlSOy9aG/WW/8PHSETIFyn0a1SyOAuoqtdITH4lxiZWUqNsYoldC
	 1aDmdTBrsgTuTHpplNyms9Nb7XX8y2nyaeTBzoiIHfQ7EevuJ3w37+WoDA9HAkduPeC3f
	 5dt6ofi+mv0cd/LarxXMVpgT/qsae05do0yjqtuYdlwYHSYStK2wLFJx/X2seOsEC3ofd
	 oF8FGeDvvRrxtsuEuW229xPBVnqYGQjJLcz4KHXlFWjaM6+0Qc65KKQvexqbJ0SyiBA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 920BB1F008A6;
	Tue, 10 Nov 2026 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
	t=1794316223; bh=ju8+MM+5dKoEd9ClnV+4W+CQCs5K842oU0A3nTNIAbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Xh9kG03ZKIbLYD4hOfV94m6EDwVtXhDnVwbwqSW/E1UBP4ubhlfAK8cvblFTYUbS2
	 I7jlTkBQ0N6OxqHCpaoLv5PZErISYDWRRqbtKIFhgP61Gtm15w+C+JfMXqv5MdKfU2
	 +91IBT9Rsxn3TZn8ABvSzhsuWSQCZJuFTmjtkA9c=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3992348B76;
	Tue, 10 Nov 2026 13:10:21 +0000 (UTC)
From: Richard Leitner <richard.leitner@linux.dev>
Date: Tue, 10 Nov 2026 14:10:14 +0100
Subject: [PATCH v3 5/8] media: i2c: ov9282: add refresh of additional
 ranges on a mode change
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
Message-Id: <20261110-ov9282-fixes-v3-5-cb6df80cbc22@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794316220; l=2624;
 i=richard.leitner@linux.dev; s=20250225; h=from:subject:message-id;
 bh=xDaYCG/EggX3Dks5xTqVdlW64wbP1xefCkWQCQ5i5Sg=;
 b=ZVlPXn9vOh24xshoxJgpv8xfLNx70LMXxCYpqn32rvF4V/GKagXHku3NGDFd2zBm3GWZQ5ed8
 utUkrSoJ2ioBxhBHxK2L6dH7/AeROdSX+0kNrIGYhovAitv8jSdLOY0
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=8hZNyyyQFqZ5ruVJsSGBSPIrmJpfDm5HwHU4QVOP1Pk=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20250225
 with auth_id=350

ov9282_update_controls() updates the pixel rate, hblank and vblank, but
currently misses the exposure range and flash_duration.

Refresh both, and commit cur_mode and code in ov9282_set_pad_format()
before the call so the refresh and any nested s_ctrl see the incoming
format.

Fixes: 14ea315bbeb75 ("media: i2c: Add ov9282 camera sensor driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/media/i2c/ov9282.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index 44ac2043f5651..86a62ccd68654 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -548,6 +548,7 @@ static int ov9282_update_controls(struct ov9282 *ov9282,
 {
 	u32 hblank_min;
 	s64 pixel_rate;
+	u32 lpfr;
 	int ret;
 
 	ret = __v4l2_ctrl_s_ctrl(ov9282->link_freq_ctrl, mode->link_freq_idx);
@@ -568,8 +569,20 @@ static int ov9282_update_controls(struct ov9282 *ov9282,
 	if (ret)
 		return ret;
 
-	return __v4l2_ctrl_modify_range(ov9282->vblank_ctrl, mode->vblank_min,
-					mode->vblank_max, 1, mode->vblank);
+	ret = __v4l2_ctrl_modify_range(ov9282->vblank_ctrl, mode->vblank_min,
+				       mode->vblank_max, 1, mode->vblank);
+	if (ret)
+		return ret;
+
+	lpfr = ov9282->vblank_ctrl->val + mode->height;
+	ret = __v4l2_ctrl_modify_range(ov9282->exp_ctrl, OV9282_EXPOSURE_MIN,
+				       lpfr - OV9282_EXPOSURE_OFFSET,
+				       OV9282_EXPOSURE_STEP,
+				       OV9282_EXPOSURE_DEFAULT);
+	if (ret)
+		return ret;
+
+	return ov9282_update_ctrl_flash_duration(ov9282);
 }
 
 /**
@@ -833,10 +846,23 @@ static int ov9282_set_pad_format(struct v4l2_subdev *sd,
 		framefmt = v4l2_subdev_state_get_format(sd_state, fmt->pad);
 		*framefmt = fmt->format;
 	} else {
+		const struct ov9282_mode *old_mode = ov9282->cur_mode;
+		u32 old_code = ov9282->code;
+
+		/*
+		 * Commit before refreshing the ranges. ov9282_update_controls()
+		 * and the nested ov9282_set_ctrl() calls it triggers derive the
+		 * frame length and the line time from cur_mode and code, so
+		 * they have to describe the incoming format, not the outgoing
+		 * one.
+		 */
+		ov9282->cur_mode = mode;
+		ov9282->code = code;
+
 		ret = ov9282_update_controls(ov9282, mode, fmt);
-		if (!ret) {
-			ov9282->cur_mode = mode;
-			ov9282->code = code;
+		if (ret) {
+			ov9282->cur_mode = old_mode;
+			ov9282->code = old_code;
 		}
 	}
 

-- 
2.53.0


