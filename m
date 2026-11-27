Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745163;
	b=28OvZkyGaqikvGlJt1ngo9tFRhCFn7lDgcQMZGMlZEKkU5/DfNbIoNfcuHbc1mHRSL0N
	 plz60Q0JM69KtwpooSfBrnE3DWjgcZskHhME0eaNjE4UMI5uOhCi3kuV2CmqJMgHl9cu3
	 E4uesmIlKxWN2QiMLTY958LIpOJLcx0y3nXM7UL23fVhdQlV1sO0jM9W8+kyhlkF0pmie
	 9a46VKC5P6w9anJIZUHNe5R5Ic0rTVr21xnWXuB1/kdlkWF+bly9ErkWeQ+zSTJw7ydKW
	 /aD/kCMLsuAGtnwxdlREdpN/hfYsIZb4pQ7uA7nPzkYUo7gG+Bdd9QGXEIt86+sdm0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745163;
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
	bh=9370xYzXjM68J2gkAIxYVkHCczW6TxycL3X19QI1NU0=;
	b=c5sx7VAEI73r8QMpnd7ANHRCoF4Fh8AJuLZDPqPFEA0kzDYZkGhOyz4hsP+QVVyvPb6+
	 7LyGWB97f+CfzbZJcDQJTAcMJYSzllkk9XZVjXPlDXBEQfpdFgeiTgqDHwiH8jY0xXa6e
	 03HJWBJ64SQ32Q1U6XTBaOymkfTu3w2uAomV7V+VTlHNLC4nsQ5CSJHsKhXDPbyN14MpX
	 LOppEiXowUMXyIjemddQ9ic0lWqTsVYoRywZZEF05jN3YvIOdXxn5GvW6tfGzIk47cZO8
	 ZCK/fxuXLIP+97nQAqG7VPzr7Lde2xHMhirw/dmJ1Py2e7nm/3Y080MVaYXl6QWXDSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=qiI3ApMD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.91
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020091.outbound.protection.outlook.com [52.101.228.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081F606A33D;
	Fri, 27 Nov 2026 02:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5081F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=qiI3ApMD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiK/qMM3R0wuyHKg0in4kmtRpUX/Zuy5yDS8buu4mNhaVQRn7p+CPgYtB3CGQcABxlk/1su2QWE6vYEs2urxpVEwTku0XPq51A9ufh/rXYBHO8T5Apv9lZ8xIzLr1TARRDUh4W82xXpq13dK7PP8NR0XW0eIP9A3H4vX3iWwmjKI5ABQoK29tn/YTymcLhfOa6qcttqbMU3a50F1ELcFhj2AyVEaT1OZ3JirnsRoYCloBCwxhK9asS0Ax+vqRGKhm7QdKjRrtFVKVTT39Gt2IcIluyctlGttQev6uWNyBSRkULzHo9P2uod0Tqdms9rfvshsN4jxrkrPqXTnGgxODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9370xYzXjM68J2gkAIxYVkHCczW6TxycL3X19QI1NU0=;
 b=BPQI2xlI0PMkE68qqWwADIHe1DMIAnBO40q3GJkpjXz0yN/WlR8zXSf1UY1fc8jYV878kKiy6kqlv0kdkFaw6q1WuyV2nLyrcuXh3y4dX53hG3DucfLGOIcQ3qrRE4rVvNS0AMjDYQgWRPo6nh+HPUZavOeJChy/YS6hX6Y8aQC0hQWrNCr0aJA4od1KvLRtR3G6BxzlVn1TOFb9RPKAswFTSwUFPuRB5nHcJMQ09fFoaBVJWxA62C6+Te21+fyNLghklOXESsidbkjVft3xyF7lrUqfMrN54QIzrFlXMLt2mCPk8choWLWuiqnERN2Tbm48bbyLFxMhmNJbN4UFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9370xYzXjM68J2gkAIxYVkHCczW6TxycL3X19QI1NU0=;
 b=qiI3ApMDq6uf2kc3Wlpop0Yeiu8PADuFxdSt7mojv+3R7KI7/HC0m5KQSe0gK/ryXjnQraH6Db2o6VRcAj1tWuqJjQWloQviyWxYQ0vBxUcX+6OQuj398rh22F78BPwjnWhSeYxYmG21pc2ZW93jrUN2kyEJKeAPGx41+HO1Anw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSBP286MB5984.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:06:01 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:06:01 +0000
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
Subject: [PATCH v4 15/15] NTB: ntb_transport: Remove clients before freeing transport resources
Date: Fri, 27 Nov 2026 11:05:33 +0900
Message-ID: <20261127020533.2481725-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0124.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 7ce0129a-c328-4bab-6cf1-08df4c2afc4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|10070799003|376014|7416014|56012099006|10067099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261009221227099003|261009220027099003|261009223327099003|261009223027099003|261009221727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zilpdZfgk39q+XoJWKNKrCJYyACeCd/h4+dWs+hq8TgV3wLxQBpwO5ZPF0NdZE4775zyTKB9EiGp5n3Eu55hOxdL6VazLZFCXtrTw98RLBYdtyzMHB0oevVspIbCF9u9k0QW2kbL8Zg8ZC6JZT+cjgadaPMgSNhSaNN9CicXiRECsG7cKuaeN5HR+bIITP90EUCLpW5fgX9EtQuPotWOtB6NKAeewDcdyvXig1PGN6yfcv/7/6CsmB9nsPbbBBfUkuKATTgVUiBQr6s8QARbBFTtaru4GiihTd8DkPfbJ7iKuCMAiyLPz2Yz+ATNsTAXl1na7T4v89/xjcaMFxGPGG+Ivc52WebZZnAgAghlsFFkR2URtB0xWdYJl15Fo+ya5R1D4VKWR46ky0cafHMCYu3baIb+Pljhtwzcv1rxyjpM88b7YyG3zTP99Sc/j4Niz5PCgHC7NJDRt7pmUMKACgCnLtSA0Qg+Qgx6qIdvbXlL3idnReXAic1Rr/eaaSA3quJReAyOJJo8MGTSc14v8b2KDghEUnheDOrVypCdBFa3mYsYYlCWfx0SgOutb5P+5v5fXFsAREyxgrEtL9vtQTLUj9RqY3vz/rjLiOxcJqHwwr+ORIKpAzDozIqy5etdxTzfzU0gZ6xF7Q6b0DE+MLhD3MBSnMgiObQnohHfI1Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(376014)(7416014)(56012099006)(10067099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221727099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ehTCu8jt9f2ymKrS3e6RS/mRBCY1pZuJ05RuO0pdrzwnNhQvkVNsW9kKTwN?=
 =?us-ascii?Q?OIv5Zxrxs9D3HsEK0TfT2lJHd0isihFjzh2WmKt156sgR1p2lmDTfjNcd84k?=
 =?us-ascii?Q?y7uq81HBXdYQ0KnPokgm6uu2GSuyZokWg80RyaW4kOQAb33G+BAoh76UVMeI?=
 =?us-ascii?Q?woH/MkwMbMlXRvcbv6f52a13iYIimIWDrSEzdgF9jD31o8zWKH9iDB1hLBwI?=
 =?us-ascii?Q?e+ikb+jj/ptUgA3Hf+E2P53Nx0Z6yiCSq3VZQgjpL4TuJytj4O0Z/DM6so7m?=
 =?us-ascii?Q?o6zCZ6puvtbGU1brdOoVRW1Kt+p5zYGaHtrSqTx6eXsR8o0QCBPHRwruyNRb?=
 =?us-ascii?Q?6slRxup3W3QWtGZxDMereoPDso2jt8jeMklHSKvz7ufm1NnpbjEyo7ioWjpv?=
 =?us-ascii?Q?cQEoIJeQq0MSUQLYv/nf8DKLvP2ZM3xGLrzHqUMRU3mXoRIJ//FJpabegSH5?=
 =?us-ascii?Q?idh9Gkv003ZZ2KWHmxSxc3GyE1S08+f9TTL6VL3gt3ytyouCIHFIwWkKbXGw?=
 =?us-ascii?Q?1gvozHSQyykKEtuwQfC/aovG3HuMr+k0CUc2FIpzKt3itQPOSc/q9PhL6Kva?=
 =?us-ascii?Q?SrIoLcqsp0II1vmR28GdtXkBAsQ0gSdqxwrnvT82LYiUcFaRymUlDHo8tfaI?=
 =?us-ascii?Q?/6GEoRm+gM6iKAv8YzVCZh1mf8QtSrf66NmhsRPjUzXbmoHqH9mI6TsEApzW?=
 =?us-ascii?Q?PXdQQZ/t/ZkFi31pmoky0zYEc/tmle+AW7L3Xi2qLoMyhrDvBXXUras0P1oa?=
 =?us-ascii?Q?/TbGcIbSQ0CjY9jiyc8AazT+OGqPzHRrVsjxT5AionfAojGleOvd+nxp+R8t?=
 =?us-ascii?Q?2rMrnpQS2fRZczkd1131UPpCcqFaXNQE8mmK4xNrkmQ2dt67DWpom/31vpky?=
 =?us-ascii?Q?BrDf1eGqXM+lir1TEigpoQ/dNKcmBU3uI3lO2hDpCelKYddzYn3ZP5XnF4qI?=
 =?us-ascii?Q?Tdp19eVCIenRioIm8FIqai3CHA2o7vhJTGRZDoBWMPSe3vLuzx+IUWOZ1wRo?=
 =?us-ascii?Q?cghFcn0tUHQigzUNcEIcDvkDxZeEkNLzcsUv7sj0TpnoElrhPdmGATQqtwcy?=
 =?us-ascii?Q?YDz3SFqmWzKtE5YBb+V+YljqtGwQn7UQBby4+kROMktiUcLqyn87LtJI6xwR?=
 =?us-ascii?Q?cZ/CHx5Ju5NrIMpMIiDCQQF3+ObEYAiPu/AW/BOVknE2w+Ch3EbvhTKNmE+k?=
 =?us-ascii?Q?WuH31yTcZfhioJWZfkWUh7NXV0yXP1J6uPKI8ojngxjrBuCb72zJys3Jk1ya?=
 =?us-ascii?Q?v3xZw5cBacpy9HRlfZKI4CPpWigGynm2OBB6tWZu0ZdXWz/Fz6cilOZsi9rW?=
 =?us-ascii?Q?YW5XVryLaMCsaCemrcyIFJt+AlPdIBmGzjeHxPQGEu67I7RhTNrvV8krq8Lq?=
 =?us-ascii?Q?7n2DKz2qXADLtLduI3+NRgEC0YjBE2ZQ4rvDFDkM375K+hDOhmI4sx4eMstN?=
 =?us-ascii?Q?H+lZ0nvvuHr2wQtsO3qHcEOkj5NdRYLJYf2+OXGysUFE0VrT8ba4pFHpOZW6?=
 =?us-ascii?Q?7Go8+gWcR27254MUKNNCM6tgP7aevx4XOTwIpqfpif6OI4aviDZqEYhIXjFa?=
 =?us-ascii?Q?YPRCKRAlpm8AQA9+eypYyg04WQDDqXIZH3JW8eMsXC+GuniHNUe4D+O9MXdj?=
 =?us-ascii?Q?5mIlqAKAMj+gw7n/eNgrYvu+C7cIJ8nkwe2pkTnY7JRV9oqMRs+Qn/QyFQ7V?=
 =?us-ascii?Q?ep0MNyCFlTkjsTCz/AJVPKbbw6hFgsQXUlyXMPcUZN5PPNCSSpDZLjRT3m8X?=
 =?us-ascii?Q?Ky5gxriMBtcAB0WhmwoaslmiRf7vxyPPRTO92wMS/5/kwszLYa4+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce0129a-c328-4bab-6cf1-08df4c2afc4c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:06:01.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ehlr9fw+8YzWSa5VKW2MAqiWtg4TnI8B8nz3GfjvQLyeKHiyuzNa7hKLvkkU2rU4uyJ6S5bNSW4Oo1VS1T5A5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBP286MB5984

Unbinding ntb_transport can call ntb_transport_free() while ntb_netdev
is still bound. The transport frees MWs and QP resources before
unregistering the clients, so the netdev's transmit path and timer can
access freed memory. Its remove callback also calls
ntb_transport_free_queue() on a QP whose resources have already been
released. This teardown order is unsafe and somewhat unintuitive.

The crash can be reproduced with an intensive TX load, during which you
unbind the NTB device. The following is a KASAN report from my
VHOST/HOST setup using vNTB.

  VHOST# sudo iperf3 -ub0 -c $HOST -l 100 -P 100 &
  VHOST# echo $VHOST_NTB_DEV > /sys/bus/ntb/drivers/ntb_transport/unbind

  ==================================================================
  BUG: KASAN: vmalloc-out-of-bounds in ntb_transport_tx_free_entry+0xf0
  ...
  Call trace:
   ...
   __asan_report_load4_noabort+0x1c/0x30
   ntb_transport_tx_free_entry+0xf0/0x130 [ntb_transport]
   ntb_netdev_tx_timer+0x78/0x260 [ntb_netdev]
   ...

Disable and drain transport link work first, then unregister the clients
so they stop using and release their QPs. After that, free any QPs left
over before running transport link cleanup. Disabling the work keeps
link events from restarting setup or cleanup during client removal.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - None.

 drivers/ntb/ntb_transport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3293fc4b0009..3cf2d778bf92 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1485,9 +1485,11 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 
 	debugfs_remove_recursive(nt->debugfs_node_dir);
 
-	ntb_transport_link_cleanup(nt);
-	cancel_work_sync(&nt->link_cleanup);
-	cancel_delayed_work_sync(&nt->link_work);
+	/* Stop transport work before clients release their QPs. */
+	disable_delayed_work_sync(&nt->link_work);
+	disable_work_sync(&nt->link_cleanup);
+
+	ntb_bus_remove(nt);
 
 	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
 
@@ -1498,11 +1500,10 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 			ntb_transport_free_queue(qp);
 	}
 
+	ntb_transport_link_cleanup(nt);
 	ntb_link_disable(ndev);
 	ntb_clear_ctx(ndev);
 
-	ntb_bus_remove(nt);
-
 	for (i = nt->mw_count; i--; ) {
 		ntb_free_mw(nt, i);
 		iounmap(nt->mw_vec[i].vbase);
-- 
2.54.0

