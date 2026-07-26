Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9803546F7;
	Sun, 26 Jul 2026 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096478; cv=pass; b=m7x6l6AvBaRHXJ2Yp9PYO0jxAzJDKbLAD96a8BQjn6Z9azsWxe2AtwlO2W0yIH4qz6TGKpPdMbeyGsXGuolJsC9kGiVCsH5GSYvAR0acHSPTRReYHE8fJ7d7ZGpq45SwhQsMJWL6NsNR6iMbtz7nj+SJltFGI5AbegpY0ei1fEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096478; c=relaxed/simple;
	bh=Wj3P2SV4KYQw0SzY8k/amxxTuOdEsVQeo6S/VwCaVUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AphPaYt/e2uuv+vItJ3MZnjbrCD9YKKjF66LqvhgKeZ29lC93iqKJw2EPQBMT9GpNZUofY6dEPjkGk87PimEpZqZ4onhJ/X/r4ByQcQymv7nK9lkqlTnihRlqm+HdR6oEdU9rMW7yBatgh1jk0FNZemNGu5aNISUrkh6GWcdLJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=RiRnMUpg; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="RiRnMUpg"
ARC-Seal: i=1; a=rsa-sha256; t=1785096462; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eTtf52KsOTKl3YIHRvwYoSi4ku3jLfR9KYkd0vHBteI17Fa51RtdCs1PQXNuFwxSt9qsCYMzD6o+nQJN/T2A/CMZuUQC5Sw7yVpZBrungXdAml3ygB7DUt1lS6xNrS7s8tgIgAoN+1gRnV3n6T/Py4J5lCRhHM+X5MeXpUOb1lU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785096462; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=w782BroTlhrMDg6EV/xHqRxbM+68ZhFHgdezxw51+aA=; 
	b=jpOmBtdBQqsQZVjxqjkBQ7RZ/+zjql4CDJG9Dksi7FbudPgwUEjF5gdhC0SlbpC1qS0IsB+ijSIqRytx8U9x139go2WRmqONp+FYp4GfD/LDFyqUFP4/NSmkgmukPi9AcY2qG/7KtWWEuWFuPPRjwKfVNjhbweH7mj09jfhjDkY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785096462;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=w782BroTlhrMDg6EV/xHqRxbM+68ZhFHgdezxw51+aA=;
	b=RiRnMUpg7Jn+59anfvh58SgJ12niQjF8nO2smO8TyO19pgyNeRwxV21fUKKAZZmO
	vAU+EHhqEm3Rws9N/nILvAXQc6Ix67CbwaLl2psx0L4HJm9pN/1VXR6OWW3XYoqBAGY
	1cNrUV/fuqDui3kHv4pnEaglhwi+MAanqv5Milqk=
Received: by mx.zohomail.com with SMTPS id 1785096460809422.2619537679549;
	Sun, 26 Jul 2026 13:07:40 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 08B261806DA; Sun, 26 Jul 2026 22:07:38 +0200 (CEST)
Date: Sun, 26 Jul 2026 22:07:37 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	myungjoo.ham@samsung.com, stable@vger.kernel.org
Subject: Re: [PATCH] power: supply: charger-manager: tear down sysfs and
 disable charging before freeing regulators
Message-ID: <amZoF1JtJKEKUE9p@venus>
References: <20260726051540.35579-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3pey6zxk234nelwm"
Content-Disposition: inline
In-Reply-To: <20260726051540.35579-1-fanwu01@zju.edu.cn>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.74.17
X-ZohoMailClient: External


--3pey6zxk234nelwm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: charger-manager: tear down sysfs and
 disable charging before freeing regulators
MIME-Version: 1.0

Hi,

On Sun, Jul 26, 2026 at 05:15:40AM +0000, Fan Wu wrote:
> charger_manager_remove() and the err_reg_extcon probe error path call
> regulator_put() before tearing down the power_supply sysfs entries
> (power_supply_unregister()). charger_manager_remove() also calls
> try_charger_enable(cm, false) after the regulator_put() loop. A concurrent
> write to a charger's externally_control sysfs attribute that lands between
> regulator_put() and power_supply_unregister() can run
> charger_externally_control_store() and call try_charger_enable(), which,
> when charging is enabled, dereferences the already-freed consumer handle
> via regulator_enable(), regulator_disable(), regulator_is_enabled() and
> regulator_force_disable(). When charging is enabled, try_charger_enable(c=
m,
> false) in .remove() also dereferences the freed handles directly. Both
> leave use-after-free windows.
>=20
> Move power_supply_unregister() ahead of the regulator_put() loop on both
> paths. It ends in device_unregister(), which removes the sysfs attribute
> groups and drains active kernfs operations, so on return no
> externally_control store can be running or start again; it does not touch
> the regulator consumers, and psy->desc references the devm-managed
> cm->charger_psy_desc, which outlives the call. Move try_charger_enable(cm,
> false) before the regulator_put() loop in .remove() as well, so the
> synchronous disable also runs on valid handles.
>=20
> This does not address the separate extcon-notifier path, which needs its
> own synchronization design.
>=20
> Found by an in-house static analysis tool.
>=20
> Fixes: 3950c7865cd7 ("charger-manager: Add support sysfs entry for charge=
r")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---

If the power-supply unregister needs to happen before the regulator
unregister, the regulator also needs to be registered before the
power-supply device to avoid early userspace access to the sysfs
files before the regulator is registered. I.e. this patch should
also move the charger_manager_register_extcon() call.

Greetings,

-- Sebastian

>  drivers/power/supply/charger-manager.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index c49e0e4d02f7..c1df512f32a8 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1622,11 +1622,11 @@ static int charger_manager_probe(struct platform_=
device *pdev)
>  	return 0;
> =20
>  err_reg_extcon:
> +	power_supply_unregister(cm->charger_psy);
> +
>  	for (i =3D 0; i < desc->num_charger_regulators; i++)
>  		regulator_put(desc->charger_regulators[i].consumer);
> =20
> -	power_supply_unregister(cm->charger_psy);
> -
>  	return ret;
>  }
> =20
> @@ -1644,12 +1644,12 @@ static void charger_manager_remove(struct platfor=
m_device *pdev)
>  	cancel_work_sync(&setup_polling);
>  	cancel_delayed_work_sync(&cm_monitor_work);
> =20
> -	for (i =3D 0 ; i < desc->num_charger_regulators ; i++)
> -		regulator_put(desc->charger_regulators[i].consumer);
> +	try_charger_enable(cm, false);
> =20
>  	power_supply_unregister(cm->charger_psy);
> =20
> -	try_charger_enable(cm, false);
> +	for (i =3D 0 ; i < desc->num_charger_regulators ; i++)
> +		regulator_put(desc->charger_regulators[i].consumer);
>  }
> =20
>  static const struct platform_device_id charger_manager_id[] =3D {
> --=20
> 2.34.1
>=20

--3pey6zxk234nelwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpmaQYACgkQ2O7X88g7
+ppJJQ/9Hh5U55PSlIrBDtQeyJGOLD4Xx8+Rx6z8ODgOU63vLrA77XqWy3UB2knw
3mL+LAahFq2cQML0CjKcABD03mdYplYesdyz9bdpL/tjmBDxzHixosb3xgy336vd
t+Om6C1B8RY8x1iDtL9KGo8MXNXD9ABvWzfxoWeA375FG/HzpK9tTWwdV34+yIpd
uttVKMhnJmimtrzbFV3UYAy7VNWhj+awZtlgeAGCXd3ilRtw8yLjyxhpHTNMgq95
udJIcYxBwzWR+EU4rhQImTsPXXRCNkyIre9EP8yri5IKRQIwul9gAJoxIRZGNf+f
jr9dhhYMl9uXZWQAcpICHBlObZ+O5QFB0O7EfSsMQEjXLdeNOm8HKhxCGG+CLs+b
35u1vKHu9EFt8CfJ+5t5gQX04LcpaOCmGS76Be/dNrLMYSJhWzoIkw5ISm6IGDbe
aJpEl/K1BYKAYSr+go33QfFjLkAzF/ZlE07/tYBHhM9RJrGuXN07Af+55/i88c1q
eEWyBlRKGqSpbqf3Vy16PHRy/RJF6eAX3F3i+LmOZfVcLbpPD6HiNDcdyuxs+wQr
xzohV4/fcmp6ZBcItaxp4fMybHrEWXWwBlMRgC2ScbtM+xKuUZCFNOWYD5X7/xd0
KQg7XcAvoj22eSN4ZGEjfpSb4GK0EFQa23nxVFzDsuSIG+zClTE=
=L9Jc
-----END PGP SIGNATURE-----

--3pey6zxk234nelwm--
