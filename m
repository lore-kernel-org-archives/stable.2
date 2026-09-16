Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEF253ED1E;
	Wed, 16 Sep 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568867; cv=fail; b=S5xV0OdOGlXCNQ7O0wp7TTYYkexEuCrpzqpXkg2CEhkH+MlA9kLUkLhpyub3u/38bEbNwghu0Pv9T6eeHxxMQXtc5MOYrgunNwH3ALqEydmexK/eVxntQXhwIFrdbJDdOGIdcqwSe6iZY2c/nlwyAa8ooZKwJIrxnuk00cOpEgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568867; c=relaxed/simple;
	bh=9pO+HlVB2mtqhyA8NJ7rOob1Es7s4sz8OM7GNqVbrsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r2/JlnQsRsLyjOsz7IYiCCITYefJTK6YPxnL/1gZ1Lnn/8W7d1KjjEk0O1bQ3PsImmTrtTAxsamHh+JVMe9LjUpGrrO9UIehMF4ex5jWEYrkYKh1gyFzM3PfkZiFFFBr4kNpIT7zCvaF1hFghS06cb4VfeJONVHl4z0W+URZCP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5iaQWOuR; arc=fail smtp.client-ip=52.101.85.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5iaQWOuR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTWY3oPRkEHR55LrWJuWVxPlVt8vtetebJVZ3iSpohAKSt33rqwcUQrMGsfyeAWRF1WM3Dqa5BKBuffwpahwhlMwGGH2/QdQ8l6l+FRbBZGt3fnQgXX/aEJ1KMWBE9EnRO4wg0Fa128DIpRuBnnDmbYf23yXMZbtNX8yhMjjv1w4WeB4M2BcwX8a/o51ZpjFxSXGjn7TdkYL+/7EZvlJ1KMrQVAMiS6B1FGc+70RjTonIWJ02FqIECCxBy4WQKzfyOel8hmAd3aQYFT5vv/HTxor449/LUdTdHiKnSm/egjVOKoKU24r+AWsDPYYqQDB83nlVPR8EF+ASVs43Vy8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBGyCdXBKAXsnc0bFofFLB4pn9rxUJ2Ojb100n2g6LA=;
 b=efLrHWWzn0ycYeMNqDtGDIJiJj2s+9kl0oJo59Qi/39A06aBnyRU1JyHIPN6s8z/1KaA+nYmlcbTZWteVBKTlTU56pjKAjaFBRNAiCtDk7Ly3dtWzQNjIkTnxvzOErkBnRo4dgP+CXMETnSRAh08LfZonA5zgCAps7j5hBl0dBzF7485YAVsB2w+47mXO4FYaSq9mjaR9jmVT1FF9Hz2bui/i+urHpSrHzCymxdgWez5re9WwEDWbg1kh4Kl1YSP2ePvqCfBRF3wozWGkCf+yPAvmTiJ47+qzYRNuIXAyRYf+EI5f8Ms0DC35qLRZhoGtFoFCtURkvnrlyrsRIy7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBGyCdXBKAXsnc0bFofFLB4pn9rxUJ2Ojb100n2g6LA=;
 b=5iaQWOuRt7xS4TiBN81zkXXi6FMeZqVP+twdVtQJlmiCjoe22Tt33Iyj8axpmGNlHVir63ceoLeJ02z6NP84ZYddjrXG1L7I8iBeSMF/hzHUHXYG0UPZ36ixgGxSAGeP2iqW1DTQ/CZ/qrZk9ibA1HSCnknJAu3ezPiB86tc3go=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DSWPR12MB999128.namprd12.prod.outlook.com (2603:10b6:8:36c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 14:27:43 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 14:27:41 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "Kuehling, Felix"
	<Felix.Kuehling@amd.com>
CC: "airlied@gmail.com" <airlied@gmail.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, "Yat Sin, David" <David.YatSin@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Bhardwaj,
 Rajneesh" <Rajneesh.Bhardwaj@amd.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdkfd: Fix file reference leak in
 criu_restore_devices()
Thread-Topic: [PATCH] drm/amdkfd: Fix file reference leak in
 criu_restore_devices()
Thread-Index: AQHdRa77LznRnTIkQUam4C+TxhLG6bbRQ5OA
Date: Wed, 16 Sep 2026 14:27:41 +0000
Message-ID:
 <BN9PR12MB514652F3D0735106D10811BBF7B92@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260916074216.1973191-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916074216.1973191-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-16T14:27:24.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DSWPR12MB999128:EE_
x-ms-office365-filtering-correlation-id: 3f3114b8-5e1a-4caf-2e65-08df13feaab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 8yuYrwivv3xdD8QrYJtxrFXYtkMNXin66YGv4csIV69lK3M7piGjhXpY6dydJbE0WJ0c23ExxmB2Vo44uwbiLA6TYpAovB5C/ApFeE2Xy8alkUEQdo2dB/lE/OAifwK6A4EodiIMeGNAtWwTv3ANqXZQnLbwZXN+nUrD7XCawCiiHTq+d0vVo5/hmL+nhlOGwmUhtvSAtZ3mQFGfFWa8wWHPuhq2HAL9wsho6LTfSx2vLKYXpOZ3fSGTk4BbYlOarGTUbpakZIhY9nMHd1GXwjDC2dNrla0nYxvcybKyNuI0qc5q7an4eL9t+KZiLQD8XB38SeLs7P8QUWKuoEMU2oBbIZ0aqixSvidpXqM7u/zGHMdIOHIh3LHtONxoAQ8Nc8e49jcj78SuC4DRorfCZbfrNb9NO+OTBsd11SJkO8oBMwkqm5bKJbHloI4Ib4DvM8zLzmHMSjk/CaFkkt1+KFeGt2n8v+ZKtiq3DxgimIJ4isi6XLEassoLzoPen9Q91KLJeUaUg8V6EWbtUSc7wvtWzZpWRotF5FBMjPSqjnJd2P7EVu+lVyzSW/IWak+GewdQBZN1/oQ/vUGLD6/cYV7gRHJOfhuZb3yHUnLSKWH0ma96EOw+GdMsq81++vl5pWgWPhrTiwUMH22vseMMHa2HZYHytXkwVvEENnadXAU5kRRaGmwHEdXmyVkx6SVayFzNIVyQgRVxMLC9cE6mSbvKZfcImOpE3jpLOq5GR/w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mX7z8DyZMG32obVmv6WhYRg2t1bL6aSSb2E1o43gaFD9vlQ2z211dg/bwfpf?=
 =?us-ascii?Q?wm2+4pnVm6pip3o8tf+hsE8GwC7pRgrtpoVQX524NR61rmKmtLTVWLGNvyJK?=
 =?us-ascii?Q?QypoFs+9d5BaoTotN3b4bDJdoqErDNzbpQcpLNKMcKU2s/7hRNmBkC8MMZgm?=
 =?us-ascii?Q?Zc8y6GEYI28y0pVs6HzlcYa5vSMS2yIyl5VMb6taKU3K+Jcs3iDh1rnWaZvR?=
 =?us-ascii?Q?KnY3mBu3IjtRMFKsSXtHMD1flk7tDjJZZbYIDsI0glihR/2NFX85+jgk0fNS?=
 =?us-ascii?Q?sY+ZxBZiBwS0Ju0fD1dMlnHiXKx2hj83DVgRgASuCBZON5J8N3qkr25AFmGB?=
 =?us-ascii?Q?slWu0OeetcPAZunDYoolGRievUmpc98GtbGckPkds9HWiMjmcnEUGuHpvjoQ?=
 =?us-ascii?Q?1vpgB1/t8t8ha/+vwgigkHgDx28Klr11ytBCq5LhqH9M7GLis31RNn7F/3ZP?=
 =?us-ascii?Q?j4q7lLmRr/6hUwbL4oRDXip6M/1tjVeAywyx2DiegWBmTGDK443GaEOJ9JDK?=
 =?us-ascii?Q?2gSz0roxg1cWNIpAPMItAou3L0EXEchCoBEH/MsRrEyJQw9X0ZlrVtOaN9DS?=
 =?us-ascii?Q?sY9QNnbtaWIGapPo95mN6iJ3GklOpewtiu5vyAfcCAfZRkvkEdDC6qrEb624?=
 =?us-ascii?Q?Su5JTdGCb0Xd8UhkVbEKWZJYYlIGuQM6JoAKCuRpJsFPYLu9VlJuMAFGxOz7?=
 =?us-ascii?Q?YWSPF9+Kf+wxG1QT9voBAmeV1uoRykyt3OE+y5DiR3xYsLLi1e29PKVtLAlt?=
 =?us-ascii?Q?dCokoLlqxqQSPIwfvufrN849DdKrGPfhyg4o6aXzI9ZNLQE8qrCMhbsPYJag?=
 =?us-ascii?Q?QMbWnP3vJKkKOGgTSkBeEI6UkOommCEmWdWz04pTbh8wGmPMyeHQBAYxtG6j?=
 =?us-ascii?Q?dh84+JnvtmOY2Vm41XXsLOAJUaYOry7yCAszF9E/GGDOtPdFc4EX7ZgxMcXE?=
 =?us-ascii?Q?wS2uLhKCsmrL1g9MgNKjM7OsTM5X89eM/yGpPfyGIwDGYFgh0pukgaOV4ZyL?=
 =?us-ascii?Q?/Ea/77vCeT611QTdQP03/RJoiC1Y4uzeL8qGHv107EF+A2RR9SM7dnr7Vhx2?=
 =?us-ascii?Q?9YsyScSp7aiSMnIs12VhEa6AkPiGmagA0vxyWND0KVBhJ9nZlXGizEDgWk43?=
 =?us-ascii?Q?7FA8WFIFixAFALueuFklkK2HsL8mRu7CcIWwScoC9VxB4xnlWgyKRAJe21K1?=
 =?us-ascii?Q?XRBV9uBLV/YUP1Q1YVZ2y+we1hISvYF7fA9LdFZI5iB4XeJnat+EdEua+WSO?=
 =?us-ascii?Q?8vHoBdYIeUFF7nTvtg3BHOJe4upFRtyxfp04RHfGeEurpC2ngle4zYGEeuox?=
 =?us-ascii?Q?iSOEAMZVnNq3KXpyOSmfknoWYoX7cCszpYRo3xlekTQFL2AW6Cx5YdRfYBIP?=
 =?us-ascii?Q?i6LO3Jf9WmPkY0nYq3ttIShXcJxwU6l5jLaucy1hiyoCxAGYCAbifIchdJ0r?=
 =?us-ascii?Q?q321yHKcft6N7DW+LPGIGFGrH11EGiKpYPrj75P2Ub7g8qnyfVB27pFnTC7h?=
 =?us-ascii?Q?Nv7XCUb5vGByJBI++rC5o/zUiImyT7MGGmlHaoWp/8i89GypZPWps9UOtP+J?=
 =?us-ascii?Q?qgU5QppqoV/YXXJ2kqGdZ2eHROS8/MDcFItEC9gBiims1MOj6a+/MRT3j9fu?=
 =?us-ascii?Q?QbIZhhzMb+kBKsin6GLE9tNilbClK5ks/QToTN9rswmGCoyvZHCn3KVrm4gY?=
 =?us-ascii?Q?/aLcBP44N7MSeu9rU1Iur1OI2ntPAQ12P6WGWVnEaKLHLj1P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3114b8-5e1a-4caf-2e65-08df13feaab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 14:27:41.6004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slI4jNGaVeIQYxes2zVYqB65izaZUxNYot9nfbEeAi6fpiHvV9hH4IX84Dupy6cS6tcnLmJWHSXqmtBO1T44Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999128

Public

> -----Original Message-----
> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Wednesday, September 16, 2026 3:42 AM
> To: Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: airlied@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>;
> amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Yat Sin, David <David.YatSin@amd.com>; dri-
> devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; Bhardwaj,
> Rajneesh <Rajneesh.Bhardwaj@amd.com>; simona@ffwll.ch; Wentao Liang
> <vulab@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH] drm/amdkfd: Fix file reference leak in criu_restore_devi=
ces()
>
> In criu_restore_devices(), drm_file is obtained using fget(drm_fd). If
> pdd->drm_file is already set, the function returns -EINVAL without
> releasing the acquired reference via fput(drm_file), leading to a file re=
ference
> count leak.
>
> Fix this by adding fput(drm_file) before returning -EINVAL.
>
> Fixes: bef153b70c6e ("drm/amdkfd: CRIU implement gpu_id remapping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

This was already fixed.

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 03b266b26738..5453fa4ce4fd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2311,6 +2311,7 @@ static int criu_restore_devices(struct kfd_process
> *p,
>               }
>
>               if (pdd->drm_file) {
> +                     fput(drm_file);
>                       ret =3D -EINVAL;
>                       goto exit;
>               }
> --
> 2.34.1

