Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794233752;
	b=iVLtlaES9xb8avmyKhJECShIS+Ym5Vkc535fCGzoOAdMks4ksH2mAdxWbSC0webZwNcL
	 GMHzDkPLjoajUTe+pNV+wTj9s0aB05/f31umyWpypQO8lhO8ksXa6V+/Km1b59yWpYGEM
	 ftEubq9G37QPPCtm/PRWRXQ34ueRL1rIT79UXByfgo7zLVObPX6+9JBq7/BoJeN0lchn9
	 Ww1O59+Pn3MSmIH+bol6Tu3taEE8UZUaeH7tvgC7MzvncZWyjyPht+ou7U+a0gWApOAv8
	 HrABS1tvdq5QQtLdTSnCU306xaUw7EfPHfocrOLhKk6rQKXyTq42DqPFiPxmIz/3QIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233752;
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
	bh=IFTShs87lghq5yOPRnznpx55y84oMBfPUhs6BplBFb4=;
	b=fLCCyyhOlXVJuTvZ62MXPAkgyi5SoLbEEO0DYJcFXgHGfJgS1UFv3aCJ31JfD6H2kp5m
	 gZ39gvdN0stqQh0V8842wfJsv3XWFrsygxwIbPFahY60W94WQvVrlNzGXE0CR46ySiaW6
	 FaHvnaP6ZjDEN1PfoK5bUiflA3ZO4P7VIVWN4PIuC4JnQlbkL5frfJD4YUn1iJBoBOoLe
	 R/YE+G1QzZLi7XhsRFa5UWC5pEDtzYXrpVhd1JaQNJHm4pObra+igo7TeibOR3FQ7y2yZ
	 wiVDL/gaLEvnlW8+62TuJLnJv0U+DV4pbyqfBaGsOAZS7KrHOwVMkacTcUf1moeov1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia.com;
	spf=fail smtp.mailfrom=nokia.com;
	dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=MpAW4991;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.4
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9FC606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 14:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F9FC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=MpAW4991
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMHQqNluvwOiGs2myiWkYGgu5ZhZDGlnrMeHNyGSdu553TWBTm6cNA2+4SQXZIZhoeghk0e1pyijDsP3XKcNCZBSA+Vxbe58xGXTa5IJ1EmsGe6xXGlfmO8xQftyWcIdmNMU/uBCtWLPa/RV2gsv6fMRXnWDqeTIArzcnP+udlvftygnW7yNGke/x+OtmtnM4V/962KsXim+hg0f71wIoik0zNC3gTDF2OlFIydLbCmn1kv3APYpS3gKCD/9zbH1ox7t2i3n+BdBOw3NCSgapWlBcTAqIF0N1OYICBjSRAiTI8NK77vrttpWk+tBK0BPSPodIgQRtZ/1k1AXh7pFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFTShs87lghq5yOPRnznpx55y84oMBfPUhs6BplBFb4=;
 b=D9pYCQCj94aZsLDRizFhea3IXZ6sfnjNbUtQRYIH2FiXt+RfwvM9rzlW6E3hoMQdPA75aHjes9Qb75O0HbUhL3IHuQL0PGc3ADvkc0F8P/24Jxtwnla6EhZ9dekhlIkQYwo6XOOUhXA6vSOnaDCaXccaB9Jb3BBr44mnWkEUwLi/9QQu7kjMEhPjf+6abIvUEJ0n9KeczZ0s6K2/UD0LwxmY2KzKJL2CD3e7hdRYrWNUt6xTQPLo5UoyQik8D0I/qWsfZS1HxbbRWRR/Pe6nyXh++WqFRtzPTY21zUlemIQVhiXGNPb8iHo6LY3F0eKb4/swTPDwEYoxLUYjfGfyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.1) smtp.rcpttodomain=163.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFTShs87lghq5yOPRnznpx55y84oMBfPUhs6BplBFb4=;
 b=MpAW4991s3/cO6AbWe5mHkLX93oqdqF+edbBlK5WzWAG113rExz7XkhUi0tNwICLxlXsDCnobFdOAGR5RvSZRBRgDlDdOax3UF9BYi0Wa7t8n5j9WTCBSaV++Hbhuzwn3B6ZuS1VoT7wppQ1NdJU+lxU1lKPzkgM43YIqP84uqKt2Mq/0vuJrCOBOrM6vYCo5TVSPoiSTEGyYtU4xNqWAKWV37bvtiPkTyMnZ46638TpVsiY9/1kEKG8KoW+LLQO9xA7WnitlRs5qiU/acZMkcm7yzdGXIY3m31aqxGujYeTqb3FS1YLqjvNPkMsbLJnF/2sfUSobWPsUQLcGmXKTg==
Received: from AS9P250CA0012.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::25)
 by VI0PR07MB11473.eurprd07.prod.outlook.com (2603:10a6:800:30b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 14:15:48 +0000
Received: from AMS1EPF0000009B.eurprd02.prod.outlook.com
 (2603:10a6:20b:532:cafe::6e) by AS9P250CA0012.outlook.office365.com
 (2603:10a6:20b:532::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 14:15:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.1) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.1 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.1; helo=fihe02smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe02smtplvp01.emea.nsn-net.net (131.228.2.1) by
 AMS1EPF0000009B.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 14:15:47 +0000
Received: from uleclfsdev01.linsee.dyn.nesc.nokia.net.net (uleclfsdev01.linsee.dyn.nesc.nokia.net [10.47.240.179])
	by fihe02smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id 1CC668000093;
	Mon,  9 Nov 2026 16:15:47 +0200 (EET)
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
Subject: [PATCH 6.18.y] Revert "mm/page_owner: fix memory leak in page_owner_stack_fops->release()"
Date: Mon,  9 Nov 2026 15:15:27 +0100
Message-ID: <20261109141527.2880867-1-hamid.nassiby@nokia.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009B:EE_|VI0PR07MB11473:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 33a87602-5645-4ece-26f7-08df3e6bf39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|36860700016|1800799024|82310400026|5023799004|11063799006|56012099006|261021123027099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	szjISrDHiqH+xXAC6bnqabanB77Yk9nazQNWA6q03efIFdn+QxQSAjs7+5ZmyRql3CAuVdOtP+X85A2BeNH/Z+RHoq2DzASzYRp/pW7kKyX7QVbef0xYvDJssPrw2UMJ0pS5Ky0i9Kby5as3ABOdj+iIRDhtyFvqJLItVXgWabVQzxesJPZcRYojOxLvlylXs26bOkupCAERDznyPcPlfMQrioQcBPNUCS8ghcu+yjeQ2ariiQyicj9aT7Mhf1vMfa16rSfWnfnlQMVH5qexXEEh0iLEcoiRfbu3Cg6nQr1rAwpZ6RofrWfQtTGgxe9cqpCimiC8efWRUrfnpIVvMTA1RKP4c1cJvb44HkwhqlWbasdhQK4lni0091gePc3k7mRwRySAsJBWP16nZ/qUfDxzXbwDeO9/Am0T4WpnHyTP4Wvsvbd60w/bRFOOq7A+RxDn6V6wKN3PSRrUV1MuitlaSArA9+Mwdlnn7LnDBNZRJCEKKqMxzeIEDMXJMT4X80kQQaQhKULjC6bhOAtsYD7F5bYqTe+WioAeQCoEvGUjbfQH9Q3DMBScdGx4dLzG1RcU2n5vvCJGvrMUWHZeMcLf21fIM9i/y5F3jfjvXhYHS/KqAi2zpRjtOyL10T79absaLWjkPlY0ozyTP+u/Lb+Uv77+bN00ymOmNO4up4o=
X-Forefront-Antispam-Report:
	CIP:131.228.2.1;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe02smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(1800799024)(82310400026)(5023799004)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BLKLSdn+GWImEy3P27Gx0ouWWFe6AlQ4mbc3pXVOyc3IZ5OiLM5qFWhaqTXr4Ai1PSOux9gV9FgpiqPPSgm3iOWAH3WW6Wc7ihd7WjcWkKUKILb2JDuHzx6DdT2PTTT1/wfTTNiXXuEnBQ7UHtuCV+yGWg0tv2dbJNmDuT1aWaDnL2a0vVjNfKd2Pf2Bw+Avivu7rH68XIS97nkX8IaHx+21qRlqy8y/SGo0lk59fJScZSD90i+qzrRyjVkR2coSqDg5Ppva27PBieE88Iklg83mZm45MrxoIeTYCZSe1XIeaHkb5k5gkhtqBR5c/qbX5l++xX0fAhMztCZjJM7KCIUwkNYobet71yk49Cto5K55wsclnLmSRE4MXpZVUoaxd+6OFdFejbbjt+CeF/zJLuYZ+9ZsEeKeaV5qEJ0IENdxApRc8McDhx1pkTv+cHjT
X-Exchange-RoutingPolicyChecked:
	zC8Z284jXUGDX/RR+a37iYnCCIYudApQI/5EbazopCAPWusaYbia/rOgMjx7HA132p0MRW2Ed3thE8DJR4ommAZBkOs6NIrUJdYVjEXsJhu0VWEHKlfQe4aOSXpbiXg2ch35+90SHJ/vvXN20z2fWlQvVNbRdwSljOcA42MQjTesjUGULy/SGRx3byaEkEf3IyJG6kBOE/8n67JdeN6tYO0vqpOcHJwROP6ub7W/gRgN3qeT2CbyC8MNBFidwrSBBo3G5C/S4VRy2OCmPEtkejOFtnxb9XlH1R2dJud+NtfkwNdKUP2BNC2p/vKz7qxXUgx8FDFClrzemVtiEoEIrQ==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:15:47.8521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a87602-5645-4ece-26f7-08df3e6bf39c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.1];Helo=[fihe02smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF0000009B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11473

This reverts commit 05a8edf607be826738dfc620a17d9d98e8976762, which is
commit a76a5ae2c6c6 upstream.

The upstream change is only correct on top of commit 156c0c5d1463
("mm/page_owner: introduce struct stack_print_ctx"), which first appeared
in v6.19. That commit makes page_owner_stack_open() allocate a struct
stack_print_ctx through seq_open_private() and moves the stack_list
cursor into it, so ->release() must free it with seq_release_private().
6.18 does not have that commit: page_owner_stack_open() passes a size of 0
to seq_open_private(), so there is nothing to leak, and
stack_start()/stack_next() store the current struct stack node directly
in m->private.

The upstream commit was backported because it is tagged for stable and
carries a Fixes tag for 765973a09803 ("mm,page_owner: display all stacks
and their count"), but the leak it fixes only exists since 156c0c5d1463.

seq_release_private() kfree()s m->private. Closing show_stacks before
EOF therefore frees a struct stack node that is still linked in
stack_list, and the next reader of show_stacks walks into freed memory.
On v6.18.60 (x86_64 QEMU, KASAN, page_owner=on), a single 4 KiB read()
and close() followed by a full read gives:

  BUG: KASAN: slab-use-after-free in stack_print+0x165/0x170
  Read of size 8 at addr ff110000062adfc0 by task init/1
  ...
  Allocated by task 1:
   __kasan_kmalloc+0x7f/0x90
   __set_page_owner+0x4a5/0x720
  ...
  Freed by task 1:
   kfree+0xf8/0x460
   seq_release_private+0x58/0x110
   full_proxy_release+0xa1/0x130
   __fput+0x35c/0xac0
   __x64_sys_close+0x79/0xd0
  ...
  The buggy address belongs to the object at ff110000062adfc0
   which belongs to the cache kmalloc-16 of size 16

Without KASAN, the same bug panics arm64 hardware running a
6.12.108-based kernel ("head -12 show_stacks; cat show_stacks").

With this revert applied, the QEMU reproducer completes 20
partial-read/full-read cycles without a KASAN report. mm/page_owner.c is
unchanged between v6.18.60 and v6.18.62.

Backporting 156c0c5d1463 instead is not proposed: it prepares for the
new show_handles and show_stacks_handles debugfs files rather than
fixing anything, so reverting the backport is the minimal change for
stable.

Link: https://lore.kernel.org/stable/20260106170556.173097317@linuxfoundation.org/
Signed-off-by: Hamid Nassiby <hamid.nassiby@nokia.com>
---

Notes:
    The analysis, the QEMU/KASAN reproducer and this changelog were
    prepared with AI assistance. The arm64 crash was hit on our own
    hardware; I reviewed the analysis and confirmed the fix there, with
    repeated partial and full reads of show_stacks on the reverted kernel.
    
    The same backport is in 6.12.y as 7fbea59f737e; a separate
    [PATCH 6.12.y] revert is sent alongside this one.

 mm/page_owner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index bc2676414..589ec37c9 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -936,7 +936,7 @@ static const struct file_operations page_owner_stack_operations = {
 	.open		= page_owner_stack_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release_private,
+	.release	= seq_release,
 };
 
 static int page_owner_threshold_get(void *data, u64 *val)

base-commit: c3f63d70f236bb7685e6d11d1d9b5b351552e600
-- 
2.45.0

