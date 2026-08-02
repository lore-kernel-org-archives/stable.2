Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F13B7B70;
	Sun,  2 Aug 2026 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688898; cv=none; b=AqNobcKl69LfMlDeK5wjfCQAvrXe1JRC1LDu3q3Dj5cbcWfP0JItXJn4ZPUMQQxCDpBYs2py5A0WJ6HmdhPeiEdmJkszbwIxZILIFkjtV6+NOK8OH45WMRZXHfVpU2nFyMCN9N52J+WZAwHf2NxqJrPvU9GvdfWyASXzFalGu88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688898; c=relaxed/simple;
	bh=Dsv9ToNTfkNro27Oe7wkDbif42ta14qNqEfVen5SMSc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YRIZNObjD0d4wNwAs1QQn0VKg9wPiTrgemKuMidVr6v/L+Scy61ddUSVajhqejnYUf3AxHCv8zCnvGE0hg9SPRqcOSsTP2SM9n21il+ChNL5dDpZp/vDpyQkc2yuIuPeZslBJb4zkDF85HbvZ9c/jRc0O0Gs/HO2R6GS1pRPvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FG4CFAl8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FG4CFAl8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bPGgIc9tRCP+NRMoJi/ECBNBlqa5Y24UAa9mM7liFbE=;
	t=1785688896; x=1786898496; b=FG4CFAl82/efQMNo4Jcq459PuVFS+TIoSqm+yYtcgXJhvQJ
	yxtJbjPoBAVOz9C34tXoqLkZF/coav+1/YtioIb2DT0bKsAT80Luxexyx/HnhgPZo871fVNF68wU7
	KEfsnZvyylhU3TuW1/Ku39KRmUoST43zAP+OJhQOrd/DNzxftgHQwvdvK6DRmck8vO22yYD1Xqj46
	l0D/YX1uN0BCTSHAE+9k5Lip1O4Id0iYYXybx17KvNDAwFT9ulV/j5dS47YLNInafWsivHluF9gwO
	6JO1b/pSLZHeDw91ClCCBDpwiQ0EEXlNntZztEUkJuUgF41OUL63ATVdaHTZo4DQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wqZFl-0000000DwAD-1fz7;
	Sun, 02 Aug 2026 18:41:33 +0200
Message-ID: <e059b52701d3cad4480dfb506e61474924b9f29e.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: brcmfmac: Fix memory leak in
 brcmf_sdio_read_control()
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Abdun Nihaal
	 <nihaal@cse.iitm.ac.in>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Sun, 02 Aug 2026 18:41:32 +0200
In-Reply-To: <20260802083905.3819981-2-arend.vanspriel@broadcom.com>
References: <20260722110713.115988-1-nihaal@cse.iitm.ac.in>
	 <20260802083905.3819981-2-arend.vanspriel@broadcom.com>
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

On Sun, 2026-08-02 at 10:38 +0200, Arend van Spriel wrote:
> On Wed, 22 Jul 2026 16:37:12 +0530, Abdun Nihaal <nihaal@cse.iitm.ac.in> =
wrote:
> > The memory allocated for buf is not freed in some of the error paths in
> > brcmf_sdio_read_control(). Fix that by adding vfree() calls.
> >=20
> > Fixes: dd43a01c5cdb ("brcmfmac: use dynamically allocated control frame=
 buffer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> > ---
> > Compile tested only. Issue found using static analysis.
> >=20
> >  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 3 +++
> >  1 file changed, 3 insertions(+)
>=20
> To be applied to wireless tree.

I'm going to put this into wireless-next, at this point (-rc6) this just
doesn't cut it, the commit message makes it sound purely theoretical.

johannes
