Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3043034A791;
	Sun,  2 Aug 2026 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659786; cv=none; b=V5m/mex2yguEdKMaRx5ciOeS4oIIbLuhDo7EFL+3P6DX99rQQfgW8ER7hRBwDAgpsQyr+IynUejZZugh+Fy/PxsCM9ERDYatQvUkRb5Qw8z1ddB8cgtLF/SsYrgDXFOAzxmnRBjceNQHjF7H11xkxLvUg30sYLQZKZgvEjb15Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659786; c=relaxed/simple;
	bh=LwgLUjqkQNUq67sHjlKhOBskd53B6t1g2d6OC60f3W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mu9gtUXjJ4MVTEbnEkoQIQNlIhZ9tCrM+dwO3/7tlqyYpsgFYOGuqavFEOvltl6rhKVV3SIuXk/zQdASi2bbDRNVxG7V748+gn7efH2RGf6ChS/apCfLQLrIN1Xf76637M1KSAEbT8OfFp2wVbdRtlqdK5WF1RNzOSpUeurTQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=ZClD9dTV; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="ZClD9dTV"
Received: by dvalin.narfation.org (Postfix) id 41148207F7;
	Sun, 02 Aug 2026 08:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785659779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ad0J6FY6KPPb6D0lcQ0Zz4cdOrCVu5qRzPaM/fyVHwo=;
	b=ZClD9dTVxLIHsUWk3ZckFthxsUZykaRa07oqOq36M8wkNHFShaI/q0dQweGhnD1ROVR8GD
	z3jh3KZ3e9QZbF7aTGP4FUH9nH9Yoe1+tsjKET1V8ypvmO5+TrJCuliBqX+C/wI3SLfXCf
	xCwxJxSCBEzbj4bs0K8HWjFTqhUhgto=
From: Sven Eckelmann <sven@narfation.org>
To: miklos@szeredi.hu, David Lee <david.lee@trailofbits.com>
Cc: Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] fuse: wait for sync init request after abort
Date: Sun, 02 Aug 2026 10:36:17 +0200
Message-ID: <3119647.mvXUDI8C0e@sven-desktop>
In-Reply-To: <20260731120353.558833-1-david.lee@trailofbits.com>
References: <20260731120353.558833-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13220324.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart13220324.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: miklos@szeredi.hu, David Lee <david.lee@trailofbits.com>
Subject: Re: [PATCH] fuse: wait for sync init request after abort
Date: Sun, 02 Aug 2026 10:36:17 +0200
Message-ID: <3119647.mvXUDI8C0e@sven-desktop>
In-Reply-To: <20260731120353.558833-1-david.lee@trailofbits.com>
References: <20260731120353.558833-1-david.lee@trailofbits.com>
MIME-Version: 1.0

On Friday, 31 July 2026 14:03:52 CEST David Lee wrote:
> Fixes: 204aa22a686b ("fuse: abort on fatal signal during sync init")
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
--nextPart13220324.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCam8BgQAKCRBND3cr0xT1
y5FvAP9puyWkL52tJXudP4z8FAHYMNme8+CaUql6hh1rVxVEhwEAzvAIQd666sjc
Uyf+6QR8YjiXioPLcNhoEwWaUC+z+A4=
=RD3j
-----END PGP SIGNATURE-----

--nextPart13220324.O9o76ZdvQC--



