Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F5031F9A5;
	Thu,  6 Aug 2026 05:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785994679; cv=none; b=WwzvgvSwD11Og7e4U9UEE6c/7X2Ho4U4gsgm69ucaUaIdrwEOnQrgTCpXypLlZ7Vr8oks6cs+t3peJofEHtYuHVTWYnZFSjvJBhRasxWHWLHEMYDT37lBMjw6sFcaIBC7A0Q3D12w2pZRvzQMQSMGnh3l+Y4g2gKgwpdsfIwXCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785994679; c=relaxed/simple;
	bh=h6nb5ZqpKGByt77VT5dytiRj0Rvp5CkQQXJ1z41mtxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LYpQhdhpfpnQd5r14VQ+NmkLl7o6bbEn4FV48Nj52wxUT+6U6ImJqrxpEh8pTtXxce+ogdxoZ051KBhiUOI2IKR0F5cQXhJolJItVe7flHf72h4kmfxIU9h/cgtlUO2hVYrbkdXQZGKcPTSxbvEFKriWJjurk18iUXUGbyssfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Id1rU/o4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id1rU/o4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34F51F00A3A;
	Thu,  6 Aug 2026 05:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785994677;
	bh=6Gxrj0U0TiP8+yU9iwhzCoyYc5aalHZiiyVeTT4WwA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Id1rU/o4OORX759+s/IAHVgSW5PB7oL26k+YKFn/QIrF8O5ODpOgA0v8vE6jM+OP7
	 Q5raRFFky+UP4ULxfIrkcN53XLAzQsJZVUJgUA4tvPzRSULicHsOsJpNvRQXHI1+gh
	 V96PnOEKxKE7hDtibe7cWoWtzFxtTu547ND80cN4ZyaSwKa13/3et+7grxDLRLClS5
	 Jbtv3z26OU0lUvCNaFtu78B0kupWrzf/TPoBmqpWnzAC+F2fYyY1xrDieWwHX1W9cO
	 WZoShgibgPBVUG7YD0LuE57Fq5a/skxzh+yhwhOaC8WMiCaeVfkNjjIXubUgsUiW9m
	 F29+ecolWKpdw==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Thu, 06 Aug 2026 05:37:41 +0000
Subject: [PATCH 6.12.y 1/2] lib/alloc_tag: introduce
 mem_alloc_profiling_permanently_disabled()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-kmalloc-no-objext-for-6-12-y-v1-1-036dfc3273fc@kernel.org>
References: <20260806-kmalloc-no-objext-for-6-12-y-v1-0-036dfc3273fc@kernel.org>
In-Reply-To: <20260806-kmalloc-no-objext-for-6-12-y-v1-0-036dfc3273fc@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry@kernel.org>, 
 Kees Cook <kees@kernel.org>, Danielle Costantino <dcostantino@meta.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Hao Ge <hao.ge@linux.dev>, 
 Hao Li <hao.li@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 "Liam R . Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

commit a37b0066a10aabf3c968b4566706fb866eaf9a85 upstream.

mem_alloc_profiling_enabled() tells whether memalloc profiling is
currently enabled. However, even when this function returns false,
it can be enabled later.

However, this is not enough. Some optimizations can be applied only when
memalloc profiling is permanently disabled. For example, to skip the
creation of KMALLOC_NO_OBJ_EXT caches at boot time, mem_profiling must
be set to "never", "0" w/ debugging on, or have been shutdown so that
it can no longer be enabled.

Introduce mem_alloc_profiling_permanently_disabled() for this purpose.

Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Link: https://patch.msgid.link/20260713-kmalloc-no-objext-v3-3-47c7bd138de7@kernel.org
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
[ harry@kernel.org: Move the definition of
  mem_alloc_profiling_permanently_disabled() after
  mem_profiling_support.

  Unlike 6.18 and later kernels, mem_profiling_support is marked
  __init and gets freed after boot. Since the function is needed
  only when creating kmalloc caches, mark it __init as well. ]
Signed-off-by: Harry Yoo <harry@kernel.org>
---
 include/linux/alloc_tag.h | 3 +++
 lib/alloc_tag.c           | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 6073a8f13c41..70025f8e2499 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -105,6 +105,8 @@ static inline bool mem_alloc_profiling_enabled(void)
 				   &mem_alloc_profiling_key);
 }
 
+bool __init mem_alloc_profiling_permanently_disabled(void);
+
 static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
 {
 	struct alloc_tag_counters v = { 0, 0 };
@@ -198,6 +200,7 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 
 #define DEFINE_ALLOC_TAG(_alloc_tag)
 static inline bool mem_alloc_profiling_enabled(void) { return false; }
+static inline bool mem_alloc_profiling_permanently_disabled(void) { return true; }
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
 				 size_t bytes) {}
 static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index e76c40bf29d0..a0d11582029e 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -183,6 +183,15 @@ static bool mem_profiling_support __meminitdata = true;
 static bool mem_profiling_support __meminitdata;
 #endif
 
+/*
+ * Memory allocation profiling is permanently disabled and cannot be enabled.
+ * Must be called after setup_early_mem_profiling().
+ */
+bool __init mem_alloc_profiling_permanently_disabled(void)
+{
+	return !mem_profiling_support;
+}
+
 static int __init setup_early_mem_profiling(char *str)
 {
 	bool enable;

-- 
2.53.0

