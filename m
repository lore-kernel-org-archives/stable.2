Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED31C47AF69;
	Tue, 18 Aug 2026 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070489; cv=fail; b=lEMXqkTHIRdwGdTiaBJ1OfdNuQfeN5xm+Cny93zOwDYEVheEWPEu1gWBHBMhwmO7+3J/bD2nbdX2xdR6u4xueHLotc+7JV+gxqJyGNxhgxzKKIXjE/KshhEgR37+yyERTl4zagr9TrwOcyh+o6kFdA5fAfYWEdbtxsU4LGi3hC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070489; c=relaxed/simple;
	bh=b3YtshLd0LpkftAkg2sRrN2T2D8iQ+H8cfzwURSwPMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A0b4qJZFBgEMmEjsSz+IZngzs+fU+BWxhoSjBtK6s0OqbjG2G2KjLU6eAZHDXN2D03btvuGi/XbBxs+njG9aRuCYt72wVWcAXqHMjnSdXnD1MG+Afa2htSu1sRDjkUEC/0dlhEOxsZNqds9g4OdqbY8ETiQDPpTjKDC+gFeWdPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HWrZOXJf; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HWrZOXJf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8EIatOQFxINGuOuu1rQRcH7jHJGQ8nTRLCbWK3NHjQYni55HLPlTmqOghkGcTlk4Zh4waK5vgyffSZovbMLx4HmmXPXCG8DKg824w86Z3WiCpXjhSoxSyoHFKIN13oZs8e6DcBR/Aybv/6n6DfFErSbkxGCOatUMxnoKext3RkS7dWxmiHRwZNf/iN/Nig029hyJ0MfLKebKpoqo4KgUnkToq13/hd6j16IbXmO1ZeALCJ/2WlY2XnCGmn3GvFhrlqHq/Pa+R1xEu/KpZ846Tk5jcvqUFfAJVlY0x8jenqfm4+grIVsRM6xHy31t2QHLZh30rz4uUwv5w3KrVTC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3YtshLd0LpkftAkg2sRrN2T2D8iQ+H8cfzwURSwPMw=;
 b=UbhCt9QVvcQd2UQBZf3zjL6YlHg2y7Oe/PkozXnCRWEhgcl9uSXCUyeafau+KETVlgMCDmFiRsrODnpdgFPPX2ijMTHdT5K6Zty3ENJRASE19oz/59PxezhFTseJCQP2rZUJrX8F+xUdnyeTYQv6s/aN0Oi8HnE6y1C2c591EODMkr3NjUQNOMtYjoqnrwwBNU2STOSWEbXmVMPRC457hM/Ovg++bQq+3QhWrZo8cEpOJqk+l3lWLfiDrr9yjuAdkEw2nKawAFafSG2qI6j8JDxHfay8n2ubT1NOrB2d1DdjO0T/fxKlcD5rKFkXApApdovct442oiZfpD4vv6tHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3YtshLd0LpkftAkg2sRrN2T2D8iQ+H8cfzwURSwPMw=;
 b=HWrZOXJfmq/oQl2Et3DEUMAW+xwMKrrEtv0SygpYnLl9T68l4+76h1hfKtGrURMQhAM1rrb1TsnpKpoj5ZEqxLJSMDsIOqGmasGlSVGL0CFOHFeHuIb7FBZlYEq/yVpg4AQoyxW3hBuIMIMHtxPGlQmCbgI/K8c3YYg32R9alf4=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 16:27:51 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 16:27:51 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "Frank.li@oss.nxp.com" <Frank.li@oss.nxp.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Frank.Li@nxp.com" <Frank.Li@nxp.com>, "logang@deltatee.com"
	<logang@deltatee.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] dmaengine: add dma_device_get() helper
Thread-Topic: [PATCH v4 1/4] dmaengine: add dma_device_get() helper
Thread-Index: AQHdLsQMANYJobyGC0S0WZ+uCvA9B7aj+0SAgAAEOIA=
Date: Tue, 18 Aug 2026 16:27:51 +0000
Message-ID: <8f748d2a4773cf526647f20d60e665a1680ce8eb.camel@amd.com>
References: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
	 <20260818-dmaengine-kref-fix-v4-1-c6ef991462a0@amd.com>
	 <aoSEe2FujhG6J0iD@SMW015318>
In-Reply-To: <aoSEe2FujhG6J0iD@SMW015318>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|IA1PR12MB6329:EE_
x-ms-office365-filtering-correlation-id: 24deebfb-1462-4b3a-91ac-08defd45a62f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 /if91MH0Nev04vmoCGSg2irRmFe/ym5rzGIHHpHP28MBBj4FUc57cTMoCDqFxYFEmnf+/uiz27mkz+7yf1w2HjzJ84yHuIQ3TQINxvrYpTYMW4K7HtqYMlwR51Ek4cIxkdmRDEHuXHAtMyvqnjN97KUuFVh8ZaC6OCt8sdVZJtAu/12s4rN2R2KdvKjoR4Ze0fxbOrHG4en/3jHW1yI9WBxYKq9QcHBw/68yFZ0nCZd1P2zWK3NdJEub/LvqFmxyRPQCDpZQ86JEdkWBheL/bZ6HV8N2u7sWGaaKNcYJgxnw15AB1105pC1pYi42Av78bEcglDoXuqjo8atup3zTNIzOWEkiqyr9dqZR9181GuQCpP9yw4xYjzR7hfMDOI+8tZgs/xwGoSsooem2nh8f1DSIWjZOMYU1c9T1O/f4D6LaT8pML4AGbU1boZX0tfMxcB8xloXRcmqVjntRFFf0UCqPQeYMHU/oHut5MyxewaDTbrUVhf+SiJKeoWVKQ3BWaUzl0GpX4FysGwORBhqxL4kXf5+9H9aNJmI2p93FjOtSoDYMotPYfOX1MvEcTehwTKkvQ3ZjHIcqEJ2MBAQZm3/Gn4p8B0pfPr6UjDSJS1sus87u4DIFlao4yGGANzrmj0s0b1UK4bY81elmMYT6Xn8PjEnYCJixzUXaBK7l6O8ezvuG91kF3FuC/pPRtGKr9vuOfQJ408r4cvCJ/uF7vCGevdhpcvtFWCkYcZyIC9Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGJmci80aXQzbFVRbzAxcHNlWThPckdQN1JzV1EwWVBmVm9qck1wekdBTVVN?=
 =?utf-8?B?M2dvdnJyWHJ4YUJVU3QvYWZqc2RaYmY5aHM1MUJSeUoxWkxGdE1OdDJnb3Ir?=
 =?utf-8?B?ZmE2clliRVN6QlpQSG1hUk1rQndnSEEvcWFjYTZDb1NRWUlzWVhGUUVid3ph?=
 =?utf-8?B?aEJYN1lOUVl6NlhoaTV1am5JYUdQVnZlejd6Znk2alR0R3BUZ0wrcWJZbFNW?=
 =?utf-8?B?Q2w1bzVUSHArbjNXaGVVdGVOTFFqYW93dFdnZUl0U2VMT2VTZVk3TS94Rk1W?=
 =?utf-8?B?TTNUc2FyTDFRSnpuSTF4dnp2a0NNUWJibWVXK0FQc0N1Ti9VaHRTZldLcDJv?=
 =?utf-8?B?Mk9BRkUzMUo2Y3dQeCtlNWtaTzJYdm1jMjB1NitnU0tRRVBmU0dnTnNIclJD?=
 =?utf-8?B?VE5vNlFnOWdkRHBzS2doN1JHU1hnRE01YVFOOHZyWjZUa3FHUHNjTzEzcDZh?=
 =?utf-8?B?a2c3MlN6aXpheHQwQkRPbFlEdDlibFZXSUI3TFJkWXdhWDR4STNVTGVPM05q?=
 =?utf-8?B?Nno5L041Qlc3SHhKaU1ic0lqbkJMMnVlMTNta21SY0FGcUo5TGNzV21JMGtU?=
 =?utf-8?B?ZVdiSlVVUGtDS2kxaVo4amtxNEEvRzNWSi81cW1uWkEwMThUUHdWbkFRQ25p?=
 =?utf-8?B?WWZYUHlYMXRxcTZjOXFSKzBJMVBsR0xJZ01yTzJ2aUlaL0pzcEpOS1hIVkhl?=
 =?utf-8?B?a2RnUEFUUzhsK05qc2IxQ1hpVjVJa1FoMUFHalNpQytCeXRDS0FvaWxvNldT?=
 =?utf-8?B?SVk2Y1lIVDR0N1M1bWRqY2VhL0VMNEZWTjNrUlZoYk9iMlEvTkQxSzd6WG5o?=
 =?utf-8?B?QTE2N20rNzF0cFBFN2RnVll3Mk1Bd2dHcTVkWWxqRHA5NWhWUzNhaklCNWVh?=
 =?utf-8?B?ZHdTcTBQRm8xRVkrRnI5WVNlTzhLeFVBSWV4a1ZFWnA2ZCsrYlBJSmxCSE9E?=
 =?utf-8?B?RkxEeUdtbk9WWnJwanNVankxSjRZem9pS2U2OHpRcTNIMm8yRzdxbVBWd0Np?=
 =?utf-8?B?bWpzaEE0Y0RuNk5pNnQrU0MzekY1bTBKdzh2R1N2RGdFaGQxZGxHWjJ2bWwy?=
 =?utf-8?B?Q2NOc25sc2VnNGMxM0ZqN3ZSbG9KcEpqaFFWekJOOTJsMkdyZ29qb0hrZVpT?=
 =?utf-8?B?S1hNWWZPRm80em8xSHFCSmpmSytzbUMxdWcrSHlGV0xyRCtjRk1TY3V5cnU2?=
 =?utf-8?B?aU9maldhalhJQjcyR1pIZTgrUEh0eFdVMldTSitTMXFVcXliU05RMitZbG5F?=
 =?utf-8?B?QlVEYitSOTNJWGNPMG5pRy9WdHV1ODVtd1pJQXovMThxTzlkZjFHWjArVUcw?=
 =?utf-8?B?RkgwUnZaTFFhV1pub1Jncm1GcmZVOU1xalRpYVY2UVd2SkNza3h6K05CbmEx?=
 =?utf-8?B?eWhGcG5xN2U0NmRqMGRKMHcrTjI1Wnl4M2YvdGxmTTdEaSs3MUMrNXhUeElz?=
 =?utf-8?B?ZkYrcE9UQitKdEZhQWxTc1U1dGNHQStTUnF2UmUxenY0amR1SkNjR0tsa240?=
 =?utf-8?B?bU10NU01b1daeGljdTdSUS9DK3NhVDY5eWxxRlF0MFN2M3AwdVh3YWJuK3A3?=
 =?utf-8?B?Sk5TSGNWUzI3U2pyZ1pZbno2ZkhZVkpvTlRESFpodkpwN1ZQWTVpYjBuN25O?=
 =?utf-8?B?cmR1K3RwWEhSdTlzdnhXUkRQVzAvUFhlUDZzcEN6WWVoLzU5cWN6czVkN1hX?=
 =?utf-8?B?TXQwOHV2YWQ5SU1oUTVsWXJYUWZ5QUEvUUNuUG80QTdWTkdBS2VxajA5d1Zh?=
 =?utf-8?B?T2IxZ1AyUHBXYmhQRkpCRC9jdUJzd1JWdEMxSG5LSlNtaU01djkwY1B0QWp3?=
 =?utf-8?B?bDFQaE5xczBjQlZwMHV5SVJKSzhhUFhtSkFBWGdjRER1M2dSR25QQkFDNWFQ?=
 =?utf-8?B?Wm5TWXhPcjBveXJMaVB1UmVzdHg1d2NseWFHbWhlNlpmSkpTdjlpSS83NzlY?=
 =?utf-8?B?TmozNnR1eU5PQXdsZUxhNDlXTUN3Z0VQRSs5VklhRDl2ZnVxYWZSSlh0OEp5?=
 =?utf-8?B?ZTlIRE9oTC95dzErS05OeVRIRW9ZdytqUW1JRGRTMmJ0MjQzNlk1Qy9IK1kr?=
 =?utf-8?B?UzROOGNaRlQ3M1llbUZjZ1JnTU9RY0xkdnpsUW16bmlGSTJ3a0s3RjVVN3BO?=
 =?utf-8?B?ZlJFZ09PZFJkaFdrbWdCQnQvWmhwSEpJdnUyYlFUQnRZV0p5QUFtbGdxYWs2?=
 =?utf-8?B?RjlCR2svYVJhMGxmcjdwYnRsazNlNTdyYUluZW1IRUcyQ0hCQ3hqTVJpeWYv?=
 =?utf-8?B?ZWVwbDhGTTRLOVdwSDFhNXYvTWwyU0IrajRFcWQ0dUxTSTByZlhKQ2NYMTNT?=
 =?utf-8?B?ZzFhUUwxcGlraExURTJ3bHl6QVZyenZkOXVkcjB2TUlVaUFzL05PZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D3FF049619CDE4495261A1E8F597ADA@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24deebfb-1462-4b3a-91ac-08defd45a62f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 16:27:51.5373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdWS0cQfz69LiW30cUDC1Ide4P/gQXoHbV6f1fynUoogaSCJX6SDT4cSk8hJ5DnbfcZl7PAqoxhvsCwRNuR9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329

T24gVHVlLCAyMDI2LTA4LTE4IGF0IDExOjEyIC0wNTAwLCBGcmFuayBMaSB3cm90ZToNCj4gT24g
VHVlLCBBdWcgMTgsIDIwMjYgYXQgMDM6NDM6NDVBTSArMDAwMCwgU2hpdmFuayBHYXJnIHdyb3Rl
Og0KPiA+IEFkZCBkbWFfZGV2aWNlX2dldCgpIGhlbHBlciB0byBtYXRjaCBkbWFfZGV2aWNlX3B1
dCgpIHRvIG1ha2UgY29kZQ0KPiA+IHN5bW1ldHJpYy4gSXQgd3JhcHMgb3Blbi1jb2RlZCBrcmVm
X2dldF91bmxlc3NfemVybygpIGFuZCBhc3NlcnRzIHRoYXQNCj4gPiBkbWFfbGlzdF9tdXRleCBp
cyBoZWxkLCBtYXRjaGluZyBpdHMgcHV0IGNvdW50ZXJwYXJ0Lg0KPiA+IA0KPiA+IE5vIGZ1bmN0
aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPiA+IA0KPiA+IFN1Z2dlc3RlZC1ieTogRnJhbmsgTGkg
PEZyYW5rLkxpQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hpdmFuayBHYXJnIDxzaGl2
YW5rZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2RtYS9kbWFlbmdpbmUuYyB8IDkg
KysrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2RtYWVuZ2luZS5jIGIv
ZHJpdmVycy9kbWEvZG1hZW5naW5lLmMNCj4gPiBpbmRleCA2ZmZkOGJkODIxNTQuLjc3NjM4ZGMx
NmU3MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2RtYS9kbWFlbmdpbmUuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZG1hL2RtYWVuZ2luZS5jDQo+ID4gQEAgLTQzMyw2ICs0MzMsMTIgQEAgc3RhdGlj
IHZvaWQgZG1hX2RldmljZV9yZWxlYXNlKHN0cnVjdCBrcmVmICpyZWYpDQo+ID4gIAkJZGV2aWNl
LT5kZXZpY2VfcmVsZWFzZShkZXZpY2UpOw0KPiA+ICB9DQo+ID4gDQo+ID4gK3N0YXRpYyBib29s
IGRtYV9kZXZpY2VfZ2V0KHN0cnVjdCBkbWFfZGV2aWNlICpkZXZpY2UpDQo+IA0KPiBQbGVhc2Ug
dGhlIHNhbWUgcmV0dXJuIHR5cGUgb2Yga3JlZl9nZXRfdW5sZXNzX3plcm8oKSwNCj4gDQo+IGl0
IHNob3VsZCBiZSBpbnQuDQo+IA0KDQpUaGFua3MsIHJlZmNvdW50X2luY19ub3RfemVybygpIChh
bmQgY2FsbGVlcykgcmV0dXJucyBib29sIHRvDQprcmVmX2dldF91bmxlc3NfemVybygpLiBJIHVz
ZWQgYm9vbCBiZWNhdXNlIG9mIGJvb2xlYW4gcmVzdWx0IHZhbHVlLA0KYnV0IEkgaGF2ZSBubyBz
dHJvbmcgb3BpbmlvbiBoZXJlLiBJJ2xsIGNoYW5nZSBkbWFfZGV2aWNlX2dldCgpIHRvDQpyZXR1
cm4gaW50IHRvIG1hdGNoIGtyZWZfZ2V0X3VubGVzc196ZXJvKCkuDQoNCg0KSSB0aGluayBJIHNo
b3VsZCBhbHNvIGFkZCBfX211c3RfY2hlY2sgYXR0cmlidXRlLCBzaW5jZSBrcmVmX2dldF91bmxl
c3NfemVybygpDQpoYXMgaXQuDQoNClRoYW5rcywNClNoaXZhbmsNCg==
