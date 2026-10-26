Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793054401;
	b=2zzKpoBqh02sYrzsa53Cmnf3iskhCHlMqza8FsR8V3a8iCWch66cav3RXsgoryn13VBe
	 /z6KK96VrocK4ecEVzGZeECyTrO0/QvfQfGGUJuVdFSD3+l5utg+02eYUFlEpkP4j+sqC
	 tLM/KmuRZN3b2AyjML08i4oCGdAlPCUc8mUwTFIkqAw/4D6nU7Msqh3nsi9lXLJxWze5B
	 hd+tlGKnNMH3HzXJ973k9FHMuIPwbWMUcn/2hCI3GqTChotF7fkgVXDYCGVHJcaxFiy0S
	 JiPyBxiElX7vXfP38dQMNbsyHpoWg20nh3Y0yXmAZMqNH5peVgK7+j3rolfWehNhZNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054401;
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
	bh=66VWupt/mZ6FBgq5tKboKohYjAfYUEXR7z0xP2PP65E=;
	b=5Me+jDcMRuWGQ+IK+ubpCZNtUvpo461xcuH/qKTbe+MQXoHckyOZYjb8x4PPvdoy7+hw
	 LUB2Gv0cDYv+p2+bwOfthZQ2EHhkBcPbEbju1E2cocX95DeJ31HWJG4SMrMP6rMYMwsaf
	 t/lAyaS3pggtouzDOq26T/wvsXAaCbg/HFIeLnuyc0uVRioLXtvd5O0QTGts2bvavqZAj
	 CSpGBNuSCrobls/D3WJAXt+u1MUCWeA/3xirXWXS4YW7tzWE3ULCmuWiLQ16HFAHHTONF
	 CHVi7L+pxx6HidPgayw5KLE8++e2rSbsokhtBRHaAChyAlKnzoDnr87yBcX7y3Cz1mQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CyhS7K6h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.50
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91943606A31A;
	Mon, 26 Oct 2026 22:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91943606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CyhS7K6h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLDJqDPuaqbCrSy/TC5HI/qDExVZ0goG8SAMrKXY7EeuAAxVYFwXBt7y4EZ5DnrC8+w/NTWdwEiGsCgNSpFZPzHubjlIY5SWg9HrwA6qdA4Or5pe3Oy4SpLvZD95IyKKMrzQTcnEAGmOxuTGPUT9gpXOd5TZ5rDpztW6/FkvLeR8lp83nnrSq7ArvlX4g6wwpVw5Ec4gjIjgkHZWf3k+pTty72VjoRhrAv5lwhoVdIBe658CpRkap2aTSP0G4pNr9VHCqak+Amse9M08WKlKv3rH3QGb3nAqQ/XxBJzY2IdCJhmC7IKIlRe4Vz486RLBQKze99LzMUp58y9hYxb+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66VWupt/mZ6FBgq5tKboKohYjAfYUEXR7z0xP2PP65E=;
 b=C49wqJZuaoLUTKlV+QBZKr4JBBtG4a9MHgiN+7bUB7kV4KxBMUQnokxWXjcqvjH05jstnukmDGHobdF0UubqtQS9U6LExfmTjj/LmiC32wVwfqxl9RgJTX5tV9sFpwtV2xA/rjFhj/N38Sngsj4julZzK+h/F9qQKvZSMnzpx43smMoPUSk27T5f439zCdV4C2H7UItpe3CyHlEUaM84pVFGmbsWoA9z94Y02yNKMDhGr3RKnFxOTFalB0sjVYY10bmB7LU+CxYjTGmFrTtsnlk584AybV/J+FKoZBtGgCNoupawIYfInw/mN5CAYGOMNLshndvoUOYQMvVs3M9rUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66VWupt/mZ6FBgq5tKboKohYjAfYUEXR7z0xP2PP65E=;
 b=CyhS7K6hFjclWoOvANlwXmxAycb8CKazaIWrT65zNzcNNfrlmpcmFF/rCljDRv5kGxejrOxET8CzbtH9qqHUcJZKQj9xK+JgaCZ0CIsGcvc9eIuXffQM1MQorqOlFL0sHj53UHY2QaTv1NmzqpkaGgerI4O6gUPeVeL9ElVesdzNrFbxYRaTLyd6uvJVa5n3MvAIb5ayl4bEoBayuzhsWzTZcMvCcp5vnza+ozZYsZMS5+OjTsAI1J2Eoz21vCEu2+uIyoTQ1MuIwkf/DFQtfRMaszBQ1tWhaFr+ySppTqcwJh6I/q7BcmuwbXXdusOuw817VJepjjqbPpUEFMmfNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LV2PR12MB863586.namprd12.prod.outlook.com (2603:10b6:404:300::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 22:39:57 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 22:39:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Stevens <stevensd@chromium.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH 07/16] mm/shmem: avoid moving the truncation start
 backwards
Date: Mon, 26 Oct 2026 18:39:54 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <B1241F56-8000-411D-A137-24596E599C85@nvidia.com>
In-Reply-To: <583728ed-dc63-4685-9ac5-5a980db55973@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-7-703206d5fa0c@kernel.org>
 <2E377C76-D62C-4A2A-94E3-ABC40C6FCDD2@nvidia.com>
 <583728ed-dc63-4685-9ac5-5a980db55973@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: MN2PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:208:23b::25) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LV2PR12MB863586:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed2f788-9e38-4ac4-9efe-08df33b20fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|22082099003|18002099003|261026140227099003|10067099003|4143699003|56012099006|261021121427099003|11063799006|261009223027099003|261021123027099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	2OKK9tqKk/P+AKYZxGbdN1B4Kgaco0VIE9hS8Eu961mmWlWQo1pa0NxwcmA61+AGpU7cxmDBPD1bZeKnEWYxaIbCdVHC6uI6EZkyPoCcXTlsE3CuTbhKZsMcJ5p5HzPFPq4fsrsFHRow6Sn8C30KEIvho0a6gSDdZa7WBxQFlUFFy3QAh7rTC/ihcnF1WVM8B7WTGfWLmK8xunW7mvWu/kaq0TiBtS9OAHeSV5mn+99dg3T8U4BF5SnmDEGlglNZ/sKGplzuvwvcZT6G0Hl2i2MhWW+jPHee9xITE9xGpFU9s45GH77hm05KkyaACgPZBHZLH0jDqiWtTTUDO/242KyMPSc6ucpiufA/CF/xOG4IZEMe/rw2mic37untFMsyeRZ/Vb5/J9ncBbVmKUqRuCl+qEPRLyhQSEf8fylvw2bs3JFbSJZ1EP/4s9liIEfsgP4Kg3n56f+wkPqdsqvTfi4GDbPVLR/rkUMexeaTmOgbLnTy9K2n85QvBVJaXQjE4qfUWK4chvhnqtkeRzPB8bRGpnKVWhyuLSKsaIWJcr9NtQJVCZ8a7lziGMdOlcImXS0P+OeIYJSq+8v+B+UFWp2i/ZeE/t+kCvGeBMRHvDQaeIIfkE6DKpsBpBFmCe14gJg2wbcsGrfFva6ckaE/rfUUtJF06baYAMWDIL4ci4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(261026140227099003)(10067099003)(4143699003)(56012099006)(261021121427099003)(11063799006)(261009223027099003)(261021123027099003)(261022105027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG51bFBibWM3aVliUDRMY0xHOGxKYWhJcXRkR1NRdzlwVVcrcEgwaWpScTd2?=
 =?utf-8?B?QWg3ZmltWURsbUdmd3I4TXpWSkppTEZwOWppUVA4dGxEbmNyQ2RwalhlV21k?=
 =?utf-8?B?OGE0OXUyWnRHekkrZjc4WjRBbzZvS0RJSzZwQjBMQmxSWVc3b2UxZFlBNWcz?=
 =?utf-8?B?a1F4TlYrOXE3dE05MGtpdmMxWWw3T2tnWmQ2Tjd0VnVDZlRzTUsvbzlmZm1L?=
 =?utf-8?B?ZS90amhkRTI3RjI3MlNqVExicER6K2krMGdFb3I2ZjZuQ2tVcFJBZWg4QTl5?=
 =?utf-8?B?RlhGTkVTd1phaWZTSUVrbkFIMC9TaS84WTdyN2pCRWkrWkt6YXFIbjBrbGE2?=
 =?utf-8?B?WjBHUyt1b0FxWCsyMlRSUitjU3VBYmFhLzdFcEdWOHpudCtZMWhlaTUyOGFG?=
 =?utf-8?B?eXZJWUZvaXMzVElUcVNxdHhjbUtUaTdCSUF0ekFBdEN5T3kweHNpTGNoTUNh?=
 =?utf-8?B?SDFVb2FDZ1lxTHpFcmF5SWNheEJYMkxwalRhbUk0dW8rK1Q2a3dESjVFOTF1?=
 =?utf-8?B?dGZMdVNQcmRWcEM2bTUwRHhwcHN3MlZLUU5selRJczFWcjhqQnpxWFNRVkNP?=
 =?utf-8?B?L2FEWnBPNW5IOUtFZEhsWElCeHhqV3o4dGtxQTZOZ3FXL05wYnNST1IrekhY?=
 =?utf-8?B?VnlZbHBkVmMwWDdnTS8weE9OQW1CeWR4R3hCUkFmK2Mya2Q5YStyK25ZMkN6?=
 =?utf-8?B?RXh0c1JVVUpXUk4zM1padVh4eC9BL3hkUHMzaEhMMUQ4Z0RocFE4YlhIbkhO?=
 =?utf-8?B?d1J2YzJMdkJvajRaaU9KUFJldUJKUUxJejJEMTZMRXVQOTF0Smp3UjYvNm1L?=
 =?utf-8?B?cnVDWDZnU2lkczN1dmNFUWpEeXVvUVpJa1EzcW9RZXkybURSMzVZWno0ajBL?=
 =?utf-8?B?a2x5NGk4QVUrSEpmUEFDWUtGWGxTMmE3WWdQTmhlSW9CSEhuMHdSd3F5TVdZ?=
 =?utf-8?B?NzdkN1Nmam9GNm8zQVIzY2ZsRCs3b01FdVdXWGZPaWNCRS9OMDJ0aStjU0hm?=
 =?utf-8?B?WHpxbjNlcGJyclQ1VzlhcmZIclRDTkN4VlF5RksySjFmenc0bmdXYnJRSWxZ?=
 =?utf-8?B?b1BaaGk1Ry8ycVNKS2pPN0ZtbEFmazdYMGU2QkJWSWNtODh5cGtMNVRVa3dX?=
 =?utf-8?B?U0t3bllVQkJyMThsSEdGbXBZM3pNRUpyQXZ6b2g0S3NzcG1tcjVyOENZbXd2?=
 =?utf-8?B?eTY2UDlCSzZMVkpXMkJlN3Roa05WaXd5ejkzYnQ1RE0yVUs4U1dOQWJ2TVh4?=
 =?utf-8?B?TnBVR1h6aDRFenFrVnp6TjZweXh2dlh1d2FTOUhvMEltbytsWFRObHh5WXJB?=
 =?utf-8?B?NDNKRmYrVitSeTlnQjlYQUNhYXlIWDVXRmJoMm5QWGV1dXc4bzlmQ3RKM0Zn?=
 =?utf-8?B?VzM2M1pQWUI1UVBsbEtrMk5VUTNwNXlmeDB0T1lvOUNLblRNcFBqZVhsMjl2?=
 =?utf-8?B?RFZMblVqT3dUQU1nTGtyQW9XZ1A4OVhQU3k3Vi9RL0pMWHQwWDIxRmFjQ2ln?=
 =?utf-8?B?SENQRnNDa3FNZk5xVXpvMHdlcDZvaFBqc0VOQnRQdnZTYXRCQmc1MURIVnRn?=
 =?utf-8?B?Zy9jVnNSQXpTUURra2Uzd3Y0MzZvTTRISXhrdk96QjVKa3hCQm1aNVg3b2dp?=
 =?utf-8?B?N21TbnlpcFhOUUZsaTh2dkdiYVZBV3lhTnpoV0VDdytRcEYvaEdHbmZEYlBv?=
 =?utf-8?B?NGF4NmY3SVQzbk82amVwVXB2bitzanFmajlJTWVqM2haelJyTDlqTTRjYk9E?=
 =?utf-8?B?MWQ3TnNaS1J3Q05PZ3JzZzVyMFRiS0syaUNWR3MydkZFL2FBbnhkdUhyWDNB?=
 =?utf-8?B?RzZEcWVaY2kzdE9JZThpc0RJMjhkQ1lVWWdqbTRrQVZlaFlsTUkvT3pNU0JO?=
 =?utf-8?B?QmlpUjJqMFJxWSt0SzNVY3o3QnpCVThtbmdsV3N4dU5EQ2R0am02UWp4S0NP?=
 =?utf-8?B?T3JBMnpOOVE1UlFwWDZEc0k2aTFlUnpmVDBvTy9WeWFtaUd6eVIxWXl6WXZa?=
 =?utf-8?B?TjdFNEpqZ3Z6TDdvSWhqNGw0RERnT3UzamdMT0JZaS9oZnFkTEJYV0xQajds?=
 =?utf-8?B?WTJnSG1sSENyR2I0blRUVWx0U1pFQnFGWStnbUw1NHNGbUM0SzYvNHUvaUJL?=
 =?utf-8?B?eXZvT3VCYmNrcTZpMjNFYWlVNElocDdtYTBMN2lWbUVBYUt4dTZvN09YaFpY?=
 =?utf-8?B?MkxEOWRURzROdlhZR3lKaGpNYVB1U3MybXFEVkIrRzFuSjNrSkZkdnJpTVJG?=
 =?utf-8?B?THo0MUZPMllPWU5nNzJqa000dmFJQ2dDQlRsaFM3RG00WXhabVd4M20zbG42?=
 =?utf-8?B?N3dFSmxsSkI3bkxCc1VxaytiTTRscEFZMUFnMm91NGl2R3VmSitGdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed2f788-9e38-4ac4-9efe-08df33b20fb8
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 22:39:57.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Io7Q/vNr8VWLBfQfL+QwRsTpt2s4VD/NiwHzWzTupiCm6hvEtZJlxS6Eq5OlNYVj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB863586

On 26 Oct 2026, at 17:13, David Hildenbrand (Arm) wrote:

> On 10/26/26 20:21, Zi Yan wrote:
>> On 26 Oct 2026, at 5:40, David Hildenbrand (Arm) wrote:
>>
>>> From: Chris Mason <mason@kernel.org>
>>>
>>> A nonuniform folio split can fail with -ENOMEM after splitting off some
>>> smaller folios. shmem_undo_range() then sets start to the end of the
>>> original folio, which may now lie before the truncation boundary.
>>>
>>> The final scan can consequently discard data below the new EOF, or
>>> keep retrying a large folio whose split point lies outside it.
>>>
>>> Keep start at least at its original value when skipping a folio after
>>> a failed split. The part in the truncated range has already been zeroed=
.
>>>
>>> Fix generated by an LLM and sent by Chris Mason in private.
>>>
>>> Fixes: 7460b470a131f ("mm/truncate: use folio_split() in truncate opera=
tion")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Chris Mason <mason@kernel.org>
>>> [ david: split fixes, simplify descriptions, adjust comments ]
>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>> ---
>>>  mm/shmem.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>
>> This is fixed by Zhang Yi=E2=80=99s truncate_inode_partial_folio() fix[1=
].
>> I think the commit is ad27479793682 ("mm/truncate: fix data loss
>> when splitting straddling large folios fails") in mm-stable but
>> not upstream yet.
>>
>> [1] https://lore.kernel.org/all/20260928120833.3440834-4-yi.zhang@huawei=
cloud.com/
>
> How confident are we that it fixes the same issue?

The issue here is that folio_next_index(folio) used in the mainline
code can be an index lower than lstart and the fix is use max()
to prevent start going backwards. (I wrote this to make sure
I understand the issue correctly)

Zhang Yi=E2=80=99s patch passes start into truncate_inode_parital_folio(),
which has a new signature, and it is updated with the folio=E2=80=99s index
within the [lstart, lend] range at the beginning.

So this patch fixes the issue at the caller and Zhang Yi=E2=80=99s patch
fixes the issue inside truncate_inode_partial_folio().

>
> Does it also cover #8?

No, patch 8 is still needed. I am checking it on how to rebase it
on mm-stable.

Patch 9, 10, 11 might need rebase on mm-stable too.

Since these patches are on top of mainline instead of mm-stable,
you will need to rebase them. IIRC, Zhang Yi=E2=80=99s patches are needed
for ext4 + iomap buffered I/O conversion. Hmm, but Zhang Yi=E2=80=99s
ext4 iomap patches has landed in mainline but its dependency
is not. So we cannot drop Zhang Yi=E2=80=99s patches and ask for a
resend. Adding Zhang Yi here.


Best Regards,
Yan, Zi
