Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793934454;
	b=yoH/cd6pNtB12HSS6pJKUL/mt9cjOr60Jp1E8T4uiXkV3kHVApha1cXsqMboIk6nZfki
	 NAlA2dfqmGfz+eGEiJPczckEtZfe7Q1Rq7fXOoZCu3MsQN6bQ+7Pg6+dL86G2bNIlsXiq
	 IE0MHBfe86dJsUE9vnK9yLAdqjadsP/WtLczEZWzYMNN9nX90AQzzACqIOLa6ah9z5XYR
	 Ex2Kk2y7jvnUnuSfrkq/BO67e3CRrT/WTt3V6mSY8C+9P0OEd3Yjv+AVwJLANg/XwM92M
	 Ts/nHafCEoC3YbXr71jy7otNdLdwqJkQdfLTl9VYt425kjTr3gGbPR8SnDWdttFhWew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934454;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:To:From:
	 Subject:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
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
	bh=8ztbuShr+WgdOBXYf5fUM80uZgltRI6WDznN3D2TyQ8=;
	b=lDmxzKfhxNDBw+GT9+T6jw/pkzivyE4TkIuQcmNtpME9iWEhqYD19d87e+PmRG/TAH1u
	 uC76QA13kPtasB2GWDEbd6bR7QEwWxEQ/KdzjiCmPut2GSqk7cXKWAGWUJZ5RcpNskFg3
	 1W+9EXTBcVLMkSxDfoUnINT8pTlgS7lbOptAuCMDLVznZtZIkFWirKSbAHZZAH51/AJo2
	 WD//eDbAfo1GET9k6SjRuzM7l2bHAOD52LsB5IrSSLOVKtbwGL4YLuFHiOSdD9drYmoIl
	 4HHIcUfVIr0zJakXmimaNf8hSdK15ea2oKT1iBc8LRc+HUD7OiGr18iZm5FcVr5wEug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YIOTH0Wb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.41
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11C0606A328;
	Fri,  6 Nov 2026 03:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B11C0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YIOTH0Wb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyyhgdCognjCT/rGwvkYvkpwF8VRoNLJmjaQV76o4TwsVSVoevDbobBQWXRvchoJNlbuxO699Y8m4I4TYU3SX04fOdnEITY9yEQ2dvFuB+HVvp4YJM428U3U2adddGxUoUvqtOMhD+jhHM3CJJOZ/W81Aou9bx0Fh8ELBFXmAxDxKG4HmVmGaF9kPLwCtc/J2A8L3ON+3QouCm+lo5deuJvzTDcIwJgEo6SXO6h+jmVCx1u05lOx5ASE2LxNA8fsbUwyYi8Hxgik+UGMw5yI3bVnytIAyxVd3wIWsZCXjGdjbLBh+OuXzLNMj5i+BPi39qRcbw12r/a3ySxDLL6rqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ztbuShr+WgdOBXYf5fUM80uZgltRI6WDznN3D2TyQ8=;
 b=W/wTMWYA774ZiIxRV9/EjX0w7zsgsrUp3kQGvU/q/kD2ajnrwGkNSjkREHGMqZ+ET78rvbeU+Hysgc/iwU9Zn7sUQJa4ncPHrxEJPTNWeixLDR8GhokpvB/xCRXAXx/YKp5mQdTQT4QEmShxn8Wdsn51X/KR1ZRtPbBe09io/OoK1+sZzjDuchLVHxB66YK+UHrJVtYeLokKVtEBhIsxmHOuxiHOMi9HSd9dE4iR3VmRl3vNXnXGbpSNs0pgarDjrejmvOo0Yv5v0lgGQOEGl94rn7+SkZxtZ3kZy0OpmNvfU1rJXptGBTAAZNtrCFlSgEufKlzYVla/2q0HHp6GOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ztbuShr+WgdOBXYf5fUM80uZgltRI6WDznN3D2TyQ8=;
 b=YIOTH0Wb+dgazmmoL5qB9Wm8gsFFipwm/h/T1u5t2/hS6Hve7ssxQdZxna38PLyHHaKeeyHwcHl9MNZNAbIpzFy0I9FDbqabBTameX7/9OVa/K5kqmyldLf4o+jxxoFrG9YlIJQoICe6E2sIiXFMnZ2OgGCvtFoAUyeZuMXfWp4h47IpEMmEZ3eJJclh5I7nBG6DFaVtx/H1Fbbp0w1Zkcrh7xOAR9t/qGscavIi0226dlvVuExqyoUnXlfTfCSVmBR33t3m8t/wGpVxg8BUOQBvgJfMUr7k6/Ygn40MN3luVuTTGMXHfzZMqGMF6gloffW9Xr3+ulLTIfKVE6HqaQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 03:07:30 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0592.007; Fri, 6 Nov 2026
 03:07:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 22:07:28 -0500
Message-Id: <DMNSOSIX88HY.40FMVMG1JK98@nvidia.com>
Cc: "Alex Williamson" <alex@shazbot.org>, <kvm@vger.kernel.org>,
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, <stable@vger.kernel.org>, "Sashiko"
 <sashiko-bot@kernel.org>
To: "Konstantin Khorenko" <khorenko@virtuozzo.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Hildenbrand (Arm)" <david@kernel.org>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, "Nico Pache" <nico.pache@linux.dev>, "Ryan Roberts"
 <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Barry Song"
 <baohua@kernel.org>, "Lance Yang" <lance.yang@linux.dev>, "Usama Arif"
 <usama.arif@linux.dev>, "Kiryl Shutsemau" <kas@kernel.org>, "Peter Xu"
 <peterx@redhat.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v5 3/4] mm/huge_memory: read a special PMD under the
 lock in copy_huge_pmd()
X-Mailer: aerc 0.22.0
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com> <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
X-ClientProxiedBy: YQZPR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::10) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 603505a4-3243-4f2d-c2af-08df3bb31871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|10067099003|18002099003|22082099003|921020|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	RSmauEqc60L1WBOa//2Pc02BIOD31+H3stC5f0JBys+aacA30tPbG+6Gl5AcIBXsqWCLEMT4DLuFrQZLsUVj7M5p2ZCryLuGEyUqgOYIndU8G4tFF52AfSFzSybHM/oIL/oPw1vdlJzhKBqM7TfiWVmxPLGM0qNxHC2ulkGEpw7xeKqXDjrNQ3lOtqKmV0a48T5df2vvpedsvN/qTzg+qcAl2h9ViRSm4p2nBHiT6Ayytfe75zkGa6oPSd4rLzchJmzNE3UZ40oWViH3snU3sGqplsrSvPoOBqy7R2oatilcktDtR19ujs7Y0uTTa+hJTzsqxB0VBn+Q1ztz3fasxYsBmkrBGBWHPgdcCMXxwyW7vxpX9gjKSF91jQHxtwn6gkX9EiQpDYhb+wT4deAVaS+t6NG8h82wnpDW6o6+31PqAQEUlnbnH3wJdOUuYcxJbb4/l9n1zMQCuYBA4oV8Bb41270nCQNa4xX+y/qeL8HRRxO4iaiW3IkF4Vy1IZEQRaXHPB5gzLsUCoFNaoENlqDraNP33KGz/US8pwVWpdfjrLXSeQdlNNgSm70RQPoFvkS2qcuPty0Jz5gZl2x9egPjvnJu+2zK1q22MuDQ2aAl3dYKncsYuj9yTAHid2U7uRxcecf/C6fBZyajgzdNAtXpwdkJYf+e5XP6Ite3Ekx68lLhjSwzbjWJR4UGgsUaGdxYOH8aMsyJLVN/hHEq2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDJWcnRqaytCMUViWGpoZXJZWC9HTE5OK3JyUVo5Q3dwN3Bva0ttVzkrNEYx?=
 =?utf-8?B?Y2xMRTRXK0tMak5YVW9iQmVoRWtUaHZOVWdhV2VvTkJTS0hqU3dWYWt5YVl4?=
 =?utf-8?B?YWxPNHVyQk9ZUHRpQmxhVmNxc0M2NXVPc3VFSkwvdTFNb01ab1M0WlFoOFQ4?=
 =?utf-8?B?UG1PTXlHZFhWZDBXa0pMRUsxZ0tyeWpwWlBqaXhqZnBxVW4wU1dacHhFbDAr?=
 =?utf-8?B?blh5TDdqM1hWZXNMSTdUSjkxT1hjb3NuOWt4MDlabTQxYk04VlF2b3B3eGRL?=
 =?utf-8?B?SjBtOWYyZFNmc2kyY04wd3JyaTRmdStvNklXaVBVd2FkODhCM1d4UVBSTE52?=
 =?utf-8?B?aGhNLytHbUZrd3lUbUF1WU05NVB1U1pDa3lacm9ZRy9HbWV1bjh3emZCd294?=
 =?utf-8?B?aWM4QU5melhpWlRST0pwekFTcXNzSVQreVBjMVdQT3kxNk9uZEpNVWRUWDBm?=
 =?utf-8?B?aHlyamloNWFlTUdnVWZpa25wNXJCak5ZTnZzN21rOVY3aXZCN1JIdW5Wc1ZP?=
 =?utf-8?B?WTltaGk3Tmg2UlBVRmozMnpJd09OV09mMzZ4a3JQNmNKMWRjZ1dGa0dBR0xk?=
 =?utf-8?B?dWozQXBOU1drQXJPeGNJcklaQnBaL1NPeE16d3JKblZ2WFE5QnBQTE9FRnFj?=
 =?utf-8?B?QVF0WVdzWlp3Y0IyVUtZQysvNmFoZHRnT056Q2MzZ25TV204RDRiUWVrQVo4?=
 =?utf-8?B?cENROEtGcll4T2dNNmFyQUo4ZEpVQW9IOTRxczZaNzQzMG5vM2lQc1N6aC9E?=
 =?utf-8?B?b3lNaEpNRktLVE92by9ZTm0xV0xRL01ra29BTjhtbFZ4TDNVSzV3cUp4Z2NL?=
 =?utf-8?B?NlBHMXNBanZVQVVTS0s2QXdPR3p2aGl4d2ppcTM3bmtkeXRxZFROR01ncnlL?=
 =?utf-8?B?YlZYbkxueW1aYmNZdHNVd1NwSzF3V2VXK0c0YmhGQWZjVllFUEtEaWVKNVZK?=
 =?utf-8?B?eFUzaUo3SklQZGMybEYvYWoxdVZVeVVDVm1UazcvUUN1QTM5NmMyWUM5SE4z?=
 =?utf-8?B?bHJodE5qcmxNUnR2MnVEbVY4T0Q1aFUrMXRrbHBlWFpmVW1DM1BOZVZTSExo?=
 =?utf-8?B?TVowR0EvdUkrdnE4a0s2QnRVemovREN0NnVJMXBETzdMcEdsd01BNVoxZ2Zy?=
 =?utf-8?B?dUZENW5hQkxlaWlvMlVNcHFra2R3QWl1VW0yTXRWT29IQVdXZS9rQUUwVUJC?=
 =?utf-8?B?VXhnc3JBQ0k3THlmaHNyUkc3UTZCUTR5TVd4cms1VVo3eXNYSm1nZk5nNWZP?=
 =?utf-8?B?Ym1RcEhVdXRTditYTTdFZllDak1WTVowVFpTSzRhc0ppZFpJNXBEZ2Z5Qk10?=
 =?utf-8?B?eW9NNkdKcHpuTk90ZlF0YmU5QUtJNU5kRitwWThwU0VCUlByeUtVL1p5a3hU?=
 =?utf-8?B?L1lDaEFsaXp6MlFaZC9tMlBhZ1Ztcnp2WUdXS3cwVXBYSW1KbXROa3pKZGhL?=
 =?utf-8?B?MHIrbzY2K0ViWjhIemVJRXNRNmYreGl3SEhGemE0MzdOMFYyVENNTExoTWtO?=
 =?utf-8?B?NkVCSHhNYXJYaU0vZTdJWmtqVTQ5R0dwVVJNalVhb0U3ZHB3bTB3cWpaK1BB?=
 =?utf-8?B?bHRBV3VDZzNjcGtjMzJRVWZNZFArdWJoSW9TMHRqSVdMK0NyQ2ppMTludSt2?=
 =?utf-8?B?ODFJUHJtb3ovWUhLZVFVL3h1Zk5RakNmRVB1bXRzTDlKMUV4ZzZDeFIxMSs3?=
 =?utf-8?B?enpUeXlWMWdCdGZpNndJZFhES1FIRFdoeUJGTDRubmtiQkN2WGFzOFNkUEE3?=
 =?utf-8?B?QUZKTDJRY1hrS05JRmRRSkRoN1oxWTRJV2w1amYzU1FQOXhKa3dBRkY0Z1RX?=
 =?utf-8?B?R0FQMjk1SE9IaFNsOE54WHVMUjBlMWRqODl4UjNIL1QwN1FIUy93TUErcmRV?=
 =?utf-8?B?S095a1crSG9XTVhPRWx6bFdWNjVIUC9JbStsYUpHNTNnczdTK2RaSWluYjh2?=
 =?utf-8?B?dWs1eE03SnZUWS9sanIwZnFTSW9RdG5WaVJicUMyUXFRZFBPK0VzOXNpOFlt?=
 =?utf-8?B?TGxYMGUrQzNrYW1MaWpybUpFeFNzNk8veGFvOXRIS2NqcVJyNzUvWDkyeTFy?=
 =?utf-8?B?M0VDaW1BT2w4T3I5TGRlYWlNbTQ1enhSQlhwVjhOdk1vdkhFWFQwemhwKzM4?=
 =?utf-8?B?VXlFYnZFQTZuQWd3Rmk2QVlOVHNvU2l5Ukp3aEtPeXlWMENnejFZVUZkZG5l?=
 =?utf-8?B?ZEs3RnhlSXloeE9ob09KVGovZWFLbkMyc0JIOW5SaDkxQ1ByTWlYWGtiTjhB?=
 =?utf-8?B?QnZWM2ZkU241ZU51K1pmREFvdlFpVHFHcDRYbStmbVBNR3UwRFgzblkxV1lT?=
 =?utf-8?Q?MUjwoT4T9/2Qh2jUSA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603505a4-3243-4f2d-c2af-08df3bb31871
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 03:07:30.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSOG4VvrYGVWS9o66Sfjn9QTLJ5Jiiw0q+kG03NChxvSPJehLwfD+cCBtmH2DMXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571

On Wed Nov 4, 2026 at 3:40 PM EST, Konstantin Khorenko wrote:
> copy_huge_pmd() reads a special PMD without the page table lock and
> copies that value to the child. The mmap write lock held by fork does
> not stop unmap_mapping_range(): it zaps under i_mmap_rwsem and the PMD
> lock.
>
> The zap visits the parent VMA before the child's, as dup_mmap() links
> the child right after the parent in i_mmap. If it clears the parent PMD
> after fork has read it, and passes the child before fork copies it, the
> child keeps a mapping the driver has revoked, for example:
>
> - vfio-pci: the child reaches the BAR after the device memory was
>   disabled or the device was reset, instead of getting SIGBUS;
> - panthor: the child maps the pages of an evicted buffer object after
>   the driver has released them.
>
> The same branch deposits no page table under the copy. ppc64 in hash
> mode keeps the hash slot array of every huge PMD in that table, so the
> child dereferences a NULL table on the first hash fault, in
> __hash_page_thp(), and on the zap, in hash__pmdp_huge_get_and_clear().
>
> Take the locks first and let vm_normal_page_pmd() tell a PFN mapping
> from a folio under them, as copy_present_ptes() does with
> vm_normal_page(). The zap clears the parent PMD under the same lock, so
> either fork finds it none and skips it, or the copy is in place before
> the zap reaches the child.
>
> The copy of a PFN mapping then goes through the same tail as a folio:
>
> - it gets a page table where the architecture needs one;
> - in a shared mapping it is marked clean in the child, as a PTE is;
> - in a CoW mapping, which only VM_MIXEDMAP allows, both sides are write
>   protected instead of a warning being printed.
>
> Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
> Fixes: d1503aa9ab80 ("powerpc/64s: Add support for huge pfnmaps")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy=
_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=3D1
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  mm/huge_memory.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
>

Makes sense.

Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

