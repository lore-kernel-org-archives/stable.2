Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795452483;
	b=zYqZfU6gY0uTaw1zA7TR4uMdhJ8ccQEyZ2FuNSqOb/eQTinIRBhMt3qCzVtEDEARDl49
	 xp/THerUI60KldLzAQ/FU5cufM3UkNRqT3d19H7bIFGwTGKn3dcU7HJ6neEnwJVBlyJxU
	 zRPZ9Ell12AUkb6+30HbBCG4rINE4YUB2x0Q2AXnwVIH0epj9wdqKEbUc8r2uCn7yNP5E
	 KJ658JPj3xwAFuozMHDka/PFUio7NEroVIP1nDVjTgkrb3mBLQpDzWN4HWCXWVmAf4iZt
	 m4HVoAqguQJe+GnlH5re/cU5H7FBtlt/mpVPeyV40WY2GkHV4ZNUR5eFdxN6U1VhO5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452483;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:From:
	 Subject:Cc:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
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
	bh=C59Hj2GPaaYR6fsr3+2DRanP+SzL6tvGvdxzBxWaH88=;
	b=kcVrL92zzBuUxV7aaDNAwFNcoMs/1nqOoP1bvP3EJF0x0yVtfvqOXXrg9kCyoKom1xB3
	 3dGJY+gE2bPeBVu9hdgUxSiT5xehpVJFRA2G26rwldWinFyBsFkNj+7iwI2SAS71UV0Re
	 NrdVgwZ6AgqqnLsBTlQT16hQ3qUop017jJisVlhfFdz4avgi/Z3j8c8RcpNBBl04zm0vM
	 Kwslv2WDwh8i1c1atnrNtZLoJUeNvp7UquV0io8Q6ADB8zmlPs+uVdNeglk9SBInCUJCj
	 anBi5XGZ2qCTqk7oTUW9x6lTmwCMKioYsPBjLNXI+TLdKRGYRAOzQeSeBXLnWNVcjaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GesyU4KX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.38
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F41606A31A;
	Mon, 23 Nov 2026 16:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81F41606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GesyU4KX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he1vB42lG5VTc9zqvON9qzyOyVEmQRmNXjLvlJYXWThyJvsyM5mNGb9rQ3AEWX0BpdpD1LUQ3nieZuy+Kdxy8W6McBWd/OoyiaXzrXMQdFlpEeBXszjFiK4AgFtwgWXo7+xkykqeekpHOLpGw5sj2xObBv7D66VaUbaBnTWD/nvk1V436mlraX06B7EkdKZqkIIGE/mvo5KnGztO/LMLHsatC3R17JN1bRjA9l6NJpiBc5UdgTk2h9AJJd+xon3fAImr1wrMPKef6k2i+DrXNnEZeLk7TRV+fK488dpF419gSIyI3WE1MSJgmFL9l227MSIWD1TJhHMiv9Ga88JdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C59Hj2GPaaYR6fsr3+2DRanP+SzL6tvGvdxzBxWaH88=;
 b=L5+qOJOoIo/b2xYwh1yT4HgTIqC17uZdlEqzKXsASAJkXVOfok8KpCgKDJQu8rv61d0G8cegt1AZgf/R/d+8q1hYb/NGvweMOWl7rD2r5m47IVCiO0yyzAG/dfNAiStKdnt+xI8JFFZD6pAImQFs25C0D1tnG012R/+CKsmv71DMMRkSUdNXGZ/6jEkw8uehH3Qvfn4u/GDFpnnYSpJSVD7tk8YU0Kz/q/PSwO95oCqgjZ5ni6n1TydiNgkRXntff8siGqG4m5dSM/6lY+06b2cZ9mKXO8tuzA9P4AgRZ1nIdpwaWboX5FazhPLQ3F1qNztN8aOTIakvPxDMI+MiwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C59Hj2GPaaYR6fsr3+2DRanP+SzL6tvGvdxzBxWaH88=;
 b=GesyU4KXVT3LjJgecOsRoYimfInq28xY0+6UuQtiBt0l8La6Q0PYYh3Y7EeFjX/LUxf2SwY++fiLwEJWQmV/M25pLgbybz1Kywu77bAGnM0dCFPiTO27e9hV+3/RXz74IQKpXafi+AxgD5zLI8nm1nm9esPG6q6LTiLs44f4AnI7G4rGkI5aeZllG3WBpnA3+/iFu+SMZr4vgnaFEPdVZzIO34dte//tVHH7qfQANCCh9rUeXl3W1jVPcjRqzcjZN1/BSnDoZ2wv9FgWpk70JvdypUJP+sLY9WD2K7QYtsMF1pIB2BpBYtvGPJ9goD84mtJkWfu/UD3xpMnRtOxRHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:47:56 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:47:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 11:47:54 -0500
Message-Id: <DN2QS80LH19O.1OM7FT3FFNW7V@nvidia.com>
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
Subject: Re: [PATCH 1/2] mm/huge_memory: use NOFS when allocating while
 splitting folios
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <stable@vger.kernel.org>, "Chris Mason"
 <mason@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
 <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org>
In-Reply-To: <20261122-migrate_reclaim_deadlock-v1-1-83c56185b0fb@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0339.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::29) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 19807074-c67d-44bc-791a-08df49818680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|6133799003|261009223027099003|921020|10067099003|5023799004|4143699003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	G/qY9aBk47llSDCbrAWEsfn0xwyzGkkrnZA+DZKg3JCdb+xQOXvvXtAfM8mGFEEFyW3G6fOCM/QIOx+r8ZvAMPZNAb4qrXKdQosntu/MdeIclQlMJ2mFpjJ8+BOrb2hYiJsiK4f3ruDZzNmCrpENPk4g6P/1a3YnCkZGpbfV/owDDXCH5U6N3Qi+plSS+LOv+5gt1OrgNofT6vY/pwn+28QUhp+ni7CWlOQIjvZaLIivUJYdk+SxlPRyKe2O1SStjRINyBCMVwpm+sL2QE/hdmSNoOlmMs+rF43S2NiI/UAiS/Jo8YR1f4ntfI7u60NSMC2WeidF0VSURN4T1ZvehYCuNC2xDOn3Unj4xEovoNeHKaAqaYx/mXePkiS88CDh/j9dydiJ2xFHTwOMfUwzx8XkqokPI+ExAbMs0abYyRn3IqKz3WeBMOBSwdbUIXfRJ1XYVzfAzGZpFTRfdW/jfqkdNqsHTG/JRkORcMh465qLibFe/gXhoW14s6zYwlovVe/WB4qBY75GpEpOrht7cJMy70NWTj2f67enc0H07cT2erz9NkxuD6nf6W07bhxXAM6hKWPReljiUbr71k2GeF+91qL9Zl0u/NFR7r9b35vHr17b7O1j4lpwl8kaGow/Uddetyx5BhxRUmvYbPNDBbbCb6NjODnNlUTviyw0OBc60EalKKAzITjcwrpiEPHwxt9oIkIjJj0hv7YC3zlMYQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(921020)(10067099003)(5023799004)(4143699003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlJxSXdBdmpuM2gzOUE3dWs5WVNlTmdwSWR0S3FTMW91Qk9hcXpoM3ZxQ2k3?=
 =?utf-8?B?T3pHc1ZKNEkrRVprRUdTb29kQ2REOVcwMlBrS1JpMVpyOElsRW9uUnl4VjMy?=
 =?utf-8?B?dERvdzhFUk03NXV6Q292VjNoT1pibXNmTFJaV2Z4UWhSSWp5eUpmMEgrWDBw?=
 =?utf-8?B?NFJhVkx6V1FxOG04Zk5TVnhRM2t0bDBQZmJjbHZaRVhqZ3VBNHZBeFNDd053?=
 =?utf-8?B?M1g0MWxJdFFQNkp6ZTMrUDY4NGdubm5mdHY1TFBBQ1h4NmNWeEtLSlQ1emF2?=
 =?utf-8?B?ZVlvVVN2aGhDOUJCR3EvTlVtQjFIb1l1WU1RQmUxdy9pK0thNmt5ZTNXRmRR?=
 =?utf-8?B?ek9YZ1lUa1Y2VWE1a2Nvb2w2WDJDN0g0bVRXLzRiMXNpQ09UdkkzQlV4ZEhH?=
 =?utf-8?B?S3VUK1hhRVhTUDZ5TEZraVRCdjliL3RWUVlaR3pEelBKZnlsbkFKZnhoYkFJ?=
 =?utf-8?B?RExKVHBtbERmclZrQ2JqNHNHRkZ0SlV2Z3R5Yk12cVl1NGVpaU53SFFubFFi?=
 =?utf-8?B?TmR4MEhoNHlwMFRhcDZiTTFQajFXL1hEWElkbFNWVEhldlR4alR0VnlLekEv?=
 =?utf-8?B?QzhkaWorM2xRZVYzRi9RYXBYTzZWN1c2aW5sZXZobDdoZVlScEgyOFdYQm9G?=
 =?utf-8?B?TC9tSWkvY0dESXZzME1TTHNNcHdsbWxjeHA5WXVDYVZSYVZKYlFkZlJDQ0ov?=
 =?utf-8?B?SW5jbkhvWDBzTUMxOVpsdFc4alJwZUxld2U2bTJpLzdNRzZ3Qy9LemsxL2x3?=
 =?utf-8?B?MUpJVEhrcTJ3aHBlT1FocGYyK2JkVVQ2MWxNWVhxUUErTUxjZ3V4VUQ1Nzlt?=
 =?utf-8?B?aFZ4citSdHdzSTMvYjh6bzF5WGhHU0FwZFVUTXRkOTNiR1FuQnFCTzd5YWR0?=
 =?utf-8?B?SjRGN2dvYjIwaUVXbUFhQjg5QmZvOXpSVE8ydnNQZjBuUDZTQTNKeXdMcytO?=
 =?utf-8?B?eThyREliZ2dMQ0hIRmhQdEp2eUh6ZDM5MHpNZ1JkdStoSWg1TVIrY0o4UnV2?=
 =?utf-8?B?N204c1FOdnJoNlBzd2RHN3RiUks5a1BvVU9acHNrNmdZcXhXK3pqcXN4SjJv?=
 =?utf-8?B?dERiM04vMUF6ZVRtdGRUZlZFL3k1NTVzcUpHOGo1Rm1OcTg3U050U0g5ZUhs?=
 =?utf-8?B?UFF1ZW5NdXU1TUFtdk90ZmtzWGovOWx3aHN0aDRwREREQ1M2cGg1ZFM1djJY?=
 =?utf-8?B?UHFFQkY4RFliRHB1SWJVN2ZSd0dFNm1RM2VLNW9tdWhOWXdZZFBsRmpoaldX?=
 =?utf-8?B?dUZvRHNtNldNcFpxQnlZM201bkFjVWN3YXk4UDR3anNnY042WHNnQkF5SU9C?=
 =?utf-8?B?Z1VzK29JdllTOEQrU284QlVNUjA2OTJFblpjSFdzNC9NekVKT2s5ZDdjQ1VZ?=
 =?utf-8?B?U1EwRmo4SW1PNHM3RVdSencvVzRCaDVBeVh4ZkFhRnpqWWNwN3ZXVGZ1UUx4?=
 =?utf-8?B?ZVkwYkFtNmQ0V3BVV0hGTHZ4WHdGVisvaXpUZno0UXBmMEZyZVBNUUoxMWhi?=
 =?utf-8?B?eUhpcGJzNW5RT3hyb1JYcGFVRjR6Q1dHZ2VjN1BSWW5tZmNQNHB2bFpPUVVG?=
 =?utf-8?B?TjBDMEpXRG1ycEJ1bnZ6T3BvZGtPUGFlYUJteDBnL3JYcGZaTGZNV0JZMFZx?=
 =?utf-8?B?LzVQdnl6NHcyZFpYdi9XTmp5OWlXTjdwS2FjTGdveTh3aE1aak1iRit3TEJ5?=
 =?utf-8?B?cmU3TDI1QWtTbDdibThVTE1oOVJuWW5pOC8rZHFaQ3liR1k5RjhTeUxVajBr?=
 =?utf-8?B?RVNLbjBvdUpLV3NLV2VjK2JZTEJXWUkrQVlQcktXYWI5cXozc2JMRWt4a2hU?=
 =?utf-8?B?WHZvNlcrWXpjVVhzeWVoQmgrcHQ4VVBrSHZud3RQM0p4ZEN6UmUrMTBQclBn?=
 =?utf-8?B?c0RsNzIxbGNXNkwyMnFlS3liNGtCaFdsUU9sRUNDQzAyYVJocGdNVUlLL0lL?=
 =?utf-8?B?dVZOTXVDL09lbVJnZHc4L0tWSURZdjI3ejlTbEs4NGx3dWVFeFJSb1RsemtI?=
 =?utf-8?B?RERJY0pVcHFVTkZMUzBWRGI4ZDk1NlZTcTJpSUhuWXRnTE5BMlhLKytsSnBI?=
 =?utf-8?B?cXNSbGF5cy9qZVQ1dHNtYnk3ZzVxaEkyQ05Cd2V3Q2tRdVErZzJWUTNVTmky?=
 =?utf-8?B?MFREcEtUMGduK2ttOXR4emxMaXpPY2dWRzFRSUYxaTg0Y0ovU3NDbnk4dXhZ?=
 =?utf-8?B?aHZLSnBZM2NNMmdsUWRhelYzTkZSNWxUelVyTnl6T21pZTRBY25NZ0tLN3g0?=
 =?utf-8?B?dzRCSjdYYzBpODlobjArV1VsWDc2QXRrKzh3TnpSVlBBQk04S3dldmRLc2pD?=
 =?utf-8?Q?aZsmzX2jlolu7fo3uQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19807074-c67d-44bc-791a-08df49818680
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:47:56.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGaj3aEQw2vlcGXsOFNaphDJyp30IFHpYiGj43UeNzdwgMTnrM59en3PFC9CgwZ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990

On Sun Nov 22, 2026 at 7:42 AM EST, David Hildenbrand (Arm) wrote:
> Various callers (migration, memory-failure, s390_wiggle_split_folio) spli=
t
> locked folios without holding a reference on the folio's inode.
>
> Splitting a file folio might allocate memory for the xarray and call
> filemap_release_folio(). If either ends up in direct reclaim with
> __GFP_FS, reclaim can evict the inode through the dcache shrinker, and
> wait in truncate_inode_pages_final() for the folio that we hold locked:
>
>     try_split_folio()
>       folio_lock(A)
>       split_folio_to_list(A)
>         xas_split_alloc()
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
> Further, xas_split_alloc() charges the XArray nodes to the memcg, and on
> cgroup v1, memcg reclaim waits for file folios under writeback if
> __GFP_FS is set. That can deadlock if writeback waits for a folio lock
> that we hold, for example with ext4.
>
> Let's fix it by splitting folios in a NOFS scope, so callers don't have
> to care. A NOFS scope also covers allocations that filesystems make with
> their own gfp flags, for example in filemap_release_folio().
>
> On NFS, splitting folios with pending writes or ongoing writes to
> fscache might now fail slightly more often, until these writes have
> completed. On netfs, only folios that are being written to fscache are
> affected. All fairly irrelevant.
>
> This has medium urgency.
>
> Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
> Fixes: eef88fe45ac9 ("s390/uv: Split large folios in gmap_make_secure()")
> Fixes: 789763523fb4 ("xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()=
")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/huge_memory.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
<snip>

> @@ -4478,6 +4487,7 @@ static int __folio_split(struct folio *folio, unsig=
ned int new_order,
>  	if (is_pmd_order(old_order))
>  		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
>  	count_mthp_stat(old_order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLIT_FAI=
LED);
> +	memalloc_nofs_restore(nofs_flags);

We will need to make sure future code all come to here for the return.

>  	return ret;
>  }
> =20

Otherwise, LGMT.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

