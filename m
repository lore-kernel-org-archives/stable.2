Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794252766;
	b=hsyJsQMy3qqaaWAHDHPpeITIX6pjBZXtIu3WrmcmaGTW5sUV3BYBhZ38zwEW++aVH7D6
	 jh+0/gZNIov67lj6jR31WGAJ5jKvacKY0BxUblUcDKdHaLiv8oN9JbOwJtygwBK7Z4v8Q
	 J+3foCeCCjT8vmTm1S5hLldesGRrhGPKWwnq+Yb4idptqjjROdB/ovafwgvWHMP64Mv/H
	 NGU/m2TfrVrNE5ecJ583MjdC3iAc3zi5V+j5Be0cE/vwbRV+vANthxEKlcKvJANAiQuO5
	 I7Yi8SIQK0yKB7/rWlHP9M6ZUl4S9QDoKHNzhwXqSs63FAZCV/pptQtUMbsRqCzD9mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252766;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=mPqaLNrJm8dxnuhFMJ9Qkn+Y7AWCO/AMz4f3/HZg0c0=;
	b=03L8GBwTh1ea+8E4IjYmdTompTIuXOBVrNh6djrczoYjU/aAbySrNjHH8JqpbcEbhI30
	 NvK5snW5POID3FgY+qKgAC1F1TjyBiMTySlN+aVYnJkXv14MGFk8702cCt2aCgU6MRq54
	 vZnINI7PiudtFA+vpDqCfdMwUqvz0Qdl1mF+JKr0Ztig+zwdIrGCmfGOcYQT2Bs1Xbhhu
	 AqTdhA3+I84Qay2uKVOVMGVLeUjT5lMkYpKKfYFSbB5DIAh1S1WQ6uTOaCBSneNZWAvk3
	 WvSy40Nnuu9Hdq1wloTGU07BHTbyRr0l3VNeRBQDlFdY0+UkOhCUyzqLuuGvCH4m+nw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dC3Rrn8j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.0
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6010F606A325;
	Mon,  9 Nov 2026 19:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6010F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dC3Rrn8j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knjpPlKA4qzRrkv1Cd84A22AHIN/3EZFXdQ+ye1gBNJLQBJyxWAhgKDWXa/AyvAK4KmLwUWQsSwoI8oxhCjrqxAf6SZzDoGnI4WVHiy6IF0oY+XkYbhrAtudXo3id4YltyM5auvpKDV71UHWumUTC/Y3gMdAZ5jhsEH+fq8xS3EpuyavJ5XHHYDVj2jCY1lIMp23o5Dx6j7o2IxczD8Js8e0vVcmmGPQgMM37ofsSdjdIBJWs4rHrvQGlnx166INOV+3RyxvpZ4h/nExuVw/cbJPyDOvjGbRBke1x0eGjd7iDcSK3TD34lpJLkWsb0DWj37Zb3POI9FpYNBjPwWZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPqaLNrJm8dxnuhFMJ9Qkn+Y7AWCO/AMz4f3/HZg0c0=;
 b=dNvv8WtwaM7FIKcIiOrgWJkrGmxzcx4FxEWHcrR5cOAvhLUHBDUYrHah3e2i1Qqesqg6RwHquMWsi0kbjySOgA/bWFoWawFJWAyjJRB3ZKVTezCdozu3ua4EkwTLkgCHR1S6F0eDMPzz3VaB16n4niTiqPdXZcuORPmAKN8ybCwoSrNp98P206LcSi2Z9pFZhJBiksoK/09DxHeAznkOV5iFVigl+khXbVDpqsnFMdHU7RhfOfv6Iguh9f2Ab0dU3gIKfz3qkxES3R+oJk1dg0JIuS+6h6H5WqjDvC/cROkPk3bIlGLNRmnn5Ng7+YfflRGdYBri24gPHQGSQt9CFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPqaLNrJm8dxnuhFMJ9Qkn+Y7AWCO/AMz4f3/HZg0c0=;
 b=dC3Rrn8jjMaL0OeRUn03XsmFcPNp0Q8vRcXhVLwnlcCR+iLFh5SxrYTskAp6xcy1qAU6KjtWBsHPkJS0uJ4Fp9k9YzOm0UfDXN9Cbx1zw6oDAgP6bnebIySaWdpCRF9jnivxrrVEWdBLm9OmmHIBdSd2MWpEkZpSL3QRS9EXk1or7QvAMmj96j+f7hmXH+/GE8D2E16BHv+eJ3BwP0oeZ/bu5ld5U63z3dlfqSAL3/DvecDpFC1l1pbElBQy1+4RdGf7j3WlYhwj82M2Eo/M6AUpkrLD5Fs4gqOQ9hJvsT0MIcyd0THcLbDACsEqZ0sXTfm6+xVwEY/cOkPVmrJ7BA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Mon, 9 Nov
 2026 19:32:41 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 19:32:41 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 09 Nov 2026 14:32:31 -0500
Subject: [PATCH v3] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-fix-split_folio_to_order-race-v3-1-1cdc509e34be@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTQ7CIBAF4Ks0rMUA/aF15T2MaYCCHVNLA5Vom
 t5dqAvjSpcvefO9WZDXDrRHh2xBTgfwYMcY8l2GVC/Gi8bQxYwYYRUlrMEGHthPA8ytsQPYdra
 tdZ122AmlMam5YKIx0nCFojE5HQ82/3R+Z3+XV63mhKZGD3627rk9EGjq/bsVKKZYFHWueFFSS
 brjGKADsVf2htJYYB+OkuoXxyJHZdmoistamPyLW9f1BepYoDMsAQAA
X-Change-ID: 20261029-fix-split_folio_to_order-race-087a2a9fbf7c
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>, 
 Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: YQBPR0101CA0211.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::22) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: f4405a5c-2344-465f-1d64-08df3e983886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|10067099003|18002099003|13003099007|921020|56012099006|261026140227099003|11063799006|5023799004|261028144727099003|261009223027099003|261021121427099003|261102123227099003|261021123027099003|261022105027099003|261022075727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	Zx6mTs8s12iE6rORPIpBKpNzebLFeRE8EgT4bfwn/tkSvoMz3GOr6bDzhxdlVXmO6e7pKF1QtF9UlnAuZIWsRMXK0h3OrJkYKhX92GL6AenPyNizt4JX5Foabtkl+9dITaxiZHRH5Qj7FCaAZVM/G3E6pXAtH0uONc0RhteaJP0xlFsekClVFz+kiZMTM+ipGLONEPTpCWVsI5NWZ/S83YGri1laiS0ToJZhqQm8kk49KymLOZT32Li85VxopGAylFItaQCf/+CaccbExW7xr/hXXjA1s/vRPuO20PWeLZp1SzFIFZJAh32L9yFdkqdxa6WgmPu4RfaaNBdR3DOLFr9+Uq0cxPXpX5oxdOifaNWjsK+Fv184YwL1ZrBE3ZtNFcOF7glIW06HdS1RCW2oBy+uCMotXR6P/iOuDDNHy+QRILMpMkB5TiSnBPcGa5Y6Cl7en0zgTInD5J6d2uef/bK/olpnu6Dvx53//7i2vCbiNQWDpnAgIsPA62qtn2CiSniVdWzNiIqa9Wxqk8L3C1Pgk6ta5LQIk9aOVkdnAGjND6NGfbu3UaTEGY6ewUnRy2u6kHykB/ToeaT+Fwu+EvnNFPkXFpX4tzjASr8yOdZGK1HaKveDoUfIU4fmgfzJKKp4+tnxjCyuJTgS8CuCQiXjrVgXdJZJG4Ko/NECWgMy6Vibo43GCT4rx7w5rqhchd5WnrWgfExd0mzYRLwP/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(10067099003)(18002099003)(13003099007)(921020)(56012099006)(261026140227099003)(11063799006)(5023799004)(261028144727099003)(261009223027099003)(261021121427099003)(261102123227099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0NHcTByNklKV0x2cUhOaHNMN2Mycm1GUEZGQytYeklNb0FpdmRiNGJlalEz?=
 =?utf-8?B?cmJib0FwSGVXdjJERFFmZnNqeU5zbHM0UGNWVFFMcm15TUwxTWpPSUFTWnU4?=
 =?utf-8?B?clpsTERDNjZoQlVJWHg0bUNPNldWRVN3SVRPMlNLNTU1RG9sSE90cHJBMno1?=
 =?utf-8?B?ZCtUeXNYUkM2bDBadCs1bnhlRmdEZVphSnBOYmthL2FGeFZ5YWl6VGZNeHdV?=
 =?utf-8?B?aktjOVlUVFJwUC9xazUyb3hxc0lUOWhDZUxKOE5qTzMrdFpzQUpldjBJYkpp?=
 =?utf-8?B?YTRwdEZpcjE4NU44R2JLMW91Rm80enJhTXZuZFV5S1JTQVN2TnROb0FvWVVD?=
 =?utf-8?B?RUE2elBpbS9YN2lSUHRuYmx5SGx2NXE1SmtGbitReUFNWHZpYWJYK0VXdVFH?=
 =?utf-8?B?TzJzT015cVpvWnR2dlJ6dVVsbW95TWszOUtrM2NIYTZ4ZEx1Vm05VFZuQU1q?=
 =?utf-8?B?ZVJ3QWJTYkUvRGNQdGZtNlIwYXAveGl6N0VuVHJPN1lRVUIwMlF1K1FuYVkr?=
 =?utf-8?B?alJNNk1GU2hYbEhrcXZIM1NhSHUrYXcrcTJNOUJLMzlkK0ZOQXViemM0M1pn?=
 =?utf-8?B?TXZKbUVjMkV0bS9kWjcrVTFlL1VmMEMzQ0tIWmFCUW5icFZIVStOTG5hTkZB?=
 =?utf-8?B?MVQyTkUrdEJvaGJuOTM5eGtjbDl3Y2JsbXJSRGwxU0JtSThFU1V0NEhxRzg3?=
 =?utf-8?B?aGFSWWNUakxzQ1VIV3RKMUV4ZmJzNkZzTS9hQXlnVjFSdEpMYUVEdHNCTHhI?=
 =?utf-8?B?eU44TXdiVHRMbkk5dVVpMmw2Qkk3eUJjb1BuYjZHMU8zRmdVTEZZMFE4QUcy?=
 =?utf-8?B?NU5idHdvSU9EMFB1bG9oQ3YxbGlqUE40bUpxVHdxQnNBUCtJaXlpM21nZ2tJ?=
 =?utf-8?B?MFd5NFBzaWRtc2trcm5UNWJZazBhR1dEM0N2NkJGUmNEejhFVjBjYmFQS1Fr?=
 =?utf-8?B?NHdzNzIwQ0hRRzRYOFFad1VrODJaMFlvWWJRNmVrM0VPMEEyblNOVnNPWklx?=
 =?utf-8?B?K25PK1JUalFUNzAwbmlLL0hYYWtFY09HYWhSVVAyc2taTkZua09GUkNhMUpj?=
 =?utf-8?B?aFFyT1FXTGhWM1FHZUlJV3VueWxQeVcxd0NHZnl4WTQyaWQ5elZUTmNrQ1A3?=
 =?utf-8?B?S1F5K1pIVTJNOUU3TUc0SkRFMVhUSlJrK2FSRW1naTROWWZQNW5qek13ZFJI?=
 =?utf-8?B?Z1FPN2RyOFRObGhNWHJPb0JLN3dsWWNOVWVVbWRSckNFWHZobnZnaU1iOGxN?=
 =?utf-8?B?Tjd2bTliQ2pZVFFac3luVDF2MmJpclVOVUtWQVNrQXJLcHEwajNqWUZIN1du?=
 =?utf-8?B?N1l0N3g2UEkvN2RNVWpGZkh5ZnBCRlYrV1dGa0xuTlNxamlzV3VyT0xGbktJ?=
 =?utf-8?B?Rk1OSlJPcVRpbkFYMTlmOUV0VEtUTFZMUFQxNjhSZjBQMTFEemxWbWNXaERn?=
 =?utf-8?B?Y283NU5LUTZQMlF0aTFJdlRaVkhsNjJKU0hJejRJMC9oMEJqVzhsOURYMjNx?=
 =?utf-8?B?NHU3OHhtMWg0NXRpcnJXN25Fb256bXF6NzlPYk95Yk80WjJ1NkpoU0ZVUlho?=
 =?utf-8?B?akRLWVRkTGtLQUZCTURtSjA1UDZkRGdSUnM5TTNXcEJKekgwb2c1OWtKMGdr?=
 =?utf-8?B?bWV3U3RmZTduNkwzYTkwampVYjUvR09pWDJFUFFWWEMzd2pzVHlhSG9YUDly?=
 =?utf-8?B?TFFVZWk0ZjVoZE0xZ29VbkZ2VW1xeWJoMDJ3RUZUcmRXbUtUeHhNdGxHTEdH?=
 =?utf-8?B?ODE5RzJudGZFb005aVZoM096MU5waTFWc0I4R0EyM25GaVpqbENUdUdNcG5z?=
 =?utf-8?B?c3RZZjZ1MHRueTA5aTFEdmlOME5lNC8rbTVNL1hCWllmQ21vVHZoVEhJS2V6?=
 =?utf-8?B?c0UyZDV5ZTBHK0oyV0g3QjRHeEdYQ204bjQ2YUtJWEkyT2pMN01GeU9iQjZO?=
 =?utf-8?B?RlNXRDBENUMwMkxrdHZrSUFQQml2QmQwSzF6Sjkva3AzSHFiNEEwRG9kenZn?=
 =?utf-8?B?OTV4aloxOGdNemlsVmZaS1NNSXBOazZmMldYYjdtUFFyTnVNNDdMQ2RmZkRh?=
 =?utf-8?B?cXhLTVUyRnZNTDRuTHVwdmJ1ZThYUnlzOHBwVDNiZnNFWlg0OWR4cHBYTHJ6?=
 =?utf-8?B?dERZck9vRGxrMFgwRFFHNHQzWWlSWmhoQ2VheFNISW5BT0RPcHVQQjZCVzF5?=
 =?utf-8?B?R293UUpkTTR4eFpFckI5NEp4TkMyWEhmUXA1TllzRFpvWFNMNThaQStuaUpQ?=
 =?utf-8?B?UnAzZWFCdEowa3RBb3lGZ0NLdlBmQVJVMFpseTVXTjZveEdDS1g0dmg2UU1n?=
 =?utf-8?Q?bUwRdLMRb2VqR/6zfR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4405a5c-2344-465f-1d64-08df3e983886
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 19:32:41.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDggy44k9RKZ8X7p+qh2aA12Hy9ujIboAK/fGhWuGcCDMPVWG/SnnHcqyeHnXoN8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334

__split_folio_to_order() calls prep_compound_page() on each new head page
to create a compound page after clear_compound_head(). prep_compound_page()
uses non atomic __SetPageHead(). It is mostly OK, since the folio is locked
and frozen and no one else is supposed to modify the folio's flags.

However, code calling migration_entry_wait() can reach the folio by PFN,
then access its flags. It is because softleaf_entry_wait_on_locked() used
by migration_entry_wait() sets PG_waiters concurrently without taking a
reference and the frozen refcount during split cannot block it. Meanwhile,
__SetPageHead() does a plain read and write, so PG_waiters atomically set
by softleaf_entry_wait_on_locked() will be lost if the set happens after
__SetPageHead()'s read and before its write.

One example code interleaving:

CPU0: __split_folio_to_order(new_order>0)  CPU1: do_swap_page()

1. clear_compound_head(new_head)
   new_head->compound_info = 0
   (page_folio(new_head) == new_head now)

                                           2. migration_entry_wait()
                                             softleaf_to_folio(entry)
                                             page_folio() -> new_head
                                             (not the old head any more)

3. prep_compound_page(new_head, new_order)
     __SetPageHead(new_head)
       tmp = new_head->flags.f  <-- load; PG_waiters == 0 in tmp

                                           4. folio_set_waiters(new_head)
                                             set_bit(PG_waiters, &flags.f)
                                             enqueue on waitqueue, sleep

5.     new_head->flags.f = tmp | (1UL << PG_head)
       <-- store; overwrites step 4, PG_waiters == 0 again

Later, folio_unlock(new_folio) sees no PG_waiters, skips folio_wake_bit(),
and CPU1 can remain blocked indefinitely.

Fix it by setting PG_head along with other flags in new_folio->flags before
smp_wmb() and clear_compound_head(). The remaining compound page metadata
is set after clear_compound_head(). In that way, after
clear_compound_head() makes new_folio visible, nothing overwrites the
PG_waiters from softleaf_entry_wait_on_locked() by modifying
new_folio->flags non-atomically.

While at it, use data_race() to suppress the KCSAN issue reported by Ye
Liu's patch (the second Closes) on reading ->flags during a folio split.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Reported-by: David Hildenbrand <david@kernel.org>
Closes: https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.com/
Reported-by: Ye Liu <ye.liu@linux.dev>
Closes: https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e331291c1@linux.dev/
Fixes: c010d47f107f6 ("mm: thp: split huge page to any lower order pages")
Cc: stable@vger.kernel.org
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
The issue was raised by David when reviewing Ye Liu's "mm/huge_memory: use
READ_ONCE() when cloning folio flags during split" [1]. This patch also
supersedes Ye Liu's patch.

[1] https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e331291c1@linux.dev/
---
Changes in v3:
- set PG_head before smp_wmb() like Kiryl suggested instead of
  prep_compound_page_atomic().
- used data_race() to suppress KCSAN reports while at it.
- dropped Lorenzo's ack, since the patch is changed.
- Link to v2: https://patch.msgid.link/20261106-fix-split_folio_to_order-race-v2-1-1b59c67b8af3@nvidia.com

Changes in v2:
- renamed __prep_compound_head_and_tail() to __prep_compound_page().
- added comments to prep_compound_page() and __prep_compound_page().
- Link to v1: https://patch.msgid.link/20261029-fix-split_folio_to_order-race-v1-1-a483c7451b0d@nvidia.com
---
 mm/huge_memory.c | 32 ++++++++++++++++++++++++++++----
 mm/internal.h    |  2 ++
 mm/page_alloc.c  | 17 +++++++++++++++--
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bd44d58e86845..99b48d7c988db 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3714,6 +3714,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		 * Don't pass it around before clear_compound_head().
 		 */
 		struct folio *new_folio = (struct folio *)new_head;
+		memdesc_flags_t new_flags;
 
 		VM_BUG_ON_PAGE(atomic_read(&new_folio->_mapcount) != -1, new_head);
 
@@ -3730,8 +3731,16 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		 * unreferenced sub-pages of an anonymous THP: we can simply drop
 		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
 		 */
-		new_folio->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
-		new_folio->flags.f |= (folio->flags.f &
+		/*
+		 * ->flags are stable since the folio is locked and frozen.
+		 * data_race() is used because reference-less writers,
+		 * 1. PG_waiters from softleaf_entry_wait_on_locked() and
+		 * 2. PG_hwpoison from memory_failure(),
+		 * can still write to it.
+		 */
+		new_flags.f = data_race(new_folio->flags.f) & ~PAGE_FLAGS_CHECK_AT_PREP;
+		/* See above for data_race() use */
+		new_flags.f |= data_race(folio->flags.f) &
 				((1L << PG_referenced) |
 				 (1L << PG_swapbacked) |
 				 (1L << PG_swapcache) |
@@ -3749,7 +3758,18 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 #endif
 				 (1L << PG_dirty) |
 				 (1L << PG_dropbehind) |
-				 LRU_GEN_MASK | LRU_REFS_MASK));
+				 LRU_GEN_MASK | LRU_REFS_MASK);
+
+		/*
+		 * Set PG_head before smp_wmb() like other flags.
+		 * After clear_compound_head(), when new_head is recognized as
+		 * a folio, softleaf_entry_wait_on_locked() can set PG_waiters
+		 * on it without taking a reference and modifying flags
+		 * non-atomically can lose it.
+		 */
+		if (new_order)
+			new_flags.f |= 1L << PG_head;
+		WRITE_ONCE(new_folio->flags.f, new_flags.f);
 
 		new_folio->mapping = folio->mapping;
 		new_folio->index = folio->index + i;
@@ -3779,7 +3799,11 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		 */
 		clear_compound_head(new_head);
 		if (new_order) {
-			prep_compound_page(new_head, new_order);
+			/*
+			 * PG_head is set above, so only set up the remaining
+			 * metadata on head page and tail pages.
+			 */
+			__prep_compound_page(new_head, new_order);
 			folio_set_large_rmappable(new_folio);
 		}
 
diff --git a/mm/internal.h b/mm/internal.h
index aeebb3e49ed11..4ce67ce2f3fba 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -807,6 +807,8 @@ static inline void prep_compound_tail(struct page *tail,
 	VM_WARN_ON_ONCE(tail->private);
 }
 
+void __prep_compound_page(struct page *page, unsigned int order);
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 143776e671abb..e2a8092ff0b4f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -682,18 +682,31 @@ static inline bool pcp_allowed_order(unsigned int order)
  * This usage means that zero-order pages may not be compound.
  */
 
-void prep_compound_page(struct page *page, unsigned int order)
+/*
+ * Set up the metadata on head page and tail pages.
+ * Caller also needs to set PG_head.
+ */
+void __prep_compound_page(struct page *page, unsigned int order)
 {
 	int i;
 	int nr_pages = 1 << order;
 
-	__SetPageHead(page);
 	for (i = 1; i < nr_pages; i++)
 		prep_compound_tail(page + i, page, order);
 
 	prep_compound_head(page, order);
 }
 
+/*
+ * PG_head is set non-atomically. It should be used when no one else can modify
+ * @page's flags.
+ */
+void prep_compound_page(struct page *page, unsigned int order)
+{
+	__SetPageHead(page);
+	__prep_compound_page(page, order);
+}
+
 static inline void set_buddy_order(struct page *page, unsigned int order)
 {
 	set_page_private(page, order);

---
base-commit: d865f2677c44cb2171b833d6775cf692756fa8be
change-id: 20261029-fix-split_folio_to_order-race-087a2a9fbf7c

Best regards,
--  
Yan, Zi

