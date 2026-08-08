Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5541194A6C
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204149; cv=none; b=ddCXs1QVUvbvzJoi285LF9NATvBm0+DBXU0VSXmEu3lHoBJgp8ruvgDqbVD6SXWarHS/5iSC9PKmj4rA3aoSulbCYuX1IPV5wfYU1jFNMdazDC94AhMVJRhJX/nJV1PnihV+4chTvGUJIakUVrvCC+PPfPSc70X5h+KBTl/6Iow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204149; c=relaxed/simple;
	bh=W+kZO4NOJkvdGtKyWqST47hOViUQKd3IjhTQhS3dmkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3BCr24DmPmI8fAk3QJQfAUkoPC7EjDRVAw/lTZavKMUcaQCOEtvZ0AL/AJmTddxBaBcvYktIPnCFL2JCwfIDtlM4C1guIARU+pd7r+k6h1GlQhxJN6X73itfroWjofgAIGe0oMGbcOvfKT1hcMnf3TAttDcZm2axczleTEaokY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcXFwKvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcXFwKvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5841F000E9;
	Sat,  8 Aug 2026 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786204148;
	bh=rZHm3WW4qD50e8BeMhxYm8Lq9CvVZwKLMStlSuAW2+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hcXFwKvlOJa5++f9a++o/s74l8I/vnSEOhoJ6Z19v/QpVNzmegjG8dZLFU4NAY1ym
	 /iV8jTjVcH/3gN0dgXv567gwnPtFxfuoeMMOaYK87f6ospNtXdcKR/+6QrAoLKFlHv
	 mLohD1+4Qz4mf+HR7HjAat44xtb+E1hgtQBkL8hjYpWBVwAndzikSSXTmFmWj18aJX
	 W/jmzHK12oqKhLlmK6vwpq5iczr8iqwsYmhAIVw4Jffr3FUO4mx10z0SIwRBR7G81B
	 g2J4Y3rDRCbYRS2pISX3N9e/lV8HvAU8hHyTRsc9sEpj8XSUXsdBNuPZ19ypHRJyg4
	 Wy1yXHHHiN5cQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] lib/alloc_tag: introduce mem_alloc_profiling_permanently_disabled()
Date: Sat,  8 Aug 2026 11:49:05 -0400
Message-ID: <20260808154906.370637-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072906-snowbird-tropics-89f9@gregkh>
References: <2026072906-snowbird-tropics-89f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Harry Yoo (Oracle)" <harry@kernel.org>

[ Upstream commit a37b0066a10aabf3c968b4566706fb866eaf9a85 ]

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
Stable-dep-of: d9e6a7623938 ("mm/slab: prevent unbounded recursion in free path with new kmalloc type")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/alloc_tag.h | 3 +++
 lib/alloc_tag.c           | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 02de2ede560f3..7e7cdc7612bed 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -134,6 +134,8 @@ static inline bool mem_alloc_profiling_enabled(void)
 				   &mem_alloc_profiling_key);
 }
 
+bool mem_alloc_profiling_permanently_disabled(void);
+
 static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
 {
 	struct alloc_tag_counters v = { 0, 0 };
@@ -239,6 +241,7 @@ static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
 
 #define DEFINE_ALLOC_TAG(_alloc_tag)
 static inline bool mem_alloc_profiling_enabled(void) { return false; }
+static inline bool mem_alloc_profiling_permanently_disabled(void) { return true; }
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
 				 size_t bytes) {}
 static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index a9ab88f416b9f..e3a9235946045 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -26,6 +26,15 @@ static bool mem_profiling_support = true;
 static bool mem_profiling_support;
 #endif
 
+/*
+ * Memory allocation profiling is permanently disabled and cannot be enabled.
+ * Must be called after setup_early_mem_profiling().
+ */
+bool mem_alloc_profiling_permanently_disabled(void)
+{
+	return !mem_profiling_support;
+}
+
 static struct codetag_type *alloc_tag_cttype;
 
 #ifdef CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
-- 
2.53.0

