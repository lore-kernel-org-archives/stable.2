Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B8F332604;
	Wed, 24 Jun 2026 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319319; cv=fail; b=F6kQ0ZQB/EKoQgxUnFgcdWttpiHHTX470qopQYF/EwUX/Ug5iwVMmRcJon+mMKgKvVALWhz1rbGqS4+dSE/gpgWWBq9f2QeHXwNksNNFz0VetQ7WkpIJclGWC9oH8nsNn9xnlUdnn6tXpAvkRrjlE4lAZcxcY5yvvPfOcbZrWDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319319; c=relaxed/simple;
	bh=E3g6frPvNc2i7fvCC/NjKykCIr+NJh1wVMW6Oynxpsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VqQNf/d34Pm1GDvTfqkaypPPLEWIWgceugoCyuOAhgcD1PJ8/2UdohJiaWshm676o4IVh6vDpcs3njRZAYUnnjHjt7JaToCgUNb0zFEBO+H5UFR8KCT55/CtMGKE9riZDA9So1b5Yj3ena5044tVZ4ONAr1xl6s1dTzeseR27iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4GGUPfi+; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4GGUPfi+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbRFEtMOTfjATH3e5CINIQGjRqSxIu0B78A52FlHOXKIH58eixc6bPlW6hfX5PxQgRUmTz1OU8dZzOugziFHlc14MWvEOcB3bAk8XUkXPUrOC6+7PQVyd8aOGBuYUzcc3tmp16/wgLfJBqh0dbm/43ndTHbczbMuVFJgAX6hsSvp3xnEYRsSiWzgBduXsDwAYJ+KnhmzYZVk5+9n9MTc2PhcA1O6+JzMzX9Cd321bD9Gc9oDyFMI1PpGJqwS7oTZMa9wY1hLciBbdNNSuDUPCXIg++Uq8xVJE71RZ2rnNX5ZrzJkRn4zTquhk/EXx7qBsKLK4RjMGJ0S5aqiP43j7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Jr0BxNAAxmcRFmeYLBoJ6hgm9vhlqWD+YMxqNT1frc=;
 b=Nh0rqoyoB0UvEn9NG94KBmCe9eg1eIP/4Kh6w6vSI6S6a7I/VSOymtIWpY4+2lzWuvYURv762ghL8NyK+vOVVKS4dI/h6B85+Uqg6Fe+hQWo2YDCpp/FrdYOTDjafYTL4MkUMHYPTiQ8Q1MCyP2i1/82nz9nyEdLZKm2XOiETvskyGQNDR7ezUCG8YqbnJpFoWRXprZ/e3w4Ci7rJ7hqJquXqnlqLqby0Wbd1xyvnJ1ltiM6jKgp5VVSDSeZRK+ZvLNbDld7izWgoACOU9NqQ/3+Fqi+Dfjk2ClOHWFRxx3NyVPVINxDx1KVg6PZ1h6Ix1Ko54ZQKNWuk77vIu2SBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Jr0BxNAAxmcRFmeYLBoJ6hgm9vhlqWD+YMxqNT1frc=;
 b=4GGUPfi+y3GqGuOmZXClX3yHhYqXXlU4btJB/51EKrKqtdwkcBI6YPuRtwal8YKUDs50MhMtXNmCJcFvui7tGrLaUNDlE5Qo8rMC9OYHgA7k6J1DHZemtJ0vfftKV4OZ5VaEIDyo60Lg9Ri7c+eYYm/bs3bufK5Sa1fHzEun9lc=
Received: from PH8PR15CA0023.namprd15.prod.outlook.com (2603:10b6:510:2d2::22)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 16:41:54 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::a1) by PH8PR15CA0023.outlook.office365.com
 (2603:10b6:510:2d2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Wed,
 24 Jun 2026 16:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 16:41:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 11:41:53 -0500
Received: from [172.29.28.188] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 24 Jun 2026 11:41:49 -0500
Message-ID: <0500111d-91bf-4105-8de3-af44a113157a@amd.com>
Date: Wed, 24 Jun 2026 12:41:48 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: Avoid divide by 0 in amd_smn_init()
To: Borislav Petkov <bp@alien8.de>, Andrew Cooper <andrew.cooper3@citrix.com>
CC: Mario Limonciello <mario.limonciello@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Penny Zheng
	<penny.zheng@amd.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260623211904.3674-1-jason.andryuk@amd.com>
 <20260623213552.GAajr8ONjXFUnuUOE3@fat_crate.local>
 <48629f88-4b78-424e-a199-d87594c8cb40@amd.com>
 <20260624155910.GCajv-zguf0GiBxt2F@fat_crate.local>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20260624155910.GCajv-zguf0GiBxt2F@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 022d1f76-e094-4e2e-130e-08ded20f7f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|4143699003|11063799006|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AHIwtURToR02W/yFq+U+Urrgn2NeidsjNnak6KQKkyYYCsuYFVHRdWRj8sp2LvuuzVNonGE6QX5G5RumiE4DVDTPOqn4MPDENYQjqltZ5rneB6Ng5raDIgL+Y+Y4/ssL1ggvxwompDFXiYSFyWkl7+y2kz5nT6953FfRhp6xKd5Mi5n+38meQ+2DqAw917DxLj3ch+gb3NkgIRInavf/234Cjm47pugZtcbZJxaGeq6b1yJ/9R9A9bpYRbx3D1z6KBkLYdqA7+fM2rsQ324y6Aznc8X1aE1oFx9CeuE6baLdyMeCuyrt+nhqPZK4ahtqWw78QIkiFJcKjHPNRHX4EBY3onP+NxcVOjRXuSBlVAhrvpImB4fCUXsAbwvoqDdktE3DcQbG7L58ImsZay1lqMzgnBTXxKgnvtUvCVKLYcDLOaQJbIkSH/G4z/uM2ubscSfulbuuXnCaMtRit4wy9p+KPKFtYWeZtZi4pTkhpmruhUid7Q5jd2XJ/ST5AMP1kUylgUvCTT8YkDPVHm2ApttALhFVlwqRhXHXEAA3m9lbttsANEhzBrLryydbrLDFSDSS0st2YHF+kNyEWi4pvutbFgDsYOPHyAgQUqucs/8ylVaa3uLNVlf3/JVUuACxxeC8W6dBs+jB99gkqoedxPF1xFEE6UJ9xdKjsAPpn1LRmo/kbZQF/5ym2vbP/7AVlLMgh/tgNKr2gtz2eSAEpQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(4143699003)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uGHpujhnVcLwqoJ1Nwyn/GIAHM/kl/mxka5uZBfRIHdrzt6yXm/1OTAT5oCFi3QaNxObxbt2Sn0jKHmCDII3In4DNb933cXiTAbcFq3uP+43LzOZvS6pooW/OUik2bjQM5fKSVAeqi3zpzAC0u9+YowLEM5u9d0yW3wTUzvcs354tkbPRw3mrgnT4/57bmkiTN6I2DhIut4/3oqgqYpeMFYiHGBrjs6EaWFC10rF/dLaTYgA73KDw7LtISNNDD/rhpPQPUfZ7uQ+ReYvUn3NLm8axShTd7MjtCzcUsNmXp9WXAFZ3oYTJNgLDyuTw3UKRKrATC01P3cY7AY2fTw7mcsqjFUhrcdLfMl0my/aNmDodjJzRgk2Vr0b47IEYLcbx0C5mvdnHzcF/489kV1CTY5T9H346/BjRBq2V9ywGYl/b2UHh1eFtrr3SW05cWnW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 16:41:53.6224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 022d1f76-e094-4e2e-130e-08ded20f7f65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269

On 2026-06-24 11:59, Borislav Petkov wrote:
> + Andy
> 
> On Wed, Jun 24, 2026 at 11:41:16AM -0400, Jason Andryuk wrote:
>> I have wip s0ix support with Xen where dom0 issues the amd-pmc calls to
>> enter s0ix.  I'm not sure of all the uses of SMN, but with Xen dom0/hardware
>> domain running most drivers, I think it should be available.
> 
> Well, how should we make it available if dom0 doesn't really allow us to
> enumerate PCI roots and thus count AMD nodes?

dom0 enumerates the physical PCI roots.  It's just the dom0 vCPUs and 
topology are synthetic.

> Andy, see upthread.
> 
> What would you suggest we do here on dom0? We're trying to enumerate AMD
> nodes but dom0 is doing something special wrt topology and PCI roots - see
> get_next_root() in amd_node.c.
> 
> Thx.
> 

I think this is the issue:

     The "root" device search was introduced to support SMN access for Zen
     systems. This device represents a PCIe root complex. It is not the
     same as the "CPU/node" devices found at slots 0x18-0x1F.

We don't want dom0 to access the "CPU/node" devices.  It's the "root" 
device SMN access I am trying to retain.  Many amd_smn_read/write calls 
have hardcoded node 0, like for amd-pmc.

Regards,
Jason
