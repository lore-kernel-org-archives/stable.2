Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548942;
	b=Xl6bT1D1JeH2cdN2hwnHLlgxwV7h6nNGtwP8H/G2mA1J577BWj9MNQ5AQJvCLmHHk0BB
	 HJ9nhfDpkoNh8TXlBd5kliNfJvqfrbYTl0EOJK17vAz6DgH41Ys6Iq0DVyJKEoJkTBL0x
	 QlrzTcPS+c6/xb09U/A8hHZt0PQ3tDHwczeCNo9LC5UDaThk8USgZM3uS1yZ0S+wVGmv5
	 UuY5AxyAAMe2tcOOgR9bRS20yVbNBEm+SraNdox4Z+K3dTR4p/Lg5c+GwWRrQD6OiW6wS
	 vIkkt1nMhT27qsuyIAtxMk9NYF0uGo9Xzm81CQxKszJ9BbamvUTVRik3FPRFKkfkXrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Content-Type;
	bh=3QqxkdGBMdHAyyER16pFtqlovnizPsQ4fu1kq3Zl4x8=;
	b=rlwsGBP3brC1Y5daegK51Ss2FXB9GO/EAdaUeqf4yK350bLYgPM2e+1aJTjcYCfik7RH
	 o4/J8tmhk7kFp6xUgFQ1Hweuz+0g2TK7Brh74yVIb/5b1zP5eSVyfsf23/1lwiZevoM5d
	 vbaTzj86DTJJscR56mjVUDcEAg0EIpyAr4MeiYl0tq3oeMmP8ZFq34hiJL+JnuBzgv2Dw
	 toQGiINLSIV9zatXA7tBC6mgWPzoqWEnpfoV5Kiyfp2AGajRsJ+UstiROCyT0r8vNGEk+
	 /pQiwSoM7G9/V/Tl9USn7dLz2hVVCKE+yf+Bp8kBclSuZ8QjeUs5rJVtlHa6GcBBDKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="P/fd7l5w";
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB34606A31C
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DB34606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=P/fd7l5w
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e818ca61bfso1980955ad.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792548942; x=1793153742; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QqxkdGBMdHAyyER16pFtqlovnizPsQ4fu1kq3Zl4x8=;
        b=P/fd7l5wxnsg5kND6SVH+f6/SK1JqKAMKIcRgEL7e0CIfe4/sXsq5PD1COVJ4SgLZe
         YHlJsEZ9bQtS4SZm7csaM7WmzRbj5F2SQUYrfa2wQJ2KNZ+galtwppA7oIXjmyelAJ29
         wG19FGNffywMEgcgJ4q2KCNYyBWQ8LjZYOtC7bxVFQYwcV5tQNK4s4wsZdDUtHsg94Xk
         oWLUdeOHVMtM5Zohki/K4Ccj8nSIgDk9Y62qWlsCgfQFey9QeoBiJ+jkx4w6bQGVlDpK
         95AW5SvLceitKUAvTBaZhv837DulzM+IR/3nz407HP5e7xS/CA6WzCoHKu25Byi5y2xI
         J63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792548942; x=1793153742;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3QqxkdGBMdHAyyER16pFtqlovnizPsQ4fu1kq3Zl4x8=;
        b=ZUFqPTwvOhFzsbllZ67XXQD92bNoczMOBSZQduJB6w1nVHU2BvSyrAhFSkpG07t3+B
         AzHNPpcJDPMOa+uPfGOqNnJI+OgJijzIExgtrpF+J1uT2FNYCOiOkTyFr1/WB08/qmAo
         cWlrYDNFDgB9JCmVnICW/nSti6+QT+yffC8bIwHkOxBAHuQgU1QCXyxZl7KaUDj3v0AG
         wpCOW5XEbpXmRoXmMFceM3ENdrJAt41Vqag7AxP7iaHuljcmqvsT4HARJNyiHFcvwd3F
         pk5mCPJfiOx2au+viqn2KNDjrENpLBN1Dz7PGJeQIzpQvPu7vLhhTQNzMWFeBVL6arcF
         QRjQ==
X-Gm-Message-State: AFq9FYIKtyh2I/v1YSLZ45I/gxQtIVvYSj0bUCcv6QO66YgzNUUaZKnK
	fmIiyGQYHRW3TP3XGJVO5Kby5puhX1pyYWFs6GnPWLYekyBZQqy3xc4F7BGtk+MQ0n78cBm7pw6
	H9+zCEYM+ERkJfMGexspJ8jRFlJ96BfRBNsk8KkU/K9VXmDIxA1i4P9c58SkLecjDSHUzXMaeJV
	93+syWW68yA/kZBfBpMwgPh4Vb74GNaK51Us0w
X-Received: from plblv13.prod.google.com ([2002:a17:903:2a8d:b0:2e8:4252:d40c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54e:b0:2e9:5d1f:dffe
 with SMTP id d9443c01a7336-2ea43c2ee00mr6182505ad.57.1792548941055; Tue, 20
 Oct 2026 19:15:41 -0700 (PDT)
Date: Tue, 20 Oct 2026 19:15:40 -0700
In-Reply-To: <20261021021221.1703700-1-seanjc@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021021221.1703700-1-seanjc@google.com>
Message-ID: <atggTIqJ9bHI5vIk@google.com>
Subject: Re: [PATCH 6.18.y] KVM: x86/mmu: Preserve nested TDP shadow page
 tables if they are used as roots
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 20, 2026, Sean Christopherson wrote:
> From: Hyunwoo Kim <imv4bel@gmail.com>

Gah, I'm rusty sending patches to stable@.  This should have:

[ Upstream commit 7a2c70e777a00c32ebafd376a6fe31ebb91c5b20 ]

I'll spam a v2 right away so that I don't forget...

> kvm_mmu_zap_oldest_mmu_pages() excludes a shadow page whose root_count
> is non-zero from top-level reclaim, because such a page cannot be
> freed. The path in mmu_page_zap_pte() that recursively zaps a parentless
> nested TDP child has no such check. As a result, a shadow page can
> be zapped even if the page itself can't be freed; as the comment in
> kvm_mmu_zap_oldest_mmu_pages() notes, zapping it will just force vCPUs
> to rebuild the page.
> 
> As in top-level reclaim, do not recursively prepare zapping of a
> nested TDP child whose root_count is non-zero.
> 
> Fixes: 2de4085cccea ("KVM: x86/MMU: Recursively zap nested TDP SPs when zapping last/only parent")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 205d314a7583..1fa251ca4dcc 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2630,6 +2630,7 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
>  			 */
>  			if (tdp_enabled && invalid_list &&
>  			    child->role.guest_mode &&
> +			    !child->root_count &&
>  			    !atomic_long_read(&child->parent_ptes.val))
>  				return kvm_mmu_prepare_zap_page(kvm, child,
>  								invalid_list);
> 
> base-commit: 2ff600d29ee478d0a8d46ef8a58afb5e038fe692
> -- 
> 2.56.0.218.g1ec904b173-goog
