Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012071.outbound.protection.outlook.com [52.103.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131BB37B407;
	Mon, 24 Aug 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595539; cv=fail; b=GvMmvS8ZPsOGeIHDNWkaZgDiSjpvMYKA/Nmds6wu9yv+WbaGPMr55BSvevEqO2D4gdDDHTcgkv6mimv/qMrIldRRkhw44AOHtcyTVQr8FYKVpz2IdhfZ7HcYRfjrXr1apeZlguu4dEwmjMcabjVhkfOs4Pnd4dQHSzh53Bbrpj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595539; c=relaxed/simple;
	bh=cMsLa9SVh7oLC09TyZTlFW+4hvJuN5ad1dNooxZLZGQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BkJzz5/mLlJY8w8qVnwnasVt7ZTDRxw44cigVkBEVe8iAiPGdplLhqoSwm22W4lI/a1u8AzkgV9x5gwUZ4ZI9n781/8S1nfO3ykaltbgnvhB68A2ad7k4HDCtoQ420371UeTiyeTFGrFQaqRp8CrWg8hnRNWW5LFBc7TCYW5D1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=le3+UM7R; arc=fail smtp.client-ip=52.103.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="le3+UM7R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogtnolwFnQ/rkgrspkOW8KBet9A5POXoDNr0wsiWVkoNZGE0uARWduW9FAoAFw02VGSO2ZlVGQl54IFVxmGfuU+JI4lqLrs+h+dTao/KOVTOUvjOPbzdCw6fjVKQPWPbqgotrNsiV/HsRWo7Eq7cxbqYU1Y6pOKFdI7UWT4rFzWk0vv+8HYI/tFvXFzD2vJvHmYijRNbpgvAh5G9sEA/jDB5/DV0c0hCwc4PqrZ51nyyMzE+zN4EKKxVXSwx4CDwITvp751qb+SraOKWqLmjMSqb1CMnmTd2RxvSVk856sFCx+AXweT7l5wMEYSoZ+I8Wg+FGIPCA9SW+paWe5unbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMsLa9SVh7oLC09TyZTlFW+4hvJuN5ad1dNooxZLZGQ=;
 b=Sdr/HEH2YFSArOh0QxOHmjcvjGNR6R+TXMnNwwfdM1oU8eu/KIbVC8R4zX3bK8SG6pUbD3779BJqf7bmdYEQG53CtzUfyUMYcUVVxSGzXhCjPzGC+SDaLqwUWF9Cj+77WK+2vzf/ApnGNQtKLTPzyUqOWKTs9O3TxnIDBtLJG5ODu3fnVJLjhx7EMNbAezyTd3KnAxcALqpNyBe2qSkeds1zYPth+PbfRxXkmBW6eCas0AS0OQ4t6iUDscLhJVvX6GKqshhIRiCw5UNyHIWys/pX3BoH9HaSn6dizMgFR3Im0zks98hnElQ/7Pn/LMnC198PbMYGShWKvnU0xMIy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMsLa9SVh7oLC09TyZTlFW+4hvJuN5ad1dNooxZLZGQ=;
 b=le3+UM7R2FKc0IlUJAptSplloBUbXbfxaGE92AkekkIz/H9f5oN43pjw3MfoklgDTaX2pOkySypPiCh7xpFtJe/nZREaP0IsEiRa0FCo7NlPvSW/Jc79fGyEkcAv24lTpXxRbk6kx+szW2JuwBfXGp6qf6DyrS3b1EB89lUpIAa9xvK7I0WkGeNAKw0Eik5MvbZ55VEBfUBblRbyIy6GgMjGOzEga6e6IW7XXxO/Ppsd+UrjJe3Netyxp6kY/a1z7dHWqhoLMLAhrBCobdcbBREndkZiw5Wj4Q+9cRmxh9XJ3OanXfkY0gEO15m29bJ+69jiOqmk5jW6cPl5AzZKXA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYBPR01MB6923.ausprd01.prod.outlook.com (2603:10c6:10:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 18:18:49 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 18:18:49 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal
	<sumit.semwal@linaro.org>, Sunil Khatri <sunil.khatri@amd.com>, "Jesse.Zhang"
	<Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
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
Thread-Index: AQHdLZnnNFUgxINI1E+0OyQiNx/eE7arLcmAgAHDdYCAAJ2DAA==
Date: Mon, 24 Aug 2026 18:18:49 +0000
Message-ID: <34CC9A1C-0A67-45DB-B7BA-61484089F3D5@outlook.com>
References: <20260817-amdgpu-fixes-v1-0-36d5298da646@outlook.com>
 <20260817-amdgpu-fixes-v1-2-36d5298da646@outlook.com>
 <88BAF3AF-0334-41CF-9954-66AD5E0DA823@outlook.com>
 <3a1f539c-7abb-4683-95f3-85869e6bdb37@amd.com>
In-Reply-To: <3a1f539c-7abb-4683-95f3-85869e6bdb37@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SYBPR01MB6923:EE_
x-ms-office365-filtering-correlation-id: cac0a6d4-055c-4ccc-39f3-08df020c24e1
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|21061999006|24021099003|22091999003|24121999003|16041099003|8062599012|8060799015|15080799012|31061999003|19110799012|4140399003|25010399006|40105399003|53005399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?C+9NlBrlr22VF50KyzHQpkRVR/X4vRzRISasnxv5rVJ1ECg2msbmQyYl1D?=
 =?iso-8859-1?Q?0mQlYsW+oIdGv0AYMvXEHc9badCFrPR7h7tjPdcAYcBn1OND6+TMxHPcl5?=
 =?iso-8859-1?Q?qSMMf+DP+UKihdddEgMzTQWATerkQlVBHOtV3jX6csMWyWKMhoBj+T8YEj?=
 =?iso-8859-1?Q?tOAPf07wnUHibDigZ2CLNVNRsBriIfbjVKMbcQX0i4tCd7wC8kLhIdLizQ?=
 =?iso-8859-1?Q?4V+TWGuUOVR/BORO0MglyLH4o5tl0boWDokYBRAsJUNCOPiJMr3m26IPFw?=
 =?iso-8859-1?Q?CSJaSAf9/2f54JFlR1krISjeKRfcgub3BibwUBiEI2ytJxbi29IfTGGbfO?=
 =?iso-8859-1?Q?K1zhPiiPffvhyXTfg5A/fObbsdBk7bUEyjluGqho+0YBU1hzJEZNkt2qAH?=
 =?iso-8859-1?Q?4oxeZ079KjBzBaXk5/WOKQ0Hj3gMtOWMiFf8ya1Aopbb18ZPNjmbL2APLI?=
 =?iso-8859-1?Q?nJDocqMN6s+5jqckxFPV2vWImDRyoqaAwkjtKfw3iJXepmkNsaJowcLm7u?=
 =?iso-8859-1?Q?gPqU3LXwJ7ZeLylG7qaA64JyIUoWjlSACfrnOEaodXOU8vZN1KyMciMUaW?=
 =?iso-8859-1?Q?2cbn3rW2TZZrnv+V58un4cnMbe79VVFLAlFaSMIZPYvoUR4IITmvd8ZFpe?=
 =?iso-8859-1?Q?y2bg+kz4jYGXxnCH0X1KU5U0WlWbD7Y/EG6z2aDSItz5yXy3MyR42nd2Qu?=
 =?iso-8859-1?Q?cBdHom7PBOHciWl8hRMl/sNSpYfWT39H+ECvg+rvDWO1wi/fdA59IrAaRF?=
 =?iso-8859-1?Q?ywSMlG9JxTWcX8x8AkKNSzH8m7bNcyd3CFpUXevkBiT1tGqzm7r903RxpN?=
 =?iso-8859-1?Q?VCPauIIWA1UOwXBftyIcmSznsqbpwhfMR1Oc+VxZrS+7GOOsNAiAY5RdOe?=
 =?iso-8859-1?Q?exSoxKIPgVXkX2MQqlwhY32fw6WFbJWm1efSnusrNLRFGVJ+/vykNpmtoP?=
 =?iso-8859-1?Q?6FRUzaRHqNZxqtCl2RDmTjPm8tSjMdY5aEeXLkI3RQKtecweI/ir7bZ9XB?=
 =?iso-8859-1?Q?epMjaZtt50ssCGactJQoLqH6pLTE/XYEJqOOdlZtc7uDZoR2zWzwPvNGB6?=
 =?iso-8859-1?Q?wkU2QX3kKAfmpFBRRXw+CCpxU/D/gvhGP/YU9oyINziKc9SAfTAbvwltvZ?=
 =?iso-8859-1?Q?G9tYyChg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7QnT+qtrBUiCMts7rsIEPNATe9cAA3uWo+kObKG99hXHngiVE3idkDplp+?=
 =?iso-8859-1?Q?vSKSKx+T8zq5ovlBUwi3j1kNiUGpK9LI+7LPiQoTbqSx1c3R30ZKNnLfCv?=
 =?iso-8859-1?Q?oY7Mhp88Ul7OZ3UdGVVdsGoJun7VKfWzVrV3alKL/VNigDiAnL51hKJfZ6?=
 =?iso-8859-1?Q?+haL2PMVUnbmJQ4a51mtNoiNDbF0HXRwBXJ8w3JimW4LcV3RzpNuAJxzMj?=
 =?iso-8859-1?Q?B1xD8mRFJDRw7Rrcxtdqv51UrrsLcfLguY0N+2nK+aT7flRl0EskF6DDLT?=
 =?iso-8859-1?Q?M05r+EaPEzlTB2BhUoYT7FQlDkTUED0ek4TUe/D0nDMdM9bEzTaTBy4wnr?=
 =?iso-8859-1?Q?E/qLufQZB0MXxODVADsirVT8ipM3c5Bd3wwhznjA6muPePBofrXyyrbwEQ?=
 =?iso-8859-1?Q?qMfsS3/KyuqIPcss3/8dRt5hRVvnIepONt2YNkWCClgxso08p0B/32Gfkr?=
 =?iso-8859-1?Q?sGv6VbnELkKC0LgYXGBknvJMPoeh8XNCCaVwIl7tJtSlY7o6YTpC2qFfVK?=
 =?iso-8859-1?Q?pR/C6P9FKqNERNYuyM2LrTDul6GAFFxIFWJNvZwHI8nDwWhAvcUpAEtudf?=
 =?iso-8859-1?Q?MFEPkjyKhJOkC3GRmhVn2jEr36PunUJFVIHZ9eGrVTVsLw9wh/MLeix2LZ?=
 =?iso-8859-1?Q?F4KfzHw+wXFwRRisVqacI33QTKZ2YvtlyApyNEo7G0bASRfqCObQnan0do?=
 =?iso-8859-1?Q?cBRbnyzgz9eUdk6tvll7wUiaFNgB3e3p0V9FyEm0S8PiV2cTGsrlnDbEPq?=
 =?iso-8859-1?Q?0y/tZ+lF5y5hAoTeJyqryRIywgfe+g+nZ5tDYpnaoiW7K1CrmrJWobllZG?=
 =?iso-8859-1?Q?cZxPxKPqzX4shir08AQtE4MQvrVpetrUKm5iJ2Qpa9d14PbF56D6XOnLdq?=
 =?iso-8859-1?Q?jhMMGcRIYMVOL34Q0MS0wt1PIwXajutgBFcEiilOiSI6cJo0epzGwYYoVB?=
 =?iso-8859-1?Q?UpVj+3nLH2nfTlV24OmrsTQOlEw3NW/2BCHb/UQWEjJfR6bIkKi5MUlJH3?=
 =?iso-8859-1?Q?e9cJW0VwJXp9WCaUm6c9tq25YjsOJqMf5XJMVAfvzjmo4cIRo4bJlBhUv6?=
 =?iso-8859-1?Q?zD7ct3Ux+0n5serLWSffnpA6IZLfVIM0UOfXQj15E7ev7bE0OzhP5Ze2UU?=
 =?iso-8859-1?Q?92sqU4hnXwaWE3FOpWJCHKBiVO77/Sqko3OHjfccODfiVQw7PjWyF/UcKU?=
 =?iso-8859-1?Q?AKrhMQR3yEiABaVmRGrgNh7sHSnL8FMIHFGMFY712sWnM1bRco9Xw6mYYW?=
 =?iso-8859-1?Q?N4r/UXqLkSHFfjzS39fefBHQ1BfMnoMYalmNdvBpgNNJ3jhxKKj7b33a33?=
 =?iso-8859-1?Q?Va4RCuBD1GMLhvoy0g2/vPzqPGra+iIz2/puwBhq/Q9ihH1wyj+VyFB4YH?=
 =?iso-8859-1?Q?lR1F372D/sw/cTlCT08fwsj06K94ZgPEOL4uql9L28WBHO86aaFHy/jmBJ?=
 =?iso-8859-1?Q?6BnedC1zbsk20SNYudN6aofmmrcaStXvqzuZ/w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <BEE17E295D14AC48A93B6008F7E2882C@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cac0a6d4-055c-4ccc-39f3-08df020c24e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 18:18:49.1350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6923

Hi Christian,

Thanks, and sorry, my commit message was inaccurate. Dropping the
queue's fence_drv reference is unrelated to fence_drv->fences, as
you say.

amdgpu_userq_signal_ioctl() takes the wptr from the user mapped wptr BO
and hands it to dma_fence_init64() as the seqno, which is documented as
"a linear increasing sequence number for this context". Nothing on that
path checks that it increases.

fence_drv->fences is filled with list_add_tail() and drained by
amdgpu_userq_fence_driver_process() as a sorted prefix cut, so a wptr that
moves backwards leaves a fence sitting at the head of the list blocking the
drain. The hang detect path does not recover it either. force_completion()
takes the forced rptr from userq->last_fence->seqno, which the same regress=
ion
has already moved backwards. Destroying the queue then makes it permanent:
amdgpu_userq_fence_driver_process() is only reachable through a live queue.

So is a userspace that moves its own wptr backwards in scope here?
I can send a v2 that rejects a non-advancing wptr instead of touching the
fence list.

Thanks,
Junrui Luo

