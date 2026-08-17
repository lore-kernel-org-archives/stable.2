Received: from mta0.migadu.com (out-118.mta0.migadu.com [91.218.175.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC843AA9F3
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948021; cv=none; b=VJgDnytQ9QhOoSzv7US0vAnOCnJDPsWt3ah5tf+ZsscKutxgVPVVGv/n8Uf1nRvCVqdLi3bHSrRpvAge3/Znt592i9aFkXtd2n+lg92htSpTBHFb9OJKgkfUtPNWyg3qmUluKSCRG9hBYgiq/58Bka1PYhacb1y76/9H6LX2QbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948021; c=relaxed/simple;
	bh=Nrl5tHbT9eQhQhzooTC92+qQ11qduWmutBe6i3Oleeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQETDCDYRu5BXfYk8OBxfIrYGc7cULoUQ1WAXJaqtmwDuna2Xyh47IOPbsjlAVTy4w42IdhLmX3+tdqtCZvwH7gSCSN3mg1YMztjNuxNIvYJVM8y9PO8LHvKYUU7QO6jqn6ho+pGLOtuet5+5197V0nNb8H9BvdFNqhov/WVlSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f6LbZYdJ; arc=none smtp.client-ip=91.218.175.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f6LbZYdJ"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Nrl5tHbT9eQhQhzooTC92+qQ11qduWmutBe6i3Oleeo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786948017; v=1; x=1787552817;
 b=f6LbZYdJbh+RYFONAlNMXgMCY6QH0m73I0gQkFwtcV5vUoPEq1W0rJI/BDaJSUr6yKX2kkcP
 57tl03izkRjx3CJv6Cr3Qab9i8hMy4S612po1osOSA0X/X60Qn+N0O8O50qNuWvFRbuRC2R7WrE
 e+HDGPSYtiVd7lQZ0fgYrbaE=
X-Envelope-To: stable@vger.kernel.org
Received: from localhost.localdomain (116.128.244.169)
	by smtp.migadu.com with ESMTPS id 411436bb243080ca;
	Mon, 17 Aug 2026 06:26:57 +0000
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] alloc_tag: skip percpu counter allocation when profiling is disabled
Date: Mon, 17 Aug 2026 14:27:25 +0800
Message-Id: <20260817062726.106511-2-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260817062726.106511-1-hao.ge@linux.dev>
References: <20260817062726.106511-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After shutdown_mem_profiling() clears mem_profiling_support,
needs_section_mem() returns false, so later modules have their codetag
section placed as regular data and never enter the alloc_tag maple tree.
codetag_load_module() still called load_module(), which allocated a percpu
counter for every tag; release_module_tags() could not find these modules
on unload, so the counters leaked.

Return -EOPNOTSUPP from load_module() when profiling is off:
codetag_module_init() drops the module's cmod, no counters are allocated
and the module loads without its tags. codetag_unload_module() now always
calls free_section_mem(), since a module whose module_load() returned
-EOPNOTSUPP is not in the idr but may still hold a reserved section.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Cc: stable@vger.kernel.org
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 lib/codetag.c  | 10 ++++++++--
 mm/alloc_tag.c |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/codetag.c b/lib/codetag.c
index a9cda4c962a3..a0b600720afc 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -240,7 +240,9 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 
 	if (err < 0) {
 		kfree(cmod);
-		return err;
+		/* -EOPNOTSUPP means we can load the module without its tag. */
+		if (err != -EOPNOTSUPP)
+			return err;
 	}
 
 	return 0;
@@ -388,7 +390,11 @@ void codetag_unload_module(struct module *mod)
 			++cttype->content_id;
 		}
 		up_write(&cttype->mod_lock);
-		if (found && cttype->desc.free_section_mem)
+		/*
+		 * A module whose module_load() returned -EOPNOTSUPP is not
+		 * in the idr but may still hold reserved section memory.
+		 */
+		if (cttype->desc.free_section_mem)
 			cttype->desc.free_section_mem(mod, true);
 	}
 	mutex_unlock(&codetag_lock);
diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 52aece27b00e..80eccaca665a 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -975,6 +975,10 @@ static int load_module(struct module *mod, struct codetag *start, struct codetag
 	struct alloc_tag *stop_tag;
 	struct alloc_tag *tag;
 
+	/* Profiling disabled: load the module without its tags. */
+	if (!mem_profiling_support)
+		return -EOPNOTSUPP;
+
 	/* percpu counters for core allocations are already statically allocated */
 	if (!mod)
 		return 0;
-- 
2.25.1

