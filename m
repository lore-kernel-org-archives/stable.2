Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794498396;
	b=Cf+RHQMsqUh1LSJ4e+T/j2gYzZlYdwn5NWtOS6w9hG1oXPS38hapu44Y5YDHRz3XYXN8
	 5LJpMo6AZxHEq4k+X7t402PvSSeAled5pZc4tZ1ez3X9YtiIhV4UB9mKXe8in2y4MFQc9
	 xx8TrsiSTLqcG2L+zklFMTMM8KGPR9iavd5HO2MJ1Upf3oVFsxI7glMlLR0hCfShzdy2D
	 fc0scdflIMhBSmnWMsGiZEATrBnMLwQzK60+DV03fwvK+TeGlKFqd2Wjw2lmqEpR84/2g
	 tQ6hoWxsBoU+aZeLsJXOOA2yyDnaBaAdEsHTWQr88LYAfC+8ADlUj2XeAJkyorldcuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498396;
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
	bh=fNRuI0yw5oTmDruCQs0gEZGqZ+rbKLZX69uLttgRUUw=;
	b=ymFru1lR1OtW5QJrlRrVBYUtVfj63vGzNpC86iFQY/XuOfNbgvKPvmv2AjESIi0aVFTZ
	 rpXGQmEJEWsMPamGv2tMv9X3UIfu488IrGt0ui21CMrP0HFcMM8p0VGGoV1r+pYNWFaIK
	 KyLy/ZVFfQY02mUdDjCh6OMIwW0EbaLkJhPu/SPLQryg/8bnKsasydy9jquubUDZFRrU/
	 XjGHOYMY/n8nMALUmz9IYx4xNpQyqe9uwROY0gxmPlqntHbTIYwrmLp0JJFr7CP13CFOk
	 ODH7iYduThA7k3eFH5T0q9rraPRkXCVFX2/2pjmGolL6rIixQ1Oid5puXfUJAHDcwwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AUAkr9sT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.41
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E4C606A31C;
	Thu, 12 Nov 2026 15:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35E4C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AUAkr9sT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd3N4LfOs6u11e6GI9cGKclZ1sMlVx5F+hsXwHzoS9N4BgB1id+B3cJspz4+93Z9joAKziC06s6X09Y0n44e9rPMpmmlRayJTpBLnWeblMvoSEu8n1USr4DFLfPyYzf8TkoUbGDde0rq1fNVN9gImrjS8HkaIDIfQZsJJJ4LJ65UNUMR0G8Q6kI0QvBXXIHSBPpwZJmp4PQGjqeNd4WtgPf19RUhasCe3dV/Ln6mSseEVS+o9G1Ln3+cWufh/S/FH7daLm0RoWGLzz+PQn6/GnJJqO32hNTGNq0r2jk4FrguTa/YSdllHPXTssr4sOXRz4lA0c3v3i8v3n90A4wOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNRuI0yw5oTmDruCQs0gEZGqZ+rbKLZX69uLttgRUUw=;
 b=R4j+Emt0HjSimoLxEfdErKfgJXAvgH0kp8L7NbHvp+xwREHONVdbu6C8He49RF4dxGkV70zV/AOV0pXMGfOByqfJDqA88B+F6+PspTX4O3i1PzL1c1C6wVFocbW6M61s3wiu6fL5BDbCmkUAL4QcizYam1gAmgzzfh7w14P9PniXO6AftqBE3he0PyK4BN00AS+A+DNHsLUPNoFsDOIoJurIBEmX32i7LBcuuLYORhbc1nOMFlgTrYP/k2E9iJd+xXGXG72cSNAHdlJd54vg3C0m1wSWLozreUVDDOz35953xsLYhy/ABfZ7Gdwn8h0AjKjw3r9vD9mu75t81sAo8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNRuI0yw5oTmDruCQs0gEZGqZ+rbKLZX69uLttgRUUw=;
 b=AUAkr9sTNUUBkntrVdYH2vT893JgJBBfQed5nSK3e3PVGTx3+9PRlxZEM7RFimNE7QCk5VIt4iHhH/SgVetr939mEt3AbsgMfsjYbE2ZqZPq0LrX8s7ScZoH/tt3reAYGJ4Hqlnk7alx/Wt0vyxyzsSIRe4lu369yKPVqN4P4Ud50nr2eKAjUpTiro0KsJ0omrOpeBobxtXAYh/YBnmMA5x0HaQQHh6UVsm1kiCGGgzrGzzTf5l+nHw1myzQRQjEkUyFMTFRTWD/iqOtmX+TNoItNlatee8eFJFFdQW+oLV9zU72li1+JScb28zJt7a7bQtGOFrUz31NuF981X2+aw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SJ0PR12MB6944.namprd12.prod.outlook.com (2603:10b6:a03:47b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 15:46:20 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 15:46:20 +0000
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
Subject: Re: [PATCH 3/3] fs/proc/task_mmu: account device-private PMDs as
 present in smaps
Date: Thu, 12 Nov 2026 10:46:13 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <72C412EB-06A1-4880-845A-EF6B78D2B957@nvidia.com>
In-Reply-To: <20261111113904.650722-4-usama.arif@linux.dev>
References: <20261111113904.650722-1-usama.arif@linux.dev>
 <20261111113904.650722-4-usama.arif@linux.dev>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: CH2PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:610:58::21) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SJ0PR12MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d3451e-d86a-4201-4668-08df40d4188d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|22082099003|18002099003|5023799004|11063799006|56012099006|10067099003|4143699003|261102123227099003|261026121527099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	eLAVQL1LjkFjXJUtjVUZSc0lQxL7sWOmI/82z9LdKQjv55QZBwvBcFOQ5nVjg9DOgvh9iicaSs524CZ34/9XGMqhfoyDqCIEvf//PNY65Z9KE+nurLmJcNj/pUqqoQYdqcyqaLMERqfm+LmL4mywDqN6uo9MQRAJB8X4aSZh4EfUXspL3MQb3cr8Aqv6haAZ7aaxVp5n+sqmbJXob3iDZlfaRBX+lKWtg5+1wQnvXmTwV/DjXpprksqxN9tCVy47FZtVwWaRXqLW5nZ2YlxupooCEcnA5yA478OZXeLV7CyhEJLi4hx9fqMcUwYtDW+pVlUu4WfDZlK4lD3qnZzTjkY1JGKKERiP1xcjZqEjcM7ptIlFQQSzcNmfnqj1i452GkvoTPonyHHcg9xgJu7n6PcNCIbVXDau3ZOReQBdfWNuC47p06D1bzNhJgLgVxXOPFf34Qj3wxHREsJxj/cJ4R3E4qajH8lxD9dwHmEQD0LTfT/dk/KWBRqNAqiHzbYC4y4E1bYVdXsvs4Os8OWXTF0iCmhtxdHLtE7jVlbwztDXpqYjEesO70jMiXaICcg3cExRCcO/XhGhHXy8CqzfC34e6rsu5epwfYENYLgXl6aleksLfV3kqh812m041RaZ/LujstgIUQp4afuGSMkml2EcfXvBafSV3GB6f2p3cdQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S4XR+gX7U6IgwIgsb8shHoQvj4Ji9bdJnp4jazqIywjVZFY37l7qFLzJTiCF?=
 =?us-ascii?Q?vuVmBZgRmAVaQIGoT0EUnfKeQSQ8vXSLKwOGPmEikKvK7dnOvsDh0j6TBk1U?=
 =?us-ascii?Q?DmWmGC4z3IzJy/LwVLgS0ZGE6+xXCN746HmbAIRzgBoj3KC554f+/EC482Qd?=
 =?us-ascii?Q?kHz0QUZ19hmnhSWDMVgTXGGTWeVj2RR2LHG2z8YzaVo4rS5MTWni2tS4HptY?=
 =?us-ascii?Q?HThOVGtXaoEFSUHhxeADLTQg0HK0RIC85wEsCaIbrQXNdKZFMrevFwDcW8nI?=
 =?us-ascii?Q?SyN2rsmQrKgtYPLFsTDATA3wv9JMt359m31XCiuE2yM98qilFtM9FdS0QHpq?=
 =?us-ascii?Q?TlHeDcQWHeOZpDiqMJ2b8w1EQJ6vHL3kcTs2rK8qN3rC9P6BJTbTsNpbwau0?=
 =?us-ascii?Q?ZqEAlV9YJiteTfkTxidJFcJ1sCNeC8x5dRgdXMxavFjTaQVS8sq5l4JcfJkb?=
 =?us-ascii?Q?V5FvSESNBHhJZr1C41iSqcTZ9RxFOFhkPK4vpSaZgUofOhzu8REOCEmk9Ahq?=
 =?us-ascii?Q?20TqeChYXpPOcp8mMH0vYheUPhgU1GzvtDAb2REaOtbpOYuCR4S1nK9rau4P?=
 =?us-ascii?Q?/zEK5jTKkbjI2DTzrA+L4Xotxh7wPcBjHWcSxUFEvOEpCAgfhn1zNCw2wOon?=
 =?us-ascii?Q?Ytf8dMh1ib20TtS075Mg6Yy/2uSqeFzoWvDZt0RQPfPaa4woHTGJXSniVPLy?=
 =?us-ascii?Q?8z6lDH5LJwGrc3YhZejlUpKvujoyL1F2TajvKYddb00fx7tloFkmLlIrIh1m?=
 =?us-ascii?Q?zm76gdnoPKfd/eC2CfxIZ5AjZ+osUJYFf5WjnouP4d0uAD7hSWRfDPivSZbm?=
 =?us-ascii?Q?haCNO7xAfRa4BjMI2VQX1IA4yrhbvUhtqSlqdEQwl8Zt8cvG5iVfYBJceMZM?=
 =?us-ascii?Q?3riKIXSUnrOtKhjXmWAB/L4XoQWlEPySyQJiQM3yKt4BeBhB0pRTPPXA6vXU?=
 =?us-ascii?Q?X2B6FkZOODi/tFnwPpg3XqiNPuYaDk6BW95SvE1QnnA2y6q/MxgbcMyiltQd?=
 =?us-ascii?Q?RJY0cEL6GXjghf+Hoyq/tQvgCqp5tAmK3BWhnoqtDW7TUQr8n1FCpSy/gnvd?=
 =?us-ascii?Q?CDVRjKRiwOdQUAKqXecWEjWcPGQrdk1xKtaCmv59Rr+oDqEh1hCkdR6gm6Hc?=
 =?us-ascii?Q?3oe0W9kA4jyOoGkT5cic/OH9O357BN/ACIydFgRNXyyizodFQyTLBs9Kb2n4?=
 =?us-ascii?Q?eMHC6so7JkLG2KYA990W3wg9HL1fZOmsZ2sWH+2VMsWFF82Q0Wk7zh8OSznI?=
 =?us-ascii?Q?WvKqLFj/ulVC+b19XttJvzcfac+JTycoJqwcRLTCnAqVxLdclw3V/ePxV/Gk?=
 =?us-ascii?Q?Op57Kcw4IFyy+iA3leBJ6Yz2PRrFSB9B6dyECyx5tTajf8rGFeLIN/ih0JXY?=
 =?us-ascii?Q?/W4Q/L3HEMhT6IRZa4pdteJk8Kep+5KFiSjURNuGchMK+sgECYsryWO2utb/?=
 =?us-ascii?Q?p+M8rp+4K8BywZ1mEEfy4LWr9Y9ATlNsmIi9bfoqZ4xkP/XolqRotb/4lTyz?=
 =?us-ascii?Q?wqpanG5A4jkqF311CUiSW2uyWs29ItteVYEL2IWLjsI8iwgvwJmPIHvaqVvt?=
 =?us-ascii?Q?3kIj0s7GRVESxPCu0+23ECEyUEnQxPs/gcrit9LQ1UadB3T+DjzVShea9lqq?=
 =?us-ascii?Q?Fubl/XQGBwJdWqMtTqQJstWhDwXzYh+sxbn9v7+u1RkvDiy0BgF4gVf/u60n?=
 =?us-ascii?Q?DoQEcg1ezkU7Ed4VVwccSH9W+93PuiI9aVZI7QK+QeAG3qh7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d3451e-d86a-4201-4668-08df40d4188d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:46:20.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hbqaraq9Z2Js5yihR8J6ZysbKI7EMNda4Ar8fd9b9s8/vggcVMpK8uPqTIUh7oZ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6944

On 11 Nov 2026, at 6:38, Usama Arif wrote:

> Device-private PMDs represent mapped pages, but smaps_pmd_entry()
> passes present=false to smaps_account(). That treats them like migration
> entries: mapcounts are ignored, PSS is charged in full, and exclusive
> mappings are accounted as shared.
>
> Match smaps_pte_entry() and mark device-private PMDs as present so
> smaps_account() uses mapcounts for PSS and private/shared accounting.
>
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  fs/proc/task_mmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

Like what smaps_pte_entry() does.

Reviewed-by: Zi Yan <ziy@nvidia.com>


Best Regards,
Yan, Zi
