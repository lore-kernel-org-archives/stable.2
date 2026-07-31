Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80149345ED3;
	Fri, 31 Jul 2026 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533415; cv=pass; b=eG+985PRYrUrzLuyurD6Bk8uWDpJLckktMKxWp/o7mIh+hS53MPsZxXvMtwwdCKSLOl1k+wvZ2Hac/pgnte55YfWnI8FshLAECqGZVwuPaNahwbmNQsZ23zrqpVsLSGnMu7yxUtu5xwQ1leeFI8YsgF+eoWnDQjQXvGIJFyOLL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533415; c=relaxed/simple;
	bh=FoRKKwIXFm7vL+HuTHo6DfVSvRV6CQlL5i9RWIu6LrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brD74pWjL+QlpU8kpoqScrXobd+X+YJc7jUWri848/uD6DOiOH8AKVKBkqq1U71I0zebcGjXDwk17x512FGB+MGshZY5QqPH261uQ8BwvjY6qxQeL7O7e5aOOCUzMbuZfzLvX2x2TPE28IImqqNSBDB6dERI97QSUhrldjeIKBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Bfc6vPBE; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Bfc6vPBE"
ARC-Seal: i=1; a=rsa-sha256; t=1785533401; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CzRxDK1mjwfPwHHpsKnM9vcjFy/JlbkUNnnkBdZ0nPbBZ7AlvhYBEhsQrdO9C75wD6GO7aLu1tdePqaikIr2eJ2ZeMJzYO7BhvUgV4SBODa5qlj/lWFqZQuA9oPoz/P0BS8iai4iLJadDKZ5cNGuPPq+YQ9Fj9SxQ4kAgxW6nGo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785533401; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HDQFriGFDmR+oMWFFaGJL3URfqf634GVEENYJlsoSyc=; 
	b=RHMg57EjBBRIFiy+uTg/mqiFGG9qLROECI6ZIIbeKU2ZRVJv4DjH6OYdRiRr5UaiTII5nfJAyg69KYHATr+GZIFHlfO866JXkSuZwecZsupD2Rlqws0MYeSJPl8yNBn3Qa7h4rSODjeoTdIMMiHFRF0ZZSobU694QWpyRmtfF2w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785533401;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=HDQFriGFDmR+oMWFFaGJL3URfqf634GVEENYJlsoSyc=;
	b=Bfc6vPBE8qEB+7MyXYIpScVHKU1fMnmIV4hYkOZy2bwU7vIxlF2KxHpZSfobDSmv
	jeVZJS8Pb+W1mLHpRif13DvaqRH9SuQxpcdcZr1aGjyIveee+2h11FDETU3jVl2y31R
	R6AL4n+O3KYIbxOAt8nB77qgbjxjmLW42EPhw6KQ=
Received: by mx.zohomail.com with SMTPS id 1785533398963541.1363057424423;
	Fri, 31 Jul 2026 14:29:58 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 1919318029A; Fri, 31 Jul 2026 23:29:56 +0200 (CEST)
Date: Fri, 31 Jul 2026 23:29:56 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-pm@vger.kernel.org, laurentiu.palcu@intel.com, krzk@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq24257: fix use-after-free on remove
Message-ID: <am0ShrO_o3lJ_V8L@venus>
References: <20260731143554.334179-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ohbx7ih6omxgklt"
Content-Disposition: inline
In-Reply-To: <20260731143554.334179-1-fanwu01@zju.edu.cn>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.527.77
X-ZohoMailClient: External


--6ohbx7ih6omxgklt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: bq24257: fix use-after-free on remove
MIME-Version: 1.0

Hi,

On Fri, Jul 31, 2026 at 02:35:54PM +0000, Fan Wu wrote:
> The STAT-pin interrupt is devm-managed, so it stays armed until the devm
> cleanup that runs after remove() returns. remove() cancels
> bq->iilimit_setup_work while the handler can still fire; the threaded
> handler reschedules that work and dereferences bq, so the work runs
> against freed memory once devm frees bq.
>=20
> Call devm_free_irq() before canceling the work so the handler is quiesced
> and cannot reschedule it after the cancel.
>=20
> Found by static analysis.
>=20
> Fixes: 2219a935963e ("power_supply: Add TI BQ24257 charger driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---

Instead of this, which renders the device managed part of the IRQ
request pointless, just make the delayed work also device
managed and thus ordered correctly:

1. Move the INIT_DELAYED_WORK() block directly before the IRQ registration
2. Replace INIT_DELAYED_WORK() with devm_delayed_work_autocancel()
3. Drop the now pointless cancel_delayed_work_sync() from remove function

Greetings,

-- Sebastian

>  drivers/power/supply/bq24257_charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/suppl=
y/bq24257_charger.c
> index 72f1bfea8d..b9110d5fe2 100644
> --- a/drivers/power/supply/bq24257_charger.c
> +++ b/drivers/power/supply/bq24257_charger.c
> @@ -1064,6 +1064,7 @@ static void bq24257_remove(struct i2c_client *clien=
t)
>  {
>  	struct bq24257_device *bq =3D i2c_get_clientdata(client);
> =20
> +	devm_free_irq(&client->dev, client->irq, bq);
>  	if (bq->iilimit_autoset_enable)
>  		cancel_delayed_work_sync(&bq->iilimit_setup_work);
> =20
> --=20
> 2.34.1
>=20

--6ohbx7ih6omxgklt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmptE8oACgkQ2O7X88g7
+prahQ//dIC78ynMsXKstM6WhszwzzvQfMvNG05wWON+xJUuQQoRp79HvPmeZFrk
9HbOn+qL9dx9vq6amfE6zaKFfV8+U0zvC/AAnbkjU8bcsodcWPqHuaNnhT+MW138
+iGlvge7xhlLC8GLE/xWM6M30Vk5+9yDIlm0DxaQ876ub+TenJgploiF9zhIYaiL
t0DHaDZ1qiVIj1aCa+Ue+hX0QkyZac0/nKF7s75iy5dHwL1+iGFd+eAm8smoiJA8
D0jJBwaPrK/uGPKpWAFfeCsLR/jYjwVUZolf+Rpi9dVCZNBTBtFt/InT0hX5N8vS
lB7SROz9sIv3ICcbwvGNjsS30xrYi+kQFt5I7PGTHCMfMFKcglfBIq/xHRPZQugd
8v+d3lVVQdHV+TyhPJIMDHC65+eNnBgUup2OANGeWq/wq8DHwgCBrD3uco0HS+58
/MFvcL7gy5u2DUWZRQ4NhlH4wBMR3WCIQ4uWMQKtfu6kM7iZYtAMRAmg+dBaIfa6
YorgGQvvhZ7HnNdxZ1MX2yuRFNMnX6OyztKZ6h02ZaCcGoMfHfWO8HiPFidSPqkk
GwN9/c0SzNgGoIc9H9ZcYPDy1mE5W/Dsi2iXF7fmSvtW0nBL9n7os6Fs6SYWX7tP
8ZXHO3o0B6ZgrAN+oWZo5wJc3RfBkQnOjnnLOXISLZIrf5av4NY=
=/mKT
-----END PGP SIGNATURE-----

--6ohbx7ih6omxgklt--
