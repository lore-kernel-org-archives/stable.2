Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.103
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794303114;
	b=kUr0x/HE05ucVtqkUomA9Ju6XhWsLdhGlXklK7H4djJxAFt8VI3Dk6n5M65HAKaer0E+
	 yMy8A87SmhHeG5VZyRHc+2GgqMcY8sq6QF4c2ApdaBSEMULUTQWmSeklbKhasHNRLNG8h
	 VgGIOpYJKIVjplaFEIv3VOSEctvi89cPo+vehsflwksBHt1h4WdaEkRgYjSQ8jutMdjpP
	 bX7Lk0aNXXoBxiYiH5NIMhhSQ8TNfBolT0snUlEQF/Y/9/08isQ7JAR10pQ+s+w+aECMv
	 HIVYj+XsouZG4se3VyhNpvgwdaQDJx5zo60wNa2w5bAOJJUta/RFN0m8wwVvWO8nOfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303114;
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
	bh=oQ1apdOlVETrEp170Baj/r/H8NcS67o5kIf1wJFHCz0=;
	b=eWQMFesSvyfUOsIabgumVVOSUfLBX8nFK3So0+ewwWXjzRKke6PZ4XBK9uhnGY79/0XN
	 gxQwnGw/0mK8d4/uBTL6KQns6HWfrszh5N1Ihb1TjxdUbWtZAebs2nhpY970ww/CJry6Y
	 khur4XeHZRrkanKFE6lXspq2y/5Q9ab4dVZjLpofJ6QGu/k1rmqh/sJDmgtdLbAn/bW3m
	 oYQ0o/lxJYgUyKbU79pwdNdSbIT/NpCVZBKlJVIlG0kQb2/aryxvREmNDv4jkDQXzgjlK
	 Tghs+uQvU+9r7NomzhNs9YWcmu6kN7hhHI7eunLKAKxmooiOZictjLJLO+5KCpDS64Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=yacoub.de;
	spf=pass smtp.mailfrom=yacoub.de;
	dkim=pass header.d=yacoub.de header.i=@yacoub.de header.a=rsa-sha256 header.s=selector1 header.b=n16KMOLI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.103
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023103.outbound.protection.outlook.com [40.107.162.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE0606CF8B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECAE0606CF8B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yacoub.de header.i=@yacoub.de header.a=rsa-sha256 header.s=selector1 header.b=n16KMOLI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5zCSO/49hsalU1QMOxR4lshJfDU7VthhPrTLovKvCCUfbk4Vx4aLTOxWh0ylbDHPJDjJqnbeXFbqHbjrq3k/OjsVKg90GtWb2PrPa3GZgZbNN4cJ0RH0AD6TRJcJGGOV6OeKDbWNj1YwsZu+/MlzPfrPjePQLEStiQFGOZC3csYQNl0Os5ynImyOBpy6Pv5ErbVOqisMaIv/aoKsCWNjiMXakgyX0FrAexTkCN+8yeTj8jyn3DAGZhruChqqraCeS/QgiKbyKp6LW5OlbrH3dCNVuMDDQc0DtQ/Ngc1ZKQ4t0BY6nfZ1b6U5s5uiousaUZpU3+lGcaPbZtgUg4XRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ1apdOlVETrEp170Baj/r/H8NcS67o5kIf1wJFHCz0=;
 b=CH3U0CtZ+FlR8LaMgvloroiMmn7Q5Ay8yWMhM9xz66JO5p5AIU8yFINQgKVIO/VC/HHKb1SCplb2Ox6eXB17R+IbPiu4tBs/hqFom7+YYer2TzkLCkAmZLjolsQvHuVhY2LOYGUb/QGoKg8ZmmCdqYx2NGMU9SM35OCvlqk8VA1ybkcoGADs10n3iCQq5B+Vq2LVmXEgHDHZiJYPeXgFJwhQfJY69pde2BnzPRPpLP/exrg7zWDh/7EVEsLH+LELwwOvTqAbLqqDHdveLlBBVZDM3euYxOPDIUFGlXPoQRYK469HR3hnwBOotEHtYFCbcrEQn/yLWw+nVgisTQ8TIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ1apdOlVETrEp170Baj/r/H8NcS67o5kIf1wJFHCz0=;
 b=n16KMOLIt4sWzdl3HBJawDou59EP0gI0mK7eXZOlD+i0xk7fqDc8MOM2GSIoKgxDpi/+G5xLc4UW1d2FsSo9EF7KLVS+hztHhqmknHGCjmBn1BlgNxZD3eL81wRMRIukIzEdTvHI48Yf5zRYTNCeccHq/t57PBTzcnElHANYqnbD/KSl+DZu3gea+tCiLV/CcUF65DSSl6nkNxWJFdr51kyh2JzmIjhPOoikuw0yqKz4GmqCYfC1PthN+WSicU1C5r4EUw6SN/5aGfJJQp+18/I7W31vwFGrFMhniTv0E2OZkCTeZYQbX4h8524pmXufQiTbVidChPPQDVi+dv7uxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by MIWPR04MB225290.eurprd04.prod.outlook.com (2603:10a6:290:90::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 09:31:49 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 09:31:49 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] microblaze: restore the ABI argument home area below pt_regs (PTO)
Date: Tue, 10 Nov 2026 10:31:42 +0100
Message-ID: <20261110093142.424751-1-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052827-failed-6.6-c35d40a3efd2@kernel.org>
References: <20261107052827-failed-6.6-c35d40a3efd2@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To MRWPR04MB12069.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|MIWPR04MB225290:EE_
X-MS-Office365-Filtering-Correlation-Id: db60d390-a1c3-4db0-4999-08df3f0d71f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|6133799003|18002099003|3023799007|261026140227099003|56012099006|5023799004|11063799006|261022105027099003|261028144727099003|261021121427099003|261022113327099003|261021135927099003|261102123227099003|261021123027099003|261009223027099003|10067099003|261022075727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	XgN5hFgM3zg72jT0BlC+8FKRiMXv8q6gOwAyYwU5PukKFOordOeID5VxYoPbYIrAK0x99vrae+ynnTm13SRzi0/IkEZHFVZpEVZ6Ob7mhZ4huyFxDibDaFDwh+ZxfkjSQ+QjjacE9HvkQwsaVo4NCU1B7Jyt60/dvPptHweaoW+297v8g1zBi/CtbDNn800datI8fzBKfYyhg8qa3N/kI9cZVuWnoT54TeZ3n7ElwMFbMZFC6pUbnB5AN6AW5XVeNAYoANnkeUVO3ZP+x1YNDEKBlTg2rcQyAB18qv7azY3xmvkZcP7dDGRKEIIGuwjVD/pmfJ19RJ5VGQ5swfMQObJBI7QZVDlVcsXVCcXE90R81lK0rrAJ01LjYjRDetk2LTzM3wJ01ABkzbmbwg51AoZLV0z3ei6g5l9g2DWPxqWSS7qy58TkL41BNJ4p6SlXbjqH1RQSLZBDBgdf2T9qj7W4Y+MCUmz39AQUalUaPOuKMj0i0Oon7c173cFEHC0KCm+QscxkJSe9xsjxgQspcX6hnl7OYOISSn1XP0cc7zXtRITJPTGnWiDwgZ4jv6O2b6ZFJdl7kD6ip2I47a3XiYKg/wKHwnE6B8h9/z4Rl0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(6133799003)(18002099003)(3023799007)(261026140227099003)(56012099006)(5023799004)(11063799006)(261022105027099003)(261028144727099003)(261021121427099003)(261022113327099003)(261021135927099003)(261102123227099003)(261021123027099003)(261009223027099003)(10067099003)(261022075727099003)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L9wKCDQ87xtZwu8wGH4E0l1a2VjSJohLCcol8mxoAleIMElxvBGHqPDJDd2K?=
 =?us-ascii?Q?8qXw3bkZ5AworE+tyP52u9kktCrijqsDlQSuxpvVc4euJVyVVpnxp7f3Bzkj?=
 =?us-ascii?Q?LdscLff8qdTgcLI0QI6+UFtpsjTVXjlcwMCL8C/Bj+rdoSyYCuZ9/Aohz10c?=
 =?us-ascii?Q?EKfJjC3xf06uTGyIw+3DTg1Fm1dG1hVGifNcFfg6qWarzd6QtVv83JzBxYF6?=
 =?us-ascii?Q?i5ikXjthrjOggnyaYgxqDXJmMq7NWEoaYxgd3asrG9IlIyvQkGftJmdx0JWU?=
 =?us-ascii?Q?o2RcY0B3/IBrgtjnkoy6cYL4KXp+nCaVoGH4gHeXHrmX6xO7Rwyfe7QdHHBo?=
 =?us-ascii?Q?zXI5O4Wf/Aw+i2EjOFcl+53OOZohLwI+ndIyB+BY6gfR0mx3XL7bbhtoZLbM?=
 =?us-ascii?Q?0HNTSA/OKaMMit6Dvjub48ulPB2hNy6dOdvmX989K0Gb1QoBkpun8NjMig14?=
 =?us-ascii?Q?HqbEh77FubiHSnsCEZMk8spCjR4FJl/p03XSzdIfLluuU4PEULFZPkQp7bov?=
 =?us-ascii?Q?VY8McRF2wXppGJQo16seqNlrQUaR+SWFJEQ4rbqACBWp6GrUsJtD1MmQP8Cy?=
 =?us-ascii?Q?Oe0ecdSUSkiTjmuT/CEJAgKrTPdujtgXTvqNRvzcQPuCLQRCN4kBQGE/Q7xh?=
 =?us-ascii?Q?x8GRam0wGYPUquakGI+DQwKpl1mVOSC9tvhzCcgtdKAea46TvPi6Y5TikIuD?=
 =?us-ascii?Q?fcHtKXN2R4vEY+rAEl7AS5fvwYPeA1UQIvukC4UixNFoGechWtEFvihs4X8/?=
 =?us-ascii?Q?AIvROjd/c3LLVFPPgp/heSvL6fQYuK9hKL38wcmPncYZIHCeYwKCmK7eFVYP?=
 =?us-ascii?Q?0T/QWqzsaA4e0M3lhL/zzLP4Si1D56ajtvYvUuiVfT01aEABmqb9etiCniHH?=
 =?us-ascii?Q?GSNFc9BDKoojNzcOYdpL5uz6WY4CO30+ncj5bvBqSy+490c27hThJNRrzJxb?=
 =?us-ascii?Q?Z82dtM7ONT2zzdvVhvK62ao4TSdD+8dcbYky7rVZVcVdsycdR8wtRF20JlBt?=
 =?us-ascii?Q?cUSGD+zlDT7irRim8IBGbRWU3hI64h1wbxS6/H+pXoag5kKiI6mCGBvp6GiQ?=
 =?us-ascii?Q?aoRsMPS2Y4Q8kGEgDfrvWmJ00unXzDzpXlaoNxjsNjHNzCMTSQgM2qsDMiUf?=
 =?us-ascii?Q?TLuGiqT0uBD4fnlTxQRByDRx/mHO2DNMWPfP7Bnoom9jFoeFHh7WsnZxm6hr?=
 =?us-ascii?Q?E6VN8g4i9HY8gwWQkm7p5uOnlOOa4g1BHsghKh3zRYVFUMnym+XarjoDAaL/?=
 =?us-ascii?Q?8FAxPkMH+a/OBw9bRRKGrbd5P2SDkMCXBUVg+gSoHt+/sVzTjkffctoLugV4?=
 =?us-ascii?Q?Yd+vemaiTEY7D4kCUT0bPlZb7DMSfDdj0UHJtaMqWOMmpKR4wESQOkUbPyTu?=
 =?us-ascii?Q?lf4mc5/9YW4uZRjsXtt4tQmDik0lot/VDxp4kpemBCeZqqspI0HdyZjjXaFX?=
 =?us-ascii?Q?9TfOP8Rk+mZ4HOHnw+N5nEjtRtn/rz4Ua+Zi5vmEl80o+3eG8zCXqbHhr993?=
 =?us-ascii?Q?Gt49aX+qLnoEeM1Lr2uilBG6mnXsLhAVDOvcLroygf7tdULeSaOHx7YXAlvf?=
 =?us-ascii?Q?2TVfagKz75BcycIOBi57JDnc98uUpDyQ3vX/q1AuRMAkv/xJXhD+395GKp4Z?=
 =?us-ascii?Q?8TIrnJslnTM+v4xVnwB5yHQ7qYT5WLtB229xiJG7hWh8seyZ9PGeSnoFp8wX?=
 =?us-ascii?Q?FR1u1WSY7UwMkPRNsGCa0dz/WebA76Ey/x0J3v6aktlyS10xs0izRC1FP37g?=
 =?us-ascii?Q?lnX7Sn6I+wsPLk/0p5lSAZpuXTQ1dyg=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: db60d390-a1c3-4db0-4999-08df3f0d71f3
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 09:31:49.1732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAmztEMBncw1CzxSI3MEbdFkWu9f+nQxzSlbr2QSgjvkYg8mhSXTMMi7Nyqs+AekSz8GqLdtiSiWPgi7NFBzPdjx/qBkctkI3aN1aNiTztw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB225290

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
Prerequisites on this branch, to be applied before this patch, in this order:

  c5947d28c209 ("microblaze: reserve the ABI argument-home area in the
                 signal frame")
  da6829138a39 ("microblaze: don't clobber r3/r4 restored by rt_sigreturn")

Both are queued for this branch but not in it yet.  With them applied entry.S
needs no adjustment at all; without them the cherry-pick conflicts there, which
is what the failure report was about.

Tested: built with gcc 16.2.0 and booted under qemu-system-microblaze 11.1.50
(-M petalogix-s3adsp1800,endianness=little); the kernel reaches userspace and
the test suite runs to completion.

Backport change: only the guard name in asm/entry.h, which is still
__ASSEMBLY__ on this branch (mainline renamed it to __ASSEMBLER__).  entry.S
applies unchanged.

 arch/microblaze/include/asm/entry.h           |  13 +
 arch/microblaze/include/asm/processor.h       |   2 +-
 arch/microblaze/kernel/entry.S                | 329 +++++++++---------
 arch/microblaze/kernel/hw_exception_handler.S |   5 +
 arch/microblaze/kernel/process.c              |   5 +-
 5 files changed, 189 insertions(+), 165 deletions(-)

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
index 4e193c7550df..fe82fdb49f27 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -73,7 +73,7 @@ unsigned long __get_wchan(struct task_struct *p);
 #  define task_regs(task) ((struct pt_regs *)task_tos(task) - 1)
 
 #  define task_pt_regs_plus_args(tsk) \
-	((void *)task_pt_regs(tsk))
+	(((void *)task_pt_regs(tsk)) - PTO)
 
 #  define task_sp(task)	(task_regs(task)->r1)
 #  define task_pc(task)	(task_regs(task)->pc)
diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index fea235f139d7..dfca6ce2d628 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -177,78 +177,78 @@ syscall_debug_table:
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
@@ -265,11 +265,11 @@ syscall_debug_table:
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
@@ -277,12 +277,13 @@ syscall_debug_table:
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
@@ -292,7 +293,7 @@ syscall_debug_table:
 .extern cpuinfo
 
 C_ENTRY(mb_flush_dcache):
-	addik	r1, r1, -PT_SIZE
+	addik	r1, r1, -STATE_SAVE_SIZE
 	SAVE_REGS
 
 	addik	r3, r0, cpuinfo
@@ -305,12 +306,12 @@ C_ENTRY(mb_flush_dcache):
 	addk	r9, r9, r8
 
 	RESTORE_REGS
-	addik	r1, r1, PT_SIZE
+	addik	r1, r1, STATE_SAVE_SIZE
 	rtsd	r15, 8
 	nop
 
 C_ENTRY(mb_invalidate_icache):
-	addik	r1, r1, -PT_SIZE
+	addik	r1, r1, -STATE_SAVE_SIZE
 	SAVE_REGS
 
 	addik	r3, r0, cpuinfo
@@ -323,7 +324,7 @@ C_ENTRY(mb_invalidate_icache):
 	addk	r9, r9, r8
 
 	RESTORE_REGS
-	addik	r1, r1, PT_SIZE
+	addik	r1, r1, STATE_SAVE_SIZE
 	rtsd	r15, 8
 	nop
 
@@ -350,18 +351,18 @@ C_ENTRY(_user_exception):
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
@@ -380,18 +381,18 @@ C_ENTRY(_user_exception):
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
@@ -432,8 +433,8 @@ C_ENTRY(_user_exception):
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
@@ -441,7 +442,7 @@ C_ENTRY(ret_from_trap):
  * so it stays correct if the number of stores above ever changes.
  */
 ret_from_trap_no_rval:
-	lwi	r11, r1, PT_MODE;
+	lwi	r11, r1, PTO+PT_MODE;
 /* See if returning to kernel mode, if so, skip resched &c.  */
 	bnei	r11, 2f;
 	/* We're returning to user mode, so check for various conditions that
@@ -453,7 +454,7 @@ ret_from_trap_no_rval:
 	beqi	r11, 1f
 
 	brlid	r15, do_syscall_trace_leave
-	addik	r5, r1, PT_R0
+	addik	r5, r1, PTO+PT_R0
 1:
 	/* We're returning to user mode, so check for various conditions that
 	 * trigger rescheduling. */
@@ -472,7 +473,7 @@ ret_from_trap_no_rval:
 	andi	r11, r19, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME;
 	beqi	r11, 4f;		/* Signals to handle, handle them */
 
-	addik	r5, r1, 0;		/* Arg 1: struct pt_regs *regs */
+	addik	r5, r1, PTO;		/* Arg 1: struct pt_regs *regs */
 	bralid	r15, do_notify_resume;	/* Handle any signals */
 	add	r6, r30, r0;		/* Arg 2: int in_syscall */
 	add	r30, r0, r0		/* no more restarts */
@@ -484,7 +485,11 @@ ret_from_trap_no_rval:
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
 
@@ -493,7 +498,7 @@ ret_from_trap_no_rval:
 	VM_OFF;
 	tophys(r1,r1);
 	RESTORE_REGS_RTBD;
-	addik	r1, r1, PT_SIZE		/* Clean up stack space.  */
+	addik	r1, r1, STATE_SAVE_SIZE		/* Clean up stack space.  */
 	tovirt(r1,r1);
 6:
 TRAP_return:		/* Make global symbol for debugging */
@@ -534,7 +539,7 @@ C_ENTRY(sys_rt_sigreturn_wrapper):
 	 */
 	addik	r15, r0, ret_from_trap_no_rval - 8
 	brid	sys_rt_sigreturn	/* Do real work */
-	addik	r5, r1, 0;		/* add user context as 1st arg */
+	addik	r5, r1, PTO;		/* add user context as 1st arg */
 
 /*
  * HW EXCEPTION rutine start
@@ -545,7 +550,7 @@ C_ENTRY(full_exception_trap):
 	addik	r17, r17, -4
 	SAVE_STATE /* Save registers */
 	/* PC, before IRQ/trap - this is one instruction above */
-	swi	r17, r1, PT_PC;
+	swi	r17, r1, PTO+PT_PC;
 	tovirt(r1,r1)
 	/* FIXME this can be store directly in PT_ESR reg.
 	 * I tested it but there is a fault */
@@ -555,7 +560,7 @@ C_ENTRY(full_exception_trap):
 	mfs	r7, rfsr;		/* save FSR */
 	mts	rfsr, r0;	/* Clear sticky fsr */
 	rted	r0, full_exception
-	addik	r5, r1, 0		 /* parameter struct pt_regs * regs */
+	addik	r5, r1, PTO		 /* parameter struct pt_regs * regs */
 
 /*
  * Unaligned data trap.
@@ -581,14 +586,14 @@ C_ENTRY(unaligned_data_trap):
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
@@ -611,30 +616,30 @@ C_ENTRY(unaligned_data_trap):
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
 
@@ -666,7 +671,7 @@ C_ENTRY(ret_from_exc):
 	 * complete register state.  Here we save anything not saved by
 	 * the normal entry sequence, so that it may be safely restored
 	 * (in a possibly modified form) after do_notify_resume returns. */
-	addik	r5, r1, 0;		/* Arg 1: struct pt_regs *regs */
+	addik	r5, r1, PTO;		/* Arg 1: struct pt_regs *regs */
 	bralid	r15, do_notify_resume;	/* Handle any signals */
 	addi	r6, r0, 0;		/* Arg 2: int in_syscall */
 	bri	1b
@@ -678,7 +683,7 @@ C_ENTRY(ret_from_exc):
 	tophys(r1,r1);
 
 	RESTORE_REGS_RTBD;
-	addik	r1, r1, PT_SIZE		/* Clean up stack space.  */
+	addik	r1, r1, STATE_SAVE_SIZE		/* Clean up stack space.  */
 
 	lwi	r1, r1, PT_R1 - PT_SIZE; /* Restore user stack pointer. */
 	bri	6f;
@@ -687,7 +692,7 @@ C_ENTRY(ret_from_exc):
 	VM_OFF;
 	tophys(r1,r1);
 	RESTORE_REGS_RTBD;
-	addik	r1, r1, PT_SIZE		/* Clean up stack space.  */
+	addik	r1, r1, STATE_SAVE_SIZE		/* Clean up stack space.  */
 
 	tovirt(r1,r1);
 6:
@@ -720,10 +725,10 @@ C_ENTRY(_interrupt):
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
@@ -733,23 +738,23 @@ C_ENTRY(_interrupt):
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
@@ -765,7 +770,7 @@ ret_from_irq:
 5:	andi	r11, r19, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME;
 	beqid	r11, no_intr_resched
 /* Handle a signal return; Pending signals should be in r18. */
-	addik	r5, r1, 0; /* Arg 1: struct pt_regs *regs */
+	addik	r5, r1, PTO; /* Arg 1: struct pt_regs *regs */
 	bralid	r15, do_notify_resume;	/* Handle any signals */
 	addi	r6, r0, 0; /* Arg 2: int in_syscall */
 	bri	1b
@@ -778,7 +783,7 @@ no_intr_resched:
 	VM_OFF;
 	tophys(r1,r1);
 	RESTORE_REGS
-	addik	r1, r1, PT_SIZE /* MS: Clean up stack space. */
+	addik	r1, r1, STATE_SAVE_SIZE /* MS: Clean up stack space. */
 	lwi	r1, r1, PT_R1 - PT_SIZE;
 	bri	6f;
 /* MS: Return to kernel state. */
@@ -801,7 +806,7 @@ restore:
 	VM_OFF /* MS: turn off MMU */
 	tophys(r1,r1)
 	RESTORE_REGS
-	addik	r1, r1, PT_SIZE	/* MS: Clean up stack space. */
+	addik	r1, r1, STATE_SAVE_SIZE	/* MS: Clean up stack space. */
 	tovirt(r1,r1);
 6:
 IRQ_return: /* MS: Make global symbol for debugging */
@@ -820,29 +825,29 @@ C_ENTRY(_xtmr_manager_reset):
 	lwi	r1, r0, xmb_manager_stackpointer
 
 	/* Restore MSR */
-	lwi	r2, r1, PT_MSR
+	lwi	r2, r1, PTO+PT_MSR
 	mts	rmsr, r2
 	bri	4
 
 	/* restore Special purpose registers */
-	lwi	r2, r1, PT_PID
+	lwi	r2, r1, PTO+PT_PID
 	mts	rpid, r2
 
-	lwi	r2, r1, PT_TLBI
+	lwi	r2, r1, PTO+PT_TLBI
 	mts	rtlbx, r2
 
-	lwi	r2, r1, PT_ZPR
+	lwi	r2, r1, PTO+PT_ZPR
 	mts	rzpr, r2
 
 #if CONFIG_XILINX_MICROBLAZE0_USE_FPU
-	lwi	r2, r1, PT_FSR
+	lwi	r2, r1, PTO+PT_FSR
 	mts	rfsr, r2
 #endif
 
 	/* restore all the tlb's */
 	addik	r3, r0, TOPHYS(tlb_skip)
-	addik	r6, r0, PT_TLBL0
-	addik	r7, r0, PT_TLBH0
+	addik	r6, r0, PTO+PT_TLBL0
+	addik	r7, r0, PTO+PT_TLBH0
 restore_tlb:
 	add	r6, r6, r1
 	add	r7, r7, r1
@@ -868,9 +873,9 @@ ret_from_reset:
 	VM_OFF
 	/* MS: Restore all regs */
 	RESTORE_REGS
-	lwi	r14, r1, PT_R14
-	lwi	r16, r1, PT_PC
-	addik	r1, r1, PT_SIZE + 36
+	lwi	r14, r1, PTO+PT_R14
+	lwi	r16, r1, PTO+PT_PC
+	addik	r1, r1, STATE_SAVE_SIZE + 36
 	rtbd	r16, 0
 	nop
 
@@ -885,11 +890,11 @@ C_ENTRY(_xmb_manager_break):
 	 * Reserve memory in the stack for context store/restore
 	 * (which includes memory for storing tlbs (max two tlbs))
 	 */
-	addik	r1, r1, -PT_SIZE - 36
+	addik	r1, r1, -STATE_SAVE_SIZE - 36
 	swi	r1, r0, xmb_manager_stackpointer
 	SAVE_REGS
-	swi	r14, r1, PT_R14	/* rewrite saved R14 value */
-	swi	r16, r1, PT_PC; /* PC and r16 are the same */
+	swi	r14, r1, PTO+PT_R14	/* rewrite saved R14 value */
+	swi	r16, r1, PTO+PT_PC; /* PC and r16 are the same */
 
 	lwi	r6, r0, TOPHYS(xmb_manager_baseaddr)
 	lwi	r7, r0, TOPHYS(xmb_manager_crval)
@@ -903,25 +908,25 @@ C_ENTRY(_xmb_manager_break):
 
 	/* Save the special purpose registers  */
 	mfs	r2, rpid
-	swi	r2, r1, PT_PID
+	swi	r2, r1, PTO+PT_PID
 
 	mfs	r2, rtlbx
-	swi	r2, r1, PT_TLBI
+	swi	r2, r1, PTO+PT_TLBI
 
 	mfs	r2, rzpr
-	swi	r2, r1, PT_ZPR
+	swi	r2, r1, PTO+PT_ZPR
 
 #if CONFIG_XILINX_MICROBLAZE0_USE_FPU
 	mfs	r2, rfsr
-	swi	r2, r1, PT_FSR
+	swi	r2, r1, PTO+PT_FSR
 #endif
 	mfs	r2, rmsr
-	swi	r2, r1, PT_MSR
+	swi	r2, r1, PTO+PT_MSR
 
 	/* Save all the tlb's */
 	addik	r3, r0, TOPHYS(tlb_skip)
-	addik	r6, r0, PT_TLBL0
-	addik	r7, r0, PT_TLBH0
+	addik	r6, r0, PTO+PT_TLBL0
+	addik	r7, r0, PTO+PT_TLBH0
 save_tlb:
 	add	r6, r6, r1
 	add	r7, r7, r1
@@ -978,28 +983,28 @@ C_ENTRY(_debug_exception):
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
@@ -1015,16 +1020,16 @@ C_ENTRY(_debug_exception):
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
@@ -1032,7 +1037,7 @@ dbtrap_call: /* Return point for kernel/user entry + 8 because of rtsd r15, 8 */
 
 	/* MS: The first instruction for the second part of the gdb/kgdb */
 	set_bip; /* Ints masked for state restore */
-	lwi	r11, r1, PT_MODE;
+	lwi	r11, r1, PTO+PT_MODE;
 	bnei	r11, 2f;
 /* MS: Return to user space - gdb */
 1:
@@ -1051,7 +1056,7 @@ dbtrap_call: /* Return point for kernel/user entry + 8 because of rtsd r15, 8 */
 5:	andi	r11, r19, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME;
 	beqi	r11, 4f;		/* Signals to handle, handle them */
 
-	addik	r5, r1, 0;		/* Arg 1: struct pt_regs *regs */
+	addik	r5, r1, PTO;		/* Arg 1: struct pt_regs *regs */
 	bralid	r15, do_notify_resume;	/* Handle any signals */
 	addi  r6, r0, 0;	/* Arg 2: int in_syscall */
 	bri	1b
@@ -1062,7 +1067,7 @@ dbtrap_call: /* Return point for kernel/user entry + 8 because of rtsd r15, 8 */
 	tophys(r1,r1);
 	/* MS: Restore all regs */
 	RESTORE_REGS_RTBD
-	addik	r1, r1, PT_SIZE	 /* Clean up stack space */
+	addik	r1, r1, STATE_SAVE_SIZE	 /* Clean up stack space */
 	lwi	r1, r1, PT_R1 - PT_SIZE; /* Restore user stack pointer */
 DBTRAP_return_user: /* MS: Make global symbol for debugging */
 	rtbd	r16, 0; /* MS: Instructions to return from a debug trap */
@@ -1073,9 +1078,9 @@ DBTRAP_return_user: /* MS: Make global symbol for debugging */
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
@@ -1173,7 +1178,7 @@ ENTRY(_switch_to)
 .ent xmb_inject_err
 .type xmb_inject_err, @function
 xmb_inject_err:
-	addik	r1, r1, -PT_SIZE
+	addik	r1, r1, -STATE_SAVE_SIZE
 	SAVE_REGS
 
 	/* Switch to real mode */
@@ -1197,7 +1202,7 @@ xmb_inject_err:
 	nop;
 1:
 	RESTORE_REGS
-	addik	r1, r1, PT_SIZE
+	addik	r1, r1, STATE_SAVE_SIZE
 	rtsd	r15, 8;
 	nop;
 .end xmb_inject_err
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
index 56342e11442d..504e73854bc2 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -19,6 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/ptrace.h>
 #include <asm/cacheflush.h>
+#include <asm/entry.h>
 
 void show_regs(struct pt_regs *regs)
 {
@@ -65,7 +66,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		 * the registers. That's OK for a brand new thread.*/
 		memset(childregs, 0, sizeof(struct pt_regs));
 		memset(&ti->cpu_context, 0, sizeof(struct cpu_context));
-		ti->cpu_context.r1  = (unsigned long)childregs;
+		ti->cpu_context.r1  = (unsigned long)childregs - PTO;
 		ti->cpu_context.r20 = (unsigned long)args->fn;
 		ti->cpu_context.r19 = (unsigned long)args->fn_arg;
 		childregs->pt_mode = 1;
@@ -79,7 +80,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		childregs->r1 = usp;
 
 	memset(&ti->cpu_context, 0, sizeof(struct cpu_context));
-	ti->cpu_context.r1 = (unsigned long)childregs;
+	ti->cpu_context.r1 = (unsigned long)childregs - PTO;
 	childregs->msr |= MSR_UMS;
 
 	/* we should consider the fact that childregs is a copy of the parent
-- 
2.53.0

