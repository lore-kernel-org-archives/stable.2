Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.118
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794303742;
	b=tqBwUs6GvtGSZDLKMnnYj4PgW8JS+Cy0MDCZKHaUdT342gIyFIDEt/GDwnyCeYJNhEpw
	 kqraIdvE0F6nixOtGxBW6XDnbi8VzmrmnIkjfm5k4FEBeFwd7sVdqse4LuSjgbMt4yM5G
	 oAV5htpDC5LRGggb3a4MJdfvdps1klaQZ+lEhed0V6pTOLLi66nh83EP95+il/kYiuL7c
	 c8bGvCRzm6j3daj8CoFT45t5RPwjvjNjyIoSRfklvZabnO6eBe5ulLNOR2rTwjamFFcl0
	 tULNdqYL49dD0TL7kheF/YdWZXg0a1AH85ggE9NwutxU4WZESjf6nyCaT2/awbpeDwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303742;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=vxsktPIKyMucM0Bz/Paxx4q9YnJdiDyVZzrNC55CRlw=;
	b=JqzDEMhPXcIclCDxMXiaGU9syRL3i6iVuBe+Zhv2TEfGlCaIfho/pigYOZFMnEc15RlX
	 TaYmOLNjnASNq6N/pPe9YkgnG1gmqTtPAE0GthHbf7b+pcU7mQqJJuhO5lBFupj33HPrS
	 QjRwzq+4lPhLBUHifkuKBcS/ywC/bgHnIGNuvzF3Uja+zz6/M90qY4dd3jyAOebLZAfry
	 naQGtjbtGEbgF5PhslASQ09Xy6F3kA+lCLGmjPNTfXyF6IUXPBPgm9QFxDoFKX4WycIQL
	 pVI3zBilmG1S5OqcNOnp90fOnbKza2KDyRsPH92qcEcwnKBLVckGNUjzJQup0eWmJVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=yacoub.de;
	spf=pass smtp.mailfrom=yacoub.de;
	dkim=pass header.d=yacoub.de header.i=@yacoub.de header.a=rsa-sha256 header.s=selector1 header.b=GgBa9Lqp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.118
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023118.outbound.protection.outlook.com [52.101.83.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E129606B14B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E129606B14B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yacoub.de header.i=@yacoub.de header.a=rsa-sha256 header.s=selector1 header.b=GgBa9Lqp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnhYY8UCSJxj4RVVH4Jt79qF/nHxTib6Ri9aVE50QOZ91FSN1UzDv3K4UMLFjeV1DvnSMtQ70HZIvBtZ7xhxCkl1ppwuatWYXWY4/UVDHPah4KI3nMgeJIat1BSMKC951uw35iCzFD6Hu/F3WG3tsNUQ+YCiBc9FsN5OYIcQ3EGvs3hCQGkbMzXXbkcJcUER9M6LkuLcPLwft4at4WfsLDpE6iG0ZIXZAD4JYzmYCbJggHO2VxCphPwjtSYCQyKAcVSTyy34o0Hyg4QwXv/EehuoVzioSJ6u1+n0/DLYKRpn91rvVc7+iRMc3OzYPEvELi1k7g6ONmOuR2SKaa2ZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxsktPIKyMucM0Bz/Paxx4q9YnJdiDyVZzrNC55CRlw=;
 b=k7hLTP9/ye0KSETCJNDWuc95+ituWyDYSX1x5Oq2hfOfYZiwNyQfQJLbr5yfngANR3jgZyDWwoGSBX/p1Rrg2+I2MBmLqOi1BjdA7V7OWrWDHGJtBOZ17JOyOsX3TPKbt4AZlafiDbgnX8HXga80wjP60MPR0kor/gGg6y3033xr3oqD9IDEfJ7WZCxxoKJkaoH0wfsRtcyuc8q6tu85ZXvbPTvKtQEEVd7Fo0sLfCm4TfDsyv1h8MMcg3O5sz5UUlpb+Q+Jqlq1rSCYS/NTo97epNOuCU9GKiysT/86Jnf9iFFZZ6iZs7DdZso50KcxNuxf/nyZuo1RfLdAZaBByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxsktPIKyMucM0Bz/Paxx4q9YnJdiDyVZzrNC55CRlw=;
 b=GgBa9Lqp4A5ljuKZ6/L9CCV63pIuJGVYNS4+wQe33V65vf4dHHjk6rBX7qUZ3ZWv0QrEs+HfpJGEscA4RtT2LUpcA6zMYPfEZZmtsBZlMY/WdJEkT6A8i0RoW0xxfJm+Cu6YV89m9e9rvU/inZ4dKuthpVzqwurJptGS+kqzDY5vdGtevQwlsxdvbkahp6NLeXKo/7bfwkYKLsX/Yrj17g7y6hBbAAZXyh2SJCaOzv+wv94KDPnpm7ZRDyE6HayjmANBB2O5uM5kOYp7foTjdUhgQc4WGSNCs6ZjrHf0FdqGsM9bGMx988Vl9Ac/JPoHlFgxnt7O6UP6RGOx3xUYRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by PA1PR04MB11407.eurprd04.prod.outlook.com (2603:10a6:102:4f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 09:42:17 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 09:42:17 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] microblaze: restore the ABI argument home area below pt_regs (PTO)
Date: Tue, 10 Nov 2026 10:42:11 +0100
Message-ID: <20261110094211.427348-1-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055734-failed-5.15-c35d40a3efd2@kernel.org>
References: <20261107055734-failed-5.15-c35d40a3efd2@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::15) To MRWPR04MB12069.eurprd04.prod.outlook.com
 (2603:10a6:501:99::13)
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|PA1PR04MB11407:EE_
X-MS-Office365-Filtering-Correlation-Id: 0804aa00-11ce-4973-9c6b-08df3f0ee881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|260925021911599003|260925021311599003|260925022911599003|5023799004|11063799006|261021135927099003|56012099006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261022113327099003|261026140227099003|261009223027099003|261028144727099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	OGaws6ueJnP6G/nkRtgAvb85IrB3HLrayNRRYMmnHEM/ZfCxdxhTJo9Ltr824Jno5/fm+cTFUPn9vIA2k+PIiu33M2InrLHwwrEz+Bt0Nkq36lWhEQ/YP9ClfaoIxwb6v8H5jsriqw8i302UjA5e3ksM6n679PZa3ukmL6ihutAE3zpMc8jkcUKQ1it0HU1eq3wP837S5GAeeKKWB4JMven/GAO+XhjSXBBzqqwNZGUpQNRa6kBH76XcwkFqHkOalQrH6S20lb/rWVKek0dUbAo8ItaitJ3tZFF051ECcdqYWzQiD8wTUpG80H3beoib7YhtKu0+VM8hvnsrsNbwGIGsnUGrtkeFCgxqD+5hE6fj/yAUjW/ahEtqjUblvci5NlIwUEHXDiIYaIVE/j8ozgyyMRrqlszfOegrnmLHS4ek9TKX/1GIb87ROlhGK7jA6gieoa6jwHP7U9NbD29IFtyglSw+cBtwdiIjhibo5hI4AOmOU29KxkZ5Vrzpjy5Ds6zC8tCgXxAzXto4grL7go63V7SF2TqmvEJoSj63HoPu4/218yVgTJtucEdwGkJr2Z7trx7kyFDY+aMg5xYMSJ31l2MSZoboVm3WNidY8IM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(260925021911599003)(260925021311599003)(260925022911599003)(5023799004)(11063799006)(261021135927099003)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022113327099003)(261026140227099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0wAsn/TNyUnEuBm3R5dnpIq2b+xJtaUI/BE0VKdbHNwj4DS20xVPaqbjBOtR?=
 =?us-ascii?Q?VbCK2rZbso6LuRh6tAusjXEMyYkPQtvrS4VV8lYOcxFGcjl6IO08fPeQyGvD?=
 =?us-ascii?Q?OyYEThr5VAvdK8SDFXcda8CuVHSDaS8kP+GLBgB1wVHUhmoU8Qw+kkdk1VqY?=
 =?us-ascii?Q?KSJG4ZMSqEMwX86jYZPdANjYIELGnjy/rhRs98kF+bq4Cb1I7941tgGZVLG7?=
 =?us-ascii?Q?8QCMY/Jzakk8GPrt4wbBfH8uxno0Pat2vmwSbkEqRZhxc12+N80S9Padhutb?=
 =?us-ascii?Q?eUEvwU7o71NfUuINvJ828d5NLGyqid0t9nGqmCuuHKivvZSCQGEZIYYqxZhj?=
 =?us-ascii?Q?IHG7lUdSiwnhApjXeWAQfRtrZGLJcYG5pPMAphTEaW3m6+XHvw9Z03jjYOui?=
 =?us-ascii?Q?M/z7QwI7u1lY+4K92eu0Fbh35ZTPOa3eVh2WxvRWl+52HyXsAP0iGwtY7S+B?=
 =?us-ascii?Q?BoKNwLfpLYhBoHhGOgWsGMinB1Amqv+BcVWyIujNytYEUr9PHJsv0JbvS34f?=
 =?us-ascii?Q?RcuqAsIBkt6hEPdYM6Uiru3DO2/6Tlyi+5KNjwDxJTkR/wtlpkhHPkPF2394?=
 =?us-ascii?Q?P7zveWpftA9Hi01koSQhrvCZwK/4BVT1p4kG5lhCaSabccRfE/sEEDl2ChfF?=
 =?us-ascii?Q?5bvFjveuanT6aMWDGQCxraqab3Ve7W9YMe6iUkD9kUG6Z6VooUJ5JZt3efoM?=
 =?us-ascii?Q?bUBsG4nZvlm/8Gx0aa5QUXJdPxjfURFFla4ySlqypN/PDII1Usw9ZZ7yYvlB?=
 =?us-ascii?Q?mvldncDKP0A/RRO1GkVzvaZjcQR5k8Yr1RUDI63AmzMZshLYd48H+DcwbHlx?=
 =?us-ascii?Q?+NGS0lvrE4nfkW5mW9maTqtaGgZ7CZ7rqRVfHUP/kaLnpkOHt4JG64qE37WD?=
 =?us-ascii?Q?G3sOY3dSra/UlNX5TLYpYAaEzgcNvlOe73VmiE2sCbOw5nBwJv/nc4VLe5Fs?=
 =?us-ascii?Q?n93AxAmktRIoeHqx0TUdV6DsVtzGeDHmIBR1WbTLPW/+DcqKMAb40H9TtkA7?=
 =?us-ascii?Q?axtrFLupDqW36ORtcg+DzT4wBASAM0tdy7wsVobQQHfr6tcvRIWBIL3b/sCL?=
 =?us-ascii?Q?oDYGs4hzxNZ4PWASl+QkJT8dP9AphNlh5ndg22r4fEqchCIGT0a1qFAzwyxc?=
 =?us-ascii?Q?bIw7d8LUj/4bQ4ORgRNH00G07v0mt5jOvwV2po9lqtxICwieaiKWhrfHdVUh?=
 =?us-ascii?Q?ge8HeXbAC5tpIA7ZW8sxXuyHz4roVN+U2VmecCY4GO1gWDS6vndLnfYqrCaV?=
 =?us-ascii?Q?h1LGeM5eRIB8QGPlPtjFOi6OA7N09cv0pYPOavMwlRvDl6AIBZWcVHCKyfJ4?=
 =?us-ascii?Q?rz4iSPeZPLvdJ4d0NzaPkHVycwRkIaGuIJ8x4nkXZVXGB9FRRzx/JvGz+Ud8?=
 =?us-ascii?Q?1Kwqv4b/U7XTf5TEXpgrlZ6Fq3VT+GbLO8zRl9YE6Qdz5LmCXOJfVOXwsN4J?=
 =?us-ascii?Q?l/4PB52e0rboQJZkXh1uZtzbEY9wOPIFYXH6cSaaRY81yLhSPhv6MMZJ31Lc?=
 =?us-ascii?Q?8JmBdbaoYmfmxYl6PqNgeUkw9xbRJR9tkRyqUSpOfvjbAXqCfk1dabB+tw5r?=
 =?us-ascii?Q?jPts7tNFWdxuBZFaHxgJtQ7E4AIIFZryrGPBd8DCLOf2OmGbRcc16Hmd7qsS?=
 =?us-ascii?Q?3PAbutq4iwwW2IeIRCK+A2n+dXOjv1GQKce4VXPlW2bsc6I485zzKLMODRGq?=
 =?us-ascii?Q?9zvTrTCy5mOYXCEpR/y/oY/Za8PGr8HS/9FfJuShiiMBVZJKTwqp/1b1tAfP?=
 =?us-ascii?Q?xUUagGVMTJmFSUdOlcPxxJW2mfKMIVM=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0804aa00-11ce-4973-9c6b-08df3f0ee881
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 09:42:17.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSOjTE7w2t0YXmYK0dzQ4o5xAOs0N5SXCIMaomRJ4L317m53RcZ+z9ocR1GIUtKjAN9366S+9kw2MKW7tGnaVu1hZVATQTZIx0s1uM55UXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11407

commit c35d40a3efd2e575ef51a761e983f2bf7113be6c upstream.

The MicroBlaze ABI has the caller reserve stack space for the arguments
it passes in registers: REG_PARM_STACK_SPACE is 24 and
OUTGOING_REG_PARM_STACK_SPACE is 1 in the gcc backend, so a callee may
write to [caller_sp + 4, caller_sp + 28).  The kernel calls C functions
from entry.S with r1 pointing at pt_regs, handing the callee license to
spill its incoming arguments over the saved registers -- the syscall
dispatch is the worst case, where the first argument slot is PT_R1, the
saved user stack pointer.

This was latent until GCC 15: since 3b9b8d6cfdf5 ("ira: Scale
save/restore costs of callee save registers with block frequency") the
allocator prefers spilling incoming arguments over copying them into
callee-saved registers, and a kernel built with gcc >= 15 (without the
TARGET_CALLEE_SAVE_COST workaround some distributions carry) corrupts
PT_R1 on the first syscall: init takes SIGSEGV and the kernel panics.

The kernel had exactly this reservation until 2011:
commit 6e83557c38b4 ("microblaze: Remove r0_ram pointer and PTO alignment")
removed STATE_SAVE_ARG_SPACE and with it the PTO offset, as part of
cleaning up what was thought to be copied-from-v850 leftovers.  Restore
it: the frame is STATE_SAVE_SIZE = PT_SIZE + PTO, r1 stays at the frame
base through every asm-to-C call, and the saved registers are reached
at r1 + PTO + PT_*.  PTO is 28 rather than the historic 24, which was
one word short: FIRST_PARM_OFFSET is 4 and REG_PARM_STACK_SPACE is 24,
so the area spans [sp+4, sp+28) and needs 28 bytes.  With 24 the last
argument slot overlapped pt_regs' r0 -- harmless only because r0 is the
constant-zero register.  STACK_BOUNDARY is 32 bits, so 28 needs no
further rounding.

Two places deliberately keep their mainline addressing.
hw_exception_handler.S needs no offset change: its real-mode handler
saves into the standalone pt_pool_space buffer rather than a stack
frame, and _unaligned_data_exception works through a pointer to pt_regs
in r7, where plain PT_* offsets are already right.  And the user-SP
reload after popping the frame keeps PT_R1 - PT_SIZE because PTO
cancels there: (PTO + PT_R1) - (PT_SIZE + PTO) = PT_R1 - PT_SIZE.  Both
are exactly as the pre-2011 code had them.

The instruction count is unchanged -- the same instructions with
different immediates, no per-call reservation and no trampolines.  The
cost is 28 bytes more kernel stack per saved frame.

Fixes: 6e83557c38b4 ("microblaze: Remove r0_ram pointer and PTO alignment")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
Tested-by: Waldemar Brodkorb <wbx@openadk.org>
Link: https://patch.msgid.link/20260821151809.1233057-5-ramin.moussavi@yacoub.de
Signed-off-by: Michal Simek <michal.simek@amd.com>
---
Prerequisites on this branch.  Two are needed for this patch to apply:

  c5947d28c209 ("microblaze: reserve the ABI argument-home area in the
                 signal frame")
  da6829138a39 ("microblaze: don't clobber r3/r4 restored by rt_sigreturn")

in that order.  Both are queued for this branch but not in it yet.  With them
applied entry.S needs no adjustment at all; without them the cherry-pick
conflicts there, which is what the failure report was about.

Two more are needed before the result can be tested:

  95fee37be45f ("microblaze: Do loop unrolling for optimized memset
                 implementation")
  8f0f265e6cf5 ("microblaze: Use simple memset implementation from
                 lib/string.c")

Without them this branch does not boot at all when built with gcc 10 or later,
so the result cannot be verified: the "while (n--)" loop left in
arch/microblaze/lib/memset.c is turned into a call to memset by
-ftree-loop-distribute-patterns, so memset calls itself and never returns --
no oops, no console output.  Both are in v5.19-rc1 and cherry-pick cleanly.

Tested: built with gcc 16.2.0 and booted under qemu-system-microblaze 11.1.50
(-M petalogix-s3adsp1800,endianness=little); the kernel reaches userspace and
the test suite runs to completion.

Backport changes: the asm/entry.h guard is still __ASSEMBLY__ here; three
entry.S hunks are dropped because the code does not exist on this branch yet
(mb_flush_dcache/mb_invalidate_icache, the CONFIG_MB_MANAGER block and
xmb_inject_err); in process.c only the "- PTO" is taken, since copy_thread
still has usp/arg instead of args->fn/args->fn_arg.

 arch/microblaze/include/asm/entry.h           |  13 +
 arch/microblaze/include/asm/processor.h       |   2 +-
 arch/microblaze/kernel/entry.S                | 277 +++++++++---------
 arch/microblaze/kernel/hw_exception_handler.S |   5 +
 arch/microblaze/kernel/process.c              |   5 +-
 5 files changed, 163 insertions(+), 139 deletions(-)

diff --git a/arch/microblaze/include/asm/entry.h b/arch/microblaze/include/asm/entry.h
index 6c42bed41166..74c5a99a37f8 100644
--- a/arch/microblaze/include/asm/entry.h
+++ b/arch/microblaze/include/asm/entry.h
@@ -21,6 +21,19 @@
 
 #define PER_CPU(var) var
 
+/*
+ * The MicroBlaze ABI has the caller reserve an argument home area:
+ * REG_PARM_STACK_SPACE is 24 and OUTGOING_REG_PARM_STACK_SPACE is 1, so a
+ * callee may write to [caller_sp + 4, caller_sp + 28).  The kernel calls C
+ * with r1 at the frame base, so reserve that area below pt_regs and reach
+ * the saved registers through PTO.  This restores what 6e83557c38b4
+ * ("microblaze: Remove r0_ram pointer and PTO alignment") removed; the old
+ * value of 24 was one word short and left the last argument slot
+ * overlapping pt_regs' r0.
+ */
+#define PTO			28
+#define STATE_SAVE_SIZE		(PT_SIZE + PTO)
+
 # ifndef __ASSEMBLY__
 DECLARE_PER_CPU(unsigned int, KSP); /* Saved kernel stack pointer */
 DECLARE_PER_CPU(unsigned int, KM); /* Kernel/user mode */
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 7e9e92670df3..03a2ae782827 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -78,7 +78,7 @@ unsigned long __get_wchan(struct task_struct *p);
 #  define task_regs(task) ((struct pt_regs *)task_tos(task) - 1)
 
 #  define task_pt_regs_plus_args(tsk) \
-	((void *)task_pt_regs(tsk))
+	(((void *)task_pt_regs(tsk)) - PTO)
 
 #  define task_sp(task)	(task_regs(task)->r1)
 #  define task_pc(task)	(task_regs(task)->pc)
diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index 18028809250f..7a86ec90295c 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -175,78 +175,78 @@ syscall_debug_table:
 1:
 
 #define SAVE_REGS \
-	swi	r2, r1, PT_R2;	/* Save SDA */			\
-	swi	r3, r1, PT_R3;					\
-	swi	r4, r1, PT_R4;					\
-	swi	r5, r1, PT_R5;					\
-	swi	r6, r1, PT_R6;					\
-	swi	r7, r1, PT_R7;					\
-	swi	r8, r1, PT_R8;					\
-	swi	r9, r1, PT_R9;					\
-	swi	r10, r1, PT_R10;					\
-	swi	r11, r1, PT_R11;	/* save clobbered regs after rval */\
-	swi	r12, r1, PT_R12;					\
-	swi	r13, r1, PT_R13;	/* Save SDA2 */			\
-	swi	r14, r1, PT_PC;	/* PC, before IRQ/trap */	\
-	swi	r15, r1, PT_R15;	/* Save LP */			\
-	swi	r16, r1, PT_R16;					\
-	swi	r17, r1, PT_R17;					\
-	swi	r18, r1, PT_R18;	/* Save asm scratch reg */	\
-	swi	r19, r1, PT_R19;					\
-	swi	r20, r1, PT_R20;					\
-	swi	r21, r1, PT_R21;					\
-	swi	r22, r1, PT_R22;					\
-	swi	r23, r1, PT_R23;					\
-	swi	r24, r1, PT_R24;					\
-	swi	r25, r1, PT_R25;					\
-	swi	r26, r1, PT_R26;					\
-	swi	r27, r1, PT_R27;					\
-	swi	r28, r1, PT_R28;					\
-	swi	r29, r1, PT_R29;					\
-	swi	r30, r1, PT_R30;					\
-	swi	r31, r1, PT_R31;	/* Save current task reg */	\
+	swi	r2, r1, PTO+PT_R2;	/* Save SDA */			\
+	swi	r3, r1, PTO+PT_R3;					\
+	swi	r4, r1, PTO+PT_R4;					\
+	swi	r5, r1, PTO+PT_R5;					\
+	swi	r6, r1, PTO+PT_R6;					\
+	swi	r7, r1, PTO+PT_R7;					\
+	swi	r8, r1, PTO+PT_R8;					\
+	swi	r9, r1, PTO+PT_R9;					\
+	swi	r10, r1, PTO+PT_R10;					\
+	swi	r11, r1, PTO+PT_R11;	/* save clobbered regs after rval */\
+	swi	r12, r1, PTO+PT_R12;					\
+	swi	r13, r1, PTO+PT_R13;	/* Save SDA2 */			\
+	swi	r14, r1, PTO+PT_PC;	/* PC, before IRQ/trap */	\
+	swi	r15, r1, PTO+PT_R15;	/* Save LP */			\
+	swi	r16, r1, PTO+PT_R16;					\
+	swi	r17, r1, PTO+PT_R17;					\
+	swi	r18, r1, PTO+PT_R18;	/* Save asm scratch reg */	\
+	swi	r19, r1, PTO+PT_R19;					\
+	swi	r20, r1, PTO+PT_R20;					\
+	swi	r21, r1, PTO+PT_R21;					\
+	swi	r22, r1, PTO+PT_R22;					\
+	swi	r23, r1, PTO+PT_R23;					\
+	swi	r24, r1, PTO+PT_R24;					\
+	swi	r25, r1, PTO+PT_R25;					\
+	swi	r26, r1, PTO+PT_R26;					\
+	swi	r27, r1, PTO+PT_R27;					\
+	swi	r28, r1, PTO+PT_R28;					\
+	swi	r29, r1, PTO+PT_R29;					\
+	swi	r30, r1, PTO+PT_R30;					\
+	swi	r31, r1, PTO+PT_R31;	/* Save current task reg */	\
 	mfs	r11, rmsr;		/* save MSR */			\
-	swi	r11, r1, PT_MSR;
+	swi	r11, r1, PTO+PT_MSR;
 
 #define RESTORE_REGS_GP \
-	lwi	r2, r1, PT_R2;	/* restore SDA */		\
-	lwi	r3, r1, PT_R3;					\
-	lwi	r4, r1, PT_R4;					\
-	lwi	r5, r1, PT_R5;					\
-	lwi	r6, r1, PT_R6;					\
-	lwi	r7, r1, PT_R7;					\
-	lwi	r8, r1, PT_R8;					\
-	lwi	r9, r1, PT_R9;					\
-	lwi	r10, r1, PT_R10;					\
-	lwi	r11, r1, PT_R11;	/* restore clobbered regs after rval */\
-	lwi	r12, r1, PT_R12;					\
-	lwi	r13, r1, PT_R13;	/* restore SDA2 */		\
-	lwi	r14, r1, PT_PC;	/* RESTORE_LINK PC, before IRQ/trap */\
-	lwi	r15, r1, PT_R15;	/* restore LP */		\
-	lwi	r16, r1, PT_R16;					\
-	lwi	r17, r1, PT_R17;					\
-	lwi	r18, r1, PT_R18;	/* restore asm scratch reg */	\
-	lwi	r19, r1, PT_R19;					\
-	lwi	r20, r1, PT_R20;					\
-	lwi	r21, r1, PT_R21;					\
-	lwi	r22, r1, PT_R22;					\
-	lwi	r23, r1, PT_R23;					\
-	lwi	r24, r1, PT_R24;					\
-	lwi	r25, r1, PT_R25;					\
-	lwi	r26, r1, PT_R26;					\
-	lwi	r27, r1, PT_R27;					\
-	lwi	r28, r1, PT_R28;					\
-	lwi	r29, r1, PT_R29;					\
-	lwi	r30, r1, PT_R30;					\
-	lwi	r31, r1, PT_R31;	/* Restore cur task reg */
+	lwi	r2, r1, PTO+PT_R2;	/* restore SDA */		\
+	lwi	r3, r1, PTO+PT_R3;					\
+	lwi	r4, r1, PTO+PT_R4;					\
+	lwi	r5, r1, PTO+PT_R5;					\
+	lwi	r6, r1, PTO+PT_R6;					\
+	lwi	r7, r1, PTO+PT_R7;					\
+	lwi	r8, r1, PTO+PT_R8;					\
+	lwi	r9, r1, PTO+PT_R9;					\
+	lwi	r10, r1, PTO+PT_R10;					\
+	lwi	r11, r1, PTO+PT_R11;	/* restore clobbered regs after rval */\
+	lwi	r12, r1, PTO+PT_R12;					\
+	lwi	r13, r1, PTO+PT_R13;	/* restore SDA2 */		\
+	lwi	r14, r1, PTO+PT_PC;	/* RESTORE_LINK PC, before IRQ/trap */\
+	lwi	r15, r1, PTO+PT_R15;	/* restore LP */		\
+	lwi	r16, r1, PTO+PT_R16;					\
+	lwi	r17, r1, PTO+PT_R17;					\
+	lwi	r18, r1, PTO+PT_R18;	/* restore asm scratch reg */	\
+	lwi	r19, r1, PTO+PT_R19;					\
+	lwi	r20, r1, PTO+PT_R20;					\
+	lwi	r21, r1, PTO+PT_R21;					\
+	lwi	r22, r1, PTO+PT_R22;					\
+	lwi	r23, r1, PTO+PT_R23;					\
+	lwi	r24, r1, PTO+PT_R24;					\
+	lwi	r25, r1, PTO+PT_R25;					\
+	lwi	r26, r1, PTO+PT_R26;					\
+	lwi	r27, r1, PTO+PT_R27;					\
+	lwi	r28, r1, PTO+PT_R28;					\
+	lwi	r29, r1, PTO+PT_R29;					\
+	lwi	r30, r1, PTO+PT_R30;					\
+	lwi	r31, r1, PTO+PT_R31;	/* Restore cur task reg */
 
 #define RESTORE_REGS \
-	lwi	r11, r1, PT_MSR;					\
+	lwi	r11, r1, PTO+PT_MSR;					\
 	mts	rmsr , r11;						\
 	RESTORE_REGS_GP
 
 #define RESTORE_REGS_RTBD \
-	lwi	r11, r1, PT_MSR;					\
+	lwi	r11, r1, PTO+PT_MSR;					\
 	andni	r11, r11, MSR_EIP;          /* clear EIP */             \
 	ori	r11, r11, MSR_EE | MSR_BIP; /* set EE and BIP */        \
 	mts	rmsr , r11;						\
@@ -263,11 +263,11 @@ syscall_debug_table:
 	lwi	r1, r0, TOPHYS(PER_CPU(ENTRY_SP));			\
 	/* FIXME: I can add these two lines to one */			\
 	/* tophys(r1,r1); */						\
-	/* addik	r1, r1, -PT_SIZE; */				\
-	addik	r1, r1, CONFIG_KERNEL_BASE_ADDR - CONFIG_KERNEL_START - PT_SIZE; \
+	/* addik	r1, r1, -STATE_SAVE_SIZE; */				\
+	addik	r1, r1, CONFIG_KERNEL_BASE_ADDR - CONFIG_KERNEL_START - STATE_SAVE_SIZE; \
 	SAVE_REGS							\
 	brid	2f;							\
-	swi	r1, r1, PT_MODE; 	 				\
+	swi	r1, r1, PTO+PT_MODE; 	 				\
 1:	/* User-mode state save.  */					\
 	lwi	r1, r0, TOPHYS(PER_CPU(CURRENT_SAVE)); /* get saved current */\
 	tophys(r1,r1);							\
@@ -275,12 +275,13 @@ syscall_debug_table:
 	/* MS these three instructions can be added to one */		\
 	/* addik	r1, r1, THREAD_SIZE; */				\
 	/* tophys(r1,r1); */						\
-	/* addik	r1, r1, -PT_SIZE; */			\
-	addik r1, r1, THREAD_SIZE + CONFIG_KERNEL_BASE_ADDR - CONFIG_KERNEL_START - PT_SIZE; \
+	/* addik	r1, r1, -STATE_SAVE_SIZE; */			\
+	addik r1, r1, THREAD_SIZE + CONFIG_KERNEL_BASE_ADDR		\
+		- CONFIG_KERNEL_START - STATE_SAVE_SIZE;		\
 	SAVE_REGS							\
 	lwi	r11, r0, TOPHYS(PER_CPU(ENTRY_SP));			\
-	swi	r11, r1, PT_R1; /* Store user SP.  */		\
-	swi	r0, r1, PT_MODE; /* Was in user-mode.  */		\
+	swi	r11, r1, PTO+PT_R1; /* Store user SP.  */		\
+	swi	r0, r1, PTO+PT_MODE; /* Was in user-mode.  */		\
 	/* MS: I am clearing UMS even in case when I come from kernel space */ \
 	clear_ums; 							\
 2:	lwi	CURRENT_TASK, r0, TOPHYS(PER_CPU(CURRENT_SAVE));
@@ -310,18 +311,18 @@ C_ENTRY(_user_exception):
 	addik	r1, r1, THREAD_SIZE;
 	tophys(r1,r1);
 
-	addik	r1, r1, -PT_SIZE; /* Make room on the stack.  */
+	addik	r1, r1, -STATE_SAVE_SIZE; /* Make room on the stack.  */
 	SAVE_REGS
-	swi	r0, r1, PT_R3
-	swi	r0, r1, PT_R4
+	swi	r0, r1, PTO+PT_R3
+	swi	r0, r1, PTO+PT_R4
 
-	swi	r0, r1, PT_MODE;			/* Was in user-mode. */
+	swi	r0, r1, PTO+PT_MODE;			/* Was in user-mode. */
 	lwi	r11, r0, TOPHYS(PER_CPU(ENTRY_SP));
-	swi	r11, r1, PT_R1;		/* Store user SP.  */
+	swi	r11, r1, PTO+PT_R1;		/* Store user SP.  */
 	clear_ums;
 2:	lwi	CURRENT_TASK, r0, TOPHYS(PER_CPU(CURRENT_SAVE));
 	/* Save away the syscall number.  */
-	swi	r12, r1, PT_R0;
+	swi	r12, r1, PTO+PT_R0;
 	tovirt(r1,r1)
 
 /* where the trap should return need -8 to adjust for rtsd r15, 8*/
@@ -340,18 +341,18 @@ C_ENTRY(_user_exception):
 	beqi	r11, 4f
 
 	addik	r3, r0, -ENOSYS
-	swi	r3, r1, PT_R3
+	swi	r3, r1, PTO+PT_R3
 	brlid	r15, do_syscall_trace_enter
-	addik	r5, r1, PT_R0
+	addik	r5, r1, PTO+PT_R0
 
 	# do_syscall_trace_enter returns the new syscall nr.
 	addk	r12, r0, r3
-	lwi	r5, r1, PT_R5;
-	lwi	r6, r1, PT_R6;
-	lwi	r7, r1, PT_R7;
-	lwi	r8, r1, PT_R8;
-	lwi	r9, r1, PT_R9;
-	lwi	r10, r1, PT_R10;
+	lwi	r5, r1, PTO+PT_R5;
+	lwi	r6, r1, PTO+PT_R6;
+	lwi	r7, r1, PTO+PT_R7;
+	lwi	r8, r1, PTO+PT_R8;
+	lwi	r9, r1, PTO+PT_R9;
+	lwi	r10, r1, PTO+PT_R10;
 4:
 /* Jump to the appropriate function for the system call number in r12
  * (r12 is not preserved), or return an error if r12 is not valid.
@@ -392,8 +393,8 @@ C_ENTRY(_user_exception):
 /* Entry point used to return from a syscall/trap */
 /* We re-enable BIP bit before state restore */
 C_ENTRY(ret_from_trap):
-	swi	r3, r1, PT_R3
-	swi	r4, r1, PT_R4
+	swi	r3, r1, PTO+PT_R3
+	swi	r4, r1, PTO+PT_R4
 /*
  * Entry point for returns that must not store r3/r4 back into pt_regs,
  * i.e. rt_sigreturn, which has already restored them from the signal
@@ -401,7 +402,7 @@ C_ENTRY(ret_from_trap):
  * so it stays correct if the number of stores above ever changes.
  */
 ret_from_trap_no_rval:
-	lwi	r11, r1, PT_MODE;
+	lwi	r11, r1, PTO+PT_MODE;
 /* See if returning to kernel mode, if so, skip resched &c.  */
 	bnei	r11, 2f;
 	/* We're returning to user mode, so check for various conditions that
@@ -413,7 +414,7 @@ ret_from_trap_no_rval:
 	beqi	r11, 1f
 
 	brlid	r15, do_syscall_trace_leave
-	addik	r5, r1, PT_R0
+	addik	r5, r1, PTO+PT_R0
 1:
 	/* We're returning to user mode, so check for various conditions that
 	 * trigger rescheduling. */
@@ -432,7 +433,7 @@ ret_from_trap_no_rval:
 	andi	r11, r19, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME;
 	beqi	r11, 4f;		/* Signals to handle, handle them */
 
-	addik	r5, r1, 0;		/* Arg 1: struct pt_regs *regs */
+	addik	r5, r1, PTO;		/* Arg 1: struct pt_regs *regs */
 	bralid	r15, do_notify_resume;	/* Handle any signals */
 	add	r6, r30, r0;		/* Arg 2: int in_syscall */
 	add	r30, r0, r0		/* no more restarts */
@@ -444,7 +445,11 @@ ret_from_trap_no_rval:
 	VM_OFF;
 	tophys(r1,r1);
 	RESTORE_REGS_RTBD;
-	addik	r1, r1, PT_SIZE		/* Clean up stack space.  */
+	addik	r1, r1, STATE_SAVE_SIZE		/* Clean up stack space.  */
+	/*
+	 * Deliberately PT_SIZE, not STATE_SAVE_SIZE: r1 is back at the stack
+	 * top, so PTO cancels and the saved SP sits at PT_R1 - PT_SIZE.
+	 */
 	lwi	r1, r1, PT_R1 - PT_SIZE;/* Restore user stack pointer. */
 	bri	6f;
 
@@ -453,7 +458,7 @@ ret_from_trap_no_rval:
 	VM_OFF;
 	tophys(r1,r1);
 	RESTORE_REGS_RTBD;
-	addik	r1, r1, PT_SIZE		/* Clean up stack space.  */
+	addik	r1, r1, STATE_SAVE_SIZE		/* Clean up stack space.  */
 	tovirt(r1,r1);
 6:
 TRAP_return:		/* Make global symbol for debugging */
@@ -494,7 +499,7 @@ C_ENTRY(sys_rt_sigreturn_wrapper):
 	 */
 	addik	r15, r0, ret_from_trap_no_rval - 8
 	brid	sys_rt_sigreturn	/* Do real work */
-	addik	r5, r1, 0;		/* add user context as 1st arg */
+	addik	r5, r1, PTO;		/* add user context as 1st arg */
 
 /*
  * HW EXCEPTION rutine start
@@ -505,7 +510,7 @@ C_ENTRY(full_exception_trap):
 	addik	r17, r17, -4
 	SAVE_STATE /* Save registers */
 	/* PC, before IRQ/trap - this is one instruction above */
-	swi	r17, r1, PT_PC;
+	swi	r17, r1, PTO+PT_PC;
 	tovirt(r1,r1)
 	/* FIXME this can be store directly in PT_ESR reg.
 	 * I tested it but there is a fault */
@@ -515,7 +520,7 @@ C_ENTRY(full_exception_trap):
 	mfs	r7, rfsr;		/* save FSR */
 	mts	rfsr, r0;	/* Clear sticky fsr */
 	rted	r0, full_exception
-	addik	r5, r1, 0		 /* parameter struct pt_regs * regs */
+	addik	r5, r1, PTO		 /* parameter struct pt_regs * regs */
 
 /*
  * Unaligned data trap.
@@ -541,14 +546,14 @@ C_ENTRY(unaligned_data_trap):
 	lwi	r11, r0, TOPHYS(PER_CPU(ENTRY_SP));
 	SAVE_STATE		/* Save registers.*/
 	/* PC, before IRQ/trap - this is one instruction above */
-	swi	r17, r1, PT_PC;
+	swi	r17, r1, PTO+PT_PC;
 	tovirt(r1,r1)
 	/* where the trap should return need -8 to adjust for rtsd r15, 8 */
 	addik	r15, r0, ret_from_exc-8
 	mfs	r3, resr		/* ESR */
 	mfs	r4, rear		/* EAR */
 	rtbd	r0, _unaligned_data_exception
-	addik	r7, r1, 0		/* parameter struct pt_regs * regs */
+	addik	r7, r1, PTO		/* parameter struct pt_regs * regs */
 
 /*
  * Page fault traps.
@@ -571,30 +576,30 @@ C_ENTRY(unaligned_data_trap):
 C_ENTRY(page_fault_data_trap):
 	SAVE_STATE		/* Save registers.*/
 	/* PC, before IRQ/trap - this is one instruction above */
-	swi	r17, r1, PT_PC;
+	swi	r17, r1, PTO+PT_PC;
 	tovirt(r1,r1)
 	/* where the trap should return need -8 to adjust for rtsd r15, 8 */
 	addik	r15, r0, ret_from_exc-8
 	mfs	r6, rear		/* parameter unsigned long address */
 	mfs	r7, resr		/* parameter unsigned long error_code */
 	rted	r0, do_page_fault
-	addik	r5, r1, 0		/* parameter struct pt_regs * regs */
+	addik	r5, r1, PTO		/* parameter struct pt_regs * regs */
 
 C_ENTRY(page_fault_instr_trap):
 	SAVE_STATE		/* Save registers.*/
 	/* PC, before IRQ/trap - this is one instruction above */
-	swi	r17, r1, PT_PC;
+	swi	r17, r1, PTO+PT_PC;
 	tovirt(r1,r1)
 	/* where the trap should return need -8 to adjust for rtsd r15, 8 */
 	addik	r15, r0, ret_from_exc-8
 	mfs	r6, rear		/* parameter unsigned long address */
 	ori	r7, r0, 0		/* parameter unsigned long error_code */
 	rted	r0, do_page_fault
-	addik	r5, r1, 0		/* parameter struct pt_regs * regs */
+	addik	r5, r1, PTO		/* parameter struct pt_regs * regs */
 
 /* Entry point used to return from an exception.  */
 C_ENTRY(ret_from_exc):
-	lwi	r11, r1, PT_MODE;
+	lwi	r11, r1, PTO+PT_MODE;
 	bnei	r11, 2f;		/* See if returning to kernel mode, */
 					/* ... if so, skip resched &c.  */
 
@@ -626,7 +631,7 @@ C_ENTRY(ret_from_exc):
 	 * complete register state.  Here we save anything not saved by
 	 * the normal entry sequence, so that it may be safely restored
 	 * (in a possibly modified form) after do_notify_resume returns. */
-	addik	r5, r1, 0;		/* Arg 1: struct pt_regs *regs */
+	addik	r5, r1, PTO;		/* Arg 1: struct pt_regs *regs */
 	bralid	r15, do_notify_resume;	/* Handle any signals */
 	addi	r6, r0, 0;		/* Arg 2: int in_syscall */
 	bri	1b
@@ -638,7 +643,7 @@ C_ENTRY(ret_from_exc):
 	tophys(r1,r1);
 
 	RESTORE_REGS_RTBD;
-	addik	r1, r1, PT_SIZE		/* Clean up stack space.  */
+	addik	r1, r1, STATE_SAVE_SIZE		/* Clean up stack space.  */
 
 	lwi	r1, r1, PT_R1 - PT_SIZE; /* Restore user stack pointer. */
 	bri	6f;
@@ -647,7 +652,7 @@ C_ENTRY(ret_from_exc):
 	VM_OFF;
 	tophys(r1,r1);
 	RESTORE_REGS_RTBD;
-	addik	r1, r1, PT_SIZE		/* Clean up stack space.  */
+	addik	r1, r1, STATE_SAVE_SIZE		/* Clean up stack space.  */
 
 	tovirt(r1,r1);
 6:
@@ -680,10 +685,10 @@ C_ENTRY(_interrupt):
 	tophys(r1,r1); /* MS: I have in r1 physical address where stack is */
 	/* save registers */
 /* MS: Make room on the stack -> activation record */
-	addik	r1, r1, -PT_SIZE;
+	addik	r1, r1, -STATE_SAVE_SIZE;
 	SAVE_REGS
 	brid	2f;
-	swi	r1, r1, PT_MODE; /* 0 - user mode, 1 - kernel mode */
+	swi	r1, r1, PTO+PT_MODE; /* 0 - user mode, 1 - kernel mode */
 1:
 /* User-mode state save. */
  /* MS: get the saved current */
@@ -693,23 +698,23 @@ C_ENTRY(_interrupt):
 	addik	r1, r1, THREAD_SIZE;
 	tophys(r1,r1);
 	/* save registers */
-	addik	r1, r1, -PT_SIZE;
+	addik	r1, r1, -STATE_SAVE_SIZE;
 	SAVE_REGS
 	/* calculate mode */
-	swi	r0, r1, PT_MODE;
+	swi	r0, r1, PTO+PT_MODE;
 	lwi	r11, r0, TOPHYS(PER_CPU(ENTRY_SP));
-	swi	r11, r1, PT_R1;
+	swi	r11, r1, PTO+PT_R1;
 	clear_ums;
 2:
 	lwi	CURRENT_TASK, r0, TOPHYS(PER_CPU(CURRENT_SAVE));
 	tovirt(r1,r1)
 	addik	r15, r0, irq_call;
 irq_call:rtbd	r0, do_IRQ;
-	addik	r5, r1, 0;
+	addik	r5, r1, PTO;
 
 /* MS: we are in virtual mode */
 ret_from_irq:
-	lwi	r11, r1, PT_MODE;
+	lwi	r11, r1, PTO+PT_MODE;
 	bnei	r11, 2f;
 
 1:
@@ -725,7 +730,7 @@ ret_from_irq:
 5:	andi	r11, r19, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME;
 	beqid	r11, no_intr_resched
 /* Handle a signal return; Pending signals should be in r18. */
-	addik	r5, r1, 0; /* Arg 1: struct pt_regs *regs */
+	addik	r5, r1, PTO; /* Arg 1: struct pt_regs *regs */
 	bralid	r15, do_notify_resume;	/* Handle any signals */
 	addi	r6, r0, 0; /* Arg 2: int in_syscall */
 	bri	1b
@@ -738,7 +743,7 @@ no_intr_resched:
 	VM_OFF;
 	tophys(r1,r1);
 	RESTORE_REGS
-	addik	r1, r1, PT_SIZE /* MS: Clean up stack space. */
+	addik	r1, r1, STATE_SAVE_SIZE /* MS: Clean up stack space. */
 	lwi	r1, r1, PT_R1 - PT_SIZE;
 	bri	6f;
 /* MS: Return to kernel state. */
@@ -761,7 +766,7 @@ restore:
 	VM_OFF /* MS: turn off MMU */
 	tophys(r1,r1)
 	RESTORE_REGS
-	addik	r1, r1, PT_SIZE	/* MS: Clean up stack space. */
+	addik	r1, r1, STATE_SAVE_SIZE	/* MS: Clean up stack space. */
 	tovirt(r1,r1);
 6:
 IRQ_return: /* MS: Make global symbol for debugging */
@@ -784,28 +789,28 @@ C_ENTRY(_debug_exception):
 	lwi	r1, r0, TOPHYS(PER_CPU(ENTRY_SP)); /* Reload kernel stack-ptr*/
 
 	/* BIP bit is set on entry, no interrupts can occur */
-	addik   r1, r1, CONFIG_KERNEL_BASE_ADDR - CONFIG_KERNEL_START - PT_SIZE;
+	addik   r1, r1, CONFIG_KERNEL_BASE_ADDR - CONFIG_KERNEL_START - STATE_SAVE_SIZE;
 	SAVE_REGS;
 	/* save all regs to pt_reg structure */
-	swi	r0, r1, PT_R0;	/* R0 must be saved too */
-	swi	r14, r1, PT_R14	/* rewrite saved R14 value */
-	swi	r16, r1, PT_PC; /* PC and r16 are the same */
+	swi	r0, r1, PTO+PT_R0;	/* R0 must be saved too */
+	swi	r14, r1, PTO+PT_R14	/* rewrite saved R14 value */
+	swi	r16, r1, PTO+PT_PC; /* PC and r16 are the same */
 	/* save special purpose registers to pt_regs */
 	mfs	r11, rear;
-	swi	r11, r1, PT_EAR;
+	swi	r11, r1, PTO+PT_EAR;
 	mfs	r11, resr;
-	swi	r11, r1, PT_ESR;
+	swi	r11, r1, PTO+PT_ESR;
 	mfs	r11, rfsr;
-	swi	r11, r1, PT_FSR;
+	swi	r11, r1, PTO+PT_FSR;
 
 	/* stack pointer is in physical address at it is decrease
-	 * by PT_SIZE but we need to get correct R1 value */
-	addik   r11, r1, CONFIG_KERNEL_START - CONFIG_KERNEL_BASE_ADDR + PT_SIZE;
-	swi	r11, r1, PT_R1
+	 * by STATE_SAVE_SIZE but we need to get correct R1 value */
+	addik   r11, r1, CONFIG_KERNEL_START - CONFIG_KERNEL_BASE_ADDR + STATE_SAVE_SIZE;
+	swi	r11, r1, PTO+PT_R1
 	/* MS: r31 - current pointer isn't changed */
 	tovirt(r1,r1)
 #ifdef CONFIG_KGDB
-	addi	r5, r1, 0 /* pass pt_reg address as the first arg */
+	addi	r5, r1, PTO /* pass pt_reg address as the first arg */
 	addik	r15, r0, dbtrap_call; /* return address */
 	rtbd	r0, microblaze_kgdb_break
 	nop;
@@ -821,16 +826,16 @@ C_ENTRY(_debug_exception):
 	addik	r1, r1, THREAD_SIZE;	/* calculate kernel stack pointer */
 	tophys(r1,r1);
 
-	addik	r1, r1, -PT_SIZE; /* Make room on the stack.  */
+	addik	r1, r1, -STATE_SAVE_SIZE; /* Make room on the stack.  */
 	SAVE_REGS;
-	swi	r16, r1, PT_PC;	/* Save LP */
-	swi	r0, r1, PT_MODE; /* Was in user-mode.  */
+	swi	r16, r1, PTO+PT_PC;	/* Save LP */
+	swi	r0, r1, PTO+PT_MODE; /* Was in user-mode.  */
 	lwi	r11, r0, TOPHYS(PER_CPU(ENTRY_SP));
-	swi	r11, r1, PT_R1; /* Store user SP.  */
+	swi	r11, r1, PTO+PT_R1; /* Store user SP.  */
 	lwi	CURRENT_TASK, r0, TOPHYS(PER_CPU(CURRENT_SAVE));
 	tovirt(r1,r1)
 	set_vms;
-	addik	r5, r1, 0;
+	addik	r5, r1, PTO;
 	addik	r15, r0, dbtrap_call;
 dbtrap_call: /* Return point for kernel/user entry + 8 because of rtsd r15, 8 */
 	rtbd	r0, sw_exception
@@ -838,7 +843,7 @@ dbtrap_call: /* Return point for kernel/user entry + 8 because of rtsd r15, 8 */
 
 	/* MS: The first instruction for the second part of the gdb/kgdb */
 	set_bip; /* Ints masked for state restore */
-	lwi	r11, r1, PT_MODE;
+	lwi	r11, r1, PTO+PT_MODE;
 	bnei	r11, 2f;
 /* MS: Return to user space - gdb */
 1:
@@ -857,7 +862,7 @@ dbtrap_call: /* Return point for kernel/user entry + 8 because of rtsd r15, 8 */
 5:	andi	r11, r19, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME;
 	beqi	r11, 4f;		/* Signals to handle, handle them */
 
-	addik	r5, r1, 0;		/* Arg 1: struct pt_regs *regs */
+	addik	r5, r1, PTO;		/* Arg 1: struct pt_regs *regs */
 	bralid	r15, do_notify_resume;	/* Handle any signals */
 	addi  r6, r0, 0;	/* Arg 2: int in_syscall */
 	bri	1b
@@ -868,7 +873,7 @@ dbtrap_call: /* Return point for kernel/user entry + 8 because of rtsd r15, 8 */
 	tophys(r1,r1);
 	/* MS: Restore all regs */
 	RESTORE_REGS_RTBD
-	addik	r1, r1, PT_SIZE	 /* Clean up stack space */
+	addik	r1, r1, STATE_SAVE_SIZE	 /* Clean up stack space */
 	lwi	r1, r1, PT_R1 - PT_SIZE; /* Restore user stack pointer */
 DBTRAP_return_user: /* MS: Make global symbol for debugging */
 	rtbd	r16, 0; /* MS: Instructions to return from a debug trap */
@@ -879,9 +884,9 @@ DBTRAP_return_user: /* MS: Make global symbol for debugging */
 	tophys(r1,r1);
 	/* MS: Restore all regs */
 	RESTORE_REGS_RTBD
-	lwi	r14, r1, PT_R14;
-	lwi	r16, r1, PT_PC;
-	addik	r1, r1, PT_SIZE; /* MS: Clean up stack space */
+	lwi	r14, r1, PTO+PT_R14;
+	lwi	r16, r1, PTO+PT_PC;
+	addik	r1, r1, STATE_SAVE_SIZE; /* MS: Clean up stack space */
 	tovirt(r1,r1);
 DBTRAP_return_kernel: /* MS: Make global symbol for debugging */
 	rtbd	r16, 0; /* MS: Instructions to return from a debug trap */
diff --git a/arch/microblaze/kernel/hw_exception_handler.S b/arch/microblaze/kernel/hw_exception_handler.S
index 07ea23965f81..4693916be526 100644
--- a/arch/microblaze/kernel/hw_exception_handler.S
+++ b/arch/microblaze/kernel/hw_exception_handler.S
@@ -313,6 +313,11 @@ _MB_HW_ExceptionVectorTable:
 .align 4
 .ent _hw_exception_handler
 _hw_exception_handler:
+	/*
+	 * This handler saves into the static pt_pool_space buffer, not into a
+	 * stack frame, so the plain PT_* offsets are right here -- do not add
+	 * the PTO of entry.S's frames.
+	 */
 	swi	r1, r0, TOPHYS(pt_pool_space + PT_R1); /* GET_SP */
 	/* Save date to kernel memory. Here is the problem
 	 * when you came from user space */
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 5e2b91c1e8ce..578aa49a06e7 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -20,6 +20,7 @@
 #include <linux/ptrace.h>
 #include <linux/uaccess.h> /* for USER_DS macros */
 #include <asm/cacheflush.h>
+#include <asm/entry.h>
 
 void show_regs(struct pt_regs *regs)
 {
@@ -64,7 +65,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 		 * the registers. That's OK for a brand new thread.*/
 		memset(childregs, 0, sizeof(struct pt_regs));
 		memset(&ti->cpu_context, 0, sizeof(struct cpu_context));
-		ti->cpu_context.r1  = (unsigned long)childregs;
+		ti->cpu_context.r1  = (unsigned long)childregs - PTO;
 		ti->cpu_context.r20 = (unsigned long)usp; /* fn */
 		ti->cpu_context.r19 = (unsigned long)arg;
 		childregs->pt_mode = 1;
@@ -78,7 +79,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 		childregs->r1 = usp;
 
 	memset(&ti->cpu_context, 0, sizeof(struct cpu_context));
-	ti->cpu_context.r1 = (unsigned long)childregs;
+	ti->cpu_context.r1 = (unsigned long)childregs - PTO;
 	childregs->msr |= MSR_UMS;
 
 	/* we should consider the fact that childregs is a copy of the parent
-- 
2.53.0

