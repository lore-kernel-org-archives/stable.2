Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745159;
	b=z1uL4es/NirYgpcYQrAFvUmIDNLxOeAVn9MCsnc02bceHVRUIyCIhmuJc3qHkbnrcPfE
	 mUo8o4vCjQIHQ3NY9nfqGQ3cY6eCJbqFEKNwuoc4Rv5/j+UnOnz5LHv0ZCw60ErjXDXQk
	 YCjYSBMlzUiKO8FW20NLRTKlkIyj7Gu+SgoMI1Ucu6GwTSJx72AS8anQOdfX+nf5Bl4Nz
	 ceP9wgj2KBgFbMrkLlR5OeXs/UK4rz7IWn+CUWh/MdDFk0mkzfAQekkHkkugEewpsUQxm
	 4tFiUQ8wt7PfppzCdVvNJ3WoG6u1vLa7UD4jCK5S67ZRrFVZbXbCPra8J1cVLoFudhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745159;
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
	bh=T4bQCc2zPZXKERyH0opYancKePx0px1lX2mNtdF62P4=;
	b=KUYMzJcRMCUFsjLIhjzJp5jcUl47pZvCRkBgF3YVTy0eRTNg2bvm3fLW2ayEhBxhKYj2
	 S5gmf/jyWvpM7zH9LtPHZTwQX9rUXzy09ENZqBz/CreTfnlD2NmMucw5Kkp1cEKeMGwo3
	 lkSHl68ypqqPqRMgPOlCdQ92MWZ86Mcvjrj4WtnI0tgj3BlI3pv9nPFU82S9N+mQRifk5
	 MesHZUQO/Sqx6ZEgmI1Px8kYjHtfa/4Iu6bP2FZgm2uFG66chR5HYZzQWgsPQ3mElI+fD
	 a/6SQWVg+AMdsycu5HVQepqXuNYLcLNYKWnVL0KwexyO+G0d1yT6AQyDcW8KemRcibQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=VI604ADr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.102
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020102.outbound.protection.outlook.com [52.101.228.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0113606A6A5;
	Fri, 27 Nov 2026 02:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0113606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=VI604ADr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVVeSr7gjNgCIAxqMF760TLbX6e3wrUKD7efUCz1UZGGLwQ86X0Zjnn+Ftz5wHZW1PLkz5JUhiRexTByat4GE8+qWFM1zZPu1W+C88OEntWE1mZnP2ERWvPOznwAMYf6Soz1xj7kHQI7H5o5N3XINUN3Eeu3aSzisbtGDLyq9qfhrIlSj0najfmOrqJXIEzgaEWiqj3Ocs4OLiJQJeTIEyjFWRDfjtNmL5uT2CHldP9sBh7I4xQ3m07FeTC1Qygs3F7nlFrlQ7ofbQgHP5FklloE5ZRyKWK7oiqrusGoK7szSwb+YjysuRaphgh68s0/+edtsWyfyzL7KBMh9zpunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4bQCc2zPZXKERyH0opYancKePx0px1lX2mNtdF62P4=;
 b=OmjnPrEB0oHIwk8Muglq+ii9g4CxNcn4sIRBBkYM+/PnxG+6SU9NMGeCxd1pznOCpgKA9RGAbX5/xpuvg1vozSpOlxBz3NtJ6IjUtxxYhD49mZy5ShJyOLw/+i2D3JZkt7koTqWWIb8PX9XihiI6NBHlwHBU89OsNv8GUqgZ/5yJfTXg0RVe3Pko4x2WTBboAvLvsma5Z4Ikovpni+8gU5Up8t9CSlBY+0+k9K5IpiZ3upZGX6jHNaAoJjXNNxNW4MsZHFpULMyztNVghFsJUVPfGD/NK0CeCgP8uR7mGpenSf0lqPxdm8AlORj93s/5tRhfId0j3Yp5xac01BVq3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4bQCc2zPZXKERyH0opYancKePx0px1lX2mNtdF62P4=;
 b=VI604ADrBqanRsr6slKBHzg5JSCYvgbpKVNS4fL1Xf0Yx6mP0nEqSUJvvCR/sxX/QkLCpffK1R6rEICmxsY33yBQl1BX6zXTRrGZUdA0mjl5yhErnbwswUpTtcHQYShcIDEIdrsY4MttYgSCp6l/dmfWX/9OrJDN/gqzIXs62Vw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6901.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:416::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:05:56 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:05:56 +0000
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
Subject: [PATCH v4 09/15] NTB: ntb_transport: Stop RX tasklet scheduling before freeing a queue
Date: Fri, 27 Nov 2026 11:05:27 +0900
Message-ID: <20261127020533.2481725-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0222.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: bab14a2b-0fa1-43b0-f513-08df4c2af8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	h+gLZ5i2rrydBSfKM2Hm4LmG0eCTOahvIyu3lk6OQNRmsm/YIyUFosJJcy+rGPlteBXBQ2D2kufg4sX6hNFnDq+8ClJIkjwNdwt33TcV5zzw9P5xyQfxH0Edpo70tpa+p0CSz9ThomjHl4CbPkPFe6pRxDMSLSSRXZ2Idzp/tRjD5MaiM4jTFESI6aPC9j/DgsinWh/f6sItya/u1cjsvNFpuf+pB6NRsVCbK/LBhc45CRs4kmbzVVNuDEsZqWf52y594gB1LPUhQdg95QqHK9mKesiR+kJLFgjcCoyS2VUJvvVtImLdtVwIPRtb/Z+6lHvxt/tW+ED+vxGySDCODTOIT4KxpqSh8avI3k5RP9WWEBe3GVU4s7EGGs85Gliq+ysyAiZSkjBMIMzIceMxYIPaG9fBlNOayrANFDIYgRKdo2GmxTtc4FLJ5lNJz2IRW9EEMANV2qEQwZ+2h6ytu/OZ0YsQT9iWOQZmLXKqk9KlZ8FoY/lrWWBJH7klKFZlxSqPaMEdm6BAPUejsVsZpAtbE5q+Bi0TD5mFRWM9Nsl6iE4Kz5KvUNjIhNYs9MQqfnayXXsuD8MaxatbcfkG4mf1jYnzpdUCLe3KFQzF4QPdrQfypCcedjfZRuyGKiy/TyGuvKOvF9gwLgI+lbPhfQDkhqbdaJUxw/5WlZ43Nwk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+tLllWGroAbaxU9X4PuaeMSc3NElyoFZkmlpce0SHT786KuKqOmV5Nw0FkVQ?=
 =?us-ascii?Q?NS6Sbm8AvXTS2SAnLOxalefy5oJmXQHq2p+dBRN0KnFSLuhMsNJfsKEouown?=
 =?us-ascii?Q?14jKSFtDp+8XPKxGq4aF7PvmNWSRXytEZfNM5+MBXYfJaXxaDYmfMIutruFd?=
 =?us-ascii?Q?MUL84tz4z9wP9rXwCiaTTtV3heodHzsA8eZqKWMlV0g0/fvnlQpCaUampOBi?=
 =?us-ascii?Q?tRwHZJKFE+OZ/rBrGQmHINDKLOsCu+YpAj4IDFNYNpDQIZVkmKTV32s4uYrO?=
 =?us-ascii?Q?k3veC3aVpEkZUEeXtXEkrBGMZr/vZjPflylCOnQxk//v6flAbfab8nMhuPg9?=
 =?us-ascii?Q?xwMDU1cBgfJGXcoWLZ01kNNEZ8MAjaEBHGbfORN3CfSQSs7nzrsifEZ/p5Me?=
 =?us-ascii?Q?41iwNMyvCqL3a0rQLmwcqXQBO7VpbY2JCsC0BkTrbsXT+JXmoc+7p/VDRqF2?=
 =?us-ascii?Q?HijEIQ7TEdN/oNRiToUObjD8bSrgNATbZH9K3I3oqMsOMmPQ9nvbWLEUh0fF?=
 =?us-ascii?Q?j5HPG7di+7jDmL+JAbo7X2RZ+54Sc6dCQVmv+Icu75gnh3uX1ve6l1tywYlh?=
 =?us-ascii?Q?vldbFriQFCm6T+MuUMaUqrbzUbbNRspWWOfPcLPXyZpu9tETZw0VbsbL9BFK?=
 =?us-ascii?Q?4dYWMrnVyYDE59YC4eLuRJvqGMe7KywlMwZkAQfJoAVRIcJkKaNgmy9VTznn?=
 =?us-ascii?Q?NMtizwuj5cL/6bhFy9+EqMTROcQuPYdK+vD7xQpwxwBRsrKEquKiOdlKKNjF?=
 =?us-ascii?Q?tHbEZiec2/zZYOlY07e7nHOK4UejnLfMEf9IvONOBWJtuWO0jgSlqiovxA+P?=
 =?us-ascii?Q?nNnKR6ISvQtdBf6xQGP18kI0t3izEsOVlI87P4y3TAy+r91mtlNKZIYJER3T?=
 =?us-ascii?Q?zMslyNH11dEs4wB5LKM94VVPGN2885jQVhZcyBj01G+SV9+YiKxYDhjjsiXo?=
 =?us-ascii?Q?MrBme7BLPRyR0tzvGIqu4SxpygA9azIPQ6Nqx+WSIMNVhiIR6zMSR8heqOnh?=
 =?us-ascii?Q?QeT4xOjePHpHSpJtQbfKCfTbsEFcH3eK076OQaxfEvzmlJRYlao7ChPIpRCp?=
 =?us-ascii?Q?KNinoj9GHZwPnVuI2kKFmnMHDaPHQNotVFbILy2iPAVAoNgiqZukSF4I7Gx4?=
 =?us-ascii?Q?R95uwMjmsFvaV2bDW15Qt9QEgNbDg4QRKD4jcXW8I0Fuwcgx3E5DwvcflqaG?=
 =?us-ascii?Q?FWlTlkyJFra6EVKMyK5GlFr8O+pN8aTUabemNGXpdnTmt5vsKAv8/e2Qytnp?=
 =?us-ascii?Q?NLDKHEVgkAxymsaWg3Iyo0KzTonKj/Q/KUGOyIhStq+X2aiT1uF5k+fPAbe+?=
 =?us-ascii?Q?PAzCVU9HGDPuNlswhCuqOfpES2xm9ayEzznhDgNNC/I9ntCIxCfxxa/2HWiX?=
 =?us-ascii?Q?Q2yArZsWdEteICtYv73pzCytz/BAoBJTqrqeylOepLYDtcp5K8TpyvccZ29T?=
 =?us-ascii?Q?ONuOl1peIWGMgoHlKG7jo7aGFK+gRF0D0GN4RLXDYXmXfjwaHd1VnSjWnsyM?=
 =?us-ascii?Q?6FHmyTDG+qZVWODVcIKlORmAjbGePkQ3PsDzKm/Fff8cvM/Mya8SKKG8VqKX?=
 =?us-ascii?Q?+Mvt84b8VSpWQxI/nKPFEjj8m4UKUlx+5zw0dEK6tH5LvdcNGXwTNSVUZrYf?=
 =?us-ascii?Q?673hnATQE1084GfpY/y9C46QykNFLcu/sENlDoB+lTFOCNa7xjUZCYyHG2Ej?=
 =?us-ascii?Q?D4zbvt+hQ9An1VHO99sTKLcoOYek3UyN16+uNPrKJINlo6YKnd1w9POS7Oh2?=
 =?us-ascii?Q?AmtnYiWaEMoQe8y73KxktKjvdouFKSA81kjPGFjW+fgHAFxZcKy4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bab14a2b-0fa1-43b0-f513-08df4c2af8df
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:55.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhOV53oKLXoNjjzg61VkT0ra2ZjlZq0oAyMoot4g/R2J8sT3M96auQjtIfaM63Wo0ygms6PIOaeRgqXRVuRWog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6901

A caller can read qp->active before teardown clears it, then schedule
the RX tasklet after tasklet_kill() returns. The MSI handler does not
check active at all. Teardown also releases DMA channels before
draining the tasklet.

Protect active updates and the check-and-schedule sequence with
rx_sched_lock, including the MSI path. Clear active under the lock,
then drain the tasklet before releasing DMA channels or queue entries.
QP link work is already disabled, so it cannot reactivate RX. Use a
separate lock to avoid contention with RX list operations.

Fixes: e902133162af ("ntb: stop tasklet from spinning forever during shutdown.")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - None.

 drivers/ntb/ntb_transport.c | 50 +++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 55f596d59453..f4161ff95862 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -180,6 +180,8 @@ struct ntb_transport_qp {
 	unsigned int rx_max_frame;
 	unsigned int rx_alloc_entry;
 	dma_cookie_t last_cookie;
+	/* Protect active and RX tasklet scheduling. */
+	spinlock_t rx_sched_lock;
 	struct tasklet_struct rxc_db_work;
 
 	void (*event_handler)(void *data, int status);
@@ -650,11 +652,26 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	return 0;
 }
 
+static void ntb_transport_set_qp_active(struct ntb_transport_qp *qp, bool active)
+{
+	guard(spinlock_irqsave)(&qp->rx_sched_lock);
+
+	qp->active = active;
+}
+
+static void ntb_transport_schedule_rxc(struct ntb_transport_qp *qp)
+{
+	guard(spinlock_irqsave)(&qp->rx_sched_lock);
+
+	if (qp->active)
+		tasklet_schedule(&qp->rxc_db_work);
+}
+
 static irqreturn_t ntb_transport_isr(int irq, void *dev)
 {
 	struct ntb_transport_qp *qp = dev;
 
-	tasklet_schedule(&qp->rxc_db_work);
+	ntb_transport_schedule_rxc(qp);
 
 	return IRQ_HANDLED;
 }
@@ -896,7 +913,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 {
 	qp->link_is_up = false;
-	qp->active = false;
+	ntb_transport_set_qp_active(qp, false);
 
 	qp->tx_index = 0;
 	qp->rx_index = 0;
@@ -1157,13 +1174,12 @@ static void ntb_qp_link_work(struct work_struct *work)
 	if (val & BIT(qp->qp_num)) {
 		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
 		qp->link_is_up = true;
-		qp->active = true;
+		ntb_transport_set_qp_active(qp, true);
 
 		if (qp->event_handler)
 			qp->event_handler(qp->cb_data, qp->link_is_up);
 
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 	} else {
 		ntb_transport_schedule_qp_link(qp,
 					       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
@@ -1191,6 +1207,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->ndev = nt->ndev;
 	atomic_set(&qp->client_ready, false);
 	qp->event_handler = NULL;
+	spin_lock_init(&qp->rx_sched_lock);
 	ntb_qp_link_context_reset(qp);
 
 	if (mw_num < qp_count % mw_count)
@@ -1728,8 +1745,7 @@ static void ntb_transport_rxc_db(unsigned long data)
 
 	if (i == qp->rx_max_entry) {
 		/* there is more work to do */
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 	} else if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
 		/* the doorbell bit is set: clear it */
 		ntb_db_clear(qp->ndev, BIT_ULL(qp->qp_num));
@@ -1740,8 +1756,7 @@ static void ntb_transport_rxc_db(unsigned long data)
 		 * ntb_process_rxc and clearing the doorbell bit:
 		 * there might be some more work to do.
 		 */
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 	}
 }
 
@@ -2210,7 +2225,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	disable_work_sync(&qp->link_cleanup);
 	disable_delayed_work_sync(&qp->link_work);
 	qp->link_is_up = false;
-	qp->active = false;
+	ntb_transport_set_qp_active(qp, false);
+
+	qp_bit = BIT_ULL(qp->qp_num);
+	ntb_db_set_mask(qp->ndev, qp_bit);
+	tasklet_kill(&qp->rxc_db_work);
 
 	if (qp->tx_offload_thread) {
 		kthread_stop(qp->tx_offload_thread);
@@ -2252,11 +2271,6 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 		dma_release_channel(chan);
 	}
 
-	qp_bit = BIT_ULL(qp->qp_num);
-
-	ntb_db_set_mask(qp->ndev, qp_bit);
-	tasklet_kill(&qp->rxc_db_work);
-
 	qp->cb_data = NULL;
 	qp->rx_handler = NULL;
 	qp->tx_handler = NULL;
@@ -2351,8 +2365,7 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 
 	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
 
-	if (qp->active)
-		tasklet_schedule(&qp->rxc_db_work);
+	ntb_transport_schedule_rxc(qp);
 
 	return 0;
 }
@@ -2549,8 +2562,7 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
 		qp_num = __ffs(db_bits);
 		qp = &nt->qp_vec[qp_num];
 
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 
 		db_bits &= ~BIT_ULL(qp_num);
 	}
-- 
2.54.0

