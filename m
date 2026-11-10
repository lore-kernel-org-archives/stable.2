Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345934;
	b=G7JvAV8zHcG92beYmwF3zXdvJwMd0RM3kp8YXBItWkV9FOgJeMuFsIhgVUoRp7OiDWRY
	 VBszp1cYW1i7HNEmVSZEXWYjAl1jM4Jp3AfANjKJB41irHlLhSLGoM0yxCK3GanT9Oi74
	 7MirLyZYISgLJ5tdhlbIzkbV2hfZhSxZOvCtblFVswYrEaqZw1aTFJFYcyjMhnVq15Bvv
	 LnCxS2qgjUZZFUnb1t7eMacFiwjUtsd2eFlEUTO44Cvu85PEfKZQtwFS7jrACgZTtGROj
	 MeH+iBH3IWWVjqHbnFWOas23t87Jfx0XmSlXe8QXqUDc9PFGeQ3JIu2RiuZ8SgUPzOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345934;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rlLXDvl/W3lJUGIAjS6E75gIw4tl62P86yxv1YaoYMY=;
	b=xOn05a+S8GizAL+590+InmpoYZsO19GIDSiGp7CP0rweoI8MQc/2ALYknVpqvWa9FjAl
	 4LPWcURHB+UMKsKPgYaGr7Q9tNqdWDBrQo0Fp1Jo2p7fInvB+Rs7OBtmQbrkUH4Rnh3Fw
	 cnyhnJo9YPGAenPy5ijqNAMsKtkDrjiZeBA3QqKgEfE1bw8QFXGr54UiLBbJTWZnxqRBK
	 DAskp2o3gauf1yKakwuPwWguR12dId+fD0pyXzWlx7TTqbWGUHvE0Ev57St25he7xjrOn
	 bOhsz/T13EuG8IHkJroFUd6PoD10jSHYzWZBXha+0Vwtxs8lvs8XsTGd8ooBtTduTBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAS0Ytnv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C297A606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAS0Ytnv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7121F008A5;
	Tue, 10 Nov 2026 21:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794345933;
	bh=rlLXDvl/W3lJUGIAjS6E75gIw4tl62P86yxv1YaoYMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UAS0YtnvXgUakM8anc6clu3jXMI8IGJvL/D5kDH+EuUytJXMF9XTf650Nbge0R8xl
	 9PzvmE7NZiVjKOC6uqOY3euhu8ilPEVA1+NVN74PCGXYSQAQ0P0w6iXzxfz+abaZP9
	 2YMMwotrR8YSRgHW4NuoraoqgU89Golw2mV6hq+Ce3SJfVe+fMreJPioAe3xJdcCq1
	 aJ+BD+2kSv1hrc97iYYNN6+j6xxy9ECeyJ8+RseZURiqYSSP4IBvjg00kkrlg7CwW9
	 esHZSwivpBB6Cc5+tRTjmiZl+T/eObuQxINJ0uoJ2FdpNsKdc76YtWVrK6++lWf4lI
	 FZ4gGjwGG6jIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()
Date: Tue, 10 Nov 2026 16:25:30 -0500
Message-ID: <20261110212248.3885710-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110212248.3885710-1-sashal@kernel.org>
References: <20261107052219-failed-6.12-a605d5d71a6d@kernel.org>
 <20261110212248.3885710-1-sashal@kernel.org>
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
index 47743a0bdede5..dd7acc6ed32dd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -287,7 +287,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(bio_first_page_all(bio));
 	struct bio_post_read_ctx *ctx;
-	bool intask = in_task() && !irqs_disabled();
+	bool intask = !bio_in_atomic();
 
 	iostat_update_and_unbind_ctx(bio);
 	ctx = bio->bi_private;
-- 
2.53.0

