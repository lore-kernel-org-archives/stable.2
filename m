Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32193FCC;
	Fri, 28 Aug 2026 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875371; cv=fail; b=FeF1xSSHzQIvMsW1bXclGbkwEt5kQx+3H5mekyQ0UKgkHyr5QypmSfi8xLFWKduhgRRoKqpd0HI4EpOLQkPYyoF6Jyr4N4sgimzs7zPYaiTPinLVI4vUCIpfxSbqm6EMJtbrsrCrUwEkK8SHSYOu8wIdsow+71vvCbNMlQDO3n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875371; c=relaxed/simple;
	bh=c/vO4QvtzI7kdFjP4lHKaVmdImz34m12ALWcDeWzZMg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:MIME-Version; b=uyEUNrh3HfPt8SUeC0OwQaOo0HR6FaN/uRKVG77ja04BENwzPSEvmLdeIvGB2qfWWIN7htWxKhGcuzKWdkBRxuhq3PX6I6xOjenAJrCkbhMUp5ceyVzozmsgVO0UQnx1eNeHgQ2OE9nQz2FxgYbETfiAnSwW7OD6Im6AUcu767Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=dssVXOck; arc=fail smtp.client-ip=52.101.72.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="dssVXOck"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjsS3vJ7r48A4MjCfr7FyCT6mmaSaBJgTHcK8AMFMVRJJdupuSoDMYlPlgwEM0zcS3DN2jQ1MBlGL9TPqLpxnldhBPhs19GgPly/8gQbPy1D81AfQpSW48T/DO4sLAvH+8zf3dB91mbgsbQyV0emdTLKaicnjeS9SoXBcOTtfsJsUG+psaWmdzAhUA5cyeiL+hkEFiHzHXRNjhzHCClGKBQvRgVpIV4FSmsga0VhaYF/Q202KDdN6jiTHPoVBAgTp9ou3NtfjMQyL2CvgPJ95TkG0B9m9ZjI3DaUp2kH0PVem074c5gTJPz0Q9BAUm4Mkh4bOI4B2IvKjedef/imTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0RtfAtLDilzrKkDGI1lVAv8A4riXGuAfy+FzUNXiV8=;
 b=RwRG/Zz5bQ6/6fYlArDR8uf0Y7kPs5J/GtHSYJJKM5W4i3u82DqJ1Enr0OU2s1ZD/UnWP6eE8w7QfFm+CgDX37JQOV2CqbEgCxNM8ziiPj6tCOnF82x9JYmr0n4ZrNpaFhq0GeQ2sN7Ct14gmfgyr3LPfteUwg1X1HeSVsd7b87gsd8Vd/Wn2mbfb2VSaIj9VhI0d6ZkYIlOfHvRZGAXsLe3PNso+c9mTX3uQDV2EgRP+hNAPeFiS8aXoqvNk4F0ICyaHTpSLIPUXFMuyekvEoZPKNawecIgb0f0TJmokmjnjLNnMcWlSN2Z5e3HOwva24+lZq7F5SfVwHoh4xkntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0RtfAtLDilzrKkDGI1lVAv8A4riXGuAfy+FzUNXiV8=;
 b=dssVXOckn1P6pFZulvENrUlqhLzrFJv+zJVYwFXcBpjT6cWoM0PFqDpme+ecM38r9ES8nlXT7+FhDQYgisCTQeQpa1E15V/fX12ZxoPTFF85EGs6ICToPcEuB5bqg6anchAEWNjzKmJEtOY4apncg8od6jsW/yyu2vk/F6PK8EgF/UAftgac0pAj/370dnYBmHm/OK1SOtc4PpXOxS0uS5Bo1CDHDf9YZrhX+aY83FC3zbGPuZDBLhEsbxCdXsbsn61BvHGfmobReHCEr3tqC7A5dpRUL+LdZZ1kzVyeAP2Lu5/3NOrWlbG4ka+XDZOVxC9X9NN4CBpEX2aD1n06tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by AM4P189MB3487.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 00:02:41 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 00:02:41 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
Date: Fri, 28 Aug 2026 02:02:09 +0200
Subject: [PATCH 1/2] x86/cacheinfo: Bounds-check sibling leaf indexing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-b4-cacheinfo-v1-1-87b01de56658@est.tech>
References: <20260828-b4-cacheinfo-v1-0-87b01de56658@est.tech>
In-Reply-To: <20260828-b4-cacheinfo-v1-0-87b01de56658@est.tech>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 crosvm-dev@chromium.org, syzkaller@googlegroups.com, 
 Yunseong Kim <yunseong.kim@est.tech>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787875355; l=7049;
 i=yunseong.kim@est.tech; s=20260824; h=from:subject:message-id;
 bh=c/vO4QvtzI7kdFjP4lHKaVmdImz34m12ALWcDeWzZMg=;
 b=Ug+G+Mwt41wXnFdKvd3NUh2n09K1ghxmlspZvuixtd0UHnwft+O9E1thfe/uDMfhL88r6UlUW
 +Tyiya78jWuCXOUTuWKSynI6vTcY5F7Y/u8KDTqSVnCYklnJ6OGaZn0
X-Developer-Key: i=yunseong.kim@est.tech; a=ed25519;
 pk=nfdmjNawkxBHo9UNdzLNBEht8sYmXp0MYUsa/hwC7vw=
X-ClientProxiedBy: LO4P265CA0239.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::13) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|AM4P189MB3487:EE_
X-MS-Office365-Filtering-Correlation-Id: f06583a1-c40b-456b-6731-08df0497adfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|366016|376014|7416014|6133799003|10067099003|921020|11063799006|5023799004|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DYttnNUwwvFf8Ya3JxGvFAmbGBnuxkPI8njdQdABZt9M+odI4kOb/7xVuupFo1era0hVP7ThMdRyHqbRLs40aKS9c1mNFtjZS2NTE9J3n1cQliXOSF+ZpQHab4LQtFQnYO+//FrQptlYk3zuaA2p1tbPt3Z3GEV1JFjPpqvCOG3ZeBjUhK8wigpQxXQ6fEBdG3TuckI5VZBOTsmw1ixwubvt/MkR+tGV4lBl4M9Dte7YOhFv2sdfu+xxMTcGQHJep+Rbc0HW32bQvxvDqnff2KWRWeX+g3l2gduI7OmqCwJL8U7nN4nWOqGm24ZKIN2dE0El5/iZQYa28sgD8JJMWtAvS565oLPmtJyR9NJ38pAG2C6cbGQOoBdsmCJqkUNtgR6V5JM+auSHY2Bzf0AY0TDPlfqC2lYG2vle8ZKBKUzAX0pEh17FzbwJZudiI160yQcFepk/UHTGzEmGihPOH3Kdjdo1yLiunmUNW0Bna5FLLcN6u6V1MgtiCiQfjyQwOYNlF30iIWN+BL63MDzUWnb6sDP1wqTHAT5J4BtVGzk/b/aNeqDA+HYQKFWX9AwEoOruqur0Jij/30QjzplACMXEXVVT4tKeq9ItnsqdpbWGwly4mDyn39jZnW3nXhEq79X6t8b3qaT3iYqPRonCPzFlWnTja387U1GWMyRl+5Is0C/VU+/vfRmGUnwCyH2AuNZ3h5sn1shAGpUNvQyT+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(376014)(7416014)(6133799003)(10067099003)(921020)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk40T2N0dGo4MytIQ2FDdmhLMDlPM3QxR3FYcHM5dEo0QmI4dVJJUzRvNC80?=
 =?utf-8?B?YXdlQjBFRjlJQTgwVWJ5T3BwWG1uU1h0ZEcyNFdOL2ZwU3ZVcDF6ZzZyZkFZ?=
 =?utf-8?B?S2pYWVRJUVJVd2JWUmc0bCtEMzFISnQ2bDlWQ0ROcm1yM0lJYUFYSUV6R2V2?=
 =?utf-8?B?MnR1YTdna0UyK041cnVDa0llb3RzYUFKWnZqR2ZIQzF1VnRGRHhvRmEzSnlH?=
 =?utf-8?B?U0pFMUdBcjg3aDBNelJrZk5saUNRcE1RVUdZQTNCMWJYVGg4Q2pwK05CenV0?=
 =?utf-8?B?T1Fod0NTVDlvNWI4dk12SXNuVmpKTTZ2U3VDQWpINHVkamVkeW1scHBSM0tm?=
 =?utf-8?B?VkJhUVdhRzVoTWE0d0ZyeE8vRVJrdzFLMktXOGJXUGVYbllpS0Qzd3I2dStT?=
 =?utf-8?B?WG8xMHd1T01TSFM4ckVrTm5BUWF6ZkQ3ZndwR0lneFpWalhzSWIyZmRzU3c5?=
 =?utf-8?B?UVJETmxnN0xkT3kvaitoam8xN3NVL1FWbHRjM2pZUUdjK3NpYXJubnA5bGpV?=
 =?utf-8?B?QTRxYzVxeUxkaTAxRWFEOTNaNlUvK3Jrb3BQS29XTzNjeVdFSHNxM09BVHpH?=
 =?utf-8?B?dTByRHY2MkpXVGpuUlJNMkViWk9UZlArZjh3WDUvRDJCVW1RQ3VtN2pLMlpa?=
 =?utf-8?B?a0FqWXA3RFVlRmdpSzhoRjNEcXd6RU5JalZCSDRTOXlvUlFROEFidzN4MHEy?=
 =?utf-8?B?dk9hU3YxdFpISzQ5ZzhHQVhmK0gxWURNTnJZSHFaNGJaZElldW1NV2VLV3h4?=
 =?utf-8?B?cG9sMXQ3MVU2OTg1WU5VcTUyNGVlYTNIM05xMGJxd3J6Z3lUZ2VaSjh6WlVD?=
 =?utf-8?B?S3YwUXN1V3BuTXNJeXQ4WksrakZ6Z1lOei96c2FyNkx0WlA5QzY3U0t6N0tQ?=
 =?utf-8?B?N2Nhamx5c0dCOW96MndkdkdRT0N5ZnpWZXFjUnpPMWx0cHFoVUJVSlljWWU4?=
 =?utf-8?B?MDJkYmV0cXFldzFsdmcrYVQ3dkppY2djVWZnMDFEcCtVVU8yZmE5TTdRSWw5?=
 =?utf-8?B?cjFnZC9aR2pVK25TdTg4Yi9CN1c4eEhBSTdOUGdQSzY4WmhHY1NXWnNGTzNj?=
 =?utf-8?B?SWN4SlVRTGZ0a3lucjJCZ2YxOE9uNGcrMHlZeW9XbXFwWHc5eS9IdS8xUFZG?=
 =?utf-8?B?alg0WWNaTGtTTjJPUzJpbG45ZGVLdUFhMk5ucENTTTJQdWxVU21WZ1pSTDJD?=
 =?utf-8?B?bXpDUTdnWWRQd0pURU5WQ3psL0FNVzJaV0pONmEyMERJNG9SL2J1UWpRU1Zx?=
 =?utf-8?B?VFdaK0hRaTVkTEFPaXRtSEUycVZSYW1QV3V3YkYxQ2pYVU11akJtVjdidkVp?=
 =?utf-8?B?Y1VGV3NFdVFFakZlUTc4SG91Y1RGRVN5Nm5GblJnMlA3aVdDNkdMRzVlQ203?=
 =?utf-8?B?cmlhcGt0bHkrWm15NVYxU2taVDd2cVpTR2NZY3F4Rkl4QWg4VVcvTmNwVkpO?=
 =?utf-8?B?NXUxUzBGUWJ3ekFTakhhM2I1Y1cxZlI3STBXRWdpZG9tekNzM1UyUVEvb1NP?=
 =?utf-8?B?TmFPMjBPVEgwb0huS0FOR3gyOTB6dkd0SEZsOFJuK24rcmtsRW1IOXRVV1Y5?=
 =?utf-8?B?K2g3U1ZhMm5NQjlPSFJjbFYrM0tZN3QycW1tYjBUNFUvcWZxQnlDYW95ZExC?=
 =?utf-8?B?NU1BZkxObkZ3aHRxckl0VzBoVjhmMGxieHFZOFk4OXFxNzFDYWZWMkNUZTJx?=
 =?utf-8?B?aG9XNW5SblF3MFJ1SU1tTVBFNXBQUUphMGxQNzU2eG42SSsrZWpyYUdSeEFw?=
 =?utf-8?B?cUVReG5kRmVNYWxHOXBkM0lINTJZdzJYTEg2SjZoVDI1ZTlMQzJKUDVZbk1K?=
 =?utf-8?B?RDZwZi9rdEdSNDdWZHVjdE1uQ3EvcVZjdGEra2tkZjcrUnRpSlhFUUJDeXFO?=
 =?utf-8?B?cU4wakdMNWk2MWo0aXpwdkxJRE5NNkpwc0E3aldOOUdHRGlrSC9HbkRIaVFl?=
 =?utf-8?B?eWtKeURiem50cnV4aVFmOUNoTUptZDBzbVFhNUY1MDAvZHgzMkJKUEU1Nk1t?=
 =?utf-8?B?M2tDc2VIN1U3Yi9DazhBVVZKVlNveW9yR01FNFJyMCtkaHVoVmhRcmhFMXRX?=
 =?utf-8?B?OGRQcDRLaTdSRytLYmN1L0ZMclM2OGVCckxoak10UFQ0NGM5d1gzVVBsaXR6?=
 =?utf-8?B?N05IcTFHUXQ5cFU2ZkxoeFhISXE4SVd1OXllQ3FEVDdLRklKbXd1SUQvRFIv?=
 =?utf-8?B?amIzTmduTCtaWUc4V0N2NGdTSHNVcHVBbCtZOFYvODJRZ3plY1dEbFM3OVZu?=
 =?utf-8?B?NGNZZGx2c3Q2VE5zMW9kS1pHM3RLNDFJZVdFMW1vUFg2cTZhV003c1RGTFQz?=
 =?utf-8?B?cjB6RWNiRnB3cEFZOXNBcXhyOEYwMWJyM1M1M1k0ZGR2ZHFHNDVqT1V2eE5h?=
 =?utf-8?Q?Lpb58qbqAfbjOa/gYfuqauKP0AjO+PYV5q0CXKTlYa1W1?=
X-MS-Exchange-AntiSpam-MessageData-1: muU9bT6XumQ6eA==
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: f06583a1-c40b-456b-6731-08df0497adfd
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 00:02:41.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: le7VnZaTG3bWVn2cCQtWGZPEHbMKC/ifOjzHSUJ4HJlHgiKJtSEcqda9qsJJsGubXzZg0sJQCtNBF9AlRFVKFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P189MB3487

__cache_cpumap_setup() and __cache_amd_cpumap_setup() reuse the current
CPU's leaf index to address a sibling CPU's cacheinfo array:

	sibling_ci = sib_cpu_ci->info_list + index;
	cpumask_set_cpu(cpu, &sibling_ci->shared_cpu_map);

The only guard is that the sibling has an info_list at all, so this
assumes every CPU selected by the APIC-ID tests enumerated the same
number of cache leaves. That assumption does not hold when CPUs have
different cache hierarchies, and the result is a slab out-of-bounds
write into whatever follows the sibling's smaller array.

The assumption was true until commit 9677be09e5e4 ("x86/cacheinfo:
Delete global num_cache_leaves"). Before it, init_cache_level() assigned
every CPU the same global num_cache_leaves, so all the per-CPU arrays
had identical length and indexing a sibling with this CPU's index could
not run off the end. That commit made the leaf count per-CPU precisely
because hybrid parts enumerate different counts per CPU, which is what
makes the unbounded indexing reachable.

All three sibling-indexing sites are affected. On AMD and Hygon,
__cache_amd_cpumap_setup() handles index 3 via cpu_llc_shared_mask() and,
when X86_FEATURE_TOPOEXT is set, every other index via an APIC-ID window;
both do the same info_list + index with only a NULL check, and
__cache_cpumap_setup() returns early whenever it handled the leaf, so a
check placed only there would never be reached on those vendors. Their
leaf counts are per-CPU too: init_amd_cacheinfo() and
init_hygon_cacheinfo() both derive num_leaves from find_num_cache_leaves().

It is reachable from userspace. populate_cache_leaves() is called from
cacheinfo_cpu_online(), the CPUHP_AP_BASE_CACHEINFO_ONLINE callback, so
it runs whenever a CPU comes online - during boot, and equally when
userspace writes to /sys/devices/system/cpu/cpuN/online. It only runs on
a CPU's first online, because free_cache_attributes() never frees
info_list, so last_level_cache_is_valid() stays true afterwards and
detect_cache_attributes() skips to the generic
cache_shared_cpu_map_setup(). Holding a CPU back from boot with
maxcpus= therefore leaves its first
online for userspace to perform, in the order userspace chooses, and the
faulting order is the one where the CPU with more leaves comes up second:

	crosvm run --cpus num-cores=2 --cpu-affinity 0=4:1=0 \
	  --params "root=/dev/vda1 rw console=ttyS0 init=/bin/bash maxcpus=1" \
	  bzImage

	# in the guest, on an otherwise clean boot log:
	echo 1 > /sys/devices/system/cpu/cpu1/online	<- KASAN fires here

Observed on a Debian 7.2~rc7 KASAN kernel under crosvm on a hybrid Intel
host (Dell Pro 14 Premium PA 14250, Core Ultra 7 268V: P-cores enumerate
four cache leaves, E-cores three). crosvm evaluates CPUID leaf 4 per vCPU
by executing CPUID inline on whichever host CPU the vCPU thread is pinned
to, and applies --cpu-affinity before configuring that vCPU's CPUID, so
the two vCPUs can be given different leaf counts on purpose while leaf
0xB/0x1F still presents them as SMT siblings of one core:

[   34.736208] BUG: KASAN: slab-out-of-bounds in populate_cache_leaves+0x9d0/0x16d0
[   34.736477] Write of size 8 at addr ffff888003752ce0 by task cpuhp/1/112
[   34.736477] Call Trace:
[   34.736477]  <TASK>
[   34.736477]  kasan_check_range+0x134/0x220
[   34.736477]  populate_cache_leaves+0x9d0/0x16d0
[   34.736477]  detect_cache_attributes+0x323/0x11a0
[   34.736477]  cacheinfo_cpu_online+0x29/0xb30
[   34.736477]  cpuhp_invoke_callback+0x3f6/0x1530
[   34.736477]  cpuhp_thread_fun+0x3e6/0x800
[   34.736477]  smpboot_thread_fn+0x42a/0x9e0
[   34.736477]  kthread+0x3e1/0x4e0
[   34.736477]  ret_from_fork+0x8f1/0xcb0
[   34.736477]  ret_from_fork_asm+0x1a/0x30
[   34.736477]  </TASK>
[   34.745437] The buggy address is located 32 bytes to the right of
[   34.745437]  allocated 3264-byte region [ffff888003752000, ffff888003752cc0)

3264 is 3 * sizeof(struct cacheinfo) with CONFIG_NR_CPUS=8192, and 32 is
the offset of shared_cpu_map, i.e. the write lands exactly on
info_list[3].shared_cpu_map of a CPU that allocated only three leaves.
Six out of six runs faulted; with this patch, five out of five are clean
with the leaf-count mismatch confirmed present in each run.

QEMU does not reproduce it: it computes one CPUID set and applies it to
every vCPU, so under the same pinning both vCPUs report four leaves and
the mismatch never arises.

On bare metal that part does not fault, and only APIC-ID numbering
prevents it: the P-cores' L3 leaf reports num_threads_sharing=64, so the
sibling window is apicid >> 6, and the E-cores' APIC IDs (64, 66, 68, 70)
fall outside the P-cores' window (0, 8, 16, 24). A hybrid part whose
cores land in the same window reaches this with no VMM involved.

Skip siblings that do not have this leaf rather than writing past the end
of their array. This is the minimal containment; the next patch removes
the index-alignment assumption itself.

Fixes: 9677be09e5e4 ("x86/cacheinfo: Delete global num_cache_leaves")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
---
 arch/x86/kernel/cpu/cacheinfo.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 13ed16527905..3a1c10699646 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -502,6 +502,14 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 			if (!this_cpu_ci->info_list)
 				continue;
 
+			/*
+			 * The leaf count is per-CPU, so a CPU sharing the LLC
+			 * may have enumerated fewer leaves than this one.
+			 * Never index past the end of its array.
+			 */
+			if (index >= this_cpu_ci->num_leaves)
+				continue;
+
 			ci = this_cpu_ci->info_list + index;
 			for_each_cpu(sibling, cpu_llc_shared_mask(cpu)) {
 				if (!cpu_online(sibling))
@@ -526,6 +534,10 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 			if ((apicid < first) || (apicid > last))
 				continue;
 
+			/* Same per-CPU leaf count caveat as above. */
+			if (index >= this_cpu_ci->num_leaves)
+				continue;
+
 			ci = this_cpu_ci->info_list + index;
 
 			for_each_online_cpu(sibling) {
@@ -575,6 +587,16 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 			if (i == cpu || !sib_cpu_ci->info_list)
 				continue;
 
+			/*
+			 * CPUs that the APIC-ID test treats as cache siblings
+			 * may still enumerate a different number of leaves,
+			 * e.g. on hybrid parts or under a VMM that does not
+			 * normalise CPUID leaf 4 across vCPUs. Never index
+			 * past the end of the sibling's array.
+			 */
+			if (index >= sib_cpu_ci->num_leaves)
+				continue;
+
 			sibling_ci = sib_cpu_ci->info_list + index;
 			cpumask_set_cpu(i, &ci->shared_cpu_map);
 			cpumask_set_cpu(cpu, &sibling_ci->shared_cpu_map);

-- 
2.47.3

