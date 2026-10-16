Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A333296BAF;
	Fri, 16 Oct 2026 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118275; cv=fail; b=fmpa4eDQAcBbLwEAyqpmwUWj8d+wnK6Y9h+HqlA2s7NPmTZJjkN79re+Cu1n5Ol2inxmeqTfj5iXgghnJ12/MaaNZUg2dKZRnZxfKaTvVA7qe6kHty5SojlL/iFctNOVpW2SZturlGn/eMwZJqUW2UwVyvYEQUYKNRPlSHFxu4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118275; c=relaxed/simple;
	bh=gBc+Ol2dS7jPzU7+XY4YGMo+nxfsJeQIXOkmO5AWAS8=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=YjPyrrEzQbsLTtARhxyHOwN1ngsldvOcKMCLZCZmL6pfy+iP5TtqQDk+x6XLxZK4+1j+8ooNcLkdFhEIj3MHwFQMKTJVm7Vq+gzrMWurdncaPg2RhG8LL7fuJk6/WuM7D7dH4E+jA+mgtaHibTliI1zOH3gy+CMI2vtjNDBBJIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cP1n0t+2; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cP1n0t+2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWypjPkcvXEY8bFtEbt4hkoqGbgwlr3ishYrj+QzR/9jaGlmN6JCxcyqoSCZU1sU0YXbHse3x2vTfmNgpCpy1VoCqusk1Yev9QiuvuJTfNHULqkgMQIVzj4Ln3aPRHCmTaxKNPISh+nmSquJhaLi+5QBoG5rx+RU+z+a8YB5Pet90okRxMdLNxDkok1c/nXqaYmlecjHbNam8bnpImUP1MKo2Lz74jD6v0rUKde79W+jNpKeKHhDO+gH5U8xGMLAk2YFQx5k1yWmxXlxJ0uPwQBJ4yWF+/mHShPNuR+HQl79/eW/sI4AHkc22UNAikLvFWzq+jYQJuzxlRX6V1El6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9OUGlew3j2Vc2qPYiIvQlwa9rPLtzvrV3O5DpbbO2U=;
 b=eU0aZwmQfgfC9G0t5o9du9Mn8UY2f4039rB3BINEr5MD5loCcY4TzYYTHgGS4WMy3EPIpJF4GmnGL9a/912/iV3dsAo8Zd6+B7lJCi65/SLG2r3I1sbAD2jd776yI7KUfI5qtXROCg21g/wG9PkWkIbjc2GCYAoq/VAh7ZY8j0o+geYTVqsu/HTGwQw54BFLUErtSgMxVGVnCS+apy3lnyx7Uy/spxyIhlRACPvWnCiES7gxiAa6HS/bBaJGxYgF5JPXh0GxilUMTF4frgciyyZYOrGphN2Q2SE1k6CMALDYCEcqOhPtsJL4X63E+KOa9Af8rLgSglMAl/SyC4o8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9OUGlew3j2Vc2qPYiIvQlwa9rPLtzvrV3O5DpbbO2U=;
 b=cP1n0t+2rjkPGLWxeOuIlTDbUiytGEtkz1Vqkdz/9pLUyiAPBtPYp1Oa4HSbsXomJAG7ff4YrHV7+ElSW4u7KSb2u+ults3A679vYul6SfqKROG76ITggy7rzZO0N56o1N7FJ1zFBbfA11MWhJYGjdZKC4wS3fvHaS/vgNoCs/Own7mHfII0E2z6mMJ05l0QKEwUuOM9mxAPb9PKKojlC6Zzemz6EpFTqhD6ZmzlHH5ZK/I0vyD3m8Zg6jfwQfYS44hU2aD31qY/ZmiyUTb477knCfuWBqJSSxGhhlYveMT2vhdE/MzVCYGAnnXnyoP/AUK5jgeFmfTsh0sROJyAwg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 16 Oct
 2026 02:37:49 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Fri, 16 Oct 2026
 02:37:49 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 15 Oct 2026 22:37:44 -0400
Subject: [PATCH] riscv: mm: don't let GUP-fast follow entries without
 _PAGE_READ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-riscv-gup-read-fix-v1-1-8cf7f2504029@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQAyF4atI1g3MWGYEryIuppNU40IlqVIQ7
 97RLr8H7z/AWIUN2uoA5V1MlrnAPyrIY5oHRqFiqF0dvfMBVSzvOGwrKifCt3yRYmgoNvQMLkE
 5rsplvqNd/7dtr4nz5yrBef4ACdDmQ3YAAAA=
X-Change-ID: 20261015-riscv-gup-read-fix-d657d67d350a
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Jisheng Zhang <jszhang@kernel.org>, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Zi Yan <ziy@nvidia.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: YQBPR0101CA0199.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::19) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: aedab152-1651-4567-e771-08df2b2e781e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|56012099006|261009223027099003|11063799006|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	LlhiJhVTjQw4UQFebjQjCGQ3PiG2YroApR44MnfDNbSqlAPYYjlqNIpSTiqIcSIGpfbk5rCYfsUbAw3dqFTlU0ncOkakh1sFTPd+kW4M13xh5Y+JlsC5BzpwolJQS2NBIiwBRgj0Ub6/qRJ62FrHlRboDMoFzX337JAX/ODATtIbbtN2nHo1bs+5GL72ii2WvdbGCjy4a8AVdubQhO8NdhAa4ZlukNFVQlUUcIzzfAI8/y4tHX8kOl/PwZ93YZpGY2uYocH268W5IRt62MDVzBJd8V+J5Xf2zAxzY+qw7gQ97Vd1Dvzg/SH55kJPkHsm0vQ3Ta0CwvdJVBbBQyziopjAZKlhffPHg6AQHClQiHSbCU8y26yYaRJj1mcbpYnchGVJD6/fGTjwaE34VDN5Oq2c2cyONOb1kPJMxuBC2KjrhKm3Be2DhyhpdfFDToKOSNUcMukGcdgmBOCslobnQ/75E+O1l+R07XTvSjoOKwDMyRomR1gO0fbHxv/HD3O4MU/GbqVAG2cK7gLXXyiG1SZCHG68NfC7CevUWpdvZty2dt9s7F3FGKNGTsqB/lZ5IShq96ZmlmCTBAWTAU4h0Fpfy0geG8EVD3b91QTcHxgq7MpDIGS4KUn4cqdWPOCG9R0LyRfUodCNJnigyvfoxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(56012099006)(261009223027099003)(11063799006)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTNaNStqckFoZUhna0s1Tktac2pQNGZTeVNmWTI2NU0zc3pyWUwyOWkzVUww?=
 =?utf-8?B?V204Sk84UEZLOGthWXRPU0xnRVJwYUpCOVUrMUpkQ2JJeWxaNWVrVldJczJE?=
 =?utf-8?B?SlV2MTNuUGp3QXJLd01hZGtJRm1EWHBHazFrdXNRU1NWZjBZZGxTZTlVSXFz?=
 =?utf-8?B?Zi9rRU5JNEFNU2hLcTJmWUJqZm5rOTBwMzh1MVE4WGtqMVJjWXRqd0l3TUNC?=
 =?utf-8?B?dGtXS29USmVMNklIbEthOXlFenhJUEZvc0RQemhSd2FzSkhUc0pyVHVNNXdp?=
 =?utf-8?B?T3lPTnppY1B5c2k4d0kxMWtLeWVFamNwZ1VMenU3dUVDamZzRjlOY3hLZ0lq?=
 =?utf-8?B?WXRETFYyZkhOY3Q4VTVoRDREQXpGcHNvKzFxcEpGZXdybFZIVHJtdncvckVu?=
 =?utf-8?B?MWdMMTM3bGFWZHF3VUhpT0dOVG01T25rUzRWcjl3dGliQXEweHJGalhjTFNX?=
 =?utf-8?B?eGNLcjFFbU9ocXVHWFRBTFBhaFlnSEUvRm85MXdvdFplMmJSbFRYRUtYWmpT?=
 =?utf-8?B?QTR2ak1hU05zUlJmRFY0VWtUeldQbGo3WmNFNEVmZ3dUejNSUWpEcE9IY1J2?=
 =?utf-8?B?ejFHdlRmeHF6dEFYNm1TRm1zQ3VZaEpWaUJVTC9YUGtLd2taK3YycE4wV1Fi?=
 =?utf-8?B?RnpZZXNIVFdDUllLUzNST3UxeEUvZThEeElMSzFvQVJNUVBCWEpCL0psSjlh?=
 =?utf-8?B?VUdWbXh6ZHNYNEk0QmFnai9ia1ExWStuWGFTZUNSdmdqeGRMdjVTOGxob3dl?=
 =?utf-8?B?eXd2b1dpZHdwVzg4Mk1XelpUTVNIY2t6NjlSV1RIKzB1Q0t5RVdXQWZXRGFE?=
 =?utf-8?B?SHVBeW9Lb1dUTC9TM2FxQStPMVF1a05rVE9BSDlURWJhakYxakNCYlduaU1P?=
 =?utf-8?B?UzBSaXljaFhkd1NlR2J1QW4yWjlRTS96Z3pURnJISldzeFJlOVo5WFpOOW1D?=
 =?utf-8?B?eGg1K1d5K0JyTG9leDZBcnhFTktUMGNQbUczdWRadHM1MUgrUC9WWEE4V0ZF?=
 =?utf-8?B?Z1hFRHdtOFl3dVZGYW92eFBPOS9qS015Y0xYSy9TQnNZVW1HTGF4MlFucEw0?=
 =?utf-8?B?a09maTRXSHd0ZDZmTlhNRlJvMUVQVU4yNDZ2NEJUU2hSZ1pucEVlRUQ4eU16?=
 =?utf-8?B?QUhkOVRWMzBYOFE3dmdRS2poQmhURGQzRkZleG04M2I3R2orTkU1RHhMZERu?=
 =?utf-8?B?R2thK005em0zQ0oyRUxtZGFvK3RTaU5tL3RLN2h6Q1kxRHNKM0FjMWtDeUxv?=
 =?utf-8?B?dXJDeDU5eHdXU3NsMFZqc1d0U1hWVUYycmd3OWJRd29zT0drUkRmRVZXMjVY?=
 =?utf-8?B?ZURFM0ZsRCtkQzh6bnlIWUF0Q1dYY3ZEdlVhbzFlWU9Qa2hQNHFFUmM3ZFdU?=
 =?utf-8?B?dnUzN3hSdHMwdlR1bDJaeDNleVhjOVpoeGdacFl4cnIzMTQvcVROSjUwczFD?=
 =?utf-8?B?eTlrNUkvL2kydkxRaTZYZnZSMEw2azh3Y0Z6SVFFcS9UdkRRN2RlRnBLZURn?=
 =?utf-8?B?dXBwZmw2cE51emVidjBremxTUnBLTDFKcURaOVY0QmtFSEx6SFltUG9UNjNW?=
 =?utf-8?B?SW5hbkM5dVB3djBkbEgxWUw0Mlh3SUFJNjVoTlhuTytWOXJUVldzWWp5U210?=
 =?utf-8?B?V2xIM2pkTSs5OWpjWlNVUk5CV0RYUXc5amEvbk03WnRCejltbkRISzQ4cjJB?=
 =?utf-8?B?TmNsVGFrYXV0ODZPL2JuaUg2NzNhR2tLb1g5RFBMVG4vbEJyUWpaLzNycHhD?=
 =?utf-8?B?YUV1ZlNVd25xK1Btbm1NZmpQV1lLYkV3eG9Id1BPT1o3a1JuY3FIUkdEaTNz?=
 =?utf-8?B?RDV6dlo2ZWxxay9jTUFPandjYWlGYk5NYVcvUHFNNUovakZocUtxN3FNdDc3?=
 =?utf-8?B?ZzMrbjRjeWpGSDdwWW1RdTd2cGhvVG1UeGRUZjdUUHV2QTkyeWRoYUdKUnB5?=
 =?utf-8?B?QkhhQWE1LzNZOEdoV3NxN2xmclEzcDRKaGFnWnRzUzJqM3BWaUNSTmsyUHhL?=
 =?utf-8?B?R0dGSG1GMG9BV2hmTmJRY09ramRHcnFicGcveFU0L1hOcUJJS0hxM0hhaGlF?=
 =?utf-8?B?NG1vcHk4dUhOZXh3M0p3cU1WWlE4ZHB3MFFPQkNwaHR1bTArMWkyRlYwdjZn?=
 =?utf-8?B?TGlJcld3WlNGME5aWER0c0t0Tm4yK1ZMQ2F3WWJLY1dMNklDbVNNbGQzYTVP?=
 =?utf-8?B?VUwremdidUY1WmpGVXhZQ0hDbzRmS0RVRS81akhJSG9KdW0yZlZNUFFrWkhq?=
 =?utf-8?B?MnlUMGFLa2dnR3VmQzlRYStZZDBQZmlqbmFSWXN4c0ZGYWJxamJZOFJ3ejly?=
 =?utf-8?Q?88OEYoaKF4fs+z/U4n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aedab152-1651-4567-e771-08df2b2e781e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 02:37:49.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLmOZVJru9InbwpxIFgQSIqslbY9SERzLSb8l7cCzAJCov9uovPyMis05SO4hWqo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141

riscv maps PROT_EXEC alone as PAGE_EXEC, which has
_PAGE_EXEC but not _PAGE_READ, and a writable shadow stack entry is
XWR = 010, which has _PAGE_WRITE but not _PAGE_READ. riscv uses the
generic pte_access_permitted(), pmd_access_permitted() and
pud_access_permitted(), which only check that the entry is present and,
for a write, writable. So GUP-fast follows both kinds of entries:

- a read, e.g. from vmsplice() or an O_DIRECT write, can read an
  execute-only page, which userspace cannot load from;
- a write, e.g. from an O_DIRECT read, can modify a shadow stack page,
  as pte_write() is true for it.

Slow GUP rejects both: check_vma_flags() fails a read from a VMA without
VM_READ and a write to a VM_SHADOW_STACK VMA, unless FOLL_FORCE is set.

Fix it by requiring both _PAGE_PRESENT and _PAGE_READ in
pte_access_permitted(), and using it for pmd_access_permitted() and
pud_access_permitted() too.

Requiring _PAGE_PRESENT also stops GUP-fast from following a THP PMD
invalidated by pmdp_invalidate(). x86, arm64, and powerpc do the same
thing.

Fixes: 3f910b7a522e ("riscv: enable HAVE_FAST_GUP if MMU")
Fixes: c68c2ef9d641 ("riscv/mm: teach pte_mkwrite to manufacture shadow stack PTEs")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261015-anon_vma_uaf_fix-v1-0-7b977303b42b%40nvidia.com?part=2
Assisted-by: LLM
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
Sashiko found that the riscv pmd_access_permitted() added by the
lazyfree THP discard rework [1] lets GUP-fast bypass execute-only
protection. The generic helpers riscv uses today have the same gap, at
the PTE level too, and the generic pmd_access_permitted() also lets
GUP-fast follow an invalidated PMD. This patch makes GUP-fast require
both _PAGE_PRESENT and _PAGE_READ. Requiring _PAGE_PRESENT stops it from
following a PMD invalidated by pmdp_invalidate(), as x86, arm64, and
powerpc already do and as the rework relies on.

While reviewing this patch, an LLM also found that riscv's
pte_wrprotect() sets _PAGE_READ unconditionally, which turns an
execute-only entry into a readable one [2], e.g. every execute-only
hugetlb mapping via make_huge_pte(). That needs a separate fix.

Link: https://lore.kernel.org/all/20261015-anon_vma_uaf_fix-v1-0-7b977303b42b@nvidia.com/ [1]
Link: https://elixir.bootlin.com/linux/v7.3-rc7/source/arch/riscv/include/asm/pgtable.h#L409 [2]
---
 arch/riscv/include/asm/pgtable.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 40b1ed4f3ea89..f46b742d6dd93 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -372,6 +372,21 @@ static inline int pte_write(pte_t pte)
 	return pte_val(pte) & _PAGE_WRITE;
 }
 
+/*
+ * GUP-fast only follows entries that are present and have _PAGE_READ,
+ * and leaves the rest to slow GUP, which checks the VMA: an execute-only
+ * entry and a writable shadow stack entry (XWR = 010) lack _PAGE_READ, a
+ * PROT_NONE or invalidated entry lacks _PAGE_PRESENT. Any other writable
+ * entry is readable too.
+ */
+#define pte_access_permitted pte_access_permitted
+static inline bool pte_access_permitted(pte_t pte, bool write)
+{
+	const unsigned long need = _PAGE_PRESENT | _PAGE_READ;
+
+	return (pte_val(pte) & need) == need && (!write || pte_write(pte));
+}
+
 static inline int pte_exec(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_EXEC;
@@ -820,12 +835,24 @@ static inline int pmd_write(pmd_t pmd)
 	return pte_write(pmd_pte(pmd));
 }
 
+#define pmd_access_permitted pmd_access_permitted
+static inline bool pmd_access_permitted(pmd_t pmd, bool write)
+{
+	return pte_access_permitted(pmd_pte(pmd), write);
+}
+
 #define pud_write pud_write
 static inline int pud_write(pud_t pud)
 {
 	return pte_write(pud_pte(pud));
 }
 
+#define pud_access_permitted pud_access_permitted
+static inline bool pud_access_permitted(pud_t pud, bool write)
+{
+	return pte_access_permitted(pud_pte(pud), write);
+}
+
 #define pmd_dirty pmd_dirty
 static inline int pmd_dirty(pmd_t pmd)
 {

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261015-riscv-gup-read-fix-d657d67d350a

Best regards,
--  
Yan, Zi

