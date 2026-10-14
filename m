Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592A64E5340
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988778; cv=none; b=mJyvgSQN1Jx7gkgbVptWYk2ZL7Gb2ClljTp42a9H2JQqYQgWtGfgcZ/KxMUDNesTejl0dDJK0jQdci73zFutWMx5H/uoFX/OP9FNlzUji4vRswfySXnRoGSoIjRkgj6RpyFEndCwFH7LAAMQxaJvhhAVQf8cykGgf3tFnTAoy/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988778; c=relaxed/simple;
	bh=98w6yIl1XHuT2wT7hw/8Xtf1cduatOdiYBV2mOGLxr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VKKL9HV66cI0d2bp0Cc1jgFY8couo8KThtfm8qz0PlLeJcQ0R8xd3TjUCOaTuzZlQD589IAC/qQVP0oyvrK32F94Y3NU7VuBHHiT/aup5Mt/xBYhqC2WfKg+aUNvWpqLJHSGDIafKkYXP3HiAE9P6cTFtzTeoNVCdkkpqAKNrCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYp1oxDT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6I4avX+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYp1oxDT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6I4avX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791988771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:list-id:
	 list-unsubscribe:list-subscribe;
	bh=zbQdOW2nxo5154FSG/2rAu4LziRZJfWIRaH099gdUYs=;
	b=PYp1oxDTCRFA5OpbsPc0qsBtLb370Y8JGo6LXTIOtK3U8Df67AlkR4alvhsMNc31DVyryh
	M9MLL2r6gWAXCBZj9eoCIF/QioKqM5g30OTfvNvh1SAYBvHjhTOKmxT0DiVoRVF4cx/iRF
	wodd5A9pb4k4SvN2dIkItxSWV2sDsOE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-cK4nWD1bNI6WY_F_I8aJig-1; Wed, 14 Oct 2026 14:39:18 +0000
X-MC-Unique: cK4nWD1bNI6WY_F_I8aJig-1
X-Mimecast-MFC-AGG-ID: cK4nWD1bNI6WY_F_I8aJig_1791988755
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-487038bc9b8so3396465f8f.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791988754; x=1792593554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zbQdOW2nxo5154FSG/2rAu4LziRZJfWIRaH099gdUYs=;
        b=a6I4avX+O0sWiivTKvHpCGlKWTlD2WsgE6hlQguQQP66gHBtV2+7yzwp/N0aQgYiz6
         Sn5k1keIg1Fsghh9/F9dX9veRbawNLssPOVHcOkmlBtAf749MYw/WMQesWDLfIpLD9Gk
         9G7yDzezvIaj7dG99n0R8/cdpBZ8EYnP3y+F6GJKAkSLEdCoSVPticBle0RKZn8Kvdjm
         jkA7EFDrkBfHEHYzVNonRq31aFe5XrlcIt8bPu7LKvMB/AkUxjN46U/3XItcWUD1pcid
         LHN4mt3hlux6Q8ysz9V5KalNtFBCbTh6uahz8CjqCkizlNQqApWx+VZbq5ksM2JXOR+R
         VEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988754; x=1792593554;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zbQdOW2nxo5154FSG/2rAu4LziRZJfWIRaH099gdUYs=;
        b=Z486lnAh9gb5T5WMpry9xKHOM7akAcdaIlgiDXQWcjRus/hpOoZNqQ1ch5oQqCMSzT
         chuJ2D+c2Y3pnHpwjNOY11J3fa896Ie+VSam6xwYPS5jChcvsTmU1VzVGk86lCJivwST
         c8rmgcL0xKE/dIKN2DaaqAXMd8TMNpb0SYkG7M1MZKNXHbWXuW830lzCegr+8oVo1jWh
         np8wbtVqXlbnKeLzdhUa9ra0bmnQi79RJmkmoRQ4lzekdOVXZaU6qoEO1UO+jhCrzljM
         iF8a8ZIHCrIIX6rcOUsM1wBo9nbQOHnz2FdXK4DROhAtc4tsOaVJehzscHKBnd4XcqwY
         qOKw==
X-Forwarded-Encrypted: i=1; AKwUvBxQYH/39bRHneBWyavvlNdFvTYX8AThv46kc7F1zBV9HO+LW6qVhexEP9Mrjsl5dx+1kZ2d53E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzqyVLrcfyotxQnWnE6azC1lApi6paqQ9FPVU4pktEJ5g6M5+s
	7bhWK529J8pjWu1YuLnYSdUFvrG6kJbAmck8zPoUsG1w4Odubxlzcqr7sntc/dnkL1UfQhFbxfW
	vvkv/JfEYUWvljH0mvNe64b3fZqLO8pDc3cpZfI7x6o3QT+kiBJsyWKV5tA==
X-Gm-Gg: AYBFou3NZHdr5AmNAMml8hBv4HTxtR0pOGTAYz5GYeL80L+3nT9JBx+zKTnV49RBgWp
	qp4b2NYmTxxTwyRTeZXXR6TWWdCmZjNpdxYhmcqbkO4GhcdX9p3SPEGG03g9aHRpdR7yYosazgK
	b2IAilbwjeEM3+H8dEw2/HBw7U4hNb80Vol60mceqQXDN6uZoOK9DJT9uFQ7Hhrq9oyWwwotQWv
	bvEMiPW1YanzlMn4+aTxAsQEe+T3bH7Y8nYj7Z3VlPsD9f069VvmSTDjjJ0bOG1+vI+7azDN6HG
	axt2ccnFyU5SCYfABHtEDREU5mGcPHcH14+u4YdGlEQHBhhLFFDDiZlUWzY6yxLk9NOOfths4xF
	sFc3Xfghf9kBRK+mZWcVRRbF4bO+F9PASa01d57BwnZHWnlOhQXviA2JIJlnKaQU+ox/sPBGSgI
	P3+3hK
X-Received: by 2002:a05:600c:8206:b0:4a1:6811:8d with SMTP id 5b1f17b1804b1-4a18e4a3b34mr326670145e9.11.1791988754522;
        Wed, 14 Oct 2026 07:39:14 -0700 (PDT)
X-Received: by 2002:a05:600c:8206:b0:4a1:6811:8d with SMTP id 5b1f17b1804b1-4a18e4a3b34mr326669565e9.11.1791988754130;
        Wed, 14 Oct 2026 07:39:14 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaaebsm12684950f8f.14.2026.10.14.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:39:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	EJ Campbell <ejc3@meta.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/kvm: Don't consume async #PF flags on a kernel #PF in NMI context
Date: Wed, 14 Oct 2026 16:39:07 +0200
Message-ID: <CADkxfh-uQTca_6jB1JPDq1MsKffF_UKGQR339oQSJNcoV75GNQ@mail.gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Gm-Features: AclHuK-0menqV2wPSclxNCnIU0qeGt1qcoIMc1LHzGBaM5EOtYHxSFhk2rGHvAE
Content-Transfer-Encoding: 8bit
Message-ID: <20261014143907.rxkNyihZ1JgwPHidESRIF139Ie26Hc40ST9eCXCpl-E@z>

> An async #PF "page not present" event arrives through the #PF vector,
> and its reason sits in the per-CPU apf_reason.flags until
> __kvm_handle_async_pf() reads and clears it. If an NMI arrives after
> the event is injected and before the #PF handler reads the flags, and
> the NMI handler itself takes a #PF, that fault reads and clears the
> flags belonging to the #PF it interrupted. It then finds interrupts
> disabled in the NMI context it interrupted, and panics:
> 
>   Kernel panic - not syncing: Host injected async #PF in interrupt
> disabled region
>   Call Trace:
>    <NMI>
>    panic+0x52/0x60
>    __kvm_handle_async_pf+0xb0/0xb0
>    exc_page_fault+0x71/0xb0
>    asm_exc_page_fault+0x27/0x30
>   RIP: 0010:__get_user_nocheck_8+0x6/0x20
>    perf_callchain_user+0x147/0x1a0
>    get_perf_callchain+0x12d/0x1c0
>    ...
>    perf_event_nmi_handler+0x26/0x50
>    exc_nmi+0xe8/0x110
>   RIP: 0010:asm_exc_page_fault+0x0/0x30
>    </NMI>

I've made a small adjustment to move "if (!kvm_apf_reason_pending())"
before the user_mode test, which preserves the idea of the "if (!flags)"
conditional that existed before your patch.  It's just a matter of taste
though.

Otherwise, the patch looks good.  What I applied is below:

-------------- 8< ----------------
From: EJ Campbell <ejc3@meta.com>
Date: Tue, 29 Sep 2026 11:12:32 -0700
Subject: [PATCH] x86/kvm: Don't consume async #PF flags on a kernel #PF in NMI context

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

Since that rework, Linux has stopped setting KVM_ASYNC_PF_SEND_ALWAYS,
so the host delivers "page not present" only for user mode faults and
a kernel-mode fault in NMI context (including kernel-mode #MC and #DB)
cannot be an async page fault.  In that case, return without touching
the flags so that the interrupted handler finds them intact.

Tested on v7.3-rc5 in a 4-vCPU, 2 GiB guest restored from a snapshot
whose memory is served on demand through userfaultfd, so that reading
it back takes async #PFs, while every thread samples hardware cycles
with user call chains and points its frame pointer at an unmapped page.
Without this patch the guest panicked as above in 3 of 3 runs. With it,
the guest survived 3 of 3 runs of 60 seconds, and the host counted
148,441 to 153,334 kvm_async_pf_not_present events in the first 20
seconds of each. On 6.18.50 the results were the same: the guest
panicked without the patch and survived with it.

Link: https://lore.kernel.org/all/ed71d0967113a35f670a9625a058b8e6e0b2f104.1583547991.git.luto@kernel.org/ [1]
Link: https://lore.kernel.org/all/20211126123145.2772-1-jiangshanlai@gmail.com/ [2]
Cc: stable@vger.kernel.org # v5.9+
Signed-off-by: EJ Campbell <ejc3@meta.com>
Link: https://patch.msgid.link/CADkxfh-uQTca_6jB1JPDq1MsKffF_UKGQR339oQSJNcoV75GNQ@mail.gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 6b0a5861ccb8..d8dd2cadcbf7 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -265,11 +265,39 @@ noinstr u32 kvm_read_and_reset_apf_flags(void)
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
 
+	if (!kvm_apf_reason_pending())
+		return false;
+
+	/*
+	 * The guest does not enable KVM_ASYNC_PF_SEND_ALWAYS, so the host
+	 * delivers async #PF only to user mode (or as a #PF VM-exit, which KVM
+	 * reads itself). A #PF from kernel mode can still arrive between that
+	 * delivery and the read of the reason flags, inside an NMI that
+	 * interrupted it, for instance perf reading user memory for a call
+	 * chain. Such a fault is not async, so leave the async PF flags
+	 * untouched for the outer handler.  Outside NMI context, on the other
+	 * hand, async PF flags on a kernel-mode fault mean the host is broken.
+	 */
+	if (!user_mode(regs)) {
+		if (likely(in_nmi()))
+			return false;
+		state = irqentry_enter(regs);
+		instrumentation_begin();
+		panic("Host injected async #PF in kernel mode\n");
+	}
+
+	flags = kvm_read_and_reset_apf_flags();
 	if (!flags)
 		return false;
 
@@ -285,8 +313,6 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		panic("Host injected async #PF in interrupt disabled region\n");
 
 	if (flags & KVM_PV_REASON_PAGE_NOT_PRESENT) {
-		if (unlikely(!(user_mode(regs))))
-			panic("Host injected async #PF in kernel mode\n");
 		/* Page is swapped out by the host. */
 		kvm_async_pf_task_wait_schedule(token);
 	} else {

