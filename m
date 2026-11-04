Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793807817;
	b=03kCMW2fM5KnX8yWKj6vi+ak3qRDBt1jFvrVx3B6mQ+LKJRY4/PzG2pqAcWFJmjjC7ly
	 ZIoHu4uyf4nxd6wBZaY+sBANCsNe+OaQ5JyJn3TQhvaJYQW/SshtGj2VVwnP2IHBaOHpi
	 tiNc+X8SYGYQap0CJbRG6q4UP3BwRN+df4faJ+BcTWx1ceG7KYZVQ+FDTiD9HxjjZ0QcB
	 h+kkkDNHVBLw6+4lHfvfrifhAKwAV8IP0KOnBk+cTA8en66+KWORmkfTdcDKoNNmTKh9l
	 rcdomgO3UpDpN2kRClH+T5GsylLjt4jEbjtrLVLDaGQvdFoUWKgSqZ5ro9QYHnOoQEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807817;
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
	bh=5IEh2vxb4MhqScCDHGXPxC8HK49frfnB17EgaWUFrvk=;
	b=F3lald+oP+iw1qHZDkWz49h1mol6Unwb11R8uwtMzph9nt1B5plcEemK11qRzu6DTsxh
	 TdVr0/bfqOJQlKJhGAHhcbRB+0gSrr0Oq0RfCDiRJJO0dTgmLU/AJ7iWlB2deAzO26SYP
	 yuI514n228h7l9ZRhs6Uph6ZVZ0Jr82u7fClIiGwdhOMfFTqzFgpFQ0MLKH2hzHnJVw3/
	 E8phPI6z+fm0ZcdLn4z3MQouZ/AiLxLNkWus50YK0UNBMJG/n4gJ1rkKlOIP080AlEzzo
	 dAZzeAtEbg5IzEDmgg6IOkYvPiHdhyY/nGeeujYgSa0/ZJa8LLewdA7tj6dicWpdjpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oyLqpPS9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.55
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F1B606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16F1B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oyLqpPS9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOH1zVC3yFKovTPy5SAlw5XfFpdAdE/ghfx4EAtCf28r8rdpGkxCX0IgzDBxuqfQ9nHM+I5Pgy2+9c7z3hrjm7FIe+z94DPZvlCwkbN7W0iFrJbq8b8sZeUJKful8gvUGeTR2CicxMhugO36c99Lka3PyzpZLOxW/0BNpf2ylSixygI3BBeEXUD8z3JxcZ+vZ2pFnc/pZO4cmrsVvGGozishI3rfrsAf/TetMTQ9xqwf1AHo2c9cljOYjamr4cldKlL73HrFHZh9scF+eMIejcWml4owRq+ncVxh5ZFAC7wZwEsyxHhw6ibv99zWdfvyC5uKiKiBWTzF1SmjEPqEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IEh2vxb4MhqScCDHGXPxC8HK49frfnB17EgaWUFrvk=;
 b=fpfynsbf7ycm3tcXB9QAhArIVJxIfqf1e4XHBK24Yx5spqyEpzYYJp3kmKuykXo9fMSBjvfmoONNjRbs7ci3m85FYYhccoYl/VnZk5gHnfYF7oozDgjoxuXDj6LXHzu6qU00qC/28gv/XRqzA0qVxykjpgNerVhO89UwerDl7/VcVta0Lha3cgHA9/33/SksvpKsSOHP5mSqDtgkoSENBWeEBi51A1Ep964rziJlbsYyUYQi+6jUadGjAsXynX5hQ6f4gcj0se3p/rPQNjBGYodJlP3v/piuMSwbX9JQPqRWOy8AcqjiBqP+olpEn1cNd/zL4DJ/KJFfyK3gPyhFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IEh2vxb4MhqScCDHGXPxC8HK49frfnB17EgaWUFrvk=;
 b=oyLqpPS9GgH98do2hy8BQekaZzpAdxGWuKo5H03eszRdHsddmQzacdd5Po78xgxL88OpoE4kJj/FQYQ1MWpUaExJl4yVJe66PBBxBIt1oXkgfIS78ogRv7Z8MHHYp4H/Axql5JMq0oIeGEnSf/P6O7W21/fWkrWMr9flz0r5hM9HZNziG9h/MpN9ORvf8b0Vxn196i5pppcgLaMWMsMCtwcV2qLnZZrpCKRys2MhWSm6scqleCjuTEMrlA0KAbTAC1CsNaJ0sxR93+xdIfmWqrpcNAugBSu0O1aRSqfka1rAcCXu0zYEryZgVR8+GXJT3duHlY1wX0P+JYePAanafw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.8; Wed, 4 Nov 2026 15:56:51 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:56:51 +0000
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
Subject: [PATCH 6.12.y] mm/rmap: don't discard lazyfree THPs at PMD level
Date: Wed,  4 Nov 2026 10:56:48 -0500
Message-ID: <20261104155648.4014303-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110438-manpower-atrium-3945@gregkh>
References: <2026110438-manpower-atrium-3945@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::16) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: fe93a7c8-cbab-453b-27b6-08df3a8c3d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|11063799006|261021123027099003|261009223027099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BHWrDOFTWyB3IqdnSm1PKmGWQ7cXRf7DdnkxuTiPm6g6OZhvlURm8jnkYPuGASWMUIVT6haP7rEJ4cePHy49+P+MWeBxbak3nQsaExTG3zP2CjYlBSaxHe1rtX43hLj0Srn5UTDDmebr+o7JBK0jiEK4CfY9Hj2yAA5EZPyTH/wi8O5OjiVAd6+CrtRpPuopvrqW6Xa104YXKpTa2SLmmlQDScvaP6YNlR9iNbDRBUy6ArFdT9ywo9z2NPSMUm0wuszlKQa9Cgg4M6oP77vdw1Zvr1q4lX7oiRaYDJQ0lw4J0mS4TXhE0DbJlqarpamDyFDQysoQL1Ga6/119vKsblnnh03prt4PMCjzoQgFEG2/YsOnkdDTpdUgdFfhT9J7AbYbtjn57Azk9CpP3xuBKJ60X+Z/p6qgOsX/biaXZoQIkOlwrLhWunP7C6CS5RBPjdpEB4KnjIfhzhnnrXsGRK3ANEF7keItgBlRL8GmMfkJaKMGXvSLMLjlOb/LS4utq2d+ApfNNuEl83c9xrnk5D+cDdAvgD8Txrco/XxMatrqW7tHzyWLKpyWFdJrcDGc3hUwAwYqZozKpfTASm9DuFwk6Ok0j4AtBJy8HCV/5Fz41njcUwXtQMNQH8NUK5+CYqbdB3vR9GmPpa1VcmDlEEiYRpRnJbznJZu6SZx0fJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(11063799006)(261021123027099003)(261009223027099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+XAszMsIj1vg8TOk/W8bLS9l2GArYa8HUQnYekZyMR3Hx6isZasI1X9Y/bao?=
 =?us-ascii?Q?BJIt/4UuqDVMfnH5sxmXrbAEwqNr38Vp/E89dFfkkgrclchunApMdsUYwh6Y?=
 =?us-ascii?Q?xWyKrPNCiS9A01+TFgCs3wivwR7JNhUvu/dnYGHmeXOZsPB5PINeo+60fwKQ?=
 =?us-ascii?Q?ViWwyIpPIrfZDvqpoGF0qNnfQlslFGBsxyekLCzK49nV03aSIeohyHheLVvu?=
 =?us-ascii?Q?E9jusMU10U8Yp2HomC9B2PT4hedbYz1PrGkITZZ5+94YlFCzL6m/u16DyS51?=
 =?us-ascii?Q?Apr3PL3VgHZeGboQ9Hj/1XnQ1f9forkLzy5CmGWvlK08VeYEiG+ZDeKhORrb?=
 =?us-ascii?Q?IxI0Py6CR3egt/JIm/dERcgJce5vXZNiKW4fABLjw8qsZyWoLno+e2bZ6QCH?=
 =?us-ascii?Q?2XyiBBQCECulBeycIOQFhKhVs7FAtDWVDUIa3vHtfy19qrVE73MjwHd8xCXz?=
 =?us-ascii?Q?gNLuYMHwiNR3Vr5k5HoZGTG6YkAs/xBB99pZYIIM8AiihIeevWWIalpHQATM?=
 =?us-ascii?Q?yMePZOifsqou2ZB4cD3qpK4bQT5aYbEXSfl0HsEl+ZXGsoK4rIQV4Ami0En+?=
 =?us-ascii?Q?Jx/eIS1WSZvgY2hf+eDSs2MpOo1F0s054WYIOA636ew9QNNWbKVabZyzsPYI?=
 =?us-ascii?Q?IsbQ2IIJW6YTZe6mMg5m6GvDYQ0thNPUfjM7n6JSfWWDVu2vywWtt7YM7d0D?=
 =?us-ascii?Q?td/Q9/Njo0GXl1MTrtdT4ndocPrOCgmAqq7yNPp+AFv4LPMY5ySJEVYPXW0C?=
 =?us-ascii?Q?w/jYrTvfiERrIoBT13OFgqWe/UKad54lKqMscchUmfAkQog4D/4KKQ84lJYv?=
 =?us-ascii?Q?6pEPGwF+xGY+uhxS6SFWXl1dq8r4bHVYCbh/E+5BCbN996mbTJwmdvJ/sRSd?=
 =?us-ascii?Q?kV4vFNCavmIXiMLjk1vMyS5WfEFmByu47jcT7wMn9Xuwdsz8AAXlwCjoiWRr?=
 =?us-ascii?Q?nGfJfNHhplI/u+HN9rDQjEnfW8q1ArndMqmhCYUEuFmL0b8GWQx91564ned/?=
 =?us-ascii?Q?ez2QSDOB3ANWAWqJo95T2K59xGGpnE2RvKNfTOmobWa/57hGkUTGjdn+qf/5?=
 =?us-ascii?Q?lCuBrUAntkO3M8T92UjESbnMG12S6dqpKR4RGIpNQy/h+MxTOx6ZlvytzTCW?=
 =?us-ascii?Q?o4pZD2J3o+OYhMdeovmHlMan6ZrwsAFzh1Pnw8lw1oTp80O5tiAoMB1cD/tX?=
 =?us-ascii?Q?Vv1uLO6j3qpQRPGr7V2HJN4DyfoTEBJ8DM9pQSvzyEf4H2oS75n3NXbYMPmh?=
 =?us-ascii?Q?0oN2bX9JWEpitvm9HwpCzfUlSwNomR1k13Jkx48MKPvmZgq/31vpKEmCUEGE?=
 =?us-ascii?Q?mW9vhkmHA6sOuOyvNybwgGvgqR8fkzSulJKqsvUqhSpMSq3lOZM3GnWAgx1L?=
 =?us-ascii?Q?sPpZQNho56rPMHiyS6CpcvJ25pZSbxNHwp9LkFUxU7EVkuC0kNxs6RMVWLhb?=
 =?us-ascii?Q?nBHEfa+DONy8JIQaqdFfdP7W3pGLjKsVLGpgsxLiR+wYT9nwcuKu4EfrLNCb?=
 =?us-ascii?Q?q2R4J7GHmnIK5FyhrOrPD+Wj9w7XIcckVHQNIw+N+W6ic+6mzgUO3VvNCCvF?=
 =?us-ascii?Q?FYGAozY20IreukfH5vVJKhwloc2RFxlDBby9tBjNoL4FnK1ogw0wE5llvova?=
 =?us-ascii?Q?i3gzlH2Ic+aZ5K8wD3qkXaOQCqWFhyURS/q7/8uwB5pE05z4jAJYcnM/uxEQ?=
 =?us-ascii?Q?g2j2CtWXQdcPon2EbHWtAYODu/Zj3Lbo0f6R71Hd+lkYRB/s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe93a7c8-cbab-453b-27b6-08df3a8c3d4a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:56:51.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Y6lx2gEPAUMnOJ/Tyo1bGrzEBWJDo+CHSTXScMF3EzSgfH8/bMys4OZj/XwedyM
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
 mm/rmap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index bc9c66cc950b7..9be1fc1847bbd 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1698,10 +1698,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		if (!pvmw.pte) {
-			if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd,
-						  folio))
-				goto walk_done;
-
 			if (flags & TTU_SPLIT_HUGE_PMD) {
 				/*
 				 * We temporarily have to drop the PTL and
-- 
2.53.0

