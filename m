Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013011.outbound.protection.outlook.com [52.101.83.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BAA47FB09;
	Fri,  2 Oct 2026 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942962; cv=fail; b=NpZJxxmlET8AiWcv1mzQgRGxpxqqmkK5LIc41/C/8s3Sr2j2c9U5t86EJKLNV+u+kezmLiEk/zT9b2HyaZRCGhUynjCV06S81GnWBkGAp1QSqiLwW3tQ7/lQtmfcop+TdF0VZ1hVHBUmaBOEci7ArHMrL3pdjDzZ/yo+0udGHOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942962; c=relaxed/simple;
	bh=DY1d5ZYrma9h0MxJ+/LaCLGlsQcc2pfGIytn/BaQ1dQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g6pQ2YjPLXGe7GScV8W5UFz7DF2EcIOBvuSWsY6TFbOLSomiWC5dMuhjVjAH6vXBNwraVNRSDA4KVNNP2vRe00hhbczmjX2t+VCGeYssSh0T0PtUeO6Nc1FCxIsLoPJU78yhEmwfOTuhPC9Id0q+BxH8o318X0scUp+dWaWVjsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=nJoSHTKU; arc=fail smtp.client-ip=52.101.83.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="nJoSHTKU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYHNucaBu+IJIVm0g0gqTXjg7m2yQSRhhsnS4I7/dnqStaa6OIsy9LshnhXDWtLDWwBd7phoe/pA1zgczRDrI+tOGuZA5wLj89lbvcT6koff5tYg1ZGKB4v/gp2xmLHpZ/Q2pZEuf0cf3gsPswMsQGDR+E82DDP51POCyqeOZuZYmBRklzr2JLHGjScIFcpGbPgrpUdRTwu2SwY4wfzKQ5tFb33qyrk7+qiSP5O81O1S0MDj5xT66ppgKEGhH9x6mW6Y2pPADcTFqIdbx65tAMHAYfrJ5YeTgI6b00nTYCoZv+Ob/e2DKTEwQFnMW91LDxj0mjn07wehYd2rWNXtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DY1d5ZYrma9h0MxJ+/LaCLGlsQcc2pfGIytn/BaQ1dQ=;
 b=J/HCzJHQd55ZSWJPuBcp5i3Y7pHVrBQ9ebNc1U4azMduhoPR3azFw1Q+nrz6J/4B6eUJL6kw7xYwipvSqzUmVeL1kocDxj91LX23VzQDTZGSDu7l79p67CaZ/VCdEvyO8IUph1xWOR4aotIdRnp9fB0v4PGzsEKWlzZkxhsA6fNLAXp0r5UzpZL2w5nz8FtulEi428Qdw/oXLqEkPckTIXNoi5j5aF6WCSh60tRO9Rr9bSmFTj4EEQwc3zbU2olL9vbIp4ITJEiSGVLVOAJUKQMX8qzJx7z7i47FEMSQqc/68d/CfXgRDD03A/GDaqKicXPvBjPgVQ+vqpeOw6jjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DY1d5ZYrma9h0MxJ+/LaCLGlsQcc2pfGIytn/BaQ1dQ=;
 b=nJoSHTKUD+Pegeg9HfDX8FWA4yv+/73AgM2rilCo5dN6s2IaeRZ+6x/3TNJ6XFEuk//TXnDCpIFB8/BtbMioRbHt/i9eZL5W4tRuZSLn25iCK+QPJNc/dttsYCR6Hz7s+uFA2U6EehiGYCZereCXl0e7ulGBmFxRiPG1wnmoKywvE/t1AuQAZ03yd3AU2gDIgJxYQIcBDePvucf6C6sTwQ4N5eKmdjsT5m7JmtCEpwAGc1eLX5U+W7rL9yI3W8MEBuJPpnnWyu10f4VyS+og0z0YeAVHwFTo6CUAveUDwsiQE5w7GN/uDrct3HBc8zK/BMWF/EsSQZJTCtbe8l7Trw==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by DB4P189MB2311.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 12:09:14 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 12:09:14 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net] tipc: protect received keys from concurrent flush
Thread-Topic: [PATCH net] tipc: protect received keys from concurrent flush
Thread-Index: AQHdUNL4fDoo4smfgkOZ7OF8xZd6FLbqK6Lw
Date: Fri, 2 Oct 2026 12:09:14 +0000
Message-ID:
 <DU4P189MB37502D602C60A78B58AFDDA1C6892@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260930115708.349540-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260930115708.349540-2-Jeremy.Jean@oss.cyber.gouv.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|DB4P189MB2311:EE_
x-ms-office365-filtering-correlation-id: 8b2093a6-e406-49f2-a387-08df207dfa16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|18002099003|10067099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info:
 ns5hVbZPztCC/7n/SjPkoK545+P4xqqRVeLue/E5UE8karJQf+VjsPbGCrF8tg99CFN05Sfm6YSegmfmNv/CrtKYFf8GR/IS8Nc6N8hm7tRDE9nDFyALu2FatRebYKbb+iyXAyeQREMY8ilO8CaZvX+ilglYdjjQeWZj4SSXnIaIB2JCbVCQW6agsL9egXlSVzlR7waABj2hhbi1b1DLrCH8je6qMvrYcacsztEQHUTlT3gITpBz4m1VuDe28/YCPo9V9+e4HBtw5uC7O1ObTU8whW0m7wMZRG6YupMAXmXsDlLcHXsBnwXzgGLMBwkt5ySnh50T0nmjUmAJtE1Xc+wVz/8NibQHAgSX5T/eyi33mqKaxqCaNI4RkT7yYcpuWxIZB/ICqhG0lQuQDglu6gAHI3A0skEb59rWYCOz/C+rY1jwzuLogaVELeobVtraLzbAzMV6r9OBGhg+JnqyIbfI5cecGb1nKta2M4rVLi1g7rPD4GXBP44rqYjF398iS19t8HhcDtEAEEDVJS1ScOyknZa1nHVhQsIwd9GTxVg3uI0HzxKF45ETgule1ShuuCplD5nzed9wAeyC3p0zmJK2xMCRC5nQ8/9gltDznWeLjBS/lBNq6KkzQFAeF9RF186vhbBk5kB7Q9HzubX8SZLAlXnxcxzL8X+34azfo9UXOVesF97JrgTgbIycd95NKLuHlCrREI9R/AXqkr/fWkJWBPB+PGSQ0mRk4f8+mT0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(38070700021)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0tqT29iV3Zmc01hSTg2dmY3WGtHM3VSRWpPM2d2WnBQNm9CWEtTQkZqcWFl?=
 =?utf-8?B?WllpWXpMWFkwYlVVQ0VKRWRCcDk2RmJ5YUNtNGVkQ3dLSU5teDl6ZjRCM2sw?=
 =?utf-8?B?SFZlbjdDaDdBYmxGajh6KzdYT1E5Nm1pQUhXdVB2bEJ3di9yK3UrMlkyM2FS?=
 =?utf-8?B?enUwazlNYjB3OUNySTBsQkVxNHJCWkJrRndTVVJ1OUI2Zm1MaFNrWXhKWjU1?=
 =?utf-8?B?eW1DRWwwNTBWVFd3b2dtc2dzWUQ1SGtzOVRHb3VVL1gzenVwT1piRWZMOTUw?=
 =?utf-8?B?ZUNFRmtLTDBtUVNuSmVTOFNNOXk5VkdhZEVSbDRGQjRzTUFNSGY3aTFnWDJm?=
 =?utf-8?B?ZTdDekdsWVNEMC9sUHlQcklWOTBMMERCMDc5WUtPTGlVaW9pMHNTMTJoT21F?=
 =?utf-8?B?ZnpuL3VTVmpWeUs3aWpUYjNSWjlzdytOOFozWUx2cFZtYnY4anM2MkYxVlJT?=
 =?utf-8?B?dS9NRHV4RkNxOXRGNkdxUlFVekxWOHlmS2llUkVYQXM1R2c5aHkrWm91dFJt?=
 =?utf-8?B?YlN6MlFSaDVFU3Roc29ETTFoVW5oTXZHWDEvVFkvVXZTRG56T0hlNWRwVHFP?=
 =?utf-8?B?RE5rTEtIQzlIUHlhUTMzZEdXeXdLN3VmcEt1b2FENG02SGw5ZStwT2NzVlU5?=
 =?utf-8?B?ZlNxUlM0M0Fqd0JNU1NVV1pLcytMRm9RNkRqamdDUTExTTc2TkU5Tm94S2pW?=
 =?utf-8?B?Ly9Hd29qOU1QbzJXcSt3cXdhRTA4b2Nvdk0yaUN2eWYvTVJhS3Jja25VbU1h?=
 =?utf-8?B?UHlxZlkvQmM4SFRSdkdhaHhPLzIzYTMyTCtLVyt4ZGI2cjRTUzhZY3VjTDNz?=
 =?utf-8?B?cStMWlZ5Y25wWVBVYlVJSnNMMVY0a3RvekszazlIQ2tkN09oSmxqSU0zNU5H?=
 =?utf-8?B?Z2Q2STdBakllbWtyZ2JOMFdHaWJ2bFF4NERPeDl4NWlFeU1MODA3THByMk85?=
 =?utf-8?B?aTVrT05FYzJmV2ZGWUFHOWVBcVlJaGtFOVhEcUMwUndEZE96VGJPOFpPQTRT?=
 =?utf-8?B?TlZRSmdZYUpIdzJ1NjA4VnRpcllEL1lhNnU5YWx3Zm41aXNPWFhaR2JVMm9Q?=
 =?utf-8?B?OFdFQjNuN2dlV2ZkSUdDRUYvMjhGZEcvNG1xNklEQlNnT3ZqNFpRQmNRZUNY?=
 =?utf-8?B?QU5yOGE5RVNjdXd4Qyt3NmpoaXRtNEZFaWRNazB4c29LRUd6U21RZnBSU2NC?=
 =?utf-8?B?NmlXTlIzZ0k3K0hxRDNjM01Fb084ZUlPQ2wrZFJGWlVaNndzc2VBSXNIb0Vn?=
 =?utf-8?B?dkVOS2FlV3VKWHBDUWk5YVp2aU9LVXB4eHBKaXdHUGxyUU8xSTFjMWR6KzVU?=
 =?utf-8?B?alljaXVndVRpNWFSdHVNZzhzaHZtNVFrcGxJUlVyK3huVEhPeXd6SmRndWpy?=
 =?utf-8?B?WFBjUmpmOUduNENrT2psNk53NEo1UzJ6ZHRldlg0VVpuZW05cjdESjRtclBE?=
 =?utf-8?B?N3ZTTUs1N1VUUHJGU2tISG91VkRVY2tnaS9pVU5WZEZ4MzJkdGFpN0hQUTk5?=
 =?utf-8?B?L3VOSVFQUzhiQWdwVm5yUTlnbU93cHhNaGhRc1pOSzdUdmgyRk5hb3JnaWlr?=
 =?utf-8?B?OWVvOFhEQmVzSGh2QmREYzNhZ0JRZ21yT2p2eWx2cHpvSzJSWVpzQ1htb3VO?=
 =?utf-8?B?TmoySWE3TGR6d3p5ZGVGdFAyUUtQT1ZYSVJQc3Z4dU1PSXM0Tnh0NGdGSk0w?=
 =?utf-8?B?UmhqNTdyNHVuSHZDbjdyeW1tM01MWlpjaWhWZXlLRDlNZEJGTy8zQ2dtOUJR?=
 =?utf-8?B?V2t0ZG5MY25TYXVwckRwckp0NmxZeGlLNUMzUFVCejlyYk5wYU9heW9GREhD?=
 =?utf-8?B?QTY3aDU0QURkaXJuWXhpcDZ0TXo4VlFTT1NveW0xOWtmTXl1M2I2RjM0V2lX?=
 =?utf-8?B?akRaSEJLdkpqRGRsTWZSVFJyeWJNbHhjY0RPQkpTYndCSm9peWZKUW9HNjA2?=
 =?utf-8?B?VzJ5YSswa2N0eXhBRjUxQW1rVW5nMmtxci9YeDNqcVlmZ1l0VjdQSFlBU3g5?=
 =?utf-8?B?ekwzYzVEMGl4b3lyYlNNUTVJeDE4bDVEaXY4c0R5VGVXS2NFdHh2b3RkRkJD?=
 =?utf-8?B?VlhxMEFhZzRYR3VOaFhOMkV1VHRtK1RIalZzMDVvME5PM09jZEVGdVZsOUlr?=
 =?utf-8?B?Nm9SdXY0NW1GL0gyYjNpMklhZ3FhZFJZaVhOSm9na0xxVVBEcGhyOFVvQjk1?=
 =?utf-8?B?dFN4VWZFOG1hRTI0LzRnWm1nOEp1WElNMmlhYUNuekZvSlQ4Q2VxYXM4N2Zr?=
 =?utf-8?B?TVdnNFZYdFZzdUpyNlkzRVpRVEVrcmZKV3hHQUx4VTMxSS9WREtNSDAvZUcv?=
 =?utf-8?B?V0xrQjdaM20vRkpLLzIrM001U3pnazNyaTBVMHJDK3ZMNENMMG9Ndz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2093a6-e406-49f2-a387-08df207dfa16
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 12:09:14.8420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDo7ZrZVT4yniJF7T59pfUFDUCi1eGjtSVWWJ8nM5QT2xIVPamb3723cwHxKhYqFcYbfF9JbTdvql1/D5j8IT8WgVrcVi4NRuC9z1MPvnzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P189MB2311

PlN1YmplY3Q6IFtQQVRDSCBuZXRdIHRpcGM6IHByb3RlY3QgcmVjZWl2ZWQga2V5cyBmcm9tIGNv
bmN1cnJlbnQgZmx1c2gNCj4NCj50aXBjX2NyeXB0b19rZXlfc3luY2goKSBjYW4gcXVldWUgdGhl
IFJYIHdvcmtlciBhZ2FpbiB3aGlsZSBpdCBpcyBzdGlsbCB1c2luZyByeC0NCj4+c2tleS4gSWYg
dGlwY19jcnlwdG9fa2V5X2ZsdXNoKCkgY2FuY2VscyB0aGF0IHF1ZXVlZCB3b3JrLCBpdCBmcmVl
cyB0aGUga2V5DQo+d2l0aG91dCB3YWl0aW5nIGZvciB0aGUgcnVubmluZyB3b3JrZXIuIFRoZSB3
b3JrZXIgY2FuIHRoZW4gcmVhZCBmcmVlZA0KPm1lbW9yeSBvciBmcmVlIHRoZSBrZXkgYSBzZWNv
bmQgdGltZS4gUmFjaW5nIGtleSBleGNoYW5nZSB3aXRoIGtleSBmbHVzaA0KPnRyaWdnZXJzIEtB
U0FOOg0KPg0KPiAgWyAgIDEyLjk4NjA3N10gQlVHOiBLQVNBTjogZG91YmxlLWZyZWUgaW4NCj50
aXBjX2NyeXB0b19rZXlfZmx1c2grMHg0MDEvMHg1MzANCj4gIFsgICAxMi45ODc5MzddIEZyZWUg
b2YgYWRkciBmZjExMDAwMDAyMjY4MDgwIGJ5IHRhc2sgcGVlci8xMTINCj4gIC4uLg0KPiAgWyAg
IDEyLjk5MTkzOF0gIGtmcmVlKzB4MTYzLzB4NDMwDQo+ICAuLi4NCj4gIFsgICAxMi45OTE5ODNd
ICB0aXBjX2NyeXB0b19rZXlfZmx1c2grMHg0MDEvMHg1MzANCj4gIC4uLg0KPiAgWyAgIDEyLjk5
MjE1Ml0gIHRpcGNfbmxfbm9kZV9mbHVzaF9rZXkrMHgxNzQvMHgyMTANCj4NClBsZWFzZSB1cGRh
dGUgeW91ciBjaGFuZ2Vsb2cgd2l0aCBkZWNvZGVkIHN0YWNrIHRyYWNlLg0KRG8geW91IGhhdmUg
YSByZXByb2R1Y2VyID8NCg==
