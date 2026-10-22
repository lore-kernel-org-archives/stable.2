Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680394;
	b=r0v7/qDbJBduLskdbAhfFJo8UqKS019LuamBmpWECfltN3sBw5TMB7aFrI4H/7HEvGT4
	 pPmZTmKgaf8viPf1zDTTW56TFNHY2EB47ZeTYYAaz426Zip31hn07tDmh+TaoAIUnHKI+
	 GIOwR/eDjGkqe8ZFlj/1+XEljW2PX8Q129WjTwejS0Vr8ZBN0IVWyxg585McovsUFSuIe
	 fpe7N42HBp1xaGthnZwMcOzjQTJon1vraa4+zXojD22NdbHh2oAlzadg4xf4EnahzvqS/
	 iwC874QFErRPinmARWXwzvx3067rPm4TJI33NmoyoynYDhKcYbu3JYgKFYy0x856/4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680394;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+oHYwW+2+REHEr6vVJAo/VLToYTJjn8LSKpd6kIFqVk=;
	b=h3yMUbXUrIZbFqk97bnSYOy77jGR78WdKglBUsbwlLLlwpghCfPZl0/4A+KGGILrd8uY
	 TIToyxUchW4phuPptHlaQmTtHXxtW3ZuXuLyoY1a3DaxeEWDPNP6dpNoC7lg0BnW85bs+
	 f6O5TrxbiDYMXj3LsdFFyvpzSgmNstwP6QQSXxxDzVvCNal0vCWwQRcRUfDyRX+vZQ3hp
	 OvNtmQrFkAZrBwWvDU3Unt5LhXrF00z0Hj6jDixhXsHSX4OCeEmMWXCeTW9SpgtW/anKr
	 ocND+kydztCdYSSi75iHRqko6aRQHJbHAfATzV928DeXfHxRBgMiTqSd4ZapWms7K+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDnhHOoR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246AB606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDnhHOoR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B070F1F000C2
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792680393;
	bh=+oHYwW+2+REHEr6vVJAo/VLToYTJjn8LSKpd6kIFqVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MDnhHOoR0YdNyYJ1me1ajZRLCz1Bq2Ck49Vz5d+G10/s2Pc0vz9gxuzmKyA91IGMO
	 G6NhvrtMY0x9cK2OtbfgmCW3x9iSDOG6Si8JrVrdsBElR03vfPNsiu39jKtJGgc1eR
	 Vl3tCGM69Rk0puqxY52folQycDewZMmKYfsfpLaKhhiOp8izSp2BxUsD5Qk/9Lziqj
	 oxjUth7jX45n3PGv8xRt5oV7yRwwknaEY9COPEpJnC7g/7VT8m2hyMaNqD0fiVpTav
	 sig2OVOtnW/z31nf6/sfgjgX4tYeE1Tf+fnWm+WTUWSc20TVDnCzYnie1sX53xqK+x
	 5Bvk20EKE7L+Q==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6cf995766a3so1572518eaf.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 07:46:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxOhZtLPDsZTiLIK0rgwcfhqnWgipO8frLUJ1Ug2lkNuWdvV/++d3/H/Y1C7J6t3gc2JuuOTRk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyIZybOqFrItuMYbtylHvuHk7UrtGfuc2bFSRrQ3bqwnl4tt3F
	sWclgDfkzupFM/eIyYu2G53qUbtggXfRXM/5HzTC/tEdCzVr4vgPMlr0F+fns2RGW0wLvHXbHCK
	+m17JpgKL1XwvD7DPm878v7LJPUil+3g=
X-Received: by 2002:a05:6820:160a:b0:6fc:373a:1775 with SMTP id
 006d021491bc7-70941a50e37mr3218344eaf.79.1792680393015; Thu, 22 Oct 2026
 07:46:33 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021193151.1819085-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261021193151.1819085-2-Jeremy.Jean@oss.cyber.gouv.fr>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 16:46:21 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqYwtZ0851Y0M1gOAQ5uU=kjU29Puwjx7+kyR7BqKEpUg@mail.gmail.com>
X-Gm-Features: AclHuK_eJ8qt7rFIbVyfxXEh_VsPWT_SRnJGCQzv1xMfMCKNtYZIIndkv2R0CTA
Message-ID: <CAL4WiiqYwtZ0851Y0M1gOAQ5uU=kjU29Puwjx7+kyR7BqKEpUg@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix authentication bypass via unsupported TCP auth options
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 oct. 2026 =C3=A0 21:32, J=C3=A9r=C3=A9my Jean
<Jeremy.Jean@oss.cyber.gouv.fr> a =C3=A9crit :
>
> tcp_inbound_hash() parses both TCP-MD5 and TCP-AO options when at
> least one of the two features is enabled. With TCP_MD5SIG=3Dy and
> TCP_AO=3Dn, a packet with an AO option reaches the disabled
> tcp_inbound_ao_hash() stub. That stub returns success, so sockets
> configured to require MD5 authentication end up accepting
> unauthenticated data.
>
> The inverse configuration with TCP_MD5SIG=3Dn and TCP_AO=3Dy has the same
> problem for an MD5 option on AO sockets.
>
> Make the disabled stubs reject options for the unsupported
> authentication scheme.
>
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  include/net/tcp_ao.h | 2 +-
>  net/ipv4/tcp.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 9a2333e62e994..bb249d6df8723 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -303,7 +303,7 @@ static inline enum skb_drop_reason tcp_inbound_ao_has=
h(struct sock *sk,
>                 const struct request_sock *req, int l3index,
>                 const struct tcp_ao_hdr *aoh)
>  {
> -       return SKB_NOT_DROPPED_YET;
> +       return SKB_DROP_REASON_TCP_AOUNEXPECTED;
>  }
>
>  static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 87ef6d5cbfeba..7d800b6283bd2 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4962,7 +4962,7 @@ tcp_inbound_md5_hash(const struct sock *sk, const s=
truct sk_buff *skb,
>                      const void *saddr, const void *daddr,
>                      int family, int l3index, const __u8 *hash_location)
>  {
> -       return SKB_NOT_DROPPED_YET;
> +       return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
>  }
>
>  #endif
> --
> 2.47.3
>

Good catch, thanks.

The forged AO option makes us skip the unsigned fast path, which is
the only place where tcp_md5_do_lookup() can return MD5NOTFOUND.
An attacker able to hit the window of an MD5-protected session (BGP...)
can therefore inject RST or data with a junk AO option, which is
exactly what RFC 2385 is supposed to prevent.

Please mention in the changelog that TCP_AO depends on 64BIT: every
32-bit kernel with TCP_MD5SIG=3Dy is in the vulnerable configuration.

With your patch the stubs now return what the real helpers return for
a socket without keys (AOUNEXPECTED / MD5UNEXPECTED), so behavior
becomes consistent across configs. One visible change is that MD5=3Dn,
AO=3Dy kernels will now drop segments carrying an MD5 option to unkeyed
sockets, as MD5=3Dy kernels already do. That is fine, but worth one
sentence.

Optional: bumping LINUX_MIB_TCPAOKEYNOTFOUND / LINUX_MIB_TCPMD5UNEXPECTED
from the stubs would make these drops visible in nstat.

This is a fix, please send v2 as [PATCH net].

Also please CC TCP-AO folks from Arista

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
