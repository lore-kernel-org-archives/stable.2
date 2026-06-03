Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B43D1CCD
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501453; cv=none; b=Vt0BeEQL3mWzt5L4tMKERNfmHZzthAfa5DdSs2ub6+433lBjcIAf6WdYESkXUTUsdaFc8m4yjVTkKkbpSP8Hoj2Sm0OVUcF8A56j1UW+sXus3O2GdNzliaWonzA1wWKOPKYWSGyT/33b7hBArqNlzNNhdS9qSPE96tmtihxbgF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501453; c=relaxed/simple;
	bh=lc++XHO5Pi3RH8t9ZAOVfPcR6EohAUdmlF+7B7NsiP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBcBZ+a4cUjvUSXiTUTl8mEZzj5WcedN67PxDGxaambq7MepK4sV0enL3Uw3gbPcSH29isGMeoKQ5q0N5g16va+0PJ5t3y2TY3N13xu0PtsQozKQcCw/kRA7S2GkFVcJ/RvgM9my594ZUMEZIaCpjcJbx08rrEcNOaU3ME1IWRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=lsBd88bF; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="lsBd88bF"
Received: by dvalin.narfation.org (Postfix) id C05112023F;
	Wed, 03 Jun 2026 15:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780501448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zd6SQOh7HyKGZgPZtq8bPs0voGN39R8wgH5zWyJkzb8=;
	b=lsBd88bFo2L5O2bxs4h74OU/RuQO4uOf3ebQpuc3MUfUhnYZ4mRPX9dauRDH2cLTTVuKiE
	wghQtCTRU5nNCP+fouGlg0TcLNdsNT8vONK/kIVFhAAQUgU+5z9f1VEI8dSkq631IlxLGa
	OWR8Jj2IzGWd5uRspL0RZobpfIaOzx4=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: tt: prevent TVLV entry number overflow
Date: Wed, 03 Jun 2026 17:44:05 +0200
Message-ID: <3408862.oiGErgHkdL@ripper>
In-Reply-To: <20260603105137.batman-tt-tvlv-overflow@kernel.org>
References:
 <20260529180618.413634-1-sven@narfation.org>
 <20260603105137.batman-tt-tvlv-overflow@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6878984.G0QQBjFxQf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart6878984.G0QQBjFxQf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: stable@kernel.org
Date: Wed, 03 Jun 2026 17:44:05 +0200
Message-ID: <3408862.oiGErgHkdL@ripper>
In-Reply-To: <20260603105137.batman-tt-tvlv-overflow@kernel.org>
MIME-Version: 1.0

On Wednesday, 3 June 2026 17:13:57 CEST Sasha Levin wrote:
> > [PATCH 6.12.y] batman-adv: tt: prevent TVLV entry number overflow
> > commit 99d9958fa10fb684b2a8e2c48a8d704122721420 upstream.
> 
> Thanks Sven. This one doesn't apply to the stable trees as submitted.

This is odd. It was from here (were it applies): 
https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/6.12

Also tested it now on 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/ 
branch queue/6.12:

b4 shazam 20260529180300.412724-1-sven@narfation.org
b4 shazam 20260528205744.636746-1-sven@narfation.org
b4 shazam 20260529180450.413317-1-sven@narfation.org
b4 shazam 20260529180618.413634-1-sven@narfation.org # this is the relevant one
b4 shazam 20260528202135.443823-1-sven@narfation.org
b4 shazam 20260528192733.76065-1-sven@narfation.org
b4 shazam 20260528194602.258724-1-sven@narfation.org
b4 shazam 20260529180804.414401-1-sven@narfation.org
b4 shazam 20260529180905.414737-1-sven@narfation.org
b4 shazam 20260529181000.415087-1-sven@narfation.org
b4 shazam 20260529181042.415322-1-sven@narfation.org
b4 shazam 20260529181125.415543-1-sven@narfation.org


This applied fine for me. Or here the patches I've just applied on queue/6.12 
(in my local branch) with the "b4 shazam" commands:

$ git log --pretty=oneline stable-rc/queue/6.12..queue/6.12
4569694c4f2a053cd2964cad24af604ae4ec2047 (HEAD -> queue/6.12) batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
d32927f478de78eb5224ed73432aa4a41d3bdbfb batman-adv: bla: avoid double decrement of bla.num_requests
ceab9caf4a4da8ee47e4e238b5f416d49cf170a9 batman-adv: iv: recover OGM scheduling after forward packet error
8b27c099491f34e3e2050e298852295eff0a4a91 batman-adv: tp_meter: avoid role confusion in tp_list
46f3587c0deaa3fee91d38ffb517a3b597758cb2 batman-adv: tvlv: reject oversized TVLV packets
8cb77976278ae5aa212908a7392188f7ff042ba0 batman-adv: tvlv: abort OGM send on tvlv append failure
ecd5b0eaf6fbcdeec2ad328aeeabd39e9c7b8f24 batman-adv: v: stop OGMv2 on disabled interface
b2fe2f8b69154de1fb8aff110743966f5ebf2293 batman-adv: tp_meter: directly shut down timer on cleanup
4420ab1d1ee86b11393a3f561a78edbc220395fa batman-adv: tt: prevent TVLV entry number overflow
09964daa253a0b7427f01ff3b67f396d24caf928 batman-adv: tt: avoid empty VLAN responses
7829b033f053aafe66080f20b68b4a60c4f58db7 batman-adv: tt: fix TOCTOU race for reported vlans
f547e2d9c2a51405f256238558699d40449483bc batman-adv: tt: reject oversized local TVLV buffers

I am guessing that some different ordering was used while trying to apply the 
patches. Just ping me in case I should rebase the patches from my lts branches
on queue/6.12 (or another stable queue) and submit the missing ones in a 
single patchset. But I should most likely only do this after you published the 
stable-rc for these stable versions - otherwise i would also post patches 
which you already have in your queue.

Regards,
	Sven
--nextPart6878984.G0QQBjFxQf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaiBLxgAKCRBND3cr0xT1
y2YCAP4i1wc49B/YoAbgg+BMyrDl3y2KJLeF+1GaCNVLQa8aWAD/dowZroV3qg/f
FtrGJe1PZ+al/bvxuhh3A1nslrI8+AU=
=TCeB
-----END PGP SIGNATURE-----

--nextPart6878984.G0QQBjFxQf--



