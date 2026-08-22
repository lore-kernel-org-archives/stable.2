Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C026E165;
	Sat, 22 Aug 2026 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787396307; cv=none; b=hTE5EWUaE9cREYIDOvNkqt5zX64+bCRXQoyuYINsgExlLi/Y48/7EWhDSFGankmqsz/ys31sUlQFKLYsdNmAa98mgIn5H5daDDR6XPpLkBC9InGecJ5qppquU1TFkkS0s51+Pv/Dt3ZXVVCsGQXpR0F4nzJsudF0qY3ooouGaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787396307; c=relaxed/simple;
	bh=JuWVe47qRIGTgRlg9FCVuX3FTKhcBf/0J6MeFd90aKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVw2hkL1LgLkVTPBUy2OSaUWuqcLS/cPGhOS/rWeDcu2U318NmQLwEi/Cbfp6uiqo/+rxHnwqku2lb/PtE5fBfTGzh2S8OjxSAaYDSEefTQrYQJt9z6DkSd8SnHMtwUh4r4W0SdWFaaDxPTgykjx3b9EpXemXbKrmrbCp2vnLF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=oF1RaNNu; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="oF1RaNNu"
Received: by dvalin.narfation.org (Postfix) id E8ABC1FD5A;
	Sat, 22 Aug 2026 10:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787395952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+A9ZO54T8rgnZj0kI1FqPmdnRVqmVtuZBXPeZ734HvM=;
	b=oF1RaNNun07Hg8VSm0t9AS/rH5mQiJWCnhcDHS7wH6yTT7/Ls+k2mK8IjCrjXzz5K/G3l0
	iB8S0ZPlXyFRbDbYLmgnatUovVTPsUNZ1C+e4wjIVPtmWIeF/iklcWmkv/2cqpy+R4UWVO
	oGVjSP+hu/fEWSNTOy18QPkpWPAJn7Q=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Zhiling Zou <zhilinz@nebusec.ai>,
 stable@vger.kernel.org, Vega <vega@nebusec.ai>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net 1/9] batman-adv: fix stale receive device on merged fragments
Date: Sat, 22 Aug 2026 12:52:24 +0200
Message-ID: <6299903.lOV4Wx5bFT@sven-desktop>
In-Reply-To: <20260821094813.201800-2-sw@simonwunderlich.de>
References:
 <20260821094813.201800-1-sw@simonwunderlich.de>
 <20260821094813.201800-2-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5127734.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart5127734.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 22 Aug 2026 12:52:24 +0200
Message-ID: <6299903.lOV4Wx5bFT@sven-desktop>
In-Reply-To: <20260821094813.201800-2-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821094813.201800-1-sw%40simonwunderlich.de?part=1

> --- Patch [1]: [PATCH net 1/9] batman-adv: fix stale receive device on merged fragments ---
[...]
> On the receive side, batadv_bla_rx() is called from batadv_interface_rx()
> only after skb->dev has already been replaced:
> 
> net/batman-adv/mesh-interface.c:batadv_interface_rx() {
> 	...
> 	/* skb->dev & skb->pkt_type are set here */
> 	skb->protocol = eth_type_trans(skb, mesh_iface);
> 	...
> 	if (batadv_bla_rx(bat_priv, skb, vid, packet_type))
> 	...
> }
> 
> and batadv_bla_rx() does not call batadv_bla_process_claim() at all.
> 
> That leaves batadv_arp_get_type() in
> net/batman-adv/distributed-arp-table.c as the only consumer that can see
> the stale receive device of a merged fragment:
> 
> 	if (unlikely(!pskb_may_pull(skb, hdr_size + ETH_HLEN +
> 				    arp_hdr_len(skb->dev))))
> 
> reached via batadv_dat_snoop_incoming_arp_request()/_reply() from
> batadv_recv_unicast_packet()/batadv_recv_bcast_packet(), and only when
> CONFIG_BATMAN_ADV_DAT is built and bat_priv->distributed_arp_table is
> enabled.
> 
> Since this carries Cc: stable, would it be worth restating the affected
> path as DAT only, and mentioning that reaching it depends on DAT being
> compiled in and enabled?

No

Kind regards,
	Sven
--nextPart5127734.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaol/aAAKCRBND3cr0xT1
y2djAQC6Wcf+fKhb5XLEoQF748sDkzw3gj9qR81Mv7zdNacwmQEAn86vSlxpETyb
Q1tMEOwhO8ckdU3MvbSB74WU/JWNQwM=
=Cj/H
-----END PGP SIGNATURE-----

--nextPart5127734.31r3eYUQgx--



