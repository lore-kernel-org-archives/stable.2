Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDB331AABF;
	Sat,  5 Sep 2026 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573671; cv=none; b=OVE4ft0kOD9MdAQ02bY6GbFYctoxGsX0QEnQDilPsEv1PbiQJ3Pzi0gRY7SNcKc4Tl7OZjrHnQe0gfUz5pkh73GUSRFgcO5ZHvhv9yTyloW38n3kgyQw5+7sK5kE//YgOe3cAGZ4HOwjYXo0WYXwrrzdFIC3eIqhuEVVD5m+S7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573671; c=relaxed/simple;
	bh=SYI2A3HyLj9jfoUI9TX7ac1yGpW1KhRC5B58efLpMH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmokBLiEva3/8l22eBkEHbIhwKDOeZKfIsYdy1hST9r9oqXTCsvrOYaw3tU8jNFApb2Lg4JeXRYp8fHIPw2VsO2HyMl0VV2l4w/YCmA7aE+ExUwPo+1tC7yGLCacT9Eiw1ozq+vFY1of9rUNlAJzmH9X3lmrqmT+srcCDedNqjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wD3QjWzd5tqsrzwAA--.10895S3;
	Sat, 05 Sep 2026 10:00:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgB35cqwd5tqMUtUBA--.5025S2;
	Sat, 05 Sep 2026 10:00:16 +0800 (CST)
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
Subject: [PATCH 1/2] f2fs: compress: fix use-after-free of sbi in read path
Date: Sat,  5 Sep 2026 01:59:21 +0000
Message-Id: <20260905015921.421873-1-fanwu01@zju.edu.cn>
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
X-CM-TRANSID:zC_KCgB35cqwd5tqMUtUBA--.5025S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?0z5tBwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI14Of1bJjDmrt5VVYQqEudo3z0OsTZjnDlQkKrfpGf0KB9a
	bQAp+VeTysGDiosA2dc=
X-Coremail-Antispam: 1Uk129KBj93XoW3Xw4UGryfXry5urWrtF1DJwc_yoW7Ar4kpF
	WYgFs8trs5WF4kXw48J3Z29rySkryrJFW5Grn2k34xZ3Z5XrnagryktFyqqFW5Cr95Jayv
	yr4UK347uFZ8AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

In f2fs_verify_cluster() and f2fs_decompress_end_io(), all pages of
the cluster are unlocked first, and only afterwards is the reference
to the decompress_io_ctx dropped via f2fs_put_dic().  If that is the
last reference, f2fs_free_dic() still dereferences sbi:
page_array_free() reads sbi->page_array_slab_size and calls
kmem_cache_free() on sbi->page_array_slab, and when not in task
context f2fs_put_dic() itself reads sbi->post_read_wq.

Once the last page of the cluster is unlocked, a concurrent unmount
can evict the inodes and proceed to f2fs_destroy_page_array_cache(sbi)
and kfree(sbi) in kill_f2fs_super().  The read path has no page
counter that f2fs_put_super() waits on, and f2fs_verify_cluster() runs
on the global fsverity_read_workqueue, which unmount does not drain.
read() on a compressed fsverity file returns as soon as the folios it
waits on are unlocked, so a read() followed by close() and umount()
leaves the completion tail exposed: when the worker is preempted
between the last folio_unlock() and the end of f2fs_free_dic() while
another CPU completes the unmount, f2fs_free_dic() accesses the freed
sbi:

  BUG: KASAN: slab-use-after-free in f2fs_release_decomp_mem
  Workqueue: fsverity_read_queue f2fs_verify_cluster
  Freed by: kfree <- kill_f2fs_super

f2fs_decompress_end_io() drops the final reference in task context
when all compressed pages of the cluster were served from the
per-filesystem compress cache; it shares the same sbi-dereference
tail, so the matching reorder is applied there as well.  A completion
in which the per-bio verity work or the cluster's verity worker
overtakes the submitting context's compressed-page release drops the
final reference in f2fs_finish_read_bio() instead; that completion
keeps the pre-existing exposure and is covered by patch 2/2.

Drop the decompress_io_ctx before unlocking the last page of the
cluster, so that all accesses to sbi happen before the last unlock.
This mirrors the ordering rule the write path was given in
f2fs_compress_write_end_io() (39d4ee19c1e7), and needs no new state;
the counter approach proposed in the report below is implemented as a
complement in patch 2/2.

This issue was found by an in-house static analysis tool.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Cc: stable@vger.kernel.org
Reported-by: Cen Zhang <zzzccc427@gmail.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/20260629052811.2167181-1-zzzccc427@gmail.com/
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Note for reviewers: the KASAN report above was made deterministic with
a 10 s msleep() injected between the last folio_unlock() and
f2fs_put_dic() in f2fs_verify_cluster(); the use-after-free itself is
the unmodified put_dic -> free_dic path, and the trigger is a plain
readahead() + close() + umount().  With the same injection on top of
this patch there are no reports (tested on v6.19 and on the v7.2-rc3
baseline this patch is based on); without the patch, 28 reports on
each.  An independently captured report of the same bug is referenced
by Closes:.
---
 fs/f2fs/compress.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ce88092d9ce2..e387a74f5c2a 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1795,6 +1795,7 @@ static void f2fs_verify_cluster(struct work_struct *work)
 {
 	struct decompress_io_ctx *dic =
 		container_of(work, struct decompress_io_ctx, verity_work);
+	struct folio *last_rfolio = NULL;
 	int i;
 
 	/* Verify, update, and unlock the decompressed pages. */
@@ -1807,10 +1808,20 @@ static void f2fs_verify_cluster(struct work_struct *work)
 		rfolio = page_folio(rpage);
 		if (fsverity_verify_folio(dic->vi, rfolio))
 			folio_mark_uptodate(rfolio);
-		folio_unlock(rfolio);
+		if (last_rfolio)
+			folio_unlock(last_rfolio);
+		last_rfolio = rfolio;
 	}
 
+	/*
+	 * Drop the decompress_io_ctx before unlocking the last folio: the
+	 * final put still accesses sbi, and once the last folio is
+	 * unlocked, a concurrent unmount can destroy it.  Matches the
+	 * write-path rule in f2fs_compress_write_end_io().
+	 */
 	f2fs_put_dic(dic, true);
+	if (last_rfolio)
+		folio_unlock(last_rfolio);
 }
 
 /*
@@ -1820,6 +1831,7 @@ static void f2fs_verify_cluster(struct work_struct *work)
 void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
 				bool in_task)
 {
+	struct page *last_rpage = NULL;
 	int i;
 
 	if (IS_ENABLED(CONFIG_FS_VERITY) && !failed && dic->vi) {
@@ -1845,14 +1857,19 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
 			ClearPageUptodate(rpage);
 		else
 			SetPageUptodate(rpage);
-		unlock_page(rpage);
+		if (last_rpage)
+			unlock_page(last_rpage);
+		last_rpage = rpage;
 	}
 
 	/*
 	 * Release the reference to the decompress_io_ctx that was being held
-	 * for I/O completion.
+	 * for I/O completion, before the last unlock_page(): same rule
+	 * as in f2fs_verify_cluster() above.
 	 */
 	f2fs_put_dic(dic, in_task);
+	if (last_rpage)
+		unlock_page(last_rpage);
 }
 
 /*
-- 
2.34.1

