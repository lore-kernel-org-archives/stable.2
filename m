Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501C131E49
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481396; cv=none; b=g5kpFSkQIVz6oj2GLYuBNmc9voyuoyFBP3RYuBhDG7MMAF3I2YwCoXX86SRrWZzQtQauIayA+7q1VNAWSO/vck/3edlktqRn4UPVDF5i0OOzvkCWFgG1UzP7OSj9Opfeov2+Z313gJyO39UmNADz/QcCEcW020KzQ8INHGI6Z0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481396; c=relaxed/simple;
	bh=A9NsgJ7Ee8zxsLvaDeA9jhD0sOienwLKxmsMjApZ+g8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aZbIrdwAVseqo8Mey+klZVT3R84WgpQa3uIRKwjSUQ5Nm9L/ZiBNMqEHayhOrkSh3025v2aNxjj2Erd7QxasONKV/otDt2DkdtOnIapj0olC13AwtnwaqT6cxEm85s9c/UtnKXumux0mnCBhZfZ7BvEcv/qOIVrJS2ZWo0DE2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqmznXKw; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqmznXKw"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84859a64079so586498b3a.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788481395; x=1789086195; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jc7a0TZBwS3nyLFiARBit3nGQ5ShsAjLF9QRi0rNAgc=;
        b=bqmznXKwsp+EnxX9vsduW8lnHX6gW3u1dgNwumxGarV7t42Qto7gPRQZ1g1Hq6skaP
         elMrvF9r/gaUFcCal6R76OUb9JOjPDWcKT4qxkYlLMw4znN/plQhPLYShc5VCtnp47jF
         aoXKMfF4HavaJbWIx4Xwkm3u9CpLcFzwL9v5Xg4kK5thbWe303jjQ0Oeib+mWX3JaG3G
         rqfI7w43QI/4fshwVubAZBz78GpGOtowM+jKvuMEXWZpB5lPsJ/fXoaqg/t8AsLQ+FzK
         4tmUQYe9OQvnvTxsGtdsxuXU63iXIG7+T4z+bKwn0dG96jbZvp4Wc57Pvqht3XqBsVdX
         SqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788481395; x=1789086195;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jc7a0TZBwS3nyLFiARBit3nGQ5ShsAjLF9QRi0rNAgc=;
        b=pGg6GmQFBXsf5ZHDhbcllK1+XWexhux6Q5QjpjMugntpfsJiVc9lrRpdx8LHXQteAC
         75pqel7wKGO+9TIsI+n32VADy7ilVyQJb2OcmPLvM49ezX8jOqhcEI9feCLmTwMmexEZ
         NA1NPMmZ9CAOIx5/5VKRyJMU3hDVGIAhogTBhcUR/JZryrc3YjkwTHKpZPSfO1bsTJsC
         52kq2xbVyv9EBxEDGIBRJnDnT5eNpuG5AvUiR1U/vqH/Fz6od3TzFz84RljEX4WPfRgY
         blNSI5v2cPDAlNQ34QNfr9EwtDy981xGyc1pW5tiRNqu407EEnyJl0ghvhLuhyNaomYx
         adsw==
X-Gm-Message-State: AFuF++kggXcLs55Y+OHjtvwKLgjeMQ+nyrGOygqV5Q54FmXUAPd/qeW+
	hfQ+b6EBDz0tiaeJ8TD1aW6XJhbhvW1og4BziUWlLOssY4Q2sSZAn5mIdYGqKaMQO+rsjrvKKHN
	D3wQFmQ==
X-Received: from pffl8-n1.prod.google.com ([2002:a05:6a00:c348:10b0:84a:31b0:7544])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1950:b0:85c:3922:25d5
 with SMTP id d2e1a72fcca58-8616aa68194mr3617683b3a.21.1788481394689; Thu, 03
 Sep 2026 17:23:14 -0700 (PDT)
Date: Thu, 3 Sep 2026 17:23:14 -0700
In-Reply-To: <20260902-daily-reply-0017-kvm-sev-psc-nak-6-12@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026083135-thud-surplus-53de@gregkh> <20260831211010.1798943-1-sashal@kernel.org>
 <20260831211010.1798943-2-sashal@kernel.org> <apchDJDrXemR0paW@google.com> <20260902-daily-reply-0017-kvm-sev-psc-nak-6-12@kernel.org>
Message-ID: <apoPcpTa7Qy2isaR@google.com>
Subject: Re: [PATCH 6.12.y 2/3] KVM: SEV: Add an anonymous "psc" struct to
 track current PSC metadata
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 02, 2026, Sasha Levin wrote:
> > NAK.
> >
> > As the first sentence says, grabbing 00b9744a3688 ("KVM: SEV: Add an
> > anonymous "psc" struct to track current PSC metadata") only requires
> > handling a superficial syntactic conflict. This mixes in pieces of
> > d1a3c2162334 ("KVM: SEV: Forcefully invalidate SNP VMSA if its backing
> > gmem page is zapped"), and *that* is the commit that's by far the most
> > interesting. I.e. pretty much all of this is leading up to that commit,
> > not these intermediate commits.
> 
> Yes, this is a complex one :(
> 
> How do you see this series then? it's a lot to backport, but if you're okay
> with it...

Ya, backport the whole thing up through d1a3c2162334.  It's a lot of patches, but
IMO the risk of breaking something by trying to trim down the backport is
significantly higher than the risk of those backports.
