Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011061.outbound.protection.outlook.com [52.103.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458852931FC;
	Sun, 23 Aug 2026 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787464982; cv=fail; b=SWy2+kGlOrt8sl24qJKew482O5OIB7uOgXDOczm/m68gOrMdIpRlHipvS/z8yaIKaeNRZhtNKQhOr1URv95sXFSlfYdv1KPjNRqPPIk4IWzvaiSfQ/nQ7DvNDClmzDxuhP8q6Fnd9K6OPce/PIpjio2MVX2Xb8pWy5jQct/+XXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787464982; c=relaxed/simple;
	bh=q5KqYUPK2tdgnReA/QEBCLbPZim0MF7lSIRAYOHRDvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=abBSWAaH3Swtlh4xeTELK9uRTcpCD0XKSouMYRQ3XDvYTSJQ0zB+BQyvULZUCaW+b8vi2Wu0bSTWbJX1D2WLyyDmF5ix1iKzLPLCztyqR+8n52TxgecVl1/4UUyGlyIPkIFxTIpAcKAYYxpAwPtSN8wlpqY5yqOF2tpZ0MDI0bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hhNY/fhE; arc=fail smtp.client-ip=52.103.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hhNY/fhE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOMnlIGxV3AWxGQZ8KdYz2GzwzEc2H8KyJJ9fxAVX36Edwcuoy913HhmJ/mXgURVOsIJze3e6x7WXmvc+uTnJQzTWwJTgOTpnuf9MKvC6+HMLh+m896HPVjTGF3YFeZIrf05qVrDbSKaXsiYPvyOOXcEZqPHVQHne3kQa1e/75Jj7ibquBs3q/QAzMpUy/TS/5VT0TbRtNY8azT9HL+/ZmWTxfn254Z0/LzxOL4t+Mu10zIwJqAsqJIVGrRGDUdswyQrRV6IYMqmcSndjLDwvy+NTCyLkJTORws0czYQwSs+CBRUHT5T87uCgYeLO/7TqShrnIFjG6HxYCtGtxzMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3Z8QCq7E53i7N3daN21JovYbarERvP9V5yDdCECa2g=;
 b=sNalv1CmrH05C2OnkmGwBNA9jiXHZ9IRGHqw7VHj5KC2CO/lPLakSJOgK6Hu22pZ2hPD+m7XV5k/pA8J+B4kGGtF7mzw08lLhH7wzyqg8RvQysJu4sdtCs2QM7ILa32CI0c50b9absPhwl51Ckyfw8IddiJxNUKDALJO7ZZM26vuf2wK0TksqZMgFKYEbkwSSJutz4ME/peHj8MmCnfhfheXtP0MhSFJZQrGpXK96yk9ABOfQMA9EmThEQZWfhjh4/FTZ8waFOw0wy54MtXHvCsSINeRjTcLI/IP3ZyQ3lop41BqReU7zawXqhMRX49cH1IUY6DX9L6umlvVYMykOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3Z8QCq7E53i7N3daN21JovYbarERvP9V5yDdCECa2g=;
 b=hhNY/fhElUwGAnGlF4bwpe9TXt0Z0p1Nhkds0Cw/UBdYonMxDHiGCDtlOutr6z3fmxWzom9ni6MdXqhczjQZa3Gisshm2pUivIosQG73J+rfehW+GX/kDk3XNR+gBfO1NrcBdfv1jtGYpXnC3QBb7qptOhgAqGVe/rnbap52EBO5iIqdlrFQNjXU0rEazrm0jmM1LS2fN65iC/EcA0ydFTNiUSMNvD6lW/LfJ3SGqjORukdnjREbBdjp6wGvf1Jvj3c0a9gnsOn2cwlqpC5nDFpVaY8VXt7yNWdDj8j9YqKej+D+NMhnSQf1EksZDuIsxsqwyxH46wDFD2AHohqgTA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY9PR01MB9816.ausprd01.prod.outlook.com (2603:10c6:10:307::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 06:02:54 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%7]) with mapi id 15.21.0339.010; Sun, 23 Aug 2026
 06:02:53 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
CC: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit
 Semwal <sumit.semwal@linaro.org>, Sunil Khatri <sunil.khatri@amd.com>,
	"Jesse.Zhang" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linaro-mm-sig@lists.linaro.org"
	<linaro-mm-sig@lists.linaro.org>, Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/userq: hold the doorbell xa lock during
 hang reset
Thread-Topic: [PATCH 2/2] drm/amdgpu/userq: hold the doorbell xa lock during
 hang reset
Thread-Index: AQHdLZnnNFUgxINI1E+0OyQiNx/eE7arLcmA
Date: Sun, 23 Aug 2026 06:02:52 +0000
Message-ID: <88BAF3AF-0334-41CF-9954-66AD5E0DA823@outlook.com>
References: <20260817-amdgpu-fixes-v1-0-36d5298da646@outlook.com>
 <20260817-amdgpu-fixes-v1-2-36d5298da646@outlook.com>
In-Reply-To: <20260817-amdgpu-fixes-v1-2-36d5298da646@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SY9PR01MB9816:EE_
x-ms-office365-filtering-correlation-id: eb121cf2-928f-4936-11cf-08df00dc2b06
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|15080799012|19110799012|8060799015|8062599012|39105399006|25010399006|4140399003|21061999006|24121999003|22091999003|24021099003|55001999006|22141099003|440099028|3412199025|102099032|41105399003|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?bxpQ05YtDOhcdw8JoFByoS2OznBtVsFtFLYrIYxm/HrPM30v8SVSucfNn4?=
 =?iso-8859-1?Q?AW/3UqmEGMQH2TVw2xnxPNhygseST6r+8Cc3P2OIX9r3AZLzThmEWqlB5b?=
 =?iso-8859-1?Q?2et36ae0JM1RcwdNPrfNAcDDQEVVW22oS7E2D4R+3FqnUu2+GHXgAUPdTH?=
 =?iso-8859-1?Q?qfGxuo5Teqn7TMj986KhX42UnQxgrlhTttWWIubzARPLfyyfiqtWDOArHz?=
 =?iso-8859-1?Q?ochHs3oJBm2ROEY9VuIxC1+RWkQ38b20/DS761QlSvQNxDSGYEAvjCLu+B?=
 =?iso-8859-1?Q?cwEJNQpQh6Fco2H50cGoWkFjKn4rmG27iyAA2X2mxyOGVLyCkjI8FUEu0r?=
 =?iso-8859-1?Q?IvgyvRyWWsT7IC29LLL6op9UFywK52yq7iilHx7vq8WjUJ6kfL2OnrI3W7?=
 =?iso-8859-1?Q?YHN3taSxgXnonRgCa5Ipq4NGldKMuy2W04tYXltg05AX21IzbuEiHrSZyI?=
 =?iso-8859-1?Q?SoF+aV+JsKlfMKzP6/HF4/L3oP+lB+eY+zSd0ERPs4UNrcFFpAYRNI5Ijz?=
 =?iso-8859-1?Q?yyKYgFzeaGkb2pFVvkFKbQW5rAqNmGkUAizb1hZOtpInEc3pT/6VXsutG5?=
 =?iso-8859-1?Q?kebo+A6nktAXIBdwVjeXN0cm47G5MCfGQFUIWZ294hOgPg7UNnyZBwxuEa?=
 =?iso-8859-1?Q?aD/gCgu6KkbtrfeT/aen9a63WLGm9zH/c0wwyXhsaPqYNNVeq9olMbeswb?=
 =?iso-8859-1?Q?HOx7R+OOPkBd+IVDMg59QsVhpqmZFRmjRoXF8/Ouovb63RStPnvxO32CpA?=
 =?iso-8859-1?Q?Sx6r1tNXTBKJRa1b0GqJqAuf0Upz8eYFEHcsIIbuEZcH4XrOtLElv/EYy2?=
 =?iso-8859-1?Q?CHM9ziYKd3zAfwR6TREumcp02CZJ+y7IJVZMOiZvAR4SjZvM9Uz7NM2Zgy?=
 =?iso-8859-1?Q?MWJc3Zdb2oQSl6GrkAM4i7O5Gei5ahFEfuiwYpwgnk2BeMciA1AxbKzdJv?=
 =?iso-8859-1?Q?v/OD8CjdyTymQ9ATbwCzggLCcLZQSsfLiyJYDOnKMLZbeAo90HPqu8Iwkg?=
 =?iso-8859-1?Q?u3ePP7b4ij8tu2phVPxSnKiwt70k0oImAeQugTrXveXS1bh+D3YoZaj0VC?=
 =?iso-8859-1?Q?DDJ+mDjCegAy5ygH8DzN5JhRTYE9GHYCVe4EhrAlUAO9lYaOFuJ601Ta+M?=
 =?iso-8859-1?Q?2z0LJrZbadtwJBgSOrxPnFs1oM601k8Xemy9ynzzuH/zeUp3gk?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?scXToJndnCu1lSEhcVB/99d6EzokimnMffX503ny2AK4fYqGMOAm55QG6w?=
 =?iso-8859-1?Q?XinRpoVelsiAufgIQ1gLS2u1dUZTn3M8IHnmNZTaQTlNzAh8YPTXjkiYQa?=
 =?iso-8859-1?Q?l+aPtCuqnEa5B7M7w+usPiWVvz6wjHqjEcDEWoiYBsloT9ALHbgfiu66EU?=
 =?iso-8859-1?Q?RlsvCeOvD5EaMkIXVDoKQ5VqaAOydfBEcaeEfASaTtu4fvaHKLIUtl6Nq3?=
 =?iso-8859-1?Q?lesFYuyHcwyizxGN0/uUR/GXgIJHYffis3l/3uENbuNUqqcFe0TVxtuOdY?=
 =?iso-8859-1?Q?lhEsSd1Knl0VkyuvOsgqONDWdmJVA58xEb6HvdKbtxMOH0Iyp+D/G9kvyY?=
 =?iso-8859-1?Q?1s8MaCqLH08lB2HP9Zjhx1yTI7tv9GSrx84cN2ZvE3TGmOrmUBZkJuKmiP?=
 =?iso-8859-1?Q?0PBXzcz1+XLA4dhk7tTOj1d9RtLNlNlqbcMldgW/zlL2MjEMCOTt66hF38?=
 =?iso-8859-1?Q?BHDINgTDrY/d9wiyjtzioRV/Y8VPlUi4zGqQNVJKrpnBNv+YuInp6uSYEg?=
 =?iso-8859-1?Q?D8WpbGaYCvNLZRw2Gsh3A3yagIKUflH5Yzsl8SPd216dd4wA3rwznjEgc+?=
 =?iso-8859-1?Q?BMixJUMUH+FU93/9wDt/hX/3jSqqy+nCcEdYfKyOJEZSAn0we7VYCvhKSB?=
 =?iso-8859-1?Q?t/pIuccmDAEZiwtRK9Kv5OBiMfcF3Yu0w5YX+oFiOJtsLwWZ1eSzRQUWyJ?=
 =?iso-8859-1?Q?Yr//OWZYQyp0sKlqzzxNTyZwppVaY8ZjdhO2Po/+xaj2JrhIOZrs30rkAw?=
 =?iso-8859-1?Q?x5QH6s1NFymNK9R4t7/IlC1bgSLbV4Qyu4H48aF1RIqrT88vHz5vGrXbOk?=
 =?iso-8859-1?Q?KMmSoX6cuYCyO7hzcaKNsvPC8+UVV5GptNdxkulfaH0N71CM8SVjJO6FQi?=
 =?iso-8859-1?Q?+DECIIzZ4GHuzkz5OUr0xvL051PvGb81qhwi6wWQcFI6UFcHg4ZwZBI/Xj?=
 =?iso-8859-1?Q?Xx5hgbA2fg3bK/my0YJ1szXmXVgr0Q/txrgia2/6Nib8SxvUrPWZqZ2gll?=
 =?iso-8859-1?Q?97FT5yFZuZEDIOIBFT3/wu7OReW2FsqZYvJo8aFpVsiUrVFccjjWuSaOQx?=
 =?iso-8859-1?Q?I+3BtNVhTUxODqioC60woVqUKqTKBD++ZzoT8+gpHNl8uQD1k13IYVjZ/8?=
 =?iso-8859-1?Q?QoHMi7zECgq008sBxI93Egtfu/l4LaOuy5A0ZDN4qRTWD0YxatA4oOiRa7?=
 =?iso-8859-1?Q?H1JTmf3K8OBlg/A59t5xD4XxF7dzRftwENv2D4LOd5pEl98/3L+uDZnO1Q?=
 =?iso-8859-1?Q?nLJbAzBHEN3+cuc72bKAZl/DZuD4CXpVLflmRy8XMio49gpFq/OEv+tiL8?=
 =?iso-8859-1?Q?xF7PK6GKmz+Y9ccfgEgvc5aKyN3k73BH74cepZG5w6txG+6aYNXMP+B/BL?=
 =?iso-8859-1?Q?OrFAt/BuG6km8xumKD29Jwf3ensKQmjo6G1+aUaLu3C21yvKaBtiXkPkaH?=
 =?iso-8859-1?Q?5q7lb37MaP3KneRJ2hufbgOeAlQIK3LZV7/V8w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E1C349F27181214AAA52CD3D435C7275@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb121cf2-928f-4936-11cf-08df00dc2b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2026 06:02:52.4234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9PR01MB9816

Hi Christian, Alex,

Sorry for the ping.  No need to look at the patch itself.

I would just be grateful for a quick word on whether the issue it describes
is a real one.  If not, I will drop it; if it is, should I send a v2?

Thanks for your time,
Junrui Luo
