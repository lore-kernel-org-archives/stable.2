Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AD544D73
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112221; cv=none; b=YDsJeS1rQMOU9/ElycDE0wJRvqp/5Ssq3x1nyke810MUt0Ug+n5vggr20rHmsqEig2Bf2OLyG8hbT6cfLrTzebdqCCWajAFx0OQrUtzICos4rh2o+pzrcfFrr1p3wxRdwX1xXQp5XYT0pPZoPSA7xhvBDOZPKJE0FViqKVWTwIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112221; c=relaxed/simple;
	bh=AlSlcPYnumMfsHWLI8E2/3DOLCtkJ3v64sHsrc12i/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7gVN2OV1Dtxg7oMxt2khZyT1pkf6/pgOXOrMxLl2/Wia1CGG2U/gX5aI4HH3Lha4LB7V4pPg7w98/54Tldsp5pqUnNnKfWG75JdZFLOKyzAxUYXyIlCN3HvlUO4DtR0Z3Z+ym7w/ISAHzy4/ubizf46BND81oioDl2FFehybFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNb5C5t5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNb5C5t5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF7D1F000FF;
	Tue, 22 Sep 2026 21:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112206;
	bh=2NyUtkKhGLVkGlEUD9KkLnEMMQ29YZWIJoocC5sHgrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZNb5C5t58IPgxOZ1J6c74Y+jGHEeFDbVTkZxGXXgOesstq96TkHDrKJZTXyySgatR
	 ekpVqrFjwcgIc3BSp7Oo5R5EOLnM7RU4QDBL3J2uiREWk5sm9X5VNN6BdptWJ2mEzH
	 yfELLrNekUGZzIHbmMMI3sBZnNGM9t4tBojCqlePxLzAUA4P2ZsVGGom2nKK9+QjWb
	 SC7zm0n2uwRNKQPfSVZmkLzVVYIsvGVQRokg/plwtWbYCF4JUSX7fxSyyecKogTDVy
	 /IJNbsdU3A8ioyH3I7s6tJZMd1WJtO7V1NqyNc4dkTpI99YLti4zOOOQdim098uWDv
	 JqL3a8cs8a1vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yunxiang Li <Yunxiang.Li@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm: add drm_memory_stats_is_zero
Date: Tue, 22 Sep 2026 17:23:23 -0400
Message-ID: <20260922212324.752416-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092255-footer-unscathed-ed09@gregkh>
References: <2026092255-footer-unscathed-ed09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yunxiang Li <Yunxiang.Li@amd.com>

[ Upstream commit fd265d9e0c3358e6b9fe244d8f5d2824fda1c0dc ]

Add a helper to check if the memory stats is zero, this will be used to
check for memory accounting errors.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241219151411.1150-2-Yunxiang.Li@amd.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Stable-dep-of: 636139603b99 ("drm/amdgpu: hold a runtime PM reference for P2P dma-buf attachments")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_file.c | 10 ++++++++++
 include/drm/drm_file.h     |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index e2cf118ff01d3..99ffbea8b6a8d 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -840,6 +840,16 @@ static void print_size(struct drm_printer *p, const char *stat,
 	drm_printf(p, "drm-%s-%s:\t%llu%s\n", stat, region, sz, units[u]);
 }
 
+int drm_memory_stats_is_zero(const struct drm_memory_stats *stats)
+{
+	return (stats->shared == 0 &&
+		stats->private == 0 &&
+		stats->resident == 0 &&
+		stats->purgeable == 0 &&
+		stats->active == 0);
+}
+EXPORT_SYMBOL(drm_memory_stats_is_zero);
+
 /**
  * drm_print_memory_stats - A helper to print memory stats
  * @p: The printer to print output to
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 2bc88d2d4a84e..92d0f9c5d788c 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -485,6 +485,7 @@ struct drm_memory_stats {
 
 enum drm_gem_object_status;
 
+int drm_memory_stats_is_zero(const struct drm_memory_stats *stats);
 void drm_print_memory_stats(struct drm_printer *p,
 			    const struct drm_memory_stats *stats,
 			    enum drm_gem_object_status supported_status,
-- 
2.53.0

