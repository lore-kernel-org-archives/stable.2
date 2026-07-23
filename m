Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7245D186;
	Thu, 23 Jul 2026 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820196; cv=pass; b=q0Kg9Z8lsWmaomglYkGzm3PyPw/MUFQ+L9PDJjnmJHr1DhkfjTXd8eXbVwId3qBUh5CJc4zPcjinftmFaRMgS44GCUcYcXfpSvrC8PWm9QhPuQD7dBG6wg9VmEE0TSzLicbTqW9pkzMMzQm9+/wIwFma70xRVRuXRcW7blx/Z2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820196; c=relaxed/simple;
	bh=n8WdC5UviNGCN43SYKlURZ4rHl8KsTZyi1gm8zDmBmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIQbzSH48mTJoGL5h8QfbNbMtgKt8AvJnRlyNcCzzN/fXinnTSMkGy8UBF6YvcuULRmta5EbE6iKQm3V8XVOmBoiF16oa8OjwyRLvvLZ9jPGLl1ZIYvbIX0bvSjLtQGQPUelFA/Rti9Bil1tt+vdCYVY6/xr1pWqPiIgBTHh7Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=PQph0wTG; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="PQph0wTG"
ARC-Seal: i=1; a=rsa-sha256; t=1784820180; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QzTONGX7JscT3djWCmUWQ5dlkfmN6dM207k23VA8+xlQ/Jj94Mpdx6Hfmm/oh1Z18Lz56Mqf+FR1nPZwfkPh4qYGGgoNOhCVY6hG1ft0VYaXoibxf7S1UCBZ1CiUexSEnnE6MKg2ert49ynAwSqfEBPwtgeqtpjeHeMoxoeYG1A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784820180; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qUKXTx/ujO8hK7TO6U5WvWX1fFpKGnXeD2tFw7NeN8M=; 
	b=RGI7dBFGcmYAeLtvJJDacCfkjFGiYvvndnQyabHRdjrb+DEQDZVPHNlORLte5vcy5ZDtCJ/RfXWiRN7t9duE/SxifL9/8Je0qMTIKh+fUoluLJ4o5Vr7oHzeRIsRVZJxRBpQEOPagjmpM0wccBv0ahVQpSbAbHT+bla5IGxZTUA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784820180;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=qUKXTx/ujO8hK7TO6U5WvWX1fFpKGnXeD2tFw7NeN8M=;
	b=PQph0wTGlDe79RKOK615WNCwlfLSMSgIWTclZESni49gjOvHY+0Z9HfYBQ7zUO2i
	9LxIHes3pEDbeELqxfm/HVFHyaoxCuftcgVtJxEYtN415wjyHq0W2ppPhksyneW2pMJ
	2EAnnQ416MN/SGZia2DwhnJHRzF+qs8Ss+E2gkLQ=
Received: by mx.zohomail.com with SMTPS id 1784820178581623.6927834355954;
	Thu, 23 Jul 2026 08:22:58 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 750081808C6; Thu, 23 Jul 2026 17:22:55 +0200 (CEST)
Date: Thu, 23 Jul 2026 17:22:55 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Anda-Maria Nicolae <anda-maria.nicolae@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] power: supply: rt9455: quiesce delayed work before
 teardown
Message-ID: <amIvCPcNi6AlU_zj@venus>
References: <20260723145352.8865-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gwcd6ngtjifnmhd5"
Content-Disposition: inline
In-Reply-To: <20260723145352.8865-1-fanwu01@zju.edu.cn>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.802.37
X-ZohoMailClient: External


--gwcd6ngtjifnmhd5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: rt9455: quiesce delayed work before
 teardown
MIME-Version: 1.0

Hi,

On Thu, Jul 23, 2026 at 02:53:52PM +0000, Fan Wu wrote:
> The threaded IRQ handler can queue pwr_rdy_work,
> max_charging_time_work and batt_presence_work.  pwr_rdy_work and
> batt_presence_work can also queue max_charging_time_work, while
> batt_presence_work can requeue itself.
>=20
> rt9455_remove() cancels max_charging_time_work before
> batt_presence_work.  The latter can therefore queue
> max_charging_time_work after it has already been cancelled:
>=20
>   rt9455_remove()                   workqueue
>     cancel pwr_rdy_work
>     cancel max_charging_time_work
>                                       batt_presence_work queues
>                                         max_charging_time_work
>     cancel batt_presence_work
>     return
>     devres frees rt9455_info
>                                       max_charging_time_work dereferences
>                                         rt9455_info
>=20
> The IRQ also remains registered until devres cleanup and can queue more
> work after any of the cancellation calls.  If rt9455_hw_init() fails
> after the IRQ has been requested, probe returns without cancelling work
> that may already have been queued.  A pending callback can then access
> rt9455_info after it has been freed.
>=20
> Explicitly free the managed IRQ before cancelling the delayed works in
> both paths.  This waits for the threaded handler and prevents it from
> queuing more work.  Cancel pwr_rdy_work and batt_presence_work before
> max_charging_time_work because both can queue the latter.
>=20
> This issue was found by an in-house static analysis tool.
>=20
> Fixes: e86d69dd786e ("power_supply: Add support for Richtek RT9455 batter=
y charger")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/power/supply/rt9455_charger.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply=
/rt9455_charger.c
> index 7045d2908148..3c64591b5934 100644
> --- a/drivers/power/supply/rt9455_charger.c
> +++ b/drivers/power/supply/rt9455_charger.c
> @@ -1582,6 +1582,17 @@ static const struct regmap_config rt9455_regmap_co=
nfig =3D {
>  	.cache_type	=3D REGCACHE_MAPLE,
>  };
> =20
> +static void rt9455_cancel_all_delayed_works(struct rt9455_info *info)
> +{
> +	/*
> +	 * Both pwr_rdy_work and batt_presence_work can queue
> +	 * max_charging_time_work, so cancel them first.
> +	 */
> +	cancel_delayed_work_sync(&info->pwr_rdy_work);
> +	cancel_delayed_work_sync(&info->batt_presence_work);
> +	cancel_delayed_work_sync(&info->max_charging_time_work);
> +}
> +
>  static int rt9455_probe(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter =3D client->adapter;
> @@ -1684,11 +1695,15 @@ static int rt9455_probe(struct i2c_client *client)
>  	ret =3D rt9455_hw_init(info, ichrg, ieoc_percentage, mivr, iaicr);
>  	if (ret) {
>  		dev_err(dev, "Failed to set charger to its default values\n");
> -		goto put_usb_notifier;
> +		goto free_irq_and_drain;
>  	}
> =20
>  	return 0;
> =20
> +free_irq_and_drain:
> +	/* Stop new work before draining work queued during probe. */
> +	devm_free_irq(dev, client->irq, info);
> +	rt9455_cancel_all_delayed_works(info);

Manually freeing device managed resources is ugly. Register the
rt9455_cancel_all_delayed_works() function via devm_add_action_or_reset()
after the devm_power_supply_register() call in the probe function
instead.

Greetings,

-- Sebastian

>  put_usb_notifier:
>  #if IS_ENABLED(CONFIG_USB_PHY)
>  	if (info->nb.notifier_call)  {
> @@ -1704,6 +1719,10 @@ static void rt9455_remove(struct i2c_client *clien=
t)
>  	int ret;
>  	struct rt9455_info *info =3D i2c_get_clientdata(client);
> =20
> +	/* Stop the IRQ handler from queuing work during teardown. */
> +	devm_free_irq(&client->dev, client->irq, info);
> +	rt9455_cancel_all_delayed_works(info);
> +
>  	ret =3D rt9455_register_reset(info);
>  	if (ret)
>  		dev_err(&info->client->dev, "Failed to set charger to its default valu=
es\n");
> @@ -1712,10 +1731,6 @@ static void rt9455_remove(struct i2c_client *clien=
t)
>  	if (info->nb.notifier_call)
>  		usb_unregister_notifier(info->usb_phy, &info->nb);
>  #endif
> -
> -	cancel_delayed_work_sync(&info->pwr_rdy_work);
> -	cancel_delayed_work_sync(&info->max_charging_time_work);
> -	cancel_delayed_work_sync(&info->batt_presence_work);
>  }
> =20
>  static const struct i2c_device_id rt9455_i2c_id_table[] =3D {
> --=20
> 2.34.1
>=20
>=20

--gwcd6ngtjifnmhd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpiMcMACgkQ2O7X88g7
+po/4w/+JPhQyRvxvso/2eSz21t0DjeBAeUuS7YgO0EYdsZQe4T/Dx6wBYw0j57S
uhcpIrBodTTad0lKHK/BiJ5RXzE2rbk/XgU8ku8Xe6Ezdl3gh9MfvzWpwzjfznnM
DgniqRu0ffboMvNcfauo3wEuotsKV6qqbGEyGXok/QYryUplqVtRKlazOLuuLeXG
hySIF7IRRvY2cPXRXbxD80N+nQm/pvPbIiX/BrZnA7vR/dJ5xQX8ErtTi5oNhHtM
U8lJSoF0EBzCKsYWgjzlXQLsc5H+wDGKThtUPESBJpY2g5BUawsaTLwiHRRVwD4O
CLwWCdEsnIUNbx0RUierI9a3SRmRpfKKdPySkaMkAZTlqmXvYCfI6ivCFQCbXeqD
BsuluTEGairHW0t9T/dIT4gYHHWT455Gu593A3kKBVDEJGh026b/8cFCISOaSzUM
4ox2YLd/jgguVRwxSR/FMYhRiTOnaNC8cqAqA1JTomooKnKIW71bqjpkcrq/FaiT
pFucEkTqjh25MsgccEVl6KrtlGjVF0rd0hDYHbyG+lu+MD7ZGr4JURKURVOdjFn1
bOjMzd3pzba6P7UgJRiVKTluy3Ei2l2ug3BU2418HQUX7PcdyM9mjz5tLo/20g4O
Dr0mn9uCNgOZWfq0kswcpRf+K9shVc8v7NolANjk7i2netSUP5o=
=0W02
-----END PGP SIGNATURE-----

--gwcd6ngtjifnmhd5--
