Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793807779;
	b=2QGPOl5izMQ3gOwRU21Ys6P23Y655ZWNs/zzwG0qlWxV8I7T54dIIxXL/7XRtwmQI97u
	 f+5viCjlER5bImu0yQCs3/TBlWfYCby/5FMe8oKBf0ocEkFNHK8mwo8lgcyLJR8/P3e1O
	 Jo3J4BXa5pXnbv/L3nFNuDBXs7pdVFETLKwqAZqYxErNTOXsfTNFmcdxDv5tcISZpMysh
	 F3LM6bWPDo4UPKnfP3j6WHdnCjHsmXavLONPdLHdNLdAqGG81LMHatuBl0qiSmAo2fdil
	 s/ta2TUZXRsX3HnWoNr5K0fp49cGmaHjCOmY4Z3Q0uhrnWZhM4M37ROy9FxCH6WdSpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807779;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
	bh=X+Arbrk8qxmnzZevEpZXgrk3wFYEBm6p4oHLYEPddl8=;
	b=gvaDv/AwKlElIhAO4cR5+VkXWwby9NeWj+FHadQtCzgzxtvxQsQ2bhZILcx8BMIYVEeX
	 GAeDieU2gz5cqYjTXaamOz4PlmfbjE9dSTLov1/WA9DLvdyaZBCtC8Rs+kHQlmF7pA8EG
	 4m7MjmYZH9aVNDlp5jFDUMY+QYtqzSd/KDFhgbwiHKhfkb6C3K8NQm2M6mXW5fs5a6vtQ
	 QegSlOpT5Ntvu2akjZmqq94ItlCEN0Vw4EEY+YA6JyEE+CcchJd7rM3z0/e0QetJHnq0z
	 BU5JWOz2SMrM6S1Q6Z2bKn5yEs64CGe9264RYoJEHd1KDBf4onzMGTprOr8CAsDQssQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="k/djFcAv";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.21
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D227606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D227606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=k/djFcAv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRzM3kf5OI83O1G2/D8TkVudNeqg9X3QMYC2bOC17W+2913EzJHl1X3GGavsf2lgm/nHDkGaOmSgWO9ngzO4WUFhM2fbdpopFvwKgLPeHKAsUf8DL4mvpP+y1A8YF1qoo6GD0zxR40+caasAiuYCfJ1TsFSmZF15LfPJIgbmliuUgm03r0J1T2KuqjsnfKR2uIv/ohsXRn/2PZPZVp5zuqhI5QEF3UbNUVnNvIaeDrv4CY/IrRJGWXc/oRtY0NGaxKWxuXfEutfx4gdbPUrlF+YAjEqe8iPxTO84ED4PZY2PGjlIe+168qtX7H+NaAZaaA+ilRT7FLphyadWk2PBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+Arbrk8qxmnzZevEpZXgrk3wFYEBm6p4oHLYEPddl8=;
 b=U/Oi63dDg1WmriaWwjGiMqqzqclVWK2xpV1NmJFbAlIRTpZKC1YXT557LtWsy6qCbet6vKaYvSDpFrJ+tK3ra4yp3fWhIttIt29bt67IWP1+k6YDEW3DMQfN3fVKXvSCc9E2eGazMjm+L0p05T+V2VueeDje7RP5l0SYYz31jt1PCY+/KLczjNUVdtFb1F+YVctkFbC9gIg0Z9xclvfjGhilI+1uABc/02HZUjZBc1mPR3Y5reDbvvBrBwko5YI1hnmOAsyRXCoom6/MZ1JV9sVlvhEqivN6Ep3Z9icswZ47JACw+yGPOeChLy7AFpR+iznPI6gHKeUaAjg0qKNb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+Arbrk8qxmnzZevEpZXgrk3wFYEBm6p4oHLYEPddl8=;
 b=k/djFcAvEJNw0PqpoWzZDTJWCj04caRfKdbikCF3/bTxFf7dE2K0M3h49GXGqVHgFCCcJg96ioKuASuvT7F/J3/SLWm8f/dQvuSAjnKnlXWW4LWkqJORc2ICoqtvUC3XDSOhSmldFvXNg/m4tQnK2/YvBcdE4SyK9kvnK+2QkpE6jWbUd6vT4F5jN92si/s3uaMV2G9bY3N4WXYFi4p8EMRb+CsW3HaT0/ys44LPIO7ZUT4e4YXd/Ngcj4WM8KC440NbsQkGecrknEt3QsIgBiECV+T36mGJzEWQm86r4IH9fIx7yivGneQEs86jUbU/Wdgb5f3w7Fe8LgaF9CKXEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.8; Wed, 4 Nov 2026 15:54:14 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:54:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kyle Zeng <kylebot@openai.com>,
	Lance Yang <lance.yang@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"JongHyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: [PATCH 6.18.y] mm/rmap: don't discard lazyfree THPs at PMD level
Date: Wed,  4 Nov 2026 10:54:03 -0500
Message-ID: <20261104155403.4012239-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110437-sizably-daylight-e650@gregkh>
References: <2026110437-sizably-daylight-e650@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::26) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 22af4cbb-f47a-48c5-52e7-08df3a8bdf5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|11063799006|261021123027099003|261009223027099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KHzwBymg6hC2VkoizaFn5/5QkUNTWSTE4hte9AOEYTZNv4hwR1Po6bUUOB7JSgwBFg5oy7GzNzCifZzHhICViI5XToLyqOALKxgYx6kRaH2Qv/mfRDwrA5Ol1hhSoPWGaLdk3cfSfAxdIALXIRSxoLZIu1pn4Hhv8ICcrbkRle5/kdJav2kmNuAVq0OrrZPob+I4HvS0wu+vgWnyCDSTbK7xVvfpaPqvD+yN63haPaRbq3JC6sOo2NjULru7grchAo3ybfFK79GQ9KcgJ/vwcMYj4nm+kQC1Q1+linrZt+ghwIiUSR3AuxE54kycQ5u0U2dh7r/p/Mc+VLBxiosszMdWjzR+pDbCTWeiNZVHm3NIN3PnUL6NbXSPt2B9rpwPDbk4S/VVMl/mbgi51V0RchtW8ExB7rZLvoLad8cdtj+co/YV/3ueKLhxyZJqP3FuLcR/+DUxQI4dp9CCi5nooebv6rtdc2waOgflAju6PiR2HqqYCL4hy9DHinnkP28czat3oN6izU2YYyGdw51SBy2b7jbz4X34RJCHxvaUWC22VDz/+4Ppac7uSWapqjvyhdzVq7itCp0XCUTLYuJgOdJmPA6sjkp4pAidsLeAZKxSC45pcSix8a2W0IabChMfj+iaUOE2t2lbxEcqMdSdTj30xN9BoHK5eZlOZJvrbj8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(11063799006)(261021123027099003)(261009223027099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rHs46FDShFoawNqKrFczoDNOCDc8MPx4HROCeCCsVxKo4k0VM8cH2nymGtT6?=
 =?us-ascii?Q?5HvYU7Le5EKabpNT1BaYSljAphSvyTKS08DW1sjSCa3wEPguSErLO1PZrjan?=
 =?us-ascii?Q?KkY+HK+qg0idCNQe6SKFklq8RmImlnDck4vinpPjiB6eu8rPDwE4pHzYSP/n?=
 =?us-ascii?Q?MpqG8UVjN1npRwYH6cAZHGGRBW55q/LYXzAv5Vb60WrJvPA1pCPsSAlM+rec?=
 =?us-ascii?Q?a1IMRAAX2oLgSDtJhNwviAncybN54o6eZ87rnUVKT8v0coOHzB9e9yBmPF9V?=
 =?us-ascii?Q?9geQaElGDJRQAHvhGeMBO3DQegRjLG5pog6qVXad2IiClJZAbVa/mQOsZ2td?=
 =?us-ascii?Q?+zZ0FakWB/gKZUvxs4l26nnekQOn1Foiwnxxrz6KRCFeYX5PsFyStDpBW9Ja?=
 =?us-ascii?Q?kFOqnPULJoZEQkfM4xeBwOOaq697vnZpTNM60B53PhfWh/NRkeWbSHb0lT8C?=
 =?us-ascii?Q?ZOWccLY0O4TCXTz0aOMbkVnUUS/a9iYP8iLef81bamFocFDLldtG01KVFfYv?=
 =?us-ascii?Q?wTzanmXwiRAg+fQmo7+dlq8jpxvlCJZyPgZBZQVd3f4qsxAshmC/Xw5Gbh/8?=
 =?us-ascii?Q?CYssjea2xrZNdoSWS9+7HbIMGtx8/1EZJ/opWCLQCE3kM5zJGIgY86Ts3wOd?=
 =?us-ascii?Q?YsFjlKPcsQXgN5b4BICgN5czI5X3wbxkIi0z2jUH1CtKr987l418TpSAkjc8?=
 =?us-ascii?Q?xOMzkAazTDdW4LT0ZZi6m1fhEey50ebEe/rADx6T67kLNr+HoUJf/Xukx6nx?=
 =?us-ascii?Q?zNKrkde/QCcChph27l1EIN9CSs7cTB7aelpC6T8S4DUdwMXqVDg9cz56RVAG?=
 =?us-ascii?Q?q39ZkABbssl23TRHF+uCdHyZFH+ybq+OHC+kRqbg/jnM4zHJfA9qkb+FrzmL?=
 =?us-ascii?Q?zcevW/iUs+277iTwIrkhbpYh9t8PXj6qUeLJ8BSSoEx2AWGhHche9s/IqjkB?=
 =?us-ascii?Q?2WkwPgTv7nBbR+4WxOETjKQyxH5CWiIqbycXOD2rqldl+5w2bnQfiuLZNXtL?=
 =?us-ascii?Q?U3HgjjE1IwHBHggBss++rSIVhii6dtfxoqS5jtjVrYsAdT5gdWeE3IGl9Q9f?=
 =?us-ascii?Q?dxGGvSUGj5+0cKuSG4yLCNnndGso9Jz0QRJX5Cbmf9t/3g9VkgFGDYMoWAGN?=
 =?us-ascii?Q?0s6SKyGxZ7TP+q3MoAKjK/vwQ2QVk9uwYeNyAPWGEM7Wd40NqWT/ikXVTSuU?=
 =?us-ascii?Q?X4+rZj1SHQJKCTpdJQ0C+rgilaWGFzePbH8812cVJ3djExyxL9aafvf7quxz?=
 =?us-ascii?Q?iWZ+5fgMqs0QWrnhKCNfPZkXVBzMrJQdm79rROETPvos7sUxPAdZn4Tjk3fx?=
 =?us-ascii?Q?MSx9OO+92Sd5KmZzC6E2HZq67ztfWhiv9RbwFbrAdFhuGzsZ17qkAT7n8BgS?=
 =?us-ascii?Q?e3P2zcFHrVGKjAcgWOec8xp0W3YYkPPYU/k/enYCBtjhKP/+yj2xSqX48Ump?=
 =?us-ascii?Q?TaftzqrD6BoSicbATngWR2TzcRC51v+ldpJPzhFW2IlLjE7fKjQWS9e6bkk4?=
 =?us-ascii?Q?9SX4UsLqhkroU7Z2+3S0QNuRnVZMuGV7U63ywLeVREjcAI52bDTYPsuWZYvQ?=
 =?us-ascii?Q?lKDwj/MMEHRzJziS4C0VxF1dfs03HPyWs6fQevksgSKgEW9XZwjv6xWZEFfK?=
 =?us-ascii?Q?t5E28qbYiJeHXbW/EiunwyXd5g7L8qSlI/Ji6/arVEl+KaecJecgypinnLoO?=
 =?us-ascii?Q?FrKYTbcXRhJMQbWVhx9M8eFZwpCUdyc5XuCudbEaYFm6eDmG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22af4cbb-f47a-48c5-52e7-08df3a8bdf5a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:54:13.3462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Er6c4fHgHhYHp+YCVeaxkpstucuNwslHhhtNcNIpTj4+Iw2yQfiT2vyAdqF0RaT8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133

__discard_anon_folio_pmd_locked() clears a lazyfree THP's PMD before it
determines whether the folio can be discarded, and restores it if the
folio is dirty or has extra references.  It is done under only the PMD
lock and the anon_vma read lock inside try_to_unmap_one() and no mmap lock
is held.  The temporarily none PMD causes UAF.

A parallel munmap() or mremap() is supposed to serialize with it on the
PMD lock, but zap_pmd_range() (called by munmap()) and move_page_tables()
(called by mremap()) do not take the lock when they see the temporarily
none PMD and skip the PMD.  There is no more page table walk after the
none PMD is restored:

- munmap(): free_pgtables() waits in unlink_anon_vmas() for the anon_vma
  lock, then free_pmd_range() drops the restored PMD as bad without
  removing the rmap, so the folio keeps a stale mapcount.

- whole-VMA MREMAP_DONTUNMAP: dontunmap_complete() unlinks the source VMA
  from its anon_vma while the restored PMD still maps the folio.

- plain mremap(): the THP is not moved but unmapped, so the THP's data is
  lost.

In the first two cases, the folio stays mapped, but no VMA that maps it is
linked to its anon_vma.  When the anon_vma is freed, it is still reachable
when one rmap walks the folio.  Racing lazyfree reclaim against
MREMAP_DONTUNMAP as an unprivileged user reproduces a KASAN use-after-free
in folio_lock_anon_vma_read() as reported in the Closes link.

One solution is to use an invalidated PMD instead of a cleared one until
the discard is committed, but it needs arch fixes first.
1. GUP-fast still follows an invalidated PMD on riscv, LoongArch and s390.
2. sparc64 miscounts thp_pte_count when an invalidated PMD is set again or
   cleared.

To keep the fix simple for backport, stop discarding lazyfree THPs at PMD
level instead. try_to_unmap_one() splits the PMD and discards the folio at
PTE level.

unmap_huge_pmd_locked() and __discard_anon_folio_pmd_locked() are left in
place, unused, to minimize this fix for backport and the invalidated PMD
approach is planned as a follow-up series to use them again.

Link: https://lore.kernel.org/20261012-lazyfree-stable-fix-v2-1-6387d6e30063@nvidia.com
Fixes: 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during shrink_folio_list()")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Kyle Zeng <kylebot@openai.com>
Closes: https://lore.kernel.org/r/20261009165214.40212-2-kylebot@openai.com
Reviewed-by: Kyle Zeng <kylebot@openai.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: JongHyuk Kim(MalHyuk) <malhyuk97@gmail.com>
  Link: https://lore.kernel.org/CADQRuqvXQ=YE=7T3oR66vTxE33pi=ygEeZKPTOU=cALZL0Figw@mail.gmail.com
Assisted-by: LLM
Cc: Rik van Riel <riel@surriel.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
(cherry picked from commit 984c0700854e35779a2bcce6b02783e709b6efa2)
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/rmap.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 4f7a44093a09f..03d7d666cc578 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1963,17 +1963,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		if (!pvmw.pte) {
-			if (folio_test_anon(folio) && !folio_test_swapbacked(folio)) {
-				if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd, folio))
-					goto walk_done;
-				/*
-				 * unmap_huge_pmd_locked has either already marked
-				 * the folio as swap-backed or decided to retain it
-				 * due to GUP or speculative references.
-				 */
-				goto walk_abort;
-			}
-
 			if (flags & TTU_SPLIT_HUGE_PMD) {
 				/*
 				 * We temporarily have to drop the PTL and
-- 
2.53.0

