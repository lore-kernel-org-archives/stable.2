Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795702981;
	b=EfrcIAjgvADMdjf3Hl8bKmxMyfaqvYBKiRmXg0Qu/Ko4qnXI69+rQSOCBAajl2qvXFwC
	 cH7ju+Y5iCqaNNsxZgF3t0ExDUCF19o1xxQ444XASGj4YYS9ZVfRIpPB1Lq7E67gvuz0p
	 NV2aYPGMPeqIZMJxp1AtMAICJ3anqT1h1Jt3HBE0Oti6jBov5iznZYwiltN+bG+kg1hhM
	 dNQzL3ii0df/vwFpkoY2OVqNXFwm3doEQdbE6LnODGE3XUkoNIYpAwtoTJ3/6vNg0Qs3n
	 s157toZzRoq0Xniwpl6zM2t7LScjhjH3f/m5UAJgahO0ProgQElYipskulrQTi+b9Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702981;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=EqLFCb5XmtQPipwvLpAcDKVt+kHlckNlX0WznuDW5lA=;
	b=WfWid5vMoUfOntaxSI1NoANthNC/1HABbdqtjHXo5Jo/6Sdh4EOc+oxmQTwIvXiBNndD
	 kUMEQpFFstryUIWP3puD7yQ8COhk+EMnwxig2nI+6zxnStfaWVVrx5z9Cupaz4sR4JUD0
	 Rdel+vrC+6uZeEnejTYv2bcYPCiG/QsUc/rg/D452cyTxVFGPJIA6jmVQsTtsG55bP5eD
	 K7Kb0BrmasL8AfgTNzV9FQvy1urszUKjGNSond0zIJuVJ/pgk+m4h/np2azEVGhNfotCB
	 RKc0o/rJuQRj+PlqFa+s8aG3ysT/qde4jvacFHvQ/aUT5Q1mpvpbinJT9tELyLEtnwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=MTP6elXg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2412606A321;
	Thu, 26 Nov 2026 14:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2412606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=MTP6elXg
ARC-Seal: i=1; a=rsa-sha256; t=1795702946; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GzcComGISICfD0ijd263oCRnoQcJw1dywIKmy93jDC5oKVQRFACS3nTRwH7djnR58rKS/X0qKv0sDeGX2ZalBYud0nK6y1ymF2gXjOVmPnDv4F/tOu10aJpRwAmvfIApbvOtKhT6zDzG620AJ61n2IvZ/Vv05hA3rK1tJA+rKwI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795702946; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EqLFCb5XmtQPipwvLpAcDKVt+kHlckNlX0WznuDW5lA=; 
	b=j38BzdZHJIunTz0eNN4FL/TBMmG0sDGqlezzN31PowDgurWu1/O9y3beJXvamXFd+T7up7U+lQUxpM744/3xhlUBMqCUiYzhJ7Ht7rGC2HeiTSG3+WlSAeENXe8pLUasuCsa/OedlsWPnf1JI9JHpkkgT/oCPRO9hKyNrUhyNb4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=MTP6elXgIUaUN1zsV21nBC6L2lc4v28RHcQkSsPFjU1kh8r29SMSZrvcaHSfE3ABucBZz9f12Cfc5VoODJcrVTkkaHmNm79m00FVfhWpKyj6iQpoS9pbnQfPWiZdFSZtkdjFJJLaE0WoyPU5we/xapg3/Z7Dt8gD0JZhhM5Z6XM=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=EqLFCb5XmtQPipwvLpAcDKVt+kHlckNlX0WznuDW5lA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795702942410502.09212304582513;
	Thu, 26 Nov 2026 06:22:22 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 7BCFC1804FF; Thu, 26 Nov 2026 15:22:17 +0100 (CET)
Date: Thu, 26 Nov 2026 15:22:17 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: chanwoo@kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@collabora.com, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4 00/11] PM / devfreq: rockchip-dfi: cleanups and RK3576
 support
Message-ID: <awg_MN-Hn7B_Z2Oa@venus>
References: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
 <86a7174f-c44b-4663-862b-3631b0d6c5bd@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2jxiphyxg2w6bi2f"
Content-Disposition: inline
In-Reply-To: <86a7174f-c44b-4663-862b-3631b0d6c5bd@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.675.79
X-ZohoMailClient: External


--2jxiphyxg2w6bi2f
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/11] PM / devfreq: rockchip-dfi: cleanups and RK3576
 support
MIME-Version: 1.0

Hi,

On Thu, Nov 26, 2026 at 10:28:28PM +0900, Chanwoo Choi wrote:
> On 11/19/2026 10:01 PM, Sebastian Reichel wrote:
> > This is a combination of the DFI driver patches from the following two
> > series to ease applying to devfreq tree. It is based on devfreq-next
> > and there are no other dependencies.
> >=20
> >  * https://lore.kernel.org/linux-rockchip/20260921-rockchip-dfi-cleanup=
-v2-0-43ff34ac8599@collabora.com/
> >  * https://lore.kernel.org/linux-rockchip/20260921-b4-rockchip-dfi-rk35=
76-support-v2-0-04f847016321@collabora.com/
> >=20
> > Changes in PATCHv4:
> >  * Link to v3: https://patch.msgid.link/20261117-rockchip-dfi-rk3588-cl=
eanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com
> >  * In PATCHv3 I accidentally used the patches from PATCHv1 as base with
> >    the wrong DT bindings; this is now fixed
> >  * I've fixed num_clks typo in kernel doc (Sashiko)
> >  * I've fixed incorrect LPDDR5 BANK_MODE_MASK for RK3576 (Sashiko)
> >  * I added a fix at the start of the series correcting LPDDR5 bank
> >    mode value (Sashiko)
> >  * I've added a fix at the start of the series avoiding usage of
> >    uninitialized memory (Sashiko)
> >=20
> > Changes in PATCHv3:
> >  * split out DFI driver patches from both series and merge them into a
> >    new one; clock controller and DT patches will be sent separately.
> >  * rebase to devfreq-next
> >  * collecting Reviewed-by / Acked-by
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> > Nicolas Frattaroli (6):
> >       dt-bindings: devfreq: event: rockchip,dfi: add clocks to rk3588
> >       dt-bindings: devfreq: event: rockchip,dfi: add rk3576
> >       PM / devfreq: rockchip-dfi: move to per-variant const structs
> >       PM / devfreq: rockchip-dfi: add NO_INTERRUPT perf capability
> >       PM / devfreq: rockchip-dfi: use bulk clock APIs
> >       PM / devfreq: rockchip-dfi: make RK3588 use its clocks
> >=20
> > Sebastian Reichel (5):
> >       PM / devfreq: rockchip-dfi: drop incorrect shift of LP5 bank mode
> >       PM / devfreq: rockchip-dfi: initialize dmc_count structs
> >       PM / devfreq: rockchip-dfi: move register offsets to variant stru=
ct
> >       PM / devfreq: rockchip-dfi: prepare support for v4 DDRMON
> >       PM / devfreq: rockchip-dfi: add RK3576 support
> >=20
> >  .../bindings/devfreq/event/rockchip,dfi.yaml       |  89 +++++-
> >  drivers/devfreq/event/rockchip-dfi.c               | 297 +++++++++++++=
++------
> >  2 files changed, 290 insertions(+), 96 deletions(-)
> > ---
> > base-commit: f9316c13d6f621af4f6f4a6089d3c989ffe899e6
> > change-id: 20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-747=
27d64d729
> >=20
> > Best regards,
> > -- =20
> > Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Applied them. But you also need to send the clock patch[1] and get
> it applied. [1]
> https://lore.kernel.org/linux-rockchip/20260921-rockchip-dfi-cleanup-v2-6=
-43ff34ac8599@collabora.com/

Thanks. The clock patches (RK3588 & RK3576) as well as the DT
additions are on my TODO list. The DT side had a dependency on the
DT binding being merged first, so I was not too much in a hurry to
send them out (esp. considering nothing changed in them since v1).

I will see to send them out today.

Greetings,

-- Sebastian

--2jxiphyxg2w6bi2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmsIQJkACgkQ2O7X88g7
+ppr/g//a7aHkud2vzc0NUnb34c5K7j1n3UQj4oqhM1BvI5qp7bk1VtbSlsKHaIH
rNhBleXpFwipY82Sfshg6ybDpxMthtqxmGr8vN8s5P8nhXnlfS2MbtV7vVpwNRV9
b+Or6Y++/x79VbeA+t3IdCbizCep2IFcdvzsFBAvumO2LDJJPZY54/DosCSK2ZhG
axl8zN+zbvvjyKXaAajNsd7SDOj3ueUoY8fEkZdsZIoBC+A/hRzv42E9s/B9F8zm
vB8oZWgo9iwoT+iJSWrF8yXrLTr7+Wx+DIRUYob0PaJbcnIzIXd7xpGx95zqiULm
ye0UPMkfbetgPNrno6KAliTD/nBbaZvjJDpLogwGbicn6gnmWHqXfgm9WNH5Jv5L
LYpO9WOc0os7BlLyKky+ViLyK9GRFKCCvpzhTBV/P5bwHMHyModSz7P2+Hm7Vy/Y
d9WGgEhXlYRaQGumfCTW074NZriA56Ct3Fjir2XhALOGOE/b98HWcOEjckBKjEoA
4dvMD6SW3a+P3/sD/LxtE7LotDw8SQyRljTZ37FntNOdOcFfrt//vgwZuU0UeCNg
f824yBSIZCE/QmTUghNeKQ5tQC2hTlF5NCIJ9oVo3sPfkz8Ove2zd8V/LZMAgbH0
jC/UeIIF8nx7C5//ogFhrkEJbeYjbxRz9fDZdNJPzFHcPSEqI7c=
=CenJ
-----END PGP SIGNATURE-----

--2jxiphyxg2w6bi2f--
