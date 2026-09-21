Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14D48489A;
	Mon, 21 Sep 2026 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990136; cv=none; b=QWDf/aKY6OviqR1aPM4r3AzyeYRpqoUnUYK/TQbKnf5sm948ScDunDT5SNOCaVXSSMG13PQ1V6Kv1Wh8sohGvNOFeW2m3M4XG8xnbrCuGI9Za4hbxHxVYAwg38g/2NtFrn1fwDjQIe5t5bN1tFQ/S6wTjDrdwVr87K0FBuVosYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990136; c=relaxed/simple;
	bh=23O1N9RAoRg8GUl0wqI99Kzo6mCdV07KZt4GTFKyfdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg8Oy//qBTIzqfRtPb7NFrlTPwO43b7ay5a5rSjidxwKW9WdfuOYXDZsUh2d6XfBHd5rzgxBalljsF3CfUWjVSKBBDjFWswbIeU3yKmC/1f3inucwP18XpHLTl/GEW8/P4mgxEeVQTOlLxVRTv5Kq5c+V8hQcOTCd235fnLCfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/e3aISV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/e3aISV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C15C1F000FF;
	Mon, 21 Sep 2026 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789990134;
	bh=aaRbicKNfqtcJIZ5MQEU8o/qjFzZn0m/iDzkauQ3Qt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U/e3aISV00A7ww8Hei7QixqUITRE14MzH4XqHHJarBC47v5xUeurs1Br+A2TFyzYT
	 rW2Pa2ldvVMGIGLZHXnTqqT0jg0LBxiWzDbX4qVi/24Rv9uHMFGYm3iUn66EYHJElt
	 cBNWgqQeQc8KZV7QkUmA98Mx6XPg3GiL3CSnvdz3YsytovHIS5CsZcsvD+QReu+8er
	 BwAe1Z0Y3oy0xe32U8NT2wpd1S0OG2mVZrfL6xREtSkiPWikff+qiAVZ4FUn5uVqxK
	 9bgCnwPFlLm3qfsAbQbtAVyrmmmsm/f2C9r1QcdqpvAyfRcZArOLIalco9PTsv6KYH
	 wNdy4UdIIVzTg==
Date: Mon, 21 Sep 2026 13:28:52 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: tegra-xudc: Disable port reset work on
 removal
Message-ID: <arETYSjwaHytxyBu@orome>
References: <CAGEsz8F2eKsmV_tymO+9UD5xkS_tWhZo-b9Xom1_SiKuc-BCqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5zdctmjwsshytil5"
Content-Disposition: inline
In-Reply-To: <CAGEsz8F2eKsmV_tymO+9UD5xkS_tWhZo-b9Xom1_SiKuc-BCqg@mail.gmail.com>


--5zdctmjwsshytil5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] usb: gadget: tegra-xudc: Disable port reset work on
 removal
MIME-Version: 1.0

On Thu, Sep 17, 2026 at 07:20:58PM +0000, Myeonghun Pak wrote:
> The port status interrupt can schedule port_reset_war_work to handle the
> Tegra210 port reset workaround. The remove path does not cancel this
> work, so it can run after the PHYs and controller resources have been
> released and access freed memory.
>=20
> Disable and drain port_reset_war_work before tearing down the controller.
> Use disable_delayed_work_sync() so that the interrupt handler cannot
> queue the work again while the managed IRQ is still registered.
>=20
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
>=20
> Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB
> device mode controller")

Please don't wrap lines like this.

> Cc: stable@vger.kernel.org # 6.10+
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> --- a/drivers/usb/gadget/udc/tegra-xudc.c
> +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> @@ -3926,6 +3926,7 @@
>=20
>  	pm_runtime_get_sync(xudc->dev);
>=20
> +	disable_delayed_work_sync(&xudc->port_reset_war_work);
>  	cancel_delayed_work_sync(&xudc->plc_reset_work);
>  	cancel_work_sync(&xudc->usb_role_sw_work);

This is a preexisting problem, but given that we only delete the gadget
below this cleanup, shouldn't the other two cancel_*() calls be
disable_*() as well? Otherwise there's potentially a race condition
between this and the interrupt handler (which is only unregistered after
=2Eremove() completes).

Either that or the existing cancel_*() calls are enough in which case
your patch probably should be using that variant as well.

Thierry

--5zdctmjwsshytil5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqxFPAACgkQ3SOs138+
s6Htpg//WPr1p2gbjuixtztjto5kgSpBtht2UIY60AmdxNMUo0WL0PUmoJ6v1s1u
Mye/zUOsJokaRKZK1x8pply2BvTiOG7mJT3fqb345BrMXZAsIVkPVzNRuPU6uHel
jck7pp3cZiD8RpFWhb38rPSzwchHlKLtAakrDzC/fBHhKc1gE7hAM8U50fLuiJJT
SOXf+aa3Bm1tPN+ydwIDeihf9OBPEgBVzl88re1aVy+D5CE3ejh24OPO8IGi3bZ8
SAAc6tNCOlNusAP9q5zMXXwTjb9nOSKS1kSkc6fSkML9cpnnKUd2LPEtiqtV6c0g
TpCVQXFHA1QfryeCxkILu7B5ZkuPTwu0DLkqNfwocdw8FNU+HQgyjAh97buQU6LS
h8eDya980cQ0ZTC76GlhCMMTHGNdVPpAwAQCeq9kN6QkqgfjqY9AfWt8Q0pQVJfL
zBw2ndvzfDiLSdEMFQuHeshldcKy+kaAQW0pws4jkKJ37BAAALpQpM1OiEUAsCp+
PQYBBpb2udeaPI6OV8zd5rPh2NDbAqIGc3CpKzLSJgSeTe9swTY3t48diNcq/rvz
0dfUmfdpMlIFL7zFYkeCXkhm0/kA7ABHIa1BKHj1fbynXbpYmfa4PLG/XSCOz4tR
G1ZcAee9mdfskKGYI/LQU0XByVGgZ84+JxtaIXN1Rovc80GE8Hc=
=oxn7
-----END PGP SIGNATURE-----

--5zdctmjwsshytil5--
