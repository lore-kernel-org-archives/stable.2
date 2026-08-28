Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAFA15B135;
	Fri, 28 Aug 2026 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875367; cv=fail; b=RcnFFvWPs8SHhy9vCWTYhVFXKHlh6vNvgrHN+4HG4Vz5o2mo25K8WInL6ZzPtvL02AdusUIRGdngBDCms19Zh9uBAjEZi5Ip6G84FeYWueKUGYUNXzSifl+fZ+Q1kjCaeodY24pqkXQFySetVSD2coGt9TDv8S86p+t5w87aGC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875367; c=relaxed/simple;
	bh=ChBQ4PrZd1BmhzuRc2FwkzsSE2bZoALXpKXkcbpXrDU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:MIME-Version; b=JnlSNKE/i4z28aNzmueAskWcnD5MWs6w4xWhKygeA9P6mdRX1LKmf0ie+DWQ0XbEmIM1Njrwp+UqKecxFBpUp6iN7PYV+ThC+UbB2bZ4MnP64rW6RO2ZWiWLz2GaCKU5gvBPmltQ4U2CecGoI0cbJDDv/jdO4LOwgKzA/tCZVZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=0mIN1OfS; arc=fail smtp.client-ip=52.101.72.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="0mIN1OfS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uATrro2piG0dkoXev1KsRWSd2H+lYhORCQk8XrziF/VQ120FKOQGfN4W8MF0xoCmKpg3Mc761cG8gz+9hraw104HRznML0lPzEYslIBTPSnpPG0+Hg0DhG9fJojiNX9eij1zL+0GovW9Mqc8A7k2kHbt/BEYAnmEBJzui3BsqS/LCgibXBsK/+6v1Ni0fc6so/TJbXYXR8DbY/OIzxaRvYxATm4eP0L43hWywa2fMYZO3r6TBgSIo+BxnLjQc9zf8SnHwJC1AgVLTHaSV+G56g81VHcMOxvR+a/nAWhHi2XUh5gS/Gi0b4ohPHb7o2zCPaiZEk+WGCrRNeetFCWNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RILUOsJp+NBL9t6hqgfdl92226ovRTQkpin/pKlrWy0=;
 b=dgVIQfY+7uMJE921ilDfjg0idgH7P+29orM6LlUzZ1sAx1n5UC1TUQ4ieAkAXvdJ9sw+13+yum5XWGI8Kh4QFMIlnncVt8RSrAPBD938pmV6CzirR+nhACMosukvH2Rt2CIeAfa1AbbMxmneDxBX3MjR3BZk3MqU6OAlC15B+6OKzKHqIf3sclsGM9XbdxmIG2IVq2gVqNY7zbFCN0cQrNlM1KRPQUPC+MUzSk8KDqavQKhdD3X6w6UVo0hRcqpMi/Gm051FrKgFHonc14f1inPL0dwNMPRYddt3MW5JrYzEAyHP4bjLzrT2mdB4hRmhDiWjj3PyXbiz+bHxQopWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RILUOsJp+NBL9t6hqgfdl92226ovRTQkpin/pKlrWy0=;
 b=0mIN1OfS/vEa8b1pYuBR2Psfs8inanT6bKC8Am4c3FTvi35N0/06qh1redHRPyFwkHSt96tIB0Q9GvMG0TvNFF0qk+3ViyLSAWVRI36EmIB+ayaiX/VHaQU0F/CiL57Zmi88Y2b0tGEzHEci42D9q9IRrKuUsGg4h4TtTlNigNGw72sVlBgQmx91UlC1jNs7TiJfSVe6QPTDEJdB2BOkvRUdR+EwwfjW4zOgm48AnRzGmmOr0RNhxkPPX96gx1KGw+vcHGX5FJGAmY07hnnFEHC2d3XgjL0/VOMv0qjq/psmq7RybEq0hCWtRSbuGgtaIS0AS/xBCvyV1f9guE7bew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by AM4P189MB3487.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 00:02:44 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 00:02:44 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
Date: Fri, 28 Aug 2026 02:02:10 +0200
Subject: [PATCH 2/2] x86/cacheinfo: Match sibling leaves by level and type,
 not by index
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-b4-cacheinfo-v1-2-87b01de56658@est.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787875355; l=7520;
 i=yunseong.kim@est.tech; s=20260824; h=from:subject:message-id;
 bh=ChBQ4PrZd1BmhzuRc2FwkzsSE2bZoALXpKXkcbpXrDU=;
 b=Fwt9AHCEW5UEeZBMjfiXZg6T+yFOhIE6AgEvjwT+aFvG+0S7jXkH4HD+IZ3WixKJlxQu/14da
 6xOOKVWP2GoDRf7mGqMzKs/14w5ZUSOk/tPQAfz4zJFXNb45be6gb/2
X-Developer-Key: i=yunseong.kim@est.tech; a=ed25519;
 pk=nfdmjNawkxBHo9UNdzLNBEht8sYmXp0MYUsa/hwC7vw=
X-ClientProxiedBy: LO4P302CA0045.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::20) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|AM4P189MB3487:EE_
X-MS-Office365-Filtering-Correlation-Id: 753ef2d6-bc03-47d3-831f-08df0497af81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|366016|376014|7416014|10067099003|921020|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	q+2TqlZVAvy0kyDjL6k9Ch9SCs7g/byAiKs7VFFJpedpiMFbn6a54H1Cta4oq4wtg4dhZJLGqb2j1BCHh1HJsrrCtwIDGvCHu+s+ICgy2tuyEZR1v089FqgGPNYweyAijVZacKmZzeUqgwCjzZd84/UntAN4bFbM4zM/dMjA8WFq+2Z8q0ibRgDs0f1HMcqBIqN/jqtX9g8nn+tbHThNMV+UcBtcRd92bNBCWpBLDeutXN5OTThkhsadJv+ZPnqoqykYRFXwNVDbB2SMqlwcDcAYLxsu6o82/cPpiQs5n+1A9L8+GK40rtuvkipvRUxGlWWWV6gZy8GfYKs9MlqnQK/bXoxqPVvcEZG9zWPWJnD7q9Wx8n767ZndDQMkv/og3UBRt59BxB52ZaugfjBig4LTWvBZMEzSqQZmvaB5SjX5aqxxiTIsimDKfqX4veU//01kmnm+MX/dw/r4XhDa6JTuQO4wF8hixYU+YvZ0E2yAajMWdsHZVZSMuWmTjsOZYidIlVcVA4ygzQfJFW2G7AXeX/BW5sv5Kv4V6uj+PzX3VqIBAHRL3q+21Z15wjhX+AzT6S+Jh72mAc+Jsl9e88KW4jjwbV73z8y2/+WnHEf6CUJnQAKoescZHOAm1jjMXwEGKBPafK7fuEb9ILo1au/p55A2fqiGwzJY37VEek8Glq4ENB8waBS0ZJZn3X26BM7STKP+VJcbcAiKur+FLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(376014)(7416014)(10067099003)(921020)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWRjdTRjSWZlTjdwZk50OTlFQUJNaFFPeDJYbSswRk1pNFZxQnR3clRPNGVv?=
 =?utf-8?B?eDdyOUNnSW40alBEOHl2Q1I1ckxwWWhaS2ZjVmRMR1ErREF3Z1NFN0ltU0sw?=
 =?utf-8?B?MWVFWXhYS3F3YTRjVTlyOSt2SWFROU5PZWN0b2QrS0RuT29yQjFnVFh4S0Y4?=
 =?utf-8?B?SzNyU1U2NnQ3NFhyeWxsSktXN2EwR0F1L09OL2ZCM0hONlg2K1pGNEFCanpS?=
 =?utf-8?B?NWJIUnZoWGJGTTBiemFWSTNsS0pYZE1HajllWHI2dVMwWFc2OEZzVTJCZnA5?=
 =?utf-8?B?UjcwelIvUHp4SlNmNEF1R1gzNGNmWm5EcU5DaFZySVFQQ0RzU1dOYUk5UGg2?=
 =?utf-8?B?N3pycW94K3dESEtFeUs3RkVPQktjVk5xaUJSbVVjbjhjWjJjeDJjMWFkQmlZ?=
 =?utf-8?B?WnRxVlltTXc4YjVJRCt1YXdFTC9DRXh2a1FiSVBERFhtVW1sSFp3RkdPWVZy?=
 =?utf-8?B?ajVrdDV1YkVWOHMycUVDMUVUbFRQTTNURlpENEdXcHBueHp0YXhEcDh4UHFV?=
 =?utf-8?B?azQ0ZSs2aVVOdHBRTVowdEFIYkVPcjdQYmZKVTJqd2pLamwyenhLTks3SFVO?=
 =?utf-8?B?eExrVkg2Wkdtc3RCRFdFRUw3TENWV0kvakdMQkRScTdZUjVpZ1RNa0wwMUR0?=
 =?utf-8?B?ZTBHaUlWZnR5SFdJWVo0ZkFUdElGczZaSThrM2VUWG04MjRpWndYZWpidHEv?=
 =?utf-8?B?UWhEOGZCMndxckhiVktjNDVUYVFWRkIxTG44ZFdFMGtkcGRoZ1NNRTc2TmFx?=
 =?utf-8?B?ZVU5MFA3dVd4czVOTU1BMDRodGV0Z1RjbzVPWkVhaXFUcS9ZdGwwRUxrS0gy?=
 =?utf-8?B?WXlOMFNiZitDMXQ0RXdmdHFnMFJFbUZXdjh5bkc3d1FPYXJOZ0RsbjVUU045?=
 =?utf-8?B?cnJRZjNKVmxOSFBpQUpvTDdJdUxQZGc4SGhVV2RZZnBHOGQzaUVpRzJqN2Uz?=
 =?utf-8?B?Q3NrWlZQVzRxaUJ6cFB0WjViNFFLQ3IvZjNrbHFIMFJmRWR0bk5RNUFaZDRU?=
 =?utf-8?B?RE92SS9DUC83eTRXeWFFVVFhanFwbTRMZ3hIcGRpTGU4NU1nUlNLSCsxODdC?=
 =?utf-8?B?ZUNjNVJUMTZsMDRCdDFDcFhyU3ZvRk1oZktzbmV1RWM5R3gwK1VVcDNzZGg2?=
 =?utf-8?B?WkYwdzExcjVtSHR5QnNNa1ZJUWc4OUVaTXprUzdNVDlRei9Hb3M1bWIrZG85?=
 =?utf-8?B?dG91eThKRzczeFFQUm1mVC9DanFLSS9xbklCNWZjUjFlNnk3azhPQStYUy9K?=
 =?utf-8?B?UjVpNTRTM0xVM2NmOGhGVSs0YVl4MVRBQ2c0ZUk3KzJoS0Z0aDBReEtGWUhI?=
 =?utf-8?B?dXFyYU1nSUdMWlJ5ejZiUGt4ZXFXdkpPQ3VKeFhNNmVMdzNRR3ZvaGczck9t?=
 =?utf-8?B?WjkrUkVVSW1TY1IxUGNJbExBNDZudEM4REFjaUh2NVU4b3dXRi9MNHQyV2FC?=
 =?utf-8?B?TzBRWTd5Smh5WjZRek5aQko3SVpjSjRLd2tYVWdoTE85NkZCVDNWQmMwblFH?=
 =?utf-8?B?ZVhPUFQ4akkrOFNwYzd1bWhKalBpdlIzNm5IUWhpTStnRXBlaXEzU0Fvcytp?=
 =?utf-8?B?VzIwd0dsOWJIbW5TTUd5b1B3TFM2YVBNZ0Q1QmtwNk10R2lXZG0xMHh1MElz?=
 =?utf-8?B?Y3VuSHlzMTlsbjEyYlFQL1ZXYmZMUWUzSzFmNHdJai9pNmU2Y0NjUzhMZTVH?=
 =?utf-8?B?OTAwRE43enZUZ3ZQYVlKWjdUTUoxMnVkRXJLTVNIVzRBSHBGQnByemRPY3lD?=
 =?utf-8?B?ZmlsWEtzN2tMRXBwdG1iL0Y0TzBFRU9jWDIrWm9OYWl6c1Z6K0dvdFVHbmxk?=
 =?utf-8?B?Wk1oK3JBQ1N3eTBtR2dBdkd5SFZKRmVzRUNodHM1REI5OC9OZjF3T2M0L2xN?=
 =?utf-8?B?SnJ0RmdWbzJFamZNVGRuNEFvK3dXUzJnYVZROXl5NzhDb3hac05EUHJCamM0?=
 =?utf-8?B?czFnQ0ZleXdtOXpkZTFkUU9WQ29vbXhTMlBnK2RYUEpUbTU1WVJJTndVa1JY?=
 =?utf-8?B?RERnMG9GR3V5SVJJdUliTk5YNG1GRS9zM3hETDdmUWlXeTF5QmVmOWhFYnh4?=
 =?utf-8?B?ZUd1UzB6Z3hvd0JKUDd0NzdEK0E5WlVEOEhPMThJb3p6MkVmdFlEYUFEeVpa?=
 =?utf-8?B?aGNKcnBsczhLZ1NmMko4cll3M0VDQ2xQbmxDYlJ5R1RiNHJ4Y0xOQ2FCSDZr?=
 =?utf-8?B?elQ3c1U4OFhzbmplNHVQY2xrVi9FWW5OeUhQU3VISCswcEFyZlhsR2NlbHBh?=
 =?utf-8?B?RkRWYXRqSDBCSjlLNFNQQ2txbS8vNXZoUlQwZUJiTWxQRnM0Q056TE9ReDYr?=
 =?utf-8?B?QVQyREJRYUx4bkhaUjl5UXN6VzUzVFQweWQ1a3NPM1ZnRDVBa1BKUm5Hclhy?=
 =?utf-8?Q?LPfDXW35fBI5HXjf2I0RyJ9OXqIL+jXHcIcI20vwIULWJ?=
X-MS-Exchange-AntiSpam-MessageData-1: cGAlWb5CwifCdA==
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 753ef2d6-bc03-47d3-831f-08df0497af81
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 00:02:44.2133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWrGHqCBJbz293ptBkCtLLtuf739RDiFAXDddpX4WBHp3m7r3tfHtDqIKalFgmyNw8VbuDz1VHTtu5XuGY9Uvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P189MB3487

The previous patch stops the out-of-bounds write, but it leaves the
assumption that caused it in place: that leaf index N describes the same
cache on every CPU the APIC-ID tests select as a sibling. Bounding the
index only handles the case where the sibling's array is too short. When
two CPUs enumerate different leaves but the index happens to be in range,
the code still cross-links whichever leaf sits at that index, so a CPU can
be recorded as sharing a cache of a level and type it does not have there.

The generic implementation stopped doing this in
commit 198102c9103f ("cacheinfo: Fix shared_cpu_map to handle shared
caches at different levels"): cache_shared_cpu_map_setup() walks the
sibling's own leaves and matches on level and type. x86 keeps a parallel
implementation that was not updated.

Do the same here. sibling_cache_leaf() looks the sibling's leaf up by
level and type over that CPU's own num_leaves, which cannot leave the
array, and returns NULL when the sibling has no such cache - so the
explicit bounds checks are no longer needed and are folded into it. All
three sibling-indexing sites use it, including both branches of
__cache_amd_cpumap_setup().

It also removes a smaller hazard: allocate_cache_info() kzalloc()s
info_list before populate_cache_leaves() fills it, so a sibling can have a
zeroed array. Indexing it by number wrote into a leaf describing no cache;
matching by level and type skips it, since a zeroed leaf has level 0 and
type CACHE_TYPE_NOCACHE and can never match a real one.

No functional change on machines whose CPUs enumerate identical leaves:
there the level-and-type match resolves to the same leaf the index did.

What this cannot fix is CPUID data that is inconsistent in the first
place. Two CPUs presented as SMT siblings while reporting different cache
geometry still derive the same cache id (apicid >> index_msb), so they are
still linked - by this code and by the generic matcher alike. That is
wrong topology from wrong input; the point of this patch is that it is no
longer memory-unsafe, and that a sibling's array is never addressed with
another CPU's index.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
---
 arch/x86/kernel/cpu/cacheinfo.c | 82 +++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 3a1c10699646..1024a6697d0e 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -482,13 +482,46 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 	intel_cacheinfo_0x2(c);
 }
 
+/*
+ * Find the leaf of @cpu that describes the same cache level and type as
+ * @this_leaf, or NULL if it has none.
+ *
+ * The number of cache leaves is per-CPU since commit 9677be09e5e4
+ * ("x86/cacheinfo: Delete global num_cache_leaves"), so CPUs that the APIC-ID
+ * tests below treat as cache siblings may enumerate different leaves - on
+ * hybrid parts, or under a VMM that does not normalise CPUID leaf 4 across
+ * vCPUs. A leaf index is therefore only meaningful on the CPU it came from:
+ * index N need not describe the same cache on a sibling, and need not exist
+ * there at all. Match on level and type instead, the way
+ * cache_shared_cpu_map_setup() does in drivers/base/cacheinfo.c.
+ */
+static struct cacheinfo *sibling_cache_leaf(unsigned int cpu,
+					    const struct cacheinfo *this_leaf)
+{
+	struct cpu_cacheinfo *sib_cpu_ci = get_cpu_cacheinfo(cpu);
+	unsigned int i;
+
+	if (!sib_cpu_ci->info_list)
+		return NULL;
+
+	for (i = 0; i < sib_cpu_ci->num_leaves; i++) {
+		struct cacheinfo *sibling_ci = sib_cpu_ci->info_list + i;
+
+		if (sibling_ci->level == this_leaf->level &&
+		    sibling_ci->type == this_leaf->type)
+			return sibling_ci;
+	}
+
+	return NULL;
+}
+
 /*
  * <linux/cacheinfo.h> shared_cpu_map setup, AMD/Hygon
  */
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
-				    const struct _cpuid4_info *id4)
+				    const struct _cpuid4_info *id4,
+				    const struct cacheinfo *this_leaf)
 {
-	struct cpu_cacheinfo *this_cpu_ci;
 	struct cacheinfo *ci;
 	int i, sibling;
 
@@ -498,19 +531,10 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 	 */
 	if (index == 3) {
 		for_each_cpu(i, cpu_llc_shared_mask(cpu)) {
-			this_cpu_ci = get_cpu_cacheinfo(i);
-			if (!this_cpu_ci->info_list)
-				continue;
-
-			/*
-			 * The leaf count is per-CPU, so a CPU sharing the LLC
-			 * may have enumerated fewer leaves than this one.
-			 * Never index past the end of its array.
-			 */
-			if (index >= this_cpu_ci->num_leaves)
+			ci = sibling_cache_leaf(i, this_leaf);
+			if (!ci)
 				continue;
 
-			ci = this_cpu_ci->info_list + index;
 			for_each_cpu(sibling, cpu_llc_shared_mask(cpu)) {
 				if (!cpu_online(sibling))
 					continue;
@@ -526,20 +550,14 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 		last = first + nshared - 1;
 
 		for_each_online_cpu(i) {
-			this_cpu_ci = get_cpu_cacheinfo(i);
-			if (!this_cpu_ci->info_list)
-				continue;
-
 			apicid = cpu_data(i).topo.apicid;
 			if ((apicid < first) || (apicid > last))
 				continue;
 
-			/* Same per-CPU leaf count caveat as above. */
-			if (index >= this_cpu_ci->num_leaves)
+			ci = sibling_cache_leaf(i, this_leaf);
+			if (!ci)
 				continue;
 
-			ci = this_cpu_ci->info_list + index;
-
 			for_each_online_cpu(sibling) {
 				apicid = cpu_data(sibling).topo.apicid;
 				if ((apicid < first) || (apicid > last))
@@ -561,16 +579,16 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
-	struct cacheinfo *ci, *sibling_ci;
+	struct cacheinfo *ci = this_cpu_ci->info_list + index;
+	struct cacheinfo *sibling_ci;
 	unsigned long num_threads_sharing;
 	int index_msb, i;
 
 	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) {
-		if (__cache_amd_cpumap_setup(cpu, index, id4))
+		if (__cache_amd_cpumap_setup(cpu, index, id4, ci))
 			return;
 	}
 
-	ci = this_cpu_ci->info_list + index;
 	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
 
 	cpumask_set_cpu(cpu, &ci->shared_cpu_map);
@@ -581,23 +599,17 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 
 	for_each_online_cpu(i)
 		if (cpu_data(i).topo.apicid >> index_msb == c->topo.apicid >> index_msb) {
-			struct cpu_cacheinfo *sib_cpu_ci = get_cpu_cacheinfo(i);
-
-			/* Skip if itself or no cacheinfo */
-			if (i == cpu || !sib_cpu_ci->info_list)
+			if (i == cpu)
 				continue;
 
 			/*
-			 * CPUs that the APIC-ID test treats as cache siblings
-			 * may still enumerate a different number of leaves,
-			 * e.g. on hybrid parts or under a VMM that does not
-			 * normalise CPUID leaf 4 across vCPUs. Never index
-			 * past the end of the sibling's array.
+			 * Skip siblings without cacheinfo yet, and those that
+			 * have no cache of this level and type.
 			 */
-			if (index >= sib_cpu_ci->num_leaves)
+			sibling_ci = sibling_cache_leaf(i, ci);
+			if (!sibling_ci)
 				continue;
 
-			sibling_ci = sib_cpu_ci->info_list + index;
 			cpumask_set_cpu(i, &ci->shared_cpu_map);
 			cpumask_set_cpu(cpu, &sibling_ci->shared_cpu_map);
 		}

-- 
2.47.3

