Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048523;
	b=DrROpPrfyEMzeKTE4n+4rALLE2Ccu1VK3JPMU7FMecUehz85m2M4BjNHNcARkxjaY6Mm
	 fgrceo6QnaYz8onQ7DU0WuDxlQ7hHjs26HzUks21VWlXk6euXpMKUXREgETApCiBd18Xc
	 +hhrnQ2uqY2Dvm5W/Y1BoyJ50Vc8rvKRBggsxtJkKRMvnlQVtHQPk5eZKUyzTNlNEpXg2
	 5GoQoVK/4tmPsCWmJddXEW4850fP7G9n/ASxK4Jdk00Vx6QxZ1sgqr81lB+RtOA0pBF3p
	 7BbCupHQkg7+f5hU/NwDP2TtcGOUTaO8gpVfWEY2K+AdxPYb1mKJa/Y3H6hwjxMckZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048523;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FTMqlU04LCAVgN2DV/98t97dM1+QhhEmY3/xukFJW08=;
	b=yh3IXddRYOFQW+5lKC1QIyRDCnZEfma2F9s+tL2yiVfxQTfzv2/DASr03dBOAnmo/pS9
	 EVyHVEdJPdOq+jyOsZdw5eP4jmJJvUQsCo/OLL2clLXaPcj6JAtNVpf+SrzQdN8544U2D
	 jnWktd26fLWN0lmYGWsCVdv+tz5XtVDgIk1RUDwNAduPEUVXPU3ztsT3yhRi6HpZi3vvD
	 SnrzZDzjDzx6ZYVw8YBOXFKeKTSpJMJshgKFSC7InM15tpjA6ndLPmhGFqDv7zOhLqjhd
	 VlE26uBDch+FspnvgHAlDNTatogdubMBIR1A3Kx9mSlV27pKVlvBELlQQPpY/Cwmcww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6TKPC2c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10516606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6TKPC2c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806C71F008A3;
	Sat,  7 Nov 2026 10:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048522;
	bh=FTMqlU04LCAVgN2DV/98t97dM1+QhhEmY3/xukFJW08=;
	h=From:To:Cc:Subject:Date;
	b=f6TKPC2cQ7ZCL5LfMMsoGd7lrz3YUvtNYW+OkcOYGnz2lch2KC8y0h//4VpJo4XEz
	 9jPtjwYYxKEHGmRtk6aq5mlsX/Yf/TsLXNPJ9xITuAbeVg+bQcVK9I7ESQDN/r9EIo
	 vV5PitwvDukKppV2cGzwUljLvcNZ4qs9W4NfGPNXz5tE6vhYuL1ZiMq+22SEaMuVaw
	 KJccHWVigEnzPGSULcjoqhZf/4tiu1GFyanVjEdLsIp+8Aj61I4V5uhxkKnzCAU/Ue
	 dBfCYBgM0ojDvLF8uhiSFLVcq6STG7yoJkoX3h7kEDEbq90jAzQ4TgTcw1HhvgEEan
	 ZtWviQXLzNwcA==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:48:41 -0500
Message-ID: <20261107054841-failed-6.1-a605d5d71a6d@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a605d5d71a6d280c43c7ede9778dda63fb5c3f22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054841-failed-6.1-a605d5d71a6d@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a605d5d71a6d280c43c7ede9778dda63fb5c3f22 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Sat, 10 Oct 2026 14:55:46 +0800
Subject: [PATCH] f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()

f2fs_read_end_io() uses "in_task() && !irqs_disabled()" to decide
whether it is safe to sleep, the result is passed down as @in_task to:
- f2fs_put_dic() -> f2fs_free_dic() -> f2fs_release_decomp_mem()
  -> vm_unmap_ram(), which may sleep.
- f2fs_end_read_compressed_page() -> f2fs_cache_compressed_page()
  -> f2fs_grab_cache() -> f2fs_lock_cache(), which may sleep in
  wait_on_bit_lock().

However, the check still treats below task contexts as sleepable:
- with spinlock held via spin_lock(), i.e. preempt count != 0 while
  irqs are enabled.
- with BH disabled via local_bh_disable().
- inside an RCU read lock on kernels with CONFIG_PREEMPTION.
- with any spinlock held on kernels without CONFIG_PREEMPT_COUNT.

So the "sleeping function called from invalid context" issue fixed by
commit 08a7efc5b02a ("f2fs: vm_unmap_ram() may be called from an
invalid context") can still be triggered.

The block layer provides bio_in_atomic() for exactly this purpose, it
checks rcu_preempt_depth() and preemptible(), and conservatively returns
true if CONFIG_PREEMPT_COUNT is disabled, let's use it instead. The
difference is as below:

 old: intask = in_task() && !irqs_disabled()
 new: intask = !bio_in_atomic()

 Context                              | old intask     | new intask
 -------------------------------------+----------------+----------------
 Hard IRQ / softirq                   | false          | false
 IRQs disabled                        | false          | false
 spin_lock() held, IRQs enabled       | true (wrong)   | false
 BH disabled by local_bh_disable()    | true (wrong)   | false
 RCU read lock (CONFIG_PREEMPTION)    | true (wrong)   | false
 Spinlock held, w/o PREEMPT_COUNT     | true (wrong)   | false

Note that on kernels without CONFIG_PREEMPT_COUNT, bio_in_atomic()
always returns true, so dic freeing will always be offloaded to sbi->wq,
and compressed pages will not be cached in f2fs_read_end_io(); this is
the price of correctness, since there is no way to tell whether the
current context can sleep.

Cc: stable@kernel.org
Fixes: 08a7efc5b02a ("f2fs: vm_unmap_ram() may be called from an invalid context")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ae3bde0767f3c..a8d39add5cbe0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -271,7 +271,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(bio_first_folio_all(bio));
 	struct bio_post_read_ctx *ctx;
-	bool intask = in_task() && !irqs_disabled();
+	bool intask = !bio_in_atomic();
 
 	iostat_update_and_unbind_ctx(bio);
 	ctx = bio->bi_private;
-- 
2.53.0




