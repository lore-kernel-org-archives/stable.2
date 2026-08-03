Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744E02F3C3D;
	Mon,  3 Aug 2026 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741321; cv=none; b=kONQnwqA+fF3RsD2s72EW96Keo2XICaBVlGkNHSEB08ijXCqFiLOAYB/S5PMSU7wu+rNlRp7/92lhHvgC5nye5ZPAt15dO7bt+5Dpc4A7GEz8Cof3/x2tl37OY8BYFwP8b24JMkiNf3HvqiIaFM2f/iD6VE8EZMc0GhijkTyOFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741321; c=relaxed/simple;
	bh=4N/XCinh0WfhPly58rkdTsrEj4YBnC4HmY1lGRaRLbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHwOBZ7MvO0zTDLtFIUnnbg7MLfVE+4LXH+5ubG5B4Hgs3clqrOiyAf/rbOKFnKwWfDILV8Jdc2EP5PrTHXF3nV95ctiz3VihYcbtfbWzq68sH3pS2kk97tBax2bDzjiyUCrNm/+LC7Tzt7+QZySbvuxmphLgni5o4/7IdVTWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViWKvJ1H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViWKvJ1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1AB1F00A3A;
	Mon,  3 Aug 2026 07:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785741320;
	bh=Y8X3NP6f1tb6ECA/APcxd2Ra/6Y+sgbGOMzwFL5+0xI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ViWKvJ1HlFBgT9zzheZGicUdhe4AKPRypbeHJ6dCCBtQo+tWpReZAC6iEKc8yd/wz
	 1fFc3v1/HVqMGMkFLHBbllmVaRbNxfgOth4OdMRGC35E6vMleNCiqY5dmFrtg57OzE
	 mQecCxQAKIO2a/FN9Fe0hih30bqi18qyhxtQmwkdG2dg8RxAKYtnYxprsPV/j8Defr
	 8XsNuevPbDvqMIXndhk42p+26tfR3/I8bfH869bQV+hNIOV1ZRR5KJoVoURXURnU92
	 Ujk4yqxKpvDDv7V3k9X41/Qe0fbS2kfsEQRwgmggFrbc1VT0MCmONhO5GE6UEZQDwH
	 zr+FxCyskGarw==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Mon, 03 Aug 2026 07:15:10 +0000
Subject: [PATCH 6.18.y 1/2] lib/alloc_tag: introduce
 mem_alloc_profiling_permanently_disabled()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-kmalloc-no-objext-for-6-18-y-v1-1-8b01d1021f0d@kernel.org>
References: <20260803-kmalloc-no-objext-for-6-18-y-v1-0-8b01d1021f0d@kernel.org>
In-Reply-To: <20260803-kmalloc-no-objext-for-6-18-y-v1-0-8b01d1021f0d@kernel.org>
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
Signed-off-by: Harry Yoo <harry@kernel.org>
---
 include/linux/alloc_tag.h | 3 +++
 lib/alloc_tag.c           | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 02de2ede560f..7e7cdc7612be 100644
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
index 3082d977efaa..7c6d3a086fdc 100644
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

