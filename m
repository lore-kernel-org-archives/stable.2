Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B054705E
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705610; cv=pass; b=BTfWFVbTs2xySGD1dCT07SF21LUo2yjZx4LKwvnATTQkGJkQBav4Jmdy+Gygoo2x5lUafKDaUynnQFo/7YKWeVRQ/614HgRQ6YJAD0qIQmLFuXvwrGJrZ+g++lNoT1EZ05m3SeI3Yezdoh0ikiQOBXTrerRBFSLr99LuoQEDMuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705610; c=relaxed/simple;
	bh=og+/cfUijpSZAoHGwYfistXQZPsm/+cWrVsHh/GMNL8=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=H9Groc/LPLdBnkNxvaciLzLNtGNTtOYs1lv3CYGAM1vFUZ1Lg0HrEdU4tV6XVgQ3IW/u0UaRqgnFjOr9GR4g4akzLHQbydGYsi/JZkFYyMHkRicGqivKEwhdmz+/ZBbLzH449olush962VDUNKslY6tdVrBy/uWbb0Qnq1oFquM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YNnZrxnU; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YNnZrxnU"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TI2FGD3137805
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:13:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pps82601-s2048-2026-q3; bh=cw5TddyzbNZYYT3wG/ekZg/7fsNBMWBQMQhmn
	ududVw=; b=YNnZrxnUJ6kXB20J5tGEVguRDlj/S9cfF1071HlZenCTjuckJILVR
	LO4xsMEomnI41+vpYxO/y2TiD8d9nCs79fGQ6/dxq0PJ5xObiMPfT8BgZOnI+UDI
	NcHeaF9Lqv2C5okAqKvvm6gArN+nYgic5bFlS2t2tPEcFqALpfhaJr+9G9jE1el6
	bwpY1ymVpRus58kif9C2cg91p6SpXbqgRefp2lrtU1bEBjaEc30IWYZX4qPWsxcE
	BjfkfYkZx7QqJwXFO+zc+BV29kEQKdZpzEVGMFXGwEdGCRxHRUMStAr5OBrBYMu/
	cTyqsjRasz700SPyk3H+MqFAMMXb3EsPA==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gyva1uu6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:13:21 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-467c2c754f8so4061244fac.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790705555; cv=none;
        d=google.com; s=arc-20260327;
        b=prjJmP9s0lErBlcU/Oo7UfRkW/OQNsfmFQshJmJlCFVzsCRMCNdHAS2qNAvex8bQ5a
         aGWSfFzV+QG2I5LL2blPXDfVZy6cm7V27GKLReUl9wIfgE2tjVJY9lKs+uekmDFNXCqK
         UeZmrU5w3L1nHh0b4dlEe8WMgWoGRBiEiO7cLQDo6iCjEjEMbDjnEWM89eWKLsGh+4/7
         LqawHW6r4LDjc7vQYp/aF/Y44h1IJ+gzfODEfBMq79meCzIZ2139AKj0xiEqGdeksUHZ
         11NFjhb4KI5q5lF97MTV3ZpqSx3XT3aLT0PMcvwbHsTpYknXj48U9qj5xpyTyQkCSBpx
         WA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from;
        bh=cw5TddyzbNZYYT3wG/ekZg/7fsNBMWBQMQhmnududVw=;
        fh=h7JOY0jHIrcm7WgNklW4dBgD0iMURM4rD3fb2vTOaDQ=;
        b=jpwLgNMB3jfrDokbeOdKKMqMncHnA3busgFraZEDej4Zj7K1vGk4hwyaObZ2zI0g/Z
         CwtrvaXocBf1Lgpv2CGmr/SOqsCYUf3BKajCTWM31r+ghkCFNz0CdYCvful1Ow11SKnn
         hoRswvE5WQzAXI7RXVGV1PO+66fvqiWe8DQDgOX9h+3aI3hQ6wfPuQDEggNHrrXjBm7b
         pFtT1qVV2SpBWpBTwbrIwKRvcwMnG1ouS/gbOraVMOpqnEzTe4jlNSk2wigWECZKeISb
         vk7PDm9VHfJ8RTdbiOuKysiuej9j/381wCKYMQtYV1mID9AcHPECry4fgrYiyPAeoFxk
         mtMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705555; x=1791310355;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cw5TddyzbNZYYT3wG/ekZg/7fsNBMWBQMQhmnududVw=;
        b=qrptO4c0mq/GWhfstmDIDVxTQXjBAM/gFMPdPT8UZWj8wB1QfHU1BCPtKi+uTCMhSm
         fry166nnY1wLnsfjmVRgx6Nqq+0VG8Tup6G6OSEIoClPb+1/K27HW5KpS9TJCLI1J6dk
         vrAA0GfVkJ7J+Qr99N0GfF4XmMiw40qSYXnXGa3pO4Y++yJmKNQulVT7y6Fm4BF8R+jJ
         sbgK+nt1vPgA5Mn4XrRPs8OneelzAm+dZiDjlmRCff7Jd0AdA1FbaEWm2xKkfuAD8yKE
         LlSpM1Y58jO9dTjvcbooRmxM1Y0F/H3x96jhiTO3s+3G+/0fMBQ8LOfwbXAwuB0s/ySU
         uZMg==
X-Forwarded-Encrypted: i=1; AKwUvBzoAG9g90I0hjBpIm2tsiRWnEXarmWQjEwnri6VGinbvLD0VXeqLZvSZRMTIA8dlw5woEHdMig=@vger.kernel.org
X-Gm-Message-State: AFuF++kjpTTFe4t8DTwdLcC4U1gn4W83PJ8cFCV4IPRPY9GYk19U+5bb
	VLO9x3sTKeMq9iWZ1wk0+vOWljWuH5OVCNpufuyZUC1x2wgZxTCCGUuumQ4peejo5Mkd8Hqrl2d
	GbItOFkxUz+unADHI5JYj8rdDMJ2yjy7Eml1vbXMX9WRnR2VQIH/eQn2obBAv/MOtgD5axoZbKM
	OU3vefyNo3MCyzDyu19mHdAiljqZhRRw==
X-Gm-Gg: AYBFou2UKZpQTxcXDv8qJ3HDyqNknpfTv8+mqh9cUntAx53DyMSSfaH70qvl0mMlZLe
	hpcL58myhpMPQKKDpXfXH31DLn+I++PCos4i6CcYL3QyTNOo4LCDZddewGniPqdWumLHNqZq3Km
	BsBmKNJ1GZSMEciDyRI9r52XXC20b/7QXxVG0ljaYxx3nZClzlxO/0lKDSc5TFHo0=
X-Received: by 2002:a05:6870:de16:b0:47c:eb7:eb43 with SMTP id 586e51a60fabf-49dd0d5502bmr75730fac.17.1790705554532;
        Tue, 29 Sep 2026 11:12:34 -0700 (PDT)
X-Received: by 2002:a05:6870:de16:b0:47c:eb7:eb43 with SMTP id
 586e51a60fabf-49dd0d5502bmr75704fac.17.1790705553985; Tue, 29 Sep 2026
 11:12:33 -0700 (PDT)
Received: from 556666599688 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Sep 2026 11:12:32 -0700
Received: from 556666599688 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Sep 2026 14:11:23 -0400
From: EJ Campbell <ejc3@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Sep 2026 11:12:32 -0700
X-Gm-Features: AclHuK-0menqV2wPSclxNCnIU0qeGt1qcoIMc1LHzGBaM5EOtYHxSFhk2rGHvAE
Message-ID: <CADkxfh-uQTca_6jB1JPDq1MsKffF_UKGQR339oQSJNcoV75GNQ@mail.gmail.com>
Subject: [PATCH] x86/kvm: Don't consume async #PF flags on a kernel #PF in NMI context
To: Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc: Sean Christopherson <seanjc@google.com>, Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        EJ Campbell <ejc3@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3MiBTYWx0ZWRfXxqy04DyblfOT
 ywRBZc6nn4AoxjfcRcrbJOlo7zlWa/+VZQTIq8F7qamWFeSjBOUYKVLacezt4fGyxolt/xcs3KJ
 ruYMAmedts9JR0RULveRkImmHFKcLZfYyShaV8hzgjI4ec3Ej1QC3MiYUnfAGTdy9a2xXqX/vRq
 94esY4tFgZOBuYdlKqfkVhOccu5lh2ECzfPCTH687tgJbTiyA1vUKQOE1Lsj8GpeUcWNnoLG9bV
 NjTTfSiiBLCiF7JBKonuFSR5LoD2wZrPIrQQwKgXugyZEW/KwGyUlsrANu4tTOaN7HGaaDWjNAB
 TwMJUpLLQCAkY/d8TOGhPThL7KzZXd7jM9+L0mt4QOFcM/7mxRYpWgwwRJA6HqkhCmJSPR54Y4K
 hm85f9R9Ji9Fd5bOZYpl4FRaOwSJXpoyalw9NYbkJ1jtHGHwy2fbyauV+BBA+aK/WO0be23LJBI
 ypS9pBe3Zx/uykd1vBg==
X-Proofpoint-ORIG-GUID: qm7vrw0aH8LmLZy_3VygtkdFPfRoRZWb
X-Proofpoint-GUID: qm7vrw0aH8LmLZy_3VygtkdFPfRoRZWb
X-Authority-Analysis: v=2.4 cv=eJSGH3p1 c=1 sm=1 tr=0 ts=6abbffc5 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=-jRnnWX_dE0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=a9TSg2_WAAAA:20
 a=VabnemYjAAAA:8 a=HhdKVQOAWFZzIEBA3B8A:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=gKebqoRLp9LExxC7YDUY:22 a=bn7x_FpfJtc3yKQXRW3z:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3MiBTYWx0ZWRfXxL54qMpvvkYW
 EcOeEVeHZQhnPSCrbBKlm89vt2riC/Xd1iHCFWqkPBpeRmzKbTplnbGybVtO0L/xgnbl3i7SFQ0
 2A8K4GhAejN3k7jBi9JcUSYr6NhNL0g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01

An async #PF "page not present" event arrives through the #PF vector,
and its reason sits in the per-CPU apf_reason.flags until
__kvm_handle_async_pf() reads and clears it. If an NMI arrives after
the event is injected and before the #PF handler reads the flags, and
the NMI handler itself takes a #PF, that fault reads and clears the
flags belonging to the #PF it interrupted. It then finds interrupts
disabled in the NMI context it interrupted, and panics:

  Kernel panic - not syncing: Host injected async #PF in interrupt
disabled region
  Call Trace:
   <NMI>
   panic+0x52/0x60
   __kvm_handle_async_pf+0xb0/0xb0
   exc_page_fault+0x71/0xb0
   asm_exc_page_fault+0x27/0x30
  RIP: 0010:__get_user_nocheck_8+0x6/0x20
   perf_callchain_user+0x147/0x1a0
   get_perf_callchain+0x12d/0x1c0
   ...
   perf_event_nmi_handler+0x26/0x50
   exc_nmi+0xe8/0x110
  RIP: 0010:asm_exc_page_fault+0x0/0x30
   </NMI>

The last RIP line shows the NMI landing on the first instruction of
the #PF entry. perf with user call chains takes such a fault: the
sampling NMI walks the user stack with __get_user(), which faults when
a saved frame pointer is not a valid user address or the walk runs off
the top of the stack. The same window exists when KVM, running as an
L1 hypervisor with DELIVERY_AS_PF_VMEXIT, reads the flags itself after
a #PF VM-exit.

The NMI entry code saves and restores CR2 for this nesting, but not the
async #PF reason. Andy Lutomirski described the race, with perf as the
example, when async #PF delivery was reworked in 2020 [1]. Saving and
clearing the flags across the NMI, next to CR2, was discussed there but
not merged.

Since that rework the guest does not set KVM_ASYNC_PF_SEND_ALWAYS, so
the host delivers "page not present" only to user mode. Read the flags
only for a fault from user mode. A kernel-mode fault in NMI context
(in_nmi() is also true in kernel-mode #MC and #DB) returns without
touching the flags, and the interrupted handler finds them intact. This
leaves the NMI entry path unchanged. A kernel-mode fault outside NMI
context only checks whether a reason is pending, and keeps the "Host
injected async #PF in kernel mode" panic for a host that delivers one.
An earlier posting [2] also skipped the flags for kernel-mode faults,
for a different reason, and removed that panic.

Tested on v7.3-rc5 in a 4-vCPU, 2 GiB guest restored from a snapshot
whose memory is served on demand through userfaultfd, so that reading
it back takes async #PFs, while every thread samples hardware cycles
with user call chains and points its frame pointer at an unmapped page.
Without this patch the guest panicked as above in 3 of 3 runs. With it,
the guest survived 3 of 3 runs of 60 seconds, and the host counted
148,441 to 153,334 kvm_async_pf_not_present events in the first 20
seconds of each. On 6.18.50 the results were the same: the guest
panicked without the patch and survived with it.

Link: https://lore.kernel.org/all/ed71d0967113a35f670a9625a058b8e6e0b2f104.1583547991.git.luto@kernel.org/
[1]
Link: https://lore.kernel.org/all/20211126123145.2772-1-jiangshanlai@gmail.com/
[2]
Cc: stable@vger.kernel.org # v5.9+
Signed-off-by: EJ Campbell <ejc3@meta.com>
---
Notes:

- The reproducer is a small C program run in a guest restored by fcvm,
  a Firecracker-based VM manager:
  https://github.com/ejc3/fcvm/blob/9c7519f861273e8be954f9d006bc4d6654669f15/tests/data/async_pf_nmi.c
  It fills memory, the guest is snapshotted, and the restored guest reads
  the memory back while it samples with call chains.

- For a kernel-mode fault outside NMI context with a reason pending,
  which requires a host that ignores KVM_ASYNC_PF_SEND_ALWAYS being
  clear, two messages change: with IF=0 the guest now panics with "Host
  injected async #PF in kernel mode" rather than "... in interrupt
  disabled region", and a reason other than PAGE_NOT_PRESENT panics
  instead of hitting the WARN_ONCE. The guest requires ASYNC_PF_INT, so
  PAGE_NOT_PRESENT is the only reason a conforming host writes.

- No Fixes: tag. The race predates ef68017eb570 ("x86/kvm: Handle async
  page faults directly through do_page_fault()"), which created
  __kvm_handle_async_pf(). The fix relies on the host not delivering
  "page not present" to kernel mode (since v5.8) and on "page ready"
  arriving by interrupt rather than #PF (since v5.9), hence v5.9+.
---
 arch/x86/kernel/kvm.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 6b0a5861c..87ba4e174 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -265,11 +265,37 @@ noinstr u32 kvm_read_and_reset_apf_flags(void)
 }
 EXPORT_SYMBOL_FOR_KVM(kvm_read_and_reset_apf_flags);

+static __always_inline bool kvm_apf_reason_pending(void)
+{
+	return __this_cpu_read(async_pf_enabled) &&
+	       __this_cpu_read(apf_reason.flags);
+}
+
 noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
-	u32 flags = kvm_read_and_reset_apf_flags();
 	irqentry_state_t state;
+	u32 flags;
+
+	/*
+	 * The guest does not enable KVM_ASYNC_PF_SEND_ALWAYS, so the host
+	 * delivers async #PF only to user mode (or as a #PF VM-exit, which KVM
+	 * reads itself). A #PF from kernel mode can still arrive between that
+	 * delivery and the read of the reason flags, inside an NMI that
+	 * interrupted it, for instance perf reading user memory for a call
+	 * chain. Such a fault is a real one: leave the flags for the fault they
+	 * belong to. Outside NMI context, which in_nmi() also reports for
+	 * kernel-mode #MC and #DB, pending flags on a kernel-mode fault mean
+	 * the host is broken.
+	 */
+	if (!user_mode(regs)) {
+		if (likely(in_nmi() || !kvm_apf_reason_pending()))
+			return false;
+		state = irqentry_enter(regs);
+		instrumentation_begin();
+		panic("Host injected async #PF in kernel mode\n");
+	}

+	flags = kvm_read_and_reset_apf_flags();
 	if (!flags)
 		return false;

@@ -285,8 +311,6 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs
*regs, u32 token)
 		panic("Host injected async #PF in interrupt disabled region\n");

 	if (flags & KVM_PV_REASON_PAGE_NOT_PRESENT) {
-		if (unlikely(!(user_mode(regs))))
-			panic("Host injected async #PF in kernel mode\n");
 		/* Page is swapped out by the host. */
 		kvm_async_pf_task_wait_schedule(token);
 	} else {

---
base-commit: 6f8319e3e9a44dd537d17f41565a8453c560a581
change-id: 20260929-kvm-apf-nmi-1911965f5e46

Best regards,
--
EJ Campbell <ejc3@meta.com>
