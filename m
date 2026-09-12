Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65763A3809
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237910; cv=fail; b=dabx9F/66ut8m2Najv2zI5/s45IbYD1ItDBq8zhCBHxEuaPA78bFy/I+LOfwriA1PA9BmOt/ku0KZDr+uPtsrxXaSCWedGdbTUTT3YvI8JkZFrHhc28OIwOp/4HSWRGUG6dkPOGBsKWi2Y2c6FgMNAsr2inV/7b0/1RWKhO0KLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237910; c=relaxed/simple;
	bh=GsST2eupM36LC1GNcEUG3tLQZLL4PAfEOZISiA5Wrk8=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=KKXhL7fex1CQJbMicO/IsDq2SvCVgnv0qea4UhIAjtA3rQQf2EY94OXqRhIYt9nCHBFnORumqD6uTQkdmoT7YSWG+XwdICcuULPsxVPyjRLMdRtbIGRezWzYEtwuWCXkUA0ME7u4VQAac6l4axIZC1mPbfKhmpYc4m6XYwuc3Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K1j0GeF2; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K1j0GeF2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eb5olTlBta+tUVwoZwtMuvxNdy64sde924VrhA2xDvW14OUIGd3qbnMlzJJEfWShwtUEiJyZBZ6Vk1/BBQY3fFcPh+JOQsN5mwWpaQdqczPQJ7bhZFWs4IO8AHFIsE7YvldzpOzQqZkJVKnoysQkyguR+8WYuG6bxvN3+5CLo9MgzqFSC7YynDjdamEjO+mT//pjn6S3/tbbT+5SAeUWKHDzdXlQZxc8JScL68YG8RrVYpMYtAbu2AvQLH2XE3P+rRcznCbGHThSsyXtFPuoj58U2bgslNhDQQVnvmYAuQHnWghj0Q50q+55QKLAkpqVwmE8nfNWSYAeLhC5nDnJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsST2eupM36LC1GNcEUG3tLQZLL4PAfEOZISiA5Wrk8=;
 b=oNSg/hKjiWKnJ1sTQJdMdkWePP6K3S3f5ydLgZDvluWDOiMthR8eD62jH9TfK3X3HHZWyRUgjFS1puig7Rp4RID3E4djnd/3qhKGTChbucAI+IIpDtKBbmK9a9QlcriycRjVtQ02PY1OCjb/64tFuos19shOcqdWMBrv4mM4ieCx+JmxVsX4904K+XFZXDUtQ2YiQQ9OCKQiLhRCgKN4TTDWSUqqhg634PJDdiKZR/GAgIQEHiN+EvAWCdAQWFYfxz0xRew0phGdmlk4iUBU2qX0wYHZpPfidN8ydcJNYAwmbkCLCtY4ygrh6A9/UFDP99vooTpQ2qY48QdGR0g8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsST2eupM36LC1GNcEUG3tLQZLL4PAfEOZISiA5Wrk8=;
 b=K1j0GeF2ZPuwSbT6BWei/jWn0MV4sfOVgpeCtos/a5woTNnXPqHkO/8pn22b+hRi+ryjX9VVWNqES6NZdOuV8WSXhyIOyBZzRs+PkLxbx/i8BCkAvQb7egySS2Raag5tPXR2VpBC6M17ctCCYvYSVdgGHOyN79dcxm1jgD1PqMPFNybD98moKJ8UTAoj2R4s3frL1G6KagPAhomjJQoMw7QjkGlxRgJoz1FlavNaTNaAcNmRq3CIeBdy24Y72mlTB1oW/z+MUiylkUrPzI5BBSVpGMJv89q7gSwOwpWu6ioU0JEMFmrzY2q0Zk58+nktwt6F39yZwgOm44IWiKYsRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 18:31:39 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 18:31:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 14:31:38 -0400
Message-Id: <DLDJWF5NE46Z.3JBTVOKAYOYGU@nvidia.com>
Cc: <stable@vger.kernel.org>, "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Barry Song" <baohua@kernel.org>,
 "David Hildenbrand" <david@kernel.org>, "Dev Jain" <dev.jain@arm.com>,
 "Lance Yang" <lance.yang@linux.dev>, "Liam R . Howlett"
 <liam@infradead.org>, "Matthew Wilcox" <willy@infradead.org>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "William Kucharski"
 <william.kucharski@oracle.com>, "Andrew Morton" <akpm@linux-foundation.org>
To: "Sasha Levin" <sashal@kernel.org>, "Johannes Weiner"
 <hannes@cmpxchg.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 6.6.y] mm/huge_memory: use folio's memcg inside
 __folio_split()
X-Mailer: aerc 0.22.0
References: <20260904022657.2656810-1-ziy@nvidia.com>
 <2026-09-05-daily-reply-0043-folio-split-memcg-6-6-bounce-v2@kernel.org>
 <DL8LKM3Q9LGZ.DENNSVG6XK1C@nvidia.com> <aqMDyxhGXZyhcm5H@cmpxchg.org>
 <daily-reply-0014-re-huge-memory-6-6-ask-6-12@kernel.org>
In-Reply-To: <daily-reply-0014-re-huge-memory-6-6-ask-6-12@kernel.org>
X-ClientProxiedBy: BL1PR13CA0438.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::23) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 73188733-c405-4728-85a5-08df10fc158e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|4143699003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	qYngZiMypBQ91D+V3guoxAmsmJFAAKUkmNtIo7KUYMHLGMX42OtRHFMJe1M8GDHoa/GhZSJNEsQ4xi336UaqVKvOwojgEqS8sCdl9BVHX5OMjEHP0JaHIjHtvH+tGh285b2YzKTa5iCWhCIzW2T05Q2XP9s0aCMFhjthy7ARYAYgQv3WshBjM1YjAzd/u0s3xEe20wUaJUyoN/1pny7Wjh4qL4gKLcSK934jSxGEN8zaiFxsIWUOL795fnTVKR7el0hd6qgWz1UExaYrwDS7Gs3Uo+612PVOtKCD1yrDaVJW7zyrQvmfjWO7CFq84xoU/mqdqJmFneemgKrhD13xzjeTXLbcQt86/csjvWxCtdtNQq8gI3QPzgSYXjjKdKW4CfWb/x1OwJMCoy017QNk7AOMnSawdWCNbKGiDvNuSyZpUDkTCI0ifofLoMMq1ghGCGu9TqXNW/VJsudeHxMgDp0TJojaai2PTgqLFkleWL8UgTiuZBOQUkcp/xEdCpqtC7IkpfGqYPcUXHw++qBgkAYjNIT6Ywst2aZLkIDmqXoa8aW6cL5f2LWi6l6nlLLauTuLWGjAPX2wlTXzySkWOzVKAQoPsjTwcpj2lLCesdiPQOxZs3a1dWkqeFi7bxHgF6rOsIc8Py5dORBmz2E0x2ImWr8jSV27WHbi2FNc594=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFNHSWZ6b1ZBbGd1ell2OFhaekxYQTcwbm5JWjVjK3YrcmdmM3VwcVNYL0Ns?=
 =?utf-8?B?OVk0R1IvTndxZ01HM2tWNEd0Unpna0ZqRTFsZ29CWnNZUFlpTTQwQldsN3I1?=
 =?utf-8?B?VXBiR2grZU9kQ1REcmswTnlxc20weENJSnpYYmlRamZmcDRFQ00vZmZTYnZI?=
 =?utf-8?B?TUtOODl4N3BJZmRVcS9NNUNxNUlCVUc0MnpvVWxxM3lIZnZlUmZXNGErNGZu?=
 =?utf-8?B?MmhzVGU2QVh2YjloemZCV0xvclJ0SXFGSXN0TnNXdmVWb25ab2RVTmxnMkFo?=
 =?utf-8?B?U1N3eVo1dXdrOEpZRkJIR1Zvbml0ZExoYnJHUXRHc0hCcEJ6TkdBMnlhTHhu?=
 =?utf-8?B?Y1FmTm1tamI1WUZBcXhWK3NyZlppaXhmSHZIbVd5cnBkek5LbmdWTVRNWEZv?=
 =?utf-8?B?QTYyK1BZUGRDdVJWeTJURi8rSThvQnJHdUlSbTlYQ0xxYU9ZQ1VWbHdBZDEw?=
 =?utf-8?B?NmdTYnlyOE1JSWR3ZWlETzc4aFlQeHAwWXRDYVhjcDNqZFZQeXBIUEpvVnpH?=
 =?utf-8?B?bFpWbVc5UnZQMFNiNmFqT09xeEloZ1FGaE44V2xZR1VVczhpY2xkdnFCbDVn?=
 =?utf-8?B?bk1CeE4vNHJpRWdId1RtSGYxU0U4bXYreFBpTkQwQjJvZnU1VFpEZEhRc2d0?=
 =?utf-8?B?eVgvYi9YMkljdUZsNGtoeXNyMzFodWtXS3ZQTkJ0eURyUXVHVnBldTM0RHBE?=
 =?utf-8?B?anZ5aVVsbXdnTkNZS0pHZDh0OGgzSU16NFJFRVNpWFZrb2QvKzlOZEdzK2s2?=
 =?utf-8?B?aFRDWmMveXVRT3BNT2k5bFBJSEJFdERSYjEzZ0VCOUFaR3ZQaDV2RnhkSTB2?=
 =?utf-8?B?N1ZMM3k3Q3FlTXQrQzVQbmVkWWNUQmRoRCtHdnZ1YkVCY0dzYS9Wdmx4SXNs?=
 =?utf-8?B?UVBYQjluNk05aUsxYmNjQzNkT2pQK2JHbnA3UnVLaVl3UDkwbHZRbWFqUzZH?=
 =?utf-8?B?SXFaQmQrdHUrM0NWU3VqcG5ORy9GOXhpTnozRXJOY3NJdi84S0ltdGU3OFFH?=
 =?utf-8?B?cjlwTUxheDVFUXpOZjlpTG1zdUZzd1hEUEw1S29lV3pubDdYcC96N1JseWNu?=
 =?utf-8?B?UDZSNENrZ2pUNG1XR09wVE5vSERMRUpDejgxai8vMFBNUzFBQTdaNmhqTXox?=
 =?utf-8?B?WjNXZ3BEYytZbkN4S2FveUJVbmlIanlSRTl5ZHdyYi9SYXptYWxwNzdtbXZR?=
 =?utf-8?B?bjBlU0pKYmVZWE1RcnRVWEZCVkZnSGdlOVJnYkVMY3J5c0pHYzV2ckJtWUtN?=
 =?utf-8?B?a2pGODN1UjRKS0RMbXhlZ0xjcy9GU3ZOUldxZnpnZ2IzdWZjdnFmODR5bENI?=
 =?utf-8?B?MVVKRTZhVG9MS00yeDF2Wnk3WUdGWDZQcUVNakR6SVE5MWhxQWliR2ZYcmhI?=
 =?utf-8?B?cC8vTkF4SmQwZ0d5TzJRZzJqWVBCbGpnRzZKTXg2T0NPN2RydVRNYzhmcXZN?=
 =?utf-8?B?S3hlUGZSNmNJbC8zZjI4c1pyenZaTXNTSmZEN2pvQitxYW9oK1pzVk9Ed1hq?=
 =?utf-8?B?b0dFNUkzV01acVhkVWpyaHNUanI2UDc5M3RMNStHeFk4azBlaXJzNkE1cFQ0?=
 =?utf-8?B?YUd1ekhCY1R4c0hUNnExWk9oM1lHOWRMQkVSeEZBSlhuU1Vsb0FMQjNNVy9E?=
 =?utf-8?B?czd0NHNkbXNySHlHa1UxZDhCSlc1azR0eUlwSkRudWZYczZsTWFua3FGMC9X?=
 =?utf-8?B?cUVUMzRLbFJDZmZHWVBMSG1yUFBiNGNFdkM4d0RWUjMxQ0NVWGp0KzNtSVlS?=
 =?utf-8?B?bGNUQTBDUzZuUDRtM0NOWkttTjFsbGhDcHJrU25FcExQOXpkUFdBcVJVVGd1?=
 =?utf-8?B?Ny9wQ0N3bkN1UHBBRGQrRHV0ZkZQWHViU3h2NnovSDZITytmQjFNbk1OdnF1?=
 =?utf-8?B?T3dNMUZ3K3ZEckdMMzF3OFNTSm5pNFZiMkZwZHJHRUdVWkZRV1hWMXhYTVRZ?=
 =?utf-8?B?eDU1ZHF0eUNFcWZXdFRsZFFaYU0yRTJ4TXRYUVRidVl3dWlXOXJTU29VUU1T?=
 =?utf-8?B?dzR3cjY1MVc0TDh4dVNGdjFIZlpxaVliaTIySlU1VnVRQW4wOVlZS3o2RVFX?=
 =?utf-8?B?dDVrOVRWRWpxejVPOGVCWFdhME5xc1BjTDBMU0JORFZpTjYzUHhtZ0U0TG9D?=
 =?utf-8?B?TUU1bDdwamJNaDcxNU83TVFVV0VnVVpCaEFnRDUyS0d5ZVg5eExPdUxmRTlK?=
 =?utf-8?B?ZHBWNE8yaGJha2NWS0hscVlCZjBMOGovTkh0dmhvU21OMGlWcHp3SE1rVzF4?=
 =?utf-8?B?VEJaWDd0dGlZaEdFSlJ4VVV4aUpTTDFPYU5EaFpyVkJTZWI1ZWV2TTU4eE1t?=
 =?utf-8?Q?wE6jqep0tYaXki4Wo4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73188733-c405-4728-85a5-08df10fc158e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 18:31:39.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RILKA+ud9cbFjJvpXYHfqOYNhxWQ9I8SYmk4MOY/AApJnbjGNFRQwnSwqsmg7C+D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610

On Sat Sep 12, 2026 at 11:26 AM EDT, Sasha Levin wrote:
> Thanks for the review, Johannes.
>
> I'm holding the 6.6.y patch for now, because 6.12.y needs this first.
> c299a2285d9d ("mm/huge_memory: use folio's memcg inside
> __folio_split()") is absent from 6.12.y, and we don't queue a fix on an
> older tree while a newer one still lacks it.
>
> 6.12.y also needs its own version rather than this one. I tried your 6.6.=
y
> patch against it and it fails at mm/huge_memory.c:2646. The two trees hav=
e
> different shapes here: 6.6.y has split_huge_page_to_list(page, list) usin=
g
> XA_STATE, while 6.12.y has split_huge_page_to_list_to_order(page, list,
> new_order) using XA_STATE_ORDER.
>
> Zi Yan, could you send a 6.12.y backport? Once that one is in I'll take
> both together.

Done. See https://lore.kernel.org/all/20260912182926.1326147-1-ziy@nvidia.c=
om/

BTW, I see you also sent one[1], but it seems that it is using a
non-existing get_mem_cgroup_from_folio(). What is that for? Thanks.

[1] https://lore.kernel.org/all/20260903223027.1739434-1-sashal@kernel.org/


--=20
Best Regards,
Yan, Zi

