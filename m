Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047693;
	b=fxtvLr1Cncb1UkuMbYZMaIsJXGMGVm8Q1bDrp1aqf5mAHBfIQ79IXcR4uZzP4ydMzjTw
	 EYzBb0FA11nDEN9Y+SfBqf9zKbKOk/HfoJeTswFukHoj8a8MkaHJkRJoA4CghVUkR9mbF
	 uYjHPmPdF72pNENonMR4GETuFQVvvHcyFiiEihpAXVX4iOTgTKwlcBa6xlu8lSGQ5SUnd
	 p+IIodvyS3sp5jFL0dzq14RzggMcH4p9kbiUYhyy5XJ/HkiPArDZvlGN8EsrBesnkXVzV
	 yrgTTgj5QCix3pTKaAA8u9CWByAu6KOEPBQnkRPhpMEz3m22XvrlvO+qGtuRrJ9k6EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047693;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+fc7bZxaQfGyCHlEvRHV3Z1buf9Ho21bfWYO0Ebh1KE=;
	b=J2Z7lMWpqc9K6TDFjK1bzh039HvpsplD7dVj2ItkpnA/h3T3n/P+zB3UK1d1MtMfL3sv
	 bhxoiHaXHc3ofnXAptHXUqW8z7K3QZO1pKWmKMGyWQvuwnXjptHF0YNun10dXSO9D0A+h
	 QWQiBcGoPri2J4i5whsdavw4yCOJ3JmKZKR/GtRWHswdWd/rPtyDfmLsevkuG4Whwn/B6
	 vS0XZNqQ+vfe/GIDcxnd+o2/7Ca6Zj/x02k0amtJZ3FWO5Y2P/tJ3K1GZhAhm6Cd6jmht
	 vosleYEV7IZ8zLDQdzUpEfMrENQuAtmEOsRVy/t2qVuFgYfz8Df+wKo9aNIx2pafGOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="duaziej/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB5606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duaziej/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03A21F0089F;
	Sat,  7 Nov 2026 10:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047693;
	bh=+fc7bZxaQfGyCHlEvRHV3Z1buf9Ho21bfWYO0Ebh1KE=;
	h=From:To:Cc:Subject:Date;
	b=duaziej/rjQi9zho5XgduvOU+FzOJ0VdPJsxNA+NcX8/2Y+lVzh54eUya59agwF/1
	 dmam4fmV/zViBblk+HiktKvsHir2yHsFYhZv5vmYa+b3zx7Vp9cjFITyz/yPRy0lOk
	 8K9Q/rHBXRb5Cqous75evFnMjTX18Di4njaDJDdDbFGoFoKjGhHFN0pC36lP1SQHgo
	 P+vsoyngsDeINRtXT/clDB9mLvRwg1FNppoIOMDwbpA0284bN5kpzJ0LAqxJzGXVAA
	 z2R//umPkmaDkUxxVRKUwLnGmau6h3GTCkwuKNFH5FfnfqfwioaMLODyPJwQ9/UkNq
	 MstNrwdWW9Ujw==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:51 -0500
Message-ID: <20261107053451-failed-6.6-a605d5d71a6d@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a605d5d71a6d280c43c7ede9778dda63fb5c3f22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053451-failed-6.6-a605d5d71a6d@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




