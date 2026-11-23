Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795454685;
	b=k+aaO8sPFzWws/2JfVaGG4IxnGKtOhWd8tRFZq1aBOiQdO0P0xkfYtyc1JFyT27HpJJv
	 xzrpmsZmJ/ZF8bm2o1TtkORORQeuXAHxjrh9lE0CcNqxo6Z5VMLXurM/RckhtTWjqZVn5
	 Hsnrl5Lb9Zwh54PYI4yNUAoK2aUKecYQro6K+yapO6VExoAAHP6VawKCwLSSxjPxdRS8p
	 StAn/nxXGfjt4E274yi5HuKE+fmtD/yW0mmLWjy8O9i13bOs1LUAXP7bAhectoLmfGEXY
	 7QBICv6Jrhi6rQ1JpanYAobzkay3Os2dwgqcx2UdBnugAEdqa8Skxf4qq03rZy64kYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454685;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=edA/ZhnYCaOhrpZ324c8HW6lHpQPAiEdl/wZt2/3nTU=;
	b=Vo3lMN3To6vVVMzCOX48xB65dOY96eeerDwCNipvMYq7Yizn8H3mnnsbQWf+15SWaFH9
	 JE36xGjHe7B12HJ+cs1+vtpJPJuCYArKT/yKaIq8kOdbuqLbgINvSSHzwilg4bNSdjPLk
	 VFHkRel2mXHwyyrqHNP4UIEQQ6mfncpgmNapzSkBc7S11odkSLHGEE1sHoIz4qpGs1I74
	 rvXC0HaWeYynhujVSu+8SwqhUDdqXQV7khiHdry5gdHeEoflGH2Z+XVZpFICb0CN5/blc
	 3AU2EU+uu+fD/r/nThkbSktuEReMXGuLMyrZxECusVS0jHxx0ED0eNDxchKb14ek9gQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CqZw4Dtd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.38
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510FE606A31F;
	Mon, 23 Nov 2026 17:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 510FE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CqZw4Dtd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4UH+9kDabtLqdKCLkuwPQzR6IOCx0iSS4LQiqspuKSbHQlsArn84b+bbvv2DxUBoG3vD+zABANxlceXbNDi1Habawcu1PPwQkVutnAVoF1RfAK+8PEjc+7O+Ji9/2dSkvjKCDMTumsEWu2Yqxp/J3z739Gqx5DtrLu5m4cVXOEV2RDXW5OZutYg6hPVnCSICx1gP1ufl0GJQc2xx0Lw2lJMiyH2ZwrrlYTZ4F4mtZCGI8NUTZQXz1lgHSkgGE9GW3TK9wMK5HW9bBEuQDH4Dht80bSlVHS0BZUiOVfSbyV/ti7yHkVNUxD37kDaxxjJLcZ6yAGX/KEqQK7lN77MEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edA/ZhnYCaOhrpZ324c8HW6lHpQPAiEdl/wZt2/3nTU=;
 b=MP7/6ugDr7j+Q+uLV4W/j1757jI2gd+6BZoqjTLVyLZNmFCstXz7QgnVl8teZxq3+rwG4L/VAXXloRkrOKBl26qJt3hMpgetsV+NSaucKcDhuY80+Nacn0hqWmWLSh6SjS3LlzGKFHlizlAiNRzNKiq9g1Ham1eW3TKuAHXtG1Mgy1PswLM+HUbqww46Aj4MKGQ7NLB9ORq0xuomOMryXWfHAppx0Xm//sGGDHKiKPjWnQ2smfJ5jRfjUgNRalYRSNEitz4/Nytcb4MYFw99O8xe0bMgYKBh/SVUYwu/5L58abNOfsMS9VHNtuEvdlf9QOsXDmwb2QVdhq4nExMvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edA/ZhnYCaOhrpZ324c8HW6lHpQPAiEdl/wZt2/3nTU=;
 b=CqZw4Dtd70Dj/oQ8Nzn0txPfVvVoQSXsnHlhf+zGf4Q8ts1aPkRYZICE4IbKkQLkKaFCOMHvYFQHe04UOZu11FbKQUm1bUsbWVDWXtZzxWwYiUA0IQsJM3jor+3qdz71SH5oJSVINk2neW/V+PeZXfwowOFfY2JVRxSHBfY5jtHZS6JnFYcVkOpE8GRg6eJVzavBh73zP+ySFHL9CHa7n2ZTeBa+rP6wrQaOpapYltjqQvlakw8QhMvVZpwAEeTkBUlAU8Vv0vPKKnaKLU47xfM7MGIiSOPUr7yPD3P5cmef5OIPBHbDeDX2LXxd4+v5CY/0sOk9SpnmVZjWaJX+vQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 17:24:32 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 17:24:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 12:24:28 -0500
Message-Id: <DN2RK7R9T87V.1DLJWTHIM19Y5@nvidia.com>
Subject: Re: [PATCH 2/2] mm/migrate: allocate destination folios before
 locking a batch
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <stable@vger.kernel.org>, "Chris Mason"
 <mason@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>,
 "Nico Pache" <nico.pache@linux.dev>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Dev Jain" <dev.jain@arm.com>, "Barry Song" <baohua@kernel.org>, "Lance
 Yang" <lance.yang@linux.dev>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl
 Shutsemau" <kas@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, "William Kucharski"
 <william.kucharski@oracle.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Lorenzo
 Stoakes (ARM)" <ljs@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>,
 "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Byungchul Park"
 <byungchul@sk.com>, "Gregory Price" <gourry@gourry.net>, "Ying Huang"
 <ying.huang@linux.alibaba.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Joanne Koong"
 <joannelkoong@gmail.com>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
 <20261122-migrate_reclaim_deadlock-v1-2-83c56185b0fb@kernel.org>
In-Reply-To: <20261122-migrate_reclaim_deadlock-v1-2-83c56185b0fb@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0239.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::22) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dff6ba8-dcb1-425e-30fd-08df4986a209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|6133799003|261009223027099003|22082099003|18002099003|261022075727099003|261021121427099003|261021123027099003|261026140227099003|921020|261102123227099003|261028144727099003|56012099006|4143699003|261022105027099003|10067099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	9KCyaDpM03HXT0lwGQBePrQkd9tQu9Wv6oaLUGozOkiz9Dl9GCiUtIgiMU+6g1pL8JdthQcSRVmG37nfJ/4n0jTGpdFNxYePSbvaG/p/iTm9zLk5Y0WX8vRxsQmescC9kkQtt35AJDEb0uUjJnFWf88kQYlytz2g/bH1XvemA1TDGJo67a4043L7rVbwV2+0T2xXuI32OI4y1VvLA8xRFHcOzPQFcurqxlhd9LFCBQz3YleGpU5ZaUWU66wB4LIqVF/KeD7cDDA/qkpGsA5Ce9ovErJJuh3w5q3NTxGgppGDFdvSuhrTn2JcdziWZOpU3ILwvocYVpqKr/D/uoBe8ovMRjw5hT/txo2oB/SKttDqX1RUGuamrtnfsFsts+fklu6HY0jT91OKlL0LytQ7pb5RRcnNEdpDdSi4AF1qMp49xBAjCJC8lwGZWtz2QSmOqnyFo3topG5QvfxPFj5rH08HkOT76ShZHZCaBZ6jLGaqDBJn/0S16P9JeZe84vtSZmwqYr5ySJvcKezes53V3a+/a74lEY9rVuJoE2yud+Feer7erBc0NWitbbxuXcitOGNF8S+PkzeOusZWvZ5X3kQkYKRT6VGl/yaXDo7UzDeT7s9Huzb4HMo5M4HzGQ8EkumEYQEVA1kOX+PBgCnCbwObZokJIr+TBCUnXQp+vxEY3Qw0NjvWst5g8zY2HpFURPWdgbzGHI/ZyYVmjwE9/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(6133799003)(261009223027099003)(22082099003)(18002099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026140227099003)(921020)(261102123227099003)(261028144727099003)(56012099006)(4143699003)(261022105027099003)(10067099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWdyeGRXVWd4UjJpWTVOWW9ZaFhxZTFtNEI1Q2U2alFaVTA1MG1aUit5cXFs?=
 =?utf-8?B?SDZjb2FRSE40a1RPVDdubzBtZTN5STA5NHRXa1p4cXdPamtzZ1JtcGFoYUJ1?=
 =?utf-8?B?WXBpbUp3dldHbEdRQmJDbXc0V2Fualc2SHN3VFZ2UG9aTlZkV25VVkdmeHkx?=
 =?utf-8?B?b05oUGpRUFNlT21JSlFWMFRLdFZDbEVGcFNGTWxweStNVm8wbm52KzJQenBh?=
 =?utf-8?B?akdzeFhDWWU4TVdSU2lTc3JlUHAvc2VKUkQxY29tVTJVczQrMW5VdUZKTDJl?=
 =?utf-8?B?S3JaWmNqdGRKVFA3bzgwUElqMnVGb1ZjVlhHMW81bndNemtMNUNoVmhSS1VT?=
 =?utf-8?B?T3lNUnYrY1hTdGJYUTBhT1g5dGlDRnhuUkNKbWh2QVFSM0lIV3pvc1FyU1VT?=
 =?utf-8?B?RG1UTm0rSHZ2cklvbU9JMTY2Wk5OcXNCa2FINjlFemJNVERaemdmL1M3blFH?=
 =?utf-8?B?aVJnRnhDVUx0cklkOTNWWlJMTUhIeHNSZURlYkNKVGRJSWh1ZzZlVXFGaTVQ?=
 =?utf-8?B?cmdmeW5CcmZocmhORGdLaCt4cVVSNlk5UytBVUg5SVV3L0JxWVJMWkNhL1JM?=
 =?utf-8?B?VEhoYmcxWFVITXNhU0FZeSs0YWpGWm5BQllzUDN6Y0VHa1B0cjZmZk90aDFF?=
 =?utf-8?B?T0lRYnZtbWJ5VHpHU0NMZXVTUmtkMEF5OG5sRFhodUttb1R2ek1jd3hoUjU1?=
 =?utf-8?B?emNlNkh3V1hZbW1SRGExRElVcUVtUnNGRW1yMHhQbW1UNm4rSGZ4MUFwRnBY?=
 =?utf-8?B?aGJnQWVPUGViRktGWE9GaUdmN3FlMGNyYkhSL2FTWEJJNXNzQVhEaTFKbzlm?=
 =?utf-8?B?VTh0K1Z4aHFNY2dxWkxxd05RLzV2ejJ0d3o2QWlGaUc3MnExcGNYYmNMWVF6?=
 =?utf-8?B?MmVOQi9ObW1sSkU1OU0xM2h3eklnVzVzOGQ4T0F2MkRTMEM3UjhHK21hdlEy?=
 =?utf-8?B?cEROVFp6N1N1S3dWMG84Zno4U05XTUxDWTlDYlR6QXNsWHh0SFdFa3l6NkxC?=
 =?utf-8?B?NEc5cUhRdGlrKzdqRytSL3NIVnlsNVVFQ0d5M0Y5c29NWkJKSDhSanJSUGQ3?=
 =?utf-8?B?N0E0NStDWjBJVGthd3JySys0a3ppWFNJVm9EYW9nQWg4NXZiSVBxTUgvMHdj?=
 =?utf-8?B?SjdOV2hRejVTbWdmOEg4UC9LR2M3ZHhCL3hXU2Irdk00dUdrbk5UV0dRdHF4?=
 =?utf-8?B?Z0FoMHo0NlpvUlkvTXVidk9ObGpKUFIwTmhnYU4wUnVYUDgyWDRkcDhBUm5l?=
 =?utf-8?B?M3ZPMi9mYTVycHVjSDhucmY2d2hwZEV3bVhkdXNHS0Ewclg1Nm9ZZUhiOU9k?=
 =?utf-8?B?KzVLV1d4ZFlOUWc4aTBKK0d1VTFmbjRkaThVaXNmd1YvWUpydjU4QWV5bnNx?=
 =?utf-8?B?UzNHT2JxUk9hTEQ3WmZrUTRkeU9uNWFPMmdrQUdhVGZLZi8zaFFHbFFKeWJG?=
 =?utf-8?B?WmxNU0lBYTlKOFNXZEI2dFl0S3dOSXNlT3dPWG44Z2NGbFk3ZURSb1RlVEt2?=
 =?utf-8?B?bm8zK0RqMzRyMjRGcFE3ek42cmR6WFVVeEo0S0dPMjNHdGwyQmxYR0RGMnRH?=
 =?utf-8?B?RzUwRnY4T0ErMTBkLzRLSDU2RVE0NjhVMjl3dGJ2ZDh0MkwxWW9sSVJZaTFY?=
 =?utf-8?B?cXo5YjZVaUovYkJPT2xoa3JtcnRmRG5vck94eGxyM3AyN2VNY3A3VUludGNa?=
 =?utf-8?B?LzFwSkF3c2g1NDlWeDFsR2daNnpkVi9EbXBBVVpsNmZ0OXZCNkxLbGNqS3ZT?=
 =?utf-8?B?RjhEbnUrN09BbWNvRW5KdXFEU0Vqa2U4NXVyTXVMQ1NmLy9ZcHV2M291Ni80?=
 =?utf-8?B?UTVORkxqVE1FUTVmeWMvZzNOZTlCK0oyY1NnUThpV2JWRkVFdE9Cbkh1OGI0?=
 =?utf-8?B?aXpJQlluY3NMeFFzQXE2bzZ1aWM2cGpZT0NhTWxFZWpoM0EvUThJMk5JNEF4?=
 =?utf-8?B?REtkMGNBdnE0cllnS1ZmSngyeXZFTjNhbUh3MlhLV09OOWVPVWhWdDlWemFH?=
 =?utf-8?B?Y3J2ajl5a2JhVyt2NUdkS2RjM3VlazliVGVXUXZjam5SUXZLOFl3RjRVZmNC?=
 =?utf-8?B?TGJicDNHSzZtVVp3eFJDTzJnSWJZY24vMU8xK243MGtMQzdmbk9NRDFSWm0v?=
 =?utf-8?B?NldTdHhMOUZMV0w2TTRRQ3RJaWg2dFJpQzF2a3R4QTRhbXdrZkJmWHh5YjNC?=
 =?utf-8?B?anU5NXVDKzkyQmNjTmhSZUo2ZTBUZmQyaEY4Z1krMFRyc09nNWlUTXYwMnMx?=
 =?utf-8?B?ZG5KWEEza01udUV3ZlBiZ2ZxTGp5N3lTOXJDWHd6c0ZtcUwvWDU0dm9mRGEv?=
 =?utf-8?Q?+zUmaytInpSitN5lNr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dff6ba8-dcb1-425e-30fd-08df4986a209
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 17:24:30.5781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFqwO5UmLg2+XpblNT1py5O3KLeG6mxFeCiZfVaxV/4CAwipe/SJfKXCM6iEpbyX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085

On Sun Nov 22, 2026 at 7:42 AM EST, David Hildenbrand (Arm) wrote:
> Migration locks folios without holding a reference on their inode.
> migrate_pages_batch() keeps a whole batch locked while allocating the
> destinations of the next folios. If such an allocation ends up in direct
> reclaim with __GFP_FS, reclaim can evict an inode through the dcache
> shrinker, and wait in truncate_inode_pages_final() for a folio that we
> hold locked:
>
>     migrate_pages_batch()
>       migrate_folio_unmap(A)
>         folio_trylock(A)
>       migrate_folio_unmap(B)
>         get_new_folio()
>           try_to_free_pages()
>             super_cache_scan()
>               prune_dcache_sb()
>                 iput_final()
>                   evict()
>                     truncate_inode_pages_final()
>                       folio_lock(A)
>
> This requires that nothing else holds a reference on the inode, and can
> be triggered most easily with FUSE, which evicts inodes on the last
> reference.
>
> Consequently, allocations under the folio lock are dangerous if we
> cannot prevent that scenario through an inode reference; and we want to
> avoid grabbing inode references, because we might then drop the last
> one, and would have to evict the inode from migration context, ideally
> without holding any folio locks.
>
> Allocating in a NOFS scope would be one option, but it would have rather
> bad side effects, such as direct compaction not migrating file folios
> and the OOM killer not being invoked.
>
> So let's fix it by allocating all destination folios of a batch before
> locking any source folio. Now, we no longer allocate destination folios
> while holding folio locks, which also avoids holding these locks during
> direct reclaim or compaction for these allocations: an improvement on
> its own.
>
> We keep the destination folio of a folio that we have to retry, instead
> of freeing it and allocating a new one. If we would have to allocate
> while already holding folio locks, which can happen when retrying a
> failed split for longterm pinning, we leave the folio to the synchronous
> fallback in migrate_pages_sync() instead, which migrates folios one by
> one.
>
> Note that nfs_migrate_folio() still writes back the folio while holding
> its lock in MIGRATE_SYNC mode, which allocates memory. As NFS only
> evicts stale or unlinked inodes on the last reference, this is unlikely
> to deadlock; this must be sorted out in NFS code independently.
>
> This has medium urgency.
>
> Fixes: 5dfab109d519 ("migrate_pages: batch _unmap and _move")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/migrate.c | 134 ++++++++++++++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 97 insertions(+), 37 deletions(-)
>

<snip>

> +			/* Remember the source folio until we unmap it. */
> +			dst->private =3D folio;

Clever to use ->private, but I wonder if we want a new field name, like
we added migrate_info, to clarify its use.

In addition, it will be great to keep migration info for each pair of
src and dst in an array of structs to avoid the ->private being used for
different things at different migration phases, but allocating such an
arrary will cause headaches. So this patch is probably the best we can
get.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

