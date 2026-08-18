Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3A3A5E6C;
	Tue, 18 Aug 2026 03:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787023914; cv=fail; b=U+fKOTSXcSDZ8xHg/bgES8wsA/ouZuMCCrMAioSLHCjA6RupEZcMRVw+FACsYJOqwmVoWy7IHzYUKaBT2gERbfA1QwW7FbFaMumOw29OQjlCgbDQ7MKIprmhNTloqQd+4k45nC5e7s/8hemF3V372L8w2yJS63tHlS5dVwa2ju0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787023914; c=relaxed/simple;
	bh=AxwBmE4lrSigCloKZBGfbYdx+hieJvU9U/YHCJQMpuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XiOfEgQunE0PQwHO8hNiqhYM/dJfaY3uiaEElbvrE0eFk/8z9m0wpF5mGY4HbxhRa5EBvBmMi+9GIbEoIRXOcfER3Zt5DCatTZzuaTkbXxUZS9HJvCYt3EZVD58+zNLKILasohiXNjncX3O1ZDBED+RFYAW74dvcEhFhdQ6YLZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v+7tj6Fe; arc=fail smtp.client-ip=52.101.46.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v+7tj6Fe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgB4qNXndJg7qZwRahU+mSiG1DBfr9uccmxTEZ0BEIP0buGfftOjbjQ6f4ymMNS3+r2vjvZ4/wFnpbzxssPa/9FEgxi7xQ8WvJTWaMP9xyQQ9dVyR07sbN03PL0DlS4t4VkMKGNMJG4Hf3aiGVZnAkwmQ1IM0Ap2nzphdAkYwHn740ijPlNQLXOsDuBQ+pzn4jmMYtz9N2kDS0HfrZcs+1CszuggNbGYgpA6E6ScR/kVJIgMJhlnk4HzR7xiM13otxUa599aBdhjhq/AZPf+TRNWTozXpKRDOoREdUuMChFspq7uRQNVvFAOKlOPcpKqU5xLc5uwGHgD+gOGDD2+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxwBmE4lrSigCloKZBGfbYdx+hieJvU9U/YHCJQMpuw=;
 b=vA4gmVuc9xWHG+U4O/ndY/SCvAqSSVzY+OrvVcUA0hvoMW3LZK2togONVGrRnxhMFyYvgvofC2dWozWMlLHT/ZLs2EPpBwLLAi67CEli/iSZSBfZQeYNkj42glLdM7cvpK4cbZ2wyqFDji3X5rHrRNJoT7/JvWhAgYbeq/H9TFCLetpa8Nk2L/ey7AKFvj4+lk2hedekgzfIrJArIAfoUCpF3OmPIblNPqqcsbCs5yKPyXLwt/KQBQunXtW+dcbx97EutOKgLrCg+UsNYlLXbrkra/rRb7ZUT5IXhJckv6FJHGREznZ8YvjMQXFDsIfavrXriUClbXa/OgVge3l6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxwBmE4lrSigCloKZBGfbYdx+hieJvU9U/YHCJQMpuw=;
 b=v+7tj6FeEFo3+T3meq+sJmhwt7N68bIQFzUr5y+4zR3nFgxZYT5YYpI2qtOHJGFb0S0oljPpuzD3UOja6JZmrIG0NHJjqzXJO5s+vAQKESk4lLJ2HG3Qt/GJKiO0Nmmks32JKEm0BE8UeJ7NALYH9n9yqCRFqOOzmG4L8RRpJWc=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 03:31:45 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 03:31:45 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "Frank.li@oss.nxp.com" <Frank.li@oss.nxp.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "sashiko-bot@kernel.org"
	<sashiko-bot@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"logang@deltatee.com" <logang@deltatee.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] dmaengine: wait for RCU readers before releasing
 dma_device
Thread-Topic: [PATCH v3 3/3] dmaengine: wait for RCU readers before releasing
 dma_device
Thread-Index: AQHdLZbfrgq8ByOFXEWCEvDyrfGGj7aiTn8AgADagIA=
Date: Tue, 18 Aug 2026 03:31:45 +0000
Message-ID: <3491f5895e3d3592907a12f75cf049609dd05964.camel@amd.com>
References: <20260816-dmaengine-kref-fix-v3-0-7e76187145df@amd.com>
	 <20260816-dmaengine-kref-fix-v3-3-7e76187145df@amd.com>
	 <aoMa1GTFd-R0Ep6J@SMW015318>
In-Reply-To: <aoMa1GTFd-R0Ep6J@SMW015318>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|CY5PR12MB6298:EE_
x-ms-office365-filtering-correlation-id: b643dd8c-583f-4d86-82d6-08defcd93a9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|13003099007|38070700021|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 wn4dNoFBeaw7W0aqEz1Yoc/oRLNNUVspU6Jhl+Vcp8Gnh/RIsK6NKGBDDdo3RdPHvTtDmGv/mAOkmY0GD/6oJOE4Iy/wcbDxF6QVRpz5+2uYHt9SBgJ/4oYuQ5GgfU603ApHm9SuIZa99pAHtaYVGWfrPfr6F0DWCQf48Nm3oRBEhe2swrbhwePiTbSo7k+sJKg3PT5BKqeZnFMXKRM9/hrbgmKh4zQjaV6E3DjKCbW+ULiVfLRPcSNe0pxxHyr60qW2lqj/Al/AaTVkBSia2cCOe+niYB7AXeZR0t9dV6t6V/r7gE+UFoeCUuUXFXACSbAX+D4eGK+kF+nZXxtTSdM3gqca0+S4qvkp3BZqI1o3t2ewhx4Mj1k+VAfCz8K0ZYg7ZWJ8gmzUDCgBI9vkgRNMEGJV9ZKlwsJXMaZQQZBv2ZcOzqkGCxQA78bM0JAZI4F6BgyupAhnKkDcD3FHoFa01tjznrO+IvYZ1TbZQUjTfitI7gYalj2KlKL16ps1AgCtH0NkPgmbpqzj2+JuvffJA686y+gHX35hcls4VkNwWkgTwpntMSus/CU4Rw82Rr+z0cCpa4jIlKf0P8e6k+7EVelzY6JKub3UlcNdngGv1roIknT8OkV8TonQ6hqu0RbBqEyn5XvNnkiM6n9iQzrmvj23MrTiMaIsyUJh8fM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(13003099007)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzhyS1NmWldFSFBjOXJidS9RTG43RmxJb1dCcXl5TFh1MTN0Y0Q3ck1pK0VI?=
 =?utf-8?B?MmlTTGxkVk5VM0FOQ3lKUGhyMVhwZ3IwKytjemYzKytXU3UvUEkrc0UrZ2Z1?=
 =?utf-8?B?M0R1aFBNbnJiTjlWcUlweXFVMFM0K1N5T3Yza3ZFU0FnMU5FVGpSWWsxWHdT?=
 =?utf-8?B?WTZFR25oVE9sSnBhVlIzZ2pib1lIOGMxTkhERmp3anhQQmFaK1VvTlhBbGN0?=
 =?utf-8?B?L0NBOGY0dEJJVWpVN1VGaUpMUFJhdUZPRDdXT3lURnE1a3NLdkRHd3VXVkpH?=
 =?utf-8?B?YjBYcGRLNFlJRXQ0V3BGcFcwRWV5WjVvOGFDb1RYZWJrTThUM2wySThVZGk5?=
 =?utf-8?B?UHpxejNXQ0d4MnQ0OFNpNUtEcy9QNTRTSHFRV01NbUNqYWNFamJwZUoxRjk5?=
 =?utf-8?B?V2RiU1hPMjBzQXZQdmV0bTh0TFQ3emRGWFl6Z0x4LzVDOE9vdGNCbm5MaFZm?=
 =?utf-8?B?RkJqQUkzVG0zT3RJN3Y1TEhkSEhsakJ5eWxUNmxEMjh0a1ZSVDhnaldaclpw?=
 =?utf-8?B?eit4OW1PMDdaUG9oV2dBS20vbWUvdEpscXU1TzdQYTBUWmorZi9DcFhhUFZP?=
 =?utf-8?B?aDZBcU1vMTNrVytEdGkxdmJ5M3hPZUxTeGhtR3Z5ZUI1ZjEzVVJTZnNNcVg1?=
 =?utf-8?B?SjZIZXU0ckhLZEtWazNIVnRkcUFGVzhTWCtITFY5Q2JnRjBqQ1BoSTlsWmZy?=
 =?utf-8?B?ZUY0cWVsWktEc1ZldlJhclpxK0o0QzRxTUdJV0pySnhTNGxsYmwvcHhJTXl1?=
 =?utf-8?B?dmZSOGhHTmdjMVVxRGtad2lXcGg4RThuZUNoUXJiVXJyeGFMUTFYb1diRWZK?=
 =?utf-8?B?K28rN3FlbzAwUHFOVk5HZGlEZ2FsQm4rNERCUDZiWmZzS3U3QkE3NnZZcGZW?=
 =?utf-8?B?NXE3RFQ2MlJxckJ1SHhCVWZ2NUlOWGZpRDVFWGc2eXNkajQxRndBY2RLMlJj?=
 =?utf-8?B?a0lPcjYybUJ2RVhpbzBEUkdhYkFzYWJjMmxhSXJHa1owMDdhZS9FQnA2MklQ?=
 =?utf-8?B?VE5mZHF6ZnZHUjE2ZWJ3WmdCdmtIakpQTFp4RjFlU01YWkJ3b0FtUy9xN2ZF?=
 =?utf-8?B?VUxFSVp2U0p3UHpkbjE1YlY3TTdLN2NqRkdoRk16UytKZ3ZieGYrM1NlWm40?=
 =?utf-8?B?YWZnVm5aR1dMVG9NQmt2bHdlakRkMnZ0RXRWNWx4TU5vazI5aUJmVk92SDEv?=
 =?utf-8?B?cFlLS1Evd0dXWENNUXJtQlIyeXJUL1lId0pFdlpaZEZHSTIwVW1pcmd2dEM2?=
 =?utf-8?B?TCthblErUm9zb3hnYVBqZDFiSWw1ZDJQdFpnMzBxd3BUY0dTa0NycFZLRVZE?=
 =?utf-8?B?Qlp1R0grdG9ZVlV0a0dMODZSMWthRFpFYkN2ZW1ObG9WR3lPYjZQaUx3MHJn?=
 =?utf-8?B?djlLbjk1WHNwTXBQbm01ejF3ZWMwMEdzYVN3YmxaWkpTSSswMCtDcXltTTVr?=
 =?utf-8?B?clA2RVdhN0lGNXdoWkgrTUd6Wmp5Mlk1TEtGZy9MWnp2SnFlaUhuYVZPVndC?=
 =?utf-8?B?aUZtQnlnK0diMzFwUTljWG9aeXhUcFA4R2RveHVFbjQ1TjRYbEw3WE55L0pR?=
 =?utf-8?B?bnRLNUFTaWNIQnRZSnpYZDU3Rm9LVmszcHJiRFUzRlRYbmY0SmtCcjJEK052?=
 =?utf-8?B?akVrOE5ZbVBEOHdHeENXOFRHR2U2OXFLRUVaZkx4NXFNYXpRVGJhZlFnbzJZ?=
 =?utf-8?B?dGh1ekMzV1d5Q3J2aURXSG1KZEgzVDJBR2o5R0dBbTJNdjNuVklIS25Oc2Z4?=
 =?utf-8?B?TWFBbzBIMVVpdXVEdlh2b2E0MDNiWERqb3ppM1lwV2FIaG9pVy8vYUpKYkFR?=
 =?utf-8?B?cnFNQzhCNzdqd1g0NlZ1WjNIL1V6ZG1Wd0tXNFdkbXJtRDJkc0Q0cE9pYzRk?=
 =?utf-8?B?R2V3S3NlNzZoa2gvOEYxRTZ1SmNtc3pSb1d4dWFwdmdobVVQSjJ1cXNnbG9W?=
 =?utf-8?B?QkJXWHhwR3FZYmFLNkUwSTJqYlBPbmhlenM4em83ZUk3amwxcGoxaEdNOWdC?=
 =?utf-8?B?RkJheUlHNXJ4V29udktlTVVQUDJDdzFiOU5oTGd3eFM5RWxMQTFla2FEVVNW?=
 =?utf-8?B?QlpYQmpPOG1adzVXaGFwTkJnb09GemliVi95ampZUWZKZDVtMDZrRTRIeG1C?=
 =?utf-8?B?dE1KVERhZ0RTR3RHTXhoRlhoYi9nS2NXY0Q5Z0xvQ01PYmg3alp6ZzlhRlVq?=
 =?utf-8?B?YU9rMXhMUUVXbTN6VEoyS1lPeXQ4MXNielFtMFVUb1dIa2lkdzVHcktkeTkw?=
 =?utf-8?B?cjhHdDBocHJWR1FVU0hQazQvOGp0STdOR3h3TGx6MWQ3MGppUTk2YU8zRkdp?=
 =?utf-8?B?dzN2WldzM0dYZE56eHdIeVJ4Qnl4eG1WaXVCeDdvaVJXTEJrL0xQQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C90E554073CCC4D837FE337FE678C49@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b643dd8c-583f-4d86-82d6-08defcd93a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 03:31:45.4106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ez59jVvfd3Bx78hkp0Jh1laNEvneoBmyG6swowlJSCLyJChQckV+2oJEBaKG4ixwgC8qqbo/EbwB08UlkXnNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298

T24gTW9uLCAyMDI2LTA4LTE3IGF0IDA5OjI5IC0wNTAwLCBGcmFuayBMaSB3cm90ZToNCj4gW1lv
dSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBmcmFuay5saUBvc3MubnhwLmNvbS4gTGVhcm4g
d2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJ
ZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBPbiBTdW4sIEF1ZyAxNiwgMjAyNiBhdCAwMzo0OToyN1BN
ICswMDAwLCBTaGl2YW5rIEdhcmcgd3JvdGU6DQo+ID4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1h
aWwgZnJvbSBzaGl2YW5rZ0BhbWQuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQg
aHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gPiANCj4g
PiBkbWFfaXNzdWVfcGVuZGluZ19hbGwoKSB3YWxrcyB0aGUgZG1hX2RldmljZV9saXN0IHdpdGgN
Cj4gPiBsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdSgpIHVuZGVyIHJjdV9yZWFkX2xvY2soKS4gZG1h
X2RldmljZV9yZWxlYXNlKCkNCj4gPiB1bmxpbmtzIHRoZSBkZXZpY2Ugd2l0aCBsaXN0X2RlbF9y
Y3UoKSBhbmQgdGhlbiBjYWxscw0KPiA+IGRldmljZS0+ZGV2aWNlX3JlbGVhc2UoKSAod2hpY2gg
aW4gbWFueSBkcml2ZXJzLCBzdWNoIGFzIHBseF9kbWEuYywNCj4gPiBkaXJlY3RseSBjYWxscyBr
ZnJlZSgpKS4NCj4gPiANCj4gPiBCZWNhdXNlIHRoZXJlIGlzIG5vIGdyYWNlIHBlcmlvZCBiZXR3
ZWVuIHVubGlua2luZyB0aGUgZGV2aWNlIGFuZA0KPiA+IGZyZWVpbmcgaXQsIGNvbmN1cnJlbnQg
UkNVIHJlYWRlcnMgaW4gZG1hX2lzc3VlX3BlbmRpbmdfYWxsKCkgY2FuDQo+ID4gYWNjZXNzIHRo
ZSBkZXZpY2UgYWZ0ZXIgaXQgaGFzIGJlZW4gZnJlZWQuDQo+ID4gDQo+ID4gVGhlIGxvY2tsZXNz
IHdhbGsgb3JpZ2luYWxseSByZWxpZWQgb24gY2xpZW50cyBob2xkaW5nIGEgZG1hZW5naW5lDQo+
ID4gcmVmZXJlbmNlIHRvIHBpbiB0aGUgcHJvdmlkZXIgbW9kdWxlLCBhbmQgdGhlcmVmb3JlIHRo
ZSBkZXZpY2UsIGZvciBhcw0KPiA+IGxvbmcgYXMgdGhleSBtaWdodCB0cmF2ZXJzZSB0aGUgbGlz
dC4gQ29tbWl0IDhhZDM0MmE4NjM1OSAoImRtYWVuZ2luZToNCj4gPiBBZGQgcmVmZXJlbmNlIGNv
dW50aW5nIHRvIGRtYV9kZXZpY2Ugc3RydWN0IikgZGVjb3VwbGVkIHRoZSBkbWFfZGV2aWNlDQo+
ID4gbGlmZXRpbWUgZnJvbSB0aGUgbW9kdWxlIHJlZmVyZW5jZSwgc28gdGhlIGRldmljZSBjYW4g
bm93IGJlIHJlbGVhc2VkDQo+ID4gd2hpbGUgYSByZWFkZXIgaXMgc3RpbGwgd2Fsa2luZyB0aGUg
bGlzdC4NCj4gPiANCj4gPiBBZGQgc3luY2hyb25pemVfcmN1KCkgYmVmb3JlIHRoZSBkZXZpY2Ug
aXMgZnJlZWQsIHNvIFJDVSByZWFkZXJzIGFyZQ0KPiA+IGd1YXJhbnRlZWQgdG8gaGF2ZSBmaW5p
c2hlZC4gS2VlcCBpdCB1bmNvbmRpdGlvbmFsOiBwcm92aWRlcnMgdGhhdCBkbw0KPiA+IG5vdCBp
bXBsZW1lbnQgZGV2aWNlX3JlbGVhc2UoKSBmcmVlIHRoZSBkZXZpY2UgdGhlbXNlbHZlcyBvbmNl
DQo+ID4gZG1hX2FzeW5jX2RldmljZV91bnJlZ2lzdGVyKCkgcmV0dXJucywgc28gdGhleSBuZWVk
IHRoZSBzYW1lIGdyYWNlDQo+ID4gcGVyaW9kLg0KPiA+IA0KPiA+IEZpeGVzOiAyYmEwNTYyMmI4
YjEgKCJkbWFlbmdpbmU6IHByb3ZpZGUgYSBjb21tb24gJ2lzc3VlX3BlbmRpbmdfYWxsJyBpbXBs
ZW1lbnRhdGlvbiIpDQo+ID4gU3VnZ2VzdGVkLWJ5OiBTYXNoaWtvIDxzYXNoaWtvLWJvdEBrZXJu
ZWwub3JnPg0KPiA+IExpbms6IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDUy
Ni1kbWFlbmdpbmUta3JlZi1maXgtdjItMC0zZGY2MGFmYWMwMWRAYW1kLmNvbQ0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNoaXZhbmsgR2FyZyA8c2hpdmFua2dAYW1kLmNvbT4NCj4gPiAtLS0NCj4gDQo+
IFJldmlld2VkLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gDQo+ID4gDQoNClRo
YW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KQmVzdCByZWdhcmRzLA0KU2hpdmFuaw0K
