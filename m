Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795601629;
	b=GSqnufsxDAmFqWq7pLgGoYfT/BTPbWDzJ/RZsMR2769yMcshTHrI/t1qQDzawzJ1U0g4
	 kdPsJ8Rm5FxHg3pwGCVivGqBGe3hUx7YSwwcmr7XhWMm1/XjjJPB/qST2nxFgfMubkbB9
	 T2NC/HTbZieqgQ6h4FhDePHJrBwbqbYXY8p8qNyCDinM3T5ItqzYAw4kUBCnag0uwyu0N
	 gSUDN1kwXeVTpjgIQ+NKpowGAFufTlpQdNOf7xgvetYAOrvLOswrNollV1WBzmsvaxv49
	 ohiyghniOGWeapEAcwZyWKUSdUVpC0s/ByfYFR+Gw0sNZPsDgwSK+mEbji6rw1DlUbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601629;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GxzN+Wzy9REbMAhy08M/716Vbz1H7dT4bIMoMb3QriQ=;
	b=Fdab1O1p0cNjZeapdoXjn4zfqmcq1wZRyt/RugAXY7qhEZigDRbYiHtSE9/RdAHcsUAs
	 rRJ5sndQTehiazdtVl3tDfNo2h1tG/2xW7ju1y4QdcMsgRtaf7A7OPLWp8BWgjGVguH6/
	 PtdXAt0yz7dK7/YV52Ba/X80gakwecPh4g/FG+qUzSgPDDapc7Mh5okiLgh1A5ucaJHwv
	 XIphfGpydT40CzP1gKRDmIhjaR+ruIoQiBtM6bf4BVpxJ9hOgSXsZzBhbr53ZUky7Jht4
	 gwNHcZIJUUjAiJ241hVb4pSHU4+T3fB/nBxi0H+0nfKVnnwKC2yOaMSwoS9an6X4DSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=IWJheuJp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.39
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011039.outbound.protection.outlook.com [40.107.74.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1908606A327;
	Wed, 25 Nov 2026 10:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1908606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=IWJheuJp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOvqAbhDnO7cYQbxHDCmDIgKOnFwkMifxACagwEMOAV9qWzveDXO++fHflyU9A1q8osJtOiVRSXuBWmVgNZ8GgSLzb3cUobyYzG21ZISppv+0G5xMENG/0n1RQ+FtDH05yR7oO16j9G2SsrYJOhN9ihnuq5sNBV02Hs5OP7N+94tLNr69GPOeSc+gkRMJn0g9XszDXxSLotLp5OwYJSaPxTAjCCElcnR9Fxp4r4NTaaonTmfCfTQVd6Vbp9nV11EuhSJNphgd547CUqvJBGvXgpYcAXp0cyQHuqt8GUEBFP8/p16BzleNWc/vNNK5Fs+Yth3KU+LdpzMXSNexhjd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxzN+Wzy9REbMAhy08M/716Vbz1H7dT4bIMoMb3QriQ=;
 b=wodK+Eql/B0O89CLh6lEXoSZ3ERsR3D1pBUL3NUq+sZB1+nwAtaai2e6zw0tWyU9bQEp5lXq48+tCmuNqaepOvh5c88PrJ2dsskf8H1i30s4i5bEsbqnoJ8CWiVXrghi1M3NrCKue7ejabFkJgZhcHuwKFdzseu0GLO48SPPzR3HwmKX0NUWAp6wUwwmNjzgXY1yDbfVrwq/bK8IcjiilQgEmuf1Zu/0CRL23tW+YvqM8wyJChC6wooZaTsdbvHRIDmPgRIb0XVDl17G1U5ii5H9j4epkv/KU91SxbKnpfcZwGNnpjxOu76RYZIHt8UE/eEEWbPQv8O89I0QbrlUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxzN+Wzy9REbMAhy08M/716Vbz1H7dT4bIMoMb3QriQ=;
 b=IWJheuJpEArWZemN823kcz9VIeSOzoIBHNuohPQNGjMvrsJsfZzljIwjrAmqF1Ug4OIAeVgP4Ksp9w19stbom0JKjSSNuo8zLi2Jj+SN3KKxI4sJGanTt/2O80dpMcqwofOp4Y8412bqZ/NPmVQcTpgtH1oGAl8LqfnYMa80Y04=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY4PR01MB15109.jpnprd01.prod.outlook.com (2603:1096:405:283::5)
 by TYCPR01MB10381.jpnprd01.prod.outlook.com (2603:1096:400:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 10:13:43 +0000
Received: from TY4PR01MB15109.jpnprd01.prod.outlook.com
 ([fe80::eaac:e6c3:ef79:e511]) by TY4PR01MB15109.jpnprd01.prod.outlook.com
 ([fe80::eaac:e6c3:ef79:e511%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 10:13:09 +0000
Message-ID: <dc195219-eb7e-4222-9a0a-90553b109b6c@renesas.com>
Date: Wed, 25 Nov 2026 10:12:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] i3c: renesas: Add RZ/G3L support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Linus Walleij <linusw@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, stable@vger.kernel.org
References: <20261026-divo-ssgrlpcsrc-2966-i3c-v2-0-2e76b87209bb@renesas.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
In-Reply-To: <20261026-divo-ssgrlpcsrc-2966-i3c-v2-0-2e76b87209bb@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0336.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::9) To TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB15109:EE_|TYCPR01MB10381:EE_
X-MS-Office365-Filtering-Correlation-Id: cf02e046-c5c4-4cf4-c2fa-08df4adcabc2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|6133799003|261009223027099003|3023799007|921020|11063799006|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	ZLcfWG58BUue56QXL/k+PGwya7kRV2GrhEdGW5F1Q292xECfhRW9hFffFFM7AJ81FMfCiTNl+1U5VR9nuqnSzdFGdPWys0AMRcAScO7agXUyI5qVZkHKyQz7BaylsREBCGiXunkThsIM70LCiqywUy7FJzhdNQWcPi+tvcRg7VEALOkyVdYc5sQ7q173w0XFvDFxP1kKhscZkjxgW9orKXi+sukCTEtrdnmZceEdVLCEGRluw6/C6P4OTtAt45kJoqiWepPf7YaErzs+t/+p75scVNj6h+jrMQ0y7G0hCksAsd6V72Lp4g1C5eWCqFNfCPkqZsH0p7JeCeav4M3Kaw6zDIZ75/7Dfbl1MQrrcB8BgGelxEeQcAePyofaBs9lSw6oGlwpAG98gzBdHxBxxUA0hxCeoyOmB+aiTl/50D+wTsQwqZLlabOkJ72CBT//hlWFtwqy4ZDhWKT5EOVJPAvXJehhl02ahb+QUBCCTcyJub89o8dcMdHFotntC68JqYYdDz5lQPhEGjvLRxz8ZZMCbcfnSBenlrtXKiT9jr2oeJ0IpXeU8SAVgsDESNZZQyx7/NhJZobJmk2nRHOa0B2l4ZwXbvlN2P1qqu4S7SzJgrFKoqkjkU0BoI+KlzxrZ4pjT6RFCyGZBAnKz+ZHXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB15109.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(921020)(11063799006)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnZuVHUwczFocTFtSzVzSk5RQjg1d3pqMDlNVTFpM0RZMHp1UmJRUitCZUg2?=
 =?utf-8?B?OXFqMkhNelhHS0VIUUdJSnV6N3NMemtLRFJ2TUtFdDhuTWlpa0cwd3NqeVVH?=
 =?utf-8?B?aGNMeTJINERWTWtMLzJxTTZ2c2xnMXNDUnZFNTl6YnVZRDA4SEUrN0RSRk0r?=
 =?utf-8?B?M3lhRFJBaWh6TlVBbytiMktTVnN2YVBhSThFZDhTMFVpUFJoT2hTMGsxMUhE?=
 =?utf-8?B?YXR5aE55WENERklUZ2haUkFJbEQrekR5VTk1OWgycVdMZ3RhQXlTV1VscTl1?=
 =?utf-8?B?THJwV1RRYXhCOTBTY09lTExZOGQzMmdCT1NndXUyVHlqUTgzRUdPUENROE02?=
 =?utf-8?B?MFhPRE9PdXBrbHRLY20wK2NpVkh5U3FGRktFSjhUait5d0htNks0UU5HZnFG?=
 =?utf-8?B?TkRGZ295RmszREN6b0REaDdJbFBTU0NSd01NSkI3MVBaTm0wS1B5a0VsaUpw?=
 =?utf-8?B?MjVBWDdldUZLZnE2RS9FcU1rZnBPSy9xVGNHKytJVURmN2p5QnZTL2FlQUZ1?=
 =?utf-8?B?VG93d3lKamVncENnVGhmazZvZVhsbE5sTkZMcWIwMWJMRk5ZZTNQanVrTDhI?=
 =?utf-8?B?ajZZaHFjODVSankrOGcvMUZNSG4yYzNoOXJWcGFaTDdBNEYyT0RNUUVSNWFS?=
 =?utf-8?B?eGdxRUI5c2ZXZlg3ODFGQWd4WGFPVFFqaTlrTkxPdXlCTEFrUzg3RStSSjJD?=
 =?utf-8?B?c2o0K09hczg2LzVrVkVaeWdZZVRKVktsMVQwbnM5QkpHbm84d1MyWnBkQ2c2?=
 =?utf-8?B?NWt4azNGSWFTOUVWcEVORWY2L0NWNFJTbmk3dll6RllMYmNqcnJWYWphOVBC?=
 =?utf-8?B?ekF2UDBUMVdnQ1VwdFlQS1F0YkhJTUxZQ1YvMlJHNlFNcm8yRGdwbFh2WUdP?=
 =?utf-8?B?YitYeXcvb2RGU1lZNTVjM29ONGVGK05WRWIrOWRKdDlJeDZRRGdIeEsrbThH?=
 =?utf-8?B?Z0NDYW1KSWNlVlYxdTVzTTJrL3NJcTg3R3ZscWplRExvckdlTjhyRmFLbytr?=
 =?utf-8?B?eUcwOTgyZGdBVWh6RFJGdVRQbXU3Tm9lYzNkU0NkT3B2R2VXRjFHN21OeHNX?=
 =?utf-8?B?bDNxaWJwR09CelEwQWJrR3h2OGd4aDROUWthUDZBa05WT0dabC9ZVVV0WUs4?=
 =?utf-8?B?L1g2LzlsSGQxTmQ4RzQ4Q01sYitCYlF1NUhqcStkQzhWRjdmMWlUZ1pOclFy?=
 =?utf-8?B?UTFTQVJ0cXFEVTNoUFJ6ZmlqNHJzNk5TQzh1NEZCUHBBbFVwbE4wbGUyRlJv?=
 =?utf-8?B?MjRtSkhabndmRXZwQlBjR2xTZXRWRXU4eWhiaWQ3dXJDR2tlbkZzdm0vS0FQ?=
 =?utf-8?B?OEx4Zm5LTHkvaVRZdGlPY3lMQkc1V0wwZjNaUHVxM3pqdGtuSEVrdW9pc0VT?=
 =?utf-8?B?VWQ2ajFlV2h4RjBTWm9PZEh0VlAveFphVVVUWXZaMmd0dTRrcWNVTDNvVFN3?=
 =?utf-8?B?SGU5K3JHWFVsb25pVGJiTFpmbnJydDhONnoxdnpMUzQ1aVF4ZCtjb283VDEw?=
 =?utf-8?B?eEVldTMrYlZKTTdpVVMyZXBmUWFsTDc1MDl1YURqc2ZkdkZnbElxa2xFZm9h?=
 =?utf-8?B?TkZTTzdxWGxrM2QxYitsY0ZwVEQyNGl4OGFlZXpkTW1LZFUzbGtDcXpUZHNT?=
 =?utf-8?B?bWxPL1h1R1JBdEs4bjY3dlZqYmVHSnp0R0c3OUVxWkZBUjR6UytyRDlqYzBE?=
 =?utf-8?B?STRCM3Vld3pjbXlKOVgxUmNZNnJyZW9PbWRsMzR4THNuckRZU1NiL2FZc29M?=
 =?utf-8?B?T1o1Qk1RdnJiOWRQV0FyZDh1L2FiaHRFRm9vMWFta3IwOTZIQ1haTGIrczVV?=
 =?utf-8?B?YkhNT1I2WEMxK01EQ1d3VFJmYS9hdWpyeHZyMFJXTmhrYnBlZFZPck02bW9x?=
 =?utf-8?B?SVl1WHV2MEl6alY5cHIxTktubFA0YUFVTUV6dGF1cm5ENUllTUZRZU9Yd3BH?=
 =?utf-8?B?VjBLeEZKSVlLbGlyV0kwQkt5Q0kyQmRjMTBsQkIwUmpnQkZkV2pJS0JrZW9Q?=
 =?utf-8?B?WDZGRkRZa0FVZXBQcGgydGVIc1ZDTEQvazI3czB4SlpIaEtXNVZEczd6aUN0?=
 =?utf-8?B?U1NRZUxFK3dlTTFsM3UxZzRkRjFEQWU2czFhV0M4Tng4QmRFR0tjeDVKZC9F?=
 =?utf-8?B?b2RGbGdsUFAzRUFSakJCOGFvTUtZUXhqQUN1b20reFo1N1FVd0U4WkdsTVlw?=
 =?utf-8?B?OXdTWVRkVkdhUFBrK1ljcWNXS0F4VXdHaWdxdnhZQW1ycFJCWEN5UzBKaWtC?=
 =?utf-8?B?NUhlbzNFN2tYRkRyT3RKb1JpK3g0emFCcjQ1T3BJL0ZXNUZoNGUvdThXZFBC?=
 =?utf-8?B?WWtNYUJVRFlMZFRtbjRqamlybnViRE13OUFpaHFlZVByaG9EQTdWbWU5aUFR?=
 =?utf-8?Q?hLnIs3zuqBvDOCHU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf02e046-c5c4-4cf4-c2fa-08df4adcabc2
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15118.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 10:13:05.1265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTYc1dNhUOZ93zt/EV45b3QIEODffUD0tiuOz0hfnQ3RvqjVCG/2nvO4c+0E8Kx83RfR2xhrT58tig6crAcDAxFv/sOwt4UFfEjUhSVmm+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10381

Hi all,

On 10/26/2026 11:35 AM, Diogo Ivo wrote:
> Hi,
> 
> this series adds I3C support for the Renesas RZ/G3L (R9A08G046) SoC and
> enables the controller on the RZ/G3L SMARC EVK.
> 
> It starts with a driver fix, which is independently applicable and
> marked for stable: on a pure I3C bus, the I3C core leaves the I2C SCL
> rate at zero, and the driver used to derive a zero-width open-drain SCL
> from it. It now falls back to the 1 MHz FM+ limit instead. There is also
> a small cosmetic patch removing a comma after the sentinel in the
> compatible table, for consistency.
> 
> The rest of the series adds the DT bindings, the CPG clocks and resets,
> and the SoC and board device tree support for RZ/G3L. The driver only
> consumes resources that are common to the RZ/G3L and the RZ/G3S
> (R9A08G045) (the tclk clock, the presetn and tresetn resets and seven
> named interrupts), so no driver changes are needed: the RZ/G3L is
> described by the SoC-specific renesas,r9a08g046-i3c compatible with a
> fallback to the renesas,r9a08g045-i3c compatible of the RZ/G3S, which
> the driver already matches.
> 
> The board enablement is guarded by the SW_I3C_EN switch, as the pins
> are shared with RIIC3 and the audio codec behind it.
> 
> The I3C I/O voltage can be set to 1.2V or 1.8V on the board through
> the SYS.3 (I3C_IOVS) switch. As software needs to tell the pin
> controller which voltage is in effect, the series also adds pin
> controller support for the I3C power source on RZ/G3L together with the
> matching board device tree configuration.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
> ---
> Changes in v2:
> - Drop the "i3c: renesas: Add RZ/G3L support" patch and express the
>    compatibility of the RZ/G3L with a fallback to the
>    renesas,r9a08g045-i3c compatible in the bindings and in the DTS, as
>    suggested by Krzysztof.
> - Split the clock and interrupt constraints in the bindings into
>    separate if/else blocks to handle the RZ/G3S fallback on RZ/G3L
>    nodes.
> - Sort the &i3c and i3c_pins nodes alphabetically in
>    r9a08g046l48-smarc.dts.
> - Link to v1: https://patch.msgid.link/20261020-divo-ssgrlpcsrc-2966-i3c-v1-0-30a47f25e515@renesas.com
Gentle ping on this series.

Thanks,
Diogo

