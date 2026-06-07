Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011060.outbound.protection.outlook.com [52.103.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646A5325494;
	Sun,  7 Jun 2026 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780834381; cv=fail; b=fSpF+frWZiAszAvL6MZ/3gcLHmAAjSUJxC+o6z6OO5E2DxuJwjjaPTEFR25TxzMbiA25SZ9/Mhc4DVQQdkl410If9zgW02ou7a4FhGoIp1zpVClCNTvGE40RrJx5rOGpW7YGiaFT35Kr2oDjeBKbbAt/0d1ICPgE25EJLyo7qPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780834381; c=relaxed/simple;
	bh=3rmSM7gXNiMTrjxI+7D+dm/LChKNJiL+leo2Y5C63qs=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=SW3DUlTRHtbdFAXSkxmUZBNq8g63f65hkjyXW9aL5UfOHS2jULm7xlnGKYvppT+2Q3yxnYOjiqFVykYbk+Ceh3yONjoG/A+8FJxUXrmkZCkDJc3cw74ugA5LIYAPvetLG+cutN7KJtSfnBbH0q1vLYYybhE7dRto8fRQq8ZPd/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AObf7L7g; arc=fail smtp.client-ip=52.103.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AObf7L7g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OY0O+XnrsysYir4apT2JNoIW6SSZAOWB0Zf3iS9KPnzyABd08k7tcrq0UEhjMur3b2U+SuSSDH/RHE4oouO4tO2SZE4HcQ/7Ch7bOsybpGK/3A6U2Bykv7LOwTV6/1iew1G/YXdpskCeKmXNqRR+yojfEPSoPQMwg1qN7aZdnA6jQMQMBqir9cJfrO2Cy1Bf0TGtUEh8OWDE3ixVdyzugPcw9gw4buu4uY7OWmCrmLtvqbvqMm5WChy4fAQUx7KfMc/FatMSo7VsQSuK59QHo9Fp1jsiZG5kzFNgPRdkepuy+km0iTdAGWm1afpnUm1XwZs5DmvZW+npajgHSuWGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1I8+NKxLkppSBCAnKvQhIVTkf2SatzznkQ1suFrYWw=;
 b=QCbrESR56O4tIxZfpOiMzVGce+OFjCQW2xPPFvEEeA/9/se9ZQXwnL3LIeT34wvQNj+vwxio+hRu+uyBiAzjAKx9tmdQV7slaESC4dGgaJgyaJCPYZ+9MzdEIVKROSjpelYIX7V2kb8Dy9nw2yz+9JFmoIzqHkLN5dYlkJKrfbWEYS84SSS3MTZgFJMg0MQQoK+kRhCPsKd6RGhd7Xer4Go1j9JrIDfBtO7W0/ZVEajShXLwKAA7ltvjWwqgcnjCWKH/U1uuw1cyd1SmkcEbrprUABGIIMw8FDKgX4YxlvsEkWtmFfqVr7/xnvMEVa6K1iaQp5+1QLrjSs/Dw7pjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1I8+NKxLkppSBCAnKvQhIVTkf2SatzznkQ1suFrYWw=;
 b=AObf7L7gdiGvoTdUw/cl48jtLc1hUWkxYsFc/qmqiqvDv0KateLSdplAEe/pef8Dre8I0vxqULUYYeUVQMo+gxZlrZoVu0D2LGKd6x/7S7ffYy4PvXufauMMbfM0Sj9cQN8V4jm+hx0n+uGR19rN4P8sRBvvlNwbJWRWJQzLudPJBzVo+VyHL5O/VjXmMCbdysgVdtCc6eYmtUmlqrLptcUH4lGelzd2yh0d6WHsOSkTWWGUJFDcm2+3qOmqixYjq+AUcuLR3S7xmvUFoqZEkZVq6lsFnZyDGvsTiMTIVlGLzgV0wGr6TvTRjCiQs9VIWOZ3FPXEm92Onsqj6dxWLQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY8PR01MB9363.ausprd01.prod.outlook.com (2603:10c6:10:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 12:12:54 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 12:12:54 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Sun, 07 Jun 2026 20:11:09 +0800
Subject: [PATCH] drm/nouveau: bounds-check pushbuf offset/length in legacy
 DMA path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <MEYPR01MB78861402D9E05E9CA6B67859AF1F2@MEYPR01MB7886.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIANxfJWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNz3bTMitRiXVPDVGNzQyPj1CTLJCWg2oKiVLAEUGl0bG0tAKtV/U5
 XAAAA
X-Change-ID: 20260607-fixes-51e37123eb9b
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ben Skeggs <bskeggs@redhat.com>, Francisco Jerez <currojerez@riseup.net>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=3rmSM7gXNiMTrjxI+7D+dm/LChKNJiL+leo2Y5C63qs=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGLNX4OzarZCcsY+eRjppacn/ZycO1DzYlu/QnJTbdm
 i+9uTKn50lHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATER6CyPDETH5tOyp1xXP
 +nNf2XCKi99vp3x2ucHHQx+cs1cbPvL7xsjwZEXAC/Za9/nu73qnyMmd1rdujdp/K19lc3TJiUO
 VKiUMAFNTSaU=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: DS0PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:8:191::6) To MEYPR01MB7886.ausprd01.prod.outlook.com
 (2603:10c6:220:17e::8)
X-Microsoft-Original-Message-ID:
 <20260607-fixes-v1-1-ca008cbdabaf@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY8PR01MB9363:EE_
X-MS-Office365-Filtering-Correlation-Id: f34c35b8-a452-42af-fb9d-08dec48e1924
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|8060799015|5072599009|24071999003|5062599005|23021999003|19110799012|6090799003|55001999006|24021099003|22091999003|24121999003|20031999006|39105399006|3412199025|440099028|40105399003|41105399003|35041999009|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkRJb0JHcDRKQ3NCbEpENzN4eG1reWovemtES0RZcy90a01ESVEwMS8xUWFa?=
 =?utf-8?B?bml2a2E2YmUwTlpQMXMrb2x1R3NaNnpnMThPMTlRN0dGaFBFRzZPQU9wTVU3?=
 =?utf-8?B?OEkyRzFocXQ2ZTNpdnBtejQ3M0F6NjIvZkdBT0xhSEh3YWhuU3Mwd1RzcFBO?=
 =?utf-8?B?ZkF2UXZIUkxZd015ZmhpVDc0Y09meGVSUmdqdHhRZWg0bmdkdGh3MTRuZkRz?=
 =?utf-8?B?R205RUxRYUp5OWNHWGdPSnU0SEdDeDR2QjVoQnBpSVh3WWZyU0lPSm1vTWZp?=
 =?utf-8?B?WmVobFBTc2NmMTM0QUpyUkIrMnB5Z0hDR1E1TDNZQ3p5bktmaHdWNTNMWDBZ?=
 =?utf-8?B?ZW1DbUdUTVNZODUxNHE2Znd2VGU4L0krUE83REdwUVZqQUViakdJUzQ3MXJw?=
 =?utf-8?B?OW9GZitZcXU5dU1lNHRBTHRKR0k5S2hWL0NrSTZnRWdERHZmd3lpMHlyd1NI?=
 =?utf-8?B?RUI4RHlDSWtGdDFOTmtqbVl2OVlpejA1NWNNRDU4U0pGUXFTbkhOcy9weEY0?=
 =?utf-8?B?dXU2ZXd3MFBxLzJkdUZFcFl1WlVNNkdQYVFOUndMUEE1T0h2Rm12RjJxNVdJ?=
 =?utf-8?B?MlZrOXRkMkhFR1RQMzYrN01BdS9qZlcrNXZnb29lbEZRUGtxWVovVmxQMFph?=
 =?utf-8?B?dmovYXVDMXRweDI2Y0pmcCszblJnUFptM1ZiMWJLMzRLTklZM0xEVkNIb2w0?=
 =?utf-8?B?YnNYaHY0TFF1Q1dUbzBrNHR2QS9FS1F5WFZFdVdJR09LMXZEV3hPUEVlRnBB?=
 =?utf-8?B?WnpFTVBpWEo4eFliakdoQWlnZ1laK1k0Z2NHNlQ0TVU0bjNQZ2FPN0lLWjVS?=
 =?utf-8?B?M3BzcmpZa0NEZm1abDErYUFsSVN3NGxXdTJkcTBvbzl0VGNJOUNPKzIvVjNO?=
 =?utf-8?B?SlZhU1NibTl5YzNxajQzWnU3WGpnRytCSTEvWlhzbm8vZjgrcUNmTFk3bEJx?=
 =?utf-8?B?dThOVEUzUFpMU3pnV20wRUdKazUxSTFoazBxWTl2OVlVK3VNd1hMMnpZcVBi?=
 =?utf-8?B?WGxaZm5LbS9Dc05iQ202YnNRY2h2WU5TUjVnSE9tczJxbldzdVJ2TkZBVmFy?=
 =?utf-8?B?QXM3eG9xdVV4SW8xUUIvU0dOOGRLbmFHNEF5dkdMQ1JrN2l2cXYxRTNXd042?=
 =?utf-8?B?V1o5WmdpS2xkK2dTbUQwR2s3R1F6MS9xa0grMGpNWVplS2VSSmxLdGJTWEJq?=
 =?utf-8?B?NTUydTRlcXRMalB2bm5XK3NVMDBnazN2STA2OFB1N3pma2R3ekN2WWdaNmJn?=
 =?utf-8?B?WmVIbG1GdTNtN3JNdnNJbGh4Q0UxME53K2NhM3doRlBhUlNJWnlVTVhDbHd6?=
 =?utf-8?B?UmdsUmhUNElKSU1SMTltbmxoc2QzbVg0YTQzT2lIMEtVMmpqdHB1cC9GNU5M?=
 =?utf-8?B?RlRJQnZoL25HSGlMaTUvck8yRmNZNFpGMlRXRGhLdktIZWRtRnBjQmpVQmg0?=
 =?utf-8?B?K0FLTGtMMFFEQXlDei9HN0ZYUURFTzRtR29xbVlscjJWTTN6L1pkWjRxcExN?=
 =?utf-8?B?aWg1d1M5TU1EVFFINnhTR0F2SGM4bnlxSGhQMjVLb01JbzNaTnNCdDJsNHhE?=
 =?utf-8?B?SE5ySE1Kb0QwRXFQTUpUcXRDZCtCNDN3UVhValNBN3B0TnAxaTh0YUdHcTA4?=
 =?utf-8?B?Y1hJaUVtdWtBZGN5NUFHbkdMdWZyblJCNmdkaFdQckFYei9NdHhOVjVYdWk5?=
 =?utf-8?B?TE9JZlJCcU9aQ1VnUTI1MzNTS29NZXBpZEJnakpOcEVUNVE5amMxbjVRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckVUVi9DU01ITVZTeEVPSis2cGpDVXlwQnN4ZlNSbEdZb3RXWjZ4bEh1OUVU?=
 =?utf-8?B?NVloMUFhR0ZyZXRuNVloSnBvdk9qczUwSktQNko3cGRCRGNLQ0YzWWF0NEIr?=
 =?utf-8?B?QWNWNGpvUVBFSlo1TW41SW5nTzEwRG9HQnJubFdBYlJMR0VDT3dhVGt6dkw2?=
 =?utf-8?B?V3NFMkVxc2taZE5OaVVyMkM5bFNRUkkwbXFDWE9OR3ZRa2hPeVNKczlaZ3JQ?=
 =?utf-8?B?NnR3THhhcjJGdVh4ZnNqWU1Ea2JoVjZRek1GVXJPNG5lS1hvYjd2YW02cmVq?=
 =?utf-8?B?Qk1SdURIQkZXK0xhT2ovWmE0dzJpbm9IOU9sVlNJQjVSTjdnM2VraXF1SVZt?=
 =?utf-8?B?ajVRNjR3OUhMRjAzaEVjdmpmRnh6dVhYR1ZncUExN3d0VFl2c1RKTTYyMGN3?=
 =?utf-8?B?WStBTHl4WHVDMUc2a0tPZFdTYWZMdmRjcGdSdzJlMjU0bWxCZEpmTWNTT2d1?=
 =?utf-8?B?d09SUzZJdnIxNHFmald6Rmo1ZmF2bjVRWC9ET2E2djA0cUpaRSt5ZFFvMFNy?=
 =?utf-8?B?MnRzN0k2WkllM0J2VERmUnhTZloxNm11Q2dXM2ZSSmprVEtFWkpNUEcwbEt1?=
 =?utf-8?B?UDZ5eU9CRjNFZFlrQXN5Yk8xRVh6WmFFeU41QlUvWC9GdGE0VGplVWMweFhR?=
 =?utf-8?B?TEtkRWZGclVYQVUwajVZSlp0cTJLNDJpT1o2bm5IVllXUWpHajlkaEpYNG9z?=
 =?utf-8?B?Y2pLYXc3eEJhR1lqeTlJdFNoSnFnSlBtSmIvVklYenlYdGFqdFo3NmZWMmdE?=
 =?utf-8?B?c0wrTjBvNGNQVlZLUFFvTVFRQVJLVVZ3TGdhb3B2SUFsenhtc3h5RCszNXor?=
 =?utf-8?B?c21MYjkwWnhCN050aGxZeklkWTNQRDdqODA1RGg4UGZTYU9wejZxbWllQnI0?=
 =?utf-8?B?MHNrTnQ4Q1hLaU44d0J1Y0pDZldic09vMTRvZmYwOWg1bFVDOXoxbHZRemZQ?=
 =?utf-8?B?TnA5TTlaYWNvbk1Ebmp1WUpTVHRHL3VBcGxEVnhoTTlyK3pmZ0o0eXRLQm9k?=
 =?utf-8?B?eVpOSnpBWURmajJEeU9JemJGN3dnR2xlMlVKVmFaMXpsY0FnQU8zemdaVVJn?=
 =?utf-8?B?SzhGYTE0VlNJZHd1VElwUnlWY3Jma0llNm9MS2piS1NwOGdWOFhSWXJ3YUVP?=
 =?utf-8?B?R3pqSGFtL2pkMkZROG9maWdhU0JjeC9yR1JpMGZzZFVqZUhUektCU1dpQ1cw?=
 =?utf-8?B?Zisyd012SWU4dXhRNXZVSkFGZXgwMEkzWFdqUjZFYUNKMjZMRDRzS3RmVzZU?=
 =?utf-8?B?Y1NJdVlLMXRoTHhzNEE3eXFQU3YwMzV5M2Q0YnlQVkpETVNWczhkdnRRcGRP?=
 =?utf-8?B?ZVRaRE9hYW5uRkY4c05HU2lZd29mVDQwYlZUSlRRaHdBTWJSZ0RMNXUxeDdE?=
 =?utf-8?B?Y0NGQmpNVkVpZGZyZU4rOHVsWWo5dmt5Sm5BaFNOUDRrLytSQWN4RWlSdW9O?=
 =?utf-8?B?NUlseW1zYk4zV0pGUzJFdDJLbEtkK1Izd1BleUtCVElyZnZJK05Zc0FWNTYw?=
 =?utf-8?B?K3lWdW5mWko0c3d0WDQ1TkJEKzY5VTJFZ1ZZTTJsajkxczJFU1F4UjNxZnJJ?=
 =?utf-8?B?OVplbDROb1ZCd05IaDlzcHJUeEVzaEgyQnJXZEFoMk9VbmhweUtJRDcvd2hT?=
 =?utf-8?B?Z2RySzZ1V3FNaGJ2eFNzSndvT0d5WC8wSUtza0FyYlFZc3hGZ054d0NSY1Vr?=
 =?utf-8?B?TDM0OWMxeGoyd25uY3JzcGtJZTYzYzErbEwxbTNFT0FFemlJKytPMmwyQlI4?=
 =?utf-8?B?Q0hNVWY0SzdUdnRWWlBPZzdvWlRVU1NEb2tidFErZ1VTc2d4Rmg2dzhNeFNx?=
 =?utf-8?B?NGpvL2loS2ZyVFN2dVA3cGliUDhRcG03RXlod3hBd2hTR3dyZ2FZdXhtaGVi?=
 =?utf-8?B?MmJzYmpGV3NOUzVMOGFsYmZLWmR0bmE3cFQrK21VYmF5cXc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34c35b8-a452-42af-fb9d-08dec48e1924
X-MS-Exchange-CrossTenant-AuthSource: MEYPR01MB7886.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 12:12:54.5327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8PR01MB9363

On the legacy pre-NV25 DMA path (chipset < 0x25),
nouveau_gem_ioctl_pushbuf() copies each push descriptor's offset and
length (both __u64) from userspace and feeds them to
nouveau_bo_wr32(nvbo, (push[i].offset + push[i].length - 8)/ 4, cmd).
nouveau_bo_wr32() performs an unchecked "mem += index; *mem = val", so
the index must be bounded against the bo. Only push[i].bo_index is
validated; nothing constrains offset or length against
nvbo->bo.base.size.

Fix by rejecting offset + length < 8 or > nvbo->bo.base.size before the
nouveau_bo_wr32() call, mirroring the guard already present in the
sibling nouveau_gem_pushbuf_reloc_apply() path.

Fixes: a1606a9596e5 ("drm/nouveau: new gem pushbuf interface, bump to 0.0.16")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 20dba02d6175..e9309279ba8d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -898,6 +898,17 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 			cmd = chan->push.addr + ((chan->dma.cur + 2) << 2);
 			cmd |= 0x20000000;
 			if (unlikely(cmd != req->suffix0)) {
+				if (unlikely(push[i].offset +
+					     push[i].length < 8 ||
+					     push[i].offset +
+					     push[i].length >
+					     nvbo->bo.base.size)) {
+					NV_PRINTK(err, cli, "push %d buffer not within bo\n", i);
+					WIND_RING(chan);
+					ret = -EINVAL;
+					goto out;
+				}
+
 				if (!nvbo->kmap.virtual) {
 					ret = ttm_bo_kmap(&nvbo->bo, 0,
 							  PFN_UP(nvbo->bo.base.size),

---
base-commit: ddd664bbff63e09e7a7f9acae9c43605d4cf185f
change-id: 20260607-fixes-51e37123eb9b

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>

