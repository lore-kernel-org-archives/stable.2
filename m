Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624ED2C0274;
	Thu, 17 Sep 2026 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624915; cv=fail; b=AXUx2YbuwCmN+c5q58pm+rvTbbMp7i0j2omssWl7eo6X3nn/U/bwnKpO6zs1q0DfTlo6teizT4QSilipRqMxXW6g/AKXQpZm2ToQZiyLv6zaR4q/SINGOUj+tCD02Bdd7H17ToLBBYmvLLbN74Zcok34tWrQsGrz435fotpSl04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624915; c=relaxed/simple;
	bh=kGFzhJ0we7FSexsT7KsViNjB4Z9b6XRi2aPaIDaAtjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sVDW3h1qnDFVfVj7s039k6Ab5HafgaYkk70V4Fo3GIJQlyy+fvp/SHdPx4seA/U3jGYI9aIywPbQv2FuwUt2U4S8jukRPHCI4dUEy+KvFesZK2y09O3e10Aim+s/7jbQ4LMgk0GBXefrJlofHcO92JkHmeUNND3TeD9jFcTYWQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nbNft4Vs; arc=fail smtp.client-ip=52.101.57.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nbNft4Vs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds5xOFjkOZb98/ARRhv1YrZ4IQofj7+9JFjeP5+cztzrk/a5QWCrfRd+C963TnaKpGQOHZO46Kp5g6IJ+yAH7MHSAXzF1zLYQUahNZXENKasTPSI1qgai45Jw2vRZrUPUmFM+u+dtikjbxiuzlNeWXq1hjY58Rx8q/PeLuym8sJ9ZH/zuxccz2wYlhNM0rYvxFuRdbys8a8xQz+nB141NEwqAsPP7me0ayTP3nC732K8w2RV/yeyZirprO/jjSfq7RxDWxzhbLAa+oafM1R8NlZz+Ly7bNvjUladkGi355r/e263FrTmT2eL2su/ut63xv9lHaFoWMNtT2u0NvGiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGFzhJ0we7FSexsT7KsViNjB4Z9b6XRi2aPaIDaAtjg=;
 b=flXtSs4Vq/Xt/mQr645lGFegtLLE/2RZbSvoOUfD7+3JeiKelXUVwEL9jGo8fnxIzUV1hKkUgwwFMPXJAvG8vKfVWq10zexjO8jf3YEVs334CXXyZu7/7KhWK+f0TaJ5JOT3e4t1XFSbc3uNQvgxNrkNa+Hkfp2MYHAjBBALI7XKmRr9mLXapdYNxpRDkyqeENaZWDuEcKP9D7bXh2rKnKCxc7ytDnXMEpTO/O0IcgX7wYbS4atFiFWkqde5mrj3P6vVwofN/ydbhpRtyoF6pvMKd6shgGF1eJ0ZCWvqQJd8f6dxO3U4K5+f7mtenwo79Ey8Y4YrnX9C9442ZDiGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGFzhJ0we7FSexsT7KsViNjB4Z9b6XRi2aPaIDaAtjg=;
 b=nbNft4Vs5ucJi48dlZZqGfF0qTUIWSmFM9ugSAJWna6bi0TF5+d1ZoPy2oWHqMArdpl4nTwJOhQ6fPM6TTnEZimsG8Erb0clii7b7qpK6jIps/6pWkz7agF8M8CYYb11Ht2woPoy9zOJ027LcFI57ZUigzsPrOGJe4ndGjuVu8U=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by CH8PR12MB666014.namprd12.prod.outlook.com (2603:10b6:610:32d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Thu, 17 Sep
 2026 06:01:51 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29%4]) with mapi id 15.21.0428.009; Thu, 17 Sep 2026
 06:01:51 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: "jgross@suse.com" <jgross@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "oleksandr_tyshchenko@epam.com"
	<oleksandr_tyshchenko@epam.com>, "Huang, Ray" <Ray.Huang@amd.com>,
	"sstabellini@kernel.org" <sstabellini@kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] xen-pciback: Fix pcistub_device ref leak in
 pcistub_get_gsi_from_sbdf()
Thread-Topic: [PATCH] xen-pciback: Fix pcistub_device ref leak in
 pcistub_get_gsi_from_sbdf()
Thread-Index: AQHdRf6GMogNWDJZT0qc64OaPhUu9bbSzYUA
Date: Thu, 17 Sep 2026 06:01:51 +0000
Message-ID:
 <BL1PR12MB584959EACF1B4FB8DC26E22FE7B82@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20260916171141.2086627-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916171141.2086627-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.21.0428.008)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|CH8PR12MB666014:EE_
x-ms-office365-filtering-correlation-id: 1092a324-4976-46e4-e4d7-08df14812b0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|38070700021|10067099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 hG9ZsU5TINVKX+GvEIFpuuSQ1E0z47m8M28eZK8uqF9phSCBbEyRzdRNgGh8Q/jNRli331/g6pt5nEEaYKeYorm3nKtOnq5RU7GL2J2DRdIok4CcY/fyuOTRuLaW4QJttNPkaekkr7jKMTSUurk/e9EjSNqvDZoQOgWZqblJmaZhN3FCyE/sgsIcxoqaxn1YXFjWV5v+/SDRSO70V04v7Jf+kgQ0k1ol/JkZBOf+xSisWjTGgY7C3DGXoVWKrIFj+TUreUv/+hLTq5DUZrqzGPoFe1w6ccP5vDK2OQygXMt0YYt8q2ZqL2KVCLTrh5QByDPPHxQaHS15CO8qabAwoE5B+4vMIltns9ge3musRVflzyHcE1V98FsjUxKKOGiCGh2bYrNxwE2xipdm4cOss5/mjEIvveBy5Hv3XNdGQ7IRCFT3n1x14v/83mo5CrY9Xft8jtN2kqJi5yQJQ8YSqWfI76cvZQ0FIINgB24MnQ73dQ+UbFd2BWVR04j0OZ0xjTnJ7vKJA84rSTuSmObxLlehq+QQIm9iYOhR0mDQ+TWrTmnj/G4U1WSP/zy1D6z5hBnmv4AqazefK7tbxOKmOgWJJixPUjUPq2GnYTENbfHZIjggR+ejixqFx5jxUVANscIRdsgwdC7O3XUJKAuSJbFqg1QwELDpqAjXC6YGVnVwOa2c7fsgjpfBmD1Viloo8x1Yw456bu45tCXTXgPDRL1VXkCjNdn6NlsPSJ8tGzs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(38070700021)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3hCRHk0MWtJYnRmMXFKZ1dXYVBIYW9FaE9kZk5lUlRKQ3FnVDI1K3ZDRHY2?=
 =?utf-8?B?WGxraWdzMjNPc3dsaG00ZGh5SHBLdnhld0h6N2FxeGpHY1VETjVGRFJXaXJp?=
 =?utf-8?B?Q29WYUJ3aURaUitxRU8va0Y5cHVObXhIbFF1VlltQmVKdVBBOThQK293L09z?=
 =?utf-8?B?Vm8vdGJibzUwTENCS3kvSGlQcHdScVN0WEt4MTFtZG1LMC9vTnJ3TXpUclZB?=
 =?utf-8?B?cnhucGdMdVZFSVUwS3dLRy9ncHlXQ1JZNG5FVXpkMDc0endqelFnd1ozb2Jh?=
 =?utf-8?B?YXVidTg5UGlvZG5zWlJRRmgxR0VBQ0lWdUUzaXdBWlYxaDBNOE55OUJWNDFC?=
 =?utf-8?B?dGlpaXN6UklqcCtVeEZEY0hGN0x0OC80c0twYWs0QzcvVFNmZkRFcTFIN3Qr?=
 =?utf-8?B?NkU2T21IakM0cS81djhlWVdEalcxcjRoZEVlclA1d1VQOVRTNW52aGc2N1VD?=
 =?utf-8?B?TXdSbzA5Q0crM0tDd1hCN1JpbWdlY2tWQmdEYXdkV3dlY0FwdjlvdUhZeGY0?=
 =?utf-8?B?U0ttSEFNSzFqQVFvRnQ5cVFCNE5TNk9pc3VURWlpelkyMmFuM0JHS21yQTVZ?=
 =?utf-8?B?SS9XSlczeTdCRUpqTTNTSGtic2hNcU1rT0N0YTBEcVlnNzFuSjlqV05KQzcx?=
 =?utf-8?B?aHI3ZTJuK21IaXdabndXY1BENW00VVpGOFJQdlFaNDdZdFU1WmtkbnB1WjdM?=
 =?utf-8?B?OU5SOVdueitOczdtMkVJM2xpSFpBSi9WcmxmZXdpUUdzaUJuQU5SZXhJQ3hO?=
 =?utf-8?B?aGs0WW9FVU9MNTBaSWVuVEtpdlh1WURGUUhrdXZCWmZjTlAvaGJlMTRrV1Fy?=
 =?utf-8?B?NEdIYVc2OEhWbG4rVVl1aEpQZkJzQ3pOMWxONWcrUnhvUVVHN3oxeDY2L1BO?=
 =?utf-8?B?ajhQOTVWQll2eFloU1dIZ015NE9lR2thamFLd0JpeHpxR2tTaTdGOUlOZ0NF?=
 =?utf-8?B?bG5zNUlkZjhpcDMyd1dRckRPSG5QRHdOWXJpdlFsVk9SQ0FrZVlXc2F5VWVq?=
 =?utf-8?B?engrQW1LWDV3bEIySFNMODZoZit2L2h5ZVFSdjMveDFFNkFRV204WUJVY3Fh?=
 =?utf-8?B?UXo1emRPUlF4RC9TRHpJVHFCR1hISW8xZmwydnU2U0dTckxpS2tGRUJOSlJH?=
 =?utf-8?B?d2tlUzI3Qk9XOFBlUXJObmpXNU9BQlZkbTFhc0tSa29OUE1hMkRuUDRNRzNI?=
 =?utf-8?B?c0dEMmZGWmR5NjFLZm5wOUhkeXIxZnh4dlNMcnhISzZEalZrYzZ3ckdxUlRW?=
 =?utf-8?B?R3hpSE0xcTNpWDRaL1Y5MGdRZ1AxSE9OMWU1MnBLMkJDT0pYWWJnRUllMnNG?=
 =?utf-8?B?TVgxVGtQc1k3WTZkaTBsZXFqSmJUMTVUMjhpUkpVaENqRzdPUjF1Yk1RVkJq?=
 =?utf-8?B?L2tsYlFFRjgraDJDODAwRDE3RkdpOHVtcExCZjhjNWNNaHhGcmhjMWkrZzlr?=
 =?utf-8?B?by8zZURSdFVnaVYyZDVnYURMVkV2OGh6MGF5ZGVKYmppWEJMaDFpdjhuYWhx?=
 =?utf-8?B?clR1QkFnM2U3cDJKNFhISDl4eWo2RzNtelZGcW80MkhQSFM4TDl0RGZwSzFW?=
 =?utf-8?B?dmtaQ2pUay8yVEVxZThRUWtoSjRpRlJnZldMeEVIVHppSDFCK1pXUDByUlJD?=
 =?utf-8?B?VjVSbWZsOHdNa3FvYXNkNEl0NmpJYWJsZXZqSjN2N0hnamE0VUpGM0hacnVq?=
 =?utf-8?B?UFBtV3NMVHhlTmVmU0E4UitjUjljYUs1Mm0yc2l0eStsb1lEUlh3bzhwM3F0?=
 =?utf-8?B?R2U0UXdIcmpvb1VPeENibXBaMXk4dTZjOGtXYlJWZTR2SGVxRVZOdTY1WUxH?=
 =?utf-8?B?T0RUVUY2U0grRW9CMmYyYlBFYXVpak9iamxLSWdFUElIWi96UDl5dXUwRUhq?=
 =?utf-8?B?M2lWMjI1REFDaUQyOG82RG8zMHpidnY1QWs1M2hlWXphQU1GTHNxUkxGODI2?=
 =?utf-8?B?WHRyT0pZSnBMd2tkSFZ5TEFsZnZySDVPR205Vk5ieU1LWEhkL1NoM2FmN1Fp?=
 =?utf-8?B?S1NxUVdOVFZBRnFYdzUwc05Ca2hSSGF4SVpRcnFFUnVFaVBodjRibkQ2WHZC?=
 =?utf-8?B?cGpMb25zQnN0WnJPOHM0NktRYWVMcEpxdmo5Nk5oU3J4S0pjeWhWV01JY1VC?=
 =?utf-8?B?WFpIRDY2SkRNTXFDZ3U0ZU42U3Y1ZUJOUXlVbHQxRk1EV1JWUkZDbU5kVTBm?=
 =?utf-8?B?MG5ZV3NGOTNuYUk3bDE0RWpteDJrQm40L2NlZlczdW5aQkdVSEhjS3c4ZEkr?=
 =?utf-8?B?THJlR2pGSTFuM3RwbkxkNnVJSTQ0QjJRZGRUZ2wyVkcrYlJnWTMzSXdITmtL?=
 =?utf-8?Q?xtiJZ/9EmsBrwABjx5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCC3F93B4AE8A8499F305A5A6DE9C037@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1092a324-4976-46e4-e4d7-08df14812b0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 06:01:51.4641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NH27bbiF2hotpvENcQVZKXrpDmN5dEO6xI4yI0wkyZTBri+3TNI/845/gs+012xerHdcpgIzJ57kkCHVLhpzwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB666014

T24gOS8xNy8yNiAwMToxMSwgV2VudGFvIExpYW5nIHdyb3RlOg0KPiBwY2lzdHViX2dldF9nc2lf
ZnJvbV9zYmRmKCkgb2J0YWlucyB0aGUgc3R1YiBkZXZpY2Ugd2l0aA0KPiBwY2lzdHViX2Rldmlj
ZV9maW5kKCksIHdoaWNoIHJldHVybnMgaXQgd2l0aCBpdHMga3JlZiBpbmNyZW1lbnRlZCwgYW5k
DQo+IHJldHVybnMgcHNkZXYtPmdzaSB3aXRob3V0IGRyb3BwaW5nIHRoYXQgcmVmZXJlbmNlIGFn
YWluLiAgVGhlIGNhbGxlcg0KPiBjYW5ub3QgcmVsZWFzZSBpdCBlaXRoZXIsIHNvIGV2ZXJ5IGxv
b2t1cCBsZWFrcyBvbmUgcmVmZXJlbmNlIHRvIHRoZQ0KPiBzdHViIGRldmljZS4NCj4gDQo+IFJl
bGVhc2UgdGhlIHJlZmVyZW5jZSBhZnRlciByZWFkaW5nIGdzaS4NCj4gDQo+IEZpeGVzOiAyZmFl
NmJiN2JlMzIgKCJ4ZW4vcHJpdmNtZDogQWRkIG5ldyBzeXNjYWxsIHRvIGdldCBnc2kgZnJvbSBk
ZXYiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBXZW50
YW8gTGlhbmcgPHZ1bGFiQGlzY2FzLmFjLmNuPg0KVGhhbmtzLg0KUmV2aWV3ZWQtYnk6IEppcWlh
biBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy94ZW4veGVu
LXBjaWJhY2svcGNpX3N0dWIuYyB8IDcgKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hl
bi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jIGIvZHJpdmVycy94ZW4veGVuLXBjaWJhY2svcGNpX3N0
dWIuYw0KPiBpbmRleCA3OWEyYjVkZmQ2OTQuLmQxYTMzNTIzM2FhYiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy94ZW4veGVuLXBjaWJhY2svcGNpX3N0dWIuYw0KPiArKysgYi9kcml2ZXJzL3hlbi94
ZW4tcGNpYmFjay9wY2lfc3R1Yi5jDQo+IEBAIC0yMzQsMTMgKzIzNCwxNiBAQCBzdGF0aWMgaW50
IHBjaXN0dWJfZ2V0X2dzaV9mcm9tX3NiZGYodW5zaWduZWQgaW50IHNiZGYpDQo+ICAJaW50IGJ1
cyA9IFBDSV9CVVNfTlVNKHNiZGYpOw0KPiAgCWludCBzbG90ID0gUENJX1NMT1Qoc2JkZik7DQo+
ICAJaW50IGZ1bmMgPSBQQ0lfRlVOQyhzYmRmKTsNCj4gKwlpbnQgZ3NpOw0KPiAgDQo+ICAJcHNk
ZXYgPSBwY2lzdHViX2RldmljZV9maW5kKGRvbWFpbiwgYnVzLCBzbG90LCBmdW5jKTsNCj4gLQ0K
PiAgCWlmICghcHNkZXYpDQo+ICAJCXJldHVybiAtRU5PREVWOw0KPiAgDQo+IC0JcmV0dXJuIHBz
ZGV2LT5nc2k7DQo+ICsJZ3NpID0gcHNkZXYtPmdzaTsNCj4gKwlwY2lzdHViX2RldmljZV9wdXQo
cHNkZXYpOw0KPiArDQo+ICsJcmV0dXJuIGdzaTsNCj4gIH0NCj4gICNlbmRpZg0KPiAgDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KSmlxaWFuIENoZW4uDQoNCg==
