Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969DC421229
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408078; cv=none; b=W4S74dO3GmJDP7tm8fju6AEvlWmGlIsEIrjpCc0GY3ROXmNQhU/JqeQ/P+TmZ5IKI/pBF8Jt8rCOyYfxxG6gaKikughNZYD7fO0UzHUeBFNJdsTnwsB1HidcTMUsj1IjF/GW67L3xQ1JoInTwBrRlfIN1rjJd1BGUFxxA/racK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408078; c=relaxed/simple;
	bh=gzKJo6kSPF0Etgl2JUkdQmEtAjpWBSucotXjh/s+Gp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7A2XsPfpfbH/fZItfRxnyf4vkwB5tmEb8omorSUCFIG9mdATsRZIyA3pzHh/STKs52ajAMQFVouQseGdDSupl/wRsQ2zfmnxqrxiqsOIRVfB9tUKWWn7h/qBFgy3Mprx8qi/Pk66124JtYFLAHU/EWuyz+TyBb56VTP9rcfb4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hknjCMeE; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hknjCMeE"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5e6b5794d26so56848e0c.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791408075; x=1792012875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LOpZSgzRV4NwYdKLmYPXK96b+o+B6wygQfoMMD57LmQ=;
        b=hknjCMeEhU8ycyd+CNzL4NztEfRJZKGZcl1pdhHLH8Ge0/+8qfeAlCwTQG9SVCbd6Y
         FH0X2X9Q/b62KV4cUxGNaYhehMrr6iKGgtYTfPjOBzqTNEFGDltoPQg6N8ghPHzb2rmY
         Rr2B6QX+ttEFlLi4TsRvobhh95564Uqe9Vpy3imOBJ2FLSKK8e7tvsYdZ+eEaSRzcNNQ
         CvA3q2chtL3Nu0+m3jPwp19GWlDiMlRXX0RptjDGxwMlrHKqyhqxSd/Njn4L9NtGb43h
         RPh56ZQigUWe6ZQqpC5Bj1uBE3Yx5iTYsTzNnAhQzGEzyiTVrQh7fUB55QM3q/vxz4rb
         Wxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791408075; x=1792012875;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LOpZSgzRV4NwYdKLmYPXK96b+o+B6wygQfoMMD57LmQ=;
        b=b377qL0foZfGeWXgE+hWLPiJ3VfngL+sTP1dJlYSyKz6WkDU2ZBeqWjzIu9l8vEliz
         kY1tCzmryqTboq3s15dj7WNym3z3/tR+kbrk9gbgYP7PK5irGVVro1hECaixfAmC6Q42
         CXqOAZLjfnGu6IpxcAfEZVEevs29tt+VrZ0KBbG1BC/XCrsvsva7LCg5tnF4jqwwlO5G
         bHM4a4MxremyYGnrfKCxcJbmoem29M5EKM4XR76y51LaA6yzkgijXVSc5LOqN6RtzJK9
         vxpSnf1wR/zC2tGmqnaQQPOmaUhr7KxuZK8FY2glGNkhtoS/52wEB63C5h7ZtMu4EWn4
         8JDA==
X-Forwarded-Encrypted: i=1; AKwUvBxWkk0RNnlGuz6L05Uam/tkY0jel6eAZbIWYbPxk5Naf5xK3BNP9cuwQAIyxWnZgMhFBbaqZSg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKc78MnBwkuDKJMO9zwwyJ8tDUNA0Ao5hd1OSgvBkKy2d9ONlsr
	H2cFWACENVgMJqQjDNyLZnOrfSfmyns/FG/D72itvhcKL7eNHZ3qqLJJ
X-Gm-Gg: AYBFou1O5V64BMCqj2CXuVNMJSbxwpqvxICNcFhdZidx/2zMjk0CGUr9iJ2WtS8bJn1
	ZSnScyXJuBZtY6hJB88MhCUCnF765QUhhVZYojdM5/oGZt95DlUpFYsv7Q5rAzcmqM4OsZZwBta
	z92KIBAElSXyWwd/hFYoeW130nsINSwxja+2wq9kQcYa60a+4E2KDQiA+UhbAENBTjI11S66bou
	M7Fcuxt1JKLNQrzRcsMNPEHbNVk3Zoc/ffnS6MRIn80KxYwHx+q2bGQuoXA7huQxMd9vYmxE+bz
	8r3wttqtcfr2htSYlb1ZY3xiOcndXeNbOM/MimBG/1k/bP5GTfLsWqoDG97rz7MZiftCSRWV5tW
	d8W+guIgyw2LwAUqPZSCCphZRWt7K4yedZQPts7Jarv1QecCjbMWC8Jr5NtziwaHOujYbGc5YAK
	htXVso8/QQk8hmJ/wMdr2G0VbZj975vuY0i6K8k2CDus+PP1G8I31QoHFbzc8JkuQ=
X-Received: by 2002:a05:6122:6849:10b0:5cd:4fdc:4c30 with SMTP id 71dfb90a1353d-5e82a137713mr88297e0c.8.1791408075168;
        Wed, 07 Oct 2026 14:21:15 -0700 (PDT)
Received: from beelink.. ([187.13.30.250])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e6c4d62704sm3115891e0c.10.2026.10.07.14.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 14:21:14 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org,
	maaz.mombasawala@broadcom.com,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 1/2] drm/vmwgfx: return an error when a shared GB surface has no backup buffer
Date: Wed,  7 Oct 2026 18:20:48 -0300
Message-ID: <20261007212051.2574235-2-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007212051.2574235-1-qwe.aldo@gmail.com>
References: <20261007212051.2574235-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vmw_gb_surface_reference_internal() rejects a surface that has no backup
buffer by logging an error and jumping to out_bad_resource, but it never
sets ret on that path. ret is still 0 from the earlier successful
vmw_surface_handle_reference(), so the ioctl returns success while
leaving the reply structure unfilled — user space is handed a
"successful" reply that was never produced. DRM_VMW_GB_SURFACE_REF is
DRM_RENDER_ALLOW, so an unprivileged local user can reach it.

Set ret to -EINVAL and, on the error paths, drop the reference that
vmw_surface_handle_reference() took; once the ioctl fails user space no
longer releases it via DRM_VMW_UNREF_SURFACE. The unref is guarded by
ret so the shared success fall-through keeps the reference the caller
still owns, and it also plugs the same leak on the drm_gem_handle_create()
failure path.

Fixes: 14b1c33e8429 ("drm/vmwgfx: Add new ioctl for GB surface create and reference")
Cc: stable@vger.kernel.org
Suggested-by: Zack Rusin <zack.rusin@broadcom.com>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd0563741e89..97966d849583 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -1720,6 +1720,7 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	srf = &user_srf->srf;
 	if (!srf->res.guest_memory_bo) {
 		DRM_ERROR("Shared GB surface is missing a backup buffer.\n");
+		ret = -EINVAL;
 		goto out_bad_resource;
 	}
 	metadata = &srf->metadata;
@@ -1758,6 +1759,9 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	rep->creq.must_be_zero = 0;
 
 out_bad_resource:
+	if (ret)
+		ttm_ref_object_base_unref(vmw_fpriv(file_priv)->tfile,
+					 base->handle);
 	ttm_base_object_unref(&base);
 
 	return ret;
-- 
2.43.0

