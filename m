Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D293B42FB;
	Mon, 21 Sep 2026 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000199; cv=fail; b=j5LUQCdlY1+jDPN2lBg8xE1F+ru0t+cS8NFDVbzIZmhzD9yt4VrQnew7UP5gCHMrLGOvnjdGFUpJlp9yFKTMbuS/RMrP9ilI+tRzocWmBmDJywq18YXEvN74SC3ZgwWIUrsNrgQvE/6IqPngtyN7MJHIqcvbEa4eGYKF1tieSlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000199; c=relaxed/simple;
	bh=IU3I9TrbW/fohkr1nyzYMosF8vtrD/VsAjvjwyY8Uok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bJkXTZA282unFWuCzxxj32mu3aaGj9r1MjbUT0aYg85PhYHnU70kaWVwBfoUxB0247ts6JhGz+qoMmMQb+aGplyfb+dTptFMhweUxVTJR+ydQXo+Pnsx7h0752tnp3CQWf2goZHryGXvmL7fcOy9WmA3YPpjtWh3XsZmayJC77Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VOnL2iUj; arc=fail smtp.client-ip=52.101.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VOnL2iUj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNOvt0Z0hzcBiRW22/JzfUvOyn20SbY6VZHZyEfr2DI0MTtLIFe/eVkt8l1zL3g0MyJiXFPuiEc+V5Fl6dBoab3IBXGuo85lYCbI47DoAbdNufkvAwNjZ2X4PNsJPokirFaP+tcTOscY56fkmMjHhbWdSBEVEFBMBlzFrg4Rg2ncQb1X050BdTmplFPEJEdvhZGAAbHAS3hdMakLi+CF6ylj9oPmHNNGMSlW5BRSlR4eqD/M+IdPutQyJcNdPz55AN+Tk2fb4T7QhJSOfMyzeA7fV8JSNrzuZZlAMSpWWs0nlvmnyFxJfgloC6ZWo/KkXBLKdaCpaDqqtGy5cfGJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU3I9TrbW/fohkr1nyzYMosF8vtrD/VsAjvjwyY8Uok=;
 b=jLYmwB0WwTGaYUC9+Cp6FSlzDEUZ9RDgfhZkftuhH0XZXLZWV3mCnNa0ka6c9/geoIABR0OWTKpu78Vy4Pq8VtKqCbccfhII3CQvnZo40fUbMBzOoGYqZqT5ylum4ESmoZsWJRuCm6L4PXBoRbtxCLYlXTJaVjOy9PVyhj4A/h6K6XDCro4vEvkSfZ1AAQiFdDxcImgGiiAYeoXTCc4gdphszNkyg4QuGylIEExeg1yIjOV5Yu2+oGkzJfcw3TDDrMFpLlCBgB/JPDses5VM9uM6j/5yZFGPJ5NWu3qh+cveRT/LWlq9Ex8bOjeRhm4lN0WdteAlYz2AxgJDyz4oKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU3I9TrbW/fohkr1nyzYMosF8vtrD/VsAjvjwyY8Uok=;
 b=VOnL2iUjI/sbOnDMKdIsce8pKEJRkJCvC1stY4KEQfIcsCPgGYZ/Crp7cyzxb/jt7tFAl+4Qq1NpFw+DCDgCvh6XIPmlPrTGXgvMsdlrcoowDEJJpqj1vxSk0MU5vghbY5kGK8H7cCsXBo0OL2UauNINqlTsrzDNdfETvmWXWeZI/vv7qK48MnM4UbWAAXAR+h57fi6k87GxKjsoWEZ4nOTreYyYtZjqW1fifw3SeNcgnetaUISjjHQvRhTFzMDokFdJh//hzC/H3ZiZPG+pwd3BnMa+7ptXAkbSkpWYOpK7gYjI2gCDNCbiDjaSNJjlhR1xWZPuhZBOQwH4iYkarw==
Received: from SN7PR11MB8262.namprd11.prod.outlook.com (2603:10b6:806:26e::13)
 by CY8PR11MB7825.namprd11.prod.outlook.com (2603:10b6:930:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 14:16:34 +0000
Received: from SN7PR11MB8262.namprd11.prod.outlook.com
 ([fe80::2a54:c2a5:16e4:48dd]) by SN7PR11MB8262.namprd11.prod.outlook.com
 ([fe80::2a54:c2a5:16e4:48dd%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 14:16:34 +0000
From: <Ariana.Lazar@microchip.com>
To: <jic23@kernel.org>, <andriy.shevchenko@intel.com>
CC: <dlechner@baylibre.com>, <joshua.crofts1@gmail.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<sashiko-bot@kernel.org>, <conor+dt@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v7 00/11] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Thread-Topic: [PATCH v7 00/11] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Thread-Index: AQHdR00udHDJE8TAz0OdNS2Ah67wwLbUGFeAgAQC1YCAAP3TAA==
Date: Mon, 21 Sep 2026 14:16:34 +0000
Message-ID: <f8ac8ad69138fc9e19074e491f91f2892e7bba95.camel@microchip.com>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
	 <aq0J9Vs1_rUAlcoA@ashevche-desk.local>
	 <20260921000803.1148e493@jic23-hlaptop>
In-Reply-To: <20260921000803.1148e493@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8262:EE_|CY8PR11MB7825:EE_
x-ms-office365-filtering-correlation-id: af9161f5-3f83-45f8-1f7a-08df17eaf134
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|11063799006|18002099003|22082099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 09EjFsVJF6Z7/kZ97+9L6fX7M+yFlPZNDkscDo3GkPQ6B24bd6kII/UxCo8c1mKIucGGFF0GyPBeKLozUvoLqmuEhT5ZII54b0mzQrD2fEEsxuYOHOJAKZ9R72Gc6AHndmKaww2VLjKQs+nu/WlrsDQbX4BJ71TTSWgnOvdBaemCl9WOHWc32yCUw80ZzUouHgAaDFiXMpSGpdPUk7Gacu9cJ6pOv4hnjidp+bH7ysJpx4njYx09aveSbsu3SP8E78NccPuA0+5kI0rJEao25N6a8U2l/kTwKdUQKibZzD02AJLDXZpDLnCjqlHZzCgYb8ouftII9e15HfAOc/SZNnMlTSCr0TE2X1URl3B3h+V31fQysyNJ5YCA5x8kGg19k8sYMHtvnM4K9g441cgF8AkbuPXSrtUdhoO95LVQE9btKR3vbgFK9JQzIYM1ku1vTodH0pRdp0bYnDT4NrVAKRTbVFDJOovffRrCJCLMmZ24gYeghM32iC8sB8pvfPetZI8dNS+pxK4gHWKrr6Pc4/Rpdi+eio/hQ0sMmgJWV4I+3HdE1i9ml+ssC871vN/x57Jzv58riI8nzeUyjGLpGdQIhps+SoIK8BX5SeMfCCH70DtGqFSCr4xj5R39y1FGhNpPGoQ+x9yQMp+miZEBCuKX5hNLNo8SgwgPv0Ni09Qum3x2T50tOFpf6iTQyg2n+HuKRm4zFD4UjUKMsiXEyjvfDmka9QeuXn98Mft16qs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkFmbWNSTnN2QTVnenZrYVhOdVFMM3A2cGFieW4vUTIvQ2RjZzIxRkdEVHJ1?=
 =?utf-8?B?Z2Y4c2Rpd2liRWo2cU5oeGlxcWlKdXNEbmZNQjNPQ1B4WHRWTDhNUlZSZEE3?=
 =?utf-8?B?cUNjUUYwZk1SNStZN2VvNitmSVE0WER5SS9TTEloczZDdjRDajZqSS82VWd4?=
 =?utf-8?B?SjdXdDJNQjlFYmZBOVFMUTloTWw2QjV6S3lOMjcwMlF3MmxzNm5hWC9NNGdN?=
 =?utf-8?B?RjhkUGZ5ZUNSMzFDK0IrdkFWSmhXZFpoRFMwQ2JGOWErRE9ydVIxZCtaUFo4?=
 =?utf-8?B?elNBY0JwdTZHS3lmMkxldlFKMzlmSkpubVk4aXdHb0U5bHYxTzVBUlJ5WVZS?=
 =?utf-8?B?V29UVlE1cDdBMHI0UnFJZTV5VTNDQlR3N3ZOalR3L0RGdnMvUStPM0ErSENS?=
 =?utf-8?B?QlFDSzYvTzJlLzluL1RITWJOZjJpcVhKU0dsWGlQZjdxWExLc29MMkdjbXJs?=
 =?utf-8?B?TUlLcGZmMGpNY2QxN0liMFpNNHNYa2tCS2dGeWMxb29kMVkvR0tNUVFJUDg1?=
 =?utf-8?B?T3l2TjZINTVxR3JLS2tBU3dRVkQvQVd2TnlvTHNOcnhzbm9acUd5UnpSMDA3?=
 =?utf-8?B?cFVZT0hXYVBjVmxYVkpqREFuM0lLK1E1YXlQVEZnOHI3ZVd0ODcyNmxkaVlx?=
 =?utf-8?B?bDVQemFJcmhTQ2taWWlUMEl2ZHNrWFkwWGMreFVIRDFmWVJQWlNyc3ZhTVJk?=
 =?utf-8?B?bVdyRW5KUVpZblhKQjUxWjZsUVNRS1BiZDJlME5TbFZqVElLQnhvRisvUS9z?=
 =?utf-8?B?UWZMd2ZFSWJVNmt5VEVtRzBOQ1REdG45SUlFMENBaDRqQXArdHQyaU1IMFZi?=
 =?utf-8?B?anNnYVp5V01TSFk1NDMvYjR4MzNlNDVpOW1COE0vN0RRTXpJTG4wa0t3RnNs?=
 =?utf-8?B?YmNSZzYrb0V6Ymltc1QwdTF0K3p3ZFFManhva1A4VGVzeFNTUDAwdXQ2MTJp?=
 =?utf-8?B?dW9VWmhoV1ErRkEvR21VUnRyUEVDOWVidFBOVVIvUm5YZDNuUWVkSlNYQk9h?=
 =?utf-8?B?ME9KMFBtSzBZL3hTNDRmazV6Y0wwRFdKcUk2YlY5b3gyQlIrREFaYTY0K2ZO?=
 =?utf-8?B?RFZkL2hKdjI4RjU2eVhnMEoyMEl6cEpDb0FPcXJSdFdFNlB6N3VIM0UzK2dB?=
 =?utf-8?B?SWF4WWpoUHJIRGN4VWZiNEQvTXBZVGxHcXpTa1VPZy83dnZ1OGR4TktRSURW?=
 =?utf-8?B?QnJPWTlzWTAwOHUyalVRSzlFM2RGOWlNaW9LWG9MckZZSDhHR1ZwbUtmNGwy?=
 =?utf-8?B?YjhaZ1F5WDJNRHZRU0FtR2ZRbHVEL1I5TmhaQWNtQVczT2dpMlBBMkRhTUNQ?=
 =?utf-8?B?eEdKTENOL003aGhteDZONGpSbGw0c082ZUVtdm9PZXBLWVFwWk9PWWcvcFRN?=
 =?utf-8?B?bTM5MFU4a3A5bStTdVIzZWhuejFOblNZa3NhNzZUMXdUM05SbFRQeFVtSDA0?=
 =?utf-8?B?eTkyaWR4YWx5cXZFdE1QKzNlSlFGN1VvQXQrZVVaTmtGeGpCWkZQMHovK3lO?=
 =?utf-8?B?MFpCYm9ka2lHQ2thVzNXVmtnWTBjU1dDTjdRNVhueW12aDAra1A4dkdVWGdk?=
 =?utf-8?B?dWVIYXBPNDdIZ2tGdWp6YXF5T3RXZjhwQ2M1bWNQakRxOVpMTjl6Q2NtSE5J?=
 =?utf-8?B?ZkFCdE1HTkVkbTdPZ3FHTXk4Q0tPa05paXZEa2JzL1JjbThoM09EbXVtdEo4?=
 =?utf-8?B?cjlTT2wyZHNwWGtYdy9CbWJRakM0UXRuQ2gvZ01OREZ4WUx6V0o4VmRXZHJk?=
 =?utf-8?B?QytEY3F0VG45cnJUbjlBc3ExVnVyZ0c2eEZTZUo0ejNCcStYdWNCcm50QTdT?=
 =?utf-8?B?cXVnVVJ6eGQwL0lubys5SXo2WDhWMTZPRWx6Y0gvTkpYbng3OEIwZFVzV0dS?=
 =?utf-8?B?cTdzMEFEVDhVYnZQU2Q2enFqK1Jud1FiM1g0MDBnMXkwdmI5VUw2SzhVdzVo?=
 =?utf-8?B?M1hsbEV5N3BacHQyaTB2MmhJbHFiQlNkeVM0MDRhZE9rNjJwaHcxRGp4dm9y?=
 =?utf-8?B?NFRRRE1qc09MNGgxRE1aSTBYbFJqK212UXE4Sy9pWDJPUkZTZmgxTk9YOGdQ?=
 =?utf-8?B?aWhiN25TakE0RExzcHBDTGRLSmkya2FyTGgxcE8yb01jZ083RWhlREp1bkZL?=
 =?utf-8?B?VUxwdVdoMzVqWXc0VTU5MFZ2OGprS3RsVHdQM3VObjhMQVp4RWRobEtjZHFu?=
 =?utf-8?B?Q25LNzc4N2JkYnhpdDI4WWovUnUyazhPMklxYVMweTc5c2Uva0Y3aHd4TzNK?=
 =?utf-8?B?QUp0WUVHVjhseFNNSDJld0ZjYllyRFlLODFHT2pKTi9McXM5NGY2UDI3cndl?=
 =?utf-8?B?dG0xQThJcmFQZ0ZvSTFzTUVyajJFM28yQnZ1bmsvV0tPWExYT0tyeFJQSVcw?=
 =?utf-8?Q?hW+NlYpHw3kJ6rhU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82B49A1D8D105541BE7CDAC41F3DF085@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9161f5-3f83-45f8-1f7a-08df17eaf134
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 14:16:34.6265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXyU26rnwtcyI77c4SkPQ0ffSKEgbsCIT/uTFe1ohLuDZICHs6JTTnNKUzac0gCVaMxAa5f+7+s+jG+e9DRVxNn18xP73x/kQEejOnd+eTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825

SGkgSm9uYXRoYW4sDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KPiBBbnlob3csIGxl
dCBtZSBxdWV1ZSBzb21lIG9mIHRoZXNlLsKgIEkgZG91YnQgd2UnbGwgc2VlIGFueXRoaW5nIG5l
dw0KPiBmcm9tIHNhc2hpa28gZ2l2ZW4gdGhlIG1pbm9yIHR3ZWFrcyB0aGUgcmVzdCBvZiB0aGlz
IHNlcmllcy4NCj4gDQo+IFNvIHdpdGggdGhhdCBpbiBtaW5kLCBhcHBsaWVkIHBhdGNoZXMgaW4g
dGhpcyBvcmRlcg0KPiAxIDIgNCA1DQo+IGhlbGQgNiBiYWNrIGZvciB0aGUgdGhpbmcgYWJvdXQg
Y2hlY2tpbmcgaWYgcHJvcGVydHkgcHJlc2VudC4NCj4gMyA3IDggd2l0aCBsaW5rIGRyb3BwZWQu
DQo+IA0KPiBTbyBqdXN0IDYgOSBhbmQgMTAgZm9yIG5leHQgdmVyc2lvbiBwbGVhc2UuDQo+IA0K
PiBBbGwgdGhlIGFib3ZlIG9uIHRoZSB0ZXN0aW5nIGJyYW5jaCBvZiBpaW8uZ2l0Lg0KDQpJIHdh
cyB3b25kZXJpbmcgaWYgdGhlIGNvcnJlY3QgYXBwcm9hY2ggZm9yIHRoZSB2OCBzZXJpZXMgaXMg
dG8gY3JlYXRlDQphIG5ldyBicmFuY2ggYmFzZWQgb24gaWlvL3Rlc3RpbmcgYW5kIGFkZCB0aGUg
cmVtYWluaW5nIHBhdGNoZXMgb250bw0KaXQ/IA0KDQpUaGVzZSB3b3VsZCBpbmNsdWRlIHRoZSBu
ZWVkZWQgY2hhbmdlczogdGhlIHByb3BlcnR5X3ByZXNlbnQgY2hlY2sgZm9yDQp0aGUgbGFiZWwg
KGZvcm1lciBwYXRjaCA2KSwgdGhlIG5ldyBwcmVjdXJzb3IgcGF0Y2ggZm9yIHRoZSBFRVBST00N
Cm11dGV4IChmb3JtZXIgcGF0Y2ggOSBzcGxpdCBpbnRvIDIgcGF0Y2hlcyksIGFsb25nIHdpdGgg
dGhlIHJlZmFjdG9yaW5nDQphbmQgU1BJIHN1cHBvcnQgYWRkaXRpb25zIChmb3JtZXIgcGF0Y2hl
cyAxMCBhbmQgMTEpLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhpcyBpcyB0aGUgcHJlZmVy
cmVkIHdheSB0byBoYW5kbGUgaXQuDQoNCkJlc3QgcmVnYXJkcywNCkFyaWFuYQ0KDQoNCg==
