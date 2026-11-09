Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794233736;
	b=JYWrVv5y9LBKoBEOyh4MJwBXKerCUtaR50B78EEDrDmc9vIlXg/EStxEVs5SVRDrh/d1
	 ij1g6H8ECZFOMwJfxt8aFpVY6evb/VXssGwcuk9m3gSOUbsT1upQd1Znv/YwKW8svsfPt
	 EPOH5ndO1yhT496jFjAviqOifPBAMJ726J8sbXg4ZA/5HnIziT2EdADyUoQRnigmjycSt
	 3pnh1jsrSXDOiurIrH9XRQ49Dqp8TabDWk2l0QtSJ5vhQHe3kvGiy3HpRMXuVrOmX2ekD
	 uhT0b1sEzuFdFXzkB10xNFbvxLhz4dTj6PQb5R8a9LWVtdu/YmeUSJwsuheuQENh6Ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233736;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0TjLrAdum1p+ydFs3cwtsemD9IVe/HsSvbk+3WEXbiw=;
	b=Q3Mu3vlYVCHGiL92Ft3fNMHvuO++slBpyCGFmJ71T9S1HciW/prhzolNw3ox1DN6kiUO
	 biku/Uu2x8J3nuss+wx/29a5AtK2FNOF43Y0LMJ2AN29oCjxq6WF6o84S/0S+Tm8jC1IJ
	 ydj1aAHgOrmMsSUJWc7OS96g4bb44dpWgBJk9lZg65YhZcn/5XWHhhqpUf7P0nuvXnX7V
	 dbrxMlM/ElMrQWupn16cidDdsmEYB9WF4OombOh0jlDMHgFezSIPq6k1aHLnyITs36jJN
	 NamgTbLvDUw442aqX0gB9aSKLLZvFPYLyYdJbH2NwXX4ZFje2BrGjmbBIpm+2PbQt6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia.com;
	spf=fail smtp.mailfrom=nokia.com;
	dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=oZWou5sc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.37
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747E606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 14:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B747E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=oZWou5sc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWN/Pd9xv1aMz6uHr9TzhOxZS5Hacn9UpanLY9cPbH/1UIeabFEAsBdddKhJVBMCmZc8WWYseUo33cHp1bxcka+CU4SbmteTQc9ujZwleH87rnsp35gAigDxFfLJs1CswGGYO2hQirR3zSNW2/73pW2TQhLufFsBfnezFmHA2reifH8ACEZpCXkWXA9LF6yXugveFYSN9gKQZNIKYb5VEpLAADpqP9GU+cplUIDFrUaDyBZhZT7+m2bmFp8keIMdQfb2ktAsq+tDDM0ogCjl6oOQ20ochQIyhOEvzn4ks7HiD0kV7GjenoVztPSuVTSeISJojDXDPKLKKKF1OcZjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TjLrAdum1p+ydFs3cwtsemD9IVe/HsSvbk+3WEXbiw=;
 b=DEJwDoDHbC/Ch+SrmxORqMX66WPMxTerY1OZ8dU9tvpH8oXVs38GQGEinrnWdhmFqYBzmdpIrAfwrKP40ceWCzCPQzCBjdvJgXisORgXdT44EnPe7URJHynyldb+5ROvSxP5P4bvoFqHV5vwsSVuHilf5CZAezUMkGJTIPOJMjn5z071weowBOTdRFsE52KIQc6WP4wBEc98upsx0TvnIoulg6s9wphIm1Cbf3DQ4cN1Ijyz35Yje42Hdrg9bvMKBblkro6YiY8438/26svrB/jZ0Hc02A72S4jiljBoiSkjD3kQwdtBCv5BXwZOKM/eWI0W8KeS55tTW3E4LdpPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.30) smtp.rcpttodomain=163.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TjLrAdum1p+ydFs3cwtsemD9IVe/HsSvbk+3WEXbiw=;
 b=oZWou5scnNgwYYls7f7UIu5VZPvN6HFX8ih6iNnOPlbgDbYRFRZRsQ5G2xMlMDqEEHv8kpD+bKfE3A5ySFD/le250DI2dfhkLoRTb+gtlCqAvqWJzR6g5g0Ra7dXNZLMOtMgto3oCTshuTtuQCRDHT/UTBifKB65+oq0OlZnVhSuYXj57G/b1/JHAK3DMJczWrTgGCYQkRBCa+p2CdfL08FFC8J4c2jEkmVeFoi8k+Ls3wnVs/3UEZPx85cWY1SKPHynV0ldlE3AJLOjVYr7vQJtzXOJSuGdsrF7S/myDbCi0JKXDeuRTg+tjCqtkHUOpRmZS9ZofA++VSQt7iGRmw==
Received: from WA0P291CA0010.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::12) by
 DB9PR07MB9149.eurprd07.prod.outlook.com (2603:10a6:10:3d7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.12; Mon, 9 Nov 2026 14:15:29 +0000
Received: from WA1PEPF000099CD.eurprd04.prod.outlook.com
 (2603:10a6:1d0:1:cafe::39) by WA0P291CA0010.outlook.office365.com
 (2603:10a6:1d0:1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 14:15:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.30) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.30; helo=fihe01smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe01smtplvp01.emea.nsn-net.net (131.228.2.30) by
 WA1PEPF000099CD.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 14:15:27 +0000
Received: from uleclfsdev01.linsee.dyn.nesc.nokia.net.net (uleclfsdev01.linsee.dyn.nesc.nokia.net [10.47.240.179])
	by fihe01smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id C54FC800009B;
	Mon,  9 Nov 2026 16:15:26 +0200 (EET)
From: Hamid Nassiby <hamid.nassiby@nokia.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	ranxiaokai627@163.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>,
	Mauricio Faria de Oliveira <mfo@igalia.com>,
	linux-mm@kvack.org
Subject: [PATCH 6.12.y] Revert "mm/page_owner: fix memory leak in page_owner_stack_fops->release()"
Date: Mon,  9 Nov 2026 15:15:09 +0100
Message-ID: <20261109141509.2880440-1-hamid.nassiby@nokia.com>
X-Mailer: git-send-email 2.42.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CD:EE_|DB9PR07MB9149:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 60bbd354-548c-4d7c-0531-08df3e6be788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|260925021911599003|260925021311599003|260925022911599003|261026121527099003|5023799004|11063799006|261021121427099003|56012099006|261021135927099003|261021123027099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	eSGlnb8cgHbkCUo2mdz631IBA73h5hiziXoConH5hv5cjeWUNs/8AG1mCs8rPZpF75CrTzz0i5UBFcYpwvvBRvnrdEKBCvnEo772CvusDquK71HxiZwDs//lhCNLEST0Ss3H89XC1vKLvTLbF4odOP7BsokSO3FStJuXKiE/eX5G3WAbW81MXoDoYt3JB89N+R1nYPqnYBl0ikRcIk47szWp7aRagx2bz59CundNAdrqrlQbX+jk53AqvC03wkvOi+6WjHZuNCGRI6t2CmZOet3XOK+860CM/KqndFNXQhAZoxRTjEAHnPKekSKpLSkaRv7WST//5Qe5ho9Z69UmxtYB3m1jv4zemzKvzTgTvnoR5MlawXJbDQGTUwayPI6d0iet5XeCktCOjEglb2gejyi9In8iyQYJlDSTYmGLje9X+rfWyNDc0UzMGMd/8BOLo8nZSghHzqZjxSeDEyEcmStX9akS/RLjllXAcVYfYaXp5MbYu8c9RmPIxWpPE4bb0fWjtGnT5L0JD3Lr52ewS/Uu4Me7dAysceS6vcK34MHJgclIQIYtRlQ8pKXdHjakQBp3slKleuuX2bm8zjmL6bhPWQKo3kdGSGAhKOzUarS1IM77rtB2jxLojThBMXfhjn0DQd345WtNHAWdc/h8TsuMDERF6FpeeM9sS06frpg=
X-Forefront-Antispam-Report:
	CIP:131.228.2.30;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe01smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(260925021911599003)(260925021311599003)(260925022911599003)(261026121527099003)(5023799004)(11063799006)(261021121427099003)(56012099006)(261021135927099003)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Og0s93oCqPfceiQQ0xuWG5TWXNv3jdHAq0C3yF9W1MenADlZSK3ZZ9A6QwXZiKiiJhvXg8tciL17tEV24bDHpcgBbGHerJUjZGuhMJALVmrTb/kAS+ESvJK1Y0FBMhwW++L8B6RfJg506NHjHjNOFYZrnJ6+TznXw2iBwplegm9beYpdWmmuK5rAH+D3aL2usfyqAepN98fkIVPCR79GjFC/qSZJ7hZxD6RsMM1y3aAO4bEsmkEo2fn1uNVuGELUnr8ovhK/Y0zivLuRV3ew5dVVNW1yew8izS6a7RBSOlp+fEj/2NmLMHslgrCCo5Mh5IOJmLIiZHUT2Rrjfi2okD5x3fISmmTRt4msoD74K5XhmxUUnekr7qtY+QqHJOzYEwOMdGXnntMFlfQGsAF6ycUvirRwG9I5HUxaUJbERo2nQnpDzoOFA7o+YfPcsISw
X-Exchange-RoutingPolicyChecked:
	M4k8uJ1edxFRPlZJ/Cwk0JOqr8kJ5PAc7fzQPowVh8itKtb0rQw7SCn9FwrWO19Mdqm92WMXoWI8J/lNciOEJJdmr2Ym7UTQnX4NivyvuHWkxV9WQjIFZaGRP5ZOSMXVNJfUrt3YpQzT/vI3emIQQ2szbvYCJT/Jj77Ps8stbJpwhRitLWO34oLb7NbvWVNm+1Z5SQnBPJqvyBXwDjrRwNG9XBkNoAjn6EKKONExXm0Av2+pfzZecVECZBfx2RIToFgdq00Hj/lp258EZPLoYzfNR2OFZBktFlqtpcOMLVoXc0xT6ZWcSMGJQT7O3KHqL9CuaE2tSbNisw+WEaW8Lw==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:15:27.5720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bbd354-548c-4d7c-0531-08df3e6be788
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.30];Helo=[fihe01smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-WA1PEPF000099CD.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9149

This reverts commit 7fbea59f737eb3a47368ee5253e708cb342faf8b, which is
commit a76a5ae2c6c6 upstream.

The upstream change is only correct on top of commit 156c0c5d1463
("mm/page_owner: introduce struct stack_print_ctx"), which first appeared
in v6.19. That commit makes page_owner_stack_open() allocate a struct
stack_print_ctx through seq_open_private() and moves the stack_list
cursor into it, so ->release() must free it with seq_release_private().
6.12 does not have that commit: page_owner_stack_open() passes a size of 0
to seq_open_private(), so there is nothing to leak, and
stack_start()/stack_next() store the current struct stack node directly
in m->private.

The upstream commit was backported because it is tagged for stable and
carries a Fixes tag for 765973a09803 ("mm,page_owner: display all stacks
and their count"), but the leak it fixes only exists since 156c0c5d1463.

seq_release_private() kfree()s m->private. Closing show_stacks before
EOF therefore frees a struct stack node that is still linked in
stack_list, and the next reader of show_stacks walks into freed memory.
On v6.12.115 (x86_64 QEMU, KASAN, page_owner=on), a single 4 KiB read()
and close() followed by a full read gives:

  BUG: KASAN: slab-use-after-free in stack_print+0x165/0x170
  Read of size 8 at addr ff11000005259d40 by task init/1
  ...
  Allocated by task 1:
   __kasan_kmalloc+0x7f/0x90
   __set_page_owner+0x45c/0x6c0
  ...
  Freed by task 1:
   kfree+0x1a0/0x390
   seq_release_private+0x58/0x110
   full_proxy_release+0xe3/0x290
   __fput+0x35c/0xac0
   __x64_sys_close+0x79/0xc0
  ...
  The buggy address belongs to the object at ff11000005259d40
   which belongs to the cache kmalloc-16 of size 16

Without KASAN, a partial read followed by a full read
("head -12 show_stacks; cat show_stacks") panics arm64 hardware running
a 6.12.108-based kernel:

  Unable to handle kernel paging request at virtual address 0030206235376d88
  pc : stack_print+0x20/0xd0
  lr : seq_read_iter+0x340/0x470
  Call trace:
   stack_print+0x20/0xd0
   seq_read_iter+0x340/0x470
   seq_read+0xf0/0x140
   full_proxy_read+0x54/0xa0
   vfs_read+0xc8/0x348
   ksys_read+0x6c/0x118
  Kernel panic - not syncing: Oops: Fatal exception

With this revert applied, the QEMU reproducer completes 20
partial-read/full-read cycles without a KASAN report. mm/page_owner.c is
unchanged between v6.12.115 and v6.12.116.

Backporting 156c0c5d1463 instead is not proposed: it prepares for the
new show_handles and show_stacks_handles debugfs files rather than
fixing anything, so reverting the backport is the minimal change for
stable.

Link: https://lore.kernel.org/stable/20260106170507.666343896@linuxfoundation.org/
Signed-off-by: Hamid Nassiby <hamid.nassiby@nokia.com>
---

Notes:
    The analysis, the QEMU/KASAN reproducer and this changelog were
    prepared with AI assistance. The arm64 crash was hit on our own
    hardware; I reviewed the analysis and confirmed the fix there, with
    repeated partial and full reads of show_stacks on the reverted kernel.
    
    The same backport is in 6.18.y as 05a8edf607be; a separate
    [PATCH 6.18.y] revert is sent alongside this one.

 mm/page_owner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 5d1c946c0..d2783b7c0 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -937,7 +937,7 @@ static const struct file_operations page_owner_stack_operations = {
 	.open		= page_owner_stack_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release_private,
+	.release	= seq_release,
 };
 
 static int page_owner_threshold_get(void *data, u64 *val)

base-commit: 5c40a1750f44dd6c7292d8c8d0b4ffff1734576e
-- 
2.45.0

