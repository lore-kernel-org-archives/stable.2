Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012068.outbound.protection.outlook.com [52.103.72.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF5C25228C;
	Tue,  2 Jun 2026 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390896; cv=fail; b=cH+db9LeY3+0F/wIVqBmw4xTDehRXxI1AHXnk67DW18E4ujoXT4lkOoMULNuMWFLVtUMYzNnoXYIpqNDoyVeRoZ8F47HECjxjLgfMbGR7P4MxAhYNn1sRO9pi+fb3o3nTVp2pf3hvgeCwdPznJvz5xn4ECTOAn29NXDDxkzx06Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390896; c=relaxed/simple;
	bh=VCHGF1IFO9MoPz+4auknhwtdE90Kr+2jmk/reCeTMNE=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=L8NF1/UL8qKC3d8BDZdBQn3pXymg9GLYTnVWwzE/NcbE1xai2taho6FP/R1kZCiHbSzSLvo2h/dIJDfcCYK+3QHkEAP9LfiGVevbvdRdH3Ib6teCjceUg/b7qreVxvLbrzCDS0NycKndxN1sjjOGdswjXQLBRONTsguSldiMAMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RTPdV7+P; arc=fail smtp.client-ip=52.103.72.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RTPdV7+P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkm4ejVzRdW+3D6CK8Em5MIXH5YcS0wmqUp0aJ2lYXs+02T3QbtEiyxI1QgkdS6AQljvipKgi5DJq7gbl9oAfG21h7bAOAKjVUxx/D8lWY/LCWD/BKslFMNv+27IAmEOYbQTgGclXqjWQ+cwXhmhc5O750ftUfVhCsCK7tpMopqz+OdRJvc3fCpFCzkBC+A56JE1UHmKElHvpxA1qrjaUDMLxIh+qxLg8VNh6QmRqwYyJgb8wsyV1F1+zoygm6UX0aZD1KoIfeYnuvTL0A7wN9FWPsMoJX3cPlsr1cV4nM/A9/A9SbrklpnQYF6AYylTqK1ctvKOcIIwXu23E6Zmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olCB7gkVJOI8cqUKCYTszALJYCdlMawq6m4wImbg4cc=;
 b=zKGKjJbZKscL8xn63KPYmlEFY1Um1WWvryzgmYG0p1ZtLYQylOdgEyVWGEbPxWWAkzSbJVpmPJsn04xnQPsp9nKji1Z3I2VQ4pBYeJBocez/fnZSVo8wXBvcxajddNiw7gGLkFHOCSSKjepJQ5qmaTeuHWg+cF2NUxUVIl1NiLfGzfOLTDOdKSs06ImZw9c8t/i4EmuGKLd9HS5rxpYxfsKG0/Y5ZIpS0OXnge5BV0Oz1ZLLqkdL5thxWfjmxjRY7hsAoZ1FOf2sHNIjQZkYCZYLnC99x4DzMTz2Jn3zMZsItPoO7yUCDA0PcwQc8OteN0+rBxmQUBJLr90/ZxvhSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olCB7gkVJOI8cqUKCYTszALJYCdlMawq6m4wImbg4cc=;
 b=RTPdV7+PxmHMsee8fa9X7GvFjid/mVoFa93hZNQ8iqc4D0wZKqI14cH7R02TsKYIlt2U2GrAwZjs9HzNEYPNlDxMcMzrGwaz2J8STUK9x/AfhFDinloKCzSgGnxZV+8Q7p3OZVLz+xLvy1ZS3b8kebbYw6xpR1A0YNikOZR5wwI9KGFQagGHZ/Ute3JBu80sf97zrqk70vLqiHorXUqh4BfjtHsYcoQxEZyGwQ9231+PYtUbXurhL6iAbcxMhFbTV2gXDZtHpl9SI9fNKolmO6ZR1tcVwwDgg2hDjHoyU+lHVUnV/IW5IDFhqN/ITMRPvQnB0BjxRc490sHZbmV2uA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY7PR01MB10304.ausprd01.prod.outlook.com (2603:10c6:10:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 09:01:30 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 09:01:30 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Tue, 02 Jun 2026 16:58:48 +0800
Subject: [PATCH] vfio: prevent infinite loop in vfio_mig_get_next_state()
 on blocked arc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881290BBDE79B61AE6A017FAF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAEebHmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwMj3bTMitRi3TTTZLNEEwsLA1NLEyWg2oKiVLAEUGl0bG0tAD/3fAd
 XAAAA
X-Change-ID: 20260602-fixes-f5c6a4880594
To: Alex Williamson <alex@shazbot.org>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, 
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shay Drory <shayd@nvidia.com>, Kevin Tian <kevin.tian@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2032;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=VCHGF1IFO9MoPz+4auknhwtdE90Kr+2jmk/reCeTMNE=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGLLnZ7i6RVg2n5mvtkK3TEN656UKXjO4sqTUMaXkvf
 s9N8hPOLO4oZWEQ42KQFVNkOV5w6ZuF7xbdLT5bkmHmsDKBDGHg4hSAiRyez8hwtk2l5cfkUNbn
 8lZvHZTDT1qbn58uns005dzEZQlGpcKPGRn6AthurNCQ/lm4SVFl0YSg2UK6BhfuP1Y1Pnb8hdS
 qZhE2AN8lRZs=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TYCPR01CA0202.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::15) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260602-fixes-v1-1-89a12f97522c@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY7PR01MB10304:EE_
X-MS-Office365-Filtering-Correlation-Id: be87f03e-e1a9-4d0b-52c9-08dec085890f
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmoFKg4HO/PmVaQxqEsmtKdHIkkvvOd+sdx+j/trefxUhZop+4Xhe479BlJflQqxWrlCS0GRIsNfEJm/jSqGIQ043+6tmxcpi0NSg2uemP/RLpFNEMzwoynHdkShHZO7EJ84Ctb98LoF4rFyxQuMpswyKZpd0Uh587KKe+ciInQAITIWSdcTcJkXMwLRmhLzikZJPlCpfBwYwnqR1Do1as0Aj2JkuTOPELd4oQdLbLske2Kx7digEDEJUh3bbjkVwBT7PGwHIVHbAOv3I6r+/wRAGfGwWM1ApQaH369aRxNeu2T7x5hyvEoUnR+uah8ztZZvVkR6MC8E4B0pKUykhq+UWUPlKY7Uf3PGbURr0mslp9QGFMqxhuoms8qlXrg5xw2Mn8SdoBJy5nlns48jdLhpbytytKSJZXwvFzTgNLwjs+9z6duHu2KEg0O/hFhm0BXB+CkrXN055xXDN8K6BLeNIFUT8DEhCgT2YCyp//dZDBEQRQ4pIznOGV2vm7lHuwe5GxzbuAzpOlvfPCGvONwC2DDAhPgoMVDS2cP1z3fZTRHgKFWZjoPfwUKMENNJWJepT+PTDJL5Ak+K702VQGTuYxOcz8kLINDMc5sTvvSZ0Fg4aCXFAKQmej6qOpof+lL8O+EbtjMbjwyukck8MSr9IAIqB2iL00fFvp0XqPSvwC1mz/K0sSU9XoOiiGs5aT577ac+ctfPbZgJOBRsLy1JLiJsT1N2EavwMF5+v5iDc1+kWYgfawVEQnChzfTT6Ow=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|8060799015|15080799012|19110799012|41001999006|12121999013|24071999003|39105399006|24021099003|55001999006|6090799003|5072599009|30051999003|22091999003|24121999003|20031999006|5062599005|440099028|3412199025|26121999007|35041999009|41105399003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2grVmU3UStKRDRFbDJIKzdycDJPcVRNVXZQYUx0YlhrZ1JHU0VwcWpXdWJV?=
 =?utf-8?B?M1JjZ1J1UG14bWozTVJ0Y2dtK3J1ZjA0K1cwRWZseDlPME1ONGJCM0NsbnRy?=
 =?utf-8?B?UmpXbkkrMTZtR2s5enR3V095c3kyRm9WVExyQjN4OUtaZzArTEwwaEdoMGRW?=
 =?utf-8?B?aE1wVkRqMzdJRk5xZnM3dHRiMkw2R1ZKUmZvREdFZzJzNFRIOG84U3VXaUlZ?=
 =?utf-8?B?dVhNdmRQSFpTZ0c0RkhuRjJDdlp6bEtJZUF1V080aXlCRiswWTFYYTVBUVVS?=
 =?utf-8?B?QmVYUFR5TkkwN3g0OG1KVkpkcldFd3hIUFIzeWJUUWJaMGlmN0JqeWdLNU5L?=
 =?utf-8?B?YjcwQ0hQV0Q2UE11bWxYZm9qdkhlLzlDTzN5TXRPWkdkNTdjQWtpUW85ekFS?=
 =?utf-8?B?NHFZUlYyd3drZVJ4SmVBemNGNmJoTmEyZGVmcHVJM2lWblVzRC9XSHJFSldl?=
 =?utf-8?B?WHR2cXRBckRlUGpBQ1M1OVU0eTNtdUkyRWNWc05Wall0NXlxa0xjUFNYYWps?=
 =?utf-8?B?ZjkvV1RLbEsxU2xaaGFuUTdmSzFSZlVTVUNOZ1dwelBSaVJZL0NPWEh5Witw?=
 =?utf-8?B?c0hFVVZRUUVrcG4vRGVoek9FUUFTeW5mRGxpS1AxOGY5b3pvUlNIWlpGZFNC?=
 =?utf-8?B?U2hVMEk4S3phaFFRRzNLMXdsZVhqSTNSelpVbXlZdHk0dnBUSHorNmJYbUEz?=
 =?utf-8?B?bUxjeXBvRFgzZlFSTFZLb3VrUklaMlEvd0g0dEFEZ0V2cjBEOWtDaWk5ejVM?=
 =?utf-8?B?YXQ5N0RlR01ya2hRdjRvaDFxSkcrTEhvT2ZvWlZETmY2UWs1eG1BamxiWmpu?=
 =?utf-8?B?TlY3aHh2ZGQvNUxTUFlBU1lTUkJPNnlsTDVCalBpYWJndVN3ajBlUmI2ak5t?=
 =?utf-8?B?K01QYm83Zit4RVZjSGNXdG5vdFNyRWsrd1VNWk1taDNQa3RZVlRJdzJscjBj?=
 =?utf-8?B?N3U4S0pBOHVzRGRhc3QvVzJQTi9IYTRGQXI0VDZzb2E1a0VtT1BBanRGMFIz?=
 =?utf-8?B?eDRiNGcvL1lBWEtVdmFueXdkRkZ5Rzc4cC9PaTZVaHJKSXgxQ0FxN1BhNTFk?=
 =?utf-8?B?UjFZclV6Q0U4TWxsT1YzY3ZqTk5FMThHUTdkRWM2YzRjMEk4UWhjME03UStE?=
 =?utf-8?B?R0NNTjBWYkcvUnFuOXFVbTFaeWFmSlpGWVlaTlQ3QU90UWo4MFBMMmRyOXYy?=
 =?utf-8?B?S2NONUR0U3h0M2tyL0JjZ1A1RjdwSHV2Wk9va1ZPMlBldWc5cGhxTzVvMTNC?=
 =?utf-8?B?b25icmM3NHhRWFlrdTlJSEdobER2aVpOT3J6b3lPdS9qS3lnWWprd1ZyOTNt?=
 =?utf-8?B?cFhUdXFVSlhvZmhCc05BenpHdndOZHdDN05rVWZCWVdhT0taOWhlaG5acHZq?=
 =?utf-8?B?MU96enlMNzJyVmJ0L0toSG5nZ2Vwd09nakJyY1VhZXp4NzlGSkZIQUh2T0JD?=
 =?utf-8?B?WXhjYU1nVXJiMExoRmx3VVVnZGN3RkpaN2ZDSjZvUkh0d2VBZ0Q5R2RPU3pS?=
 =?utf-8?B?Vjd5c2I1VkdmMHNwMEFOaXcyUlFLQkEySzRQRDBZM3JEU0hYVWVydnI2eEp2?=
 =?utf-8?B?ckljb0dVU2JLc3dOWEtjZEh4YkREemJlM2VwcXRGUmMzdnZmUTFMY1VWaysw?=
 =?utf-8?B?bDg0MitIWTVSc0FmR2tDWUs0K1JEcHRkMzVFOEU2QWtRM2lzOHUwS09nZHl6?=
 =?utf-8?B?WmJZUTBCaGdQQVhtWGxROUkwT1BhenpSK1FCMW5hK3VLRDNQc0o5clVMZ2pR?=
 =?utf-8?B?RDJLRzBRVlB3RVNoVndQNVpQZVFzayt0TENKeE5Zd0N3cmpxR0ludDZ1OHFQ?=
 =?utf-8?B?VFVNay8wVXZLY1NDc1VKTUkxQVR4dCtaVlJvMENtbDVyekhaZUJPbGJGQ1Qw?=
 =?utf-8?Q?NtajJtKDWi/tY?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjdPK3Y1eDVFRks1OUZsZnFFRnoxVU83eFR4RXpCMEJQNDNFRWFKMnRUdEZh?=
 =?utf-8?B?QkZVaWlyRmZFb0lIcm5RMG9zVEtwVHVzaC9nZllIR0FzTkpTUGdBd1hHVVZM?=
 =?utf-8?B?Q1lXQzVHSTYrbFBXVnRyOXZsMjFvUFdGME1uTFlvQUFtcVVqbCtKcnZQR2gy?=
 =?utf-8?B?cGJvUllGbDlaVk5kZ21Vd1NWd0IzMEJBeHVWTndUdWp4bzJGYkpMQU5YbHBV?=
 =?utf-8?B?RnhmZUJkRjFNOTZQRW1VYlE2dEFPT0tpa2J2NUdrUmJZYVloMDlyZmh5amsw?=
 =?utf-8?B?bjZKcGMwQk1GanZybm9oaHlMRk5PUDFQa253dGV2Kzh1WGdlam9iN1g2Q284?=
 =?utf-8?B?TXYzK0x2WlNpR0xYMzlleXJRUStLeCtKeTRNalhQdEg5N0Qrb1E2TmlURmZM?=
 =?utf-8?B?VXhwcTFmRHo3QWRBUTNjdjNqVXRNaHNlWG9YREMwV3dVZ3hrNjA4cklhN1pC?=
 =?utf-8?B?Z0E5THBzVDhFcUVpUHhqZDdWRE1yeGJmYlRJRmVXOE1uNU9PTXVFd0hMZ29Y?=
 =?utf-8?B?aWZzVTRHaC9ITVREMldHQnkxQ1RMRnhLUi9kWmJYTUxDSU9GOWx5NGlpcGd0?=
 =?utf-8?B?N3F0bENIZlZkcitiWTZLSjJRdFB5V0d4U2Y0bzR1L3d2elhDdDJJTlZuV25Z?=
 =?utf-8?B?U1VJQ1hramFmYk1hVjJvTU1jUlErZmxzK2JkeTI1Y0Nqa2RPcC9oOTFHVDBD?=
 =?utf-8?B?Q0Vvanl6UzB6eEtIYnBGQUF6YjNXNk84emthL3NNUDdYQzl4ZkJLcTNVZUdl?=
 =?utf-8?B?Nkp4NVUyYVF6SG9HRllRRkJtQVhUVmtWb3hENzhkeGo1VS95ZjVTVVZCaFFq?=
 =?utf-8?B?ZTBoRzNLTXVLdGFsdUk0QWdNZ2dPMXVkWldFMjZZaGk3M1JmQkM5NCtxM293?=
 =?utf-8?B?TzlSWTBLK0FSTDVaV05IYmY1SkNhejlZL1o4ZC9HbmpHdmY2UVluSmUzR2ls?=
 =?utf-8?B?Zm5XMUt3WGdwbWwzVDd5OWVhUFBmdlhkUjl5eU1vMkloZG5WR29LZWpCdUxj?=
 =?utf-8?B?YjhXQ0Z2ZGdEWGtsdituVHo5NlFFQmthYXh4L2RURFRYN014cHFDNG1qdGwy?=
 =?utf-8?B?ZGo4VFpVWDNvM3JnbzlUUjB4MGE4MHpSVk5meFM4QnNncnpLVWVCT25MWUl5?=
 =?utf-8?B?cXJBZUk4VTZjN3pjbVlSSEk1SXVGZjIwVW53QWhET2RYWm1mRHkxZ09wZW9H?=
 =?utf-8?B?Zzh1bVNaNmRpRVZjYUwzYjNGZjRxMGRzZy9qUFNBcVdvTEszOTRRaHZCZXlO?=
 =?utf-8?B?YWl0L0pjRzUrUk1zeGVJL3lIeGsxT25qZFVnZDhPWDc2RndOMHlEaTRQQ1B4?=
 =?utf-8?B?Qi8yK2E4ZUJqVkxRZGZ4dzNVdE9hSnVFK1Q1MEVlNlg1WXlNSVJ4aFcwQUcz?=
 =?utf-8?B?KzhLUEJMdzlTTkE0NkxGL29mWjhtUlJlMnEvYVlXdGlnZVZFRGZLMURkVGNJ?=
 =?utf-8?B?UEZTdXJaSzdmVkFhVWdYdXVZbWhoZ0hkek5FZ0gzdEd1WXl3M2VGWVUxK1do?=
 =?utf-8?B?RHZqcU1vcUVTZEgydERKajdsLzF5cjMzMEFWeWhyeDQ3R3hOaTV3QlgzajJS?=
 =?utf-8?B?WjhGaVZXVHBzbEJ6WkJZNkdaNDN3MkdWNXREQVlNWXpjZDRnVTUwajQ3YzNS?=
 =?utf-8?B?RlczZzFJWlFmcGt6MFBoQ04xY3lXNzNFd0k0NE82ejhYNlM3NG5xS2tidTJJ?=
 =?utf-8?B?Z0JMKzNGTm9VOXJNMTk4aXIzbWp5bUhKcTZ2WWdPMDZBYWVzbmJERGNsQXdw?=
 =?utf-8?B?SVBSNkVDR1QwcHc2TDZ4OEZKUGxLczh2Rkx4NFJiV2hITCtIVWpaeWRqdCt1?=
 =?utf-8?B?Yk5WNGNGdnU0TUlyUVF4UFVEQXl6VmNoTXNqK2dLcEJzMWxSbFVvU2RtTkpo?=
 =?utf-8?B?SkJDQ3dWSGNVc3dNSUlaKzkwZGRuTjVvaGdhQzV5S3gvM0E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be87f03e-e1a9-4d0b-52c9-08dec085890f
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:01:29.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB10304

vfio_mig_get_next_state() walks vfio_from_fsm_table[] one step at a time,
looping to skip optional states the device does not support until
*next_fsm is supported. A blocked transition is encoded as
VFIO_DEVICE_STATE_ERROR, which the trailing return reports as -EINVAL.

The skip loop does not account for the ERROR sentinel.
state_flags_table[ERROR] is ~0U and vfio_from_fsm_table[ERROR][*] is
ERROR, so once *next_fsm becomes ERROR the loop condition stays true and
*next_fsm never changes. The blocked arcs STOP_COPY -> PRE_COPY and
STOP_COPY -> PRE_COPY_P2P map to ERROR yet pass the support check on a
precopy-capable device, causing the loop to spin forever while holding
the driver state mutex. This can result in a soft lockup, and a panic
with softlockup_panic set.

Terminate the skip loop on the ERROR sentinel so a blocked transition
falls through to the existing return and reports -EINVAL.

Fixes: 4db52602a607 ("vfio: Extend the device migration protocol with PRE_COPY")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/vfio/vfio_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 6222376ab6ab..5e0422014523 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -858,7 +858,8 @@ int vfio_mig_get_next_state(struct vfio_device *device,
 	 * logical state, as per the above comment.
 	 */
 	*next_fsm = vfio_from_fsm_table[cur_fsm][new_fsm];
-	while ((state_flags_table[*next_fsm] & device->migration_flags) !=
+	while (*next_fsm != VFIO_DEVICE_STATE_ERROR &&
+	       (state_flags_table[*next_fsm] & device->migration_flags) !=
 			state_flags_table[*next_fsm])
 		*next_fsm = vfio_from_fsm_table[*next_fsm][new_fsm];
 

---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260602-fixes-f5c6a4880594

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>

