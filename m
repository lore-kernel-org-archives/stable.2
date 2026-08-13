Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8439A81B;
	Thu, 13 Aug 2026 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610839; cv=fail; b=cgeMFMC0M6WBp+yOcJ3aWO2fFKu2fODNILBxt0E72Sp72XKwRonXf1U2jY6hsVBsMvfD0R9+nJdNm8U63uFa1pEgaKz5peo9TfaNO+anEdus77occgyW6dfvFHAEgdzZPBr4WftBL2uqMYrBcRbNvgkjZLYM8QiXAphE8sIU3ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610839; c=relaxed/simple;
	bh=ycke6aVkrvIUK//CXLgnn4CcdrLp03ZP8XtWhlGPEyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gwbA6Kr95wCHALwhjMv3HB7otDDa4s5Vxjh3fzBQiWGWEpkSbvHu4LflW/PmPswBHUfsQA9Jxqwa35LMFS00UErhizjWr08vAR0etSzdQVF7MkQSqyvbJ8xom2Vt3QUAhTdLBNnvLGgCfFvgNlnCIPURYuyMAyIn7hqrrgv7yTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FSuV+doM; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FSuV+doM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/NgfDQwDv8JENMf6kuSMMsKZXdjRc3vd9wG3mpKN3tjDrfJyt9pCzv3vv8/1Z70eYvFnTrOUzkJ6p8CLvYQ4vFaETB8Rrk1xdPk7xuLdfY1q26xgdo36D0PWXQRNz1IEh/2hVgWyQGedEgV9qNyqwymurxbu349LjV+oTd/tP2Xd23kHLT2bGezhHBhmVVbYXrUZjfAvwHopDgpm9EQ16WSsnl7NVFybiH+z5lZX3GQVejAK1GJUkslBOVgplXAMDoWSULNBgkE+5Iex3wPs7aL/PEZX40jv8zx0Pjug4GAq/zCvCWJ+9tCws8TkZ4V9NlzAUhoBBFs/UACI7Dh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycke6aVkrvIUK//CXLgnn4CcdrLp03ZP8XtWhlGPEyI=;
 b=L56QVgDqL0CUVUebrwK7Mu8yq1dOYJEuHlShrl9axxJBjQrBTqkNawVtf4W79UlMiS7sl7OFpBcyy3HZd6ueW9z5BCMjzWux9mJPW57LKo8+u4ZCBZGSsXoEVM8LPQ6fIOkXCSVtcVFngEWnoG9WVQ278ZSG7XFKo67let98Xn9esdEl6CBuzOetWQZtiR8aJy+KV99SOpb6LTfu02CAincT88hXZFK+m1/ivYGGA2PoisohbpLHtI8l3F6eb7hHFhDmzDaqa+AwtkcDuXOJHVmVbv4odF/haK1uKY43Gn34seLH+jnPRFMXTSxKLJwV/ejSlovec4ELl2890GOB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycke6aVkrvIUK//CXLgnn4CcdrLp03ZP8XtWhlGPEyI=;
 b=FSuV+doMsPboSVer0oUj/VM3ucqS0JgZh4pHaUawpCU6CzN8k1HRtiO7ysQFrNAw6Oeb1uW3LVmJy+bgPg+oUbIQUVMv3Mn4cohqjzL7pAzbylpiQe/wngP7dsR2XEb0nhJlusWdWITUZ09n+W2avbgbaKycGJnpSTiZrRtk//lYBdcOaW8mxgWdPaSfFHZ+5PicbpLc6VTmtmUn/Yuzrtzi+uzbZ4x6M6B4IFXahcr5dpn9MbdQLr5T8RZmHZap0N4NRP8nT4ZyuEloMimnNFqroMCTzmMIXdOrAKJappcyqK79sH+iKY/HI7UlruJTqYiV4/SlewSdDCek60lHxw==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by AM9PR04MB7716.eurprd04.prod.outlook.com
 (2603:10a6:20b:280::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 08:47:09 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 08:47:09 +0000
From: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, "Hongxing Zhu (OSS)"
	<hongxing.zhu@oss.nxp.com>
CC: "leoreis.costa@gmail.com" <leoreis.costa@gmail.com>,
	"fra.schnyder@gmail.com" <fra.schnyder@gmail.com>, Frank Li
	<frank.li@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v1] PCI: imx6: Move clock enable after core reset
 assertion
Thread-Topic: [PATCH v1] PCI: imx6: Move clock enable after core reset
 assertion
Thread-Index: AQHdKv1SJJL6sTcL6UG+PXRRjRoy3rabqHMAgAABuyA=
Date: Thu, 13 Aug 2026 08:47:09 +0000
Message-ID:
 <GV2PR04MB12019165BBE41100A6B5E82698CDB2@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260813082900.270003-1-hongxing.zhu@oss.nxp.com>
 <20260813083912.GB19687@francesco-nb>
In-Reply-To: <20260813083912.GB19687@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-08-13T08:45:23.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|AM9PR04MB7716:EE_
x-ms-office365-filtering-correlation-id: d56b55fe-faa7-4e70-849b-08def9177637
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|19092799006|1800799024|6133799003|38070700021|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info:
 iUGulCx7FM5xaB7P2WjZgd6+KLxkkJje77QX/H0aAYuHhgCQ4FkklTHOg5bvv7zyLFuCo3z/f6Fpfih9saqpkJ7zq3fA2tGV4n6BYTAyUVs7/6bg6G0423BjEpNAnFqDk+gHk5KpArSxczpyr3RvTBCBYJwH4g9eozP8i+41oAXwCpJ8lvssCZYO4l3y+/D09ACZ8cDkLiEHT/poaC/jZC2MezKqcTeXVRoZDl1iILpxIbi/pc1fJmXgXcDPiEWY9poi8itZkx0wjM5mALhQlKsNRa4kcXP7pOlSU1pKS0ciTQwtfqjrqKAu/I96jPmr/u8MNn6Jb5+DOaOx40AB+LJX55e/e2ECAVM1hgG00C4OA0TLu4vN8q+oEzd58/0CTxcvdYVF0wdq3GWl3yT6s9F6y+Lt5WnOcbfAmH89X2bpMQJIj6wUhShGA+XlBqC0i5vk6MLcJO8YeUcstk7SLA0j2320InAUPNpZbfHVYmX+D+aBXv6Wpeg2yKHldX3iYU0Va3zaBH0iYcc1rfH47DG7rUUsdHIsN19GsqpXlOY5PYKGWEIimwyARxzc3a1OdghvZH4752ctF4m9foGThzSE7dYiQOUOXi8ma67XpMR7E0c/PaoUAAb/uzxE/kdtQoLnLrvPtQD13KoypexONf40F1MRHwT9WimHOp0XWeZTmrSGjDRiFVLAMfo6ODMA0Sy99yoVA8sONmL4rleKeN5LgXU7w+1a6qVEdTU2JH8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(19092799006)(1800799024)(6133799003)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUZQa0pzVXFXcVdGeWRYYmJYRzBkZ3pGMHpZMXUyUUkvZ3o5cEdWR2lKYmE3?=
 =?utf-8?B?b3FrYis0VWM5OFE1OU9hcVJrWU5WZ3JtMkszbjk2SFhjZ3Z5aFpaNk9WWCtD?=
 =?utf-8?B?ME44b21qaDQ4VlJpZjdma0dlYWJGcWc1SmhIWUJPQnhIeUtuV2JwSkl6SGpG?=
 =?utf-8?B?RlBabkFQZVdsYXI5OVRFRGlFQTRnWUtpMFJFdDBJdjU0aWx0MzFDSy9uaHVK?=
 =?utf-8?B?Q3pRMW01dUptNkdtOFVTUEtxR2JRQTlGOWQ0cVk0VEZUb0NnN2k1WHhGeGV4?=
 =?utf-8?B?c3VtUVhueUlnME8vanp5SFhmVzZPem11MnVhbFArUzRkV1ZHS1ZuUVRtb2RW?=
 =?utf-8?B?Zk0yK1llaEtvWEplN2o5TWVLMTNuUU96TGhla2pKbEk5VnRkSkp6aVUvQWZO?=
 =?utf-8?B?ZjVCSDdlYXYwdU5ZUExpSDZSNGNCbnNQVktSQ2crYmRpV0UyR0FyUHZ5OHFP?=
 =?utf-8?B?TWVENFR1eFNHamwrM2N0UVpvdk0yTUNhMjdiNGF1cFJNZ1JVQlY2QVZ4Q1BT?=
 =?utf-8?B?WHFrQ3o1eTJNYTJsTCtKT0JZMDRya0xad2w3NTg0UGE0UEJHQWlaRUpidklI?=
 =?utf-8?B?cEZvZ0ZHQkZkcE4wWThSR1RRMTZNV0cvK1dSa3llOWw3MHBlNElVY0dDWmlF?=
 =?utf-8?B?R0dDcWxVYnQyRm5zN2I0TG5yMGgrQ1RJZEs1b0F3MGdXc2F2RWJ4M0tZYUhm?=
 =?utf-8?B?MU5vU2Frakdhd0N6V0pnSk96a2NDSnpJOWZ6QjdaMVZ5YTNUdFJRdGEyRERC?=
 =?utf-8?B?YmN5Z05FVFhmdEFhTE1rVW1GSTMyVURibmFXcjdzeFlUOERYbzFXcnEwYTR1?=
 =?utf-8?B?WmdtYlM4SG9scEM5MWZ3cDl0RUVnR2pWK25OQ1J2ZnhSMVNRMFJYbFNuRTYz?=
 =?utf-8?B?U0w5aCtRQTJOWFNkVFg0aHJUMFB6VE5ram10Wnd0VjZjbkZXNDFOQVhZSWg3?=
 =?utf-8?B?cG1lVUpuVFJtY01IaHhDVmlrWFNpY29KQlhaMyswSTFlMk9CVHp6NmlKd0lw?=
 =?utf-8?B?ZmxjMVBNdUZTL0FHSEhEbHduTTN0MU5xUWhYbkFzdzA2K0pucnF5a0g2M250?=
 =?utf-8?B?TCtpRTY4WWwrT1ZwK0s5YlZ4bmdoYlVSanVKQVZhN3hYVlJPNFREVS9ldFpQ?=
 =?utf-8?B?Z1QwKzRwekl4QWhzVDhJZVhWdnVRcDBQejlzUU5adUw0K29JRTJnT091TE0w?=
 =?utf-8?B?eExQN1ZvT2dXWHFQSnNWMDFHVkw0bmFNUTYyWkt6RVZTUTNJWjE5Y0hiWW0z?=
 =?utf-8?B?V0hEc29IMVJtYmFZWThrVzg2REJ6Rk5jK3RyVW1vNS9hWTdqQVc1ZmlGRUh1?=
 =?utf-8?B?N3lZSWQ3eHd4bm5OblpSai9HTWQ0N2JYQThvU1VtdUdaNTJjWFJhVzd1WWY0?=
 =?utf-8?B?Y0x0c1dQcUNHZ2cyKzdyWHp2eHBKMjJFOEtEZkJOcHVKZUtwQXVEWHdjZ21M?=
 =?utf-8?B?QkI4YjBuWVViUUNic1ZFUThjWXh6eHROdGtrdXlvbXlnQnNlOEJ4VHVLSlE4?=
 =?utf-8?B?TUs5SUNqTDM4MytvNzJ0RHBZRmZDbjE1SmVrSjFqeTNHcTNWUFJjU0hpeHd1?=
 =?utf-8?B?L3ZhTURNYWNaYnVaTFMxL0xrY1M1TnpWem10ajRWR2pNZE4wRnE3STRFNmZh?=
 =?utf-8?B?ZEM0NEZ1ZnMwRmFaQVlaVjhScHR2SEVzNG9RL0hhWXVwTElQK2IzMEhTSEk2?=
 =?utf-8?B?MzFQb2p6RGpKaWd2NmZ4dmFPUXVTdG1zU296cTcvSWF3akt3b09CVk5MSklP?=
 =?utf-8?B?dDUwMTFjYUlrbnlmbmxMU2RQc0VFeWhlMWhjTFAyWHc0WTVOVkNJd3RlS1dN?=
 =?utf-8?B?S1NmYm45ZENiM1Y1cS8yQzJNSjliWjlkSzkyUXkxR0FhWmxGdXlIeS9HNXRE?=
 =?utf-8?B?ek0vc0hzcnAyOStZRGVaRUUwbHlMQmhTVlZJNW5TQmYzSDRyMlFIeXZuNDJG?=
 =?utf-8?B?VlZXL2R1SnlEcElVOS9mQ2UwQzBYVEpaZ3JoajlOMWMwSllyZjVjWlVrUkZH?=
 =?utf-8?B?aU1qSS9ON2EvQ2RzV2x4bEc3NWFpbDViT3B0Yklha0laU29GdzJRL1RvYXdo?=
 =?utf-8?B?V2JtUnJkNGxUaHU1RE1JN3dVV3ZIeDYvNGlsT2dvQVloRjhyanZuZ08zWXNa?=
 =?utf-8?B?NGVWWHJHMXdzRTVReHZBbzJobzAzOE5lQzZhaEtzUEIxOGVMSlNWMk5xYzF2?=
 =?utf-8?B?ZEFwUGpmMmlIa1d3S2FiV0FjSWxSZDcrNVczbnNZS1U5dDhPTEVYSzFUYjhR?=
 =?utf-8?B?UXQrSENjZGdseWFyekdyT2l6RFF1RUlQOWtIalBMSUw3eS80dWJ4MzlNZ0lD?=
 =?utf-8?B?NUU2MjZMS0IzL3FCbjZtRm03akdIY1VxV2laOEI4S1A1dlJLam9FZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56b55fe-faa7-4e70-849b-08def9177637
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 08:47:09.4933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqdugIFgcNc5J9RFQltq+WoO+mvLeP0YAb3DxS7B7UF4dlcR2btwB9x/+kGawPLz4yptk51LBwWQ+jGDo92PmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716

DQpOWFAgQ29uZmlkZW50aWFsDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY29AZG9sY2luaS5pdD4NCj4gU2VudDogVGh1cnNk
YXksIEF1Z3VzdCAxMywgMjAyNiA0OjM5IFBNDQo+IFRvOiBIb25neGluZyBaaHUgKE9TUykgPGhv
bmd4aW5nLnpodUBvc3MubnhwLmNvbT4NCj4gQ2M6IGxlb3JlaXMuY29zdGFAZ21haWwuY29tOyBm
cmEuc2NobnlkZXJAZ21haWwuY29tOyBmcmFuY2VzY29AZG9sY2luaS5pdDsNCj4gRnJhbmsgTGkg
PGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBscGllcmFsaXNpQGtl
cm5lbC5vcmc7DQo+IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IG1hbmlAa2VybmVsLm9yZzsgcm9i
aEBrZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzLmhhdWVyQHBlbmd1dHJvbml4
LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXgt
cGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gUENJOiBpbXg2OiBNb3ZlIGNsb2NrIGVu
YWJsZSBhZnRlciBjb3JlIHJlc2V0IGFzc2VydGlvbg0KPg0KPiBPbiBUaHUsIEF1ZyAxMywgMjAy
NiBhdCAwNDoyOTowMFBNICswODAwLCBob25neGluZy56aHVAb3NzLm54cC5jb20gd3JvdGU6DQo+
ID4gRnJvbTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+DQo+ID4gQ29t
bWl0IDYxMGZhOTFkOTg2MyAoIlBDSTogaW14NjogQXNzZXJ0IFBFUlNUIyBiZWZvcmUgZW5hYmxp
bmcNCj4gPiByZWd1bGF0b3JzIikgaW5hZHZlcnRlbnRseSBtb3ZlZCBjbG9jayBlbmFibGVtZW50
IGJlZm9yZSBjb3JlIHJlc2V0DQo+ID4gYXNzZXJ0aW9uLCBicmVha2luZyBQQ0kgZGV2aWNlIGlu
aXRpYWxpemF0aW9uIG9uIGkuTVg2USBBcGFsaXMNCj4gPiBwbGF0Zm9ybXMgd2hlbg0KPiA+IEFT
TTEwNjEvQVNNMTA2MiBpcyBjb25uZWN0ZWQuDQo+ID4NCj4gPiBMb2dzOg0KPiA+IHJvb3RAYXBh
bGlzLWlteDYtMTE0ODYwNDI6fiMgZG1lc2cgfCBncmVwIHBjaWUgaW14NnEtcGNpZQ0KPiA+IDFm
ZmMwMDAucGNpZTogaG9zdCBicmlkZ2UgL3NvYy9wY2llQDFmZmMwMDAgcmFuZ2VzOg0KPiA+IGlt
eDZxLXBjaWUgMWZmYzAwMC5wY2llOiAgICAgICBJTyAweDAwMDFmODAwMDAuLjB4MDAwMWY4ZmZm
ZiAtPiAweDAwMDAwMDAwMDANCj4gPiBpbXg2cS1wY2llIDFmZmMwMDAucGNpZTogICAgICBNRU0g
MHgwMDAxMDAwMDAwLi4weDAwMDFlZmZmZmYgLT4NCj4gMHgwMDAxMDAwMDAwDQo+ID4gaW14NnEt
cGNpZSAxZmZjMDAwLnBjaWU6IGNvbmZpZyByZWdbMV0gMHgwMWYwMDAwMCA9PSBjcHUgMHgwMWYw
MDAwMA0KPiA+IGlteDZxLXBjaWUgMWZmYzAwMC5wY2llOiBpQVRVOiB1bnJvbGwgRiwgNCBvYiwg
NCBpYiwgYWxpZ24gNjRLLCBsaW1pdA0KPiA+IDRHIGlteDZxLXBjaWUgMWZmYzAwMC5wY2llOiBM
aW5rOiBPbmx5IEdlbjEgaXMgZW5hYmxlZCBpbXg2cS1wY2llDQo+ID4gMWZmYzAwMC5wY2llOiBM
aW5rIGZhaWxlZCB0byBjb21lIHVwLiBMVFNTTTogUE9MTF9DT05GSUcgaW14NnEtcGNpZQ0KPiA+
IDFmZmMwMDAucGNpZTogcHJvYmUgd2l0aCBkcml2ZXIgaW14NnEtcGNpZSBmYWlsZWQgd2l0aCBl
cnJvciAtMTEwDQo+ID4NCj4gPiBUbyBmaXggdGhpcyByZWdyZXNzaW9uLCByZXN0b3JlIHRoZSBv
cmlnaW5hbCBzZXF1ZW5jZSB3aGVyZSBjbG9ja3MgYXJlDQo+ID4gZW5hYmxlZCBhZnRlciBhc3Nl
cnRpbmcgY29yZSByZXNldCBhbmQgY29uZmlndXJpbmcgdGhlIGNvbnRyb2xsZXIgdHlwZS4NCj4g
Pg0KPiA+IEZpeGVzOiA2MTBmYTkxZDk4NjMgKCJQQ0k6IGlteDY6IEFzc2VydCBQRVJTVCMgYmVm
b3JlIGVuYWJsaW5nDQo+ID4gcmVndWxhdG9ycyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFy
ZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFJlcG9ydGVkLWJ5OiBMZW9uYXJkbyBD
b3N0YSA8bGVvcmVpcy5jb3N0YUBnbWFpbC5jb20+DQo+ID4gQ2xvc2VzOg0KPiA+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC9ibDdpM29idTJjbHpzZ2VvY3QyYTRtdGZodjZ0eXBjamRxbWdu
ZXJvcGYNCj4gPiAzaHBnd3ZlNkBuMm01dWhsZHV3NTcvVC8jdQ0KPiA+IFJlcG9ydGVkLWJ5OiBG
cmFueiBTY2hueWRlciA8ZnJhLnNjaG55ZGVyQGdtYWlsLmNvbT4NCj4gPiBDbG9zZXM6DQo+ID4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL3Q2NXk1ZDU0YXh0a3NiZnM3cjRvbGNlZnFod202
bTRkejNuamducm5mNw0KPiA+IGZjb3RqNzRpQG83YXZvem5sYWZiai8NCj4gPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZyAjIDcuMSsNCj4NCj4gNy4yKywgNy4xIGRvZXMgbm90IGhhdmUgdGhl
IGJyb2tlbiBjb21taXQNCj4NCj4gbWlub3I6IGl0IGlzIG5vdCAxMDAlIGNsZWFyIGlmIHRoZSBp
c3N1ZSBpcyBzcGVjaWZpYyB0byB0aGUgQVNNMTA2MS9BU00xMDYyDQo+IGRldmljZSBvciBvbiB0
aGUgc3BlY2lmaWMgcG93ZXItdXAgc2VxdWVuY2UgKHJlc2V0IHZzIGNvbGQtcG93ZXItb24pLg0K
VGhhbmtzIGZvciB5b3VyIHJldmlldyBjb21tZW50cy4NCk9rYXksIEkgYWRkIHRoaXMgIm1pbm9y
IiBpbnRvIGNvbW1pdCBtZXNzYWdlLg0KDQpSaWNoYXJkIFpodQ0KPg0KPiBGcmFuY2VzY28NCg0K
