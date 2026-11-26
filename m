Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795706244;
	b=JqYGBPFCYgjPqIoPn16jwg6bKgxG26n8sIHBK3KroIKLH26yUZfAUXjw5cQ3hp5Thhe3
	 ac84TJkCP98nxfu2mENQQxqJstfvG9GNFQ/oYTTVU/9nWLDutlruwg5u6u1RpoQOPBBKC
	 5z1ReV/Cmak8ms6E8M9HCBnnc0qyUr5q5sOi3/zLT5t7H1QYnsxCPdm8QIz53Afm7F1q3
	 jO2CLQbjxTEVpkpgbfho4r2K+GUZVlb31ivVqw4Srf8uYFPVzrVGFn9ED7e8OMHDm3ahI
	 Rji9/YoNNRvDrwEQQA5WvF4HHFdnocAFGse29o/yPFHQATp1N+S0tx7jlIqKcv47PwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706244;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=X8KYyDYMaZiCFAZyvz+r6hrVVoTZ1AvlFxjx3t0TeSw=;
	b=BTaxy46lgDCxVD1erqEyitskQf/NQg8sFg3YjWCvjIauTv3G4RIokcBT/a7256/3klj0
	 obYKN7eEqsQUqw2/sKigp22bLLWvYXM9X2sReChXBD7xd/NIIMP1qXVwGWvl2PRPbifTD
	 Xl7DjP+25ABaMd+sXZHH5djNPL0icVH1qhU/6ZXaIzq2+8K2Y9EH/c/5B2M5pCCRmrb8H
	 3p1Hi6+jv86IbXawVH9nUrEbC0TB10mze6qwGZG828fDvQC60kMnEAMvLU8K37CdtfORD
	 VgJv7r9ueRgiEy9nu/eO7JpU0HDJMwmmOlL1MfPvP5eF1ptmgKHIi7JZkLARI/CHVEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="nkHqk/el";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.29
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332C606A326;
	Thu, 26 Nov 2026 15:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7332C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=nkHqk/el
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+T7WGJv+jcb0nNZMejd8q0yZVgWFoOoEsMzdwVTdFOUDs2LYOwBpMWgq6EOAkT6E4KA1kxyQn5RqHBMYNPWoglPub8a3PKFBVImHKLOJlNUtEPLzkdC9bD36ZoxRuNJkG/vKAJC7zg7+DNS+KJBKD9AzgeKR9jsr4c2sTonMvEB+xYwJkKxSE49VUpF2JPxM+UA5WcY+X2yxAWwLj8YSN6/Q/wIjQQ1RVo7RgCXbmOxuBy8TUnYK3cGHp4lx2NqH60us9VNPX2dymuSd9CcEK0aHqVC/7syFT9yeTvIeV3R2LBvmFIFKC0s+NMILT4qsWp4DG72H4ms+IUTUP+kpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8KYyDYMaZiCFAZyvz+r6hrVVoTZ1AvlFxjx3t0TeSw=;
 b=qivSfsQohn/6iuoSM04EpoSKBlniTZv6I3XYH75l64bs19DXntsCEscql2hYoc9JYWytRJYM/k1TOtNkWIbUUPwK7cceg/HyNP/58wBPRgv48wITWBv5ivygdTMyt1MafXp/W4Vbxc9HHcZBlczf1F3AIpQH/ZGviWtYblgAuolXHbQnZnqCkQqSW3tscUS7cwYSZO8v1QE7n5G+xkS24mh2VWcVVHblSPS7KmlqMzOpcbLLga9h9dcgAmFT7eHCf+C8Ka8VxgeJr7j1kbc8da/si6l5jPM1LR+hS31Ng2hLT/G+b1khFULd1BTnKFuhhUmfaF1dq675H6dGExO/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8KYyDYMaZiCFAZyvz+r6hrVVoTZ1AvlFxjx3t0TeSw=;
 b=nkHqk/elejSOX+U+vbtdfkMskHuiV/bunUNRL3LdhGsiLG47IpfOgpXfmlRgOFiHMVjtNugCh/BLUTAQ+lnQHX+bnHDtO3Abgmx3pxjxAssq/WmqOz9zGPSmfI7PrEbMLvw30SVCAMosUHQZ1CKXEtWeSmGMkXGO9NtMYaa7vFZr7FU2qNsjEgkod4v7SwSD6OPlVS02XD6B1ywHLFNjdj248m0bpF2DZOzKpqf5tGPV0wDvPnDglJk3JiNtM/CgTdSvF70m4rvoSOgjB3RJu9ODh0NN6ijA+HwnkVraDSXwd+Iq1THHLjk+9A4AA8EjoN8x8SnYwOIlSAb3OfCb0g==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3879.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Thu, 26 Nov
 2026 15:17:20 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:17:20 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "Haener, Michael" <michael.haener@siemens.com>, "ulfh@kernel.org"
	<ulfh@kernel.org>
CC: "ziniu.wang_1@nxp.com" <ziniu.wang_1@nxp.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "avri.altman@sandisk.com"
	<avri.altman@sandisk.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mmc: add ISSI IS22TF128G to fixed secure erase time
 quirk
Thread-Topic: [PATCH 1/2] mmc: add ISSI IS22TF128G to fixed secure erase time
 quirk
Thread-Index: AQHdfbk77oaGUG8kjUeoXGthMmQ6ZA==
Date: Thu, 26 Nov 2026 15:17:20 +0000
Message-ID: <27db5e2bb9ac77193c504517f8fd96e6f2b305bb.camel@siemens.com>
References: <20261111120759.100830-1-michael.haener@siemens.com>
	 <20261111120759.100830-2-michael.haener@siemens.com>
In-Reply-To: <20261111120759.100830-2-michael.haener@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-2.fc43) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3879:EE_
x-ms-office365-filtering-correlation-id: 2ef9d3b0-ec89-41c2-9e7f-08df4bd05daa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|4143699003|261009223027099003|22082099003|55112099003|18002099003|3023799007|10067099003|11063799006|56012099006|261026121527099003|261102123227099003|261022075727099003|261021121427099003|261022113327099003|38070700021;
x-microsoft-antispam-message-info:
 JGvpNBmIVU1feJ8Jbt71IFtj+NdNZrEoDJHms5An62h4guRS74y7AK4CWzI/xHAoFE0/FKeWGWnLJKmwDUc5dlRgRSO3/vaTYlnnAXDUPWK4zjiQqsdHL5crtEB33YaLegxqgvvNDaIlRuN0VNhPRlu6dNbu7MJ3N5AQJkzg1ry0um05mNRcujtu+kbXfDIYYxAnOLdEB8TUOqVPGia6qiM1l+zxKpugyUSWEAP2hrJuLOKxH7vSepWI3mTpyv8iGwagPssTLQdkDyA02Hp5jA4w7KZGE0WTNOajUEwaRdDRKO/XbGLzodbaj1xTvOKkTV0/WPw+ahMEFYklEGUHEk5oJd1e3poLOvcq9C7VXmTbDJHFt1iaC/4jPKZYT2b25OZTR9+yTTNXUjZvPVIX593W+ezuUWe8UzfszPXAdbkEW5zOMRRqeNhUc2UwJ+1snfj9Q0THijW7L6T15E8JPbZkFnIIEo2B9XxU34X+fp8ma00TfZRwTeBereqDItNOAfriRR7W8vRfrTDiePKnaDgbWquICfV/6qX8n0XqwBjVXamJ5B616XVcVNMI6b0qnKpcS2qJ726gQuiCeMU9tDQthqu8UWdmAqTsE1tWHCyrOgRt1UrQoEPBDexlag952ZRMyjEtcMSuVUgtjQxzzrVZtW0hVz8PaaT8b3N7mi0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(261009223027099003)(22082099003)(55112099003)(18002099003)(3023799007)(10067099003)(11063799006)(56012099006)(261026121527099003)(261102123227099003)(261022075727099003)(261021121427099003)(261022113327099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WG81M3g0Yk55YUptS3QyL1NmZjNJYnhlVHlOYWdoS2V2NEppdStUWXFhWVgx?=
 =?utf-8?B?OHV4TlhPSk5PdDFSa2VmUEJMYWR5VmxtYmlYT3YyT3VzRjJWcVQ2cXVtbllt?=
 =?utf-8?B?RVNVd2hwMEY0Snd4STU2SnlidnArRjhQSmdYT1FLWHJYTkVSMldHeXRzYWY3?=
 =?utf-8?B?UGlVdkpIWEZWalE2QTlncHlLemZRWjVMdmJRQjdaZ2N3T3B4d01abG5hMlZo?=
 =?utf-8?B?SHhWMU1qK1hycWRwUnZKeU40WGF3RENxUmZTd05ySm5BdUEweVAzR3VSTVFo?=
 =?utf-8?B?MFBkVEM3Q3NaWjhjTldJTHhzaE8rL2FXRTlsc21MS2ZwaENoeE41bkp4bHVs?=
 =?utf-8?B?anR1SzhHdExTRUM4em1sbUZmNnpwcWNybWhnaElHZThXODNQRk83RmIva3dC?=
 =?utf-8?B?eS85NWdTWWY2TzQ2OVp6aTdRL29QZEJkM00xTjkrYmVyeTBQTzZmcldoakFo?=
 =?utf-8?B?U0NQenZyZVQwYzZucmROQkVodHBCUUZKb2t2SHZpa2R0MkZrS1IzZWI2NEx4?=
 =?utf-8?B?NGRWZHVZM3FjQXlERklJaGs3QzFPQmtMODNOb09KL0x5THZMcGoyeTJMNWF3?=
 =?utf-8?B?eWdCS2F6WWVzb0dtaExoWS8rRWJ3MmpYbWltUTZXUkQ3MWZKNWNJaElJODhk?=
 =?utf-8?B?VDdTZ2orNnZwR0JkYUxDbjdHM1RZZUE2TjcrVEpUaTdJSjRWT253OTJlTnBY?=
 =?utf-8?B?WkRkeDBvWGo2Zmo1ZU9MakN3ZE9EaGVVeWVPTXVFdWlHcTNJSld1V2FVU3N1?=
 =?utf-8?B?Qyt2dUQwWUE5d1U2dFJ5b3NicGhtRUhncFp5UzZKLzdmRkRKVDBBaTR6aE5k?=
 =?utf-8?B?Rnd5VzBTcHhiYktQd2d2bjBhd1hpOU9vRUcrLzAzcmRMOHpWSFVWSVhxelFx?=
 =?utf-8?B?VE5LV05IZnUvZU9nL095QVViR2xPQjhjU1hBMk5nNkFrM2s1QXZzUDF2Qk11?=
 =?utf-8?B?a0ptOFFxTmZwMFZjaEVPVXQ3d0s2Y2FKcjdmSlFURi9yTkZyd1V5cmNxbzQ0?=
 =?utf-8?B?WlppdDJnZ09yd2tveTFRanFiUlg4eVF4QnY1cDBETUNHYVBXZDI1VElsclRL?=
 =?utf-8?B?dVRJMmlPaEdQT0JaNUR3dlhFeVFvbnVzakdUbEdsV3dINGZwTkdQS2pIYWlk?=
 =?utf-8?B?SjkzU1Joc08xTlpOQWNFcW9zOVQxRXZZRUR6NlhLblB3T1R3dSt5WUs4c2dY?=
 =?utf-8?B?dmJVRkZWWkZLbDRVMmdhUkRjNHlVQndhaE01VGxIZklxTEhWaEx3MUx1VWlt?=
 =?utf-8?B?cS96b2FJQk1mMHdwWWhtamdmd0paMnV6V0JIUVdVeEk5dENMU1hYVTE4UVR6?=
 =?utf-8?B?WnZMb0cwYTA1YjFRMVlSVmEwanhRcEw0aHQ2cFgyYjZ6enpQQTFUZ29BVjhB?=
 =?utf-8?B?c1pIQW9vaHZxRVhlZDhXRnMxUlJDdklXRHkzeml0YTlVelJoY3p5dmZoSi94?=
 =?utf-8?B?OVRWOXRidWk0S3RXRmhmbTNzeERGZHRLR3p2WndtS1BpdWwyUnRuejBPKytR?=
 =?utf-8?B?b3NUTWY2Q1JxZEF4U3JxQmIwbFhlSE1kUS9VMlpwZmlpMWZGYVdpVExTQ2NN?=
 =?utf-8?B?S3Y1blFnKzd2WFRpNkZpTnlTczhxM0RpQTZIZE9SUWMxVjVhby9PRzdzNGhW?=
 =?utf-8?B?d2t3UmtHQXYxeTgrT1dLSWFBdDVFSjBiekZ4b3hWd3VPM3VHUGxheHBwTmdQ?=
 =?utf-8?B?eDJVWVdMK05MOHFFOXNJaDI1RldDb0gyQmM3bDBFd3FOalJ6eXpLRWxJK0RE?=
 =?utf-8?B?YUdoMjhhbE1uOXlOWkdnNFExN01UQ2hncGdlbTR0QUp2NWRJRDFaYk9QS0hq?=
 =?utf-8?B?WmdGRGhWVEIxTU5EbkFmWUtmaFNFN1ZraHdOL0laV0FjSityMTJLN2hmcExv?=
 =?utf-8?B?ZjNDVWgxVUxLQ21uYm51RlVPNEdMMU13aEJtK1BkcXg5SlBFWUYxdkZZZXB1?=
 =?utf-8?B?bmJNNHhoU2hGVit5UlVReVVPOENtejluZzl3YnJmd2tzeFNUR1NKdEhBYW1I?=
 =?utf-8?B?MVdFY28ySWJ4cXhOWDQ2dkdkMXpLei9ZQ3M2TWwyS0NFT3I4RlFTbU45VHhW?=
 =?utf-8?B?MlRJdW00WmVoeWt0WUozOWdBY1B5RXl2OTd2T3JlaXc5WE03SksrSHE2d1FY?=
 =?utf-8?B?OE1PQ3hLRXkvNHl1SUlpMXlEcFdwUGg2aXIwcS9zdlVWbjNtU2pndXlkMm9r?=
 =?utf-8?B?UXNkMmN0STBZWHRTVThSVnNqbUlQV0JGa2RpTjF4d2dYR0J0dVhVSFlEMmJP?=
 =?utf-8?B?THZTK3ZHb0YwVlFsRkhYYWNyVk41U3pYZ1JQQWI4NXJkbjRkZXVYM0drb2tI?=
 =?utf-8?B?L3V1QjRKdE1KVVVNVXZRZWJNL2RrMktHQXh1UXJCQnhVVk8wZ3VlNDM0NFdF?=
 =?utf-8?Q?rXlLPwNDRYuW6vMY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D593EE892358124BBE4C6CA2FB3B6F67@EURPRD10.PROD.OUTLOOK.COM>
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
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef9d3b0-ec89-41c2-9e7f-08df4bd05daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 15:17:20.6141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHAA1WRdmLh5XESGmo2XHC3VaC/hhdPONIhev1FGQYMJBPNFLQss2Sz/B7BJZa7CyVBfMAnCScWilUYGiaRg3OEwl1QQd3e9ilHKmX8lhws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3879

SGkhDQoNCk9uIFdlZCwgMjAyNi0xMS0xMSBhdCAxMzowNyArMDEwMCwgTWljaGFlbCBIYWVuZXIg
d3JvdGU6DQo+IFRoZSBJU1NJIElTMjJURjEyOEcgZU1NQyAoQ0lEIG1hbmZpZCAweDlkLCBvZW1p
ZCAweDAxMDEsIG5hbWUgIklTMTI4RyIpDQo+IHJlcG9ydHMgU0VDVVJFX1JFTU9WQUxfVFlQRSAw
eDAxIChvdmVyd3JpdGUsIHRoZW4gZXJhc2UpIGFuZCBoYXMgYSBsYXJnZQ0KPiBwZXItY29tbWFu
ZCBvdmVyaGVhZCBmb3Igc2VjdXJlIGVyYXNlLiBTZWN1cmUgZXJhc2luZyBhIDMzLjVHaUINCj4g
cGFydGl0aW9uIHdpdGggYmxrZGlzY2FyZCAtcyBvbiBhbiBOWFAgaS5NWDggKHNkaGNpLWVzZGhj
LWlteCwgSFM0MDBFUykNCj4gaXMgc3BsaXQgaW50byBtYXhfZGlzY2FyZCBzaXplZCByZXF1ZXN0
cyBvZiBhYm91dCAzLjVNaUIsIGkuZS4gcm91Z2hseQ0KPiAxMDAwMCBzZWN1cmUgZXJhc2UgY29t
bWFuZHMsIHdoaWNoIHRha2VzIDUtNyBob3VycyBvbmNlIH4yN0dpQiBvZiB0aGUNCj4gcGFydGl0
aW9uIGhhdmUgYmVlbiB3cml0dGVuLg0KPiANCj4gU2luY2UgdGhlIHBlci1jb21tYW5kIG92ZXJo
ZWFkIGRvbWluYXRlcywgYXBwbHkNCj4gTU1DX1FVSVJLX0ZJWEVEX1NFQ1VSRV9FUkFTRV9UUklN
X1RJTUUgc28gc2VjdXJlIGVyYXNlIHJlcXVlc3RzIGFyZSBubw0KPiBsb25nZXIgbGltaXRlZCBi
eSBtYXhfZGlzY2FyZC4gV2l0aCB0aGUgcXVpcmssIHNlY3VyZSBlcmFzaW5nIHRoZSBzYW1lDQo+
IHBhcnRpdGlvbiB3aXRoIH4yN0dpQiB3cml0dGVuIHRha2VzIGFib3V0IDYgbWludXRlcy4NCj4g
DQo+IENhcmQgcGFyYW1ldGVyczogRVJBU0VfR1JPVVBfREVGIDB4MDEsIEhDX0VSQVNFX0dSUF9T
SVpFIDB4MDEgKDUxMktpQiksDQo+IEVSQVNFX1RJTUVPVVRfTVVMVCAweDEyLCBTRUNfRVJBU0Vf
TVVMVCAweDY0LCBTRUNfVFJJTV9NVUxUIDB4NjQuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEhhZW5lciA8bWljaGFlbC5oYWVuZXJA
c2llbWVucy5jb20+DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRl
ci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiAtLS0NCj4gwqBkcml2ZXJzL21tYy9jb3JlL2Nh
cmQuaMKgwqAgfCAxICsNCj4gwqBkcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oIHwgOSArKysrKysr
KysNCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21tYy9jb3JlL2NhcmQuaCBiL2RyaXZlcnMvbW1jL2NvcmUvY2FyZC5oDQo+
IGluZGV4IGE3YzM2NGQwMDMwYS4uZGM5OTI0MmEwYWYyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L21tYy9jb3JlL2NhcmQuaA0KPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL2NhcmQuaA0KPiBAQCAt
OTMsNiArOTMsNyBAQCBzdHJ1Y3QgbW1jX2ZpeHVwIHsNCj4gwqAjZGVmaW5lIENJRF9NQU5GSURf
U1dJU1NCSVTCoMKgwqDCoCAweDVEDQo+IMKgI2RlZmluZSBDSURfTUFORklEX0tJTkdTVE9OwqDC
oMKgwqAgMHg3MA0KPiDCoCNkZWZpbmUgQ0lEX01BTkZJRF9IWU5JWAkweDkwDQo+ICsjZGVmaW5l
IENJRF9NQU5GSURfSVNTSQkJMHg5RA0KPiDCoCNkZWZpbmUgQ0lEX01BTkZJRF9LSU5HU1RPTl9T
RAkweDlGDQo+IMKgI2RlZmluZSBDSURfTUFORklEX05VTU9OWVgJMHhGRQ0KPiDCoA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaCBiL2RyaXZlcnMvbW1jL2NvcmUvcXVp
cmtzLmgNCj4gaW5kZXggOThjYjY4MGUzYWNlLi5iZTI5YmU4ZWM0MTMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbW1jL2NvcmUvcXVpcmtzLmgNCj4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9xdWly
a3MuaA0KPiBAQCAtMTYyLDYgKzE2MiwxNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1tY19maXh1
cCBfX21heWJlX3VudXNlZCBtbWNfYmxrX2ZpeHVwc1tdID0gew0KPiDCoAlNTUNfRklYVVAoIklC
MjkzMiIsIENJRF9NQU5GSURfS0lOR1NUT04sIDB4MDEwMCwgYWRkX3F1aXJrX21tYywNCj4gwqAJ
CcKgIE1NQ19RVUlSS19GSVhFRF9TRUNVUkVfRVJBU0VfVFJJTV9USU1FKSwNCj4gwqANCj4gKwkv
Kg0KPiArCSAqIElTU0kgSVMyMlRGMTI4RyBoYXMgYSBsYXJnZSBwZXItY29tbWFuZCBvdmVyaGVh
ZCBmb3Igc2VjdXJlIGVyYXNlDQo+ICsJICogb25jZSBkYXRhIGhhcyBiZWVuIHdyaXR0ZW46IHNw
bGl0dGluZyBhIDMzR0Igc2VjdXJlIGVyYXNlIGludG8NCj4gKwkgKiBtYXhfZGlzY2FyZCBzaXpl
ZCBjaHVua3MgdGFrZXMgaG91cnMsIHdoaWxlIGEgc2luZ2xlIGNvbW1hbmQgb3Zlcg0KPiArCSAq
IHRoZSBzYW1lIHJhbmdlIGZpbmlzaGVzIGluIGFib3V0IDEwIHNlY29uZHMuDQo+ICsJICovDQo+
ICsJTU1DX0ZJWFVQKCJJUzEyOEciLCBDSURfTUFORklEX0lTU0ksIENJRF9PRU1JRF9BTlksIGFk
ZF9xdWlya19tbWMsDQo+ICsJCcKgIE1NQ19RVUlSS19GSVhFRF9TRUNVUkVfRVJBU0VfVFJJTV9U
SU1FKSwNCj4gKw0KPiDCoAlFTkRfRklYVVANCj4gwqB9Ow0KDQotLSANCkFsZXhhbmRlciBTdmVy
ZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
