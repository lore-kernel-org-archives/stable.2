Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2E4AA401
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439622; cv=none; b=KFO7+PZeN44kgwPYESeMW4xfR642x5rYFHPnNRySfv1570qMwKOTMlwau3YpxjbbhI8SVkZC+jXj3F2dxDrm6JR47eQJk+uB74eRWJrJOW4j22TKcIFJRUBnwwPF2E5qAx3Et2W2X+MaRhevrlRS2hBV/rPw1BTNa7aY2zqE+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439622; c=relaxed/simple;
	bh=fR9w2V5B5g3STzFFqC0IVZ/3YegmHrP17FLYeFYKyPA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TSWzuP68c170xkxdAu8sh8gpAmaUPFmC5OJIkkkq1vt5i+gHdl+LTKdr1TZg+l9ECdzzdnaAlWPdKvgFuvX3AyKcJcPr6+9d1zbBsBgogqhbN6++jF14EXL1KwcFIhUM58lJIL1svgUyViQWr/dsdEnEc7A8Kdwq+RRiDgMjQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nHmjRCis; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nHmjRCis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D861F000E9;
	Thu,  3 Sep 2026 12:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439620;
	bh=WTyJIHFcWu3PVYwSR91mwRygPNecaNKtJx9pCTmnKaY=;
	h=Subject:To:Cc:From:Date;
	b=nHmjRCis9U3zHUtMEb2CpE+G9FUkN0gTH9cO2ecrSKAb0CgCcpLm1oADfT0Ijrxco
	 KtbS2jMA3lCcqyHeiXWcp+y4GBUnZf+k6yCmWgvyBeQ+TJS4+8rys3xwEDA5keS2Sh
	 +/84SzP8ocZ/PgKxH6Cxfz9zq1VZfnIZwDTvE5Mo=
Subject: FAILED: patch "[PATCH] mm/slub: fix missing debugfs entries for caches created" failed to apply to 6.18-stable tree
To: lixiasong1@huawei.com,harry@kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:50:09 +0200
Message-ID: <2026090309-defame-darkening-edde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7e98f856395618011c517f767fb80ac3fe90de2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090309-defame-darkening-edde@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e98f856395618011c517f767fb80ac3fe90de2b Mon Sep 17 00:00:00 2001
From: Li Xiasong <lixiasong1@huawei.com>
Date: Wed, 29 Jul 2026 18:18:49 +0800
Subject: [PATCH] mm/slub: fix missing debugfs entries for caches created
 before sysfs init

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

diff --git a/mm/slub.c b/mm/slub.c
index f528e5fbef82..9656bdc94007 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -333,14 +333,20 @@ enum track_item { TRACK_ALLOC, TRACK_FREE };
 
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
 
 enum add_mode {
@@ -9746,28 +9752,20 @@ int sysfs_slab_alias(struct kmem_cache *s, const char *name)
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
@@ -9779,13 +9777,42 @@ static int __init slab_sysfs_init(void)
 			       al->name);
 		kfree(al);
 	}
-
-	mutex_unlock(&slab_mutex);
-	return 0;
 }
-late_initcall(slab_sysfs_init);
 #endif /* SLAB_SUPPORTS_SYSFS */
 
+#if defined(SLAB_SUPPORTS_SYSFS) || \
+	(defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS))
+static int __init slab_late_init(void)
+{
+	struct kmem_cache *s;
+	int err;
+
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
+	mutex_unlock(&slab_mutex);
+	return err;
+}
+late_initcall(slab_late_init);
+#endif
+
 #if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
 static int slab_debugfs_show(struct seq_file *seq, void *v)
 {
@@ -9976,23 +10003,16 @@ static void debugfs_slab_add(struct kmem_cache *s)
 
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

