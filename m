Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795473523;
	b=OZuFO1rQmVbDCcT6C9PSexxGLSx2s3plXLtcjtl71lKzZavEmE+zSgC1E0WF3eBF/FDG
	 kVoiMua/bmtnElC8hYfFAw/9i4NkXeas7qZ4guUdnpg3oIyRqOekPvN3UePx8N0ZToWwH
	 OeVoPwoTGgvlpdgYd+rLDnppRBNuuV3qJEuGii1GUyHxncjrsIroxZF5nejYIqMGDJVxJ
	 ktb8AC73jlfebgh8WrIyjVgS2zJHNiKu5O1iOrbuLZYYpFI5xOlNCrliTuyJN2/PQJAtd
	 kVnen9dH3nH5GXHC0ja8knXWIFtYWBokOavlCdJs+k7lHHT462y27sdHaaY5riHYmLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Cwh//GNxXkDtdeGWxHy4iPFypYSAhLQNf5Ufwrx4yf8=;
	b=2x5BdTxFPhztQqrRI3E4nedx0SmTv32zOoLNd9MYgb2M6A4cgqDPK2bqfqc2ip/UEgr8
	 38syT06XFyhuUperv2jnHoV+rxO7Ki++dXqp10LQy+fn0Ymls+NIz1Z6rtDsnH3ROF6/M
	 eIzHcPqunP2QpX9Jbn9Nb0MUqMQq0NR3bNPa2zA2njUrM1M3Pg8x6pMZunIeZ9X0+Ehk9
	 stA4U88wS+IoEs1Pd9zji9Kq0ktNn9T/wRUBuokHfLENbkf11tzJt5KR/XnT7FlQLhlXh
	 46MUOQuZ9wnnNWl2tfqY3VpM4kY+fcodoT/5z6EcJrdy85HQhCUE6YCljFtsY9tBKzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=zyiUCvTu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4C606A322
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 22:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5A4C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=zyiUCvTu
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ebf39def3aso1400919e0c.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:38:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795473521; cv=none;
        d=google.com; s=arc-20260327;
        b=YOi/yNnHi9FRS2faok8OunKfxft9eCSec+ca21MAYjVAU2Kk57vWHYAVw4wzd9D3O+
         0lofMViPCaYexyUCSFhjuc8hbXgf+ZKQ+/qizLUjV+NQCfHojKVf+9Q3GGOOAC0fjNfY
         h7dBi2sW96LpvHkyABm/PJkjO+5U29dSoiPyfrU7PRzBve4lfOHcIQpeoxqK3F4Ui1WU
         IwNdZ9tMNYlj+LSbCUJ0qevrDFQZ8h+DtnVswrrv5+MDwSA0caI01x1cd1NoopwK39yo
         y9EvESSll/h33/XYrJYf4J/S9w4NcKH41zcxr5jh8Xek9D6KNOfYA5Jr3l+/VQHrRkEU
         6DTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cwh//GNxXkDtdeGWxHy4iPFypYSAhLQNf5Ufwrx4yf8=;
        fh=mfOb0eZgufZ6csAKajESvj1aQRf1cLNzfM6kCPkZELY=;
        b=c6G5IhknLVgb4sbT2xN0tdZfzFfSBCDeSpLUES6HZdoQU/GC5kpLJXZ8qfl9yXq0/5
         Ezcr6t/4m/25GW8smN8cpz36+HPA44QUZDBG9/C8X7kEnwVpy8rVdgvMASjYOiZjrOhf
         TtBUruLBuhScQ/ifLAt8iXYS/8srUa0i3H93iAtaPXzVf2yHhQWwgMd/NxyGtKJIgctd
         AtYAPOhL7/9cLiOMPOL8LI1AsavVTgVxqDoGzaXN0oS2xAAt0/N4AoJ7M14dFfTwdxbd
         FVbSK8SHo+4rSI0RDusrQQeUtGdBcokDO5VAadVTBVETdsJjy4+fArGa9kY4AU4B5YwZ
         1/aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1795473521; x=1796078321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cwh//GNxXkDtdeGWxHy4iPFypYSAhLQNf5Ufwrx4yf8=;
        b=zyiUCvTuUruIC9KA7f/TKpjXXvuqRdzyyyrawPTRvar9oKK+YD/nxCoP33rGakGsav
         sVJ8T1hmCDgtZ2JwIyRdjkY8XfyO/0ttbF/16+Roobqw4ueTWztO+hRTpK39RF0TbRMu
         GHMKhS4DubOZklj70d+rMG+P2cp+iMlHMljBdjmehin9OoDpP3DNGbNmzG47jJ6KN6ho
         Dy5oKTNcCyaDipy9l2RsVqWSfXZRs5MIVqMqTjIjt9Xw8b5QCjTEiLhgNUkS7ZUQzT9Z
         a1UdIhaowt9Qr3ksyQErDAyEvTtAnO1e6+sviza4NqZYQIlIVjK5g652ikTPpAbrHzWv
         Wh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795473521; x=1796078321;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cwh//GNxXkDtdeGWxHy4iPFypYSAhLQNf5Ufwrx4yf8=;
        b=iH64Wi6MMty3AHYeuWs6KMVETiPgnysE2VIEV4ElOMD5bpmkD/gnY0brfQihZwwYWl
         kIC19J6HumunmxvUTcbxITRxDtkZnBFUaEm+vAKMYf9e/oRg+bKoekTbU2PgbNVnlDTe
         FnsoFb8N9m7O3i3vS2yaBGxqS0/vbT36n/E3bQB7+KAOfj2Zv/aLuA/3a7ozaro3qaK2
         W492E3IRaP5z1BJ7nV4G30VvXA2hYoP+he8pU8TmxBvbyPMlAuV6W8zUScfhYKitMW32
         +W9OyumfvsbZtf3PUwqILsVhGo8zw3+/WKprL+VicK/cKqnCKhiXmqvZCvkO4YozNTWZ
         HhqQ==
X-Forwarded-Encrypted: i=1; AL+hErFIjULmdcgw2wyyKtp0CHSyWABlTqfkj/bZUS+G3a8TyQqsWefXeFSrhR9Vvz/FjuiZofxvZr0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GbmAhhk/IcejqLQm2kxrc3J4QwRuWsHKVXO6yzKWO7sZN74Sa
	NpMAoMhpRKbt2GmkV+qLd493bnmpO177D+Afj0emCvqrRYwaflTCUvGT6qkTWa3wJ3Hw8KaXRxI
	CyXv792Gs49EIUy/DLwFzDU1O2nvtbQms5KLwUQQedA==
X-Gm-Gg: AZFdTZdLv/HTs5/epYZziArt5IbPaAMERnwhjdJ8zLylF3T1iJHpk8Qw5/tuLFFNFI4
	mPpUM3A7GbzYkl9+AcfIcKag/0qHtIAt8I+bBR7CRkZTxI+JEkM/z6sfs/2q0W4o9hmvi3f3PrF
	eyi6SORO7sTc4Z3bIA6VT0yC7pPzC9FT/X46pqv76giIZQ/VvRRETxouCOTUdG9wNEmdk1JvTpJ
	xKEzThFc/aMeJdDv8Gzif0jqS9UwcLWksOtqdL7O1nBb2aZrCjo0lsZzLgOG0FRr3qUjCtkrfSQ
	YZIuYTiRvu3O8XgfL5dRugLzU87c+aMF/xbEZVpsV8fB1sSqzNShCM+uSWAtuYvxMxmOemZW1Gv
	r26Vz5ZrMuE6pgaAydvLz0mklwjwm304C6AGgXSB9GK4olfWMfYoNjBNelRSrmhPDcd0ASq4DK0
	Ua2vPLEoBwPRlmb/XbZ64du6WxztxdZ65LVdrN/N2FjraTgpl3RCyYfSUcPdQAhwFvdMDQm/pxz
	ItZg3/9rwbQ4R4ZaflBcpnLWsHqAnXnwdoRAVddzrMv7+PCqhXsTTm8uuUSJC1FdXJTjpo7iJG2
	TcA=
X-Received: by 2002:a05:6122:4b88:b0:5ca:fc48:5634 with SMTP id
 71dfb90a1353d-5ee8aed35femr6594776e0c.11.1795473521432; Mon, 23 Nov 2026
 14:38:41 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116183519.3314837-1-rjethwani@purestorage.com> <awSQENPQBd7ogyyA@krikkit>
In-Reply-To: <awSQENPQBd7ogyyA@krikkit>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Mon, 23 Nov 2026 14:38:29 -0800
X-Gm-Features: Aa3M54o9TN-CRk9fIngUEHWt_m8XYLfhqb3UWdu_Qp60Que949if8U9zCRR-XfE
Message-ID: <CAKaoeS15yiScYY3uokc=DR++M-R2fyeUoK-qAtMPpbkyaqY-rQ@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] tls: fix socket use-after-free during device-down
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alice Mikityanska <alice.kernel@fastmail.im>, Tariq Toukan <tariqt@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 11:12=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.ne=
t> wrote:
>
> 2026-11-16, 11:35:17 -0700, Rishikesh Jethwani wrote:
> > tls_device_down() pins each TLS context, then drops tls_device_lock bef=
ore
>
> pin =3D hold a reference?
>
> > switching ctx->sk's TX validator. The socket destructor can run between
>
> Please stop calling it a "validator". Those abstract references are
> just obfuscation.
>
> > these steps: the context survives, but __sk_destruct() frees the socket=
.
> >
> > Switch the validator while selecting contexts from tls_device_list unde=
r
> > tls_device_lock. The destructor uses the same lock for its context put
>
> Which destructor? We shouldn't have to guess which functions are being
> called.
>
> > and list removal, so ctx->sk remains allocated through the switch.
> >
> > Checking sk_refcnt would miss sockets whose queued SKBs still hold
> > sk_wmem_alloc and require fallback after sk_refcnt reaches zero.
> >
> > Requires commit f08d8c1bb97c ("net/tls: Fix race in TLS device down flo=
w"),
> > which moved the destructor's context put under tls_device_lock. Include
> > this prerequisite in older backports.
>
> Can we add the dependency in the Cc: stable line instead of bloating
> the actual commit message?
>
> > Found by code inspection. An ASan harness running the extracted teardow=
n
> > functions with userspace shims reproduces the UAF before this fix and
> > passes afterward. Tested on Mellanox ConnectX-6 Dx (Crypto Enabled).
> >
> > Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device =
goes down and up")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> > ---
> >  net/tls/tls_device.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
>
> Changelog? Links to previous versions?
>
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index 4cdfbb57ecff..866193a506d2 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
> > @@ -1345,16 +1345,19 @@ static int tls_device_down(struct net_device *n=
etdev)
> >                   !refcount_inc_not_zero(&ctx->refcount))
> >                       continue;
> >
> > -             list_move(&ctx->list, &list);
> > -     }
> > -     spin_unlock_irqrestore(&tls_device_lock, flags);
> > -
> > -     list_for_each_entry_safe(ctx, tmp, &list, list) {
> >               /* Stop offloaded TX and switch to the fallback.
> >                * tls_is_skb_tx_device_offloaded will return false.
> > +              *
> > +              * The context reference pins ctx; tls_device_lock keeps =
ctx->sk
> > +              * allocated until the validator has been switched.
>
> I don't think this comment is helpful (and again with the obfuscation).
>
> >                */
> >               WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xm=
it_skb_sw);
>
> --
> Sabrina

I sent v6 before seeing these comments. Please disregard it. I=E2=80=99ll s=
end
v7 once I=E2=80=99ve addressed the review feedback.
