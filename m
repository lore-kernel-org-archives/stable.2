Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891605;
	b=iy/OdyJfAwBKLFFBBmrwRK87M4btTGW6+fHxzFEg4ALkGqRXpAOQpJpv4uzaJ2eyz0KD
	 eFCIFPO28Mpv4a72FQsl//PL5uWXgQ+gC0NS/Lm17F+cOxnByDMALolKub9DIsbOF4RhC
	 1jBFCEt9sqZYpBFdTuStKuubTDVn7K2PFbSkinFhHRHkqzUP599jbpavvkm7DpHerOFi9
	 A0ZfTSr/hC4CTysPmPlZgvxDuubdquFAnIj5oajl7+B7cDKcO4AC3q3yH82TNKIhvy32X
	 +2jEkDd+Np1P7REsLGM5RiPfntOOIhxznWooLsoCHXXF57ITWYKVThIkZb1Y1btpWjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=s0nutuVUph4b6cXq4/OVubQ7e7mF9JBGs/elhgXlqrs=;
	b=WMJJ9ilqW/2Lq5YnCGP+dv56hr5AoN6iZxLuMymPEtuMEiHM7M6auZysDvrRtVFO4/AN
	 kb2AGGoouqzZYlq+KQ79YJPo/s7H1wo5PjpjLnzn0zV2l3GtC593Q8fyE9+czUSz8vtlc
	 tk+XMhE65Vit3HcLydXjxMnJcpUzD1IImpLhXfKtJSW7jP5M7d/m5eIHlPjxZK4JweG8K
	 n1a9mA1G69rh8nsDFZTdBNNxHsrEsLaod50R7tSBhLNSqTKP2LzYV1W37wY50rZ1LxQil
	 9UdJ6DtMJZrVrt9ZoPIqkNq/D//NK9cF9mFPzZenonelgmFXKAAKMbKsWJG+wc786OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f407I9Ty;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654EA606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 654EA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f407I9Ty
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e9995cea88so20764885ad.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 07:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793891605; x=1794496405; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s0nutuVUph4b6cXq4/OVubQ7e7mF9JBGs/elhgXlqrs=;
        b=f407I9TyFd7QbDEAzI4VxDF5MD7wg7TStiJPXukLWrKxgnX4nnD49GaJuzCNmfjO7Y
         2ZN6ZZsk38cOKzPccK8IzPL14yfvhqwO0OUldjCr7i2vGg65dAsCC+RlDlXWeT8URmkz
         GTf0wNR/7GwWjQfe1NURJ/fad8QQlVgs+uCqIEBGD8fW1G2Oywgafp3dKnNs+Ng+XARf
         gDzb3XsS34UShDcan2SodCQsUVsnXV0qcmGPE8RW57/AoetxK1a8CnTY9adobJEHC5hg
         cCnbRleQ8PdxtZ+0MlNqUVJc1hmWnp5yPuP3deg/Btaie2B5d1iwqXog/RP2Iac9tEuo
         6J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891605; x=1794496405;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0nutuVUph4b6cXq4/OVubQ7e7mF9JBGs/elhgXlqrs=;
        b=k4CSmrIAxE9AlcHFRC9m9+CCt86A+JH9ZA0X1Wrobo1lJDoNzER+xB27o/HZDs/UBX
         vnZUEvmLUpmwTAa0iB5CumPgRnuYfvoz/TDvPMjlDWuDTUB2w+kS3wXP2YxbRLM2mpfK
         y3gLBkJFoLkBjgMgjtPNS2i3UdxrORS3fTDQhczdnoE4c0dNU3e78T1hDOf8+kGaJkto
         qZ3arIVHI/gtBhctGTSwCa2Topg1PGMuvVIWMOB5wWkNV7D8A9sUI7/AEz8EHcHf4qJZ
         +/hkCKy495/Jx/8klurYS+v+XGvkrA4Dvq/24ZIYZ/nW9zesLrj4DTPf2YnVVN9dzfnC
         /TaA==
X-Gm-Message-State: APuU4Z/sN3DBerWimh8sm0pCMK2pfpRW0LmL3OjYtptluzQOOY2iDbYw
	rZRzxdL0atFsA1garPItn/Xq/zSSXhvDguAJ9aPbJW1T2cBjkQzKbz94y+o1qPhOZVy9Y/5p0iL
	XNWeE+A==
X-Received: from pgfd3-n1.prod.google.com ([2002:a05:6a02:6543:10b0:ccb:62e:3f01])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:390f:b0:3b0:a4bf:b90
 with SMTP id 98e67ed59e1d1-3b0a4bf0bb0mr3622356a91.20.1793891604482; Thu, 05
 Nov 2026 07:13:24 -0800 (PST)
Date: Thu, 5 Nov 2026 07:13:23 -0800
In-Reply-To: <20261105121724.2103509-1-xiaoyao.li@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026110400-steerable-maternity-eeae@gregkh> <20261105121724.2103509-1-xiaoyao.li@intel.com>
Message-ID: <auydE1K6ENl8wIfk@google.com>
Subject: Re: [PATCH 5.15.y] KVM: VMX: Preserve negative return value in
 vmx_handle_exit() with bus lock detected
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 05, 2026, Xiaoyao Li wrote:
> [ Upstream commit cef48693da1e964e9f192bfc16cd0ed287c48337 ]
> 
> Preserve the negative return value from __vmx_handle_exit() when a bus
> lock is detected, instead of always overwriting it with 0.
> 
> The purpose of bus_lock_detected handling is to force a userspace exit to
> inform userspace that a bus lock happened. The negative return value can
> achieve this purpose, and changing the negative value to 0 fails to return
> an error to userspace. So, preserve the negative return value.
> 
> Fixes: fe6b6bc802b4 ("KVM: VMX: Enable bus lock VM exit")
> Cc: stable@vger.kernel.org
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260805034602.5B2BB1F000E9@smtp.kernel.org/
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Link: https://patch.msgid.link/20260819094903.3060020-7-xiaoyao.li@intel.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---

Conflict on the exit_reason field due to lack of 7172c753c26a5 ("KVM: VMX: Move
common fields of struct vcpu_{vmx,tdx} to a struct").

Acked-by: Sean Christopherson <seanjc@google.com>
