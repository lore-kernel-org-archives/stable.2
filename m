Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380571;
	b=m1ppVbjm6dyOzxAV2zDb99/ROCFtBCTJxSxstpmyQ8KCNLMKA49VQLDKCgvW3GMiikol
	 TYlf84BhKQuga/br1t9OQElsirpdZpblprpYsCbDSnG0yWZEJecgFZ/wcjBQ7Et0w9fjf
	 p4rOjkN2SqB4ekGyOxp4iexI66j2lxyaNrmOq2mSsmj8NSzTTQpdYAnG8xSz2sB1gGO3A
	 nnH0mwayo95KWmgfk80chwgdERdkhYMDAC1QHje3Lm+oQQhhrAoBAdsylWlY7QC/eQ9mp
	 oBFbbyNZ9daC33GTl/npIteg4v9705f/FhOYaiMFA4Ft7GwlGuWfso+d/dWnNmRGgOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380571;
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
	bh=ybKVbrtZEUo4ZkUVHlywlKk6LlM+bSvFqSsT60Q6nMQ=;
	b=POGJh4yYwnf2kFLjejFJIgp7NfLeqe2jA3DauL5NO8417gUU2kCt4UQKU8CdeILf+3va
	 4qVujsVBPtVwrmNi1lkiqkBzoaQGdm9a+/QnLYds9wHt3mXuZ0ZKqfahkNJ6WZJQheqL/
	 BpdfVvDPob2XgL2JctQoiAeVrbuymLBjp151s453L1IxUbWRDsDlUKYIk6wcobZ1AlOAq
	 RoZxRKA6cpMoK+pqdRIgJLcIhdsXnRh5cDteHs/0ci4yWbOb/jHi/EkeJbZ/A1xCjVq+a
	 /UoRGxOJCFvQ7Fh8sZYqddqxAvr64DTC4x7XlrtltgLYoe7ruW7s0lRMjupMxFJU2jQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qpseBjFK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.51
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCF606A31A;
	Fri, 30 Oct 2026 17:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99CCF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qpseBjFK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWvv4kL2pvb1+Uh/Pwjb1+OPD3Gic+0MlAP+KuvnxaIOb91VYimdOSknUfY1dm3Pxaoc+xa12jWKtXQMurMZ2ldMAMX2ViQWU+vOsNiefGxELXpXABk8oR8pdynumRgwGqj518F/kguFAsmpn0+zd6+zMz/+Kch6yAzHy+wNw3710YXQRQpS4f1d1yeMXdXFl4EhAriU2AmyN5DLRrIcKJi8S+EvC8gtdHLu1jn5bEgVADx42zaYAfYc339lZ7JouG2sGorl4Qorla/BVRV6drRbnGz4O/9WzxQf/nQtZVnpkiDeSJBKX+Sftpd1uLHDPTTQWyQAqTEVO7JmNnBm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybKVbrtZEUo4ZkUVHlywlKk6LlM+bSvFqSsT60Q6nMQ=;
 b=Ee3BgvibJJ+MdLeZBMYHjqdI+hsUMaZqnPotUtJ6tVZknXaQ8AtN+1GfwUPenTKFPFDmNeneLG3/Bde+j4Gj7+K4H9DwADt24X9jzu2pFxbDsnh8MC3aoUuOSMPO+r0IUgqFagu9IOjCA2q+71FvroNAeMWexIBZsuvsQ7UiW7t07cjG5I8kV63SYRegs/DDN0sp3+Is8BMyKGisFDFcVsJTXXkm8WYmRXKQ/gZx1pAiDsovan6WUX05TZx8QTtbHjAMMY0FQM+oRURoy6BGD94kXNH4cqNAo5vqn61pyA0LpH6FEEBTRDPpeUjk7y3KfLYoShfEjbEkTxQhmwmspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybKVbrtZEUo4ZkUVHlywlKk6LlM+bSvFqSsT60Q6nMQ=;
 b=qpseBjFKCY7R4uz1NE4P3dnptQjJmvu5hcRGee4842hsyRB7sP7GwH/MefNc/H9+tj8wx3Z5hfko9DsZuDiB1z0AV42llnAYBez3OSZZNHf9uQMjgHEt04lhLTJ8gbgDhMRHf7ETv0a4U44ZCfkHq+Di/B8kZ0mDO/Lh0y/R+dmDmlc1oPLnNaYOWllDFj8O6ARQLq03G3t8cXciKq4grhOV4DxPkGRMx08lCJcwGpMjm5/0Fq4ef0XXSsEN8Xyt+Tb7TJRCGRjg3xv5Kiq4+BlAfm7mf/dMIVaHrDw1ST6B089tV/LgeoEhsidDrXaAlISj1jjOVxYg35wRjmOuRQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 17:15:50 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 17:15:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 13:15:46 -0400
Message-Id: <DMICCHK80H4R.3R69XK82S57AO@nvidia.com>
Subject: Re: [PATCH v2 05/47] mm/truncate: look again if a folio left the
 mapping
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <stable@vger.kernel.org>, "Josef Bacik" <josef@toxicpanda.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Michal Hocko" <mhocko@kernel.org>, "Qi Zheng" <qi.zheng@linux.dev>,
 "Shakeel Butt" <shakeel.butt@linux.dev>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Barry Song"
 <baohua@kernel.org>, "Axel Rasmussen" <axelrasmussen@google.com>, "Yuanchu
 Xie" <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>, "Baoquan He"
 <baoquan.he@linux.dev>, "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Kees
 Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Jann
 Horn" <jannh@google.com>, "Pedro Falcato" <pfalcato@suse.de>, "Hugh
 Dickins" <hughd@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Pratyush Yadav" <pratyush@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "Jan Kara" <jack@suse.cz>, "Lance Yang"
 <lance.yang@linux.dev>, "Rik van Riel" <riel@surriel.com>, "Harry Yoo"
 <harry@kernel.org>, "Alistair Popple" <apopple@nvidia.com>, "Nico Pache"
 <nico.pache@linux.dev>, "Ryan Roberts" <ryan.roberts@arm.com>, "Dev Jain"
 <dev.jain@arm.com>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl Shutsemau"
 <kas@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Peter Xu" <peterx@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Nick
 Piggin" <npiggin@gmail.com>, "Oscar Salvador" <osalvador@suse.de>, "Minchan
 Kim" <minchan@kernel.org>, "Muchun Song" <muchun.song@linux.dev>, "Xu Xin"
 <xu.xin@linux.dev>, "Chengming Zhou" <chengming.zhou@linux.dev>, "Chris Li"
 <chrisl@kernel.org>, "Kemeng Shi" <shikemeng@huaweicloud.com>, "Nhat Pham"
 <nphamcs@gmail.com>, "Youngjun Park" <youngjun.park@lge.com>, "Gregory
 Price" <gourry@gourry.net>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Rakie
 Kim" <rakie.kim@sk.com>, "Ying Huang" <ying.huang@linux.alibaba.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-5-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-5-a64ce7f83abb@kernel.org>
X-ClientProxiedBy: YQBP288CA0048.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::18) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cefca3-0ccd-4580-8f49-08df36a97223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|921020|4143699003|56012099006|11063799006|261009223027099003|261026140227099003|261026121527099003|261022105027099003|261021123027099003|261028144727099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hF+tC7yRsSx1Z+i32+U14mF8hMSFMJmFFAON7ZIQRb2FK3FDmXWwaGTUxtRBP+gPUIG6fKgBDqxqnlvWs2IbjnVmGxbzLL3pS66tbkS/lOw6+Hc6/wxyS6XiVnZoGxbOzQdDS4Q5GQuTIts2Fbg9C/ZhwAzKnkBHJhefhoHBb4illIUZ36pyqoFiaMiw6TFV27lUqQf0jVgSapBsG70keI0+yB//I+EQRJ3cukt3FYZz23aBdVrzwObLwllhsYGTFiZZzNrryjWFinVzfkWvMNr6wPaQUL3DF+mR2Tkx+T4CvWDTbwhn+Q6F0Jy9KDW5wS+rt8x+aaz634RjEwCgzuSfQ6NJ9Y8/BQ2DJOQFolqIRvUMa5Uf//EKv3aVXHEeYh7nzS2Kwf1LSapzVZ+Sl2reeFnxPkyXWnEPdG4j+CTfjBQYD2ckGukEOWonzaU8lPcQ6u1I7ep1W2xU9ofuMwqHz7E64TA9NfFM9kCrNfMWv8sgTpXLlzmNUCo9VlIwDubcrqnxbPYLTsyHAJOsqTM/3o5AhKYHqBGz5ZZd4tZuhDd93e7VkS8xY1z1wObipR+fC69eesYguCVDgzBxhOLFWIS1CU+o/S+/O8l9sKrQGmJ6DfeI78ohJKRfPUqs96M920NvGUIQN6MbqyMIyAE4bfILnprw2a6BOdCEZa+Od83FI87TuJOIRfwLqnnOyTQVfvu4rHd+8hONj+hrPA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(921020)(4143699003)(56012099006)(11063799006)(261009223027099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021123027099003)(261028144727099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWFjTndzY3BuM1ZEM05EWEVZcUFzeXB4aE9PNjlYWEdzRVVjMC9YS1o3MWZl?=
 =?utf-8?B?YzZPcHJaditldVJhM04wNEpzci9ESTZ2VWx4MG14d0xxb0ovL0xwa2h2SzFM?=
 =?utf-8?B?QTIvNDRUOHI5STNIU1dVZGdWZ1NPWGpRelZCaTE4MVNENDRSczBJRFc1eXRF?=
 =?utf-8?B?anFPMkNQVmtuQmpFcTB1UjVUajhuYlFHSkpyVzZvQVpIaVk3dE01YUZ4V1ds?=
 =?utf-8?B?S0FtMGlKSFc3alRPWm9GT3VWZyt2NGxXNVc3Ykl1bVcrcXp0MERNd0RlNTNl?=
 =?utf-8?B?czlIbmpsWUpWNWdqSzMzWFZvYW1VRzhnR0I5WTJEa2J0Y2hnbnI4OFY5WElW?=
 =?utf-8?B?R00xSmU0Y3VTUm45WFRQbjh3Y3pBbUJjRFh3YUhhSk1pM05wSklMWml4Um9Z?=
 =?utf-8?B?cWdIaHhQNVplSi96aEd3bWZWOS96TFNUVkhFajhmM3o4NWZRVVRGaVFiajBQ?=
 =?utf-8?B?dGZXSFU1d2NmYW5HVitpMVBtSnNUaUJpQ0REczBIYUVRSE9rVzZxNUNPTlc4?=
 =?utf-8?B?V0lDdjV4QzJIL0hTNVA2WXhxYzN0N1h1THZQZDNZdVM0UmphdURmRlNIcWlx?=
 =?utf-8?B?VFpzbHNrdnJCWU5TaG1Jc0pKTnhXQ1JZQ1FBR2JhM1RiNkxJY1ZhUDNHNUlm?=
 =?utf-8?B?VEhFSXhuMUx6U1Q1S0RUVDAzd082dHhteUpSd29TZlJ2dlFScS9zSG1wcUs1?=
 =?utf-8?B?Q0tYNVYrK21QWFM0eit3eElic05sY3BvcUFVR0hUUHpjWVkvNnRMMHBlU05Y?=
 =?utf-8?B?Z3NwMjdGYjBrc0pTZ1U1OUZ1RXFYOVpObTBVdVl6bjJZOHhFUTVNQ1ZwaVRx?=
 =?utf-8?B?ZU4xMlZuenFMQXpyWXljNTBYendFaVJrYTF2TXdKVzVSM21GMHRVY3plZ29S?=
 =?utf-8?B?Z3dKTVJlb1FNenpjaHhWWHhxRXI1TG41UHI3amk1UmFvTUNGcTNRTkNqNzI5?=
 =?utf-8?B?aDI1aHlLZHRaTENJUmZDY2xsM0ZXaXJCRk9uQnN2djM3RWVpY0QrTDZNZi9K?=
 =?utf-8?B?NmtKaGZiYVdFRm5jcnZIRjByMnZYVVBLNU13UXQwL29jUG5FZ2NoVTkwb09y?=
 =?utf-8?B?OW1PV0loUWQrWlp4TFNjZVlveGg4WExRQmk0b1gxbEtrdHZsajdjR3VZVTBl?=
 =?utf-8?B?T1VhUGhkNjBkeFg3c1hGVlFBZ2l0d05kOWVtTk1vRFZkazBPeTVMUEFnNmFt?=
 =?utf-8?B?LzJlNUYyQ1h4L3ZaaFVwSXRtbnZHTFJPL00xd2c2ZjRFbm9UaVZIN01ubzYz?=
 =?utf-8?B?UkVhZ1hUbkRwd1g0dUFKWGZ2N1V6cFVTR0FIZ011QmROMXdUK2wwQ3MwWHk3?=
 =?utf-8?B?NmJnQnd2UURKNG5reGpyeDkvaWNHR3pKbWsvQmRJbHU1UzR5K3RzbFFRMlhB?=
 =?utf-8?B?aXl6Ukk5dHlhVi9GT2kyNHJvMHlxSXZFMGtKN2FJQXlHYkRTNEt4L2Q4emNo?=
 =?utf-8?B?TVNkOEtaRzh6TnJianRqb205UHR4aklGWFhWS1Vsc00zNDBsZVRGTmk0QmdD?=
 =?utf-8?B?ZHpPRDN4VUlOSVltb21ITUdBYUpUWHNQODM2T1RLQjNuZUFRQTFHaEl0aFd5?=
 =?utf-8?B?QkUxT0VUazZBOU1kVU1Ec3lXZmNyQ2RTMEM3WVY1dXR5QzNJbUdadWxjc2RO?=
 =?utf-8?B?blpFaXBtM2xQbk5PVmhmYmdwclRwaHZpcUYrOHJQT3ZBWm5taUhFREVkZk1T?=
 =?utf-8?B?R3BOLzFOU0FpNlBPQ1kzYXJoczlXYVQ3cXcyTUQ0aDREWUV0a3pmaE9oNkZl?=
 =?utf-8?B?ZFA5YmhNNkcwTGhUNk42OFR3aDl6UDZhVmI3K1ZsTHRBa2RKTGV0RXBQZGk0?=
 =?utf-8?B?SEJ4Zm9mWGFvVGpDUkg0ZzBVSk5jY1hTMi9MTDFpZG0xYjdEcVhJZ21KMjFM?=
 =?utf-8?B?U05hNEhQbW1uWUpVR2hXLzNhSWJWdC85UGFYTzNxNWFzL200ZVRhVXFlMjJ4?=
 =?utf-8?B?WDlFU292d2g1M24xMW9sRk1OOE9oMHBKUGxyVjlPRGFVUHgrcmtwSjRZK2Zx?=
 =?utf-8?B?VU16bEFvZk02ckZKVEo3dytLSkNBekZuQWt3RDVYMXpLRkZyclRYK2hWc21D?=
 =?utf-8?B?TzJlVzhjckZ2UmdWZjF5QTBkdG9ycXBOSWsyQ2dMQnp5aXU2cTNSemp0NlAw?=
 =?utf-8?B?cUErTk40NUt6aTNYRnNkVmRwNDNSZnRqbVYrMCtwVERVMWV3REg5WjRLY0xZ?=
 =?utf-8?B?RnFIdy9zdzRIeUdEVHF3aHlXUjhFYWZtTk5PcTBSU3N5VU5ydXFHV3ZOSkR5?=
 =?utf-8?B?SFh1VTJrQVpDeS9nSk1WUjg5SHdUa2J5TzJ3TTJkWWFyNUowQktSNGR5ZElH?=
 =?utf-8?Q?v077EA3heQG3+i51gM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cefca3-0ccd-4580-8f49-08df36a97223
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:15:50.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX4zk400flKWjrO1eitTIt2cgIoUwMZ1IWQjJxTUnQhomGQP8f/wWP+rE0gaAaFs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047

On Thu Oct 29, 2026 at 4:33 PM EDT, David Hildenbrand (Arm) wrote:
> invalidate_inode_pages2_range() skips a folio which no longer belongs to
> the mapping by the time it has got the folio lock, on the assumption
> that somebody else has removed it from the page cache. But the folio may
> have been replaced, and then there is a new folio with the same data at
> that index.
>
> For most cases, like folio migration, that is impossible. However,
> collapse_file() only checks the refcount of the old folios, under the
> i_pages lock, and relies on their folio locks from there on. That works f=
or
> users which repeat the lookup when they find folio->mapping changed.
> The following scenario is, however, possible:
>
>   CPU0 pwrite(O_DIRECT)               CPU1 collapse_file()
>   kiocb_invalidate_pages()
>                                       read the folio (old data), lock it
>                                       refcount check
>   the write completes                 copy to new_folio
>   kiocb_invalidate_post_direct_write()
>     find_get_entries() -> old folio
>                                       xas_store(new_folio)
>                                       folio->mapping =3D NULL
>                                       folio_unlock(folio)
>     folio_lock()
>     folio->mapping !=3D mapping
>       -> continue
>
> In that scenario, the collapsed folio with the data from before the write
> stays in the page cache after the write has returned.
>
> This used to be impossible, as khugepaged only collapsed files that nobod=
y
> had open for writing.
>
> Restart the lookup at that index, like shmem_undo_range() does. The same
> problem seems to exist in truncate_inode_pages_range() as well when
> truncate_inode_folio() fails, so handle it there as well, but slightly
> differently: simply check once more through find_get_entries().
>
> Fixes: 1b6444331beb ("mm/khugepaged: enable clean pagecache folio collaps=
e for writable files")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/truncate.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

