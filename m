Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793739367;
	b=ljhvz5erYTA8tXC4p3K2jWXgnqX5WywNq/02y5R09QAoJ/s4M7+u64c/DTxbh0wJPi1O
	 NskdzapTFXbafayjqLDDmUiUcYHQZtEFuasJEQIUAFtks3DImMPC7RrP1gy419zDb0yo8
	 J7pVelERJginfAt/VndrScmfdKN9PnTszeJnNs3MbFoFdQqFc1DD5gwQtEwQbWz1qeVsJ
	 m5D/P2RNYU1Ljlfojk77P2Ov+zi9qV61+WZJ5bh5IfrI6oEdyAK8GfblNs2b1mr2/lF8+
	 ZQE7U98OLM1UF7IlgYAP8637PLT+bEnRWCFETavMnDIwqdS2OBC/ZpaooHfXVoQqcPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739367;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=wXKDb0shvTVmV3AagAoa11gS9VL7nY0cemZyFZyr2hY=;
	b=n9pkU0K2dEUmKJU8crKV94KEYckUJZpmB4yGrFhVvvIQI3e/lTVwUdgxdOOhjSo+fU4w
	 H3zswWyuqyu2ZSZLzyzQxkhOMeMyzhpIHv8A88yQgm1DEmb+WV+3/tP6k3LkUgjDk/uU3
	 OPtMJSvH66U59/ieyMIpzJ7GkJhnvcDlp5ehkrbHvDZCmJAiHYrUmcfsAH+fMSmFkfolE
	 kUyd+Okq/ufpCSyV13mBpQqUkzUDDdlNLn0mBi/wmk8AFFwdkbRsj8cHK70dDUP/FOhJq
	 eBE6k7xbDBiRfXQjyR7RPWxDslUiTjAIUD+HwmrnNbx7TOG4NkQSbqfKqhEbkFD4PTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K2U+Oy10;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EvRt06rc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79BA606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 20:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A79BA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K2U+Oy10;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EvRt06rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793739360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXKDb0shvTVmV3AagAoa11gS9VL7nY0cemZyFZyr2hY=;
	b=K2U+Oy10KM7Fc26c+kfydX9SUQLUfffKBND5sj+eSD0LEY9d9YqukUSYgwBvZBi+KxXuM+
	87vykFB79Bv01VmS7OQaMhjr7NcQaHvgky6swFzN7C6lyODuQGy9IqX9WliehVpLyd2btC
	0GGrxq5Cxr6fUedADKPHWhzuYJrrHjg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-QRqC2Qe2PjKmzxa_YUPK4A-1; Tue, 03 Nov 2026 15:55:59 -0500
X-MC-Unique: QRqC2Qe2PjKmzxa_YUPK4A-1
X-Mimecast-MFC-AGG-ID: QRqC2Qe2PjKmzxa_YUPK4A_1793739358
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1fa972b4fso24389805e9.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 12:55:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793739358; cv=none;
        d=google.com; s=arc-20260327;
        b=AVKLUjF2a3LD41St8bvP2F6Sibcux6vPPYT9UTaXW1NKEfSYnzeVreHr44vd84rX6g
         2rutdfQmenAGXZPsLYDPu7av6XEevStEmYS1b0FbYb23iff4jddAbkJdM5Uses+LLfG/
         ILP0zAoEnmZr5ZkbagqCpSeOxPVpL3EOGo7z6nai7wHBiQIOOMtpEvusjdcZRDQFKB2r
         SjCBPh22ekp/fhOqy6X/noAf447mqw+ersNzEpNvxWXq35GcH2WYHq1ZxBv9k/GrC6pS
         uzhmgOGoPvWx9eutGO9th1cON+nZDif47w+UkQBIrJXtkrjUtE1Ya7ETU6Yk421f6Zx4
         WosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wXKDb0shvTVmV3AagAoa11gS9VL7nY0cemZyFZyr2hY=;
        fh=f/3fbNiS5DaNfvyeC/Hxs610SpHtjL0pVXWKL6r8I34=;
        b=XEgrkICkE9iK7ZF/GVTwHkNz3EPDlH+UBoE8RWbsdK/W69oG5ekQ/vJTGrllvpaqcR
         YOF8migL/qeIhtrzzL92rvYO2UkKXPFdZxgaWJ7/Fzmz3TFrvUwcfXSJctpHjxnun70m
         4ZWKY2DOcvP5kHYEPS+CH5YnLjqOW1/CxOCMr4t107s4Oyqe32ml9CR026/eJL8SuBUC
         zIrbVkQPYmdxaYpA9mwy0B8zARwgPsAe3k6UWuo/RCB4KKji2dzmBYne9+PyAyVQ2gvx
         oRY7DMLrQyiBF7kgMJXp83Yz5lUjM0SPytcENCSUKVnXQXW2CrsjJIaMFV+Ia14hDJne
         TUUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793739358; x=1794344158; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wXKDb0shvTVmV3AagAoa11gS9VL7nY0cemZyFZyr2hY=;
        b=EvRt06rcENLPGZTISqugrXcti/3DIXMpcTLyZXzDagPNxAays0a7NDHqvSUKlLvkuG
         dtwiPancTukm9o29Jik0KyD/5j2pnfNEuT88IyFwbIpsrYwexGaOccAVHzpvcLvEUjhF
         qLgjuLFApK7lAfd5NNegmmGvpeeusEvbZfSQ8u/k/qODM8oTHxkzACvOdLPixBlZlDin
         ZtQgLJCWcCIrAAZGhydl1CeQNR01MV/wFfJmk7VpFb7RSwugdN/8u8dEeUM5g5/5Ns6B
         U1sTGln7qQHmzmEkBb/uG5Qrpb1wsj9GlG5rrGwULFuDwR7wJJPxkw1kNSs+IoMEt7Vw
         +qDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739358; x=1794344158;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wXKDb0shvTVmV3AagAoa11gS9VL7nY0cemZyFZyr2hY=;
        b=hKxx6rOc8rh9lfnJkHxbqGtYFnIjt5E3bzlKbdthi/dfWITk96aMjD216TN2XZGbLS
         stGRM18FBupjPGoym0Ce9aQyrBMzvbWDixuB+ByWprdktGXWyOVOeqWQx+e/5wmXVqEr
         OQKJTSqtzIfnBWay2diMBNkMiMGleLMB8p5ToOgFOC8bfa5tjyEYGjkSQDPJAZ4ouDz9
         CpWEowNK5jGph/V51xjq1nRkYu5tX5nANS/gC3t6qdFQrfElmqw40IB6nWgR/QCwcFnT
         L5FwZiydHQQE2Agt+ZVXlGBRK4aP7zHdc58Bxfix3ALtjl57XQevlKoalV4ko4jusnFi
         6tQg==
X-Forwarded-Encrypted: i=1; AKwUvByWqjG5zwGEoIDX6/LStvR1TCNrRe3wqUFN8wSHKNyOrQDl+qZJ4HrSIGB53R33uk31vaTRiZo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hny7P55LneSbGIkQQUhaduMwRAwW27WIO7g35r8v50YO+5K9G
	okdoM8qpWaFzxfBFLE/E5L1GIZCuYxzw7LaOzsbaz12dq74uet5K4cgfGx9h7P+5uPjY2EHyDVU
	N/coySGWfthVxWTtHuA6HaI2TUTpHKI/mxdEeZf2Cp1AgeSw3zwFeXXYHeO0lCjoikGRcQRDgLb
	MSF6U22f95gZDHOwMhB59PPJABUTjCVBUeLSgZgNuO
X-Gm-Gg: AYBFou0s6C8I1X8gjsaLdPTjPNpIA5DuY7pMgiCujCMkbHzjWy6ZBPhqOILXQpPD3Ws
	2XHqxm9/BpocYchVkdMgmEotVrGYtAW2n6cXMfZubNAavXq74c4nz3JAWxEYm4x1mg6EaO3fVIL
	cScubXHrr8p2Md5leTdgaPySm/AGWfFJD39NpYl3eeOFD1qFw63HMN8oqe/D9HgM9FVnjWQB05k
	DzEHRsbuGGzZPPHGzuUr7Az+7VjO5ypgEnsble5IX+WbcWbwBZhT/q11Ibs
X-Received: by 2002:a05:600c:811a:b0:4a6:b49f:9ae5 with SMTP id 5b1f17b1804b1-4ac18e5dac8mr298620575e9.34.1793739358120;
        Tue, 03 Nov 2026 12:55:58 -0800 (PST)
X-Received: by 2002:a05:600c:811a:b0:4a6:b49f:9ae5 with SMTP id
 5b1f17b1804b1-4ac18e5dac8mr298620325e9.34.1793739357803; Tue, 03 Nov 2026
 12:55:57 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103124930.2278671-1-pbonzini@redhat.com> <20261103124930.2278671-2-pbonzini@redhat.com>
 <aunzE4yywHJOqsk4@google.com>
In-Reply-To: <aunzE4yywHJOqsk4@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 3 Nov 2026 21:55:45 +0100
X-Gm-Features: AclHuK9NbLFeA4rOMmjWiElPvRKkJKekyTJisFXX1WKeTFZUAYkS3xpedGH9E5s
Message-ID: <CABgObfbvv-fQnC35EU+TxEtNMyYA0wgJ-nA_2B1eqKrZ_2qqkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: register asynchronous page fault waits with
 interrupts disabled
To: Sean Christopherson <seanjc@google.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Hillf Danton <hdanton@sina.com>, Steven Rostedt <rostedt@goodmis.org>, Harry Yoo <harry@kernel.org>, 
	syzbot <syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il mar 3 nov 2026, 15:43 Sean Christopherson <seanjc@google.com> ha scritto:
>
> On Tue, Nov 03, 2026, Paolo Bonzini wrote:
> > KVM cannot use a node on the stack like kvm_async_pf_task_wait_schedule() does
>
> Oh!  Yes, KVM can!  If we fully handle the PV async #PF in vcpu_enter_guest(),
> then the node can be put on the stack, right?  Juggling preemption and guest
> timing is heinous, but on the plus side it consolidates the PV async #PF code,
> so I think it's a net positive?  Especially when factoring in the node stuff.
>
> Fully handle PV async #PFs (when running as a KVM guest) before enabling
> IRQs so that it's impossible for the current task, i.e. the vCPU task, to
> be preempted before invoking kvm_async_pf_task_wait_schedule().  This will
> allow the guest-side async #PF code to eliminate its dummy allocation,
> which is needed only to handle the case where the page ready notification
> is delivered before handling the not-present #PF.
>
> Add dedicated handling for PV async #PFs instead of wrapping/piggybacking
> kvm_x86_ops.handle_exit_irqoff(), as the act of handling an async #PF may
> enable IRQs and schedule out the current task, i.e. needs to be done just
> before KVM itself explicitly enables IRQs, and needs to enable preemption
> before calling into the kernel's PV async #PF handler.
>
> Opportunistically wrap the code with CONFIG_KVM_GUEST to help document the
> context, and drop the CONFIG_KVM_GUEST=n stubs.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>

More like Instigated-by. :)

The main advantage would be that it bypasses the missing lock issue
that Sashiko reported, but I don't know... That;s surely nice, but at
the same time it is not great having to add a new callback, and to
duplicate the guest_time_exit/preempt_enable code into
kvm_handle_pv_async_pf().

Not that the extra field in vcpu->arch is beautiful, I admit that, but
it seems extra unwarranted complexity.

Unless you insist I will send a v2 that takes the lock properly.

Paolo

