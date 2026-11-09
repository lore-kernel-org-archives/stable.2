Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794242265;
	b=1YUd1f2nmTDVrK037Mik3JuuilL/I7fVAVlDqu9B0+EYWsXe/+TD0Zvkzl1bz9cHvDjk
	 M6FnG+m6Q3SInqnvMtWYdo0eKWg1pmDRtZZ0hi2cTJ8JBkyK0GYm6Xz3Oo7O9ZPT8oSjE
	 X6WLW9FgdWZ8lJaKvNubRDQDlhzYS+dJi0cy0eiu1QuceGKDRAl1kMvxZkuVxhXjFOf8K
	 VXZ1Uo/FkzI1dj6wTw2Djdm+IuIo9XjipOK5bc+PawwO1nEx21p/rfEUNHK9eujPwhYPD
	 5QWTVpgCu4GgqAqKuD2bJ0dKKGdMUx3jQcN+00Rv9xXxaGGcPZhxuehQCUtV+vi+k8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242265;
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
	bh=vOB16N96a6fWThf78r2vqLkEcFc6SrHMM8CVCVo3uTo=;
	b=F7pdlF+CJBcE/4KwphAAK1dyrSmIh00ieB1uCaSZO8/rzvnXGRGzqi0kpbQh9EjZQCa/
	 83GSWPFS7s0pI5mwzIUk6dHP8MX22V6qWTBQVDvc8593ELQdATBuloAjg3ATLuwJq07xR
	 EjazR3CjrbfPrxXhE6QgfUvCx6KNL5jxN9v3KNlk6Oq4sZ/CfBT+/9HxOLBJ1yZTpIti0
	 KjeKObSSXhxjZ5hnZRw7/93Rex1NbMF3h8JQ2eDv1BmDDbq2MvFu0M7cUls0ALi500MbI
	 cMMhWrgM5y/IY6t6DHLq84RbbaXypiJqIcfFTmR8HEMkOc4o34PyUv3fCeg9c62DWrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m1ys4KxC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.35
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0A606EE8A;
	Mon,  9 Nov 2026 16:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7F0A606EE8A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m1ys4KxC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7OfUyZaCTDmLKAi4/y88/JZpAkhteLtcI/u1LYDwkU/RI9R18LsyJqu5bJlOc5I2RATrWa4uONxKuCqWv1eU/270RTpVjMpc8uffgRfdZy+htY8SQoVGmVJMSw+uyxbQED30H0aojsigaxFvl4S72DzgBxUKuFnhYL9wrHxVBO6S7/eEHqJykDoRB+GACvOroJUXM6wfAOC/XWsDk0F+P40/+vNX7yu9SXJEnlg+BEBG2c/9q67o3lKhh2YrsuIMKYaF+v1MwCONhv0gfMyH5zl2LOdf1VkY1uBc2/OzbNiT+o8ggeOS0VlJyX2g16h/4SZ2diNfWyrhifL4kc7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOB16N96a6fWThf78r2vqLkEcFc6SrHMM8CVCVo3uTo=;
 b=dPuKfmq94X2/w2Z25Qu+H9ECptz625HYu32TNZRZ0X4I4oOQgXIRAR3tXFg/KzeKK8ObtqJTcSgS4WReXcEEqcC5fOxqzphijEKaacdgncDLPFy9l9o7gFTVrrHkRnevDqi/CqpdtNeXNm1PEIUqPymiX0UlbdmfTn9NauMTa96fxw07564tIXTJ5LQ7TrLOfHDGz26ClRSD9N372KRvbQv7QbjkUyXPnZUkR63qRH1XtEeWsYOlfidhfg76OhO8uJ5RW/w9T3Bjfl/HFtNjcOqQjIehkOnNGjlNH1yArvHYw6VJ+dIRY5jUzENxY/28Udq3iCNQ6Q3Mx7IezCOP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOB16N96a6fWThf78r2vqLkEcFc6SrHMM8CVCVo3uTo=;
 b=m1ys4KxCwfTof5YWgQSodka3O40jUcaiLmpnjb99sa46OxjvTjMCAwCup8x/zselcwlq2BElBeCp7ECVtBJvlJHxVc2h5m7JrWG78UhHoZJ3ctrTUHn60u/L+0ky7JdncaXIU06q45SmHsuA2BHFVsZa8NRkdpIdeusNJavIQtE5RpBFCpK1cDZVgiN6Yd8v7gDetIEuRrr8UvBIB+8h63f7QofFTOJhPGTYN/k2czzcy3jwSUt+IkXVHjd0QHhZvtyLoctum7L8CxbZrOCpmYImANK5Zxqc4gjrTiWuF6qErrgxvsRCW4mrQG6lsUXV87tehLabHmE0LnMEnozNEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LV1PR12MB090032.namprd12.prod.outlook.com (2603:10b6:408:516::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 16:37:41 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 16:37:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Date: Mon, 09 Nov 2026 11:37:38 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <0A8001AF-25B1-4C50-AB63-7188C309C125@nvidia.com>
In-Reply-To: <avHktSBkWvQSakji@thinkstation>
References:
 <20261106-fix-split_folio_to_order-race-v2-1-1b59c67b8af3@nvidia.com>
 <avHktSBkWvQSakji@thinkstation>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: CH2PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:610:4e::37) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LV1PR12MB090032:EE_
X-MS-Office365-Filtering-Correlation-Id: e667f5b2-3842-418b-59c3-08df3e7fc5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|18002099003|22082099003|10067099003|13003099007|11063799006|4143699003|56012099006|261026121527099003|261102123227099003|261022075727099003|261021121427099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	N2rTaz4icbxvL9pMin2aPzj3lO6dnXPfT6stdsg0bnLAg2ynBELBNZYoUg8XfT83ELdzvdkFbz5AcydPI8TqIgC9eMM3EkstONXG0U/tsQJb4rZJ9F+AaC+t/FeFhrdc0mjVWr9XXLRWKERYtvFoUQKetr7IreeVZ20yQZt3G1qGfQ3mtw2qqoDlkURZLMSXR1PjemL3YBljcc3UkyvHraUUskKBbDuAQAyVRL4cL6u2w1d4oHeQNcJYbV6Z1uNC9sR34wEbLCB0/LAbjfwEd+vkHFqzoPnRJNuRwvh/YLHFGT0lBAeR7CwCXlbqI1L8J+Cvt7JhWwskYdpECj3EHh96Ec9iyV9ndPgMznNv48ZJL9CNSQlyFp3OPf+0dUH5PhG4wLgUay370DSEPs2DU2vpKQuPzk/TRthXj7lRAl+9ibnKCwatwJms4O1GYBDx5MMC3X8JwvNrPQ1pqCcRr1u23FrMLcj0dw5xcWSOROIHnReVM3UsHu26D0p2AdwFHl478kqimi1aOC+v4EY6UdBXx9NH8dFpWuYiWfoIDqACRSrRwfoiGxKSCj43XIdDmKvznCH1LGjGtQi+InSZnr3VPTppsVQ9NPYELFsHOLp3MpfE8dZd4H37VenKmHRxSNCAOFzhoFdAjvQwA30BBsilsPKzPcj0L+l8Cr2NePk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(13003099007)(11063799006)(4143699003)(56012099006)(261026121527099003)(261102123227099003)(261022075727099003)(261021121427099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnBCeEswWHVWN2N3cFRMaGpxcmdoQXd0UnVPNGZFVjdoa2t5dTlHSHZnUmtw?=
 =?utf-8?B?RStVbFN1TjdlL0lHcDB1bm5RODUwUEZ0cm0ydjN2eG5vVzYxL3kvQ2RPb25U?=
 =?utf-8?B?UVA5L0w0RStOWnhtQ0NoaXFuNksvSnJRVi90aW9JK0tVMmVYUmlyeU94OEUx?=
 =?utf-8?B?L0pjcEdFNjErSFFibUxJRUUzbEJtK3U5ZStNaGVTM2JiQ1Fhclk3YzZUSXl1?=
 =?utf-8?B?OHRFd1MvQzVJSTF2M2RqTmptd0lIOG85TGxkWEZmTVlBMnNUb2M5YnlLbDJ3?=
 =?utf-8?B?WVNYN0ExR0R1cmUwTFFScVkxMTNiMDBMTEZxL2ZuWkxTdXpkVTdwZ3hIREFr?=
 =?utf-8?B?VDBtT3d1TndqZ2Y2ZCtJeXROZjMvaDI3TUNaL3RnZnVZQ3NkTUpJN095ck9R?=
 =?utf-8?B?S2ZWWDdVZjM2VmZ1b0svbzRQcnpudDNrb3JweWllRnhBZVgxOHc2QzI2MFQr?=
 =?utf-8?B?YVo5SjJ3R3o5QjE1MEQ5L001cUpTMDBRQStqMC8vNGRZQkFqWEEwS3FHMzNI?=
 =?utf-8?B?SFpIRi82QUI0NDFDR0ZMSWYrV3BhNE9Ea1E2L3RBd2hQL2JJUXRsbklWS1Qr?=
 =?utf-8?B?Z25tTjBzK1d2TnI2NVVSUktGV2VPSnczUWViZERuaDhFUFRhQW4zZkR2UnJR?=
 =?utf-8?B?bDlzblJORUg1aHdRWnFRcXNZOWtMYUY3cnowU09WV2lWRmxlZnpoL2NiTDFi?=
 =?utf-8?B?eVNremNYN2hNelZRVW9OM2U1SEpaMUp6MUs4NDRxdFFRYUhFVWFIUDh6aEkr?=
 =?utf-8?B?Q3lhVWlzL1lWNnBrUDU1cVFMaU5RcnZyWXo3aWlHaENnNUNGVUVVOTVpdTFH?=
 =?utf-8?B?WUt4ZEZ1RTVydjlOdFE1UlI2NDYxM2NvZ0JwTEx3Z001N2JDUlFvMmpxK1hR?=
 =?utf-8?B?dUtGZEd4OVQrTWs1U0cwdDgxVWVGYXdjSWpMRWFtQWZmR1lWUWMrM2RicVc1?=
 =?utf-8?B?QVBWSitPc0l4TTBNc25SbDJPNnd0bDRrTi83UUlmc3JRRm5TNGg5WU8vSEJU?=
 =?utf-8?B?ek5VcXN4TFBUcGtWdmxlMHY0QkRVa3FDTC9ZNXZYVy9iMlJJSjR3MkU2d3dO?=
 =?utf-8?B?U2NoVFhZN2Fvc0NBbXp6Nk1qaEIwZE1sMWg5MGswenNIK0hHWUFrYkFCNG02?=
 =?utf-8?B?UElZQ3VKZ0txS05YcVRHNFIvWE5ZUEJMZFRGWlVYaExQRE1hbll5T2NIM1lj?=
 =?utf-8?B?Q1lFdVdnNmx4RkE2bm03R01KY2hpNGVDY0JQdkYrT1BxeElGOGtnelQ5b3Ez?=
 =?utf-8?B?SnQ3L0IwdzVaZzhiN3ZBYVBaeGNpZzZKaWpLeVdOVTl2bm5SaWpnd0ZWazcr?=
 =?utf-8?B?aDFyOTZBbkREQ01DbXZRY01ESnpyUWJsdFhkdDd4ZXpOSDZuT0FZWXpuNzlx?=
 =?utf-8?B?OVo3dFlDQjVvTk40MFNIa0U2TE9UcnZUemVKZEhWOXdCQjZaMzZKOWRXNWlj?=
 =?utf-8?B?dEgrUmhkMXdOYzZ0dkZCbVgwYmM5QStPc1dRMnZBSnM3dHZFRWdQS2pIMWVw?=
 =?utf-8?B?S1Mwa2dGMmdHb1Ntd01NQS80WlpESXdJbTk1RGlHSmRDTTE0OWxURVdhUXAz?=
 =?utf-8?B?Y25KL0w3SXRyL0ZBVTgzdHhvbEo2OEVNZmdlMDhYeml5NlFsc3NYZnRUSE9L?=
 =?utf-8?B?U3R0b2FhbG4yM2tJNzlGdEtlUjJQSS82Q3ZrQy9qSC93TjhGVCtEcURJakl4?=
 =?utf-8?B?bEZhS2MxcmxKb0p0cit1VFFJZXExNGFTUCtZRnB1c1pLdHJUcm0xWjhiOFFB?=
 =?utf-8?B?WldHa1FlNDRwamx0d21aRXplVnhpVjgyZ0VNRVUxaEh4aFh4ZGFJNkNFSXlj?=
 =?utf-8?B?bEh2QXhDZUw1Q1AzMDBVMzVreUlQRjk2OTlJQlJycjhjSGpSM1E4c2svYVBN?=
 =?utf-8?B?MmNPNCtTVjIxWlIrMXRHODVhMEJJK005ZE9vQzNQdXNlamMzRGxzemhBYkxs?=
 =?utf-8?B?SUo2TE5kUzdaL3JRK24wUFBDc1dXWXdQMHZLTnZFZkkvRUhKT3pQSDF6Rmsy?=
 =?utf-8?B?TEdjSXVBcXhQZmFjR2lCa0FZT1ljWHhiQ0U3NmVkVGg1MkNLVWNWb1NQWjkr?=
 =?utf-8?B?QTBmM1FiTTI5MGkxUWhsWU5TYmtyUGNEMVBqcG4zNWRIR2p3eFZDaUp2NHQ2?=
 =?utf-8?B?a1h1VklpbHBVVTRab0RCcTlQQzh5R3dhQ05US1NvUlE4M3MzVjJuanNxSFdL?=
 =?utf-8?B?WmkyMmh3N0FyVVQwUGo4b3lwdGdHREpPSFNBejU3bUNIYzNnNTBhS3pkS1ZJ?=
 =?utf-8?B?RGZVQWtvdDVTNWR0Z0ZxYlhvTDY1TjNKV0RXTitMYUlVcUorKzVQUkRISTJm?=
 =?utf-8?Q?JF7axeziMiirWLLi7i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e667f5b2-3842-418b-59c3-08df3e7fc5ff
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:37:41.6876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0r81HVt2XHeMIzsP7Bv8XeZe6kwMJ0SFvjq5kNkUR2OEhjpHdHfIXI1r2zN5MqLM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB090032

On 9 Nov 2026, at 10:26, Kiryl Shutsemau wrote:

> On Fri, Nov 06, 2026 at 01:28:46PM -0500, Zi Yan wrote:
>> __split_folio_to_order() calls prep_compound_page() on each new head pag=
e
>> to create a compound page after clear_compound_head(). prep_compound_pag=
e()
>> uses non atomic __SetPageHead(). It is mostly OK, since the folio is loc=
ked
>> and frozen and no one else is supposed to modify the folio's flags.
>>
>> However, code calling migration_entry_wait() can reach the folio by PFN,
>> then access its flags. It is because softleaf_entry_wait_on_locked() use=
d
>> by migration_entry_wait() sets PG_waiters concurrently without taking a
>> reference and the frozen refcount during split cannot block it. Meanwhil=
e,
>> __SetPageHead() does a plain read and write, so PG_waiters atomically se=
t
>> by softleaf_entry_wait_on_locked() will be lost if the set happens after
>> __SetPageHead()'s read and before its write.
>>
>> One example code interleaving:
>>
>> CPU0: __split_folio_to_order(new_order>0)  CPU1: do_swap_page()
>>
>> 1. clear_compound_head(new_head)
>>    new_head->compound_info =3D 0
>>    (page_folio(new_head) =3D=3D new_head now)
>>
>>                                            2. migration_entry_wait()
>>                                              softleaf_to_folio(entry)
>>                                              page_folio() -> new_head
>>                                              (not the old head any more)
>>
>> 3. prep_compound_page(new_head, new_order)
>>      __SetPageHead(new_head)
>>        tmp =3D new_head->flags.f  <-- load; PG_waiters =3D=3D 0 in tmp
>>
>>                                            4. folio_set_waiters(new_head=
)
>>                                              set_bit(PG_waiters, &flags.=
f)
>>                                              enqueue on waitqueue, sleep
>>
>> 5.     new_head->flags.f =3D tmp | (1UL << PG_head)
>>        <-- store; overwrites step 4, PG_waiters =3D=3D 0 again
>>
>> Later, folio_unlock(new_folio) sees no PG_waiters, skips folio_wake_bit(=
),
>> and CPU1 can remain blocked indefinitely.
>>
>> Fix it by adding the atomic version SetPageHead() and
>> prep_compound_page_atomic() using it. __split_folio_to_order() uses
>> prep_compound_page_atomic() to avoid the issue without adding an atomic =
ops
>> to other prep_compound_page() users.
>>
>> Reported-by: David Hildenbrand <david@kernel.org>
>> Closes: https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.co=
m/
>> Fixes: c010d47f107f6 ("mm: thp: split huge page to any lower order pages=
")
>> Cc: stable@vger.kernel.org
>> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>> The issue was raised by David when reviewing Ye Liu's "mm/huge_memory: u=
se
>> READ_ONCE() when cloning folio flags during split" [1].
>>
>> [1] https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e331=
291c1@linux.dev/
>
> Sorry for late reply, I only now got to this.
>
> Setting PG_head atomically on its own looks odd to me. The comment above
> smp_wmb() already says page flags must be visible before the page becomes
> non-compound. prep_compound_page() writing PG_head after
> clear_compound_head() is what breaks that.
>
> Can we build the whole flags word for the new head, PG_head included, and
> store it once before smp_wmb()?

I think it is a better approach.

>
> After clear_compound_head() only the tail and head setup is left, and it
> does not touch new_head->flags. Then SetPageHead() and
> prep_compound_page_atomic() are not needed.
>
> This was option 2 in your analysis[*] on Ye Liu's READ_ONCE() thread,
> but I don't see a barrier problem.

At that time, I did not think about separate __SetPageHead() and
__prep_compound_page() and what I had in mind would still call
prep_compound_page() after clear_compound_head(). That was the source
of the complication.

But your version does not have the issue.

>
> PG_head gets the same ordering as the cloned PG_locked, and
> softleaf_entry_wait_on_locked() already relies on that through the same
> smp_wmb() and page_folio(). The new head carries PG_head for a moment
> while it is still a tail, but page_folio() only looks at compound_info.
>
> Reading the old head's flags with READ_ONCE() while building the word
> would also cover Ye Liu's KCSAN report.

I am planning to use data_race() like I said in Ye Liu=E2=80=99s email, sin=
ce
the flags are stable at this moment. But let me know if I miss something.

>
> Something like this, on top of the v2 base, compile-tested only:

I will send v3 based on your changes below. Thanks.

>
> [*] https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.com
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bd44d58e8684..53786b2abe89 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3714,6 +3714,7 @@ static void __split_folio_to_order(struct folio *fo=
lio, int old_order,
>  		 * Don't pass it around before clear_compound_head().
>  		 */
>  		struct folio *new_folio =3D (struct folio *)new_head;
> +		unsigned long flags;
>
>  		VM_BUG_ON_PAGE(atomic_read(&new_folio->_mapcount) !=3D -1, new_head);
>
> @@ -3730,8 +3731,8 @@ static void __split_folio_to_order(struct folio *fo=
lio, int old_order,
>  		 * unreferenced sub-pages of an anonymous THP: we can simply drop
>  		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
>  		 */
> -		new_folio->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
> -		new_folio->flags.f |=3D (folio->flags.f &
> +		flags =3D READ_ONCE(new_folio->flags.f) & ~PAGE_FLAGS_CHECK_AT_PREP;
> +		flags |=3D READ_ONCE(folio->flags.f) &
>  				((1L << PG_referenced) |
>  				 (1L << PG_swapbacked) |
>  				 (1L << PG_swapcache) |
> @@ -3749,7 +3750,16 @@ static void __split_folio_to_order(struct folio *f=
olio, int old_order,
>  #endif
>  				 (1L << PG_dirty) |
>  				 (1L << PG_dropbehind) |
> -				 LRU_GEN_MASK | LRU_REFS_MASK));
> +				 LRU_GEN_MASK | LRU_REFS_MASK);
> +
> +		/*
> +		 * Set PG_head here, not after clear_compound_head(): from then on
> +		 * softleaf_entry_wait_on_locked() can set PG_waiters on new_head
> +		 * without a reference, and a plain write would lose it.
> +		 */
> +		if (new_order)
> +			flags |=3D 1L << PG_head;
> +		WRITE_ONCE(new_folio->flags.f, flags);
>
>  		new_folio->mapping =3D folio->mapping;
>  		new_folio->index =3D folio->index + i;
> @@ -3779,7 +3789,7 @@ static void __split_folio_to_order(struct folio *fo=
lio, int old_order,
>  		 */
>  		clear_compound_head(new_head);
>  		if (new_order) {
> -			prep_compound_page(new_head, new_order);
> +			__prep_compound_page(new_head, new_order);
>  			folio_set_large_rmappable(new_folio);
>  		}
>
> diff --git a/mm/internal.h b/mm/internal.h
> index aeebb3e49ed1..4ce67ce2f3fb 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -807,6 +807,8 @@ static inline void prep_compound_tail(struct page *ta=
il,
>  	VM_WARN_ON_ONCE(tail->private);
>  }
>
> +void __prep_compound_page(struct page *page, unsigned int order);
> +
>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>
>  /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 143776e671ab..37768fa5341b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -683,11 +683,17 @@ static inline bool pcp_allowed_order(unsigned int o=
rder)
>   */
>
>  void prep_compound_page(struct page *page, unsigned int order)
> +{
> +	__SetPageHead(page);
> +	__prep_compound_page(page, order);
> +}
> +
> +/* Set up the head and tail pages of a page that already has PG_head */
> +void __prep_compound_page(struct page *page, unsigned int order)
>  {
>  	int i;
>  	int nr_pages =3D 1 << order;
>
> -	__SetPageHead(page);
>  	for (i =3D 1; i < nr_pages; i++)
>  		prep_compound_tail(page + i, page, order);
>
> --=20
>   Kiryl Shutsemau / Kirill A. Shutemov


Best Regards,
Yan, Zi
