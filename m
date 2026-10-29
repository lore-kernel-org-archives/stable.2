Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793293610;
	b=MmvVS6IXdvqu6Q20VFn5h+QSHuqj14wAD+cnuP169cF3D/yfliFMsEyxv/kwPHPmBPy1
	 ZXvZOGyjZnfBYA6M5Aboz+FQRUsSEKEVU/l/6UGbUlr5xTcCXIlIcryNIuNwmUY6Dw0Mq
	 PZnuqfY+FlfUw/Ds8q5WevMbQoLzT+w4vE98DXQpW5LIWkz0UJfLrDJICyTHGMn7xkbBw
	 qF9H179zxBnidwzOGLeIHY5W5g136/yzb7qcj62Gwcna1M9g4S8GevfKlVOT8mErnXX1e
	 C21WKzpvv5TWeXvP0ebf8tV/TfyUoXKXMNzkB7OY2ZMTvz2jWui/Os8n6Z+sSE2Yi1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293610;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=L/RZCIG6rAWJGd8WSVDRzKldLRL4Vua47wkutkhdp+A=;
	b=h1J021jeb26SMcs8/gSycGETzsQACsR4oCp8mELXGkgFfMjtAkkDCrQybv7Iyfo2S+s/
	 QysoqCk8NzxSCnr9rOAkI5jYtSBUOBGwPWb+CgrrlhxYUx9LdeIrFHlGiIXuSRYXieW00
	 978k43SWwZ0j7UTqguZvao9D/n9JDHeo2s02QKmOgzxZ3X8aytEQyS+M2v/MqyYo/ab5q
	 byi2Do2NRdsNvglvi/bI6TxKlk1k7r5jeyHMVmwpFiXP3vyVBkDA6a+sqaGBxFAoLhmwd
	 gMejbqN0fKj4NCrIf7TTFjRcqA3vZXbxcgG0OAB1oqexMGdULcd5Iy61BoWTw0Ab2JQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="1Ke6N5/M";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.3
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC96606A31C;
	Thu, 29 Oct 2026 17:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AC96606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1Ke6N5/M
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQlNVhRTzT4HnQYmV1VWQBcG5wWwYC9G1jYlINV94dFE2S6ysmsxABsohmuMAO0r7Wq/Y4InK8AeNHcOkrpohy3eCdyiy6XBZt+0bwtBwnK3ftnrbRmqA4ZjnxWrbwIoDycgSJYbjx4M/l5obYiPYp6+cOPVJvEiYbMkTXiuAWU9iuusjR2RDXr3pKUkwCjTTpC3eJrQIaeHjP4i/oKhO+b7zM3wiQ5pFL6xccIHeorw6QUEy5lPwcbCZs7w2+flxRaytb7/yENf9+gKmE+cin1ankDCk2JeGYC+SLhD3pkl5ckfTDyolaG4lhhyb+PBegIBhypJJVAHncj2h2fG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/RZCIG6rAWJGd8WSVDRzKldLRL4Vua47wkutkhdp+A=;
 b=a+UuTKsdcHjLsNrMTjrVY7nboph3yHl5fluTSOiTV6m0r3eQIlgr1rvvyDSQoMd6qPXXlfF+KWQuDdDW0+6JU5uBlPPGwMeWyjgWUCLU8gZmdF9rfSmqf502NjPU0flBgvq7uox0k2nsuUBhymRQsGRyUtzT8WU+gBoDpDNaygumjMj8zdUQkCxX0MRtQvaqeDFRPaj2aEvALNCDmjCyXuISERTcGvXsUYZN9l//vEN5HLjEuvIE80O0lDesdrMuJwjJjGr3kXdUhP5C+aC5ZaC/SbMxlU5VA2QD94xlG8MRxs6GqCwyD4kkelr+o+3mCStYel/wyzVWJcnpAwKibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/RZCIG6rAWJGd8WSVDRzKldLRL4Vua47wkutkhdp+A=;
 b=1Ke6N5/MD0ih37BuUhYt5nyjEEPoELvBSUbOpD8j0+sYOg4oCuP2E1Q16v3JWvOWEzbHEsSyCi4p+ttstAtBoHWnIOG0FBWn9FRbwncRhT3cHBsrq2p5EkfDbutMLOUkyMmHaDlvw/jv4saAsm1kPeaXMy6ayayRWu7xI1xesh8=
Received: from BLAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:32b::26)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 17:06:44 +0000
Received: from BN7PEPF000000A1.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::23) by BLAPR03CA0021.outlook.office365.com
 (2603:10b6:208:32b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 29
 Oct 2026 17:06:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A1.mail.protection.outlook.com (10.167.248.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 17:06:41 +0000
Received: from [10.236.178.151] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 12:06:40 -0500
Message-ID: <7a22cc6a-deba-40e6-8033-97d1234420ba@amd.com>
Date: Thu, 29 Oct 2026 12:06:40 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/core: Create einj_types when EINJ becomes
 available
To: Yongxin Yang <yangyongxin@kylinos.cn>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, Dave
 Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261028084934.1735010-1-yangyongxin@kylinos.cn>
 <20261029065629.333949-1-yangyongxin@kylinos.cn>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20261029065629.333949-1-yangyongxin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A1:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a8a6a1-1d13-401a-aeff-08df35df00c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|11063799006|261026121527099003|4143699003|56012099006|261021123027099003|261009223027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|22082099003|18002099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	wNXLHHZn/1VIBC2DZEF9FjupGzIB2gNq2NZYguLHK+zUO9SoppqA9VMJRjRyLot8n7gg3CjfDymg61XutSswhweppQgXeTsoAHCA/VTpK5ugTBuP9hp/kK00U33CBmJ459+oj+ictXCo/ZaU3DDlrcgh5H5rzsvHQ1jW43rMTvbunV39DAgCOYhKwmV0TwygcRdqIhmQihUpyGcmxcSp2nP3wTwDbmXMoKxbYMO17FsyYaZ7x03Wkj1DJgyTure5ycjLyo3uADZmLdV4aJzCze6AtqSyE4RQ4cpE36VU+i6teOoLE+HFzZ7y5Y2Ki3npEFpjWyYqbrnoUHmk4RBr9m4eSyA2M/MBgMfdu2MKbHPuQYiJyeCoC+AFAPezqowHKhYMczzY0T52ltQEYORaPY5BppRJhNOBIAyJVXv4kl/rlBl9s9jHcqLFq85WcslwXF4WQNuvMbi6V8ICwqRTX5bLhdk63BFPpQFQVTgOp4oSFSqVgsBOZYH8NzLekZzZK8/WcnMLjULC/YmL9sx2lWIXjZgs69/7E/HvtdxRD87UI7FfHbreMA1VaCqZpsz7lM7T79DmG6DOVJ/Z3/HHWWY+1ekTt8LdI3T0Ngf2zLqD5q/8PBSZ97ngTK+nucdtxECG57Wcw53X1eov+mbXefxm6vkVKaq9Q/LBxb1G/D8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(11063799006)(261026121527099003)(4143699003)(56012099006)(261021123027099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w4JHNCUkla17pDAzWjHUZcZrYJiQyatLG1j6+qNE+L0laxMLk2Npw8popixP2jZId7dXj6MjjxMg8P76Z5iLmXkIA8mFqW7a61Nj7YZqBD003O1cseBqsSnSx7ZqtmcxXG7MrqoJlDAD+wZ1+JXIboa6hzjoBzqUPjkX1v3LMKaS1MdXb6jNca5F3rMxEi+KaGyZR0RtpSlv1I+5QoNPR03dvqJAR4L2tbwDqG0J5kD1nmE0e3dOqHIwFzFrpeZGaUeY+DlvnoGFSeAd+vQUIVTUVYs00zNj8TwHm7QQmLheqVLmM0mclqVEs0uTkrMgX1vZAq1bYulE6Q2bGf9idGNrYmUVg6LArxr69DT+Jttlk7r1tU6euMKoppAgCzqdL8hbszzab7RwRE2fp76nd1lKAQei3Ajk72IzUrS7tKSWE6lXl6Y8YkYYw5CAqKLo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 17:06:41.6205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a8a6a1-1d13-401a-aeff-08df35df00c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707

Hi Yang, thanks for walking through your reasoning in the last revision. It made looking through
the changes here much easier!

Nit-picky comments in line :)

On 10/29/2026 1:56 AM, Yongxin Yang wrote:
> [You don't often get email from yangyongxin@kylinos.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Yang Yongxin <yangyongxin@kylinos.cn>
> 
> The einj_types file under the CXL debugfs directory is never created.
> 

I think this should be "The einj_types file under the CXL debugfs directory
is never created when cxl_core is built-in", but I haven't looked in a while.

I remember you saying something about subsys_initcall() being downgraded to a
module_init() when cxl_core is built-in, and it looks like that's the case
after a quick look at the macro definition. So module dependencies should
cause the file creation to happen post EINJ init when both cxl_core and einj_cxl
are modules, in which case the file will be there.

That's probably why I never noticed this either, I (like most people) almost always
set everything CXL related to 'm' when compiling a kernel...
> cxl_core_init() runs at subsys_initcall level, while EINJ registers itself
> from einj_init() at device_initcall level. When cxl_core_init() evaluates
> einj_cxl_is_initialized() the built-in EINJ driver has not been initialized
> yet, so the value is always false and the debugfs_create_file("einj_types")
> call below it is never reached. Users have no way to discover which CXL
> error types the platform supports from debugfs.
> 
> Create the file from every point that can tell EINJ is up: cxl_core_init()
> covers cxl_core being a module loaded after EINJ has been initialized;
> cxl_acpi_probe() covers the same case for cxl_acpi and also systems where
> the CEDT is parsed but no dport is ever added; and the dport probe path

I would rather this not mention the case where no dport is ever added and
instead talk about the RCH/RCD case. If there's no dport ever added then
error injection isn't possible and this file is useless, so there's not
really a point in bringing it up.
> covers the built-in case, where the dport added from the memdev probe is
> the only hook reached after einj_init().
> 
> The dport probe path can run concurrently for different parent ports, each
> holding only its own device lock, so serialize the check and the create to
> avoid a duplicate debugfs_create_file() attempt that would only fail with
> -EEXIST. Reset the cached dentry in cxl_core_exit() so that reloading
> cxl_core starts from a clean state.
> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/all/de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.com/
> Signed-off-by: Yang Yongxin <yangyongxin@kylinos.cn>
> ---

The contents of the patch look good to me, so with the changes to the description
and comment below:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

> Changes in v3:
> - Take the review from Ben: the helper is now cxl_debugfs_einj_add_types(),
>   non-static, declared in cxl.h and exported to cxl_acpi only, so that the
>   cxl_acpi hook can call it.
> - Add the cxl_acpi_probe() hook, before cxl_bus_rescan(), so the file is
>   created once the CXL topology exists instead of waiting for a dport.
> - Keep the dport path as a retry point. With EINJ built in, cxl_core_init()
>   and cxl_acpi_probe() both run before einj_init(), so dropping it would
>   still leave the file uncreated there.
> - Drop the "RCH is out of scope" paragraph. RCH does add a dport, from
>   add_host_bridge_dport(); the file is still not created there when EINJ is
>   built in, so do not claim the acpi hook fixes RCH.
> - Reset einj_types_dentry and cxl_debugfs in cxl_core_exit(), so that a
>   reloaded cxl_core does not keep a stale pointer and lose the file.
> - Use guard(mutex) instead of mutex_lock()/mutex_unlock().
> 
>  drivers/cxl/acpi.c      |  9 +++++++++
>  drivers/cxl/core/port.c | 41 +++++++++++++++++++++++++++++++++++------
>  drivers/cxl/cxl.h       |  2 ++
>  3 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3b818adbd38b..0584245b30f2 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -958,6 +958,15 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>         if (rc < 0)
>                 return rc;
> 
> +       /*
> +        * Create einj_types from here as well, so the file also shows up when
> +        * cxl_acpi is a module loaded after EINJ, and on systems where the
> +        * CEDT is parsed but no dport is ever added (no CHBS for the host
> +        * bridge, or a CHBS without a valid component register base), which

Same thing as in the commit description, just mention the RCH/RCD case here instead.

Thanks,
Ben
