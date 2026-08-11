Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010012.outbound.protection.outlook.com [52.103.73.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FB0212550;
	Tue, 11 Aug 2026 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786420823; cv=fail; b=cDPum4E88YGBNLnxbZi5Clrf5eV6Axjnc3OLLY+VGHMt6W0wDtqkfmUHFnoW7nmBSq8NT/ttLphytrYyuo6iahOmwvnwZ61oJbVNrqrjn+hwnf+eMxGaWiFrgvj6JF+efnaU4CvUglfb1ehjC34Iq2uZK5C45UdCihlDXCaF9s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786420823; c=relaxed/simple;
	bh=iDQ3SK2oQQMMvmrq/edYLMz2mlZ9+YWLoBRXNHknz2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uJs4aCjYemfSTL1vT1vS8g2HnXqUR/cjx9DrkTJ1j7TJvInaYciZZX1cjPRLbYBqacOkO+THeFKtlrkO5GPTlHdX/NhN15zEVU2QE2OsSZH41zfh+jtgq+2G9PtJRVk6bQhyDMIJtml9AFn15bPBZkCrn5AKK/DwQdkQdvAgTY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AGlUA8+7; arc=fail smtp.client-ip=52.103.73.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AGlUA8+7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MISYZvw3rLha7GAr4SkWvtlfaZJu9L64xbUWD0LkibXBTv8um0maYQd2irIAquBGR5ikGNnFgGwnWkXSI8/xCdRay6pj7F9BIjOb7Db/esAJqSRWNBpUnDT/YfWf1U5f7VkXfNK057ny8JBSMlsP/qCXMd3bT5ck0jpRxxKYNWMfGic/HYZgZIZ+hCV0h7rKPW1Ds4GbLDQa0/GxW3gObiiY2HPlcxm1DRtrUFciHpygTh140jeU6xWqeV6ue7hOTw6n3/5DleZawnCnNWFMU7Qg/cRVLE1lryzpM+/t/T8PrYdJXR6TZWWFLZ7W3w+AuedAbbMIMIPnNceCgUzd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDQ3SK2oQQMMvmrq/edYLMz2mlZ9+YWLoBRXNHknz2E=;
 b=wxbejDzmmpWvUk35aFstn8eeNEUrlIVkmw+zv69f3qlx2i52WOOP5xeZR/gZURwCZKogXKkjwsXlMNofAQxgchxIUrArOIcM3obD632YCNsnBGaBaVbcCuNJk33WXhNcyHoaOXhDl0DOdxYVziaxp9iBNyAVgkmkG8Bu7XfWUCPFRXc8TyvtQ828gHlLB2GQt2I6x+Dvi5yGqQMzzKvD5h7o1dYJ9UlZoUk8eORdRAuB9sJ3B8+nzxLspRHdeEMewAdwe5woErosZWjfKRvEzCutj2HyLoctxOKfk/LpbMtyO5/1hwnIwEV1Zfq6N0EOaFx41ssd9p+kUtlMCGIwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDQ3SK2oQQMMvmrq/edYLMz2mlZ9+YWLoBRXNHknz2E=;
 b=AGlUA8+7F5IxVZnu1QRXVml7Z7UJNuB7QJ1hFh15XZV8+RtFuOnKjJJ13vGs5OgCRvVbLVJ7ewyJEVxZAomDlAf2jQcQZ/u9ijirynUM/SdYLYirLqGsLHtIk8yF9b7NIZvT9qWAXzj7XWHvueCcgQ2jOwPMFNkCgNLlDOVAVe0YlfmZo+GJQPNclVdfXfctFfjLK8cYdyX/vEuNIyaDjuiHNvQzt9XFNsHArjYLVnDyoyEl6gcm1d1OdqHJvDJfLASjxXhtA1sqlZ/nbe0rulLgv1S9UT85t1iAZ+iRz4ZIB6Al2aMJskXo+vH4zSh3WNnR7KPzbYuUHaCLfCRQXA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by MEYPR01MB6583.ausprd01.prod.outlook.com (2603:10c6:220:12a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 04:00:16 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 04:00:16 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: David Airlie <airlied@redhat.com>
CC: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuhao Jiang
	<danisjiang@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/nouveau: bound sync and op counts in EXEC and
 VM_BIND
Thread-Topic: [PATCH 1/2] drm/nouveau: bound sync and op counts in EXEC and
 VM_BIND
Thread-Index: AQHdKFCL60Me3odJBEStS5HWPvuGibaYOyEA
Date: Tue, 11 Aug 2026 04:00:15 +0000
Message-ID: <55965C34-9026-4EE7-B2F0-1D5D9807D682@outlook.com>
References: <20260808-nouveau-fixes-v1-0-c3ebdc17a89c@outlook.com>
 <20260808-nouveau-fixes-v1-1-c3ebdc17a89c@outlook.com>
 <CAMwc25qozGSRw8KKNzVhakH1jCNWsFS_z=mFn9hswxjdNNX0GA@mail.gmail.com>
In-Reply-To:
 <CAMwc25qozGSRw8KKNzVhakH1jCNWsFS_z=mFn9hswxjdNNX0GA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|MEYPR01MB6583:EE_
x-ms-office365-filtering-correlation-id: a2c596d3-a65e-44f2-67c8-08def75d0d5c
x-microsoft-antispam:
 BCL:0;ARA:14566002|22091999003|24121999003|15080799012|55001999006|24021099003|4140399003|25010399006|31061999003|8062599012|8060799015|19110799012|56899033|12091999003|440099028|3412199025|102099032|40105399003|52005399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SN7HWyyHZBoqc6hbAiVpCqAK41oEazsiwIH85fIJsYIccCBnX/xlm+KlhHye?=
 =?us-ascii?Q?uwT1vnW2BRJfPnRqLV6P9M1L/65xSUh7gSOjy92a8K3EXB56mPNlz73f79MN?=
 =?us-ascii?Q?5iqAWGWDtwZ4ppQy3Jq7yZjVlkfsu2vaLzdHxnJIjVr13COymwpJjjs3bI9b?=
 =?us-ascii?Q?GW/iuWwJQhBa9aWQJceqhD9JHpN8YQhCWICC23QVxyYid85mPeOZEm9taRJp?=
 =?us-ascii?Q?kVAhstliD7ssbIZTAuNvVAd9EJK7NSTSmJLIK3AYRhwzcj68EwgL3r0o8qi3?=
 =?us-ascii?Q?6uSuf5dsms43oTUIVvs+hnUcvZENvZHOLP+XcnbypR8qO2dQV8M6UdJxxXw5?=
 =?us-ascii?Q?5oqX0/5co7NsrANHZ/kMzK2HmkIlViMmDm9j/uJwMX1Ojzpib3+s98qWWvAZ?=
 =?us-ascii?Q?Na5wht5lstcNSD6XxyKIi1Q3v1jEm0mECoBacj450/dr1AEf0l4e30qdPRbd?=
 =?us-ascii?Q?dix15szIWewiE44Z78jMHJbtJwZTs9u8UeAbrMjrHQYTUihJUmmn1zOqldOi?=
 =?us-ascii?Q?FLc7CdbsmLLSX6jxCbq2ZJ869rniCgLqlWfYnPG54cgjfBpFpfCtvjFGMKIw?=
 =?us-ascii?Q?1bmlpBLIshJy0PK9n683KdRolyKMDsupq3eqAJ+TKQzDuOgtpcOH5oZnS+EE?=
 =?us-ascii?Q?clcHzTB0lPHER1FmBIvPy8waSwB7xQ6QgQYKiMtJDf1eTlXIU9op+Zei83YG?=
 =?us-ascii?Q?NsS2WPbbol2mGZNOd3cNwy5iHCnKzDR4OxH0h/8M1YgGmwmHyT6y8fjhoCJZ?=
 =?us-ascii?Q?ZHQjC5ujCbKAW34QLDAekiqY4HBH7AOc6073Fw/7gq2CCjrAMbrUw4Ag32uZ?=
 =?us-ascii?Q?hdI6sY/VjBB14BqrYljlyRQDb6ZVebldmWDeZtG3cqJXmhQMK4BmYuEDtd7l?=
 =?us-ascii?Q?1Vsz+bWNXBe57jGCXU3BVrQBxE6H89dYBcbsc6UxFQLIxyd/Za6hrnXf/ADO?=
 =?us-ascii?Q?xyk0JTjZjWcbWzS98RQT3F4mVIlITxNCKG9R5XSu8NDQTNMi34P1cAF7VkaM?=
 =?us-ascii?Q?rKWR9VPFJNFjcQkT2CYUhNMcXXHV1olEbCS4c/eolXH8KHsd9hV2bEKjgJcw?=
 =?us-ascii?Q?sNlXNn30?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CwRfFkKhs6zhj9mlL2IBzzpkPhixLE+SVhe3OS5EqqzBFVt0HmSni0idFP/N?=
 =?us-ascii?Q?7KnfkfrFCJ2+gk+z1yySMEUO7zLSh+ItfL8J3lv9vE8lMq0xfWl8v7vuOLFk?=
 =?us-ascii?Q?5LCmxuxIfHWmPrzXiBjfU3t+BjY8PdRiWmUfZxV1IJHXu6v+VBBVf8Qn39U3?=
 =?us-ascii?Q?T8OvB1jcLI6KM+AKS6jiFUSLFamEMcE9jQQhUI8Qv2q7kY+5cpmFlSE/7E06?=
 =?us-ascii?Q?jzBZAh3epBfN2rlGp11xTz/97QKUOweb74zV63V5pBpP3h70ZgRogMHqHj10?=
 =?us-ascii?Q?H6Y7PYKMfMRWyCQh+5MuCh2bi+pWIOysIDyfltcgB4u2BnJq180X3GoV6u4T?=
 =?us-ascii?Q?eXpMmajnHn3uJWECFwKx0djVp4N4MbCcd3diUkqvRF/SWCh/8d+jCdAj/A+x?=
 =?us-ascii?Q?IicEVQQXw7LTzEmcTPszTbWvz7Xu7rWXv4arqb8IQLZQxckZ63iABg1lAbiW?=
 =?us-ascii?Q?4ZZING81d1sGTMjh8vkp+Zfo7E37V+uO3d2hNA4+FKRh5TL4To+pBv94Onkr?=
 =?us-ascii?Q?qRbL8jd6liOsRZLxUJv6RtrfOo7V4fIdA1bxqe/Cedj24AMX9K/lR0nXLzSB?=
 =?us-ascii?Q?c8C1lOuZSMLTPJEStVHhduxFv3uxWSgWPXfMbWYmBo8UiB2P3m3ol481uRSg?=
 =?us-ascii?Q?BvQPFlyqPncmjR3EH/U2GotTS4PW2og0uo34FMNSIiU2mj5v6+uJh384OA8R?=
 =?us-ascii?Q?hzHoJ4s0KlqbYt7z/cOMv0oYZLuq8HwV3yO4hd2Nf2RA9Kh9ilYDZ8vati0l?=
 =?us-ascii?Q?5yusAM53eZChnG+bcBIJ1pNHqHRfX6E0gjxAFpS+eU6CzNSsURMUpHo3DyfG?=
 =?us-ascii?Q?ul5tUiHs1c6dS7FgYJqF7+CosknGU8pyWMymC+Ii+cTHJSZuPV96O+LpMDsu?=
 =?us-ascii?Q?9/E8hYbbA7YCjOhN2MZ5RbP3wmThvVT9laij4GjO9sG/H3Jv44KSq78d5O9i?=
 =?us-ascii?Q?JvPkcaG/YnTaR8v6t88Kl8/8iY8Ac/G2+VzTkiFyCI8XnCtDeV0TCMrqvjod?=
 =?us-ascii?Q?IXi1cDkMqpc1EEqvbVsiyWzrKfq84KdBUOM0pltN1M4ijVWXHdvZ7sRUEthD?=
 =?us-ascii?Q?gUA4vaSAvY5NQbNqFFsiK/HQmZmXK+f1Js17zxUf4XfM4gUlqEf88LQ7ome7?=
 =?us-ascii?Q?Q5M/wYWTS42b+oTCKqfktplG3DlDy/IC/K5HyJWEaull+CvX/aMXrE1dCGHK?=
 =?us-ascii?Q?/OTThdo/gGICc21jmAPnkOaAsDA7F816Tt9VBQKzZJsuDWDu/wTdWwoGjJ+R?=
 =?us-ascii?Q?SMLQlTXX7fsAKyM/8574KKcYtFVxOtyks1FxrJjd2cSeNduJYPT29srlsOFp?=
 =?us-ascii?Q?wImSOIh7HSdRB9V/1NmaHSD6BjmFvXT8w461qawAwBx0f6RebmhL/fYprDSA?=
 =?us-ascii?Q?bkA4q8i91s//o3jL7AGDqHqdhEtLAnq7b/fD0WpgYTsXQlxErw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9CA76C564FC7D74AB67E4A18184564E0@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c596d3-a65e-44f2-67c8-08def75d0d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 04:00:16.0787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYPR01MB6583

On Mon, Aug 10, 2026 at 08:43:50AM +1000, David Airlie wrote:
> Have you run a complete Vulkan CTS with NVK across this with no regressio=
ns?
>=20
> I'm weary of those limits being too low, but I think the only app that
> might push them beyond CTS would be Forza Horizon 5 or 6.

No, I have not. I don't currently have the hardware to run NVK, so I can't
offer a CTS run or any other regression test for this.

Is there a better guard that avoids a hard limit here, or does this need
a test before it can go in?

Thanks,
Junrui Luo=
