Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661115;
	b=JUT4loZuuw3P2cnYAej0Kx6coyhSRdck4NtgJdgx8iiDRrHiKV7MGved/I465o+5FrMZ
	 A8gb3DkMeDcmCJnS1vZk4G+NQsfRJ8QRn0rwuNly++YqpxzNM7glS+zCDPoN6W5dU8afl
	 osgWZnwpLKykKWO9nsIO8Gr6jIMDkdzr98I+3pMB+Jgz6pkxzSTaBlKqDFC+MSZYFdQ8J
	 HSY0vugk2DkqDw1JjyTTfFiMa3rEQwVls0cEy0NlcvzXSJJjUaZj2diO078DgHl+JpdKy
	 P3cB/qATn4Y1SJqV/nWduU8gkORw1mGcWM0zkc2+4eZ5m9Q7eqa4TgTeiWviCEjqYRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=5TgY1+p4C3dlnN2vB8vTuygWlaz1e3tNyjJvp1UBN7I=;
	b=XENzdnovj7W5kvZZ3+eTVGXCVlLnkKi6NfopULJ70ovBdbl/q71Nk4qsdOBYmp+Gu5mj
	 De27WuONR3D+Pcb4TwCBsbB1e/Vlng5untegH9pic7JgwCHmWcDU7TsFK3loojE7M70hQ
	 /GJa0Y+FYHV+YQL8zzgpiy+UvEmtWjYG9hNl9/na1OmR0OmpBDKf7epa3IE5Yh7dJH+6t
	 Zaz8nJhOXUGDMmqyI+8DiPT70fN/R/iBk55ygjjv/7aDk639DeoOdf546xq3ZvuDRW7Up
	 H+fOg3X+pzyssGavD58Iiq2NkNf63UuAJVVmAmig1R60EmpyLBcoGtgSM6Miug3zNrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=D+31K0RG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A383606A32D
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A383606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=D+31K0RG
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-679aeeddc6bso6296002d50.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661114; cv=none;
        d=google.com; s=arc-20260327;
        b=BxaPzcosf7EjNU3DMxEFJ2e8VxMsVkdarC785YmfII6784IcsISIaSX8ZtFuA/TQAa
         AjYwMZnOMHvX/w8L+A4RKramfT5Dwa8wHoWS8P3wtgM0CsGU8k25JbgebdHKKnZJshLm
         loGaGUDryBZL8zJggU/dhrfiAvzb4Ap8jUUx8fQ2IFs2GXEi31DX4mxAtVMUQCMp35MH
         2JdhwAow1Gm6Pu+v3VgGaZGbPGjSeWEtyE6Rq8l8cKCEs7oXfHJXRm9djCUybjcP/cfB
         /+THM5Qm06hZtJ8tIP3d5PkOk7pQ3kUX43W1ZwHoEHMGcunmrY8Zy8u5neMHx1qrWA0H
         s9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5TgY1+p4C3dlnN2vB8vTuygWlaz1e3tNyjJvp1UBN7I=;
        fh=+cA+MtEkTHAeB9PR55SBNX/r8bF8Kb5/ZIDaT0yLVjg=;
        b=lma39sfU8DXcBE0AEv6VJRzLV/4f8ZLj3tVVMU52BdICEU1Y/R6pa+s3pJaCKKkyH7
         rYYhHyM6N/roPp3ldrwoqtg7yUXh90dqSR9SUy1xdIdU2B0ewjuLBQ2/E2j6FEEIC4Ck
         N2dSD/y8DGsY+oIGLAZ8iY9YNqsWezp+5F6b3GUmTyKwDiVzDwUJ36Ju29ycUuwC0R0+
         vPNXTL69FBH61AMH6JPsW+8oKLZiVcjCHgy2uLedO0SnyZG08EDO9Tn9H4UNVA2f+WBK
         4T3WrGkTaMpYq8xV2SsM0SwE2HQcfeVOqJHvcq8rydOm556bZYFRagD4bcKpTJJdpgr/
         DuqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661114; x=1796265914; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5TgY1+p4C3dlnN2vB8vTuygWlaz1e3tNyjJvp1UBN7I=;
        b=D+31K0RG4yFw1XFsGQZUWFBWM3SevFmK3xxC4Q7IBjAR7YrLulY2qh+6Y4pnBL26ZN
         hMsqZOXnNSuscw85vpqCD0nU5qK8rpQrst4D7ecT0iewcZCFa6si3VyMsVOHSXrwv8Fb
         K1lT/0PurK57+zBlnwY/JtqtHQOvj/V6Ap7E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661114; x=1796265914;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5TgY1+p4C3dlnN2vB8vTuygWlaz1e3tNyjJvp1UBN7I=;
        b=vOQr6AnXaLStpQ/7HbObwxaJL/KtjZMi96fLXMPubCffspwjDS8qXqS04EjDWbx3IU
         Wlfb+Txr4va4j2G1LO8mlUnfsHqWK5UhlxyWzRkDo/RXKjD8umXtQEEwYmPH6MlGhR0F
         m9Yv3YiAL9EqPTHYQXIsN9awDZ3pjoZvg84oLxog7c9TjAeMkujMDaVB4k5JLUizD1bc
         CuE455XDeASsNwVkRYQsutvmr9/ig5Emmc4vtmmCXQWnlng9i/x5FwHUvU4DkY+xDy5M
         bLRMDaWDS8DK2w/etg2Yah11trnS+HBjtJIatVuE/pVzmnJg8+KjxzZKzBJObNie4uIV
         jdfg==
X-Gm-Message-State: APuU4Z+xFCzSSDTHnIvpT0jlkOnDEQ/R8LMbXJIQrUlTOy+hmXwiQx3C
	++tAHiZysJRVaZFw/uq40QXtuQSjSnXv6yv8OmStY5Cr/BIwCU1CpQ1LJy9Ltx/ZuSKYxcc4nFs
	tNgr4iTbWtFmVK/H9HvPrWH8KGUwGUjlO0RKb91vKzNlWb/mOc8YHrxs=
X-Gm-Gg: AZFdTZfnDG0J8e4wy3xFKey+tkl3UssN0X+azH7FU6Jz3DsA0fSia7cAObZa6Vnj30h
	vSbHJqY/gGFQ+0CrO32npSlkgqGHAHL4qNR4AsJg5LO7g7G7pEFt8JFiczmn2klWnMrO9S9EEBp
	Zv0uYvcFge6bKmavT7tuRRuGaa0RkqYNEFDlktzUyBySsQCayD1NAb5Z4gV7Nb6tXl4cybyToFF
	ccqGvzSRVgyAKW64CvlRf3bjvjQ96HG1rBL+Hf7vJIBYCJorUBFa6C/0ho5r9IX5f/5Uj2vwhMR
	SYEN6w48zmhQN9Lb+ZykO9DIHwcR8TN3Fi2qGJee1CSQ+ERZH6GkeU+F27dw6Y+fNDXojRFDkDO
	AFE5/g2ZGvuzwNLKElC3T+BJVAWmmihdmS80EN2rrJEs+3s6VQlyNHvwiwEgnAqbyPneCZtED5u
	S+g57FjJUVDI5x+WIN1RwVzY9sR2+kfYHGqbNhDnGwe+0rbMRMNcM4NusnxrjvyuGChoU6LFC0x
	s7+0/pGJoAYkPC3jyxbdNfruPLyEpy6iy25
X-Received: by 2002:a05:690e:134f:b0:67e:4934:63cd with SMTP id
 956f58d0204a3-67e49347c5dmr1352415d50.76.1795661114352; Wed, 25 Nov 2026
 18:45:14 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 20:45:13 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 20:45:13 -0600
X-Gm-Features: Aa3M54qdJD_NbjhkFxblgIbJ7L9Miw14_6xcHoRjRrZigzO-Yzs4ek9cUzQtaKU
Message-ID: <CAFaZ9eoOtFxAansjaUbA-CDNQLcVAVJre2R9vaTQONG9MYUEng@mail.gmail.com>
Subject: [PATCH 5.10.y] KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

commit 4bcdd831d9d01e0fb64faea50732b59b2ee88da1 upstream.

Grab kvm->srcu when processing KVM_SET_VCPU_EVENTS, as KVM will forcibly
leave nested VMX/SVM if SMM mode is being toggled, and leaving nested VMX
reads guest memory.

Note, kvm_vcpu_ioctl_x86_set_vcpu_events() can also be called from KVM_RUN
via sync_regs(), which already holds SRCU.  I.e. trying to precisely use
kvm_vcpu_srcu_read_lock() around the problematic SMM code would cause
problems.  Acquiring SRCU isn't all that expensive, so for simplicity,
grab it unconditionally for KVM_SET_VCPU_EVENTS.

 =============================
 WARNING: suspicious RCU usage
 6.10.0-rc7-332d2c1d713e-next-vm #552 Not tainted
 -----------------------------
 include/linux/kvm_host.h:1027 suspicious rcu_dereference_check() usage!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 1 lock held by repro/1071:
  #0: ffff88811e424430 (&vcpu->mutex){+.+.}-{3:3}, at:
kvm_vcpu_ioctl+0x7d/0x970 [kvm]

 stack backtrace:
 CPU: 15 PID: 1071 Comm: repro Not tainted 6.10.0-rc7-332d2c1d713e-next-vm #552
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Call Trace:
  <TASK>
  dump_stack_lvl+0x7f/0x90
  lockdep_rcu_suspicious+0x13f/0x1a0
  kvm_vcpu_gfn_to_memslot+0x168/0x190 [kvm]
  kvm_vcpu_read_guest+0x3e/0x90 [kvm]
  nested_vmx_load_msr+0x6b/0x1d0 [kvm_intel]
  load_vmcs12_host_state+0x432/0xb40 [kvm_intel]
  vmx_leave_nested+0x30/0x40 [kvm_intel]
  kvm_vcpu_ioctl_x86_set_vcpu_events+0x15d/0x2b0 [kvm]
  kvm_arch_vcpu_ioctl+0x1107/0x1750 [kvm]
  ? mark_held_locks+0x49/0x70
  ? kvm_vcpu_ioctl+0x7d/0x970 [kvm]
  ? kvm_vcpu_ioctl+0x497/0x970 [kvm]
  kvm_vcpu_ioctl+0x497/0x970 [kvm]
  ? lock_acquire+0xba/0x2d0
  ? find_held_lock+0x2b/0x80
  ? do_user_addr_fault+0x40c/0x6f0
  ? lock_release+0xb7/0x270
  __x64_sys_ioctl+0x82/0xb0
  do_syscall_64+0x6c/0x170
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7ff11eb1b539
  </TASK>

Fixes: f7e570780efc ("KVM: x86: Forcibly leave nested virt when SMM
state is toggled")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240723232055.3643811-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ adapted to 5.10: same as the 5.15.y backport, vcpu->srcu_idx since
kvm_vcpu_srcu_read_lock() is missing ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
This is the 5.15.y backport (5f35099fa3d5 in linux-5.15.y), which
applies to 5.10.y unchanged. 5.15.y and newer already have it.

Tested on v5.10.275:
- x86_64 allmodconfig W=1 build of arch/x86/kvm/x86.o, base vs patched,
  no new warnings
- KVM-enabled defconfig boots under QEMU/KVM, and the existing
  evmcs_test and smm_test KVM selftests pass on it

One thing I noticed while there: in 5.10 (and 5.15), KVM_RUN calls
sync_regs() before taking kvm->srcu, so that path can still reach
kvm_vcpu_ioctl_x86_set_vcpu_events() without it. The upstream message
says sync_regs() already holds SRCU, which is true in mainline but not
in these branches. I left it alone to keep this identical to 5.15.y.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 58660d5de141..d44c97475625 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4970,7 +4970,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (copy_from_user(&events, argp, sizeof(struct kvm_vcpu_events)))
 			break;

+		vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 		r = kvm_vcpu_ioctl_x86_set_vcpu_events(vcpu, &events);
+		srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 		break;
 	}
 	case KVM_GET_DEBUGREGS: {
-- 
2.43.0
