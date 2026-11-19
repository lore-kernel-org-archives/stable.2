Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795127561;
	b=z9opGgU3Mh4/02PG9FO6ZnjyVq8YgvHJxG0lvWRwncsxxmPZNUzzhLr0JaKhuiMRBAaI
	 G2egX1Fd9pRLum5KcvUzo6ctVRUQd/sC6xHc+6cB3BGJvjHdIJgWZAyjlENECf1ZP5OpL
	 tY6SUG4LrnMF2mC7D1SkJC+5F5c/f3MMYWdKCJ77XByt9Pd0ar2FJMPDxO/C7pmbblaQm
	 Z85+sSubXnXCkN4YKDL74PXDBIX9+NORKHOyhkT4WsrmwuiJ42mABWqySWPsfZ9kv9N8D
	 hh/SCmhAc8VGdHEM/uhulIeOiQdz7eFuHB7g+1y6oWp+QFHn7BBYZfqJv8V5OodmEwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127561;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=YcbKqnV+ap1ncW6JW/nH40WueHyn45x2bnFe6a5RN8k=;
	b=Ylgxs4OPjbIv8c/ISnjYrIja/6XSfySc/3xeoyVl4Q7sxT0F31IoUPhqHRjyjYnjSX9J
	 aIdcleSWsSKqlZyDFqe+UK2hlncSNbqTA4TWQew15qw9Be3H1pS0YTtri7EAXBIpel0mi
	 WO4dDnpcS0iWr0t+WWVOn/wUoVDObgocWLLq4TBtFp1sg+chtX248ASzPmJzvAK0N4up1
	 exH5yJdpuIGnaI3P43bdRe3RfECvV8YcGQHw4Sbfk9+IYa7F9cZNA0aqUT9jTxjlzkTg0
	 5MefX6zA/sbF9ER63ucVDe4pBM1co6gv+oWOnBF1s2qltggodXHw236UwxL4bluoUNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DVKi6C3U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.19
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27698606A320;
	Thu, 19 Nov 2026 22:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27698606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DVKi6C3U
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlygVDU8ez48a0N2QQt51UdVZs6g97iW1UmOKoSXuFXuGsayeVzugH4acMiVvqwuZNfjfbCwRTsFBvc1VvY3mSECMEAA6Lhp3CRRLTwAGm8dKk1ztfGNVfzO3lT2RAioCDH5XJiZ4rftwMTSQArC2Bg6+YNwmKQJjFswbEiYZ9TiyJv+FYUlv59fkXH+duT3Y9iphCH5c8dxk+IZIxk6JMbrN1B3bT9Cq8ffy52wbzaxeoJxuXk3qsBj20LIPIuSV31lCo8I7duedLBHM/9NUrRKVYMsZA3ahuiZd4yiTsQp80x8KHOVad6FH6WIF7kOJry07hZ+6snAw7Z8w1h0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcbKqnV+ap1ncW6JW/nH40WueHyn45x2bnFe6a5RN8k=;
 b=c1sjFAgwRPHBRZJBpoMroyNO2YdGwq21Hc3GkydXCZcDimBwnx2/6B3tIlWHkoHiK/CbWBuWe7KvSbFlN3x6SvWJ5Vlyxl3YgIwcNtnkzY0jdnTG3WF00/TOtpV3O9pSY4wd7K4k/nRiNTTtdGzJUEvxksZOjTW4lBH/oHG/4y7U9vG0XWilfiirttz6ye29ztXRCtJRv7La7uhlILNdlLmnoFLomFNoWKxxzk3arT3FpUkb7zPw3hAZsdWOZpvjKed7nK1enDc0UDmcB779qf19IOuwHftjx3UTXZz4jznew5xisTFGFqMOaaBAoiwH6Mg9KMIlkkTnNqU5MHXWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcbKqnV+ap1ncW6JW/nH40WueHyn45x2bnFe6a5RN8k=;
 b=DVKi6C3U3wjUZF5CksPJ2MGZdqGwU6EuWDaEVg569iMHbUUE5xQ2ZpjgxIVuXN51lo/qbpvulA+I+MhxYZdyAndJ0zslTVYZ94p+UY313a/b6jnTrQCrIlaU/aJEQkcmIzn/Kd4E9LN4HEQJzzphFR01QB3aSTwatJfetiH9myp/ycbtZXoilBD8LnjZ8GxgACeBjA+Jr48MXkKl5EfNnMpDjt499swXgDCXRHSYvoBnN2DWbrAfd+WZizPO60dnPG19jr3MadFT4E1Ywt5/puN4s9Qa80aybs6vbOekpDhT03ihUOFijNj0W/+WmIsOAOxQbtyMlwgDHPVLwhaHEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 22:32:36 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 22:32:34 +0000
Date: Thu, 19 Nov 2026 14:32:27 -0800
From: Alex Williamson <alex.williamson@nvidia.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, helgaas@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, lukas@wunner.de, sebott@linux.ibm.com,
 schnelle@linux.ibm.com, bblock@linux.ibm.com, linux@roeck-us.net,
 matthew.brost@intel.com, michal.wajdeczko@intel.com,
 piotr.piorkowski@intel.com, dtatulea@nvidia.com, mani@kernel.org,
 kbusch@kernel.org, lkml@mageta.org, alifm@linux.ibm.com,
 julianr@linux.ibm.com, ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: Re: [PATCH 1/1] PCI: Don't block bridge config access while waiting
 for the device lock
Message-ID: <20261119143227.7c00a09e@nvidia.com>
In-Reply-To: <20261119123504.25906-2-ionut.nechita@windriver.com>
References: <20261119123504.25906-1-ionut.nechita@windriver.com>
	<20261119123504.25906-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::10) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a80e0a-96f7-4a01-2d50-08df468d01cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|7416014|18002099003|22082099003|6133799003|261009223027099003|4143699003|56012099006|11063799006|261026140227099003|261021123027099003|261102123227099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	nE3o/8fdPRsUR70Ew0U0+b06of4BZjvRYvLYXTIrHp8wCDatRcMXFKsvSo9I92sFNviKzlSnJ6/2r5SBHycwlVX7vKBXCFctioXgJBahOSZp7xQDJAP/cFyvHWNpjc8dgMegY9x1N6BD/dr6c2CxnT9B2tUhIrFBYLCtoRlDs5fvQL3nOxK+vISYuCMJmJU/RfX3ur9JGYwEuDylUDSMxJ2vb5CAFkCb7wywELU3Y9GqChSxuv4eP2EkZ4PB+eL0pUDCM6ldg6dLKPqLPaI+Q2jph5H/DHr5nZ7wTBBUafhksRMLURQFxMgaJNRafp65o2HK1s1BwGeaUUcAhJHfv+IFaeR++rJ4yzWiyoQi5MV8lQECC7Y6e1DAbgmF5fofta60J1rf1Zr7bMe8xp+d1t8y0lUi45r5oxKBxk9I/McXvkBx5LdmTTrUN1r1O1SLtpdV3WJdD91GNAuVB85uI+kL0RgNMAzCxtQ/YPY4TOuAKe3gfF16MaqHTCcnnc9L0tWFZwseZtP90DUdIrXul4uJ+3SG4I5upFQTYRYFXW6/yEr+x39jkgfP+qDJYAbdJ7b8hYVzuXRwrPTzileJl3OKrV2GK+XG6WNIFwKTYBTtsHShUAmj8Ax0yjUf3I0sv9Yt1cSv/K9JHRQOSNxILrSum00gqG2VpZv146HmPp8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261026140227099003)(261021123027099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IhiTyNd2JrTB32gZ5vidSNZFtKIRVZyMVVP2R6FZliNexs7YOhwwV078MUEw?=
 =?us-ascii?Q?ACgzlUg4kkaXuICFJXZRCU5aRzHP1/8c0PRuvUci0CcIZ+Pm9/esqdUASrL3?=
 =?us-ascii?Q?ITp2UJ41KJaEwyV9Q1ph3oMI926KsD7RAXnjU+85qVvnQ6UgossJf+RtacQ4?=
 =?us-ascii?Q?3f2+3dAvmuywk7nUbDP2EcSV2A3QXNdBXLGqzhLuPHgn0sFojM4LHWX/kr8H?=
 =?us-ascii?Q?VgUsby8q5lOKpQKOhwYZx0+j35ot3zDvL2nguTyQ7FZJnYdq4Bz7naqMD31W?=
 =?us-ascii?Q?Ew7MeKLY9b/FDKbyKMtSWe4ZKQGp5eL19uLCcCcVrheJfmj6nNn/EAojpydQ?=
 =?us-ascii?Q?MZaRHMn3JwP44eQx7RlqC91iZy/tXKqtuTkBlOERoNH+qWp693Ycgu37VjVM?=
 =?us-ascii?Q?391UrL19CYcNIYKT8jtjKHME+uzWpMokhq4IvjHajCw1TxWUv766RwnIDtFG?=
 =?us-ascii?Q?0x7b9BT5YgNeejLG6kuWwVL2jwMIFBiZvDxMGvEjRSafd+3dZHigd1U0OMiH?=
 =?us-ascii?Q?3KH85DGNKT8rV4ILaU0ZaLxkdT/qeNSHPY6pNLebcnRgqlYewMZTtnIyZbCe?=
 =?us-ascii?Q?eQvPPuGWulIGVuhzGoHhuw00RwLTXs2lEfALTDbKVdzHj1Gh2IZt6COkclGz?=
 =?us-ascii?Q?dmQSBz+9xE+3sepcr9aTTGVz/8B4vL3pp4VhohtD/mYKAX1bYk1RD3vv/l39?=
 =?us-ascii?Q?wLVRhBFc19Nw4QzWRrxRnHlS6dKFFRcutxlgFoiJFWS9yxd3o4vEYV1tJCvk?=
 =?us-ascii?Q?lFmBHvK0NqU6mQcZ+DfT/JPdg+L2MkPqyYuBeI8j/vz88woy6g3vc+K9VKfd?=
 =?us-ascii?Q?FyAl2EbIaIxLZbRNaKMs7VF3dcFRgIKR41Ic9t0P+ohP7GgKLmWYrE0JjITI?=
 =?us-ascii?Q?OFSCEgHEsUs5Tx6RczlVYBp+bA0IEo37JswuPnc526dSi7eUEpQX34B3UryW?=
 =?us-ascii?Q?yQVKIMrDNilPVCvM3o1s6+HJX1OvImMis5YUl/QLRYS+E9HPcox+mfmfIqGZ?=
 =?us-ascii?Q?oS5IzD44TS1hf23twp/vNUM6dOiYuqbYNHht/ddTrp7cBH9yqk12Nsg8au27?=
 =?us-ascii?Q?hYH0K9AvlHdLtGS0Yox6PE9Vz6YgGRc/1xPxCwPSjWKU87uaBZe0oGJ7P+NL?=
 =?us-ascii?Q?RfdIcpg58amCUKPSIyqd7rkTT04k6/5vHfZU+21sDB1lvv5Viqq0cg80Kcq0?=
 =?us-ascii?Q?tL8QgLUG72b2dyvvhJSte9EDOi7BP33yNl7j7yGoeFZJ4wGTM7GKbIddQZ/f?=
 =?us-ascii?Q?ccPV2k6C/dkaiaBP6/C6x9EckpxAxk1T0s8nfsmk04kHb3WJtFG39jzZ8RZ4?=
 =?us-ascii?Q?hGRr8qIGVe+59UeQMrLiJUUsEUDqbJtzEU7sx7bbrmQfhRo4PEcUhNKSiWLv?=
 =?us-ascii?Q?T4YsWrNB6unIndz9QeAlGsF+Smz6R6jfCGW9UMHMqE/IcpqBo42dGCKs8UyR?=
 =?us-ascii?Q?2cAioKajAlPXKwVI286PHrf6bWnsRttnaX+NNwedKlaXU2kN3lND7PhqFKwX?=
 =?us-ascii?Q?iuowDaEYrseiU/19byWckkFts9ZiOkCl8Y2nPfi4vxX0jjqfw+08GW1cKaxD?=
 =?us-ascii?Q?64ezMn5pyWMiS5XsgPUDvBdhCxw/vCdpLdpjcSWB/eZPe934VZtkrEQq4KZG?=
 =?us-ascii?Q?3jXLzAvKahEk7Zfl7HE79xAAyggseAIZNVPwIiGFjTvISNvqCHxWxUi58n8p?=
 =?us-ascii?Q?Er4Ox+FI81U/zDXfoOk+1y+ZgQIaGluQHFIeEzBHEUY1wcxiwVS+YNvByxkh?=
 =?us-ascii?Q?/Uuu9nONyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a80e0a-96f7-4a01-2d50-08df468d01cb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 22:32:34.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRE10j+gsya8e2gJIodEqlj22P3T4ZjUMl3eA8i40kywtYJ/p5Cm0gShhY5zNGwNjZazx4gvnrT/zrbAuM3obA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269

On Thu, 19 Nov 2026 14:35:04 +0200
"Ionut Nechita (Wind River)" <ionut.nechita@windriver.com> wrote:

> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> pci_reset_function() locks the upstream bridge with pci_dev_lock(),
> which takes the bridge's device lock and then blocks config access to
> the bridge, and only then takes the device lock of the function being
> reset. If another task holds that device lock, the reset sleeps with
> config access to the bridge blocked, and every user config read of the
> bridge sleeps in pci_wait_cfg() for as long.
> 
> This happens with vfio-pci when a userspace driver keeps a VF open:
> 
>   1. A driver unbind of the VF waits in vfio_unregister_group_dev()
>      for the user to release the device, holding the VF device lock.
>   2. Writing 0 to sriov_numvfs on the PF takes the PF device lock and
>      waits in sriov_disable() for the VF device lock.
>   3. Writing 1 to the PF "reset" attribute calls pci_reset_function(),
>      which blocks config access to the PF's upstream bridge and waits
>      for the PF device lock.
> 
> From then on lspci, which reads the config space of every device,
> hangs in D state, and so does any tool or agent that runs it, until
> the userspace driver releases the VF:
> 
>   lspci           D
>     pci_wait_cfg+0x60/0xc0
>     pci_user_read_config_dword+0xcc/0xf0
>     pci_read_config+0xf5/0x290
>     kernfs_fop_read_iter+0xb6/0x1b0
>     vfs_read+0x21f/0x340
> 
> This was hit with an Intel FPGA PAC N3000 FEC device bound to vfio-pci
> (PF and VFs), where the SR-IOV FEC operator reconfigures the PF while a
> DPDK application holds one of its VFs.
> 
> Take the device locks first, bridge before device as before, and block
> config access to the bridge and the device only once both are held.
> The order between the two device locks is unchanged. Config access is
> now blocked only while the reset runs, not while waiting for a lock.
> 
> The reset itself still waits for the device lock, so the tasks in
> steps 1-3 stay blocked until the user releases the VF. Only config
> reads of unrelated callers stop being blocked.
> 
> Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>  drivers/pci/pci.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d79f73b28..9c8d5dda9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5345,19 +5345,35 @@ int pci_reset_function(struct pci_dev *dev)
>  	 * no upstream bridge configuration to hold consistent.
>  	 */
>  	bridge = pci_upstream_bridge(dev);
> +
> +	/*
> +	 * Take the device locks, bridge before device, before blocking
> +	 * config access to either of them.  device_lock() can sleep for as
> +	 * long as another task holds it, e.g. a driver unbind waiting for
> +	 * a vfio user to release the device.  If config access to the
> +	 * bridge were already blocked at that point, every config read of
> +	 * the bridge (lspci, sysfs "config") would sleep in pci_wait_cfg()
> +	 * for the same time.
> +	 */
>  	if (bridge)
> -		pci_dev_lock(bridge);
> +		device_lock(&bridge->dev);
> +	device_lock(&dev->dev);
> +	if (bridge)
> +		pci_cfg_access_lock(bridge);
> +	pci_cfg_access_lock(dev);
>  
> -	pci_dev_lock(dev);
>  	pci_dev_save_and_disable(dev);
>  
>  	rc = __pci_reset_function_locked(dev);
>  
>  	pci_dev_restore(dev);
> -	pci_dev_unlock(dev);
>  
> +	pci_cfg_access_unlock(dev);
>  	if (bridge)
> -		pci_dev_unlock(bridge);
> +		pci_cfg_access_unlock(bridge);
> +	device_unlock(&dev->dev);
> +	if (bridge)
> +		device_unlock(&bridge->dev);
>  
>  	return rc;
>  }

Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>
