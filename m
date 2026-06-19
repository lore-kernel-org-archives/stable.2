Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB12DC32C
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781895171; cv=none; b=AayUxYdNyxs5e2IeQx5QiGFxSdBeib0vmMTdbkGmCalHTQRYmXoWaTxFAFugbjvP6TjPgLMDKPuW4wfZLDN6tIZPcPvyT2un9jJegtkzPHvxg0U6h69ZOISLSo3BAWwuEpcGxXW5FESd4x1P87LbqaxB0hT4bBOP4xLt6DGktFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781895171; c=relaxed/simple;
	bh=KmPYFDA00ywcpcV04V/qvoVq6coYe693gi2Digv6cYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZ9SxfVd4pLZVH3jBIsaqlPWFRC1CVeDrNtf1FFLNljq750tlAWe76+tKxSWgXLzqLDLFH5Jg5zT8D8KWAHMnOZWFdP8eDbTSyuhP6+IEEBb8J5eejUjmayg+yUFX2ngBNO/zlJG3ArcP8cC00oY1sMOymDbv0+Yl2Gv500GnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JykFicz4; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JykFicz4"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1383723dfddso3954383c88.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 11:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781895170; x=1782499970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3t8E6qPCGzKBRUKhCyGND86O0xwSlmxNUAVjxI941B0=;
        b=JykFicz4L2ywnSnkGpXG9T6JGBIYJF7NnxEO9DMAwiVkQ+c1AtK6m2O4ebeF2Hb8CG
         3SqnuhLWBA6Ki7tnyjoitfBCanYCRm/1u6JS5DVaw6yNvoZocsBKHhQfi/SruvUVLaU8
         o1Tmdz/93Kxs7dRQ0sVixHeO6yUcXbJ6FvadNRLE2Zq/fxPcfcnDqLc0TEStp5NIXRSC
         xK5wgi2nttmFXRv8KOIYqmr41V7OEoKauyuMFooVQz5O9YUsUu6kLB24LI8t7z5y07Eg
         zXHayQa4/fYlkb5+mJJP0OWUSi5ubuNOFBfKmpmoZzlgcdnUW+65Ca3U2LWiNf/Qxfs9
         DOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781895170; x=1782499970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3t8E6qPCGzKBRUKhCyGND86O0xwSlmxNUAVjxI941B0=;
        b=jdmB79W8pOUEyfrtTFT5NNetjV7NCnd627zjzn7BLko09gSAZUu5LazAXl2MIPGDJF
         6dr0Jh8op9WM4RO/eWbFZIe0/t+tNFUpHUD9PTTzaFggU4hZOW/oK7NYb5AUwHYGLhOE
         y2VvZOhDFXu+SFeebW99Sy98L6KPe45fP4/SajylcnOypdZqZUsGxix7pkoCU5zIlarI
         68CKvwwYsi3iUkHttFX2gyTjCR2WywC37L9e/GxNTXqrelGpuVkSwx4bcPreORtJK4vP
         sam/ijKS8pHBs/Ixg4GHk7xT3glSxQcqaxJitNhne8AzvrQ4suWNwgwfAalJVu5THgLE
         f5ww==
X-Forwarded-Encrypted: i=1; AFNElJ8FSAm9lRUAYDnfXcChUSTxyeHVfVkLRSopX68I/0qfRCrM3zW2GnfH6ZRxtKsCxKWlv0+p150=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4o7il/Uvd+pabgJXsRd7O7yDvNAYaNUBo4I4/7Bc+hODM446H
	eYzgqhj6YaYAef5w7BAzvmK0o30FZJ+ilsGNcts0EDejzAvqIds64drJBqi5Ws3pj/sNJoFe7cI
	zag3y8wWgW17wLQ==
X-Received: from dycmb20-n1.prod.google.com ([2002:a05:693c:20d4:10b0:30b:e04d:8201])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:4194:b0:137:9ee5:208d with SMTP id a92af1059eb24-139a368eae1mr1954093c88.33.1781895169173;
 Fri, 19 Jun 2026 11:52:49 -0700 (PDT)
Date: Fri, 19 Jun 2026 18:52:31 +0000
In-Reply-To: <20260619185233.2194678-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260619185233.2194678-1-cmllamas@google.com>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260619185233.2194678-2-cmllamas@google.com>
Subject: [PATCH v2 2/2] binder: fix UAF in binder_free_transaction()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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

Cc: stable@vger.kernel.org
Reported-by: Alice Ryhl <aliceryhl@google.com>
Closes: https://lore.kernel.org/all/aikJKVuny_eOivwN@google.com/
Fixes: a370003cc301 ("binder: fix possible UAF when freeing buffer")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 09bc052186cf..b85920c39694 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1658,10 +1658,19 @@ static void binder_txn_latency_free(struct binder_transaction *t)
 
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
@@ -1676,6 +1685,10 @@ static void binder_free_transaction(struct binder_transaction *t)
 			t->buffer->transaction = NULL;
 		binder_inner_proc_unlock(target_proc);
 	}
+
+	if (target_thread)
+		binder_thread_dec_tmpref(target_thread);
+
 	if (trace_binder_txn_latency_free_enabled())
 		binder_txn_latency_free(t);
 	/*
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

