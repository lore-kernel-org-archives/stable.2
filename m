Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300253163A
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175309; cv=none; b=W0DhRp1G8DDYVVCnS0OzPy7jdUPu6F/0VRvphkkTK4bVeq8m6bzEZu8eUdiER5ORML/XySVfxtLOyG2erzmCWxLK/m9N4zfGQ240QwJWazrhS0AeiLgOamK8JD4Q8ctWIVKfPB9zrL0wAhxklndZu0DCSXfSKJjDtn1lJCnqH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175309; c=relaxed/simple;
	bh=Irzn3KoZz2CPFbn4S9qLAfiWXivutTrsLSXE8ABhv5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZ4x04zbU5r5ugxHn4NM5rars3SM3zZplIQqa93NQcYC/WZDgD3De+ePaWxNHzXseAygX/c3pgxjQLvQA8Eq8gOOlLQ+hoL1FMRHNfFuCrt1vfv6VuWomRPMpqEE0Liu7tRTo221MBxhewUF5AX+1JRZ+XOIkx5Phcv0f8A5EO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAJXxPwy; arc=none smtp.client-ip=74.125.230.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAJXxPwy"
Received: by mail-lr2-f3.google.com with SMTP id 38308e7fff4ca-3a4f7261b56so6997511fa.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790175305; x=1790780105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IYj8DR6tUMAlSBOX53pzMRuQvG2jVj6PU8CNMEIk8m4=;
        b=DAJXxPwyYuMjUl1UVWY4kopRxCiF8/0gmmrFtsSeivWvwcBh+DebL7tf1VVVimPHZm
         ibPkOh/EVG8U4EtAuZUAMJfz4TnNjvbUEMzH4/uoUPAnn5/ddiVfq0KS/K7iBdQtGNW0
         tatcPDkBbOTfgkF1jyZST2J4peaR9a5gMAxUao70QR62izKoMSltTKQgPDzez9y7R4t2
         Bou2YN5L8C6lmHeANHFQTumLKsr+wTPw3NCUynj65cfu8Md4I3adf/Whl2hO6al7aMot
         S3Y1cey44JMXSWTWmSr5y1C4aoFEbHH/1OR7fEda1W2Vgdi7DsK/UDUSQzkdgdwHbx3S
         J4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175305; x=1790780105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYj8DR6tUMAlSBOX53pzMRuQvG2jVj6PU8CNMEIk8m4=;
        b=ZDo+lLObaXN9CS3ySqo/RYS8Z4CUjJ0PV0KhTI4fZBuWuPznO+whgTNotw8o6SHEcf
         QEXk5tBzUfYJp/c9r5diu8r4hUgdplaLM6tCRomF/AL1lmb0Dc9tEaHpTXLUQvE1vFlA
         5yZX8KVig/VJ8n4cIixqvcODQthYGGzJxiEy48h1JQG9Rs/RywfJGG8ANsQareN2a82T
         q28iq7hpFp3TMmfXHyP6bQcp6WCUSPGS7A4fneaBgfO06M3jb5/CXHdUEaesQphcKljR
         Y11DRxHMmTIWxiA1mBAtYY1p6sBbg0iGfydMEyGWcgDrtDJlX6ZZelimNoj6S37yx8NY
         UUTw==
X-Gm-Message-State: AFuF++mlRq2NnBAlzJeyU+D775vohpLH0Tai+iHZL+vZVmWdixLBpcKc
	vnFkLoOKJvmKKKI5s3kiP7VTJxwKI+eyZ5gLkmLVIzR20CyPOI86yGNfbe4Kdb+Nu1k=
X-Gm-Gg: AYBFou3gPdvYbe3bvqlRJY42qo3AsP6rY8hv+CbIE7CupoEHQP4QVibF+9h2p9xwti9
	ZRSfLMEYs5Bj8ZPSsoB4Vpi3nrIy8Zuwmj4Mwd2kAufZ1Za+0PwkAdmZh+ZW9VmyAonaTj0TfQS
	MhGyejAjaZLVHgzQCCdzkGxIyLlVOuy113UUXzEANNF3QZJIz28G9TfQ39hHWAA/PHbblDjgtIU
	umO6FQj3ICHbfVEEjsD8I3aGIQ7997vLsmDfU4pIF1WL849mlXo4bDNuRMmURvS9IMXbHUstOid
	Ui4HD34ErxSNqr+EJZl3Bi+5t5gPi08EcEMUKi+ePSn8BPsARacijXh8hTGw4q1C32EHfp9HHba
	wgn9Lie49xlVAdc3Di/yqu8333N3ABTngM7L+ewBJLk38HHPd0Wenyu06fB+IpfNcUtiZmw9vtJ
	KufDeYyvSL1dwPEVPiOhZ8gww1B/rVrU5q0aBBm4J2VauDb6qm3Tt6mQszPO5WgjyXenforsN4L
	Y1b+VhbvBN0IK2T
X-Received: by 2002:a05:651c:a381:20b0:3a6:95a:52b2 with SMTP id 38308e7fff4ca-3a630659a31mr4896841fa.28.1790175305364;
        Wed, 23 Sep 2026 07:55:05 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a62f527d51sm7824951fa.33.2026.09.23.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:55:05 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Fang Wang <32840572@qq.com>
Subject: [PATCH 5.15 1/2] drm/amdgpu: Use vmemdup_array_user in amdgpu_bo_create_list_entry_array
Date: Wed, 23 Sep 2026 17:54:48 +0300
Message-ID: <20260923145453.76114-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

commit c4ac100e9ae252b09986766ad23b1f83ca3a369d upstream.

Replace kvmalloc_array() + copy_from_user() with vmemdup_array_user() on
the fast path.

This shrinks the source code and improves separation between the kernel
and userspace slabs.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Fang Wang <32840572@qq.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Stable-dep-of: c833d6c7199c ("drm/amdgpu: Limit BO list entry count to prevent resource exhaustion")
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-23468

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 41 +++++++++------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 9fb8012007e2..22d7b7c504db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -224,43 +224,36 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
 int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 				      struct drm_amdgpu_bo_list_entry **info_param)
 {
-	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
 	const uint32_t info_size = sizeof(struct drm_amdgpu_bo_list_entry);
+	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
+	const uint32_t bo_info_size = in->bo_info_size;
+	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
-	int r;
-
-	info = kvmalloc_array(in->bo_number, info_size, GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
 
 	/* copy the handle array from userspace to a kernel buffer */
-	r = -EFAULT;
-	if (likely(info_size == in->bo_info_size)) {
-		unsigned long bytes = in->bo_number *
-			in->bo_info_size;
-
-		if (copy_from_user(info, uptr, bytes))
-			goto error_free;
-
+	if (likely(info_size == bo_info_size)) {
+		info = vmemdup_array_user(uptr, bo_number, info_size);
+		if (IS_ERR(info))
+			return PTR_ERR(info);
 	} else {
-		unsigned long bytes = min(in->bo_info_size, info_size);
+		const uint32_t bytes = min(bo_info_size, info_size);
 		unsigned i;
 
-		memset(info, 0, in->bo_number * info_size);
-		for (i = 0; i < in->bo_number; ++i) {
-			if (copy_from_user(&info[i], uptr, bytes))
-				goto error_free;
+		info = kvmalloc_array(bo_number, info_size, GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
 
-			uptr += in->bo_info_size;
+		memset(info, 0, bo_number * info_size);
+		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
+			if (copy_from_user(&info[i], uptr, bytes)) {
+				kvfree(info);
+				return -EFAULT;
+			}
 		}
 	}
 
 	*info_param = info;
 	return 0;
-
-error_free:
-	kvfree(info);
-	return r;
 }
 
 int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
-- 
2.53.0

