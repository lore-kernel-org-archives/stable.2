Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB512F5313
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361360; cv=none; b=pub9FQTejjF5iX6tX3vJ88vKPnRhc/SiEiVzCoBQU/pjH7I0RX7820yDrYu7E8SN5aq6EhvXw68Kh4UcIDFJJ+7+AKNaUPkCWbrhZQZQ0OXc40BMkrzZCx1jfNKnPWhnAmKRtl7BAcDguHqAtvEVcB+T8AIvehnPQJX+nm+RfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361360; c=relaxed/simple;
	bh=6dW+JAuxB4Bg0lJ9WN8fFkd4N5NZoe/+1w+Q139I7zY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qsu52xV+sFE+qQsxij5tkwsZ92tYIcAZmoqlBMJN6cLSkgnw80eHt/KAy3lm+anmppQlmQcEk5QPiG4VqElIU0e77Xfkw0Hy0b8P2tKT0rQEX8ZgAU2HMIxNr0oOuEtqXUfM7yAEJIxy6eCpj49ilw9iGpnIQgN2C+Y+cZfEHQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jEns6GX7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jEns6GX7"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c89956023dbso4325988a12.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783361357; x=1783966157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=24Bm1f0CNkzkBDhc/3jVoVdYR2LedLwQS2n18W/er8A=;
        b=jEns6GX7g5F6PXLGe5c+ktjH/iti5wwIu1NoFWOP3ywdcq7aOs1Zt78m1bqikzft/A
         FQJjrmvTIWb04jAjouA/s6++yUXnTDXFhjOHFhKB47FOFbEvRuHRBCbVZ4TWCAiTJwUh
         yX1c9s2/f0cEPs85jDjImHrh0iirG/FbbJZEzmbRaW6KVdKCeYnULKelOc4c7v+h1Z+b
         +2KXYYlML/63cKEv/eHNrvuvDhAgea2Tt6zg1gYUQ2+B8/ja7pk8L85X3oqfZ1IFAHqa
         0XB2llfleArthD8wRLR8+LHJnLP7ZOhBT2hUX3gt0BUFn6X10+KKmqa/CEbBNaaAZ/YC
         EhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361357; x=1783966157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24Bm1f0CNkzkBDhc/3jVoVdYR2LedLwQS2n18W/er8A=;
        b=GWYhJHeQaH3874z9FbDalb//JEQbhSOCe8xBlKbj+Tmt2g2NuN5mJ99BonHduqcz8m
         0PyfQMVpElPqxOneRwAjmiTISF0VuCPP186chzFVQejToe51kgZChnrT0u5wVbLAdUCZ
         BxNyaSvSGym79ZX3eejkTlSB6QukTkLMqfv9L+2K6EH7Z4OgWOuBb5Q00fnbjcXcYlMF
         netyiOWgroWP7c7l841F9tGaSnMRozGoKp95L/s2x9tTe8zJNq5IHY7zcMpj9OBie/d+
         sEG4OQ3BmXMJKYqATegvaey0Swy7pH+vS17j2Tk61Z4ZnCKFwDgAj1jVTuj2gGDfgHC/
         5K5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrhhCmVlC1lQBIjVAhG6MIYAJgzUanZLIjTJjv80RZApLMNZ99st56VcjMKrG1YGMQEcdbPP40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2NxZFdfeMvISQOSJ0JjwUFap4/YvVVugIsM+v802U07HN86C5
	DZ+g5eYK767jcL9wKaB3NChN3L65C5652qIMryvWXFwahCFm5f6OgZ+Fqr6gKVE6D0mMyQbtZJQ
	+k13Ung==
X-Received: from pgbz68.prod.google.com ([2002:a63:6547:0:b0:c96:8ff3:53b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e8b:b0:3bf:6c05:ab
 with SMTP id adf61e73a8af0-3c08efea06dmr2045616637.58.1783361357431; Mon, 06
 Jul 2026 11:09:17 -0700 (PDT)
Date: Mon, 6 Jul 2026 11:09:16 -0700
In-Reply-To: <akdUUggmSSS1a0IW@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
 <20260602-sev_snp_fixes-v3-3-24bfd3ae047c@meta.com> <akdUUggmSSS1a0IW@gondor.apana.org.au>
Message-ID: <akvvTFUAI9tjOXRh@google.com>
Subject: Re: [PATCH v3 3/4] crypto: ccp: Fix possible deadlock in SEV init
 failure path
From: Sean Christopherson <seanjc@google.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Atish Patra <atish.patra@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, Peter Gonda <pgonda@google.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Youngjae Lee <youngjaelee@meta.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	John Allen <john.allen@amd.com>, clm@meta.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	stable@vger.kernel.org, Atish Patra <atishp@meta.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 03, 2026, Herbert Xu wrote:
> On Tue, Jun 02, 2026 at 03:36:34PM -0700, Atish Patra wrote:
> > From: Atish Patra <atishp@meta.com>
> > 
> > __sev_platform_init_handle_init_ex_path() calls
> > rmp_mark_pages_firmware() with locked=false while the parent
> > function of init_ex_path already acquired the sev_cmd_mutex.
> > In the case of an RMPUPDATE failure for any page after the first, the cleanup
> > path would invoke reclaim pages which would result in a deadlock in
> > sev_do_cmd.
> > 
> > Pass locked=true to honor the lock status of the parent function.
> > 
> > Fixes: 7364a6fbca45 ("crypto: ccp: Handle non-volatile INIT_EX data when SNP is enabled")
> > 
> > Reported-by: Chris Mason <clm@meta.com>
> > Assisted-by: Claude:claude-opus-4-6
> > Fixes: 7364a6fbca45 ("crypto: ccp: Handle non-volatile INIT_EX data when SNP is enabled")
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Signed-off-by: Atish Patra <atishp@meta.com>
> > ---
> >  drivers/crypto/ccp/sev-dev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Want to take patches 3 and 4 through your tree?  I'll grab 1 and 2; there's no
dependency between the KVM changes and the crypto changes.
