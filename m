Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B383B2FC8;
	Mon,  3 Aug 2026 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746145; cv=none; b=hneix6RzSifmmAyzhGPaSa6/mH941+CIntRIXFKDi4M9Lih5OE7DizxafRwkWwm/yCNEjdV0dUM3d3qvlVPnjf4I7NtBdn+1awEkfpm2BkQabGKa5By1sfF7ZsySaRDFfl/bYC/0PtVJ3K1a3eEXWab5hitQZeBXmB2sDY/bYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746145; c=relaxed/simple;
	bh=yWnjSS9vKXPJ84pKJJ0of6r86pbCS1H32ygisOLc57w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WSMZGC8470CG3XPocZpJSrkjBRRqN0xPSe9dZqxE7/IB1N4RQDcs7ToBHQX8vUtR4nhz+3dC/29WZ+FovRvFEbKiCEiYd9YOmwMMolgcpH23OGcZLTNaGVBGezs+3xgxaDCU2eIyoYB1m6QzytXStdUUGJeX1N/LpoQy7XOyQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KEePdZ9q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KEePdZ9q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6p1m/ojTb6OKIEBFPCad5AVVmbyfw4zU7FwpLGdBjwQ=;
	t=1785746143; x=1786955743; b=KEePdZ9qnRQzNEv70BUzbcmVxN6coQXvjdsZJKcWlpahrw8
	GgpvOkj88YozoCtQf46ystPItaK3dgBvzVWf9GZYsPqALu2jzL7fM/G01SfTPhVHUeWrpwk/O30mp
	0NWTxT6puld/jVveX6XXahGUNLSNuA4Gk7t0UsxUmgVBR34Kx8GHzcWQj2GZmbwnQBE/VrcYOhl9z
	Ws4VqP34+8NczlyTv9s3u3tIPwQJ1V0ySaZVJZswa8xBwOr9YMVGYMkG0/6lZhnjbTLegQvB9+1WX
	i3fBpDF+4SAyK8UvUxghueLfL+krEoLd9PK4TMqaD7zs23oyglHH0AF6A6i3CNkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wqo96-00000005v8c-1FXW;
	Mon, 03 Aug 2026 10:35:40 +0200
Message-ID: <e628d43a4aca1763cafcde41338cf7a34fe57d6c.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: brcmfmac: Fix memory leak in
 brcmf_sdio_read_control()
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Abdun Nihaal
	 <nihaal@cse.iitm.ac.in>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 03 Aug 2026 10:35:39 +0200
In-Reply-To: <c2589f1c-c754-4282-815b-df64f0250623@broadcom.com> (sfid-20260803_102116_661427_959202E9)
References: <20260722110713.115988-1-nihaal@cse.iitm.ac.in>
	 <20260802083905.3819981-2-arend.vanspriel@broadcom.com>
	 <e059b52701d3cad4480dfb506e61474924b9f29e.camel@sipsolutions.net>
	 <6648c1d61a44ad732550ff20c0b1aecaa43676f6.camel@sipsolutions.net>
	 <19fc626a040.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	 <c2589f1c-c754-4282-815b-df64f0250623@broadcom.com>
	 (sfid-20260803_102116_661427_959202E9)
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

On Mon, 2026-08-03 at 10:21 +0200, Arend van Spriel wrote:
> >=20
> > I looked at moving the vfree() to the done: label, but the code also=
=20
> > gets there in the success path to wakeup waiters. In the success path=
=20
> > the buf is stored for further processing so it should not be freed.=20

Hah, my bad, sorry!

> > Maybe better to do:
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_bh(&bus->rxctl_lock);
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brcmf_sdio_dcmd_resp_wake(bus);
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> >=20
> > fail:
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfree(buf);
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Awake any waiters */
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brcmf_sdio_dcmd_resp_wake(bus);
> > }
> Actually it turns out brcmf_sdio_read_control() is only called once so=
=20
> the brcmf_sdio_dcmd_resp_wake() can be taken outside the function.

Or just something like this?

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -1827,15 +1827,17 @@ brcmf_sdio_read_control(struct brcmf_sdio *bus, u8 =
*hdr, uint len, uint doff)
        if (bus->rxctl) {
                brcmf_err("last control frame is being processed.\n");
                spin_unlock_bh(&bus->rxctl_lock);
-               vfree(buf);
                goto done;
        }
        bus->rxctl =3D buf + doff;
        bus->rxctl_orig =3D buf;
        bus->rxlen =3D len - doff;
        spin_unlock_bh(&bus->rxctl_lock);
+       /* buffer is queued */
+       buf =3D NULL;
=20
 done:
+       vfree(buf);
        /* Awake any waiters */
        brcmf_sdio_dcmd_resp_wake(bus);
 }


It's already using vmalloc() so seems it wouldn't care that much about
calling vfree(NULL) on the success path?

johannes
