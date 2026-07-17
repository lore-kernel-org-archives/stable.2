Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392942903D
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298168; cv=none; b=hP5Sw61WTt64YXUzL2itGxuOgSb2eMwjwFMCSkR+Mj7DKvnEaHktvnwwy+lLkvu9ksK47Zbzbig29vparaNnmZH3aZnf7jnKdFpH2skoT3Fld3i87mezeM+XBmaTu4YYAix+vsQJ3k4rAEY6DVWBpOJcT/QX5yulTfMlTE8L9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298168; c=relaxed/simple;
	bh=Lgs9P96j95lWhIEL/yHTC4H4Fd5TvvC887cXqyZgXY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmT+8n0mqPyl0uKQV4+HC49gRIdbZGuTSuP4JJfK9zwaPIY4yTUaeKvV/WwOJF1gFNLUiiUQ5z22RC8L7J8IH+i0VT+/4fsOAb91tS4r+YHd3mYH+TNMSSJUFXsfUWKhU90LqMDK1IrdiomdrovJNJb8oG5TG8NjTJVZgnuh0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0sULqoN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0sULqoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5071B1F000E9;
	Fri, 17 Jul 2026 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298167;
	bh=GQ7/2qzEt8lZJSsWd9tb0zm1n6LY1MaigtiNVF9TET0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b0sULqoNuLejOJDhUimEFs+vHii3lv679UmtcBk3I1U+0l6F/jxjUy2F9HHkyiuG0
	 nJWUXf+0zT5J2J5u9BUDoGzXdxTgIGLIrlr71wZ90O781Uh98FxT7P3Xlz9k3T7SvJ
	 WALRu69ym2WRNZ8jEU9E+FpgymxDlOBML6XRj3ta8D1rnlDXk9AgqCcsST1L3Xat7o
	 WuP5re/RpK/xRAiCsseY3Ebxt/x4m/bhvWY9xKltMAOUnnBa62vDeCyriWaA1pv/ka
	 synRHSCMYIqQv73lDcmOgwLYyDy/m/Z2r+fvdf3Mbt3Q+crgdUvEVoeH8rLbgj0V+U
	 Hw3/LCc/EgZZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/slab: do not limit zeroing to orig_size when only red zoning is enabled
Date: Fri, 17 Jul 2026 10:22:44 -0400
Message-ID: <20260717142244.1820826-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071403-afar-policy-60a2@gregkh>
References: <2026071403-afar-policy-60a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>

[ Upstream commit 648927ceb84021a25a0fbd5673740956f318d534 ]

When init (zeroing) on allocation is requested, for kmalloc() we
generally have to zero the full object size even if a smaller size is
requested, in order to provide krealloc()'s __GFP_ZERO guarantees.

But if we track the requested size, krealloc() uses that information to
do the right thing, so we can zero only the requested size. With red
zoning also enabled, any extra size became part of the red zone, so it
must not be zeroed and thus we must zero only the requested size.

However the current check is imprecise, and will trigger also when only
SLAB_RED_ZONE is enabled without SLAB_STORE_USER (which enables tracking
the requested size). This means enabling red zoning alone can compromise
krealloc()'s __GFP_ZERO contract.

Fix this by using slub_debug_orig_size() instead, which is the exact
check for whether the requested size is tracked. We don't need to care
if red zoning is also enabled or not. Also update and expand the
comment accordingly.

Fixes: 9ce67395f5a0 ("mm/slub: only zero requested size of buffer for kzalloc when debug enabled")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-1-7190909db118@kernel.org
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Reviewed-by: Hao Li <hao.li@linux.dev>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slab.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 62df6eeeb5ead7..cd55e4a7678d91 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -734,14 +734,17 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 	flags &= gfp_allowed_mask;
 
 	/*
-	 * For kmalloc object, the allocated memory size(object_size) is likely
-	 * larger than the requested size(orig_size). If redzone check is
-	 * enabled for the extra space, don't zero it, as it will be redzoned
-	 * soon. The redzone operation for this extra space could be seen as a
-	 * replacement of current poisoning under certain debug option, and
-	 * won't break other sanity checks.
+	 * For kmalloc object, the allocated size (object_size) can be larger
+	 * than the requested size (orig_size). We however need to zero the
+	 * whole object_size to handle possible later krealloc() with
+	 *__GFP_ZERO properly.
+	 *
+	 * But if we keep track of the requested size, krealloc() uses that
+	 * information. Additionally if red zoning is enabled, the extra space
+	 * is also red zone, so we should not overwrite it. So limit zeroing to
+	 * orig_size if we track it.
 	 */
-	if (kmem_cache_debug_flags(s, SLAB_STORE_USER | SLAB_RED_ZONE) &&
+	if (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
 	    (s->flags & SLAB_KMALLOC))
 		zero_size = orig_size;
 
-- 
2.53.0

