Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794154756;
	b=EB32WB/pcscBKhSYU/wkkPWWITi0AkWLtdPI29rKXufuy/UxTkeWdgrR86XucVvadiQr
	 x2Q3aQIPuRu2X+lQNvTJ7YshscAM7nWDyAgcAMwYLTnlDiCO+isVPO22MLiNpU+ENyjhu
	 +jF4p1qjvRzfbEddmTVVtagP0iYtDdL8mYWvz9UlhUS8uSgRhZD6vz3ASbC2wdjP2JMfT
	 D0OfSAWL0fNa+06INJfQ9N8Lmnz6r+VfZKgpjhiy+krg+L3jhTuBRQjQSNtEb1QW3TQbe
	 0OBLt3g1U5bnjaXnkrHtdMrbwFFI1JaWEeZBk9TxaC/QJ4Fjzs8R3FiVQ306BxXEknQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=et3swsdOfldP0ujJDRmFWaImEh1vX8VO0MRX9DcXPOI=;
	b=fzHHyfM3Bd3OS0T36PpWimVdCOMZSRoz6awNunqDfKDPteHnOEjQ4/Ec9C3KN6fPRDRG
	 0g0yEPBX+J9DhdTFLDs/L8QHA2k0yB+jmiwvaHEf3i3QqKyO4oe+vlSSNkHrBzUIzeOSe
	 mE+V4rG/QSI+HGj0J79AeZyqVY07jjUCGuqAYY9MxKi06EDCz91nWRnZnCRUDPjFOgx1m
	 xPkmVdqyp7hiIZgahnLalvhFX22pL7WR9Z1Rpu3txYB/LOUkMv3EOY3QY49MY5YBsjBcp
	 6i8fA4HNqGz6bqlkZpxZRYrmEX78QqVsgs6wl6u2BPoui1H3V/qVdzBtNRAuCEhYxnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=UnHJPzGX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF73606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 16:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CF73606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=UnHJPzGX
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4682977f9aso18173266b.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 08:19:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794154754; cv=none;
        d=google.com; s=arc-20260327;
        b=kblUzksaWrcOxEiJIzQzl0gTRYCD6LmC3kiWkY6nTtW4mWMrI4u32CCtg/gdXy+bxG
         mPwkxIjZNYfH9H2ri4WHjNbkraq10kA0wgO4UtWrL2mPzqcj/kfrQVPDFX+Dd3QhqBZq
         oDpYf9hZBUftguLpAXg9S5aO64DZyXZZmIUwEUbTACR/HsN+DYB03YFeO2z56RNeGugf
         DLZd4+0+bCDZauyY1swBngufqo4HLj5AOwog72QPmenXXDanYLu2h+92h1XVWdqhyajM
         vrLJde7rSLva/rXPZqmG7GFocMoB9rF0bf4mLutqjoqasehlWtKY4kkRISVCKBNQQSlF
         qepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=et3swsdOfldP0ujJDRmFWaImEh1vX8VO0MRX9DcXPOI=;
        fh=X/7NwXo0p7k8WKtoSJUxPcrcSya5flhqnX3zMpIW+Ig=;
        b=AlS6WZhkESQG7+Ye6i9gxtojfC31K1xJQBj6uWGC6SBkfjrma9CGgBFPMSoc+Kbri3
         Jec5UY8D12XxwnMnpp02Y0y+crcoKWRPbQEQbXkjahU7jwusvgikUjJ8IYS0JJ9JaxuT
         IrvyV3g59oWH+y9Vho88iyvM6Zxwwm5HJmP4uKAN37FGcxzjvdxdkuFWVvshAWcRujeW
         qn+G2Hhi05mV412uQjM0fP3hOoXPSrVhgKeO0v3ian/HxX9iK85G59D74PKFYR2u1IzD
         HWhRQEDPI/POJ8VKKVBTUa2LEuyXqhm8n1v16pPra8LfLGh88E4ah4B4sZ8pcUmLixjl
         OUQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1794154754; x=1794759554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=et3swsdOfldP0ujJDRmFWaImEh1vX8VO0MRX9DcXPOI=;
        b=UnHJPzGXqtf5M6DSoZKrR6UHFBMfoWqYMQ1Rv17g7fWWT+sUOEqe3QB3lY70652EHs
         R4u9V0gcMFrFvvSx2428DKOdXjulw15zG2Gy+Qfh3Tw2JxCfbPsye6YS1qby+4Vh/LcO
         Xzdrbu808uhG44B8h5piODGDrpJo9JOx93iFfrb/IqbcGKOeWlNJGCJ0hA5eBs0PBuPf
         gCPhGndoxAT6kRnicgZ706hl6Gnyq556H8teishi0UUNNcmQmMprjdC/vEt+ztlS80Ks
         vDgdeb3d6MYYHH7yqg4ylxT4o6vYu9P0xtrKBd0wphb4zuKRPhhIaLnZx88GNjKCbx1+
         M+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154754; x=1794759554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=et3swsdOfldP0ujJDRmFWaImEh1vX8VO0MRX9DcXPOI=;
        b=TGOOpbyX/9oNRB00p2f1fFfszRtbMmLIgBcWYqIECOrhMOYRfXJn4/6g+TvdbaUFGE
         x/sFpt5/irfHWSfaWE33VzAj/EeR5ojJ9W7GgWBBZg1hfNVj0ltXywO3kDh/XVHffJUT
         4N3cSHIcYY7OLFlIR+Qu/8qvej7jQOFKREtpZfv0RDLuiRMYnem/eJNeZ5w4xDK6stZ+
         m2stcxUDjp3q8FhBE0cKg2HgJns+4RVPOwZbttsvedMrZhirshhpP/c0LwTXjjTbsp0c
         GW032Rlz+sQ/Qk73SqaSmg98sm41i6ln0SqAS7WlzlRvAoOCPrfmNfI6IiHHVVJQWV6L
         zm+A==
X-Forwarded-Encrypted: i=1; AL+hErHHK1RLaEYYEgpsLZlCnuJlypQ4hxDcg16Z1evePycPeqE1ixTlAmbdGi0FmJiyFnp81GLnmmQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pr+W5nc8wrRhek6pbRfI2UWqV6bZ7zSN5trqBUB3K9jUZT5DN
	1TOVmHGlDZgNvkGO5YK8ByqJ2uvrm869MlCeMftHnD1JacdDm8+1OIlS4ceBm5N+WXVpB8l0CTX
	WaZinGmGuNmu0gUAP5Yq/6uR9NHVjhXqdSyW+21FQ
X-Gm-Gg: AYBFou3EPFGuS92+t6kovWpvNYkB4WQdeNxSLf1hHmxWLmNpOR2YQbFbPIrnCEaTZKM
	5rRKM4wwDb69K/ferjlynkLMQxnx8ZRcllMW5vE0CwH1NEZ97v4XAQGGMyAlRZXSFBkn/PoA8QD
	YixubsEPhvlj/xqdUCGuWWUwBlyFGjMHUP7yZIblzGrQYa4j6JWOX7z/McetCpNga+2lFaFtjpe
	X6sEV1kxWXEleo0X5MlUrQJjIbKlaKCNukXYO+P5H7rXFIZiQTqWWVS66GIafh7ws1x0XthGafG
	4JEp71X4rStP9JAAQ7wq4i23TERrK1bLFzCuH9HRp7nm89PSf+nayy7EHiGXC2eTTYPCtHOD8KL
	/vTWIxMpf8DW5nUjYf8i0XsRQv80cCwM0bRiutwL+Qaxh2p5f5TWR3VpWLdYNIBwofl1or/ds1H
	Wb801YLdnNGReKGWS8xg==
X-Received: by 2002:a17:907:3f8f:b0:c46:7ec3:fdfb with SMTP id
 a640c23a62f3a-c4d6d1af6fbmr112340366b.7.1794154753715; Sun, 08 Nov 2026
 08:19:13 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107224733.1104094-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261107224733.1104094-2-Jeremy.Jean@oss.cyber.gouv.fr>
From: Dmitry Safonov <dima@arista.com>
Date: Sun, 8 Nov 2026 16:19:00 +0000
X-Gm-Features: AclHuK-RlKB8cK6nkN9idStz4fDt7ECu6dP4yCWsCwUDnlTQSNjJu1k9KvIrby8
Message-ID: <CAGrbwDQFY8gBtEKi2RaSMUSEvLLVADspgoLLppwNt5XQgd-hxw@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: fix authentication bypass via unsupported TCP
 auth options
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 10:49=E2=80=AFPM J=C3=A9r=C3=A9my Jean
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>
> tcp_inbound_hash() parses both TCP-MD5 and TCP-AO options when at
> least one of the two features is enabled. With TCP_MD5SIG=3Dy and
> TCP_AO=3Dn, a packet carrying an AO option reaches the disabled
> tcp_inbound_ao_hash() stub. That stub returns success, so sockets
> configured to require MD5 authentication end up accepting
> unauthenticated data. A forged AO option skips the unsigned fast
> path, which is the only place where tcp_inbound_hash() can return
> SKB_DROP_REASON_TCP_MD5NOTFOUND.
>
> The inverse configuration with TCP_MD5SIG=3Dn and TCP_AO=3Dy has the same
> problem for an MD5 option on AO sockets.
>
> Note that TCP-AO depends on 64BIT: therefore, every 32-bit kernel with
> TCP_MD5SIG=3Dy is in the vulnerable configuration.
>
> Make the disabled stubs reject options for the unsupported
> authentication scheme. This matches the real helpers' behavior for
> sockets without keys. It also means that kernels with TCP_MD5SIG=3Dn and
> TCP_AO=3Dy now drop segments carrying an MD5 option on unkeyed sockets,
> as kernels configured with TCP_MD5SIG=3Dy already do.
>
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>


Acked-by: Dmitry Safonov <dima@arista.com>

Thanks! Nice find.

I think TCP-AO patches tried to preserve accepting MD5-signed segments
on !CONFIG_TCP_MD5SIG kernels and AO segments on !CONFIG_TCP_AO ones.
That's why the default stub was to accept the segments.

And I prefer we don't add prematurely ifdeffery to tcp_inbound_hash()
as long as no-one complains on this changed behaviour under kernels
with disabled auth options.

Thanks,
           Dmitry
