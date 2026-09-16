Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E35469830;
	Wed, 16 Sep 2026 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789547566; cv=none; b=AySOddGIic4RoHEjMW+IXlyD9Ge7BS5kotAf1KhpuPWv0iY7LxAT/xNmEkGLaH2xpp7BKWzKpWjIJcYX5E8K+VugmK1gr1ai9FeJmz03TpaFQCzagLdrrmTfNm8AhVQXoUpBG/5QY3v8s42SbwQBTEtUa97MmmR0s90gD0i5mZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789547566; c=relaxed/simple;
	bh=6bMl1Uhl9Yw2O/P7sN+LnmPt8iT8vA3apyVKRZj5k0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WQSmDAqVSfa+k9Bv/KBSPsjczeQtF/rR8IU5jt4hj9MUR/fYMf/SmjxyrCfnYRlLR6LF3l9Ucg0OfmOZmA6mPqsSxluaMmRwH6hmTMV6QmL0HqdF+j9Jk786qc7cUJqQ9D8kGXbc9eAMcjEke7Az6a3sIJZasKQNq03qqgkSCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hJ0cJS5T; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hJ0cJS5T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6bMl1Uhl9Yw2O/P7sN+LnmPt8iT8vA3apyVKRZj5k0I=;
	t=1789547563; x=1790757163; b=hJ0cJS5T5Y4jDz29qzbkku/9wGOkL0bWpWBfoNey+a2IHUW
	CSUEH3M+J1C1HN9glW5+RaZEgLSRz5YRqFVPRVocTUHnnCVGIQz8vZuSo/NAIUdZ2s8COKK9ypys3
	6hKpq5LHZbCS7RiosIeImyoprre0mej9AlUO4qLuNEfr0SfiOODt2vmPL96SdRMDDKTabXsCAMplX
	y4slN8QEoD8khR+wL1D4g0Dd5YuGpq6iYW8e4LbUcxuqt3hHesj6hoFG+T4F0KytoVlYpNDx9EU5o
	L7+f9Z/T0IxLw3S0PsbhohIMNyfaswSgGV+dDyOQ2TUuwZhom397FHPBsAatbulw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x6l4J-00000000Yum-0PLE;
	Wed, 16 Sep 2026 10:32:39 +0200
Message-ID: <b07d37cbb90b6132df0aebc1c603bad903d8d0cb.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Report port_authorized for
 4-way HS offload
From: Johannes Berg <johannes@sipsolutions.net>
To: Janne Grunau <j@jannau.net>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, Hante Meuleman	
 <meuleman@broadcom.com>, "Gautam Shukla (Gautam Kumar)"
 <gautams@broadcom.com>,  Kalle Valo <kvalo@kernel.org>, Pieter-Paul
 Giesberts <pieterpg@broadcom.com>, Jason Huang	
 <jason.huang2@infineon.com>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 16 Sep 2026 10:32:38 +0200
In-Reply-To: <20260915190527.GA212312@robin.jannau.net>
References: 
	<20260912-brcmfmac-4way-handshake-offload-authenticated-event-v1-1-e41a6a8281a2@jannau.net>
	 <3422e0b3b7d4889d2a728c41b0b02f6c80fa71bf.camel@sipsolutions.net>
	 <20260915190527.GA212312@robin.jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-09-15 at 21:05 +0200, Janne Grunau wrote:
> On Tue, Sep 15, 2026 at 03:22:50PM +0200, Johannes Berg wrote:
> > On Sat, 2026-09-12 at 11:40 +0200, Janne Grunau wrote:
> > >=20
> > > This will conflict with the "brcmfmac: add FT/OKC roaming offload
> > > support" [3] series but is written in a way to easily resolve the
> > > conflicts.
> >=20
> > I ... no, I'm not going to take that conflict, and I applied the FT/OKC
> > series to wireless-next. Please create this patch on top of wireless-
> > next, if needed at all, and then you can backport something later to
> > stable if needed.
>=20
> That is very unfortunate. I hoped this change could merged as a fix for
> 7.3.
>=20
> The change is required. wpa_supplicant 2.12 (and unpatched 2.11) will
> run into its authentication timeout and disconnect WPA2/3 PSK networks
> on brcmfmac devices with firmware offload support.
>=20
> I'll rebase onto wireless-next and send a v2 but I think it's serious
> issue in the process that it will take until after v7.4-rc1 (7+ weeks
> from now) before this fix will land in stable kernel releases.

That process issue is yours - wpa_s 2.11 was released *well over two
years ago*, and nobody cared to fix the issue since. AFAICT this could
have been fixed in kernel 6.11 or so, but now it's suddenly urgent
enough to make life more complicated for everyone? ...

johannes
