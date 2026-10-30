Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793392618;
	b=k9boHXpYHyLmhwYYx5yHHpqYmMccnDqVHinYgQslYsyQ+Eda1kqyghsSbvW3BeEHGV4x
	 kJSov+K0Sy10MsJz4JEwgh0h/7MMq8+oqJXhs9fTTtejJKQfI7JlxfggPtIXxbMZOb8of
	 /CiPQVuqRzdEzUx7bvQZOVaZR9Z1nlLllA+wMAKVVgkCxVeWV4NTFQURaQMc6NOLrPTLv
	 r5Rl2j9dSQfT7JRv55IcLaApHcR4wuRkoJPKS4VQqjZjPHFHMKB1yPFc5pCnoSAyx897v
	 z3orsFexCt4rBJgYGXeHSg6MuWGEXFMn1ROymLp6lDU7ZEAh8ZiMrwbWDWU+96N8x2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392618;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:CC:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2/50cHKJ0zAk2SR7UM6J5hICRV55uXiScQFf0DMSz2A=;
	b=LPmlxftWejiuAMqJ7yf97kcbfe7BmIpH2wRa08rqVDMBKVkyf916qrXFOzPFfLkie+Tc
	 /+G4/ei5ZrrQnL0Sj1KePJ1s8AuYElt7cO3Hz2N5wx82+Wfhn+eobSLJkJ8lWvM4SVPaE
	 VpirCTSO/LZJSVerw83XThIGuehal69VdHFePlq4GCphv4We46WluRVDgoZdF2kJqmh9h
	 BZhPj3ojJDxRmN0GCqRVEnZa6qYZMEEjdXKn7qbiy5Wa8I6zj0wXf6DFQYTgcbAIC+O8k
	 vigpgEZaGQUoMUXqO+Lxshq5fYmb3zPwTBglhIK3sIgt8agJOxLFq1nuX5lghFOuAEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ik3aJES5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.20
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD3A606A31A;
	Fri, 30 Oct 2026 20:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD3A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ik3aJES5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cm0NaD3PwKj5/NmmIv+XScMH6i7f8sOqRxNXG84iFUT0i/DLRIUILtjvSIsb74uKey9jztk4xmJ2K6jVXthDqW9gE1fxjJt6AhOShp6wBvIWKBhTINWRd/eHyhc3U6yU5vhR4D37TNm2R3tRr2uWnei8Ggtth/2weD2SGm0GVGg1qVVgXPvN2iURtIROSYby16oA+ZE6ltlnhCApMWRvCRlOuvQOpTBOuEC60DTpKNDKYalBir7GqzePq6ZMyb8qLkA/MOvaFfqbVQEaLyTNAAa3+VANliTtLftHDwxaczmEF0PIkclocSWFOerhkqwWdJXFgXHR+/GMBRcZGdnIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/50cHKJ0zAk2SR7UM6J5hICRV55uXiScQFf0DMSz2A=;
 b=aSWd/9ktGITvp0hzYSSZ8rAuXmOpHNfZv13EXlN6Va+xdvZPuzRQyObojpqeJ3gNur4MPaZz7nuej7goWBx9gDMSuOJ/qE7i2+qNQCz+kmQAqp6tD9EVYMinLcW/qnmrtezCW+MJvBF/2EkpBE1iIJ/dq0J+y2xy5Hn9GpBttAbsuK2ulBFi8sOydgmnW5Q/h8g0HS4GGR81VUOEVO/C0UlRAq4wTzBlwWItN6U1iRj1tXoY/aB2twtv7dDYKOumF75uwsKqZsMAGk+A1sBSjAhSyMPsoNj8CtttCWFheb+Z1XxBd7Oy7NvuR6OueCJQAb7kE5Gvg9F5dEaVGZBYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/50cHKJ0zAk2SR7UM6J5hICRV55uXiScQFf0DMSz2A=;
 b=Ik3aJES5naEltFBIGQdrjBI8YH7XGc+uukVvqrahSToh5mqXJnYXhBhelDK2sizh8L9jLa9Q/D1uQSOMTawG0/x8KzcbbeKzVW7uxwNrT+loXhmBQ8kMXXp32NkVYgaVy/F2nY6JYOg0cm3bFq6sPS6DnyCXyo0jAdHQY1oVnLk=
Received: from MN0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:52f::15)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 20:36:52 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::88) by MN0PR03CA0008.outlook.office365.com
 (2603:10b6:208:52f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Fri,
 30 Oct 2026 20:36:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 20:36:51 +0000
Received: from [192.168.86.104] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 15:36:49 -0500
Message-ID: <211fd9a8-3aaf-4952-a38f-69e5842008d7@amd.com>
Date: Fri, 30 Oct 2026 15:36:43 -0500
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
Subject: Re: [PATCH v4] cxl/core: Create einj_types when EINJ becomes
 available
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
To: Dave Jiang <dave.jiang@intel.com>, Yongxin Yang <yangyongxin@kylinos.cn>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261029065629.333949-1-yangyongxin@kylinos.cn>
 <20261030032050.787682-1-yangyongxin@kylinos.cn>
 <89885d4d-02b0-4c4c-8568-fc3d41623d51@intel.com>
 <7ef537e0-536e-4e32-8366-df3cee7fc9fc@amd.com>
Content-Language: en-US
In-Reply-To: <7ef537e0-536e-4e32-8366-df3cee7fc9fc@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 826b574b-a2b1-4e72-2901-08df36c58738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|23010399003|376014|82310400026|36860700016|5023799004|11063799006|4143699003|56012099006|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kLEebEU10E2bzyDu1EHliSzXga6n78y5zSlnK1xdhQAONM9Bifr4tqEcL250zl98wDZT4AOZ19JBthWEqO0w7NFLWrWOxFOxI1TnLLTron/UpPd2mBF6sgdSItG8bpWmS8gP2c4TVpxBbX44crwWjETAgwxvF9vlaqpsjAIJkFOMLAEudUmro06ZwXoMOligIaktXkQlavqwDGYPzjxQ2xH61qOUHMg+KsyUsWcDHUHjbi1L2kQNIhSec+slpWhTg2kZt0NZnkEh2kPP5FSuAvai8qsAcLKWTm3VDATYMHGli4EKZx2axhrnxH8CedWPjr7bW2EEu0GN3Kf6t6aiQUVXAMxF5sl8wFV1Gb/fH4LnyHZsgY/BoEdRFRkOYC1h6a1oT6JFIKxKLEyCMo4zYVxVmCXHZYx9/RVDchJjLV+l56nK6A6QPcijxi1LuOxMmEDNOSRXHPdNtHFVBW8dbSwmL2sUAWP9nRf3sCJpy37UrlsUAbdefn3XPtacGiYTa2gWa8CEHFnsHraYvrY8ZTKtYHj5flVRupgnZ2eKfzVDDrfqr+/4p1UpFh/TbPhcx3tXvfCnrHBQUSdqrqxrCgrmOiKZ/jDIYf966fAZTJUWyjrU5OxFbjon+/odM1X73KD/hLScC1fndbXD5Vyp4GvviUpmXZk3+kYeggjMYGEsgoI7k+n/aVujUnhuvVhKJFeeA44kSXwWVyOStyMADg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(82310400026)(36860700016)(5023799004)(11063799006)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iuiJjXcQgyMN1X4k4gp+b0SqxLLfuLP62xKdeYu6W7FOogM9iDZEf859UYGVY0dpsDV8fPkZpvua/9l5wQakI7Sq4nntqYF/Jut1fbv06i4E5bcpXzrDH1ItSDa2+Qx1EkS6IGSG0XKwvuhiqObbJy4oNxPLhlwclvcyAzO/vBkySZno+pf0UzU47ThMWptnSPzhxtZoP3lQ8Rhhu3cLua0hiD36EaDmL4KxRQO9cxxFqZlZYTAQktnZQ/Cdmssaj5cftGlAR/Q+RLTaGOF7KDujn2XbsdQANsTc9V2UEA1JTXjuysY+GrFkW4HP8p1ui2WNAojF0wr7TEck8Glglkl+zWggp6GXiVq/Z0FtdN3Bkz89V7DJ37wDvk6KkfVoXhq9TGPX2u0PwIIwm3l54KdPOsQXyrLomSoKmxA3/DsMwKFk1ecZd3ZvmTk5L/Qs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 20:36:51.4523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 826b574b-a2b1-4e72-2901-08df36c58738
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610

On 10/30/2026 2:24 PM, Cheatham, Benjamin wrote:
> 
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index cab8ce39f465..b9245261ee39 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -926,4 +926,6 @@ struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>>>  
>>>  u16 cxl_gpf_get_dvsec(struct device *dev);
>>>  
>>> +void cxl_debugfs_einj_add_types(void);
>>> +
>>>  #endif /* __CXL_H__ */
>>
>> Maybe drop the cxl_acpi_probe() hook? Host bridge dports, RCH included, already go through __devm_cxl_add_dport() -> cxl_debugfs_create_dport_dir() -> cxl_debugfs_einj_add_types() inside the same probe, so the hook runs at the same time and adds nothing. That also removes the export.
>>
>> Also, the RCH all built-in case still never gets einj_types since the only RCH dport is added at subsys_initcall_sync. Should the commit log say so?
>>
>> I do wonder if it's simpler to always create einj_types in cxl_core_init() and have einj_cxl_available_error_type_show() return -ENODEV when EINJ isn't initialized. That covers every config without the lock and the extra hooks. Any thoughts Ben?
> 
> Yeah, that sounds good to me. Wish I had thought of it :)

I thought about it a bit more and there should also be a check for CONFIG_ACPI_APEI_EINJ_CXL as well. It doesn't make sense to
add the file if the support won't ever be turned on. So change the check for creating the file from "if (einj_cxl_is_initialized())"
to "if (IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL))".

Thanks,
Ben
