Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819F49F136
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788289411; cv=none; b=DXb4EwT9aPGA23WH7Xw9s4a4OKgnbp0Sxq6Z+nvh9QWuIjHKkLbv6hroJN6+XP02ju6bHz7TgpNE8HioaTqlAUm+v554Ty/qsAbcmbavoiSXfIu/v81dD0T6tB59uDGKIai8jQ3HFk5nVXJr/KswF3MuUHbjOxzrAdU28VXoVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788289411; c=relaxed/simple;
	bh=3Kp0ruSb7w8NiCCRW5Ba3+QdyzM+JqjQOGHTfQfwoRI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dq9/yd9MbawInzPxzeKGCdlQaSvMbVOauz0XIKZMXptMWIX6114MkMa4VRJ0+dGyb0wXVvVZphLqI3lQRnB3shpgPIWafBTcurhNoxqQzvlEPma2XOkKovtqvZBTM0X/JInKlaF8RHKuh0yGpCgweTcP39AkNytjDzojzoLaWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSuV13Ws; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSuV13Ws"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d9336581a2so2209575ad.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788289410; x=1788894210; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IFHCAYuzAoxAVdP16wqFsrrbyckmsjpCUKEk4ZtD+0k=;
        b=MSuV13WsE4gHOa0xTqpeTe5IvPY63nYKdEDojqCZdHO01m+1+Js1iDUE+dGDWQlCL4
         uppF9W8Xj8bCIVFTLKQ9SE5BbknsaFzpK9qSuZCk0mnC2f2CjPg0ZownfIZ1gMuer33U
         fqJ+a4Kv9ETCaStBJDXUn6ewIAl8J9AhLBdtUg9Hm5YrAergVHMXj9/GfRPXl/4Jgyjk
         yqVTJUI9X097vo7BSZfnM2Q30OG+SrDRJWLMlcvhDb67Vswd7KXHFr18fZkMvqyaDeq8
         fX/rHnJpzpAnTe0uE7o328PWuYusES7BtrzSQALR3qNWPBpRI3X9wY38tHGqNaoDmY4f
         ikWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788289410; x=1788894210;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFHCAYuzAoxAVdP16wqFsrrbyckmsjpCUKEk4ZtD+0k=;
        b=TUjbEmNaFxj7IIZeBV/fDIY7llmfiC+sJVrm1lvNHDg5SstvCY+WQfAINS+Lns1LSB
         l+dcmtvCiAwhkj3A2nJSCxFSRx1WZnJS4Ui7z8LjS7dKbiaCMQTf2UgZTwXYGZgUMTtB
         zembu/qKZEItuzzdJB8bvsj/XyD5E/pmHPlMyaLkbACfs9wFMZ2xxwjsFf2wujhUgz7O
         XiVYNqPxlt7PconnTqeBlcfdC9YBRpOvD3gX/aRdkqgjK3e+M75Q23NsU1kciK/GOO8l
         ujr/fFSS7cwrmmtlo6MF5mHSkNqu3pCVlGMC/yNSf4tFwqGdhj1Bj+rdUDERMhaw+c0L
         4XOw==
X-Gm-Message-State: AFuF++norvPEf6UKE31VGhMXQH7kq2Hw2XXiYteDbhPc5VwL68EZ6Fyo
	ENspLbsdH+ADUMFSrr/KUXZ/s8mP7grNJeVlhPo7sYEdXi2Wmffkc7nOYoIZnIjWMog2/4tIG6o
	+bXZENA==
X-Received: from pleo20.prod.google.com ([2002:a17:903:2114:b0:2cc:1455:612a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8c:b0:2d9:2ff6:2497
 with SMTP id d9443c01a7336-2dae5eb9e13mr5317645ad.13.1788289409548; Tue, 01
 Sep 2026 12:03:29 -0700 (PDT)
Date: Tue, 1 Sep 2026 12:03:28 -0700
In-Reply-To: <20260831183157.1673215-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026083106-utensil-mangy-28f5@gregkh> <20260831183157.1673215-1-sashal@kernel.org>
 <20260831183157.1673215-2-sashal@kernel.org>
Message-ID: <apchgCHbFRXsjfPr@google.com>
Subject: Re: [PATCH 6.12.y 2/6] KVM: SVM: Use guard(mutex) to simplify SNP
 vCPU state updates
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 31, 2026, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 5279d6f7e43d9c5863411482943200bf5ab8a261 ]
> 
> Use guard(mutex) in sev_snp_init_protected_guest_state() and pull in its
> lock-protected inner helper.  Without an unlock trampoline (and even with
> one), there is no real need for an inner helper.  Eliminating the helper
> also avoids having to fixup the open coded "lockdep" WARN_ON().
> 
> Opportunistically drop the error message if KVM can't obtain the pfn for
> the new target VMSA.  The error message provides zero information that
> can't be gleaned from the fact that the vCPU is stuck.
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Link: https://lore.kernel.org/r/20250227012541.3234589-10-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> [ This tree lacks upstream commit 1fbee5b01a0fd ("KVM: guest_memfd:
>   Provide "struct page" as output from kvm_gmem_get_pfn()"), so its
>   kvm_gmem_get_pfn() still uses the older pfn-only signature (no
>   struct page **).  Adapted the refactored
>   sev_snp_init_protected_guest_state() to keep calling
>   kvm_gmem_get_pfn() without a page argument and to use
>   kvm_release_pfn_clean(pfn) instead of kvm_release_page_clean(page). ]
> 
> Stable-dep-of: 42a39ad5d592 ("KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP guests")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
