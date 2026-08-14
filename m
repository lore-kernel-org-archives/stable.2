Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6625346C4DC
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718455; cv=none; b=PlHe9aapnxOv3vlkks2yooqqgMAEjEQyNDpM7+EkszFrIt+yZWfUjuC8liT+4ji4mJVgy2DNm+Fuze3OyU9XdEb29Eym64RWAHwzcJZlVY531w7CoUAYqBmMkowQJqFie+/M07QiqO1sW8Wg0b62mP+nGoSMVOwCzdD0aLceyGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718455; c=relaxed/simple;
	bh=vi8gclO6dA0Qr43/AeZbnQs6yw+wCFlnSmv/oXTcpF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g09gkHj99/F90WxK/zR2IeySVs24cFedYgk/AysLqa9cXbU8SduflpKTOHP1+UlhvRmg/krwOVf3/zbnilxG3Dxf4MeSrYmdGLsSBTaRcZkAqWdHhU5+Dc423yZSRrqwoKEPvW3SFMb3qaoCNcksGFPGr22J46279qUlts3XLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HL9+58HR; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HL9+58HR"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so1527637b3a.1
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786718452; x=1787323252; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NEG+D/4GbPr7J7w9NHsXjzozIw0acGw+AY09OInlalw=;
        b=HL9+58HRtaV8gtgzv0jhQ7GWEhCRUsvN7qtPaxsTXUYgZASkrMfcIrRXByscDOV3LN
         BZrd3A2jEk78X67DcPQDfWYhxZ2o3+utYA2GNvOJHP/P9Xrk/K6VnU8AVQ+OXaHnWET4
         RR9dMuAWEa874AHnFU7yPNjYB6dprujq1Q5QYaCG4xThtR/5AtXZ7FeqKxyDodJY3y1h
         qxnjdaVGTmJHqQQHfIbgp04gPyXc968PFcXYJu0ScnX/BjUgZ3OL7kq756fNQ7BLx4LI
         1u2d5xHfB/YliSCjyUZFEJwqAis0GRMuoJHM3iFZYp7vgWFmKdLBlFYIRGmirJwxSe6d
         Omtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718452; x=1787323252;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NEG+D/4GbPr7J7w9NHsXjzozIw0acGw+AY09OInlalw=;
        b=h1ZILshFzzS+vzZJL/NZcqL3aykcBBou/JCtjNs/waiT55RuLPTTXnnFgRmjIGanRf
         5zt5VMbB1Ra65US6NW4GYDDEtiYedbLb/HZzBhHAbWJP2gN1EGW92eZqNQedmEh5qjdl
         jkkBmgebAOMYyFI0gfHh4dZ0o8j2m2PPSk+mAzSlCMRkoS+MGAw2saPrMQOxmZGa4Ph2
         9je9TefZSucSIvgOENw3nuKcSMhpi54q0omJZ5MY+5Ue26Wgwwor5/WQ9MktpTny+7hw
         p22Snpw2boPErFHC6XBIQIj8+U/QajMWeXhq6/e/L3ClmvXMlHonzapARmOf2tZ+O8tC
         iDWg==
X-Forwarded-Encrypted: i=1; AHgh+RpsQ7MU1k9rPR/T41IJ/yy863efCXtB95e0tLuelGMkORh5aBnFmzN8sqvFe30QiJpE4wRwgG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOC05YKoIehadpa2v7UCjAwNUcuOXvkF8D5SInsSPHIeGwM/l
	YCJNA8uWo5btiD36ei/4etmM148xtiCV5+qX7f3o+YrLVhjtdIRsQBy/iWLn22clj/0jPps0LFL
	oYyc1Ug==
X-Received: from pfblb23.prod.google.com ([2002:a05:6a00:4f17:b0:848:2ec8:662f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:808a:b0:848:3e74:85eb
 with SMTP id d2e1a72fcca58-84fde11e5fbmr7315203b3a.1.1786718451519; Fri, 14
 Aug 2026 07:40:51 -0700 (PDT)
Date: Fri, 14 Aug 2026 07:40:50 -0700
In-Reply-To: <20260814100652.225499-3-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814100652.225499-1-jinpu.wang@ionos.com> <20260814100652.225499-3-jinpu.wang@ionos.com>
Message-ID: <an8o8j3h020zxAOO@google.com>
Subject: Re: [stable-6.12 2/4] KVM: SVM: Add support to initialize SEV/SNP
 functionality in KVM
From: Sean Christopherson <seanjc@google.com>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	dmitrii.omelchenko@cloud.ionos.com, Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 14, 2026, Jack Wang wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> commit 6f1d5a3513c2370bbd6115dd430906bc2f4bdc53 upstream.
> 
> Move platform initialization of SEV/SNP from CCP driver probe time to
> KVM module load time so that KVM can do SEV/SNP platform initialization
> explicitly if it actually wants to use SEV/SNP functionality.
> 
> Add support for KVM to explicitly call into the CCP driver at load time
> to initialize SEV/SNP. If required, this behavior can be altered with KVM
> module parameters to not do SEV/SNP platform initialization at module load
> time. Additionally, a corresponding SEV/SNP platform shutdown is invoked
> during KVM module unload time.
> 
> Continue to support SEV deferred initialization as the user may have the
> file containing SEV persistent data for SEV INIT_EX available only later
> after module load/init.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
