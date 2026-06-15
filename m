Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE1A2F39AB
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781559979; cv=none; b=HuJAZFWOiSBuUTu3TQbrxap3gZorVjkTG4160s8KnrYvLBe4YKuu4kekajaoE4JNcb+f8ppdhM4H9orW+m45x8TgmHfyLiKB/cuCoTQaWYTzWH4/0NOIZpn2/zxsUPoMx98KvpS2TV7wTy7B2bwFnuzo+yHaWRbWjBLbaJ5n0ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781559979; c=relaxed/simple;
	bh=1IdWJSsooHpRWnlvtfAwsDPz6wI8yPfuVVKZnegPiWY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EprGeZVjjTI1Xott2eKfF1Rek1AiYs5qMCLYDqzDAH3GkqWT75cBlcyknfglGq7cHbk8DEQMYOxJcuwCsRL7X7KH00+dLhWbGwO1h6A/nXX/nv4ySEOjBRchr1Q8sxvEw+vqOg/Bx1VUCj/ncz/PFDlxhPmSCRqLfyTdIke8Zt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip0ZPIf2; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip0ZPIf2"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8584bbbf2cso2260756a12.3
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781559977; x=1782164777; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vz6stOMSk3vpFUFzv+jJpjA2EoqJIkxHHZXo5ER0nFI=;
        b=Ip0ZPIf2AZFGF3enB/dktdH89h+aGD2o2cgbJ8SPk3O0Mw80gTZekiJl6Qslhg2NMv
         BkY+xIx8Rw6CPI1J+xIIIa/zBqduSbmX0s4bO33eZdaXc4pzC0JKPu0bRvfkyJSzlGKt
         f0I5RX9gfEvGcMKqb82PTtqr8T5eL1HVrqSnTEr/uEslmSb2rd65GEzS2NIyq1q1CpzB
         BXx1KaCIW5nBt/1HZMOfVPMK6p5uTG0Yw1fn73/hjOtfYg/A8cvKhq9SKbiYTic1BYg6
         0Y6yqgLLqDgoLN/1rj4VGvQrAmKesyCXqKkwH2JmdMRYEs5KZKDUHoJF5x3RelwWbYpe
         raXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781559977; x=1782164777;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vz6stOMSk3vpFUFzv+jJpjA2EoqJIkxHHZXo5ER0nFI=;
        b=dfyp+PGGqQTSFKMrf0ZWIy1AZgkJVGZfdNdL5fME8OPEkAAfRZIdTgIhDih2iur3/3
         dDiV5yKGzPO8lMGu0cvdy4ctUvpFYob3bcc9pshRgf9qmhxhGArqvrYqZ4caXwOZOL/y
         ++TQGJ+ip21gGsjHf0/ucTkj3FxJ/+F4dFc3yc4+GfS/0in1p/gqwxq+XGhL4hrjMsYa
         6Rzs6Mw7d6F38J6u6cIKYaLWSOAW+xx5VLVkW6KY1fGbtwUFpMNxZdTeFBNTSonqspOx
         BMbSZlT3BiMBE6QtMJcoZOTI1mBnOWYfiDSb2c8B9/hL6eJgD+nxswW8mbepUWVndBkd
         9m7A==
X-Forwarded-Encrypted: i=1; AFNElJ8waDmIPQnsmLNOwCu6lnbXTMJ9IZgK8n6EgYxbDhByL0wwLhLRyChjFe2YonnY9Yvi+ZIkVvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyunx4Y6W82N35yzpSmJzDM6ysRT7K8vzEUC6WZE+V4prtf2N50
	UsDbyM9D32kh7GmttxtdRbWco31WgeviDe7i7hbdmgAKluor5V/hNqd5
X-Gm-Gg: Acq92OEfD+ZOD4j6XIDZlDigOPxp2p1DcdbrLrKOts7+1Qg0bn7xkjSymQmp72FlVcp
	hV3pYX2xvOt3opDncTpHjxkXEwn9iIMuDGHl4t62S1crcMNmIIoAslhZr1Gdfk6ArGL5kV0lExw
	YvVCznJFlo5RNrCEEXQxTlzr1c02Lx8PvvcKqgYM3NFMpk6kvo5Ool1C6Q9jPeAMFHm9ZyLqvpL
	B+EC2mirIl0WpZQ11iBGLw2i70JgCUL2+0wTM2g098pRP8NWDNLowdlIgLljSAke85UNBYAo8p3
	yFPVi4PBxUmYdEq9QxIRoqo17c08f/Qwh3btduHgpuh8+JJ+1ZtTS+OK3AOe3hlewOyuuZ71qL0
	MRo/PPTALOmg412IE2rmGlS6vgyKzvMERtWCJyLkBd+7O1OBWoMFEagepw/k7O1IN/WwUhtgcB3
	VQWWnnGKuYlP1pXJezcqYUJNF0GWrS0vn/X0PYLzrtBVCmuAUf5zBRQYhCOFI2BeSXPreW+BXYE
	erdtZnFOXkE7rJCvx5WsbebA3KSnw==
X-Received: by 2002:a05:6a20:748a:b0:3b4:7aae:1ee8 with SMTP id adf61e73a8af0-3b79624cb18mr14017944637.14.1781559976818;
        Mon, 15 Jun 2026 14:46:16 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([103.129.135.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5e509sm9835799a12.3.2026.06.15.14.46.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jun 2026 14:46:16 -0700 (PDT)
From: shuvampandey1@gmail.com
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Donald Robson <donald.robson@imgtec.com>,
 Sarah Walker <sarah.walker@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 [PATCH] drm/imagination: Fix user array stride in pvr_set_uobj_array()
Date: Tue, 16 Jun 2026 03:31:09 +0545
Message-ID: <178155996993.4848.8618351576278880213@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

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

Fixes: f99f5f3ea7ef ("drm/imagination: Add GPU ID parsing and firmware loadin=
g")
Cc: stable@vger.kernel.org # v6.8+
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imaginat=
ion/pvr_drv.c
index 268900464ab6..0a68a9c32361 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1252,14 +1252,13 @@ pvr_set_uobj_array(const struct drm_pvr_obj_array *ou=
t, u32 min_stride, u32 obj_
 			if (copy_to_user(out_ptr, in_ptr, cpy_elem_size))
 				return -EFAULT;
=20
-			out_ptr +=3D obj_size;
-			in_ptr +=3D out->stride;
-		}
+			if (out->stride > obj_size &&
+			    clear_user(out_ptr + cpy_elem_size, out->stride - obj_size)) {
+				return -EFAULT;
+			}
=20
-		if (out->stride > obj_size &&
-		    clear_user(u64_to_user_ptr(out->array + obj_size),
-			       out->stride - obj_size)) {
-			return -EFAULT;
+			out_ptr +=3D out->stride;
+			in_ptr +=3D obj_size;
 		}
 	}
=20
