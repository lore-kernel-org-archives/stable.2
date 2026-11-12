Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464841;
	b=cEeinf/7XveX5D8W0pFESp0/W7hhGC3P6KNVdO70SM+akz+16FvrtYlHlfFssEvjOO5H
	 /1RwKdGXM1GRb20jdt7IXxyj73MlYAEksTc01stbryxWObMJjgfquNdPKnWYGQhy1j9UR
	 4EAvBj3whyc6aLl8aQ53tNQ9cuKYFHO+qsylOdwJTojk75vQiRkszvsiGlq4Y6aBbVv3U
	 sHs0k+7iurFM7KqGLhamUMfO9WMJK/S7RDTVOeupxm15yT6OyjYA0SDFaKbqoKUkRwpKz
	 pJQ+t1YhVIX1h5HX5gU8eRQoJgsASknDx68nhKd16ZGYV3KxoZkGOOKcEzt9+H0gTWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type;
	bh=RF8nSYHgZ3mAndPkH0mt47AX5IWuspIpOM9gMeupC3M=;
	b=PqoNfZgU7bCzUh1TVaaUKgVLXcxsTme0Jc4Bb7ost5ni1EDE2ZAO79wzcM3jhI8nOSEu
	 9Qo/K+3qtzaYAhwo1tCaPC2/guM2RUvqZmpPUk0iFBSz+ed+Zu8cF3nRjF67wq7nt01ds
	 PhBXTJm9ICHUhU4wWIGFvnWgqDU1AOSwXT0llBn3H0a+HhdtwkRPAtciMhYylk4BSX/BH
	 5M8hoX3FiHRCCdVZUI1ZTgeUk6j9IsNjFdE6ntvMgHHSf2dvAYsevASMTDv5RlEBAJlV6
	 B61a7gwV6WsoT6WB4iR+Ta0BIdYAHQeG7i/h0WHdc1sIII5S2yNb0brbVZ6ZymqH1XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ffroot.co.za;
	spf=pass smtp.mailfrom=ffroot.co.za;
	dkim=pass header.d=ffroot-co-za.20260707.gappssmtp.com header.i=@ffroot-co-za.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oALOAzYZ;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25760606A330
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25760606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ffroot-co-za.20260707.gappssmtp.com header.i=@ffroot-co-za.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oALOAzYZ
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-498f5fa5103so1296435f8f.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffroot-co-za.20260707.gappssmtp.com; s=20260707; t=1794464838; x=1795069638; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RF8nSYHgZ3mAndPkH0mt47AX5IWuspIpOM9gMeupC3M=;
        b=oALOAzYZM+oMzDxJH9B2GI5my8j2p0IDL8+qPlDJUCJEYhlsBObm4Pk2X9QbvtFSpZ
         2LyZDB49iDJ9+DtBhTuvu87YPbCsw/OSEJ5hJ2a0O6e7R1UzPKAPJX2NugKrRwtbtuq0
         3xC7W0RvAhGt+Qpx1VejPwHmlIT6VNajbZNU458fy6aueaBfNXqYFMW4jKMc/DI3TQQi
         9Md/6tcZfofUoCwcALJPp26LEblCgoDZsESSyGZKCOdgOe7+3gW0qf0q93u/IoFJUcD+
         uAYr5zfl7Q04WWv1nrxz6w+1RJBlxuYXZud+4X4NC12tJX840RdKGPQLBTmmYRJgKDZn
         l77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464838; x=1795069638;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RF8nSYHgZ3mAndPkH0mt47AX5IWuspIpOM9gMeupC3M=;
        b=QgrNhdawF45Epy6evJpkA1qWR7oX8iLQ1zAYUWkmvhfhELqvZ5dnDi0vr5loFHJzav
         Ff+1JsPlvZ8SnreMaOi1cYoCfCq8CMjts1Dvjxsnxdq1glx5AToUrA2N3f9j6TmbmoZF
         peGcxohGYOx8nXMZzPBRzwIYl06ZQXFGmSMdMLidaCFzhLjA8A5pHMCUGnGgHxEurdGr
         DJeuMfgjHacCyap5YVN3LDIRklitmsZcpz6kvfzpjl1L+yFIwSBg2SxBNgGeIVkr+TUI
         v262wKGyHtsnj1Pk/Kv960NTKSoCaU9HpQOeU5qfPCjTKfg2pTwFbl0aMniMCUjInJ0B
         K3WA==
X-Forwarded-Encrypted: i=1; AL+hErGHEM83fFKSbSw/4F8BEiRe3sGPYJuNT2TqvKPLXCWGKnG2wMemiXQB4YrioIGGPX/L5C34uPo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/d5o97p0BgWNoKMCzi7qBmNQlaZncWpsoaF8F+aSJxIsozZV4Y
	nvZuODxLqklCq8l1bnjLpJsN7QcmD9Lu2e6KtPbCuCJwawSKRk0YxfLa2Rk+xg555Fn3yLt7bi5
	urUURCAA11g==
X-Gm-Gg: AYBFou1fn9H/RrZDzL+Sh/aCLC+fBeMe64yvlt7SqPEVfPfEXfSxSeyO4R5yQpkAvnQ
	xCSd0ScDUiNQ0GRPa8uqXJ9Jh182IaSDxU2qZ+QmAwwfLeLYs0H46elNLmGPFwyLiAy71mi8qIH
	vff39kiVz2H/Sr6GKdojryAtQeavXctOa3v52aksOXroSNjII9K3HBkpNLPimHlAsPP/VgYNj1e
	1E30wYiRHUCMTHvLjdfnDwHSoUU15h0FT4sckno8+RsaFkQzxKhequvuwLakhUUKZmk8PM1eoRU
	2XBDb+lqS6LpUZ+7CsIBVjNdYSXui5tcm8L4TDX0S0ESK7C9q/ZrISHyz5tIlz7kGr4aVh3a1bi
	Jqj6FeT6TxJuGKlzeP1L9kSjqdf8q+W9IP55qKTG6+NM923WF8L3BDmH6NKVQ9otmt2hqeJRD30
	aVS4cnll4zBH2bpOBY1qogA4pgCm6b2i46kb8jUv4dxB4agYUJ6VV5yyMpAk6mD4jj8uW0PgObN
	jl6SA1ByjKuXVl9DdwBUABNpJA8VHVwQLiYKMgNuRyJoAxzEIZBAye0PBe3j1qgB4+xw1YK8gIH
	r9TxhsfLPY31L2+ZBTMx7rgYK54C6kDjKu/zlRkanRG6+Rhb1X/SlTPMXWpeHX0nzx90cy0SeIf
	b77w=
X-Received: by 2002:a05:6000:460b:b0:493:2eb8:e7fa with SMTP id ffacd0b85a97d-499c888ce81mr7051233f8f.43.1794464838079;
        Wed, 11 Nov 2026 22:27:18 -0800 (PST)
Received: from andrew.office ([192.145.132.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4982eedfb36sm14820585f8f.0.2026.11.11.22.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:27:17 -0800 (PST)
From: Andrew Gaylard <ag@ffroot.co.za>
To: Lee Jones <lee@kernel.org>
Cc: Dvorkin Dmitry <dvorkin@tibbo.com>,  Wells Lu <wellslutw@gmail.com>,
  Linus Walleij <linusw@kernel.org>,  linux-arm-kernel@lists.infradead.org,
  linux-gpio@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH 09/10] pinctrl: sunplus: Validate pin_func index in
 sppctl_dt_node_to_map()
In-Reply-To: <20261111215256.1982044-10-lee@kernel.org> (Lee Jones's message
	of "Wed, 11 Nov 2026 21:51:54 +0000")
References: <20261111215256.1982044-1-lee@kernel.org>
	<20261111215256.1982044-10-lee@kernel.org>
User-Agent: mu4e 1.12.14; emacs 30.2
Date: Thu, 12 Nov 2026 08:27:11 +0200
Message-ID: <sa6se1636ps.fsf@andrew.office>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Lee Jones <lee@kernel.org> writes:

> In sppctl_dt_node_to_map(), the validation loop checks that pin_num is
> within sppctl_pins_all_sz, but does not validate pin_func (bits 15:8)
> before indexing sppctl_list_funcs[pin_func] for fully-pinmuxed pins.
> Check that pin_func is less than sppctl_list_funcs_sz when pin_type
> selects a mux function.
>
> Fixes: aa74c44be19c ("pinctrl: Add driver for Sunplus SP7021")
> Closes: https://sashiko.dev/#/bug/linux-977252d6-b0cc-4d3a-ae2d-59d1e2f8a649
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Andrew Gaylard <ag@ffroot.co.za>
Tested-by: Andrew Gaylard <ag@ffroot.co.za> # on a Figment Design HW84 board
