Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1203D2F7EE7;
	Sat, 22 Aug 2026 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787396486; cv=none; b=BbVFI/b1YISOuHALyW+U+8Lx4qwju9ud7DHqx9FuGJPnPu/AqkQo2kEznKAkkSUDVK0feavuyVwWjScr6i5M+0TGCf8EqIAp0H/lEPInRZrugchNaI4lMrWq42B3dhxjUgIz0tXnv7mikHr+8RV0EdfM+eEWgP1mbaJHtKtVqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787396486; c=relaxed/simple;
	bh=TSgEsCEs2NIOIktOR+Zlq9TrAnS4Uz6xl63TDYsdwy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sejPZ7ivpjcg5dLXalbfBLDyWDtAI3fH3K9Rsrrsioe9zkLzcjv9sn7Rzt/5jAI1KlS6zmSSmod8fWk88NUK5xyPsMfJgRIlSa9MmqTXTikG/Ma4y/9sVLvDyiMxK86wG2geMIIqixRHJ056XhqIop1BqV7YyjuOsY1Qi/qM2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=m5P5axHG; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="m5P5axHG"
Received: by dvalin.narfation.org (Postfix) id A528A200FB;
	Sat, 22 Aug 2026 11:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787396479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5TYPD9L0vmzoBWI6d9zzsVJKKo6+pNNu3F7nzirXqkI=;
	b=m5P5axHGoYbicMzsTsmqiUl+iT6btqG1qWti/E74AUKojpV8/aTK0thoU6Oj88mn8Ksgv2
	dcYw5VzI0Pn2JYlbFAvQb+rrBPAZDJoBcBDYUfk2kYzXv6XGdSie28ond565Wwazxo09zR
	b9ZdX+57R4GEjwKdC+adI5XV+59MJLw=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net 2/9] batman-adv: bla: avoid CRC corruption due to parallel
 claim add
Date: Sat, 22 Aug 2026 13:01:14 +0200
Message-ID: <2277407.irdbgypaU6@sven-desktop>
In-Reply-To: <20260821094813.201800-3-sw@simonwunderlich.de>
References:
 <20260821094813.201800-1-sw@simonwunderlich.de>
 <20260821094813.201800-3-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14080243.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart14080243.uLZWGnKmhe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 22 Aug 2026 13:01:14 +0200
Message-ID: <2277407.irdbgypaU6@sven-desktop>
In-Reply-To: <20260821094813.201800-3-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821094813.201800-1=
=2Dsw%40simonwunderlich.de?part=3D2

[...]
> > @@ -732,43 +734,56 @@ static void batadv_bla_add_claim(struct batadv_pr=
iv *bat_priv,
> >  			kfree(claim);
> >  			return;
> >  		}
> > +
> > +		spin_lock_bh(&backbone_gw->crc_lock);
> > +		backbone_gw->crc ^=3D claim_crc;
> > +		spin_unlock_bh(&backbone_gw->crc_lock);
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't an issue introduced by this patch, but how do these relative X=
OR
> updates interact with the absolute CRC store that still exists in
> batadv_bla_del_backbone_claims() at this commit?

Please, look literally one patch further.
https://lore.kernel.org/r/20260821094813.201800-4-sw@simonwunderlich.de

[...]
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This is a pre-existing inconsistency rather than something this patch
> introduces, but now that the compare and the swap of claim->backbone_gw
> both happen under claim->backbone_lock here, should the two remaining
> readers be annotated too?
>=20
> net/batman-adv/bridge_loop_avoidance.c:batadv_bla_del_backbone_claims() {
> 	...
> 		hlist_for_each_entry_safe(claim, node_tmp,
> 					  head, hash_entry) {
> 			if (claim->backbone_gw !=3D backbone_gw)
> 				continue;
> 	...
> }
>=20
> net/batman-adv/bridge_loop_avoidance.c:batadv_bla_answer_request() {
> 	...
> 			/* only own claims are interesting */
> 			if (claim->backbone_gw !=3D backbone_gw)
> 				continue;
> 	...
> }
>=20
> Both do a plain load, not even READ_ONCE(), while types.h documents the
> field as:
>=20
> 	/** @backbone_lock: lock protecting backbone_gw pointer */
> 	spinlock_t backbone_lock;
>=20
> At both sites the pointer is only compared and never dereferenced, and in
> batadv_bla_del_backbone_claims() a stale comparison still keeps the CRC
> parity correct because the deferred batadv_claim_release() XORs the addre=
ss
> out of whichever backbone the claim points at. So this looks like a
> KCSAN-visible plain-access race with no functional fallout, but would a
> READ_ONCE() or a comment on those two readers be worth adding so the
> documented locking rule matches the code?

No about this patch and definitely not high priority. Still made a ticket:=
=20
https://www.open-mesh.org/issues/465 for Simon

Regards,
	Sven
--nextPart14080243.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaomBegAKCRBND3cr0xT1
y+KRAP9EfpNMr0q7Bfn7zIWFY7VjQOW7BiYkErSJbQdMN/rPYAD9Hi9nJOko648D
VHcO8RgNr3MYcNRsHGItdwE+8+03kQI=
=d71n
-----END PGP SIGNATURE-----

--nextPart14080243.uLZWGnKmhe--



