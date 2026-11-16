Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868417;
	b=KDA3zndHNBMNaYgTjT4F10RS7XZKKYI9JKMcjQf294Cp3uO6mh+Tbqj4QAcQ+/I2F8u9
	 f/VpyU/Mq/G5CgsIpa7lSbmQSVIp9dwRFKqUaW9OXQjisSx4+X7+F2hu4LaWfl4JNtW14
	 bPCwxUc4b+SUXvb9QFJSng3+1EymuP+BG8hFZiDGi2Kt4CVTW4ZkEyOAoUyoXA5VKcG3L
	 vRBVkw5jqx5kcUW+A2capKYr2sGSN9Hg+Q8kIHOmzHtH1rp87gxxruQ4cTbegy+1YOrY9
	 WlZdGB7b0BTnDdy/E1aSaQa3v3XDXJkFoZBw3K9+sE9jBa4vnX5GYj67YUBvKo/eWjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=146KtYj5/4CvTd+WEKKik7JO+KM+Lzb2aZviH8pov+g=;
	b=bKHYBFxsl+anSNW0kB4tBqLhLCAI1pvHf0etRo7Nr95XXGA5ndO07g/lyRZO1maL/7kK
	 cibd+dtIsxmHvAI2Y/9WEyaNgYpgc6bUvm+K8snEutjlbLzC3rFT9bsKMAs7LwJu6jC+4
	 5ob8GyIYunfyFsXyrk9ueqzS8c7hT/fTCrbMeP8Vs95m73gSY7HiqQfcA1BAOO/QbBbTH
	 VvKZqbs52FIUX3khQREm7cxrSvamukCsIMIJ6m1WrHCsBkLDvC95923LNrHhPe3HrEJzA
	 z8BXswKDxKUMoJA2c5Ddn86jGCxpnHsjv/Y2ckYqk5o9slM2p1rKFL2pA56dghJQ4SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YZIAMAmk;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A93606A881
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98A93606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YZIAMAmk
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e95f8543c9so56666975ad.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794868415; x=1795473215; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=146KtYj5/4CvTd+WEKKik7JO+KM+Lzb2aZviH8pov+g=;
        b=YZIAMAmkuGeduYPzNuBeX4s4ImoV8LhTIw7P6qpOCpsvK7bNcPWvnnIeOxvn1bBRHb
         /4h5jn1k3Hh5c4SUiH1/GPQ7RVjJFD6KSC/SDWxKYpDXRasqJj7gEJjFkPRGjAQJ8Gpb
         eQu8+FTH+gSElpKljJcriGpsDyq3OPLIr6bg2MIMHLuTmKmNP4dUCHdKHgeI/WrdSsfb
         VbemN5cEo35qiK/zfCeti0FMIxjyAB7WuClGXXl5nounXo4I81hDaq3jrRpyrmt5+bMH
         z+pBedBDixpryUo5I1+7yoEm3OeJ1JjibGC9uu8Gb4tCA9j43uIvvd0XHuv/U6DDUw5Y
         gfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868415; x=1795473215;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=146KtYj5/4CvTd+WEKKik7JO+KM+Lzb2aZviH8pov+g=;
        b=qVkunyOm5LwmMpVsS0Em5hIctlGTljPRlDImmFOi+S9jCkvEqzYfP3OpVcWUMCzME7
         C1QcDIu7BKmSFkeaiRrJnGvT1CuUa/C+KfbT31jK6OQM1ZIpDGVBo3t3mqmP1MW7dNW4
         DeDzJPMfEED8kuJL58MZ41zBxlXvtFGPFxb5nqxZBYvbfo5ZPZzQeHbLmnhynZu9YUkI
         QzhoirMw2/kgdmb+gecpPrG8gAwJyp9naTz+UcmuN/YBB4DdTwV58Ubb8HfufR/tUTa5
         qmr70W5TgzRoonMXrvdTrlrnWGHuxC+cX7Kbd2EK9fdRAjQthhDEb+NH9LhtD/2kL3ZF
         +5mA==
X-Gm-Message-State: APuU4Z/vN8UjTFzEbgZlqu3//2/vu3p9FDjb1u3qLTrAZoat28gcydDr
	vBFaaUGBPVTuWJF0wQRYLZ8ZkjOC7yhTULrjUu7Shhe8JHKehVWZfU0OqLnAWbilHXnSqR9KzKi
	R0wKzMA==
X-Received: from plps22.prod.google.com ([2002:a17:902:9896:b0:2ea:7221:e753])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b43:b0:2df:35f1:8771
 with SMTP id d9443c01a7336-2ee0df93a90mr106659485ad.54.1794868414739; Mon, 16
 Nov 2026 14:33:34 -0800 (PST)
Date: Mon, 16 Nov 2026 14:33:33 -0800
In-Reply-To: <20261114041301.2801291-5-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109202153-failed-5.15-c7c288d178cb@kernel.org>
 <20261114041301.2801291-1-sashal@kernel.org> <20261114041301.2801291-5-sashal@kernel.org>
Message-ID: <avuEvfAczcRP8a0i@seanjc-mac.roam.internal>
Subject: Re: [PATCH 5.15.y 5/5] KVM: x86: Unconditionally reset MMU context
 when emulating INIT
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Stefan Teodorescu <fane@google.com>, 
	Oren Yomtov <thenameisoren@gmail.com>, Chris Mason <mason@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 13, 2026, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit c7c288d178cb0b78d3464a616b16b1aa0b316049 ]
> 
> Force an MMU reset when emulating an INIT even if paging was already
> disabled, as the MMU page role includes guest_mode (L2), i.e. an INIT while
> L2 is running with CR0.PG=0 will result in KVM running L1 with a stale MMU
> context.
> 
> Alternatively, the reset could be scoped strictly to paging being enabled
> or L2 being active, but SMM is also encoded in the page role.  Even though
> it _should_ be impossible for the vCPU to be INIT'd while SMM is active,
> there's zero value in not handling SMM.  At that point, the only scenario
> where KVM _doesn't_ need to reset the MMU context is on an INIT with the
> vCPU running in Real Mode or Unpaged Protect Mode, and while INIT in those
> modes is somewhat common, it's far from a hot path and re-initializing the
> MMU is not expensive, especially when the role isn't changing (KVM elides
> most of the re-configuration in that case).
> 
> Note, like the Fixes commit, this bug only affects nested SVM as INIT is an
> unconditional intercept on VMX, i.e. it's impossible to emulate INIT while
> L2 is active.
> 
> Temporarily keep the guest TLB flush when CR0.PG is being cleared even
> though it is fully redundant with the flush that is emitted on all INIT
> events (KVM itself only does RESET when a vCPU is being created, i.e. when
> CR0.PG must be '0').
> 
> Fixes: ed129ec9057f ("KVM: x86: forcibly leave nested mode on vCPU reset")
> Reported-by: Stefan Teodorescu <fane@google.com>
> Reported-by: Oren Yomtov <thenameisoren@gmail.com>
> Reported-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org
> Cc: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-ID: <20261022015407.279870-2-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

NAK.  Backporting 4 *optimizations* to resolve a trivial conflict is absurd.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bbfc8ccf4fcd9..5165147407e23 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11351,15 +11351,19 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	static_call(kvm_x86_update_exception_bitmap)(vcpu);

 	/*
-	 * Reset the MMU context if paging was enabled prior to INIT (which is
-	 * implied if CR0.PG=1 as CR0 will be '0' prior to RESET).  Unlike the
-	 * standard CR0/CR4/EFER modification paths, only CR0.PG needs to be
-	 * checked because it is unconditionally cleared on INIT and all other
-	 * paging related bits are ignored if paging is disabled, i.e. CR0.WP,
-	 * CR4, and EFER changes are all irrelevant if CR0.PG was '0'.
+	 * Unconditionally reset the MMU, even though super strictly speaking,
+	 * a MMU reset is only necessary if and only one of the page role bits
+	 * is changing.  All of the CR0/CR4/EFER bits effectively get covered
+	 * by checking CR0.PG=1, as CR0.WP and the paging-related bits in CR4
+	 * and EFER are irrelevant if CR0.PG was '0'.  Subtly, if the vCPU was
+	 * in guest mode (L2) or SMM (although emulating INIT in SMM _should_
+	 * be impossible), an MMU reset is also necessary as "guest mode" and
+	 * "smm" are both encoded in the shadow page role.  As a result, the
+	 * only scenarios where an MMU reset is *not* needed is if the vCPU is
+	 * in Real Mode or Unpaged Protected Mode, and micro-optimizing those
+	 * paths are not worth the risk of running with a stale MMU context.
 	 */
-	if (old_cr0 & X86_CR0_PG)
-		kvm_mmu_reset_context(vcpu);
+	kvm_mmu_reset_context(vcpu);

 	/*
 	 * Intel's SDM states that all TLB entries are flushed on INIT.  AMD's
