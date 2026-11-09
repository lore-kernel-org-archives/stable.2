Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794262416;
	b=bm0OPK0MlMLZC6LsOOBgqYzetmeVaMbe3We1wpJxGNJLAoS7/qvbGu0PIKiX6mOecjbS
	 ab6cg/LZSpl02xMV32RlCwZW/bto5d1cAW+00En8sOYwCZJGS53Z9BvwiGZhkkcSAStZj
	 xHewISsmnkp5ZwGGrc/P5UDW3yYP+v4d5iiMEHTRtTh/zD0F1+8/DEX9P9mSTkdJCdB8Q
	 lazuS371WFJoiKsA8e+94xqq1GJrbE5AvAlU7SubOdfFnI9roHAiirl3gfdB5QVPbGEBO
	 y3lK7BxOVqmGKDaIdPiti6hhzh3k+yctHOw7ZUo0+HTjk539NmKXPJY5/eCl2movGlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262416;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jhFE0fyWih8XquU98lCv3a5jbkEdSuXJStfnMSMVAkI=;
	b=QpP1KoPo7R4Fydq+XjEC2dP+cMJLLwyIeqDcLo1f306Avd68v4aimqVjBTlIjAxNa4o8
	 1Ehj/zzN8CqLrIAt8z3TTfh24YIWk8G/Tq01AQGfBJ4p+zcNeeAreRzrd9z/oNA0I4mcp
	 xWVGmQH4DJ8qll+99ay3i2WNOVfHCvHip3pplOQrRzF4671nA8MDIh9nLqNWReOxZv1wU
	 YbsRsCZJK4gNX4UEgNsIzL65tMUYA/qrSwAC6S/q+yaatnXjotAPFSfp8X2duXiYenrs3
	 GqFqekhfX4lRW9e90lL4ca5Bt0nIz6xLBTupV0FTXqt5fKKGLBUuuYDEGj5i+/zLs6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZE388eIU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C049606A331;
	Mon,  9 Nov 2026 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZE388eIU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794262416;
	b=kbemRZGnzsB6KIY/WDl4UEH9393reAUy6owXHx4G7dinSpO3szc9jRljYSSYP764sNYB
	 0ix0UOJY8PqMAT24a9FXmzJ8AuBVgWGaiEANhVGLNwzdx/dqf4iJMbw9/AHeE0Qj+WpQx
	 kHJVmJWAUaOo1oG9pQgc5oEd7WG1160ZbrKdfROfqvy/9EuGZ0SYVSvqYUIx2lmbwbMai
	 +gwVBW277UHsZJ6RoNwgByDyfeF765BhtpeoSY9kP+jB135GlZXC2nTqmmVFWyDVgwDJa
	 oHS+uRn/M2FeHQ1YLWY2PVtl2YIXO/3eLkANsNXqat6RcAIyyVZR3xaVxcrIMLMl20A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794262416;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jhFE0fyWih8XquU98lCv3a5jbkEdSuXJStfnMSMVAkI=;
	b=AbQXqUuugKDnGB8pq8/K4qfMZo/U0OG2gnX2OQ9YTMOaEnRfyY+XmLuX+zs9Ajk7lKTb
	 Jq5T45HkZ7lrN8vrPUTZXk8dxYZqNREfMpN/y1TEKKKUXzZpNGUrK7jgYhr8S3XChVSSc
	 tYJ6OG8+6xxEOEbFmj7psd6QLdZyNbjJuVsIWMxHFN0MmaubqEqrDyWe9R+7hLwm52D50
	 K0g4CmhOw33HGkafGZZRplZolMyQITWr+t1M6kCcAk5JyntmZXKEgU/iQFf0qW8Mey4p4
	 dMFw06zW75VgPgIFr401dxwGMtSWzZQPSx9lEyJNMYrpesB9njrk24Sf6w9F0vqN0WA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B4C5C1F008A2;
	Mon,  9 Nov 2026 22:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262416;
	bh=jhFE0fyWih8XquU98lCv3a5jbkEdSuXJStfnMSMVAkI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ZE388eIUmmFDudEmsmxj+iDze7gvRe1X0GjIIMqFKO8+tENmhBCARYaOPs8QpdA2B
	 3hNbIuS4TdQLCxyY+vWafQVNvS88lsqQDC7N/F8tVK8hQgMRy4ao6MlRuxKimdQ56z
	 1/qkvCRRE+B8WNloRPX+H66s3aVsWxXUwjvZ9l3CBP42eZicrJEEeqNG0ji/jrRGKY
	 BeVUIwkxPHMBdrjU6hqiVcBJ3JSaAlOloal2+vsWy0uj6BhQi8QuCQURgj7AwRtar4
	 20H6wWP0PEi7eNF1qCEhTJaM9L4dzh43W5Y8APbpVu7FhEhVvOsN/ApMFvtBW5I3Rp
	 KkbYbwcE92mhw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3C77A486AA;
	Mon,  9 Nov 2026 22:13:35 +0000 (UTC)
From: Xuheng Li via B4 Relay <devnull+xuheng.cs.columbia.edu@kernel.org>
Date: Mon, 09 Nov 2026 22:13:36 +0000
Subject: [PATCH v2] KVM: arm64: Order a later pinner's accesses after the
 hyp mapping
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-pin-barrier-v2-1-64ca73cae5e3@cs.columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MQQ6CMBAAv0L2bEm3ihZO/sNwaMtWNtFCWmk0h
 L9bOXucSWZWSBSZEnTVCpEyJ55CAXWowI0m3EnwUBiUVGdE2YiZg7AmliiKRnt1VK1rUSsoxRz
 J83u/3frCI6fXFD/7POPP/v9kFCjkiaxH1HhpzNWl2k2P5WnZ1DQs0G/b9gUSPyAurAAAAA==
X-Change-ID: 20261105-pin-barrier-58f2329c9182
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Xuheng Li <xuheng@cs.columbia.edu>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794262415; l=5667;
 i=xuheng@cs.columbia.edu; s=20261028; h=from:subject:message-id;
 bh=fuEJKXd7OZH045MEhiyU1s2rzbiFjb8ltiEtBO6sALo=;
 b=V618ePRfwdZZAW0Pe+S4sb9++ANEHkXDx1Ax0HhTJq2uWt5VDvp2qki7W/rqYoREcrssbVTdH
 7CRRVgGJ3JsDX7FqfVtXtz0282zcW+t5AkqW6SFLLdg9BlruAhnkscu
X-Developer-Key: i=xuheng@cs.columbia.edu; a=ed25519;
 pk=L1HVV+goqxYmEMO/OXakL6uf9isSpgk2QrLlFqyZ2Qs=
X-Endpoint-Received: by B4 Relay for xuheng@cs.columbia.edu/20261028 with
 auth_id=1349
X-Original-From: Xuheng Li <xuheng@cs.columbia.edu>
Reply-To: xuheng@cs.columbia.edu
Content-Transfer-Encoding: 7bit

From: Xuheng Li <xuheng@cs.columbia.edu>

Since commit 48d848882395 ("KVM: arm64: Defer EL2 stage-1 mapping on
share"), hyp_pin_shared_mem() maps a shared page into the hypervisor's
stage-1 only when its refcount goes from 0 to 1.  The CPU that maps it
runs dsb(ishst); isb() in kvm_pgtable_hyp_map(), which orders that CPU's
own accesses.  A CPU that pins the page later sees refcount >= 1, maps
nothing and runs no barrier.  It then accesses the page through an
address it computed before taking the locks, so nothing orders its
translation after the other CPU's PTE write.  The access can use a
translation performed while the entry was still invalid, and fault.

A host can do this with any pinning hypercall by passing the same page
from two CPUs, for example __pkvm_init_vm() with the same struct kvm:

  CPU A                                CPU B
  -----                                -----
                                       host_kvm = kern_hyp_va_host(x1)
                                       (host_kvm may be translated now,
                                        while its entry is invalid)
  __pkvm_init_vm(host_kvm)
   hyp_pin_shared_mem()
    host/hyp locks
    refcount 0 -> 1
    pkvm_create_mappings_locked()
     kvm_pgtable_hyp_map()
      write the valid PTE
      dsb(ishst); isb()   <- CPU A only
    unlock
                                       __pkvm_init_vm(host_kvm)
                                        hyp_pin_shared_mem()
                                         host/hyp locks
                                         refcount 1 -> 2: no mapping,
                                         no barrier
                                         unlock
                                        READ_ONCE(host_kvm->created_vcpus)
                                         uses the old translation:
                                         translation fault -> hyp_panic()

A well-behaved host can hit this too.  Since commit cf533b4d3630 ("KVM:
arm64: Validate the host vCPU's VM before reading it under pKVM"),
injecting an exception into a host vCPU that isn't loaded pins its
struct kvm to read the VM's MTE flag.  On an MTE-capable host, two vCPUs
of one VM that do this at the same time from __kvm_adjust_pc() take the
same path as CPU B above.

The lock hand-off orders CPU B's loads and stores after CPU A's PTE
write, but not its translation table walks.  Arm's herd7 model with
-variant vmsa allows the fault for this shape: a mapping made and
completed with DSB; ISB on one CPU, handed over through a
release/acquire, then used on another CPU through an address it already
held.  It forbids the fault once the second CPU runs DSB; ISB after the
acquire.

Make every successful pin end with dsb(ish); isb(), so that the pinning
CPU's later accesses through the range are ordered after the mapping,
whichever pin installed it.

Fixes: 48d848882395 ("KVM: arm64: Defer EL2 stage-1 mapping on share")
Cc: stable@vger.kernel.org
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Xuheng Li <xuheng@cs.columbia.edu>
---
The fault was found with herd7 (herdtools7 7.58+1) and Arm's AArch64
model with -variant vmsa,fatal.  The test reduces the host/hyp locks to
an acquire of CPU A's release and the pin to its refcount check:

AArch64 pin-maps-nothing
{
pte_x=(valid:0);
0:X2=pte_x; 0:X1=(oa:phy_y);
y=1;
pte_z=(af:1,db:1); pte_r=(af:1,db:1);
0:X8=z; 1:X8=z;
0:X9=r; 1:X9=r;
1:X3=x;
}
 P0               | P1                ;
 MOV W5,#1        | LDAR W7,[X8]      ;
 STR W5,[X9]      | LDR W5,[X9]       ;
 STLR X1,[X2]     | ADD W5,W5,#1      ;
 DSB ISHST        | STR W5,[X9]       ;
 ISB              | CMP W5,#1         ;
 MOV W7,#1        | B.EQ LMAP         ;
 STLR W7,[X8]     | MOV W6,#2         ;
                  | STLR W6,[X8]      ;
                  | L0: LDR W4,[X3]   ;
                  | LMAP:             ;
exists (1:X7=1 /\ 1:X5=2 /\ fault(P1:L0,x))

P0 is the pin that maps x (refcount 0 -> 1, PTE store, dsb(ishst);
isb(), unlock).  P1 takes the lock after P0's unlock, sees refcount 2,
maps nothing, and then loads through the address it already held in X3.

  $ herd7 -variant vmsa,fatal pin-maps-nothing.litmus
  ...
  1:X5=2; 1:X7=1; Fault(P1:L0,x,D-MMU:Translation);
  ...
  Observation pin-maps-nothing Sometimes 1 7

With DSB ISH; ISB on P1 after its acquire and before L0, as this patch
adds, the result is Never (0 6).  It is also Never with
-variant vmsa,fatal,ets2, i.e. on CPUs with FEAT_ETS2.
---
Changes in v2:
- Add a case that a well-behaved host can hit, from __kvm_adjust_pc()
  (Fuad).
- Collect Fuad's Reviewed-by.
- Rebase onto v7.4-rc2.
- Link to v1: https://lore.kernel.org/r/20261105-pin-barrier-v1-1-04ebf118175a@cs.columbia.edu
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d4c332a91..5cb1a1e1f 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1210,6 +1210,14 @@ int hyp_pin_shared_mem(void *from, void *to)
 							    PAGE_HYP));
 	}
 
+	/*
+	 * Only the first pin of a page maps it, and that CPU's barriers order
+	 * only its own accesses. Order this CPU's accesses through the range
+	 * after the mapping, whichever pin made it.
+	 */
+	dsb(ish);
+	isb();
+
 unlock:
 	hyp_unlock_component();
 	host_unlock_component();

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261105-pin-barrier-58f2329c9182

Best regards,
-- 
Xuheng Li <xuheng@cs.columbia.edu>


