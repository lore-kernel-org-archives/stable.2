Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049343;
	b=svOu8lYFuu1FPDhInXbCoZ4b93pCC/LF2g1s8fT1gvd4o7TTy28fEEMgCSoZeePqVReW
	 adPkihcahIN1XqWSDBhlYHYb/z8+ZomOH9aBL5xwt6w7HaX5AkCPPmuZNQlmu+8KJ5no8
	 cGKrOXahJ6406Fu6X2lUa9IMBrwBsbe4aZvXHn8honAYN3P5ZVkqE3wIko04SxjXbv6Zf
	 4op+HVDmhJelBvt3ndX2P6CaCsNLXgscy8FL7HIomCIcjREqkkxjx3hqwYDxNQrkBSEv7
	 /w/VKigeLvXeWuhZYfNCyWrFBSMDAnwx0RfFbqJg/keYPKJOopDJnSsBy6THNvczGog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049343;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=S65lyMMR1xE8IrA8zcxyTFGEF6srOPz5FeKYqMApl9g=;
	b=GLL7rr9xKQMB/4xQr+4ZGgRWFfzm3upT/Wie+uuPQIevy7gl+6/jQoz8uPT3FOoBNDQe
	 wr6G0Qa01TmQvsHFV3OgkH9FlZ0Y/lM2W8rKF6cXmoVfIqlXvl/QHpq6I4sEVCgZFG4ww
	 m9MfFE43UpSidQcCYW2K4oc5qXUIi/WhWwn45kTgVvPmNEiScItp/fdqrHcMz7Uq2LH8P
	 GTOWYxqWNmuc476n7xtZ9pDM0owm7ClJymypESpsllsZPkigWUF+p43o5dOjFQNdEfYp4
	 4VuqjePsKKCiOu5fFFu7i9giqIpC6e2USrnis2Kh3MgDDHQ7QcY5u4dbBDv/ETZTqLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LhRpIZXH;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HJehicea;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E128606A32A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E128606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LhRpIZXH;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HJehicea
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795049341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S65lyMMR1xE8IrA8zcxyTFGEF6srOPz5FeKYqMApl9g=;
	b=LhRpIZXHVHDSHAYPBrXCYLM/yWYiqAaDq1judW61Nun6D43FhKPg8xPOlf65T1/ItenuY1
	q60miaktR0s25zoCqikUxd3fvKl/uaSe/w3kW5kbp+1/MoVBaSSj9soyBUyBhjMAjKXVot
	RELTgeUh4U+GEEYQ82YsGC9615tpN1g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-lMXbT_dlNOO2FcOdKTUejA-1; Wed, 18 Nov 2026 19:49:00 -0500
X-MC-Unique: lMXbT_dlNOO2FcOdKTUejA-1
X-Mimecast-MFC-AGG-ID: lMXbT_dlNOO2FcOdKTUejA_1795049339
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a4654add56so12382955e9.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795049339; x=1795654139; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S65lyMMR1xE8IrA8zcxyTFGEF6srOPz5FeKYqMApl9g=;
        b=HJehiceaKCDXeFC4JNkXjCqGVlH8JdiQ49uzKhDkE76gZMq4YrJEev2Atmq9ggrKMU
         OkrPi0gWJmgFZ2VuPC4D3jTXZx9+ZuIdMv9vCYmEqkQwFqR9tSyqEeDHpqWlorcdzwvi
         OpPFPHr6fxflIWbjBWtG4abQkLPYRt3LQ7GW2IkrraGC+39xxGQWKaMwj1kAxqfgpIdu
         KSkNXNuHsWq1Ni+FwOgPdGE/qTKtmUQoH4KFp4FPle9dLK9h1eLwt+KWGGgvhiCHRiE4
         ERyUww8QwHD5JywAYxswYo2ELIz66cPqr38AGnSkmTn1f2rkvtizkPPOQaHYcqsv/OBF
         7vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049339; x=1795654139;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S65lyMMR1xE8IrA8zcxyTFGEF6srOPz5FeKYqMApl9g=;
        b=Pj6ar9camgP68yHC8lXDjpha7k9ji3qzI4AQXbPTTJ8EVuStxsLp2/9QJ4kVXeyLtV
         u9kPF0zsqIREm6l8UtBHEkJnpMTWxZOxGaM8lRJJKCbPJZlauS/nF/xtH//YuaYoQO8X
         zw4C2782V3HbmIWr8X2S17cpCsZuMo6thVPh4VcCsMgB3wVzrHbNXVNX6ypul9ctgRZ7
         xULifBYrIUW8tj3I6fW5oCXL+2wsckgTmbvbXQeuEhhI0Nc3IoXLhbQtBm0sfJ0NiwqH
         HzWZUndA+hf8gex2QdSi4GOt5BmwhKRdx93NOQbjP+/1nf0VxxDMsRUtgxAo3TSchGi7
         xi8A==
X-Forwarded-Encrypted: i=1; AL+hErGNbwNnfNC5bqg00grRRsbX3Cye+s2RPaYPeLrDWpHFhWF/CbgiYhHo4CUyb0wxdG8cre/Tedk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QQp27t4vX770T90HVCFDioQ0GKyiMSsr/Zu6mk9Cgx7XMgRLU
	YCqQdaawmqrIA0/BcW5Mpb0pd7ght0XhP9CzyurxaoOe7FhIP9cVNLE3l7u5NAZMFVmYumPQzw+
	m/DOBM0zW93PeaKcyBfO1s1o2JTd8bpW3Bfgodra1AhJhP+/PlaYY3CRUA6gtOWxYdlaT+kyEq5
	elyuklvfGwCzbLhJSQOLa2lt62iukIcsY/hQI6tmay
X-Gm-Gg: AYBFou10BiltvUMTu8O6p/IcCXt7FMZ+jIBsn/LqwhOfKkoZn8ufgORA3a0R4svWkaA
	d72vRgMDspU2NHfoXGuFViYbw4G8Ni+WAdoK+PWxdVqjBfPJp4djvahABUbfkrkJC0BgoF15Vh3
	z2DVhb8/Vf8M5nS2DX5/Ab8bGaA36EKh4ky0w9yDaqXZXDdnSXSGK+UdUTJHH6x5dAropjghUSr
	1s+d3opG6q4te2gKAoZz4jgtLpfHfameNN6XXWK9Sc9SaccGjToB/EtV/aU12iv1vog29OgmecR
	e84TV069Cay1fl+9UnQ7bYTWpUfvt6IYOWZviPIps5Qbq8iBS9VzMysE3NTscW0FqWwAwXpkwQo
	ZP1Xdw8Z2uiRh7Cow7SRNE9uvP36x9XuAylfj9aN+N5h2aN/qBn6byQFR53/bEhhjUJ4V7uy2uV
	2imGQ=
X-Received: by 2002:a05:600c:4ec7:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4bb7da3b3e8mr86399115e9.27.1795049339074;
        Wed, 18 Nov 2026 16:48:59 -0800 (PST)
X-Received: by 2002:a05:600c:4ec7:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4bb7da3b3e8mr86398765e9.27.1795049338658;
        Wed, 18 Nov 2026 16:48:58 -0800 (PST)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.39.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8450fa2csm10795485e9.7.2026.11.18.16.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:48:58 -0800 (PST)
From: Aaron Conole <aconole@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  David Ahern <dsahern@kernel.org>,  Ido Schimmel
 <idosch@nvidia.com>,  Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
  Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,  Xin Long
 <lucien.xin@gmail.com>,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Justin Iurman <justin.iurman@gmail.com>,  Linus =?utf-8?Q?L=C3=BCssing?=
 <linus.luessing@c0d3.blue>,  Sabrina Dubroca <sd@queasysnail.net>,
  Stefano Brivio <sbrivio@redhat.com>,  Hyunwoo Kim <imv4bel@gmail.com>,
  netdev@vger.kernel.org,  linux-sctp@vger.kernel.org,
  dev@openvswitch.org,  stable@vger.kernel.org
Subject: Re: [PATCH net 1/5] ipv6: gro: limit the number of extension headers
In-Reply-To: <20261113124625.4010206-2-edumazet@kernel.org> (Eric Dumazet's
	message of "Fri, 13 Nov 2026 13:46:21 +0100")
References: <20261113124625.4010206-1-edumazet@kernel.org>
	<20261113124625.4010206-2-edumazet@kernel.org>
Date: Wed, 18 Nov 2026 19:48:54 -0500
Message-ID: <f7tfqwxk5mx.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@kernel.org> writes:

> Hyunwoo Kim reported that a long chain of IPv6 extension headers
> can push the transport header offset of a GRO packet beyond what
> the 16-bit skb->transport_header can store. The truncated offset
> is later used by gro_receive_network_flush() to locate the network
> header of a packet held in the GRO list, leading to an out-of-bounds
> read.
>
> Since commit 3744b0964d52 ("ipv6: Implement limits on extension header
> parsing"), ip6_protocol_deliver_rcu() drops packets carrying more than
> IP6_MAX_EXT_HDRS_CNT extension headers, but ipv6_gro_pull_exthdrs()
> was left unbounded.
>
> There is no point trying to aggregate packets that the stack is going
> to drop anyway if they are locally delivered. Apply the same limit in
> ipv6_gro_pull_exthdrs().
>
> When the limit is hit, @proto still designates an extension header.
> Extension header offloads have no gro_receive() callback, so
> ipv6_gro_receive() takes its existing "goto out" path with flush set,
> and the packet is given to the normal receive path. Local delivery
> drops it with SKB_DROP_REASON_IPV6_TOO_MANY_EXTHDRS, while forwarded
> packets are simply not aggregated.
>
> An extension header being at most 2048 bytes, this bounds a chain
> to 24576 bytes.
>
> Note that offsets can still accumulate over nested encapsulations,
> so the places storing them should be hardened separately.
>
> Fixes: 4b0ebbca3e16 ("net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment")
> Cc: stable@vger.kernel.org
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Link: https://lore.kernel.org/netdev/avTTQNyvwPP6LtGx@v4bel/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

