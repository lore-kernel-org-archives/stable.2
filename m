Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6E3CB2DB
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144341; cv=fail; b=U7McKhY+WODcOykwTaWWj/IhlzMm3wZA3E5hhv+syvb5Kfo8r1rotx5zSi/fC4R3HkW6w+3mECAv79XziEedaQooSPlVliA7mbxUAL2/SYA3qRtarIDyQzWBVFvpKDSRP3wqGzaC+r8UT/lw2SSrNRuRcThoqmeiPtFg/wdHBMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144341; c=relaxed/simple;
	bh=dkHnORNcMfDDiKre34HOwvFTYvI3sWETlqRkgT/AXWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AWmUlVipyQSyJlx3RsAfPxitX0s0VnPbFS8KjqbP3tDAE6TMZUd0lIVLHoBkn51A2G6OMI0kaoVHAQeXdXgO20Il815UiBb1jBQcx6aidf4CNA5k3xKY474PKi8a9byigUDYGyc7uvWKQhAtCdG62OUwh+9eUVhfj1UIVKnBVKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XPOGEM53; arc=fail smtp.client-ip=52.101.61.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XPOGEM53"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FC9y3YoH2OeLgygakSpl72Z7x2vTJxF6fzfMPTBs0t6YPGIuWrP9jtJLdaw7lzoA3KaQ6yyNQJp2RMOfXWfzfxc3jlkoMV5/M9nLejFfuWxk8K+ug+OglzwbP12RNvbrlyWsYFZXgNgxs40cndICW7OaC6+fm5r/qi9WWBOIoG5+DY/DwE+2iGbP8oqAK7mWEnoHyQA0llEOJVvGMRXJexlSRL1rTb+h7+8y9RW63tBTLZwDFOnFuuFgbkRJ+ZTuQxEISnSdhWAmN7gWL8sZNKodD5PE9JIqyVLzcwDymV/9Hx2e0/F65wqHI4Qqb0HOwxN8FxV4E1q+5emGhVS+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8zwOnadhn/K62CvuAGerGeXrh7KD594WLhI4MkJGgY=;
 b=Fik6COpU7t6jy+2hT/lpe9dZB6JOckLB0FBQKWFILD4b86hBipUu9u9CRgaWXGw8HinXab9Vc3MPy+rw38agTkUQlwdsP8tIPO1PR43fgk4Lqx7qfiy8zwholfZ4y2HWkF8zjojc+2TGWoWNRrKIBpsf6gWWyfRZRGg7PcjkY65A73eUp9k89juNPyrlqNK8nsx2HEZWARKSnf0Ii8M4Uk5CkWEuAhJ9iz+4+zcqhb9yNuzOUv1G3Cv79QOVz/iX9kjCiqq6Hdm1VLN744lRGhT/wcuG1dutHNjCSputEsAn1VVWJm6CdnrgpSVxnlBPHh652iuxqvT6mi9Crlq5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8zwOnadhn/K62CvuAGerGeXrh7KD594WLhI4MkJGgY=;
 b=XPOGEM53ymnxBnCR/R00/ThTIN862KwXsbXiyPjCnarmjevrigSVCo5APBZFv/4HwV0HqiyulWn1lffl4DueMjy8C8BFhIOgsy3WSm5XzeSirx64X+AOocRZ/VoPykRO4MSuGfClyhQ0ZOpKhS+CrnHnK3wd/2qsqC5r8x5dq3jJAnFbghzwHatsJT+jTBgxdDdt8WQvHL4XXfjJ8DiuCGs+3fzeylB+Tnze0Sx71EvyqR7Hvs7SLCF/vDRQ/WsqcH4ZrKxSW5G1FNGolhM6HDOphFvZoIj0pbIxj6dJYWXv0bmsWLMq1NFGIKKQvPmlRzlkkbZmQHcneHBlCfV3HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 by IA1PR12MB7614.namprd12.prod.outlook.com (2603:10b6:208:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 16:05:32 +0000
Received: from CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315]) by CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 16:05:32 +0000
Date: Mon, 22 Jun 2026 18:05:26 +0200
From: Thierry Reding <treding@nvidia.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh, 
	dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/6] drm/sysfb: simpledrm: Improve panel-size
 validation
Message-ID: <ajlce8LJQVXm2eic@orome>
X-NVConfidentiality: public
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-3-tzimmermann@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wqtgabbwikes65nj"
Content-Disposition: inline
In-Reply-To: <20260622132433.722823-3-tzimmermann@suse.de>
X-ClientProxiedBy: BE1P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::10) To CH0PR12MB8488.namprd12.prod.outlook.com
 (2603:10b6:610:18d::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8488:EE_|IA1PR12MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd43ace-73e7-4868-3f6e-08ded078161e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|23010399003|1800799024|3023799007|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JZA1C/ibJhYOR0ld3qy9poYFwM2KutDjpJ1HHHRB9VoD6xS4eOiasf6xrQvQpnyzo6GFFf3kIR88V3FvOEDNv+IB7RHEhJ64ckl3WgGhbM+jcHAbWX0iyfJday3iefsUY14BIHHNjoIS9JEM2uO1MQm+4mVzmbtZW0eE6BMpBwfGik2yNX3CpUHndAgZpHAsc45oFjix22TD5tFv8MhW1+Z4GVmwGSuyJ7Mfq6rERVA33almAsfz0jLC0VEfs1AEhiewD0xBC0IZg+q8L0yaiWInuGb24wQFhyU3pWom65/Prkx2hPX4/U976qYKTHhf2jHBaImmk2xqDDeVqQEb5eoQyQ71Tmrn+4eHro0dT/tJE8ESjGZ4vU50gk66Bxt+PaWSegGTjErpQuWg1pYq4J1N04oinOXp5Nv58vzGUjVj/v6qxHkSU9R+QAdla0hoJ/rarTxs/GbZUA5tfpYyHxg2Md2yUyqJteHSEtZ5JPSJ3uX7L3GMkL938TSztM3CrmPEKapgJutz/u7/P7vIU41LvD8208K8WsLoNUu1dRmSQ0yWD0rdFDE7VilV9gJ+c1B8AOv6VhdrPUDe1eI6+T2gQyWzFgSmGPaGPlnjdDMHoHVuz7bvqQ6t63bB4mIxXHoPHyQmnNXqSkgRyim8/X5FnEgufR4+zFZIQggtGrM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(23010399003)(1800799024)(3023799007)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EpOWWFPc5r8/Nzr98s9bhyGvl5xKi8f03DZ2S8XkWEETxM9Gn7siT51k5Bz4?=
 =?us-ascii?Q?lBYC49Io5v5jHeb2qvsefSpvs83Jdtwn86JFSbwgmWhmvacYAF2/6uMiPYor?=
 =?us-ascii?Q?l8+kUAI9aPHY+qGmCq0aGyf9vB/YqmJQdlz9Ywm0LH5J7ZE6fBGMoXLiWyK9?=
 =?us-ascii?Q?YXoPz9MF5yXZLsASv0Ci/LpHCLG83uvvj8k634N5G8lbk+dmoc2gqQJynWRk?=
 =?us-ascii?Q?bbcArHe048vrHUHLpYfS0fy9Bi0tB9qNTeZENdqT1GKAW4ZvxPXz8QL1+bGc?=
 =?us-ascii?Q?Zb8J/QT36g/b9ewSnmAJ2PehE6k8C0eM4842YQXpvdwTfBmNnhs1PBLCQgO1?=
 =?us-ascii?Q?K6Pel5qyM0kVrW4B5hQclJ51UonhZv3YgGSXXrQyNgVlQ6IzGGRzB4y2gO8K?=
 =?us-ascii?Q?uns7V+EiYexNe01Bszbpu5WDkO4OUTz8+6p62foKiLmTAa8ZIgRUvtTRpaC2?=
 =?us-ascii?Q?6nTn/i8GaUx0EikFFAaitHHfeHhkTNAZokUwf7XA9IAbm4BmV5csEAgtZs/u?=
 =?us-ascii?Q?JbJBlDH0y5rDXX/gNoeygJF32ZQV2Xc5JPicxDtEF68VfPT1f51cM52Kx9AW?=
 =?us-ascii?Q?qjM7tmwjcpf/wm9qiMj2bCdrILolQDZNThsV+vh7dR1KmdN3yuBpdAmHXkoy?=
 =?us-ascii?Q?HK7Xygw2dL1f6CA1a3Ro2x4WglCDYp8T272Z8UCMdzXW4SWscACZ57hlIjpz?=
 =?us-ascii?Q?wade8D4lZdNXJF2n1lmSBHx1u2GRn/8Gf/6fsUNu/az3FldSvMPG5xyTGNuF?=
 =?us-ascii?Q?OfBVBfQ99QDaNvaHwftaIivYScaiyBnDWr3R8vPuggz0gu2RwqNJ7n+wfmHV?=
 =?us-ascii?Q?y2jme2RwfxPqv0KabQWdQIxIhwjPZoc/yaieMItateT6tWa0muwvwkbZD5Ga?=
 =?us-ascii?Q?PvI2RvLLyO64gI3fVDW/3Wop+2cE++oI2w9bO5nCgwjRtoayPbuV/nGIVIFo?=
 =?us-ascii?Q?maOZWgI6C+K5tCqO5A2R0nhhJ3eQQS8c1z5hVYDtNR04pcDIKz2wjCWbL7Hh?=
 =?us-ascii?Q?M1mTNLJceuINd7XlV/FXxihQSlz073Q420c9FWRABTDtEJsK4K3Uon2btOHv?=
 =?us-ascii?Q?L2U3Gfkzs5LzabY73YK54BfmWx7XL8DxDqnXkKvHnHSz2r60z64SW5L6s9D4?=
 =?us-ascii?Q?QLGhGmZkb+q8SqyX9jsPDDHlMaRdxLAIm1Rr9xjQXfU47tP8Ig3ZFzeNJ7Zj?=
 =?us-ascii?Q?84cHsUWjTX6kpxof7+HIjCkUjcdJuqJq8Xgw+XldabG4lgHiimPd34WQFYBG?=
 =?us-ascii?Q?T6uSyGvIJE5y4RwEEqQbscI+lLdJ7y2V9MlbkydmVKxgJcY61xK6zQkH62Ty?=
 =?us-ascii?Q?JBQsBwwYOX1dTPIMIUrVlzNPfbpAI38CIgcdM1RxWdhwKRLBi8ImlymY/Kd+?=
 =?us-ascii?Q?SRotkatlW5N377lN+8ztyk/EWt/DSLSOB/c+x/PdBUJTa8BXMpnuoI1DG07D?=
 =?us-ascii?Q?897UeDmcBN0IYEQJKZdhRFj9/gfd9kDY3tNngk+XvLYjW28I/bd/6zNMp7Ie?=
 =?us-ascii?Q?ygS/epubD8X43+PDx4Vjvy8/uwqmkhcaMayN4tG1j6cYheuWQGjuPZvfkZym?=
 =?us-ascii?Q?/VKyI3UHO9ZnPpxAcHYKCrpvOA5XtyONE8UjdjmRbSQcIwRS6YVJfW2Tz40b?=
 =?us-ascii?Q?MkXvMnSY+b6rnbF3WJHUAiQFNU2G8qMKbrCUyexkxRpgD0VG0oP1c6tlSd7i?=
 =?us-ascii?Q?rdF03XZ42/Xm7z+dOXpfAMnR0fQd/JMme8RlH8bAEEoslOqJ/3lPjEEIQz+u?=
 =?us-ascii?Q?1pRv8QpTM+HP2xGif8thHjI8vHY8fMPnxjhK2loERhOq4H0SUOQehihjfmIj?=
X-MS-Exchange-AntiSpam-MessageData-1: ZtMTy79q7HQb+A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd43ace-73e7-4868-3f6e-08ded078161e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 16:05:32.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJq0iM98S9nefgzOSWX0p+dUeXg1Ifdi+NLfwEzshJ7msTl54jkpYt9t7n3iC2TP9iX2bNIOW4vXu4MANRN3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7614

--wqtgabbwikes65nj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/6] drm/sysfb: simpledrm: Improve panel-size
 validation
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 03:19:36PM +0200, Thomas Zimmermann wrote:
> Validate the panel size from the device-tree node against the
> limitations of struct drm_display_mode. The type only stores sizes
> in 16-bit fields. Fail transparently on errors; do not warn.
>=20
> v2:
> - only use initialized values in debugging output (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 2a6d731a8f16 ("drm/simpledrm: Allow physical width and height conf=
iguration via panel node")
> Cc: Rayyan Ansari <rayyan@ansari.sh>
> Cc: <stable@vger.kernel.org> # v6.4+
> ---
>  drivers/gpu/drm/sysfb/simpledrm.c | 40 ++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/si=
mpledrm.c
> index 15dcafa9d524..fa2121f81def 100644
> --- a/drivers/gpu/drm/sysfb/simpledrm.c
> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
> @@ -193,6 +193,40 @@ simplefb_get_memory_of(struct drm_device *dev, struc=
t device_node *of_node)
>  	return res;
>  }
> =20
> +static u16
> +__simplefb_get_panel_size_mm_of(struct drm_device *dev, struct device_no=
de *of_panel_node,
> +				const char *name)
> +{
> +	int ret;
> +	u32 value;
> +
> +	ret =3D of_property_read_u32(of_panel_node, name, &value);
> +	if (ret) {
> +		drm_dbg(dev, "simplefb: cannot parse panel %s: error %d\n",
> +			name, ret);
> +		return 0; /* not an error, simply ignore */
> +	}
> +	if (value > U16_MAX) {
> +		drm_dbg(dev, "simplefb: panel %s of %u exceeds maximum value\n",
> +			name, value);
> +		return 0; /* not an error, simply ignore */

I wonder if it's perhaps better to move this comment to the function
scope and explain why this can be ignored. I didn't know and had to go
look at drm_sysfb_mode() to see that if these are 0, it'll compute the
physical dimensions based on a default of 96 DPI.

> +	}
> +
> +	return value;
> +}
> +
> +static u16
> +simplefb_get_panel_width_mm_of(struct drm_device *dev, struct device_nod=
e *of_panel_node)
> +{
> +	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "width-mm");
> +}
> +
> +static u16
> +simplefb_get_panel_height_mm_of(struct drm_device *dev, struct device_no=
de *of_panel_node)
> +{
> +	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "height-mm");
> +}
> +
>  /*
>   * Simple Framebuffer device
>   */
> @@ -594,7 +628,7 @@ static struct simpledrm_device *simpledrm_device_crea=
te(struct drm_driver *drv,
>  	struct drm_sysfb_device *sysfb;
>  	struct drm_device *dev;
>  	int width, height, stride;
> -	int width_mm =3D 0, height_mm =3D 0;
> +	u16 width_mm =3D 0, height_mm =3D 0;
>  	struct device_node *panel_node;
>  	const struct drm_format_info *format;
>  	struct resource *res, *mem =3D NULL;
> @@ -658,8 +692,8 @@ static struct simpledrm_device *simpledrm_device_crea=
te(struct drm_driver *drv,
>  			return ERR_CAST(mem);
>  		panel_node =3D of_parse_phandle(of_node, "panel", 0);
>  		if (panel_node) {
> -			simplefb_read_u32_of(dev, panel_node, "width-mm", &width_mm);
> -			simplefb_read_u32_of(dev, panel_node, "height-mm", &height_mm);
> +			width_mm =3D simplefb_get_panel_width_mm_of(dev, panel_node);
> +			height_mm =3D simplefb_get_panel_height_mm_of(dev, panel_node);
>  			of_node_put(panel_node);
>  		}
>  	} else {

The drm_sysfb_mode() function that width_mm and height_mm get passed
into accepts them as unsigned int, so maybe that should be changed as
well for more consistency?

In either case, since they all end up in the u16 in the struct, it's
obviously correct to check for the range when parsing, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--wqtgabbwikes65nj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmo5XUEACgkQ3SOs138+
s6GDUg//YdFKHi9j6iuT8sgOHj5xeMEaXLCs3VmlSmYxkr4sRaVz/gz/SdpnGAeZ
kKnHg3fbueu3V9vL5iegiQTtuPEGyjPIJ5D/+ozSmXDgt6zCcmDxfgOP7U6QYvn0
A1qJcARW7EvEsfH+kEw5yI7eDKN19akrMLaFF2A+yqf9tkcecbUrvltGvPJzShZA
hVmA+P+rSRLPjrnBf39Jx6dJGkebBPBHbkGwXnVZFtzPWCP4DJ2KuigqcWnSqW5b
bXGOw2pgUZtBWdbL+Ng3v3qrccZw4NqtnwVemwFGR8qEUXyT3e/aj9o06f7PVNJi
zKMVj7Ujib74q3EOugkWntfTGOgS4o8j9mJw+xTcJkgslRxNxvZYvpKA9wqBXNgn
YPgD15LLKXegr3CrhZkkOy6miBjEcRfRrb3Kr2yAQaLQG+qk5wBwL8E1oIGZljgK
r1jnIEF80gRoE6+JvoEqD+eQn2nrLtn4Xg33mE8xKcRFRt9zhoStyrLpKEJufWWw
haplOHUtCDh7gjaRMV3NQ4kBqiqgPicwxNfD8XoBg8ixps5dQ8HiyJQhGi7rXRRG
jTdafWjWfasd9Hen6x+3HSl0PIBPe3635LC6WA4DO2aq2+Z1IedW0EFBNs1srZmH
x+9fssO80Dw0CaBEFtn8UYCbHsOREvM2LVhtziL3DN7o1Jwzmg0=
=TC0O
-----END PGP SIGNATURE-----

--wqtgabbwikes65nj--
