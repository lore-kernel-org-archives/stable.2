Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4572E54AA
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142615; cv=fail; b=M7tgjAKnw8bDZMbE0hU7AueN6iNdOIahQzVz85/5+zIVJQ5Gq1ccQYe1Ruer/KvNApwywxV6STEZyBBLONpkZpVmgfpsX/xAuyyTqfk7r6HjGZrNNDZrDtGBLkmw5Qzpq5nycc7lcECb2wkN/no0e3aB5Ah/LUEScUTH2q4ENag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142615; c=relaxed/simple;
	bh=lLgWmy6ocwjDa1M2L1HPnVXQMWpXPslyNrzNFWApF6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mpZnf57ETWgcq9sXKL2uBFfdDsI55+Ld9IV6xvQCUBROwPAbmIdnbvYOxCqAPJOljXZAIdnFLSXsu2l/Bi1y2Oxu8Au5aQvq4O3Vx4pcBLyhCCvRpf1yy3d4kwzdUscMrpU2h9+p2pRilg7OuXbo3fJvjv2sCbOgln1Bm7DqbgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a4mDC1g8; arc=fail smtp.client-ip=52.101.62.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a4mDC1g8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyI2tg67LKJDH2PrcuewiQJo0g29QTKy1YxnisWzcjB7qxTBU7WMTtPTOEIh6A8fCqAi32G0aRqGEA6jLuyqaJa7iESk4J4x1ll+0PqFvF8KT+HvZXZGAVKrynpmuHcxBA/kQO4NF4Amh+1kJaupuJbabB6Tz8M34Z0+xpsrqfHM8/+W+9UEBknBRADd0QkBx9cufseEK6v1tMl+9gabnHxYiDOpU3LATeL8CSQ/L4qHVFozTlOwq5o4XjeXwaRblCU43XQU2s9XXIZuU5/do8ax0LrAiBtMPyUtIZCQTkBfKFxfGYE1IWpgYeDttxDkFzuP6FvCe+oiN/s9dQvkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGBM2LCi6a/+3eUSqN0J8m3NwZq1tmKRs+CR206ykhg=;
 b=WGrEpBGjax1KzETJFFiZzTAHtDpXGTHlo1+KngYTsS0V5v7UhIQDOU+LGA/eb5axpOE3HY65ELJxTQQBhhKvo4xvGlTIBJ5oUfxpSObZUsJjXQ5o1uBkI4IZMZRAbDU6CotT8nXapAmL+18tF1MlfYXbfdN7Vfw+q9ht8THcB3axaQiOzSVZEqJHoTwugAxzfQx7VKw+1AGjMI6hCJ5WhKKQ8n7RnmSDLtZJ27Q2bvH9WNpRnX3MLROl79gskILaUqMfJQzpR0toMUdS9Ssk4HLgq1C8HtJ08FKcdzHvpHRRWdsAdzmX+2gxAqDYXyIxEiG1zmI/oSTKveLYL3rHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGBM2LCi6a/+3eUSqN0J8m3NwZq1tmKRs+CR206ykhg=;
 b=a4mDC1g8u0ko9g+O1QyDTFCKNoExgg+ecwpRNjM8Dfq+jr3ZZ5/gTUgLcGTV6Mkjc9hXGYZhgLn2is5QnROkWkn5U0STiW/cjkZ7QeELWDBokSiIoFAwsIY2cbaIk/mICd2iEPKnCLZ18F7JvGXzR+1MfddwEYAVSM+w/kGEnc4nfvZ7WrgRBU/zsPkPhUFPe9K4OfqumAWC23OGSucX2mZdi7E+S0JMuedIUY2lk4z5EPVSOJJW7GQmCarjl5Bg5IwMl4jY0kmYtZTepGsAkxCXsp1SWXTgEBKIv4IfH7ptHX4vxHHVxs/zD8NoVz1ckdgd48EMb73+pFYXOAd+rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 15:36:48 +0000
Received: from CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315]) by CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 15:36:48 +0000
Date: Mon, 22 Jun 2026 17:36:40 +0200
From: Thierry Reding <treding@nvidia.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh, 
	dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/6] drm/sysfb: simpledrm: Improve framebuffer-size
 validation
Message-ID: <ajlWgKOnMAmkyZTc@orome>
X-NVConfidentiality: public
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-2-tzimmermann@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="klyze6w3qjzq3jpe"
Content-Disposition: inline
In-Reply-To: <20260622132433.722823-2-tzimmermann@suse.de>
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To CH0PR12MB8488.namprd12.prod.outlook.com
 (2603:10b6:610:18d::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8488:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2ee414-6a9e-4573-a150-08ded074129f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|366016|7416014|376014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	MGKLM2RHlxkdawsFggPVU5jmG/gh8ZYSLGDDp/0eLmV7VwrjM6/u3teDWjbrYh4964An5bGQvEjQnCT3JPMoS1Ta2VGEURRGWXse0rszRhwuxxfgS9/19xaUwN8GLqZcKL5KZ0+a79fNCqp3zhcT3VB7A4xA3LhrOJHf5eLYu3J/Wwx7Lhy2NlPiWkAZO1uVoI0epOb1fbYYATZGyrA8mlCSMCcoMWjSR+XkDTiiStazJKqRCpY6uNWSc5338BzhhW9T8ub8LTBQwkoVPmuyae4NI0nkaKLHsndKBGaz37M+pl4LbrObCxV65Q/QeZIXTKom3aUpS9N7TURwn72Fv0pd/etYpmy+qnZMDIgzEc59TojEIcwEiyEygUFNExt+gNCCLe5qUlPKqmD1j0B8SQF8GUjSvO1Dlj2Z0o/ghZAH7Ln4w7zZb2SCPGe4cf82BRH0EPWH2v+b9TlCBj8M4UJHLVc+QYwHUwUrInFmFNOR+sB5C5PmmU29XsAQkq/boeILZVE2sXC0v92HzesswExb7tanhwPGQWmWVCpHq1edgUgq5uJEa3oL1bPYDZd+9u9Wl5O1dNMhir9SepNsLWcWW9WB3vrzXDwu6nCwFByxRG74rsSJfZq1K8g8NnaSKdL/TS/hcqkce2cGEczqVVqzxAgyULUL9EpJQYLjcq0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cB8mJV8x3K9Pm6EC3bLn/SvBN10p9YRWRBIbYqAeGiRz1OjiUzzeGfcGETYy?=
 =?us-ascii?Q?+7rQUchRR3wTdNgHGMygMgTEQ2MPg56n/+obJoHzalrdPkFc1NJJqBM9LyRU?=
 =?us-ascii?Q?aQF4be7GGySEjZ76ed1VpQX+wWx/DZAnYQPT/i2+Fb+JQ23dpySCrZG6lm+j?=
 =?us-ascii?Q?FrrniAaVan9FelEMC5uGjnYEvTobSN7gB977SVWiDAOx9Ym6ps576vYJAnqE?=
 =?us-ascii?Q?FatrtIgso0620HXbicVUSEx6OBZdocEhG65z7oN2cCMUJMqbFWn6LiSxoNpE?=
 =?us-ascii?Q?bj6OxJTZycBkhYZt0j3lPxi9OIM1VELsrj8wSf7JZhpVbkvXfjU0epkDvHmi?=
 =?us-ascii?Q?5+o2f2Pas4scgqRF+Yjrv/ZU+o/381hZnJ8pnoWyxN5Ezqfr468u9oLmPFjr?=
 =?us-ascii?Q?bR1UvfTqVrBXFgfyugDbd/hDFzXHjSc22NsmbVyoyLt84l8pMOrz1dh03qPX?=
 =?us-ascii?Q?QirjPHwyNmg0pfkTDue4iuEBxqzQqOqI42d+JNjtYR7vhWGY0K0mt57NdUq4?=
 =?us-ascii?Q?jVb1+9uBAq1uIelNvaSz1cjtvVHPCDfvzKMZ76joYsUaYqmGUR2/QALZqT3n?=
 =?us-ascii?Q?WqcNAX6wk3cRZQG8JUX3JXUfd/+k/hvy4G353NrE2R03Z5fbIhgOo8jq65vX?=
 =?us-ascii?Q?hzaVqYS24P49rFN7PBo1s3yTUvMD/MoVP8JIzjxJCK6KrfQ5/x/xX53x3o6e?=
 =?us-ascii?Q?vZnvLuEv0xvZks9fDzeJSeTi2zMHP/y1eb+oXP13NbWRe/PGA+dTq/xu9pUU?=
 =?us-ascii?Q?qo/5eA56g8LUaZ4VzTL1CxA72ibCe6bh0PBSMCfIp29SptNsoosezLStxe1y?=
 =?us-ascii?Q?Z+UaSjAAKFG0J8h9JzK849lL77gvEaNgasZnpVik6L06tOkQvRoe4vkkzxbp?=
 =?us-ascii?Q?OHejn45JdgjGnQlOoWP1MioxBLXatYDObkIEo2V7Eb7YQdFT7bvi4LoGZnbd?=
 =?us-ascii?Q?d3J3mo3m4aGvVtCIuFvaW8FsAIvDNwMbHDSE01ymsYbf+e+u4rgHHJ4n+i9H?=
 =?us-ascii?Q?+oWKPizjdOBw/Zaxi0XUX4RYTJQRuHFnW5QyAPOf++S+A2Hj8Sxb1UeGF6Cg?=
 =?us-ascii?Q?BK1+AMKZvlIFoeihn2f9Zqtfzd4hbczVvpM7MX9hktVMG6uW5rxEfQP4rCh7?=
 =?us-ascii?Q?uIx9dnSQ/STs3v2oFLTkDwa4jbc4UvBP84BAcH3/xvSEZfD24/yXeuMmmLbR?=
 =?us-ascii?Q?9oGZVkQvxSLNaCL5giygSG/S3D1Jtpljbuf3xCJdjsV0WTSC0tg+rvJf1/qU?=
 =?us-ascii?Q?OeKiEIbe/ZXbpQTQ2sUdhmyCYXayzGRBN9oR2J4pYElhxGe3f22I2WgxxId5?=
 =?us-ascii?Q?jyJSxxQ3drb0oFUto6CYUvaL+GQYqMZ9cEQMM9qR/0/VJTAH/Nvw/CfHntEO?=
 =?us-ascii?Q?pk9S6LVzgycVx1Q2zMBhcM6NsgX8gUp4VOglB3CSPBYWiRpZPDFLComP6nN/?=
 =?us-ascii?Q?6xeovNHeJg+r2J4FT5STuvLZzaIbj266wAmScQDyYcvMWDn6sAQpQQT+kDzY?=
 =?us-ascii?Q?jFk6oHPMZ2wYlOURGbdt61Qa9S4NhKKB/ogQ+QO2ZR9yh94QPU/R3+wYVezn?=
 =?us-ascii?Q?AKI2ud+6NpvcGJZfWs4y0HkjzSrYehgK3qWPP+gPTkE2C/pEWkBv8ynVn0tr?=
 =?us-ascii?Q?qJuuMpWeGDWlmBNBL/2lorqsZqjxAoz6blmQMkW2QzXV+pOD/chQ48aQORHd?=
 =?us-ascii?Q?bJJsU9H6XALcqFWo8i9BnjtU/lAZa0WxWwQxKyqI2UoIljQdxk0AcjD1XQlj?=
 =?us-ascii?Q?P3uy5Q79JfHTWLh/3XEjt5aaGAZwAb3x2uxrpfKFwGkpDHqIJRXhHjJHOhkY?=
X-MS-Exchange-AntiSpam-MessageData-1: jzgHU4HIp273gQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2ee414-6a9e-4573-a150-08ded074129f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 15:36:48.2334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWRfUTI/vKWiTw9PoEW5zEULHri6D2K+mET54BwfJZI5/YJ/v1zVE/ozy9I+TGUaMswyGXLnExAv21w2I3NtOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591

--klyze6w3qjzq3jpe
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/6] drm/sysfb: simpledrm: Improve framebuffer-size
 validation
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 03:19:35PM +0200, Thomas Zimmermann wrote:
> Validate the framebuffer size from the firmware against the
> limitations of struct drm_display_mode. The type only stores sizes
> in 16-bit fields. Fail probing on errors.
>=20
> v2:
> - remove unused function simplefb_get_validated_int0() (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
> Cc: <stable@vger.kernel.org> # v5.14+
> ---
>  drivers/gpu/drm/sysfb/simpledrm.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--klyze6w3qjzq3jpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmo5VogACgkQ3SOs138+
s6G/sQ/+N38eGuw+5JSBEXVb4A3CpPETUlrxKb0u6gEr/qlqErLWK3e8+ud9UJwG
LIB3PeR46kIJv3I4nNwuWLOTiVvAZZunxrfuGn2CK7vcdpQJ3QMKTm5oh0QYL3Bm
K+FDeVFJycUaoPKnWAfV2u9LVZUzW8YkoVDJqUjLZk9oSUs8Iy1AZsVMdJLEXj0q
b/Vrwi/LEERGxEsRwUIO+OwDS8s5OookpfQN7lRhQ/z20UvWl122VnziT12OukdM
kPSnHQhMGCcrpm+ZCEHs2112UkWs6jvhLeO4rXMKYvEjhKwgPuqPZDMGC4cbp7x6
dJYXL1BD+jQbwZNSTqkl0N0+bLqwqA+dq+OECpvXcc7/us0LikNhr0vxw3H50vBk
/kR4HWD8OeLSUcud8eXVbdzbW+8OFrXWJN28VvESvK4Fqb1KXNLlZYTQXjyb1lzB
Xbkc56gomTouvHkC85Z63qEw4yIwpFBuKhdjf1YB/VWe2Rz//E7CTn+YZB6TgwEk
25PfK1gq/VaxKKKyOYuGc8p+RKnLR2XEytEJwMeCi9EzvMSdFkllg68VYYylXttf
h5GW0srZphloK2NtFoTBbtoZ1XkuW6pk7i784sLZ/24sPuDpsRA3vipT3PdAj/Ha
owo4hB1ddW93shBEuKq+TXJhTzRIpEGA8gAN4Ahrd13omlCecsY=
=a2Vb
-----END PGP SIGNATURE-----

--klyze6w3qjzq3jpe--
