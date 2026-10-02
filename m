Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2B4E0201
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955319; cv=none; b=l2l3PpaQ6bhFlbaNabSPB8uqY2VRyrNoR5Yf8ol7tK/T9SIAu+qhdN5miwoDoPqiA36m/iYLSywlXKQKF7lzwtvG3szKYxA6bXkFLRojcfNcQNnV+CCiQ/RJZE1KeroPpyWRu+HBzdqj2xUy7gscRYOqzcar0d8p2KZCJ8BOo40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955319; c=relaxed/simple;
	bh=bgMeIh1vpMW5r0Z2UUaueYfyJsodKGJ3R8+jL/Snwco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uE50y5ZoN7B0nkH7Zsbrdei1xh3ucUQY0BioQwrmMwNp3IloY7+wxIXzBp7scdwCiPD+dj2OPXePo68g6LsKRVrpwtVOxgPSg7rT0VTguV0sq5Y7bGfS8CQjHEYrMP7gcwPk/sCaqOQ8eWeQuGjp3l4GdqrLf0o8bynTgutrtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nNudwIvh; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nNudwIvh"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e2ebeaa0a4so24672395ad.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790955317; x=1791560117; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ulPJ+yIIyvNEzuRqB5Fotp1huOAGEZ6P6NiuujPsDU=;
        b=nNudwIvhhu5usQa6iKxaCWlojQRbykbKapf29CHEmEuiT1EL7/n83bJbhV6qo+9Hmz
         DEBW9h6W/HqPQYSZ4Nbme1n8hGR/PrSIfydaS3h81mIqyfQ9qRYRO7zM1XG6ipcKakRr
         1UTZocn1KbLTYGjmGHvUcjdP6vQszd8C2/xJKMQbAnFHdyM6pv48I3lT4LqB8ZuE9eDf
         /O3xtakI9fZQ5vSJ1jEsQxeVKKBuUkB5lCuRVEdhm25vJDw7jvzmESYLkGypU6vu2zfU
         MKOqFwr/ZT578n6+QTuD74+qqMHZcElfAM8PHJVJ+fhat6J8nKYfJ4pD0+f+zTpB69nP
         ehug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955317; x=1791560117;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ulPJ+yIIyvNEzuRqB5Fotp1huOAGEZ6P6NiuujPsDU=;
        b=KGAxl4k4gb0Ae4d7Lz6OGYt1Iyedqb2FPt+tCvPK5jedmjmeA7xlx1WZgjHfeoqK3L
         u1bNCdq172IMJEmBsewtXCJlOxqMNxcQviOkI0K4CzIx3/w49sKgKNntuZbcAyN8RQQF
         akHK0/eCgjsYgx7M/BsERo9IPSFr/XUXwVLgOsgqYPpl4HkI1+ZPACLbvzFuY0XU7ZUT
         V1kyrQy9wozsTXKXHSbKUNhN41dO4Xba2LRr1fekkBkh87YXlzMLXE1XCGKnl4MvvOHN
         v95H52fGquggJjB5dwmTxyfxbCxA4oDaTjCrBPXDF+5RB0TpP+dgy0vH2xEytvezWCd+
         EXyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUFqCVueAXo11IItNSuh2VhfxorB8bu93m8lUgGR+3e7QD0YBi5L/HP2Tc+Q0wt2W4aWRMvUA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4mQl1D4Ft5rnqeTfrd+eb+2hsS8frQDX/NJZTcV9oFGjq2nIS
	QUfgWcXlQ8MJ3ZZQFgIa8S9+mp/dQOlF5Zjtn7//u2FX1IvtGk0CNWERMXD2Y8qwQUNyJQaXGN6
	Lq7iFTg==
X-Received: from plq5.prod.google.com ([2002:a17:903:2f85:b0:2e2:f17b:1655])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8c3:b0:2df:9305:8909
 with SMTP id d9443c01a7336-2e49b6ab32dmr26853235ad.17.1790955317254; Fri, 02
 Oct 2026 08:35:17 -0700 (PDT)
Date: Fri, 2 Oct 2026 08:35:16 -0700
In-Reply-To: <20261002151942.491680-1-bruno.produit@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002151942.491680-1-bruno.produit@trailofbits.com>
Message-ID: <ar_PNEIvsQMQPMLg@google.com>
Subject: Re: [PATCH] KVM: x86: Cancel PIT timer on failed creation
From: Sean Christopherson <seanjc@google.com>
To: Bruno Produit <bruno.produit@trailofbits.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>, linux-kernel@vger.kernel.org, 
	Dominik Czarnota <dominik.czarnota@trailofbits.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 02, 2026, Bruno Produit wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> Cancel the PIT hrtimer if PIT creation fails after registering the PIO
> device. This matches normal teardown and ensures the timer no longer
> uses the PIT before its memory is freed.
> 
> KVM registers the PIT's PIO device before registering the optional dummy
> speaker device.  If speaker registration fails, a vCPU can have already
> programmed channel 0 and armed pit_state.timer through the published PIT
> device. When I/O bus registration became fallible, its cleanup did not
> cancel the timer before freeing the PIT.
> 
> Fixes: 090b7aff2712 ("KVM: make io_bus interface more robust")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
> ---
>  arch/x86/kvm/i8254.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
> index 1982b0077..b7875345f 100644
> --- a/arch/x86/kvm/i8254.c
> +++ b/arch/x86/kvm/i8254.c
> @@ -793,6 +793,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags)
>  fail_register_pit:
>  	mutex_unlock(&kvm->slots_lock);
>  	kvm_pit_set_reinject(pit, false);
> +	hrtimer_cancel(&pit->pit_state.timer);

Given that the timer can be armed if and only if the PIT was successfully registered,
wouldn't this suffice?

diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index 1982b0077ddd..33d772c7160b 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -790,6 +790,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags)
 
 fail_register_speaker:
 	kvm_io_bus_unregister_dev(kvm, KVM_PIO_BUS, &pit->dev);
+	hrtimer_cancel(&pit->pit_state.timer);
 fail_register_pit:
 	mutex_unlock(&kvm->slots_lock);
 	kvm_pit_set_reinject(pit, false);


>  	kthread_destroy_worker(pit->worker);
>  fail_kthread:
>  	kfree(pit);
> -- 
> 2.53.0
> 
