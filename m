Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9F47DFA5
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037977; cv=none; b=X8Cddw9xGEJCnMmsjeQgBAIM29nhyB/YCyomkZ6LK2jp4Z29l+67ev7blDp2DhonpiOLJ2VGTFkjaNaQja1/G9kwsBndS5M1ISGWzQZBfasvUeHRjG6aaKjUgXjv3pnBPZmGxQFNB2jpVjFeEYu5rPTHETG4VC0uk9WIqrWS+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037977; c=relaxed/simple;
	bh=KeOqdwslWMNoiPrajlEI9Jkrk0OJNifOhujgESRuEsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C29Ip6FlwPtiaxbuzgPpDDNiiOZB3Od0wSmJCPQH/zu6OhWHW2/R6CKrcLsMDADrBiAYoaJzA3K51wJ9pFWyrFPZfdPgi3M11StIZowvnouxDpZFPIazlxpWywi4uazhUqq9WMLIYLMYCIFLbtrCNEVs9P98LsiEFryOIDBGrec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRq50T2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRq50T2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE451F00A3D;
	Tue, 14 Jul 2026 14:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037975;
	bh=92KaWi+ye6SXKmpVmCoq9fMyaXnAPTqUzWGkkU7h7/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fRq50T2kXthw7dp6in1exy4BLbEN5rqVKOafs4vDxvQHt7D5tlRw8DGAGGC8D813P
	 7kRTHBI8oOkHGpWEtOIOPUT2iXuNFVvl0Ls7p4KzxP3+c+OpeUoYUm0Bpn0GWHzG/R
	 EUrEYELWMl0znoB4nSzjUH0PrKN/zHYZSgtR4rhwd4Qqc9dQMxrenGA9qvnxyu6A6o
	 3aeNJesLNOzcTzlDQP3Cearr3O69daV610aLGkuC2Y1nxAm5RBXL60ZRGumy3ZPBJ7
	 Vi0vm/cu1HurY/ebsEFUApBOv+8pdP+nnPM9APl2yIKSMljp6GEAmYxS1IJoG/CE60
	 jmv7avzOWxBVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>,
	stable <stable@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] binder: fix UAF in binder_free_transaction()
Date: Tue, 14 Jul 2026 10:06:12 -0400
Message-ID: <20260714140612.2729754-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714140612.2729754-1-sashal@kernel.org>
References: <2026071359-voyage-hassle-bb34@gregkh>
 <20260714140612.2729754-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Llamas <cmllamas@google.com>

[ Upstream commit f223d27a546c1e1f48d38fd67760e78f068fe8c4 ]

In binder_free_transaction(), the t->to_proc is read under the t->lock.
However, once the t->lock is dropped, the to_proc can die in parallel.
This leads to a use-after-free error when we attempt to acquire its
inner lock right afterwards:

  ==================================================================
  BUG: KASAN: slab-use-after-free in _raw_spin_lock+0xe4/0x1a0
  Write of size 4 at addr ffff00001125da70 by task B/672

  CPU: 20 UID: 0 PID: 672 Comm: B Not tainted 7.1.0-rc6-00284-g8e65320d91cd #4 PREEMPT
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   _raw_spin_lock+0xe4/0x1a0
   binder_free_transaction+0x8c/0x320
   binder_send_failed_reply+0x21c/0x2f8
   binder_thread_release+0x488/0x7e0
   binder_ioctl+0x12c0/0x29a0
  [...]

  Allocated by task 675:
   __kmalloc_cache_noprof+0x174/0x444
   binder_open+0x118/0xb70
   do_dentry_open+0x374/0x1040
   vfs_open+0x58/0x3bc
  [...]

  Freed by task 212:
   __kasan_slab_free+0x58/0x80
   kfree+0x1a0/0x4a4
   binder_proc_dec_tmpref+0x32c/0x5e0
   binder_deferred_func+0xc48/0x104c
   process_one_work+0x53c/0xbc0
  [...]
  ==================================================================

To prevent this, pin the target thread (t->to_thread) to guarantee the
target process remains alive. Undelivered transactions without a target
thread are already safe, as the target process can only be the current
context in those paths.

Cc: stable <stable@kernel.org>
Reported-by: Alice Ryhl <aliceryhl@google.com>
Closes: https://lore.kernel.org/all/aikJKVuny_eOivwN@google.com/
Fixes: a370003cc301 ("binder: fix possible UAF when freeing buffer")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260619185233.2194678-2-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/android/binder.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index eaaa6e86cc5599..233deb4d55daef 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1909,10 +1909,19 @@ static void binder_free_txn_fixups(struct binder_transaction *t)
 
 static void binder_free_transaction(struct binder_transaction *t)
 {
+	struct binder_thread *target_thread;
 	struct binder_proc *target_proc;
 
 	spin_lock(&t->lock);
 	target_proc = t->to_proc;
+	target_thread = t->to_thread;
+	/*
+	 * Pin target_thread to keep target_proc alive. Undelivered
+	 * transactions with !target_thread are safe, as target_proc
+	 * can only be the current context there.
+	 */
+	if (target_thread)
+		atomic_inc(&target_thread->tmp_ref);
 	spin_unlock(&t->lock);
 
 	if (target_proc) {
@@ -1921,6 +1930,10 @@ static void binder_free_transaction(struct binder_transaction *t)
 			t->buffer->transaction = NULL;
 		binder_inner_proc_unlock(target_proc);
 	}
+
+	if (target_thread)
+		binder_thread_dec_tmpref(target_thread);
+
 	/*
 	 * If the transaction has no target_proc, then
 	 * t->buffer->transaction has already been cleared.
-- 
2.53.0

