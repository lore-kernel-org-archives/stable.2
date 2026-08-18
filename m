Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DF047CA99;
	Tue, 18 Aug 2026 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070302; cv=pass; b=bYJsAqzJJ8JGg1kizEulW+dk7fbrmfN1Vda6t4GUhxFKmAG9apDiK/o41eBZWNJSN1iBZYYKaIAsNVI9fnuiGMuQzj7xEwlNPGQMxYXezfKDkiRWEiO0T+ntCDOR/0hd9CXCtrjvY0/KFn4eUrx5evnBH9uy1R0uKlk5Bf/vMfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070302; c=relaxed/simple;
	bh=HkX+A8fbDBXs4ynMVwSa7jLIITve2KmEtJpFbFgLdPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOjpWfHyEEf6lnRi1IAuvItpSW9fj1pPE1BwE/lxNFzm+Ru7ogt70P5PdNwDA1xcUVbgnVcH688tBmRTqV3++yDNFkke9+fWHUYuDc1oVZndFgnOH/pVa7OQK1yrS/GNYELbEqGR+f0jqo4xXLhecP/7LZoOL+/sOKHcEbihvFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=atY4DfeV; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="atY4DfeV"
ARC-Seal: i=1; a=rsa-sha256; t=1787070281; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ee6ajLy9zDS8QYvW+k/VA87jAK+oeLcILanqeHLaSQfuzSa8DsmJt6OsmtT7WxL0GhODXLndIV1fU0VPxiT9+V8SMvT8hABAwk+IuvySA/5owNx16oUAzNg8uIJnhEEzwPdpXytnMRqpPPe0PmzOkrhCNbu81/p3ZOk1smBmJR4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787070281; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oAKvOX4PFcRaataemJ49GMvXzzjgcRbVJQZ0nhoT50U=; 
	b=CablqBn88tJ7a0cUCbXeu8hQVhxc3XK+xlihP2McDg/ujGzlT5Z6rePxb4zszmQbkyhUgaD8A1CaDVTwmkKzELtVSx+xfQj4zUPxzH8hWtUcXAt2od449eDhQF5OKgm//KXdyldVb2oh68duVmv47n8NhCcHNoxuTEDMQKP3f8o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787070281;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=oAKvOX4PFcRaataemJ49GMvXzzjgcRbVJQZ0nhoT50U=;
	b=atY4DfeVz8W7ROz8xSIkRN75tplWUg4BGmBqYptbUuiwO38JDXsyVCbFnCVzSSHH
	skmc9aq3IVIyxEQAELA0NMwD4oWHPUxvOyYMvmKN8urCCxVmgG8/Jd/In1+4OVHl/7U
	r1R5G1ZCOLCcN7z4Eetj9o26Li95/RDzpqTK99sQ=
Received: by mx.zohomail.com with SMTPS id 1787070279232254.45731234932612;
	Tue, 18 Aug 2026 09:24:39 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id C75E3182034; Tue, 18 Aug 2026 18:24:35 +0200 (CEST)
Date: Tue, 18 Aug 2026 18:24:35 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>, kernel@dh-electronics.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: mux: Fix typec_switch_match()
Message-ID: <aoSFjbydIiu4KyW0@venus>
References: <20260817182302.146546-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="55cu3hflvddctikp"
Content-Disposition: inline
In-Reply-To: <20260817182302.146546-1-marex@nabladev.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/287.45.26
X-ZohoMailClient: External


--55cu3hflvddctikp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] usb: typec: mux: Fix typec_switch_match()
MIME-Version: 1.0

Hi,

On Mon, Aug 17, 2026 at 08:22:39PM +0200, Marek Vasut wrote:
> The fwnode_typec_switch_get() sporadically returns NULL instead of an
> -EPROBE_DEFER for orientation-switch described in DT. This makes it
> impossible to discern whether the DT does describe an orientation-switch
> which did not probe yet, or whether the DT does not describe the switch.
> This happens with gpio-sbu-mux connected to an I2C GPIO expander.
>=20
> The class_find_device() on typec_switch_match() may return NULL in case
> the mux did not probe just yet early on boot. The sw_devs[] array can be
> empty on boot as well. If these two conditions occur, then the conditional
> if (to_typec_switch_dev(dev) =3D=3D sw_devs[i]) evaluates to true and the=
 match
> function returns NULL, which propagates to fwnode_typec_switch_get() which
> makes it look as if the orientation-switch was not described in DT.
>=20
> This is incorrect, because the mux driver will probe a bit later on, but
> at that point, the caller of fwnode_typec_switch_get() already got the
> NULL return value. The NULL return value also does not trigger IS_ERR(),
> therefore the caller driver interprets this as if the orientation-switch
> is not described in DT, and does not return -EPROBE_DEFER to try again,
> even if it should.
>=20
> Fix this by checking the class_find_device() return value, and return
> -EPROBE_DEFER if it is NULL right away. If the return value is not NULL,
> perform the deduplication test, and if that test passes, consider the
> return value to be already non-NULL.
>=20
> Fixes: a53b4f9c51a9 ("usb: typec: mux: avoid duplicated orientation switc=
hes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> ---
> NOTE: A similar change was reverted in
>       f576c75f95a5 ("Revert "usb: typec: mux: avoid duplicated mux switch=
es"")
>       Maybe the orientation switch commit also needs a revert ?
>       Or the mux switch revert can be undone and fixed using this NULL ch=
eck ?
> ---

This revert negatively affects Rockchip once my USB-C rework for
USB-DP lands and I undid it locally. I've just not yet found the
time to investigate why it regresses the X1E platform to reintroduce
the feature. Maybe you found the root cause and fix already, but
investigating with my T14s Gen6 Snapdragon is on my TODO list.

FWIW this patch is

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/usb/typec/mux.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index 9b908c46bd7df..2bc7e8edb3cbd 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -56,17 +56,19 @@ static void *typec_switch_match(const struct fwnode_h=
andle *fwnode,
>  	 * function "defers probe" for now.
>  	 */
>  	dev =3D class_find_device(&typec_mux_class, NULL, fwnode,
>  				switch_fwnode_match);
> +	if (!dev)
> +		return ERR_PTR(-EPROBE_DEFER);
> =20
>  	/* Skip duplicates */
>  	for (i =3D 0; i < TYPEC_MUX_MAX_DEVS; i++)
>  		if (to_typec_switch_dev(dev) =3D=3D sw_devs[i]) {
>  			put_device(dev);
>  			return NULL;
>  		}
> =20
> -	return dev ? to_typec_switch_dev(dev) : ERR_PTR(-EPROBE_DEFER);
> +	return to_typec_switch_dev(dev);
>  }
> =20
>  /**
>   * fwnode_typec_switch_get - Find USB Type-C orientation switch
> --=20
> 2.53.0
>=20

--55cu3hflvddctikp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqEhzUACgkQ2O7X88g7
+prenQ//fhz0+xzgaZa5hZfFPOf7/0+cn+fpYlpRM2AdHsIlsAb3f8reJePUJ233
pxTQHeHBOcCKWcaEjCC03EsmAKjRv7Bo499aXQdJm/cH8SoIiIpzP+rTkuDjW/Dd
AAwW6fqmLaG42OVkTiE3u2tiCtdil9EkxJpuSvrA5f5TI9H6KdmpZVi+A4oQAk/N
iFvZJxUfBnHIlY5fzEcJsbQCb1z0n0bawP40axDGECBcIrGQC2+PZuFmd8xhVssM
qwxdMpbqu56dlm4Pqmcf6gkrwZl/03ELBPzx2wZjYeNtX+hh8UY2D+pE9moKCzWF
S4C88u9pxZP0rBE8Uflbv9tf9pxdaRImFrljw30Lp8xZfU/WvovKl2ZVhMT4p4mj
0mGc6S+8RL7Uo2nStZZtzCFSG6oYQOr7c/tfhYfEcNjFEbPEC8q6buB9CACNFDKB
diXna6Ykh1358IhT7o7Tkv1XHskuwK9r+3GpM8N6+E92nwofsvsZ0XMEdo85nFdX
QVVhHc5khUnFK4yETc5lY3CdbRWBQff5BaFfFlbt9XT6w4rnwXLThMI+kvjylK6G
G5+wmwtAoHO6tmPLTL8Fe/Ppu9QAP/ic6xnm3jq1odzYETuc6S7j74XFAjMKW35P
TUF2u5xODWmu8Z4dHeNhVbpI9quSJ+YlY9nCB3lut/hu00vX3OY=
=bOCK
-----END PGP SIGNATURE-----

--55cu3hflvddctikp--
