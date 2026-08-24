Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02084052AF;
	Mon, 24 Aug 2026 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573949; cv=pass; b=G/JmhUJdJtxQ+LRpG3XWNX+6ZhRqsVmSesAKqTRymADMH6/8Ttk+d1m1vaCFqUQxsiX7Q+HqWfHDNo4K0w/hJAVGc/b7YQ9a+9YifuDL38Up1MG6ZhAQ+ReXT8dG21VFmcMhj1+/cyIzrtW2Gn71xsWY0JV6mQzEZZSpc22zRQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573949; c=relaxed/simple;
	bh=oXSyQbJMaCFyHPLgO+M1Zn2NxfGd2XmVSNpkw8g+0xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqAQiXx/UW854zeS1EJN7Bn8MBFqW7+LfcKMtnjTuS6MZlPin8ke4L6bUi0svGYO6apCGMOG+nufCce0/dVLpRPUyQM9qB9Dq44fpCsz1BRQKI+wRjd2Ql0UEJgNXqUslbkXY+b5xHioDznUmrSA5uYYKokHe+21iuu3wuIj0Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=O2zGuaSM; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="O2zGuaSM"
ARC-Seal: i=1; a=rsa-sha256; t=1787573932; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EYLfL2js0GSiA+3q+SuLYycN43dQ7himjkuuv2iQE2nEnaFvDjIlC+3JfL9T0aEtqqZUSbNi4JYhdMSTlwPI+JaYRNAIo3iHCYb8dmCWtjEPlTJ71cUf6Z7lawQR/iQqToAWmR6QRNrb9He7H/jX1ML3DBsSP1023Ar9tP8o1CE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787573932; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oXSyQbJMaCFyHPLgO+M1Zn2NxfGd2XmVSNpkw8g+0xE=; 
	b=WZITXfVuURAffcWw3vlKy8YqYrqvnhek6NOsaQNh0dWbK7jKgHkSYXdwQepMlQ9BL9yUi03H1yUs5ihOcIz7i2fxjt6FDkZxyWLRrNyscjyxtBDyYBoV0h/3rP1N4ryYReDk7alSVzHSdwOY8PpTr3S+OdESnCdMkmyYfX7gR6g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787573932;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=oXSyQbJMaCFyHPLgO+M1Zn2NxfGd2XmVSNpkw8g+0xE=;
	b=O2zGuaSMcSE/ggklscJPBLwhp5kBsC24nOkmVc9CymXXnFB+GvODYDRDRWeC934Q
	mkf8FuhkWBMnp1ymW/Gi1OBKXepc+uzlDTkpk1oVF3G1Ik09Ve9BcU4KeeB8EAUQ7nY
	PewQMDG3TemB7OOnKpBiw4ssJkN5uBlvPDvmrYx4=
Received: by mx.zohomail.com with SMTPS id 1787573930202549.2921163268792;
	Mon, 24 Aug 2026 05:18:50 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 7E762180830; Mon, 24 Aug 2026 14:18:46 +0200 (CEST)
Date: Mon, 24 Aug 2026 14:18:46 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc: Marek Vasut <marex@nabladev.com>, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, kernel@dh-electronics.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: mux: avoid duplicated mux switches
Message-ID: <aow2jLtrvHqPLI_w@venus>
References: <20260822072556.490594-1-marex@nabladev.com>
 <ef89a8ba-af41-425a-90e5-77061fec3f9f@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wrpw432ce2qfgpj6"
Content-Disposition: inline
In-Reply-To: <ef89a8ba-af41-425a-90e5-77061fec3f9f@oldschoolsolutions.biz>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/287.552.98
X-ZohoMailClient: External


--wrpw432ce2qfgpj6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] usb: typec: mux: avoid duplicated mux switches
MIME-Version: 1.0

Hi,

On Sat, Aug 22, 2026 at 09:47:33AM +0200, Jens Glathe wrote:
> On 8/22/26 09:24, Marek Vasut wrote:
> > This is a re-application of b145c3f29d62 ("usb: typec: mux: avoid
> > duplicated mux switches"), with fix derived from usb: typec: mux:
> > Fix typec_switch_match() .
> >=20
> > Fixes: f576c75f95a5 ("Revert "usb: typec: mux: avoid duplicated mux swi=
tches"")
> > - Extensive test by Jens https://lore.kernel.org/all/8bdf6062-8ec2-4c30=
-8463-0368d3a0f1ce@oldschoolsolutions.biz/
> >=20
> I applied both patches and compared to my tip of tree, same except for a
> newline. Also did a test on the Lenovo X13s (sc8280xp, gpio mux). Therefo=
re
> justified:
>=20
> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Thanks!

-- Sebastian

--wrpw432ce2qfgpj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqMNqMACgkQ2O7X88g7
+prnlQ//evCtj283/a5GHiY0JQ3J318qcwF/aFB+ZuykvgRFoT0dU0NrWlM6ohQI
luCvZSLo7xcHomNcBu7VZSJm9SyIKoU5sE0kcfkjvLJzxqSOsE5h3AYTqvhSRvRT
wprIsyykw+8YO5rPTUZouDEmSTKr8+nAolv+XZ4mbW7cQoDXG9f2dG38wtLRol++
O6HiBU78Bg4H95qixiMVAvfHVLjz6oc5AU01/E7zEjSmcM8vXR0YTVbp3nqCMJX/
A4eG8jYJ5THGcAX/gxP6L9UkDfDraG4zEDxTuTBqB6ZmqMqeDyG8ZsZrLJYNlqBk
8gADT8uufCisQAXHNeEAgn3snlSBbOx6etQYHCCjoAYCCktd0WWOpeXZRXCFRjEh
URwOTx6U77x6Hr2YmoUkFfHT4B49IWhV7PYfWYKhQb/z3UPucnQdnV/mkUXJaxJx
2wTbCPLxgx0rwBhHP2E7vtv+i06m79g/SV0nO1Jtp5reYwpBd+KB5uC4B/3WU21o
SRkh6TCyFBSmXB61/S0zd2Fn+VZy9a1MUa+OY43/MvNlkG/DYXM3mF6LyA9mkkQb
6jAJD2mQm0+o1/0iLzCQr5dCyZukM0XeuqCWvL49BlsGz38PqGjldwLAS2SnZGUG
m3Ebw83iFrzSJlUBoar9RlOwz/wY+lX07mvmk/feK6WECN7I6Y8=
=JQfS
-----END PGP SIGNATURE-----

--wrpw432ce2qfgpj6--
