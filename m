Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6140DFAF;
	Fri,  5 Jun 2026 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686869; cv=fail; b=pvS3aj/CgtB9nVVmiqaSrCzuGvZ7jHlf3j3S8/oidc8FIh3+vBvOfqyR/K5HFhbFJqlF10Ld34f8eNEvCTPLpBIZ6l/bAiPAcpeM2OJFO/0EEZr66brP2Wf+oZCyenidZJqbBcB33+zHVPoRtUziuF5ZEFqMxO67YSU6p4AWUSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686869; c=relaxed/simple;
	bh=5duPizzuaXaRkkj1mow7RczI+btNTJaVcQBIfafNd4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SpdDM0ROU5GdjYNUvQKYFpvWZooEW7kzf499iGyd5iInKvbKKqrqgOGfYQLw0WqsYLiKVnaUtR/oDknMhfGdCUOcAzCSTBVc9024JleQj3QW60DLZtI3WQDaMgDpsNQ3YNX+6C+PafJ3vWn2gnw0q1suikI5K2xOYFG1HUJdKwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hP+ol/Wx; arc=fail smtp.client-ip=40.93.198.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hP+ol/Wx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQCnE6bQzlXjIk3oS/+1Pdq4tmIZ4J8ptjFVZlIb5LxLQ3e0JRP6ZCN7qs2XAFfFu+wZVagE4SAX3le7lofB8F5Aa9Gls02oiY+X5/x/zO6u0kYc+bOehwf+J5MhaJtpq0t0IB/ZUE/ceuy0b7ZntiM17GermqJNBXXnYG6oiDtEsMKghdH2dZ8EsbSChtOpSazrkNmAXQ4R9kj2kiULHwkYbolLKTuDkO/Z8OBmsBHcd/cUWDBvf8ZRKRuT6kdTc9kqxn1MIadskJu2D4fXVt5Pb9AGCtCGHFD1I10jJ0lcG8c4VFhu1aqpAWR2hshjwbzzXKCHDRj/GFrgrIIsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+XGvDRW9WEvx35yqVr/O9AILSU8R/N4jly9BfJzPHY=;
 b=SEKp9+RqWNkH8jUc77oOm7swa1dp2t8DBZQykLiPUD4mVYEoGiwuVCVqtkeg2aWMLYoZN+NHFcfYCE7MA+vI+UImupGuecmeVkbX8VO/fTlRI0369eRyd0YK6QSj+RjTq8x+XueJTpC+JTUaOE54Yk+90Rbhua5AGbWym2Sab7SrSWNrWMBhHYa94+It1k1DDOUwDLM72gsTn7c1VxKw2TDp3Ch+/6Z1y2SyjKCGt6ku6mfpu99VVwmfUV2pTjNfLFn0JOE/FMygjeUmuo98gnJsVOMLH+nh2WPDz3SIaSHK1/DoOYtDON1Bv2xyXpFN+uQXXB0uETT7T8yGzyDiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+XGvDRW9WEvx35yqVr/O9AILSU8R/N4jly9BfJzPHY=;
 b=hP+ol/WxJ4DvkNgIsWGv6dUCu65ZhmyaqSG0HeRDDbqlZ19N3r2Hn0Km7aLMIrr/V8xJqNymhxNlyonILT2g6Efmg/fgV7ZdeJNl0wUhs9m6wtAeTaYKIqkC/9iMBB7oPsaR+djo9PRp6kZ470pfznZ9gsD68pw/LtiedopLaFs=
Received: from MN2PR01CA0055.prod.exchangelabs.com (2603:10b6:208:23f::24) by
 CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.9; Fri, 5 Jun 2026 19:14:20 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::6c) by MN2PR01CA0055.outlook.office365.com
 (2603:10b6:208:23f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 19:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 19:14:20 +0000
Received: from [10.236.189.17] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 14:14:19 -0500
Message-ID: <8ba9aef5-07da-43e8-86f7-1f6ac6124994@amd.com>
Date: Fri, 5 Jun 2026 14:14:18 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size
To: Terry Bowman <terry.bowman@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<djb@kernel.org>, <PradeepVineshReddy.Kodamati@amd.com>, <rrichter@amd.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>, Shiju Jose
	<shiju.jose@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Li Ming <ming.li@zohomail.com>,
	Tony Luck <tony.luck@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260605180610.2249458-1-terry.bowman@amd.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20260605180610.2249458-1-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd60fca-1046-418c-6245-08dec336a537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|921020|3023799007|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	AjThSEKT9qk1M2BwToWwqXAZBG1rLaHq5ClwWfgd0HFhbTMxTqXGn1Pp8P8cJZqUKu4ugjbKpZrI9fn6/NutwntngU1HCDOCHW+1DI1qx84UiddzWmUxxzuxvr6bmaZvA3OEpkhIzoX8YlGEnvXgJUhb+ShEuv7WwFHeUIoetS9RuFpkl8eBSY5mk/6C5YBuTkJqA17L/HEQbqLGaDXbA/YABBesWqpC6roDlyhsVg7gIC3nfOl+edMwSfF8nivC8GjuOBSLFfOU2D5luRZTVA+WUq5K+LcVf7JUIsuJBx+3+lXyuvaXZfaX3XZ8KlhFnluJgEkUhMg6AMWMEwiA9y6GnsnVf+G8mAPq/I3yIKjiNYe+QLwhvSdt2VogHF3RRZu3kGBObN67wL3zD8HKtYJoRjaAXrhIpilGeWnYF5INSliAnHJavrQoF9TOGc6JHwXf7OFI2tFQKIfCJxPCTPOlA5Jar0FU+ky/XKsDVVXrtwfEa4OK8piTSN+68CdP/+xItHrz2jPDqKCcyPkCWRNxCdVA6doNfmMIiUDSeNqZXSfOiE85DFLOBvhBgQvmvfzxjwkt4t1ni+L0pVUz7r1L0gkgmhJZlJg6DGwxNWnyDvVLCDlwPO+MXKqU0kuIMQVwEBywuClN1YhNq5rbgiGuQRAVKHWHGnPXmStM6ML7ZCRr8fxCdjE4PZjLOYgRyUyAcKkDgt7niMai2TaLer0M9Sd3ZQQJj+rRan36yZ+RmOwMnEQ+EirhYwuBkOCwfFuRJjzg+eC9PbqjWpMkpQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(921020)(3023799007)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vM2fYmSUC0eGqn6V5mPIfFaJZVBwpyOUBaSSzAzUEN9nfcXsohuKe2AMo+yCzZ0FOsk50Tw5buy88HhMV/NWXWZ56GdAFgtoEuXVuW4x3JcyW0UD/XHO1Cl+AZvUjrLqFXIdDiUUVnmEc/EcCyQOH5bO9Df4c0tBqeHr0PqxUb6+6BJiYmww1KvATgOa4Y4+rNHIadVhou2rv+8nM6s9tZVdntshiEqTelEbB9tMDZxlRUIOlHSiJEi9R8BOn3310Xxt70oC2TgIb5R0fxCPzC4CaKq56u0bEWRvY1svRf07Tx1WO3oc2Jd/W1QuZF+Sce5ekPJt7R1V6rcMgg3RbIbRuZiwL7bnZTwnv6bWMnhHtAqbpf3gY49dC6dB47qn7sV3dJC/CzMV1qVvGljY/Qc14fVxZ0mS6K+neTSs5NkUPETfkpwOAhT5BRJqxnwx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 19:14:20.0263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd60fca-1046-418c-6245-08dec336a537
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132

On 6/5/2026 1:06 PM, Terry Bowman wrote:
> The CXL r4.0 8.2.4.17.7 RAS Capability Structure has total length 0x58
> bytes (CXL_RAS_CAPABILITY_LENGTH); the Header Log occupies the trailing
> 64 bytes at offset 0x18.  CXL_HEADERLOG_SIZE was defined as SZ_512,
> eight times the actual on-device size.
> 
> header_log_copy() reads CXL_HEADERLOG_SIZE_U32 (128) dwords from the
> RAS capability iomap, overrunning the 88-byte mapping by 448 bytes.
> The cxl_aer_uncorrectable_error trace event memcpy()s CXL_HEADERLOG_SIZE
> (512) bytes from its source.  For the CPER caller the source is
> struct cxl_ras_capability_regs::header_log[16] (64 bytes) embedded in a
> stack-local cxl_cper_prot_err_work_data, so the memcpy reads 448 bytes
> of kernel stack into the trace event ring buffer where userspace can
> read it via tracefs.
> 
> Set CXL_HEADERLOG_SIZE to 64 and derive CXL_HEADERLOG_SIZE_U32 from it,
> bringing all iomap readers into agreement on 16 dwords.  Userspace tools
> such as rasdaemon have grown a dependency on the buggy 512-byte (128 u32)
> header_log layout in the cxl_aer_uncorrectable_error trace event.  Add
> CXL_HEADERLOG_TRACE_SIZE_U32 = 128 and use it for the trace event
> __array and its memcpy to preserve that ABI.  Both callers now pass a
> zero-filled u32[CXL_HEADERLOG_TRACE_SIZE_U32] staging buffer with only
> the first CXL_HEADERLOG_SIZE_U32 (16) entries populated from hardware;
> the remaining 112 u32s are zero-padded, keeping the 512-byte trace ring
> buffer layout intact.
> 
> Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
> Fixes: 2905cb5236cb ("cxl/pci: Add (hopeful) error handling support")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
