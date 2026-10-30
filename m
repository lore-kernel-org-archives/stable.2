Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347588;
	b=hxaNpuSnD+JIpwofSilCee5o1No+uThBhSRt2HgnjqVzGFOLm244LLNHi4QLAjsLVR/8
	 cK79HH0DoQg63RrRfi4XlwKvUgPZMu7t5mIuiP/HcqwZyqzFvfBst7XN2FE+V6ZQ05Znl
	 3aOxoMsamfVltAnxhKbpkqcurwLhWjqM6Gb5JW5m1IB2YdNIw+NRbHXZnfmTw2s/7CAuM
	 ujq7EepEOKhiICnA21DN7kYbJtQrwh0iCBlx7TkrdZ10SmPImic+k0IWakwsmdIou+Ojx
	 +A+dqE+ea0NSh3JSsh3hN8604sEdUUeQNFz0s3Flp//hy0OODQeMt0/Z2YvJLmKbDGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347588;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C2ZirJKo0vypwPPLrNmCiJuDTnWo0nBD9fcFZAsttqI=;
	b=wnYzegyeU1mZteCABGB1jjPRg/clVN8sl7hPv5598qePWzqUMyJmoEEsNz2zB9+sVzXF
	 XtxMGkBBMGvWt5LgrXov+PgOqxtL7GQU+3+35hYcC6yIy4n3r+/cnQfRMT0HOpphoS62n
	 GUXZv3a3Qiviaj9xnOHYK3EH7tQbKfzu4Q9M+/Hkz+aBQz12krn2TxA5XLeBybPoc64mc
	 GhrOFRYtk8pwY13vAsk6tFrIL0sEv2V2j+EYw2xIy3ZqZAAmNuIzGGENn+Z6tHx6ATnwr
	 r8vuukAVu+iCpoNq6DDSMlUlM74h/YJ9geqOCFWkK48ha+pny+Q6pLRuAhYB1YyITww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6s7p5xB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B3606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6s7p5xB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B841F00A16
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793347587;
	bh=C2ZirJKo0vypwPPLrNmCiJuDTnWo0nBD9fcFZAsttqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n6s7p5xBjOVGRmpnwfG72OJ0wLBDRXw2umZ1qOI8xmzj0xuBovVTUWEbSFN9oPcu1
	 n43di3H+dhghtblDmspmXjL9YdEFQBE2W37319IHlLS0T/a3ztIpKgkGIPH17tS/XB
	 9KCXss4Ry7Bn1JXUnUXx9fbatEUTa1kJS83ylxkd7KvZM9tstakVE74AbzPzSYSCPQ
	 hGTYjsierdY6dC1hnLohDTzGKAJVfFWs4yfchgriLW0U0NN2cc2UcdzmR86Dq8+zlY
	 F+6WEW0Sxrp6hN4lg393xIW0aOwD8CFMY4M6Qz0Je4zD+X4+Tv+MpNr5lDwkRklxi3
	 XGT2NWN8nZnZw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6de1fd5f572so159664eaf.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 01:06:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxSidiJRWAdeOsSvBZFSMKhr/sYh/U5IbYdNDTVI4K2Wio06M6p4U9gbaa5VoPiCuYL9JdRxso=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKf6V2KwFpvDL/E//hfDl7jsxncwOt0ulF2VWQmdPTUnwKZfu3
	oRa9BDeMdTPv6GWPVE8K1w7R34QuTvGJJO2E7NgMimrNsCMoCqYrswEudFro4Urh5q/5kymu/Kz
	gBs7HUtjRD0uow1eOxzZCVtnVQ7sDxy4=
X-Received: by 2002:a05:6808:11c7:b0:539:dfe8:9960 with SMTP id
 5614622812f47-5640de0f2bamr1134379b6e.56.1793347586555; Fri, 30 Oct 2026
 01:06:26 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028182934.2236310-1-edumazet@kernel.org> <20261029153539.1224463-1-wang.zhan@smartx.com>
In-Reply-To: <20261029153539.1224463-1-wang.zhan@smartx.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 30 Oct 2026 09:06:15 +0100
X-Gmail-Original-Message-ID: <CAL4Wiip-ejpT=8bswZBYM1DE32WhJ+cbhjP+N_EnbPtcFRnjFg@mail.gmail.com>
X-Gm-Features: AclHuK91IS9jZ21-erii4HBfZqZ3TIi3m-ItxwzPgKEm_mQVTWJaDnsYN2Q2QfY
Message-ID: <CAL4Wiip-ejpT=8bswZBYM1DE32WhJ+cbhjP+N_EnbPtcFRnjFg@mail.gmail.com>
Subject: Re: [PATCH net] inet: frags: limit the truesize of a reassembly queue
To: Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	stable@vger.kernel.org, Kyle Zeng <kylebot@openai.com>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 29 oct. 2026 =C3=A0 16:37, Wang Zhan <wang.zhan@smartx.com> a =C3=
=A9crit :
>
> Hi,
>
> On Wed, 28 Oct 2026 19:29:34 +0100 Eric Dumazet wrote:
> > @@ -510,6 +513,7 @@ int inet_frag_queue_insert(struct inet_frag_queue *=
q, struct sk_buff *skb,
> >       if (offset)
> >               nf_reset_ct(skb);
> >
> > +     q->truesize +=3D skb->truesize;
>
> I am not sure whether q->truesize should be cleared in
> inet_frag_queue_flush(). Was this intentional or an oversight?
> Although this does not affect the fix, after reinit q->truesize includes
> fragments that have already been freed.
>
> The call path:
>   ip_frag_queue()
>     if (ip_frag_too_far())
>       ip_frag_reinit()
>         inet_frag_queue_flush()
>     inet_frag_queue_insert()

Good catch, thanks.

This was an oversight: inet_frag_queue_flush() should reset q->truesize.

It is harmless for the overflow itself (we only over-count), but a
queue repeatedly reinitialized by ip_frag_too_far() could eventually
hit IPFRAG_TOOBIG for no reason.
I will send a v2.

pw-bot: cr
