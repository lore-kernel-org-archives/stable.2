Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186531;
	b=dDJPJsAs8hXle9HsvhphT+l/SUfhPgnsPyTc+NxknQmG22ppKPgEAd3zN7aGqcAWGSCj
	 wVonpadXPMrHNO6PlT4mzy50OvASALvBg8K8fRIyCDbNVJagjIGvnYAf1EGqbrXEVIkNl
	 NKuyn5liveduJMI+s5v/eP04KtDOmqu7maqejRMV9Kd5AYe0C+JFx+x4mFFa+Q+9eHrT+
	 e0laKIZHp5pIMJUcgNhQ5kG8wJKgNSsdBwZQER5HzrWaTW59LyyqpRd+xZz/nwr+xOeN+
	 3c5pD3y1xRQOzZJ+FX6gUXXIMhQ/YgeDlod/Yj8U7ndbNMSvf0FqFrexmMfVU/WYA4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Hq1+ntt/iEffpsZs3NUeDNL9muD9vYu5VwqXCAfAeHc=;
	b=Y92YA/REJ5TwXsIDRNp3gK045eLQP1LIaANsQBxMaKT783gv7hXBCvicrwJ8HOY3DrV4
	 sfA+6TYfqqqS6qSvbIQDNwKQWAAmn3zAcH3tnvgGUYXIyiYLHtyNtggir4+MyVlMHbP6v
	 J7qOa9RaAhLgLEM+Qf4reCZG/cZZ/MfL30LP6SXq6YHx23wSsO04yPia4CQvZUU0+KBVg
	 r2jgvhvOzYiXRn4TiqSPVmQAvWwJmItEyqjwqIEiR6GLV6nOBXyq7isGkesYEQnzsbIhF
	 8OF4E7BiGKLpivfZr7kdkKSTd6wF9bAHVWKJaNyxxIWaEr72A3mOoBUh+AkqxwuHayQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zE5Ypgth;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0A60A2622
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E0A60A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zE5Ypgth
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9deceda30so1037585ad.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793186530; x=1793791330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hq1+ntt/iEffpsZs3NUeDNL9muD9vYu5VwqXCAfAeHc=;
        b=zE5YpgthR8gElRrgY2abQjB2zWIbHsL/HjqGIOo31Mdp5ge+giwVNAk1x5aozJDksT
         dbubHSzaBc5xalFGw2IiCHUpi1i3qS+ZxojiE7q1pKi5Zqatk5Je9c57jc6NO4MImSnZ
         Q4+HF8GBsJiH7OlU+scpTEc0DIhvHPAzS0je5QYDciSltO/j2la+ZJMH8RxMFC+WHASm
         JrCuHJ37zlgs2gnuZzxa/h3k19DkE3UsnQ2WR5MUxF9p2vQVCjaWZU3KIF9oI37Wdt+A
         a1cTESkf8sIJ92tBxZ9FBLn0bCFxXTPcFv0hc7LbUW8Re37a/r0ZEPGXBky+ANkNilHi
         TmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186530; x=1793791330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hq1+ntt/iEffpsZs3NUeDNL9muD9vYu5VwqXCAfAeHc=;
        b=vSnA64ePmVReANI4fHSTUJYVEqxdqENqHjiikZt0ZUZZZ7qoHsYDmQAuu3tvifxENM
         TR4xiho0AGfRhlizrtypfiNB4T4FNixgNS+sWiU8OfWFm3ZuNpfBkPM00dVNKPJokHkG
         K27ZnI8CdKgc0iBuVS7+ZQPqCwE8Zun580fD4zCbBb/1Y0jJ96aXG9WYEf6DdIfd1MiF
         pfVAQ1rhl7yZfWFR9nGbZpNUKr/J6QnQaHnOAyqeEGyBwuKcLpMspVorqTbxoylxmKvk
         Zz/1o7kTx7znepSQrFmJa+ZpGh50zU/sp4S8TdAGkDt/hpfZikuqF3j8li6jlMT4BOEq
         ojVQ==
X-Forwarded-Encrypted: i=1; AKwUvByzHPqczil7jGGYx9TUUknKOich/VvpWBzss/7cohs5OifmxLcjVloiyiEV8meOoc+Ol7Cv5+s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlAxPbCG84BPVi0Q1exutp8XpJR9DBo/+1yWE2PBluHk5Tbw/3
	F86B+lfz7W6Z5joDvAXvTcNDNSZfb/uB8PoBSmMdgP1PI1n6EOGyP6i1
X-Gm-Gg: AYBFou2KhRffUQyEH6IxhZhnb9qSK1XyjGaf6St0ZwzuOEPE/+0bhazpTrs3FmATIQg
	tyyMJEUEB9z0hxhvvbajL9yLBrp1gvHxx2I3aU61uJNWgSJW6RXwyIrnObBxzCPTZZ7DW3OvJX2
	Lmu0HLvOdJp6103oSGr/oTDk4839ocmcoqQVTj6+qnexzaAKWz1dGIohF/o/mAv696d1OYR9Xqf
	Uh9OVdgeUc+787YARq+o8Jfcf8ketCASDvKwEot5QEK6AAPj3RETtplGUFE4fMmvN8SEJYi0yaX
	iUqIaTVR8wdJQcbh4Bb7J5cqr/ry+aMPHZESMhiJsMV6iWzS+KuNwaZX1xA3Z20HIJxppueU9Ij
	ytYTd9BB/ZSnPMOLXjsQhUJZYkUpzrq+0fkfpCtPM9ki6BI9icEcbq844HgRKtxEDgGJV/Jw0Fq
	9UKYzVP3higJcvnZMEfWQ3iUBeGwIhorbjM7sKolqtDE6MMkHq2WRn567bjkbS8dvCJYJ6Wwz7s
	keKznXdgaQVO4Dzm7sbQcaqOytLkEwLn4EihwE4YhL07aKJB3oAkg4G21nfBS96QNBMp+rs3CoQ
	3i+4VunpA05yPeiCVwoFQ8DWX9p8ormHFosNCcEixSbHhdouRlUO8Lama3P6tOQ4dqXRXZb5jQh
	5G5y0xO1D0qXC5L4qWnPrIWOk2rEuERJ4HkiHDZX857bvzJUXZjQkEJOieNjnL+AVmmG5ANu0Xd
	LH+Uui289PB7x1M3ot5H0=
X-Received: by 2002:a17:903:3905:b0:2e9:5714:607b with SMTP id d9443c01a7336-2eaffb64751mr32808085ad.0.1793186530083;
        Wed, 28 Oct 2026 04:22:10 -0700 (PDT)
Received: from esteban.tail1178e6.ts.net (132.20.31.150.dy.iij4u.or.jp. [150.31.20.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eafcdb52e6sm10157945ad.74.2026.10.28.04.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:22:09 -0700 (PDT)
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
Subject: [PATCH v2 4/9] media: i2c: ov7251: Reset vblank when the frame interval changes
Date: Wed, 28 Oct 2026 20:21:49 +0900
Message-ID: <20261028112154.855185-5-antoine.pichot@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028112154.855185-1-antoine.pichot@gmail.com>
References: <20261028112154.855185-1-antoine.pichot@gmail.com>
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
index 2db6c28a6e34..859bf6c42341 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -1259,6 +1259,10 @@ static int ov7251_set_format(struct v4l2_subdev *sd,
 		if (ret < 0)
 			goto exit;
 
+		ret = __v4l2_ctrl_s_ctrl(ov7251->vblank, vblank_def);
+		if (ret < 0)
+			goto exit;
+
 		ov7251->current_mode = new_mode;
 	}
 
@@ -1412,6 +1416,7 @@ static int ov7251_set_frame_interval(struct v4l2_subdev *subdev,
 {
 	struct ov7251 *ov7251 = to_ov7251(subdev);
 	const struct ov7251_mode_info *new_mode;
+	int vblank_def;
 	int ret = 0;
 
 	/*
@@ -1440,6 +1445,19 @@ static int ov7251_set_frame_interval(struct v4l2_subdev *subdev,
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

