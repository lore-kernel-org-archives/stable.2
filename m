Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537699;
	b=W9butSG1XZ080DQHWH62P+73lJLE52OSFiiSiNZNvlOmrxKUTkx1p7874xTerI/mlM5C
	 THJLKgoxDYa65cw5PqYB47bwCb+3Cz84KHPj+ehxp4+4ZFjCAPTnhwX32y+7JIzHxprm1
	 bforzonEhvI6S7ROQkzPjzXtsMd62z5Ww1cOGPiZd055m5KjTmUzaDKo/7+frAOiEuKqS
	 XUtFwPHLA6on2AlBsg2r0DHlzmut6kpfptGM2vH6tfHV5SQlqhPeY0P1yJ8/HQvjGrN7n
	 KE88TSGBqQjLKv6tg1BOV1mXiwZnq4HL5OOqZWrm9ACZaYCsskx4ee+tVxbzAsRr2mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HXPaDe1GyDmDZyt1zBepWwW/7I0nMtcyrpGqoJCQR3A=;
	b=Ne3EKXC4LtKkHKwg4QkJIMRlquUBoNojrecr0/rZjShQzChGMZ3A5HUTMA7dgV8vyjGq
	 KkqiYOJTsjeQ6WgK4ACUsIyI+ZOI4G/TsQyUQvv75KytFYG3aqJ5BE3/ssm9x9EqkeJUZ
	 jrNuYKpUVQm13FObmgTr9ojU33cZ7TR5C+0VNd7zcvi78up98belEY6TUZv7LmfxN9q/L
	 jQQyDWV7tA5qd4PqoEPRW5B3ggM3YTUupSibdX47sYbTWnaK/hJpbmNA0BQHmiEkeYRpR
	 IUud9qD8jR91b1Dkt9Whoy7mX6eTID+Zjnktena65Zg4XpjuzSNOc3bsdG+WneoZH7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FTgvzN7O;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59193606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59193606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FTgvzN7O
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-376a4059061so57463eec.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794537698; x=1795142498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HXPaDe1GyDmDZyt1zBepWwW/7I0nMtcyrpGqoJCQR3A=;
        b=FTgvzN7OSkT3vZRg+VtPKcEXeRf/ywtn/+H4mOytppQa/L54w5w5VcB/9lNqJ0+Wfq
         zZ3nty79bXjcflr+/qAawOp8qmGYeBj72os/92CXs1q36AAfOZbq5eq/1D+8kZkTBnMx
         l8dSUvtunlcXTbpjDY9UpOz02+D2JRFRTjUE7DDi6uaGIKlXeTo1iVeLLYqvKUQ5t/BB
         KTokuP4G8cqX6VNxrGSe9/z9IIeA3NXOo7BSQgMenv+uPlclYfoL0J3igB6mbTPnLSOe
         vlzmGoJZAl2udrhl11n9GxPyFlJrobRZQRLyZul5GYpqFuuWxGI++I1RaYkWFXeLjrl9
         QYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794537698; x=1795142498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HXPaDe1GyDmDZyt1zBepWwW/7I0nMtcyrpGqoJCQR3A=;
        b=Tuaxb6kYdNF18WMyv6TRBXqTCMrvrMXuAiVqeV393LARoDWCSd7V4Aqzvq9is/ogtT
         EnIzWeThu8ykjiiI6OS14tktRmH49xBfNJjp8+/liJt0jlDSPFCG55v0nUoVQODGIXAP
         gvUO4uxt/80pFRj/cZmaWUt3rD+RKNg5Vg5Uy1byHqiwXEYHBVUtP2WpdGQMZ7bk2Cr+
         Odyp42827Xrusrl/e/91fcEjLHgBAgqIs8CMiUYtHISaEWFvJhTvaGXJH/W8wUvr/Yxo
         ClSljlmkLQDauIswUzb+GilDLfUyis829GLLTx2yq6PNzhNQG4qOeBOcZHxC6OThSuD0
         ar0g==
X-Forwarded-Encrypted: i=1; AL+hErGd2oONTvU8+SMhQaI8qThyBJPclxOWByuuWrvsotLrRo7llcZObT1F4+slpBV8nRdBPy0Qf78=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6/sRKeLX9dn35PNMHwyQIKdi6r/np83xAyvx5PxudcFdOoiMe
	17SaDk4bY6TVNvQ4yaFgPZNyWDFchwNNZ4yfM+pIaftyeqQJNloFjrx+
X-Gm-Gg: AYBFou3moBn2CU/kp6HQlsn1bFRQin5wWjLRU4oyxJJoJdUGnpEIu2Ub+itpaukyasc
	s72m7I3I2kaOL9UhYHkGOYSrDduWRSLtAXvuKGo11M+VPKdnjoV5PyNAnZ91UKuRTvNdAeAVoCd
	BEAQ8vdMZ2HTP16eUCFydyX7ARiiOpPtYPvQxy08gCDPzEGoH5IS7iYCpjVaWmfXgAPiIhTrHTf
	O70LPCxCgSKhX+AoYgCgqhgbBFxAraSdxgxKwENTalYW43E8gmtqJwca4n0TVmqGHYf3O3sxWYu
	WVdcb7UEdb4T1Ln8nJ5b5N0GnjsHCfLeNvzZNHKW2eu0Fku5Vy55DfDcdDSrQpwwCcz/F6Pjhn7
	iQ+iUvCU0gSQpFEzUbOnXeccsTKYllGAjv3+indTlopV2A/2eWuBzcm1883Z2fiwU39Lr65J6M9
	/gV/FRkhDNqcDX87WvTAj4evnE0xRXtcezSg9frFVoX37fHdSZKXveUB5/sPfESPJaDQoihBAdk
	9XB2j3dT9c2w6AC+ZJlBVTLemHrGZt2QECgsBZBr1cS6YSdHoxn/I3s6DhAAl5Ubl02M76zcH7S
	ShPr2JdTbdyGG33sksdwRW7gGgNfaQXSgc1Q25+dkHWgN62muXAJUAxfvbXNUJ+Sw3c53eJyeJr
	rIuz41QIV4dUoEGTN4gbCIJotfJ5Jdq5glrAli9TVhHvKoi++ZFmLwuAS+RRQ87fKExXD76jLij
	vFTPnX2RN+uA==
X-Received: by 2002:a05:693c:8204:b0:372:c0ee:875b with SMTP id 5a478bee46e88-3796057b529mr1567197eec.0.1794537698330;
        Thu, 12 Nov 2026 18:41:38 -0800 (PST)
Received: from esteban.tail1178e6.ts.net ([240b:c020:623:52c6::44d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm2334704eec.22.2026.11.12.18.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:41:37 -0800 (PST)
From: Antoine Pichot <antoine.pichot@gmail.com>
To: linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	hansg@kernel.org,
	andriy.shevchenko@linux.intel.com,
	dan.scally@ideasonboard.com,
	djrscally@gmail.com,
	dmanresa@gmail.com,
	dave.stevenson@raspberrypi.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 4/9] media: i2c: ov7251: Reset vblank when the frame interval changes
Date: Fri, 13 Nov 2026 11:40:54 +0900
Message-ID: <20261113024059.1087031-5-antoine.pichot@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113024059.1087031-1-antoine.pichot@gmail.com>
References: <20261113024059.1087031-1-antoine.pichot@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting a 60 or 90 fps frame interval is accepted and read back, but
the sensor keeps streaming at 30 fps.

The three modes differ only in their frame length (VTS: 1724, 860 and
572 lines), which each mode's register table writes to 0x380e/0x380f.
Since the V4L2_CID_VBLANK control was added, s_stream() applies the
controls with __v4l2_ctrl_handler_setup() after the mode table, so the
VBLANK control rewrites VTS. ov7251_set_frame_interval() switches
current_mode but never updates the VBLANK control, which keeps the 30
fps value (1244, VTS 1724) and overrides the 60 or 90 fps VTS at every
stream start.

ov7251_set_format() has the same issue in the other direction: it
updates the VBLANK range and default for the new mode, but
__v4l2_ctrl_modify_range() keeps the current value when it is still
in range, so after a 60 fps frame interval a format change would go
back to the 30 fps mode with a 60 fps VTS.

Update the VBLANK range and default in ov7251_set_frame_interval() too,
and set VBLANK to the mode's default in both places, as is already
done for exposure and gain. The VBLANK handler then also restores the
exposure range for the new frame length.

Tested on a Microsoft Surface Book 2 (IPU3 CIO2): after
v4l2-ctl --set-subdev-fps pad=0,fps=60 (90), v4l2-ctl measures 60.15
(90.45) fps instead of 30.01, with vblank 380 (92).

Fixes: 1b598f413c7a ("media: i2c: Add vblank control to ov7251 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Antoine Pichot <antoine.pichot@gmail.com>
Tested-by: D. Manresa <dmanresa@gmail.com> # Surface Pro 7+, IPU6 (8086:9a19)
---
 drivers/media/i2c/ov7251.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index 65f3fc2d5889..81520833120a 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -1260,6 +1260,10 @@ static int ov7251_set_format(struct v4l2_subdev *sd,
 		if (ret < 0)
 			goto exit;
 
+		ret = __v4l2_ctrl_s_ctrl(ov7251->vblank, vblank_def);
+		if (ret < 0)
+			goto exit;
+
 		ov7251->current_mode = new_mode;
 	}
 
@@ -1413,6 +1417,7 @@ static int ov7251_set_frame_interval(struct v4l2_subdev *subdev,
 {
 	struct ov7251 *ov7251 = to_ov7251(subdev);
 	const struct ov7251_mode_info *new_mode;
+	int vblank_def;
 	int ret = 0;
 
 	/*
@@ -1441,6 +1446,19 @@ static int ov7251_set_frame_interval(struct v4l2_subdev *subdev,
 		if (ret < 0)
 			goto exit;
 
+		vblank_def = new_mode->vts - new_mode->height;
+		ret = __v4l2_ctrl_modify_range(ov7251->vblank,
+					       OV7251_TIMING_MIN_VTS,
+					       OV7251_TIMING_MAX_VTS -
+					       new_mode->height,
+					       1, vblank_def);
+		if (ret < 0)
+			goto exit;
+
+		ret = __v4l2_ctrl_s_ctrl(ov7251->vblank, vblank_def);
+		if (ret < 0)
+			goto exit;
+
 		ov7251->current_mode = new_mode;
 	}
 
-- 
2.56.0

