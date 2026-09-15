Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF8486408;
	Tue, 15 Sep 2026 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476426; cv=fail; b=kRTqG4rkgqjBIO9oUpbb9xbOEQjR0UVbu7kFhFeMkQx3AGHo1usRyKe5//qCJgPfFO/I8j0foXGtsJ5B/P1Gy3ATpHjjBkLdnGBS8FT9+SfL/CW9UCnc7U+k4dbwqmVKFI1LDCjn28Ly35j5uKF/Hm3sUp64MwjaM5RHGiOQypo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476426; c=relaxed/simple;
	bh=TSlk1F7cZOVQp3n8I0cfszpUq40qV9jaOGRd+d+rP5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c6jYDVSr2SV88i3A7kpK9Ucc1C4rtbPHNlXcXg8T8SGWB6rs4ysRsFx3e6772gI2qSzZmq8f35I6neJSkafiP5akI9R/aONYkovyZqqvvIZwht5s//czvnGANM/EK19fKR7WL2fGmFMSyw3YmDg8wQGu+BUxgoIW0D+L15jDafU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aG/OZYQk; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aG/OZYQk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCHTs0ShCgAU8uWopwvlXsJwcz3JP5z1f8JFKLh9ktLNSDWKqhVJqB8BQAjspYmF5PJSpY7FO6ddUG/pIROLxLhAWVayuzbkMhbaHTEwO17swcli3OUInX8NLWUFFehKdY0PvznDEoOKWQZj2q2TA3qjJOuVlFEhjo8dbZCC1bEYIwRyyRZeVr1yRA/9LdheAvtRu8nNBE0ymI1Y0IYYopwrrtY4gsVwuQbM2RkxCA6zDBlUtdZxCzEF0Vdytg+kDlQpU3WZdRmj0RRmLzBB9l6wpGm9nQoKuRAi43PDLwO2ukKi2UohuEHDu9tvCXwaf9pR70UMNTAlpfS9EpRDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSlk1F7cZOVQp3n8I0cfszpUq40qV9jaOGRd+d+rP5I=;
 b=WwUnDQb5tkbtEwbmeYIf4QufsgYgKuh2sQPBCIGvsvvgXJULhfIkSj1fWJNWycvOg2fDCBYWoE8Dn9hQ19+v2hpytD6WY01OypfmnfMonDHMQmlBJdWSr9TSipFz5qSdXrnFE2HOvjY072GdkoG5CQ90aCo4/ClAP8DE2xeqFC5zVTHMoVWXIn77DfXdqdrH++iSJYlSnwBX6YXla8WVHIXlf8Nq5UzHdHc46hpNhbQGWRJ8fp9stfJsB15rSZMa2CCFiB+ecSFTQENjoDTNG8Jef6eH4Vg3zfkJF4wvsbnc2OBV7yHPWmVYKdQtGQKrXvRF5yrMdetopMkDqRKvIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSlk1F7cZOVQp3n8I0cfszpUq40qV9jaOGRd+d+rP5I=;
 b=aG/OZYQkv5tY/7HkGYnGXLP7v4PgM663/qmvcm3KsbVjS1gHq9c4HQvOI+DOkkJ4avISj747KzkKcSteJa1wjLu9Fthl5BEpezk/Wn/tT3EYtG/4c4HVUsDCznbmSceDaTOg6+2aUmpf2HP60owlRmW/tDs4ZUvCGikpVx6UTWNaTbFQq0z7h9YvqFK63kcNaF0Ee1ixIqngk/aQq/+z1uCm/j1S4SBGHrTh6YWHi7MFeFIDYois7nFmo59P27100pJgZ7uaa90zgxvU6QhpUfFwI+6/BGCpDctopwHz3zO7DTpjPX1rzUohHrYUZCv0z/OER5vD4nm1oY7g3/jZpQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAXPR10MB5406.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 12:47:00 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 12:47:00 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "hauke@hauke-m.de" <hauke@hauke-m.de>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "olek2@wp.pl" <olek2@wp.pl>,
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "john@phrozen.org"
	<john@phrozen.org>, "daniel@makrotopia.org" <daniel@makrotopia.org>
Subject: Re: [PATCH] net: phy: intel-xway: workaround 100BASE-TX Link-Up issue
Thread-Topic: [PATCH] net: phy: intel-xway: workaround 100BASE-TX Link-Up
 issue
Thread-Index: AQHdRPCKWUkgfxb0/E+V52VOySh8a7bPk+8AgAACyQA=
Date: Tue, 15 Sep 2026 12:47:00 +0000
Message-ID: <2260984048d0c6a6e779a245830e0cc03bd002ea.camel@siemens.com>
References: <20260915085921.1354706-1-alexander.sverdlin@siemens.com>
	 <8768cdd3-e65f-4e74-9700-c21d642fa15d@lunn.ch>
In-Reply-To: <8768cdd3-e65f-4e74-9700-c21d642fa15d@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAXPR10MB5406:EE_
x-ms-office365-filtering-correlation-id: ce8466ed-4143-4c43-a099-08df13276f9b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|10086099003|18092099006|18002099003|22082099003|55112099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 Z4pAl5ZyGNXA2X3l3Z9qc6IdLS00tJ08I5uHPIqQX1IsbQFG+g/yQbYYffcApAtGrQjYJ8s8jTvAFbxo5tBPML6vVe3bA6gouO0cO1+czWoMG0btuoYzqKP6G4MjSCImMXF+YVwrRo+rUeeqM5ao2b9fWpTX/eJbj13z6KxpB0up6jJKMhOVkV15L8kMXBkjsDYKgLb3XVtN9qeLszN0On+qJjWLTKJQwuvI3Sai6kCLzVkzK+LGGeOFXzXWr8fkxbBAUlPwvMtypq2QvwpNdxD7CfnmkaWK5VRb2fkp31MCxkaC6PIb3h6hKHZIyeih4PeckODx00mJPlfnHIT95yaYKoUuLcjQjHr/qG5LPC/KKH7xQs1plEiTCmgj68G7O6gvIH0+Vp4pkH6SnzjpKrJFieJQmcIg5wWsZq/RI8mI/hVh/HklZMdAkK0tsWm4aFBFX8oAy+vMiksWXxKK3z17DrAtEiBTkH1X0owLulTyFeMTNnTNsJG6Rlb4V+5WMRljFPea3OhjWlf7OuhLEqoPSJGNlnGdUOeT5OkbgVGMUq1Zczz4k8VgizW6xBJ3b3J5MOceBXLqF2bQijOZUyVKRdbV7ObqZd9EW/RN4hwC9HoUpQwriuGUJe1YEnPXm7/PNdD2O9VdbrizorXYR5+RipO5qn4Qwb95/TiVzu4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(10086099003)(18092099006)(18002099003)(22082099003)(55112099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nm5jUWFvREZ0QXpQdk5kSkw1MXJ0ZDlOMVNiNmhCODJmajBvWXhHNnFZTTVm?=
 =?utf-8?B?OVhwWnBiTUFYR0VLQWt0MmxYNm0rd1JEcGVLZk53cW9rNXgzTjBidVhZa0Y1?=
 =?utf-8?B?a0dtcGU2dU9waDFRNG1zN3lhVGZpWURTU1A3ejJJdnlVRUxRWldob29Kb3ZF?=
 =?utf-8?B?Qll0dys3S3U4RkU5aGJlc3BDcWQzd2kwMDBHT1dqNWZxckxISDljckFPd1JZ?=
 =?utf-8?B?aHVmZ01STS9DWXFPZXNxNkVKK0dqNXc2d3V0b0VvaFVGMjFxS2ZwSWdWRGwx?=
 =?utf-8?B?dzFzaTM5VmZGdTJiK0VNMmhaTmJtT0o4T1Y2QWRMWEpTM2hWei8rOHVWbnRK?=
 =?utf-8?B?YW40aFFKN2NKT1oyVjN4cVBQN0FWT2dGS0VnODZ3RVdlcDluV21yZkZ4b2hC?=
 =?utf-8?B?emp2cjFabkxIamFwSTNHQys0YU1lZ29NU2gxTllRMVd4L0VHS3Q1MXZSMnhN?=
 =?utf-8?B?UjZ1eDdRTlVRTFM4RSszU0JqbFIwaTFITzU5R0FhS1dpbFZCeG9uREY3ZlVH?=
 =?utf-8?B?cVJhUTR0dlB1QmJrWkk3R3NabnB5ejYyOXQ0cnFrOFE0WTN2VE1teURlQldZ?=
 =?utf-8?B?Qk4zOHJzeWE5N1BtM0RsTGNxbmgrNmlNc05Da202aDg1R1djODNQSytXWlI5?=
 =?utf-8?B?dkFJbkFCbGIyQ2ZWSHYrcnpXd0M1UllyRnNiUXB4SlJ3Q1ZhOFZQUzVEMXlv?=
 =?utf-8?B?RHh1bTJmS3p6ejdIK2ZVcmc3cDVMc3RSZlVibHErQlQ1N2RQd0Q1dGt4eUlu?=
 =?utf-8?B?bVdVRXF0bndSalR5UllXaWp2STA1UlJmM1FzdzhVZGgrYmgwV2pZQ3NHV0lH?=
 =?utf-8?B?bUs5c1ZlRmdYYkhhcUx3MmRmZlc5aHhrR2p6YnBVSmUyRjVuaFFPN1RpMHZ0?=
 =?utf-8?B?N0gyZVJLek9IRWdxOENhVk5zZXpIbEVmSlFWaFVSNHluMEN5ditSZXJKVVBI?=
 =?utf-8?B?b1Y3TXQrMTZJSU0xYmdYV2M4Y1V0dk5GejJGOHNiRXJ5ZkNENE5JaXMzUEpK?=
 =?utf-8?B?RHZVa2YrOFF2a1NRb05TcEdjM05FQkh5NzI5MkhyeFBGNWVGbVMreC9rRUVj?=
 =?utf-8?B?NjVlTnc3b3FPeEIzQ091SmdjTmZQRnFzWGljM09iK3NtY1RMMTI5ZlhmT281?=
 =?utf-8?B?ZFpSYXhaMXVSSDJ2OU1GZDVmNG13YlF1eUJ1VEpyZnRvQTJZTEljZVBDMEFo?=
 =?utf-8?B?amcxNEp3bTVoMXNCTnBSZ2o3Z2gwUzIzdGg2U3FKYjdtUXhxV1ppYzMzK3la?=
 =?utf-8?B?NTl4QUR2VUZ5emhYMkgxMUkyVDdBVVQ4Z2NudnZaU3VlYWpHM2RqRnllL2Zm?=
 =?utf-8?B?SGNkREhWbXkyV2ltUmVOdkdOT21OdmFGS2haOU5YamZBR3NEbHBOWW9WMEV6?=
 =?utf-8?B?cnE0QStxdHMvczMyUVgzeFQzYldDaUtHazdMRlFpYllIclVtYVhrRm5xVStT?=
 =?utf-8?B?SmVFQlJmNysvcndVUDZjZ2FOQ01PNExYU3ExWnp0eUpZTXZXektwT3hqYzFD?=
 =?utf-8?B?c0tBYlNsTk9tZDA2TXZLVUNQYVdDWG1FUmUvaHhFZmxVY0FMNXF4UGI3aCtB?=
 =?utf-8?B?bDVVNXpwZkVEejVxUjhJNTZIT2d2WHJ2dmhlK1ZVcmJXYytmeEJLa2RQeFNt?=
 =?utf-8?B?dFNnSko4eFZxUHEwZWRYY3Vwc2xGVEVQYWlDd2dEdHNyQ2Vxd2xJa1gxSjB4?=
 =?utf-8?B?K0tkbzhiNnV4SnZYVERkaDNVenp5WWZLNWlSRXVxVjA4aDdic0F4Y1h5YUZF?=
 =?utf-8?B?dmtJZjRqd2g2OGpmRGxPMWxMeUgvQUxXS0tVZFA2bEFzNmRNdE5UcHdnREpM?=
 =?utf-8?B?cyszaEhFZnNxK0llbGpmcks2ZzJTRkhKWDUwWjRFZmZKZ0FkTktiZFhmRU45?=
 =?utf-8?B?YzFoaHY2bEdqMVZhUlAyT3BPSU1VcFBVemNmNXZwOGc3ZjlwWTdQQnF5dWhs?=
 =?utf-8?B?b2tiYWtaMFJSWjNNRld6WUxHT3JjYXZpdFhXSE9NV0NIdkdRVDhsakhWQXNO?=
 =?utf-8?B?SW9wTWV0WHJYazVDcUtzc0dBKzJSdlBacWxxc3Y3ZHdLbnU3ODBYbUtWQ0VZ?=
 =?utf-8?B?dm5hQTdKRCtRUTRwall1ZElnUWNOUlhpb3MrUkdLeDNwK2ZKSDdvbU9aK1BR?=
 =?utf-8?B?ZG4vR0JTRk9xQ1plbEF3VVpuOFpFREZBeStsRXFkQzE2dGpiSGpMb2UwOFBO?=
 =?utf-8?B?YlJLSDEvUGJOZVgxM0xnbWdoVE5LUGVNYXBXak1ZU3ZSYVduOXdlWUY2QitN?=
 =?utf-8?B?dy9Vdi9GVzkyTDVIZVFob3RHa2N6dzBlWEVvNFBaUkcrRHNETkdQVisvOVRk?=
 =?utf-8?B?MlJKYWp5d2pDTkE0NFR6T2M1b0NVMGExdUZtNkI3NUduUG5sSnpMbmsxZkZl?=
 =?utf-8?Q?L0R4fyJqwGhnPRDc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DCD3B3F9CD695449200ED4271916584@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8466ed-4143-4c43-a099-08df13276f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 12:47:00.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFiXIs/ECZ2PrZb+Si6du7FKtz52Y4oMmCVgPoVyrj5o1z/pvyLeemqaOO05a+CsXr/f0pv/JkjjhYoDjfoe4v8/rp9jdzTY6ZiNgxCn95I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5406

VGhhbmtzIGZvciB0aGUgdGltZWx5IGZlZWRiYWNrLCBBbmRyZXchDQoNCk9uIFR1ZSwgMjAyNi0w
OS0xNSBhdCAxNDozNyArMDIwMCwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+ID4gTWF4TGluZWFyIEdT
VzEyeC9HU1cxNHggRXRoZXJuZXQgU3dpdGNoIEVycmF0YSBTaGVldCBzdGF0ZXM6DQo+ID4gIkFu
IGlzc3VlIGhhcyBiZWVuIHNwb3JhZGljYWxseSBvYnNlcnZlZCBhZnRlciBkZXZpY2UgcG93ZXIt
b24gb24gdGhlIGZpcnN0DQo+ID4gbGluay11cCBhdHRlbXB0IGluIDEwMEJBU0UtVFggbW9kZSBy
ZXN1bHRpbmcgaW4gZWl0aGVyIHRoZSBsaW5rLXVwIHRha2luZyBhDQo+ID4gbG9uZyB0aW1lLCBv
ciBmYWlsaW5nIHRvIGxpbmstdXAgYWx0b2dldGhlci4uLg0KPiA+IA0KPiA+IFdvcmthcm91bmQ6
DQo+ID4gQWZ0ZXIgcG93ZXItb24sIGVuYWJsZSBDYWJsZSBEaWFnbm9zdGljIE1vZGUgZm9yIGFs
bCBwb3J0cyBhbmQgZGlzYWJsZQ0KPiA+IGl0Li4uIg0KPiA+IA0KPiA+IEltcGxlbWVudCB0aGUg
cHJvcG9zZWQgd29ya2Fyb3VuZCB1bmNvbmRpdGlvbmFsbHkgaW4gdGhlIEludGVsIFhXQVkgZHJp
dmVyDQo+ID4gKE1heExpbmVhciBHU1cxeHggc3dpdGNoZXMgaW5jb3Jwb3JhdGUgSW50ZWwgWFdB
WSBQSFlzKSBiZWNhdXNlIHRoZQ0KPiA+IGRpYWdub3N0aWMgYml0cyBoYXZlIHRoZSBzYW1lIG1l
YW5pbmcgZXZlbiBpbiBvbGRlciBpbnRlZ3JhbCBQSFlzIHN1Y2ggYXMNCj4gPiBHUFkxMTEvUEVG
NzA3MS9QSFkxMUcuIFNvIGl0J3Mgbm90IGNsZWFyIGhvdyB0byBkaXN0aW5ndWlzaCB0aGUgYWZm
ZWN0ZWQNCj4gPiBuZXdlciBpbnRlZ3JhdGVkIFBIWXMsIGJ1dCB0aGUgd29ya2Fyb3VuZCBzaG91
bGQgbm90IGh1cnQgdGhlIG9sZGVyIFBIWXMuDQo+ID4gDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gDQo+IFBsZWFzZSBzZXQgdGhlIFN1YmplY3Q6IGxpbmUgY29ycmVjdGx5IHRv
IGluZGljYXRlIG5ldCwgYW5kIGluY2x1ZGUgYQ0KPiBGaXhlczogdGFnLg0KPiANCj4gaHR0cHM6
Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9tYWludGFpbmVyLW5ldGRl
di5odG1sDQoNCldpbGwgZml4IGluIHYyLCBzb3JyeSBmb3IgdGhhdCENCg0KPiBPdXQgaWYgaW50
ZXJlc3QsIGlzIHRoZXJlIHN1ZmZpY2llbnQgZGV0YWlscyBpbiB0aGUgZGF0YSBzaGVldCB0bw0K
PiBpbXBsZW1lbnQgY2FibGUgZGlhZ25vc3RpY3M/DQoNCkknZCBzYXksIG5vLiBJIHNlZSBubyBk
ZXRhaWxzIG9uIGRldGVybWluaW5nIG9wZW4vc2hvcnQgY2lyY3VpdCBvciBjYWJsZQ0KbGVuZ3Ro
LCBldmVuIHRob3VnaCB0aGUgZGF0YXNoZWV0IGNsYWltcyB0aGUgZGV2aWNlIHN1cHBvcnRzIGl0
Lg0KDQpJJ3ZlIHRyaWVkIHRvIGFjdGl2YXRlIFN0YW5kYXJkIElFRUUgdGVzdCBwYXR0ZXJucyBp
biB0aGUgcGFzdCwgdGhvc2UNCnJlcXVpcmVkIGZvciBFdGhlcm5ldCBjb21wbGlhbmNlIHRlc3Qg
LS0gaXQgZGlkbid0IHdvcmsgb3V0IG9mIHRoZSBib3gNCmFuZCBJJ3ZlIGdvdCBubyBzdXBwb3J0
IG9uIGl0IGZyb20gdGhlIHZlbmRvci4NCg0KU2FtZSBzdG9yeSB3aXRoIHBhY2tldCBnZW5lcmF0
b3IuDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5j
b20NCg==
