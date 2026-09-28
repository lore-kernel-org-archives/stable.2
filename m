Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80438E8CA
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620125; cv=none; b=F9MzJyMpW5L1kVq7EXZUfuXL2/vihrCcwYjD8nba02MSX+WhVQDSsEPySO8CKfw8CJFt/7WdvcX72UJEF0tvrGR2rGL7o4piFzQ/G5x2QEjPqWNTzeMp5LZeefr0cAaHTOAtD6yD0Ctzrc19KaSW0qvxQPnZK4Lnvxwkicq6nIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620125; c=relaxed/simple;
	bh=PM7o7yT/Rqooq4IBMLSMsdjoROJ01Ib/Nu/ypwEpkk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZlFncHXOOQb3s5EJcbrBcxJVl6hyw35BOdeJh579Jz4bGlD70IrCNRTIl8kGev7WrJUjpKv4VnucdAWzR3GaXbqiSF/PxVdWNqAHIdE4gYTUYMIOkKtgjxE0n5th/Gi2KQDHl5my8Szp9PJIPjc2lM7qS6axMIGSn4m7+oWDc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IemQbq/O; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IemQbq/O"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d001671a54so33868795ad.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620123; x=1791224923; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCua0pp+YaMex9dVxoGDp0jAQYnIyP+7fQUI4jKTB0Q=;
        b=IemQbq/OnixXiZNmFeFjeYRBndVu0oc89OLyUx9SG/g+a5hBaBOt4Eo9PcLvsJ2Ljr
         YQ7owou9DlPlHx+19BLz5sNVTm1hFQNImh075825vMX6HDVcqPeXpDqXUWMJs+2B9Y7A
         n9FJsn2a6TjtFSKB0mH3hf04+22cneapbnROgvy+iN8xRb1wbUCC9AzfPsmMw+AnWdkB
         K0rX8CgJKLMlURHPyqdcHU6C1/i7BL8m37kLPGHOjkwDJtYMywb7ZW8ZgfnDUdtN6JXs
         GQV745c6INICvSwm3NFOMTMJqisOE6/ikgK3A4Pvd3jBhPXa+QnPFA/UbzEoWb8kb2DQ
         hr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620123; x=1791224923;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yCua0pp+YaMex9dVxoGDp0jAQYnIyP+7fQUI4jKTB0Q=;
        b=Ih3UPV9LIpQzs6J+vROovxqwccnK+W0hHfjQwwyX0rbnP01XzFU16aOYR8L/S0ubGN
         bwwjeuyUWgWM2VvwXOuhNRcEsQTX9MIvyyAbdiv65PNJ9A3C2hdJ8DMZf2n3CkdTCK0i
         K9i5cQKdQXLxROTcFZmJhsEd3NCvBMeU8tCy4IdevQBygSzTMoxDc+ojzjQeNev5mSVK
         rZXqL1H8J8Yl8GCO8HbQmp0bSJpyJ4Yu3UPnA7O1/9juCKhKv8MDWDonYsscqUpFEqo0
         yjMPchmunINlaFQTOp2UOZxo1AFBhrAneC0t/zqr8sGwX9sKYF8P5u2MyFtTvhuXGZI+
         cwTg==
X-Forwarded-Encrypted: i=1; AKwUvBze79XMKVYtF9RK1CN8oQaZqGvhsrvC9QxPPJbYHVqXBQvqR2/k5gB4yaC4+Jb+zEskW1O4hDk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMeyGgobnzp2EvMBgSZimjP3TJPR9jUId1DVqLxsup8tTswz2u
	T8FvCn9+pu4M7OLAnDPA1pgQRj9dON9sDrn7acIAEnQLfqtQJlvaYwe2PakWWF2vLUdmgjc9n37
	IuS8TWQ==
X-Received: from pleb21.prod.google.com ([2002:a17:902:d415:b0:2e2:bc36:1c75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec8:b0:2dd:b6e7:ac1b
 with SMTP id d9443c01a7336-2df7da427b8mr112270915ad.2.1790620122874; Mon, 28
 Sep 2026 11:28:42 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:28:42 -0700
In-Reply-To: <20260928164427.4699-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928164427.4699-1-k@mgml.me>
Message-ID: <arqx2imW1-OL9IU6@google.com>
Subject: Re: [PATCH 5.15.y v4 00/11] KVM: fixes for CVE-2026-46113 and related issues
From: Sean Christopherson <seanjc@google.com>
To: Kenta Akagi <k@mgml.me>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 29, 2026, Kenta Akagi wrote:
> This is a backport of the CVE-2026-46113 and CVE-2026-53359 fixes to 5.15.y.
> 
> v2: https://lore.kernel.org/all/20260626174620.1819772-1-pbonzini@redhat.com/
> v3: https://lore.kernel.org/stable/20260913155523.7423-1-k@mgml.me/
> 
> Changes from v3:
> - Added patches 3-6 to backport the change from gpte_is_8_bytes to has_4_byte_gpte.
> - Adjusted patches 7-8 (patches 3/7 and 4/7 in v3) accordingly.
> 
> A regression has been reported in the backport of commit 0cb2af2ea66a
> ("KVM: x86: Fix shadow paging use-after-free due to unexpected GFN")
> [1], but the corresponding fix has already been merged into 5.15.218 [2].
> 
> [1] https://lore.kernel.org/kvm/20260630223723.83727-1-zcgao@amazon.com/
> [2] https://lore.kernel.org/stable/20260825132543.573783299@linuxfoundation.org/
> 
> David Matlack (2):
>   KVM: x86/mmu: Use a bool for direct
>   KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()
> 
> Lai Jiangshan (3):
>   KVM: X86: Remove useless code to set role.gpte_is_8_bytes when
>     role.direct
>   KVM: X86: Calculate quadrant when !role.gpte_is_8_bytes
>   KVM: X86: Rename gpte_is_8_bytes to has_4_byte_gpte and invert the
>     direction
> 
> Paolo Bonzini (5):
>   KVM: MMU: update comment on the number of page role combinations
>   KVM: x86/mmu: Derive shadow MMU page role from parent
>   KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
>   KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()
>   KVM: x86: Fix shadow paging use-after-free due to unexpected role
> 
> Sean Christopherson (1):
>   KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
> 
>  Documentation/virt/kvm/mmu.rst  |   8 +-
>  arch/x86/include/asm/kvm_host.h |  32 +++---
>  arch/x86/kvm/mmu/mmu.c          | 184 ++++++++++++++++++++------------
>  arch/x86/kvm/mmu/mmutrace.h     |   2 +-
>  arch/x86/kvm/mmu/paging_tmpl.h  |  32 +++---
>  arch/x86/kvm/mmu/spte.h         |   5 +
>  arch/x86/kvm/mmu/tdp_mmu.c      |   2 +-
>  7 files changed, 159 insertions(+), 106 deletions(-)

With the disclaimer that I didn't do extensive testing...

Acked-by: Sean Christopherson <seanjc@google.com>
