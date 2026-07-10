Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35AC374735;
	Fri, 10 Jul 2026 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706222; cv=none; b=NeuHHgCiSLnn3wUx98BuNllBJNFAkrrtGTdYCi4/cxC8ng/BdtH9G9oTmQ56iSmJ92etuGPpubJssDj6OX3d9pLF7yLuMhzdKeMmPig13hN1xqMa+vgXztgvL3G17ZpXBz31pFRB45XMnvayWc2uEazocl7C+IBw4L2BiKm4h1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706222; c=relaxed/simple;
	bh=xwxQdZfxFYULS/iu9BnSGTxA8o4jcnIHlt6iMGCXCCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCn925v/TrVP+G3co2u423hf4tFCwwEwnr4FJL/naYWNMfi1m5jC/Q1RB3NSlQHZpwoGflGWrlz6p99eBX1MLOxEwSF15q1CikBt5timxVrwm6cYFgm3/KmlU/4d+oDiQzFDwXCk0EjVaO0CCC0TRrOrs2KHoCIXIj9Wykszo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=xgLp0G6K; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="xgLp0G6K"
Received: by dvalin.narfation.org (Postfix) id E8B941FEF7;
	Fri, 10 Jul 2026 17:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783706212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ritIdVLzbj6jGCexJmHL4fv3M9Of1DhbmY1pu2yQQGU=;
	b=xgLp0G6KISG8/9EskNJLZ6u7J+8YiO7e0cS7QaHyewhvJ5GQT0BVQhdS0+NVqkQ6/OqDlt
	cUR2MAcCgtsoNx12pHk23L3op/TycLPuS3kIhl5F8iTYx8/o91mhROYZqFZPRJKdfXuglv
	W4sklEtt6OWJyHfS1/Vd5FxhBPJ7N04=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Ibrahim Hashimov <security@auditcode.ai>
Cc: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 Re: [PATCH net] batman-adv: bound BLA claim and backbone gateway table growth
Date: Fri, 10 Jul 2026 19:56:41 +0200
Message-ID: <9098133.T7Z3S40VBb@sven-desktop>
In-Reply-To: <20260710165224.39411-1-security@auditcode.ai>
References: <20260710165224.39411-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11273385.nUPlyArG6x";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart11273385.nUPlyArG6x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jul 2026 19:56:41 +0200
Message-ID: <9098133.T7Z3S40VBb@sven-desktop>
In-Reply-To: <20260710165224.39411-1-security@auditcode.ai>
References: <20260710165224.39411-1-security@auditcode.ai>
MIME-Version: 1.0

On Friday, 10 July 2026 18:52:24 CEST Ibrahim Hashimov wrote:
> batadv_bla_add_claim() and batadv_bla_get_backbone_gw() each kzalloc a
> new hash entry (struct batadv_bla_claim / struct batadv_bla_backbone_gw)
> for every distinct (mac, vid) / (orig, vid) pair carried in a
> BLA-group-conforming CLAIM frame, and insert it into
> bat_priv->bla.claim_hash / backbone_hash. There is no maximum-entry
> cap on either table -- entries are only ever removed by the
> timeout-driven periodic purge (batadv_bla_purge_claims() /
> batadv_bla_purge_backbone_gw(), BATADV_BLA_CLAIM_TIMEOUT /
> BATADV_BLA_BACKBONE_TIMEOUT, on the order of 100 s).
> 
> The BLA group a frame must carry is htons(crc16(primary_hardif_mac)),
> which is trivially observable/derivable by any node already on the
> mesh soft-interface (batadv_check_claim_group()). A single on-mesh
> sender can therefore emit CLAIM frames with an incrementing source MAC
> and force one kzalloc(GFP_ATOMIC) per frame on both hot paths, growing
> kernel memory without bound for as long as the attacker keeps sending
> -- uncontrolled resource allocation. Both allocations are
> GFP_ATOMIC with a NULL check, so this is a graceful memory-pressure
> DoS, not a crash: there is no OOB access.
> 
> batman-adv already has an established pattern for capping an
> attacker-/peer-influenced, unbounded-growth per-mesh-interface
> resource: the TP-meter session list bounds concurrent sessions with a
> fixed ceiling and an atomic_add_unless() admission check that rejects
> new allocations once the cap is hit, logging and freeing/decrementing
> on the abort path (net/batman-adv/tp_meter.c, BATADV_TP_MAX_NUM,
> bat_priv->tp_num, "Meter: too many ongoing sessions, aborting").
> 
> Apply the same pattern to BLA: add two atomic_t counters,
> bat_priv->bla.num_claims and bat_priv->bla.num_backbone_gws, each
> capped at a new BATADV_BLA_MAX_CLAIMS / BATADV_BLA_MAX_BACKBONE_GW
> limit (4096 / 256 -- generous for any real bridged LAN/VLAN
> population, several orders of magnitude below what would need to be
> sprayed to threaten memory availability). batadv_bla_add_claim() and
> batadv_bla_get_backbone_gw() reserve a slot with atomic_add_unless()
> before allocating; on cap-hit the frame is dropped (matching existing
> "drop silently, let the sender resync/backoff" BLA behaviour) instead
> of allocating. The reservation is released on every existing early-out
> (kzalloc failure, hash_add failure) and in the kref release paths
> (batadv_claim_release(), batadv_backbone_gw_release()), where the
> counters are decremented right before the objects are freed. No
> locking changes are needed: the counters are only ever touched via
> atomic ops, mirroring tp_num.
> 
> This does not change on-the-wire behaviour, hash table sizing, or
> timeout-based purging; it only stops a single on-mesh peer from
> growing the tables past a bounded ceiling.
> 
> Verified by code review rather than by driving either counter to its
> cap at runtime: the atomic_add_unless()/atomic_dec() pairing was
> checked against every existing early-out (kzalloc failure, hash_add
> failure) and against both kref release callbacks, confirming exactly
> one reservation and one release per entry, mirroring the same
> tp_num accounting in tp_meter.c. A loopback CLAIM-frame reproducer
> was used earlier to confirm the pre-fix unbounded growth itself
> (distinct claim_hash/backbone_hash entries scale linearly with the
> number of distinct (mac, vid) pairs sent), but reaching the new
> 4096 / 256 caps with that same reproducer is impractical: entries
> age out via the existing timeout-driven purge faster than a
> single-host reproducer can accumulate enough distinct pairs to hit
> the ceiling, so the cap-hit and slot-release paths were exercised
> by inspection, not by a live saturation run.
> 
> Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 38 ++++++++++++++++++++++++--
>  net/batman-adv/main.h                  |  3 ++
>  net/batman-adv/types.h                 |  6 ++++
>  3 files changed, 45 insertions(+), 2 deletions(-)


Consider this rejected:

* the target tree should be batadv and not "net"
* patch doesn't even apply to batadv.git

  $ git am 20260710165224.39411-1-security@auditcode.ai.mbx
  Applying: batman-adv: bound BLA claim and backbone gateway table growth
  error: patch failed: net/batman-adv/bridge_loop_avoidance.c:179
  error: net/batman-adv/bridge_loop_avoidance.c: patch does not apply
  Patch failed at 0001 batman-adv: bound BLA claim and backbone gateway table growth
  hint: Use 'git am --show-current-patch=diff' to see the failed patch
  hint: When you have resolved this problem, run "git am --continue".
  hint: If you prefer to skip this patch, run "git am --skip" instead.
  hint: To restore the original branch and stop patching, run "git am --abort".
  hint: Disable this message with "git config advice.mergeConflict false"

* there are already patches for these for review [1]
* breaks existing setups and doesn't allow users to adjust limits according to 
  their requirements
* own backbones must never be prevented
* I start to get tired by all these overlong AI generated patch summaries 
  which meander around completely irrelevant detail information - or 
  information which are not even relevant here

Regards,
	Sven

[1] https://patchwork.open-mesh.org/project/b.a.t.m.a.n./list/?series=726
    https://git.open-mesh.org/pub/ecsv/batman-adv.git/log/?h=b4/resource-limit
--nextPart11273385.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCalEyWQAKCRBND3cr0xT1
yzCaAP9HyxUvpnN5Dwp5ZjnKHA/sfcJNIx4NLUj6XfqoSrg8QwD+J/iCM0F11StK
uhvihT1OUCtBXnK6/uWK8K+TVALj1w0=
=MqzO
-----END PGP SIGNATURE-----

--nextPart11273385.nUPlyArG6x--



