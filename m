Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694216;
	b=uWwxQWFhzmWGO5b6aEi+wa8MpZGzDy9pz5UeZSgqqoVlVoMPnKee8UcmW+bBg+R+gnrj
	 Ec0nbZUeT6wY6xxgo29p4aSekdJ36Muh7z5GzuN0JvsQUkxW67Y0vKUowFkqp5pYOCCN0
	 wpdimrNdXIETz3JyhhC4ij3DtyX9wPwsrFWfIj4pKfIOZ/RgG2kG0/VBs9nUWBAgJsQfT
	 vyluOvkMoQMeZSn9g1uJbFlPoLupyH2i3dI2mpRqgPluAoYtIKTUsWZvdMpA6h5n1t4eh
	 wcXMuPhrCyjzTJJXQs1T5rpQVekGKkUdYLYBcIwBA5F/muQQhHO43F5cge6zyBVx7pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694216;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=V8UYp7qVy64yxBL1iZ5RNTwYBzXsnnh4TVvEsNUf1A8=;
	b=wcfhKjE7e+xIVoGbM9Tdcbm1OjudgE8scNxlCkcQ3mcpLRSMswlm4zos/ZIZqlbNly8B
	 /jo9ZTt2sM4K24sjSQK0YPJDqAqnex8Kz5Ey6spIVt/BB2/YuS6sTJI/wXq5rKhzt9UT5
	 xUb/Q4PAItAJrAVum+4BO7PTpC2D95cK0cvN7O7JFWF8Zobg2nsodkRq1HsqH/put73Wj
	 xXZV69uC+Hsqa7pI9Id0z3e3JYMFjhQRQ/vYrC1cF9xS3jzOOVHWO6pRQ5SLWOnQnV0gZ
	 PVFiMN1r9+JPGSCXMsKxAO/s/yBFT5lG7pK9EO7dQXcToG6I2K4pyQNlmMgJFtYOMQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=HT8csTrz;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C8360A2615;
	Thu, 22 Oct 2026 18:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5C8360A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=HT8csTrz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=V8UYp7qVy64yxBL1iZ5RNTwYBzXsnnh4TVvEsNUf1A8=; b=HT8csTrzXZtDDxrBa9FBDoxRbX
	o+8tyr5/Th61ko7LJS71QLW+4GwHxIKzL5eqs571eSv14Fma/4pnv6Ai7EyUEF1ZjYIE+lVblxXEJ
	rifipuahKXrxq513U2fgW0nUMXWpuIOIbjnQw2k0baWUK35AmgROl20nH8KadFnUWweEP62DSoKbD
	cCbFml9j2gTYtH/bhmvZj7jGUTe/5BgQa9jCF0Pv2FeXECgp7itGrgk4nQoUvJfT1EV62yR4zNw+K
	k86lothh+an0hffCDqVLhLEkZXkwB6Y+GqWMf5JGLfjak8dFEfQ2zRtlmwi5HEOAc9jkvyte2FJZP
	WPCBeS4w==;
Received: from [::1] (port=41390 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xJxeo-0000000BPPs-17qD;
	Thu, 22 Oct 2026 20:36:53 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 20:36:53 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] tcp: fix authentication bypass via unsupported TCP auth
 options
In-Reply-To: <CAL4WiiqYwtZ0851Y0M1gOAQ5uU=kjU29Puwjx7+kyR7BqKEpUg@mail.gmail.com>
References: <20261021193151.1819085-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <CAL4WiiqYwtZ0851Y0M1gOAQ5uU=kjU29Puwjx7+kyR7BqKEpUg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <76cd85fa3315cd7efbd99c791514f22e@oss.cyber.gouv.fr>
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

On 2026-10-22 16:46, Eric Dumazet wrote:
> Le mer. 21 oct. 2026 à 21:32, Jérémy Jean
> <Jeremy.Jean@oss.cyber.gouv.fr> a écrit :
>> 
>> tcp_inbound_hash() parses both TCP-MD5 and TCP-AO options when at
>> least one of the two features is enabled. With TCP_MD5SIG=y and
>> TCP_AO=n, a packet with an AO option reaches the disabled
>> tcp_inbound_ao_hash() stub. That stub returns success, so sockets
>> configured to require MD5 authentication end up accepting
>> unauthenticated data.
>> 
>> The inverse configuration with TCP_MD5SIG=n and TCP_AO=y has the same
>> problem for an MD5 option on AO sockets.
>> 
>> Make the disabled stubs reject options for the unsupported
>> authentication scheme.
>> 
>> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> ---
>>  include/net/tcp_ao.h | 2 +-
>>  net/ipv4/tcp.c       | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
>> index 9a2333e62e994..bb249d6df8723 100644
>> --- a/include/net/tcp_ao.h
>> +++ b/include/net/tcp_ao.h
>> @@ -303,7 +303,7 @@ static inline enum skb_drop_reason 
>> tcp_inbound_ao_hash(struct sock *sk,
>>                 const struct request_sock *req, int l3index,
>>                 const struct tcp_ao_hdr *aoh)
>>  {
>> -       return SKB_NOT_DROPPED_YET;
>> +       return SKB_DROP_REASON_TCP_AOUNEXPECTED;
>>  }
>> 
>>  static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock 
>> *sk,
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 87ef6d5cbfeba..7d800b6283bd2 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -4962,7 +4962,7 @@ tcp_inbound_md5_hash(const struct sock *sk, 
>> const struct sk_buff *skb,
>>                      const void *saddr, const void *daddr,
>>                      int family, int l3index, const __u8 
>> *hash_location)
>>  {
>> -       return SKB_NOT_DROPPED_YET;
>> +       return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
>>  }
>> 
>>  #endif
>> --
>> 2.47.3
>> 
> 
> Good catch, thanks.
> 
> The forged AO option makes us skip the unsigned fast path, which is
> the only place where tcp_md5_do_lookup() can return MD5NOTFOUND.
> An attacker able to hit the window of an MD5-protected session (BGP...)
> can therefore inject RST or data with a junk AO option, which is
> exactly what RFC 2385 is supposed to prevent.
> 
> Please mention in the changelog that TCP_AO depends on 64BIT: every
> 32-bit kernel with TCP_MD5SIG=y is in the vulnerable configuration.
> 
> With your patch the stubs now return what the real helpers return for
> a socket without keys (AOUNEXPECTED / MD5UNEXPECTED), so behavior
> becomes consistent across configs. One visible change is that MD5=n,
> AO=y kernels will now drop segments carrying an MD5 option to unkeyed
> sockets, as MD5=y kernels already do. That is fine, but worth one
> sentence.
> 
> Optional: bumping LINUX_MIB_TCPAOKEYNOTFOUND / 
> LINUX_MIB_TCPMD5UNEXPECTED
> from the stubs would make these drops visible in nstat.
> 
> This is a fix, please send v2 as [PATCH net].
> 
> Also please CC TCP-AO folks from Arista
> 
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Hello Eric,

Thanks for the quick review.

I have prepared a v2, which only adds some bits to the commit message,
and leave the actual patch untouched.

Noted for the Cc:, I will use the 3 @arista.com addresses at the top of
the tcp_ao.c file.

For your optional remark, I was thinking of adding a second commit as
a 2/2 in a 2-patch series. Something like the below diff, which AFAICT,
would make the drops visible under TCPAOKeyNotFound and TCPMD5Unexpected
in nstat. Is it what you had in mind? I am not particularly familiar
with that subsystem; yet, while getting this kind of feedbacks in nstat
seems good, I am opened for advice. Do you prefer that I add this
in the same fix instead?

Regards,
Jérémy

---

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 9a2333e62e994..xxxxxxx 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -303,6 +303,7 @@ static inline enum skb_drop_reason 
tcp_inbound_ao_hash(struct sock *sk,
               const struct request_sock *req, int l3index,
               const struct tcp_ao_hdr *aoh)
  {
+     NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
       return SKB_DROP_REASON_TCP_AOUNEXPECTED;
  }

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 87ef6d5cbfeba..xxxxxxx 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4962,6 +4962,7 @@ tcp_inbound_md5_hash(const struct sock *sk, const 
struct sk_buff *skb,
                    const void *saddr, const void *daddr,
                    int family, int l3index, const __u8 *hash_location)
  {
+     NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
       return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
  }
