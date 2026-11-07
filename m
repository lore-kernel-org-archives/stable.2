Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090240;
	b=nWn4uHqXP5w14/klrk5R6EL9aN1dS2M0UDk2OrPzPLhh4jdj9PHXv9T4TH+LS/3i5pTX
	 QB2aTUGvR50tPvBDyXrZB/od/w98qo0VTwcbtywbwavtBaZWb9Uu+dJzeVE/kC/mcv1on
	 5+P7EsgqNR+gzB7+J18sZbpwVCrQadPeSTR0JdZ8j1Oigjkv9Fbt4xlB8F8MjkeMlIFJB
	 HU0oysj4rH/eGUJXnGCSCfCl/21jp/n1ajQanD65qaPzyVoS/J1Lhc71YCnysTng2mbL4
	 49QxOACVjFAkrb0D5+icASIPjVtpgeOuPbXz49mSTGTYhqkfIHghfAQGufkEXFm0oMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dm6rO29QixR22u6fEQ/JRWKlqBHjUSHEU2oHT/qED9U=;
	b=zVRWNX8tsjR3+nYX/hdoi2FA1+EpRTPLgasaOZLruZZFxpXQZwG3AMum7YRrBY7A1vMQ
	 UKycdEgJQ/PTYWZvtlEp01/zf+FEjRoobGpIF3ZLCgy5k12awnMbeoqqzeY2nO5I3lpMm
	 xLCCwgSA1kXNhjPMz6JDWlhkwdqPXFrNZc5c/b6aoSW8lvUadmmCbraC3yO8p4omXQdLx
	 T//FGqe32Y6asRK4y2b89LHUg9KuoWf1KqRHrk9Fe4NwoCzwAElqtB/GUldG4cXWObCti
	 ar9PGaSlmkwflvgYa+fJtAxc6Ap0+FjR85eje+x3EpPu5VsI8XG6Uw+rJxH9siRtxnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V0t6ybGm;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3A8606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 22:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A3A8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V0t6ybGm
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b10afdf947so403919a91.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 14:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794090239; x=1794695039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dm6rO29QixR22u6fEQ/JRWKlqBHjUSHEU2oHT/qED9U=;
        b=V0t6ybGm28ZDrqSbzWcFepU0cd3Dw9egLzbJtYq8z/iegL2YyT1oI3o7OR+ftW3xT6
         BFFhbGZ0Iwm6pxFJoLdohWfmOJUg4L3dzZGtfd6d0NqkEArLdN1MJZ9NDeIfClCEjmeg
         1ZVl82FAmtHDMAmS85N2CXZ+YHn4xOxhilYZhxjH9XAbX+kF+4fhuxPDlQTYvQtQ5Rpx
         TmitgMuLQdbLCoBGi4zKF09jjDbQEu58uWoNFxATGCpXdDNjO1wC8B0OeXoa49nYst2h
         pydGyroHPRy6HfSWwOBOmpPyJtHhabfDNEmzCCivRNMeN+bcgSYXulEO5n7AKWXIxuPF
         c/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794090239; x=1794695039;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dm6rO29QixR22u6fEQ/JRWKlqBHjUSHEU2oHT/qED9U=;
        b=0w1c9TagseYCSV8gtqIHwSnd+GLrG8Jjqxbu7rX0/5jcOL9T6Ocb/d3pifgOiXa724
         kKAb7H4y3ZSIxxbgiWAv9hajwTGsjhCKG6Uo8ctmx7zEgUQIUZ85T6irbhwEqca0+rmu
         hl9t+W4mw2Ei5rO3txHZ5vYBn7A2LMYEsmYv46D3n79/LS4GKijJINuZR8UintTtxFbC
         yYRvm8VPkgOOKkhej4eZD6jwNk/hHG3AlnsUZ23VqpiO543m2Y7HcK6gOJYxjh+CAi80
         VuZXkuYWzKxpAhIRfkbnjocQzemcpfv3NWEeE93JTZcJJ6ajwjArGA/vaUZvhDdhKGYu
         G8gA==
X-Forwarded-Encrypted: i=1; AL+hErEBa339fWZNH5YWl+TGaWwfWxCR44/NxL50aWZO6YBNuwQYgvCs2mCqFyk5GuFKlz2nw/dU7GA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+WvE/aXB9my7X08r7bxTMEJmbEP186CttNjNVpxsS6nKp1BTQ
	hqXPD5wbCxKgdyF4xgb6cD55RNYZEx9Yu2axYJTYrt3pc68pWpSHbEGQpLWVz3w15n4BZktLTSb
	7buIabg==
X-Received: from pjbrr5.prod.google.com ([2002:a17:90b:2b45:b0:3b0:a379:b383])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4488:b0:3ad:7f4d:2839
 with SMTP id 98e67ed59e1d1-3b1060a69f7mr2074752a91.14.1794090239138; Sat, 07
 Nov 2026 14:23:59 -0800 (PST)
Date: Sat, 7 Nov 2026 22:23:58 +0000
In-Reply-To: <76cd85fa3315cd7efbd99c791514f22e@oss.cyber.gouv.fr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021193151.1819085-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <CAL4WiiqYwtZ0851Y0M1gOAQ5uU=kjU29Puwjx7+kyR7BqKEpUg@mail.gmail.com> <76cd85fa3315cd7efbd99c791514f22e@oss.cyber.gouv.fr>
Message-ID: <au-kFhuPgrCjxI2R@google.com>
Subject: Re: [PATCH] tcp: fix authentication bypass via unsupported TCP auth options
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "=?utf-8?B?SsOpcsOpbXk=?= Jean" <jeremy.jean@oss.cyber.gouv.fr>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Oct 2026 20:36:53 +0200, J=C3=A9r=C3=A9my Jean wrote:
> On 2026-10-22 16:46, Eric Dumazet wrote:
> > Le mer. 21 oct. 2026 =C3=A0 21:32, J=C3=A9r=C3=A9my Jean
> > <Jeremy.Jean@oss.cyber.gouv.fr> a =C3=A9crit :
> > >=20
> > > tcp_inbound_hash() parses both TCP-MD5 and TCP-AO options when at
> > > least one of the two features is enabled. With TCP_MD5SIG=3Dy and
> > > TCP_AO=3Dn, a packet with an AO option reaches the disabled
> > > tcp_inbound_ao_hash() stub. That stub returns success, so sockets
> > > configured to require MD5 authentication end up accepting
> > > unauthenticated data.
> > >=20
> > > The inverse configuration with TCP_MD5SIG=3Dn and TCP_AO=3Dy has the =
same
> > > problem for an MD5 option on AO sockets.
> > >=20
> > > Make the disabled stubs reject options for the unsupported
> > > authentication scheme.
> > >=20
> > > Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments"=
)
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> > > ---
> > >  include/net/tcp_ao.h | 2 +-
> > >  net/ipv4/tcp.c       | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> > > index 9a2333e62e994..bb249d6df8723 100644
> > > --- a/include/net/tcp_ao.h
> > > +++ b/include/net/tcp_ao.h
> > > @@ -303,7 +303,7 @@ static inline enum skb_drop_reason
> > > tcp_inbound_ao_hash(struct sock *sk,
> > >                 const struct request_sock *req, int l3index,
> > >                 const struct tcp_ao_hdr *aoh)
> > >  {
> > > -       return SKB_NOT_DROPPED_YET;
> > > +       return SKB_DROP_REASON_TCP_AOUNEXPECTED;
> > >  }
> > >=20
> > >  static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock
> > > *sk,
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 87ef6d5cbfeba..7d800b6283bd2 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -4962,7 +4962,7 @@ tcp_inbound_md5_hash(const struct sock *sk,
> > > const struct sk_buff *skb,
> > >                      const void *saddr, const void *daddr,
> > >                      int family, int l3index, const __u8
> > > *hash_location)
> > >  {
> > > -       return SKB_NOT_DROPPED_YET;
> > > +       return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
> > >  }
> > >=20
> > >  #endif
> > > --
> > > 2.47.3
> > >=20
> >=20
> > Good catch, thanks.
> >=20
> > The forged AO option makes us skip the unsigned fast path, which is
> > the only place where tcp_md5_do_lookup() can return MD5NOTFOUND.
> > An attacker able to hit the window of an MD5-protected session (BGP...)
> > can therefore inject RST or data with a junk AO option, which is
> > exactly what RFC 2385 is supposed to prevent.
> >=20
> > Please mention in the changelog that TCP_AO depends on 64BIT: every
> > 32-bit kernel with TCP_MD5SIG=3Dy is in the vulnerable configuration.
> >=20
> > With your patch the stubs now return what the real helpers return for
> > a socket without keys (AOUNEXPECTED / MD5UNEXPECTED), so behavior
> > becomes consistent across configs. One visible change is that MD5=3Dn,
> > AO=3Dy kernels will now drop segments carrying an MD5 option to unkeyed
> > sockets, as MD5=3Dy kernels already do. That is fine, but worth one
> > sentence.
> >=20
> > Optional: bumping LINUX_MIB_TCPAOKEYNOTFOUND /
> > LINUX_MIB_TCPMD5UNEXPECTED
> > from the stubs would make these drops visible in nstat.
> >=20
> > This is a fix, please send v2 as [PATCH net].
> >=20
> > Also please CC TCP-AO folks from Arista
> >=20
> > Reviewed-by: Eric Dumazet <edumazet@kernel.org>
>=20
> Hello Eric,
>=20
> Thanks for the quick review.
>=20
> I have prepared a v2, which only adds some bits to the commit message,
> and leave the actual patch untouched.
>=20
> Noted for the Cc:, I will use the 3 @arista.com addresses at the top of
> the tcp_ao.c file.
>=20
> For your optional remark, I was thinking of adding a second commit as
> a 2/2 in a 2-patch series. Something like the below diff, which AFAICT,
> would make the drops visible under TCPAOKeyNotFound and TCPMD5Unexpected
> in nstat. Is it what you had in mind? I am not particularly familiar
> with that subsystem; yet, while getting this kind of feedbacks in nstat
> seems good, I am opened for advice. Do you prefer that I add this
> in the same fix instead?

FWIW, a single fix commit sounds good to me as it didn't
drop the packet previously.

Could you post v2 ?

Thanks


>=20
> Regards,
> J=C3=A9r=C3=A9my
>=20
> ---
>=20
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 9a2333e62e994..xxxxxxx 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -303,6 +303,7 @@ static inline enum skb_drop_reason
> tcp_inbound_ao_hash(struct sock *sk,
>               const struct request_sock *req, int l3index,
>               const struct tcp_ao_hdr *aoh)
>  {
> +     NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
>       return SKB_DROP_REASON_TCP_AOUNEXPECTED;
>  }
>=20
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 87ef6d5cbfeba..xxxxxxx 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4962,6 +4962,7 @@ tcp_inbound_md5_hash(const struct sock *sk, const
> struct sk_buff *skb,
>                    const void *saddr, const void *daddr,
>                    int family, int l3index, const __u8 *hash_location)
>  {
> +     NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
>       return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
>  }
