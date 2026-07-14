Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCFE47D929
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037976; cv=none; b=d88TtRLgJQCELp9OUUGJH3Oj/+b/AsxXREHn0DrCR3QCsWMxs3zrjlewg9Nzc4bnXTRhlib7SzXwVU97ZZw6uoC2QWZPQqBEsTBOFZHhsqZGy0+EDQCtJ06Qb9YzD/X5JOyrl0IZUKQASq6O2EaDcJvXgxVw9o59kc2YTeTRxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037976; c=relaxed/simple;
	bh=ELWD60fxd7hMcnCF5rdlp1wliX0R1ShlRk1ghGPKjMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApRYRtVHq548qSk6VHnwBWrV6zdOgWA1/XyC3jUCaRBt4penyetPwlXH+lWma6+M72+QAlzRNjpBZeqMSwC0xe2glMQTjQOu8dX/6enBAdMTE1Y7CxH2jETMUnqiNgyeCspmNB31fUBtKOtnuPc9ew0tGRmof5xNT8V4fuDMQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rpzm7GGl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rpzm7GGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B9A1F000E9;
	Tue, 14 Jul 2026 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037974;
	bh=pQIIvhTEzQeESioJuQJgZ94FGl+q8LlRv6y6P6UnRmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rpzm7GGlW/i/drGgx+8JUZrTekQpxpH67jyC8BGWISV83OuhYuQSjiZ2mq8fsRef8
	 OGlW8HDHPxB8yCFwpAF0EOlpqNFdknxe6oeQ+mYGupwqfUA+LZLX4+HHDvz0+S5+Bx
	 OQ+/cKk1QPZspufRoa+tFdyfBwwN+SVbdT630zc5OKIdfE6qhCBR31Eo5CLViKO1M7
	 CoVttnYTaiX18EdEOGMVjqnPd9rHV1MyC5T5XwzW8clfcdtIDpFaBEmVW0Kx73ZXPz
	 SF32akZr+GV9jdQ018vEVi5YAOV7dATW69KGmwrfxU7PCbUxaGJ7mBwBw8FhCpUiYF
	 G+Fm0BVzVXFIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>,
	stable <stable@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] binder: fix UAF in binder_thread_release()
Date: Tue, 14 Jul 2026 10:06:11 -0400
Message-ID: <20260714140612.2729754-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071359-voyage-hassle-bb34@gregkh>
References: <2026071359-voyage-hassle-bb34@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Llamas <cmllamas@google.com>

[ Upstream commit 114a116aaa5f0295376cdf12da743c5bce3b20ce ]

When a thread exits, binder_thread_release() walks its transaction stack
to clear the t->from and t->to_proc that correspond with the exiting
thread. However, a process dying in parallel might attempt to kfree some
of these transactions. And if one of them has no associated t->to_proc,
the t->to_proc->inner_lock will not be acquired.

This means that transaction accesses in binder_thread_release() after
t->to_proc has been cleared might race with binder_free_transaction()
and cause a use-after-free error as reported by KASAN:

  ==================================================================
  BUG: KASAN: slab-use-after-free in binder_thread_release+0x5d0/0x798
  Write of size 8 at addr ffff000016627500 by task X/715

  CPU: 17 UID: 0 PID: 715 Comm: X Not tainted 7.1.0-rc5-00149-g8fde5d1d47f6 #30 PREEMPT
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   binder_thread_release+0x5d0/0x798
   binder_ioctl+0x12c0/0x299c
   [...]

  Allocated by task 717 on cpu 18 at 67.267803s:
   __kasan_kmalloc+0xa0/0xbc
   __kmalloc_cache_noprof+0x174/0x444
   binder_transaction+0x554/0x8150
   binder_thread_write+0xa30/0x4354
   binder_ioctl+0x20f0/0x299c
   [...]

  Freed by task 202 on cpu 18 at 90.416221s:
   __kasan_slab_free+0x58/0x80
   kfree+0x1a0/0x4a4
   binder_free_transaction+0x150/0x294
   binder_send_failed_reply+0x398/0x6d8
   binder_release_work+0x3e4/0x4ec
   binder_deferred_func+0xbd8/0x104c
   [...]
  ==================================================================

In order to avoid this, make sure that binder_free_transaction() reads
the t->to_proc under the transaction lock. This will serialize the
transaction release with the accesses in binder_thread_release(). Plus,
it matches the documented locking rules for @to_proc.

Cc: stable <stable@kernel.org>
Fixes: 7a4408c6bd3e ("binder: make sure accesses to proc/thread are safe")
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Link: https://patch.msgid.link/20260619185233.2194678-1-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f223d27a546c ("binder: fix UAF in binder_free_transaction()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/android/binder.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9577193e72e64f..eaaa6e86cc5599 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1909,7 +1909,11 @@ static void binder_free_txn_fixups(struct binder_transaction *t)
 
 static void binder_free_transaction(struct binder_transaction *t)
 {
-	struct binder_proc *target_proc = t->to_proc;
+	struct binder_proc *target_proc;
+
+	spin_lock(&t->lock);
+	target_proc = t->to_proc;
+	spin_unlock(&t->lock);
 
 	if (target_proc) {
 		binder_inner_proc_lock(target_proc);
-- 
2.53.0

