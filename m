Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D6931AABF;
	Sat,  5 Sep 2026 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573682; cv=none; b=MI0IQMEoaVqdayXJ6z+qMzC8HV7hgmvDcLvnSueCTXnfLzjRC7uAbFVGAKC7rsqVUjv3Y2LvrKOfQbk6bDfWhS/aWTGAUNUMWm69e4xVF1R42tCPrDBOjOMMEELaQ088D818R+tqaTbfCkf4a+AgNW+DEL+T5GT/mPIpIqG15ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573682; c=relaxed/simple;
	bh=Vr9xVCJnWwGl23PyxkEFyeYEriwBHvZSX88WNDHLsKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lkEsyT7TnaY3vtVVay5/gBXitbABw9+PmFvIYo9rNn63yIy4gPjwa4gXaZUlDFiIQwAVKej/COGmzy7fh+lryUI+frIm8xJSUGzWKDJt55uGZQh1/yIa6rfwsEpP5FqP+Ai2T1p4sY8uGAtFXi9bzdQaPbk0NlmbeXbgYgDyzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=132.226.202.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDn7y_qd5tqiL3wAA--.5269S3;
	Sat, 05 Sep 2026 10:01:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgAXY8fpd5tq1ktUBA--.60413S2;
	Sat, 05 Sep 2026 10:01:13 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-dev@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Cen Zhang <zzzccc427@gmail.com>,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH 2/2] f2fs: compress: drain decompress contexts at unmount
Date: Sat,  5 Sep 2026 02:00:17 +0000
Message-Id: <20260905020017.421913-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905013438.419932-1-fanwu01@zju.edu.cn>
References: <20260905013438.419932-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgAXY8fpd5tq1ktUBA--.60413S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?AE8hSwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI0BIBUSNTPQKPHyMmhtjOuYEQDTN1noouyVmlJdqmzKN+x4
	PgwtqEGbyXKncBl3CTGp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW3Wr4rWrWkur4fWr4fXF47GFX_yoW7KryfpF
	W5Cry8Cr48XF1UWws7Ja1Y9rySkrWFkF47GrWag3Z3Z3WYqrnYqF1vkryDZrZ8Jr95Xa4q
	ya1j934fGrW5tFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU818BUUUUUU==

A decompress_io_ctx can release its final reference from several
completion contexts: the cluster's verity work and the in-task
decompression completion that patch 1/2 reorders, but also
f2fs_finish_read_bio() releasing the bio's compressed-page references,
for example when the per-bio verity work of a mixed
compressed/uncompressed bio runs on the global fsverity workqueue,
which unmount does not drain.  Whenever the final put happens after
the cluster's pages were unlocked, f2fs_free_dic() can dereference
sbi (page_array_free() on sbi->page_array_slab, and f2fs_put_dic()
reading sbi->post_read_wq in softirq context) after a concurrent
unmount destroyed it.

Track the number of allocated decompress_io_ctx in sbi and make
f2fs_put_super() wait for it to drop to zero before the workqueue and
the page-array slab are destroyed, so f2fs_free_dic() only ever
touches a live sbi.  This is the approach proposed in the report
below, and covers the completions patch 1/2 does not reorder.
Waiting there cannot deadlock: a worker still verifying holds the
cluster's page locks, which blocks unmount earlier in evict_inodes(),
and once those pages are unlocked its tail performs no further
filesystem I/O.

Verified with KASAN (QEMU) by parking the per-bio completion right
before it releases a compressed cluster's bio references, using a
readahead that spans an incompressible and a compressible cluster of
a verity file: 14 reports with patch 1/2 alone, none with this wait,
with umount returning only after the parked completion finished.

This issue was found by an in-house static analysis tool.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Cc: stable@vger.kernel.org
Suggested-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 fs/f2fs/compress.c | 15 +++++++++++++++
 fs/f2fs/f2fs.h     |  6 ++++++
 fs/f2fs/super.c    |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index e387a74f5c2a..1e63e934925e 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1705,6 +1705,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 	dic->log_cluster_size = cc->log_cluster_size;
 	dic->nr_cpages = cc->nr_cpages;
 	refcount_set(&dic->refcnt, 1);
+	atomic_inc(&sbi->nr_decompress_ctx);
 	dic->failed = false;
 	dic->vi = cc->vi;
 
@@ -1769,6 +1770,8 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
 
 	page_array_free(sbi, dic->rpages, dic->nr_rpages);
 	kmem_cache_free(dic_entry_slab, dic);
+	if (atomic_dec_and_test(&sbi->nr_decompress_ctx))
+		wake_up_all(&sbi->decompress_io_wait);
 }
 
 static void f2fs_late_free_dic(struct work_struct *work)
@@ -2063,6 +2066,9 @@ void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi)
 
 int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi)
 {
+	atomic_set(&sbi->nr_decompress_ctx, 0);
+	init_waitqueue_head(&sbi->decompress_io_wait);
+
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	char slab_name[35];
 
@@ -2084,6 +2090,15 @@ void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi)
 	kmem_cache_destroy(sbi->page_array_slab);
 }
 
+void f2fs_wait_on_decompress_io(struct f2fs_sb_info *sbi)
+{
+	if (!f2fs_sb_has_compression(sbi))
+		return;
+
+	wait_event(sbi->decompress_io_wait,
+		   !atomic_read(&sbi->nr_decompress_ctx));
+}
+
 int __init f2fs_init_compress_cache(void)
 {
 	cic_entry_slab = f2fs_kmem_cache_create("f2fs_cic_entry",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8376bbe58ee3..b03853172346 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2025,6 +2025,10 @@ struct f2fs_sb_info {
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
 
+	/* For waiting for in-flight decompression contexts at umount */
+	atomic_t nr_decompress_ctx;
+	wait_queue_head_t decompress_io_wait;
+
 	/* For runtime compression statistics */
 	u64 compr_written_block;
 	u64 compr_saved_block;
@@ -4694,6 +4698,7 @@ int f2fs_init_compress_inode(struct f2fs_sb_info *sbi);
 void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi);
 int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi);
 void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi);
+void f2fs_wait_on_decompress_io(struct f2fs_sb_info *sbi);
 int __init f2fs_init_compress_cache(void);
 void f2fs_destroy_compress_cache(void);
 struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi);
@@ -4749,6 +4754,7 @@ static inline int f2fs_init_compress_inode(struct f2fs_sb_info *sbi) { return 0;
 static inline void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi) { }
 static inline int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi) { }
+static inline void f2fs_wait_on_decompress_io(struct f2fs_sb_info *sbi) { }
 static inline int __init f2fs_init_compress_cache(void) { return 0; }
 static inline void f2fs_destroy_compress_cache(void) { }
 static inline void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index be22c31015ef..8951ede2ea48 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2075,6 +2075,9 @@ static void f2fs_put_super(struct super_block *sb)
 	/* flush s_error_work before sbi destroy */
 	flush_work(&sbi->s_error_work);
 
+	/* wait for in-flight decompression contexts before sbi destroy */
+	f2fs_wait_on_decompress_io(sbi);
+
 	f2fs_destroy_wq(sbi);
 
 	kvfree(sbi->ckpt);
-- 
2.34.1

