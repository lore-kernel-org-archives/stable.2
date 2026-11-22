Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795333175;
	b=Usl3MCCZ+uTHAT/RCH9pbzXXdMHm5EARMXzw0qyAszQCdh3IPhq/e9bu0T4OZOt4E9FS
	 M6oGyiLaXaPJoizwjkkNIgS54cXwvJxTQeI+nl+xcU1QWBueNoU4m2Q85DkEcjeHa1JwF
	 kC94xONnso//F2oS9Kf0z6HubgZLhg+GBgs9+8KX6EJDwnVmeAhNnBLPfhupuOlzSPZTb
	 wdEioNolkY+yNqepkvbn49i/rtlb24LAeT4mqqpWFD1f5Z0AaMbrMWk1X395H6RjD6UCj
	 5RwBPCUIrS5pXJW0NRJljCwAtEyijUvOKb7HHwppIHDWhcoVX+2/aafIBv0KcdZfu7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795333175;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type;
	bh=bGJ0He+CFqKKITgfeT5yY/QNsxp8dPrI9FvnnrbFMIE=;
	b=ZAvWFPsWt6MVNK+nlRei6ECS0S3jG36BXlKLcRZeUBv0OwsWAYqkcDpbJfdWChZeWMbj
	 9jon5Kqwa0UAlPr7AvllO8tGmmS3H1gnJ+GSh7lxTYLnWsaoaFNGUBw5l9ZRoIyZq44AB
	 eSyE3VFlY/Ln4wvdlOncdCbW32CXJAe51kLvOVSfXgAZMpABeswHXnYQ2tV2Q1UPM2Ric
	 BrB4lcjnLtQ8ZE8Q+gsEMwWg/flGy/6T1Flp+Y0rWGXizuqG0tJolOFfwoeRQY1e0UshD
	 I2pIPXem4esfTvq9h7DlpyClr9ls4+F4R/78zCJBSe9+2VoEQHFWwSbiwTmHhW6lL7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=Kw4HI3RR;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C785606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C785606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=Kw4HI3RR
Received: by dvalin.narfation.org (Postfix) id 739091FD16;
	Sun, 22 Nov 2026 07:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795333167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGJ0He+CFqKKITgfeT5yY/QNsxp8dPrI9FvnnrbFMIE=;
	b=Kw4HI3RRkoJTYQmYG7XSon0MSE9h/iL8rAfrNY3mu8tZ0lrbF9lUKIHaQGvzKsdoLPGPR5
	kzjqOOPMH/fDYvcvGsOXUM2RsbjWEKi/Nhc/FDDGYhB1epANxzpwvpFylPp3d5UEc7jfw8
	4s9l2IefvdkZs3WZGgxj9PUfFgF911Q=
From: Sven Eckelmann <sven@narfation.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, sw@simonwunderlich.de
Subject:
 Re: [PATCH 5.15 0966/2214] batman-adv: tt: send ROAM_ADV on each roamed back
 client
Date: Sun, 22 Nov 2026 08:39:20 +0100
Message-ID: <3073076.e9J7NaK4W3@sven-desktop>
In-Reply-To: <2026-11-21-2-daily-reply-0020@kernel.org>
References:
 <254e49b8-c3b9-41b8-8692-bd5d9f04f7a4@oracle.com>
 <2026-11-21-2-daily-reply-0020@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3443466.aeNJFYEL58";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3443466.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Nov 2026 08:39:20 +0100
Message-ID: <3073076.e9J7NaK4W3@sven-desktop>
In-Reply-To: <2026-11-21-2-daily-reply-0020@kernel.org>
MIME-Version: 1.0

On Sunday, 22 November 2026 04:39:03 CET Sasha Levin wrote:
> > Maybe we should take commit bbfb0d2cf035 ("batman-adv: tt: remove only
> > the entry which was looked up from the hash")
> 
> bbfb0d2cf035 needs its follow-up 597c0f2f69c0 ("batman-adv: tt: only
> queue local del event after successful unlink"), and that one doesn't
> apply to any stable tree: batadv_tt_local_remove_now() only exists from
> v7.4-rc1. So I haven't queued either of them.
> 
> Could someone send stable backports of the two?

It basically requires most of the work which went into v7.4(-rcX) - which then 
triggers the "AI" to request stuff which is pending in net-next and this is 
then triggering the request for things which are pending for net-next in 
batadv/net-next. No, I will not go down this rabbit hole again.

If it makes you (or the "AI") feel better to have no back-ROAM_ADV working 
then please drop this patch. The patch is intended for normal back-roaming 
clients but not for the "I try actively to break the TT states" client and 
therefore will never fulfill the requirements of the "AI" to have a perfectly 
"consistent state TT" implementation which is simply not there (yet) and still 
requires massive changes to get there.

Regards,
	Sven
--nextPart3443466.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCawKcKAAKCRBND3cr0xT1
y3JpAQDVFfuGE92Vmr9R/KXpW6G2V/8n8GQfmV4jti1Fu246pQEA2XeNgCU4DLpB
FSxD++CzHWC3e/xtQ6X4f/inV9eg3gM=
=MSxw
-----END PGP SIGNATURE-----

--nextPart3443466.aeNJFYEL58--



