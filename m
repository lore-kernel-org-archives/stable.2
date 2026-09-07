Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478EA48B397
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783495; cv=none; b=j7bVLzGlW3mqGGn2ShQKYNV/2kyqj6CVAhUVtOFFsFK1Wjhar78ftOhAiltS36oxl64DNn7nzObseBxJtn8i4VtIEecXXCI5gdI5ZcShXoSZ/D7hEvTh0omFlJv7vj5iq2KczQHRyRl46Xn2c+usGlxaeL4g3UcRR2tC2B5lc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783495; c=relaxed/simple;
	bh=LYnwUEwJzU5eJuUV3p/96JuI4kii977npFTZZOepNH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ldc6Dxxmej9/RyfYSqD0BVbbzOP1RZ/cXw0uuLqgOeu+aTlnvinaQIdwJomKXDBzKEUNz4bGOqS4yzmePm3K46E1WEIkitlTkZ2NFW/Sc9YHb9jfWjDyLcIw3EjNI4S81Wt8A6FkyyQYlhW/F4yMEe8Qn6gptAdKmMT8GurngAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR51r13T; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR51r13T"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a68279dd86so4245104a12.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788783492; x=1789388292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oMsCw8GiZTKqLZR6QIiDUwMuQHXPEn7isoxeheHJ5mw=;
        b=NR51r13TAIhWgx/vzWMr/PMzJICFDUWkGnmWvez4JjYHjP6/kuLbqCleILh9Q+gWKW
         rEJWyZfO1ubMd39d6HBsn4hPbblSppDchXDStLkHctKA5EUZB9hhBCr+MCKNBd4Doe1H
         EBcsxHWpVwjXhcoXMl40isHcCFrAMz0SqFXFRpWrbF/OF7dS0SLx+oP2e1Y4+FQCsu+F
         ZGKCWQ1yMQzTzk52kLKrD5jtRn+P+51OitLG2xZPhj10mW6PgQ1CiSZGFUv/3soOZsJm
         X4nPx5Gz0Osb2IY8nErcS7eUj8H78Lr0WFYl7/fcYDXs2Jw/DD53Xd9x5eWjIACD/ZeC
         2KBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788783492; x=1789388292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oMsCw8GiZTKqLZR6QIiDUwMuQHXPEn7isoxeheHJ5mw=;
        b=C8XIoMus89joAJniaPmzFlbP+hCfkZKzg1KfAPSB7UAXcBJUBHrQoWEQfLl5oS24n+
         uKBOgU/j1xalYJJ9sIXQzhx7bBYDxOGtqPg1WggwMF8BfOcfEkMERXpAFj+C2XzoMsrk
         0lrEImMy/fCHtlPXne7XAoKqv3y1O59SyH/fus2bzX7YWPX6XF9sB4DZ4hLWJ1ap3+3y
         ++1w8Y53QdiifZuBTMXk31yxxzRvEH6eLWoHNMw1u3vW7jL7rLh1VKAYqy60NFNLCX2i
         DO7ILO10012KWdqUDFSVGlLP/o7QoOEBmbCqYrcMYkpxeik4TLuLBnIHV9pxZxqOPx5n
         SBwA==
X-Gm-Message-State: AFuF++nbHrNL7TjiWoBGR/oIMGQOC//wM2/8CYtyeiYasN+/JANQWSr4
	gB9A2OZaR8S9Dkh25lvxteJBCk8rvaE4tFSa0tNezeYJhlS3FDEb4ytXCHzPD6lF
X-Gm-Gg: AYBFou1T5MGOM8REj8EO193XbvsSWsyXQlq4w43BZYWOsroad/wwb9P0Q5TiP/01YFL
	tYoHnE1HZebciJIMN9JqJObGbwasV6KfBCJFihdw9UdxbPOsIffn7+vEquVGXuNVRholeYZtbR+
	QhpWiGQemsyZ3zi9yhiRpp+MZQNmI+Wdd0rFiZwdT6pxXrDBPfqfseJL0tItg4YDBnOtIFCI2Kv
	pMzoyOGLRTKlcInJGD7qam9WafyfUN8/qffku2Ewxd/J6fOUk4B0nJ7eQp1aalpIqTU/gH0epRt
	6hbhMXwZd4hGPFLI9izMrVf3oLsBPfQwl9G/Z4QptYmenc9O9TSMQzfthNj1I1bDSkNUxtMkWW7
	yYAC5aoV0ihFCe8TzX+T6GZf0EgC0+pLBiKAskTp5v6IpMuvM5145lDyat2RDH5pykRwvXJuTxw
	/M+K7gEySulMmeuD+SMZSxENqdN3jow6wITj56PhrsVsz4mNGDc1loRmI/GG/rUWg/k4Hevx8=
X-Received: by 2002:a17:906:2099:b0:c28:f9e4:836c with SMTP id a640c23a62f3a-c28f9e49c9dmr85196166b.28.1788783492029;
        Mon, 07 Sep 2026 05:18:12 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5921e2sm466938166b.46.2026.09.07.05.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:18:11 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	VMware Graphics <linux-graphics-maintainer@vmware.com>,
	Roland Scheidegger <sroland@vmware.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Jakob Bornecrantz <jakob@vmware.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Zack Rusin <zack.rusin@broadcom.com>,
	Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH 5.10/5.15] drm/vmwgfx: drop dma_buf reference on foreign-fd prime import
Date: Mon,  7 Sep 2026 15:17:49 +0300
Message-ID: <20260907121751.126950-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zack Rusin <zack.rusin@broadcom.com>

commit f739416dc555fa205a785e5135d73fa39b26f35d upstream.

ttm_prime_fd_to_handle() returns -ENOSYS when the imported fd's
dma_buf->ops do not match the ttm_object_device's ops, but does so
without releasing the reference acquired by dma_buf_get().  Any
unprivileged renderD client passing a non-vmwgfx prime fd through the
DRM_VMW_GB_SURFACE_REF{,_EXT} path leaks one dma_buf reference per
call and indefinitely pins the foreign exporter's GEM resources.

Funnel the error path through the existing dma_buf_put() so the
reference is always dropped.

Fixes: 65981f7681ab ("drm/ttm: Add a minimal prime implementation for ttm base objects")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Reviewed-by: Ian Forbes <ian.forbes@broadcom.com>
Link: https://patch.msgid.link/20260505222728.519626-6-zack.rusin@broadcom.com
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-80888
 drivers/gpu/drm/vmwgfx/ttm_object.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 16077785ad47..39ddb74ad07f 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -658,14 +658,17 @@ int ttm_prime_fd_to_handle(struct ttm_object_file *tfile,
 	if (IS_ERR(dma_buf))
 		return PTR_ERR(dma_buf);
 
-	if (dma_buf->ops != &tdev->ops)
-		return -ENOSYS;
+	if (dma_buf->ops != &tdev->ops) {
+		ret = -ENOSYS;
+		goto out;
+	}
 
 	prime = (struct ttm_prime_object *) dma_buf->priv;
 	base = &prime->base;
 	*handle = base->handle;
 	ret = ttm_ref_object_add(tfile, base, TTM_REF_USAGE, NULL, false);
 
+out:
 	dma_buf_put(dma_buf);
 
 	return ret;
-- 
2.43.0
