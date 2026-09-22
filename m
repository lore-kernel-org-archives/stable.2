Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495F44998A;
	Tue, 22 Sep 2026 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066575; cv=none; b=DoxD4c9ocGRlle9QWFSjoqpTTZ1TBEG6mNumg0PWnlf/0bMU5pelhPhQXz8jEPuBmWAotkjvoyoYmb/AME24wNaiXJbxYgakZ3mU1aZTo213RJZVXZNC9ZY5JFxfBBq7INXQLKfY1BzcVuES94tAKBl91h5WNR0ObWTf0NjhMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066575; c=relaxed/simple;
	bh=3e/BsRy35eV7UZWO5PsqnAuc6Ly+wdX4R9Ku26lvkm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/iAC2brhnclC4e1oqsrwRX8gQvbZtwNBOzVNzGaRarN2N3Q0jUJ6qkqS88IjwHhzc0L9Yz1hFZ+yqGTdslCvCZZIOVY9+wgfnVNdZMRJzM2P3tTH3tTMMmTgHPUbin8irgEHxSFCkekVBaSxFEfhrGFBMwdqaCMbAB8q5gcGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaEsM3dW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaEsM3dW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C911F000FF;
	Tue, 22 Sep 2026 08:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790066573;
	bh=fi3feLtPVMOYDU5sUdusGNlECI2wB3sb2uL66NcRc9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BaEsM3dWk6wO/Saa4fIrO+Mh3NPfkoe9ZQcZyG/yXkQGiFFm5tTlbD32I7tzqlbg/
	 vx2k3Qn1Y6m896KGpgneohI2pxEl7Z0VFM3SUgQbsZ1rY4K6WjWQRgoe6/WZo7R17h
	 1NXYCUYOU2ubx20DuHLzFF8tcUZmmPgcbRDVrhNC5SndIekDeCDRw9CHN/AixWf8ER
	 tV80o5arod7lIY6Exk2YSycqkx0xHHFXWta/Ks1pUavYnqisrJIZmVSMrCNJtwGIkI
	 I8yhuEFrDftHcM8ggvz8sj1yTL+qkmywXYgiFFTBHMzHwNYwxp+KpM1sJp4TtKp8rO
	 /1Up6/elBhjjQ==
Date: Tue, 22 Sep 2026 10:42:51 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Myeonghun Pak <mhun512@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH net] net: airoha: npu: cancel wdt_work after releasing
 the WDT IRQ
Message-ID: <arI_i_JpOBsXM3ln@lore-desk>
References: <20260922000914.542068-1-mhun512@gmail.com>
 <arI5OD8X2Eoz_Ojd@lore-desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ROMP+kOHbe7PUdpe"
Content-Disposition: inline
In-Reply-To: <arI5OD8X2Eoz_Ojd@lore-desk>

--ROMP+kOHbe7PUdpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > airoha_npu_remove() calls cancel_work_sync() on each core's wdt_work,
> > but the watchdog IRQ that queues it is requested with devm_request_irq()
> > and is freed only after .remove() returns.  airoha_npu_wdt_handler() can
> > therefore schedule_work() again once the cancel has returned.  struct
> > airoha_npu, which contains the work, is devm_kzalloc()'d and is freed in
> > that same unwind, so the late work dereferences freed memory.
> >=20
> > Register the work with devm_work_autocancel() before devm_request_irq()
> > and drop .remove().  Devres runs in reverse order, so the IRQ is freed
> > before cancel_work_sync(), including when probe fails.  A cancel left in
> > .remove() cannot get that order.  Initializing the work first also stops
> > a pending watchdog interrupt from queuing an uninitialized work item.
> > Probe currently calls INIT_WORK() only after devm_request_irq().
> >=20
> > This issue was identified during our ongoing static-analysis research
> > while reviewing kernel code.
> >=20
> > Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
> > Cc: stable@vger.kernel.org # 6.15+
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
>=20
> I guess this is net-next material, it is just an optimization, not a real=
 fix.
> Anyway:

Sorry I misread the commit message, this is actually for net, thx for fixin=
g it.

Regards,
Lorenzo

>=20
> Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> > ---
> >  drivers/net/ethernet/airoha/airoha_npu.c | 18 ++++++------------
> >  1 file changed, 6 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/eth=
ernet/airoha/airoha_npu.c
> > index 5bb4817a898d..4d3195eb00f7 100644
> > --- a/drivers/net/ethernet/airoha/airoha_npu.c
> > +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> > @@ -5,6 +5,7 @@
> >   */
> > =20
> >  #include <linux/devcoredump.h>
> > +#include <linux/devm-helpers.h>
> >  #include <linux/firmware.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/of_net.h>
> > @@ -751,12 +752,15 @@ static int airoha_npu_probe(struct platform_devic=
e *pdev)
> >  		if (irq < 0)
> >  			return irq;
> > =20
> > +		err =3D devm_work_autocancel(dev, &core->wdt_work,
> > +					   airoha_npu_wdt_work);
> > +		if (err)
> > +			return err;
> > +
> >  		err =3D devm_request_irq(dev, irq, airoha_npu_wdt_handler,
> >  				       IRQF_SHARED, "airoha-npu-wdt", core);
> >  		if (err)
> >  			return err;
> > -
> > -		INIT_WORK(&core->wdt_work, airoha_npu_wdt_work);
> >  	}
> > =20
> >  	/* wlan IRQ lines */
> > @@ -803,18 +807,8 @@ static int airoha_npu_probe(struct platform_device=
 *pdev)
> >  	return 0;
> >  }
> > =20
> > -static void airoha_npu_remove(struct platform_device *pdev)
> > -{
> > -	struct airoha_npu *npu =3D platform_get_drvdata(pdev);
> > -	int i;
> > -
> > -	for (i =3D 0; i < ARRAY_SIZE(npu->cores); i++)
> > -		cancel_work_sync(&npu->cores[i].wdt_work);
> > -}
> > -
> >  static struct platform_driver airoha_npu_driver =3D {
> >  	.probe =3D airoha_npu_probe,
> > -	.remove =3D airoha_npu_remove,
> >  	.driver =3D {
> >  		.name =3D "airoha-npu",
> >  		.of_match_table =3D of_airoha_npu_match,
> >=20
> > base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
> > --=20
> > 2.53.0
> >=20



--ROMP+kOHbe7PUdpe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarI/iwAKCRA6cBh0uS2t
rCBBAQDy2x6M/fi6duRrhEFZhDWaiM2e2dJo7Uiggfh389sWAQD/RM73V4pw21iD
BWMNWNTf6UaF0dWbwvNONop0kmUkHQI=
=o0gu
-----END PGP SIGNATURE-----

--ROMP+kOHbe7PUdpe--
