Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2703B14D4;
	Sun,  2 Aug 2026 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689083; cv=none; b=DqHCMTYPujezqH9D91WKYxZ5EZegOAPa1LCy/TQr4/OiwlukNh/d236cIlEJyFh2+v4tzRFTHpOdDOxLmxSDuTrMjbAWZiZyuXXmCDZ5A2NyMtygayJKX3ks1gFCOprAp3J5VqlSnH+RxmvSVNyiO+1kdwX+q4CFRa7jT5a6rdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689083; c=relaxed/simple;
	bh=ud4vT+e2j9Ob/tFcw11ih0csrD+GjTQLdgbkBjEU3MA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxGJgjVOTzYF/dbUHiUmUe6+ZgnZWQcV+feUdKGcrNEiOcIsVpzLnrN+PqNhTP6fAXGacZK+D6WMUn1XRcvDwnhAlvau/GkCxXvumT+Uft6OWjYMes7a8f78jrFSRlw80AkDsrsdt1pYdA1SSgFBTaH7RA90U0Mi3dO7AHf5PoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=w3U/XZyX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="w3U/XZyX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zC4AhMh7ol+PrePXq4QYAm34GA0EeXjZGTiE2KymlTo=;
	t=1785689081; x=1786898681; b=w3U/XZyXI9w6duJLV1u0c7KwF5+3HmUsgQYemQ5nctglkTp
	aaAW+1t75NZ7hzMRmhg8uwNwn0iSv31Xc617GKKyiot0ifCEjX5T6Pjp+jI8igxr97EKwKew7KHaz
	Kc5WZhBsAshlBeVsnFPk7xLydWGo/2mkWHdS/u4MjcMpPKJf/+3XBwqqH/w/OTE33KTJilA+tuFQm
	vxjZ3e7u9Xf3Yt5LpUQPN5g3+UT4r2xmtkYkcQ1kbpHapOaBRw97Z95ZnqUjZQGk5D7mOMmAkQ1tM
	RaQqIx7rJ72qUfOYeKenIwj09CVpnEjgYMrPcBpNW5ZlLrMV+WmWzuiC8Q1HE/sw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wqZIk-0000000DwEd-2ATY;
	Sun, 02 Aug 2026 18:44:38 +0200
Message-ID: <6648c1d61a44ad732550ff20c0b1aecaa43676f6.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: brcmfmac: Fix memory leak in
 brcmf_sdio_read_control()
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Abdun Nihaal
	 <nihaal@cse.iitm.ac.in>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Sun, 02 Aug 2026 18:44:37 +0200
In-Reply-To: <e059b52701d3cad4480dfb506e61474924b9f29e.camel@sipsolutions.net>
References: <20260722110713.115988-1-nihaal@cse.iitm.ac.in>
		 <20260802083905.3819981-2-arend.vanspriel@broadcom.com>
	 <e059b52701d3cad4480dfb506e61474924b9f29e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2026-08-02 at 18:41 +0200, Johannes Berg wrote:
> On Sun, 2026-08-02 at 10:38 +0200, Arend van Spriel wrote:
> > On Wed, 22 Jul 2026 16:37:12 +0530, Abdun Nihaal <nihaal@cse.iitm.ac.in=
> wrote:
> > > The memory allocated for buf is not freed in some of the error paths =
in
> > > brcmf_sdio_read_control(). Fix that by adding vfree() calls.
> > >=20
> > > Fixes: dd43a01c5cdb ("brcmfmac: use dynamically allocated control fra=
me buffer")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> > > ---
> > > Compile tested only. Issue found using static analysis.
> > >=20
> > >  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> >=20
> > To be applied to wireless tree.
>=20
> I'm going to put this into wireless-next, at this point (-rc6) this just
> doesn't cut it, the commit message makes it sound purely theoretical.

Actually, I'm not even going to do that - sprinkling vfree()s over the
code when moving the one that exists would be sufficient is, and I'm
being generous here, not a good change.

johannes
