Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794498279;
	b=CVTC57h3uOOjLNIfmmZ2athH1hdSTPXIR1ZkZKeDKjQ/+VxQFG7IYhq+lF3YhvDMTGuT
	 RkAlLNcE11A84hHaL2jjBhfqYqttS556XImVbJyFyuItz24YlNxPjkzF9GvWSTT7jANek
	 7g99l9QTYLPaam9csS+xk7or+64SjUChcnOy1bRMeA/LRq86ufDgB8/9SMHO3+AfQ9sA2
	 Qf3WoAZnTrzSqVDKAxQ7n4FmaybUxIsFfdwesCYwQn8+O0psIk6695oHl/rhTdRsWiCyf
	 HDin5RHfNfoS71jsIyYjSyprwT4CKcVrM4Ipojq1rLDZhR3NaCedLx3GEGqwIVBpXrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498279;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 X-MS-Reactions:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2MdypvYs0G9YJTI/gCtpPun29r6JDPp0RHSkU63+kD4=;
	b=hA9q4frlsuG6ZNtJ7VaRz1pxk9VW4/GQxXgpJ1xNlebxVCSV54WhK8OLt15mihoy1d6H
	 Qj+wHUJ4QEHwnMazFsgDlaCJHAZvjCA5a/uWASmYHsMExkjVhA+O+zTTUqwg5ZmMCFmGN
	 dWaCVmB8OXptpWgqlOsx5s7WSAFKmA4DAWIoj8yj/eTEAUPEDvsw7jbKABK4qdCH+ASbc
	 G70GXOE/bW94g0t7+Bfn0z3J95nDWbDIPZ7UqhalPOLCOmcPCq71f4t8XDRX7aVnOoGmK
	 SwanTAzdP5q5OnqqtoN66fvMG1RPa6gnbyrvxvUNQ/0FsuIxCOCns2jq2EBck1q6xXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sno91Hqx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.27
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA2606A334;
	Thu, 12 Nov 2026 15:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEDA2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sno91Hqx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXBiP7hooN7jKd7OYX4vTn+XDB9rY3r0vvWrsDghLW85FiA/vw/XPA0NbESUJcGLZfT0Wc+ovmMNGXV/zKpRly52vKo3lllX7U6DRrH8QB533sCIQfu0YhUgQVQKNeOXgkb4wfO8P1oX5J7BPi9tNa46S+I6IgCi167BfnDORYSlptK7+hZJZC+XZnB2V9UxppiLSIOtXzFNo50J3uD8WI2Ru7ct4sKG+45qjdAK8fMgugKG0VdcgycjyNo8fxm09+xP5F/F7EPSJjbWie78iGPH2YpOJxx8/dk40Do/deTv9gNqSHRvozUy8OrMAV3PMqg46VjwptLiWO2g9isJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MdypvYs0G9YJTI/gCtpPun29r6JDPp0RHSkU63+kD4=;
 b=XnhXyCyxx61zwwIhvnjwbTUcTbjepHYWn7lUOWf5g5vd1h+Lype95Vaptb2C2dBe9yP2eCmYy0kQblZoXo68DUkgC27fA8FTX8X80kmoLMU4KnQ1zdF9ogWzR8istFwLQfiN1uXav92Wnz3k+liIX0RqWkTvvkCbPntUUwyD2vUECPt9SO6nGDEzcWeZLUw/X2EK4n9rwLRmUe1LWgcLhjfZYb2aekdEEFoQuRtGBqsERXc+dTENQeMNL4NqwoP+9Hbs/1J+h/N8j52alwszVp1Iwi4E7YXXRU0VZlRAOu+4bmE5Zg8O93uRdV8quTRHT+AqZYxJJejpw+f7fHuvSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MdypvYs0G9YJTI/gCtpPun29r6JDPp0RHSkU63+kD4=;
 b=sno91HqxJITEqWcHz5MNMj4E2SpVdGP1CdxIyVZsd/TQ1yY4Rqb6j+CVxdMQo6Ly1lgSX+UWB074B/xnSUxbnj2qe281d1Pl7El0iN0LrpbCp5/Ko/Hkh7VUzFPQdTA/IGsYA39laxJMOjVRguEEH37xEjEdKEZ9hFBW1MNcKYuYPPsl5VqUQHMgNH2RRIBpr54hBbjiaFunCcCugNXzbTjbGgQspB74Dwtt1mSOgOHrD23Y21FDRmNYCE+eG2EAMJ81E9zIQyR+Oc3/WHE9ruiW80PaxOzZvqz2IIemoziakWvyOqYZxJLmjGw3uoy8aCUw2uLX74Hfv1AknN0GHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 15:44:35 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 15:44:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
 byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com,
 joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
 matthew.brost@intel.com, mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org,
 surenb@google.com, vbabka@kernel.org, ying.huang@linux.alibaba.com,
 kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 kernel-team@meta.com, baolin.wang@linux.alibaba.com,
 Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] fs/proc/task_mmu: don't read young/dirty from a
 non-present PMD in smaps
Date: Thu, 12 Nov 2026 10:44:31 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <7A78EF9B-1D4A-407A-9948-7AF4DBDDB732@nvidia.com>
In-Reply-To: <20261111113904.650722-3-usama.arif@linux.dev>
References: <20261111113904.650722-1-usama.arif@linux.dev>
 <20261111113904.650722-3-usama.arif@linux.dev>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: YT4P288CA0085.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::16) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 6452bca4-f030-4926-ff1f-08df40d3da03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003|261102123227099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	tWi3LyxLqhfc7Aqw93inKz9d7u7WmvgqtT8M7+tT5CKl1+1vUlQjDbGuy7XHhfrjHRm46NZC8keLG9hvJMslzQ7GvG95Us7V+hXDMI+vys4Wvc1WcK0USEu5JNPD/Jx2L/y7rmLW/qhiRWrr/RyuhSkMTJ1g9jhGUy8lQY8jgX9+6pC9hRtq4qGIiudrQEyjAyT+D0axpd3l4POxsUFo/4GHZt+2q2N/wX+9HBv1qac08Bi5ulAswLYfBET97EZcOKav7rMT8JJyiFE5QZoe3T8kqH4gAkQh4d5nsoxYDluKHJ9ssSyGYYtpYv5gCZHYOi2LVXCMlfFx83sZWj+aL1bkXmaaHMiwcPr92zU13Kxip9bQDfIR52iw9wyaxEb1pqas0KUZDDVNsw4NZdLNSHvrvZT8Jda45uliG2ZvXg+RogunTTyuh/AOAjh7LWxAhiK2AnC6pUUx5dzH09BVLHFgZJCyEg9FpB8DflQo2qI2dPrFnIGk1VMvdc4MXwrSbNC2jODQ55eahjzMIZVeqBRH6wnSNb5FZ8hYw+GBw0vP7mkUnQUZ5zPuh1e7A3v/xKUEoUuOjf+Y9HlDdQUXPpTSc/PCYpqrYwu387mUM5jpJS+a9EGKW5zEgc76ENSdYjEZQuFVwxDKLNy9ZJk4QXRMawkOFtaqYhf+J7/xCsk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIuE31khTkbCLWouxHi9o5PvDnESdvlhbfpfjH5fj95dGDCquSIARrWBsnnF?=
 =?us-ascii?Q?VX/DZ/KKVKtDxed9y28CKdWVE8+sBU/txIBxusgGYoHLy0op9DP8npqLILWk?=
 =?us-ascii?Q?6YnvuoQ3uAeSEcNnJwHYgy+bXD8bZOxRA6PIjxi8lIFptBvFptevVsFBPYxc?=
 =?us-ascii?Q?Rf1+Ph9S2eiD7RQpVn4eoCTEwYblw1MrwVTs7L9JTjQF+PP3jKtL/KSQzQXI?=
 =?us-ascii?Q?kKgM+a23GJUuWTX2BEvc9ri4lF8BP1CpwnEkpiuQShBIGK6VD7TPoVOTSUBV?=
 =?us-ascii?Q?uEBB3KNWr8mOFFdvVuXw1WXqqZ4TUDUSxaARb4dEuxfh8ruyHFE/CwwZDVEx?=
 =?us-ascii?Q?wrRUWE+PANi6zvqRHTJJNf2FnLczxscHFXGXg+4rC2dEiR+yEihur5lBrzvw?=
 =?us-ascii?Q?/+MV1RVD8co+RsBi7kfUoegJAjuMfuCue90Ws65un/1ul3ZUlgrAVJgzqNXZ?=
 =?us-ascii?Q?qnsaZ68bEq1o9+3pJbrexxGq405hjD/bSqQsrtAakuuRGBsdt2NVyh0UZlR3?=
 =?us-ascii?Q?8PqUX2rrp+j9lzsSxfeQbUrP+aIi4LyQQjLVFL7c5+FzqlI8VCK/tB7jJW+o?=
 =?us-ascii?Q?Cd+dIYhTt/FtDiRxqyHbyIF25zMF7G8wRjIE2C/dubZfFxspcb00zN5dP63m?=
 =?us-ascii?Q?bHdIFJj9tYO/sIgATg+qe+U+As/e/jwMKzdBkBeaHV24/XRFnug3DRw4JORs?=
 =?us-ascii?Q?urO0yXFhn3iG1D3ONnB84s8+dP0urwQxhtVi3zax7t535PwMDO+3kXMUKQpv?=
 =?us-ascii?Q?XWL+2qQSz+k0fpuzsLe0TcKR11YU5EJXHzGlPGE/Kf5zP1aXWS353CyKiDeB?=
 =?us-ascii?Q?JhvXsad6Em57AQLxsVrI79lqZWISYSTghb0Yei8QZWt+oHT2evIvVXn2DePA?=
 =?us-ascii?Q?J85+en5DVvrNchN8uikavLugJfUz54kUhUTdE/w0Brwy7W+CubkV08D9fk+i?=
 =?us-ascii?Q?ZzhwlGO8HZd9NNdggAgwgBzPyjwmCiWAwHffVyvGcEpQWugcPll0uhjACIXF?=
 =?us-ascii?Q?61Q07uM2XYt/h6zxhayUq9ZfTEvpauDtPkjXOxd8rp1mQ3bJy26VIaRa5hMf?=
 =?us-ascii?Q?R9uc0V5Jc5Ww9mDkYKc0oNzmXdY3fviqjOG4cv8O1hGXC28leL2Pjr/ICkle?=
 =?us-ascii?Q?7DUxXBizbohnodVe1icMl/ngQAIudVezGhdFhv4GV3XDSS9Htjy/ZsOeTzZF?=
 =?us-ascii?Q?phFRO9W/qPKYjjtdz08B/LOQpFnTBtfJg3Q8s8GsowzyUGWOc+1xQE0rps+9?=
 =?us-ascii?Q?bZAS1+Xtohmxb7LUc8mLkA42v6lb176KmIfaa7A0r3b86PRoOkynP3/3O2+d?=
 =?us-ascii?Q?HUZ7MMbbgGcm0uRP9WvF/RMpqfoFb6wYAL1qJWQD9yJ4zkgMWXvKEDI7kX76?=
 =?us-ascii?Q?LOUT0CmNE8685de7Bi6ujBAvJ6rfVX/tQkF+UftO6iA5ei80EHeA9e5xjsWF?=
 =?us-ascii?Q?IJSXdgVJP8+/A//Tl9tSQdPvkxmq3fPaLTHAohNT1jgvO5fvcSDpNnT4XaNg?=
 =?us-ascii?Q?tRJEnntCBGosQvaYw+Xl8SMnJcB/4TdkIVsljhIgYZfl33mMmxi09cDAM7Ye?=
 =?us-ascii?Q?rxYZSFj7XdJYZNDChgfoUm4mweu3c1ISyr2VbpsWVqb7wpBX7szt5Ajv3bi0?=
 =?us-ascii?Q?0CcfbQV+vO4+949SxuOpFmJBHUOkLB5gmuxflKC4CTaR9mmGjppcsxCYT4l4?=
 =?us-ascii?Q?6jHBOXbVv4srLq4WKIa//WSa6gyfgr7iUkGp4hITnJMHfAGh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6452bca4-f030-4926-ff1f-08df40d3da03
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:44:35.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEiO96KhMn3dJ6JefROsDGws07brrwvWZ9g5p/vOjqselb25nR0dhrRhZ2pX4iMu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

On 11 Nov 2026, at 6:38, Usama Arif wrote:

> smaps_pmd_entry() passes pmd_young(*pmd) and pmd_dirty(*pmd) to
> smaps_account() for every PMD, including migration and device-private
> entries, where those bits hold part of the swap offset rather than
> accessed/dirty state. smaps_pte_entry() only reads them when the entry
> is present.
>
> On x86_64 the offset is stored inverted across bits 9-58, which overlap
> _PAGE_SAVED_DIRTY, so pmd_dirty() returns garbage: a clean 2MB
> device-private mapping is accounted as 2048 kB dirty, and lazyfree
> accounting is suppressed. pgtable_64.h also warns that the hardware can
> set the accessed and dirty bits on non-present entries by mistake.
>
> Only read the bits when the PMD is present.
>
> Fixes: c94b6923fa0a ("/proc/PID/smaps: Add PMD migration entry parsing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  fs/proc/task_mmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
Makes sense.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
