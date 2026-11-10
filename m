Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347654;
	b=Hpy2gTa47RzFf7KZe8WNW3opA8d8ila6MEQwVsMZiHm6h0ni6eI/L9USBlFBsmG5Xeqo
	 uaBh5cLYAV9t8kXZSmfV/MV4In22zYjJa0RsUecIhveXhjjM1C5IfZfRL+69Ohp6RYzgA
	 qnuUIBbjHRyZoY+Xhe9p1K4bYGD8NhBfW4dz0LoITLcf3TJwISRoPM+3++mkuAuwoYuYe
	 fg4bGSZ5YnSr+6ur8MrORe3jmcYjQwTEfM0omVe7u3z/knNXbCYtKjzV8EffP0ObkkUJ6
	 wFI3Smv1JOeSm7HfbU1edlDEkzylpP7hmCxjcf9UJ9x68j7Vu4ILdWknqiX/ZZRgfcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347654;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CsvWyDfjQnKVUtXqRV+SiMfXSH+JqmAfV1fsoWfsjdI=;
	b=KkQmXDojP9aJxEJ6zOGVT2Cy11Af9vXtkn9rovfeThCOAt9iBUxH+DcTDcWSF917NuLr
	 HtH56Zm3yIcBipS8ZwjL5ZkOIAHxIX5B6RTmAvaHUmWCwxoNC4aN+EjzzDA5bNWj0OKPI
	 rW+l5tP1xANnm3mNifRNLX7IIQWN4CqdvJDsVsNkn3r78/+8UMNLoitIqrL0Lu9IqJAyB
	 s0Z6Rj+IckU1n43O6nHUpkoHJmFhoItZTUXXxnrA4JqZJ6UuSEWQf9RnuvvgTqWQDFRi6
	 OE/6j/oLfD6we6bSrjvy4SzgXVGIcMK6h58ILpb+9z1w1mK8CgVMwzXvGLJK14Gj+PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eq7dT32w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3DD606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eq7dT32w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7991F008A4;
	Tue, 10 Nov 2026 21:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347653;
	bh=CsvWyDfjQnKVUtXqRV+SiMfXSH+JqmAfV1fsoWfsjdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eq7dT32wsSsYu83MH4hDO4dRXFQUGu70gCAGyu37OPqpJZLvPzpZ4jRpxMQq2lAvK
	 CsIxmjchqwlWtmw00Bu/2Uk9vhB/8a6aMIE8YR5MJajJFY0Y0DquLmw9B1W9o06KUd
	 2gAgcnBGIfp5m2M+t4qBLsOsx9khGICIoffTPkJqMKV8BD6rh8pzUBz7kCMHTi+MPe
	 wYPNFcOsNlIP8dYs+JWdvaIATcpYKKVTYmZXkhpzv+lOLh3Mz37/LXM1Fi5rxyBsoH
	 eMKjNWaf9hEqHW31feCGdzdEHtNJW3DlSje0NAe+geeSY3qUOOw05TlZ8c6QnHSm5E
	 Yz9Z2Ci7fEkJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()
Date: Tue, 10 Nov 2026 16:54:12 -0500
Message-ID: <20261110215136.3962883-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054841-failed-6.1-a605d5d71a6d@kernel.org>
References: <20261107054841-failed-6.1-a605d5d71a6d@kernel.org>
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
[ sashal: replaced !bio_in_atomic() with equivalent inline RCU and preemption checks because the helper is unavailable ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6384ac931bb7d..ea27184c4af6b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -273,7 +273,8 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(bio_first_page_all(bio));
 	struct bio_post_read_ctx *ctx;
-	bool intask = in_task() && !irqs_disabled();
+	bool intask = !(IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth()) &&
+		IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible();
 
 	iostat_update_and_unbind_ctx(bio, 0);
 	ctx = bio->bi_private;
-- 
2.53.0

