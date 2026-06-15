Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D5D3E5572;
	Mon, 15 Jun 2026 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550789; cv=fail; b=LWJE2WE26QP3RlXnG5rXB4Mtj1vqHhtBjEWD5QzidNczgAeGDyRL48+bTJYR5ggELwnyW+WgDJozyevL4kpA8ecdQ572xiAGOKJ/oC9lMh6x+N39donrp8sHt6a3f5gHNIMy9ZP0Y02b4kodOOFI6kv9nqzLeDhxReuwSEch7qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550789; c=relaxed/simple;
	bh=TXD3Ibspdh6lM51YlDzQbSldNoYPTMCrpwgzUVOEvLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cddO9xBr5qLQaWSpFXPAP65pnC/pUS/GLILjj67fUJKFPLz4wl3CQpt324J+mX+srIdSe3P2EsPUdXiHbKERD+T0sbYVvpm8iryYAR+gNf1InmZSiJujgTxxPpjoUfiWXyCrZT/6tlTruSwHaHa/RXEX+j7qDNm3N4DCJbwV8r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SKKsSQ2D; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SKKsSQ2D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef8gUyLyRlNJajDnDKGQCIiS2IHGHM6zqFerhSldF2WJZqX7tGfHC/t7tA5uPKQ84xhUclaM6r+gJzTTaTBwgyQFcnZeUatUTJLMnD7UrWhB7MZAWMqM8JCYWGMqwxL0y0oJmyFczZLEIjnKT+k3pMwGmdS2MM60ECxBuAmQDEvzz9YtOdLHIjXCfA+/eo3zq+hb+MOSlhfW/yXVrXd48WFBzdBJdE4HjBsP4iDbM2Eo16gXzMo2/35YLVCwdKt+bqKLwC1N8AaJSZ8qDw37/x84+/5rZxm3ac+rdwHsLxDgGAENqSe6tZAh97bSnWdn++ipuAQXZ2WEdCgUKPobxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTvKictou46uQ8TFk1TwQKXR9/Ux/iBmpOZPxyxDfqc=;
 b=j0wOSxwuRWv8gWSnkE1QFb4WmWCa0ynyaGparsC4g70bK8vhwDsqiMMTZuPLOTzXkC0naq7je+wL0dB6qyb6ELEnOyMyF7F5qQWFm7pfyB7lDM2tL+xikr8PaeI8DgFIL/dLqJOq+Tft1fMhLbxudTkb9wP1IJg2J6nNqytFVTGLyxz4R5ZtRNUN8Xgou/tyz4YBSm7ucppeUoOJgH0OR99+DwkTqiGvbs+3ntHXdIx13zsqd1eGmZ8PJ8yb+971HDsk7SS2X06Xf/bAAFJ+/aeHjrOuaNRkyw947Kgm5r9SL0qk2Wj1xcmibLlgi66t3P7j9xLduE8L9j4zl+5VvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTvKictou46uQ8TFk1TwQKXR9/Ux/iBmpOZPxyxDfqc=;
 b=SKKsSQ2Dvezglc3FtJwUid0+ny7PsH/cVqi5YQhINZ0JK6uxVgEMlTlVqO3ZNXhPR39cF5K0xyRTv3R+tShh/QVzNTn75Pscq0YYXes6GFugdSMyiEYEOZ/W5u1DgEM2pt3/Jqn8KPgRglxNbf7L60uTVK3VIokpQJ9l4MlrHY56OuKGiExH+dBrhLibFgABqzLzxpn04fM4Zdx3R6hx3jReC3veg4gEfZhVRY8R4Z3JjFLi3d9Q1JBbQQo40wSsP0Ycvu8LgUXSXeUfzXSHVaYbycQRujOI9km1d1yYWegUNa7sbLgJfuNwT2vMNSd7E7qJ9qkOn/vKbLrQEm+CuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 19:12:58 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 19:12:58 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com,
	stable@vger.kernel.org
Subject: [PATCH v3 3/6] vfio/pci: Fix racy bitfields and tighten struct layout
Date: Mon, 15 Jun 2026 13:12:31 -0600
Message-ID: <20260615191241.688297-4-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615191241.688297-1-alex.williamson@nvidia.com>
References: <20260615191241.688297-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::14) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 034c7f73-b03e-4fc2-5121-08decb121caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	J8J/Dx625RX3G0eBTcHs77Wd7rpwXmkqECa8G9LS58+l0VQgWyNGhz82EENgYIq0s/k8wUPHl9bgnub+JGNgWdPuBMVr3y/xuD7xtDo8IwRukn2HCHSJ5B3IoV08Gcwp6l7kTydpnrLxS/y5HUS2fu7ahpI66CqT1e5O3RPFnDF16jtJVMJpugpZi8NSBZiiysC5mgK/wE9LpghAVC4bTcnEVZxNFq15pb05g28qAHjini5cx+aYbG2/kQfsKCkEreMI4+Faiqeq4MnIbHo2SO0ogaVRR2fuDTrW7iAKhobAkMafUcTyLZq739U1XLuS42f/Iw3mopaDe4C4dHERo3NPIMAF/+bIDJekaD3TxTzA1AMuU+Uqv/maYLJJaQ7IVopbizYDb6eKcx3OEfE5P4OjFCVrj79sxn5uDvWFnxoBsWFpRiL76BRd8KNUfB1YEBfWcuaxvQfoQs/2evcxO3h9/8Vu9Awse+k55ldOETRmG2fRgYHujaNJ546prKMHfrZXBtNDN25k0mZzv2kkSSXaaLxiVlVmeavVzBq3d/qh2gun8NO6BpuITn4x0TQtNu/A/+C8vePZ48z/UGSBoxZdcbWdP5IcfuI8Qxq8yx1nA/Qisj/LYM3/tAvHU5CZpq3lXvEOvNDy3laiIfOWqJ+xokF/D33iKMavb5lpcuQ44VNaP8JazAaepAziM04V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sUInF3DDtroXUtcTw1nMlvn30QWkyDk9i0mg27ORgd7r2/9hSYZU90trZVfr?=
 =?us-ascii?Q?Q2ipRvCmsxMlIeEFgE9wCf+W8/Te2fZObBoQUjHzmVNt7yMBcI3IAheWXPzP?=
 =?us-ascii?Q?UovBAEoR2NpgiLpAiwjOLpIxmuyRokPbiDqIXngPladAZ/2GUAlo1ykuwYhH?=
 =?us-ascii?Q?0P/Caf1G4FFkFhEQiGqTXVbtXNrnhd1Y6JXLIpkaq+iRu9aCAUbvAQGTeGZM?=
 =?us-ascii?Q?SaXj4sKomLOlXiBQxisbu64b8SrZnnjPykWyBPykGV2gPBMQPe9p0VBxZf+Y?=
 =?us-ascii?Q?jpS8CSqbC+vZsFRwdErgL0B4rkqo6zw+BmWoh6i3myTA/jxU43BycdL2sGBv?=
 =?us-ascii?Q?BKTo8IUIw/rYMfaN3FhPIUbFBmP/wpjEdICnfOshoo8lR1RkzMDPcQAKV/xl?=
 =?us-ascii?Q?JRG0gjoxDbABe8Rs+uZCTfofo6XXlR4/4wB8dhtr3wb9FQqcB1EmX3ep1A0Z?=
 =?us-ascii?Q?0Gx4wPBhDS0KM24aGSI7TszLNj1q4L5QZY3UVJP8ldj+XOtCdipLoFOsR+v/?=
 =?us-ascii?Q?oucqxaj5nv92w6ihhglDINhkvh2aknYaNBcaTxWGDSLKRnDaKHAD5+ryoyBU?=
 =?us-ascii?Q?fwxqLfxhc5KyE2dGM1/oXC0/SNexMqpHgLDoltVyG/MlxXV1drgSDVzjUu5Z?=
 =?us-ascii?Q?90I1CGH8Q/0v6rRIGFO28uDIRTyap0kxVkfy7+VpdGUVdSJ5Mh2yatnu8Scm?=
 =?us-ascii?Q?JImhn47YKHW9EM8LvsMOOnFs0kM52IBSUMDkc8Fc0GjzG7CIkSGHhzg0W+qv?=
 =?us-ascii?Q?xnZkLqkBY083/PhPGVjVrB6ItG0Y1Bws/uMUAzETZen4qB53uGEPLY8pjZ4/?=
 =?us-ascii?Q?EtTZfEWnetOm1Pjvseguje0DRqUJpFBNVx3yxuuz4iR0VSjAyMoWq2aix2sV?=
 =?us-ascii?Q?3iAKVXpRID3ug+QU2myeaF9V8XSl3eQsR5LG7VEb14SUdfSX4bvWL+BtL1ye?=
 =?us-ascii?Q?1mmGfLFhX4vQWKiWO1A0syUZdT7ghWxrXB4tjLisgX4BYq9dduhOp7RGbVh1?=
 =?us-ascii?Q?0zCgvMtE9Fip+GTGUpYL6fUod0qf9G5Zg36gsuQsgUwNFyjG5kaWefEJ1oXt?=
 =?us-ascii?Q?mhdH0ElF4glHtvhF9IxvtHjvtWpeJ/rFhA4dW3wOSzmE0nOAvAPKq+21oOpG?=
 =?us-ascii?Q?VfNo9/41dMr8WwKi9DYfCimYOuuGsCVEnR8/MQ8Ll6Y2GLD88VqJYLulnLwe?=
 =?us-ascii?Q?HPuia+cLB1VrJBdwXZclQgrbihxutnZZKxtDyVBVIbXP5FU4mOTVa5UGu4wR?=
 =?us-ascii?Q?nCYU1lOWeV2nMwkX+n6i0pvODpsw9PtEmtLQ3yTck9i/KfFWQkSG69T5/pr8?=
 =?us-ascii?Q?FoCKMJXK3vpkYPacMnqeGibqowk9r4+AyCANCW7gvPcDo533xkhdDRhLOeeL?=
 =?us-ascii?Q?A0JkBoAVwZWbemZdQHSqfPVk5Qs/Ayvn4m9+fn3+GuKv4i+BoupDUrOzB9e+?=
 =?us-ascii?Q?YS9KrgXk9NS8xTb9TFaSRyNKGcrYcWqMrXD7TMqxPar85fJHzBQrCSbQnVrx?=
 =?us-ascii?Q?Blxxa4V7eH/WV5WNGpbt0lIaNcdayyFMYb2B5J2ZGWifjJq+jYPdvQ9YmfGv?=
 =?us-ascii?Q?x3xMJd4peB8vl9kMX1wshKN9ArpLrl3KugRWMY5+RxHmJQcUYOZCLTieLW2B?=
 =?us-ascii?Q?qgDnrhTGOvazDqL+cQP230vqDb7VKmKq8OH2Sa7NeHeQLKLhLG9cmDSzieXK?=
 =?us-ascii?Q?o3tU7wkZMn4gwgX9YmlTFMnzupJm/80E8CO8rOkapeP6EHjpHyzvcBuNU3jN?=
 =?us-ascii?Q?rVXH77X7Tg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034c7f73-b03e-4fc2-5121-08decb121caf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 19:12:58.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GecCa888a3ZMq5zSGm+ftrza5nDH5ulJ8AtGMOPQH1Cimycr7n0kJrKZVmOTuYlDGleSFZR9cCEcZYS4db2yBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

Bitfield operations are not atomic, they use a read-modify-write
pattern, therefore we should be careful not to pack bitfields that
can be concurrently updated into the same storage unit.

This split takes a binary approach: flags that are only modified
pre/post open/close remain bitfields, flags modified from user
action, including actions that reach across to another device (ex.
reset) use dedicated storage units.

Note that the virq_disabled and bardirty flags are relocated to fill
an existing hole in the structure.

Bitfield justifications:

  has_dyn_msix: written only in vfio_pci_core_enable()
  pci_2_3: written only in vfio_pci_core_enable()
  reset_works: written only in vfio_pci_core_enable()
  extended_caps: written only in vfio_cap_len() under vfio_config_init()
  has_vga: written only in vfio_pci_core_enable()
  nointx: written only in vfio_pci_core_enable()
  needs_pm_restore: written only in vfio_pci_probe_power_state()
  disable_idle_d3: written only at .init in vfio_pci_core_init_dev()

Dedicated storage units:

  virq_disabled: written by guest INTx command writes in
                 vfio_basic_config_write() while the device is open
  bardirty: written by guest BAR writes in vfio_basic_config_write()
            while the device is open
  pm_intx_masked: written in the runtime-PM suspend path.
  pm_runtime_engaged: written by low-power feature entry/exit paths
  needs_reset: set in vfio_pci_core_disable() and cleared for devices in
               the set by vfio_pci_dev_set_try_reset()
  sriov_active: written by vfio_pci_core_sriov_configure() via sysfs
                sriov_numvfs while bound.

Fixes: 9cd0f6d5cbb6 ("vfio/pci: Use bitfield for struct vfio_pci_core_device flags")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 include/linux/vfio_pci_core.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 27aab3fdbb91..985b8af5a04b 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -101,6 +101,9 @@ struct vfio_pci_core_device {
 	const struct vfio_pci_device_ops *pci_ops;
 	void __iomem		*barmap[PCI_STD_NUM_BARS];
 	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
+	/* Flags modified at runtime - dedicated storage unit */
+	bool			virq_disabled;
+	bool			bardirty;
 	u8			*pci_config_map;
 	u8			*vconfig;
 	struct perm_bits	*msi_perm;
@@ -115,19 +118,19 @@ struct vfio_pci_core_device {
 	u16			msix_size;
 	u32			msix_offset;
 	u32			rbar[7];
+	/* Flags only modified on setup/release - bitfield ok */
 	bool			has_dyn_msix:1;
 	bool			pci_2_3:1;
-	bool			virq_disabled:1;
 	bool			reset_works:1;
 	bool			extended_caps:1;
-	bool			bardirty:1;
 	bool			has_vga:1;
-	bool			needs_reset:1;
 	bool			nointx:1;
 	bool			needs_pm_restore:1;
-	bool			pm_intx_masked:1;
-	bool			pm_runtime_engaged:1;
 	bool			disable_idle_d3:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	bool			needs_reset;
+	bool			pm_intx_masked;
+	bool			pm_runtime_engaged;
 	bool			sriov_active;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
-- 
2.53.0

