Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975911E7C02;
	Sat, 22 Aug 2026 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787398903; cv=none; b=cm5RfRoNVxv8P0xgH8UIlgOhrf8JPWSLX01VtwvqIlCqkbQY3K+aIgFE8AjFvKpbqn60q2pEoMlF5KSNDW7gM2ysCGj5Jcb6uPWuDZklH9D/D2NzBUTX3edi+OD7YkH/nGPCpvKxFdUyhiMWnmRYbAIvr/vf44CN28lbSQ3SpQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787398903; c=relaxed/simple;
	bh=uFLutO+WbkRh+7JG/1fSmRCatUA5qR0sRjp6VRo4ALo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUnhXwr7gahTVQHD7U+cxwO9gX24ZwganKbLnQlbaqCT0llgvLtwSQgR02La1kXa6QbxR6o3Mj41Q7YlOMd0w1Os3T35chV/m4kfg7CUHBsi3uy6ijyBAVjkyDM3+LxEFM74AgNbynvAnZCPhSQ32sBeEP2Uxdx5tEwkhSV7vu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=wjspKXsO; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="wjspKXsO"
Received: by dvalin.narfation.org (Postfix) id 48AD01FDD3;
	Sat, 22 Aug 2026 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787398896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TekJJ3/G2DEyN7x0ZmtuopZ8f9leW9D0loLPGanNg+Y=;
	b=wjspKXsO4PXEzuo3No0hIEv5kvB0qg9rdoz0W6VJ6NrcJSr6UfnNesrM3TLWwExPQHIJTC
	iFqBA6JaqrzFAJwrrdmdvSJjbUosmDFUWOabZYEdKgqFZmvwTEozYmVSnwnxd3nRCytQ5j
	kxIp2h3+xr//6zr5zRvIrtAMQBLgLBM=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net 8/9] batman-adv: mcast: linearize skbuff for packet generation
Date: Sat, 22 Aug 2026 13:41:34 +0200
Message-ID: <3908873.MHq7AAxBmi@sven-desktop>
In-Reply-To: <20260821094813.201800-9-sw@simonwunderlich.de>
References:
 <20260821094813.201800-1-sw@simonwunderlich.de>
 <20260821094813.201800-9-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2016828.taCxCBeP46";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2016828.taCxCBeP46
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 22 Aug 2026 13:41:34 +0200
Message-ID: <3908873.MHq7AAxBmi@sven-desktop>
In-Reply-To: <20260821094813.201800-9-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821094813.201800-1=
=2Dsw%40simonwunderlich.de?part=3D8

[...]
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't a bug introduced by this patch, but the new comment states a
> whole-skb requirement that the existing kernel-doc contradicts.
>=20
> batadv_mcast_forw_scrape() documents only a prefix requirement:
>=20
>  * Caller needs to ensure that the region from the skb data's start up
>  * to/including the to be removed bytes are linearized.
>=20
> while its body asserts the entire skb is linear:
>=20
> 	SKB_LINEAR_ASSERT(skb);
>=20
> with, in include/linux/skbuff.h:
>=20
> 	#define SKB_LINEAR_ASSERT(skb)  BUG_ON(skb_is_nonlinear(skb))
>=20
> Similarly, batadv_mcast_forw_packet()'s kernel-doc lists the caller
> obligations (set network/transport header, free the skb) but does not
> mention linearity at all; only the in-body comment mentions it, and it
> also understates the assert:
>=20
> 	/* (at least) TVLV part needs to be linearized */
> 	SKB_LINEAR_ASSERT(skb);
>=20
> Should the kernel-doc of batadv_mcast_forw_scrape() and
> batadv_mcast_forw_packet() be updated to say the whole skb must be linear?
>=20
> Along the same lines, the invariant this patch establishes is not recorded
> at either interface boundary: batadv_mcast_forw_push()'s kernel-doc does
> not mention that on success the skb is linear, and neither the
> batadv_mcast_forw_mcsend() kernel-doc nor its declaration in
> net/batman-adv/multicast.h mentions the precondition that
> batadv_mcast_forw_packet() enforces with BUG_ON().
>=20
> No in-tree caller violates this today: batadv_recv_mcast_packet() unshares
> and linearizes, and the batadv_mcast_forw_mcsend() path is now covered by
> the skb_linearize() added here. Would documenting the requirement help
> avoid a future caller reintroducing the BUG()?=20

Will definitely not deal with this documentation work this bugfix patch. Li=
nus=20
or anyone else interested can work on it: https://www.open-mesh.org/issues/=
468

Regards,
	Sven
--nextPart2016828.taCxCBeP46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaomK7gAKCRBND3cr0xT1
y0dHAQDkkm6Ghk24ASYO7aRNwmGivKGlfgreBB+LR5M7otgeqQEAq/Vslc4Hbk7p
/GrkDJ3rDWy41cTXnSztK3BMHLH8xAQ=
=lW4r
-----END PGP SIGNATURE-----

--nextPart2016828.taCxCBeP46--



