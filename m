Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819B443A89
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 06:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455561; cv=none; b=c4HEOlpT1/liQZRRgtULifgASaKRWaRpGmcgi2+BCXdwR8rsdOcsjYholeaOdaYs7+Qeci7u6/MteMbp1mOuoDCwM0V8laqJM0/nS0YznprjKfrck6yD54ixmHC4x5tEaiGbKATOiqLcAGmUy/xJtP0JVNk7idlptp0N0rLFx2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455561; c=relaxed/simple;
	bh=5Vw+v6tRRrP3hQtpFy1LEiukFTySuc0mxZr/k7GpH8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fy1NuZMiTgHar9fEts8eD1nBb2fkQOoRgNNOgW1ky0IiMLBDr3zhcNNCQcdGCXGj8whEiAwmS0GGpNa9K1zvWVPEpCPOlS2Q+4VDc/J+H4jxRVx/qDIriyciwwzxU1cotiB18sf6Gd/xhC5Q20IEzv0+QlqGIcYbVRSIWHoy9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XvH0H/gQ; arc=none smtp.client-ip=91.218.175.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XvH0H/gQ"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5Vw+v6tRRrP3hQtpFy1LEiukFTySuc0mxZr/k7GpH8M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789455557; v=1; x=1790060357;
 b=XvH0H/gQ5qZmazbWuhKBFp2+oUOmHjfpydsM0L5V/NgCCPIFe6vhmxRZGBaXpsOBgGDKmDtd
 zmbEMmdwUmy5/lFMm4b5JNGQF8A+ICmaNJs7q8QIbbToqFgD6TyKUsVV98xeMTThCSFOoi0PBhn
 LXSlF8qY6ajAsV+EVsusMMQ4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 332822dd31fa1db3;
	Tue, 15 Sep 2026 06:59:17 +0000
X-Mizu-Trace-ID: 332822dd31fa1db3
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Hao Ge <hao.ge@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-modules@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v10 2/6] alloc_tag: clean up the populate failure path
Date: Tue, 15 Sep 2026 14:59:57 +0800
Message-Id: <20260915070001.113559-3-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260915070001.113559-1-hao.ge@linux.dev>
References: <20260915070001.113559-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reservation is already stored in the maple tree when
vm_module_tags_populate() fails. A failed load never unloads the
module, so nothing releases the entry. Release it and roll
module_tags.size back. Without the rollback a concurrent load that
already passed needs_section_mem() can reuse the freed gap, skip
vm_module_tags_populate() and write to unmapped memory.

vmap_pages_range() may have installed some PTEs before failing. A
retry to populate the same range would BUG on them, so undo them,
but only if vmap actually ran.

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as needed")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/alloc_tag.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 2070e682fe10..95ddf5b743d0 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
 				     next_page, PAGE_SHIFT) < 0) {
 			release_pages_arg arg = { .pages = next_page };
 
+			/*
+			 * vmap_pages_range() only runs once all pages were
+			 * allocated, and it may have installed some mappings
+			 * before failing. Undo them.
+			 */
+			if (nr == more_pages)
+				vunmap_range(phys_end, phys_end + (nr << PAGE_SHIFT));
 			/* Clean up and error out */
 			release_pages(arg, nr);
 			return -ENOMEM;
@@ -947,6 +954,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		return ret;
 
 	if (module_tags.size < offset + size) {
+		unsigned long prev_size = module_tags.size;
 		int grow_res;
 
 		module_tags.size = offset + size;
@@ -961,6 +969,8 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 			shutdown_mem_profiling(true);
 			pr_err("Failed to allocate memory for allocation tags in the module %s. Memory allocation profiling is disabled!\n",
 			       mod->name);
+			release_module_tags(mod, false);
+			module_tags.size = prev_size;
 			return ERR_PTR(grow_res);
 		}
 	}
-- 
2.25.1

