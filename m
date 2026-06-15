Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206EA3D16EC;
	Mon, 15 Jun 2026 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550788; cv=fail; b=Xr+f1vU2x1obhOuO8DcOEcZ1lFwoXE/UkHEoSU3piQeqjkqTDdya9VnhL/aYodXqkM72qh00Go+VOsKw4WXlHiRo8IExoR1PLKDv2VM4lUB3jnn3tPfmSeGmsbJofgyPivzwi1YCeA06a1MgSJZjERlj7c4LPKhuBP5OP7jl2Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550788; c=relaxed/simple;
	bh=i0CBXVMcul4FJWSns6LCNPJ3tM3RO3x6cgFF1Z6Nzn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ww1PWYCL1t+eVq56nVYN6btZiZhe2FrRfySIiS1xsqS9BomQ/ZgYJv4q74apMrxRqgEoDoH2wIgfBHEl1TD+MwOUQMpVxvIM1uuwZxkqQJlYSwl9S5cPdQuDFBtRh56ka4UwF1wrpcIp4Ig3s6dQrZfhbGaHoNvXb4i3A5sxvv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jKr2A6Di; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jKr2A6Di"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KP6iqjTF1ONZ5DlUh/2Q5t5lqTCrjX84ZvQzQHYMYABitQ0rOlVhPtDr+GvM7GP4k/TeNKMEfESH8/koK9otGqyJOaAgDP32ljtcc7ZvNYFCWFbjXKqrD3mhWtRxcQBNG/B/jvcsVpf8bLwSgLco75jQnfzIUWU2XmfDnf46ACI7Y/in9mVIGPjXnPOU3FD99cf1a/mkceJKYYM1DmF3T0VXDTZd1EIkqlhRDwPI0qslLMguJqt/mlIyw9wNAXX9NMaXO4/shJ7PInlZDoUa18w06eDyvFB+Da+lLulUSOgRFGVP5Rm0VHoi143/2PcX/OXIP6oeKaPMInF1yd6lmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5jbgmKG3LAFnXQuWUcWyLpWBn/oRGbkj92hbxSAs6E=;
 b=W73y6BEo1Q3Bf3bQG8HhxXIxVzJ8OXdi1kSwk61TkR9EvmKkCL1NowYyXheQa7cPE8Qk25aLbimmDxP2iKxMGdZa31PeAkWnJMGWYNr2QHJGxXfHHJp5/ydaaArPmzlPrOaO955txcCPJ6BMgpntXW6JOEgRrqE+QoxMi+JIXny+Kgnp7GIs83AkNDs/RaPqY7PU6/sRFjiG6PsQAnrwdb45t/sRXWju/r7JFkn2Fa5+VLsrn1SIXWpEw61V3X/frzf2btGkb/oZPmS/zFbRoDpd8n9Dpn48KyE8hdaYniqD3uDFna4IBKjM6EYZJhoZIkvMoAQMbH8HljFMyGMDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5jbgmKG3LAFnXQuWUcWyLpWBn/oRGbkj92hbxSAs6E=;
 b=jKr2A6DiZRdkHAPeTrOHJ5Hztt2bVF7PTCOTiiJNsEeAiL68h/MO02DHcapW1lrlQpuACBN361H4e8TQxJiabLeAyZz7rE/uOe/7L/pazTRQpao1P1k9lSTUnC0LyIjGeBxT1eDS+ufCLmskFFMWl3WSOcGuYZLf2RKmJoDIJcTCFv5P8eg7ZBs+fU+BYz3VIbnYNmn0Uufe/HLUumyJfYO8GFPboD/Kycr7F4mtemEwiaWfcshfAof5VgEbcjjp3F8s8gGM83FMlayQB51JC+M/UBZYYAf3JbFj8iKLzsSR+Wq3P5Tdfqg+iUH80XEaJwN5er/n6Zl3M8qMJH96bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 19:12:57 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 19:12:57 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/6] vfio/pci: Release the VGA arbiter client on register_device() failure
Date: Mon, 15 Jun 2026 13:12:30 -0600
Message-ID: <20260615191241.688297-3-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: da19d3a4-38f1-4eee-6608-08decb121c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	AygYlzCqXYW8fDTOPLpBceNDmuqk5jQxME5Cgvb6vDFC1iWtQNuVALs7iPTs2Bd0aDGG0aAGKh7110WYsTtjuYgahF1rdKRQ9ge/nAyOl+J0n4x1fLu5qUA0p/H0kc5cO33zf/8NEvGd3L1QqsrC1TPECYdyau8WIBBe1TiIfQxdPtjPIXDU3GaOFm9WWc7XV+VqcxuwdhWCg6e1GE5wwYzJlCf5CURChUg37xNhga0zsX7zq/vMCM8VsKXO7UIJ01aNBhJgg8+h1t6yZe0yVfo3YRAirM0p9nX/c/rOwLTSI+fGMWd5NlHXgZN0uOAu1zhl+fdJ78h5o0IKj8sifr7U+eg/M+fl84tDyWVU2Kl7H0WloOsxV/hFDeAUHCfxBpRowuUFSFHuRY2kWVRpON1YcmD7nTmTgtXgSaP+gF8aWvjsmk6KCnITO/1ZzgNsDWNMPt5yNJ2LFdu9UyHs04XpDpxQa9fAe0wy0J71b7WHegfR/Mgbswyfy63VsyytmRDE7j0mzb2C2GK/Npre505YI42Dm5nY8CVmg/udU3nLH7Eal3KXd6AwDzBOJl+unQ/zdVUvKSGj9s6H/S+C6uYcY0DdT3YsFy5hKF57lE2oGwXcWFoi0HEpC2rsIJ/L1HyA7Lj9aXDtn/nIO4n/xQeNUt7DIBnNLS3ywVQMjiwjKwPoPuW0dMKfGCF2RR31
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?24iOWKbK9a3Tjj33fR+RQI97/tGYMXtmZkB9/CEltPy7UQtrn1EJ05biiQa0?=
 =?us-ascii?Q?P9HaLqoCiHUsJKCUO5uD9mcibFg7Q6wnW3ii3of89crdkSDyLrOmNPDTPppM?=
 =?us-ascii?Q?dTeycDNLAyUuvl4Nt8AC3sN4JQoTPRFB9TplvEvSGgljNtgyzRAdgZTBoi/q?=
 =?us-ascii?Q?GxNAc9aVtMfjrkj91jnRtiWZnhjemfvxJ9TkVXBoAyDJf1s1TF/eYzk8wXwk?=
 =?us-ascii?Q?5mFwIJmQAe9DA/bPa+TC70T7MKew75OpBbrnaOWMGPahB2//YL+HA/R1DxrF?=
 =?us-ascii?Q?E6ELYOhA8j+8Tzh2eTDFHFz6afXROeN8sz1u+F5vlt+g5nXiPY0PfL+v/3JX?=
 =?us-ascii?Q?QEbhGzWb28veV1MjugG7cZqSB7xcCMC43VFCF9GPRN1z699i6rYuZNOx+xNW?=
 =?us-ascii?Q?lIQQiXzf5cZOeBLhDr6u9jNd1iFakYB6uLyZ0Ma98Lxem2kdaMX2VAFWiSkR?=
 =?us-ascii?Q?8HpiBmM2RcLw9c1RkdbPmNxrQ/mFj70kYBlekNYNO72028Y28cKZydKVfR40?=
 =?us-ascii?Q?WtdddI+rST3sTjnP4I1aQHgLRlZWxDy1TR72v8WfZOfmPQvVLYPDWIyXlqjm?=
 =?us-ascii?Q?t5Lz/ZAo5L5ljpoCZRuwyBjthVL8FQKQ4Td07UqDlTE5rhDhoQDtIz96AEmI?=
 =?us-ascii?Q?fFBgvkUftAwsYYhbqIabq7HVmKsUmPwLeI0k2+q0iahDrhysS8GwrTbry+qO?=
 =?us-ascii?Q?LwkK6NsvWjoJPNO2BjbxcNjGOrkMqJJgHy7+hMHhn+hM6hlhOc7AyvR+ZcVD?=
 =?us-ascii?Q?UdP54V7/RAgiJq8/UPi3v9wdj9q7weG8WcXQa5Up2k4saHW5ZARcWmVRJNhf?=
 =?us-ascii?Q?t9hcu41vLe0g2BZ6REy1BOPEk+R43zYQSlxb9hYtKYBg1Bm36UuU3ucUrgw/?=
 =?us-ascii?Q?eR9pWkTpauc9628U4Es46fRdJXovPm6P+9RXUQu/evq2NY04bcgDCRjKLYC5?=
 =?us-ascii?Q?T+LW06LN+tmfgWg9rfglEpO6pv73ON/xefsQ255YHk02lAXWqO672Ht6+tlc?=
 =?us-ascii?Q?jla1YkUObaGwxTvRKzquUB6omWXYIgZC20Mnc8JOD1MiUCtFgoy86RUOiA5n?=
 =?us-ascii?Q?KNwRVAz0LAeh9p4xQXqKKMt4Zxr1jKw8JQJlzVSkKWeY2J9j52hOKO0XHSz4?=
 =?us-ascii?Q?xULuzLoXY6luRhbR2U1ep7Vn+EDhj6X1D2Z7H1dA0YZNe+s33dpDiR8g6+9N?=
 =?us-ascii?Q?rXZM4q0b/tL5YgaKYZFXq40bqHI8Xpaxng1pMwKAWbv8WYUj1sZpmBCDgk9J?=
 =?us-ascii?Q?REJtEHkTYETecbNFzNdiarDPMD2us/nHBtM+fn+2x7s1/fyd9VOc9JUXCHMr?=
 =?us-ascii?Q?DPWGQSQM+pU1o+CVjDk28pqKV6+66v/CESjKmMuM5c3cLidMhAZ+8FX+mRcN?=
 =?us-ascii?Q?JVc57k4wTH+jT+xYlWxkhyClV3CXjShaW0RrqN5r0n+A6YjngBwQw25uXPB/?=
 =?us-ascii?Q?Q51Nqzw3336LvO0yszhlknwdulaHV2fOnejhH8AKCKGfBubK5pIJjUTWYC0I?=
 =?us-ascii?Q?cN47JBgA2/DQLF1oMUAmSJdrFD11FDLqk9RzHtH83sdPgJ6hYOKsvRzkwnyU?=
 =?us-ascii?Q?kNSzN+JPAVt488l6wP0hbXJxB0KEzzwPqJE5JWsYm+xTid9aE8qZDTYh45AA?=
 =?us-ascii?Q?tNDqC6z2sEsAKpTq/K5Jt035mdbVy5oMSCXpO4UEPnm8gI6rN/r5JfLWx9O0?=
 =?us-ascii?Q?pf7yTqH6+zLDsMV10VdL0Ei2uQ09xFPyMfyQhq+vPNJw3XXVaplzlpTudzX1?=
 =?us-ascii?Q?xfGwOXCVyw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da19d3a4-38f1-4eee-6608-08decb121c1d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 19:12:57.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +apiaeMY7BSRXbZprS76CxOsaQvxWOf9pQdIsoj6400zeVgxo7/wlVtJ6L24JNfEXlUr7oE0XjeeDQ6pfg0vIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

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
index f8d1755de2ce..dab82c078580 100644
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

