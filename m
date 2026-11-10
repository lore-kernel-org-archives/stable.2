Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344339;
	b=tAYQ3taFuS+GBUZoQXX+a7OU53C2lTlFXt4QY350IrXo4bHbJsTZaGqXxMSzmnUfBGYo
	 7S8q4ArXrBWS63+1gT3MEnj8HYLUeTGHLuXnIMPJuwNeVBcYVrdZx79UPjlufLv7pPttX
	 71UnF97gVGv2TZPg6LDQ9PmxVd03MuR/fFj7zR6muS9PUoll8akJZOHT47mAD93jy8uL+
	 ggQ1bLsxq63akA2Yk2uqyOhVjsIPYZurNTJg9RnQiZBG7pF0byomr7A5il1dKazX/33Xz
	 ebp2J9zhI3aI1Prg695pO3roBC54rS8c9AZ6rOnzZqd5GL4rvYzFUPU5tfy2reeTyfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344339;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fmzIUfG5pBAq07/ZBe3A8DgLKLeFmv8BAnuK528caC0=;
	b=JU3+xDW+HDDttHhxd8ZqCP0QBTxPacMogEH+M9urFMf4CGybN9FCTCdVWc3Ahd8nNOJT
	 Q903wXrN/TS9u9SlTBfQVE2Mb6hg4/xv/m8JuNxVNqZvoOUmWATRTlgMDEf3SeoqFonu4
	 jQ1dXkC1U5gjseBLi4y84p3KHkIL9WfZguxgtcz57o8QRpd2qm+M4qQGfmu4piqqoOpeE
	 GVaFvT78AgFR+BBrSm7VU6VdeShaimTJFly1OIZRPhkLvd4v4yDfSd1adtW7ch55JDOEC
	 h1izSc+fSfRfCRS3vs1sUI+6Chpp7LUIgSy5kvzfSsTQb1AKjY4LImx7YHOAASuXoYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCVlxCvV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62F9606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCVlxCvV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17A51F008A1;
	Tue, 10 Nov 2026 20:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344338;
	bh=fmzIUfG5pBAq07/ZBe3A8DgLKLeFmv8BAnuK528caC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gCVlxCvV/UU653XRQSZscMneeGJewMbxsFRLWh2woW45QLONlB8UFob4wx5dc9r5j
	 vFtYCWZSKIP5wwoOMdHf0atOGXyEoyXLvGXcJyhgrHjPf2l5QbLl/vycEfgnGnHtsD
	 Xh26S/iYWPMaXa56i1gz3mHwoVhYBqYN6sDnkjDMUTjPrH8+Ytq/CFLokcxnRWcq+M
	 cyoKEqS+Nk/O9jUeSJZa9fmwlpeMwdZ6Q8GRIYln44F1Iu11CnTTb0p55ewpjtSnWP
	 HySnuVitTljVU4ZwwuU/V/4MIOqBPQrImLaHlGQzQKNTd5qLG5ZCkSGL5khbFnpkNe
	 xo7b4+KwB6ypw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()
Date: Tue, 10 Nov 2026 15:58:55 -0500
Message-ID: <20261110205812.3791945-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110205812.3791945-1-sashal@kernel.org>
References: <20261107051116-failed-6.18-a605d5d71a6d@kernel.org>
 <20261110205812.3791945-1-sashal@kernel.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit a605d5d71a6d280c43c7ede9778dda63fb5c3f22 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index eba1e025b9d6e..25fedcd3db23a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -287,7 +287,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(bio_first_folio_all(bio));
 	struct bio_post_read_ctx *ctx;
-	bool intask = in_task() && !irqs_disabled();
+	bool intask = !bio_in_atomic();
 
 	iostat_update_and_unbind_ctx(bio);
 	ctx = bio->bi_private;
-- 
2.53.0

