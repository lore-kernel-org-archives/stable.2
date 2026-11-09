Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794259112;
	b=Jylg7E/HnnHfzYh3qG31CSapqewMa+kjaBQ3W0zex0brC+pYJ2Mj4B0RGJ3I7btSB8ab
	 lvM10P7qUk+yfNLItTcCpl5kp8khYfm182xrHrBkM7Z7UgPChlNNQ6fOeImqbGpgqd52/
	 dF4u1niLK10as+cu48TK8yY3e1uFKi0oiOSg38AskrntiBUXHVt7wDUqOw/dmzcS7aqpe
	 J/hwx/YulXWwnwa9eAK2TuiFigOTQFT0nY2m/aBXCiGc2BooFO6P5YpF9x3b5oEZIWxuz
	 BEAOMpZojlyS3Dtf/s8Flq4uI9njPtjSW5XB8QR7y9hfjo0Wl1ZDd6s3ZtarZCPnfMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259112;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-MS-Reactions:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=4BtzVLWThIpWtN+y42OyusvnPOpXFLxTl4GnX9HW1hE=;
	b=jgobM2n/2hKsVo27nuATSqmgFV2eP3a8kCPaDWUdb1Jw/DO4p9Id9ArWKoH0IUbA5Zx6
	 pgiSAliglKpEGYpUJnkOGJ4Z3NT3CEya4cFwnygOMG4CsZPGMhnxhbJCJ18nop3LIt4mn
	 bAajBwNOgBA6qHE10Gkr91MZ1K2Lgbv8Q+6rZGLMbdxGm18CGq2GTnegOFdp6cq+W5vX4
	 R6FU0u8r6chOXzQDwP9SDRrs7F7YzuEmQW+6pB4IvAuemy9cvKCt4gn3GGttD/wX3TkJb
	 dgYqxiiKuwzPfqUlRpIACVkJ8JLN5um9XjjK93SKH+Oz1a/6vEQZheTqm5r/uUltj0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WpFRySw8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.13
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C100606A31C;
	Mon,  9 Nov 2026 21:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C100606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WpFRySw8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFpWPB12oN74WG0nsP3WV34IBY1A+cr2gKcgpQEqXW8vPfr25KRtDQKUEPIoLJSzQkehdgsO8x5xcF4FMObdN58M62Bi/hc7T+AMRsXmj2EcCTTragGkXGsTJJ0buyxyPMIznBCn+ngU4RBrL8Lw9+Ga774d4EtZzqAGKQaIb7tz8x7qFUn1BLfmllodjO7bDCaDp27EoyESZ5RllbVZXNpbbRNb4CPR8tTDndarufeL8P/qbgBgRw+ll6HcHzPmI/RLHQlGbu8wKaL3qU6AQ6ViM63tvD5ojjIXA+4Xak47RFxMg2czEZXo/PuGFoI7ZuGRs2wyFwpdx88nP/vm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BtzVLWThIpWtN+y42OyusvnPOpXFLxTl4GnX9HW1hE=;
 b=Plz2vadqWLm8bRFBLToWHr4eL0UozW3I3UvZdv7kJZ8Voxgcyf0+q0rhBAtQ9os3aFTNNUdotVY9TYdHtt41DQ0v03WGnzbguPX2LjxL5flVUcIpBV2ChroXUaUz53akLMi5ijULr/xQ9IsaBG2V07XNSs/SzBU/kd2y2fEaP16PQUtrLW0lkZSFi1ipmOOJquOI48omnPbQswAlI2HyDjS4KLxkGRL4cN9a6Qz4OkjdlhtiInawfgyFu01ugVq4EpDG7QY5JUIwZOFAKuma15iBOHIGMkhz2rm2qYhpK9/MFVuJFm5oshr57d6xp5hn73K9Hxmao94p9rOby3R3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BtzVLWThIpWtN+y42OyusvnPOpXFLxTl4GnX9HW1hE=;
 b=WpFRySw8fn6Xv6aPx6u/YL6MVTNqKJMDbNTIJwKlDgciDdUG7xBuvQf5QG3otcYH6jOS45lYCVlGtLX3GLuxEUe7/3Xhr+1UUbb+PgHOFnM12a7YRf/4dKLHX4DfMtRj7+Dvz6PEGTH1xlDBFj4pzwVQM79c4PzYYk4CpM7t1Vktyil+9IongjvAxTknkWBW8SZ6thGkBVa5jYC4VtOjjY1ya6ewc6FjVmwJM0pqGwG1nmd39lzdpeKqZUvopDLYfoW05489klEa/zUFDAllEAXGGM3bcnACHQut+b04mBEny4kLjkGU/qwZ4HHoKE9IoE02sD90ie7bnJbFCmEyYQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 21:18:26 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 21:18:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Date: Mon, 09 Nov 2026 16:18:23 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <98C24D6A-22AD-44D8-94DD-E73C34A7EAFE@nvidia.com>
In-Reply-To: <940CBBBB-D564-4D4F-9C8A-A9A272F08064@nvidia.com>
References:
 <20261109-fix-split_folio_to_order-race-v3-1-1cdc509e34be@nvidia.com>
 <5a7bb477-5392-404c-a748-4748cec2c84f@kernel.org>
 <940CBBBB-D564-4D4F-9C8A-A9A272F08064@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: BLAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:32b::33) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed6efbe-ee53-4606-ab5b-08df3ea6fdfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|4143699003|11063799006|261021123027099003|261026121527099003|261022105027099003|261022075727099003|261021121427099003|261009223027099003|56012099006|261026140227099003|5023799004|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ZN6eRDaQooQnN3MZfpnVLMxDmiLHs3EzXW2E8JJM/RROTKq0NbKlRELYTrWhKiF7sVs44009lzfM/Kwy9NP946w8rGACjA6tsuyffmfSrCq/XY6TagPBad5JRz3sJBf7dBBJcEqwwpi0chshhB516oAuyMWqG6rAqdmR/2FRvhI6ZXul91AFAemawT24yhYUzPKgdfKX8MqKxFGGKctFLGCt+Y6Jl/eibiQl2efTtFHwxTrwWiMit4zFqx5fE+I2GpxRghRPikPt68xzVxyzTWFCp5BwV/uX7bjKBOyGY0UTR6WfQ6EFnN8x7GhmNzKoXQGzgChjcnZpVyG4X6ehU2LAN7DLKB4odvyprFf4Y9S2xlbvyC66mke3MNlljY8mGqsBuB53wypA+eeT+BYQxei0R7T9eA2xCp8z6PvPl9tu1JcwJf6y5dnWx8KCf7DmDij3g2paWLsqGPvExUsA/Th3L9lGT2poD+AtsWyS3puCa7p96w1YPgMl7C+FsO+j/Fk0EFraOx6QJPEdJNsuYo8PT7XWqtui24nwS8XVyGEGnc9am4/GRjsqH5GpQghEBVCPuMG8mki6LWN0hW8UPEC+vLqZh9H/dVgr+yPp8xqlmnHoqbrFNc/aIv+muIqgTBsURmBPrbuWvNN3b1N0CrV6Xs0TtlaWbIFbUHaxLRk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(4143699003)(11063799006)(261021123027099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(56012099006)(261026140227099003)(5023799004)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHAvNlB0SXM5VXhYM2F5TmFDcmhmZU1xVEdKdmhtT0dscVV2UUlhZEVHTTRs?=
 =?utf-8?B?Y3FVVCtOU3RpdlpzOU9ySldUSVRmSXZUZUlZSTZ2RUpmY0tMWUpTekVaRTdC?=
 =?utf-8?B?VVo3a0R0dEJoUHlyc21YeEF3dllIbUI4azNsUkUvdmZ1UytKVDBnanR6QUJ5?=
 =?utf-8?B?MmdwSGRocmZoOUVqNFRYdUlBNDFuQXl2dFBqVE1HZDRnZ3Jsaklzenh5TUxy?=
 =?utf-8?B?MGVvT1RSVVY0eWdSMFFoT1BGeWg5dVdzeFFINDhzUCsyc0dHVHN4ZEd0K1U4?=
 =?utf-8?B?K3ViNTY1WjVYM0VrWjVXd2d3K0NSanRITXh2TC9RcnMzVU1qclZqRjRWTG4x?=
 =?utf-8?B?T0ViVDBkMzUzWU1WRTdJSlZYd0RwMlBpK2dGVUVRUkxJcGdHY0lhVVJCNzkx?=
 =?utf-8?B?elhWWUtMNVg1RERHenA0SjdNRTBwMVI5cS9nMFErdDBDOE1MdytBaHRRNmFE?=
 =?utf-8?B?VFFtaXBJb3R5RDNqTW9neCt6RG5zT0g0N2lSY21TQ3hwcG5nSWEvdU4rekhE?=
 =?utf-8?B?RzEvakYyajZUdldybFJSS2I3MzBObzJaWk5ObmZyaEd3clFHcFd1S3hpcnd3?=
 =?utf-8?B?Mmo4YzRmK05HNFpPSUw0d0FGaTJNVEo1OHFKeGgzemVQWnZQQWhZMDNpTncv?=
 =?utf-8?B?Z2ZzdGxoT1NtTUJScFVIdFIyZ2cweXk4b1dJdy9ZSkxwM1FpZjRwVkozaHVZ?=
 =?utf-8?B?ZGVlZ05pV2syY2tpZ0dwRkZRZ0JoaUV6akNUUzF4d0hRT1JLdi8wcFlPQnYr?=
 =?utf-8?B?R2NRTjhQSCt0aVd5eFVvTDV3ZGg2RG1WTkpWRk9NNG1OaERWRUJMcHJzOFk1?=
 =?utf-8?B?cEtzcTF1emNPbXhScWFjam5DT3JsNmg4MWtKWWhYNmM2cFJJZUh0WGtmYkpC?=
 =?utf-8?B?L1ZMT3VKSVVDbEh3RFcycnFHNUJZYjZ4aGU0RUdveUxTNU9uckhjQkpPRkZa?=
 =?utf-8?B?Q1NXcnN4dldwNi9LcnlYTXkzQi9uQ0g4WXA2NGJ2c3l2ZmwwSFlEaCtFZERh?=
 =?utf-8?B?aDN0TWhMOXJaeUJEMUM2Y2NKeGlBc0p2WnYwNkJ0SWY1RjFaOHd5L0JjejFN?=
 =?utf-8?B?Tm5vcHkwdFhJSWttRlZyZDZscSswT2NMMEtRb0xjSEJsWUxsc0srZ2IraTNH?=
 =?utf-8?B?eGx0MlFJSjF6TW1PWk1yNVRnUHhlNWpMYWNlRThsa09UN29Zdmd1Y1ZNSjVk?=
 =?utf-8?B?SHRqUFk5TXlkZ3RiaHYwR2NuZFVacVZvY3A2ZHd4SnkxNi9Wc2NRa241MFBH?=
 =?utf-8?B?ZCt0VjU0MFNEOW1lK0V0eHVJQ2VCZktTVXByNXNhWHJkWkgzaGtnRTNDYm84?=
 =?utf-8?B?RXV0eXBQQWVleXVvVGZFR1M5Sm5kZms5VFpjbVMrYm5ZcEZCMkxoNDBLVnNR?=
 =?utf-8?B?ZmljSGdtZC9STDFFSWVuNUZJaml6WkZtc3JlVmtCKytCWGovL3JuTS9JV3pR?=
 =?utf-8?B?ekFvMStZVGJGMGJoSjRVd0pJSmVFclJLY2d5QVJBb0UzdTBDSjFTUlh0blFZ?=
 =?utf-8?B?d3ZucFhteE1xN2l2T2F6SzAxeGFuTndvMmduc3FPd2xtUHIwcTFqYU90RHJ3?=
 =?utf-8?B?RHRENGNEc1hBcXpnNDd0YUFTZ21aOHozR3czQTNFUzMzSzlWTHAxdm16ZWxu?=
 =?utf-8?B?NVJNbEE3dWRHN1JEQW5VdjJ0by9KSkI3dXp4UEY3ekVJeHNJeWZ4OGp1RmtS?=
 =?utf-8?B?OFB4VjBGTnR3V0VEMjJlMTlma2pIMVE1V1RZYlprb2VpQ1g4Z3lPLzFXL2NE?=
 =?utf-8?B?aXZsbTV2VjNtMkhNRENUTmdROWFCZ2J6R3RaMytEWkVDTDE4QXR1ekRzUTVJ?=
 =?utf-8?B?MlExcHZPZnNra0NMTENrMGR4UHJpRGErUzhPVWo0ZnZwQ3JXMnhra1VoMXow?=
 =?utf-8?B?cFZmS0RjbFJSR0pJOWZSMHdTN3ljZXdOTTEyZEhta1lRMS9vL2JINFFxV3FM?=
 =?utf-8?B?SDVUTklycXAwalNBbmFlTGZUWUFHL3lTdUZtS3o5TDJuUllxcWY5VzJNNWJu?=
 =?utf-8?B?SDFETWtvMDNmcWNBMHFsOUFvclZZQ1N2emtIcTdIQTVHcldwM1orVGJMU0Va?=
 =?utf-8?B?c1grMzE3YUZabkVUeHJvSmJjakNrWGh0dFg5TnA0eUZpUVYwUWxZdlZIYlR3?=
 =?utf-8?B?OG9zTjFtaitrWm56SUZocy96YkRSYnZPdTN6THhsSEFDQ0xhSnROSkpXTksy?=
 =?utf-8?B?ZXVsZEpIQkV0UWE4eWUwb21wRzIrRzJWNFpqRnpSM2RhSXFQeG1IYmJ4ZjUw?=
 =?utf-8?B?T2IvQ1dEaHJkTWgyNUJrMmdFZlRraklHQVNaYVNoQzdPVTVyNTltWmZ5NkFl?=
 =?utf-8?Q?II+heRaXNofM3O8slN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed6efbe-ee53-4606-ab5b-08df3ea6fdfb
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 21:18:25.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pmrZm9ou+UBGV61Oa0cPx63OP9tQR6ntCc42CRkuvYBACzPh2HT4+TvrIZdOMyl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019

On 9 Nov 2026, at 16:05, Zi Yan wrote:

> On 9 Nov 2026, at 15:21, David Hildenbrand (Arm) wrote:
>
>> On 11/9/26 20:32, Zi Yan wrote:
>>> __split_folio_to_order() calls prep_compound_page() on each new head pa=
ge
>>> to create a compound page after clear_compound_head(). prep_compound_pa=
ge()
>>> uses non atomic __SetPageHead(). It is mostly OK, since the folio is lo=
cked
>>> and frozen and no one else is supposed to modify the folio's flags.
>>>
>>> However, code calling migration_entry_wait() can reach the folio by PFN=
,
>>> then access its flags. It is because softleaf_entry_wait_on_locked() us=
ed
>>> by migration_entry_wait() sets PG_waiters concurrently without taking a
>>> reference and the frozen refcount during split cannot block it. Meanwhi=
le,
>>> __SetPageHead() does a plain read and write, so PG_waiters atomically s=
et
>>> by softleaf_entry_wait_on_locked() will be lost if the set happens afte=
r
>>> __SetPageHead()'s read and before its write.
>>>
>>> One example code interleaving:
>>>
>>> CPU0: __split_folio_to_order(new_order>0)  CPU1: do_swap_page()
>>>
>>> 1. clear_compound_head(new_head)
>>>    new_head->compound_info =3D 0
>>>    (page_folio(new_head) =3D=3D new_head now)
>>>
>>>                                            2. migration_entry_wait()
>>>                                              softleaf_to_folio(entry)
>>>                                              page_folio() -> new_head
>>>                                              (not the old head any more=
)
>>>
>>> 3. prep_compound_page(new_head, new_order)
>>>      __SetPageHead(new_head)
>>>        tmp =3D new_head->flags.f  <-- load; PG_waiters =3D=3D 0 in tmp
>>>
>>>                                            4. folio_set_waiters(new_hea=
d)
>>>                                              set_bit(PG_waiters, &flags=
.f)
>>>                                              enqueue on waitqueue, slee=
p
>>>
>>> 5.     new_head->flags.f =3D tmp | (1UL << PG_head)
>>>        <-- store; overwrites step 4, PG_waiters =3D=3D 0 again
>>>
>>> Later, folio_unlock(new_folio) sees no PG_waiters, skips folio_wake_bit=
(),
>>> and CPU1 can remain blocked indefinitely.
>>>
>>> Fix it by setting PG_head along with other flags in new_folio->flags be=
fore
>>> smp_wmb() and clear_compound_head(). The remaining compound page metada=
ta
>>> is set after clear_compound_head(). In that way, after
>>> clear_compound_head() makes new_folio visible, nothing overwrites the
>>> PG_waiters from softleaf_entry_wait_on_locked() by modifying
>>> new_folio->flags non-atomically.
>>>
>>> While at it, use data_race() to suppress the KCSAN issue reported by Ye
>>> Liu's patch (the second Closes) on reading ->flags during a folio split=
.
>>>
>>> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
>>> Reported-by: David Hildenbrand <david@kernel.org>
>>> Closes: https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.c=
om/
>>> Reported-by: Ye Liu <ye.liu@linux.dev>
>>> Closes: https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-11=
2e331291c1@linux.dev/
>>> Fixes: c010d47f107f6 ("mm: thp: split huge page to any lower order page=
s")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>> The issue was raised by David when reviewing Ye Liu's "mm/huge_memory: =
use
>>> READ_ONCE() when cloning folio flags during split" [1]. This patch also
>>> supersedes Ye Liu's patch.
>>>
>>> [1] https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e33=
1291c1@linux.dev/
>>> ---
>>> Changes in v3:
>>> - set PG_head before smp_wmb() like Kiryl suggested instead of
>>>   prep_compound_page_atomic().
>>> - used data_race() to suppress KCSAN reports while at it.
>>> - dropped Lorenzo's ack, since the patch is changed.
>>> - Link to v2: https://patch.msgid.link/20261106-fix-split_folio_to_orde=
r-race-v2-1-1b59c67b8af3@nvidia.com
>>>
>>> Changes in v2:
>>> - renamed __prep_compound_head_and_tail() to __prep_compound_page().
>>> - added comments to prep_compound_page() and __prep_compound_page().
>>> - Link to v1: https://patch.msgid.link/20261029-fix-split_folio_to_orde=
r-race-v1-1-a483c7451b0d@nvidia.com
>>> ---
>>>  mm/huge_memory.c | 32 ++++++++++++++++++++++++++++----
>>>  mm/internal.h    |  2 ++
>>>  mm/page_alloc.c  | 17 +++++++++++++++--
>>>  3 files changed, 45 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index bd44d58e86845..99b48d7c988db 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3714,6 +3714,7 @@ static void __split_folio_to_order(struct folio *=
folio, int old_order,
>>>  		 * Don't pass it around before clear_compound_head().
>>>  		 */
>>>  		struct folio *new_folio =3D (struct folio *)new_head;
>>> +		memdesc_flags_t new_flags;
>>>
>>>  		VM_BUG_ON_PAGE(atomic_read(&new_folio->_mapcount) !=3D -1, new_head)=
;
>>>
>>> @@ -3730,8 +3731,16 @@ static void __split_folio_to_order(struct folio =
*folio, int old_order,
>>>  		 * unreferenced sub-pages of an anonymous THP: we can simply drop
>>>  		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
>>>  		 */
>>> -		new_folio->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>>> -		new_folio->flags.f |=3D (folio->flags.f &
>>> +		/*
>>> +		 * ->flags are stable since the folio is locked and frozen.
>>> +		 * data_race() is used because reference-less writers,
>>> +		 * 1. PG_waiters from softleaf_entry_wait_on_locked() and
>>
>> Hm? I thought that case would be handled by your patch? How can they sti=
ll write
>> to the page?
>
> This is V3 of the patch. Instead of using prep_compound_page_atomic(),
> PG_head is written before clear_compound_page(), after which new_head
> is visible to the reference-less writers.
>
>>
>>> +		 * 2. PG_hwpoison from memory_failure(),
>>> +		 * can still write to it.
>>
>> We lose PG_hwpoison left and right when racing with non-atomic updates. =
It needs
>> a fundamental fix. Is this really something we should take care of in th=
is series?
>
> IMHO, memory_failure()=E2=80=99s reference-less access violates the froze=
n
> page contract and should be fixed. But I do not think it needs to go
> along with this patch. We discussed HWPoison flag race with
> Michael S. Tsirkin and Miaohe before [1]:
>
> 1. Miaohe proposed to reset HWPoison in memory_failure() as a best effort=
,
> 2. mst used RCU for all non-atomic flag accesses,
> 3. you also proposed to move HWPoison out of ->flags.

We probably can add a per-section bitmap like pageblock_flags for
HWPoison and only use atomic ops for that.



Best Regards,
Yan, Zi
