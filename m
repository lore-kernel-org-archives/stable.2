Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA318AE3
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373486; cv=none; b=C1gpRtL8mcScoQ7PKf6BzvN2lgh5x9Qv198zDeRAAD2jeBtBaPKkQ69PAO/f5fPFeeHQ7SwJn4NcoSSglwRz6lPXPpURf43ugH4jYCOf6nyqZHnrWbyCv3PxVuwKba8DN++Fz4coOceIncx+naXWwsGdza6nTFL8fCTBHH5ceAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373486; c=relaxed/simple;
	bh=KNBWdwrXuVuLe1pGgzoYnnrur2xfF1tee4C4t7SlKBI=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ilH90pTkJWlwOnUxG1c5w5/jZOSBoBqGDu9FPxTCxvY/GQfZ7TsTQ1LyPworvfZCDrHjq6Y2jcm68ga+Dp+2I764IGV0KczJNrUkdglRyEI7sWAT4LUiWNqTDQOC4Nmf/g7s/gIcG5pHp9UORYCPcerqHIvjuTFvyKNaAS5Cs4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujXuQxMl; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujXuQxMl"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7e9dc0f5900so38749a34.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783373484; x=1783978284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wrEtuZnNKTHhXzzXH6FBZuUyiD4QdjI7aUV2ges9QRI=;
        b=ujXuQxMltjCwjeaRO5X/+cs9wjpq4TcLMkHSBFigL65F4d77USM6no6VrftLLdtPNB
         kTkMo59K++FToNKieSQzWhfuF19MM5hSATEqZvnNXSyMAHqDpBzQBL9+wjHo0hl385Se
         Wg2Z0uOXMLc0UaLb9d0Bz+4vOTNt7PC3iba/fbaBEFt5OVNvCIID+bMbZpwe94YGxg6R
         JqF+LV8ZGG5V1jC95fguLgdhV7xakvhbRqIzyeIm2xPM9OgMZ7zCnz6bSzLh6yqqYxOr
         Ibl+Ytmz5AYMSnuoWP9wPqweEpOlLsKIRL7p8jX2UrnR3MRSDpoHEPwntRVlXAG9Ekld
         90WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373484; x=1783978284;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrEtuZnNKTHhXzzXH6FBZuUyiD4QdjI7aUV2ges9QRI=;
        b=PZfDwgXid/GTDfQOndtJeCM42Q8KmXvvBruoivCxMGIInoaqEzoHh8R9WxXi8UvP6X
         /Gh2VigAN8U4sctMCHK9w/HjuzVhan18RvzxGK+AiZ4f9p8E+bV4mQGKSLoL7DabsJ0n
         ygxqvDkS4jcOX3BetDmUBee6ddqqzynwz1BzJCoijtRiFzxkgQDoCc3UUsDNhv86x2OT
         jJoOV0w1MzMSjvaEOlsR6gOkonto8Wb42QuqB6J07az22eKk0zvI9d1fo4oYxqED2uej
         VbpeHeHfjkiYJEXuF5gJKFonqZU6R6+v0DiYexZ3Nm6eNjmyzDAg2c+AkPuf9uQJ9t6u
         u5uw==
X-Gm-Message-State: AOJu0YyAuMPDLH3wNk+BKI4KC2MIDgLuuzqz8cKQd0ZaeTIfnHcyCyYU
	26fcdf1YTvtDeLURR9fUDt7e4js+ZfifeA2LcpSGi9DK+RQrJL5pbNXPb+eXKoXMCZuVoztlTbs
	X4kgpo4hVpYGCCDlA9ZdRn712ng==
X-Received: from ioel1.prod.google.com ([2002:a05:6602:2761:b0:9a7:ea8a:6db6])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:c92:b0:6a1:93a5:cd70 with SMTP id 006d021491bc7-6a35c45cbfbmr12190eaf.31.1783373483917;
 Mon, 06 Jul 2026 14:31:23 -0700 (PDT)
Date: Mon, 06 Jul 2026 21:31:22 +0000
In-Reply-To: <akWhad3U5VNjWzxu@kernel.org> (message from Oliver Upton on Wed,
 1 Jul 2026 16:23:21 -0700)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntqzlf6c0l.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 0/5] Backport ARM64 VHE boot fixes to 6.6.y
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oupton@kernel.org>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mizhang@google.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Oliver, thanks for reviewing.

Oliver Upton <oupton@kernel.org> writes:

> The subject prefix should be "[PATCH 6.6 0/5]" so people know right up
> front where this is going.

I'll make sure to include that in the subject.


> On Wed, Jul 01, 2026 at 08:43:37PM +0000, Colton Lewis wrote:
>> This series backports VHE CPU boot fixes to the 6.6.y stable branch.

>> These fixes are already present in the 6.12.y stable branch (and
>> newer), but are missing in 6.6.y. They are required to enable booting
>> L1 guests with nested virtualization enabled (kvm-arm.mode=nested).

> It's a bit worse than this. The architecture retroactively made
> FEAT_E2H0 an optional feature, there are now implementations in the wild
> that do not support the feature.

Good to know. I'll include that context in my next cover letter.

>> Without these patches, a 6.6.y guest boots with HCR_EL2.E2H
>> incorrectly configured (because it misses VHE-only detection or early
>> initialization), causing early boot hangs/trap loops.

>> Conflict resolutions:
>> - Patch 4 (KVM: arm64: Initialize HCR_EL2.E2H early) had conflicts in
>>    arch/arm64/kvm/hyp/nvhe/hyp-init.S due to differences in state
>>    initialization. Resolved by extracting EL2 state initialization into
>>    __kvm_init_el2_state.
>> - Patch 5 (arm64: Revamp HCR_EL2.E2H RES1 detection) had conflicts in
>>    arch/arm64/include/asm/el2_setup.h. Resolved by using raw msr hcr_el2
>>    instead of the missing msr_hcr_el2 macro.


>> Marc Zyngier (4):
>>    arm64: sysreg: Add layout for ID_AA64MMFR4_EL1
>>    arm64: Treat HCR_EL2.E2H as RES1 when ID_AA64MMFR4_EL1.E2H0 is
>>      negative
>>    arm64: Fix early handling of FEAT_E2H0 not being implemented
>>    arm64: Revamp HCR_EL2.E2H RES1 detection

>> Mark Rutland (1):
>>    KVM: arm64: Initialize HCR_EL2.E2H early

>>   arch/arm64/include/asm/el2_setup.h | 52 ++++++++++++++++++++++++++++++
>>   arch/arm64/kernel/head.S           | 17 +++-------
>>   arch/arm64/kvm/hyp/nvhe/hyp-init.S | 16 +++++++--
>>   arch/arm64/tools/sysreg            | 37 +++++++++++++++++++++
>>   4 files changed, 107 insertions(+), 15 deletions(-)


>> base-commit: d1cfde2d5d15be14123bdd1689162bd27f995a90
>> --
>> 2.55.0.rc2.803.g1fd1e6609c-goog

