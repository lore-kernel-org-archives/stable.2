Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793204828;
	b=nkzHqWYMiQdsyY5mbz09cPVcWMmnnyU54ggP9JoLRq5HLZdWZbuqXfkjp3F1/1MrjMFM
	 MwZGrTg5ANt0+kBsAqoNGbh3MQxaO7uZlIUcee8rq0SGM3Bm86d37DPkY8XZWjWf8kGvE
	 tE+vHfc4f71J5Aa+EFFqeul6QhlIyyEiU2Lo82rbYdIhDnFLN3oJyJlM0uXncf5YzAF86
	 2J/1C/15iT/XJo7JQQGrnxSrw65z2CVxlfzhE8j1FtG2mtfZkvvOnijbTvzPf0pnH37d5
	 u0su1wOw6+srQxXvFubqDibGf/7czyyG+yNzSFihgfgpHkPIq/QAr/EbA86vGcxDMOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u/BKt/NLdxmOPfR6/Fh72TlwAgDRWWRmsiL7d6srOCw=;
	b=nKWuhkblI0xDrRdTFWOJIsJELcMThc1gmShA1rRAzsvpAb2kfQi5zbn1QFOB+/PlbMh4
	 uOXm7Vncqqneb7vCfees31Ow+j02aCRcZ9cnMvzSd1oGj26awqVThW4B8AT7J1FVeEW0O
	 vI3RHeB4buD4F8oE553y+vctXJLx++8b161jAZKdivEwKV7vxUcvaRYNRchkFXs+oT7d1
	 2JdyGcgUOV9fZPLv7OZRQtoW17rAjE/FRlOIf+ddX3OVGRTijit4RrfpglRl1Gn1aLjic
	 7q9DZiv6cKQShZyCasV/4g/hgyvywIcJZRusdqmU6OMBlhyZT6uBRcZ42qMz+KzYcFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UaioioWE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6B606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80F6B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UaioioWE
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so12058a12.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793204826; cv=none;
        d=google.com; s=arc-20260327;
        b=VYy1tW0Npd0Z7l1qlzpglsh4gAyzlq4rT11qOKjnMB2+lyUNueZtnfLnReaPeKbK1r
         wJWXh/VZBiuOGw+DtCB9GUTmF67MXVGFD8RvoqqeKlGjJnYxQFcZ5Y51yaG/kRE3SIdq
         /yRJh6LAgBUWGQy2VN3kZYxxepR26YrnydDQClFQ/0ACatQcTr3tr1nE0rKGdjQ/VeTG
         OcGYfpKHNXKJ9Uip8hhh3P2DAmYKJwTfFDq/MheDn7HA7sZJb5aMDWqQDEe50ok5Qnt2
         03qRFFBylJF3SbzviU88qAHizgfHy04pfujj9vfZgocqOluS/oY1Gmtw+713fiCq8wu3
         oebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u/BKt/NLdxmOPfR6/Fh72TlwAgDRWWRmsiL7d6srOCw=;
        fh=hBYJ/nbh/YbWtR+XwTqcHa5FlrsDaM6wqDW8T7Jlmds=;
        b=P76zAtD3qjJOkgFfLW9ubeh6PxT4cTeYSsRC73dFSGCaz5mEYuVsFP63KT6fHXQtPZ
         PRjHP8deogylFF34x15Sj0MjJtcQlOAxpYrXnBdAvJoEBFbXna8fV2dArgvxvb50jNhs
         0LEA2dJwrU/QxTUjB3e1uTIzNFhg+jRwBCmx518ITyAGJnSgRBptxB3Ja9IfNxN2F7us
         qJXIl/c1E5KTLeB04IYmPtxUrNv67aiqKHqxyVyekWKvheg6PQPsaDx2FKA5zmA6p2sy
         ipV8JTL/UeNboMYeWiqUvbeEn9GmeBLltb9uSbaIwleWXgfgIO8CgpFSm+v0mzhQTCBb
         M4tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793204826; x=1793809626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u/BKt/NLdxmOPfR6/Fh72TlwAgDRWWRmsiL7d6srOCw=;
        b=UaioioWEjjYNGTIHp8DvJGB3OxcgRAv+ZpIBH/xBuVGgEzpDmH046N/W1+1owmEp1l
         Xe+xnwQvWD7o2XcXq5ngdP8NQUShP4+/jcZlnso96hJc9Oh8RooarJBi1GbUA8pbkNj5
         jJtWGdgKxUuDccy3AvmoKspzxAkMs6Ezh1ThYC6mItK5S4p4/qJwuqQ3BhrFvWxnAncY
         VlcViopPRkE8rCViTl9PsyuNxINotVfn3WibDujgKKoQC+MR/3gOdWF54jn5OFIV+TCN
         sLnL6i15siEMlYcsOzROIFm6yILBZTwGAle3wjgeeG7VrwDoLJycipor4MSUxGl4IHiz
         IUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793204826; x=1793809626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/BKt/NLdxmOPfR6/Fh72TlwAgDRWWRmsiL7d6srOCw=;
        b=X+MGkurHSCa9C0l0mdjjWXxOtk7r3nHNVH5uoOc36vFQMeD8tOxdwnHqpLxAxTswlg
         LZ3Cb5MrJtxmMfBbzamTkPakg7Ts5A5R87qGkVoBgDdRXcR6o0fJLlKqq7GV1q7Jurfg
         xWaB9+G6lgrys+fA43JDOGF7una1zX41eV3LeyMmcl8lzlhPgJNTM0vKY0qmfZMluaaI
         W1lLh4AVF0oJcCtyhYd9YQ65PKC3xS6dAd2SxqqB6d9eiiU7acVY3fzPlQRb+/VjlEor
         6iBNiPKe2tFgkhWrGjfyA1oJngg7u56TUYpXf2loeqwwVUwZF/waXh5dhNVNcMTackAt
         Jq8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwNi8dmxkCGJfZ/SLXPB/mys+x+j4X80xwk+aP7iSQhC9OEQSzGX0OhLvKK2iwVvAjdnRWm0iE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuK+lA4UAGNbno+MPOz6CmiU+7tiBKAkbX4zgVPkfrb0J/Rbpi
	kIawwYGP9MDV8cfVXz9R+OOSpp6a42nP9cmpaorLBU5u9jEi8S6TEtiFremXqQXOTOOmvI/oxsg
	m5KEK9T3jBLX4baHvoE8lS4yOidpdbpr4y0LY+gVI1NmUO05V6ZZ1Fp5mgJg=
X-Gm-Gg: AYBFou03lgHaKDztcJmvfIyvAKf/3SKqXqYfnVqhxPHuRR2Nk6rxXByyNOAS3TdoOOt
	FLSdi6SgMO2gGxYMBKomIFMcF3zcGhRsam0MddUhxkmfWXA3EVWJxvQbpwCnP8yivGXWkZ9gYBl
	ldFhjSHf5kmEIPVzgB0S/h69oMzAUtkvS7XOu9s7OGVrsLFStpxrVCCnbxytAn491tpIsnBoU31
	7eqMW2Zs5Uc63e7BNfscPfO7iWHPCt2IjWL7FFnmaEdgLmiBSitWfZWleaR/KTfP8cc8btatCr5
	0Bsw42Q/7DxyRGUlqS4k5GlxHO1aIpaa7L5Ue9od2LVUtvug33VhJhXn8xRhnnzoXBd25idgdPN
	e5q9aHajDFaq4h5XBcM4ZXjlshLCF6nzLlWeBxaqxkNs3lH0jo7R2H3F8WhkmE44qP7cCciwsWQ
	GSfJlQYPz1wHs/mv5MBR1g1+giKyk=
X-Received: by 2002:a05:6402:c20d:b0:6ac:84a2:bdc7 with SMTP id
 4fb4d7f45d1cf-6b49c12bda5mr82863a12.15.1793204825348; Wed, 28 Oct 2026
 09:27:05 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028160226.2170244-1-edumazet@kernel.org>
In-Reply-To: <20261028160226.2170244-1-edumazet@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 28 Oct 2026 12:26:45 -0400
X-Gm-Features: AclHuK_y2lwU2dfxPHC5zpefWOEB9ROEQsLXt441lxysDlYZ1eijDbr_ZkGEi3E
Message-ID: <CADVnQy=Yy=3BPdxNesgfPUtpHT+R7nodcz39a3SCW4e+WcnwhQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix reordering addition overflow in MTU probing
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org, 
	Wyatt Feng <bronzed_45_vested@icloud.com>, Ren Wei <n05ec@lzu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 12:02=E2=80=AFPM Eric Dumazet <edumazet@kernel.org>=
 wrote:
>
> From: Kyle Zeng <kylebot@openai.com>
>
> Commit efb8763d7bbb ("net: ipv4: bound TCP reordering sysctl writes and
> MTU probe sizes") widened size_needed and the MSS multiplication, but
> tp->reordering + 1 is still evaluated as u32. RTAX_REORDERING accepts
> an unrestricted u32, and tcp_init_metrics() can install U32_MAX.
>
> In that case the extra-data requirement becomes zero. A write queue
> with probe_size - 1 data bytes and a FIN satisfies the sequence-space
> check. The coalescing walk can pass the queue head to
> tcp_skb_can_collapse(), and tcp_clone_payload() can produce an skb
> whose advertised payload exceeds the data in its fragments. Local
> delivery followed by TCP_ZEROCOPY_RECEIVE can then walk beyond the
> fragment array. KASAN reports a slab-out-of-bounds read in
> can_map_frag().
>
> Cast reordering before incrementing it so the arithmetic handles the
> entire u32 metric range. For U32_MAX, the required size exceeds the
> 32-bit queue and window limits, so the existing checks skip the probe.
> The calculation is unchanged for all other reordering values.
>
> Fixes: efb8763d7bbb ("net: ipv4: bound TCP reordering sysctl writes and M=
TU probe sizes")
> Cc: stable@vger.kernel.org
> Cc: Wyatt Feng <bronzed_45_vested@icloud.com>
> Cc: Ren Wei <n05ec@lzu.edu.cn>
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index c8865205cdc8bacea4e37f67eb60730cb17294aa..39803b874c3373ca635454690=
a445ba072c05a62 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2720,7 +2720,7 @@ static int tcp_mtu_probe(struct sock *sk)
>         mss_now =3D tcp_current_mss(sk);
>         probe_size =3D tcp_mtu_to_mss(sk, (icsk->icsk_mtup.search_high +
>                                     icsk->icsk_mtup.search_low) >> 1);
> -       size_needed =3D probe_size + (tp->reordering + 1) * (u64)tp->mss_=
cache;
> +       size_needed =3D probe_size + ((u64)tp->reordering + 1) * tp->mss_=
cache;
>         interval =3D icsk->icsk_mtup.search_high - icsk->icsk_mtup.search=
_low;
>         /* When misfortune happens, we are reprobing actively,
>          * and then reprobe timer has expired. We stick with current
> --

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks Kyle and Eric!

neal

ps: It also looks good to the frontier LLM I checked with.
