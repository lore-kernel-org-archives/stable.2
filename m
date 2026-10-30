Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793388275;
	b=idMTJxtvgfgGYScL61LZmI6wX1yBKDub+GjHFwJQXVMEK1CIwalAi9qZhzJpC9PUqD6s
	 RI4+XJRjHkF06Gi1nDVQHPwLrbFcp8DbP6cf0Y5J6Jg30QrfEz/uNtsUIau2+3rAqtyvj
	 rY67uZmDt5MSbj/6XWtt5t+YC2rZStYW6xjnzE/jf7A3XUchpo6pnl9HNryVC5R4rS58R
	 nhf7BxxqRFdj+u1oA9iNPl1F/Od/8VtU09QuxI0amJF899nWQMFZNdoNQt8xKdZsc/6c3
	 UMtGrX7YlREcR34mb7dGJt1I1IFsjhIbixYvIbf+3Km1zzhfWKI12514WCNK+9yzxCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388275;
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
	bh=teCyBHNIjpyb/XHkSMRZom30VBt3+PhTmGRd1zie7II=;
	b=dshCh5TPlMSAzGSjl+cE1z8qjQibZN11c4/mMdvCgRrKXQr7Owch8FkC2ZLkoIgTlPvL
	 5sLU6RwPsm6GEWDjHJp6BlwnoM2jMqHnTpfKLKvAn4YZbr15hiidpUyZmnIeJhMOOMyGZ
	 w1+SjON/xgLK3WQUEH1evF65ZIVH1g2sGwjZk4O7bqWN0toiBLQX7DAawW9Et7xLFpnQX
	 ctEkEOr/DquWaZnIK6ReQ0Tv5T3zpLzZAsb0JZuAV8lRm3wxXyA9Y8xyYRflnufpFMaQf
	 5I3qxGsXSvFLo9eA8bwp43EwMtulisv+rO4+0jE+VhrlAOukDKrEUBscVslixkOeIxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="RcOgd/bP";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.37
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AC5606A31A;
	Fri, 30 Oct 2026 19:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70AC5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RcOgd/bP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IP032WSf+zRcmVDsmFNDW7oAgmvyblfR8h+QCrFDwa06t0V4YYRSKgdXnG/ynnV49eEy5ie09b6yTLr0Ns5tC/ldndanmPMnJWKVz+Qj9NvIhzXUg42EOvN9ygtUR4CMUjLj4KB4G79e7r2pBra/R99ZcoVvQWYiDMlQIhhA2yX7HiWCcyE5erK7HkI6qaQoZYi4wG3apHldVDucuD64UsgyOpw0o+nfZhUQe0kUik1/MWrbpn3XS/SYcapqAZl06AMyEmpD2RoTAyNFnYko/2GbAPHX0T+hjp3UZsKPUNh5U/CubRrCotlAEnn6ID4JWNBRD6ySGTab/L5ZrqLw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teCyBHNIjpyb/XHkSMRZom30VBt3+PhTmGRd1zie7II=;
 b=FbDH8ACXWT3Hq+/sk5ZKdk0a4+jxk6plRxGDyESK6dqVtfcxveCpT8/c4JwZ1Bon3mBnBR5G8oSo6m8056JmciShfFCKz3gWci3U/b17rZES2UEPhRhXSGm66YxBFKiGofyrH6MiZiqvAXpf8BsqkOXnzXbH5Y2K/2NqRRNPiF3zHoZLJQWsOPyItX+zP8kXXJUKZqXMvB52o+uaFUI5leDcpA79y/VkoxQy0nDDgSIzPHZGA0puJnDoYo9qDajtCqoNh35Tvo/ViauHC7RDeM/phyJHSqo140zW0ce8mm1osLoCVfq2bwoQrDn+TgxHXAOHfsoiUJSZOYbpjB3Ibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teCyBHNIjpyb/XHkSMRZom30VBt3+PhTmGRd1zie7II=;
 b=RcOgd/bPDMoc/UOAmC6HgWVxQp+K0Yi7v5EI+UZdrQ/dteglqNhJcZsjHuqX71882Y6LCezqkoqD4cr8HVQWzhVFVY+27+EcepZDtQcGvmaB6ckkH89hGLQGxXBQd7JTbDf4fmzaO4UMvs10fKDW+DGhU6ANv7gxc8tn3Y9cfR4=
Received: from SJ0PR05CA0076.namprd05.prod.outlook.com (2603:10b6:a03:332::21)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 19:24:27 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::9) by SJ0PR05CA0076.outlook.office365.com
 (2603:10b6:a03:332::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.4 via Frontend Transport; Fri, 30
 Oct 2026 19:24:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 19:24:26 +0000
Received: from [192.168.86.104] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 14:24:25 -0500
Message-ID: <7ef537e0-536e-4e32-8366-df3cee7fc9fc@amd.com>
Date: Fri, 30 Oct 2026 14:24:24 -0500
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
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <89885d4d-02b0-4c4c-8568-fc3d41623d51@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d99a58f-1301-47e1-4db1-08df36bb69a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|23010399003|376014|1800799024|22082099003|18002099003|56012099006|4143699003|5023799004|11063799006|261026140227099003|261026121527099003|261028144727099003|10067099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	iQUBvnXKv4nczRflGQ9CiZKxaDTSVl5A7md/93Q22NcDqBZqolCIHdlxU/U5zaIjlUvfpD4sbURwIMiunHX7GV8UiOAsdFjOK+wPA28ND5I4GaWDpZ5EkvuF0XAU16I+ZbXmbbtM07W5dW2LjtzOKBUvtxKcbQCqixMz9kmR/t2zBYtBhJ0mRVPdJeWy8LUHtpV9GiIpqJ4Fa2O0eFbJI4JeT4CTSgDT9FxzLNhwyWJrrcKLtJLZ51VX+11Q2vVVQzS1tmVTgQKx0PPdPqF15PfEhFNzfZj89rM+Ec5i4kGwy02cVFqSRnEA7tFN3q6lSFtexOb1UuOZ4SjY/6UrsupE1uWHAjlSPvDCKvcpwevbK86sMJ87zu5eAYO7HMjwTrA0oeVhnGutPyx2uFIF05j8gJw9fZziEgYCTBrnwKTyrmOaqc9k3aheUZ200ziAg2FVxkKLNScsVozRWOvLV4s89qTdNqh2iwUSbxfCUJ7cBzvcaCwF186RE3L7+bT/hk8KKhcvWp0z6CBt/E3/eZ+J5AX7jS4LswJA7xgydhSqUnLmiRN7mcKmA2F9ZlbeXnMbRigG8OCMfu1nwF+kD4Bl1nyGiG3EvYhLYrgYCABzOPSYaRHsWx6moFxfApWpezjZk99GB4lBIDtJ9Yi+TcAyRLqeWtsR3KkSV7X9zPxC8krFaeZZsGGjpIRGO5HKO0b9i0ScfRi196RQYcmAxA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o7RBhJ8S+hBJPrSP/gH9gBYl/REYfLHoPhXJ/Rj/jBQh2ayvCmO4EDJdAWhtqPFwb6SFoisRXrHlJ9YdAS9pti2KVvIk4jm1+TF5pKqjd0Ydv0lRkZk4ATng+/R5Qsem+fwOb5dAAiRheEsQrKI1xTUPj4Zwf9MUWLlpmAwMreZFamy8yu1S83X4MFiqBsdMVAkZaImT4viU4xHR9sD0v9VuIWZqgiiI+kh1aKfvDHw5sKmd5IXzP2UhYTaPjjNHQopYCWliwB7goPG0WqxnpC1DSV5S9T0BEfpEvbLuRDsjZK3d6gmZJV+ehQUlZQo/WCVLpk8n7Wivqyp2KDm/qlUFg8FxWTZPZxHJ6dCYadv4nuL51TKdkpdqOKsQ0n7Ai9RM8ZVwqQp8AIw3MTbH+MkyI0hao0bP6JH4CslCLoZy/TVewHy2dMMPbcx/E1A6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 19:24:26.7816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d99a58f-1301-47e1-4db1-08df36bb69a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274


>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index cab8ce39f465..b9245261ee39 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -926,4 +926,6 @@ struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>>  
>>  u16 cxl_gpf_get_dvsec(struct device *dev);
>>  
>> +void cxl_debugfs_einj_add_types(void);
>> +
>>  #endif /* __CXL_H__ */
> 
> Maybe drop the cxl_acpi_probe() hook? Host bridge dports, RCH included, already go through __devm_cxl_add_dport() -> cxl_debugfs_create_dport_dir() -> cxl_debugfs_einj_add_types() inside the same probe, so the hook runs at the same time and adds nothing. That also removes the export.
> 
> Also, the RCH all built-in case still never gets einj_types since the only RCH dport is added at subsys_initcall_sync. Should the commit log say so?
> 
> I do wonder if it's simpler to always create einj_types in cxl_core_init() and have einj_cxl_available_error_type_show() return -ENODEV when EINJ isn't initialized. That covers every config without the lock and the extra hooks. Any thoughts Ben?

Yeah, that sounds good to me. Wish I had thought of it :)

Thanks,
Ben

> 
> The NULL resets in cxl_core_exit() aren't needed. Module reload gets fresh .bss.

