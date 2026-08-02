Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205343921FA;
	Sun,  2 Aug 2026 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785660377; cv=none; b=RSU4DhBm6foF9Nyou9FVGKSvqcqvYP3fJAWBINbgAZy7ZCIO0Yt4II8UpZ9Utufd6ppDrhmMt+KMcUTCR5V+oYHxIvsLBWUzF0rLb9B9q3bSw86S7hhvU/DVD0XABWS5hVluAE7dgTcnSQ194xW0Eq64Tfci9CV6AslxOacGxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785660377; c=relaxed/simple;
	bh=o3LeybA06lYiSr6bJJ1QdBAom8CkwEsciaADoEdDPDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khb59slHIyqcZaA20p+rqokiZlNl2vjHlPHj9z/rYJ1YiXotxji3GXDTKp7UblgZK8L08VEwftMopO8B/1fZiDLTgWW1eUtZjSPHlg38Be+UhmEYfK4p+1xPZ16lgvZ1edYVTX+Pb7HqdRTTcjsL9l26XY3bhh68ExXzZwUpeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=TjDJ5vhm; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="TjDJ5vhm"
Received: by dvalin.narfation.org (Postfix) id 6EB0D1FFF2;
	Sun, 02 Aug 2026 08:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785660367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jaWkTsruOUYnQJYEKZyhk1rUbK2SnP3vO1ZzJwOZd9M=;
	b=TjDJ5vhm+U8yvYsJwm5dhP4stlAEpYt5lG7oJjUZWWlyhvhcBBYlioL/VSBPWpwssbMXaJ
	gTjjBUry8wkkOeVVHzfoKTnWjfH110y8y5opWhT9WykOVzYcVtEebcTgp96XzCC8rSdvQV
	jJvFoHfn+5LaW/QU+QjrCw7ItK4u2Dg=
From: Sven Eckelmann <sven@narfation.org>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, David Lee <david.lee@trailofbits.com>
Cc: Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vxlan: keep the last remote linked during FDB flush
Date: Sun, 02 Aug 2026 10:46:05 +0200
Message-ID: <3985450.iIbC2pHGDl@sven-desktop>
In-Reply-To: <20260731141311.570187-1-david.lee@trailofbits.com>
References: <20260731141311.570187-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9932979.CDJkKcVGEf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart9932979.CDJkKcVGEf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 02 Aug 2026 10:46:05 +0200
Message-ID: <3985450.iIbC2pHGDl@sven-desktop>
In-Reply-To: <20260731141311.570187-1-david.lee@trailofbits.com>
References: <20260731141311.570187-1-david.lee@trailofbits.com>
MIME-Version: 1.0

On Friday, 31 July 2026 16:13:10 CEST David Lee wrote:
> Fixes: c499fccb71cb ("vxlan: vxlan_core: Support FDB flushing by destination VNI")
> Cc: stable@vger.kernel.org
> Bug found and triaged by OpenAI Security Research and 
> validated by Trail of Bits.
> 
> Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

1. weird text (advertisement) + newlines in the tags section which shouldn't be there
   https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
   (and all these tag/format related sections below)

2. author didn't sign off the patch (see below)

3. odd unrelated Signed-off-by without any obvious connection to 
   the patch

   - I actually would guess that Kyle Zeng <kylebot@openai.com> is the author 
     and David Lee removed its authorship (From: ) before sending the patch.
     But in its current form, David is claiming to be the author. And even
     when it is the case, David must still add the the non-Author SoB at the
     end.

Regards,
	Sven
--nextPart9932979.CDJkKcVGEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCam8DzQAKCRBND3cr0xT1
y/+qAQCYO4/lgKSB5RXFbhwe2OfZJ8YYWHysLHcT8VcoxUvMEQEAgAhp3V7DH+ri
07OdGLw0XpRnWcRbJs/1+Ey+DckTvgY=
=yCaE
-----END PGP SIGNATURE-----

--nextPart9932979.CDJkKcVGEf--



