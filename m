Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013048;
	b=N78UgJ9AJooR790DZyW5XHDsszuIHGqp8x3EPbJDDoAcGPjTxUVSph6mE+vmfQpYfjJj
	 o/1OnJ/V1WRQDUQSA4F/j6C+LhrLy0YHFRZA6qXdJx9UzT81mTxfZUmGCaeg6Jhdf0nDy
	 BlmvVCA56oSY7EScM+0WGG+Oo9qKW2gJnO1iSi95zS3GwxrDUYs0hNSsv/WLzUiVUdGsM
	 IVfS5VGPpwr2AVbiZd+VbJkRYmiTWRyL3T8Y8WVjXYnRA+Ewah5IS37faPiatSJJeb7pH
	 W3UKFuQR5CZskiTeH+t7lulZlITkn4DxCn/Ed/e+f5xfj90r1fGX0/8tnVrcYKdZODA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3skT80xn6avHnOifeNCjAY8wDgJalatgrsaykd9zQa8=;
	b=gSO8q5KFr1j7hxOkb/TSKNakaPTGm8dvEAfKSGHv/Zawt6IBn5fixGccwgUbSt2uCFXI
	 /dkBPuc3GIbZsicA8QW6YwY+NQdo/Ywj9ddaF5MN5NHHPrcCQ1+h2yD382chFFBJP2wCV
	 3z29k3da8Eb/dAh6m1ggVycUzBmJWmjyKISC4bqYv1j0SKNCnQKZywxekEtxNWLURu7cF
	 m2lE93FaEk/iyoeH1tS1v1my0ujABgE+Q/mxwVpHtbR05qnXnVMs47FTuryptiM4/vPCa
	 6E/qCDtihs1eKMd4/9LLTYeUUj0oSRg0KSRbXFrkI7kDX5XMQqnzddSiWwRLKM/IFHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=joSZ1tRi;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BCF60A261E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17BCF60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=joSZ1tRi
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab7b8e6fc2so317113a91.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013042; x=1793617842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3skT80xn6avHnOifeNCjAY8wDgJalatgrsaykd9zQa8=;
        b=joSZ1tRizUp8DRq6YgfdH7JbuA96xkUqa5EhhOTrX79uFoMSZfbkUIOGjxlqdP2tR/
         PgjQEXOxtHrVprFB8/GrGpZMI0hX8BP+ghvr5c4aJ8dnle+Kmn3JDhkpBswpQ6333a8o
         QaJO5SuID+ZqtcSX07Fe2sLLYIFPnXzsUb6M/YdAv+bqS7feqsdfbVGUQdaBhlJArkkG
         WnTvRJ5GcHiUnx5gTCCDjB0kdMNzUCKiCKRWlvIkNO1R2dtHt6xZ9zBzbSkfYFv+ufGR
         4kWjIWu4bRuSSWJhCyCe6c9SYd9FLyxvDihiKfhj0WFl9ObCe5In5pqX0XYkHZ6vq5fz
         4N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013042; x=1793617842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3skT80xn6avHnOifeNCjAY8wDgJalatgrsaykd9zQa8=;
        b=j+XbyoFNyLfSxXYD3TVom6fuIyU9SKnEaQ9MDhKRPb6oJ1y5ODFyMqC/OoXI99klso
         RpnbHr+b3aRGuu7wp4sLHwk/BtgjAk2IEDYAHgfZhr96ZJYY6RYzq2m3NtmAmAKJAK8B
         MoptHd5RRjxtHc0WAH1vfgC+Ptw6aeUBLq0/o01+//N1p7LA/uYtNekOmLweNSYelHDD
         d4UEIVJ9+qoYKQ5pZ6ysfEIRMNgTlvx49PZpgbkv1myFkmjDrp6dXwR34e3odU8COlFP
         kZXOw552ztzqpZh0W/X+UjSBNiVWRnMZNU8Z3FUo3WW2fvy1awJS8j/JUxJF871S2fa+
         aejA==
X-Forwarded-Encrypted: i=1; AKwUvBytKH/bEy5JXGg+2oeHchBpDgPHJPQwQrHKecYIk7e8LAGkK6WnTtzofgLHAx6NXno+emNqc60=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWfvZylE4fHEWt7OdhDUjbjzvRlAA0P+qDfsi5uUHH8WQ/aQ2o
	Lyw/MhEkw4xbyrJDCV0bIhsUGd4NEbTd/O4J2cgW87hBN6uLUVjpXQl5qvvjh1A0T3k=
X-Gm-Gg: AYBFou2oziXzzz+oTqukQJan0mJ9zc05+Hz4ooJyHVaf5fEjTBqGbDbc35NJppJJzvm
	UmfgG4jBkLSb2MY/wtZa3zDL4502Sgvrdlu1/fEQ08mBVID/bSF21hqBUdyNXiqHpEadDDlk2p+
	KavfaqPBxd/X82T09iSXeJH24lumbx1kwhni4bs68FIULCjRNb/S78KBwGVIf6JYrP9B65R8EPf
	VcHXCYB7mjTNB3CpPL762u6KDrFbSoTK1qqnPEvIVFeBmHhl5BidDvgWXU52QxwJ3vjmMjx3IWM
	NVmMWf8kQUkXZxBKel/b5jrVCz+bOJ6fXlRnuHL3F+pohRUSA7K1IWRzn1/VgmqX5M6P2Tx3YzI
	l7WXN2wO2cCreAJbUGa3v60EnS+y27s9dZZJqZMOf7AlEkxxbZz8tIBpEJilTU5Nogt4c5iyLpa
	XWVJ2eqKXdcjzfTlG80+Kejg9PC7qLPillJyG2jDLIHNVQl0BVS7/+0ASTCl585qXXVj334W2U7
	TCMh3bV3lQzjcvhEEn4/ElGwjGbcOihyZb0on7Plm5aLg0ClYfMqS3O2o3g2xiEnZOLPjBS4nEV
	bWSDFQ92HdWVq3sjjdHkbVPyLfTA+xYLmOqI121VZWG8HOS+y4EYAzt4TkfSgFVHc2ZYVFXj4aQ
	ZyF48lOWMTsp7CMkZVGIdNDmx1TnqJG+E8n0KlL0NCm7rmw==
X-Received: by 2002:a17:90b:52cd:b0:3ac:9e76:aa96 with SMTP id 98e67ed59e1d1-3adead00d90mr8351812a91.3.1793013042309;
        Mon, 26 Oct 2026 04:10:42 -0700 (PDT)
Received: from esteban.tail1178e6.ts.net (132.20.31.150.dy.iij4u.or.jp. [150.31.20.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfa82sm8023593a91.8.2026.10.26.04.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:10:41 -0700 (PDT)
From: Antoine Pichot <antoine.pichot@gmail.com>
To: linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	djrscally@gmail.com,
	dan.scally@ideasonboard.com,
	hansg@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Antoine Pichot <antoine.pichot@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/7] media: i2c: ov7251: Reset vblank when the frame interval changes
Date: Mon, 26 Oct 2026 20:10:27 +0900
Message-ID: <20261026111032.88355-3-antoine.pichot@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026111032.88355-1-antoine.pichot@gmail.com>
References: <20261026111032.88355-1-antoine.pichot@gmail.com>
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
---
 drivers/media/i2c/ov7251.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index 1413f1856e..8dad747f77 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -1261,6 +1261,10 @@ static int ov7251_set_format(struct v4l2_subdev *sd,
 		if (ret < 0)
 			goto exit;
 
+		ret = __v4l2_ctrl_s_ctrl(ov7251->vblank, vblank_def);
+		if (ret < 0)
+			goto exit;
+
 		ov7251->current_mode = new_mode;
 	}
 
@@ -1414,6 +1418,7 @@ static int ov7251_set_frame_interval(struct v4l2_subdev *subdev,
 {
 	struct ov7251 *ov7251 = to_ov7251(subdev);
 	const struct ov7251_mode_info *new_mode;
+	int vblank_def;
 	int ret = 0;
 
 	/*
@@ -1442,6 +1447,19 @@ static int ov7251_set_frame_interval(struct v4l2_subdev *subdev,
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
2.53.0

