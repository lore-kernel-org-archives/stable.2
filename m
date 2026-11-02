Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655137;
	b=xBXWAZDb1m904F08ZV/Cotv8i1t01G7zhc/eLKBzDCmTluMfVXBAre/PBc9scJcFtiVi
	 8Hx5QgCMDo/vULRbyvrjYoOyEeSD4GO9KsjVyUh7xc5oU5FPD5ZhUX1OsWiDCLLXW3YB7
	 kONYorifkMORS9DvSmUJKLLpKignalfb0rDt7dT93eFR8LK5deEPoO0hFCV7cmpeOVVNI
	 uWDW8ETDAhslJzkew+7YRN2Le/jdNLUE5yVQUFMXp1tbsQ0xZX6FUF6yLy+Z9l5MWSWGp
	 IA7LxJNP9dWE8Ln8EDz4aFXROrvc7EqASl97pFIl1Su6fJk9J0YScR5Y58JREP3nyNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655137;
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
	bh=J7nIxLEKPJH78lPVgN5beRlgz71TkDF1YEbnyEcUTlk=;
	b=YED94A+B0s8oqG9viJw8M0ybAsbkDMwZNQZj/nPrz9nO4dQud2td37t64b5ZoffHMVUA
	 rXBNvMrzmOHtfsCrAsqADn6E6JBagXG5r2QGXGIo6jiZKB9aa3SNiznVR2DKCjBZBqCrC
	 VJDdHjOmsRD1kA5K6qoN6v8uHRi6907u6UaGRK4TJ48OgIm/1NTwWWxhbtvEZNElybQSp
	 QqLsG7jL80XNn2oa2btu1ggcVTyLXJlvCDyq+IDkXdq9v4wzP0s68Bed9FgMvqAKsj4WT
	 REljXLRGlUMj9vdXsH8EdsR+SE6Uhl7XQ8Qij7/NFjM01akxla619xFMN/yZyoA6uUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="0Uhg/fYm";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.29
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD3606A324;
	Mon,  2 Nov 2026 21:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1BD3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0Uhg/fYm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8JtnuPhTPV0XA2mML6MXanKWQB1ulmRBx+WkLQc9YxErGtXXVGDdLKPcUqlqqGfxXL3u6Q0G6e4J/CUEb4wIYHi83lGc6UDVIL1udG69QY6BrB2dR6Ui4JczfuRflldEewfIJYZ44S2/FvrpeWzwvtgroyPBW5AtLDCRcTZ7cRJzYtRSmRYKTTUTxmv2MSboj7RumQQhSWGorfebHR/AHRFn1W+kqn2v1t+NvxbN5V/bDcr054PPk45ZR/dtAhHUZBzrtPwqRVDZ+TfWGrzWzqv7jhYlBhASgCKTAfj+Yi8ecaRqQOdHAVquX+8ubbkuoVMEDLpobufVgfqWAHPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7nIxLEKPJH78lPVgN5beRlgz71TkDF1YEbnyEcUTlk=;
 b=Yq/sOsNlkMe1J3Md2YxNBYs5TRyL6MV9lfM3psOj4WKoUUCAoQVeq4lqgkyK9g6fP1dp8rbhbHgw9wALCAj4Y65szFIyZNLeFtptzEq7bc0pP/C9jQg/ze+j3XJZlpfpIaYXBkUvCvt/Xro8L959P12pD1QxuowAjc7aOyG2uIV73RV1xpCyBKUFCFx9lxS0DBuF4RIxu/MAth0p1eXPhTm1JnnxU/zuiGrrlhOgNYLmb5gWKeHTL0GqVPRdvRlq0cdpWtWBhbWVz5I+bsM2CIa/NPSn3VXgtyvaJcpkjg+3Cwk7cATqHgwYBL9rQIWIT+vEG4jfC+6yASoqaZ8F3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7nIxLEKPJH78lPVgN5beRlgz71TkDF1YEbnyEcUTlk=;
 b=0Uhg/fYmERtBzh0MjBNn0+bAX4f4wtkmdvtQMvCqNkQrf8AiCRNj/HmFCWECZbA9Xhesvr22JDox/ZThgiZKplZPORaH1qCYGeGK0OrBC6+BmbplXBJoI0wHQ8vosP/u4dWquPvh7Jp0Udg72HmA9LV//Nkb8bouNw9NUZ+MLzk=
Received: from BY3PR10CA0023.namprd10.prod.outlook.com (2603:10b6:a03:255::28)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:32:07 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::27) by BY3PR10CA0023.outlook.office365.com
 (2603:10b6:a03:255::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 21:32:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 21:32:06 +0000
Received: from [192.168.86.111] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 15:32:04 -0600
Message-ID: <63e782a6-e33a-46ce-a455-5d207a60661f@amd.com>
Date: Mon, 2 Nov 2026 15:32:03 -0600
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
Subject: Re: [PATCH v5] cxl/core: Create einj_types regardless of EINJ init
 order
To: Yongxin Yang <yangyongxin@kylinos.cn>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan Williams
	<djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Hanjun
 Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai
 Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261102032436.230945-1-yangyongxin@kylinos.cn>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20261102032436.230945-1-yangyongxin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: edfe55f1-8d6f-409e-c7ad-08df3928be2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|7416014|1800799024|376014|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|5023799004|56012099006|22082099003|18002099003|261102123227099003|13003099007|10067099003|261102130727099003;
X-Microsoft-Antispam-Message-Info:
	HFmxWT5VmGuDUeekkJAUlVH8DLGmdrdr5Fa3ofRfF5x7gz9uIcPnT9A4qM57KfyYdWu1TAnAcG1tTZfJ1e78csC98YO1o+SDSjLedQEswDKwx9BelVXPS0fr1bsoIPmsrPQnDjBPoqNLBf4UhoQ1RH2wCzPBTxnReq9+AZZVJs3bwAzZgtoW3d3vtpgzrPDfguREDPE9mEKXb5tHqOj6Y0zsPTZD4qIu6oukC822Bkdv/TpZjJZgu0+o0k8mstB3usURQjBpcza8JZ9t3dNGM3YJhOmLiwDat68nvwv5R5i2jOXKlRdk0f4BU4wPiEEqdFUZzOoFEYaaSZteCfb8wnnce9MC7lp+YnbaLrM/M7TeYNmgiwkb/fzwVMFa9lKfLcOHo+iX16oH2u3doCS0BvtiJMVea3f6DQwN9bLp5/TZiJxyZwICQd5KW+jMa/9bqvEWa/LuxKvP/EXP56NCzk3EUslZaGwqZSy49+WsuUQR5VwJPdLeVL+sSRaO+xkKID91VHZNHHXnWcsFF4+5W6VkRhoVyEU1U4x/EomxG/3RIrf91jSCIFPGjoBUSABwlXEVWNQZ8J1QObPWcMI2a2+LM9IDrh+W263ZJbfXIIK416apnbniiv/HyjNJgl98FweEJD7aj5RjJfPKRkm/CsLFyvXsm/gNq/zORP6LUxA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(7416014)(1800799024)(376014)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003)(261102123227099003)(13003099007)(10067099003)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vKkz23gyu9RkvGKigfYsN/873v/H7y2vZWuQUNbVjMi05UbtotA5N1LoYhoU7GBXiSnAfQVYBR7beFLPw4oiv4GhGeg97NxgRsrBvJw0xYrZxTFZR/w6VELK/ZY9NQpBBy5E8PtqwqHKm4UFlb1OmnyvgiaVV9bOsfSRqDKLiMYpmMe/WTcusQgbjEvuX+TfIJoZuj+6lalIIuAP9gEPaOzQ9Sea5pDOJdEaBqvs0//IZJHY41i7y+7XW1iOJJ6+bFSEdYOwEXoFKnUX/P5HAuLU4uYOPcGR/YqwvcU6By9emMkp8j0fVlWvpPtHdbJ9Fwu27sca9iXlS+UDTQq9Fvo2Av1L1md7wXW+9fJi7Fkey7OxuUQJwa204PhT60pyxNgnKsjDFZcGs6O2KhAI6u5lDmG+Bc21UcLPcQDeCC5mB5FpOIrPGTxpq3oCRz9+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:32:06.0748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edfe55f1-8d6f-409e-c7ad-08df3928be2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918

On 11/1/2026 9:24 PM, Yongxin Yang wrote:
> [You don't often get email from yangyongxin@kylinos.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The einj_types file under the CXL debugfs directory is never created when
> cxl_core is built in.  cxl_core_init() runs at subsys_initcall level, while
> einj_init() registers EINJ at device_initcall level, so the
> einj_cxl_is_initialized() check in cxl_core_init() always sees EINJ as not
> up yet and the debugfs_create_file() below it is never reached.  With
> cxl_core as a module, module dependencies make sure it is loaded after EINJ
> is up and the file is created.
> 
> Create the file unconditionally instead, gated only on the CXL error
> injection support being compiled in, and have
> einj_cxl_available_error_type_show() return -ENODEV until EINJ is up.  This
> single check in cxl_core_init() covers every combination of built-in and
> modular cxl_core, cxl_acpi and EINJ, with no extra hooks.

The first sentence makes no sense, it says it is created unconditionally and
then lists a condition for it to be created XD. Second sentence in unnecessary
as well, you already mentioned the module case is fine above. I'd change to
something like: "Change the file creation condition from EINJ being initialized
to a compile time check for ACPI_APEI_EINJ_CXL and return -ENODEV until EINJ
is up."
> 
> The check in the show callback is required, not cosmetic: einj_tab is
> NULL until einj_init() runs, so einj_get_available_error_type() would
> dereference a NULL pointer.
> 

This is pretty self-explanatory in the code, I'd remove this part.

> This restores the discovery of the supported error types only.  On a fully
> built-in RCH/RCD hierarchy the inject files below the dport directory are
> still not created: cxl_debugfs_create_dport_dir() has the same early return
> and the only dport there comes from cxl_acpi_probe() at
> subsys_initcall_sync level, before EINJ is up.

I'm looking at this now and this doesn't need to be the case. We can do the same
thing in cxl_debugfs_create_dport_dir() and replace the "if (!einj_cxl_is_initialized())"
with "if (IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL))", then modify cxl_einj_inject() to do
check einj_cxl_is_initialized() before doing anything.

Also, this function isn't broken for RCH ports specifically, it's all downstream ports...
> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Cc: <stable@vger.kernel.org>

I don't think this is big enough to be backported to stable. This functionality isn't very
heavily used, and the config where it's broken isn't what most people use AFAIK.
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Suggested-by: Ben Cheatham <benjamin.cheatham@amd.com>

Suggested-by tags are for when the original change was suggested by the party, not
when they have review suggestions.

> Link: https://lore.kernel.org/all/de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.com/
> Link: https://lore.kernel.org/all/7a22cc6a-deba-40e6-8033-97d1234420ba@amd.com/

These probably shouldn't be here, you can put links to the past revisions under the git marker ("---")
below though if you feel so inclined.
> Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
> ---
> Changes in v5:
> - Rework per Dave's suggestion, agreed by Ben: create einj_types from
>   cxl_core_init() without looking at the runtime EINJ state, and return
>   -ENODEV from einj_cxl_available_error_type_show() while EINJ is not
>   initialized, instead of creating the file from three separate hooks.
>   This drops the mutex, the exported helper and the cached dentry.
> - Drop the cxl_acpi_probe() hook: host bridge dports, RCH included, already
>   go through __devm_cxl_add_dport() -> cxl_debugfs_create_dport_dir() in the
>   same probe, so the hook added nothing.
> - Gate the creation on CONFIG_ACPI_APEI_EINJ_CXL rather than on the runtime
>   EINJ state.
> - Dropped the Reviewed-by tag as the approach changed significantly.
> 
>  drivers/acpi/apei/einj-cxl.c | 4 ++++
>  drivers/cxl/core/port.c      | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
> index e70a416ec925..3090c7649ed2 100644
> --- a/drivers/acpi/apei/einj-cxl.c
> +++ b/drivers/acpi/apei/einj-cxl.c
> @@ -30,6 +30,10 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>         int cxl_err, rc;
>         u32 available_error_type = 0;
> 
> +       /* einj_tab stays NULL until EINJ is initialized, don't read it. */

Remove this comment, it's redundant in this situation.

Thanks,
Ben

> +       if (!einj_cxl_is_initialized())
> +               return -ENODEV;
> +
>         rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
>         if (rc)
>                 return rc;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..d4ed1cc7c480 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2515,7 +2515,7 @@ static __init int cxl_core_init(void)
> 
>         cxl_debugfs = debugfs_create_dir("cxl", NULL);
> 
> -       if (einj_cxl_is_initialized())
> +       if (IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL))
>                 debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
>                                     &einj_cxl_available_error_type_fops);
> 
> --
> 2.25.1
> 

