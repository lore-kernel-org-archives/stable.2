Received: from mta0.migadu.com (out-152.mta0.migadu.com [91.218.175.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76890330B09
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455586; cv=none; b=k+CznPqczCpb5mDRLUiu7/lSnwly99qFz3aR63zev2Qk9/kera1GG4dvHfIwr0gpRwSBGEBatNSZG9GzDVzsiJ4y0klvrJvrk+KKRiIPknqtVDuJj3xKfCCVDOhxG0ulH5c33ueJc/FEGD46XAh4eh/OIZKfnqABw5TeDi1Nb0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455586; c=relaxed/simple;
	bh=0gcszhOdin+bUpsUHNDDdcWh1NUbmDL4eeu4aqfKVU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qodIAJC4D5FgpKZbR0RC/iqmHJgCTePq9JxiLV21hNsjah+gfAqLJGVtmn86kguye9mptWijgvBGBHhVd4x1aXYrWaZ/D8edHR/h208u+0nJvzcMcCoWu/Zix8W3MpeaiIH8gFGqbh/VNJFU787rb2SrWD0gYyhz8uagdI85/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ii7UKsEJ; arc=none smtp.client-ip=91.218.175.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ii7UKsEJ"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0gcszhOdin+bUpsUHNDDdcWh1NUbmDL4eeu4aqfKVU0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789455582; v=1; x=1790060382;
 b=ii7UKsEJcTBsF7caN5U1iFoEQgL0UqerqAbbcBOobpfHYqOXY5XOrkAR+NW+SfrUtm08NJgX
 wUnivqnee3uX/0YJZmuNIG0ypkh/Gd0p3OUsCYe9AN0OJ9uJwla9HSyQpjYPfieGPxJHVhKV39V
 kl65Ukv3OwOzPAtRWnLwwTng=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id efae1140c7a24bc8;
	Tue, 15 Sep 2026 06:59:42 +0000
X-Mizu-Trace-ID: efae1140c7a24bc8
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
Subject: [PATCH v10 6/6] alloc_tag: Defer /proc/allocinfo removal to a workqueue
Date: Tue, 15 Sep 2026 15:00:01 +0800
Message-Id: <20260915070001.113559-7-hao.ge@linux.dev>
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

shutdown_mem_profiling() calls remove_proc_entry() from
reserve_module_tags(), which runs under mod_lock held for write.
remove_proc_entry() waits for readers, and a reader takes mod_lock for
read in allocinfo_start():

  CPU0 (insmod)                      CPU1 (read /proc/allocinfo)
  ----------------                   ----------------------------
  reserve_module_tags()
    down_write(&mod_lock)  [held]
                                     use_pde()            [in_use++]
                                     allocinfo_start()
                                       down_read(&mod_lock)  <- blocks
    shutdown_mem_profiling()
      remove_proc_entry()
        wait for in_use == 0         <- blocks

Move remove_proc_entry() to a workqueue.

The file creation is moved to the end of alloc_tag_init() as well.
If alloc_tag_init() fails with alloc_tag_cttype still NULL or an
error pointer, a concurrent reader of the leftover file would
dereference it in allocinfo_start() and panic.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/alloc_tag.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 1ca0409b492b..cfa0fc84b68f 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/string_choices.h>
 #include <linux/vmalloc.h>
+#include <linux/workqueue.h>
 #include <linux/kmemleak.h>
 #include <uapi/linux/alloc_tag.h>
 
@@ -591,6 +592,13 @@ void pgalloc_tag_swap(struct folio *new, struct folio *old)
 	put_page_tag_ref(handle_new);
 }
 
+static void remove_allocinfo_file(struct work_struct *work)
+{
+	remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
+}
+
+static DECLARE_WORK(remove_allocinfo_work, remove_allocinfo_file);
+
 static void shutdown_mem_profiling(bool remove_file)
 {
 	if (mem_alloc_profiling_enabled())
@@ -600,7 +608,7 @@ static void shutdown_mem_profiling(bool remove_file)
 		return;
 
 	if (remove_file)
-		remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
+		schedule_work(&remove_allocinfo_work);
 	mem_profiling_support = false;
 }
 
@@ -1358,16 +1366,10 @@ static int __init alloc_tag_init(void)
 		return 0;
 	}
 
-	if (!proc_create(ALLOCINFO_FILE_NAME, 0400, NULL, &allocinfo_proc_ops)) {
-		pr_err("Failed to create %s file\n", ALLOCINFO_FILE_NAME);
-		shutdown_mem_profiling(false);
-		return -ENOMEM;
-	}
-
 	res = alloc_mod_tags_mem();
 	if (res) {
 		pr_err("Failed to reserve address space for module tags, errno = %d\n", res);
-		shutdown_mem_profiling(true);
+		shutdown_mem_profiling(false);
 		return res;
 	}
 
@@ -1375,10 +1377,16 @@ static int __init alloc_tag_init(void)
 	if (IS_ERR(alloc_tag_cttype)) {
 		pr_err("Allocation tags registration failed, errno = %pe\n", alloc_tag_cttype);
 		free_mod_tags_mem();
-		shutdown_mem_profiling(true);
+		shutdown_mem_profiling(false);
 		return PTR_ERR(alloc_tag_cttype);
 	}
 
+	if (!proc_create(ALLOCINFO_FILE_NAME, 0400, NULL, &allocinfo_proc_ops)) {
+		pr_err("Failed to create %s file\n", ALLOCINFO_FILE_NAME);
+		shutdown_mem_profiling(false);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 module_init(alloc_tag_init);
-- 
2.25.1

