Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503DF41A927
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054521; cv=none; b=ploBP5/TelkCyRPZ4lJwYJOklINBf7DwNHG4zpLj178zhw/2t9pa1n/yqifWbX52STmS1qJtdocdBPoLQMCEnd7EYGkXVY/eEtYdvQfZLIBP1pt8Xu30QtKoyLtUAVhRCvEvb10gKJF4wE+8Q0Ocwn1VSB7R/7visvohm3m/jos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054521; c=relaxed/simple;
	bh=PaQBkS90a4rPCv/dq+YRWwLuz5fATYts+TOoZzoPZj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dp2o7FXtyNrG+Iif8kPIC5Ngt+qhIsdLxqezFYr5hQe27dpIfGDExNSiRxXcdHIcLROLEoWSXQBFoplpHBmwWt8eIsPTdCpPUWLGDKjwHGAuP7dLF81uUjfJVN3bzDV3bj4ZHw3Q90Z0GtEZvdYwSbHX5KK3XxhsTohse7+Vkog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNCK1ue6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNCK1ue6"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84870e7f498so5426558b3a.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784054517; x=1784659317; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4QSNMOG9WUYsnTrdiXuaPBwAZEBhxka1gM9x6zaBmSM=;
        b=rNCK1ue6708Vv/JHVtlGRjDGmBg7q7721OgtbVuL7BIIm4HkNGVJG1vYzTGM9MDe5z
         1OUpxXC0cOGbLG+Jzn1WMctTPA+1IfA1i77sPtNKFgOEjmuSt06dIks3incEeubf428m
         zSITgaZnP86MMavZ181GykbtaURT2oBdYUpnDPxXERg/EWu+mul+RMoxZll7Pjf9AEfo
         Vm/SyCa5dOmFVfkZOWFptvYLO38cjr/ZZBMFQdzRv6KzEGbecMfb8ryqEBDI8RTMYfZS
         mZjgu9H3fKEOon8Rr9RbYgQaJAGn8urwRUCOqbTNxWJAs0meHhowCK3PmlfZYDb8nqci
         pYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054517; x=1784659317;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4QSNMOG9WUYsnTrdiXuaPBwAZEBhxka1gM9x6zaBmSM=;
        b=VUarIg3xYlcceNKK2p7fW1audxd0e3ludoBoPG23ey7Jf85FH1ySWVrzfs0OZS+pNx
         i7Jlx+dEdMlEk/hOdldw7cTpCuKXsNrTshaiANeaG3Z2z6EpNIOWlaZ4aZqzDLZltj8f
         XYKfMIaBbJZzzrYEAyghh0o2wzN5805usDCj8pRi1GsemBrTEpiTEq0yYD+9IaIRMUCK
         sbFVRDW2gXJZed+4WX8o8HCl1CL5Kz7MG7DcHw8K4km4Y+Dz3kevWfdsvwXtKQcEDixH
         PJxAmLx/sS5qmiwuiM2zAZIGuh3S3UWpQuciOxDXYL9qPfqE9+QwoBqJVXf809gp6Rnz
         qpGA==
X-Forwarded-Encrypted: i=1; AHgh+RraLn/uoC9b4KcJtJQlxy3gYfNtqVMI3eRvIqMVvRP0limC99ZpAd0WGcY5RKVYHEUg67bzuzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymNMNBNZAcnJr3e8FF7yHSqFsdrSJig4FtNCy9r9F1A+hqXKqo
	LpTqMOCWiyVkzEP5jXlu0GUdV/tOkwb6IVD3/5YTiCzssYCDy9URQjrFMAVefKciEoY0u02U1kR
	0M46fjg==
X-Received: from pfmy4.prod.google.com ([2002:aa7:8044:0:b0:848:56a2:f6a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9289:b0:848:2ae4:d2ba
 with SMTP id d2e1a72fcca58-84889687b36mr12770821b3a.28.1784054516663; Tue, 14
 Jul 2026 11:41:56 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:01 -0700
In-Reply-To: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405419095.3137257.15966365152304045590.b4-ty@google.com>
Subject: Re: [PATCH v3 0/4] KVM: Miscellaneous SEV/SNP related fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, Peter Gonda <pgonda@google.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Youngjae Lee <youngjaelee@meta.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Atish Patra <atish.patra@linux.dev>
Cc: clm@meta.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, stable@vger.kernel.org, 
	Atish Patra <atishp@meta.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, 02 Jun 2026 15:36:31 -0700, Atish Patra wrote:
> This series addresses a few issues found during code audit of the
> KVM SEV/SNP and CCP driver code. The fixes include a incorrect lock state
> and incomplete state handling during intra-host migration for SNP VMs.
> 
> To: Sean Christopherson <seanjc@google.com>
> To: Paolo Bonzini <pbonzini@redhat.com>
> To: Borislav Petkov <bp@alien8.de>
> To: Dave Hansen <dave.hansen@linux.intel.com>
> To: x86@kernel.org
> To: H. Peter Anvin <hpa@zytor.com>
> To: Tom Lendacky <thomas.lendacky@amd.com>
> To: Peter Gonda <pgonda@google.com>
> To: Brijesh Singh <brijesh.singh@amd.com>
> To: Youngjae Lee <youngjaelee@meta.com>
> To: Ashish Kalra <ashish.kalra@amd.com>
> To: Michael Roth <michael.roth@amd.com>
> To: John Allen <john.allen@amd.com>
> To: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: clm@meta.com
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: stable@vger.kernel.org
> 
> [...]

Applied patches 1 and 2 to kvm-x86 fixes, thanks!

[1/4] KVM: SEV: Do not allow intra-host migration/mirroring of SNP VMs
      https://github.com/kvm-x86/linux/commit/6ee414078823
[2/4] KVM: selftests: Verify SNP VMs are rejected from migration and mirroring
      https://github.com/kvm-x86/linux/commit/df371f2c6244

--
https://github.com/kvm-x86/linux/tree/next
