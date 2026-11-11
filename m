Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794431726;
	b=lbUec4drrQWI1AuL+5fD3Rg8e4m/KV79kKEwUhDfVaS2HTqB52UpZClr54To0RJ5Bjc4
	 Ho6uVvf3WJH5yfAiG2t2zgI4nYTwaCmJe01ZbfEQ3ZqIJhwfJPNXrLCdMSqdcuTGQwnlP
	 93mTuumjFovkLpBsSRhXN+DYIzgb9FKKM69mYnLv/MK2tkcg74rjxGFgeImJ6p55WLTsn
	 ATO8eh7SAz7YkkvfHycPu8qY2f4RwmP36MuJzDRZcdNJUI/PoJcmvg5mPZLvnCImGV4lt
	 HIDo7wFrHYz5rc+PfsNU2I8WhcBpM4Mkc2+7AgIXV7UkdvPVFssD67jsSc64tq7QJbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431726;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=GcuRJmfhHEBE5TyuhOQ91Uqf1/3c2UeMK9MFRYr348I=;
	b=xm1P5kvDZqlmvV3o38dCq70BJ+vOxjW6XPqxvmC66vLu1/E+jKXNF0Uqt9GOgdrzO/p8
	 Y0EOXrvPWeqRgqlLbDzpCFR8U6iMtp2uzXj6Y+gJ2Z4tte+gDxgBI1nZjxxH2odkcn8iw
	 Vpxtw2VhmwrlQpuo93Ovh9t5HKPaXGzlw1pWzkYeiFBl5JHEeWfg3MeNrXvGmZ2XDP4/0
	 ILBz3f37Fw7tHcWEG/QV4JxEt15OTs9NwpaPCeWvBYXh64d8rfbjyu++09koygJ5mZYbd
	 /hrWBEFJR1PuJRVRsDkVeiCnqeAzxbAtMCyR9A/p9L49z1JgmSSmHu6IROmJHhXPe4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=t5sK0DVe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.14
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDF4606A326;
	Wed, 11 Nov 2026 21:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FDF4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=t5sK0DVe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xb4v1U8QRUBoCTiC8Mn9EW5tE7bo76mx2A52qbRjqjdo3lzmYQX6buNgql61KHvMiV+zmGta2iShtfcANcRE/ezUKdmkWcv9kwF/WKkmWT6N4Yg1QSioq4pZtVY45j/OTk8aTKa3f/jEsUyk9DNrT/QKf6a+zaSsjifJkWMzqPQG6iyyKyWjpH0GyLRXKpz45gLnLkshCGm/lrV7QsqRyYht+yjkZdDD3x3kLD0Swggo6jt6H5nNOKB0w+FYZ+5Pafe92i0Hy3WlQsouiq1gPEPQbzaUdFCUx6icgJWj1TxyQUYnUigx16JrMmn4pNk84oQxc/epk1u7PH9RRx206w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcuRJmfhHEBE5TyuhOQ91Uqf1/3c2UeMK9MFRYr348I=;
 b=Lb0FdoPTJlONtgMxUFFIx/7kCpgfqV7cnLtQJVrIznPUPVGYzohSmvghHLBLcs3vnwxDSozFMhQYyADxeAHw2mHEUfeZhyFPDOhClexFPqOh7PD4mV3w+tlTRlrziEuTs72ghKduHyHwnUFLdVVKO8PoQzZxfTc98fqorL1SjnMqAQnwvDFqtMltTFkmtmMSZiwpoBm0/UzyEhIt5OhmuRXUIspJ+NtXBlBkG9zeazgeBu9aD7aU8oOykVz8qscrg1/j6hCfOriA85HNDisNmMgBK+osZUtxMeU5V7V+HkE9UFsDrXAMqMzMyNKStWfTi5/2XS1CdSbnQ4Hh5ouGGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcuRJmfhHEBE5TyuhOQ91Uqf1/3c2UeMK9MFRYr348I=;
 b=t5sK0DVeLjPXHhus3oLXADtmfSiy2LMOIzLMUieWh6a+8eogqWxsVIkNZGRL5/hGSJDHuhkIqv0xRaZRzr3TZoDtPzEO6s8I4O11X/MHVa7trYMUaWwLlvmgt4pO30IsKqkNApWTb0Og9icOeEfz/aowgcB57KYpJSiskdqKnEJ/IQg+Y6Wh1JzqgRrNHhcgvLv9Kx3uyx08iZgVaeZQJ83SVyqBzmjW0N2gJKNL425D2i5EWhiT4OpkKLaN+5QHA20L9n9KEpLRjxa+1Z21UFuqDbIriXwweHmWf9UmQgsexcD1jMvNynVU51fYcy5L3w/a8OfN4v734/MtlG3OBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 21:15:13 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 21:15:12 +0000
Date: Thu, 12 Nov 2026 08:15:07 +1100
From: Balbir Singh <balbirs@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 10/13] mm/migrate_device: refuse to migrate shadow stacks
Message-ID: <avTYIXME2I033p9w@parvat>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org>
X-ClientProxiedBy: ME4P282CA0008.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:90::18) To CH3PR12MB9730.namprd12.prod.outlook.com
 (2603:10b6:610:253::9)
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f355f30-d647-46fb-f66b-08df4038dfd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|261022075727099003|261026121527099003|261021121427099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Dst/5E5NTGSUMT/xrFXRrPBjBpFuFuDqZjjAagSt+6wU4PECULKrkDfeZlaTgybqhJBe+EgJxBrHCAFoDDm/6zGqi7kI2Et+bJfMxTqSpxpUrz7lYz1A8fQ4th+UX2iyb0voA5So2K7w/Y0J35YQ5qZz+md4tyaK8AXDOwqZAtKqwhKseoY/kpxF0DOOLEpXPltP5t1NBlQIsD+Szwt8tyzflOhuRrjpcZszyJVxO/8gh0Xf4LMvG2Sp8QBjJmrg5Wuq1vm2BIdQ8zT2GG8z9Sm5LeeRCaQEyLdPZwzUx50A6znywv0UMvsb7kDef8cparW0L6F2O1X65er4cXGppodfhVPZdbGzfxIuiz6JxR1UJiBgyjUNodLc0DRW45URZ7cXBvn2nc4tQ02WSb1BGlfcjLappTNrxThhrHQx9CcAaRjqoA05RiVarVy2XoLql8kco7Fbg4Oqnz3AGSgNLt2lZCceEHP6//uoSff9o9C1D5SL/7piCRfEhNx/tbnqeWrElJclmzRghOlmHDN/ETVES0f3RaJLmPwoPwoWjZR2+AgPiH34WNQmh3Qk5feW5QrIrIVYDwBthLm45dzsQUYGyweJjhp2zDQhw/5ONVJseJODctrWIWhou7M32mm9aJeDKXqwkavedStzrovpnU2fF5Snp8Zen7RWRwLcUn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261022075727099003)(261026121527099003)(261021121427099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kYi+Qx08rtrDz1MDNyKLTVSPy+V08cYtHrJsZ/4pXuMKy6g4bncpSpiu3Dh1?=
 =?us-ascii?Q?TSHLTYLn1Fg7vwnXQeIsi5o66ZW8VgZiEYq0kyJRNk1FOqzGI9x6Q0Z/3vBf?=
 =?us-ascii?Q?vMvNxIyo5DcbGv3UxeTZH0rBjJOvOkAjGEWrzw5MsF/gwsnbLRAeqCdIkrpN?=
 =?us-ascii?Q?qwa83h5xvOkUouKlhBkBcnWL3NYkanNtnHZhWAvJ89u2A5OFli+5sdUE1D2h?=
 =?us-ascii?Q?sJKnuDWqTq/x4UKcjcWgbiQrxFDk+CLGF1yWUjUgHdcYnItuvfigos2hczZZ?=
 =?us-ascii?Q?4/F5JDJkaziXFtggf64zLcHAD5p0uWYw7puoxWLrhVtr3jHJxkFHS3Mp/PMS?=
 =?us-ascii?Q?l4zT8pQac3HYFonn5YpPKeeTZ4PI8tLt7VrLf3HvpGblyuao0x9fGCPWF5Nc?=
 =?us-ascii?Q?eOjCLpLbYFUm3pUJ4Z7PplPuEzJJSoY2yHFc9irzuhHuPDxsy0o8YUpk1zEr?=
 =?us-ascii?Q?buQaJDMGoZn+4vqfzw13LrBzkb+zppzJS1TsdcEjtmGdR9167P59+Ql6Ei8E?=
 =?us-ascii?Q?mTHzFIlcp6whcDuTKwozEd+gF+pqoG6bUapPnodg2DPu/gTLp5Q80wFxA32G?=
 =?us-ascii?Q?raMsTtUGLwp7eBrXE7KeSrZ/a6fpS8twTLETs55MrToed3WOR6WLkFo7rIzF?=
 =?us-ascii?Q?sDKWgVm/R5GvIBU9afn2TW/PACCPaA8cYc6AlVAzCu+x0exEqYuKU8dwbe1c?=
 =?us-ascii?Q?mdEDxxDoYH/9dN8RNg3kFIcW/EKRccdYxUZO28ZGihPiQSBWqL4/WLQRX6XT?=
 =?us-ascii?Q?1R0J8wE5/uk2n3/gpHgeqPiqoIz/nK9U/0EKQhlUJmWfHK8jR5OZzdyyYtwf?=
 =?us-ascii?Q?kvyDsdcEroPQc6P9WM/+MKOIiSM+yALZ3oqzLsSi2t1fk+f+nPD1Wu53i/0w?=
 =?us-ascii?Q?2FZG9SEXSoy18Of+kDnqKRMuygpTnj/XNMG/WGEEZBnKAHTJ99oMY6yY72Tj?=
 =?us-ascii?Q?m1dAiOsk4RjYxocvF+jclyObGYS0D531cMfn6vuw0i300d5/g3IGbIIRNpiA?=
 =?us-ascii?Q?TkdiguDbVTsXFKr452AgmCQ4HjIZiimE8YOnJq2RxXrnxkJUmORtiObI/MKj?=
 =?us-ascii?Q?Y4+Fputvzw3i3OjesYjzP3kPdO66OFkW2RhAbeWIQfT9aUxwU78WpP9ss2Uw?=
 =?us-ascii?Q?ywoSdJKt78bv37luZOsMqIOWSa24f6dRNz10COjqNt+EUkjeaWfsSllrm26f?=
 =?us-ascii?Q?3qXgTpsqjTZCSyKEzK1V0+DAWw3GKaS4IfAUV5mZGi8K1grmkF5XKm6WlHkZ?=
 =?us-ascii?Q?+Ll9Vy0irSG+dv2k25IfF6u0PpUfDmC3srP/0ShRLw4CFezF/q2YsVVVxoWQ?=
 =?us-ascii?Q?Yt4zjHKpCkuJ4+6AtLAMzOK2+JWVqGa75JEit4TNgwxhQlhKXNFwCCGmXDXq?=
 =?us-ascii?Q?kPg5vq4b4e5PYZdwXX+TXTvBK4MN7bisadAXlCfuVHT28CUMbGlYqhw1qyo/?=
 =?us-ascii?Q?sdvXz5RQ7qHgFjlkQn7d+ScNohK+Np2mI3ZNlRRhb6cYgmlL/19NHp+V8PWL?=
 =?us-ascii?Q?4EbMZNZcGW4Ft6+QA98A8/CNYTrBzOsQcvcqCfEzbn6i79Eg9GPdndtSfJaz?=
 =?us-ascii?Q?RZ1UjvcDciMiHQm4ip6BYQ+3TZpaqm/JQu7XDKgiYK6+yRfLyZPwPOz0DAYb?=
 =?us-ascii?Q?cvaqbFJ06Xwg7+kqGq9drrSFxBq4AN19yO51dFx/VLAbBBYq3Xddrc2YDdvN?=
 =?us-ascii?Q?aXTYFwS4mS99QP6j0VbvOtxs37gY8TC1MZXs/SSCi3g/aU36GyjKCcxaVCNI?=
 =?us-ascii?Q?C3oCsKpAUQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f355f30-d647-46fb-f66b-08df4038dfd3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 21:15:12.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBbLPHLmVHq8g7o+vvbAV+2Z0cwtJ8wuXQ7zYpe1/nZRwE4NRJRePOIRpNbGtxMYK+9eTIGlfgsh+S9zuF75dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456

On Wed, Nov 11, 2026 at 06:13:24PM +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> The kernel blocks ordinary writes to a shadow stack. But pte_write() is
> true for a shadow stack entry, and migrate_vma_setup() sets
> MIGRATE_PFN_WRITE for each page where pte_write() is true.
> 
> Notably, the nouveau GPU driver takes that flag as permission to map its
> copy of the page writable for the GPU, meaning that the next CPU access
> migrates the page back into the shadow stack, and the page then holds what
> the GPU wrote.
> 
> Be consistent and disallow this for migration.
> 
> Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: removed unnecessary comment, refined commit msg ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/migrate_device.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 5fe11dd01291..a59864f2e9a6 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -759,6 +759,8 @@ int migrate_vma_setup(struct migrate_vma *args)
>  	/* The migrate_vma page walk has no hugetlb support. */
>  	if (!vma_is_mm_backed(vma) || vma_is_hugetlb(vma) || vma_is_dax(vma))
>  		return -EINVAL;
> +	if (vma_test_single_mask(vma, VMA_SHADOW_STACK))
> +		return -EINVAL;
>  	if (nr_pages <= 0)
>  		return -EINVAL;
>  	if (args->start < vma->vm_start || args->start >= vma->vm_end)
>

Reviewed-by: Balbir Singh <balbirs@nvidia.com>
