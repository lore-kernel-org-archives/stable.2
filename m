Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83E1380FD5;
	Thu, 11 Jun 2026 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213758; cv=fail; b=Ns3btVetSOD4RWHon6ZDZ47CaOLlzzVlyzmcLIU+D5++0+LZ9T8QvYlSsWItbmXFZVg/WPQ19Ua6jW4Ncj5w3RXAH/SRvKApAjPtqTRWEo9arlNiAgRzApziW8ZaCB3POUrP19RuKVRHWAliyLmAMnYufPZ4sQYg2L3IxCJM3h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213758; c=relaxed/simple;
	bh=496Yw+dQkmZT51Mq+a1ey5ZYf8OS/8MGCHXDYVlactI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tCOiI7jMVcDEKIGtkmtaxCeMgNdVUio8KCIyk54VWW5fB5cCuH/VDAnzctz/d0WLojQu6aNiLS+sgAq0oEyRPR0O/qEGJtMLiZXf2Ve1ZLNWPj8+yK39vGazvCMWZvZCiV2yHQDn75qCEXjyS3fbq9PjhZTzr2W2/4FVH7PcOcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qsH/uIGw; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qsH/uIGw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKDwxs5DDaS28rUsiHNASlnLzhWDX1+r8gXriwqOaz79fLlTlHN0P7GDk2rwjrK1eRNGnCe99MrlWtiNJQ+jYKEs7emg/5i5GYsI4Wax2K0eFE8x/7ETmtybjd7g1gSz8q/zh3fkwrdYnS279HtX8u7eAJugCGRJ0boU6SZRF4YYbuLuSLGBygrhV6OYRGx0hhzNhxUBi/Yn9OXnuDqUxTutZKeWBFaDvM4hTPqLfr5/LqNTTRMZMSsyRzMFPDmQbXJPmq9VqBIx4BGGtT2M3GucTyybBo46dx3YlSKpixrMkZiuIKXtmhodrm69VMVL5yWGjAeauiMLJSR42JPX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rMdqEAEWKHZEgTOxGGZyieeUCH5CPKSDzYwHpRwDTU=;
 b=RIzO75B5t3uYFzusXbnyr/J0DBB0w4wXYulZ4N2OoUfVq5NG5lzxo+2Z+B/EZKq/K013+8twGaL+LImhZmBz5O3lpVFfbsZx6aigB2ICDpfjSGVYe+VhQBb+xha7RHf7wORfk2bjcd8WBLh2zFcNZ2b7viV2FU/9uk3FclThadXYRFdGJ4bghlidZvQgFwfezxVOA5KvmwbRih1I7XvFsm6XjQkhMOKUv/7YAZmiZXyWnpfQImT95ABF26FgAPIWF9QnqAkH0JTtpye+jFBZrlOdzQOK+r1Z1bh3XAonBANBn6z1A/EuvjvKsVQcnjH82YmuSRU2IKo2aASbO5WevA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rMdqEAEWKHZEgTOxGGZyieeUCH5CPKSDzYwHpRwDTU=;
 b=qsH/uIGwYDg9smFSZzHVn234g+jAEXy5x4oE5bycFXtxODYQIj9Um7URb4kfXobmUfwj/kAXihKE4Tg9NsTpieRqKSHVRQLDRnbW9xYInJXaa0lnKCIEf1yDnjVXBgtfnybuld3jpHPbEo5Y17VjkyJPs7Y3bRDE+pAY4AIVnOh+/iJtxsj2Lt2GjTVf1d3p7iu8VOKgwC1ZOmsAG1l/gBXtDm9u/JBVz8kATHMuKw+dyyHGuWQCaoUrHos9adVMWN33cOQ2ohl4MPk/tvrLaQk+0lOtn1h+6OyzJnt1jF+L+RPFkAi9zPjALVy0fGU6Cwp4u47ojWNxdBQ5yOXx1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 21:35:44 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 21:35:44 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/5] vfio/pci: Release the VGA arbiter client on register_device() failure
Date: Thu, 11 Jun 2026 15:35:35 -0600
Message-ID: <20260611213539.4100590-3-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611213539.4100590-1-alex.williamson@nvidia.com>
References: <20260611213539.4100590-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:44c::15) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e63905-7346-4fdd-7cab-08dec80164ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JXeeuJwsVr+erx1Vn3VDzeskPbrGy+B8k+qQP26laIbg+98qjj75FCY/Eh1FwiJ+t8CtCTtYA5flKdQCgzP+VOkIuLduRm6uxa1ifSGl7kw7W6XnQQNaYl++cRUlaQJ/cpxYtTnwiMFpLynSvBVmFE9iFZGs78N346Urmoogy1/jAtBAThVpYpdx2iuUuwKZMKG14ni9RjAS48uiOcaVHg7v1epS/sQ6aeGJngZ3UEV4m9jtEifCYxqZOutxkQdxx+rzHvZ+hi3WpJq3EPjMRmhCfo5ayOWIvmU8qaFF30YeUwbSyUnD+HyAsbBwRO3F3KJelEgg8SNKr5Sl+/2yZ9KeoIHU8sch8una6omoco39DLOMnvuICCbz8J6lJKcIEY2lqxwagyHZycywkPzS13GVEbQCqI1McusIxe2UEX5zPVH0H8BDRg9xZkBXNrFqv6tYk0PU9o0rVluPlsjZRVhb12YHSMb9nNWJJfnXxmYJL0rcHgOiHrIzUa2WFHFi8GXwG2LR22p3Qtmb635Z3FsTTSicusOHiDWA0d00ypTbWn9mqlw1ghaPJ79QQ9woNvw3rJho4MMdGNEEJ2DMH6HwJo0r9PzTWVH4/Rm3sPrbVtbpmShdAODN3WlJ2Tm8fOwdRkoYEii7hYrjMKXMG8cZ1lLP9imIo5iI6qjB1GbDhG6uD8sfKPhGB9lEaQX9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QGoXEDTuru/cDBXG6/IAZTuTm7Gkhvre6rxbXV++6EMXJdJ8fjyaTae2dnxF?=
 =?us-ascii?Q?C8o1FZ98AH82MAQOynCkTzcTIGp8+X9MubGi6/IRZVLm5d/uuR+mxN2pQNTx?=
 =?us-ascii?Q?Vz1KQ2Q9xowo263otapfPoOn3qF17vFjLEoQGFevXrKI9eCbtrlDsXgKHZa4?=
 =?us-ascii?Q?DngFjKSAY2cq+Y9mqHCYbidlEGFTrD7vi6JTCUOT1ifk1NqLO6yeJcnMKKEf?=
 =?us-ascii?Q?DVyQTIXAL9mJfXpPQQakEA5T3OPgnEC81HNLeZV6451m772XzvCZg6Xx9CAR?=
 =?us-ascii?Q?v58n8MJf3BDaPRgPtMFideyC7qOuX0qD1q8YiOzlcy3pHNYgBb85AZup4Tyd?=
 =?us-ascii?Q?1uOEQK/kw2S8c2Gec09yGZLLDSzK+rwoF11OkrQcxbulo5Kb86U13Rhb0ukk?=
 =?us-ascii?Q?I/WzqA9qe6TWZOgZ0q8RA4cjR/OrdWQkZGQJC7LsBRTzd0Em9uicXt2X1TME?=
 =?us-ascii?Q?N1VLGjfpmufWscyNvsp/juPPKgHgK8BFBejq06U6QWVuIDsrdPERfHxUkkMH?=
 =?us-ascii?Q?OkHYPUa0nUBFjOcIfnxtE8OIAKAmhyysCejXxV7RYqoWxvcaqxiROlGdpTks?=
 =?us-ascii?Q?HgpZvYmYQuyvA7lGOu/cxT9cuXu/fGmbleDah2EJ6pUX/giSq791Ob551gWx?=
 =?us-ascii?Q?POF02kTpVB/0lcaH60oWdwvPrGy3Afl5nHdtpgXfdBDOITMqi+aavmyaFXQ3?=
 =?us-ascii?Q?TfCSRUq7YpL1UVwYi2f6wYWsbsFBNO1Ja1W/FV/bhsTpj3ezyWeVpvtpiBFu?=
 =?us-ascii?Q?Vu1J+76dycPncB+wsBBwBS/bGyVpGO3Fla1oTbEbI+Fckq4Y/K60oDvtuIcj?=
 =?us-ascii?Q?xRimNhBiEeWYNzq9KwpCbrOLvj2PgmTH+gY43KFEF8PHq1Fr3RW9Loj0aGlV?=
 =?us-ascii?Q?Vm1Xhoi0wBOxliAaY3QsCI98eX5FZfe2xMXQf3F5MzK1I5/G8BRKRD4TL52k?=
 =?us-ascii?Q?30ZCxAixe03fEu5BpXZBKREmQBnHAS2M3JUZbTPe1XDRuOJ5sUWRbkQmJeBV?=
 =?us-ascii?Q?9xZCPMyu7TlTLJf8oDUL+BImQZE3zwT5uaZhawgX6QmBmWHEUqp1Dqlbjfzp?=
 =?us-ascii?Q?3+3Uk8kY7cLE9EeB0cK2fMa+SyJzRGyYC1nSnQpIQiB6Ax8vPmGTT5BNisen?=
 =?us-ascii?Q?wc3W1LrFmjkRERPbDZOIEa+x4gSFQhQDxOKvspXnA/03deWaK1rmoiVk6fK1?=
 =?us-ascii?Q?FGa5cnwQ+Olflb2Y/S2LUgLGLZ/Sp+tmNOzjmLEjDqTvMfdoQVhrm1FYpNGm?=
 =?us-ascii?Q?DCA05EIWHDy6w5shWeTaAbaGVirbqzF2nGPYx0OXPgr2SdoksTjF+m74C6rT?=
 =?us-ascii?Q?555d2YZqJq2P9YdEjFvch1OIkL1DSwFe0Nx2orM2INA+0aJubdUk9k5eEtLv?=
 =?us-ascii?Q?m1OvuGwVmJI2zfuUjXsSd1/UhoNDAE7U/FNtNB7bbhQdpB2TDN+SR2gjIv25?=
 =?us-ascii?Q?6TEzVBY0xWuj7WFj6Mn7rtR1pfu14r+N3ad6jRgXl+A94tbkolL51IEK6f8K?=
 =?us-ascii?Q?8IKs4TZwYuEEpkSSuKve6FxShcIGQII3fk2c8qXEof/Y67EnnW9kYG7/++Se?=
 =?us-ascii?Q?V46v+ReVs/ovPW5gdgCFxo1cOyqftENPZEBJfRAQb+eUt7Te4S+7m+iIqoxf?=
 =?us-ascii?Q?OJsUORZ3/fmKO6rVQzuPOX5ZATpi6/Me2QVabzKKjGkSpW+JAzXfxSzWP2rJ?=
 =?us-ascii?Q?+8K+s9s9p8sYAtNSyGeTvAGE3zfuftZXTQkDlymLBelYQscYMsA2b+4nZgnW?=
 =?us-ascii?Q?lvRpyDjcSQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e63905-7346-4fdd-7cab-08dec80164ad
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 21:35:44.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZNlD0sy87K7ZORsaNm4kkTm3Ir/BqrDQvTG4JPVuuZBQLmM6GUPIyxpu6qapAwXs2p+GQfMEsllRGn6v19ufg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706

The re-order in the Fixes commit below displaced vfio_pci_vga_init() as
the last failure point of what is now vfio_pci_core_register_device()
without introducing an unwind for the VGA arbiter registration.

In current kernels this is mostly benign because vfio_pci_set_decode()
only uses pci_dev state, but the original failure path could leave a
callback with a freed vdev cookie.  The stale registration also becomes
unsafe again once the callback follows drvdata to the vfio device.

Add the required VGA unwind callout.

Fixes: 4aeec3984ddc ("vfio/pci: Re-order vfio_pci_probe()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 9f71eae0cc94..d2d3fddec610 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2254,6 +2254,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 		pm_runtime_get_noresume(dev);
 
 	pm_runtime_forbid(dev);
+	vfio_pci_vga_uninit(vdev);
 out_vf:
 	vfio_pci_vf_uninit(vdev);
 	return ret;
-- 
2.53.0

