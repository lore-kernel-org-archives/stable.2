Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793433532;
	b=bWOd2h/cyoppG6Xl0eJTZUIyh3b88lusPitU3IMw3ToDFYwtBQfnDFZGaMA8e0CYxSgx
	 lM7PnUClMvwqIf8bQxrbf2CtPDVfpLqC1dv0xCu5XxUp0Gdv+OMkqNx05HEPfLUT95do5
	 t09q+VhOVLdACkwQXOPJA3tW6REck+aYgcll5MTFNgBedCT20Kzfp14+0KLGDvJvWX19z
	 OFPQfKiaVJRnYsIb1GqC2B/aW6jhAPh68/ti26dHGbwmWPmHqwjASAzmIkXipuVDzd4Q1
	 pn+T3hc3K5twpeD0Ee5F681ifZ3OWtF8pIkxOHdRPEDTVgsf/Kpy3NJs9Mfav9PYd8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433532;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=cWLQnA7YxkUV11ntJAC93nyQrTQTi9l/k6D1HlIezuo=;
	b=eoUM0LxkIvjuB3C2DzAIxwcYVXGgLtXKCZZwco5BpWsYUkHbZws9eYiEnObv+CykXhQ3
	 Sevh5IM1GIYLw7bk0fI7L+qk6lCenz6e+pl1G0ByngMkkjb4wcfiKNttaMFGdTIeiCrR2
	 nhnCF74offgTwWoLdlIchMxogwgKQ5zFkCyg3WEUz7oYv2aOFpc+NmPJqH0TMzIrhZY1+
	 qViNpRJJYFyMbpZ5KHimePAnCidDqWxZcWtwtJMw3ApQlSH1OgoQg/s8edepjstCFB7o9
	 5uvtfsR5KnCggpltvBKUk8KCRDzA7te0qRngjIhT4CmNsuUbNCoAU39jBaHtuOSYm7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idOVwg4r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A7959606A32C;
	Sat, 31 Oct 2026 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idOVwg4r
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BA1BE1F00A1B;
	Sat, 31 Oct 2026 07:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793433531;
	bh=cWLQnA7YxkUV11ntJAC93nyQrTQTi9l/k6D1HlIezuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=idOVwg4r/o2uK7SKqorGQqz0mBzCSMRRPR/IxtsWNSt1VbwC/DMiJr/qw6PnRkZaN
	 FIVDw2eXQjbxW5lNjdw7M1LU+5hilbGdiDM2Y5Ez3oMMOfPTlnmAoL3b3Jz6jB+LFT
	 eRL6/sl17ftvlo+dxhGVqFAZeSoxTzImCOcTuMme3+c9y33pdqrlYJGxvBywXjNXc6
	 AFcULzA/XubDkc/qBI36fOmqJbfHAkU2dZhvD3TJVMPpGpIVVbrvoTmv4ZnFNit7AO
	 cz5A2RAhNFQ9W5N+wPudDQn9r8n25IxS1aP7hsnYNtr4CfXHu7HSR+oTvPFvHtfsEb
	 JDQAlSGU4yajQ==
Date: Sat, 31 Oct 2026 09:58:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gallop Permission <permissiontogallop@gmail.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] KEYS: request_key: enforce keyring restrictions on
 constructed keys
Message-ID: <auWft1EcujMbVy8S@kernel.org>
References: <20261030173930.40948-1-permissiontogallop@gmail.com>
 <auTfZL8RjQqT8uiW@kernel.org>
 <CAMdFwLH_cg_=cLaL-j2B_0kzAEof89r13=cYR--hgeLxC7Bubw@mail.gmail.com>
 <auWejQPzciYJWHj3@kernel.org>
 <auWfECT7SNhBDZtl@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auWfECT7SNhBDZtl@kernel.org>

On Sat, Oct 31, 2026 at 09:56:03AM +0200, Jarkko Sakkinen wrote:
> On Sat, Oct 31, 2026 at 09:53:54AM +0200, Jarkko Sakkinen wrote:
> > On Sat, Oct 31, 2026 at 10:10:36AM +0530, Gallop Permission wrote:
> > > Hi, Jarkko
> > > 
> > > 1. you asked: What does "key becoming positive" mean here broken down?
> > >     Here key becoming positive” means the transition from
> > > KEY_IS_UNINSTANTIATED to KEY_IS_POSITIVE
> > >     after the type’s instantiate() succeeded and the payload is present.
> > 
> > Great use concrete termininology.
> 
> Please also read:
> 
> https://docs.kernel.org/process/email-clients.html
> 
> Especially quoting part. Your responses are somewhat difficult to read
> and we don't prefer top-posting.

One more thing: the short summary (subject) is incorrect as we already
do enforce restrictions.

I missed this one earlier. Just put something more appropriate, that's
all.

Br, Jarkko
