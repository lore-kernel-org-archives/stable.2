Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5374441D131;
	Thu, 23 Jul 2026 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806423; cv=none; b=gobkOrRtsMDKOO1AAYFoADKFGDPrmN1WO1KQrS04tka40JQ/fIXKIsWIjPMOUSjdo6jOyvqSXjIT8wK+KCr9QR0QPLbfHPCEgpsC3DPpJukRp2qC3ThJ8aAFnZCdMjGN0epcrDZmRCPGbioFmNpmdz2Wag+GFNcjOtm2NLBahUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806423; c=relaxed/simple;
	bh=YLqYUhA5pH1o9NqB8bLnXii6WkRni51S7NGtW6uD8M8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QleIFVUtxAZ+EeGun5+gGkSsgCQ3ON7vMwNxY9U8Eet4+wyozPbzmDE9pscfo3eivOYDCzG+ay5aLIumIEKgkmOqNUQfbxVTSguFgnUuaGt5Ypbv7iNFaJQuPlKfjTJUV1/IGN3r+9GuNT02Qs5tVAF2IlZZRRoDykH8HnxwjGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RcC4lbyw; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RcC4lbyw"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GxVNFt8xQTYyKNyZXDf27eETT5f/KM+VvCGWAK3V/z8=;
	b=RcC4lbywS4NyQB8ogFvDv3vWqNzsM05EjyaK9pIIK11HfiA3i/BbV6Ul/8d4m8g2e71eXSoFq
	+AYUlYCq3WtuIWn/OpH6GHJdRZyWfuRLL/K4lCmUXrUAxZ/bfT/NRDkKxrl2JFA1RhwsX5uv1ig
	2iEQqzz8YnL2S1s1GtZVN/E=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4h5TKS2PCwzLlTV;
	Thu, 23 Jul 2026 19:24:12 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id A1FC740586;
	Thu, 23 Jul 2026 19:33:35 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Jul
 2026 19:33:35 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter
	<cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin
	<roman.gushchin@linux.dev>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<weiyongjun1@huawei.com>
Subject: [PATCH v2] mm/slub: fix missing debugfs entries for caches created before sysfs init
Date: Thu, 23 Jul 2026 19:55:32 +0800
Message-ID: <20260723115532.761920-1-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj500018.china.huawei.com (7.202.194.48)

slab_debugfs_init() creates the slab debugfs root at device initcall
time, while slab_sysfs_init() moves slab_state to FULL at late initcall
time. SLAB_STORE_USER caches created in this window miss their debugfs
entries because do_kmem_cache_create() skips debugfs_slab_add() when
slab_state <= UP.

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

Initialize the debugfs root and add debugfs entries while
slab_sysfs_init() holds slab_mutex and walks slab_caches. This gives the
sysfs and debugfs initialization an explicit order and prevents caches
from being created between the debugfs scan and slab_state reaching
FULL.

Since the debugfs root is now initialized later, a cache may be released
before the root exists. Guard debugfs_slab_release() in that case to
avoid looking up the cache name in the debugfs root directory.

Fixes: 1a5ad30b89b4 ("mm: slub: make slab_sysfs_init() a late_initcall")
Cc: stable@vger.kernel.org
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---

Changes in v2:
- Move debugfs root and cache entry initialization into
  slab_sysfs_init() so both use the same mutex-protected cache walk.
- Guard debugfs_slab_release() against an uninitialized debugfs root.
- Update the commit message accordingly.

v1: https://lore.kernel.org/linux-mm/20260720145124.3684976-1-lixiasong1@huawei.com/

---
 mm/slub.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9ec774dc7009..70e9aeda6a8f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -339,8 +339,10 @@ static inline int sysfs_slab_add(struct kmem_cache *s) { return 0; }
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
 static void debugfs_slab_add(struct kmem_cache *);
+static void __init slab_debugfs_root_init(void);
 #else
 static inline void debugfs_slab_add(struct kmem_cache *s) { }
+static inline void slab_debugfs_root_init(void) { }
 #endif
 
 enum add_mode {
@@ -9771,11 +9773,16 @@ static int __init slab_sysfs_init(void)
 
 	slab_state = FULL;
 
+	slab_debugfs_root_init();
+
 	list_for_each_entry(s, &slab_caches, list) {
 		err = sysfs_slab_add(s);
 		if (err)
 			pr_err("SLUB: Unable to add boot slab %s to sysfs\n",
 			       s->name);
+
+		if (s->flags & SLAB_STORE_USER)
+			debugfs_slab_add(s);
 	}
 
 	while (alias_list) {
@@ -9985,23 +9992,16 @@ static void debugfs_slab_add(struct kmem_cache *s)
 
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
2.34.1

