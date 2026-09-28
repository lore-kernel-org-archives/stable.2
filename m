Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020096.outbound.protection.outlook.com [52.101.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150D4EDCC7;
	Mon, 28 Sep 2026 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609181; cv=fail; b=DY9wExJQd/Cnbm0LgnH+Rpk93HpbCn/9293vMZA920hTiChmCNjKSZHl/Ofm0nJviXCPr/Nzg9N2DwTecYg/gu3fKjy8SenxT2qIYjpzjAYy5c2NtJCRdJl3a++b1+8G8EkNWB1KVMVjMnRCVqLJP/5fE9H1o2C9Lgc6N33hY64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609181; c=relaxed/simple;
	bh=6F5Ol8EQLmN6QoYetV4ZbJ/EXpSILo8qj12YjH6eK+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UkuwVDVODlZ7RxMJwB6yI3wdTa9eB0Pj2VLe04hVe02FJmmJVazlDRgjdOCTnH0q2A7g/yb/WHY1R7+BFl3QvXaLH8ol4o4WjXKfF1nvXTDkx995PwhW8T1L2FLYKhmAJSSP826yB/zDeLriVYu0Luc/6MlGuEOht+2csT/3+e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tPt337/y; arc=fail smtp.client-ip=52.101.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tPt337/y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pa1htHtTtsK+0YtI7IJ4LcR1JKNY2YwKGC9MRlGy1m/aNudxysdGiP/Dhsbh2Pj78rjT8EQd4TblNCK8rRFk/i6oZDYimxzSgAtsbyH3VzQe1A93LM88cAlzTtfLuENj44l4/4T9GCKxU6QxQcRyqLlROpRntvCaHbl86Dm6wIOVT2o4/0vUq/8+rWkv03rZ1eLPqmFlJnZRMpWtgL+MLwFIOLwpoTbYt9fwGCZYBeXmwdSLIm4wezw4CZX3Uagdvwh+Cj2lJwQZad6mi7zN0hEi4YHnI0QWCesEysM1LLKAZsMqJWpFYFmXdFXR3Qy28qa5iTg4WOpcr1UMdYWgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WQpLT7OrrPmvAFTpvGgueQnLYniySDK7OR7cYsu/Fg=;
 b=LfqfINbeBma5RYblOWzEfVAMT3TgiLzHe9gugGPQksyO2N/CiJG08fkwadJBzx44Csc5IEF4otYPPaLfalluxvs9i9aogg0WX9E5qQvr6+oSehPr67ouSHiPKPv8qRFr5FNWWxCU/MMs7+ntBv+4Z4J/P7OjavBMiGXuPFKV+nhPp6wFzix4k8f8OgYW7wf0TtoexcZZl+uSFD/8i8+M6tqPiQxrk7qqjuDhfm+o9DpD2B2Oq3AqEe78BAbwvVW5GlFj1g878E06booYp5ZdGo3yoFnTqldoXWEgtHx3Gze7WgQxKoDaNx4rqrtL95iDfZ/j+4I4MSCwvlWKUYwbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WQpLT7OrrPmvAFTpvGgueQnLYniySDK7OR7cYsu/Fg=;
 b=tPt337/y/BsAZApDSu2DWziZpaBsNnWyhfTW989IxVm3kQIeNzvPpYih3hCyT4j5rCVdezCEjdb5U5NikcH+3gqyer/I4alb0CvHcEWTGd74myXZp6y69a2imnA0Yxzmq4IJ2XizV64S7nQ/ulX1gu8h7stuQE7RI+jbcXhD91Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:26:01 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:26:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 12/15] NTB: ntb_transport: Prepare remote RX info accesses for MW teardown
Date: Tue, 29 Sep 2026 00:25:47 +0900
Message-ID: <20260928152550.3354675-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0179.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 5368ed21-e09c-4e35-53ec-08df1d74cddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+x99epdHz5RkcOURkBwpjqnXbcPlvRvOwFNvAR04s2ToSKsoWBTMfVmoQvNHs3Usq18NrRVUPub3WZsDc7yzM5Xrz5E2T1wBv/6bTS1dgh1pF9m16qjjBCzH7xqh6VuVGLE5wliiRtrak94nuF6U6bsE0D7Cf/U4oSFgIy41tUcud1dUVr2AU0szOwPASppHJLm7JSSdq6CZ7n2Hqhztw3sb1VktP8jg1RsH2e7ErzJjdszekma3+hlWr2Yc4zQCSGGtR9vmV5saD3zJCrv3l4miloQxNrKFt7k0ESivwFdtEj3O4456UCSnRjYYOXavDnPiEW1ZuQbo1dUY0ydsp7e1KWfT1eWoY33TnL/yKDaevsa5yfu0gvmyDJ1xTVe4Web5hXFHepwOpU2x7EdGSzUp6f4rTA9V828X3rJxzvKvS2U5SKZIiHS6xU66Sw3pYxGTX1pBMgpenlN3Ja+DsK1QCHbG5YkEUqIabIwQoruTbnqWVR9K3s1sQuPnvAtArFf3P9zi7Rq/K6PL1NthCkwb3CE81VX6l0QfP/e4zScs7VyB7DcL+bz8/Tb+wjAMIiL9+cxZgHcBD0sCi5hgNaGzq8fh4dCXzRgtV/oIYvg/MMJcY0r64ODl7eo8d6T1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NFN0Pa6KjyxXOnutb0WjpCUbNBpB0y5yUyaXGXGda+Ig/OGF6NWLCS+RWz1Z?=
 =?us-ascii?Q?63aE5MG3Wf88BPiTSA1lVQaQ+HXOybPuVxLyYnOm2QHnnZLS1POgOF4LRQvT?=
 =?us-ascii?Q?45/SY0QDrP2hx5CkRQ1hePrW6OO67GlnQLcav5h8m62YLCrnXTOnhRnbW4um?=
 =?us-ascii?Q?7VWuDt7HmaiHfI10gBsIO8G425sYWnXQ8hvlks8wH2n1ct6f4hEw0mFnIhhb?=
 =?us-ascii?Q?bfrTVimQUu5Co8T4HxQct8KXE+3iiGjCp2pGo3+5fOXiSBYYBQlyB/jUdyEi?=
 =?us-ascii?Q?UAzT19GXl1JeE0aAjL+LwGeE+irIiVJnuuaE562vxgYZ/VjpgrhwcWpbZXKl?=
 =?us-ascii?Q?1qkuRYBX3INLM5+iPUjhwY+coxfz63d0sbBLKjo+66iO0KvmfJ3B7DajcHkQ?=
 =?us-ascii?Q?ozHtK9FA+u5HJpTd/nUC2EWS3GSj5aLLv24MvYKt8UpYuKEsvqThrRYY4Dym?=
 =?us-ascii?Q?kmet+nfeClWcgZOnCsT4MKqycyMygVelMdz9ekh0/n4DTc1lLu04aCw2D2Yi?=
 =?us-ascii?Q?w2r5BDz08eyKAgqpSuuEs+pGnA1n5JaY42WaKIuxmkqZynZgpeNdKM4q/I5b?=
 =?us-ascii?Q?JdiFiGZqRH8dk/EfJJYu+83bg0A6po7Yb7CDfBfadxef8Zzyy0uYsC89JrHF?=
 =?us-ascii?Q?aR/gKnkEIWHJMMa1AyeCNxuvbV8V1J5ANnJ5JQ3VUU+ttzLf3vWH4itaYp2y?=
 =?us-ascii?Q?IDagDoyev42Np2enwhbYmDZPQzow0/HzNYfsveOfqh6ikSj5mmEkDNXu7am4?=
 =?us-ascii?Q?KNULdrqvWQ62OQXi8X7uNZN1seOScT0hJK7WhCg4QanqyVUjMvgbVtJQRAMr?=
 =?us-ascii?Q?WGWXk3yMH0M2I3ic7JEBtJkkfleQbcJXoCyg5iEsrg1f4dq1Di5A5sQvgqPJ?=
 =?us-ascii?Q?zS1HzwgRilZ9P5dUNuLPXi5lyMnlObyNpiLiPhoLMDovdnW876uGUhDp5k81?=
 =?us-ascii?Q?590kM3cokizg2qfU6M1sjS63m7U+wRuRNG4TNpD5jvO44lHwRUhVLKs3xyZ5?=
 =?us-ascii?Q?Awhz2nP4C00PjZlxYnIAnLc5RTiY/wDW4go1d7agpnV9pOIR7MUvd2ZGu0Bw?=
 =?us-ascii?Q?imBszntPwK5Us6gvoYb9lEB2UDoC5K2EGF+im15su8qhtRKydQ1bY2FKEg/J?=
 =?us-ascii?Q?eRuqu8mw6YRXRsA2sWBdvavCo2LlCGLqINiJanVt5EzQuduHmoxl8lQtMJ7d?=
 =?us-ascii?Q?B2lNq5YaG3nWwNY9xV7/w5rOiD8AqepsqktzrBvcSQ9xsD3t+RyPpPAfH38i?=
 =?us-ascii?Q?K+1oAQrlFNQxr+8+TWr5MtoNoZGHS1zh2i1cJObNEzqQMDHSIZ/SU3DayH45?=
 =?us-ascii?Q?swOCH7wxzg9+rfGxV9FrA1paxdmylRVHP3OWVG6gE75PlaAK/LkN+gUP8oks?=
 =?us-ascii?Q?r16BB+MLFNfpJRWmvjXTAFWDWwxp+CIZgfp32Gw7wYYJldAZWfK9NVxqePU3?=
 =?us-ascii?Q?c+5BDf8r+onFI2fVsa/i44wKIwQpt51Akpc9H88XspQTm4m5aiI932qOa0Tn?=
 =?us-ascii?Q?CJtIh+ZNBlcVBjlfcJ+592L3Iokw05G0u6CVC19GNhOdmZz27mhWZ8SrLth+?=
 =?us-ascii?Q?prnKzrOAWvam7J9wr/7wTzAk6WiSEoXSwpdKDdoj8+7vdn8yiYYnXjdBff08?=
 =?us-ascii?Q?Tduh183w/pNhqWymLfVdNMsz5egsO7xztEIKH9VG8Dt2LRWzkSAjhTu3j6rr?=
 =?us-ascii?Q?v//g4JNqo/Njd8IQRhhsIW6z9/2bJz6mbkWngV3tFBkpqWYD08FVEAJlmVHV?=
 =?us-ascii?Q?aCH9ciU0HMhBShRbhAmSohEQuewNNZt1qwywnULJ1FrVJ7PQuPL/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5368ed21-e09c-4e35-53ec-08df1d74cddf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:26:01.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9qisIkQVHLq5RLyit1hmf6c2XLN/4VYKY89qJwR+mXPaerOAVO5+rs94fyxY5ksBBVhSKpuIqHNANhZr5a19g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

The next patch clears remote_rx_info when freeing its MW.
ntb_transport_tx_free_entry() and debugfs stats reads can run during
link cleanup, so make them handle a NULL pointer.

The pointer is accessed locklessly. Use READ_ONCE() and WRITE_ONCE()
to prevent compiler-induced tearing, and retain the read value so
the NULL check and dereference use the same pointer.

Also drop the redundant credit assertion in ntb_async_tx(). The caller
checks for space, but cleanup can clear remote_rx_info before this
second check.

Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Drop the redundant TX credit assertion (Sashiko).
    https://lore.kernel.org/r/hkrizcxjisnrkedwzycnkvhxynncgj66oj7crozf5ynuz4ys6c@7i7tixcnt2oa/

v2: https://lore.kernel.org/r/20260910040836.3792333-12-den@valinux.co.jp/

@Dave and @Logan, one-line change after Sashiko's feedback. I would
appreciate it if you could take another look, thanks.

 drivers/ntb/ntb_transport.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 8f1acf44bb53..c4dfef75f159 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -490,6 +490,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
 static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 {
 	struct ntb_transport_qp *qp = s->private;
+	struct ntb_rx_info *remote_rx_info;
 
 	if (!qp || !qp->link_is_up)
 		return 0;
@@ -517,7 +518,9 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
 	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
 	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
-	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
+	remote_rx_info = READ_ONCE(qp->remote_rx_info);
+	if (remote_rx_info)
+		seq_printf(s, "RRI (T) - \t%u\n", remote_rx_info->entry);
 	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
 	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
 	seq_putc(s, '\n');
@@ -612,7 +615,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	qp->rx_buff = mw->virt_addr + rx_size * (qp_num / mw_count);
 	rx_size -= sizeof(struct ntb_rx_info);
 
-	qp->remote_rx_info = qp->rx_buff + rx_size;
+	WRITE_ONCE(qp->remote_rx_info, qp->rx_buff + rx_size);
 
 	/* Due to housekeeping, there must be atleast 2 buffs */
 	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
@@ -935,9 +938,12 @@ static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 
 static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 {
+	struct ntb_rx_info *remote_rx_info;
+
 	ntb_qp_link_context_reset(qp);
-	if (qp->remote_rx_info)
-		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
+	remote_rx_info = READ_ONCE(qp->remote_rx_info);
+	if (remote_rx_info)
+		remote_rx_info->entry = qp->rx_max_entry - 1;
 }
 
 static void ntb_transport_schedule_qp_link(struct ntb_transport_qp *qp,
@@ -1988,7 +1994,6 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 	hdr = offset + qp->tx_max_frame - sizeof(struct ntb_payload_header);
 	entry->tx_hdr = hdr;
 
-	WARN_ON_ONCE(!ntb_transport_tx_free_entry(qp));
 	WRITE_ONCE(qp->tx_index, (qp->tx_index + 1) % qp->tx_max_entry);
 
 	iowrite32(entry->len, &hdr->len);
@@ -2555,8 +2560,14 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 
 unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 {
+	struct ntb_rx_info *remote_rx_info = READ_ONCE(qp->remote_rx_info);
 	unsigned int head = qp->tx_index;
-	unsigned int tail = qp->remote_rx_info->entry;
+	unsigned int tail;
+
+	if (!remote_rx_info)
+		return 0;
+
+	tail = remote_rx_info->entry;
 
 	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
 }
-- 
2.51.0

