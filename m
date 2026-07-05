Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91413570AD
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278744; cv=pass; b=Mof3tfyOVCBZ8rerYsPEYL1lU/Z0jcpY3XYQzCo2AZ+2DWJM5VV/423+sF9CyAS0bh1mmYmv3OP+2IzSW4rFMRs+n6TENosYWTDdMW87OfecKm6SO5gjaZd3ZsHjfUQN7gi3BX28V/MYE8TNXm7LR/s6pMl/2KaR2LStCOuqIvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278744; c=relaxed/simple;
	bh=kzBIwScZkxmJaAbRIZn89+TPiZbPYudZb4JFa930OGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM6QsdKUoflmFRm4QB45kdSIdyVTwnGhSgrnntF6MtcQ7i4ssutQ94zABdYzk4J1xTp9SWfTrzieDPGAm4wc3u/e0d9IzHnzfygGMFL415RcbhQ6QJE+AR8YsHFGOvPMoYHjqTsQ+BheTmm4spQjyTanP8hdeGlBaEUHgQ+C3vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKNqQ7lj; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKNqQ7lj"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-845e363246aso2490302b3a.1
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 12:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783278742; cv=none;
        d=google.com; s=arc-20260327;
        b=Oue6jgNc8ibOUh96kzH81WEfu/gaQBQ305N+QN2VEeg9TYQGlG4KKR65bpt8rk7X35
         +2Td9IpJRgrKoAJc6Jcv4kIK7rSRP5eH3NN3M8NGVh6yW5OgqJ68bXJhRW3zvskVn9wF
         gMmU2Muaprsw+hDJUlIB1rL5W0MsQ93orsAbc7Ky2KtpxJxleEqEBifWJdtdg1q4Cb9O
         MYjaRYIZiuzIztPeIwdwEVaeCeGedgxmFFia4U8Fj0bunlwOSSWj/o1+OaXjB736L0MN
         WaGsXmiMRCYDZc2L+NM58iYXSNa7yRoQHYTYb6nGFHXh1OgeUxsQ2KpwlfXBGtlUCYFO
         znQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HYplnZoZM9QLJ4q2m4G26mYUAV9oJQFImSbHJW3ZRgs=;
        fh=ucTTNU+yRopHeTc7ChXp3P13KOuQ9WRg8of4xhBKIP4=;
        b=ULzru7O/8BXDj/qNjhfx8H9pDQMecCOujVo/srhDc78hK7KAV0WB1SFMZWxonc3QKr
         CBZiLxfkuLWRORXmRmmixf2rLB6gNaPvF8aYjsyKJspX7yphMlHBxGw5sFhweqVsgcBc
         1RvtPWuSf+8ngb00CIt9ECbzBSLpP+3DwdFSf0310eTbcAs4vZ8n5cjNcE3sDLC2TUeT
         9nIiLPsdHyrlpmOHZ0SN8JS+5peRr/73E7e+u+P5k77g+T8p067duDh2eBoM9UPPttvC
         FuWm3c1h9XwV8tvEaMbxZ9k2iqu3fn0mS3uHvv+tX+oEiRhK1gmyAJxf9DocY4XioKDk
         zckg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278742; x=1783883542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYplnZoZM9QLJ4q2m4G26mYUAV9oJQFImSbHJW3ZRgs=;
        b=lKNqQ7ljm0Q2s+uh5ZBmKjNi6BfodIrdl24723FeBhzQvFumO+GY0kVFGYH8mMU1ra
         Y4rR0pmxeLK7qjOinA+wYWkM9Z9u5d+1eEfve5Vnvc3qLc5doWdrqLCeUJxhO/9uwHbB
         puNO3wiY6Nf+IXn+0jYXlRoCaqL/zeNI8dv9mPelgESkhGkuH58N0mXDjRSIb8p2jaOB
         XMusjDqZnGCHeMbkWdLjm8lVVQKFYW0lFTvvrOYoDrxIkXkEHd+kYpT+WoEuFEm8+9NZ
         2xcjdGDNHa+RpUjrm2WYGdvahUBdCI8k6gNSBahham6UsAE7uHtEbS0ot4k9clpeK6X5
         KQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278742; x=1783883542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYplnZoZM9QLJ4q2m4G26mYUAV9oJQFImSbHJW3ZRgs=;
        b=e/z6tPmhFBRPAFgwO1R9wkz8GvUbyFAk6hEudmw2i3RJtroEBVL+35aeKOU94L7BPr
         2Hfad1nFW7+Cg8yU+M3cxf8QYPGNIGolHoLsQp8b/VP7cnXz5Sgwbf5+h9iOaNgLjEnI
         wGWXKOZw7MQUO8zrIMyVwCTJAGqkFm3D5L/4wcChmOiPqwxLomEyYZGByJMWhZbYfDf7
         2w0swbpkR8ngQZf/5Zz6AcVsACXuhsF5CHGw2otDm1bbh69p5U5bFn8VCKRfHqiRc1jy
         e1pKm1s9YC8Kxr78yEo2K2dqm+DTax/FimnAyyIyV8bU9of/taEgRJ8qcAAeVbWjzEXL
         iNWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVrLfZgEqPj1wOfFAKasc/sV4T694P8VhiP3QJ1MP/T97hC7IA+ti0dkGMIjxqdcxSIi0gtGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVOlz6hZj1w1k+ynx3YVNpi9zIph5pyXojwJBNh8l/w2Xy8UL
	qQwanITnNKKY74i/G6d3xqA/ckutta8QIJg6/BVgWOWvCzy0Lez2KWx7JOd8jaqViUNRM324CG+
	EstPXbrRLZyPk5K1iYoN2BZPpGhZ5HzI=
X-Gm-Gg: AfdE7cla65MKNKAAQhmWSIe3UURxfGZj4KfYXnWB/My6i5Qg10eXbsY8nSJSja+HC6p
	gNjUkpQF0ZixwIf992pbrF+x/GOtCgJ3/aJ7piQw3RJqzYXvKae5ANDplSwKOsKKKvbJhksLFYZ
	2Wr2kI1Fy1KWdI50OFCFUKrSZjT1yWGdOkhDBu3VFhA/zSu+lY86YsoZjFt0o6vFUOChi6IeGhZ
	7xA3ORamuyvNuC0RzCoT0kJRCP/PuA2sqaio5Myrxhd3hqbwNMuW3k+/7F/hrBuxlfXGK/E/8wP
	riqM4XBB8dQe/1DscMuuZH4Kx5wzTtwhro4bZ7SvAuIxZk2Wxg9DubA58pF/6K4AYnGBgcTEOw=
	=
X-Received: by 2002:a05:6a00:4b4b:b0:847:77e7:6f6b with SMTP id
 d2e1a72fcca58-847f6f96baemr6642867b3a.59.1783278741837; Sun, 05 Jul 2026
 12:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704033545.2438373-2-bestswngs@gmail.com>
In-Reply-To: <20260704033545.2438373-2-bestswngs@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 5 Jul 2026 15:12:10 -0400
X-Gm-Features: AVVi8CfHA-j0EDc3OlrYh1r7n_r_L9jvhfkZenL3RS3ltcoq4Bgp2Uu1c7Bg_Sw
Message-ID: <CADvbK_eJ+qePAuDF0u=rmQ2brixwmxhJRrUHi=jnbWoh169OfQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate STALE_COOKIE cause length before
 reading staleness
To: Weiming Shi <bestswngs@gmail.com>
Cc: linux-sctp@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 11:35=E2=80=AFPM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> When an ERROR chunk with a STALE_COOKIE cause is received in the
> COOKIE_ECHOED state, sctp_sf_do_5_2_6_stale() reads the 4-byte Measure
> of Staleness that follows the cause header:
>
>         err   =3D (struct sctp_errhdr *)(chunk->skb->data);
>         stale =3D ntohl(*(__be32 *)((u8 *)err + sizeof(*err)));
>
> err is the first cause in the chunk, not the STALE_COOKIE cause that
> caused the dispatch, and nothing guarantees the staleness field is
> present. sctp_walk_errors() only requires a cause to be as long as the
> 4-byte header, so for a STALE_COOKIE cause of length 4 the read runs
> past the cause, and for a minimal ERROR chunk past skb->tail. The value
> is echoed to the peer in the Cookie Preservative of the reply INIT,
> leaking uninitialized memory.
>
> sctp_sf_cookie_echoed_err() already walks to the STALE_COOKIE cause, so
> check its length there and pass it to sctp_sf_do_5_2_6_stale(), which
> reads that cause instead of the first one. A STALE_COOKIE cause too
> short to hold the staleness field is discarded.
>
> The read is reachable by any peer that can drive an association into
> COOKIE_ECHOED, including an unprivileged process using a raw SCTP socket
> in a user and network namespace.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Cc: stable@vger.kernel.org
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Acked-by: Xin Long <lucien.xin@gmail.com>
