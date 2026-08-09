Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8884B04AC
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 00:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786236488; cv=none; b=t7Cnj8NdRSpHIxxsnlZjvuqp9nsO74aGxVV65gxGqJD04u16D6MXV+lGKN3LgtoOECGGNtZDhsxulLeU6IwaF56n9NK4mgPol/1v3RpNPUSl7SUkuHy5zQQ136Q11IuFQ+fb0wMIbHuQVDTv+qiFEowM5SKozZGZEvNQ02tAsLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786236488; c=relaxed/simple;
	bh=DSlu5Tkbdyrxs3m/Eyzpc5u1LlBKAzp1Julk4/A9md0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBkQcSFCHQiS1PMK0ri4XoijtnaEJJ4OhiaF/BvQyilnMo2KU5Q9ozx3iBDCs+z59SFRXaRmBlJhGIP2Dyx49YGs4Uw4MhT3cn6iFxEDG0QFxzChTgQE6uEjEcKoTWV/blB6caWNPH1RNoVStHfYubDNyGaDAQNoRFFzdoOATmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNEOh8kt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNEOh8kt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDFC1F000E9;
	Sun,  9 Aug 2026 00:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786236487;
	bh=AlebbDIMA2FdZ0216wAtpIHqAOWUm4PMwaU/egQMHVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QNEOh8kt4hUUIFZm/oC/U0mFg05eqIjDXJD9dBUoTFB+FN1yaSu4OL009hwDOoRFZ
	 QWsjrtSj/MjpUEYpxPlB3HR9k8oVj7wtDk8ItcjwaZsxNqu318eto8Yaj86k427yDa
	 QQI6PR2UQpMeI7N8Ib5KSpFNfJVXVudr+p1vyNoBK3yfO1ZMD6cvcCaHg9/VIcY3Kr
	 H/7o+ym6FiRshw5EdozW3T2XfRcThH//gTDYYgGolR8cIY8UVpqIbqpKnYvDcWzDap
	 8WEGwgx60q1jD8p0jF/Vhm1zN1O9EdgSlcxtHt9ilJckZ2YD8KYViP/P15B8DVqSM+
	 V/H8G4kdup43g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] lib/alloc_tag: introduce mem_alloc_profiling_permanently_disabled()
Date: Sat,  8 Aug 2026 20:48:03 -0400
Message-ID: <20260809004804.874153-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072908-drowsily-racing-b265@gregkh>
References: <2026072908-drowsily-racing-b265@gregkh>
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
[ Move the definition of mem_alloc_profiling_permanently_disabled()
  after mem_profiling_support.

  Unlike 6.18 and later kernels, mem_profiling_support is marked
  __init and gets freed after boot. Since the function is needed
  only when creating kmalloc caches, mark it __init as well. ]
Stable-dep-of: d9e6a7623938 ("mm/slab: prevent unbounded recursion in free path with new kmalloc type")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/alloc_tag.h | 3 +++
 lib/alloc_tag.c           | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 6073a8f13c413..70025f8e24990 100644
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
index e76c40bf29d06..a0d11582029ef 100644
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

