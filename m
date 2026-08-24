Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B438B135;
	Mon, 24 Aug 2026 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601952; cv=fail; b=hf//1k2Pn0ds5J74+a24Ffs9UwHeLeLRowOjBSZVWYqNw2UDwMcPB0g47Q4u/gysonmclahOtshAXImgOjg/WIhFOORYE2eHjE0ss5KO56WHjvqwTB4FxATEXKz1pJIiiFo8viHPvw3FypJEq7QYiJ/0vv5/Ps+WhejLHP4Pvfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601952; c=relaxed/simple;
	bh=xrRZSGtSzbEvTW08/UGd0dzABpk+JYUQOpL7/Oh5afo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FQ5SJIjuyN2PGJPBDh/mKp9yRv1kTEciPv6SiJPxZz2Mq9pD3O5vQfobVmVRau1TDLnNZM74qDsWfPkoaMVN62xYFvKfNBCcfNx7qzBjS5QOMxlMVwWN0WmhpMVu/e67mxw2aqOwOca0fTNUrTQ+acJruBOsROzIOlt8lYGi1P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gAR1TXqI; arc=fail smtp.client-ip=52.101.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gAR1TXqI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFcvBm7x1xPZwFySeL1P1I5+2C3q/bsICb0wrb+/UUyvag83qWuiEZUCVow63c2m34ra37HjKLgN/R6UenALd7TuU1ZmuTTSQj2tucKVz0TsxEae7SGnKkmB+bWhDX8fdTi4Xf9pnQ7ZQha8IVtWWvTvAnIw9d3B6aW4nHCyDaMdtzyRn5znth3Bdu2NhxpYlDlliQ3cNRFZ1wBz3o+nWuihMVVJ7jkz73/AheafZPu9KxPyC4hWSk4jd5iFxaSeVzyNu+KAJrAeFj0HJeKIDsR21Z/OVGNZ7GH0yz3fZlJxLkTw+9JxC2jZnpbdCNk5vHKqFkEvrm1To8P745CMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGnUnMQV9S54t1FH83oyVwaBTHpZ3ODtytR6dWMP7PI=;
 b=xOQeNtFODmlucjLCKYkB/U6MyxfSPuemsOziR3S0ZwBlxN4WXsAgR7USwDW69G3PJMa6CszbXAhP96G3dA7ttx+sI6CeuuOxudUkH+ZyUn75kUbPv0sKFD0umPj44N0V4UswR7uKzcoEhPmvdO+fcSdAczXx+jMZOEdXZN4nnOBGWID32h1ahsn/PfNqBsboFYIlwWXa2kP2ymKnsFPNzjqnAX9X4/3Nw/J0gTkQN7I2TY5E0os1WmPs6ZnnlFWatHMvIGK138nbk09LYDDTBF9JqyNvRyEHE44UfB+QizfnKrnT1PDBq3WQ8exR0SjGKsrsk/KRRRgEqDyAqkvC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGnUnMQV9S54t1FH83oyVwaBTHpZ3ODtytR6dWMP7PI=;
 b=gAR1TXqIOb2ZclqXHHf7eP1M0cXoyeCTeECUC9tZaGT8BM7wqms1PdZSCN3WlitI8wN0QlnuXeTJVwNBxwqFVMfmGiA1ohFxX0LCe3DGqw0g2VHqxh6QXetwdXhO9vKSFL+lxi2VT6b7ye2H5/0ivs5KGNoEIbArwBTnWz+w+2s=
Received: from SA1PR03CA0020.namprd03.prod.outlook.com (2603:10b6:806:2d3::17)
 by CY1PR12MB9649.namprd12.prod.outlook.com (2603:10b6:930:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 20:05:47 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::66) by SA1PR03CA0020.outlook.office365.com
 (2603:10b6:806:2d3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 20:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 20:05:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 15:05:47 -0500
Received: from [192.168.19.2] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 15:05:45 -0500
Message-ID: <49f2616d-e37c-4420-9d8c-81f978386ce6@amd.com>
Date: Mon, 24 Aug 2026 16:05:40 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, Penny Zheng <penny.zheng@amd.com>,
	<stable@vger.kernel.org>
References: <20260814214255.83127-1-jason.andryuk@amd.com>
 <20260814214255.83127-2-jason.andryuk@amd.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20260814214255.83127-2-jason.andryuk@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|CY1PR12MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fdc147b-bd2d-4941-e7ac-08df021b1664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	fxS6gIezclc/Rvw9t7wEgxR+GKNrFCNgHoRnciImoaxngoyKXTs3TZoG1sYG3A+TdPj50fEW4rU0xNBXNlgLscCvS3+A96cZ+HL0WtTtRxbL0gDAf/sewjCHwfqljOq9Klp3BWoy7eAt8zekj4BWy6pwNlV953VfYCFQs73Ywf0WR8XSK7TSYP0Z2FpeHaG2+FMNLeJ+z/6vECHzhdh86GLr9idS8b+w9QJP9q7s+r0jiwzLmNKg6dM9CmTjGm2baiVtAg/lX4OtkN7IcSl97DOK0sv13x5YxXhXYNBYVC285CD/n5l5MA6AUIkxZUA4CuPAq/0YxjVfyCCzBCpD1Mz5n+nILi1wQqzuuaCue+6FGxke2k+ZsFndNkQfACeidryUwqVIrlyTspx1/sLM6bCGYN2+3qX/lBnqif76Ymmpbv0J7tR/RWsQodZdedbudD3XKcKzEyS82MvyPTZ2YCAeKi3qrXFhuoYiM/A9BKs8I5bNSz9pjifq9gXM9ztV5uXMo0jvxeRFafuTVDnEIhNz89AbXsuMPud6ZEPrAxJ8gCtLpJDrIXQwtsiCLSULYwHEN1dJJnZYgnYV6fqQdDvv8fOfseVk4toD6J5HPKTRJWnBtLV0KYm7I7Xp0E3JE7UeU8XePk8gv2/4geR7maO3cHMT3XWeqx8UrMvJXdPX0/khJd06J0GKPiYTIB/wgx1jKxz7ybsOor5YQBqWOA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bQA/xESZX9EdjEpMJ4GxAByOHCGd7z6GIC3r4sNouxKOk/LOUst3nTadK2BFyILeS8RCdKb7pH2ZqgqG3IHiUr2lt9ZB0Y4gXOqYl7UDHBM2N/Z8Ct11OFajxCHe8fZ0FNCC8U0RLj0tDo3CkvXadc+kj9wHg7Fj0jTpWfsq/IdAZBa3ymlnZAon1qn/lBXjLq2gcYEYEx32jhWt1nqrXdquJ8nHcC5rD3fP5H4jY9cWTI/joWf0GkBU5DYRF3UrULnTt1cJABWKA8ZoViveWuBsM1bPrH58ClQXCS2K0F4ULiQu0SW6pugksvMIyf6LwzLrClWSJGnW1x/JJn65Pm5IvTl2tRJBafc9wsnubNsY1fnls1vav+acwZTzuFUuaxZ3hFpOrQrJVTjAovv1ha6LoJpiBVvVvE5oPu7kOdlJTpx8s0mMw8QJfy3cu9P7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 20:05:47.2560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdc147b-bd2d-4941-e7ac-08df021b1664
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9649

Hi,

On 2026-08-14 17:42, Jason Andryuk wrote:
> On a virtualized system, the number of nodes does not have a
> relationship to the number of roots.  A Xen PVH dom0 can calculate
> roots_per_node as 0, which crashes with a divide by zero in:
> 
>      if (count++ % roots_per_node)
> 
> The issue is seen with Xen, but it could affect other systems.
> 
> Change roots_per_node == 0 to 1 to allow the system to boot.  Print a
> warning when this is performed for non-virtualized systems.
> 
> Fixes: 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
> Cc: stable@vger.kernel.org
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>

Any feedback here?

Thanks,
Jason

> ---
> v2:
> Print as a warning instead of error
> Use "!" instead of "== 0".
> 
> X86_FEATURE_XENPV is only for PV, but this is observed with a PVH dom0.
> ---
>   arch/x86/kernel/amd_node.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> index 0be01725a2a4..c3e214925d9c 100644
> --- a/arch/x86/kernel/amd_node.c
> +++ b/arch/x86/kernel/amd_node.c
> @@ -287,6 +287,11 @@ static int __init amd_smn_init(void)
>   		return -ENOMEM;
>   
>   	roots_per_node = num_roots / num_nodes;
> +	if (!roots_per_node) {
> +		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> +			pr_warn(FW_BUG "Error detecting roots per node.");
> +		roots_per_node = 1;
> +	}
>   
>   	count = 0;
>   	node = 0;

