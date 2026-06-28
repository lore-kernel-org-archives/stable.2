Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D312C40D569
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 04:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782621424; cv=none; b=gJu7zd7OoDJxCV4GkhNDnlo0PcRR5I1b/r4v4hCyDtCi0D1Hs7L5MCl+HYdhVkiDEskGnQtZG58VjHdUrWqOYV6QH5i1/tOuea9aLeSkAoEWno9qeQVf3S+5EGMIu8a6ehp+dgOr61FzoUUEpIuvVy5yzwONRxLc7ke22E9Ygsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782621424; c=relaxed/simple;
	bh=osiFwRs5hcozOwGIwTB9Ue6kC2NoziHe8ozeoRvPrm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwrR0XDrRlDeXBKF8vkZ84FF8jdu4WA+MWFrS/Ts2cAL0qEONTxhSUQASpZuc8zo049EQVs5CO26oLtCYtJnZLsUOZa+xMkeqP+RU0ZhcFbHgOmHC6ceDlkVyHt8rTnqutRygI72PI43fuw4c885hq7x5jQsEjL0OPPtx06G8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=TZwE37pO; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="TZwE37pO"
Received: by dvalin.narfation.org (Postfix) id 664F41FEF7;
	Sun, 28 Jun 2026 04:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782621414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UO1X4md2YCOfX2DvdPc01Q2k2MNAJvagKZJHgX02ViU=;
	b=TZwE37pOfKZN0vW1pWgf25EOHiLAy/78FcGCr6LEa2udanaPsVsIV+zDYuj32C+QsVJODt
	OBnZLS43OH460qVpg3Nt7ih+9uUfLeE1pACEnVkwhAR9/BhChKFl4wDxF4zqRCB3Zp08Z8
	8g5vfExgDUUP2Ipw4Q8aK2Gf9mFQVXY=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 7.1 00/26] batman-adv: 7.2 merge window fixes backports
Date: Sun, 28 Jun 2026 06:36:44 +0200
Message-ID: <2075326.PYKUYFuaPT@sven-l14>
In-Reply-To: <20260628032401.0002-1-sashal@kernel.org>
References:
 <20260626161241.124988-1-sven@narfation.org>
 <20260628032401.0002-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23186641.EfDdHjke4D";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart23186641.EfDdHjke4D
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Date: Sun, 28 Jun 2026 06:36:44 +0200
Message-ID: <2075326.PYKUYFuaPT@sven-l14>
In-Reply-To: <20260628032401.0002-1-sashal@kernel.org>
MIME-Version: 1.0

On Sunday, 28 June 2026 05:33:32 CEST Sasha Levin wrote:
> I just fixed up the backport on patch 10 (and for all other trees).
> 

You are awesome. Thank you.

Regards,
	Sven
--nextPart23186641.EfDdHjke4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCakCk3AAKCRBND3cr0xT1
y96wAQDAEjrN9ENEElWqq47N6Z71hpaE6XObBcvviW4Nl8bKKgD/ZSJrJEtZkeio
HJzgJ+mo6tdcco2VzGIT/+0/A8r5Rwc=
=olgh
-----END PGP SIGNATURE-----

--nextPart23186641.EfDdHjke4D--



