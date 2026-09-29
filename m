Received: from mta1.migadu.com (out-163.mta1.migadu.com [95.215.58.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9D3B27F7
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670049; cv=none; b=JHxx0ni8Tdt15SJNgWmVw42iVgtKpCvzzyFtKFy2kTxgb+PVP1AbRUXgVyEctdN3MjtD0EfHt+CH6v2Y5G5E45cjTfuEmdXQf3mxXnvoxUGbeEDEipjLr3LJ2b8o/kGmHISsDQMxXkIq4f6QM1+ydVjjiTPU5Jw1RD94yQJ0h5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670049; c=relaxed/simple;
	bh=N0ff/iGVp+b52+6AW1hzofKLKiwU3Q/JuQflNfL6tR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R7/HWdcoz4KMrqmeDS16ng+Di34WtZq8dfNTkocAK5nKsfop1mVQVTFn2zLiPzs4Yd7puik0iWMimsc0JfW56XBn4Mr8lT+9YZc4WYGy6qCrz92L2vjOR0tP/6ADexba0Z7ED8KKRo4fhM5HxF+Brnb4KD0yVSJEclcFjuW0HMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wY8aVxj4; arc=none smtp.client-ip=95.215.58.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wY8aVxj4"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=N0ff/iGVp+b52+6AW1hzofKLKiwU3Q/JuQflNfL6tR8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790670042; v=1; x=1791274842;
 b=wY8aVxj4JpcVF/SXqQM/e3Qda2pFi+YyPDKB71tB4ZiJmKwjBK7a+hBExwF0kO4h0BWcNbgq
 APjmev3X1DDydKKguV84f63chjw6jKx3YOGRXy0aljHZ6WX57Z1vgjlBtVfrn11RalqAGhcQnhK
 dG2PKVfF4aEqZZL491SUYIls=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b8917535a4169c27;
	Tue, 29 Sep 2026 08:20:41 +0000
X-Mizu-Trace-ID: b8917535a4169c27
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	=Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Hao Ge <hao.ge@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v11 6/7] alloc_tag: skip percpu counter allocation when profiling is disabled
Date: Tue, 29 Sep 2026 16:20:13 +0800
Message-Id: <20260929082014.160587-7-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260929082014.160587-1-hao.ge@linux.dev>
References: <20260929082014.160587-1-hao.ge@linux.dev>
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
Acked-by: Suren Baghdasaryan <surenb@google.com>
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
index 605c0016f646..ba8a651769e3 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -981,6 +981,10 @@ static int load_module(struct module *mod, struct codetag *start, struct codetag
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

