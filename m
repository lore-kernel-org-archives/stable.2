Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDAA335081;
	Fri,  5 Jun 2026 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683775; cv=fail; b=H+GaSzdbNBIBBVsQSg4kT1Hu7pKG+GPTxrhYywH+DUx5vnodVqjk+D7nv8VoE4LdzhhYNQq4HAPo3GyYXQy6PBBPfDxt+TibuDQXsCV5Pl0dhPRCgVnN+I5FTlvwwTaizTjSWM+SwAK8xxEs3BO3WqdCQ5Jn2FCzLCArvv3kPdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683775; c=relaxed/simple;
	bh=WnuHqSoEaLkFdRd72GkQfSxUh5QVT/9gIPgtDaXWLwI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nQZ26bfcBLwkAULC+gYcEzWESSMOmyyERXknIdkGVqvItjLRWKkDjO1r6ns8tsuKBKKjwz//CctgAtUYpHpIANZ7ltX8zQXK3q2wB4iOk73spLu+7I4spNU9/be/LkcBcK6BEga+blk6n5DdK2OfBQxSuVsWnjyY7xavIZ9uJEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I9Rfzneu; arc=fail smtp.client-ip=40.93.194.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I9Rfzneu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8LlLdVdGUAn16t18cNoGzhvax0Zpa7ATzh6eX54jiBA/sZldQ08/qxS66EfHNWiZeVqURTvnx59cHBlJpTFdtYhxLjnuUGT164Xgg97cZqcW5fr5i92sT0LTtmQKyqrEOYMhhw6uzfLnIdiPQHu8+2hPbJFq75kcNWi2/k1dAvfnyiPgTgKWp4xb65qp7ofWGRIQLPtatzepZW8B2YTeYKWOvjpLom+/E8rZrPbHpYz0UiGEl/ZpwCtQy3osLzHTysqcvix55zMRwTZXaFBoProf2WlXWBYRNBh5xZ9UdbBnl5zN2iCn2kQVpGp+2xxeFuMdctVZ0XSHOW2Rhst2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnuHqSoEaLkFdRd72GkQfSxUh5QVT/9gIPgtDaXWLwI=;
 b=pXPIbTBr08RDntVEmYd5wpbrzrFIVmCbb2kQojIqIOOH0yFtr/i80on3QG+o7mIf0O9MgBVGhHpjgTwbF41rDrG7SCExUlFktbTnbetTAfx8h4SUanLEMEtX1IubDujDTk7lCxVru46Cd0uf1nFqWUa2oMwgZBTYqjZ7ikekeigUbvH70H9axK8rQl4gWH9Gi1D2jBKrUN5ZM95AOMq+nkGg+4v+RfoMz1sR/sL5YZFD2ExOXc5PfrDgM4hyJOEqu1t6AJpNmFo3CeEf8P74qcqR+fPcZMNBvNmZqG3b5qn11BP+0IjBs6uk6Yu+pVGJxXuTEcIUi+BEVwkPtdHksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnuHqSoEaLkFdRd72GkQfSxUh5QVT/9gIPgtDaXWLwI=;
 b=I9RfzneuzS2ZDphG4IilWYFGVehnMOEyFksiuHeYkZ1KQmPlVLssyehRfjl4QvnvfjetuxjfrdK6RxlrHRw7o9pw7I3wv4JQLhikV1E3BgNJ9P0aPzLl5u/ddpqdThvqvlfQrqnOSYxv6/Y8ZvyLQfkKEcAnF9Fhg3HibzoddbtzLF7T7ktgC7BUxvCT0f3Gw4MWOt5gBlucQOytKsCBzjntk0gfBJao8CQR5bsjuyzlX7f+s6ZRw2zkS4NG5bmO+aIuZ2sCrN8hmtQBE1rYtZyH+/a0AT3f+6Rs5/AR1ZooJbUv+3wYc9okQBWdjRfR4tZUFvI4uBle6ooaDKYoNg==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by IA0PPF002462CFE.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 18:22:42 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:22:42 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "lyude@redhat.com" <lyude@redhat.com>, "dawei.feng@seu.edu.cn"
	<dawei.feng@seu.edu.cn>
CC: "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>, "zilin@seu.edu.cn"
	<zilin@seu.edu.cn>, "namcao@linutronix.de" <namcao@linutronix.de>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "dakr@kernel.org" <dakr@kernel.org>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "mripard@kernel.org"
	<mripard@kernel.org>
Subject: Re: [PATCH] nouveau/firmware: fix memory leak on BL load failure
Thread-Topic: [PATCH] nouveau/firmware: fix memory leak on BL load failure
Thread-Index: AQHc9QhQDYV/oMN/d02/Uz0YAF01qbYwRoUA
Date: Fri, 5 Jun 2026 18:22:41 +0000
Message-ID: <aa2e39a828634f20852d066f593f26510fbdc2d9.camel@nvidia.com>
References: <20260605020752.1707562-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260605020752.1707562-1-dawei.feng@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|IA0PPF002462CFE:EE_
x-ms-office365-filtering-correlation-id: f687b39f-f213-4c4a-ec71-08dec32f6e9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099006|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 eShHWpziUyBxNB9dP7PZVSY/TaM3BkhDXi4pZfnwdUkB+qeSPhNsonTgO7DcqFmepOIIXYeERSgbCFDOXegelolskqGGNKzIGxwiD2fPQIMsu11eZyZaODqiTHT8CkfuJPSBEoFyfWAtWcpeNvrlFbVMLaOy78AcYdqfejcHXPNVT9iLL2PryhDNwJ5CL3AlgFZRNhE7AmsrZeAGYcYqySXhIlBQc8wjX+SDUucm1CGLSEhNjPbp6OB+/shGM5bpjEKuV5NqI5ukfQn2FpxKEyArm0NZTgtX7lNIJpwiCFnezXUdrplzxdSyiKfGDy0Qtf27712E/4ofTFFvgW02HZ4RG+ct5R+LhzLf2u1OKn+0iaZQClfGtAX87yDSLznb83p0cCLGVcLHeXRQcOrRG9e56VF4GgpfjxeJ75E+yCsgSyAyUxLjgRvqCcBbBJeApWipb5WyQr/bl1fDedeCvrngJI7YuI9ugvtR5N8FatTiqWVle1akmTP54mD4xFlXqDSBZSwTMubTPOu8pqV0Ejz6XXm0Kj1icqpAzR+RN2Zf7EhMDwyIpzwmicYkRyZ89MJca7acboNu1nK4NSRHQYZGHO1IA0jDfYDaJr89EgVryJGYHl2Jw5Du0z6B+2YaVGPGwmBshVE85UwjzBm7tcGlrIZFoU53mppflQiIuefxlcfjKL6OXzcWFsIrbVRx58zbtzUHMONeKYKeoc2FkBFGt37/6UtQydmbBQGIfg9n3cAE2RYWd4CubbWazJ4U
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8412.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099006)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWwzVThtNjdCQkxUTWc2SFhweEt1M21POEE1SjhEMVhYLzZxNUJSMWVEUDhL?=
 =?utf-8?B?ejJTUlY2a1M2M0xuYkk5SDFad3V5Q0h6dm5MWGRTa3BWT3ZoOU9DSE9Ka2lq?=
 =?utf-8?B?YmdVMlBLSE5rUXZGVVpYZDR5WVlTSjl6TGJsMlhVendvSWIvZk4vUTltaUZM?=
 =?utf-8?B?WEx1UXh2K2toVWVKYjlaSUxPMVN2SmIxQlBBaGFnNWcxOGsrUTV1TDVGSHkv?=
 =?utf-8?B?TUtJczhIMWd4eGpiYk1NalpVN2FZV3lab2RsYUlnbTlBNzEzaUxjVzhMY29j?=
 =?utf-8?B?VXMveUlsUTlXWEZYRmxTQWxmd1dPZUE2b05pd3FaZDFYSWZXdU1EYkV4UGky?=
 =?utf-8?B?NnVHa0Q1elpSUkt1VmxVcjJJdlQ3UTZ1MWpLQStSbkNURmo4TnhNa0JDOUxl?=
 =?utf-8?B?ZDdRSFJzMXZCZzV2elpQaEI0a25vT2dONGQwOWpZVXpoZVFSUjFsZXBkWHJY?=
 =?utf-8?B?eThwMmZSY1FZSkdQN0lkWG9MWkUyUW9haUgvL2lGb3JISW9KeER3Sng0ZkJG?=
 =?utf-8?B?M0lFdysxK1Bka3FQYzRyWDhxMVZQTGdMQS9kaUdTc0FuL1Jua3h6bmNYZEoz?=
 =?utf-8?B?Yzd4NW43akNmN1JBSzkwZFRqMy90RWxWem9vekhDS1Y5d1ZUVG1WUlp6ekNM?=
 =?utf-8?B?eUVOS1FhRVBrNndiN1VMUlRrN2FxTnJtL1BHMlBlOE5zSHJEamtDamNBeE9m?=
 =?utf-8?B?bThqVTh5QTFkYXFtZWFnTWRLWDhpd1UrSHZTUWFmKzhKZEM4VnprVENkQ3ZT?=
 =?utf-8?B?OWFSRGgzYmNEeExTZHdHc3ZPblMrMHpteFVTT3RxWGx1VlNSc3p2Zytidnor?=
 =?utf-8?B?dG5iK251dlNwZEhzL0xmUXRjUUR5TDBqRUNvY3F1TFZ3Ris3Yzg0N1BTVEpp?=
 =?utf-8?B?cVZRSmU0R0hiS2ZMVEVQakQxQnp2YzFod1E1K2JXaytoTlczVTNXeXp6S1dB?=
 =?utf-8?B?ZFd0NGh4WUVGRmtXKzFjMllkRFNnbjR5Ti9oYVk0b1BUbCswRG1nMFFUOUdP?=
 =?utf-8?B?bXNDUjV1VS82dTQ0SnZ2MGladjBXb09EWDYremQrdzc5Z2VWNzdvYSttdTE0?=
 =?utf-8?B?U1lQM3JGUFRSTHR0VUhhK2hWV1QxcUhrNlZoTmtFNVByUm1Vdkw3QThZc1lr?=
 =?utf-8?B?eVhHK2ZGQTlyQnRSeVFDR2toKzRleHJCZnZqY0NabDE0bjg1WGoxUTByaXdI?=
 =?utf-8?B?WjFYQ24xZ1BCcE1hOURNMlNWb1BHSjlwejVZdlhpM1ZoZTk3aW1sdDJVYUQr?=
 =?utf-8?B?ZW9ESmhFK1VRTzRPdXhnL1EycjJhdCtIc3d5eENWeHhtTGZDTXozcWxtM0tx?=
 =?utf-8?B?S3dNZitqYjJxcWx6MWRTamNaUmxybjM5SCsybEhnU1pOSFl4QkovaGQ0VDJ4?=
 =?utf-8?B?K0NFYjBBT0M4TkpNUWpaRXZacUFGWlNFazB6VkxXbndyeENGYTlLdFZLRmNQ?=
 =?utf-8?B?R1dxeHJ3L0x2QzFJRWhYTVdWV09xTVprK3V2V1ZxcTNmVzgvSURXanlFV3BR?=
 =?utf-8?B?V2tJUFpvWUtGUnZseHZZZHp1czFFRnhHSTllOWUwRGU4alZTanNsaGd6OWQw?=
 =?utf-8?B?OTRySzZhaW1YYk5NVEZlZUtUaFd3TGcxekZDQjVnRm9jVmduK0h6NlRLdTM2?=
 =?utf-8?B?TStFS2lGM2U4REhSYkY2Q0FSb0JqQ2JCWEtwTkxqbXduOVZNemJjdzl3RGg4?=
 =?utf-8?B?SlE3QkFvTFlyNU9KWWVBVkVMZFhpWkZ0KzNqeWdIMVlMazdITU0vQi85eGI1?=
 =?utf-8?B?VGtna09qSHZTbk5UUGE5eWRQNkpkT1BOYWFQUWVDQjF6aFdPL0wycUxhdCtZ?=
 =?utf-8?B?MGQ0Tkg0a05PdEN1aHlrSlNxS2gwVWEzMDhRdVJtNGtQcFJ1NlQ5R3hnUmp4?=
 =?utf-8?B?bTQzbVF2TC9JTHptQjdUOWdWZnF2MU95MlJTWU45RzFVK2ZvMnZ4b3pMVVI3?=
 =?utf-8?B?QzhGbUR2V3BTTk9ENEMwbm00cnZ1dmppMVlmQ3ZTaTY3N3NWMWF6dWtmaEtk?=
 =?utf-8?B?a2JEblRab01URTlJZEFCcExvSHNXYXRQSkdrRFhXUENrckJmd0xrbkZOa0tY?=
 =?utf-8?B?TnovbnVESVV5WEJqV29SbmtNUnVMSUFjckhFa0lYQzNPT2tvNit6UDlYZ2VP?=
 =?utf-8?B?ZkVvV0dLbHVHQTkvaVpUd2RVRjN3c05rZnNXclNJV2hQUTNLUlJVRzZPdkdF?=
 =?utf-8?B?MWdVR2FyMUtHWUVmK01tc0JTSkN2L2hlekkwampmZXhKUmtRUVpna3o2Qjl5?=
 =?utf-8?B?V2Z3YlEwNE9nUGt4QXJGNis4WnJQLzBoSGF3MElzVmhVVGtRckp2K2lHZlp5?=
 =?utf-8?B?cE5OZ0JGRW4wdFQ4MWJNV01jd2R2b25jc2tSY2d6RTQvSnN3aGJMdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11D9100BF1BE174B96A3E14C92BE211C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f687b39f-f213-4c4a-ec71-08dec32f6e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:22:41.9629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fW7cQmSFtSyniudcGtAhvikOG9iNQwmlhXwKzhI22qAKQEMgRMtx4py3X9jsLy+uZAh3i+L7ulUve+0c6ek9/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE

T24gRnJpLCAyMDI2LTA2LTA1IGF0IDEwOjA3ICswODAwLCBEYXdlaSBGZW5nIHdyb3RlOg0KPiDC
oAlpZiAoYmwpIHsNCj4gwqAJCW52a21fZmlybXdhcmVfcHV0KGJsb2IpOw0KPiArCQlibG9iID0g
TlVMTDsNCj4gwqANCg0KSSB0aGluayBpdCB3b3VsZCBiZSBjbGVhbmVyIHRvIGluc3RlYWQgZGVs
ZXRlIHRoaXMgbnZrbV9maXJtd2FyZV9wdXQoYmxvYikgY2FsbCBoZXJlLCBhbmQganVzdCByZWx5
DQpvbiB0aGUgY2FsbCB0byBudmttX2Zpcm13YXJlX3B1dCgpIGF0IHRoZSBlbmQgb2YgbnZrbV9m
YWxjb25fZndfY3Rvcl9ocygpLiAgVGhlbiB5b3Ugd29uJ3QgbmVlZA0KImJsb2IgPSBOVUxMIi4N
Cg==
