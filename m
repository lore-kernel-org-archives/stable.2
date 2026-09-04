Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB543FD0B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517826; cv=none; b=DMUAzoH76AxS31fVeyhD72XPQN40RoFFf4Jp0oQMefCE/8KXcPl277W1JZJ4YCAyrShMFdh6us3FO+sHfGdYpK3oUkJMISZc6os9TPUEPUIuA8R3ZsyyekIebmE1wowoJYvv8J/T8t3Df0Hy/3N2k1/Xqa8dOdWIBjLHKmNb640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517826; c=relaxed/simple;
	bh=NnxUTNFrnCPy+Amr7f6pL1Buuo1HNRzNH7DpwVYL+4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSni8bb8OgQ4hXPXvjPayFC/pZqMc6AMDMn13SsYNBltyA+EBa/O7GBY9cjE91yay2BnmsBuXb/tjbmyI5EBw2iszXjJqTp5V+GUIM9YCmqU19cA24WVnuK8Dr9pZL4EnkePB+CyY7Ev5cHUcpq1d3xY8NwBiDB+ipO00g/MGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7P0lx0J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7P0lx0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7936F1F00AC4;
	Fri,  4 Sep 2026 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517825;
	bh=Jf5CywErXNzBtUQdtLu3LUpQaWLER6eeUWutLEB43Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F7P0lx0Jh8PsbUBLsdM+RHhefBik60+jy/DrQ2PbGuWqmKLf1VGPpdvK5Abophu/B
	 MCroO8hJI0HleqcJ5qs3gbrTMN2nFS66toPq5h8KF6NYrlootFB9is4pwXaPPN5KY+
	 krLa3ty+WJV6q+Zt8V6Fk0Hik4ctbuExGIcdHOnH8a4a2C3x2yykiWXNoTEtnjGmmm
	 y9056C1YHyPyND1GrjucsF1cR1L68R3oKiD3UHHkCk1YhdYiBnDxRTUS369gLVSxHB
	 oXCgU3Pop0tQ33TZl96J3RDabxNnrmp0ZkkfQ47ZcAsF+NhA1Z2iM/2wyWsDlafgCh
	 +/9NgCyMA49kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Xiasong <lixiasong1@huawei.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] mm/slub: fix missing debugfs entries for caches created before sysfs init
Date: Fri,  4 Sep 2026 06:30:20 -0400
Message-ID: <20260904103020.2502384-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904103020.2502384-1-sashal@kernel.org>
References: <2026090310-subtract-womanlike-c117@gregkh>
 <20260904103020.2502384-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Xiasong <lixiasong1@huawei.com>

[ Upstream commit 7e98f856395618011c517f767fb80ac3fe90de2b ]

slab_debugfs_init() creates the slab debugfs root at device initcall
time, while slab_sysfs_init() moves slab_state to FULL at late initcall
time. SLAB_STORE_USER caches created in this window miss their debugfs
entries because do_kmem_cache_create() skips debugfs_slab_add() when
slab_state <= UP. This was observed with MPTCP's request_sock_subflow_v6
cache, whose slab debugfs directory was missing.

The affected window is:

  slab_debugfs_init()
    slab_debugfs_root = debugfs_create_dir(...)
    list_for_each_entry(s, &slab_caches, list)
      debugfs_slab_add(s)

  kmem_cache_create(..., SLAB_STORE_USER, ...)
    do_kmem_cache_create()
      if (slab_state <= UP)
        return without debugfs entries

  slab_sysfs_init()
    slab_state = FULL

Initialize the debugfs root and add debugfs entries while holding
slab_mutex, walking slab_caches exactly once and handling both sysfs
and debugfs entries in the same pass. This gives the sysfs and debugfs
initialization an explicit order and prevents caches from being
created between the debugfs scan and slab_state reaching FULL.

Gate the new slab_late_init() on either sysfs or debugfs being enabled,
with the slab_kset creation and alias_list processing factored into
helpers that have empty no-sysfs variants, as suggested by Vlastimil
Babka. On slab_kset_init() failure, slab_state stays below FULL so
kmem_cache_create() keeps taking the early-boot path, matching prior
behavior.

Guard debugfs_slab_release() against an uninitialized debugfs root,
since the root is now created later and a cache may be released before
it exists.

Fixes: 1a5ad30b89b4 ("mm: slub: make slab_sysfs_init() a late_initcall")
Cc: stable@vger.kernel.org
Suggested-by: Vlastimil Babka <vbabka@kernel.org>
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Link: https://patch.msgid.link/20260729101849.3734287-1-lixiasong1@huawei.com
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 76 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b5944af1ead34..43070c4d1ad4d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -317,14 +317,20 @@ enum track_item { TRACK_ALLOC, TRACK_FREE };
 
 #ifdef SLAB_SUPPORTS_SYSFS
 static int sysfs_slab_add(struct kmem_cache *);
+static int __init slab_kset_init(void);
+static void __init slab_sysfs_process_aliases(void);
 #else
 static inline int sysfs_slab_add(struct kmem_cache *s) { return 0; }
+static inline int slab_kset_init(void) { return 0; }
+static inline void slab_sysfs_process_aliases(void) { }
 #endif
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
 static void debugfs_slab_add(struct kmem_cache *);
+static void __init slab_debugfs_root_init(void);
 #else
 static inline void debugfs_slab_add(struct kmem_cache *s) { }
+static inline void slab_debugfs_root_init(void) { }
 #endif
 
 static inline void stat(const struct kmem_cache *s, enum stat_item si)
@@ -6258,28 +6264,20 @@ static int sysfs_slab_alias(struct kmem_cache *s, const char *name)
 	return 0;
 }
 
-static int __init slab_sysfs_init(void)
+static int __init slab_kset_init(void)
 {
-	struct kmem_cache *s;
-	int err;
-
-	mutex_lock(&slab_mutex);
-
 	slab_kset = kset_create_and_add("slab", NULL, kernel_kobj);
 	if (!slab_kset) {
-		mutex_unlock(&slab_mutex);
 		pr_err("Cannot register slab subsystem.\n");
 		return -ENOMEM;
 	}
 
-	slab_state = FULL;
+	return 0;
+}
 
-	list_for_each_entry(s, &slab_caches, list) {
-		err = sysfs_slab_add(s);
-		if (err)
-			pr_err("SLUB: Unable to add boot slab %s to sysfs\n",
-			       s->name);
-	}
+static void __init slab_sysfs_process_aliases(void)
+{
+	int err;
 
 	while (alias_list) {
 		struct saved_alias *al = alias_list;
@@ -6291,12 +6289,41 @@ static int __init slab_sysfs_init(void)
 			       al->name);
 		kfree(al);
 	}
+}
+#endif /* SLAB_SUPPORTS_SYSFS */
+
+#if defined(SLAB_SUPPORTS_SYSFS) || \
+	(defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS))
+static int __init slab_late_init(void)
+{
+	struct kmem_cache *s;
+	int err;
 
+	mutex_lock(&slab_mutex);
+
+	err = slab_kset_init();
+	if (err)
+		goto out;
+
+	slab_debugfs_root_init();
+	slab_state = FULL;
+
+	list_for_each_entry(s, &slab_caches, list) {
+		if (sysfs_slab_add(s))
+			pr_err("SLUB: Unable to add boot slab %s to sysfs\n",
+			       s->name);
+
+		if (s->flags & SLAB_STORE_USER)
+			debugfs_slab_add(s);
+	}
+
+	slab_sysfs_process_aliases();
+out:
 	mutex_unlock(&slab_mutex);
-	return 0;
+	return err;
 }
-late_initcall(slab_sysfs_init);
-#endif /* SLAB_SUPPORTS_SYSFS */
+late_initcall(slab_late_init);
+#endif
 
 #if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
 static int slab_debugfs_show(struct seq_file *seq, void *v)
@@ -6494,23 +6521,16 @@ static void debugfs_slab_add(struct kmem_cache *s)
 
 void debugfs_slab_release(struct kmem_cache *s)
 {
+	if (unlikely(!slab_debugfs_root))
+		return;
+
 	debugfs_lookup_and_remove(s->name, slab_debugfs_root);
 }
 
-static int __init slab_debugfs_init(void)
+static void __init slab_debugfs_root_init(void)
 {
-	struct kmem_cache *s;
-
 	slab_debugfs_root = debugfs_create_dir("slab", NULL);
-
-	list_for_each_entry(s, &slab_caches, list)
-		if (s->flags & SLAB_STORE_USER)
-			debugfs_slab_add(s);
-
-	return 0;
-
 }
-__initcall(slab_debugfs_init);
 #endif
 /*
  * The /proc/slabinfo ABI
-- 
2.53.0

