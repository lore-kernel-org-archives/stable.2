Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506EC402428
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571799; cv=none; b=mk1IVn8Ak67voOt3YHm2hMBctrZ7m5cJZluN1ZzPOnUJG1XbSBPkEOVnmBFxLB+eOv7b7JDGqwyJyh5N4LqB2EJKOqih/t5Xv/nf0tC7/NoX8zh1e/NqrPhK292OYHkvS3onp2zbJZuQaVAl8oIDQB1dkkvuQccYsWS9t9y9YuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571799; c=relaxed/simple;
	bh=X0INS0+9ZIi+6B7TKaex45BPys5YvJC4MTr9fnoNny0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qe128zohkqc0zkjVi+EARmJyTT8St8WY81EF2tBR5zftEbStVQk3SIcvqARC9mfaE3VLBNwrGTkcE0Dfhji/QsqT3fhz6Nlf8rEmvJG93RGOgZsmRSbFjVZCP5UOOfefhuntIEZrVhSmEU3fJ3tHb6NG5KN6PLmu+MPJeDYt9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4+1CrRh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4+1CrRh"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d319b84213so4358105ad.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 04:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787571798; x=1788176598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=npJ1wlMR/wnROhe9/hNtOlEPg6MBfWz9mLakFDeeZlU=;
        b=K4+1CrRhTXhuV5QLt4A04p2qjitYFmCit8RfZEX0PUdDuH+m83+AGONxh8T2mxiBWV
         TdksCCdtLF39UfnqRHBPGkr355jxSDmLypUx6wYAvEeF6P8TyvZ1Sqoka2z9fFjLNUQg
         7Y11/ODA+jKAQvPH0oQlaDjfhQBSbe51n0PpL31udhiHt9qJXg10p5ydZjL4/BR+pGKP
         XvE9sjy48A5B882VzLIKyz7rTkrhm6ACFuQcy2IEWuPKlA8u7O4lb1S5ImDlb23Jn5UP
         MiBpFhRi5FIw22W+sEXzltWoShRCGDi7Kp5xSi9JaUFFi6Nij5W+FXgpkkySUnzmq9/6
         jYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571798; x=1788176598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=npJ1wlMR/wnROhe9/hNtOlEPg6MBfWz9mLakFDeeZlU=;
        b=XH7VSdQ1tn4YGqx1l80aawwl1jSZksjcFdNBrMYD7bmXLp/LXw+2FSXDKyrox+uvmC
         q7EiN6htR4e7hqE1rlCq5aN7e8CJStkNANgfBAwrBtnRjbkrwyzNfUR055aF90BzUTkO
         7auA/BnPYC/9Jf+Tg9kLM550Rv9pTV3f81SWfyv4T1/wnxzwFDENhF037q2DYG7RBfj7
         5fayLR2W6Hppj8s76Xw6rJAK6IMjO92yH/KeImM2TdQ6seCLhGBRt4F7bSnJWAcW295g
         qicZ1acz59j6jxwXszkJ3+9MJHIAazG6GnBXUIr3qL4R/P/uBCE6Wuw0ZHx3siuhnyOH
         /WlA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5NcrPf1qKLu938sz0ucQsvV5jetiKewCY6bFKFPL2b3dRJOnzHeW756fId/a24bSUGXa2wik=@vger.kernel.org
X-Gm-Message-State: AFuF++kr/waNfHENdDBrX9++IeyrbZOZi18vTAKqfA92uUHc8UvfyLhb
	Ell9698LK1ALKodd+QxidY8tLPUcSeiTFSz/40602hN9KaxjeYGeCuWY
X-Gm-Gg: AR+sD10y0cVJkjvAZmFL3PWfKHxtqNcXzB82Ou0st0Aaq30UPQJRK0Qpmtr05dg762u
	TXXaJKuspw2cOMqu7PdFyYva2Z7U7yBeA3jmW+9Ee3ixn2YJ20TTxeHTuehvbiaa9x5+gsdUs9G
	HeGCZfVlHqAMhb79BShHcueDzQKBcwb2LHy/YhsedGZUDx+7ZzJ+12u0d8iy48jM/gnu00Uvr4d
	E64w6vBJzc1OMNXTJ95Mv2Jxrc0+sIZvX3Qnb17nF5H8gkIIpPca3v1cvLPYCYM6ntJ11u8qEh/
	AodhzwpkISxf/NIDQfWM3TXHsGJrolLcsUZn1vewyZNDWagumRqVZdDCo8xwzMXNkYN0ACleHfE
	smBiffpYTSTaUoPbbxpybXgmHMGf8BZxM+2l/Mf9wGzx9YktHIQIx5VSpSmMlaP4/T5BRUbVQN9
	/AQ7oMIuQGubbYbBHnMUb2XuDWM95W32/7pN9uKFQKUqm+q9h4xCAb0pfIV+LV9/32D/S0fA1FK
	/vgy2US24UOfyJ5XjhJTLVNk881LqQi/g9oDfCQ/C97PQ==
X-Received: by 2002:a17:903:110e:b0:2d6:3c1a:85ef with SMTP id d9443c01a7336-2d64b2f5865mr218029055ad.4.1787571797589;
        Mon, 24 Aug 2026 04:43:17 -0700 (PDT)
Received: from localhost.localdomain ([14.216.85.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d67676170fsm16908915ad.6.2026.08.24.04.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:43:17 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: dwmw2@infradead.org,
	paul@xen.org,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	boris.ostrovsky@oracle.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH] KVM: x86/xen: Fix data race on poll event channel
Date: Mon, 24 Aug 2026 19:43:05 +0800
Message-ID: <20260824114305.198732-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use READ_ONCE() and WRITE_ONCE() for runtime accesses to poll_evtchn.
This marks the intentionally concurrent scalar accesses and prevents the
compiler from splitting, merging, or inventing accesses.

kvm_xen_schedop_poll() publishes the single port, or -1 for multiple
ports, before setting poll_mask and halting the vCPU.  Event delivery can
call kvm_xen_check_poller() on another CPU while the vCPU thread publishes
that value or resets the field to zero after returning from
kvm_vcpu_halt():

  vCPU thread                         event delivery thread
  -----------                         ---------------------
  poll_evtchn = port
  set_bit(poll_mask)
  kvm_vcpu_halt()
                                      poll_evtchn = READ
  poll_evtchn = 0
  clear_bit(poll_mask)

The plain read and writes therefore race.  KCSAN reported:

  BUG: KCSAN: data-race in kvm_xen_hypercall / kvm_xen_set_evtchn_fast

  read to 0xffff888112f55af0 of 4 bytes by task 98:
   kvm_xen_set_evtchn_fast+0x204/0x7c0
   kvm_xen_hvm_evtchn_send+0xab/0x100
   kvm_arch_vm_ioctl+0xb31/0xd90
   kvm_vm_ioctl+0xf42/0x16c0

  write to 0xffff888112f55af0 of 4 bytes by task 96:
   kvm_xen_hypercall+0xd8d/0xf50
   kvm_emulate_hypercall+0x157/0x1d0
   vmx_handle_exit+0x40f/0xae0
   vcpu_run+0x137f/0x27d0
   kvm_arch_vcpu_ioctl_run+0x5a5/0x970

The field is an aligned int on x86.  Access annotations preserve the
existing matching, callback, and poll-mask control flow while making the
single-copy access requirement explicit.

Fixes: 1a65105a5aba ("KVM: x86/xen: handle PV spinlocks slowpath")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 arch/x86/kvm/xen.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index eae17141773a..cd15d2379616 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1536,9 +1536,9 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool longmode,
 	}
 
 	if (sched_poll.nr_ports == 1)
-		vcpu->arch.xen.poll_evtchn = port;
+		WRITE_ONCE(vcpu->arch.xen.poll_evtchn, port);
 	else
-		vcpu->arch.xen.poll_evtchn = -1;
+		WRITE_ONCE(vcpu->arch.xen.poll_evtchn, -1);
 
 	set_bit(vcpu->vcpu_idx, vcpu->kvm->arch.xen.poll_mask);
 
@@ -1557,7 +1557,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool longmode,
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 	}
 
-	vcpu->arch.xen.poll_evtchn = 0;
+	WRITE_ONCE(vcpu->arch.xen.poll_evtchn, 0);
 	*r = 0;
 out:
 	/* Really, this is only needed in case of timeout */
@@ -1773,7 +1773,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 
 static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
 {
-	int poll_evtchn = vcpu->arch.xen.poll_evtchn;
+	int poll_evtchn = READ_ONCE(vcpu->arch.xen.poll_evtchn);
 
 	if ((poll_evtchn == port || poll_evtchn == -1) &&
 	    test_and_clear_bit(vcpu->vcpu_idx, vcpu->kvm->arch.xen.poll_mask)) {

base-commit: 388b607d107c07aaade04c7f22f344cab6bdccd3
-- 
2.43.0

