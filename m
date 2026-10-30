Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793382938;
	b=l93+h6zXjcOipSJQveKM+5/EM3Xnf2T2KcFCh0p5l5+oMcE/c67jcXTYtZW88xSuraTM
	 6R0wO33x9pUWIZxhq4E24u496Yhznkrqt/7ndK8H8pDQWiMk+Er8bNcILwgTiKzsgmF6t
	 G53hq+jB0pfLyXVT9MStII3HcfxzYoIw4/GB1Ij8AxWD2BDSznPq+UYJHcyBeAZlm05x3
	 b+0++fm8bwMEs13lFdvWSDAS0IYOgcucPcH+qWlW2VBem25k1hsbnnT1IYuYupj4KKrOx
	 6zXTdW50nLK5h49MM0XOvB+SZPI0x/BpNEXsuwQTed+jKJ4IMULuO3orcp2TNb0EMyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382938;
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
	bh=5t9Ik+Xn40v2YUIFF97fV2ihpRAbPLQi02EprWu9+aI=;
	b=pFT7EhHGo405oAZ4aAJH9SGoZGxEpOwCdUYUtf1+rYFrjwQiIV3wt1HBspaDKzrGWNmt
	 Mk2MV4IPWToI7eac7hnk7m7G4SMwNscS5Z4BKc2DqdjuDnkxPR331SiylpV+878KOH3R/
	 m2Lsz2CT3r0Wcy992UdkfN6HqAL80jnSWmj47+Of+qKwXSYyQYj2nZoRb66y2z9usZoQb
	 afBiZABUZeB3Ag6yKdl7/1ZbiKT4dFB/Yn/AmYVqpWdINd6Vgg1Rq0MB5YF3rr/ECuWZp
	 HPV34hrCjIs11M+wKMHXoLKbzuHekKH2Ts03fm6yIV7PjnvAIWCbBWgMDjfgDmVNeAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pvRBMiTG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.1
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6329606A32E;
	Fri, 30 Oct 2026 17:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6329606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pvRBMiTG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/U7UF/lsPXMvHMc7/4+ZmsnGftzGSwPWy3RjgQk8ygVgFsTt3yeZF8QPDc6cBG6oqjqvofVoUmpomxuyuFJYj51AYOQD6yzz5J3G64xGfi4bncEu7Xtv9mUSYEHQ4at1mTuuycgMMWbUDHMeVkUKqxypyED28s+jU+dWdSIrtJkue043waJGu3ui/OAnLQinmiefhvyMHUmMZtBR2rOzaK5qtmrlB/gFItiwwP+/3jt0sKTJXwRVo200uVGIv+y9IZYL6EfkEaCFdOLEQ8hZ8u99Iue7vgOHn0gn3CUoNIcp0dZXt/dXO+Ngqz3XIDmH3JxSfEZDZCE6fZs0dr6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t9Ik+Xn40v2YUIFF97fV2ihpRAbPLQi02EprWu9+aI=;
 b=XPKMuFo2/hTwFDXLIlqVq25598rhn0nfm6g7n7t/CbLFxIQod03kKAD4Q/w3XPj5kOnK+xIvFNw949xPXGkMhWeRjQam64bw58WZKVxpCqH/iZWgRcl3Yy+PIg4iZ60V/O4dk2HbzLP4SWE0VpSulYaipFhS0phvhlMX8DCJ/M1BbvMBS7EX2P7XahqCDGox0WU5xrr8ebVJ87Q7yGcp1zNr+wxMI2J02nhH5EsDmtelEgm3IBHBvZdpvh6IoKsMw741VkSyRuSZRjS2kQZWOTPeCvMGk1YpOWkyX4Akcqs51yNTeElFURTr1PHC5/OWS8j5Oaxopli3l8SDlL6Q2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t9Ik+Xn40v2YUIFF97fV2ihpRAbPLQi02EprWu9+aI=;
 b=pvRBMiTGADq6s/d3kJwO9AnNUpwT2A7g0/t0dYmvqObqcwvJPupmiN5UHchIes50NY7Z+d82WFRxiZ5Ht7iqeWe+E0gFiGM/SujA7FhKSm7tF4/sISNiC1tevua21I4rxvIa3ysJHnPpmVcyj3ANYOgtg/lIWt5NZYp20hOssDdJ+r8RC9UakiG+dFyP9xaYsXHgcYWE1k50p7vRPKbNpATkAyIjoupBWd8fWV2DrAkuWhSzsWIYgzbmobPSyFtEGExxQPoeSdoYdd9dGNCB1YeaAaEmSzRf+2sQsqYFXOFQMCGd0j5+yEdHRZsFXm0BmzdIhMvYZ7QUCTu7IqvR9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by PHXPR12MB999255.namprd12.prod.outlook.com (2603:10b6:510:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 17:55:31 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 17:55:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 13:55:29 -0400
Message-Id: <DMID6W4179LU.2GP3DZWJ95ZVR@nvidia.com>
Subject: Re: [PATCH v2 06/47] mm/filemap: read mapping->a_ops->free_folio
 under i_lock
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Josef Bacik"
 <josef@toxicpanda.com>, <stable@vger.kernel.org>
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
 <20261029-fixes_core-v2-6-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-6-a64ce7f83abb@kernel.org>
X-ClientProxiedBy: BL1PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::22) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|PHXPR12MB999255:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dcf4974-f4d9-4917-6f99-08df36aefd39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|921020|56012099006|11063799006|4143699003|261028144727099003|261026140227099003|261026121527099003|10067099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	UaXycZhrGMIKRNFkdCxTGshtn5zjH2nR/RJiF5RrMpKrP7cXKTVVHmCzxB8CMQ0JEqp5IL0o4MpJIfGfo3wLLTAE6uCmf1rxcTpV8y2x/7yXR5jLUePh2ggZ4uR7wvSntFVmVs9geNXDt5OMa6FRgAIZDNvDSe65Xr7jwmTUVOKQ/vrjGHrx7R/uEbrOq81WF+CaA9xTdMUfJqA+dKrJ2Eaol2IiRBn9OHZmJOnsSJNjMis30NqdmhJwHktm3AbJFnIIES0Jv9WzcO5ak2Qe6AiGxqY65jKDMjuhOaorrgzsP4iR3kYqUjcMafN+ge5v3RAxErRDnglu+KRlEtnq0578w6wA37LSCkWmQxLl+OndM38OnM5mmitpF9rMvIX7ttz9eENOAxHk5eTnFuA+YPOirLhhj7lkg5IAX0/7IXxkKlN4gzDK0zcIsbuu/z6R+hjRYj35+lKzXhyl9EMtSB1+rvWzPQzySqJfAR8K0x1hUOJ911LmRUfsPbufPdEDLincxNHEQQajA62rkvupKR9AbjgK0XD5BCvD5TqCmkl2d684nxnSMHBhIa++7ys1nZxOcYfE2K4w/ZHG75NV3CGLzPcyvsRzzb6is4xyy7Qwrz1rni+W7YOJUDD+6rmhJHp8VhsJik53nX29B/cH6USJsmmsJ12ICvfTg6nI3Ak/chwpnRgPUMNoIAHCCWNQfoRN1kB6JfjriJTnBkTwcg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(4143699003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2E5YTcybjRQSkRLUW5xbzcxOUdvQlowUFA2REw4cG56VkNBYk9pcldIaUJQ?=
 =?utf-8?B?cGxQRVcxOVIzQjl4VklRQ0MwY2g2U1Q2TWc1RzRnb1I2aGNLM240WVVQRXc5?=
 =?utf-8?B?b1JLVmxBejRZa3YyYW5WMzRsdW1OZTJUTEN1cGhkNlhlSEwzU1ROOEpXaWZu?=
 =?utf-8?B?RzcwZDdSVjgzRnM4OGFJR3BQeTZSQnJ6ZFQzVVNuQnFpbm92WVlnbXZ1dndV?=
 =?utf-8?B?Um5UUzdibzIxWlZrM1V3OHBqb3QzVHhuVWdqN1pMYVVZeUd2THQ0U09XSnJj?=
 =?utf-8?B?eVR1NWVaSjJRdFVqZ1JUTEVRb00rcG5IdHQ0bWlmNi9xT011LzdUbDdGVzJP?=
 =?utf-8?B?SFZCc3kwNXQ1UGlEQ2czU2E3aVhDK3llVzhFckNuZWJ0MW9jSFJZYXdDVThN?=
 =?utf-8?B?TGhOR1FHQVlLM3Y3Q21CTmFTdkRmT0lnS3RaVUZXSjhmbnl6ZVhwMmpCa1VL?=
 =?utf-8?B?cGlVRHdoN1UzczRtQ0c3SW5vV09wN2tlMGFkMGQyaWpHN2FEVHlSWmNXTHZZ?=
 =?utf-8?B?M3lxRXBSNUwzQUVmaTA3WnpiOGVWNFRaQ2RYTlNLQkoycFpPWFRTNy93cDhN?=
 =?utf-8?B?bUtPQ2Z2Z0lranlLRWk2M2V1emZFWVdHcVJ6NTdDSGVWUDRXTDZMZEhuYmxo?=
 =?utf-8?B?anNQU2d6TklEZTNZZFZHUGNQVWx3bHc3OUdvWElES3puVGJNVGd4Y2g5V1VK?=
 =?utf-8?B?ZkJ5aUorQzdnd2YzQk5LYktOOWtYREpuM1crUTFGZVFIYVhsVER2VkFiMkRL?=
 =?utf-8?B?dFZaSk96akJ4OTMwQitjTkZqd2hnL1l6bC9LUlhSczQrQzlvVDBkSjNDMnEw?=
 =?utf-8?B?b2NhWEdFOXcwek0zRFluN0FWcnF4NmdwUzlDRnVkM2NkcmluZTdOZ0NsSERC?=
 =?utf-8?B?OVdUQjAyV28vZnUxcnljcGZyeTJkTGMvVlM0VWtCZ2ZqZDl4dFd3OCtlRVli?=
 =?utf-8?B?RjNRSHlVYzF4QWtIdWVDV3UzTldaT1dkUWdzMTlVRFFnbElsMlhLMENoZmts?=
 =?utf-8?B?OVIrNTVoS0ExMWRoRVpzdUtDZEx2V1Y5N043YmtDdjN4RWl1Zi9DbU0xOHBx?=
 =?utf-8?B?eVN6aHBiMzFZdkUwd29oakpkYXFxREViOENBTis0WktPZkpmamNmMncvUytS?=
 =?utf-8?B?czR0Q0RvYXBZV2V3TGREYUY3SXNhNzRGaGdxZUZib3VPV2g2NnF6WCtpaFFr?=
 =?utf-8?B?dlJEMEVrMC9ZOEo4NkJKQ0ZQZlFCM091ajBMdjIyUlZUQ0JVdElHRzJWWTRU?=
 =?utf-8?B?NDNIR3JnMTVaTDBxU1FDOTdOMjJTZWxYZmh3UUFSeWs4MjY0MVF5NmZMOTNF?=
 =?utf-8?B?ck42ZzZCNEw3VGUveitFdDVtUkpCdUN6aTlJNDFyWUFsbDBGRjl2WUNtQURW?=
 =?utf-8?B?VE5sL0NuL1JTdG1wVFBQWmpPZkw1QlF4ck9hMGNucTR0bmNkUllKWHF5YlE5?=
 =?utf-8?B?Q1ZIN2gxZ2pmaWgvZ2JvS21iYkhJbWdaMEczLzlEa2FNZmc0NXd4OWg5YXVU?=
 =?utf-8?B?Q3lFeGlsNEZQanZkR0lyTlVuUVM3M24xQjMyN1liVDRFVlF1d0hXQzhrZGxi?=
 =?utf-8?B?dHRsVXhBZWp3MkFMTGF6ck51RjU3QU5DQUZSNVk0dDVzYlBTT0UrbHltMzlr?=
 =?utf-8?B?SVRJU3UrOVVzdEJzOVk0eUd4NUp1RGdBb1VUMkhTNU54UktZeXRoQ05jK1BZ?=
 =?utf-8?B?elBKSkN5UlNuYmVMRnlVdE9VOUlQWW5sd3B2RVVBWmgzTmRXejcydmFqdk5L?=
 =?utf-8?B?S21CRE5GL010UmJjWGRTdW5DOVFWSGZmd2NIdHFJSEhsSm1xdGgra0s1SVla?=
 =?utf-8?B?K284Vzdya2dhQWZERVE4clZSZGc0Q2ZoQi9rT29wdGp1d0tkVmxYVnZUNjZi?=
 =?utf-8?B?WElLamtCZC91R2U3Z2ZycUFiRkE1TG5PdGNnSk1JejlPV1JTRDVoa1JibFpx?=
 =?utf-8?B?Q0VZQVBZRFAvdHlkOGd1Q1F3ZHdrUkdjclNPNDhZT2F1NEJ2K0dRZ1ViYnJX?=
 =?utf-8?B?WkhVM052cm10ZHVQaVpSK2t6Unk0WXhIUklmWnVuVHpDQXJWR1k0V1RpTXpu?=
 =?utf-8?B?dFlORTlHS3hlVnFMZ3hZV21ka0p4ci9aUTh2ekwvT1djb0lLZlBWUWpkRFRS?=
 =?utf-8?B?d1hyYmV5aTJLSkZrbkE3aXpSSFJ3S0QwYUs2anozSkl4NW1OSUxwSnFTTUEx?=
 =?utf-8?B?Ty9oY25tcWhyZGE0MmxJcktEdEF1Y0Urb2gxbXZrSXZCajFnd0hyNVVtQjAw?=
 =?utf-8?B?b2IrR3FUREQ2Wm9neVFUZVUzQy92VVZTZWhnalVUYmhkbUVZSHpjbGtGbjRM?=
 =?utf-8?Q?gI8jVTYGVrSIA+qtMc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcf4974-f4d9-4917-6f99-08df36aefd39
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:55:31.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYevNH66hkvMYw9k7TMVYMuKZFSc6CTOJnOn8pIE0pMHHJQyB5YpobiHadth3sN8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999255

On Thu Oct 29, 2026 at 4:33 PM EDT, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> memory_failure() -> ... -> filemap_remove_folio() can read mapping->a_ops
> after the inode has been freed. Once the folio is deleted from the
> pagecache it no longer pins the mapping, so after i_lock is dropped
> e.g., a concurrent final iput() can evict and free the inode before
> filemap_free_folio() looks up mapping->a_ops->free_folio.
>
> Most callers hold a reference on the inode, but not all.
>
> Documentation/filesystems/vfs.rst explicitly states that ->free_folio()
> must not assume the original address_space mapping still exists.
>
> Fix it by loading ->free_folio while i_lock is still held, similar to
> what folio_unmap_invalidate() does.
>
> Inline filemap_free_folio() into its remaining caller such that
> delete_from_page_cache_batch() also just loads the callback before
> dropping the i_lock.
>
> The bug was found by code inspection and has not been reproduced.
>
> Fix generated by an LLM and sent by Josef Bacik in private.
>
> Fixes: 59c66c5f8c4f ("mm: factor out page cache page freeing into a separ=
ate function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: get rid of filemap_free_folio() entirely; improve patch descript=
ion ]
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/filemap.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>

Makes sense.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

