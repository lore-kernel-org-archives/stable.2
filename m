Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159363CB2D4
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144629; cv=fail; b=feGFn1HwAll46CA+1abv1JgakTCJQ4zfIH081FNz3eDbYGTh+n6Kz0r0kY+t+m2lqVoD0MM8AtY0A/Hw13/+1rCnd+tmZq53bU3OcmlAUXNJAD80v3qCO/7Mr+BS2oQfKcHz33Cy3tzcbqR0s1QM5sIFj6g1BH86RP2ypgbKybw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144629; c=relaxed/simple;
	bh=jfPCj8eIsury3P+CX9frpdSerWPReEWUodA6T2+2yIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JBPZQ8HQe4k8weymJcmOt2M8/HKcCysIxGQJ7CCWYEv+VHe9kIUg291jL0nOWhy2/Z046PBW8mWE7bgHCApfVCoc6vFvqRl0ZSU59OSOi0ClPxUw3T2Idn0llt4xAjDKmWdrFs2d1OBKsLfTJ83c+AOfagNNxX9V44oXUUy9ijA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oUW6IGui; arc=fail smtp.client-ip=52.101.57.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUW6IGui"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMmRlvvUgssmCIZ+NiCf1e2yzw/dsUNZdte0cV+MW1bhmgBsgsihze0Ga2wuKO6cpvnR/0X2yZqvmU/xsJOYsVhYvc0fWd2TMlotp7R3s8TJ0DHyyUnWT099HQLrREf4o3YnNYPtt1Ii2oTvStFW0B1juAzmV7scF8Jr+cI7J3/WrsasDCJzY3hWutUHrXr1xhz+Y8RBs1SqMfmTxScomhlqm6mhdXTvUqLzn3+f35sejq0qFjf6I3qsA6A2YE48DH+2behLdy+UeznP8jec4ohuRdZbKzMYbaKN4YOtrR7ecyzF6otjDZuET53G+prxLiQheAFaPOSTPXVcuj4mQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTTxtljqVi7oB80SgRuG/ZSd8P2f4Wxk5EAQcLq7vbc=;
 b=TIMM+N/udkIcWH7wrL0IZn5ODRjqdPQE30dmvtf4Sxu6slJk2C3RCzkYVfpGpYTVvbtHLeO+Sjpz9sekHvaUblXbH1eMQZ0KRL2bGc+3edU1LLKCqLfN0Ak1mHfN6JbFtE61XjiO6clwdyJOoDjepoZQeUqS38ys3iqV0bFjz9WPHej7uwAoHimMrkCXRQkfIcrpnaR0zm08nfC04mjbO7M11qWxN3zC41YgLLlkoIZEngWBk7T9OVr7e6HMC7mkDSd2UFoq/xefTxuJ8sI7VgN4H1fcpCNrYh/PyMmiTI7eoW63XO6bJ/Ff8lhWMj6mdAvb+2yJhji0hackrGOBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTTxtljqVi7oB80SgRuG/ZSd8P2f4Wxk5EAQcLq7vbc=;
 b=oUW6IGuiHOCnWm4NPf/n7aDqX9cf4fuWorrCj3BRqZtnm1sIqHEqSyH47F4uOUmA/B1Gaov6mTmTEcH2dyJ/KUArY45gHBimc5SRVprzI6as7DF5foENE9T8BoqwsVNKeG090UVCiXlHKbaXYVhTo0CSv7hFQ4vokKmWxYLYjkYi54v98vasTxMzh6dXz9R0KQRcXbBwOt2OveCnMdKPsE4fLSxMVVeYlGLXKs6A4/LLXO10QClEIOhLWMedf2fDVQd2rc3wyPoEryS8XMgDXdHt/fATKlblo9MiFRgaugEZVqnjinkdiPf2bjDgslBjaqZFXy7Sb5c7jFriJ4xDlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 16:10:22 +0000
Received: from CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315]) by CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 16:10:22 +0000
Date: Mon, 22 Jun 2026 18:10:17 +0200
From: Thierry Reding <treding@nvidia.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh, 
	dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/6] drm/sysfb: simpledrm: Improve stride validation
Message-ID: <ajld8iWQ9iLwBen8@orome>
X-NVConfidentiality: public
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-5-tzimmermann@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5k67bgowkeraeisy"
Content-Disposition: inline
In-Reply-To: <20260622132433.722823-5-tzimmermann@suse.de>
X-ClientProxiedBy: BE1P281CA0395.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::15) To CH0PR12MB8488.namprd12.prod.outlook.com
 (2603:10b6:610:18d::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8488:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: fdea43bf-9df3-48d1-85d6-08ded078c32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|7416014|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	C5ERk4/WTe1+Hgzpj+ZH8vfANOv5i6seGmalt2yL3b188SmfnaGfNwQ17XbHO33xTSHTcwHNhkUcKGLl01Q6pP/DPLL0oqYEqDStVi2prw+U6t09zhETgLSmHizRKctru9V45XoPYbZxmOgCEfAzfTWEfmW/la6fWeBw8+a/fuaCQMWLxCB7QL4w4SKBPuQHIadPrUaHmDsZ7fGW32cNzhmtJ1wIm/1GgwId+Pbzp5ludj0YiCqlIv5uoyqHoaWsz++f+EqlcADDvm6KkfejezaKmsQVwhadQ++5AvUgNWtM0cWJPB4fa50TXNIbkQYYOUVh9q+i4Np6D29TPyQPNUSSOJ0NUVQbXUMzgEUiaH67i9P3wMd5j/kckgf8ZrII2AdahTshAc0pNNeUJyri/cfcuP3L5Ik81U2V9m+aYD9yI9k/2I4IgYhkXapilo5meiBn67YHgUmvn0Z1hjT1WvrFXlJSG7m6a/zrNiwaDjF3+p+HANdfe0drsaowmjNQKFkRHk1xgl2WEi2i7HdVZR4Houii70hp5QjKxtrornTH5EdBX1QXNrP99anws2Uu+unDbmokAFk5/w8oLL9rWoVOYuIgM4W4M8TuDOSZzo6mcNRKYyJCul87ZjSLPS11EEVDI/bpDEKzHF0d8lL8OzTABR2SQvv0FCXDhY19QlA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TAppDvLoXhIoTfTnLQbSSi2dOYYxRC0FZOWTqCM+LY461gtwQu8t8jrIuavI?=
 =?us-ascii?Q?Y/EPxusw+wk8BGro/yuJ8LJksWra9UzbXsT4+26h1BkYPTBnRa/qGjDk7xBP?=
 =?us-ascii?Q?kE8OJ5YZCahmboLQGVPvQKTPAh9Fzi6PIp+7AsHFqpbLyeS1mxZvuPUgj7I7?=
 =?us-ascii?Q?D/CmEYUL/9XmXQRuG7RGzXMw96cSUTDgOtP+vwgpN0DFlMFQ5GpCIaBbaLtC?=
 =?us-ascii?Q?/vm9ie+6CheY/stlM29JlC1Dp4NO5gIdTflJC/Ezjw9Wcac2v/T1zlvuzuRu?=
 =?us-ascii?Q?hmr2gXG9VnLPL2ppaG06QGjXgib4IUs7yZavTsGxa45m7E9CR7/XnyLOB5Uk?=
 =?us-ascii?Q?lvfQS9MlwrJjnZiP9C/5RQA7627thLt44sVIFLdquyPAuCYhwv4p5cmxetmI?=
 =?us-ascii?Q?hIZn7t8lC3zjT2qfJz1z56yXfEuoAVa5QLzD8V1MFzu78sXU37ky+vPFH5AY?=
 =?us-ascii?Q?Ux8pVjcpbfrVEJ+SEvV2hEljnYqx7cPYdDGmspAJLBwiCae/GPAFfv6r4mLq?=
 =?us-ascii?Q?EfZUYR/nrigCB4tyawQX05pNl970BP0ZxpCPBCIX6h5iUBjl/WUZWt/c1uKC?=
 =?us-ascii?Q?gzrHRWQ3UXzN+pjIBH5gmZ5AQIaEzEBb8zEIB9h3cuRAKNzAxbSWK/vzqxUu?=
 =?us-ascii?Q?2SWliHurkd8IvfKIC2okfZ045G1gqZ22TmXwV9DHJ5b8+fI1Jt52EEwpDIGU?=
 =?us-ascii?Q?s21ZBcnBD/s//QjdjOijjzFizG5h2SSXLULwfznDZs9a02AbYwqqJPE8FQiO?=
 =?us-ascii?Q?mgTjmvSNxunBKesKMMNMsgYx6PuY96EWbEd3t1cNlrmgPQpZ+QKdZyjAe0QG?=
 =?us-ascii?Q?uShv7dQk/iWsL04bNQV2wbr0vO7TaqOYPyfyV7nlKpPtO0x5mQ5vNiuAvb/h?=
 =?us-ascii?Q?4f5uWHZB9YX/Ywvbqa2UF7os1k9y1lgbjGIV/sefhgN+hNxu+/h0jvQY39aH?=
 =?us-ascii?Q?iTFuVsNI7pCdU+WxAUBcaDFQG8OltEGiAXJkvFqXDILE2Qr2JqxU25JZgWGi?=
 =?us-ascii?Q?K98TJ5kuwRipRjx9NnjdXHxuTTyEoLtMb+1NFztAfSmrPpUXM6rKNcftcAV5?=
 =?us-ascii?Q?wJTgNkjI+cO5a+mimLCZQIkop2JqP0QtmyZvc9aSiU6ogfm57ZjzjnhMLTKC?=
 =?us-ascii?Q?80W5Kwm1XTzsc7jxDqqpwXU3cvAMbH4daqOSfhhiebWSEixzzltCns7QPXY5?=
 =?us-ascii?Q?w+12whxX+bT6kuUZUdLJtoVaZz3o4gzkcoSuEHXWswtUPP1W+9u3C9uuaTNL?=
 =?us-ascii?Q?4zMgQVOnSo8KSrvd6oKEliUY644WIrgNkA52W14R0etRujdaG9B4fmFkHdME?=
 =?us-ascii?Q?TNoXHDQT1hHW42z4p0SGCTGx6NYF10UYhP4SQSF86Lz/j8EZN/FIgTOi0+Ya?=
 =?us-ascii?Q?Cv/U7owMf14vIpL2Wj4QFETCj14YvT9yVKJokiDuBrIY0KSUbBUMJQ2pTL0C?=
 =?us-ascii?Q?8qcmvKdtY/cAWvutRMUStmhByZ7y7Eb+W0hCLRoMZx5uSxngvfTJjumvuiT3?=
 =?us-ascii?Q?ywO7R5vWHMbBxJ+0iOsobB78NwtDz3E8jTz7FOUvQnlzZwlFgW1dBohZffn/?=
 =?us-ascii?Q?giEj55avwdGOPV8sfM9iwZVPKGIklvZMqqAF4V6YwuiB9Z6jXENRoa2jIO7x?=
 =?us-ascii?Q?xaAIPM9Eu+ULREj4N5gffwoXI3sVeDFyCttZMLGvkz9Dytjku5vUDzuIg3ux?=
 =?us-ascii?Q?IcK9INKBC0xI0pJ9RZqwuei3nIwFmvMyonYE26L6tju1+phqNi60maXiH9/U?=
 =?us-ascii?Q?r477u6vBFHMvTVlAzKJFB52F8BmKsgsyjmZyX90PR4aGZgrKNnDqS9soyTs0?=
X-MS-Exchange-AntiSpam-MessageData-1: 5Or9g6V3/9i+Jw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdea43bf-9df3-48d1-85d6-08ded078c32d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 16:10:22.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8JwNf6qMA3KK4RvdXPNt10E74xr6UeXqcop9mVgi/dCQoOM0ZzmgaJ7CUoYCq2OUi67NQz36fPgv4GSPOYTKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

--5k67bgowkeraeisy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/6] drm/sysfb: simpledrm: Improve stride validation
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 03:19:38PM +0200, Thomas Zimmermann wrote:
> Validate the computed stride against the maximum value INT_MAX.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 7bfa5c7b28d6 ("drm/simpledrm: Compute linestride with drm_format_i=
nfo_min_pitch()")
> Cc: <stable@vger.kernel.org> # v6.1+
> ---
>  drivers/gpu/drm/sysfb/simpledrm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Ugh... I have a hard time imagining that we'd ever exceed INT_MAX here,
but I guess better safe than sorry?

Reviewed-by: Thierry Reding <treding@nvidia.com>

--5k67bgowkeraeisy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmo5XmkACgkQ3SOs138+
s6Gs/RAArHMJRiJ+b7/io1WDzPa1O5d4F1yNMDiqd3pTZi4qIw4ae4xp9AoVhmsc
t0MsiTVolZKHV7Z/AsKEPBALWonz0jSdRWgkls2tXYt2JFOgSVvNGYZPU4ke4ehS
BgYx1gjyXmlPc+lkXOJ1u6+CG/9+6DLCC9TH3BuWbIgFnwCVes0YhfyqXEINDz26
TpXoG9LK4w0aQk2YrpWh6QBuKWZPiQK4Edol+IJxWkRfggE4aOo/Oxjjxbg0IWqr
/9DoitahazMYitHOOp4c0oZjmOutXZhZ5BJEMkFk+lXmvLa3rMeF6TmxgRjnffqC
9NxIRQPLMDZv6IgbCezadcy85r+AuFiXItMoPW3PfNOxrKofzZrv78iCFPqUeAvh
wwjkan0FyZEGTufIRn2Oy4mEdzquKrJbX9YnIf2HWtG7E/8T8OuecX9S9SXJvv73
PrLmX+fshh0RMHcj/QCCQRd0XTyXss1F7LYTCKkrj0Nr7HgZlCoJ1uAKCCVDdeza
63WWbtrLvc2uNrdupoMeFLIEgcImyqrpMlqcPf1ps3YecG1kgNkm/3OXNOJ71t5U
ce3zQhfpjX0oU4dnOCEuySqW0Gg74RVclsVJx9pxgGORfagLRo0vZK07r6mU7UTE
8xpth4KH4Y9CqRc6B2Aknue6herhn9yNKg0BRLEX6ieWyn5IKDQ=
=//ms
-----END PGP SIGNATURE-----

--5k67bgowkeraeisy--
