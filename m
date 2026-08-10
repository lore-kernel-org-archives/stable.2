Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6283397937
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402053; cv=none; b=h+PgvHeKyMun3ghpJI85pBbfp8ycf6WfIxqSazzowzRlI2g6NniawGxvI3jX7I3XpyB95e9J2uHEjkJOZnX7QmlMjNdCPrg+70oyLKtsSu+kxPD/PJHrk1Wk1q4CprfF9+MANtux77RcalYv84sEt6X6DXmdgq/FGWNYHa4/DE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402053; c=relaxed/simple;
	bh=Zvc3OyNFbFxd+L1WQUIk56P4XO3D+Yy7+jgjnvCcOyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UTDIXfsqWlPt8R8KA7GMIRm2BHo6ekJqaysthGJFPpYE0zuDtGttWBhQfq/siQP230ppcB1t1x/lUONO1Dsfr3mPe8B2LF1YQu2jFtoP7WGqHCz0V55jLNCB1M0Z0oZBL80l88RJKhYErvFwh5H2MuV3Jei5ZS7PtFuCIuUUGOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oVS1Hyjf; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oVS1Hyjf"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso3651326a12.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 15:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402051; x=1787006851; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8B8SlHhlD7eK2Nerw5QgDEiMfw4ZcEyEQcNiyaxSgck=;
        b=oVS1HyjfagOSnNOGEX2+wexlCJNKKxZxohhaGQeFgI1jQAH7SbAZ5ly72tVl+zJVWe
         eHKCpSG9kLyiU7Sqgb1zb8sV61K6Tiu8I/U1xEaoTNhVcIdrnGLdsLNlKtQSxS5iPeSJ
         UhGBKOom2wPUGiO3oNQHyPVOg9vmZuEcNtkVSVoSl/p/tfI7Yr9TmshqHR/id6ktbyL2
         qy4nkMUtwHPkuus7dA/jPQv7NhWZGJDPXrhTjHpVujACMJiehAlp8lBlkftoIQ4st1j4
         0lRbyW/Iv5guftoiLNwxxBBUl2lWWN1mnJ877iBJlfttHPAYkpztKks9EMBMiYuX0O6s
         E/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402051; x=1787006851;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8B8SlHhlD7eK2Nerw5QgDEiMfw4ZcEyEQcNiyaxSgck=;
        b=q1Re9BRyioq36Tf0Pl4MJackI7e48lvyjpdwZI1YvEyDMm5qnr/0aNS9HlejwoUl+q
         3pJ2nFz+jWFSaqkVjMoBKD5X8JE3UCVKkQ/585UBEjAl5UMXmak7lrp8iW4dVfdY7xGP
         U1chZAgb3XmVj8zQWAR4xTHOwtPUvs1maGrcdLL0as6VLc8nWroZxK11ob2cjl6pAvBy
         IDfTv542z7dK16uuKxIt1touVT/jqitgqqWCpW4OwhM1DWkmHHpL6azemOwj6MSAoNNR
         s/1RgtwiUjgqP2qOSmKgp+P398YkCsSdYrohdXtKLeh2dH/KCaWiBvJrxdkdRMHsr7fc
         fbCQ==
X-Gm-Message-State: AOJu0YwxRGPaXQ/5WB7Ma7WWWWQxdD5OgmKajpFzY7JYhmlEQ67M14bX
	xxEppWA+zAGOewW9nvnLsXuyIGz2L01SfeS1W3VicFakpUUQTPUnu62fO4/EyMgbgDwO8f28xhz
	xizlBuQ==
X-Received: from pgn38.prod.google.com ([2002:a63:d66:0:b0:c96:8ff3:53b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:420c:b0:848:2f2c:b2c8
 with SMTP id d2e1a72fcca58-84f9c95f809mr5744526b3a.24.1786402050785; Mon, 10
 Aug 2026 15:47:30 -0700 (PDT)
Date: Mon, 10 Aug 2026 15:47:30 -0700
In-Reply-To: <20260808062208.522577-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808062208.522577-1-senozhatsky@chromium.org>
Message-ID: <anpVAhjqvBvIuoa0@google.com>
Subject: Re: [PATCH] KVM: x86: Check for invalid/obsolete root *after* making
 MMU pages available
From: Sean Christopherson <seanjc@google.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: stable@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 08, 2026, Sergey Senozhatsky wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Check for a "stale" page fault, i.e. for an invalid and/or obsolete root,
> after making MMU pages available for the shadow MMU.  If reclaiming shadow
> pages zaps an in-use root, i.e. marks it invalid, then KVM will attempt to
> map memory into an invalid root.  On its own, populating an invalid root is
> "fine", but because child shadow pages inherit their parent's role, any
> children created during the map/fetch will be created as invalid pages,
> thus violating KVM's invariant that invalid pages are never on the list of
> active MMU pages.
> 
> Note, the underlying flaw has existed since KVM first started tracking
> invalid roots in 2008 (commit 2e53d63acba7, "KVM: MMU: ignore zapped root
> pagetables"), but the true badness only came along in 2020 (Linux 5.9)
> with the invariant that invalid shadow pages can't be on the list of
> active pages.
> 
> Note #2, inheriting role.invalid when creating child shadow pages is also
> far from ideal; that flaw will be addressed separately.
> 
> Conflicts:
> 	arch/x86/kvm/mmu/mmu.c
> 	arch/x86/kvm/mmu/paging_tmpl.h
> 
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Fixes: f95eec9bed76 ("KVM: x86/mmu: Don't put invalid SPs back on the list of active pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> (cherry picked from commit 2abd5287f08319fa35764566b15c6e22cb1068db)
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  arch/x86/kvm/mmu/mmu.c         | 11 ++++++-----
>  arch/x86/kvm/mmu/paging_tmpl.h | 10 ++++++----
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 7785da8f0ad3..1f4d306e5c81 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4272,22 +4272,23 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>  
>  	orig_pfn = fault->pfn;
>  
> -	r = RET_PF_RETRY;
> -
>  	if (is_tdp_mmu_fault)
>  		read_lock(&vcpu->kvm->mmu_lock);
>  	else
>  		write_lock(&vcpu->kvm->mmu_lock);
>  
> -	if (is_page_fault_stale(vcpu, fault, mmu_seq))
> -		goto out_unlock;
> -
>  	if (is_tdp_mmu_fault) {
>  		r = kvm_tdp_mmu_map(vcpu, fault);

is_page_fault_stale() needs be checked for the TDP MMU as well.  I had the
pleasure of doing this cherry-pick for an internal kernel, this is what I thought
yielded the easiest-to-read sequence:

        if (is_tdp_mmu_fault) {
                read_lock(&vcpu->kvm->mmu_lock);
        } else {
                write_lock(&vcpu->kvm->mmu_lock);

                r = make_mmu_pages_available(vcpu);
                if (r)
                        goto out_unlock;
        }

        if (is_page_fault_stale(vcpu, fault, mmu_seq)) {
                r = RET_PF_RETRY;
                goto out_unlock;
        }

        if (is_tdp_mmu_fault)
                r = kvm_tdp_mmu_map(vcpu, fault);
        else
                r = __direct_map(vcpu, fault);

As a diff...

diff --git arch/x86/kvm/mmu/mmu.c arch/x86/kvm/mmu/mmu.c
index 7785da8f0ad3..d05bd467dc5d 100644
--- arch/x86/kvm/mmu/mmu.c
+++ arch/x86/kvm/mmu/mmu.c
@@ -4272,24 +4272,25 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
        orig_pfn = fault->pfn;
 
-       r = RET_PF_RETRY;
-
-       if (is_tdp_mmu_fault)
-               read_lock(&vcpu->kvm->mmu_lock);
-       else
-               write_lock(&vcpu->kvm->mmu_lock);
-
-       if (is_page_fault_stale(vcpu, fault, mmu_seq))
-               goto out_unlock;
-
        if (is_tdp_mmu_fault) {
-               r = kvm_tdp_mmu_map(vcpu, fault);
+               read_lock(&vcpu->kvm->mmu_lock);
        } else {
+               write_lock(&vcpu->kvm->mmu_lock);
+
                r = make_mmu_pages_available(vcpu);
                if (r)
                        goto out_unlock;
+       }
+
+       if (is_page_fault_stale(vcpu, fault, mmu_seq)) {
+               r = RET_PF_RETRY;
+               goto out_unlock;
+       }
+
+       if (is_tdp_mmu_fault)
+               r = kvm_tdp_mmu_map(vcpu, fault);
+       else
                r = __direct_map(vcpu, fault);
-       }
 
 out_unlock:
        if (is_tdp_mmu_fault)
diff --git arch/x86/kvm/mmu/paging_tmpl.h arch/x86/kvm/mmu/paging_tmpl.h
index 1c7d73b8081c..75fd2b7dc0e5 100644
--- arch/x86/kvm/mmu/paging_tmpl.h
+++ arch/x86/kvm/mmu/paging_tmpl.h
@@ -869,15 +869,17 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
        orig_pfn = fault->pfn;
 
-       r = RET_PF_RETRY;
        write_lock(&vcpu->kvm->mmu_lock);
 
-       if (is_page_fault_stale(vcpu, fault, mmu_seq))
-               goto out_unlock;
-
        r = make_mmu_pages_available(vcpu);
        if (r)
                goto out_unlock;
+
+       if (is_page_fault_stale(vcpu, fault, mmu_seq)) {
+               r = RET_PF_RETRY;
+               goto out_unlock;
+       }
+
        r = FNAME(fetch)(vcpu, fault, &walker);
 
 out_unlock:

