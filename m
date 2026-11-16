Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845371;
	b=wxi1tRETRWxkBc4Q+e4wdDk1mkQlEe3+cu0EDAEuw4scoJax5jSHs/EvspAKF2+NlLl4
	 V8+DRWculgf9zdD3+a6aPB6KkcQBKIwksmtVWc9HYypRIr6hTtpQYs5RHQDOA7n9Y6417
	 nObXsZpNX5mZleDUZqIlfciQ5xsXpVxvfe+SGLl7t/Z8ktdnkAU+qwn4StAqxHufn05wt
	 LJ8Jynp+yWFkMd28HjlPijmyjnmXsK14LwO5Tom8r6YtJ0uLBMIQLdptbTykDZY51MVjN
	 NJ1+oAcMio1n/gBY8rHGeOxXioVHASv9IlqEroeYhb4kgWVhucowuqALdKIbm+T6U+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845371;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=xuWJrrizIQaSrZTQFgUO3V0HL4ic1BmuoACdN3FzMhU=;
	b=ehiiNotkGMQSncnlWpeGY4kyYUcMGDkeOyNl8lX96Pt8CiTvjciTK1Fux9M63AYZhb14
	 z8rYgVSqQgS0VxSRJmiHMARn30C0gKmBD/d2xSes934xAjymrWbWsjICZlhET5mNNXoOb
	 j7ZTmcE3WX4+9A6egk/QWOUev0G+Hf3rLbwzCvnjcZRkXBt5hKrmCMyb9vV/sTvyWPcMN
	 WzJk4T0DoLmVlyfIbKD2tusEKSv7JWcZJImDyq+ylQVarAceBkE1At0QWdctILKewDyof
	 Rq+G7ue0uGBqGcwT27WE3NGYtn1iowO7/6mHhRyEKVzT6a6HqctxkojJve1sFdKnZcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U0kna3NM;
	arc=none smtp.remote-ip=95.215.58.250
Received: from mta1.migadu.com (out-250.mta1.migadu.com [95.215.58.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D8606A32A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 636D8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U0kna3NM
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xuWJrrizIQaSrZTQFgUO3V0HL4ic1BmuoACdN3FzMhU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794845368; v=1; x=1795450168;
 b=U0kna3NMwIP0yu9sqJFhrpm2vr144awdm4FaRl/JloNBV3+PnZOxa8uRg5tpTZVFpT82km4w
 RXe7enmqkg0iwArMBg5yWCDGzVBCQGWjAXMdLoOMLh5wV3t6g2KEv9c5zaYytTSdm9Be1LUk0W8
 nVQR3+uDXSIjVjz8FSblmi0Y=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 44f9fc7a1421093e;
	Mon, 16 Nov 2026 16:09:28 +0000
X-Mizu-Trace-ID: 44f9fc7a1421093e
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so12523e87.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:09:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEmu8hvbZSMp68yPo2Vd+M8lWGdP4m1pTFkWmmofrpUAN/UD8mnvXQpXCIdpWwaHvqji9FyCRA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/J0n/23tHUTS5sCCwpYYB55Drdx5FQpUtf+KRXtDSl5v+Bw487
	+Bw9XIKrMNZxtiQc1CxefINRqM2mTjDmKx66RCfSAVtdb9nfNKCFuGg3nJzM/VUsjbmgqmNUdsM
	oH0XezVSmeVhiv9nbotO5zCs6uJd/ZYRPkSBcEAcW
X-Received: by 2002:a05:6512:1304:b0:5c1:4cc8:2f22 with SMTP id
 2adb3069b0e04-5c17e4b9f86mr221482e87.8.1794845363481; Mon, 16 Nov 2026
 08:09:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110110724.3614412-1-fuad.tabba@linux.dev>
 <20261110110724.3614412-2-fuad.tabba@linux.dev> <avM81YcTBTJ8zCMX@seanjc-mac.roam.internal>
 <CA+EHjTz-Nb-g9YQKX2fKk61hC2BfzXfmUHv=2j+eZ18YuTv2Eg@mail.gmail.com>
In-Reply-To: <CA+EHjTz-Nb-g9YQKX2fKk61hC2BfzXfmUHv=2j+eZ18YuTv2Eg@mail.gmail.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 16 Nov 2026 16:08:47 +0000
X-Gmail-Original-Message-ID: <CA+EHjTyqJfGS+5UajX=RYTAG-qfhZ-vmGi=1SixXydWhwGHLUA@mail.gmail.com>
X-Gm-Features: Aa3M54pa7DZ_uBY7ynCUhZPG35ZaG2vJ1bC6E24f7r2YagR26_2vzli-PPKoWqQ
Message-ID: <CA+EHjTyqJfGS+5UajX=RYTAG-qfhZ-vmGi=1SixXydWhwGHLUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's dirty
 ring is full
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sean,

On Tue, 10 Nov 2026 17:18:22 +0000, Fuad Tabba <fuad.tabba@linux.dev> wrote:
[...]
> > Eh, I vote to just use kvm_dirty_ring_check_request(), I don't see any harm in
> > clobbering vcpu->run->exit_reason.
>
> Will do.

After taking a closer look, the clobber is problematic on arm64, where
KVM_RUN completes a pending MMIO exit only if run->exit_reason is
still KVM_EXIT_MMIO. If a pre-fault stops on a full ring after an MMIO
exit, the helper overwrites exit_reason, so the next KVM_RUN doesn't
complete the exit and the guest repeats the MMIO access. The ring can
be full at that point if the pre-fault dirties pages, or with NV, if
the stage-2 walk for the MMIO access does.

I don't think changing how arm64 completes an MMIO exit should be in a
fix for stable, so should I keep testing kvm_dirty_ring_soft_full()
directly in v2, or do you have another suggestion?

Cheers,
/fuad
