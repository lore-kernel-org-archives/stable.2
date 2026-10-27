Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793072636;
	b=eSeOSpKtdRvtFKRwAPQ0ODSe4L7UdqlhwOhJBTGgKoHAX+8x2gpgHX3C6DjrdQZv6Gho
	 DAPnwIQ4Uy8miHkcw0Pg3LjhhnZat+bGYD2xORJ085vMxjtF812t4IETYPJleHss8oE2K
	 ASy8Ua8pT2cB4B/idS/VHcpx2FgqVnRSxXJYOLd8qBkL1BM6P6sXWvsQ8w69vA5Q4CvX/
	 a2I4PiGOC2QF3IFOFqT8LlyQe5DwGtaVSszsJf7G/3irqpY7L5h79DWUeiY8DhVExQqYS
	 HxquPYuV+NlpYbgfdvE8cTc/fzA3mUhNDLadXqUvFWE/GOkNQ+ErOk7PkoKQbDV20CQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5qKxJCbfRdRrH3hTlJ0h5gJEmaH0ng7PGOWlvDUhXUA=;
	b=s/Ov/M1DGwPGGQTq8HxgYAqIEMuVM2Ltu2r70HZjLLFPbgFgQShdYJaE1aKAOysqm7eq
	 6EBsJH7smZwFU4zfpqYQ9g2FeE42Le/s3Hex+Eq/MQRqRgQQyeG8C4QTjf49U44RccEDA
	 fzPJEqH2uYXSedC/oGnHR/jB8nn6ROInbGWo+lew2GScP+4jFw1tkP2uuChQ5z1Scw5+U
	 s2TKQJtXNrUBeDixeU8TAB/I4sr7VbpIhbKMPDOS9A3/O/Z6JKHLq/DWiaEVIU8V5yth0
	 UsaLTY6DvF8/CT7u5Q+CuIFzSJco0y3LfCZiXoC3flzV9/01tumasqD1+GVzavo1zgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=Jk9klGgU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B36606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B36606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=Jk9klGgU
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso5272691a12.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793072635; cv=none;
        d=google.com; s=arc-20260327;
        b=gC4MuAU6vzxZuYIDpvMNli03JNCxc5s82a3HGY3ycgYv9QZLPTyL+awHYbvMpdTjbY
         /3N9x6SPMlKCX87KJfThdlgFzQUhaCKxAB5CDtr1rBe+GtWicE43pconS3tPK5mbJCms
         nq6qCZe3rocEUIAJfSMFurjUnIusYi1Z9ZcxFCszgtN5CN4p5at10MoDWgEiMzZobE/U
         2MxKYP14gdX5nOVIFVBoZyuPhWR04O1Kr8k7jp35vWu8A8TMUj5FdVM7V0FojaIng26k
         4UHpozeEFBHDr1UfFlhhUYhGxIf+M6p71HFXjLwQ6Ain//aX8af06SPWbiUU4EKMsIMj
         MFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5qKxJCbfRdRrH3hTlJ0h5gJEmaH0ng7PGOWlvDUhXUA=;
        fh=ryzd+ijsfKdt1uCqwTwi/PZZFOc6WMv5ztnfND3qQ9Q=;
        b=gMqEsBTTpaJ8mxP6cnTRE5oL3p6oOXcFV7qKvLW1/AcA9/ZX19zQg2KTK3LIUODbBS
         zlUTh/u6leuzrQ/J+KlPv7namOmA5C02lZcua0KV6Gq/MbpUsOLbNgB74gbzZiD2Nvy4
         EEb6c00ne2XJ+HKA34XkGyn70rlWSrj8BMzdNQXHp2JVJcC+wU8PHUlKbqyLCut190X+
         HbpU4d4f6jX/5KY4h7OIkDwANOiJbM2MBTxzwOdRPfXAinvmCmRaOtQuGAbIKGuEICN0
         352cJEsm2CXzq2YRHx5MKV/g6bQwN9RyW6ZGAFgLr1RHKiBVmBQ1H2dbdfVgrR8eQxf5
         argg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1793072635; x=1793677435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5qKxJCbfRdRrH3hTlJ0h5gJEmaH0ng7PGOWlvDUhXUA=;
        b=Jk9klGgU8GCrKZmkFhs0ofHkPl3C52FsJVCvOYWx7PjTj+kkHRZn7BK3ECb9H4p988
         csjhO5vqCOnHyVq16sNPNfgZl8cVYqnLVh4+/AHV9f3DE9YZvzU9C2PAdvtWZLzVOY/A
         bjIMnQcvaPVD1Qts2AKCN8ddA2CkscjuAuKsphVYQGjG1qBF+4x4CVQzzI3Job19LEek
         z53oj2K5xfKsoaROJGrQx6CkAoA+fDmIuqWeUEPVFPYyr4U4NFnyuVYmRZ+i146NycjI
         BdJpjrCCZt+2KcxGL81Wg1AiMeSmTJYKbQaHv+5d9SMe5vII742HyniZsixYbPk6IsCs
         M1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072635; x=1793677435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qKxJCbfRdRrH3hTlJ0h5gJEmaH0ng7PGOWlvDUhXUA=;
        b=BXShjONP5zOdkR+4z8TZPgWdX+SS+AFQrsdxGqPB7xIqZqX4fUvIlGqzqrc5fKi9gz
         eECv9hry737/WRiNWKy5oyKJUSPcQ+zeIhzQqhOMvumwZg3h7aBCsxwwnMcYAGnLvj2v
         fEh27uSBJvxRmtB6YHbiO6A/H9eRNgovlLY5OlLmEQix1Y1J9bJSxkyWhMGS2z53ZWES
         3Amckj/mxVBxrKiuRhYqQij4B5juAYT1LoyCAibvjvg2jWEFNmsRe8MLvFskACY1EdpZ
         VywKiCCK60rlONCatkD99RzywWelM8002U11jzd1nK2PO6kEQl4ID4HImXJ6LuiHm6db
         bLNg==
X-Forwarded-Encrypted: i=1; AKwUvBxGDYBw8oKhBq4FnDcM/EDG43rQHZcuif8e029IO8dH8fYYTkyLvVgJ5hr1X0+nQVVgDKRhPzU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2VTUR26fgVOZp+/Wuw9BN0QQ7oayX9lZJRNY6vGAFu22Qbtd5
	yLywmrE95J1L7dw+1VzGqwSRWXjbzzY1NRwjGMC7xbPiAouQQzk30ygdPm4HtJIfgHn3yv6NAE1
	5E2Zh6Wz48J9Gr2AkXRc4HU8yVDVmTyRtoyAYSO4A
X-Gm-Gg: AYBFou0TF8eCcumWTLTiaM9yTA4AMliogDNab5PV5xgciXBOw8L8F76BGZVBILn8G1Y
	f+783WHpu3Mhmu8mCmOZSDG9DTGTAj0b8wrUnrXbspQqjLEg+Wwk3N9bYPIfBFhGEn5k9woqb9p
	dVLCHfyjfNq5lEppYb329nAxmcbOVAFKEAdE8EGLVw4ArEEGKnaxLXqjIoYmgBE3DBimDqHEtq2
	NWKu/kq7lar0OJr5cJu15ZQe5Gf9VIXNPl8MtqgGDkDuxLtHQlBIKHsxI2D0FZj3ScEuKL7WPez
	aQzT7w6PstQdG94oeBsikodjKWaNWWT6HMRV+eebXZCcgcBmEqcM3BYEKgwJZLBtBuol9l5KjOg
	d5CMQtVWLDzwODWo2XCNjM/tk3JEqGegnrEfRV8MGV/h4zq+rW6fTW3a+tpzMyvb01CU1+A==
X-Received: by 2002:a17:906:794b:b0:c42:4750:8d49 with SMTP id
 a640c23a62f3a-c46bde3aeeemr1002596266b.25.1793072634757; Mon, 26 Oct 2026
 20:43:54 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027024635.366900-1-prasad@arista.com> <179306948792.3327.2977782192715102568@kernel.org>
 <CAKh1g56_WiP3gTMbcWkukb_tK9Fnun6NqLAQKWdU5o2ECL0veQ@mail.gmail.com>
In-Reply-To: <CAKh1g56_WiP3gTMbcWkukb_tK9Fnun6NqLAQKWdU5o2ECL0veQ@mail.gmail.com>
From: Prasad Koya <prasad@arista.com>
Date: Mon, 26 Oct 2026 20:43:42 -0700
X-Gm-Features: AclHuK-1EqxydWR_WSLPmaEW4heYYjA6apJgh5zMMaiBELQB98cyhu7hOmmOXQg
Message-ID: <CAKh1g54bKZYQwyAS_t6FSOfZvt0Gn3gUWqnwg+6Nv4qTT3C6NQ@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: fix allmulti reference counting in passthru mode
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The issue was observed during development testing with 5.10 and 6.12
kernels. It was reproduced on Linux 6.12.68 by enabling allmulticast
on a down passthru macvlan, bringing it up, and toggling allmulticast
off and on. This triggered the =E2=80=9Callmulti touches roof=E2=80=9D warn=
ing.

> On Mon, Oct 26, 2026 at 7:51=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wro=
te:
>>
>> Hi!
>>
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>>
>>  - How the issue was discovered, e.g. hit in production, hit during
>>    development, syzbot report, manual code inspection, LLM or static
>>    analysis tool scan.
>>
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account. If the series needs another revision for
>> other reasons, please include the information in the commit messages
>> then.
>>
>> The evaluation is done by an LLM so it may be wrong, if you think
>> that is the case please reply and explain.
