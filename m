Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5510391E5C
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166042; cv=none; b=DZsdtdKWH3bgc2yhawQRlf2XgTKtg+1jMCMf6Cw6oBQlIcGtlQk5+QNu5jk67eWSS7oLZleKwGqLBTo9W+zrRZVZ4YNz8/LrGxynuo+wm9oNN5SbC6bCzx0WoEmQjfX4JC6TK+lgeKYTE+esjeAdpw8SrSnAwhInBicCS2Nqb58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166042; c=relaxed/simple;
	bh=zM3YKYBF5Ow4F/30IYJUSdZG0wFWAxs1rbGMCyNjfBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fyrTm5bKx17Bx6A7FvS+kynAtd/4ESHNfB5y022smCNZCWe7xLuSL44Z1emdMrgaDHzg8HfniuOr7rKJcmPod/g/V+XUojk2qotmNQQdLkSidttRohDWOhZKZ+Ihv7J1KlJVEDVh9YLN5af/cBQaFn+JxpUHldXvM+1rjJWWeJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3PUbmRR; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3PUbmRR"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8487eb67173so4710780b3a.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785166040; x=1785770840; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xYjVu2PU5ywM5mcIzPZDkpnujTQinp7QtborFpJrUY=;
        b=N3PUbmRRSr2R1mU4wJxFWwuGs1v7HhET5YQ9v1WL+WgiUhJti7ECoiLhL+8A3MbOmj
         vj6Ebs1aVWBquhL0I7dq1woRhs1xfDFyeylaleQlTP5F2/X5e43rAxtk5XVNXdM7A0E6
         2go7lAyV2c3s8bw+3usJr4XCJBgXcLSpJIIHbRzRJ/OZJb+//krTVRwdO2v145l4GElu
         xmi/pkQhGP31YoKhNEDVhGn3yxLbOTo3jQx5qScxUkYkGlu5r49NR89QBKCHdCshHACG
         67irhUZatgWjDQkkrP7e9QlmrKY1HO2TbfrivoauFX13CRkjzdB/7rfMCCM4O3LxSMir
         Ww/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166040; x=1785770840;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xYjVu2PU5ywM5mcIzPZDkpnujTQinp7QtborFpJrUY=;
        b=nhKz3eaX/YaGIhdzZ+fWMknY4a5G7zJMBbiySIrlVBawQ6p0N1a5P1JRLYSx7JR7Bf
         CeYKcdPRQkeFVW5xiUoX4NSvE4AWU8RKedsl1vPq/8wSdJHukF1P178iXWuDfa60j1ql
         LpuqNtnl69c0fZjrCIUqNpTOmaCSd+ulKRFoRWuHfHSFI3VNQ6RSEeLC8kFXfVwr3E2m
         CtAJRnQJLRRPdHuaGmIlj1vK74sjPUEQGnEM7wMON2AQZfCotgt/ijk9czxq+jnl1uhF
         qNHPrhU4KtRKMUtcYVki61yjtwvSQQRRmjmuq0JXJVyGU7bOz1hpS3SFsKMXFVtBwLY0
         KoIg==
X-Forwarded-Encrypted: i=1; AHgh+RryWDYYAjgwwvq4ipKO55mTW8Ubk1lp5RqbmgPQaEev+Q2NeZ/cCgFhkg+4TD3gOmFNP4w76Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEXbfwqw8Ds5vi3vCBjwVuft25so4J7Ki+OJOUlc5OJ3KNigPJ
	hHAWQ7CPLlhpSGSsgsGgnxgAEeSUmKGjN2m7dZp9vn5IH+LTk0ucfj2vTWtA/hsBCxjHXEOh8PK
	OTYayHw==
X-Received: from pfbmb2.prod.google.com ([2002:a05:6a00:7602:b0:847:80c0:ec04])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94ee:b0:847:9367:e054
 with SMTP id d2e1a72fcca58-84e88b4bd33mr927497b3a.57.1785166039852; Mon, 27
 Jul 2026 08:27:19 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:27:19 -0700
In-Reply-To: <52cd5021-0290-401e-85d8-bdff0d07a9f7@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720205208.519622-1-chang.seok.bae@intel.com>
 <amJXsVGv3xe7GKu1@google.com> <52cd5021-0290-401e-85d8-bdff0d07a9f7@intel.com>
Message-ID: <amd419IkCNqnHhdz@google.com>
Subject: Re: [PATCH v2] KVM: x86: Remove AMX-TF32 enumeration
From: Sean Christopherson <seanjc@google.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	stable@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 23, 2026, Chang S. Bae wrote:
> On 7/23/2026 11:04 AM, Sean Christopherson wrote:
> > 
> > I'm not convinced that yanking out support is the right move.  By publishing the
> > feature, for several years, Intel pretty much burned that CPUID bit.  E.g. it's
> > not impossible that someone other than Intel has implemented TF32 instructions.
> > 
> > The opcodes are fair game in the future, because their use can be qualified and
> > guarded, but the same doesn't hold true for enumeration.  E.g. similar to how
> > MPX got ripped out and its XSTATE assets got reused for APX, but the CPUID feature
> > enumeration is forever reserved for MPX (I hope).
> > 
> > If the argument is that "Intel Architecture Instruction Set Extensions and Future
> > Features" isn't binding documentation, i.e. that Intel can do take backs until a
> > feature is documented in the SDM, then I honestly don't see any option but to
> > refuse to accept new features until they land in the SDM.  Which I don't think
> > any of us want.
> One distinction I could think of is whether a feature ever ships in
> implementations. If a feature is actually implemented and is later
> deprecated or removed, then I agree the bit should remain reserved. That
> appears quite clear.

Per Christian, who's mail client apparently doesn't use In-Reply-To and breaks
threading for me and lore, TF32 made it into a shipped product[*].

So "officially", NAK.

[*] https://lore.kernel.org/all/CAKSQd8V%3DwfVrUxeU%2BfDRgKJBLdiyCkkY2SRY%2BOoRBNE68LFnCg@mail.gmail.com
