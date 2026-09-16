Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A1E4FDE65;
	Wed, 16 Sep 2026 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568939; cv=fail; b=MEFGB2y49hRHbQfPsMSRwG9B266MZL2UubP8YY1kA85Uxl//TbQwipXJfvXC8wMuRW2stXpYRAYP1zvnzFiwXbfnCC5e5CjZ1Fpk4ChxxUBfyiEk/5vvT8b1+PtrMahISdjdQ3W8iEm0Oz+h3p9UU8Nuw+ouOW1z7zZEkInYKxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568939; c=relaxed/simple;
	bh=rAVVQHIZ5N4HYyPqBtvmvYkZv254UPKThdKhHtRL9yk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FZ/rNHcdVEnHG/RKyR+b1FGKL0OiEku7fD/jAFbagmrscIBwrtt6gMRNdoRoYEWfNQEqY8b36gfzG/M77MwNSZfE6mSKORw/CpTRHIhIq7cI6oCvvcVnJMwe86IPtC/8aPSfJ3nvw2uOMr5jqLZQsqifwyBL7ovq2Mdxq5LEjiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aFjfcG53; arc=fail smtp.client-ip=52.101.193.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aFjfcG53"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RO+NU4xdOkN2R+w+ApsvH3XRP6/+fpNJ3J4nEuSrr4UlVFLMwzV4LnqOka2Gla6wzZys2f/6JsalwDJ1g4wh/yfZriNVaueK1z/B2+OHRkcSsyd56trclbKbwfhWYkC26Qs25/T+5Y0qTFbeSNEoPBFyfSCjhKX4bS6Q01Zor1PBf6Dw9eIEOX01lOIb2MBuhKlvibwH8CkoAnsoAObta4gaZKzTcrAlOQ+uppZWd6XcUbjKfVpj/uS1i7vHNMbVhoKXlq4tsdfwuVeM5ygULMRYMjUByVxQoWUYVSjp7qxiiREOxlSUwsCAlUF6rg6Y0ZoXwdiaUZKiSdRmLtPRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdZGJbVXpOvrn67pCseFNL9dnQuuPcxgdAorWrYNLqw=;
 b=SuW14nrXLC6Nh+5DWzhWDujMjrp3xYkBC5qbT+cgY/nN47O4ED0j0hAvoySJWf8qfDO8TAFeTJbk91zZOP/21KLIkX3cmtmc2kpCkdID7DdCy8zymxzmZDEyt4D95IQDzU+HmlcGuZpx67mj7JNL4iLxDheDj4YCTMaXU3yFhD/KxETGRHvZRF1gmpEoGhFMSOu2igKj85uuotUbbjW2rKILh1RTE4g4pPW8LPHB44oeq93TCtdHQOiMMSOW3aKPXhUywNTGZLrsq2BejhPnMDJtvrEDmhHneo6dl5RhoFNz+D0LgPoSO7iAv6wxi0c7sRjSTRUgwO3Bq7rKgRfcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdZGJbVXpOvrn67pCseFNL9dnQuuPcxgdAorWrYNLqw=;
 b=aFjfcG53AvvYES3fqg1R9Zz6L+Hlu2rbVsVPu5w9SELa1LeEafrRwbfF+2GVsFBNKUL0AMdAp2GSawqVCbrTjEj5+gBzJO4q5J+Tumi+pPQEbl8xUDW2UK6iqgMQFS49SGS3rrrUL9YxpEfK2SuCFJ7iqOWPTdPLuvHK2SGDyag=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 14:28:54 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 14:28:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "airlied@gmail.com" <airlied@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: Fix acpi device leak in
 amdgpu_acpi_enumerate_xcc()
Thread-Topic: [PATCH] drm/amdgpu: Fix acpi device leak in
 amdgpu_acpi_enumerate_xcc()
Thread-Index: AQHdRcF0t0KdYAIolEGOrThUxJPDh7bRQ9PA
Date: Wed, 16 Sep 2026 14:28:54 +0000
Message-ID:
 <BN9PR12MB5146BE26416B0C4A537B91CAF7B92@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260916095432.2009976-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916095432.2009976-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-16T14:28:52.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SA1PR12MB8118:EE_
x-ms-office365-filtering-correlation-id: 53a102c8-fe35-46b9-47b6-08df13fed62b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|3023799007|56012099006|18002099003|11063799006|22082099003|10067099003;
x-microsoft-antispam-message-info:
 jDDGYP+AEe/UnX5zr+ZcrbG1e3QeBUySuuLVD5rYoMKj0JV7YOT4efwz76tfrr9HC7hHMMV6O1+6DyvaBM5XQNXq3TexyzKrxQS2fdI+3dCx97IjOkRRaVtP9/F72gmMWeZnN5kVu7heqYLUeqOvbLo69wXWGR6+eEzrD1SR1X+1WJkSlF+pMdhEnFmkJ4tuYWzRyg9EYxQTpseycBQcksRUQK97hGHdE1FRopgSn4DdzKpsZ6EWo4Sy/hNzpbwscOQV7N5wAbDp4rr0ggWoP7P//c8ANHKrc3sNKY32fgmv6zdl60U4vVJOoERaO8MkjS+OcNfG7IG8MFk05Q9y0xCKV1i55U3DkZQ+1JdyUCchHxPqlsCwDktRYQSAACPi3oSE0m8lfQLvxn5/Zn+YVg2Brq+vAcZllszcib1Rx0pQrz2Nb5zuKWyAKso67qng4Xx2MVClUcHqlwooQaKyXNoTIL9DlZMSS0WcbQrqOaRfwJ6o4I978F1LEyeXTgKWF77c9P6Egqpp3YZatVDo9k+ffnB8IhYWMOYrd8EwJnXGEqUYNTIC38VLwP1HhiPgiiRyqgwW906PhO03Kiu+qbFFSdnSp0D8o/UQZgx8fmCbyDgHd2WnlafiZXfQl2dHuibkEDWxFQ2ZEpuUKmrNEfcfl1eyC8EH5XP+isnBAbKVVTwppHNrsbpsFDI8KNprNH/7pAsZkXgsPnbZGDgUqYvpI7ptDSqdZmYKl/P1+y8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(3023799007)(56012099006)(18002099003)(11063799006)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x2SZiYPKRmfu/iDSlYRxxLhvVygINpAPyNhKo0V6Tl/qsUXsdPtNZ4LaJwWg?=
 =?us-ascii?Q?UWGxXCPbJHkQG8qN7fjhYI3o5K2MvLcV9jANLSNALJ3U6rDKEyOy2Oqnh/+c?=
 =?us-ascii?Q?8YpJOi0BRv70eBBnVLR61aOefLnDHSeLtmKWvghM1+SpQDZZ7BFK9T9fMIzo?=
 =?us-ascii?Q?zMh+AxMJGfXz7YquXPcK0FfPaa6mhKi+IvuE4ENyIskDC5qB4gAUQJaTv3JA?=
 =?us-ascii?Q?P7xcR3E0DVWGMs1RmZ8BhyaaoQ59kqCJaTHsQ3E97ZpwKP6dq2uOS1a2LJnm?=
 =?us-ascii?Q?Sfw+cDVP2bNaVCNPFHl7YFe+FbBO+t5YF4VlGGao0w8gLL0/2uc3xelyWukR?=
 =?us-ascii?Q?K/kNAKMQrFvU4rX2XI6mc3Pi5iOcF2TJE0Wb9aZdgmFIg6zr0TR1NRVd6LEx?=
 =?us-ascii?Q?BMTsiRs9IFQbyv6D1YqcRNA02U24GUS/YUYX7I+9L3qpL/Fuv7O6jaTOGkJa?=
 =?us-ascii?Q?glBflggBgRu++4vj93mFO9NiOusJy5OQbxVNAp9eF9vDJYv8hsLgztP8MFQP?=
 =?us-ascii?Q?LWhnSb4Miz4IV6/rfpCTx/qkdivQhucZZZreA1JMQnYvxyhKkXzO5Ltr95Ew?=
 =?us-ascii?Q?hC02S55FWvN2ZNdb5i6ZAec0yPVQ8kn7rdt0YIoiZrvfACQhtZkEzpbrg4Nc?=
 =?us-ascii?Q?f6Fh0hkjKqb+nekZRkbuU6Kbs6vka8i8uRxmuPsy5qaGlswbVjluCEZD2Z0+?=
 =?us-ascii?Q?U8d6ceeGyDBOM3+p1eO1yCyWh8KcDD0XcYb/wkCpHDQi1648SArrlxof4irt?=
 =?us-ascii?Q?2r6gg9xX+tZZk3e+ghojlt8bGajwGlzlZ1fUuI4ameGbI70qHdqmxSfVBdUy?=
 =?us-ascii?Q?wo2JFDYYqMJkcYO2Vg8GPxcCrdRUJ7J9up3fj7cIKr6kpe1KLjKL7bthp5HY?=
 =?us-ascii?Q?JFmHo9Fa/VNu6LbAIOKbi2qXtNF2Pm+HBWqy3HdwYQci7D05IdcFEnTLLhOQ?=
 =?us-ascii?Q?wF7GwxGUE+kEw4UvB+qwjHD2q8a5ltQix10239inrGHJxj0ZEeRD7smVkVfF?=
 =?us-ascii?Q?+pjmydSe9fsa3qa6Ge9CYgvvVwoNumt0z6m2kKubiowcLcgf+FMGEZ6j/hlT?=
 =?us-ascii?Q?cRiIMNCr4Dl4V9GkKGN9VX0zjOz9bxh4s6mG3p9biqWVciY2QSkZNmcY+HVR?=
 =?us-ascii?Q?X4ZIBPa+PXVD9w73StQs49en4fKoJAP2lIOs4yxz+b9H/j68haf5leLZtdgN?=
 =?us-ascii?Q?do5tjrqTa/TZHNOePifh+vPhZfxg7MHWxOhgHl7FrWMJ192bXrJDXOtCovHo?=
 =?us-ascii?Q?UtUytSzB/oRE+N4vGHj/Hf+pGXjK+KDGnh2Ci732rzFvBkT0610N7kP2ggRr?=
 =?us-ascii?Q?TEzu0xdJ0PVouLrKSoqUQH4Kt3cwd+tZ4thLvFVWoFCmqJnY8NtqfNvQ2pv2?=
 =?us-ascii?Q?pzhqtZ/PeqvFe8QTL/e5+/hvoJErMBWCpvKQgnWmpTLnju2Lo1l11HOssvoy?=
 =?us-ascii?Q?YEqSCpBLQ0ISlivO7h/pqopdKlLETfQV3K551qjH2qFapLe2lAIDMnD1ORFg?=
 =?us-ascii?Q?23Rt1E1UKC3PRqy39wvEzH90+iLwqclt0JzyROjvPm+hnuo4YKW0kuYVuxU2?=
 =?us-ascii?Q?QLhMFjJe9jAageSapZpKQwAToTreuyOM0koHdAiDfmMtMuNRTQIJ/gdNA/7m?=
 =?us-ascii?Q?0A+/t+KO2bG9HJD8Po8sn6QxYQTyOEW1jiUcjeOwwc2YaDr8daduXWWY5wL4?=
 =?us-ascii?Q?mqbUEPyQUpxPlRInj6p20jiAyw80IFSvjI34dJsTTRu0VeB5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a102c8-fe35-46b9-47b6-08df13fed62b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 14:28:54.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3I4ZXYP/S+kxjVHbvHIXoQuiBQ/JG9aLBd49Ss1x22mJBGWb+SXoWLqV+cBaw0CNG02uaDfNV0VPtEha7oHQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118

Public

Applied.  Thanks!

> -----Original Message-----
> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Wednesday, September 16, 2026 5:55 AM
> To: airlied@gmail.com
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>;
> dri-devel@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; linux-
> kernel@vger.kernel.org; simona@ffwll.ch; Wentao Liang <vulab@iscas.ac.cn>=
;
> stable@vger.kernel.org
> Subject: [PATCH] drm/amdgpu: Fix acpi device leak in
> amdgpu_acpi_enumerate_xcc()
>
> amdgpu_acpi_enumerate_xcc() looks up each XCC ACPI device with
> acpi_dev_get_first_match_dev(), which takes a reference to the device.
> The reference is dropped with acpi_dev_put() after the XCC info is initia=
lized,
> but if the kzalloc_obj() allocation of the XCC info fails the function re=
turns -
> ENOMEM without releasing the reference, leaking the last reference to the
> ACPI device.
>
> Drop the ACPI device reference on the allocation failure path before retu=
rning.
>
> Fixes: 4d5275ab0b18 ("drm/amdgpu: Add parsing of acpi xcc objects")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 516ab9cf88fc..8d3f1f5a141e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1167,8 +1167,10 @@ int amdgpu_acpi_enumerate_xcc(void)
>               }
>
>               xcc_info =3D kzalloc_obj(struct amdgpu_acpi_xcc_info);
> -             if (!xcc_info)
> +             if (!xcc_info) {
> +                     acpi_dev_put(acpi_dev);
>                       return -ENOMEM;
> +             }
>
>               INIT_LIST_HEAD(&xcc_info->list);
>               xcc_info->handle =3D acpi_device_handle(acpi_dev);
> --
> 2.34.1

