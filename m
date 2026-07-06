Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBDE3750AD
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373555; cv=none; b=hWtEdodaL9cU0knBe67HkthnWsw+8TPDsJBPMHBfg+Uzdwii4avQ5lWPY3JUwgshEqRHp9yzN4MUM8YCf08pdeUnT0yftblq5cJ0oE45xCY0dISS+QqPeFKfeCMY3jM49BLDh5WjsfCuCBK32rfoxgwM2fpN48LbDGzPWXZ/FUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373555; c=relaxed/simple;
	bh=/dYMC4TsSnaaozbxuhxnl8PamyI6atTK96Kpm82VMT8=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ibTPRYIlxHGXOSZYRAJUCXX/q1Xt9iO5pA/HuH4ODY/XkhFI8qu1i0R9Qz4dKmdd4VXG2ULlI7rcCNJlbZXNOHQHGl+EdsjVskR5c8U4UTSzE+7TUBlGyIDXkLB7qK9vMFc4ERcI1I7NZtrneobWTOnSA12TR33rAcfWdmjl/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WwE0BTvL; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwE0BTvL"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-48976713b46so2762501b6e.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 14:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783373553; x=1783978353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MXM42XRsNruvqY2Vgb884XDt0as+6A4qsiGUbLElGzc=;
        b=WwE0BTvLotQGAnQ8H5X4EAjC5BlXjD1XHPYy9MVGqV7aZhzhmCvwc8x9ng7eB3OgvA
         Cq6uwrf7h0VA20zTShy6dYsyudNZiyn0OI+Zhwu3A87I34KjGCvHyodJYfYHGMkOSs9H
         UN3LUhTubfBDI/RXZVjZUGrVcCyKiIoyn3vyisVoMAS1f/r3Jl8MZq+QHEIrMECobVyY
         DMWkxsB5d0qN9oFBYs/O/RNWVhgjoyMoYfLC3C3EJiR4k77tBwV9CDJFcUnJS1RjxV17
         vx5P+Xob1kRGGuPmoaONoXKALsY5+V0cNukqr9u9mc5g/u1qkInMeOwCRM+01ousui3J
         VqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373553; x=1783978353;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXM42XRsNruvqY2Vgb884XDt0as+6A4qsiGUbLElGzc=;
        b=m0GWXIgKNZgLU6MBEpLSUDy2kqdTLxBIzO0rqEoqtNSXqb0tTWNC459wHRNq7kA7v7
         fnvPh9YRnJADtSG9ZQ83iZ30ZNkK1bNCqvq1TyYf2GG/3GDHHBzJcSL4arf69KqOKWMn
         XosciTBO6vZxI6nMs7636Ukh1OIbZ1m4PLu3ivUZuyQe+/SekKJsIxupXUwgdcDno2HB
         TlnyhZA5lFB+AzbiHz26yqOM+ozQACrNYKnakgC0Magz5fNiHOs/OdJpA9YDUERI6+5a
         FvN6xhWa8UuwOqy3wQ3DaaTu6z6ISXk4Kf48dXbvPcoUzvQ+Y3t/kIRlkNv/DpDEoVvm
         vG7w==
X-Gm-Message-State: AOJu0YyE7UqZPNH6EfDn26wmYX62mxgdxvY1Juz8qbAsqI9v2SltJIvl
	9nw1bAVSNPcL1HzxVfDclXdT3jBx9WCuecYm7zkPvQdEz5zFWDwg6CCWfcWoEVDzVagxDg5Oh2q
	TKyyJORDc0s76P5bnZOXQDii7IQ==
X-Received: from iljr8.prod.google.com ([2002:a05:6e02:1088:b0:503:bc46:aeaf])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:178d:b0:6a2:92a3:d1e7 with SMTP id 006d021491bc7-6a3554fa67amr1473951eaf.3.1783373552699;
 Mon, 06 Jul 2026 14:32:32 -0700 (PDT)
Date: Mon, 06 Jul 2026 21:32:32 +0000
In-Reply-To: <akWqXBJrJ1n34BQ5@kernel.org> (message from Oliver Upton on Wed,
 1 Jul 2026 17:01:32 -0700)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnto6gj6byn.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 0/5] Backport ARM64 VHE boot fixes to 6.6.y
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oupton@kernel.org>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mizhang@google.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oupton@kernel.org> writes:

> Circling back around...

> On Wed, Jul 01, 2026 at 04:23:21PM -0700, Oliver Upton wrote:
>> The subject prefix should be "[PATCH 6.6 0/5]" so people know right up
>> front where this is going.

>> On Wed, Jul 01, 2026 at 08:43:37PM +0000, Colton Lewis wrote:
>> > This series backports VHE CPU boot fixes to the 6.6.y stable branch.
>> >
>> > These fixes are already present in the 6.12.y stable branch (and
>> > newer), but are missing in 6.6.y. They are required to enable booting
>> > L1 guests with nested virtualization enabled (kvm-arm.mode=nested).

>> It's a bit worse than this. The architecture retroactively made
>> FEAT_E2H0 an optional feature, there are now implementations in the wild
>> that do not support the feature.

>> > Without these patches, a 6.6.y guest boots with HCR_EL2.E2H
>> > incorrectly configured (because it misses VHE-only detection or early
>> > initialization), causing early boot hangs/trap loops.
>> >
>> > Conflict resolutions:
>> > - Patch 4 (KVM: arm64: Initialize HCR_EL2.E2H early) had conflicts in
>> >   arch/arm64/kvm/hyp/nvhe/hyp-init.S due to differences in state
>> >   initialization. Resolved by extracting EL2 state initialization into
>> >   __kvm_init_el2_state.
>> > - Patch 5 (arm64: Revamp HCR_EL2.E2H RES1 detection) had conflicts in
>> >   arch/arm64/include/asm/el2_setup.h. Resolved by using raw msr hcr_el2
>> >   instead of the missing msr_hcr_el2 macro.
>> >
>> >
>> > Marc Zyngier (4):
>> >   arm64: sysreg: Add layout for ID_AA64MMFR4_EL1
>> >   arm64: Treat HCR_EL2.E2H as RES1 when ID_AA64MMFR4_EL1.E2H0 is
>> >     negative
>> >   arm64: Fix early handling of FEAT_E2H0 not being implemented
>> >   arm64: Revamp HCR_EL2.E2H RES1 detection
>> >
>> > Mark Rutland (1):
>> >   KVM: arm64: Initialize HCR_EL2.E2H early

> Please go through and correct all of the SHA1s for the cherry-picks,
> smells like some LLM just hallucinated some bits given how close they
> are to the real deal.

That is what happened. Sorry about that. I thought I double checked
those but I missed at least one.

> I also want to see that all KVM modes have been tested (nVHE, hVHE, VHE,
> protected) before this gets picked up. Overall though taking this to
> stable seems like the right thing to do.

I'll make sure to test all those modes.

> Any reason why you've only done 6.6? The kernel was first aware of
> E2H=RES1 as far back as 5.13.

My reason for only doing 6.6 is when I tried to boot an L1 nested guest
with these patches on 6.1 I ran into another boot hang I haven't yet
debugged, and I didn't see the point in applying to 6.1 or earlier if
it's not enabling the behavior we want.

> Thanks,
> Oliver
