Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D764;
	Sat, 22 Aug 2026 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787397362; cv=none; b=g10otyeibBS4xocVCXBxom4/mAq+5sMP9VKQ85y6acPnkO/47xGBJ/JIQK4nFou6WrYh4aWKbF+ZA5fUXtcvBwo7TEIKNqe8rJTFfmbEDtTy3sqyLwwVVkkea8XyGjrxkWy1naxrDSSttcaBXxDQcwb/VMS9Xl/T2RLO2zI8PPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787397362; c=relaxed/simple;
	bh=NrzvX4U2UqnDLWIvL2I2Yt5Yq+EbbVQHhIo2K9yQ45U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Csed2F22BSD9krpAZ29hG1HWvt+kjqDBAACtDe4mVIDkuKs0PEYB6s4o6e4Cy6iLg8O7ZWJq9XY/Lx9atRcwiHoG25v0IOfjd/nbbKdP0vo23lYQIeX2k61h8GQoaFTjLc2gv/tIk7X8xn/MZox8upjeKREWkzGji/6e0YCg+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=CdvO0Fcc; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="CdvO0Fcc"
Received: by dvalin.narfation.org (Postfix) id DEF5C1FD5A;
	Sat, 22 Aug 2026 11:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787397354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJqFFme5zny2M+ndpmnl6LydymRJAkASRNq66ejAgzE=;
	b=CdvO0FccrsDHcoW+djXygOmYVd/tvOIPlv0IL1jAkFMfGf0LTMoQcuKGnPV6P5aKQEcNyf
	96GJCygAWbOB6oCK9Aq7KdDICYhk2N+5tuETjvBUVSFw3+BV7kjk1pBLu5Cm6WhUv96fnE
	cL6rvUyz4GzJDwWEie+Fn/MFetpQz1U=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net 3/9] batman-adv: bla: prevent CRC corruptions after claim
 flush
Date: Sat, 22 Aug 2026 13:15:45 +0200
Message-ID: <23219208.EfDdHjke4D@sven-desktop>
In-Reply-To: <20260821094813.201800-4-sw@simonwunderlich.de>
References:
 <20260821094813.201800-1-sw@simonwunderlich.de>
 <20260821094813.201800-4-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7985708.EvYhyI6sBW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart7985708.EvYhyI6sBW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 22 Aug 2026 13:15:45 +0200
Message-ID: <23219208.EfDdHjke4D@sven-desktop>
In-Reply-To: <20260821094813.201800-4-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821094813.201800-1=
=2Dsw%40simonwunderlich.de?part=3D3

[...]
> Discovered by: gpt-5-6-sol =C2=B7 Missed by: opus-5, sashiko-gemini =C2=
=B7 Confirmed by: opus-5
> This isn't a bug introduced by this patch, but since the patch touches
> exactly this function: is the ownership test in the loop just above the
> removed hunk sufficiently synchronized?
>=20
> net/batman-adv/bridge_loop_avoidance.c:batadv_bla_del_backbone_claims() {
> 	...
> 	spin_lock_bh(list_lock);
> 	hlist_for_each_entry_safe(claim, node_tmp, head, hash_entry) {
> 		if (claim->backbone_gw !=3D backbone_gw)
> 			continue;
>=20
> 		hlist_del_rcu(&claim->hash_entry);
> 		batadv_claim_put(claim);
> 	}
> 	spin_unlock_bh(list_lock);
> 	...
> }
>=20
> claim->backbone_gw is read here with only the claim hash bucket list_lock
> held, but the writer in batadv_bla_add_claim() only takes
> claim->backbone_lock:
>=20
> net/batman-adv/bridge_loop_avoidance.c:batadv_bla_add_claim() {
> 	...
> 	/* replace backbone_gw atomically and adjust reference counters */
> 	spin_lock_bh(&claim->backbone_lock);
> 	if (claim->backbone_gw !=3D backbone_gw) {
> 		changed =3D true;
>=20
> 		old_backbone_gw =3D claim->backbone_gw;
> 		kref_get(&backbone_gw->refcount);
> 		claim->backbone_gw =3D backbone_gw;
> 	} else {
> 	...
> }
>=20
> The two paths can run at the same time:
>=20
> CPU0 (workqueue)
> batadv_bla_periodic_work()
>   batadv_bla_purge_backbone_gw()
>     batadv_bla_del_backbone_claims()   /* reads claim->backbone_gw */
>     hlist_del_rcu(&backbone_gw->hash_entry);
>=20
> CPU1 (rx/tx softirq)
> batadv_bla_rx() / batadv_bla_tx()
>   batadv_bla_process_claim()
>     batadv_handle_claim()
>       batadv_bla_add_claim()           /* writes claim->backbone_gw */
>=20
> The same interleaving looks reachable purely from received frames, since
> batadv_handle_announce() calls batadv_bla_send_request() on a CRC mismatc=
h,
> which also calls batadv_bla_del_backbone_claims().
>=20
> If the purge observes the stale owner after a racing CLAIM frame has
> reassigned the claim to another backbone gateway, does it unlink a claim
> that is now legitimately owned by that other gateway, so the next mesh fr=
ame
> from that client MAC makes batadv_bla_rx() claim it locally and two backb=
one
> gateways forward broadcast/multicast into the bridged LAN until the
> claim/CRC request protocol resynchronizes?
>=20
> In the opposite order, if the purge observes the newly written owner and
> skips a claim that was just reassigned to the gateway being purged, the
> claim survives pointing at a backbone gw that is removed from the backbone
> hash immediately afterwards. Since batadv_bla_purge_claims() only expires
> claims owned by our own address, can such an entry linger and make
> batadv_bla_tx() keep dropping multicast frames from that client MAC until=
 a
> unicast mesh frame triggers a re-claim?
>=20
> Refcounting and the CRC XOR accounting do stay balanced here, because
> batadv_claim_release() re-reads the owner under claim->backbone_lock, so
> this looks like a claim table state consistency issue rather than memory
> corruption.=20

Minor problem, self healing and not about this patch. Not sure if Simon wan=
ts=20
to fix it.


> The code is unchanged at the end of the series
> (b32d9323b268). Would taking claim->backbone_lock around the ownership
> test, or comparing against a value read under that lock, be appropriate?

No, this is wrong. You would then complain that this patch is having a TOCT=
OU=20
problem. I will not fall for this trap.

Regards,
	Sven
--nextPart7985708.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaomE4QAKCRBND3cr0xT1
y7v/AQDPKO7s5WxY8IMFpBmmglO7ByGKPEKeG7czt8xaYg5kAAEAhlcqYavv8IPK
kq/Lfs0218blq7PYob14oQZzGNsrzAc=
=MvmJ
-----END PGP SIGNATURE-----

--nextPart7985708.EvYhyI6sBW--



