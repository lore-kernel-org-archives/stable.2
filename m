Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6C389106;
	Mon,  3 Aug 2026 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747440; cv=none; b=aeSftJe5ZlMbxYCuTJaeEPNX3FgDMRmMIG/mR1dNmsYNU/FyJC4UMH8FzrhA/9WL3PVVK6v6AJe/m8UDL/EbFUFn7Bu4A9UfGKZb6FpPYW3bem1v+CSv8O9+CnAEN4tSPz4+feCkmVbjJjINjzF+3QdL0Wz0e6HB/M0VFVt89SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747440; c=relaxed/simple;
	bh=HDON8GFNlrgcg6jLvqJQgS3YW4Y5ljIBsfULOebfcKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=peDvURbdveyw0HNNo6CkJnD9oxDjkIn5qzFNLS1udBlGWmWSwZLGKHPiw3+CiN3tJ3vNCMYtQ12A0YwqcYZMS7npfYOPX4+GFHEba1+KV//6VQMRQgJ5CtedFoyBnuLInGE9LO6Q6q46MhJ3SNJ7mtm81/Bu4TmJ4YG2eHmCG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IJR2foV5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IJR2foV5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KQhbPjL0Cwy9FGeO2wW7tXyf6su+oC6HvjL0ynDvWO4=;
	t=1785747439; x=1786957039; b=IJR2foV5t8uXLLb23JdcfcJI5ZIljnO7OexRqQ3DfSO4JuK
	ojv8luTo50+x//D7h6cUSirroiRA/nsJ4sfCw7twSET+tgQt9B3dXo2XHYKTL1wVDX19vrjXEM8Hv
	/b8z8FZcw9qlUyskDKETtAGgUCz7smMbiG0DALpbGO6/t6qbz2aUB6PUcsEaiJfUJw0gqTSRHTI2K
	fo70OVTvNiNo3aAL7LxfFtxcEQh3M03pcSB5+VTnB5uFLwVpJioE8y4s4kiXOEIaJi8MbZbemXM+2
	JeJNPGSmUOWmQK4Hq9AAFtdXFGCRV1V9R8615QRV2OIYn/IHpHN6WeFVb2NfonAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wqoTt-00000006S3B-2uJb;
	Mon, 03 Aug 2026 10:57:10 +0200
Message-ID: <0f7c335c9c1350ed7ef36bc6b633a2b800c44d31.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: brcmfmac: Fix memory leak in
 brcmf_sdio_read_control()
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Abdun Nihaal
	 <nihaal@cse.iitm.ac.in>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 03 Aug 2026 10:57:08 +0200
In-Reply-To: <c5aad785-8d7d-4015-a3c9-1f70f2a69579@broadcom.com> (sfid-20260803_105505_078678_6131A81D)
References: <20260722110713.115988-1-nihaal@cse.iitm.ac.in>
	 <20260802083905.3819981-2-arend.vanspriel@broadcom.com>
	 <e059b52701d3cad4480dfb506e61474924b9f29e.camel@sipsolutions.net>
	 <6648c1d61a44ad732550ff20c0b1aecaa43676f6.camel@sipsolutions.net>
	 <19fc626a040.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	 <c2589f1c-c754-4282-815b-df64f0250623@broadcom.com>
	 <e628d43a4aca1763cafcde41338cf7a34fe57d6c.camel@sipsolutions.net>
	 <c5aad785-8d7d-4015-a3c9-1f70f2a69579@broadcom.com>
	 (sfid-20260803_105505_078678_6131A81D)
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

On Mon, 2026-08-03 at 10:54 +0200, Arend van Spriel wrote:
> >=20
> > Or just something like this?
> >=20
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> > @@ -1827,15 +1827,17 @@ brcmf_sdio_read_control(struct brcmf_sdio *bus,=
 u8 *hdr, uint len, uint doff)
> >          if (bus->rxctl) {
> >                  brcmf_err("last control frame is being processed.\n");
> >                  spin_unlock_bh(&bus->rxctl_lock);
> > -               vfree(buf);
> >                  goto done;
> >          }
> >          bus->rxctl =3D buf + doff;
> >          bus->rxctl_orig =3D buf;
> >          bus->rxlen =3D len - doff;
> >          spin_unlock_bh(&bus->rxctl_lock);
> > +       /* buffer is queued */
> > +       buf =3D NULL;
> >  =20
> >   done:
> > +       vfree(buf);
> >          /* Awake any waiters */
> >          brcmf_sdio_dcmd_resp_wake(bus);
> >   }
> >=20
> >=20
> > It's already using vmalloc() so seems it wouldn't care that much about
> > calling vfree(NULL) on the success path?
> True. And yes, the existing vfree() should go, but I figured that goes=
=20
> without saying so I did not mention that. I am fine with your proposal,=
=20
> but I guess the author will have to submit a v2 patch, right?

I wasn't going to do it myself, but I guess I don't care who does :)

johannes
