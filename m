Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE928C037;
	Mon, 10 Aug 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373239; cv=fail; b=uInJu6Z8rtUgJg1GTvb40jtqOXxWTJmFTWK3xHlbiSpGL0UkAEv+7Di+vs2xqz4J2ZKTkDP7gcyhZnXmBuc5G2x7dyKGU2rgsVjSr5sv+3lmyc8+tzyPSSkWOt5lHs9VI0OdU48HnHZRmSKpCM73iexg1X1kyl3dM5PP+H3F00c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373239; c=relaxed/simple;
	bh=mNmdUVJ/W6o0YKHE7sF8XeS3YQEmx73Jsl3z2b3c4cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FZQacVSL7WMho2NDQdr39JPI5TCxpgKhkjv6tzYBPJ36g2hwlJ9hq5BmzWTFHQllZgQr6euxO8gLAw+Okl8b/6fEmQEuGNCgEbV5IlEV7pIt85yEzihIObzRO8iP5kSz0x8zEg5wzUkYBj3umQxymGm6DEktbH5m1u5IqHr0qF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PnGas5J1; arc=fail smtp.client-ip=52.101.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PnGas5J1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwTraW4thNg8c9ymeFv/a1peYoGydnLmVwCaIHazPlMVtzNwlS9V+hFNVUYh1LUJ+DE8YuNHeE39egoN9yqPJPPKFJBuS7Zrg1/6t4nBkflqfRNiMOWL+JiKhv1Z+s6M8LrDJqrDyn6EOWWbKviM5B2ChQ60P5aKuozb4hkoReCYPfIZBAqtWd8z5lGHs27RZnS3745tyjapCoSfhsr57eOH088H7B53/mWQhOxCU5zRHDeFCtI160p7UYPv/oV7DTnZPrCPe82bghVCKveP0gGi9r8Oqm0GSeIv//4rL9g5TfFpHbtHgf/W0rkDU2XBxux+ZPOOcKvcmPgh1mQxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKbgW6w5ysJfiiWqj7al+Ey/abUKMSrPs0OlzFOe7Zo=;
 b=ddoRf9z8LS6QjiaYS6rBP1Rl8EPaBw7vn2GWc93B5lcIE2102adkXUhb7tl7MbtsiGixV/k/ATxYx6ZhnLJN5kBcF6mjpOKD/nS+0/IfWkEwvU/73WcJALadrjQp0BDAoqG97wIVMoEp0M+PCzce8h3MVs175fJdXWOzBwes99Jr1CJyG/sAcP9lYvnad+YTvvZ4qgPCxvTXeJN1UfCQXYb7OJVKiIlqOB2wmTJqHFrIdhomH6FErJbSCTpfD/ecRkVgVpA6SSCCTI5t2AtXffmYxmmtxTWwFq9IrSZk6bb1CaVu8PAdu12e6zKeIaywX2Y4FZ6fkCGRLRmdBqX9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKbgW6w5ysJfiiWqj7al+Ey/abUKMSrPs0OlzFOe7Zo=;
 b=PnGas5J1kuBiIIl4orySzEdh4sAYLLPuTRB7A8DiJou4PtNIWQnMijy3qs7o9FoxRTk5qFz9UBvFMvCrtpgf/UzyVnxMO9buB211/pxKGKmP8ralBjoRUJGXvylg2K52HIeyI80I2sQCVTp4CrzwEQYSGrNm8HR4I7/xCTTb7fo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 14:47:15 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 14:47:15 +0000
Date: Mon, 10 Aug 2026 10:47:06 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
Message-ID: <20260810144706.GC57095@yaz-khff2.amd.com>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
 <20260806160159.230453-3-jason.andryuk@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806160159.230453-3-jason.andryuk@amd.com>
X-ClientProxiedBy: CH2PR14CA0053.namprd14.prod.outlook.com
 (2603:10b6:610:56::33) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: c56bf41b-8611-425f-2643-08def6ee44fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	y3oUxh77mtIHizmNOY+sis0NcxFqKPoYmkZUjXtGiPmpzy69RDx7XziVSXQkgOm3lRFngAGiIdpSDOHTtY5njrNRQ8p5whOOxxFgYbbma5UWuai1CsS4wTIWQwO6Xiyly4+7X2p1Xnt8U84R3nV3azH70Jn3+HBZPPX8tOiJRZHwggb5KeEw8H4uwrUzDN/acP/GJL+kmTUD9FKEcTEtpkoGF/sCf26A97WnMqahumBIylnSsxkG5Tv79JabkCN7EDNyVPPYawt0JBvtAEONX2WqfFCa60BmWWuX8lpxUmE4rkVuGRuDAz7Mo54+edl3iwVrqZvhenHkvPE2pOmGei39qYYkYmVVtKWF3F0peYMb1n3h2ZkMAIoskGaDiUdvQN5zkjufh3pDR6Kmv/KqGmr33wfkb+NA/WEw4zvJGoJrBi1BM/TOSqPhb9QN3cN4vBneE8zi9BNmpNmQZTeiuxEJTr8Gl6qqG2giCwxwmiFJU7UKQYEaItBzO6Nv3dcBy51WYu9uKtbF+q4ugZA1PvCOt8wJJTO26vxBpL/JRVgDRlTrlc4E74niyaro9AwSJvcgmEQEP4dVTS3B183w5CTBZUF5+UQx8JSzoABR/TgrA4XinABXG60PLuorSCpJ8zsduPhOiMWupvKc+xYuLQ8vI/VfsBL5+8VeGMJXKtk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o6MlTw5wOp7cycd/r3gtMggVBAjgRpy8Lx9+JuhoUjb1xtCKWlbxSZ9ykOFP?=
 =?us-ascii?Q?unb5rQPdMMHAc9j8BPE/vBw2qNr7IONfgQlZwwtxkW0ahoDuNT1fwj0zreiv?=
 =?us-ascii?Q?Gpe9Upe5oO6oBhogfjmj3s1H0K7fxC+EgzcL7h0+Ep/TVAuzh7b6AU0/G9HH?=
 =?us-ascii?Q?cTNDb+/NS5wtG4KX52NBYZP4BKm/QvunLaJLxaccG4zTmogFk2LKLjPnSEBU?=
 =?us-ascii?Q?bnqt2cOmdh5LTZT5LbQ1odXeu54zPLvhlFV02XiwA/QjjxzPLUgg0MJtoz7s?=
 =?us-ascii?Q?ylEIEvl7SWryWwsgCR02QEcecw2qReK/a7I+NYwwMXTpeY7ndlB4rLIlWuBo?=
 =?us-ascii?Q?FE3pVTS3aslJxwS2Pyy1kj3i51/3kDaVSoDo/fzEME+JHCKEVh8ktZRU3WHT?=
 =?us-ascii?Q?wOgbgtfQsnKvY094Kq9QWB1GXFjWbOBU1LO32UceAIP91SIl4A12YDYujGRV?=
 =?us-ascii?Q?YzEHtQc/9UMijNQQYojzDzprG3ICg0EZr1Lr3OwrMTgelsmZqBTem1+tI71w?=
 =?us-ascii?Q?BWclNPSB0oeT/XxfBJRWaYAtsrK9KJAGez2GV6Ic/Z/suFRK2EJNa4d+FUzn?=
 =?us-ascii?Q?jHI096m7qnnlbkvcXgJNlNigVENwVIZOpVadY4+pWcpH2dZMv0Krw3nK3WMY?=
 =?us-ascii?Q?id4GtSDw+HmEAX/9pDErOeGG0mxB0NLjSpmYNr0oltxkIFNeq3yH4ASth26z?=
 =?us-ascii?Q?1nweFbmeQLbbnfFlRRKs7WlTyg6wYquA0IJFMd/4spw7Um9jW17HV124d7a1?=
 =?us-ascii?Q?ldKlI2o4mAMaNm3cNJlu5IPsio7kqNH8rnSUCLJ2Xzw2udqiyFoKnGVkso0h?=
 =?us-ascii?Q?/2p5EcJUlooeeyq9OW4BQs2irAzOgb1Yit5O0gbv81Ig5Rtjb6ONf67mT5eq?=
 =?us-ascii?Q?mPYu1pTaUomv+oPrQUzVEAgs/xXAW07AE3/OOlJXDVIa2dv3JTmEdl1TWVZN?=
 =?us-ascii?Q?DL6BAP0ONFFRToToUQP2TNzQvxuEYQ2URg+QzRThEqNyp4sxBMRi46Fee3eX?=
 =?us-ascii?Q?79+EjL239SbchQyaei9YacUAxRqSBmCUPPjurJxprjcD/1eaQZZJ/kQRgquZ?=
 =?us-ascii?Q?4/Zm80Dis1IcYDg4xN5y+ECg8zHYAbsskP8eBTr2+pTLTJ29AtIZ6VZaPkNS?=
 =?us-ascii?Q?dEhGlilbbGbpdyF0YtaulbnzhC6UihB37YqNQpgJ0kexYdpqs+tU2adijii5?=
 =?us-ascii?Q?r0ZTZl5M9uYQDpUazTphwbu9HC1pBZY4vu6Gu+MLC6dS3o3Mjo4G58MQp1AI?=
 =?us-ascii?Q?pejo5ekr+zCklT5aY9JnWfQ6C45q6z2Vb8oY1xrMqFkNeKG2k+fjtAysl3eM?=
 =?us-ascii?Q?OfhxNF808FrA3dFnjS1APLavcZ6j8B+y0WFJPposOokozO9scWrajq1CBPvO?=
 =?us-ascii?Q?u6Si/TH8AHgR+7Byq6aMJlaXa65vhV6kpivkeTky9zC90E6aQKHGdOH0zJLY?=
 =?us-ascii?Q?0LJPHtwEKlEMm5GGmCSzYFDQIyhlDEGXt9bfFRdg2KW+vR+tL6/fRrabXJtg?=
 =?us-ascii?Q?A60Y0fqnHmSay/Ah9gb8h+uyUj9KwMUAMXxTn8cZvvA1SSdu+Hmz+utRaXqI?=
 =?us-ascii?Q?eCnlOYwsnXU+Bg4vETCGgh6W0D2ITQbTiyVer6O6aS7ktIMzcnIRzXpnFn2f?=
 =?us-ascii?Q?CjzatVJUlWvjdF4an2vwpG1+TUJc/JIMeqQ67NMw3IsuZty0fQMje2l3niz9?=
 =?us-ascii?Q?S2sLdqRIGztp3rPRfpnlHZe1TERolbQorVh3xOSDDT5Qe2/T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56bf41b-8611-425f-2643-08def6ee44fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 14:47:15.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkIlQAGKYyKjHIWlHoxDz66230KiT6A8MIbM/uq1/i8KLP9mZXsj0RhQgd3dwGZziDFJnLMnR8IDoTTR/ARpWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828

On Thu, Aug 06, 2026 at 12:01:57PM -0400, Jason Andryuk wrote:
> On a virtualized system, the number of nodes does not have a
> relationship to the number of roots.  A Xen PVH dom0 can calculate
> roots_per_node as 0, which crashes with a divide by zero in:
> 
>     if (count++ % roots_per_node)
> 
> On a virtualized system, default the value to 1.  The issue is seen with
> Xen, but it could affect other systems.
> 
> Fixes: 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>

I agree with the idea with some minor feedback below.

> ---
> X86_FEATURE_XENPV is only for PV, but this is observed with a PVH dom0.
> ---
>  arch/x86/kernel/amd_node.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> index ea553267e5fa..c5025e5291b6 100644
> --- a/arch/x86/kernel/amd_node.c
> +++ b/arch/x86/kernel/amd_node.c
> @@ -286,6 +286,11 @@ static int __init amd_smn_init(void)
>  		return -ENOMEM;
>  
>  	roots_per_node = num_roots / num_nodes;
> +	if (roots_per_node == 0) {

Can be '!roots_per_node'.

> +		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> +			pr_err(FW_BUG "Error detecting roots per node.\n");
> +		roots_per_node = 1;
> +	}

I don't think this is necessarily a Firmware bug.

Likewise, it can be a 'warning' rather than 'error'. I interpret 'error'
as something known to be incorrect. This was my position before on this
topic. But the various contrary reports changed my mind (even if they
come from virtualization).

Furthermore, I think 'warning' is more appropriate. It says "We found
something unexpected. We're letting you (the user) know about it. And
we'll mitigate it to avoid an error."

Anyways, I just wanted to write out some thoughts since this topic has
come up a few times.

Possible rework for the above change:

	if (!roots_per_node && !cpu_feature_enabled(X86_FEATURE_HYPERVISOR)
		pr_warn("Expected at least 1 root per AMD node.\n");

	roots_per_node = max(roots_per_node, 1);

In any case, we should just go with a simple fix for the virt cases.

I think we could even do away with caching the 'root' devices. But
that'll be another rework/cleanup.

Thanks,
Yazen
