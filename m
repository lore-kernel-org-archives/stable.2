Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B08E42C505;
	Tue, 11 Aug 2026 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442361; cv=pass; b=n7+hKWqbTsDP6ehA69BqCILbEEngZgAZ5AcwvDx2PwNKQ2T6amOyxKZ/nqBosEa8YWTsEvKYC7qqOXtlzVcUemLGahBc7NeWbN29ntZTqK0mNXPBaWdr1gshsphMKLqWKcR/bRoFK9XIFTxyDmMVW1NhGjngIVfXCBnTDqvXk9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442361; c=relaxed/simple;
	bh=uYGlhKymNnZsOXyBIbYPiOTZKpfEaZrCJEwejgqjH9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTHHfQEGN8f8hWAZpMnmDm/zFsx+VywsrRVRADH/np0u/G4ZBanOrtulIRstdcC44wmyTQsacWTsYVV7rjcHbHtSnCot9Ok0j8Iecu8MITfJQd9hB7iPHyD0XPL7G20mRr077TkFCGUUnPtXVQu30w5W+Bbs18tj1T+3Dq9dDns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Ay4ArX61; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Ay4ArX61"
ARC-Seal: i=1; a=rsa-sha256; t=1786442340; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mozdD34E4HH/pFm4wiHNJ87c+Ef+T33FbHRHh6+1lyARiPBEAfC6hFExK97HJnMHzuHn6Y4toAgcpdmGW2nDjl+xcyJ4YKptmktfRMFSaEYqaAiccykLeCvWnmMR9XmPaLf5c7HUcLypv5DRdgapqXhpEs74cNpGlhThaedlgDE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786442339; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vxEvYYyBezC75jJQ3RoOdEPHjpblgm6x4Qw72BfL7go=; 
	b=dRYVxinFWS4Cyz6dnjnWghMDEljDMW2CmV8rSDFFbbgGSKsOQGDMYsJVUT/NkkhRz1nZCw70JSSil6vQ5YYWbbU2XmnQYt7Ok255hobSUo7s2sUEbccixbgB9qZPSPR7gDekWfwHJS09EHAYv7pQJavL6OpAE0+QGw/ILADr0eM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786442339;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=vxEvYYyBezC75jJQ3RoOdEPHjpblgm6x4Qw72BfL7go=;
	b=Ay4ArX61ikZruc/9fj3NHKqtev6eLxj+Xzb6ZJQNYC3pn7icSlhGEbuHwbU8DEkc
	c5zHKCSWF6qM8EsJ9DQM7Mr1qjKd0dhrfPvOvT51vZnEs2nOpvVrvf5jAhcPUaUlYzu
	j3cbKzB+fvvsDJuC106wLBWm+8j5nXzsBbu+s6JI=
Received: by mx.zohomail.com with SMTPS id 1786442337024779.1505974458477;
	Tue, 11 Aug 2026 02:58:57 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 5B52B18025E; Tue, 11 Aug 2026 11:58:53 +0200 (CEST)
Date: Tue, 11 Aug 2026 11:58:53 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: jason98166@gmail.com
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] phy: rockchip-samsung-dcphy: fix out-of-range
 max_register
Message-ID: <anryDBa6t1k_VhY3@venus>
References: <20260811-dcphy-maxreg-v1-v1-1-aa63f6a63a64@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hezfusjcjm6tq3wn"
Content-Disposition: inline
In-Reply-To: <20260811-dcphy-maxreg-v1-v1-1-aa63f6a63a64@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/286.434.97
X-ZohoMailClient: External


--hezfusjcjm6tq3wn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] phy: rockchip-samsung-dcphy: fix out-of-range
 max_register
MIME-Version: 1.0

Hi,

On Tue, Aug 11, 2026 at 04:10:22PM +0800, Jason Yang via B4 Relay wrote:
> From: Jason Yang <jason98166@gmail.com>
>=20
> The PHY register block is 64KB, so with a register stride of 4 the
> last accessible register sits at offset 0xfffc. max_register names
> 0x10000, one register past the end of the mapping: dumping the
> registers through the regmap debugfs interface reads beyond the
> ioremapped region and oopses on the unmapped page. The oops fires
> with the regmap lock held, so later PHY operations deadlock.
>=20
> Fixes: b2a1a2ae7818 ("phy: rockchip: Add Samsung MIPI D-/C-PHY driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Yang <jason98166@gmail.com>
> Assisted-by: Claude:claude-opus-5
> ---
> Observed on an RK3588 board (v7.2-rc4): reading the debugfs
> registers file for this PHY faults deterministically at offset
> 0x10000 (translation fault in regmap_mmio_read32le), and every
> later PHY operation then blocks on the leaked lock. With
> max_register corrected the dump walks 0x0000-0xfffc and completes,
> and the PHY keeps working afterwards.
>=20
> Growing the mapping is not an option: the TRM address map lists
> each MIPI CD PHY as a 64KB block and the second PHY starts at the
> next 64KB boundary, so offset 0x10000 of one PHY is register zero
> of the other.
>=20
> The same mistake was fixed the same way in c7d436a6c1a2
> ("dmaengine: xilinx: xdma: Fix regmap max_register").
>=20
> This is independent of the D-PHY receiver series for the same
> driver and applies in either order.
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c b/drivers/=
phy/rockchip/phy-rockchip-samsung-dcphy.c
> index cbd780556da8..18f5f582d1d7 100644
> --- a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
> @@ -1526,7 +1526,7 @@ static const struct regmap_config samsung_mipi_dcph=
y_regmap_config =3D {
>  	.reg_bits =3D 32,
>  	.val_bits =3D 32,
>  	.reg_stride =3D 4,
> -	.max_register =3D 0x10000,
> +	.max_register =3D 0xfffc,
>  };
> =20
>  static struct phy *samsung_mipi_dcphy_xlate(struct device *dev,
>=20
> ---
> base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
> change-id: 20260811-dcphy-maxreg-v1-74a99944cf52
>=20
> Best regards,
> --=20
> Jason Yang <jason98166@gmail.com>
>=20
>=20

--hezfusjcjm6tq3wn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmp68lYACgkQ2O7X88g7
+poK9g/+Nqc7myb/yuNbrNPi5imh9k6+yt7OLjibqi6W+/7Q+E00IAwOkcqqi/CQ
Ar2C9sq/SbG3++kYmuLFSeTuFNdrMJnFBTV7aRSLv/Q2+ZDuOwcKpEeHXZvajLVZ
FPYqXwJo3bK5gzRmBmEZRZ4vLETayDoBj3NCcQ7vDj3EQYi1JealpGoWHqa97sPb
zPW/HGPprwR7RNLde/oWaz4dlW2oGNA0eOD3W6/KN6kwfuwXkTNZLWU1ITYVCKtt
NzJY+zJKBAvKuMuGODfST0q4yY3+zY5YDHmLGO7kaDzowEVMg3YRhD1o1DRiicuh
WafZFqbnbA0roPZyLHoAsJoTK8M/mjzhjcBmTpFC2X4MUeKs7thtb7TIMegRaR9A
2NzBDw+S/Yt+pVc15FgrZ5bB5JvEGeI4FsNpQglnrgvsINcmKw/xD+zx8QXE2fJU
Kq/iBRw4hDvINts9hXIu8c5Xi+VwIgB4GC2dM7ml2Su5puqHHfXSQx4BamFYNoiq
ojRmpJjrCI598iHBR4CfTbFRGKJbgQEML/dmSGtuGtFuu5dSlxqP+xvW4kA4Aibi
iTl7sV6KA/+zHYRFtLoWzyapkBzueOZXG73d+xUpvzjmKCSUMF0cBh4XQdNuBuOX
utzPltFrDO9mrzRemCRTLnYsdtxW5/Q8A0YGSBfOSHJAE+m5Yso=
=54wT
-----END PGP SIGNATURE-----

--hezfusjcjm6tq3wn--
