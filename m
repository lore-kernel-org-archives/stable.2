Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D583E558F
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151280; cv=none; b=DKtr13gl6fYVQs6CHvPAaiJvmekoygiSQjMthM1VO9L95lMXdEBRXNEkpmJu2SHNQbQ5jq0s5Fb2iFiB0wYZgfbEYqjoDCcgbrTy7h6l6qsDw+1pAHRwR4DsJqNR1SupfBHvX5MSoXArQfeFJeT8qT604ZkeOlD4YunSLB4qYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151280; c=relaxed/simple;
	bh=JUDXYjE+085vb/qXA5RYsfGWqhq2Vv8zIRaknoSRtqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s86NBcnEbMeDX2wsLoctPm//naFnAANQkCErwYJi1wESiw7tXgG2K5+puV4Lp+bGO7rtxwBmxHBz4r6WqGZb/qt28gnHO2wd/aPUOOAZsq9m2T+d3Txh5Prs3PrXiGRGZTy8jwiRLm4uGtCR3/Wa5JkHZzHDAtE6qIOienizbuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TUcTAwrp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TUcTAwrp"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c40447e25e6so118854666b.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 04:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1792151276; x=1792756076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sN9AXA6EqMmnIUQ8CwnmZZw/CdisNxm/jULatVAixaA=;
        b=TUcTAwrp8CosftUxh8RirJuBq3RYlLWem5/17h60yxHsyLw5bSwYIvXv/J+Rt4+BPX
         y5ot6EoupSPvmyDPy/kO1MqTVSRCnGA0mLZ6+BjOGgT0OFJ/3ADcQOKdcVrmWfUZxR5u
         Od1lPhSHuM+BT0DSVd9TLOLKa9ZnJezFkPKVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792151276; x=1792756076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sN9AXA6EqMmnIUQ8CwnmZZw/CdisNxm/jULatVAixaA=;
        b=ifPYXEViGhW0SOdgxbhlTc31nLHyG6muzd0kBN6L6hhtlIF6a0U+zsFrWM9Y2hQCk4
         aDFuMJ+ZJ5K6M1IVPGn5mURSQ/lqeIFE6aKdpGbknr3M4Ps6iMA112EwnRYSm9zoJ6KZ
         lCJdfwkNhf+iH/1Pe2JPAhD78JXuLqpbIy86zhxVQtXFYYEcVEbcWCxP98SSya2qm5ym
         yKioYCmiGXAEoeBt826/p7kgKlRhK7qEmchLlZD7rrteZgKQOZWqnnqz/d4wb7Z99gOh
         EulIx/tINXGLEgQU3l2kxl63OF691H9narQfuF6oqmoabh3phiwNqu6en9m5L/flsiR5
         5zOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwyzN+QB19Gv2ABCgD/r+vW/UWX78eqxvtIuSXKFNR1se9cFhvMSNcyZxSq2dC4bCH/Bo9BEY8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgxG0YWwy2tEYdgiG8mi/hTGqS9hibI/PXAdbZYoQ/2se8foab
	cyCW02XYvno36Jyof2iJ+hejkKvJoEIBjHo4zwIyHBzgycLmw4ZhXK4QrTois1aF2UdIAJWJ4r5
	kNjXYfjo=
X-Gm-Gg: AYBFou35WR7JWeqCr1RKcy8EVm00zhJe5UG1qq5S763gtRPzGR93wWJqCjoFcZZZmKY
	AYzebTtRBw8P9xKFRobOVpGEHYeoQSko/YKYrf9yKaJTOPfX8AtDaFyivAhZB5b/Bxup7bl0cz0
	aJ+0DW5DnxVmSFf54p0g13Rsbki6OkNGiyVa1MN+0DPFQHDwoQZK0VwxoxY9TSxSiofjcWifsOg
	xoDs/IlSQe5ggR//TxWC/PUzrwNBbbXLlKHJovuOksWYsUsc6jkZy1R9QUNoL8qWY7f6cerc4JZ
	SAXELKSiYnPch+EqPearmlfB/2ELjJq1eGDHiWga251XgXW8cPvlRew5lyaK1VOpCcXM4pDB2SD
	srit+IcqKcy+Iq586bAts3bjXob8tIic6jiwa5jv0MiYiVyh6Yhg7bey5eIqeCO3YaUnO71AguI
	mrpP7hlmMu4aZFaevXdWiWQqr9Jlw0GLc7LR0yhMyO8sTXpDu+QihumJnPtvgTKPhkF2k72S4+Q
	/br9RNNZYsIR5CgSgb4vU4V5jXYlwsjwj52teuXlbIacon3
X-Received: by 2002:a17:907:9447:b0:c2e:3307:b922 with SMTP id a640c23a62f3a-c31a9d569c2mr2147312666b.28.1792151276455;
        Fri, 16 Oct 2026 04:47:56 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40913c6145sm65550266b.41.2026.10.16.04.47.55
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 04:47:55 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c40447e25e6so118852066b.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 04:47:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByS44brsXWBMotc+spG6ZwNvubObO4wCtZHGLjhX9cPJe14bqPtwpxtSA9fLFdJNQ7XEjX1QCM=@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:c26:1649:47ab with SMTP id
 a640c23a62f3a-c31a9f8d2c1mr1950016066b.33.1792151275531; Fri, 16 Oct 2026
 04:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016085013.136825-1-toke@toke.dk>
In-Reply-To: <20261016085013.136825-1-toke@toke.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Oct 2026 04:47:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqmfF3SL=r51KZ72TZJVzEgbMkp5Vhxf_c1fGCyeTS9g@mail.gmail.com>
X-Gm-Features: AclHuK-pNrkTLT4US-FhTlvtT0CJPZm2Y6CTKe4y46HYYxBap8FQNPYdpsrF2Zk
Message-ID: <CAHk-=whqmfF3SL=r51KZ72TZJVzEgbMkp5Vhxf_c1fGCyeTS9g@mail.gmail.com>
Subject: Re: [PATCH] wifi: atk9k: Revert "wifi: ath9k: reject short WMI
 command responses"
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, stable@vger.kernel.org, 
	Mehmet Fide <mehmet.fide@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Oct 2026 at 01:50, Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.d=
k> wrote:
>
> Linus, this regression was introduced in the 7.3 cycle, could you please
> pick up the revert directly? Thanks!

Done. Thanks,

                Linus
