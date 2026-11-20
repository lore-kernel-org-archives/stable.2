Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175958;
	b=k/EKjnvpUkO5SgnHeLXGW91xMv5S30Em3jkWje3h9rY52AeDFy83yBXRJtJqEQsfLADl
	 4VxjCbId+EsEj8jVOlKCUjrHDyRcOw9h09iYZtE55+VttMLxKzuMg6zHSp+1XZ7AEPBOC
	 ewoKWXxFU24diLQH19HE6uSOENg1pRhiiPiIY0Da1WOPXSHEDDWJujWUbdMmlg8A2oTki
	 IYrWTzys1n172zRhmefHdneGShxHE7O0fPU68n+hw3hftSVbuwuyDZBsI/+ZJeNIuPG3k
	 6dWDKaTi7prh31o66aydVtEGj4RLF5eJYPrSjbeTTYnHCAKPNxjGioFXWyRAUqbzJ6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S6IS/mU9CGQB+CxcqZArg7eMwtn8KJF1AGNkVI6J8eA=;
	b=teNYz26mKqb3Muv11HQi7LZMTyg7lvsIN7TV0yRrxENCStmeDwN0ezL50YSlKm2ARno5
	 J4w2fHRSbXJENGtxTUEnuqAYKM/ua7cjIQBsrnAR499LFLJiy/feHCl6rgI9VMQOdRnQ5
	 pFEfA4sIrdlqV3cIVBSyDHvBbqOs0BkPtH/0SgvtXi7u7QWSsxmz9QntAe+pB54BsIJeE
	 fhLzFXjmEvwDsdGj4kO9Wn7lkfv3qHCHw8cPgyqq61vNJH4zedP2hibhDl3uTzAwCwOjO
	 xrFJiSwhRHgt8b5yEKdZaZRo3Ob674B0fiWrDQlT/UxQluIXyqeZ3IsPDbbeAWRAygg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LeYD9kP3;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301EE606A326
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 301EE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LeYD9kP3
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b3a42a4bcdso408996a91.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 03:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795175957; x=1795780757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S6IS/mU9CGQB+CxcqZArg7eMwtn8KJF1AGNkVI6J8eA=;
        b=LeYD9kP3LEkPFodkTZtvjQYkemxgiuqkO0RIBQ6B6V4n7J9B8Ar3paQvjquel/w2rD
         bx7HN2K9tJFqK0nYnC2e9vly4Tl98pmxNmDNCz/CrZ9pCZAYlwM5Yd2Dia22kaG00+Q/
         rfZVgbFkxHz0S0kZS3f048oEHHCEog+LauqiLE7eV9ZxA6tjI/od2i1Ihz2ISt5YGLcO
         G7CjbtpABjFtoGy+GejsInpDrIlbCojwLFlcUbV05rfCV0RdVWrv7lXMfCxYFPm9/G9w
         OsmnIXLrHEMGxEipj05BrJCa4nDWIRAMMwsE/NgO9+cnh9VwMxCVCpczlBFxm+4pZ2be
         7OdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795175957; x=1795780757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S6IS/mU9CGQB+CxcqZArg7eMwtn8KJF1AGNkVI6J8eA=;
        b=l4VX7nWsYjZrFm1oBc04PcoSbfApnOZFV/6tkYvzB6d7RM+V8h52leVo+tTcivVaFi
         p+QR4VGWoXFEQukQTd5qpVNjAFcnUzI728ADYXU73tgbutmDnYgx1SYtWKqTgFx5o6Af
         aGfK3UA0fprpAJFfjbDynx39izIAXGwNBBIgCHFiIAQfygH9xJXob3N1rGePQbWlA5j7
         +4miSxgkI21GR44Atekb+kfHRa9PxQl1b11CmhoWDX4lMlilJbDbzKWbo8h1Xh9aFry/
         ErRfd8rG4Jy1TqGvr7AywFmJU+wk85GpNHy5VHIsENWsvzmmwPrj6aHdohdYnppbnI8y
         u06A==
X-Forwarded-Encrypted: i=1; AL+hErEonltTaOWN28akrEVPjlMjlWN3T+uiL9dlB8oJhl8EOaZcj4qdM/xO4QJ/cQryGfL2lDSDQ2o=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YSFEQhCAdiOGdSlcFKl4vtIgcVgLWlshQxUnrHXivyhcwLmZb
	0yc1dIb7gNM+TtTSN2nkhidgTjLm3STipovATflq8Ro2815UwPeDtq6+
X-Gm-Gg: AZFdTZf3MJcRBkOtGKY2N3/Z0EsfOpIMlXd+MU67GcXTQy1BSl1agP++hSt8dIwUDC1
	nLSdBEBl7FV9bpyJ7FNlgB0Wwyf+paSDZj6f83ztbFXwrm6AJumec4xL7PIVGV3WWchebFxCzOO
	yyTAmxaAUL6B/TKNmEfdigQBZvIlM+lCuTbR9h041WOHrP+gG4DBjl2qTBHGvglpzwh92B/T3L5
	MN6atT66/pcNVI5xCLUWDjUMtwdJyHf2WmJF9LEnogTC9LsQQl96P3UPr1ZGXRfrsC9R/SyWbM+
	bLsZmfW3orxJClXYzFTQcLq0zFFC77Bvhvw3fB35MxHzMaJ44r/d3rXos9Osn1PkGygJdokOtY5
	3sfivE0tskogjv/aFR2iTLqv+7lbUzAFfzXMfaO/6iHeMl1tRns6xLh51NFS3FTvQEYd81lsn3C
	7N6ShxkPMr+K7Wd6Tf5+RwJhtnjUeTK15iEVQidW9IG0VMP4iIChHw+inF87OKH7yKzfKgoncn5
	eIHhUBtADr9CB1fndtbWNAZA/Gnlem18YUskV4+53cgG1TKUWrqdiv3yzcbt2RafuzizzXxYB1d
	XAfu6q98Xu6sJCJ5h1llhTP9Sb3Tf06qp9hdBI6MnioWqLI9dw3N7PnDvVP1VbDvkpshW692Ki9
	C4YorU/3V6w==
X-Received: by 2002:a17:90b:2cce:b0:3a4:967c:6947 with SMTP id 98e67ed59e1d1-3b41c909001mr2615121a91.21.1795175957247;
        Fri, 20 Nov 2026 03:59:17 -0800 (PST)
Received: from DESKTOP-TPPBPA1 (36-226-249-217.dynamic-ip.hinet.net. [36.226.249.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0575d9sm1226566a12.25.2026.11.20.03.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:59:16 -0800 (PST)
From: Roy <rongh7426@gmail.com>
To: mwen@igalia.com,
	mcanal@igalia.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Roy <rongh7426@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/v3d: Don't free the core's sg_table when PRIME import fails
Date: Fri, 20 Nov 2026 19:58:40 +0800
Message-ID: <20261120115840.417741-1-rongh7426@gmail.com>
X-Mailer: git-send-email 2.51.1.windows.1
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

When v3d_bo_create_finish() fails in v3d_prime_import_sg_table(), for
example with -ENOSPC because the V3D address space is full, the object
is freed with drm_gem_shmem_free(). At that point obj->import_attach is
not set yet, since drm_gem_prime_import_dev() only sets it after the
driver callback returns. drm_gem_shmem_release() therefore takes the
non-imported path and treats shmem->sgt as its own: it unmaps it with
the V3D device, calls sg_free_table() and kfree()s it.

That sg_table belongs to drm_gem_prime_import_dev(), which then unmaps
it again through dma_buf_unmap_attachment_unlocked() on its fail_unmap
path. The exporter's unmap runs on the freed table, and the kernel
crashes:

  Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
  pc : dma_direct_unmap_sg+0x84/0x260
  lr : dma_unmap_sg_attrs+0x60/0x148
  Call trace:
   dma_direct_unmap_sg+0x84/0x260 (P)
   dma_unmap_sg_attrs+0x60/0x148
   drm_gem_unmap_dma_buf+0x38/0x68 [drm]
   dma_buf_unmap_attachment+0x3c/0xa0
   dma_buf_unmap_attachment_unlocked+0x58/0x98
   drm_gem_prime_import_dev+0x1a0/0x1e0 [drm]
   drm_gem_prime_fd_to_handle+0x1a8/0x280 [drm]
   drm_prime_fd_to_handle_ioctl+0x40/0x58 [drm]

Users have hit this on Raspberry Pi 5 with Xorg importing vc4 buffers
into v3d.

Clear shmem->sgt before freeing the object, so that only the PRIME core
unmaps it.

Tested on a Raspberry Pi 5 running 6.18.39 with a small program that
exports a vc4 dumb buffer, fills the V3D address space with BOs until
creation fails with -ENOSPC, then imports the dma-buf into v3d. Without
this patch the import oopses as above. With it, the import fails
cleanly with -ENOSPC (60 runs), BO stats stay at zero, and imports
succeed again once BOs are freed. The fix was tested as an out-of-tree
v3d module built against 6.18.39; this tree was not built for arm64.

The bug was found and the fix written with the help of an AI coding
assistant (Claude); I reproduced and tested it on hardware and reviewed
the change.

Fixes: 40609d4820b2 ("drm/v3d: Use the new shmem helpers to reduce driver boilerplate.")
Cc: stable@vger.kernel.org
Link: https://github.com/raspberrypi/linux/issues/7504
Signed-off-by: Roy <rongh7426@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_bo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index db95a2f..d0b672d 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -185,6 +185,13 @@ v3d_prime_import_sg_table(struct drm_device *dev,
 
 	ret = v3d_bo_create_finish(obj);
 	if (ret) {
+		/*
+		 * The sg_table still belongs to drm_gem_prime_import_dev(),
+		 * which unmaps it when we return an error. import_attach is
+		 * not set yet, so drm_gem_shmem_free() would otherwise unmap
+		 * and free it as if it were ours.
+		 */
+		to_v3d_bo(obj)->base.sgt = NULL;
 		drm_gem_shmem_free(&to_v3d_bo(obj)->base);
 		return ERR_PTR(ret);
 	}
-- 
2.51.1.windows.1

