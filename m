Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795750226;
	b=uG52hzlY3Nh4IpgYpG4lDgCEZUjviNB1HB2h+Kj9hR7U85eQCx2cy+n9N7S8YJHFhDAi
	 C2QNsajFmKikyrq4eFmSRpL0xOrRGkmAUbOLwljLVu0PuNKlvihREwlNQAhQr1v2id89E
	 avCCbO66yWPchnMln0ZCH+1HDTyPLpEK3koodvYzXxVDXuMEYl9068mC9Ah/D7gEUmOGT
	 UCGH9qm6063foKYHOpNaqMTOqzB9req4LNFvy2EdDW/kLRcQOAYjU9yY9JeBCHbiWQlIe
	 XkFrL6Xa1t0Prlx5you1fyOb85omSAXcglnP3B29i7Homti1a5irrxUuQAv9LkTew/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795750226;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2F2hxqVE/hInKFHBY2zMbzmQ4nNGWwOBoQq6/i9B19g=;
	b=OEw+6TEU6+8QaoHwI6MSGtUO93lYOZH+pf+5m1pwS1XS5jjO1RPUlGA+tIhzhCstQr3l
	 7bHk5QcP0Vmhq/PxbIzI2QS8cZFxuwWo1z/656cNE0+WUhEliI/3SD88t/6r0lqcCXynm
	 1ZMztVPb6TP7UG4OL91dmbK+wm3oCCP0DDwMYfCxRgPiwLJfUe3nEN4cENBQhPd/Z3DrW
	 p9ujtp34dbsFSnzyJZu7SZTHdKLYes96uOgNrsBhs6TnORX5nZxybd7IYJ7j1281g8ElD
	 7v3PcToF7VHMN5G2TGSPOBP6QN0pDuiDslGG8VxDkZ+rrATkVePkmsrYMXEFYAkj+Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=mQtb4kDv;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC3D606A31E;
	Fri, 27 Nov 2026 03:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC3D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=mQtb4kDv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=mQtb4kDvfQ+C90Tn9jTcKpwd6Osu5dAK47bsr1q3lCpPadmpNWunL5Uf7rcuHark2txo1qbownT7a
	 BXhPI8JYsN991FEBHoyDwTjxE/9nI+TfFfLJ0/kP1jwV2CoQ7dpx8Qz3q3WRGcQ4PBjPE56GUUwANK
	 V8PKPtWJr214oJrk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26b08f931227-9db65;
	Fri, 27 Nov 2026 11:29:53 +0800 (CST)
X-RM-TRANSID:2ee26b08f931227-9db65
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46b08f930695-8422d;
	Fri, 27 Nov 2026 11:29:53 +0800 (CST)
X-RM-TRANSID:2ee46b08f930695-8422d
From: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
To: Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>
Cc: tongzhiwei@cmss.chinamobile.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] dm-pcache: fix use-after-free of cache segments on teardown
Date: Fri, 27 Nov 2026 11:29:29 +0800
Message-ID: <20261127032934.484-1-tongzhiwei@cmss.chinamobile.com>
X-Mailer: git-send-email 2.45.0.windows.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NOTE: this fix is found by LLM but reviewed by human.

pcache_cache_stop() (called from dm_pcache_dtr() BEFORE
backing_dev_stop()) freed cache->segments via cache_exit().  An
inflight KMEM writeback completion can still be in flight then: its
late callback path

  req_complete_fn -> backing_dev_req_end -> writeback_end_req ->
  writeback_ctx_end -> cache_pos_advance

dereferences dirty_tail.cache_seg (== &cache->segments[id]), already
freed -> use-after-free.  backing_dev_stop() is the authoritative
drain (wait_event(inflight_reqs == 0) + flush_work(req_complete_work))
but ran after the free.

Drop the cache_exit() call from pcache_cache_stop() and free
segments/seg_map from dm_pcache_dtr() instead, after backing_dev_stop().
The free is a local static cache_exit() in dm_pcache.c (not exported);
cache.c's static cache_exit() is left untouched for the start-failure
error path (pcache_cache_start's cache_exit: label, reached only when
cache_init() succeeded).

The other resources the late completion touches (cache_dev mapping,
req/bvec pools, task_wq, backing dm_dev) are already released after
the drain, so relocating segments/seg_map closes the only UAF window.

Fixes: 1d57628ff95b ("dm-pcache: add persistent cache target in device-mapper")
Cc: stable@vger.kernel.org
Signed-off-by: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
---
 drivers/md/dm-pcache/cache.c     | 2 +-
 drivers/md/dm-pcache/dm_pcache.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-pcache/cache.c b/drivers/md/dm-pcache/cache.c
index b0b3e21677de..c41f7b7d1d04 100644
--- a/drivers/md/dm-pcache/cache.c
+++ b/drivers/md/dm-pcache/cache.c
@@ -453,7 +453,7 @@ void pcache_cache_stop(struct dm_pcache *pcache)
 	if (cache->req_key_tree.n_subtrees)
 		cache_destroy_req_keys(cache);
 
-	cache_exit(cache);
+	/* cache_exit() is called from dm_pcache_dtr() after backing_dev_stop(). */
 }
 
 struct workqueue_struct *cache_get_wq(struct pcache_cache *cache)
diff --git a/drivers/md/dm-pcache/dm_pcache.c b/drivers/md/dm-pcache/dm_pcache.c
index 645fc27d82ba..b7abe585098e 100644
--- a/drivers/md/dm-pcache/dm_pcache.c
+++ b/drivers/md/dm-pcache/dm_pcache.c
@@ -351,6 +351,12 @@ static void defer_req_stop(struct dm_pcache *pcache)
 	}
 }
 
+static void cache_exit(struct pcache_cache *cache)
+{
+	kvfree(cache->seg_map);
+	kvfree(cache->segments);
+}
+
 static void dm_pcache_dtr(struct dm_target *ti)
 {
 	struct dm_pcache *pcache;
@@ -364,6 +370,7 @@ static void dm_pcache_dtr(struct dm_target *ti)
 
 	pcache_cache_stop(pcache);
 	backing_dev_stop(pcache);
+	cache_exit(&pcache->cache);
 	cache_dev_stop(pcache);
 
 	pcache_destroy_args(pcache);
-- 
2.43.0



