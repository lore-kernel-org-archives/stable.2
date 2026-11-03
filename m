Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699182;
	b=LwX5IggwwA5Hlr6zj7zpzbYnk7OshIkRe1KD2IAthBS+KO5jvatJ2uw7Rwqw7Btp/MLM
	 W4OzOdHmF9nreb2EpD+A6uFep/mrB66PStbV5KwVv1pOa7x/wl1k+FKibNUGJas7iZIwj
	 gtqcJ5VcMZBQ8dlrlNHV3UALRIJvHJOBc77SzUnfugjs98YlDHM3kJyFTuU7xffw47Rlm
	 gDFbRzj8qUhFjv7oBI3+QRQ4Zky1Ce8dcaDwZ/W+2p8cJr5JkgZvAbZ0ApcBR5vC8hAtJ
	 DEuVuCE4TvsxhQf+9OE5hXNyTDCh25wDir+eAcQApAqYXA+M5hRMfj19Vw2eoO6JhjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699182;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=dtKsH0jS+laGioqm28BDiqTDI0Fspbluk66RTVMMyS0=;
	b=yo7BkBed4aCeaT6lLW6jU9Z7145vOEdiQt/xiD8tJBYGYJTZRAGc7cjWDK/LWcTW94e8
	 AEKwyEA96tXp5ZlMINWasra/IeY9SfJfc+AEsUMb5pIYFDaR7263T6AG7A53dcWw75kPK
	 UlhdXBWNDY00I3x896Xn/UyVuufz9rctV6ZoreooxpdV/gHYmmMyNJCkiYEQzWZC2Q3P7
	 ZwRBgg4nw0B5T+RqXrIguZ2T/tenYV4NRFneNveG1AnmYezcnf6k0vgMKBhjqb0/+hiPc
	 z0OSyXGtltLHyjmTRso+JKNpdooJ80fRiP2gid43iyQKG66NvYrYBXMzDHjP3DK7XSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22466082BF2;
	Tue,  3 Nov 2026 09:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C22466082BF2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHE5RqrelqVU87AA--.2396S2;
	Tue, 03 Nov 2026 17:46:18 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] bcache: Release the cache kobject when cache_alloc() fails
Date: Tue,  3 Nov 2026 09:46:27 +0000
Message-Id: <20261103094627.1289665-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAAHE5RqrelqVU87AA--.2396S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45uF4xCw4ftF18tw48tFb_yoW5KF18pF
	WxKry3tF4kXw48JwsrZF1kWFyrA39aqFZ8Ca4Svw12vrn8Xr1F9F4vvw10vF1UZrykJa1a
	qF45Ka1UWF15AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWx
	JVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UXID7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgQAA2rpnIRRdgAAs9

cache_alloc() initializes ca->kobj with kobject_init(), which takes the
initial reference on the kobject, and takes a reference on the bcache
module.  The object is released later by bch_cache_release(), which also
drops the block device, puts the super block folio, frees ca and drops
the module reference.

When one of the allocations in cache_alloc() fails, the function frees
only the buffers it managed to allocate and returns an error.
register_cache() then only calls fput() on the block device and returns,
so the reference taken by kobject_init() is never dropped: ca is leaked
together with the super block folio and the module reference.  The
comment on that path still claims that ca->kobj is not initialized, but
kobject_init() is the first thing cache_alloc() does.

Put ca->kobj on that path so that bch_cache_release() runs and releases
everything.  bch_cache_release() frees ca->buckets and ca->prio_buckets
as well, so clear those pointers in cache_alloc() after freeing them, and
drop the module_put() from the error path because the module reference is
now released by bch_cache_release().  Skip the bucket page free in
bch_cache_release() when cache_alloc() failed before allocating them.

Fixes: cafe56359144 ("bcache: A block layer cache")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/md/bcache/super.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 97d9adb0bf96..5d4975873c2e 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2221,7 +2221,9 @@ void bch_cache_release(struct kobject *kobj)
 		ca->set->cache = NULL;
 	}
 
-	free_pages((unsigned long) ca->disk_buckets, ilog2(meta_bucket_pages(&ca->sb)));
+	if (ca->disk_buckets)
+		free_pages((unsigned long) ca->disk_buckets,
+			   ilog2(meta_bucket_pages(&ca->sb)));
 	kfree(ca->prio_buckets);
 	vfree(ca->buckets);
 
@@ -2364,8 +2366,10 @@ static int cache_alloc(struct cache *ca)
 
 err_disk_buckets_alloc:
 	kfree(ca->prio_buckets);
+	ca->prio_buckets = NULL;
 err_prio_buckets_alloc:
 	vfree(ca->buckets);
+	ca->buckets = NULL;
 err_buckets_alloc:
 	free_heap(&ca->heap);
 err_heap_alloc:
@@ -2380,7 +2384,10 @@ static int cache_alloc(struct cache *ca)
 	free_fifo(&ca->free[RESERVE_BTREE]);
 err_btree_alloc:
 err_free:
-	module_put(THIS_MODULE);
+	/*
+	 * The module reference taken above is dropped by
+	 * bch_cache_release() when the caller puts ca->kobj.
+	 */
 	if (err)
 		pr_notice("error %pg: %s\n", ca->bdev, err);
 	return ret;
@@ -2408,13 +2415,12 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 			err = "cache_alloc(): unknown error";
 		pr_notice("error %pg: %s\n", file_bdev(bdev_file), err);
 		/*
-		 * If we failed here, it means ca->kobj is not initialized yet,
-		 * kobject_put() won't be called and there is no chance to
-		 * call fput() to bdev in bch_cache_release(). So
-		 * we explicitly call fput() on the block device here.
+		 * cache_alloc() has already released the buffers it
+		 * allocated, so go through out: to drop the reference
+		 * taken by kobject_init(); bch_cache_release() then frees
+		 * ca and drops the block device and the super block folio.
 		 */
-		fput(bdev_file);
-		return ret;
+		goto out;
 	}
 
 	if (kobject_add(&ca->kobj, bdev_kobj(file_bdev(bdev_file)), "bcache")) {
-- 
2.34.1

