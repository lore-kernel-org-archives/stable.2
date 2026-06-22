Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23C2BEC4E;
	Mon, 22 Jun 2026 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782156995; cv=fail; b=hD4SDOjVR0kAhw9eTtECk6G3HUK0UOkgp2eLjNJVuTqf2Na6PpzmEbv812If976+cTLxmnAlnGfA6gbaEy72FSXlHheZz7FcCGW/XF0tvpoJnYYlG+DKClqVKCWD/RG1i1vJsOgu8dRq8ujECD+AH0cr32KUaUHa+G8/zOEbfc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782156995; c=relaxed/simple;
	bh=8GGVAP4hijhTlMXNM3KmAK6ogIBHODNvsXJunVSR0sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qji8h0OF+Vvbg7OeYCS3Blw0wQBVXpn4SZbowZkT58ABuz3BWd5gexvT6E0hocb/23jQIu5GlS7tBIx6JCk4rMF3Xq1/cAy08/8gXeuGsWkCq2tH/UKLneQpTgTzag9LyTOKqnU2h0XqYEesJSaC4OJ7TUOAmUZe2ebb5C6/8zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JnZUHiBf; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JnZUHiBf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpkCQ7I1HXWNwbXNADTg/5asVkcoIrwUWAcZCHvhlt98JJ/etNmPk04zToRQs5MR2IIRp5tszrVzVrQEotuB5vWonHLVdC07wXt2gCgnCdy6tn21f6A3iMZ5TDwBoPWFWzdOe3M197xkWOh01dNzPBWHiZd0q9i86qyrEqZUsFz+/9dVWExVzXAF1vn4VIt3QXKgquWJ9uKISWTmK5q6paeiJQ4q3qakHGpVzsdfDc4t2H7KDHOMugft7UQBExzCGFcg9wO5kBdmPisC3kJEmgf4l3E926QWvlGM2FfgUAJGtao0Fx/5E9jI+1vKwhNSXBLlm/g4kQWX60Lx+cpC/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWlMRZXERD8z9LpXBi8ki6pLJH25vjmy/vtMl6zm4M0=;
 b=ZEphW4vu422x7tWO4xispAPipSpdzq4YEVWGH16Zsu1sL7+v+MbBE4fIeCd4AJVimxEbc2H3EhHuxXjX11izwUK1hBQdNvg/2BTO3oK1s8Ehk8j3vhpOR7tEqKfVLB/UsCImelzv6Z527f72rDJC+6YMkfYcrjnn/jGU8+X8sGh0q0i381mJUQaYJMhK8SmjtdEYsSFj+EE1oeCGdjrnULLNiVgx6ohGcsAaBUtcdpD8vkPtJ5CLW/5d2vmIqfSY+k0AXGikHFpg9bDWyho6DodcXY6M2HDKxxhSSWhTEzPJSleqnn1VnxRYQPTlIV9+AbO6HytSLcHgvUgkpqD95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWlMRZXERD8z9LpXBi8ki6pLJH25vjmy/vtMl6zm4M0=;
 b=JnZUHiBfCVgQmhPREPMgPlEkZnmN0+ngDA1iaSioIXCIq3lSk9g71VZ0XkHfGLKk3lzpI/nkx1uI2AriRq6Ou+02N2d4M/mG1yLDdQ2ADQY/pk81IzeTdwqJD28bqA57pXzD152MufRw00DgTf3eWfQz3gNepUrgkyRE6bCW6xwoBv3s9E5+0HG3ESaVzld9lQdN8oByLzO6BGTryL94F7cuEA/QslyGAFQciQFlFGhq0f1DAJtdBtVOp78vC3QVSka8pppWdRvitZaXfrmxA9GmKhoOiGR10sSy+EurrsZupjhDJQrcuY2pAiiMf8/H1WZX/gKWGJMNSwr0yMgUsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Mon, 22 Jun
 2026 19:36:26 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 19:36:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: syzbot ci <syzbot+ci8a7f89fd8f70a458@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, hannes@cmpxchg.org,
 jackmanb@google.com, kernel@oss.qualcomm.com, ketan.kishore@oss.qualcomm.com,
 liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ljs@kernel.org, luizcap@redhat.com, mhocko@suse.com, rppt@kernel.org,
 stable@vger.kernel.org, surenb@google.com, vbabka@kernel.org,
 willy@infradead.org, syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] mm: page_ext: add count limit to page_ext_iter_next
 to prevent invalid PFN access
Date: Mon, 22 Jun 2026 15:36:24 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <88AEEEF8-B9D9-48C8-9069-00E8528BB619@nvidia.com>
In-Reply-To: <6a396a5a.ac26f6c2.9a9c4.0000.GAE@google.com>
References: <6a396a5a.ac26f6c2.9a9c4.0000.GAE@google.com>
Content-Type: multipart/mixed;
 boundary="=_MailMate_CF82A964-76B8-4DEF-B35B-AC42D30396FE_="
X-ClientProxiedBy: MN0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:52c::11) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a898deb-d8e7-45fc-919e-08ded0958c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|6049299003|7416014|1800799024|56012099006|11063799006|18002099003|22082099003|4053099003;
X-Microsoft-Antispam-Message-Info:
	x4s3lLdUuRDeSwgzORBHjdD+dPON9XN21qq1PltzwC6JHcMZZEpyUdJQUDNczR1MpDrOZ8rbxIzegl+97NUYmv5MNvCp7hR9AKVfp/XHzpgzL6k1p/vKvuCk2/A01A8qzobQ+0Tug+Nx2Cpz42sKBkKWHdliyl4A9SzriiSQ5ayj3wBTuLzWY8482tFqvUz4V26rNX9dMYAe6QVN9j4707fvMF6y6j3DzlZWvCi0XB4A/2AVrMqDPcQhjC1nRP3hMYxZS9Y0wR6uRYUS7WbXvCrHY7iW03aRy5LsnWWYJHJNmn7UrnLxLowce67n8YhepD9hKyioIwM7OB/FyL7pTF38rw0pVFCO4coBMI9qSfSSvjkQO1NukWRTwnOwETMaYI9CtzZfyGW5eOYkXFo6qeDeng9S4ASjvM/0gKioSDSVrEjKGynFhD4BzeBKusEit7SnpRcQVtA5EjehKHSCe1swmlEQEhAeneu1RBCSElMbV+A9lCET8tHKOg3e1GKjQSGOs7guBmgcogc3SvAPXv4i328Q1f94C8iX8a3nqXPYLpJ86ezAS8xTovjKIiyaM48qnlovyZpVXIWNiHHQ2mvILygmonN1oq4AbRm9EP1Yvnk0cTioXu/CGLWCU1SVjXnrjGGY7PV6/OYX4YCvncq8ADI93h7YouK88Iqcres=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(6049299003)(7416014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CAS0NXoau6pcNquqIoKuOLbCEJxeQGT6AbR6biNC/d3aatZSSNHlRL5rXKz3?=
 =?us-ascii?Q?c795128Yc7rebM6CXM3+CEY23Ql4uGSuh/+A+Qhs9V1wN10bU3XrYK76xB8j?=
 =?us-ascii?Q?caJ/aIDWfD5LOXJJrTDvJH+uAttP6ZBAHK9gusEVOXLTa9I7l9s3wd9rB75V?=
 =?us-ascii?Q?FJ4uYrVjBpvvFouBmnrLGghpQF5ZhmdXKcn4EnLT1B4005HLF9h8miHPTdvZ?=
 =?us-ascii?Q?PrzoUvNYWp+nKtDvE56vyVAeeNz3dLocqhQkSFf0RBqR0DEbo5nRidVlroWg?=
 =?us-ascii?Q?tHhOJTQ9LM5xPkfxUKLV2Ohl8FkarQFqYBBc4plftyFJt+K3fJyCFNP9OPQe?=
 =?us-ascii?Q?MuE5DlLJdDsoHnbq0uJ4WZ+3M6mRvT7Kkiysq7Twn728cJQcoSrX3mit98U8?=
 =?us-ascii?Q?cFzTc5Y5+vkxR9V5AAc9ogowVzT0NYOMlrACwjAFu91EuVKrID1jgfZUiXUu?=
 =?us-ascii?Q?r9bF/8Vvi9+UPEQ8HzhfUDScHyqVkX+ANy0KzBGtZpAVPODmf2EzjvU/VhVI?=
 =?us-ascii?Q?nw+LAqvyA+RIAtU+9UfzxtyHEi5SvXVONK5v/PNEKY6BcR+i9SFP4VbW5F5Q?=
 =?us-ascii?Q?eumZIVmDSfBUkpYBfDIM9i7dvbfT8fmLLzGX5Dp/KSZAqc8jl00mRlXEe6bL?=
 =?us-ascii?Q?upDNbzTm6QrZPCKu8GHNN4ckZuACXnkXIeFBZ/UtCShvQxuZo5MnNmT183fQ?=
 =?us-ascii?Q?665Yz8mBqFdpNAsLs0x7Np24udJz3WGx40Y1QZAdmGjYcXmGS//gxn9sD+Rh?=
 =?us-ascii?Q?7nr8UtVjfnYtayJYawTfTneh2faNQXBRe/RuVDc+Rld3eJpapPxkL02nxuzL?=
 =?us-ascii?Q?SmcAZpnb2T4OxPSl2jqdy+8YSN7d/5WxgbsIVPXWyXHKhO7MkYFqe9neGaxQ?=
 =?us-ascii?Q?wXSWhKTnfaz5BEAq7NE31FQ3//DwVKXs88yUWDLPZRoVCuQeEwJHp1a2u4S3?=
 =?us-ascii?Q?ZrC7WgITY6P7z6vskTpqrfLAY7+2LtwCbMg285cmjFv3BPL0msvt2mfyY6dD?=
 =?us-ascii?Q?60SdOX9xlp/foocEMGrPZ3hpQQvt3ZBh/hlfZORflDLfb9OWG34E5guGe32N?=
 =?us-ascii?Q?j0PCgdtp0tuVdkqofjbhzsShQm8PleLhxV5pvfENdhnHmc+XTX+dUFhhX0pL?=
 =?us-ascii?Q?Bd63EsGwPJOHTAFTemUWEb888A3l16JXOjoFYzgqlICc6G+aYzEK/Y3bG2HD?=
 =?us-ascii?Q?rFOrKLIWewO2gZrRRyweYkKES/Ijm0o6nQGMp6w25mbSSz5dBM092HP8Pd0Y?=
 =?us-ascii?Q?EuBTI2ns1eW+h96n0na4lbOhE+JHfUxSSowvUGRHxX5Hb8LDKU6TkT8Fv9wy?=
 =?us-ascii?Q?dl3IPHlPtpmy5ukpjTxBEzUAtrtJNN/1bpS/KPomZEn0qsyBbZ2Agv5FY7SF?=
 =?us-ascii?Q?n+BtN23JSMEs7HE5eX8C+EDqVkMpr4FsPlObbaFJUN2Q0tBnhj5hXuvlGfQF?=
 =?us-ascii?Q?NaLh7AMuGclKhMIj7CZovBgxD/H8yr+1r0L5whG6murwy6BEQivyAdTHNTe4?=
 =?us-ascii?Q?gC57nVyS3MwAJivbondb7+zQS8LQFV1dspBYFf0BrWExlgeYyDKSTg637BOD?=
 =?us-ascii?Q?bs3C411e0v5QJaqHTxYur8UO0ZbnLmp/iEvuPRZD8gxm+znQqnv/R5HhRSks?=
 =?us-ascii?Q?20V8gWHIqGuMV6dvyCwlbFdvB0tunCU9dxSS+XLsKkAWBYXAknCMb7BA8K+b?=
 =?us-ascii?Q?8fM11fBAua8nt7V1yxE3Djk44oGiMtg5gcukDrEgWVd0eI9m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a898deb-d8e7-45fc-919e-08ded0958c7f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:36:26.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpbugPNgllF5he7oN6C/9gD8g/HMH+/yu+zFcVxW7RoyFuPOzKfimLaHYOSk/wTU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271

--=_MailMate_CF82A964-76B8-4DEF-B35B-AC42D30396FE_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 22 Jun 2026, at 13:01, syzbot ci wrote:

> syzbot ci has tested the following series
>
> [v2] mm: page_ext: add count limit to page_ext_iter_next to prevent inv=
alid PFN access
> https://lore.kernel.org/all/20260622-page_ext-v2-1-135d4cfbc42f@oss.qua=
lcomm.com
> * [PATCH v2] mm: page_ext: add count limit to page_ext_iter_next to pre=
vent invalid PFN access
>
> and found the following issue:
> WARNING in depot_fetch_stack
>
> Full report is available here:
> https://ci.syzbot.org/series/092dd7dc-cb78-46b6-8703-6044fff2631d
>
> ***
>
> WARNING in depot_fetch_stack
>
> tree:      mm-new
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akp=
m/mm.git
> base:      e1201ff76176ef666b13d1a4ec6b6190ddc6abc8
> arch:      amd64
> compiler:  Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1=
~exp1~20260514074407.73), Debian LLD 22.1.6
> config:    https://ci.syzbot.org/builds/18f461a2-7098-44bc-9d42-634b56b=
a48d9/config
>
> ------------[ cut here ]------------
> !refcount_read(&stack->count)
> WARNING: lib/stackdepot.c:517 at depot_fetch_stack+0x91/0xa0, CPU#0: kw=
orker/u9:4/1114
> Modules linked in:
> CPU: 0 UID: 0 PID: 1114 Comm: kworker/u9:4 Not tainted syzkaller #0 PRE=
EMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-=
1.16.2-1 04/01/2014
> Workqueue: events_unbound call_usermodehelper_exec_work
> RIP: 0010:depot_fetch_stack+0x91/0xa0
> Code: 39 f5 72 d0 48 8d 3d 7e 1b 4d 0b 89 ee 44 89 f2 89 d9 67 48 0f b9=
 3a 31 c0 5b 41 5e 5d e9 87 67 b8 06 cc 90 0f 0b 90 eb ee 90 <0f> 0b 90 e=
b e8 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
> RSP: 0000:ffffc900079a6ce0 EFLAGS: 00010246
> RAX: ffff888168b94000 RBX: 0000000000000ce0 RCX: 0000000000000067
> RDX: 0000000000000000 RSI: ffffffff8e215937 RDI: ffffffff8c28ab20
> RBP: 0000000000000067 R08: ffff88810495a407 R09: 1ffff1102092b480
> R10: dffffc0000000000 R11: ffffed102092b481 R12: 00000000019c0068
> R13: 0000000000000001 R14: 000000000000010f R15: ffff88810afb1dc0
> FS:  0000000000000000(0000) GS:ffff88818dcb5000(0000) knlGS:00000000000=
00000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff88823ffff000 CR3: 000000000e74a000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  __set_page_owner+0x140/0x4c0
>  post_alloc_hook+0x1f9/0x250
>  get_page_from_freelist+0x21fa/0x2270
>  __alloc_frozen_pages_noprof+0x18d/0x380
>  alloc_pages_mpol+0x212/0x380
>  alloc_pages_noprof+0xac/0x2a0
>  get_free_pages_noprof+0xf/0x80
>  __kasan_populate_vmalloc+0x38/0x1c0
>  alloc_vmap_area+0xd1a/0x1420
>  __get_vm_area_node+0x1f2/0x300
>  __vmalloc_node_range_noprof+0x358/0x1730
>  __vmalloc_node_noprof+0xc2/0x100
>  dup_task_struct+0x28e/0x830
>  copy_process+0x79d/0x4380
>  kernel_clone+0x2d7/0x940
>  user_mode_thread+0x110/0x180
>  call_usermodehelper_exec_work+0x5c/0x230
>  process_scheduled_works+0xa8e/0x14e0
>  worker_thread+0xa47/0xfb0
>  kthread+0x389/0x470
>  ret_from_fork+0x514/0xb70
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
>
>
> ***
>
> If these findings have caused you to resend the series or submit a
> separate fix, please add the following tag to your commit message:
>   Tested-by: syzbot@syzkaller.appspotmail.com
>
> ---
> This report is generated by a bot. It may contain errors.
> syzbot ci engineers can be reached at syzkaller@googlegroups.com.
>
> To test a patch for this bug, please reply with `#syz test`
> (should be on a separate line).
>
> The patch should be attached to the email.
> Note: arguments like custom git repos and branches are not supported.

#syz test

Best Regards,
Yan, Zi

--=_MailMate_CF82A964-76B8-4DEF-B35B-AC42D30396FE_=
Content-Disposition: attachment; filename=page_ext_fixup.patch
Content-ID: <4702953D-48D4-4C7E-82E5-AB976FF49C19@nvidia.com>
Content-Type: text/plain; name=page_ext_fixup.patch
Content-Transfer-Encoding: quoted-printable

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 4f7d7a8709de..f797bc898b8b 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -156,7 +156,8 @@ static inline struct page_ext *page_ext_iter_next(struc=
t page_ext_iter *iter,
 	if (WARN_ON_ONCE(!iter->page_ext))
 		return NULL;
=20
-	if (iter->index++ >=3D count)
+	iter->index++;
+	if (iter->index >=3D count)
 		return NULL;
 	pfn =3D iter->start_pfn + iter->index;
=20

--=_MailMate_CF82A964-76B8-4DEF-B35B-AC42D30396FE_=--
