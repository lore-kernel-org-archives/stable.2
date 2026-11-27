Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745161;
	b=GlGoTXfHCtf8GYOPNXqjufzIM1W+ExAp6Qbku+M0WR9i7IPnNOlyKzVt6A0TwYtjsiEt
	 wUGQxNh6FCGK4DmJwJlNHf7CiXxcPcPHGXSAkTEMqUN5aac4hJhRtbO+GELLj4yFN605H
	 SNtv6AJI4KIHlw6RUTofvf5BwjWZ/AZNFuvsNRhNp7U/oH29mCgBE+vzQJ0xiXZqV7Xr7
	 FKOoSfrsx/r47wHCJNLyMGLZXqehFiS8hlHD7k9IVkULqzUtmMm1zbQACjHrGZLSuRXYz
	 PzKJ9h71XpzF9C+KtBrMSBI3xuBUdpzaU1hnjzXdwDKixKPUgv5MthWt15WeW7Z21KA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745161;
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
	bh=A8ViiUEDrNKzY9f+dO9CPAvOW1tgZCoTqYhLqhTMJO4=;
	b=Y3CUpKGgnCwQF7BJLdrSDuSeFj2xtL+6Bj3bZGohiddySuFfHfK1ofGIgRQQ5s5P6V7M
	 A5pQEBW7ZCaOZY2PNZW2AxEPRUTVToE1jzrruocuPB0gG5OlSVdx+Ecslx7ePYcbtmQ2w
	 Oh6jIK8QHT8vGL995pr5STk7evH4p6aOt5tDtbUvGKVYJmD+dQvi7DwD+QdtN/9KYgfAp
	 wqya1GPBg7jU9qlDPU/uL9Nmpnd9U3O4b7CKLb4+C7u8DqZNJl2PDCVNWlY5zbj33B7a8
	 L0MScvIIB0Lt3fwzGM+KonR0Hq3WUX2WCyuDMgdKszv2svOZf8oy//Scwg/8DM0Ebzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=V+lZflvZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.91
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020091.outbound.protection.outlook.com [52.101.228.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53660A260A;
	Fri, 27 Nov 2026 02:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D53660A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=V+lZflvZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYVZBNFUIHiFucTIfDoYkGZWQhBPLfoP0SYL7cg7clU4tN+S+oh7sNDP3Z+qF0cTVH7O6z0RRmpmlPCV+smNdrWcVU4SPWx4Cd2zbDtxykp9+oi3kMe1eYiHHDbgenDv9Fw5DhlLfJykOMyi/+brR9mPy43OvQYuqQAJ4C+dmQgwOTpYcSi+ejp42dnQ+hsasPpUt82tEJCyrA5J60U3LEU4wHUasF0hotLTvgofh29ns1tx+Tj4QqnJLv48zNj9IlPz3iTVtnxiVuGYto1sChWg5xl03Xr6UGjLct+oPeXZKhOEoIhlXE2Uf/wHMUAX3FGA1nc7WNgeR88iBEXWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8ViiUEDrNKzY9f+dO9CPAvOW1tgZCoTqYhLqhTMJO4=;
 b=ZTQMo0ScVQY8mbzPzvDF/xSUgMj8hFXnUOO5/0NLIhH4g1hRCK8aIc1nDI4ObXYC8hgO/C7d6ZLV68p7mBq7M/o3DFwiLCzbk8ypBpelC6LC2ufyCSZAx6BFJ24uCMhsM7iXoYX92pVFaHOLcCYUxWk1aHqrae5JCesT79yA1ubcTEuPawI8tiXzdweRe9GVS5s3qSApoxZhamDvx0r3S5Z+KFq6n2TPDLWYSjh7YWBQ0TOupRv7BVDgLg+YEJZZHbMmtW5sf7F4G21u5sAKKXRAc+JhElFkYQoCDMHzJUeoP+sp0doEYH4TyS0OUXnzIPg7an+jnOVyFTlff0A1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8ViiUEDrNKzY9f+dO9CPAvOW1tgZCoTqYhLqhTMJO4=;
 b=V+lZflvZRZTICsCrM8OQKNRat/kNl1RbahAWhFig9OTGK+Z2UlQJXaPuHpRKsCz0zxIE3mb4rLIBQzcTRe1TaFA6kgv/8/qt9vcRWVO/69GM6dWP7v05lyiPZsckyKQVRwB/AV3PSK10OZXHfKP1xRWBjRN4L7sL6OKQc03U5ig=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSBP286MB5984.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:05:59 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:05:58 +0000
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
Subject: [PATCH v4 12/15] NTB: ntb_transport: Prepare remote RX info accesses for MW teardown
Date: Fri, 27 Nov 2026 11:05:30 +0900
Message-ID: <20261127020533.2481725-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0061.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSBP286MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cbf2f8-d7ba-4f3a-fbd4-08df4c2afa75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|10070799003|376014|7416014|56012099006|10067099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261026135527099003|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261102130727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p3UgQdArxpn4zGSdbP9jwrEQkRMV8yvupZA1Z93bri//MN/BEyRQL/6wuDaDSN6IAEyJC6cZR6pd4uqPKgxCxZ90P7JPC/mzT6rVWAeueUw3mTfTMJmtVRHuw5olGkdxo2FP0op1z4odvviQ9LjQ1OncMVUIdy1rGW23PCOGGEr7Q++q4einuslRmfQjJQjTYvUTI4asEDrVJDfj6ZjNZMe/g35chs8hgehZ7OaNU9qznCDjVA3RX62wCepwTjBpKtZuQvLcAWmRdKYscYRSPxih5kPU/RD3burA6izC+A0jw60MOh9qUpZj1fc6jHXVaiNlB3kI/Yp6g3pr32DGdZIl3eldHy9GqHE1EnIdqpDMMrAXPtGb1wZTBOHUZhugly6SgVuh/cQm+eJgFdI8BDMyM9ILV+97PnKgqkATBSjrOlVhmpgsjGiKxTr3LMV6XkJ3Ub2QKjgCbK1sMWsXGjtmu8CFMHaIi3Cifm0E01gQ2DRD8Jdm30OAbxNeUTutYbwe1OmHagCubjWdS4FQdSd/BaV52QfReeAcq5f97vgk9KtV1+r/sVpBav7QaLIQj1gsgq11GaLQUl2OYGhs6iEDTnyeBJ7Y/Uqn6JO1cOJ7QT9kGgZCa8X8LEIRCk/O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(376014)(7416014)(56012099006)(10067099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261026135527099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102130727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EWOJq83GPnEpBdXXz8mNhPdGnfg9FOmOvKcYf/uEPdtLWwfT6dsKi7etGS97?=
 =?us-ascii?Q?wjSwCY2HXorL+Mu/Wg+YKjryL4X6CmI/tepeQ0QspqvuBdJZGrcxMyn1aRi9?=
 =?us-ascii?Q?nZdCLICw1L7WomY1wLIm+S0TNelVFyQth7c+ZA/SMBOfRJDPGIHq7aINAx0D?=
 =?us-ascii?Q?wpunjX3Tu2wszGK98aCEoCGMT95XzbnO/vQzPH2gM4Q+ZIqodxTTxCyqETGY?=
 =?us-ascii?Q?o3/p/xOkTNwzV2yBEFgW5GV7HLMoE0gQkGH5Ib28VI8bf4oY+ufK6EIrrBPs?=
 =?us-ascii?Q?P8eiEN1pkLQbg31y/2gpFmDA4OF8mx2LXPFFY8S0qaB+Ick0rw/vFowDYs+V?=
 =?us-ascii?Q?c4O6fy5c2snxdnPpkLSLSizKomgz7JsS3nJ0+GVrVQGAGHv/rEwlGm4QxEIp?=
 =?us-ascii?Q?DsBC1xYKKdy7GWRswF+Wehfiq+MTgEcb58SKH8tcUcCxoOGmdxeSC3YGZvBB?=
 =?us-ascii?Q?WGUMuE8pDI0SYsouFkZJNyzgRBxQzmwPcTGT2BYxEX+y8Ycc0oJ0seyGVOBw?=
 =?us-ascii?Q?nSwGHeLpR0/NxM23FtWcHyg0cg6xJbQ+0pNNb8VgDALglF8aBMGZPprHdxk5?=
 =?us-ascii?Q?b9PX2W+/hfI+U3+27FIlUJ9rD8Rjd63RXsqHCui+j+rWY+SP3Q+6JzQ+IyDR?=
 =?us-ascii?Q?BlZvp2AVqV4CFoNz0OruUgQD2Tq8Ym2NtJTPrUiFJznPLknfLN7sBuMMmqV6?=
 =?us-ascii?Q?JIz5CYGpPkOBrJIWnrmg0zDnoTOIpRfqW+fN0wbMs/Icl754XQaoZpTUWFca?=
 =?us-ascii?Q?ZwLNlFOOd9USvor0lR0SkYHvxinXlc677SQcllFQYfFVxsaS88ihfoFfz/Iq?=
 =?us-ascii?Q?2wF5HkICyRTu+RIkMiHi484QkLQ6yAc+E5ziTROsvhyPKXFGijdDRaEXdiNx?=
 =?us-ascii?Q?yHuFEl5nO19SufoZ9cdZIejhLcOW3KV1K4dlLI+K0FtTLaMOgEr2AAiZo0za?=
 =?us-ascii?Q?OXXYDufuizLpKddWl3swSUCN1bYwJ+xyk5VOpGJwnPDCda1MXWB9ET054fMq?=
 =?us-ascii?Q?KGUnzfa8eRLCeIXLJjEYdxVca9tn8qIL3gLJES19BbkWqU7G2IcJYlm2U45Z?=
 =?us-ascii?Q?h+WiOerCau3HhYMXcEjuoRsEFEeX5Wz7a4D/FEUkvWVtfyD7Xlu+J5aI7FHi?=
 =?us-ascii?Q?d7GusruA2Q1kHGQ+0gRD3dcfSRepQROh10NMfA0jaOd/A10TDU9ljUz+9EbI?=
 =?us-ascii?Q?DG3NLldZmO6bHsuAy2MeKs6ALuLom6p4ajZcxaSm5SNxAe2v112jVTC8V8CT?=
 =?us-ascii?Q?f9TWdFpCi4Ki5/fNKpoROB10tCPDrf+ZBllGfJxywWbiTRtpcNrZdzQKVL2p?=
 =?us-ascii?Q?8WMuTDpUMt3ICHhGXPtKO1znpCILJr58imQxyzcQEuPmheh5OhbLo8AJSYEg?=
 =?us-ascii?Q?El1tTV9d5MjiqSLwPQptBd76tm6UiQXbWXkTB//fTM0QrMntOr+FLT5wx2XJ?=
 =?us-ascii?Q?0X4bcTWAFmr2/Ng9/+snot1f+RyZieuKuon0YVDuiBmc84psCBsvuIiUDhQK?=
 =?us-ascii?Q?W4VL/kQerfFXqdxxKH0jmk1PG2THVXpUNsFjbKKQCQxjNFFoL+6f+KEEAGWp?=
 =?us-ascii?Q?0byyoixofDxmvjqq1WXezsG6KwvSOzc141kj1yEtk9abKHd/L+wUpGOcxsux?=
 =?us-ascii?Q?N9BVTWJZP0/hVdDAiK/OyIAiU6V+UwY/cfvqZ8NQRTVkKVOzZJQ09ALUADZ2?=
 =?us-ascii?Q?k0M1ukn+He/Y+P776Faj17gY4MHS6gYz5L9bkSgLCDhvFDrUIVWsEeGIhST7?=
 =?us-ascii?Q?VFMZAQI3qPDxGgCYj5FiS2AoTAVjFb/R8E83pvvWqXSZWzJ2S/Om?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cbf2f8-d7ba-4f3a-fbd4-08df4c2afa75
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:58.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wf8+d57s53keA4hebZxrrATuzNjnyulMz1kyHFTsIyp7I20qW68ZD2PX7P7cTAiI9dXPNnNHp0qKjmTaD1V7Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBP286MB5984

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
Changes in v4:
  - None.

v3: https://lore.kernel.org/r/20260928152550.3354675-13-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 0c661558a5eb..fa53fcb87bad 100644
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
@@ -1990,7 +1996,6 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 	hdr = offset + qp->tx_max_frame - sizeof(struct ntb_payload_header);
 	entry->tx_hdr = hdr;
 
-	WARN_ON_ONCE(!ntb_transport_tx_free_entry(qp));
 	WRITE_ONCE(qp->tx_index, (qp->tx_index + 1) % qp->tx_max_entry);
 
 	iowrite32(entry->len, &hdr->len);
@@ -2559,8 +2564,14 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 
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
2.54.0

