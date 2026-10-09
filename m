Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012071.outbound.protection.outlook.com [52.103.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456824854F4;
	Fri,  9 Oct 2026 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532932; cv=fail; b=okMFoPHrTHANnMpMIxCL04AlEOFRsKWZ+RZszLUhEUq2FvfJgsVrQz7jJCvxj/vnkiYu2Icmqqf0Prq8XkChDo6ScWps8IKl4Zl+cLICHzdN6Ttg3JrCjoo6p7JI0JDC7R/DCYk47/ZOKu7wbUFbq6OCnsBbUVp0UmrU52N7sUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532932; c=relaxed/simple;
	bh=ipDsmwEasG+9StgsDx7RDFFBjLwK9g7whjLsKxG0NSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ckQzxsmp2FTv0RuM9lUQYBtVtbfbq4jyox8/DmZSzOrJcvJHiRmNv3h8C4X4u3odBjoyXGpSopAtryckWm913d4jpYuR3maWbADK+ihdRbseTsa2vc4b1GeD3aNA/WIxxcnRYWxDlj4LnOc/B/ddgFKECIdE7nTUx0wth9g3NGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MKUUwq6K; arc=fail smtp.client-ip=52.103.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MKUUwq6K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xdp6AkH916XjyCd+8mS9ckPabfOMiGUkLfhBR2ncgtTcZ2NyYf3ZTfLvgqsEQoImvdXKeFPKnFQnGDehN1bOl+Kb4JRnZr/3FLMaSsdJG+6hbAiFadcCRUaLWJfVT+RgqXmphBt/3XLsX4s8mbZ3o/0eD5BoGc2I4CEkNdS54k6RJrr21SZ1Kz02fu9dNCjjpO2XXnRH2f6dbO5GIwkjnINJFtOO7IlWroBXT18NTT1av5lwXA4AakVC9BBa3DiKukFJcKNF4JhP/49WeXcB1Rg3pf5I5q+a6NCaYCCjud+e1ePnJKlkFO3bdysBv+aUN1JvXNPiE5fD/tnBn8rvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipDsmwEasG+9StgsDx7RDFFBjLwK9g7whjLsKxG0NSw=;
 b=VHdfx7c4EUX3FNfSxW5ncdujCP9XH+/5b4pDt/k7PbIKc2F4G4Fsl6bIYKMqNMUsw0Li+AQaPaPsw1ipYtLLQk3rKKzc2yI9sOfNpMfr9kLRF5EBoDjBJE4cK6a722IBh/qh7LgtTEBC8qTeYn4lAYDvmuMEznYhQlM4jvXInFwXXbd0I0SOQTi0v2ag9ULo/rgSuZI46quENZy73buiU3Z/JflJWV7fX4tX5JgLAEmg6P8YJH1m6dg1yiuEzAA/AhCIww1frHP5aosyMIK9woJCSEsUXdUGkhm7xHh/tZCpoOVJlQTTpAcjTO57hMa2x2GSzi2/izwdIXY8+Ui5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipDsmwEasG+9StgsDx7RDFFBjLwK9g7whjLsKxG0NSw=;
 b=MKUUwq6K1Jqq0rWyWnGYyYHKS//e+47t1OzE3mBSF2rCtH6fG9oU3y09pe8XAjOCi+TbCs5LXS70YG1/w34BNLoGdrTQdxiw6uXRW7hNbH+qTIhCDg+qsijJIT7ua7sy/n/oJLf+N7jBuO4vW4fNl2NCPDWWX0TNh0zzqygxUuHCiQNp38aoNUk8bPlrW+++Tv9ty1w2wZyRnI7Oosvi2VNveha8j8sXZu9fi9mJA8wUcDQXEsCVL5+Lhkl5+Lv7QLPfB9UWK/I53cALCkq6rE1dKSH/mYAwWjAxIxeDLKD03jFVtj7gVuvUqOF+oh0r7Ax9RhVtsCmgdttQ8+9MWw==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME2PR01MB5667.ausprd01.prod.outlook.com (2603:10c6:220:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 08:02:00 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%7]) with mapi id 15.21.0522.002; Fri, 9 Oct 2026
 08:02:00 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Andrew Morton
	<akpm@linux-foundation.org>, Mary Guillemard <mary@mary.zone>, Mohamed Ahmed
	<mohamedahmedegypt2001@gmail.com>, James Jones <jajones@nvidia.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuhao Jiang
	<danisjiang@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/nouveau/uvmm: reject replace across page sizes
Thread-Topic: [PATCH 2/2] drm/nouveau/uvmm: reject replace across page sizes
Thread-Index: AQHdRvYcklAowvA/gEmsg6OoXFvr57b0+X+A
Date: Fri, 9 Oct 2026 08:02:00 +0000
Message-ID: <FBF1ED94-0D02-4C4A-812B-818897A605C4@outlook.com>
References: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
 <20260817-nouveau-fixes-v1-2-f518d0c735f3@outlook.com>
 <61d42916-a391-4b98-a6fc-84175127c2e2@nvidia.com>
In-Reply-To: <61d42916-a391-4b98-a6fc-84175127c2e2@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|ME2PR01MB5667:EE_
x-ms-office365-filtering-correlation-id: 3692f9eb-d79d-491b-a7de-08df25db98e1
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|25010399006|31061999003|22091999003|24121999003|4140399003|8060799015|19110799012|8062599012|15080799012|53005399003|40105399003|2607281247196008|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?S09YejRialZST1hHN1dHbjBzZWhUNCsrUk41ekFVUXFLNjc5aG04N3d4anph?=
 =?utf-8?B?RVdsMGFLdE1INGlLYkRSY2RGaHdFUjBxYlpFVGRpbVdtaVpTUTgwQU9sbjRJ?=
 =?utf-8?B?WWs4RFM5SEhUQkV4N21lK1NsekFFdlFPc1psc1Z3enJ1UDJWbDNsWi9jRERj?=
 =?utf-8?B?bWdBWGhMZndoVmRCQjh5TVZJMkk0b3JWbVJjaXlOc2Jwd2RKbXErTjNXdWhM?=
 =?utf-8?B?SlJ1emMyVEs0L0d6WjVMdDVBUmhIR1MxWmYreHR4eHZESVViWjlXYktmdGFj?=
 =?utf-8?B?cGdtUTBmVDJEdHBoSVZwZ0Q5QjRKazFVSGZyMzN6d0EyY2xWMkgrRUZ3U0Ir?=
 =?utf-8?B?WmpCRGZpSEs0UkhoRmR1YXZoRUkvY2ZVUFllVFo4ZmVxb3NocVJHMkdoR2g2?=
 =?utf-8?B?YVN0czNYR0lBblVYQlRQa3JrWkZlOVIvbDl4cnFUUlBOSE1DbFA4SU5Xdy9o?=
 =?utf-8?B?MFRjRmFjam5RMHU1TmIrSGgvc05mY3IrTko5S1JINzhyM28vYjJKSmRzUjU1?=
 =?utf-8?B?QzRXcnpZRlFkUm9WSkxOa0QzM1MxRktuZ2pzSVExa25IWXl4MEFJMDVnejNY?=
 =?utf-8?B?eVROdFBaSnFWUWt4Si9ORGdyWFpzOXo1VnlQUStMWi9jZklHYzFJY3JNazND?=
 =?utf-8?B?U2hzamVUSXhJQ25KWTB6RzNjcTdYc1B2akVneFJjK1JIeUM0ZTV4dnZsVk5Y?=
 =?utf-8?B?ZTUvZGRpaVRJZ0tTcFY2aFYvQnpyTnZJYWZYZXB4ak5oOGNSb01IVGIxMHVY?=
 =?utf-8?B?WWpMUFo1WnkycDlwb2hCQnIvYWxKbTg2TmxFNDJ4eEdRUFRlR1JvWEpMZUIx?=
 =?utf-8?B?TjA3b29PS2xOYWFGUDZDZlF1eVRmWjh1QmovMW1HTDQ0SzFSMUtmYWJtaGdN?=
 =?utf-8?B?dDdKckg4Q3ZOOVozOUVRZmFVcDRBUStvck9mcHpsSXRxeFMrS2xZUytRVzl0?=
 =?utf-8?B?TVV4bC8vZEJISGk3dDhuZ2Q4R25EdWxjS2VhSjFhTGV6aUZUUlp2a0R3VUV4?=
 =?utf-8?B?NWJWRVBtT0hNQ3lKZmRuMFFCRmd6K01jOENXTmVQMGpObUk4dGcvSUFnK1Nv?=
 =?utf-8?B?S1hvdXdFVndzUXlmdXNleUFyS2dpdEZpbkxwVUxreXp6eWNBejZTREJSblM1?=
 =?utf-8?B?eHJKbitoRmVmM3NPYzJpVFdySkt5ekxBbS9PSXJIZnUxdVA3OEN5ejNSc2pj?=
 =?utf-8?B?clpzckFmNFNhWXhQeE1oRzJ0UHJtNUdCcjQ0MnFIOEZockdvMmdLWXRsUmZG?=
 =?utf-8?B?cm1RRDJSd3c3L1V0cVZnVlZtL2NHUnJOVTNQVXFKTzM0NGs1cVNSYjZONExz?=
 =?utf-8?Q?7H7+tga8vELTF24kCtZngscmr1juHZ2nU4?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjVYeU9qR3FUYWF1TXVTQlNKV2ZsQlVXUE9xcmZHcjNTZDBIeGJxbVdIdnRa?=
 =?utf-8?B?SVA2RDdyRDNQaGxHUWEwMHYwbG1HbFlzLzlmdC9rdTBLWTN1NFJCN1ZRNnBx?=
 =?utf-8?B?S2lSdXhKVHJrVjZCZGJpcUpmVElPNkR4SE9SRE1OZElrbU5mSnJqbjB5bXhJ?=
 =?utf-8?B?MjU2WE1sSjNya01MTHdtTEdTSmlWQzFzTG1qWlNyN2dkUThsZEMyb25FR2hP?=
 =?utf-8?B?U3dYTVBpd3lwOTlBU3Y0MXRSSi9hNzBITjMvWDRWY2JnL2xjMlJIMzNGNFBM?=
 =?utf-8?B?L1dxODdzdytyeDVhd3JNd3A3OUF1ZTdyUkFyQ0hDWXFrV1N4OEc5cWNjcllZ?=
 =?utf-8?B?R1pZYmN4d3M3UUsrdnVGdHlsblFweXBBRVpHaEpvY0pYNXQ0QWRMeWJhMXJC?=
 =?utf-8?B?c1ZvWitBYTRDMi9Vc2FGaHVYTE9OYUU4YXR3TUo4dVhBbGlock9GZkpIWWNL?=
 =?utf-8?B?SW5WSU1jeDl2alQrL0lnM0RuRlBXMU44dndRbHk4R1JiaHNudjdkRDdnbTli?=
 =?utf-8?B?NWwxTnJ1T2JTUWNjYzZEa2FISWhBUDNDb1E0bVgrYktnUFBNZmZtcWtZSktl?=
 =?utf-8?B?a3dqaTF3cXVXdUFOS3Y2TkQvdk1tb1Y4RDdtK2RKbVBxM3l6LytkbTBpRDJu?=
 =?utf-8?B?cDR2bTRBRTJESy90NU9HbXlHdUhpN25vWTkvYWRjTUMrc1JwN1F2aWJ3a00x?=
 =?utf-8?B?RXFyYjlHbncwaWcvV0R6SXY5UUUzWXJNRlBkWVF5UTMxTU5zQkpHV2tjOGQv?=
 =?utf-8?B?ZjRVT1B5WUIvSU0rb2I4MTMrdmhaVEtkNFl4QmxnbndzdC9sQmlYN2FmVTI2?=
 =?utf-8?B?alkxRmREbE00bDJuSWlDRFVtODg1N2tlcWV3TGlSVmppSXVOREpTQ2NFZ2ZN?=
 =?utf-8?B?ZFJNemVTQk9HbUpyNWVScG15NDVVck1JazBCUG1lbzdIS0Y2L05VU1JueDFa?=
 =?utf-8?B?dU9NaHNadXRIbGxnb0hVMlEyZGo0czJneEhaVTB1aDYxUmpLV2lJTHFrdTZZ?=
 =?utf-8?B?czd2QUx4bGtMS2Y2dW9EMkN3Sk5sNjl4WE5NTGU5bjV4RnJLbUc3K1hZUXNV?=
 =?utf-8?B?UWtDTUdtMHAwTi9OVnQzcnFwZHd2VHl3NTBudVJZaFRrTHcwcE8vVXMwcUdo?=
 =?utf-8?B?MlpIRVY5ZHF3SFJodjZMZnRxTS8rT3ZJcmJIU0dVZWtRVGF0akhQL25qOGdY?=
 =?utf-8?B?K0dOM09Mei9sdkcrWk9VTkIvL3doeWMrTnlXQW55Y0ZEOFlMdWZnMlZsWXJK?=
 =?utf-8?B?N3RMaHphai9CMWtFRjNVNy96N2xwc0VUZlB3OHFPdEgxRHQ4dWt3Sy9DV0Ft?=
 =?utf-8?B?YXVmbEEyc3RPbWlSZFdCS0hFOVNvWHgzT1F1S1BHSXpyT3pURzlCVWxJVWtl?=
 =?utf-8?B?TXdZRzIrb3lMVWc2VlFUMGxzWTJMRHRGSlhhZ1pOVnhxUWR2eC9JNElvUmlO?=
 =?utf-8?B?TkhMNkF2RmlVcnJyZHhXQjVTb2MrdUFJVUpZT2tSV0NVbWRYOG9zUnZ4VTJu?=
 =?utf-8?B?OUtQVGVPcmxKMkxVQmZlVGwvZG5ZRnExV050UStsbUFCQXcyWDNqVXFJbHYw?=
 =?utf-8?B?LzFVVGlsNkcyc0Z1K3QyTEdxeGYwUTJMUDM4MG9wNTIwNjRUSmtSV2s4UHNs?=
 =?utf-8?B?aTBNREw2dG5yTWxSQU9CZ29YSXFFcWFib3lJUmdCL282clZxRTB5Y2NjQXhQ?=
 =?utf-8?B?b0l2Y3JKdmhiMHFOY0ZXbmNwYndNc0o5YVRNamJWeWRRS3cyaTdjbzAvUVpI?=
 =?utf-8?B?RU40QzI2QlBQMGZHb3VRMmlpZDRDalBxeEgwclFBRDdRTzF3ZzFaZEtJSWRy?=
 =?utf-8?B?MHJQOGZyK3pyV1h6THNVSFZCcTRBM29ITERYU0Ztc25kYVp6LzRYRXpudGFs?=
 =?utf-8?B?UTdMU2MxYXh4YnR6Y2x0U09RT2QyZzRmOTZ0cGsxNHRCNkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A52D2784EACFA24BA6CCDEA30A706BED@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3692f9eb-d79d-491b-a7de-08df25db98e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 08:02:00.2798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2PR01MB5667

PiBPbiBTZXAgMTgsIDIwMjYsIGF0IDY6NDTigK9BTSwgQmFsYmlyIFNpbmdoIDxiYWxiaXJzQG52
aWRpYS5jb20+IHdyb3RlOg0KPiANCj4gV2UgYXJlIG1vdmluZyB0byBBc3Npc3RlZC1ieTogTExN
DQoNCkdvdCBpdC4NCg0KPiBKdXN0IHdvbmRlcmluZyBob3cgdGhpcyB3YXMgdGVzdGVkL2NhdWdo
dD8NCg0KVGhpcyB3YXMgZm91bmQgdXNpbmcgYW4gTExNLWJhc2VkIGFnZW50IHdlIGRldmVsb3Bl
ZCBhcyBwYXJ0IG9mIG91ciByZXNlYXJjaC4gV2UgdGhlbiBjaGVja2VkIGl0IG1hbnVhbGx5Lg0K
DQpJIGRvbid0IGhhdmUgc3VpdGFibGUgaGFyZHdhcmUgdG8gdGVzdCB0aGlzIG9uLCBzbyBJIGhh
dmVuJ3QgdGVzdGVkIGF0IHJ1bnRpbWUuDQoNClRoYW5rcywNCkp1bnJ1aQ==
