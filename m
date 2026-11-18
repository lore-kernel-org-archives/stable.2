Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037911;
	b=y9rN6St0yIFjonyQM0ddyIIAtu4j4EAbCOzuiC1syBh3eHBm/YCqTYf0wejTKRkJCytn
	 VwIW43AH0iwiTJXtAxVpDCGmetaJk0bVsFl+tTISdig18CnpYHSbU7ZfYFEAlo/rHUUqw
	 pceHIIG98DeSa2hbUctPRhbnAykRGzXrCMRCuxfppGqhME0E/eOVonyLLskIo7wICFUeI
	 sxbmV4EcG8SKVvTSgeUOX4OCfrscBjrkHCMp6O6O6b+hmeul5yaj6JUPY+7HgJ9+GpRZH
	 h5EocQPNIP0a7orx2t0uC1H+auLKp+7ZZA40le26E0S9PUNVsTyETBoP36bEQO2G5/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037911;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ekV3Zp9Kv6Gg9Gx28Ixu1oWJqsN2SEzOcocFPzNJ91g=;
	b=nX7t3TPD5ju9YgjHfnFCeJ0Aym4YG5lsUh7DanHwdIaMEjXRWzMpYYVJWgvAMgXArmgx
	 Uo7lP/ETM9Pvfh5hPTGju548+RmbAwOdQNVTpp0LwJ5Xdr/FJzZBLwMU5471Sg0CtTLhH
	 H2DoZNs0NVGE/HMvIc4zo5Xz2fmyULI3AxLv9T63RU1L64g/1hZUncYYHGOUyLv3O7wmR
	 JhmGURTVruHZ3C/ro4iWvsRcrZEyCwMbw4wkmVGiPz8+qOUkE7EKHNMDWopH+Sc0A8ZuH
	 aU95apetYYCT42dFvVHsWyDbwBBvDVKy5YXD4wRS/gsKpGj1B5rJoUJ/F2jjRWmswjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxiU+muY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C75A606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxiU+muY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7841F000CB
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037911;
	bh=ekV3Zp9Kv6Gg9Gx28Ixu1oWJqsN2SEzOcocFPzNJ91g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hxiU+muYb69WGRdZTzbW3rk6CnWtArSw6qLtyQ5RWx/AkKrKO3zuaK+AzJDklsUh6
	 +XwepY169geDSvKBwoUix+5wtXyFJe95/I4pFbPLACD/ySPnDiY7anccYC2Hanlzf/
	 H5kQnrOPWQRWHg7fti89kCpKupBcvU6UHM1T5G4CuuJ83j5ko5c+qrnXFAUn1QtKRD
	 WeH3WF2qjkTV5Dx3E7qkDzXsSzqnuUmDK+g5ABNBbuomUEtC2uwQnYG7rH8weA+k7s
	 5O6aMhK5vSX66uPXstjQgc5f1PdN4T5EgFkjdRahikjTkDCzoKU5u18dHtVzcA5moz
	 R+jemDYy60ikw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43bf9548df4so1580453fac.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:38:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErENu8XeziQnIDXnp98YxMvVLdEmFCbgBevC2xDv6T187OfLiKZukP6TMAMMIr0Z78yOLOGV7nA=@vger.kernel.org
X-Gm-Message-State: APuU4Z92Rg38P7SCRmAqMtda/RUrCr3j8y8ov+feD6H5UCI49+4JqX14
	VvMM+YEsFF78BjElyNONys+v6+fziEu5YhkVgYSUthCARbwfYAhyiOy92+fSiSho7fmMXrt6var
	ICbKrjFJ2FSl7u3nD1Cmji1SgGBEnwgA=
X-Received: by 2002:a05:6870:8289:b0:4ad:8277:8b2e with SMTP id
 586e51a60fabf-4b75e520769mr3695264fac.57.1795037910498; Wed, 18 Nov 2026
 13:38:30 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118212045.3575303-1-joshwash@google.com>
In-Reply-To: <20261118212045.3575303-1-joshwash@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 18 Nov 2026 22:38:18 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqCqjm-OZ0O+KCJTb9UTqH8eXFZpsKZyc=DObM5aYvJ7w@mail.gmail.com>
X-Gm-Features: AclHuK9AmXzNN2yxUqVfOu_k9nQ29zzu-2-Bzya7Osu9i3xWf3af1oRJEHG5J80
Message-ID: <CAL4WiiqCqjm-OZ0O+KCJTb9UTqH8eXFZpsKZyc=DObM5aYvJ7w@mail.gmail.com>
Subject: Re: [PATCH net v3] gve: fix checksum state and gso_segs of HW-GRO packets
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 18 nov. 2026 =C3=A0 22:20, Joshua Washington <joshwash@google.com> =
a =C3=A9crit :
>
> From: Ankit Garg <nktgrg@google.com>
>
> With HW-GRO enabled, gve_rx_complete_rsc() turns a coalesced packet into
> a GSO skb by setting gso_size, gso_segs and gso_type, but leaves it
> CHECKSUM_UNNECESSARY with th->check as the device wrote it. Unlike
> tcp4_gro_complete() and tcp6_gro_complete() for a SW-GRO packet, it does
> not seed th->check with the TCP pseudo-header checksum or set
> CHECKSUM_PARTIAL.
>
> The GRO stack completes a HW-GRO skb itself only if it holds the skb for
> merging (since commit 5eddb24901ee ("gro: add support of (hw)gro packets
> to gro stack")). Otherwise the skb is delivered as is, e.g. with rx-gro
> off or for a packet that is flushed immediately (e.g. with PSH set). If
> such an skb is forwarded out of a TSO-capable device, netif_needs_gso()
> accepts it as CHECKSUM_UNNECESSARY and the device segments it with a
> bogus checksum seed, so every segment is dropped by the receiver. This
> blackholes forwarded TCP traffic on VMs acting as routers or NAT
> gateways and was observed on VMs in real use.
>
> Fix it in a manner consistent with other drivers with HW-GRO: set the
> network and transport headers and, for packets whose checksum the device
> verified, seed th->check with the pseudo-header checksum and call
> tcp_gro_complete(), passing gso_segs through NAPI_GRO_CB(skb)->count.
> skb->data points at the Ethernet header on the napi_gro_frags() path and
> at the IP header on the header-split and copybreak paths, so account for
> that when setting the network header. Since the header layout now
> matters, tell IPv4 from IPv6 by the EtherType, as qede and bnx2x do,
> rather than by the packet type.
>
> The device only coalesces TCP directly over IPv4 or IPv6, without VLAN
> tags, IPv6 extension headers or encapsulation, so the IP header always
> follows the Ethernet header and the TCP header always follows the IP
> header. The IP and TCP header lengths are read from the packet, so check
> that the headers are in the linear part before using them, and drop the
> packet otherwise.
>
> Also compute gso_segs from the TCP payload length. It was computed from
> skb->data_len, which is 0 for a packet that rx_copybreak copied whole
> into the linear part, leaving such packets with gso_segs 0 and a
> non-zero gso_size. Such small packets usually carry a single segment, so
> deliver a packet with at most one segment of payload as a non-GSO skb.
>
> Fixes: e637c244b954 ("gve: Advertise NETIF_F_GRO_HW instead of NETIF_F_LR=
O")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Ankit Garg <nktgrg@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
