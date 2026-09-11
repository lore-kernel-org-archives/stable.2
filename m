Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37602C235E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130473; cv=none; b=lcIxTc4wxTRi4UWickSmRKCbrasnydb15+KAYVbDEP2YbQmiknpOv0Lz8zsJ/vRBmOHCcqqBeRqVRzSUHKNTsHGSqIn7gzesJ/uYrl2I1eij25dJVlR0h8oQSgYMpmAB5WesubX9CRs9AOmw9CS2iVQc8eGZriVsdDQL+A0TKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130473; c=relaxed/simple;
	bh=ZybSQFNcD5yG78sFMI/jtRmQl92ynI6dP9IUqTyMgl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrAQalJm/J5SUiHDSpFxgk0L7wwvB2Ctm8R+EHWrSQUp7ohEHcb+jvsRd72EGYi3M4VSTcewI3OAXc64iixZGc3ISAe+5NiT4ujznyMvr/NagNydaa4w+uyjEHShOnLIF/A6NPGqZLhCoDLsR6uMah7oEvHq43hajrx/BUb+VDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=KVK4JTZJ; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="KVK4JTZJ"
Received: by dvalin.narfation.org (Postfix) id 149AA2043A;
	Fri, 11 Sep 2026 12:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1789130464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G1H366am7EZuAabvqpFxCIlx+4vKpSZriexNkOdrdu4=;
	b=KVK4JTZJBL4DTb2pB95z5gi4j+2R2we4USh80sWdJmuL5YV7H1F5mjjiYZ1KrbkqmXjeSA
	eHqit3EFybYh62rxZVkbfoQGtxm03zeO59f01aX6QOqc3Ke6J+k+OHp8qAUXEOW3JrdBMc
	GOEJsdmyzZImXCVsfe9xNQ4EYvelT40=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 5.10.y] batman-adv: dat: atomically update mac addresses
Date: Fri, 11 Sep 2026 14:41:00 +0200
Message-ID: <2201888.KlZ2vcFHjT@ripper>
In-Reply-To: <daily-reply-0014-re-batman-adv-dat-5-10@kernel.org>
References:
 <20260909191652.1174815-1-sven@narfation.org>
 <daily-reply-0014-re-batman-adv-dat-5-10@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2769211.k3LOHGUjKi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2769211.k3LOHGUjKi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Date: Fri, 11 Sep 2026 14:41:00 +0200
Message-ID: <2201888.KlZ2vcFHjT@ripper>
In-Reply-To: <daily-reply-0014-re-batman-adv-dat-5-10@kernel.org>
MIME-Version: 1.0

On Friday, 11 September 2026 13:20:33 CEST Sasha Levin wrote:
> > commit e6de568d3eda3e3c01c868fabd7a9535d5ee4a73 upstream.
> >
> > When a MAC address is updated in batadv_dat_entry_add(), it is done
> > using a simple copy function.  A parallel reader might only see parts
> > of this update.
> 
> This one had to come back out of 5.10.y. It applied cleanly but broke the
> build:
> 
> net/batman-adv/distributed-arp-table.c:901:53: error: format '%p' expects argument of type 'void *', but argument 4 has type 'atomic64_t' [-Werror=format=]

I really should remember that the 5.10.y needs to be tested with debugfs too. 
I should not sent out patches until next year or create a really big post it.

I will post a version with the debugfs portion changed. Thanks for the error 
output.

Regards,
	Sven
--nextPart2769211.k3LOHGUjKi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaqP23AAKCRBND3cr0xT1
y1ndAP4lVIUMHnW47QGEqixgOF5uRfyLwNK6Vb0dGJqQBfMWvwD+Je3mnI9DmVb7
+THl995iwnzdrs6Mr/ZxE4KTVaQFJA4=
=Nlwq
-----END PGP SIGNATURE-----

--nextPart2769211.k3LOHGUjKi--



