Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872B1CA4E;
	Fri, 28 Aug 2026 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875365; cv=fail; b=ZcjFdvHIM78F3Q1/becis3AGAO0tKdQPST5osXcVn8hKOmkayCXyWPaO2FkKFKc1hq1OCe8sAI5MaIgf63LLjaMv9tX6InDccwFD+7y+jmMYzY9gnUZs/OVaqmhQZPASeDG7J/pYIp3IPgfCK9Bx8ah3j/Y7uhsheBatMKl3dF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875365; c=relaxed/simple;
	bh=qliBGY0G2CkhtI0cWMPrlbov9Rv763KnGYLtDYCLmbQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:MIME-Version; b=p6m2Ii6IoNwlRXMfhF4fo0v+nsYcA4blt3eG9WHJKwTA2kSuU8bGmedJdPOrblx9DtOuScMUTJGzNix+XIZDJsIRW2uyEVazHoKXJwsq4bNLLBi+pq4zKsOl8MQHCtF3qWEpOQktTwiE38DRgl+rZejSJAgMn1oH9+/YpIOWizM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=uAl9LzoI; arc=fail smtp.client-ip=52.101.72.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="uAl9LzoI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRoyxlM+5hijLkVU++pqPSqBk7aABukV+lQo2wxxzoQ88wi8/g8TKbWbST+at/s+6n9U87xa6oKOGFETlAl2RRkP2G6UvFUgcL09qXhaIWLAbxu9q45/ZFTN6QkwdGn5ADaj+p++Bm3suTg+OoCLY950vCjv1GL59tXBfTcLki29WYO28ep1EfdDmSc6fai+ghNhmDMEj/svcBuIQHAi0rHuwyQOgvZzrt2s8rJFnGfG8KRADlFOMCZEqpXEXSEGtgH06aQGLft6zsPscpUiLWEA7Lz29Cq0rwZf9qF5DV+fGdrW1WY5cx0dt8N2k9IJg1h2/GtBUF7GTYjKksahIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIi3SFAQeTLojkz0pQIQA6lazha/cajCSdDkNgBLNBU=;
 b=o80HZaPAhO8EzgiYvxToXBbzoY69Q62WtvLZpDAWBWQtUuNdxPufiYwDTC0Lm9YWN+kw8JCXxLlVb8rI6O8hPYTkXqq3AdkzuV0pAN/vDwd19rogtfR+jfj0sLk/dMy6aK095s62cYcxJDxogKZAV2nyj2SwtFr4O3e8ZOwUotSlPFYDF9n0M3Hn3+KsK2qa3OQQIxNm9FT5vJC4lvxOXVKKmxeHgtdXXYPeXAKPxM66DwsjXhbbBPoq92jpL2rCJdDYGmz0utomY4JHAwQvnXoo0GYaDl21nvJu9T/lfCDyG6PSHO3Cpd1tv4l/gIw52ZnXfM+1RSZBI3HvR8Rkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIi3SFAQeTLojkz0pQIQA6lazha/cajCSdDkNgBLNBU=;
 b=uAl9LzoIpJO2tZTy/GN3cgDG52TAog3ob47qcHjKdSJNTTQGRP7BkpxM2KDKrx5uAiAY0xGwbPqPGdJAjMPcYeVt577wpITImdber3C51muXGkl2VDFSgXNXeZKuFvw0o0zBYxw5up9QPSXu7oR7wijbt20kZPx1mzHaSyzLNqUKnamI/NmPwrKq+Ogt/GjzKczxtwLgmO9v+jBwNcPHqPxaKyRNfP/2ky2x77JJQdvEzWcJQqw4xvZuPrSz7qTe+qQWluFGXmOZV4FkFYNMgS2Ptva8IoBvUJEldEEhQQtvALivVd2tWj5bsZwy1Uzrxe5ro7a74qsrxY1TUYG48A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by AM4P189MB3487.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 00:02:39 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 00:02:39 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
Subject: [PATCH 0/2] x86/cacheinfo: Fix slab-out-of-bounds write on
 hybrid/VM topologies
Date: Fri, 28 Aug 2026 02:02:08 +0200
Message-Id: <20260828-b4-cacheinfo-v1-0-87b01de56658@est.tech>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAADQkGoC/yXMTQ5AMBBA4avIrDWhflquIhbVThmLkhaRiLsrl
 t/ivQsCesIAbXKBx4MCLS4iTxPQk3IjMjLRwDNeZ5JLNpRMKz0hObswIURj8soaWQiIyerR0vn
 tuv532IcZ9fY+4L4fEEfn83AAAAA=
X-Change-ID: 20260828-b4-cacheinfo-7779d15fd837
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 crosvm-dev@chromium.org, syzkaller@googlegroups.com, 
 Yunseong Kim <yunseong.kim@est.tech>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787875355; l=4284;
 i=yunseong.kim@est.tech; s=20260824; h=from:subject:message-id;
 bh=qliBGY0G2CkhtI0cWMPrlbov9Rv763KnGYLtDYCLmbQ=;
 b=Tquk5RR8gd9ndQN+2tEBsZF/daXfT4lqIo6+y778pivjvZV6p/Lg2xQlIvCO3FFjQTteB13j2
 unysDnodyeUAIvfQQ+TpXL4bC7r8/ziB8O3QO8RDfH8gveCnMZT1ut8
X-Developer-Key: i=yunseong.kim@est.tech; a=ed25519;
 pk=nfdmjNawkxBHo9UNdzLNBEht8sYmXp0MYUsa/hwC7vw=
X-ClientProxiedBy: LO4P123CA0189.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::14) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|AM4P189MB3487:EE_
X-MS-Office365-Filtering-Correlation-Id: b66fff38-f074-4d55-6185-08df0497ac8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|366016|376014|7416014|6133799003|10067099003|921020|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	pZl6Ly3/1rjwKk1APai7l2JzkJ3hT5PCqGJU8mDiBXzjJxwmKNlAqvcxomX7otqa2dGGSXKZfGpfSMLDJ/IQ0UZXVH7FG65io9c0wEY6odeeq1pxY/5Z03CNHK84pQoerMexs7YOYeWTSmQ/HOnFUJ2mF3dX3ulruGP+oIo8+mcZSGUBt8OtXR5TJfs7fUHUIVMeEDBTFbNSh/zSlRHxsEb6SgQ/PP8yZ4yLr1VeKbyzLmbqn/OMSugQKCzn0hCd6lyLsAxlkXazxzkbPwD+2451C1hU2Vhmv+pPAlpbCLy46oJ8JDBrAGgyNs+b46Rw8/ld5+qF6xqfMdpCQH/FpM+HE9GIO3zxGD42NKglTVVJcPz5oLBe+DRA3utjSD9+iJwO85+qBqNWNL6chGrWZKv6o2Y59kkG9ZMEQK5hCOcGIJIG4JG465E8iPoyFgRYLgxPW32s243JgbgTX9b/XE4yH5MoJ5T8/4BnoGdM0FL8cIPKbjaXvoGYk9Vuf7/Qvm0/RUJ7E2Et/RJ/kbeIP49cOwqoBDsQ/VKnzG+skRI5py1g3K/+2A15ttZI0U+nq3QV2T2Iy8OOJnvfP1FCjA8uobjfYOB2N3hVUYjVtYG2pblPbI12ph1jRdnuUbcl7NsvcT+aD+TXpO6txlDhYNVry4xncoqSIvTSx4IkRhAgJXwD0DE0JFlJdUUnEgnsyrajIMD4M9LBoS6ikj3hgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(376014)(7416014)(6133799003)(10067099003)(921020)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWZjRW5mUGJZc3EzUVJwWG15d1I2WDZFMWNyeVdSMXY5Um1MNVpOWE90cUpU?=
 =?utf-8?B?NWlOZE1GYjRzUWZYOTI4UjN2WnFIbmZrM3FZVnhUWFVkeTZDZXJvU0FOLzhU?=
 =?utf-8?B?OURWNjFYUmpBcTFsR3JwSHNEV0lVRFFDUXJMS0lsc1hacVVqYmFmNVJCcEYx?=
 =?utf-8?B?SDk5M1ltVEZTRjV5cDJJdlZpVGVuNTZyUytUWEZ6bkN1cld2MG9CUXBpOWJn?=
 =?utf-8?B?ckFvcmV2L1ZHTGhnMlZiNUZBeER1Vnc5NW02c1FWMkdhZCtZOXdEWVpIUVdt?=
 =?utf-8?B?RkpzTG9YcWp3Ym5xcnhBY0cvWWRhNXlucWphVVN2ZmtXVzBLUkVQTFZZd1Ez?=
 =?utf-8?B?alNldjNnTC9vV1ZRNlVvMlZNb2s0bXJBc0szbUF6d09CY3E1RG1saEdib21W?=
 =?utf-8?B?b1hqQXBNMDhDRXpDWmZBMEt4VUV4VTVlMGhtUEdlM1JtbkhNSmxDa0xNZ0ZK?=
 =?utf-8?B?SFl6aVZ3VmtWUFZJNWhEazJXRFAxNFZzN1h5Qmt5OWs0WWdiK0t3TDJvZ1Jj?=
 =?utf-8?B?OG1KZTBQd2NKd2YwM01zUkV3ZDN2WmJwSTRFaEh4aUFYVkVWaWVXU29vWG5s?=
 =?utf-8?B?V3pFdHJDd29qQzFRSUw2bTR6MU83Tk94czgzWFdjSEs0cFFGTHUra0ZOMm5h?=
 =?utf-8?B?cHhmdUVMakltdDRJZWlocnd1UTd4aGNSMnQvL3lIZUs1eHlkbU4xQ2NSRE52?=
 =?utf-8?B?YzFwVmIrQzNNSWNvUXZyK0JMNUV1Y0tFazNVNXAzVU5OWGFWaVlWWlhSWnFX?=
 =?utf-8?B?MFczR2lveERHSlJVa2RmR3J5RDlwUWRtQWNTSjZUZlRPOXBRVGZBOEV5d2dB?=
 =?utf-8?B?MkJ4RmtNUmREVzF4REZaSXgrd1RqUWhJS1dHeGlOOEc0TUxidzlraW81d3l2?=
 =?utf-8?B?UzQ0RHhYWi8wVC90c0VaZngwTXlJUCtkWEFGOUNrNTluVlM5azFDSksvU3lK?=
 =?utf-8?B?Z1dBa3Z4QjVqL0Nwc1RPNDNVdTlkQ3QrTytYOXNlQ2dQS3FvVGdxdW15NHc4?=
 =?utf-8?B?MGl4cVlKK010Q0NmeWFidEVWQnBXZktlUWJtbjd2eGlRTTJCalVINDFqbHNI?=
 =?utf-8?B?WDJEdmRDTWcxK0pabE1iR2IrQk5oVTNaUFZaVXphS2FWdzNlMmNKTkhXMEhZ?=
 =?utf-8?B?a2ppNEFJWERIUWExODJCVENzMk1NUy80bFgzcTJkalh4ZjJUeFBoQ0tPMXpw?=
 =?utf-8?B?MStsYWZwTXluVTVMb3ptYXBHQmU4TlRKejB2RXhuQlhmdU9ZR3IrUjVOQnky?=
 =?utf-8?B?YlFNdGQzY0J5Wmw0NXdISk12aU1lRklONEljaUYwWmdNWG8rSXNIbXlpNU4z?=
 =?utf-8?B?ZFJGWXc0cUhjSVVORnViNnBDL1VGdzhrdW03ei80Rk9pUmxVUU9UUDBwSWR6?=
 =?utf-8?B?eldNWUhjZjFoNEMrTU8veHIwOC91SXRiME9qampGRzhGL1AvM2lvRDlmRStV?=
 =?utf-8?B?QjMrSHpmSWlUcUhEbG55UEJGTEhUYkZDb3RVV1hGMWxXV1R4c0dCK0JoRlk3?=
 =?utf-8?B?UHlCRUllVHhKK00zUWFlaU5JMGQ2OXZRajlJZE5pcG02aGVCN3VNZUM3a2Zu?=
 =?utf-8?B?Rm54bFQrYlhPMVNxVnRvU1RYSVhQbHI4ME1EeVExU1prOUo3TkpuaWhuOVEr?=
 =?utf-8?B?VkhqRzIzTk1IS3ZqeE5ieGdiNDdEWUFUVUtoTkdydzB5Mkhxd2hQTkRrNXd5?=
 =?utf-8?B?NGkwRk10ZzR5dklWelA3bG1GV0hYQzRNeTRDcSsvVjM3Mmx4aldZSkZuOWM3?=
 =?utf-8?B?amFDNjdQV0dLa2tyU1o4Rlk3dzdZZzJKeDN0Sml5QVl5L1REMlZkNXlNcE9l?=
 =?utf-8?B?TTlNTkhCaUFpdUFYOXdNVGpwdDNnTjA4c1hhczRSNExmT3hMdHFtUEVDN3ps?=
 =?utf-8?B?MjJQbmtzZjc2YUR2elE5VXFHYTdENlNCcjR0WHhreWQzRlBoMnU5OWZVek9n?=
 =?utf-8?B?VlBtMW1abnJuZHhXSkRPV3VmQXhCT3BlVHVIOW96NndCSldpa3dQTlRzY2lZ?=
 =?utf-8?B?a0kwVW5UNHVhUG5KdDFVbXlKdmxSQSs2dlBOcWFYaDhBNDVIL3VoQmdPbVRM?=
 =?utf-8?B?SEJNV3R0Y1hnelhZREhQckx3b1hkdmR3bEthSm1mMm5TaEVlWjFWQTFiQU1R?=
 =?utf-8?B?VGEyczU3dVBLcGVjK2RHWUU1VXR5ZmZLRkdPK0lXRzJHdTBXRWk4RDJ6Mk55?=
 =?utf-8?B?ckdLN2tINmJsMnUzblppVmZkR2FYbmJvV0RGclVlazlsYmlRNXk3MURDNzVY?=
 =?utf-8?B?bHBZQUVZdS9ITTZSeHo2SXlHc0ZiSzJscmV1Q2tDaG1lSUVjdEVGcitod1Z1?=
 =?utf-8?B?SFd2VklnYUlzMU9kUjhrdEhQVzRMTEJmTGRjQlhmQ3VxRGcra1ZlY1krUUNC?=
 =?utf-8?Q?6dIsQ2uFOayJDeBKu4NhuDBs0U8ILfVqrr25gA4WyLOqh?=
X-MS-Exchange-AntiSpam-MessageData-1: tJwZXqs4gKlVhQ==
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: b66fff38-f074-4d55-6185-08df0497ac8f
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 00:02:39.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MV0XmqjEcG6SP2OWQunppcMybdu+nDvp37pdCBwuDcDh0MVsQXRochDlQOX7MKXE2bTEuXWgGPEVKioHnxscQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P189MB3487

__cache_cpumap_setup() and __cache_amd_cpumap_setup() address a sibling
CPU's cacheinfo array using *this* CPU's leaf index, guarded only by a NULL
check on info_list:

  sibling_ci = sib_cpu_ci->info_list + index;
  cpumask_set_cpu(cpu, &sibling_ci->shared_cpu_map);   /* OOB */

Since commit 9677be09e5e4 ("x86/cacheinfo: Delete global num_cache_leaves")
the leaf count is per-CPU, so a sibling can have fewer leaves, and the write
goes past the end of its array. The generic implementation in
drivers/base/cacheinfo.c was already fixed for this exact scenario in commit
198102c9103f ("cacheinfo: Fix shared_cpu_map to handle shared caches at
different levels", CVE-2023-53254); the x86 parallel implementation was
missed.

It is reachable from userspace. populate_cache_leaves() runs in the
CPUHP_AP_BASE_CACHEINFO_ONLINE callback, so a write(2) to
/sys/devices/system/cpu/cpuN/online triggers it. On an affected
configuration it also fires unconditionally at boot during AP bring-up.

Observed on an Intel Core Ultra 7 268V (Lunar Lake) host under crosvm
[1] during my syzkaller work with crosvm [2] The host P-cores enumerate
4 cache leaves and E-cores enumerate 3. crosvm evaluates CPUID leaf
4 per vCPU by executing the instruction inline on whichever host CPU
the vCPU thread is pinned to, so two vCPUs can see different leaf counts
while leaf 0xB/0x1F still presents them as SMT siblings. This creates
the mismatch that the missing bounds check turns into memory corruption.
QEMU does not reproduce it because it computes one CPUID set for all vCPUs.

The bug is also one APIC-ID assignment away from firing on bare metal: a
hybrid part whose different core types land in the same apicid >> index_msb
window reaches this with no VMM involved. On the Lunar Lake host used here,
only the fact that E-core APIC IDs (64+) fall in a different window from
P-core IDs (0-24) prevents it on bare metal.

Patches
=======

 1/2: Bounds-check sibling leaf indexing — the minimal containment that
      stops the OOB write. Skips siblings whose array is too short.

 2/2: Match sibling leaves by level and type, not by index — removes the
      index-alignment assumption itself. Mirrors what the generic code
      does. Also fixes the subtler problem of cross-linking the wrong
      cache when indexes are in range but describe different caches.

Both patches are split for stable backport clarity: 1/2 is the fix with
minimal code change, 2/2 is the correct long-term solution.

Tested with crosvm on the Lunar Lake host, using the deterministic
reproducer [3]:

 - Unpatched: crosvm, --cpu-affinity 0=4:1=0 (E-core/P-core), maxcpus=1
   echo 1 > /sys/devices/system/cpu/cpu1/online -> KASAN slab-out-of-bounds
   write in populate_cache_leaves(), allocated 3264 bytes, write 32 bytes
   past the end. Reproduces every run.

 - Patched (this series): same configuration, same leaf mismatch confirmed
   present, zero KASAN reports.

The cacheinfo-oob-predict tool replays the kernel's sibling test from CPUID
data in userspace and predicts the exact write offset before triggering. The
prediction matched the KASAN report byte-for-byte:

  allocated region : predicted 3264, reported 3264  MATCH
  bytes to the right: predicted 32, reported 32     MATCH

crosvm's per-vCPU CPUID sampling is a separate bug that should be addressed
by normalising CPUID leaf 4 across vCPUs. That is a crosvm issue and does
not affect the kernel fix.

Links
=====

[1] crosvm: https://github.com/google/crosvm

[2] Developing syzkaller with crosvm instead of QEMU:
    https://github.com/google/syzkaller/pull/7747

[3] Reproducer:
    https://gist.github.com/yskzalloc/5acfdef88e6354dc047604c9883faa8b

Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
---
Yunseong Kim (2):
      x86/cacheinfo: Bounds-check sibling leaf indexing
      x86/cacheinfo: Match sibling leaves by level and type, not by index

 arch/x86/kernel/cpu/cacheinfo.c | 68 ++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 17 deletions(-)
---
base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
change-id: 20260828-b4-cacheinfo-7779d15fd837

Best regards,
--  
Yunseong Kim <yunseong.kim@est.tech>

