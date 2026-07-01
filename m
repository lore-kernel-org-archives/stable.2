Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49E392822
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931476; cv=none; b=J4yF+mgXoTpRFOMSaa8j2Z5scgrImopzgyjC9rMO7qtgL9PrcZ212+C3GCUCabBfLci7ewV7KDXdwNdmjt1UOcQ1zYYdYQLvZUM4Irws+Zwjtc0UVJaT/Q5vBhCgxDq/HHc5ERG52K5UmhWf2xeIytcE0G6UsQxFLEbXlfN2tVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931476; c=relaxed/simple;
	bh=/acg9/ZV4XQhN1wNrm7pTsDWmwMqd50DhwanU/SMjU0=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type; b=UTN9umVLehRlgPtb+HgCWgQdCRYw0zDjADf8ag9ePv3V/cn4nhdKiq6TPNLBx83k7NSWGVfbUQNUZMo+RcfYVTphFOqsAs8xwMDMUabtrp/4NSOBkD1XLH4lbXpSHUt+w0i5Xk6sUuRqVraj/g/LYxrUTC8jESRUODXTWyn+NaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPoUMhYP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPoUMhYP"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37de8008910so620926a91.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782931475; x=1783536275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:cc:to:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ban9nVUuk4Kjsoscd1xTKmaJVwsIyHeDMlfeDJiaGMA=;
        b=gPoUMhYP6pIC033r6Jk4W7GjjjmbFsOdlllM4gbtfIURJbVBUpuS7qmKt8KtWUw6bX
         34zeaBvmYJvqRgXpzfhcs1bxrQtdNxOoDr0+lrGP74hyiiIbK51YpThNYibs7zCyU1Xu
         +qiLCTrATAIt+C0q6q7ioZ1uqDdtraTtCapQ9WzzKj83Ad7f2hYOflF1EN4jdstySvZb
         Kno3jzBFYvMQaUI8+ciRCkT6D9+UY3qKe+5EPqBd2y+ooMjz0MOQVSa0AY5aHWIMyMcK
         kw781Cna44o18e5KHB/fMFDAZHlM6fd1UzBwToHNe/UU6EsTXgADtSFhvAl6J8+RPolK
         MHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931475; x=1783536275;
        h=content-transfer-encoding:mime-version:subject:cc:to:from:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ban9nVUuk4Kjsoscd1xTKmaJVwsIyHeDMlfeDJiaGMA=;
        b=U6Yfhsj4fZrF9St3oWqynSlUV/RFooYSTBNyOtepmvs8Qr4PqSllI58LAiU0XcJB6/
         mgthE4dRAV19ifdfxajtOY9giA0XskesnPx3tNPTS0iYq8ISgtcJX4h/y+JSecCzA0U9
         F2xvn3fqZF4gXNQVXufQbsHeQcmoq3AgahABsdZ1bZPUM8X4GRC/Jv3J3s3xciLZmWm0
         Xm8j38Mz7I8pmsvX8Eomj6y79uSq/2sg34Uq/pcWNgPH/S4d56t8XoHoM8HH1myxegba
         36nVCC7XB5nLta7GI6LPP+M0+Av1pMLqVwbQ4/bCVQnj8sQOEN3ds5GH/q+IEtssKmHO
         TDAA==
X-Forwarded-Encrypted: i=1; AHgh+Ro0QfdC/UJu9fR9XOMHV8DP9FERxxoi4mJvVa2Lsf3W0Xj84Mt4RAa4jCXgHbcMuQz4e/QN564=@vger.kernel.org
X-Gm-Message-State: AOJu0YybFew4DqwwAGp6bLy4rjdeAXyYaY8oM7bW+sCv6YaQDj1E+kdU
	jVdJFGSmfAcWU5QuHdHNO2uKNopClpQ8863WQ7T/Y9N/SWunCXlFumeT
X-Gm-Gg: AfdE7cnPSfS52RqHGgaXZK3A/KHMTHC0j2QNSeA8QZtFkX4MYV0uYR1WIK5gTkRIK6i
	v4fRYnl1Lvsb1GFfm255qbK9MCdlOy72Nen21YaLDNGOlmYiDEfBTaRk9uGUyC5exjRuPL+D5CU
	1swMpu3/6jA0HqCuNkJpX4d7LlLsfyOkJ3J4/6U9JhMz7YGh2MfihSEI0Kcgl2i/ojwmHH+kms9
	uyE2icRxmOi5hP0rkz5tJWWsD4wTMnr9dGZbVw1CY+rgUlS6UgUdQfSvVui68pcjdgEYUjAfxyO
	XXng7Eyq57IBjoow9+Tcl5CfbP85K9OZa4AwQWWlRjayOYdqneRbiP050zGz0pwf62duH+Df2uC
	qYhwCXlF9p93UczyWgx/qrewwPwI2FA6UlZ0VkEPuQrI6qd6TEpc1TL0b8sG7s70+SLwyqIb15z
	m4ycCwsB2d8orMXgrbUR3n+hd7/Ltgv5eiA5k0pcsaKZhKj8L0bI7jWOXJw3MqmtsPmpMmwxOm1
	P/xsuCDpochIm0Om6SXT4fp1ICsZVKfP+uKcwK5Y7KA5Gt33v22gQ7b2qoT86OxAVAMyKs0rKv6
	8628jAtoWg==
X-Received: by 2002:a17:90a:d647:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-380aa221bf1mr2580207a91.23.1782931474540;
        Wed, 01 Jul 2026 11:44:34 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2407:1400:aa40:6780:6462:8b0c:2576:642b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb843fasm393406eec.18.2026.07.01.11.44.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jul 2026 11:44:34 -0700 (PDT)
Message-ID: <6a456012.eb165e5c.113c2a.b71d@mx.google.com>
Date: Wed, 01 Jul 2026 11:44:34 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Frank Binns <frank.binns@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Donald Robson <donald.robson@imgtec.com>,
 Sarah Walker <sarah.walker@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 [PATCH v2] drm/imagination: Fix user array stride in pvr_set_uobj_array()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pvr_set_uobj_array() copies an array of kernel objects to a userspace
array whose element size is described by out->stride. When out->stride
is different from the kernel object size, the slow path advances the
userspace pointer by the kernel object size and the kernel pointer by the
userspace stride.

This reverses the intended layout. For larger userspace strides, later
copies read from the wrong kernel addresses. For smaller userspace
strides, later copies are written at the wrong userspace offsets. The
padding clear is also done only for the first element instead of the
padding area for each element.

Advance the userspace pointer by out->stride and the kernel pointer by
obj_size, and clear per-element padding while the current userspace
pointer is still available.

Fixes: f99f5f3ea7ef ("drm/imagination: Add GPU ID parsing and firmware loading")
Cc: stable@vger.kernel.org # v6.8+
Reviewed-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
v2:
- Fix From header to include name and email.
- Add Alessio's Reviewed-by tag.

 drivers/gpu/drm/imagination/pvr_drv.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 268900464ab6..0a68a9c32361 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1252,14 +1252,13 @@ pvr_set_uobj_array(const struct drm_pvr_obj_array *out, u32 min_stride, u32 obj_
 			if (copy_to_user(out_ptr, in_ptr, cpy_elem_size))
 				return -EFAULT;
 
-			out_ptr += obj_size;
-			in_ptr += out->stride;
-		}
+			if (out->stride > obj_size &&
+			    clear_user(out_ptr + cpy_elem_size, out->stride - obj_size)) {
+				return -EFAULT;
+			}
 
-		if (out->stride > obj_size &&
-		    clear_user(u64_to_user_ptr(out->array + obj_size),
-			       out->stride - obj_size)) {
-			return -EFAULT;
+			out_ptr += out->stride;
+			in_ptr += obj_size;
 		}
 	}
 
-- 
2.34.1
