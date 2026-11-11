Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794370769;
	b=StnN4eGavcfeKhfuHRrMfDTkjMlpGa49VUmhQycbfc/+BXmCS4AqParFa9W4AkpPRoFH
	 u4Lv4cm5+hChvVlTMYuD0TmJMz8L9hDZJ6Cro5n3QdhGFsxq4hY8kHyUyw5H3/ChPV68o
	 jp1BlPPEQ72ygCAOQcxXlY/emmtawV2kHznvoB3OPp3JblS/4TzuyKAL0qEQdrES+0aFy
	 XM3oxPwLPmHTIssANzQUP5TBhkgwiggqQZECDrYmJHDWJNvNuzZ0QCHNt32q+rTH7BOcr
	 dxlQJaY8n0cR/LnJt3aKBvu9EdVF14nBnSmC+G3Ev+G/6d9kN8RYMYSsinOEuUQSzUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370769;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6x3mjp1qkfjS39o9TZ+rNGdLZDJ/SnCqTCB73yuPQuk=;
	b=ajwAlvfE5XxKnQKEazBWvyg/+2bS80Qai1kLeMu2CZtNDugwIjjWDakumXR+TTrzxFqP
	 grBJKAW/v2svQ1XjNXq5aUgVmPiVbUBiwO7qRy8saxjI9r8BKsw63GOrI1mc+9b4fAeu6
	 BdLRpwZ3DvkKwb+bjE4V9TuguZptddb+PWWS2oaGjwCsSj8qQqzmu4qQgDt0BshZurYC4
	 2GT7c0wnyZFp8fFKM6yBBMNh2CVRD5SDovFYdgoQLtCWdQtK77+VIrJV0vmYd3iiVYCMD
	 QgMkAD/8G01hnnLtYOmQd4YP6wRk26FE3+BL4UK8tkG3GKlvDLqCpgtnLTNA6dI3ErA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=pubeBKNA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.46
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2C60A260B;
	Wed, 11 Nov 2026 04:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FE2C60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=pubeBKNA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pthMp+fC9OBB+A5GTqWHMux8LlcS6aNoPpxIzttPKyrOjDsicAva4AxgOV7wagjJ57Vbyq2z3OIdTtxjgECt4yTlqXphwVWSTIv+bUSlc6PEoc0tf6pRNdrmFqEaUEyMmMx6STFDakPdWaL0hTzFp/O2LfHhdpIn3ufoRjejO8yGhRx2FreYT73H0XgO8/jIBB/8OknWTJ+S9M8DfyEu0vKsoFxMqk0DJ7Gl6+x8egZ1JRh4xhVUeI6tvvWGP4031ZduGjr7DeCbrjmAx837Xf/p/klf9OP3zrMaojL/f8aPjxWREFBI9lli5Im8LHOiKZdTYEiwdqra1B6CcZgjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6x3mjp1qkfjS39o9TZ+rNGdLZDJ/SnCqTCB73yuPQuk=;
 b=zPQk6KfFKniwpBa1fk5ApaigXgxnPfFnqsEY+FngqfKq9cwk6yz4HVuBfeYX0HA+qOwXleUg/4OQ9qwZGAP6MKcam54LdyrVeCISCtrjvaNnRNbPiRp7hUfsfYmEoVnbuOVEh8QEHN2+va4J7KYyVxa/mkRkfJsW2NTeAFbSMIPSWtCZWfI5Ury/MvsZtIdj/6/NelKir5WIAgLAW5llIPjZ3VnQYTKzPmQIKPWmwhY/2u1IiGYsEib+jC2xV5QTnM/RzvZRnS2cbhKWYvPHY5QgSSTQ6EO7/PHbzERfeHdosPxpasVRWNxyHfwiyBiAN6X6gP/YyhVkD64ll0CiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x3mjp1qkfjS39o9TZ+rNGdLZDJ/SnCqTCB73yuPQuk=;
 b=pubeBKNAjJYzpeqhMsf30UBlh1uy7fcVxhr+61f1+CJX8U7OmCgIleR4UA531ZUZ7IYBQKdGbEmYJjN8ujv9MIUAgTNV3bkijFFn5fu9Q71wpF+CtR4IGfeZs2MwcOSvyWOg8csJLDN9tHyLdRPhFrifZ1cSnDilUNW60aeA1sKNWf12gglAKbiu0+VXZvOy6vrcXrOSib5TlcyjdwjaE+TqgWn0+NiJg9JDwXP2kOnEhkZD8v3ICAZXzhAhy4VvfAJYxjEQdRsoBPumi4Xj0nHGcx4oKypmc0XKs1z0sJjO3ftr6e9S/P9TAG49w7kSmiCoC8APNWVpxhYXGhAMjw==
Received: from DM8PR02MB8087.namprd02.prod.outlook.com (2603:10b6:8:1b::11) by
 SA1PR02MB8480.namprd02.prod.outlook.com (2603:10b6:806:1fb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.8; Wed, 11 Nov 2026 04:19:26 +0000
Received: from DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497]) by DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497%7]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 04:19:25 +0000
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: Matt Johnston <matt@codeconstruct.com.au>, "netdev-bot+sashiko@kernel.org"
	<netdev-bot+sashiko@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] mctp i2c: fix double free of midev on netdev
 register failure
Thread-Topic: [PATCH net v2] mctp i2c: fix double free of midev on netdev
 register failure
Thread-Index: AQHdZdVCHj7bYODww0an4KePwzs6t7cVyFYAgBKPedA=
Date: Wed, 11 Nov 2026 04:19:25 +0000
Message-ID:
 <DM8PR02MB8087B22F3FFB3A9561381BCF8E712@DM8PR02MB8087.namprd02.prod.outlook.com>
References: <20261027053715.1623087-1-kenny_hsieh@jabil.com>
 <179334949479.3134.2940952959452938540@kernel.org>
In-Reply-To: <179334949479.3134.2940952959452938540@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jabil.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8087:EE_|SA1PR02MB8480:EE_
x-ms-office365-filtering-correlation-id: f1fd314b-8e84-47e0-e667-08df3faaf88a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|261028144727099003|261022105027099003|261026121527099003|261026140227099003|56012099006|38070700021|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 7jLUAcQyl+D5yFgMBf5uO+r1SHjALcSZqOb6U44TKUjfsd43bqn7yG6fhzMQPWVa+pWXcODnhTacxKgVxM2mX0pfhgZCw+tFnKwtMFOvPtoYfh+etdJvas/tW9dV6/XwHhV7S15MpDWB2bqHWlp8JThJGOym5oqhQxmZMUQBgMfkvw6TPz23yI9c1eFT1FLRDcI2FxrdUj8MbI5XR7ICS3XQg8qquGT+Amy2JcX3sSqUqEWxQ6LZbH3vlr1qPoH/7UspntKzz2yTId5vDYYNdXwvEwF5lpmUVGjsyPCZw9V8P3XAMqCAR8g5sbg3DokKZYToQDSKwYpZVUx7/1ftlPY2HuEq6bGnQ5BTc794jHxcG9piZ6TTq29IEiVHU+7bujyiixFeG3o1m1snqN3txDVKv3hE0N/U3yyy8xD95zze3n1AVXM8VXY/pzbfRcpzUHeSmwWETY705AStfMdISrnDjl9Ify5GEvFjQkWoMbwXBHP9AYtCNVP1IcIc3YjyFU2VSF/bgzv5MUln5hWXX6Qd/GZiuAv8x/lHc8U6JWCKWK7mwPNjl/5v6A7WHb3GwR+3olW4cwbJM63G+Gk4d+1q1icH3LFdr36ReDdJLgd4l5qOKYUYAxFTnkf/iURTaHqU3nEQxByp8KgV3yvE1He4uFxf8HphB5kYeHuumelj/Ym83okt9GqboK3VbAr8eVoWyfez0Y+xWOg60PM/5w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8087.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(56012099006)(38070700021)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0ZKbFUrWDdNci9DbGYxaG82ZFlQckp6SVFvekIwS25qa2F3dmhNM3BGc0pJ?=
 =?utf-8?B?QnpQVDBZZkVEaTdrOTYyTnNGRHR2c24rSkhUZHNyQVdwbUNaejRWcFovZ0FF?=
 =?utf-8?B?L1ROdlB2d1lwUzJhcTh1Z2ZVNmJ3K3hmUE9TNlNockNxb2Rnemc0SUxjcElE?=
 =?utf-8?B?RDAvUk4yZGZzVGNsOU82dXZXamVXa2xGVEJrUXJaNjdoYVRtY1I5dEJ6VFBk?=
 =?utf-8?B?b1NGdVZVcXoxRU5EckVWK0tJRG4zQU00aU5jK05nQzExaWhXTExnVTBDeEpz?=
 =?utf-8?B?czB4Qnh3Z2Y3UkppbVhWaGF5OUtIQk83ZERlRStxdWwrUVpVWXp4Ym84eno1?=
 =?utf-8?B?MTExSllITlhEbG9TcHpFVlAzRVFTTXV2WEZUWjVzZUZiTXIrRlNsY2lCV0Jk?=
 =?utf-8?B?akpheFo4VlRFRFRQK1lpS09ONWg4RXJyemorRjVWMWwrdVRqN0lhWFZ4K2FO?=
 =?utf-8?B?UHNOR1NDSXMzNUNLK05DN1lxc25JVkxhcFVhVDRyclViTjZlbFBVYjlDMk1H?=
 =?utf-8?B?WEE2UWhUR3FlRmREYjdSOFR4bGFDTHlFL0FVVEFvbFJUR1QyQnBlOWwvd2Zj?=
 =?utf-8?B?c1Y0NVJzNThsL1dUM1JyWnVsWktZYW8yOVZoTFlMeXFRSmtaWTBVdGtNVmpm?=
 =?utf-8?B?aU5zQTZrUGdFTFUzUVNNeUR2UDNnYkdRNmZZVmNtTGtSdG0rZ1hvYzNaR1c3?=
 =?utf-8?B?V0YwLzdsMk94NXM5bU9DNGJGTGoyWGsrWksxTk1XdHdYaFpWVzBvNmhJYjBV?=
 =?utf-8?B?M1piYlFZM0tXaWlVOExGNWhSRzZmVEMzTUNHSkNhZ3h6UlJVRnBDQlllSUdF?=
 =?utf-8?B?QUVvWllnUlRWWXY2U0t5Rk5OYyt0WHN6cndZdnZkVFRVNmNGdnY2aDZ1NlQz?=
 =?utf-8?B?ZTJSNHdPOXlRcVllMG5YZVozeFpIVTBlVGhzTHFOZ0laTVNnanVZWHdmOTRT?=
 =?utf-8?B?NnVncjh6QWJYN1p5akhaQS9acFFXNXE1YkgrRlZNYjBKUU9MU1N1cys4NkY0?=
 =?utf-8?B?OXFKOU5Vci9WUER0djVxa2dVeDJJOWhwNWQrTytLY2N6UzNOL1hXTVczaUlx?=
 =?utf-8?B?eGFqYzBjU0Q5WWkvWUdxM09EWTFKMXBNQkFvODNGejZWbHlhTnN5dE1iY1lw?=
 =?utf-8?B?aUU4MG5hK0xhWWdadmhxRjE4aWN6TmhKdUxqMlJYK3JDa0JqWU9yYmF3ZjlV?=
 =?utf-8?B?NWZKZi8xODlCV3FDTjVyN0l3Mkg1dkhLM2w4N2xaNTdoNnFCSU9wRjlDOEZ3?=
 =?utf-8?B?ckxIODFKV2t2Tkp4Q2JIM1BFTzNqZlJpYnkyakw4VVk5YUU2bkNNR2VpL1h5?=
 =?utf-8?B?RXFYRUp5VmIzZTdKQm5pTkcrY2pMbDVnSENaanpYQ0ZwRmxjNTVRRnN2Q1Iy?=
 =?utf-8?B?RXNHUHZLYk8yeGlxM200WjBlSC9JREtOVkpveHZmRWFBYVNpUi83ZEhPVWs3?=
 =?utf-8?B?U3hORVpsM0VZeU5wcGlnVzEybldYVEZzMXpXMlVmekJYdWdkS1F4dlUvYXpJ?=
 =?utf-8?B?ZkRFa2VEMkV1aUR0OUlYZmdvZll4NmpGOFVCeEphNTNnQXQrZ3I5ZmxmbFIr?=
 =?utf-8?B?ZUtnWXd5aFQ0ZTFUN09uenhtVzNpUy9qK3lHUjV0N0gvQi9MOUZ6SklnblY4?=
 =?utf-8?B?ZGs2TVE3NVI4b3l2UDZuYnU5aVpvRkV0d1AzWk1QSmVGZERIVkYxMVN0R1lD?=
 =?utf-8?B?K2kyV2EwQ0k5Ymtkbm5uTjJ2Y3dBNG92aHFwNldFOTdMakRFZWtZVW1aV3R4?=
 =?utf-8?B?OWhlWmZHeWFJTFJwMi8vVEVuQWdrcXRyT0Y2Wm1UcEtrUEdzcGp2ZnFuY09t?=
 =?utf-8?B?R0JJUWJRYUJ1WWx2R0xJdklFQTFrZG5lYjN0WXR0OGhXbVhLMy9qK0pudWxm?=
 =?utf-8?B?MkZOaXZMMUc1aGZoTEIzWWFpck14dTIwNnNwRklzTGkvWTN5eDFJMkNzUHpm?=
 =?utf-8?B?RG04dWNDSnN6ei80eFVwMytWSE8zZVc1NU95WHR4NFlMZHVDZE04enJmOE1P?=
 =?utf-8?B?THBuM0JXdUVVNUlhelg5VlVvRGVteWdzRWluL0daWVBxSmZxWHJnQ0c5V0gz?=
 =?utf-8?B?Q0RJeTFMaXBFWnM0TUZFekFzSHZOT1dmQ2ZZb1dUSC8yWGFCWVRkcG5OWitD?=
 =?utf-8?B?d1JjMTJvWFpnaXB2aUcyblFyZ3p1Wm9IU2ZrcDJ2anV1OU5CTytUb25IU0hH?=
 =?utf-8?B?cGFyRjZoRU9aM2pHZ1ZjYkh3YjRVdHozRkxkZzdqamJDeC8yckcrUktkbjNv?=
 =?utf-8?B?RFVCR2h6aENDaTU1UEp4aEpIWTZhdjl3ckFFVEpOOW5wUWxzMFp0eHdzNFVX?=
 =?utf-8?B?ZXN1dHZIRERpSFJHQ2dXR2czNk81MnlaM2dJZTBWMnRJRWNYdUVtdz09?=
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
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8087.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fd314b-8e84-47e0-e667-08df3faaf88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 04:19:25.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPTpdnhgur0LvNie8UAitEfeONOxpmf2PtENnnOo8bg3x4zZ/ZCDBLsYmEQwomvKDkmB0S32ImWaoii6M14HCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8480

SGkgTWF0dCwNCg0KU2FzaGlrbyBmb3VuZCB0d28gcHJvYmxlbXMgaW4gdjIsIGFuZCBib3RoIGNv
bWUgZnJvbSByZW1vdmluZw0KbmRvX3VuaW5pdCwgc28gSSdkIGxpa2UgdG8gYnJpbmcgaXQgYmFj
ayBpbiB2MywganVzdCB3aXRob3V0IHRoZSBmcmVlDQp0aGlzIHRpbWUuDQoNCkl0IHR1cm5zIG91
dCBuZG9fdW5pbml0IHdhcyBhbHNvIGRyb3BwaW5nIHNlbCBhbmQgZW1wdHlpbmcgdHhfcXVldWUs
DQphbmQgaXQncyB0aGUgb25seSBob29rIHRoZSBjb3JlIGNhbGxzIGFmdGVyIGRldl9jbG9zZSgp
IGJ1dCBiZWZvcmUNCndhaXRpbmcgZm9yIHRoZSBsYXN0IG5ldGRldiByZWYuIElmIE5FVERFVl9S
RUdJU1RFUiBmYWlscywgc2VsJ3MgcmVmIGlzDQpuZXZlciBkcm9wcGVkIGFuZCByZWdpc3RlciBo
YW5ncy4gT24gYSBub3JtYWwgdW5yZWdpc3RlciwgYSBza2IgbGVmdCBpbg0KdHhfcXVldWUgY2Fu
IGtlZXAgdGhlIG5ldGRldiBwaW5uZWQuDQoNClNvIGluIHYzIG5kb191bmluaXQganVzdCBkcm9w
cyBzZWwgYW5kIGVtcHRpZXMgdHhfcXVldWUuIEJvdGggYXJlIGZpbmUNCnRvIHJ1biB0d2ljZSwg
c28gZnJlZWluZyBtaWRldiBhbmQgdGhlIHB1dF9kZXZpY2UoKXMgc3RpbGwgb25seSBoYXBwZW4N
CmluIG1jdHBfaTJjX21pZGV2X2ZyZWUoKSwgZnJvbSBtY3RwX2kyY191bnJlZ2lzdGVyKCkgbGlr
ZSB5b3Ugc3VnZ2VzdGVkLg0KDQpJIGRpZCBsb29rIGF0IGtlZXBpbmcgbmRvX3VuaW5pdCBvdXQu
IFRoYXQgd291bGQgbWVhbiBvbmx5IHBpY2tpbmcgc2VsDQphZnRlciBtY3RwX3JlZ2lzdGVyX25l
dGRldigpIHN1Y2NlZWRzLCBhbmQgY2FsbGluZyBuZXRpZl90eF9kaXNhYmxlKCkNCmJlZm9yZSBl
bXB0eWluZyB0eF9xdWV1ZSBpbiBtY3RwX2kyY191bnJlZ2lzdGVyKCkuIEl0IHdvcmtzIGFyb3Vu
ZCB0aGUNCmNvcmUncyBvcmRlcmluZyByYXRoZXIgdGhhbiB1c2luZyB0aGUgaG9vayBtZWFudCBm
b3IgaXQsIGFuZCBib3RoIGJpdHMNCm5lZWQgYSBjb21tZW50IHRvIGV4cGxhaW4gd2h5IHRoZXkn
cmUgdGhlcmUuIEl0IGFsc28gZG9lc24ndCBjb3ZlciB0aGUNCnVubG9jayBtYXJrZXIsIHdoaWNo
IHJlbGVhc2VfZmxvdygpIHN0aWxsIHF1ZXVlcyBhZnRlciB0aGUgcHVyZ2UuIFNvDQpJJ2QgcmF0
aGVyIGdvIHdpdGggbmRvX3VuaW5pdCwgYnV0IGhhcHB5IHRvIHN3aXRjaCBpZiB5b3UgcHJlZmVy
Lg0KDQpCUiwNCktlbm55DQoNCg0KVGhlIHByZS1leGlzdGluZyBvbmUgaXMgaW4gdGhlIG1jdHAg
Y29yZSByYXRoZXIgdGhhbiBtY3RwLWkyYywgc28gSSdsbA0KbGVhdmUgaXQgb3V0IG9mIHRoaXMg
Zml4Lg0KDQpwdy1ib3Q6IGNyDQo=
