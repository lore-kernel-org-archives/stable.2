Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A622844AB6A
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515756; cv=none; b=T+0z2+ghbfjjxLZyW0KtgnAQZ4VOJj89rkk6Er7swMa0hnqoDOC6B9fqL8TQvepeEtgYoBPZkFTFo7r80sTQKQvFtJ2ETQor+d8L91t99whTgmtiwTKVo4/eXscedpNponl7lvx9Y3+9iAXEo9ojVbeQmqf87LM1mTOJzrgWYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515756; c=relaxed/simple;
	bh=8AsJQivIvh05NxAaZ800XMQSi1CvVtRnuVUMO8HT4qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JasN0iB42g/vR+v/VAIjjvzfZFoS0lgDv0oG96h86Cdz+PF11EMAVe1F9/9tuwJpxMsY6h82eSA058Io0/MJy3luCUmqKYWi5PUGI3jImN2SK/2mPFUvDT3SFNwy7/l/KwIjjw/OLzfE2M0mgs+AiTIFLCEtlyC5Ohq7Qq2hzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MR/Ekjkk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR/Ekjkk"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8486ac3f347so2323786b3a.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785515755; x=1786120555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rU2QgWWmiwDOTc97tpYJfn2gTZC2cyR2MioCmCqpMNY=;
        b=MR/EkjkkpKh+lQapp2CdZAFuKlKb4YXHlc3ZQLITtMcOx9sdfoXeaeLedRTvBapwd/
         Dx74d4ZlDzfkAnvY7Ktz8p1Pk9ZLIyePj3CV3A1+4eJMpz8JuocOe/dubUZZNxKA+SV3
         FlzEnD3T2qkyVlHheUiO/9cMrg89RjqQNJUB+k1QGQKSfzHe2tlv/vOk2Lrx/4Np7WOV
         DwWa4ZzAzjZfgQx3lkWb8WbfnSjjeFBCQBhhTQMFz+aiQdy3QWYJMn8gkG21A38x2u3F
         gpHgZgqoz9knAUs33OCkEBB7WRXoEyMGY+12H5qYmalYQR4aT9Jl+txKPhpUWihc9Xmt
         lIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515755; x=1786120555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rU2QgWWmiwDOTc97tpYJfn2gTZC2cyR2MioCmCqpMNY=;
        b=CtxaJOcT9jD5oVsqrwlTTMfGvIUJ/BjbWGVeerqCARZbMa1ltbWPXjxOXFsXuWeXTY
         DKI2bSeDw70zsFtkuwbTQRRVWXcVzwdKeZnR3U+LluEh5bg/q1hgtpzy6yyQWXYRNxEK
         Ckm6Z9wbHBMeeVP3KdmR5n+JEYCNhd3JMx/ZyD4BZEPyKOxWxS8aAoWXHab5w8bg+Bva
         YATRnURkQW85tepxyPKMr5bSYS5wQcchLLCBktLp7B+cYasUfcAbLx8uU7keqPOND8oI
         cc2nGObKb87UcXHyAYDkLfx5K9/Qbam+m9pyt8eoS9Ce1hKozKD7DchafMVaoKV1yI/B
         J4UA==
X-Forwarded-Encrypted: i=1; AHgh+RrtYLN+d6nNE+NMeGPYoyWzOJhoz5FO2gZLMFhT9X8c5ML67W1enIWiC4XU3sdGRfVUifoD0a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgy7RV0CnDJZsdRVhgz/nu9ai0Wa2x9Mp98G775it47XGYDSO
	Ibjs3j9I7kw7aaXA66ynKQvP6XVgaQM2vfm2YIsEsmFsYXZ78/cebdk=
X-Gm-Gg: AR+sD13CKh+1JqymdSIiB/lZR9dE1UfoN8WVsnBrm7EC5ZdErcz0+g/mC9oj3UniEaO
	hVVjr/sZZaPidFHOWLnUbudo5d2oU3U072dHAL1IDV+95sP3aj8v6vtuQyqYuzM05zjXztwSkzN
	j+ZUPJR0Ehijd0oBxhTrIsf5C4sygObVc3pCWS7j0NDD1ioyZIh54PcNJFwJ53tPMbWoB/kjD4T
	gDIB0xTfcxHj57X4kib3bLPK2TmhRCW0oQhKnbRk2A5bXsY+i8MWoJn1AZEK2XAaAKPXMESev6c
	C1Zwr2ryxhzKfVXsX2U8BCx4nBevf89/FF1HkihwiDju/2ta4J09TF5UlKb+Gxw/BI8exfpVN/J
	4l/tyZ0Wg8rv1BdWkZcqM2CdhEiqYwnz+5r9/8E8aF/FxtWxjYDIuok5tVJxz8BKMakMR7WRv88
	zVxyCWMGujhZpXaUShHuPRqkFVXyzsOyxbctUlzSt7tGjoRrthgJeFcnvWd4do4un2jmnQrRlHl
	rFnmsYX5yvAUarqQN1kJshSfmDdO9sliOh67an00kJ8VFFDrAvOjAMyxLbVR1nhkdSLMqaVMgYV
	7DCkI10ak1WHav90Q8lj0OA=
X-Received: by 2002:a05:6a00:14cd:b0:848:40f5:ff5e with SMTP id d2e1a72fcca58-84ed7517231mr2195457b3a.37.1785515754707;
        Fri, 31 Jul 2026 09:35:54 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc422ff9sm674942b3a.54.2026.07.31.09.35.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 09:35:53 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v2] RISC-V: KVM: Synchronize hrtimer callback during teardown
Date: Sat,  1 Aug 2026 01:35:50 +0900
Message-ID: <20260731163550.46991-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAGEsz8GNHFCOZ=-_y56rK1aX+Ze7w8qVqZSQ-OuGo_dPC4bXCw@mail.gmail.com>
References: <CAGEsz8GNHFCOZ=-_y56rK1aX+Ze7w8qVqZSQ-OuGo_dPC4bXCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The non-Sstc hrtimer callback clears next_set before its final uses of
the enclosing vCPU.  If teardown observes next_set as false while the
callback is still running, kvm_riscv_vcpu_timer_cancel() skips
hrtimer_cancel() and kvm_destroy_vcpus() can free the vCPU before the
callback enters kvm_riscv_vcpu_set_interrupt().

A guest can arm the timer with SBI TIME and request shutdown with SBI
legacy shutdown or SRST.  A VMM that honors KVM_EXIT_SYSTEM_EVENT and
destroys the VM supplies the teardown side of the race; no post-launch
host ioctl is needed to arm or request teardown.

On upstream master 62cc90241548, generic KASAN reported:

  BUG: KASAN: slab-use-after-free in do_raw_spin_lock
  Write of size 4 at addr ff60000005e58898

  kvm_riscv_vcpu_set_interrupt
  kvm_riscv_vcpu_hrtimer_expired
  __hrtimer_run_queues
  hrtimer_interrupt

The object was allocated by KVM_CREATE_VCPU and freed concurrently by:

  kvm_destroy_vcpus
  kvm_arch_destroy_vm
  kvm_destroy_vm
  __fput

For deterministic validation, I added mdelay(1000) immediately after
the existing next_set = false assignment.  This only widens the
existing post-clear callback window.  A no-delay trace build naturally
reached the callback-after-teardown-start/before-deinit ordering in 12
of 200 runs, but 1,500 stock-kernel stress iterations did not produce a
KASAN report, so natural reproduction is timing-sensitive.

Always invoke hrtimer_cancel() for an initialized timer.  Preserve the
existing -EINVAL result when the timer is no longer set, but only after
synchronizing with a running callback.

With this patch, hrtimer_cancel() blocked for the full widened callback
window before vCPU destruction.  KASAN reported no error in 100
fixed-and-widened runs or 200 fix-only timing-sweep runs.

Fixes: 3a9f66cb25e1 ("RISC-V: KVM: Add timer functionality")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Add the required Assisted-by trailer.
- Drop security@kernel.org from the recipients.

 arch/riscv/kvm/vcpu_timer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

AI disclosure: I used AI assistance during the audit and am treating the
issue as public as required by Documentation/process/security-bugs.rst.
The reproducer and full KASAN trace have not been posted publicly and
are available on request.

diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
index ae53133c7ab0..a2cd277a4059 100644
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -61,10 +61,13 @@ kvm_riscv_vcpu_hrtimer_expired(struct hrtimer *h)
 
 static int kvm_riscv_vcpu_timer_cancel(struct kvm_vcpu_timer *t)
 {
-	if (!t->init_done || !t->next_set)
+	if (!t->init_done)
 		return -EINVAL;
 
 	hrtimer_cancel(&t->hrt);
+
+	if (!t->next_set)
+		return -EINVAL;
 	t->next_set = false;
 
 	return 0;
--
2.47.2
