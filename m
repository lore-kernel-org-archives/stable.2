Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89AD47A0B5;
	Tue, 18 Aug 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071476; cv=fail; b=N8H8seHBoop1E8KM/KqeqZBMsljRnUByWsHT3DH4LKe0WiJAuEjtdtS2ybpLVE+3XqmPh1htmCyPsLVI6holdbeINPutpfxbGw0YoM0KsONICUvtzh5wTcjT3g5jtwgFtafNAvyrNpjveTnbYTOqNLiESTGwVdP3H3H+CoAQzgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071476; c=relaxed/simple;
	bh=ArAkx+PXFEaDX2fRQDDTyyFZbGslLv53GztaCSG4usw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=taJQVC07tM0Fq+t1axg0Ci4XXZ/ABPFe1tkoT+PtXYHD2/QfdFojyrWd10c71thpYVE10qGQbYHK0/E4XXtmG288MJ58VYGUVzUrKFNU2SajWTtKiRv4IyroXxHnIlpypgOlzVWEAtwaRZq8Iz2LeF2O8QsMJugkoMTV8tISGsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yfqngqf9; arc=fail smtp.client-ip=52.101.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yfqngqf9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHwo5c5K82+ZRJmHz9WpBtsHdXAP47dDMcQCz5j3eU+8NV5zeSBS72TMYx2zTOrLoIh6nfh32eM1YSyzjhq/bELBWHvQXRhcv4u7zjw24zwQrLK5EyMfSmJ44YZLvbdM5qrUQg8weYjgXuGgKnYZVZQAXlCpKHspYdWePAMdgPI57sahi7I+Szxigby78Qqx6zBWXgdhiu3dpiPXjVHCiHerJrbMc1AVIHh/h7Wg3VRUs42yCfSIEzIRMyLJeOMsd81e4+HWSa+NK6rFP5uErNF/fEA472fjSFULnnYlrkTdxJswfqZO1SDw+c2D6sPzWRXLhKqVuUt6J6tKSDqs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArAkx+PXFEaDX2fRQDDTyyFZbGslLv53GztaCSG4usw=;
 b=NHpyTxZ8yRqFY1s5RptESadVfH4JIZIkJWTtToNUdqoggJ2OYbNXCjnf8/c/rkJva1v7DOiet4qx2IGxUxDHKvWQyRpIGWha9hU8MDeoUDoktBp/wlh6kICpPLkikaxG2n346Ggt9SoMXYko7xmOAmBDQwSxpgfp22BeFvWOpIGz9TG1iE3+SIGhVnPoQVkLtCxevzgORV7Iu9ncTullDxETRZwbdB5AtJqhyYdFS6Z5ECyQIlRYXZMvbbaX/iU0jQYMecUFULSR+MMMug/ARwApxPHgzf3uOWOKw1xf0j2iZCUzaZe5dIsoxWJ/Z07wOkjF5HvJzv4ABxF2wgeL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArAkx+PXFEaDX2fRQDDTyyFZbGslLv53GztaCSG4usw=;
 b=yfqngqf9klDG9e9nv1vHWor5SLy2WJ62ssTdftAQMprz1iFqm9LpbzsofQEjtp5qp5U+2noJf5OloE9oql6eG1UUk94N7Rps/cKxBd75EjFno3TJeN8jkoPrsjObdnSBrDWO5Sayb5vPyHSz2EtagTcki6w3MQ/OMxfmYyo4PsU=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 16:44:31 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 16:44:31 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "vkoul@kernel.org" <vkoul@kernel.org>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, "logang@deltatee.com" <logang@deltatee.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, "Frank.Li@nxp.com"
	<Frank.Li@nxp.com>
Subject: Re: [PATCH v4 4/4] dmaengine: wait for RCU readers before releasing
 dma_device
Thread-Topic: [PATCH v4 4/4] dmaengine: wait for RCU readers before releasing
 dma_device
Thread-Index: AQHdLsQPKkopLxtOiUKyMU25b37lvLaj/dcAgAAGTYA=
Date: Tue, 18 Aug 2026 16:44:31 +0000
Message-ID: <6ae652b864ccf2e56b56b2a541e4b81854879593.camel@amd.com>
References: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
	 <20260818-dmaengine-kref-fix-v4-4-c6ef991462a0@amd.com>
	 <c9e8b7e6-6a3b-4443-8632-81f2a2a4f79d@deltatee.com>
In-Reply-To: <c9e8b7e6-6a3b-4443-8632-81f2a2a4f79d@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|PH7PR12MB6396:EE_
x-ms-office365-filtering-correlation-id: 80cca827-690a-4d14-f552-08defd47fa4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 K9iuOJhws/zgjbK9YSHXTA10v2VvYmTOb7MbjMRmP6eA5Rj5+qh8zbuce5DgDkSWWd0N+42ZtUCXlV9kbi1rZvgWyy89wt9Dz4btZZPXeT5I59FrVorncY+GLfnrQeTdEPOZQTdAyKOMNDw14UCKcOPc8nbdplL0XDoiC5rQnVlO5yqxs+5luIQomX6B3NACUL9+q/9Xl3mEjf7TDqtQ7d221AxzLrcIfkYHmbMeWhddyLnAvO+q/bhCLmmhW5JKkdlXSWFbkNTDUIYKW1N2iF1ht/OoGiej3mICt6Z7xVdkzhkocfAcqj/XIvgZ6vmcG54lM88ScNkvtxM9J7OVzOm0+PtCFEH6WCptjiZOa4Nq//WPQbaJ3Ru7dxAAcK1lIiFe98G11kvGSQtsV/6XksaLZbpEqShDI/N78JFeVgILKXG1Ejzh/3H6b+/OfAiH0Lx5avYLfvUcphN6cNd2cah3oOoqI0Ttwk7lA5G+Ti4AxKqYtoGP8IiT7K9eN8jYvOowSTt5IzgaYg/NDO0+zFWd0INCWPYWJYG0S96hsQukHihMK9wAS/N+fdR0Tt6qzlEHIxfv2npLVbIrOg5ij5fOw5A/q7CUKMLq/2uGEOmCVoO+gJL/7DBprgdcLD+yvkbIF02pp9v18VIU9qgODO9mNP/CR/HGCzKu6cQGjj498cXkv85A4IgybNSRiWTf4yINcQoUQMJKKG25CLNDvAC5QQ23MM130I5A+Q7LfEE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTBScjYvRXlZRWkvcnJ2bzBTbWZtQmwrVUNNSlk1Z0U4QS9RWVhIN3c1eEF5?=
 =?utf-8?B?VzVvMHA0N0tJcFBYcE5Sb3g5QjdZaTdrSW9wMXl3WW9FYnpOYkhjZXY1T3lr?=
 =?utf-8?B?cSttVDBxL2gxUE5TUlZtT3F2a2t3M3lLc0pxTm0yRFdDVlMzbFdyN1JnVXZv?=
 =?utf-8?B?RkRmbE5mM0UrQlMzZituM2g4aFlBUkJWV0k0ZUVuRzdCRFFlT05mKzk4MUFo?=
 =?utf-8?B?YUdsNFV6bzhHNUpUNXhORXZ0Y1psZUgrNm81Z01GTDNmdWJUYU91cTNudHhL?=
 =?utf-8?B?bDhvYlRyY0d6a1EyS2RKalRyeGFQNTE5bm5SUEd3Z2l1SmZpT29ZTXFUNUVk?=
 =?utf-8?B?eG5WNFVCU0VvUTI5RTVyR09lYkQwa3Y1T3hDbjRCM0cwUnE1TkhNd0pXTjQz?=
 =?utf-8?B?Z3RCQ09aVVA3alk1eG9FODF5YVYremJINXZudWx1U1U5WldLMXoyK3NwY3JS?=
 =?utf-8?B?dUFUTDhFVWU1Y0hKR2luQXVlSGQxNXNSMDJQakNKcnI4QVdvWWc2Zy9WamlM?=
 =?utf-8?B?L0x3U0RKTGdSY3VZZUUzcE5wYSsyS085andoRVpsY0VZWkEzOVo4K3RhZENm?=
 =?utf-8?B?WW44RzJHWWFjZVhzQSt0bmRUQWtKVGROT05HMDhXQ3h6N1JPb3ZzcWM4eEdJ?=
 =?utf-8?B?MGxOeU5Gci83UzZTcmJjeTN2R3MzYTRwa2tOcE9adnVUcVNPUG5Ud0lGSDlI?=
 =?utf-8?B?c2VaYWVGektpd3VSRExuenFMb3JJOWlyT0xmd2V3OGpjQXFzMUpJS2pneXV1?=
 =?utf-8?B?bWoyYkJnTXd1TW5DdW13N0VLdXNiRkNOd3dXelVsRlNISEJUSjM3c013MXY3?=
 =?utf-8?B?MlNCZWtYTjEvZEIzM0hGNUlISmwxdWNoU1NJMHNxUm1idGFkdVAwQlRJSURH?=
 =?utf-8?B?enFiNXU1RDlBcU9wRDVkOENTQ3M1cUJjT2NaWjhDWGtndHNwKzl4dGFLd0Ft?=
 =?utf-8?B?SmtuS3prK0RjL3V4T1QzdmJOUi9wenhGc3VuQzlXR21LZlRza1VRUVJZUEZY?=
 =?utf-8?B?VXdaQ0NJNi9zRDRrdHdDOTlURWd0WmRkZVp3aHNBcmJVSjlvUXpJRlgvSDRn?=
 =?utf-8?B?WWp4QUQ5Tng2N0dUZVFLY0g4TFhKZUhtQzVWazJENlg1WTkybHlUUm5waU1R?=
 =?utf-8?B?Z3cyeGxsSUxRcmJnZkprdGlNK2ZwK3ViNW1PWkVVMWRsbFlVaDdkb000elVw?=
 =?utf-8?B?WHhGQkhlQTVRdnA4ZlZrVU5FYVBzRy9WRWZCOHZTeXNwaGx2VG51cW5KZUNw?=
 =?utf-8?B?OEdPUGwycmd4OUsya2tMVG8ySFd4MGN0dkc0RnBmT3B1dmFYMWdqREhDSnVK?=
 =?utf-8?B?emszV2hqb0gvSXdBSnU4VkxHNlJQUlNJZlRIRVFvRmVnUU8raHRvZE94R25P?=
 =?utf-8?B?ZFgrWktjcXBIdHYwRWZPOW1KbzNMdVNGV1lINTdTeUFkMjVMeU9NdWdkdGpS?=
 =?utf-8?B?WHg1SVF5UlhOKzRRQSt4aVlGSmltdVJkbjN4RzYvRWpRTndDR3puZ1ZVSFNy?=
 =?utf-8?B?bktlTDRLZmxaS1k2ZzFkNm5HY3J6OGFlRy9hUlJ4TmNEWlJ3Q3pTZzhrM3ZK?=
 =?utf-8?B?WGUzbHM0VnY2NXFDK2JUTzEyUkU5cGhzWVptUzF4bDNRVkhZQXZQZys4UHZJ?=
 =?utf-8?B?UUZ3S29CRFU2cXM1L09FTXorelh6cnUrdWU5bXFpSWVjbEplVDY3ZjhjdENo?=
 =?utf-8?B?Sm1OakR5WWM2NVdOSTNZUUdGdmpuQmNqRGwvdXIwTXVzR2t2WDZSb0l2V3BN?=
 =?utf-8?B?dEVlNjdJZWl0YU9meU5kRWxlSWhTTmtFVmV3YlVtOHNYNUhQbUFHNGVVVHdl?=
 =?utf-8?B?OXZEbURkQWNXK2ZtMzN3ak9vWFBIRHNYUnlneXZkN0JQSjlwcXN2V2pxVWRn?=
 =?utf-8?B?eCtpdnJHeTFaNkY4dHI3OFRsZTZFUTBUTTllYStiMTBmMHBtdGJZWlFSMS8w?=
 =?utf-8?B?T2VmbzdMZ3huNmNwYU9QUGIweGkzTzFTdU92WmkxbDg1M0NUQmtTMHVDb3lJ?=
 =?utf-8?B?RFFKLzdldzk4aHkrYXp0cGRxYkxsRUliTGswY1k4NURlVkFIektOVmZYMkx4?=
 =?utf-8?B?RndWdGlFZDlxeWU0OFZzaFdUQ3hhc1VYYkdSZzI3SHdiK2FHaWlPUWMzNkhZ?=
 =?utf-8?B?L2RaRE5OR3lzWmN1NitPaDJISkV3ekVyMUpRdjFadlJkTWVVUlJrVXdJNU1o?=
 =?utf-8?B?ckV0L1FlQXJOQkcwSEVLazhoQmdoeUhqVlJ4WFIzazlrUmh2djh5TnZhZmRx?=
 =?utf-8?B?Uk5TNWplaUFmVmdvRnFnVDNhN05tYXFZRzBGdTUvNzM5a0dQRW9jS2pyMkow?=
 =?utf-8?B?L0NBMlNPblJFTkVCUk83VFhkaDI4QjhWRE1takFHam1USE9zR0RIdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9890700D9A730245B16EB5F6AAEA7443@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cca827-690a-4d14-f552-08defd47fa4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 16:44:31.6883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBMyTGzVYPlS4b2gZ05QHS6g34GfoWxhzb8+0VtvBiJP5GhW7J8qPfCTpjwWk4r4lNBKWyJOXRrvpDYfPUKPBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396

T24gVHVlLCAyMDI2LTA4LTE4IGF0IDEwOjIxIC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+IA0KPiBPbiAyMDI2LTA4LTE3IDIxOjQzLCBTaGl2YW5rIEdhcmcgd3JvdGU6DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2RtYWVuZ2luZS5jIGIvZHJpdmVycy9kbWEvZG1hZW5naW5l
LmMNCj4gPiBpbmRleCBkMDc1MDUxZGQxODcuLjYwNGM5YWYxOTkzNiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2RtYS9kbWFlbmdpbmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZG1hL2RtYWVuZ2lu
ZS5jDQo+ID4gQEAgLTQyOSw2ICs0MjksMTIgQEAgc3RhdGljIHZvaWQgZG1hX2RldmljZV9yZWxl
YXNlKHN0cnVjdCBrcmVmICpyZWYpDQo+ID4gIAlsaXN0X2RlbF9yY3UoJmRldmljZS0+Z2xvYmFs
X25vZGUpOw0KPiA+ICAJZG1hX2NoYW5uZWxfcmViYWxhbmNlKCk7DQo+ID4gIA0KPiA+ICsJLyoN
Cj4gPiArCSAqIFdhaXQgZm9yIFJDVSByZWFkZXJzIChlLmcuIGRtYV9pc3N1ZV9wZW5kaW5nX2Fs
bCgpKSB0aGF0IG1heSBzdGlsbA0KPiA+ICsJICogYmUgdHJhdmVyc2luZyBkbWFfZGV2aWNlX2xp
c3QgYmVmb3JlIHRoZSBkZXZpY2UgaXMgZnJlZWQuDQo+ID4gKwkgKi8NCj4gPiArCXN5bmNocm9u
aXplX3JjdSgpOw0KPiA+ICsNCj4gPiAgCWlmIChkZXZpY2UtPmRldmljZV9yZWxlYXNlKQ0KPiA+
ICAJCWRldmljZS0+ZGV2aWNlX3JlbGVhc2UoZGV2aWNlKTsNCj4gPiAgfQ0KPiA+IA0KPiANCj4g
QSBjb3VwbGUgbWlub3IgcG9pbnRzIG9uIHRoaXM6DQo+IA0KPiAxLiBJIHRoaW5rIHRoZSBjb21t
ZW50LCBhcyBpcywgaXNuJ3QgdXNlZnVsLiBJdCdzIHByZXR0eSBjbGVhciB0aGUNCj4gc3luY2hy
b25pemVfcmN1KCkgY2FsbCBpcyBwYWlyZWQgd2l0aCB0aGUgbGlzdF9kZWxfcmN1KCkgY2FsbCBh
Ym92ZSBpdC4NCj4gDQoNClN1cmUsIEknbGwgZHJvcCBpdC4NCg0KPiAyLiBUaGUgbmV3IHN5bmNo
cm9uaXplX3JjdSgpIGNhbGwgd2lsbCBkZWxheSBmb3IgYSBncmFjZSBwZXJpb2Qgd2l0aCB0aGUN
Cj4gZG1hX2xpc3RfbXV0ZXggbG9jayBoZWxkLiBJcyB0aGF0IG9rYXk/IEl0IG1pZ2h0IGJlLCBi
dXQgaWYgc28sIGl0IGNvdWxkDQo+IHVzZSBhIG5vdGUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0K
PiANCg0KeWVhaCwgSSBiZWxpZXZlIGl0IGlzIG9rYXkgYXMgdGhlIGFkZGVkIGxhdGVuY3kgaXMg
Y29uZmluZWQgdG8gb25seQ0KdGVhcmRvd24gcGF0aC4gSSdsbCBhZGQgbm90ZS4NCg0KPiBCZXNp
ZGVzIHRoYXQsIHRoZXNlIGFyZSBtaW5vciBwb2ludHMgYW5kIHRoZSBwYXRjaCBkb2VzIGZpeCBh
IHJlYWwgaXNzdWUgc286DQo+IA0KPiBSZXZpZXdlZC1ieTogTG9nYW4gR3VudGhvcnBlIDxsb2dh
bmdAZGVsdGF0ZWUuY29tPg0KPiANCj4gDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldw0KDQpCZXN0
IHJlZ2FyZHMsDQpTaGl2YW5rDQo=
