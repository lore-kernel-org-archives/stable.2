Received: from mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511A351E437
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859529; cv=none; b=D6eiyduYqeMxRWzXP3Wff9kUc0V8mRDCaU6dsaeUN1f+k5A51fV2RFH1qlf1tRhkFEVh+YYTq+PvjvVOD6F1OO+6wCERFhdqQ67XAE6oSb6I8HcvMjRt/MRn8yQIg9ToiJjxWF1TT7JT6MwZc/6MVxD+1pG5DZ+b/ScIwpXthns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859529; c=relaxed/simple;
	bh=LBg+sSLJXtOw4WEz6FbemiKRacEtP0xCjkkrVUCvXnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rC50ZD92L+9turg28z4+tT/HMIxXMUWkADiBJnxPcvmMhWFu4Ma1emq6SZ08cKwQaX+UsKqAHjKEejt0LRsoVNTVyVREk/6GeKCEqFs+Bshj+4ZTLoV3os9CBJEFaIovGNL7eD64RZs6tFZ4NzveVIvroWCf97Ut+U11ntMRorA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xkjjv8Qk; arc=none smtp.client-ip=91.218.175.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xkjjv8Qk"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LBg+sSLJXtOw4WEz6FbemiKRacEtP0xCjkkrVUCvXnY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788859526; v=1; x=1789464326;
 b=xkjjv8QkGbLFxmumUWQo4JmgAxkQdSsD3poo1JVJvohVH54wQYpRVSmscrnbe3XBjOUUoZQE
 hQBRbWe66aujOa/v3EIf+Vw0P2EtRZ3WwlJywiexqmvjcmHx1KlvS9HJo9eDnk0iJTMsLMAkCAw
 gkWmDBKkN2Vydw4zjcWzGHNU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7cf99981dc3c1c49;
	Tue, 08 Sep 2026 09:25:07 +0000
X-Mizu-Trace-ID: 7cf99981dc3c1c49
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Hao Ge <hao.ge@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v9 2/4] alloc_tag: clean up the populate failure path
Date: Tue,  8 Sep 2026 17:24:10 +0800
Message-Id: <20260908092412.115953-3-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260908092412.115953-1-hao.ge@linux.dev>
References: <20260908092412.115953-1-hao.ge@linux.dev>
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
index e7a79116ad81..e7a40a276ed9 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -812,6 +812,13 @@ static int vm_module_tags_populate(void)
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
@@ -955,6 +962,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		return ret;
 
 	if (module_tags.size < offset + size) {
+		unsigned long prev_size = module_tags.size;
 		int grow_res;
 
 		module_tags.size = offset + size;
@@ -969,6 +977,8 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
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

