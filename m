Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501270;
	b=fq5GCHr4Q4K0n2kVfKtp7cI/lCrIViVBSgJLY4Cjad8O9/cpHaiqoJBgQJFn4uTqWgWG
	 RFLxGCV1I8j2WcWAAmrhJZ5BANQsvZk+rsMKSPaxTNoDTxmzvVhZowOekP0OTX83TiBW3
	 iqeHar6jmGLb0W36KuApF6VlVfyLMLpD5aen3xJI5ozBWjY4mqLee2rNcnPYp/43/bMmH
	 L9Zfcwq951IqAADD0jls5u+QXabM3U+EOvvVRwBhOKCQEF8llKlyrXfceoh1NvClynav4
	 xjaKsQob0bVUkLXgBUQRfmYLdKlq/aJf7Ndkco1o1NgtzbbsFi+MqHbSjDhSDpwZIEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501270;
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
	bh=R2iRP3hUaHUXwpmbqK+JvpTTHXIjx6DcTCN1PbXkNng=;
	b=C4GBfX14QhNufVzfTmmfzTpafi8H9YzphubuxYg3HRbsNQ5XCc2PjZoh9i9WUFjrkIDp
	 8p3T95TbW6R4i1WGnpJZQNidVHqZ56UgJln8cSV3lN85gKhRSF6KIc0joQyxtAYys+VhM
	 vK6PYhmTYCvOvbf7M6JqRfYRXV3tLa4qiRRRVmAesJIUgopCwId/ay/cxpomS/dNtdBzn
	 YicA1P3CUeAu0OOoGde8fIrMl0aC7xf98W4DPW3oEXwhPajSZA+yy4tTYvmMQH3xbjd8k
	 Hl/xdqCUySzYccAZB/Nvkxs5aKPyNfFy5g5zB7KVrYWqqS/CQMuA6MfrW6U+8Bmt+ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H11cWQuJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.59
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51D60A382E;
	Tue, 20 Oct 2026 13:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A51D60A382E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H11cWQuJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFn2fretgq/kXmE0gXNLbfkjax+oEiXOXyso0zE7ElZP5ZuYPSrrpFRMCh5JsU6qdhC8L1p9HWRUi+sw8A/xIfm8Vqm76u3pF6wF4qRj3k8hvmmsKNn64d+jFWBkVvKubOJB9b5Pd6Del1eGftyQOLsHeKiaECsd+3fH1V5ItQgwo4hoRRLbTqBwgF/18/v4O+oGsmlEe0Dy/sudHevpgIWc3rf8NwPzztD5jeXkfV2RL1wHdiIfEhcXmsXKz/GxVuAlIKBzvBcsnK6McTvC3IQWcScNebmmQFuIjK/6lmQJHqH2CIj/7E7F6rdRy/rZ7/7bQOK9CiXFIYGfosSgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2iRP3hUaHUXwpmbqK+JvpTTHXIjx6DcTCN1PbXkNng=;
 b=xrM8cHuXBkBgu4+5pRMWt2cMNOa0w527fDMUcRFVqQncIRvqU3y2G03HeFmPUq8vn5riMN85Szs+lL/wcljBskzGUquEp8oXBKry0qUSPc2tH+HlMA6Oog6EJljr2pZISvHehn/k2yPqNJJzuzxKIPLK7P1ExCzNhcxaiu8BTeR5Ym6EU8kzmm9IL5xmjtwjHEhDMWTA2z3oPVdMEr0gmcDoddbZhwPr0sJArsN2lz1652FKNAKHghY2m6D4GQ0tzY3AU7Uq9loX8BU4ZUgMwyEoAZkwodTnNntfsSqBEwLUUy21ByznrhyZny2uTTMyoubk+u9mMyVJ/Hep11Y1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2iRP3hUaHUXwpmbqK+JvpTTHXIjx6DcTCN1PbXkNng=;
 b=H11cWQuJV38Z2/JjoXtfTjMlia1/l4waRYKNwQMRQobTI/gISO2SuTKCxtCHFAus/64ED7KjfeUYRwzrxbOVzZ8/bCjKBCDqHOQLIhsQqLg0nLvPr62EoLI7WJBT8usTPG4Mjq/mqEsNDKY0Zych4c5WjR9ei7DT+IqId6jvvjce6Z0ui0G5D3jSFDbyNsGpyDAHh4vdByRE+t74N+03/K+JsIs5PPZ634BJaooeGzD5b1Eqjsknmnz766vrtu/+GX3BUGq3VZ/Qlxsl+6nKKlIbI/EdbqGkw0OyawyOd8UA+LiRxWcuvipEMAoUs3hZi0KFr9FKO+ScvHp90u58fw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:01:04 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 13:01:04 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 5/6] gpiolib: cdev: don't leak the IRQ name when the chip is removed
Date: Tue, 20 Oct 2026 16:00:27 +0300
Message-ID: <20261020-gpiolib-chip-removal-v3-5-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com>
References: <20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: bd601bfc-24d2-4b2a-aa55-08df2eaa32cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	vbXl2dk2q36N8S7dbmYOym+9wvegjP0gbw0Joewfk0TyqhfLnRpq9H+8vCjbxxwMrTM/Fh72fN5wOLCKGa3HE/WhWXK/OfhUMu6zXJqrOO9KRBTcvcw2YgA/L/XvEQGOT1bFRswRybtAvzeUAWTkevZ2ND9BQxPn/QzxjWwhgYRflxtmOdeooav1pFgxAAz3KPsNDel9b9efK2sDIKiD6jAWomaJFprwWU5w/9ilSLwfLJexZ4TQHC4zuSlyHZd2Z7fcZFXDPEuLofECtg/Zvqe3OlFXP+VdavLfkGtw+gAYv9FVJIxT4J0Pwil3SaOIDZb4hj3w03Qtl/Mu3vU2oaejDZdJsQ/EGcBxQcRAvYZNvYdaktcOztFnK7EawYupwK7oUEqcmaaRTCgq38rYzB3QqeOPRAjtepK0RpfXnAq0mmJUvt1g+/eceNB3cXWWLVbvVRq0ibuO/WW62NTWci/Vqv7e1WAyAix7dcqXYC+TqyLQKpZluwMXZ2uKoK+m7yJed0OzRuRwVeGMZei8rsTsoepd0ziWFRZzW1FKL9q7QWjBgzYuv42XL4S/TrapEwkiLChjXsQmiez+A6cz0EQN5GXiJfNK9E8U0nRDZMkg/b33T/WY9yS7SysIPr46Tn461PRbjw9eDJd8SjoJGK69EHWKgsV8s0C/xq4WgPU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AT5BYfhGTNU2e5jrWAVrJ1VAWjmijA0qaqJiuWhobPcDnoZGaaZABTHr0gAz?=
 =?us-ascii?Q?yLrqk/EMj2CIqGrSy1RjqwwtwChvG6hAleZWl12+wXnZQ/w8qgkVkEMr8B4e?=
 =?us-ascii?Q?pF5PgPQcpIOjUC4dAafmmgaf/mLuJvhDlxiDX2EAEOuL+6ZVtdhcStk/z0QX?=
 =?us-ascii?Q?asGrfQvsIiEoPQhaCeHiwsSuXwUFx6u811Z2g9Rnj/7MjaOo0A2Kjohi28zs?=
 =?us-ascii?Q?zt6V3jDztOVH0ABusDOpHutvJR744XhNAOxc9BwXDqSYF7MgBUgfXFtJCylE?=
 =?us-ascii?Q?zRpMPQjmLNG0aJe4AGmZtg5bpnMWX6NtCrq71kLJ092aQ+nkpSaOTcZ29Tpe?=
 =?us-ascii?Q?NW6g3sXEBQ7cXXf76Si8N7hFijIKo5bjzcodXCUEVFgaNaVgwdMGq8mF6OSF?=
 =?us-ascii?Q?4ibbI1Y9hL0yebQRRBvIyhvvyQV3uI77+XlN+AtXzU+AoEMyaLONYKYxsogU?=
 =?us-ascii?Q?XTVxe1FJWzbsjeu4f+GSiaY3pSV3VW6v35wMTXj0TZg0RFA+NCeVLwSaX1Wh?=
 =?us-ascii?Q?aXZeJN1KX7OO315gMSIh6PsbxNURA2LtttMb7ipapl6BaxaD+Q+yr4cl3yMv?=
 =?us-ascii?Q?szn7uP7DEmcYSY2TqyVY072ggLPVsiKlho6kFkNSSBRHl8HZR83TF+DqpwuF?=
 =?us-ascii?Q?1VkfmeChvXF4WF1YBsOgbjcGBONuR2qpH3h1/HTHUEBZI6zG57QxIhmSL8hx?=
 =?us-ascii?Q?YZKpVrUbYafWv/U/zG8GuDmvXBVf3h+5AVt5oAel5PiTYibE9Fu58cn17KKB?=
 =?us-ascii?Q?eE8bpVtoduiFd6LSIQ9TTJHAcpX38CfcMkjpwI+9az4YAJh1p99NsKuGvuHL?=
 =?us-ascii?Q?cNJgizjI9S/ZSO//3OOVjODiesL2ihQnF8y7DFLibSRF8jENxOWqO83zaDfn?=
 =?us-ascii?Q?6cfGPx74aeglU4kE6Tb0Q5ZynNdRSU+4rJDcGPcZpywbwtRrDeQ216ckS6td?=
 =?us-ascii?Q?kkfbnW9Ly3Z075EC9+Y7cdV2VkZq+M6Sp4VCWidN0HZvAga3uJMtbHhkXY8T?=
 =?us-ascii?Q?Y2LoCmJ/iYvLxBanuMDkzzQg9f9SsBs1M+TBfc2Kbbm0bry16b6ov865s2YJ?=
 =?us-ascii?Q?iWYwsZK6j2Hw3HOMuojaaxxt+rXUTY4owbRvy+DFSTE/NEVwVkhYvqiq2J4H?=
 =?us-ascii?Q?9rBrDJ1LNSP+/44W7NIj08EvwTiBAX69ZY4xH6ns7h/TUFB66kESIMuKKcmz?=
 =?us-ascii?Q?wAiU2RxhNKm2duGnV2Ganasn/FgbDKKEYuJYcIGHZcx3Af7brvN6pnEHELmm?=
 =?us-ascii?Q?GB4BM2r9MLdwf/ebu6PozEiD6IYT3LG+/wTzR0U5FzcjtBtUILghvaSJ3NRb?=
 =?us-ascii?Q?81Agg+vAFBPvI8Yx/cQe9YdngwBiChncqehwf6Le6oFJf6qMhgRXKZYSj8HM?=
 =?us-ascii?Q?NZqE6GRhKgC5f9WO2xSuExxAZuNH88sa4RKlWwyNd5TzRqNvtW10SPbw5r2I?=
 =?us-ascii?Q?iU59xt1MQRdII5yJNMxwN+YxIEPVLhtj7zFJW007sCyUM67GHi50h6CYMVfJ?=
 =?us-ascii?Q?jToO5s1QM7gBhOqSwvpQ2Yz8PstWbEHFV6pocJ5GmeBDn4Txn9Y2H1Ir1D3M?=
 =?us-ascii?Q?O9bEKYgtUTkPuWhnSGgjod2zMW73PWB6uhP/T/bxcSzYpxjKcgbUeNj4uBDp?=
 =?us-ascii?Q?Yk7qhn+dg/o/uj6ZLZmAcxWdD+NH1tra5bmU1Uz8qAR9LvqOVl15OUQD7JwV?=
 =?us-ascii?Q?+FBpqpFt6HjvTIxb1Qm3dVaDrVyAbhx9OmXz3zawTvlxS24DtvXOti49rVTF?=
 =?us-ascii?Q?phE2N7Rcgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd601bfc-24d2-4b2a-aa55-08df2eaa32cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:01:04.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QY6sSvffR64vTWDdfAvQHPz5uIJJOdAx5tTO2pPQJZ9xJvDTYi6AZzZwMIqo/01QOUhIQLSVfxVTFgluhGsJiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990

The character device requests line IRQs with a copy of the consumer
label as the name, and frees the name that free_irq() returns. When
gpiochip_remove() frees the IRQ first, it drops that name and the copy
leaks:

  unreferenced object (size 8):
    comm "gpio-hold"
    backtrace (crc dc8eac94):
      kstrdup
      kstrdup_and_replace
      edge_detector_setup
      linereq_create
      gpio_ioctl

Keep the name with the line or v1 line event, and free it there,
whoever freed the IRQ.

Reproduced with gpio-sim: remove the chip under an open request with
edge detection and a consumer label. kmemleak reports up to 23 such
objects after 30 cycles; with this change, none after 100.

Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index c5869e3f7767..cf23b5296fd1 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -399,6 +399,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @desc: the GPIO descriptor for this line.
  * @req: the corresponding line request
  * @irq: the interrupt triggered in response to events on this GPIO
+ * @irq_label: the name @irq was requested with
  * @edflags: the edge flags, GPIO_V2_LINE_FLAG_EDGE_RISING and/or
  * GPIO_V2_LINE_FLAG_EDGE_FALLING, indicating the edge detection applied
  * @timestamp_ns: cache for the timestamp storing it between hardirq and
@@ -422,6 +423,7 @@ struct line {
 	 */
 	struct linereq *req;
 	unsigned int irq;
+	char *irq_label;
 	/*
 	 * The flags for the active edge detector configuration.
 	 *
@@ -601,16 +603,18 @@ static inline void free_irq_label(const char *label)
 /*
  * gpiochip_remove() frees the interrupts still requested on the lines of the
  * chip being removed, so once the chip is going away the IRQ may no longer be
- * ours to free.
+ * ours to free. The label is kept by the caller as free_irq() is then not the
+ * one returning it.
  */
-static void free_line_irq(unsigned int irq, void *dev_id)
+static void free_line_irq(unsigned int irq, void *dev_id, char **label)
 {
-	const char *name = NULL;
+	const char *name = *label;
 
 	if (irq && irq_has_action(irq))
-		name = free_irq(irq, dev_id);
+		free_irq(irq, dev_id);
 
 	free_irq_label(name);
+	*label = NULL;
 }
 
 #ifdef CONFIG_HTE
@@ -936,6 +940,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 				return ret;
 			}
 			line->irq = irq;
+			line->irq_label = label;
 		} else {
 			ret = hte_edge_setup(line, GPIO_V2_LINE_FLAG_EDGE_BOTH);
 			if (ret)
@@ -978,7 +983,7 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 
 static void edge_detector_stop(struct line *line)
 {
-	free_line_irq(line->irq, line);
+	free_line_irq(line->irq, line, &line->irq_label);
 	line->irq = 0;
 
 #ifdef CONFIG_HTE
@@ -1078,6 +1083,7 @@ static int edge_detector_setup(struct line *line,
 	}
 
 	line->irq = irq;
+	line->irq_label = label;
 	return 0;
 }
 
@@ -1776,6 +1782,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @desc: the GPIO descriptor held by this event
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
+ * @irq_label: the name @irq was requested with
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1789,6 +1796,7 @@ struct lineevent_state {
 	struct gpio_desc *desc;
 	u32 eflags;
 	int irq;
+	char *irq_label;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1824,7 +1832,7 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
-	free_line_irq(le->irq, le);
+	free_line_irq(le->irq, le, &le->irq_label);
 	le->irq = 0;
 
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
@@ -1908,7 +1916,7 @@ static void lineevent_free(struct lineevent_state *le)
 	if (le->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
-	free_line_irq(le->irq, le);
+	free_line_irq(le->irq, le, &le->irq_label);
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
@@ -2147,6 +2155,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	}
 
 	le->irq = irq;
+	le->irq_label = label;
 
 	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
 		   anon_inode_getfile("gpio-event", &lineevent_fileops, le,
-- 
2.43.0

