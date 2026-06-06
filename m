Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8E2153EA
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780712600; cv=none; b=e2a9fAWoyo32MpqSGt/GV0ay+dWxKOuStLqAN26O7OdNv/XXw9TntSiP3IDszDSsgPEl7Cp5aYwH9zTNhYQDoSyGXb+q78nz1fYUuUEEJhf1dbSepKc7hoyefcn3J6gfWHfUC7fNAukTg5pMUXRb7ZukpQB1ZaE7qRBBLoo8h9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780712600; c=relaxed/simple;
	bh=5nq1Rv+eY322uEwnY56CbK0D3OXYqXsuNnJKxuf95dQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MUa46yVDNomUbGNPXDp9t/ZShkrStXTt/eaTnNSI3Q8p1xO9n89AoiAREDqZD7jJFalT8Q9qENuwcc+kjbHDe/BnCQrZTxUHqtQnwrq0Oyt6dLFAtgtY1EdT9l5EXAIZCzJ81oXvjm4x4xr/LMLyGkfiPgAUplPhKlB0lJdr3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nvluRGzo; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvluRGzo"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304f23c55b2so2495024eec.0
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 19:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780712598; x=1781317398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qMU7ZIai1gQHR6450BLUZEyBAHdcgrhlQJpmeHdw0j0=;
        b=nvluRGzolC0rn9a2dMQu4p9dKOj/wNg/6e5K/P5Hb1NkJWo0JCMwGYVMwl1HX/np+Y
         0viMYXzBeuyKbsjkmcS3KgPKqYaO+zYooMR0g/U5fhe03ia9X8EIA4A5d4AX484aVyaQ
         1H3cayXUTmwlnYqBaKcDBmw0QDiMNoQPw7bjJfraDRN3KAY6J7KvanhuyofRp2jdK3uR
         39YD2sy4oQyqvhLVwm64dwEgWtbfxeX9ORE3+sTcZfHjR1fef2lC84mwOQoPhOKAvI8f
         8DVVui2Ad2GnGUZUrmsaV6Ob8b8h2Qhxq+S/9IQvJW2qwqIbKd1jL0ZmRHEH3AqgLVHr
         r3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780712598; x=1781317398;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qMU7ZIai1gQHR6450BLUZEyBAHdcgrhlQJpmeHdw0j0=;
        b=Bvax3IiqX2xyIGCXtE2Uve0WkUHOedfeWCNRpwoq7LOzAvYmi15zcJYr18PI6o2PyB
         QvS055Sy3l5obAp9yE/32qbTFk0Ld7fNbufJUJFHu4dIhx3YzGIlBTkhW6m9TWWl5PWP
         nGpv4zx2Cl+kzzeVHmT5dVJ4ohizJ2ykoBYe/SFUS1sOclkhmT4zLBafYNHOwgotHpr0
         IBoYm+vSJWoeekAZq/8jAtRyA5KMiIOVGCsdvODnwb/lTD3DVAEnuW51pqdNhrNQFPAA
         ZwfPpN4va3bYoAFfWOSf1iZSc7XXBxinO0OM+v6Ve4dXqpW/HNjwm1Ie6GrgUMFHugeX
         6hcA==
X-Forwarded-Encrypted: i=1; AFNElJ/kopvaB1GHyA0+9mPP89IcyQDgo2v+cOmE4r2XqpyvexXmTvpUnOBSIJAv5KDDoHVNmYHE5cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VGLZEL7uqpiemj7Di4XjiO+bashgcn7CI/Zl+kpiLqw3Gesz
	1vpaZHFacSW52Km8PIuDMcc+80kS0hdqzoqx3hzhD958PeLIecCT95G+UpoOXYM++2+Tg7hjllD
	7A/VBJjxqKarcGg==
X-Received: from dyeg12.prod.google.com ([2002:a05:7300:538c:b0:2da:2af9:bfe2])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:fd09:b0:2f5:3fb3:4a76 with SMTP id 5a478bee46e88-3077b38e294mr3607633eec.10.1780712597440;
 Fri, 05 Jun 2026 19:23:17 -0700 (PDT)
Date: Sat,  6 Jun 2026 02:22:32 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260606022233.2402965-1-cmllamas@google.com>
Subject: [PATCH] binder: fix UAF in binder_thread_release()
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
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
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
2.54.0.1032.g2f8565e1d1-goog

