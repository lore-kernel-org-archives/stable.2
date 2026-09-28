Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020126.outbound.protection.outlook.com [52.101.229.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630C4E8DE6;
	Mon, 28 Sep 2026 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609179; cv=fail; b=ITzR/7szmahGNapAtTZx7bUmWozoeXg4JY/gtFyWZ48sBkHirCb9mBhVs6G0Anq0aTeLY52S4cOyIgVojOwjzT/XvS7cSi2iDYko5q67eUjAEmUrq6BXndtRXz5CsoxVFB9WMcTmH10zgsxXylH8lYYG8WShuCErKTkwoh/d1zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609179; c=relaxed/simple;
	bh=SNgRqr4YVtggbH0Goi4wDN2FgWv5qoKOnA7ggFW3XBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nCeq+074jJC4/qT0jhYIS4UlqowzVsIcBdxMpRyVfn5xXhrbV6HVRYLSH3TTueGnnL7weRGw3cbIMXsya6thknHhtInm6jA1wqQnsDuPeRdv5c+RH9lyY3V9wNDQIwY4ei8pUIoe25OhhOtkUgNtPwQBgrXTe65TdhPgoneLtbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ej02Uz4s; arc=fail smtp.client-ip=52.101.229.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ej02Uz4s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDUuYIo7lO3L6CiX0c4ei/5Mb601Ndg8ab5cT3xa4ltVVMftBAmaZIYLIefSI6zoEHOV0wDXBA2yli5jyOETwWmqNiHKsMueNDlS8h10xBwAKs5KzwnVfjMEY3ZxLwJNiQvb+Hk/MlcFiVro17KsZj+NNETaI1KiiwLFZbD4dqLvyLgusCvT9u3legw3dPOp7usoj3G6Ia/un49oIGdfNSJGpIIWhXdHzfE57FDmonQGtN6XIxVb0GsVEOI0aB8zkrFMC/w8VpbOjwIy1qEBpU/9urFAWcRm83s8U4e/f3WHROiEtTUeb3p+4tEa0RhIVx4MC2uotJRX3Uhr3FSAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXiIO6CL5kXeKTw2+38PeosFZOxP/5JuclsJKfm24LE=;
 b=hRgSkT7VOPG5Vxr32cNvucQAHBqCGxaFKYhbOiV4/vqOrAbpt/ppHOZGOIPbzUbhpQoexM/LLpak3qxx8d+X2FzF+v6I8wGElS8LmT2KLPUw0tOfETyfOlUhYKEoRyqj6wLXe2oXWmCbX7TIsVsgqKsoDZsLEp4xi3yrNKt0IVCucRje+XFTQNuajYFfkqaA4yZIeL3jB7uE+027ekqtuc9oSbx9GxVXv8N1rDUOYTQDf2iSVs5kqMqsxaV/nnffJzdzgXkyReSFF5cfNsbqw+G0Q0vLTBdmXm1aznlYMcKPvv11cW5+eJiKtk5TGx2ZfW/e2YTWQOxPb83V50hjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXiIO6CL5kXeKTw2+38PeosFZOxP/5JuclsJKfm24LE=;
 b=Ej02Uz4sW1sH4rHMaVYpXdZD7PcZXaCAoTnp/tsxGIHufO09IvfsXamdKgrAjZq+dTLu79RRhi7BJHX/CfWVqO6NPkpytOgpnmAkFPnrUPb2UMEwHgLVqidEIP36TKtXOryP3wdLL1IG+ZkRmlgCWsSvChdtmd1TTRLjcpGRayw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:26:00 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:26:00 +0000
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
Subject: [PATCH v3 10/15] NTB: ntb_transport: Drain RX tasklets during link cleanup
Date: Tue, 29 Sep 2026 00:25:45 +0900
Message-ID: <20260928152550.3354675-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0281.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ac53e7-dc47-42b4-186c-08df1d74cceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fTNOiqO2jHTAWt5eqivImih+ox7ZTqeWYIjQeGPmVYtdmpLG2pfRhru4KTWwl9t5kBzc/YQyGUmVLPzOnDJh5AX6NPq3+YhZhIokfLpEfOnPHeshPrS9rVunTFALhzLCzkfj7ikJLY3gcxMLWHUrExOBVGl7+hIii28YopsStUjmlyLCve/MQEG8BjW9cADaRojgWgkxA7x92eYhCcDDEMicBABdgk+13IoQzlIc5FrbFdGqAYbgtj3GREWcJJpgUtumSib7Q3qpCasgqthrn7nv+mEXIdE+cVk4EHgy+AYG6vTSuJM7sAoc7IxuNSXMzsIAN75AffSjtN3we1SlN2jWb+hUKdNM3i/vnJ+mEXPTd0AQlSy0ciKB7+47u70kKwlFz1rFU/Tv2kR3Rh9GVFN+XRLbHR+Jx7R4G8JEJePo7ub5EdZHfScO8QaRzR4Yxntg6j7UkdI4RaGwWkqWcZNqzzm9BpVlBuA0dqwc9B+uRdqMJYBJmtC/WiDdUtejMeN0b8DUoh5hvrcdTqLpQgzAuSmQs3M0pgqynqqzzWGwPp1keuLTl0Ffi4QC29c1ar7ui2tgflAnVjZXknoYrZoYE95ClNyVzoxMxKOD1oiVvEn0RYjJ7NxBlYGo7buwECSYmPG3vLz0lckz7B3Czw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EiPHBnlYGCqHkkuLrmw8zQySTIWqT5M9TqY/Pi45GJ2b1j6LaOGIRgnz/zyG?=
 =?us-ascii?Q?58Ui7mb4GNsaMbHcI/IvaiYh2gFIflyIUoKULvs8O/ZqwMSTscMZsZOTaf4u?=
 =?us-ascii?Q?XaZCmtdDImoyP3JSr99yVKI7JHKUvWSkxxTu4MhDFb/KoRuMaOr5br+jpSmX?=
 =?us-ascii?Q?dF0T5nsAQ+MUA8HepGMpAnR7D63xCtHUx3V4H8XTZCDQqlpuXCOh7QcDh1qG?=
 =?us-ascii?Q?aYcwrLNIbh/VqiZhcLS7ersQSJxuw0J1iwzxU1TX4euH8XvsRNqha153Sbie?=
 =?us-ascii?Q?Bo30cLj9btiCErfqmZ44fNMlw0TACYVLuucytxAhC0rP9Lwf62838gA9UXb5?=
 =?us-ascii?Q?GvimL5MDPVOUukFgIxY29xNdAG2aD6cnvhtlgQPadYUQBvsVkyGUQODE0ZYX?=
 =?us-ascii?Q?946lCfTg067O2n3iG+NTZanj0HnCKGqOoRRXV8JpTStWT4yW7niuLi5tiLGi?=
 =?us-ascii?Q?CZOS9CwfOYbTDwPtamTlr4mnInCyNLff+lJP+WVg11SK0rjH062tVrEsP7Rn?=
 =?us-ascii?Q?ukEGLu4LCoPkPBoAHSOPNjhS0ro77Xi/X2AE9ZODUeDv1cjmcrHFL9Ij4RMr?=
 =?us-ascii?Q?DVSnTZkDI2v1d9koSjg99ws0KnGy37r0xvSSbSBW/ZG+6soZtGeHD6g+DcTZ?=
 =?us-ascii?Q?uzLgkjQSMCZ5OaZ8XpNGTpWhsHhb3kR9JQ0F048dnZBUyMOUqsHsGc5xE3/u?=
 =?us-ascii?Q?9ZL6TcCDROoZ8x/5JfVPalTdL3DDAhVe5tI7W5W++B+HIkqOgu+bM6E6Ok84?=
 =?us-ascii?Q?P6N5dfCKUhjyqDy7O3GEPMXLgxtkVeV8vZCds4GygLIUMAS4Zz80uNOe2U01?=
 =?us-ascii?Q?RYdfct89grZfeaYVR5ppd7mwXzfRrNCmqnxSBpnoUe0P1IxwubxNtKv384we?=
 =?us-ascii?Q?xhuFvWdJ82ofQx04BOCy3BXFCzrh3R4xnY10vcwuHSFDXM/X3+z9WVmD6d4G?=
 =?us-ascii?Q?F0EJWOYH/q9ntM0iD218eXu/xqiGhLqenpzkaENhtpt6bCA9fvhr8JI6y9qL?=
 =?us-ascii?Q?QSv4OY3rcu8cAckb48ZND5fmA2bPCB254s7Oiq8G+XPGEXqFLSsgORLXgFgZ?=
 =?us-ascii?Q?rGTYc6aydRUK4pEEJtD8w8Mzk/d5e2Q/62aLnsXpGDOQZjLRgQ0vLo757s7y?=
 =?us-ascii?Q?IsQvxi446N1dIRRYmOablYKLdmwRi3HXMKe6PNLXPFh1j4BzClPe3WK5R07B?=
 =?us-ascii?Q?CVQ6I7+2mvWrFXkLPbczZSb4DUVA8LBW6rEfCqQPWBbMewDDnQ0UvVlBxYQ2?=
 =?us-ascii?Q?xb59vTQ6/rnWKdxiTWSpHPgRiq4eNA7W/TrBM4YY1LpjuT0olCf7ElaLQupf?=
 =?us-ascii?Q?XGvceB7Hq+yjM+zak7TlHeaK/Gy+oHR8as2uicJQi0gGeLgYpNOMM7I8jFvP?=
 =?us-ascii?Q?VqNjvuvqzG9EjvBcTt7CF6rPjOM1ojo/CSOy68IrrlrW+mgTjHgUzc0NM57L?=
 =?us-ascii?Q?EPuY7s5setr7yJk7YYS9tNt4DSJ9Q/vB9XQJ8WKtrGPdAXLCvXecimLq60nJ?=
 =?us-ascii?Q?RFvGNaXJz7BayPs2tiQL9eNuW/WDGnEZZfGA3yUcd/FBSbIzeQ6JjsV7ocma?=
 =?us-ascii?Q?CM0ZBaYR0RwnIR94l2hpNF6E3w2E2EHRoz1c+b756892peD9KhS66KvKH38o?=
 =?us-ascii?Q?dEg+H54cPVVuWpN2B4tgwReSo6msni9qm9QF7z1w/UzfQFdNtvMWocXDlKzt?=
 =?us-ascii?Q?j6lUMuzb/8y1S0nOkM4+VirINa08qPh51vZT8HmznVMhtuRZ/CbfJlFQu/1q?=
 =?us-ascii?Q?s9fJmxACqjDPdxsYgMm9ASEZa0y5sJgc5DODd6cCwh6nfNiqv1XP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ac53e7-dc47-42b4-186c-08df1d74cceb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:26:00.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OZZiD7zJvZUQMrSRilVAwcXZLBJcbIGVPTVcPnBC0D3W5cfg5S9zkAmTHXMTqcdljt4I6nk+bpgiB9mTj1Fzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

ntb_qp_link_cleanup() cancels QP link work but does not wait for the RX
tasklet. The tasklet can still be processing the ring while cleanup
resets the QP, and transport link cleanup can free the MW before the
tasklet finishes.

Clear active under rx_sched_lock and drain the tasklet before resetting
the QP. Temporarily disable QP link work so a concurrent client link-up
request cannot reactivate RX during cleanup, then re-enable it for the
existing link setup paths.

This does not drain RX DMA transfers or their completion callbacks.
The next patch waits for RX DMA and its completion path to finish
accessing the MW.

Fixes: 9143595a7e05 ("NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Refine commit message by adding a note on the RX DMA follow-up. (Dave)
  - Add Reviewed-by tag. No code changes.

 drivers/ntb/ntb_transport.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 30411e118a7e..9f71af97a8ef 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -957,11 +957,16 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 
 	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
 
-	cancel_delayed_work_sync(&qp->link_work);
+	disable_delayed_work_sync(&qp->link_work);
+	ntb_transport_set_qp_active(qp, false);
+	tasklet_kill(&qp->rxc_db_work);
+
 	ntb_qp_link_down_reset(qp);
 
 	if (qp->event_handler)
 		qp->event_handler(qp->cb_data, qp->link_is_up);
+
+	enable_delayed_work(&qp->link_work);
 }
 
 static void ntb_qp_link_cleanup_work(struct work_struct *work)
-- 
2.51.0

