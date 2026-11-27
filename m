Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795781885;
	b=nBCKS4Q7o9dQq0QNyCqH2cwikj3FcheaQhByL11RjFH2if1pxsJRc+byajpOlr7aGio2
	 b3PuYZFAXoBmwnioTHGlFhqsUjy4LWhc6YXBZywhleO4/XHxAvzdH9wGBtg+WR9TFMlTC
	 9WoB5PnLGNuctm3KYui3xiFKlQKSPsImMJdiMN/srbwt3xN8xACOdZTLLTRxiCbTFPYgC
	 JK1GmFk4uihZwzs2ofl3yjQTD60w68b07nw6S2rKPOVtfObAil08posx4PbUMIdNzFDoR
	 6ou2szqaH+Cj6JjQ943dAj5pbnmF7pXioJNRf0pKKWrKBMHykKvDRV5bTFjR1RVnX5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781885;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	bh=8GM4+1z3MXiFhuuyRo5bDjjiFnV2TtyBmRaHS0kauZQ=;
	b=pmUz3VjHSdxOMWvwGrYJFFq+55NCr1KXvh9Qu3d3xwqa5v7E6zxMhl01QsZ/y5Wl2XL9
	 iogQHKg3LsgoNqTDTZFLnZsDq9op+ruBTHXUKlveJpgKakO7D+GlBjvS5Bkk3rgZ6tTVQ
	 8JFuUKGicIX7N/DRc8bIFEadG0LXDlCdWQELEQw07JElH9JZ8E0+DLw/4kAAqN485nddf
	 wlscP6TRrFNFhs24UuUFfX41ETCg9rseYOdEVP5t9i6hXjxLl5wrXLXt39KntUcM141vW
	 GUPQtZjpaX91UUyl4hfnBSV7nYQc4/orv3ulHD49Z0Uze7g/YWJKFYGY/6UdEXghk4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=u5eKR6NB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.48
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC33606A31C;
	Fri, 27 Nov 2026 12:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DC33606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=u5eKR6NB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e150JoUyAHPymQ37Dhw3vcgXCXiB2eNWi7fveKR0v36L83C1f1yw3aiVfNXIRJ2IJrGqY1r9QbcsIG2zdjMin56XlEbYFPZdj5CdFz+3NEidCW5KVa732dOOSxhUD5CFLi55G6mT3SqmjtrEYL/rrIEOZs/rTtUK3G4wEZ6a+yaRdwfIyWrV0Xz9VLXfqkqRJULBTTGgIKRbrVIdNMekMuoKSTKy5AxCv+zt9IpVZMFkCL6D2JitZOgPsCpZSJdiD7yq5kfAtFRXOOgk36uejSJoYcWrEnf2dS5FRBpiqSAQsQ6uAwzqS2cei4JMtwvULFXLhL34jNqJAg4rMTOgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GM4+1z3MXiFhuuyRo5bDjjiFnV2TtyBmRaHS0kauZQ=;
 b=p/PW+NeoCFFZtHD+x3lsSAfR9yXQup+OMgorHfFCAaFanidXWRsDR1PBgrkFWEqfTgxxaivNoAKUqZsL/Xd/VR9zjc6Pdc4ntD/mQGtfNT9AfeksnBMvT4zfyX7VmnXfPem7IwerRRK+u2WkrhdVHaQo+7e/l5lwX7zvovykNFDHv6rGL4EGD+7Du6n9k8OVl+Q36jii6lYQmEB3fv7uTnP53vQ1yy2NkgXqVlU9JrCGvVyotrIuDcktc22UAg582S86Z01/7WClB3Yba1Hrhxt1g9CwauayHQOptRMpVM4iYYPYI20QVbrlHYlCTbm7KoX1NFF9AT7xHvY2w/KECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.dev smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GM4+1z3MXiFhuuyRo5bDjjiFnV2TtyBmRaHS0kauZQ=;
 b=u5eKR6NBvLQGXUPFWUBHklgFtSMiBScj2I5XzPgjXUiABt/4RhWSDWp3SsfVUNhc6xgxeUTgxmKnJuTwd1xaIQsHfab5Jv5LkpxvwNhvfdnVwleL2Zvxu726CmNzlSTn/wxc42BaIjh6uneYUYBYrKPLz7pfXt+L6TENVthKa3Q=
Received: from CH0PR03CA0318.namprd03.prod.outlook.com (2603:10b6:610:118::26)
 by PH8PR12MB999322.namprd12.prod.outlook.com (2603:10b6:510:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 12:17:15 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::4c) by CH0PR03CA0318.outlook.office365.com
 (2603:10b6:610:118::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 12:17:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 12:17:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 06:17:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 06:17:05 -0600
Received: from [10.211.224.132] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Fri, 27 Nov 2026 06:16:56 -0600
Message-ID: <78f43e25-7617-4b48-9e18-ca7be1011d54@amd.com>
Date: Fri, 27 Nov 2026 17:46:55 +0530
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
Subject: Re: [PATCH] perf/x86/amd/ibs: Don't leak stack contents through
 PERF_SAMPLE_WEIGHT_STRUCT
To: Usama Arif <usama.arif@linux.dev>
CC: <stable@vger.kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@linaro.org>,
	<tglx@kernel.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rkeilty@meta.com>, <atish.patra@linux.dev>,
	<dgreid@meta.com>, <riel@surriel.com>, <shakeel.butt@linux.dev>,
	<kernel-team@meta.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20261123162315.1142701-1-usama.arif@linux.dev>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20261123162315.1142701-1-usama.arif@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH8PR12MB999322:EE_
X-MS-Office365-Filtering-Correlation-Id: 354bb124-7761-480f-0100-08df4c805f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|261102123227099003|261021121427099003|261026121527099003|11063799006|56012099006|10067099003|22082099003|18002099003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	J3pT3x6jqGHaRD1DdOQc7mJGdExRDDyM+6W4X/yOachdN8mpwAId2p8cS00fA/8F5ZPF7f/TiXLhcTCO7VqPWSbXq0MiDIneifSjXTfHW8DKnvt9DqCnZjgJCk24iwlJhc4u1atrnGFo2inY1QAM05wbQYwffpDWVy6tC9yBs9OGQY+VxRt/4mDIaiqiQFqB4dPQFgbo7hCh8WtMVmZqp1QQ+7jysHQJKDfhNri6QwQK96CKvyZuWLv0EEULHk3yHHPd3wLVSD3UfAv8lcCb0+DHZirB1ZlPlfvtWVFOjuxhdQiJP/4S4t972c8q/ImqwLh+wtPcnWGmGzeEJPQxYVJhLw8HvXFWk9+y5Asxf01Qi0yGAm0XU7s8Htncaz16bqiMlrCp6r5WVWd8sLs+FE4L9h47dPdshIEDQomQNW5bsCwmkDBT4t6E+1TSZdpnn2qU5f56gGU3es0j6QqaP6VMqNDhg4Lcz1fcXeKtt+K8Bvnb0VYHfMbCFmBrOiVIuycOBbJiG5LO3limJWqDPQEh5f4GowEVHkGgSo6B2Z+JHoPnBvm3nP95TjUmRhgxp2S6Nf8CkUUwL+1rOxLtKRqxe1eiwRnYPJNOi74UZIp4tKT/pfisLQMq7zNnVhpm8VzUCkUgzN9vGjbHmW020K4n3i+QP7gmSNoyWGJJCtAJkGksZe/Ui009mdRU9JnPdOQ0zsgWb8dI9xqBV6dq/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(261102123227099003)(261021121427099003)(261026121527099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R4QaYUdszGPxeGNiyCWKWeb4/7AZiaOahJ7BVoLM9TzvQ2yHTctd0tM4FpfqmX17KRpkVR8pwu5nUg398rj2haKQgREqPyoHnuPL/NDfh0QWjtE/kGsednsWzB+d6YFQGBnWj5Ol2e9s8mL7mDfxA1cOf95RNfBE7y2ygbvxI+/L4u8P4szV1QeWeuBljzUhNg9IDLoJhLMrZkZs/jU8Fyty1+54324I60bDtjTZPbU55CCUuFj9qecG+W+km0ni0G7jfBq1Nj7Qfx+tkXXjbeZmQ7tAjFuMHZ7e4Uzfni7G15CfIDLgzHFn8IaNa4WxR0KCcXIiB8gm7bdA1EStRqZcDeG3e9hnwmyZ0tPXlEpagfHsSvzMkybYHygoB8ofEj4VJeZeqLeNEnRSBSDAoaJ1kxZ0/UtW4CoEDD7R4dZjmTFXOeDNmGvMoUmUCMvo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 12:17:15.1634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 354bb124-7761-480f-0100-08df4c805f88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999322

> For a load that missed the data cache, perf_ibs_parse_ld_st_data()
> reports the miss latency as the sample weight and marks
> PERF_SAMPLE_WEIGHT_TYPE as done, so perf_prepare_sample() leaves the
> field alone. With PERF_SAMPLE_WEIGHT_STRUCT it writes only var1_dw and
> var2_w, but perf_output_sample() copies all 8 bytes of the union into
> the ring buffer. var3_w therefore carries whatever was left in the
> on-stack struct perf_sample_data in perf_ibs_handle_irq().
> 
> CONFIG_INIT_STACK_ALL_ZERO hides this by clearing the struct on entry.
> Without it, every such sample hands 2 bytes of kernel stack to user
> space. "perf mem record" asks for PERF_SAMPLE_WEIGHT_STRUCT on x86, and
> since v6.14 swfilt lets an unprivileged user sample their own tasks with
> IBS.
> 
> Write var3_w as well.
> 
> Fixes: 6b2ae4952ef8 ("perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
