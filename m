Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793021837;
	b=4e+O3TlQRpghtjorwlh9uSm5j/FZ0uXpehJMzX5PN/txuEpKua+vt29NQ50kvRQKOATE
	 7kHzMKvRmJ+3jowgwNDP84CRrX2+Ww/RVG3VptPcNwRMESEZBby3PUUjUXGvOVxX/83Sa
	 jfT8qcU1AZVjfNMQVafs6zQ68qEO5SYlRbd2kzpeIK2Dha0oM3mPeTIrQGNOG8yTijBJf
	 ZFDf0Eqm5E/TDBPga6buJoMSMWrjd4N7/2rMDJN7ARz/6J+LwVvKpW9UnjmWX1LZilwEX
	 JHjwN+q+aKpPHnV3QGken+mcPJZrwsIBSqCvM+EK85/wi92YCNDjxp1+QR2sACQz6zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=c4ppOZ7c6FXgFTH2gmSpwM/JgOkQlj5fbz4MqhSpDso=;
	b=zMDVm1Dt/nvlpQjCyIIsg3v8id2zKCgNrpfzklwy8ddR7O7QVW97xh4U+k/h62UGcCsS
	 mIa3Mq3ScyyaP/WdQSJDWS3YZtGpwcIA292lcsxU+b0o6BrGVlbmmLMoPdaBJvS1ycFIj
	 LsZs7LZ1jQEr82NHBlzljhjD1D9D508iSXH+kAnDXeHxoiWRKRtMACCFZoxsgYBFibEWH
	 Wy2I7YxoZCZw9B6eUMt50gh9Hw4JLdddyu9IlxLZL5CsukUWhwCyd+JAJwRRpmjssh9cy
	 R4XxAP34KUEqaXyZr+noFYSN/tDo0SO/YZYMXwOsrFgl1/wdZwC63KlIQ60XiWWmjkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kHWEnru0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17647606A328
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17647606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kHWEnru0
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5337c7b9937so433381cf.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 06:37:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793021836; cv=none;
        d=google.com; s=arc-20260327;
        b=k/ZIsPe82rfkRtjwWD6TvLI3OBePNGYQ5AVKiLm1ESpzVoRwmEb2iHEBmnm50daO/c
         94LAH6MvpPEJlK+qKkIYoTItkVgh2HDqiZSgGowCSgqkdJ40putdvMWRQx0IL7YOJw7n
         Fy45EUnBOZzy2f+bdyRxA1neKbxB4BVngREZ4dno8kthlXfw+UXW7E11HxkvbGBqU2ge
         0rc/wZ2askSX4rY2sybwoDNqqcC/Y13dFkX9VUNcoDCXM8xyF5oS1AeZ/Vk9VZKryWi2
         d0sl5wQBpnSjS/KFHWbdecEuJbEDJFyrEVQvAbTSC/y+qUZcBD5j/NOsCWNC19qKtWWb
         6naw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c4ppOZ7c6FXgFTH2gmSpwM/JgOkQlj5fbz4MqhSpDso=;
        fh=n9anm2ammotg7Ej/ng7E1N1dFul2ntAXN9wGQWhnj84=;
        b=nXgsAYwQ3JEWV6oHsSyneb0DcG2sG/aJSH5mIZgeDyyEpeSfop+H+8Adorm8x3LSkS
         zxWrbTel3MGbCX5HgoZIkva9MQFBHjNkMR8NJU5A+uPT99s3ioD8ZqU8cimspbYULiL8
         1JUUWoJsB9qEAshtr1W7dypWF3Vvsv6gw+74fEdV/QGkqUMUXi2llyLsN9NiUWApyGQW
         cC6CdubcFOpogqx9DlJRaS4S7ekvtiZU/bTpat4HL2UoRGfvcGywoIqrlwnJEJhaH/v+
         cw61nxI9E7zcyJXeWNnCBsHi/zyG2QVehfuEC3k93Q1MbjGqgCuf7t9HzyeI6QKerHAs
         PuGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793021836; x=1793626636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c4ppOZ7c6FXgFTH2gmSpwM/JgOkQlj5fbz4MqhSpDso=;
        b=kHWEnru0CHmLudr9EcHq1gQt7nBEJ/ssbwXcC+mpIdeqydP1sisZ15xxZd6hymIJ/E
         C5ML8ayjzxI7VrsDiWtaPHlViiwjg41YBfqrCzZymXV7YThnRYnc4sbTeu9dzvvSKWn6
         Yi3Z7qw/0ANHdczAokJXCD1mj9LAwgoQXbhwQ5XJSayhz37+lr5R+JptRkR4SKPRIJIp
         m6i8W6fxEx3dH+0HH2nXyDvChl29fHcyzgWUBi6Oj3vE/cBjWcGoR80FbrKT2WNOcm+W
         Tj9WIRsGVizMCc42HM6xouGMZXI8hY0bhCbWksSHdsU6S3p4hxv5FCWrGvFIq4fSOCko
         PakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793021836; x=1793626636;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4ppOZ7c6FXgFTH2gmSpwM/JgOkQlj5fbz4MqhSpDso=;
        b=qkatl//TNsYNMwAPSoYZDnWTvErFnKsLyXsBXCXzPGe9ZXw6y3AmAKDNKvaD5mwzhH
         d3AjLL9HHjovlboRfxpDZFwJi5XrVcuw/9WLKxf+j//Xhlpj4zUBbus/Y5QZ6PEbR/C6
         JDgM+Z6/BgycUrGM3wCOX65v+TeDhuU68reoDTNq5vNEuxD6NnsQ1yVvpOP+Y7az0KUC
         Rpdod0ICAFUkbqYrx0DtIg2QbBLfW9x9X3KdCqsfF1OuYC2dI1lTpbmvNVCivbUWH7qe
         mtfPLumB4sdA2rMUEnwrKcSoqb1xv368Vk00sEtl4zT0mpjJgencih84+Tze9HkzUwbp
         8TEQ==
X-Forwarded-Encrypted: i=1; AKwUvByBH179NzJ0z5KpIqM4hd5e8FraVpg8al28TEPWvPkJzH/s8MltOmKPDQp4gP3V9WhGuQ/sZ+0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJD6Gy4d2VUVFW/o5qVmxw+KX5syvVtJ4Gp+fbcIcpaxT11fIaz
	yWwA/GmuW2ZmMc+dbhtERu7tWgCINAN6kZ57mVoHU0bo6YTVGm5C7M9AhppXXMqesn08hVLIeSL
	KPcjA3U30dWgFUI8r9XBWbw8mPShdjbCUr9KuV965
X-Gm-Gg: AYBFou2i/fWusqXIxAuz8EIXT3yP3auEYjRFwfZ4u55urYMKZ1eICac1bcfpbMe+Mss
	fJ4tqML0qD4vUiTjXu7sPpNIiwyWSB+NaVNGaep3VPjo4x17HKm9Fu/xsx0Puuzn1JHwAA+38Vs
	0WFpvUldhmiflMKdGawRf+HsRaNSYjZ2LePPwctWboPqGQJTCWsCyrabm4+NV5Cqzcix1+M5jli
	me8udJGiZzeVdcg/Cyf5SFP9gYuWVVMlpoy/vW7+izVa9aLCsDlh/QCeVrUCUvNYiAlGsC8VcSG
	QWUutYAJe/nxpd8sAeOzMAcbOkJ2m0sOS7qCuxp0zzMWW0Zuy+u5O8kKzGBBYACEgcmUm6ZYVYJ
	14WKFAp8jbVQsyxv+S1UlbQZDXl+f5taINmhT26pYrQiQ3qirC/W/0b/NE9XpxzO62/c35i0Od+
	4AVtYwqspt77o51npyjhWZUI/F06+J
X-Received: by 2002:a05:622a:90b:b0:532:9220:a9ae with SMTP id
 d75a77b69052e-5383b540914mr33040301cf.6.1793021835298; Mon, 26 Oct 2026
 06:37:15 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026123244.239766-1-jiayuan.chen@linux.dev> <20261026123244.239766-2-jiayuan.chen@linux.dev>
In-Reply-To: <20261026123244.239766-2-jiayuan.chen@linux.dev>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 26 Oct 2026 09:36:58 -0400
X-Gm-Features: AclHuK-ZwT-Ffa8PUyxQxfIXZbtYplbPQ0Z6MF6o-MPhrCkkbjJDCm6CcXr5iWA
Message-ID: <CADVnQyk7wTXsgUKbEijSVd689E96Ps=sbiK8osWSuemKYD8BVg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] tcp: fix shift-out-of-bounds in inet_csk_rto_backoff()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Kuniyuki Iwashima <kuniyu@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 8:33=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> icsk_backoff is incremented by tcp_retransmit_timer() on every backed-off
> RTO with no cap of its own, and by tcp_send_probe0() up to tcp_retries2.
> It is used as a shift amount in inet_csk_rto_backoff():
>
>         u64 when =3D (u64)icsk->icsk_rto << icsk->icsk_backoff;
>
> Once it climbs past 63 the shift is UB. Seen with tcp_retries2=3D255 and =
a
> silent peer, when an ICMP host unreachable goes through
> tcp_ld_RTO_revert():
>
>   UBSAN: shift-out-of-bounds in ./include/net/inet_connection_sock.h:258:=
40
>   shift exponent 73 is too large for 64-bit type 'long long unsigned int'
>   Call Trace:
>    <IRQ>
>    dump_stack_lvl+0xc1/0xf0
>    dump_stack+0x10/0x20
>    __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
>    tcp_ld_RTO_revert.cold+0x16/0x92
>    tcp_v4_err+0xdb3/0x13e0
>    icmp_socket_deliver+0x1a7/0x390
>    icmp_unreach+0x2dd/0xe50
>    icmp_rcv+0x93e/0xe30
>    ip_protocol_deliver_rcu+0x36b/0x3e0
>    ip_local_deliver_finish+0x37d/0x620
>    ip_local_deliver+0x165/0x1d0
>    ip_rcv+0x284/0x320
>    __netif_receive_skb_one_core+0x16b/0x1c0
>    __netif_receive_skb+0x21/0x150
>    process_backlog+0x37e/0x1200
>    __napi_poll.constprop.0+0xa5/0x5e0
>    net_rx_action+0x4c0/0xf70
>    handle_softirqs+0x204/0x9b0
>    __irq_exit_rcu+0x13c/0x220
>    irq_exit_rcu+0xe/0x20
>    sysvec_apic_timer_interrupt+0x92/0xd0
>    </IRQ>
>
> The orphan check in tcp_probe_timer() calls the same helper. On x86-64
> the oversized shift count is taken modulo 64, so an orphan that should
> be dead can be seen as alive, and tcp_ld_RTO_revert() can end up with a
> smaller RTO than intended.
>
> Cap the shift at 32: any non-zero icsk_rto << 32 exceeds TCP_RTO_MAX, so
> the min_t() result is what the unbounded math would give. The
> ilog2(TCP_RTO_MAX / TCP_RTO_MIN) + 1 bound of tcp_probe0_when() does not
> fit here, as icsk_rto has no TCP_RTO_MIN floor the way tcp_probe0_base()
> has.
>
> Fixes: fcdd1cf4dd63 ("tcp: avoid possible arithmetic overflows")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/net/inet_connection_sock.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
> index 903499581db7..562e12033a5d 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -255,9 +255,10 @@ static inline unsigned long
>  inet_csk_rto_backoff(const struct inet_connection_sock *icsk,
>                      unsigned long max_when)
>  {
> -        u64 when =3D (u64)icsk->icsk_rto << icsk->icsk_backoff;
> +       u8 backoff =3D min_t(u8, 32U, icsk->icsk_backoff);
> +       u64 when =3D (u64)icsk->icsk_rto << backoff;
>
> -        return (unsigned long)min_t(u64, when, max_when);
> +       return (unsigned long)min_t(u64, when, max_when);
>  }
>
>  struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *a=
rg);
> --
> 2.43.0

The following review comments are from an LLM, look legitimate, and
IMHO are worth addressing.

Please either incorporate each piece of feedback or respond to
indicate why you think it's not appropriate.

---

This is exactly the diff Eric suggested in 2020:
https://lore.kernel.org/netdev/CANn89i+=3DQRibXsm6tw-eVwhB3wjOtgF-MtVu0G--K=
5=3DoWP97+A@mail.gmail.com/
Please add "Suggested-by: Eric Dumazet <edumazet@google.com>" and a Link:
to that message.

As for 1/2, please add the discovery/validation/testing statement
required by maintainer-netdev.rst.

---

Thanks,
neal
