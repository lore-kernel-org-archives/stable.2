Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012012.outbound.protection.outlook.com [52.103.72.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5437C119;
	Sat,  8 Aug 2026 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208622; cv=fail; b=MrWENUZb7oYBcWejobKjNiWVtRchSOoQLLl4PgHj3o+mGqKqpBlIsJCm868zLp1m9mLc7o9/H0bIwafQhbKKvLOYgWZ+gkzgcx1GOWZ6s0/gD/1za2cQCqWJnMuJmy0FCzF+9K9PFyOvo5p0RqpmHje3gDijpnjmpfkYf96eQ4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208622; c=relaxed/simple;
	bh=5Z35ouHF+yzlIWgiTLEt95WGmRL2cioPmPXtnyox86o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WG5ZCFLfU0TTVZUtTnB3u1x8FbyVNpqXa1vImaTMTQh9zI/BJZxtQ35dabLKzWg4CT8mIY6VU9o/8kKY0l2glETuyG0Wme1sYwicKxTfEiwrgwFnGvpG9H9vHX/8XuXK1E5USBVTflmdLqwPja170tWJKyZEW1uh6yS2xWcBrY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AjA7MYMF; arc=fail smtp.client-ip=52.103.72.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AjA7MYMF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/bPQMdiE32u32qpUrWkf88ewsbsphE/N9pKVqVTtTZNjhj701cS2bI0/Tci1y9acarUOJEjcpHR1ifiVNGrQbCFOA0LAqlfc7aKo5s23tNQY/V6zDm1tsu+Bd7bldAjXGhUiw3SGOYhJOWM+DR+s3m9SOGhZWaciQCuhUQi8CsTqth8Ah2gmvFh9OoLhXOno3Zeuk/Mx+pkjYT3dS0ZI6aBtLOHKJooLAzKBxmGj38ucwGsao5iJxK0+hGdnVFAC2tE8jby107PfjrVSRF1LJ802tm97EpS6PQrddYcJ380PzDQe6KEhZ4/+OixXOenWnjQ3/eb9rOw7ZFIGl2nXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z35ouHF+yzlIWgiTLEt95WGmRL2cioPmPXtnyox86o=;
 b=jZN9NajTI9oXmc56dykBCqy5pyViTsJxJcUaWJJ0EI9qDBo3oGlmB10A6MUvGA3QtNPmBfhTBt/O9MiqgIhO7IVPGtrMswlLs0vjAMXO1CW4rUm2iNa8kOg0u2Swn/ovC9lWg3l24nSB3SP+DKi4zVH9Wd2WCvEIGABKT5WVJOoxgcRD3Znk9Cbas1SblCkXCoCR0lekImX28jz8oogSd8Hs0hHfQONVB7aZaysKcMpe+YU7wLrIkSXj/CLdTNLrQF/fysL1P5T0jb1+jrX9sIJaNcSi4lzlapixoVIqhriDIcleB5y2J0QtUUOr5t3Ck76EMPo3STq1B9NAViTjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z35ouHF+yzlIWgiTLEt95WGmRL2cioPmPXtnyox86o=;
 b=AjA7MYMFajBNKtFtbNYST9BG10dsh+QUXFvMxh96rRumDuwz/O+d8sKiZrhCvFsmji4a3i+MuSef75U722L+OskH3tkiaN7EO41tdmNRv754bcVbHCxvB+N/lmxzunMvrbJY85n3FeQvqGyoZJ+jwebegly48zmxDv5LaySeZi+KHT7OzXOgDXzWrhQcmuRt+5oWDmhZI3CpGJ1vx7xeRPQa6awqg2MiyezIfTQN4+GK4CVCwJpa1x303MXWzDmL54znwwOBYOEjb1TJ72tnB5ORHuhZgrqzU5x3+k3MEK69qVfW1U+sliRiyElV+uNcHfGXgirRR+VFlPpi4X8Olw==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME3PR01MB7262.ausprd01.prod.outlook.com (2603:10c6:220:136::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 17:03:33 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0292.024; Sat, 8 Aug 2026
 17:03:33 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jammy Zhou
	<Jammy.Zhou@amd.com>, Madhav Chauhan <madhav.chauhan@amd.com>, Felix Kuehling
	<Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: fix VM update overrun on non-4K page
 kernels
Thread-Topic: [PATCH 2/3] drm/amdgpu: fix VM update overrun on non-4K page
 kernels
Thread-Index: AQHdJV5wKzNRhIhedk2T/sNvjgRw6baQ63AAgAN4qwA=
Date: Sat, 8 Aug 2026 17:03:33 +0000
Message-ID: <B5DD8C80-AB11-4D23-A602-EBEACD6EE04A@outlook.com>
References: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
 <20260806-amdgpu-fixes-v1-2-ce247012d4da@outlook.com>
 <88f614f4-5001-4cf1-ad2a-00802508a4f6@amd.com>
In-Reply-To: <88f614f4-5001-4cf1-ad2a-00802508a4f6@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|ME3PR01MB7262:EE_
x-ms-office365-filtering-correlation-id: 3058bf9c-b2a4-47d1-13b7-08def56efaad
x-microsoft-antispam:
 BCL:0;ARA:14566002|20031999006|21061999006|19110799012|8060799015|8062599012|31061999003|12121999013|39105399006|15080799012|24021099003|24121999003|22091999003|24071999003|4140399003|25010399006|40105399003|41105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGFvMHl3MWErdTFLazJaQTBuZ1hySG44WnljdUQxZ1o3YWoxMUFYMHpKUHJI?=
 =?utf-8?B?K2Z3UHhncGFKcS9SQWxuYUVKSUtVUFJLeTZWdWtVSUZOVWZ6K0Q4MXJsNG10?=
 =?utf-8?B?eGo3Zi8vbzNFbVNMMWU2VkpvZ2pjY3VzbjRPYTA4aDNSeDZyQklueEtITTRa?=
 =?utf-8?B?ZVQ4dGltWGFpMFdYK1AwUVBNSUkxNEpoQ3BBM01mTUZxTTNGUkFXaHd6QVRo?=
 =?utf-8?B?dk9Fall3ZXREZmpxKzVMY2YwamNoQkZmNHZlUVpJVUxObFEyWlhXdEtBdUlt?=
 =?utf-8?B?akhxV3JSb3lwZ3E0T2s0anIyVUh1eGdaM2V6dzFsc0FkdW1TOTFTU2ZBSllO?=
 =?utf-8?B?aHpBRWhUSnNsU0NYUlJwWTVFd09kcVVkdk9tUUNqbXV1Y1BIT3doQnZOVEUx?=
 =?utf-8?B?Rk8ySjlzUlFRZkpldVFEK3l6SHVrUHdSc0kxRVpUVDJsSjB3RTl3MXRwT3pK?=
 =?utf-8?B?L2VrSHVIUytaa09sV1FlTUFPdk1rNnRGNlFkcG84aXV5TW1OdFdrbnJTSG40?=
 =?utf-8?B?UVI4UVk3SVFkK0pxcEtqUERZN2Jtdlo2YTVNNEs4M3BJTVRZTkx2ZVpQcEpk?=
 =?utf-8?B?RUdGSGhhS0hpTkVvaGo0NitnbFJDcTN4eW5FbjNBc3V3bFF5TXgrSjA5bVVM?=
 =?utf-8?B?NkZHS2J5ci96Y21sb3BQajZyVjF4cXI2c2FrRWhRbm9tekdDa1habUE5SWha?=
 =?utf-8?B?aTgranphQXloSFY3STZnVkJtM1dLVGNRZTdFWWZSWmhRcG5zL0JIUFIwbGtC?=
 =?utf-8?B?MXVCTGhQNFAySUptRUEwNUlCWGhnVnJ6ZkJsK2xqamF4c2cxbDhxS2xEVE9H?=
 =?utf-8?B?dko2Q3Y3eVI0RHErMm1IczlmdkY0dEtBVyszVWhZVmFlRVhha3pYZitqdDJ4?=
 =?utf-8?B?RkNraTFJUE4yT2pmeFFlSVZhOWpjN1JMckN0Mk0vSlp1RndjNUJGSzBKUERY?=
 =?utf-8?B?WG10ZTBBcU9qdXY1d3daa3ZENTRyaHJBSzdJQmVkV1d3QTZuOUFQSlhXSkNV?=
 =?utf-8?B?N1ZxaWVvbkdOOUVXOWVZdFVTVVhQUTlrdGxuWS8vU2p6ckZBTE1KZGg4bHgx?=
 =?utf-8?B?eGRlMGhyT3V3WE5HWWFOckZ1THVIVSt4dmNGd2xxcDFyRmRsUnJKYTN3Wncx?=
 =?utf-8?B?RzN1d1RDeit3dmxvbUU0RXZvV1Z2ZHQ3VDZNSU1aektyQktwNGFQUmhoK3FW?=
 =?utf-8?B?VjdwNDc2clFDWXNiNHpNU0s2SVFTeUpuVkM3WUlGZjdlSUVqUlNsM0ZiTXQv?=
 =?utf-8?B?RlZTYThINVZOMGRVU0lRQ2Z0cENwSDUwS1EzM2pPVCt5cXYvUE9nSU1DY2pN?=
 =?utf-8?B?Mk1hcVhmYSt2SXhJdlpIekt1aHFlMjlDTkFOYnN1ZlkxWW1xcktPaVdmVlJS?=
 =?utf-8?B?VDZBSVI2dzkrNUhnODRtZlRPOXViM1pmcEFSMnJybXJodUtFcUpkUjFEUElL?=
 =?utf-8?B?L2pJcmlWV25rU3ZoZTFpbWRwQ2lYSEFJSnMvWDFaanhNSUhkUnBTWVdHaFhx?=
 =?utf-8?B?TlorRldXT05VbHkwazZUR0V3WTFESHk0eU4zRXo2ZEF5QmVGeE9iUVhqSGZn?=
 =?utf-8?Q?ZrRFteMLVjmQHuzlX+7EjWrnA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGxyUFFjWStLYXMzdWhtU2pOL3k5WFBiWEgxWnJlaDNPQlZ2MTFUYkx1ektH?=
 =?utf-8?B?VEJwMWR1aStQemRhdFFtSWZ1V2hqS0tSKzArRUVDS3REYUtLT1FFRkIycDZN?=
 =?utf-8?B?cllaK0d4WGZZQ3dQR2xEUmUxOUNEQ1Q5NnZIb1ZOYUJmNWxWYnFIeTd1Sngr?=
 =?utf-8?B?OXNSR01IUmFDRkpIYXhiY3g3SmtpdVhVbFdQN2h4bzVQcW5Ca3ZNempyVW16?=
 =?utf-8?B?dkRnUWVsUGFlMGx1bnhGeVZKNjZhY1pSNUI4aGZKT2l3eDNxYnBzcHBxNUUw?=
 =?utf-8?B?OFpMbE5jK090TFJIWDBUb2d0U1R4MElteUFNV3Zlbjd3Q2poOUx5RGEvMXV2?=
 =?utf-8?B?M3BiV3k5SlJqdmZoQWZNeUgrcXVVS3JmRVlIWHhJNzdHNHdhRTVmTStuMnk3?=
 =?utf-8?B?WkROVXdrQ3UwMTdleUdLR1UwbXRyTGo3ZGJ3cDhFVzE1YWlESmpkR3M0dTNl?=
 =?utf-8?B?ZUV1anltYWNFOXV4YjJzWnQ0K1FHUjdJWVlUV0VuK1VDUC9iUlphTDNTRjh4?=
 =?utf-8?B?Y2t4d2ZRWTFOQldRTCtFVEtROW1GdUZXT1dJQ1JEdjdWM0xNcS9aK0YvZU5H?=
 =?utf-8?B?Qm54WXkyeC9IV2UzSHd0bGdkdDBUdURFa0dHdHlDcnc2MCtFVElKNGJKdWV2?=
 =?utf-8?B?SkpzN1FSMFROSHJhSkRsYXovWmhNc3NNblN5bFFybUQ5Rk9jR2tPRkdVSjVh?=
 =?utf-8?B?NmlGRURkUkc2WTVXRDRTYUlmTG9zTndvYkxNcGVyazE3cW5Hd3dmSm43TS81?=
 =?utf-8?B?NmhsM0hJNjNGa3drRFhjdGRPRFEwd2dBRC9vcnVqTGNpQW5OajlTY3BnNEx1?=
 =?utf-8?B?cGswZGs5RkVCNEM2RXNUWE9lZmFLWmZtSUhrdUtCWUYrb0N2a1FJYUdOU0V5?=
 =?utf-8?B?clNWcnh5NDYrZ2l2SUJqcUpwamVyS1JyREp4NEp4SWE4cDI5amRwYmhpVi80?=
 =?utf-8?B?N244bzhRUElGd095S3BlQm1QTjFmSmtNRklwN0dwZ3dRWEhwdHd5aUlXZHhY?=
 =?utf-8?B?aWpRMW9HWHordmlpVXRWL2NHN0hRTGVTcVZkT0tUZktVTDNmZm9xWlJZUDNF?=
 =?utf-8?B?dy96bExHZEFJQVJsUjMyWGpVZ3BkalN1Mk80REV2cmVNajVGUWc0L0xIenkr?=
 =?utf-8?B?aUdSZ2JpeWE2WThDT013bzlXZFJIdjYrUEx2ZlgyL2xlM25YMk9rWkFQdTMv?=
 =?utf-8?B?WkVoeldMSVVWTFRxeEdlTm1NcGp2QndxY2Vuc0tGamJCMmppY1hTQUJXNStr?=
 =?utf-8?B?YU9DNE5lZExUeXJSUEFqN0VGU0w3aGI0QzZoRUNFVWlxcjdtUWVJQVpxMnFT?=
 =?utf-8?B?RDllaHRMT1RQZXFhYXk2TldHSFBMV2IzdmlDQnpJZ1BXWVhBdDg4Y3M4TU1D?=
 =?utf-8?B?UUszNTNBUmFlbkRhdHkrM0pnYmVlN2J1KzhhenArV09jNEJZL1doaHMrUmRl?=
 =?utf-8?B?SG1GOHRMUDBxUXI0ZTY2QWs4aGNnZW8rVUZDc1BnbWRnYkhHN0g2QnhHMFVw?=
 =?utf-8?B?Uk0yMmMvT0tkMGNwN3ZMRWc5RGY3U1ByREJtZm50VHVFZHVsTGY1NU5FZUhZ?=
 =?utf-8?B?MGJ6V2lIWFkwNzlpTDZGSFRkQXFqbjZGQ25WT0hKZEgvMFR2b0ZIN3lSMGJn?=
 =?utf-8?B?d09xblBPV29mT3FvallGSVFubFh2THhxWkZveGkwcVdrbnNFK1BHNHhyb3Bl?=
 =?utf-8?B?YnlrZ3lHbnBaZ01mYStPME5rcTZLNXZhTk4vNVEwZkw5WkZmWkt6bzVzOFpv?=
 =?utf-8?B?K2xzM05kTWxHYVZxUVJPejZqL2hUWmVXdjdVSVRqTjNYT3hhRDNYM3RlNXNo?=
 =?utf-8?B?Sjc4MEg5WDhEa1liaWo5TG1Qam9ub0EwekNVS2VpUWVZK1hXTjlSMnZ3V3M0?=
 =?utf-8?B?QzZ6U0xzR1hNeWs2OWRzU3daeTlBcThERjZMUXFWeGRYRUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F418828F4FB534FBA13DFE13C818F4B@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3058bf9c-b2a4-47d1-13b7-08def56efaad
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2026 17:03:33.3857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3PR01MB7262

T24gVGh1LCBBdWcgMDYsIDIwMjYgYXQgMDE6NTk6NTJQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToNCj4gDQo+IFRoYXQgY2hlY2sgaXMgY2xlYXJseSBub3QgY29ycmVjdC4gVGhlIHBh
Z2VzX2FkZHIgbXVzdCBiZSBmdWxseSBjb25zdW1lZCwgb3RoZXJ3aXNlIHdlIHJ1biBpbnRvIG1h
am9yIHByb2JsZW1zIGxhdGVyIG9uLg0KDQpJcyB0aGF0IGFuIGludmFyaWFudCB0b2RheT8gIG51
bV9lbnRyaWVzIDw9IEFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0UNCnNraXBzIHRoZSBzY2Fu
IGFuZCBpcyB1c2VkIGFzIGl0IGlzLCBzbyBvbiBhIDY0SyBwYWdlIGtlcm5lbCBhIDRLIG1hcHBp
bmcNCm1hcHMgYSBzaW5nbGUgR1BVIHBhZ2UgYW5kIHBhZ2VzX2FkZHIgaXMgbm90IGNvbnN1bWVk
IGluIHdob2xlIENQVSBwYWdlcw0KdGhlcmUgZWl0aGVyLg0KDQpTbyB3aGF0IHNob3VsZCB0aGUg
Y29kZSBkbyBmb3IgYSBtYXBwaW5nIHdob3NlIHNpemUgaXMgbm90IGEgbXVsdGlwbGUgb2YNCkFN
REdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0U/ICBDb3VsZCB5b3Ugc2tldGNoIHdoYXQgeW91IGhh
dmUgaW4gbWluZD8NCg0KVGhhbmtzLA0KSnVucnVpIEx1bw==
