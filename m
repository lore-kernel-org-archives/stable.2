Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794215143;
	b=Jz5R79KRwKbq9W+6H5n8m5if2IZmEJMkvc4fIDoICfr21Xq+d/2upLaA9qk2ENMm2ll7
	 oQaVC73ZikJUNO37DAKDGgZ2CM2em8xMFqMpLbINj04QPBVCBmM9ReXnaVg7x0I1m7owZ
	 oOfTgkJQ0ZmrOG+MEEbo1kq6iqAJU0kQSpJJAQcc5EjzV0DXIjE/HIrcnQUjmaXp9pFsi
	 2M2rxOGJNRZdrkUcUUcSitK+cV2wdixUF4WfXrxgXpckNagg2/8MLjEWWU6qvjPsR/dTG
	 py8tv2jW3vsvUAf7lp4tOv9MpdwDfel8U7HJx2ezQ08SrnDGZ/665Eq2cetXE6WPlRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215143;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WylHbpifQiQzxtVNJBuSfQIf9trTxA1PXe8NMw4j3Mo=;
	b=ZhR+dsGygb2f8UcYBVFC2LPlJg64vxodwuNUY5jjc7Y+Yny9RzYurc4W3tDuIrw5o8KM
	 RqrISfjdepg5WigmcPQR+Hdh2QjDaPz9i5MGZ2WzPMtsW8kFFNP14b3ZS52yAq5a1xiEj
	 GWqiCZzw2cVkqtNXKqbfyqyS4rYgefsbMwCkjl5LtDhgFoyiqLhwTEkQy2zMUXd4laIB6
	 v2eyUKD4ERxboTtlu18emiwCbbKT4LfbA5+9V2udig+8s0E3yRr9rSrGI89EowXkppKtg
	 78l7WxnAHE7RvY1Oz1+HoSQe9f3WCg8FK1hj4hTdSrhxvkhOydqzDH3DDhjn3ntSe8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=XEEQtNw9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.9
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012009.outbound.protection.outlook.com [52.103.23.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D3606A321;
	Mon,  9 Nov 2026 09:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D1D3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=XEEQtNw9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bS68sKaNsNyGsDXXykCQBoiNLe2ljwvYqpx4uc7mHY4ZU6oOl3NbwlrujMeGVMDEC5GUQ1KsDsChvmgGIIDBl0KZILNWwR/7vvrRKNYPd35uUDUa9Z/S1ABsPAogssJRY7TpqhhjwiqrQmELpwfFjJGD69wNFKSHqH0iUFopnr/HYGxeCvJeuzIPzL9MkLC3buP2eO1N2PGs4YiNG5M4+aO/B7o4xfgs++sMTZiEZRuIyKs/totlAklZK1k6uAJwUUzYClZh00ho/yObatWvLfa7gbZzp/597tvtXqo693qtCqoPCgEtkClSWawdMc3Xvv6TzfKgJdbQQtGFeX3FmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=WylHbpifQiQzxtVNJBuSfQIf9trTxA1PXe8NMw4j3Mo=;
 b=dLlbqGK9fZhDrIctCKHXvcnd+G8PGAhhCtdGujzAmIxOu9vsVOyBqONzDLPhSPVbJStqFzt6YZqR9gyVxRBkYjOVY7uqUTzyV0JZ1SOgtCrGkjA6yitLSzU58NO9dbO0x4rLETnmLsrojjDjB4H11Ctm07TwAaUns8oZc0+veEgxS30AoMcEzWMYTkWX0GH+q5UhB6mfDKpyc4NzUZTXJXBBbTksm4889hGxRztRXqhY8NclVsLfP0Rxd6PZRKAyboWIKAo8fNCJihPl5T2QxwUmDZ+TDZ6rurXDogyw6L4LRrLUIpMeIvYCC6OhlVP2sFuUPa1A6I6MLdv6SZFa4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WylHbpifQiQzxtVNJBuSfQIf9trTxA1PXe8NMw4j3Mo=;
 b=XEEQtNw9ZhJYXVM2pv19AZYQLBDS42eoKkQhcK0esPY/US2ZaM9NIGnCillF40kzmLL8P+8dezkljZM3j5rPKILmUaV/Ocg3QQkCw+ttK80MnivmubTFjF9Ql0qBTxVF5fbYH7Twh9iILIWM2N+nlyhMFU02dpzbTjwMkyQFb/DvriIZtyFGlg0craDqs99thWL8Y35WW0AqAChhj2penjyexXFHGhKet48SjYUIbedojAXKpRNZxZkDGzzHdd/kbVDolkJAa7c5Lg0EFrgyofdQ1luwmJv0xneD7ymMiZXSGcKtbA+pMlarwJNrC2UKtprTmBuvt517czjn1tWrMQ==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by IA3PR05MB10668.namprd05.prod.outlook.com
 (2603:10b6:208:536::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 09:05:40 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 09:05:40 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: Song Liu <song@kernel.org>
CC: Yu Kuai <yukuai@fygo.io>, Li Nan <magiclinan@didiglobal.com>, Xiao Ni
	<xiao@kernel.org>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 2/2] md/raid5: preserve active PPL log when removing a
 replacement
Thread-Topic: [PATCH 2/2] md/raid5: preserve active PPL log when removing a
 replacement
Thread-Index: AQHdcCl+q6EKlaBTK0KWyOwlHZkBMw==
Date: Mon, 9 Nov 2026 09:05:40 +0000
Message-ID:
 <4e31c3b1c402e1b80cfd027c3441684dfd1909a6.1794215128.git.x-professor@outlook.com>
References: <cover.1794215128.git.x-professor@outlook.com>
In-Reply-To: <cover.1794215128.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|IA3PR05MB10668:EE_
x-ms-office365-filtering-correlation-id: 2c15c35f-7f36-40c4-f874-08df3e40a0a2
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|38102599003|8062599012|19110799012|22091999003|24121999003|8060799015|15080799012|4140399003|24021099003|25010399006|31061999003|102099032|3412199025|440099028|18061999006|40105399003|26121999007;
x-microsoft-antispam-message-info:
 =?utf-8?B?cm9rQ3l4YmV1Y3dKd0pqVEJqVnJGVXpWNjBHWUFWa0JpdSttb3BQaldFZHpN?=
 =?utf-8?B?dzNua0V2S05udnBuVm9pSVF6RDgzbDlWU3dhdXpjWjE2S1hUVnQvOFBpbGVj?=
 =?utf-8?B?U20rdUhZRWswSWFJamZkdFpKQ0NHQmJWSmVNR3pZTEJQRWQvdDV5SzZQUkt2?=
 =?utf-8?B?bkRSUGlEZytsMUFhWjFCTjlJdUd5K28zdDFPaUM5QnlBYmZQMjE0ejVrRU16?=
 =?utf-8?B?RngxcldYc21IZkNRUW14U0xGODNwY094S3ZBTXNGdlpLNDlibGtKNGp3THVs?=
 =?utf-8?B?cEtEU29xOE5WZitnTDBNV0RHanNuNVdUTWlvVjBxdUNwaU9veE9mUVRLVE5r?=
 =?utf-8?B?ZGxlVk41RStaSWk2VldIZlY2UEVCYWlkd0VITG9CVTA2MkJraU5rdHNhM0t0?=
 =?utf-8?B?MHJSK0JyOEcvbEp4MDByR1o4eGVtZDRNcHVQRXhXZ1BoM29nRURTNDJ6TmQ1?=
 =?utf-8?B?TmdnbTFVWktMckl3Vks1MXpibFk3WWdUM0Y3ZStMRVo2cUpoaXJHVXNKQVVF?=
 =?utf-8?B?SnlTWkJFdlJ0Mk1tTlBxM3ZBTTRDN1E5NTlKNC8xNFQyWnRGUmphaFc3ajZp?=
 =?utf-8?B?UEs3TWxHdFF1czJabldvTWl2L2lvcmh0ODl6a0ZFMnlLblU1SnFlNXk5bGov?=
 =?utf-8?B?blJ4TGx4UUVWTTVrZXI2VWpEcy9USGVqdGhlM2o0S0FWZzYxSHJyQU1oNlly?=
 =?utf-8?B?MFBDWk16L3Evd0xZMFhrWjFGTlJTa1pnL05HUHVUSXo5cU9SNlVXQm5OelFr?=
 =?utf-8?B?eWxaVElmVjBRM1BlQ0M3QWoxQmg0OUZKUThDdHBHaWtneHJvYzhaVTdkSlNi?=
 =?utf-8?B?RmR1QlVoeGRiN0xxRGV5TEVaa2ZyUTd1VG8veVhaY2hHYmhGQ3hwRGxMa0lW?=
 =?utf-8?B?b1BNdU9WWnVKdUhKaDNMbVFwaTh6aXArZ21RV05mU3piMlNKT2RMVk1mNk9R?=
 =?utf-8?B?MEh0K1VhUUtsY0JTSWx5b2wxS2xIZnZGRFd5ZTZ2N2xvSFFoS3BPWDlZNDRJ?=
 =?utf-8?B?Q3Y4Ulppd3h6VFVuVzBINmdxSDRjaUc4dlkvWGlnWVdURUZ2Qy9ucGh6cDdX?=
 =?utf-8?B?MVgvbWpXdm5jbG5nNW9oYW1Kd0E3SGxMTUs0d2dlV1N4VGFUMGtCeVFsT3pM?=
 =?utf-8?B?WlJqT1ZjYjNGUHZQN2JteEhhdXVBNEhKNnZXL044RENXSVN1NjNRaFVsNS9K?=
 =?utf-8?B?ZU02K2RiVU5uUURzU016d2RsazZMWW4yNTZoTUU1aGFNWWlzVG5xcHV3WVMy?=
 =?utf-8?B?WG5NZHpuaSttcy9saGExZGFBcmJqNktvRjdCOUJwT1ByaW9HblNxc0VRang4?=
 =?utf-8?B?YlMwc21pQmFOcmlVdHU2N2VVTDA1YjdKRE4zMHRJRVpzS2J5YndkYlZaVVRo?=
 =?utf-8?B?K2p2RDNXNFh1bk5hWHBSUTlHVk1PTng3TkJ0ZHF6WnAzbkttSlpoOFZrSStn?=
 =?utf-8?B?NG55MWxZMEwyMkszRzFlTS9SV2k5aVAyVndXNTJrMWJmODhCcjN0TW1IMWJz?=
 =?utf-8?Q?JiHHhE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVpsRDhITHl4VXRVbW84QzJycU90aXdseGpuNmJzSnRxcDVicEFLdy9kMEdh?=
 =?utf-8?B?M085cUIyaTdmNzEybXIwdENXcjRjcWFQZERDSUxTQ2Yrc3hObW54b3ZMNm0x?=
 =?utf-8?B?Mzg2dXVxVzdKR0RudHRyWmVDQUF4Z0Fqd29jS1BjWWRjZzk1VWhSM0kyWnpW?=
 =?utf-8?B?dXF2TGZZVllJMWZHVEFLZ2RDUXlNZkxkYisvU2JHNXJ1TmticlBmajdoYUQv?=
 =?utf-8?B?V0VIWnp1OWRFWWh1aURjaldXOVZTdUcrTWM2YTdPNDRUdS91TE9ScHBFbENG?=
 =?utf-8?B?M3NqeU54Z0RNRnJLTXVLd2tlVnhxakY0YUpVc2p4bzJtUVVjL29IWTFuY0JS?=
 =?utf-8?B?aVNjblRwaXZGUVNCSWxxVi8xU0tRK0FjM2xPVlJPNWZidFgxRy9sNEIrNUMw?=
 =?utf-8?B?a2l3MmdJczcraGl5Y1F6TEtmaUZiWXQwVkYrUk80M3BINkpkL1RiTU9leWVu?=
 =?utf-8?B?bU80YmhINHpFZU5MQ3RrU1I2L0llckVKaS9OYmZRVWFZM1Y1dEhJSC9zV0pC?=
 =?utf-8?B?VlpKak85c01LZlpCWkNCdzdnZy9lQVVBb2dJWDNmUXkrVk8zRUpXbTlNYVJF?=
 =?utf-8?B?bXFpMlVQRnF2Qkx3eTZUbWlpKzMvaklFTysyYVg2UHE4TDFsQ1hDeWFTS0Iv?=
 =?utf-8?B?UCtaMnNxbGxnclZ3Nm1jL2YxUTJQempFQzlDUnRVWldYQlJxU2lZc1N5L053?=
 =?utf-8?B?b2g3L1llN1p6NERnOWFYV2QvWkdVMFp6OVBlQ25yeldNbTArZktZOVV1Rzh2?=
 =?utf-8?B?a25rSHhCK1EzdFVWLzZIMFp2RjRxR1RPNGpYckVvdnQ5OUxKenZJc3pXa1M3?=
 =?utf-8?B?RUR0dmk5dXJlbE1rR0k3WHJ4b2hJWEtvbDNoOGNMZUdvSlBHWlpYdE84RjQy?=
 =?utf-8?B?c0lHQTJ0Njh6Umw5ZWl6MC9oMS9RY1UyMDJEZmZnT0lwdWVUb1B5YWF1NUQr?=
 =?utf-8?B?L2Q3bnRhbUZ1eEUzWDFuankvdWV5eTEwNHBLQjhMeCtkZ3ZidThpV0FVVUdO?=
 =?utf-8?B?djZwalZySzJTVjArRmpKWmNwR2lwRGRTZENLZExrS0lEUDZGTzFBWS9taDVF?=
 =?utf-8?B?anE4L1VieW5zakVlMGtlVEk4bDlUaVpUc1JLZ1R3bTkxd3dUeDFoaXRxMnJo?=
 =?utf-8?B?dmJpd0NybUVIdmFDMEZFRnZUd2J3R2V5Y3dZMWpRL1p4YTdpUmhnNE1LS2tr?=
 =?utf-8?B?T0pCNDl3alBZWXFlNnhHVXZKbVJvdzRNRXRwbHVTcnJwSW51S1JsdWI0U3l4?=
 =?utf-8?B?SXp5MG1ta0IzSU1venZCR0MrWml4c3ZLWU5VeUp2bFdEb0FUUk1yUEZzSTVY?=
 =?utf-8?B?b2swcU56Q2FVdnhBVGhmbzc1RElmQjUwS0gyMVFYUTByUCtjSHppNk1odXcv?=
 =?utf-8?B?VFFyT1UxcTZqTmxqSytkM2RrRmF0WXk3QmNQL2RlVnBXQkgvaTdrWmRzd1ZF?=
 =?utf-8?B?WXFUTjBRejlmMVp4T1dJeHRWM3FDZjUza3hMdDlFWmU5RGo0TWlwYjU5WGVE?=
 =?utf-8?B?Tnh5S1Y5SHpsRzJXZ1lkckoyekFBSVhyOWkvVm1lelBQWEJvaUoxeDhuUS8w?=
 =?utf-8?B?MVdrekZvVk1zR3hTbGZYMnhWVkR0Y3VBdXNEMUhyTzNlS0k2MHB6ZldQM1Ir?=
 =?utf-8?B?aFRjc3FGamlhb1pFSUtwemd1YTRyOUI0enQvRGs4Yk43WGZkL3ZNaHd5NTEz?=
 =?utf-8?B?WWFuUHJscUR2Z1ZSeGlYWDNPS0xibVk4N3MvRkI0YlYrSTdQbXJEQmN2d2Qx?=
 =?utf-8?B?bHpYZGd6VDJnSFFIKzM5cmlHcUFUTEF3V2dpaTI2MGgrU2k3UlJzVUdib2l3?=
 =?utf-8?B?WGxnWHdtSnpTbDhPQlJtaDJBSFNBQUxuOFhHUWp4Y3A2NVBhb2IzdEI2SFlr?=
 =?utf-8?Q?5HSBTc1y8eyzk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c15c35f-7f36-40c4-f874-08df3e40a0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 09:05:40.3570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR05MB10668

cmFpZDVfcmVtb3ZlX2Rpc2soKSBzZWxlY3RzIGVpdGhlciB0aGUgYWN0aXZlIG1lbWJlciBvciBp
dHMgcmVwbGFjZW1lbnQsCmJ1dCB0aGVuIGNsZWFycyB0aGUgc2xvdCBQUEwgbG9nIHJlZ2FyZGxl
c3Mgb2Ygd2hpY2ggZGV2aWNlIGlzIGJlaW5nCnJlbW92ZWQuIFJlbW92aW5nIGFuIHVucHJvbW90
ZWQgcmVwbGFjZW1lbnQgdGhlcmVmb3JlIHNldHMgbG9nLT5yZGV2IHRvCk5VTEwgZXZlbiB0aG91
Z2ggdGhlIGFjdGl2ZSBtZW1iZXIgcmVtYWlucyBpbiB0aGUgc2xvdC4KCnBwbF93cml0ZV9zdHJp
cGUoKSBzdWJzZXF1ZW50bHkgcmV0dXJucyAtRUFHQUlOIGZvciB0aGF0IHNsb3QsIHdoaWNoCmxl
dHMgb3BzX3J1bl9pbygpIGRpc3BhdGNoIHRoZSB3cml0ZXMgd2l0aG91dCBmaXJzdCByZWNvcmRp
bmcgdGhlbSBpbgpQUEwuCgpPbmx5IGNoYW5nZSB0aGUgUFBMIGxvZyB3aGVuIHRoZSBhY3RpdmUg
cmRldiBpcyByZW1vdmVkLiBLZWVwIGl0IGF0dGFjaGVkCnRvIHRoZSBhY3RpdmUgbWVtYmVyIHdo
aWxlIGFuIHVucHJvbW90ZWQgcmVwbGFjZW1lbnQgaXMgZGV0YWNoZWQuCgpGaXhlczogNjM1OGMy
MzlkODhjICgicmFpZDUtcHBsOiBzdXBwb3J0IGRpc2sgaG90IGFkZC9yZW1vdmUgd2l0aCBQUEwi
KQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBZaW5namllIFdhbmcg
PHgtcHJvZmVzc29yQG91dGxvb2suY29tPgotLS0KIGRyaXZlcnMvbWQvcmFpZDUuYyB8IDQgKyst
LQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL21kL3JhaWQ1LmMgYi9kcml2ZXJzL21kL3JhaWQ1LmMKaW5kZXggNDU1
ZTM2ZGRjZWVlLi4yZjRmZTQxNjExM2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbWQvcmFpZDUuYwor
KysgYi9kcml2ZXJzL21kL3JhaWQ1LmMKQEAgLTg0NzQsMTIgKzg0NzQsMTIgQEAgc3RhdGljIGlu
dCByYWlkNV9yZW1vdmVfZGlzayhzdHJ1Y3QgbWRkZXYgKm1kZGV2LCBzdHJ1Y3QgbWRfcmRldiAq
cmRldikKIAkJZXJyID0gLUVCVVNZOwogCQlnb3RvIGFib3J0OwogCX0KLQlXUklURV9PTkNFKCpy
ZGV2cCwgTlVMTCk7Ci0JaWYgKCFlcnIpIHsKKwlpZiAocmRldiA9PSBwLT5yZGV2KSB7CiAJCWVy
ciA9IGxvZ19tb2RpZnkoY29uZiwgcmRldiwgZmFsc2UpOwogCQlpZiAoZXJyKQogCQkJZ290byBh
Ym9ydDsKIAl9CisJV1JJVEVfT05DRSgqcmRldnAsIE5VTEwpOwogCiAJdG1wID0gcC0+cmVwbGFj
ZW1lbnQ7CiAJaWYgKHRtcCkgewotLSAKMi40My4wCgo=
