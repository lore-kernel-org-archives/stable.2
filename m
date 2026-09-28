Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020072.outbound.protection.outlook.com [52.101.228.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B05B4EBAE3;
	Mon, 28 Sep 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609183; cv=fail; b=Hd0Iy41xf6oyYtTcP+bMnXOrNzsLH3rk4ZiFj+oEH3pe/dcNQbouAy4AbTNleSfWsXwlJLe44IQLW2f76S6dHkJHYj86c5Vn5HjSF8DPRKqGB0M05ryfTataCCJk8PuT3VsSWqENCMhhXTIJAWgIcNUoxerFR9yA7QD9rfpO0wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609183; c=relaxed/simple;
	bh=Clzdqsd5p+b/4lZvWyPF6GVAK6/aKwKMNfE99F5nPvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r8ErpYZ7yFv4FTCxTg0XmlnWiVZuqHTdMExd+ADtEj9xndhRu9OF8tAR/TSIl+FMIB3g7ch3dWTN0pjAdERCPfJIyTInGmvq1pH5PhBz69fL0hxcQ9vtpnXjNGbwao60vSuLHe7UPZZvIZbQCWpPTeYowu8adbWM9B8omXaS2n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=HGBagAg6; arc=fail smtp.client-ip=52.101.228.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="HGBagAg6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfU1GP4RWXfAcJBsKSx+NE39hzzYLx8PHiVF8FvBjjoPTgk7A1Fhkh7qv0ITSs+oInNWt1LNdQ4iWIMSe5SwrcG+C75ggWh96Xsj9ztfg5QLyZE7KzI7AGpbQK6h67Ym18SWTrrIvE/8+qlXj/qC58bSjRVXqf9DRubFt3moq53dQVHg/Ro7bss2Yw/9HO5bTrVnKvazPAMd+YUlFsCkLlm/lXafeYl9LBKx10Hljs0DAidIDD2lIFg35DpLfJZ8GdXs8ZCv2J6KJwM7njnQfSmbZKNld5S6gOWwnKwtMTLis5HcUOYNIagpFQVr8VTG1RqaIonrmYFw1CN1P4/6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFMC8zMw05lfI0D6kQeNff/d5jJirQt6fsnQ+k1hNAo=;
 b=cjvmg55/3kUnaMcsltPRNncxLJMwU6ZUbFfSM4HShICUyRQaNRWfI7/M7kiO73Uq8E1NdQg+/cUX6bduKBbr05Rx6pctFOoMW494v/c06htJ89uHUgtgXRLsyLAzWPCWUZBaGILY8HoV+It0bRxJgzKUOq3eOURtM5FxrYzRMFrnvvVRLROVZFL67iYR/B+ojRSgE/2bj3Wxp2yE4fH4JxvfeFTW4K7ipBZ67QSWQgfXCqRhp/NPBqEL5SZY6M6Nyc53PymjBLNVCzRYChr+EWl/8+8z2QiANWs1bIBkuWbiKWcK7MOcmwsHUoZckB0wOkE2GYualvqtgZE1GlPOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFMC8zMw05lfI0D6kQeNff/d5jJirQt6fsnQ+k1hNAo=;
 b=HGBagAg65VLwOndIgHenLWlsLO2QaLTIZYIRU5iPEhlKBjJusYfWvKXmmDIkeM4z0kAkg7V94fRwE2dunbmrCud97qJ7mhEsXTt2zb4+O4xsc86eXxwJxyNXElBS1wpuyKwG5Im4XcFvtibCwHiw3aBTz3mqolQuj+QPOebvXo8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:26:03 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:26:03 +0000
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
Subject: [PATCH v3 14/15] NTB: ntb_transport: Abort link setup on QP MW allocation failure
Date: Tue, 29 Sep 2026 00:25:49 +0900
Message-ID: <20260928152550.3354675-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0266.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c63e6a-f53c-44a5-f67f-08df1d74ced0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cC6zVxen6St+P55U5ftgZSo4qumm4X10XZdMjWRSuQ1VIN+p7wjSK0AT7rfgX/M2+1b8TexedfGM7hwDF1P4lnXfmicIVQakuJCGS2PVZ4PnE+arqJ7x4NjI+HOmpkg9E78UP78iwW1lxyf2sy1vJzyT+qWF4CeANPk1S3QfIwMvo/6uBl7AJ87BnEh7Zqps7N5MzUx0XWl/kuYerqZOjQkuUu+tbqLkuymYnyLXiJuldIITzSyogK5aUcED9Wxswpo/fgVRDq69f1P6tAjmAdOdFoqQjilcqbMVmIlB+vQb/QFswGN4uJth7PSaxLPY8bu8XFJOw06y9D0KHQ82FYzRv/RwkdsCWuZRS15yziCKYhqfFBXfTUTtUlWBKrCcU8fNcUfcwVXvrVGtNttuDmW5dXDqDbi+p8np8KMZqCIzkxDoBoB/EZFmRDH9KeHPigM5i34YAfEUh1UuKr6BqJYCyphulG9DU0HDWW+oViTig+I0lWBhUxXRXfeij5wMbeoEv9xwxaxC8mLhfNgVMzqsjxzSVXjc8llcqzY5uaQWg66V7eb40cmb47sK8BaHTwHDXLLMUeRO4R4uuEHPD2x5qnp3pG05wIaqKdiUw548lol3kJQGMTMdFZRWckRxhcOn17Nx0hhDk4HJQMHRRpb1O8F+gWhYOjtwYFDhIkE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HJhr1ocr+eAcnHmvwUcxubgV77UGOJ9TLcMaOafjFvxRZ9EiLM3Fk+UcZofe?=
 =?us-ascii?Q?tD1jTD9md7b0FCKegSxqJVojfqQdJ7oTmHb7dmX5aOQlN2zRStt54qEmJj3q?=
 =?us-ascii?Q?TzrfUVHMXrHQgl2rNJp+Dq3QGZ79XJuJp6gcPxuPIgC1VDnYqde7Shsj5TVm?=
 =?us-ascii?Q?RMYv9YzPk0vxxhJnfsq1SmNH4Uhz9l9/i3Wy8lEWot0Py/wLX15pcJUWEFEI?=
 =?us-ascii?Q?e0avtsMa1PCGeH5vaZ+hQANU0VYfUj5bb4jf6h3bIwaYiUtBe6uhyR6WKmz6?=
 =?us-ascii?Q?wyJ52MCXsC/k/l2jP0DoO3tiPKMEJ7jbjlLFBx+k6Z0Nl1TiZFcvSX0R8rX5?=
 =?us-ascii?Q?a81V77FLueB1FYlZeS3z+Gmbge8mli2ZroQRiWkFYrDREzCpAoN91z84JAZ0?=
 =?us-ascii?Q?BIJ1QGiOiDUtDgVI21BxZsnWTqin0NRX7H+2zN7/LENQ5bZSzSe1MUK4qQbl?=
 =?us-ascii?Q?f0XFGPi1Asbx8m7Phc7lSCcGYnFuX00Y5gzsqsx0GglwJXOhdMF3lNBIyQWF?=
 =?us-ascii?Q?J5PrJQNBPSTKtvBXwXBIlI9KJEvSsmiHVAm4GiLEe5V+hPtP5C7Yeh9sCw42?=
 =?us-ascii?Q?XyQnKib5Rn96OLQE1wsrSRd1dqZezFibu52Ir3qIwDLXdePszM436qFc1YJ6?=
 =?us-ascii?Q?oknJa6m8yvdY0HoOjGdbW6Cr0L4c0MIqW2CIp+Fg2hGw9x8h3aUmumtoXtIo?=
 =?us-ascii?Q?7JG8RL6HIWhxXQyh7M0la4X2Bozw7Px++l1G9+7vzL3Kj1dCWLDEc5WyTxuB?=
 =?us-ascii?Q?c1KB1TAP9y1hb+OqqbnDMerjpHpWFKXm5YibYM0aAWIHlKOJ3XjadsONrkQk?=
 =?us-ascii?Q?UPuhuYgFuppsOa2lUqN3gfrw+WiDDOCMAeRx1rAZLHoP3G6ALS8tl4L9QbJZ?=
 =?us-ascii?Q?NWg/YIidNGMUTAlLdbb3FJaSkUGBbiZCne78HjPjoUc15JQDBGFAxgt9Zayc?=
 =?us-ascii?Q?nCciy69zt47XOKbfpcpa0wkNrotIvJS610n+Z2QkF8/jgzqfAM0fUcZ0pMDq?=
 =?us-ascii?Q?vIEJ9fSWvoywmT5/xMD5uqEVWmpnQsWObgDRs7waviefrYzHvCcBK8wWAwLP?=
 =?us-ascii?Q?cLFa9Pzq2VzmPPxUehavwYiDMSKut6bDjjAvTZtCc4FInPrNj48+h1Th/f0A?=
 =?us-ascii?Q?n06aE0LVY9nFVmMdwB5/3dM8GIWXFB1ojy/PvPH1ySrE7fOvaC8HEu+GB0Ft?=
 =?us-ascii?Q?ropTp5Dnt8vJa7KBB1/Qt2KRRIgg83PHEmnFcPWyLOdA9aLZvhGfkxkRT+/s?=
 =?us-ascii?Q?xwC78ydk4IkJayve1YMHoVHI3rMV9FhZmwSsZjSYNdZkD/h3cwSjLImbuSYc?=
 =?us-ascii?Q?jr4G8e++mdbaZQdUP6hpPCUYhNxiurtMjymOxM2ZSz94K4omDZx7nxYumhrx?=
 =?us-ascii?Q?5j2OOu6AC2Ezhs6V87qgJENOyJPrNXP46ICfWnC7DOzexR+TCh1zmOjNveBU?=
 =?us-ascii?Q?z0pcsxjJYE9JXrTB1EX9eQRTo6aNwSdkDRbGjRvG6DJEshPPOFpujwAB6f3m?=
 =?us-ascii?Q?XKNFmXmEzysTBKquK7amglJudhIfsvF2NsJAnETb+EivmTUnkZ00l2rlGyLq?=
 =?us-ascii?Q?bLmzoD5Rlt2S1FqUog59LWXCsb/AwC4OBThs9j+zCHlVqyc0dQJX/WeWvOvp?=
 =?us-ascii?Q?MsoSH4xTbq6csE9F0kaZZI39U+DeOIPCP32RHIoOKiMZbjoNExW9Nfpz6zmz?=
 =?us-ascii?Q?l/RR0SIUx8lGeWzjTBE+JB2mJrMPKHBEgUxBFhfPq+JhrszsQkCHOFzztESR?=
 =?us-ascii?Q?M4FAJTg+3/A80nV2iGDEiB936ffBD+LMjBuxz1w8deWGRuEG6ia2?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c63e6a-f53c-44a5-f67f-08df1d74ced0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:26:03.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ym7UZQB9u0rVkgypeB8rHT3ibdMc79q7jsbaF1OFNQGwBZyNJYdaLq8ZBYxlcgRfsan43a+Wi8nDNVQxBxR/xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

ntb_transport_setup_qp_mw() can fail while growing a QP's RX entry pool,
but the link worker ignores that error. The worker can consequently
publish a QP whose memory-window state is only partly initialized.

Abort on the first QP setup error and release the MWs through the
existing error path instead of publishing the transport link.

Fixes: a754a8fcaf38 ("NTB: allocate number transport entries depending on size of ring size")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Add Reviewed-by tag. No code changes.

 drivers/ntb/ntb_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 9f23c9c3d220..af7f240479f4 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1149,7 +1149,9 @@ static void ntb_transport_link_work(struct work_struct *work)
 	}
 
 	for (i = 0; i < nt->qp_count; i++) {
-		ntb_transport_setup_qp_mw(nt, i);
+		rc = ntb_transport_setup_qp_mw(nt, i);
+		if (rc)
+			goto out1;
 		ntb_transport_setup_qp_peer_msi(nt, i);
 	}
 
-- 
2.51.0

