Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C71DF980
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781895170; cv=none; b=Ctq+dI1EZsN/Z5JPtJM2XMnn8Mk5xTYDSarC1OfIq+XzBOR3Ph2ugU7wL5oSXpu7xVyU48zTuUpwdWLasCfsctmLuelQ5RLGQUnlLh/24LChZJX3tNUFr7TqhDrDK+P4H8kC4/m0fDPbKdRPtwGWaC7taW10QLCLiZu+iQ1qfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781895170; c=relaxed/simple;
	bh=i8Fee9Cag4MS8c3EOk4Nno3bWetUHm3DxJlk1w5Py78=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lq5CB3GDNKkJYwol83Nm7u8jbKt4oZlOEki12CjDc8319RdivkZmfw1T/0ggJES1YLitbgx2/psvycv3mMiVjpATqb/9jnc47hpoT5duyFEbeGy203j24hU6l1HFCvensDk6us+4hpmgcHSWGJ4wVM2rThV+wHAv+wx3jyd/A98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=herOH0Pi; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="herOH0Pi"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1394c3ee7f2so11750498c88.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781895168; x=1782499968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eFOEWMPHqf48471rOYGz9Me3HWQp0H3qY4ChS38V8/4=;
        b=herOH0PiAxji181nvuZD+wt9QNvZ1dbtvxl2CwMOcz2SwjFEKkiDFRQ2+9bPiqi4lI
         avDjjH0AT/zprCNGBRPYPRWXadhZW1SRfhrgE0lCHcVRWCWqcPmvlA86ANB/Mtx4mNSc
         E7vkJffE4xYlKMpvVl/G6jtwGbGXdq/dStbgOONiOnvUdbIhMgFCgFGSYx3uCbUZFbSE
         j/1uVwWgfd0wW+AErmt++X/hNiwjrnyoHbroFdFS6sjqjq1FazSCrljzmTuqLDYymotj
         UGt0PnssVg9sJZoa24DvwfcyVE81n6Z4Q28NRMwQ8Td+2ycRGwJM5xN7ZKr8XAA+XsGK
         aGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781895168; x=1782499968;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFOEWMPHqf48471rOYGz9Me3HWQp0H3qY4ChS38V8/4=;
        b=D3JlgUsIPwndsfASnI89mCqUkkby7CDPb8kZmhyLvDwZM7VH9VvcWBT8NeUXOZm+on
         A6uQlvGqppdo/cNNue4ZJFj3eL/hWKdW066/rCmY7zw1SI1unaPNUODbqVJ4q+VGFyYn
         jveeD0Lkvuy+qj3UTbazRT21XVtSW3SMhBqwTf8yY39YRgKmsHvl6mG8jcsYpG93kBBU
         ylAr94fOK3bW+isU0ByDb1a+AGiD+jXKci7Ko9a43WF6c0xj9OSH9n0U5AsrqZl+Q9VU
         M7pZ0Qy2mkMp3R8LRTyfxVvN2RXtxDuX2GUXBNrSCAIPBzdh6QiMrK8+V7PRl14ClS74
         xdtA==
X-Forwarded-Encrypted: i=1; AFNElJ9J7sNBtyyZnx9XIHE5fmkhyURWdFY5pwfxNWxnJ7TOdb4fWfR2o1IfCty+ZgqlZaFjv6rOAf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmfVB/MIbCGmr3q45coV6WMLdrtsuxHYcli3P7ujtdEOy2tk/
	bCsK+RaUTFpMigWOdMUc+HnlLkXZSP9201LUqZGGbsPje3figcgYid5CBhV6HySaIlSaIEf8oQY
	lLhuB/qV4L8WKPw==
X-Received: from dled13-n2.prod.google.com ([2002:a05:701b:42cd:20b0:138:14f4:c975])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:ea2f:b0:135:d749:574f with SMTP id a92af1059eb24-139a2060a0amr3662550c88.13.1781895167874;
 Fri, 19 Jun 2026 11:52:47 -0700 (PDT)
Date: Fri, 19 Jun 2026 18:52:30 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260619185233.2194678-1-cmllamas@google.com>
Subject: [PATCH v2 1/2] binder: fix UAF in binder_thread_release()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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

Cc: stable@vger.kernel.org
Fixes: 7a4408c6bd3e ("binder: make sure accesses to proc/thread are safe")
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v2:
 - Collected RB tag from Alice.
 - Attached a new patch [2/2] to fix a separate vulnerability reported
   by Alice. 

v1:
 https://lore.kernel.org/all/20260606022233.2402965-1-cmllamas@google.com/

 drivers/android/binder.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 9e6194224593..09bc052186cf 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1658,7 +1658,11 @@ static void binder_txn_latency_free(struct binder_transaction *t)
 
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
2.55.0.rc0.738.g0c8ab3ebcc-goog

