Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA93F5BF0;
	Mon, 17 Aug 2026 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964064; cv=none; b=I50aDmOAEIpKwvA7ehHb3AE+390H3rriqAm9ai9Lwb3zfy9seictUUtTp5curJnevubWJcIOBVmhtLYcHU5n3kEfaaYBPKcjRZvrEdbj62FZK8vfbCy3zBSdCBGklZgTQnY2NgsPWZlj6fCHGVkU1ehLcglPaYubvR0k4oRmmLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964064; c=relaxed/simple;
	bh=SzsrJXSXDcIL1uc9QD4gqOrgXHo+/QoIwZq3b1Ipnzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRmxIPmcStjNkx/zLQBH+5nEhPAZZVEqMY/L453mjq/DnF1R/vED6+ylCBR9GD8TghjU1esQT/RrgXFD8VfFnnaWJzGivj9ptZZDsBysOs2g8iK4vUOjX1kvCEocBFSLt4EN38Pn4s/r3iDuhm4wkEJz6IRiJnAzTeykf21CCJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=T7lqvcJE; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="T7lqvcJE"
Received: by dvalin.narfation.org (Postfix) id A23A21FE13;
	Mon, 17 Aug 2026 10:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786964049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJ8WBa2jvYvoCXiVxlGZwnT/sE+UmDdw+JRzkjtj2l4=;
	b=T7lqvcJESzVnxMZ7x6/tHFT/25848gHtGdfZAsjUSVprUxa64j47dTBvfyQZOkN8Rgz0yo
	+QpbIJFY2q5RZHU8enCIm7VUw4kn+djYQDZ1MmX7Vd56LkVCrn5Ec4dEbcULkR6VHJiAfR
	AiiBwKd+hBjeBwlpP7e9EgC/0U0tEbI=
From: Sven Eckelmann <sven@narfation.org>
To: David Lee <david.lee@trailofbits.com>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 Kyle Zeng <kylebot@openai.com>, davem@davemloft.net,
 linus.luessing@c0d3.blue, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH net v3] batman-adv: reject unrepresentable multicast TVLV offsets
Date: Mon, 17 Aug 2026 12:54:02 +0200
Message-ID: <6020830.DvuYhMxLoT@ripper>
In-Reply-To:
 <CAC_etQHifs5Qo-syD4pF+OPkKZFwHoNJFsLdjQsQcm3=_PyydQ@mail.gmail.com>
References:
 <20260817084955.944189-1-david.lee@trailofbits.com>
 <178695824178.1497243.16045312752677179315.b4-review@b4>
 <CAC_etQHifs5Qo-syD4pF+OPkKZFwHoNJFsLdjQsQcm3=_PyydQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6296243.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart6296243.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: David Lee <david.lee@trailofbits.com>
Date: Mon, 17 Aug 2026 12:54:02 +0200
Message-ID: <6020830.DvuYhMxLoT@ripper>
MIME-Version: 1.0

On Monday, 17 August 2026 11:41:53 CEST David Lee wrote:
> Hi Sven,
> 
> Looks to me like you've also dropped the
> Suggested-by: Sven Eckelmann <sven@narfation.org>
> 
> This was by mistake, would you want v4 to be sent out
> with the Suggested-by line?

No, not needed. Just wanted to document what I found.

Regards,
	Sven
--nextPart6296243.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaoLoSgAKCRBND3cr0xT1
y7quAP9Ifbia1KyXmtLtw69lytNqlJYKiQ+IGptNxxp0dyE13QEAgdja4wi9SvFe
cg9eeBbwvS6/4ygt8em9s3G2nMIh7wo=
=QdLk
-----END PGP SIGNATURE-----

--nextPart6296243.lOV4Wx5bFT--



