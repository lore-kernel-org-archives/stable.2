Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794091882;
	b=rPJhJN/u1c6M/LCUVvry4e8DoZKvW0oElAETJ8WOUyquTSP8+KB2povh0EPUxSyqotRp
	 f+hl+NQPX7cRE1j7EngN0Tu7v6B5qlSqysCpTc5MJkt5yfrqQv3TfjWJ8jIqp+iqs8Ab6
	 o35uSFNq1Z7uZYG73CxGgKDrp+Mitfz4wFmVlSZMW+vgLpGEDco2Ow9qH3mBelBbzONGq
	 cSl3FN4VSTRwN444UX+mk6eOWXgchkEXMg9DqE2TmwLk7kxzYujEI8kBNTpF5DoxFUUUI
	 yV9sR8CTgIJfgObBkNMoTOO7xjfls2RwCwIMJEcwB20pXQck4OejyRxrtj8u2YQhSuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794091882;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=8AYIyxR2qt4kI6F4cecc2jpV4LEvoDE4i+wFqOlC5uE=;
	b=VOO9T/XnQCph9VCYbpF0N7hdIfBgiJz3XKcrPmFm+E3G9E1SeWIv7C3rjUu+Pd4iPNjc
	 Zt4cowNP5Uwc6sPGlCPwhvNrWgJ6RLcaeg84CcbpTu2kx57NUVJ0AjKdJ1lzEqB3nb1bN
	 2g+BlGui6mD7LkCR7RZbBsIWeyKj66tVT6n/Qq7Z5x3xUQfi/vBm9Zn3l9JNJZ03LQt8f
	 vrnuAnhmC4y82pdL857RYsJC78nzXnc+QxnKJyD4YP6Qyp2dZg3FCZlw9hB/Ar2jdgiC+
	 6BMwS19LgXrQJr4fAO+uPeBZ0FqLNc1MPTe0WhTyN553Y8JLIu2IVWS+tyvTp6JmfNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=OozpBp1V;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2D606A326;
	Sat,  7 Nov 2026 22:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84F2D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=OozpBp1V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8AYIyxR2qt4kI6F4cecc2jpV4LEvoDE4i+wFqOlC5uE=; b=OozpBp1VxBtwhzhEVyXTuX3mS5
	eCn+bVBulMnj6Xp9jU+p2/PokzxpEaTdbx/Ozj9I9zQLApPDJTqTq7l3P/3uzA0EQ/EgMsV6/ZY6Y
	3rKN5P1Puhl1PYGCy3DUeY6Lp81DLGpjLidYyGAwwi9k1EVb0k6QeorlQRwaAgz/CltvBhiSriNKS
	vz9sEGad9XCP9KEDe2vghnzGzQ/USALN62b0wT/1uVToUgtNoqI+38sz7Trx+JuNwwsZI4TOM1scb
	oSQ/DdWChRt6TLCj18tY/7VWnkEDzewtLoauuc1nUQuBwruKbP7fA3xH3FgLkVqgH5l4VPKX2AQkU
	MaaKWMhA==;
Received: from [::1] (port=55914 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xPpFr-0000000E5eh-0bks;
	Sat, 07 Nov 2026 23:51:19 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sat, 07 Nov 2026 23:51:19 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tcp: fix authentication bypass via unsupported TCP auth
 options
In-Reply-To: <au-kFhuPgrCjxI2R@google.com>
References: <20261021193151.1819085-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <CAL4WiiqYwtZ0851Y0M1gOAQ5uU=kjU29Puwjx7+kyR7BqKEpUg@mail.gmail.com>
 <76cd85fa3315cd7efbd99c791514f22e@oss.cyber.gouv.fr>
 <au-kFhuPgrCjxI2R@google.com>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <68e6c9af4f125e4b068de2b8c7751adf@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-11-07 23:23, Kuniyuki Iwashima wrote:
> On Thu, 22 Oct 2026 20:36:53 +0200, Jérémy Jean wrote:
>> On 2026-10-22 16:46, Eric Dumazet wrote:
>> > Le mer. 21 oct. 2026 à 21:32, Jérémy Jean
>> > <Jeremy.Jean@oss.cyber.gouv.fr> a écrit :
>> > >
>> > > tcp_inbound_hash() parses both TCP-MD5 and TCP-AO options when at
>> > > least one of the two features is enabled. With TCP_MD5SIG=y and
>> > > TCP_AO=n, a packet with an AO option reaches the disabled
>> > > tcp_inbound_ao_hash() stub. That stub returns success, so sockets
>> > > configured to require MD5 authentication end up accepting
>> > > unauthenticated data.
>> > >
>> > > The inverse configuration with TCP_MD5SIG=n and TCP_AO=y has the same
>> > > problem for an MD5 option on AO sockets.
>> > >
>> > > Make the disabled stubs reject options for the unsupported
>> > > authentication scheme.
>> > >
>> > > Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
>> > > Cc: stable@vger.kernel.org
>> > > Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> > > ---
>> > >  include/net/tcp_ao.h | 2 +-
>> > >  net/ipv4/tcp.c       | 2 +-
>> > >  2 files changed, 2 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
>> > > index 9a2333e62e994..bb249d6df8723 100644
>> > > --- a/include/net/tcp_ao.h
>> > > +++ b/include/net/tcp_ao.h
>> > > @@ -303,7 +303,7 @@ static inline enum skb_drop_reason
>> > > tcp_inbound_ao_hash(struct sock *sk,
>> > >                 const struct request_sock *req, int l3index,
>> > >                 const struct tcp_ao_hdr *aoh)
>> > >  {
>> > > -       return SKB_NOT_DROPPED_YET;
>> > > +       return SKB_DROP_REASON_TCP_AOUNEXPECTED;
>> > >  }
>> > >
>> > >  static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock
>> > > *sk,
>> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> > > index 87ef6d5cbfeba..7d800b6283bd2 100644
>> > > --- a/net/ipv4/tcp.c
>> > > +++ b/net/ipv4/tcp.c
>> > > @@ -4962,7 +4962,7 @@ tcp_inbound_md5_hash(const struct sock *sk,
>> > > const struct sk_buff *skb,
>> > >                      const void *saddr, const void *daddr,
>> > >                      int family, int l3index, const __u8
>> > > *hash_location)
>> > >  {
>> > > -       return SKB_NOT_DROPPED_YET;
>> > > +       return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
>> > >  }
>> > >
>> > >  #endif
>> > > --
>> > > 2.47.3
>> > >
>> >
>> > Good catch, thanks.
>> >
>> > The forged AO option makes us skip the unsigned fast path, which is
>> > the only place where tcp_md5_do_lookup() can return MD5NOTFOUND.
>> > An attacker able to hit the window of an MD5-protected session (BGP...)
>> > can therefore inject RST or data with a junk AO option, which is
>> > exactly what RFC 2385 is supposed to prevent.
>> >
>> > Please mention in the changelog that TCP_AO depends on 64BIT: every
>> > 32-bit kernel with TCP_MD5SIG=y is in the vulnerable configuration.
>> >
>> > With your patch the stubs now return what the real helpers return for
>> > a socket without keys (AOUNEXPECTED / MD5UNEXPECTED), so behavior
>> > becomes consistent across configs. One visible change is that MD5=n,
>> > AO=y kernels will now drop segments carrying an MD5 option to unkeyed
>> > sockets, as MD5=y kernels already do. That is fine, but worth one
>> > sentence.
>> >
>> > Optional: bumping LINUX_MIB_TCPAOKEYNOTFOUND /
>> > LINUX_MIB_TCPMD5UNEXPECTED
>> > from the stubs would make these drops visible in nstat.
>> >
>> > This is a fix, please send v2 as [PATCH net].
>> >
>> > Also please CC TCP-AO folks from Arista
>> >
>> > Reviewed-by: Eric Dumazet <edumazet@kernel.org>
>> 
>> Hello Eric,
>> 
>> Thanks for the quick review.
>> 
>> I have prepared a v2, which only adds some bits to the commit message,
>> and leave the actual patch untouched.
>> 
>> Noted for the Cc:, I will use the 3 @arista.com addresses at the top 
>> of
>> the tcp_ao.c file.
>> 
>> For your optional remark, I was thinking of adding a second commit as
>> a 2/2 in a 2-patch series. Something like the below diff, which 
>> AFAICT,
>> would make the drops visible under TCPAOKeyNotFound and 
>> TCPMD5Unexpected
>> in nstat. Is it what you had in mind? I am not particularly familiar
>> with that subsystem; yet, while getting this kind of feedbacks in 
>> nstat
>> seems good, I am opened for advice. Do you prefer that I add this
>> in the same fix instead?
> 
> FWIW, a single fix commit sounds good to me as it didn't
> drop the packet previously.
> 
> Could you post v2 ?

Thanks for the feedback.
I have just sent the v2 here:
https://lore.kernel.org/all/20261107224733.1104094-2-Jeremy.Jean@oss.cyber.gouv.fr/

Regards,
Jérémy
