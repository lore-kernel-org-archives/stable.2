Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A963D0C07;
	Tue, 16 Jun 2026 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590889; cv=fail; b=deuoKXpaCEyJ32LIu3u18Y4poiwJu7501O6DeLvVS7BBuQ7irD5JKbr/u6+4t0M4vJpWBeFOsZULXnvlQJ1VDQTi3kLvU8O/xb4gVwrwrQvZaJlL0n2RrqJtn2vvd2+uVHw6vHkCPrKY0JfVTmdK+uIs5zvlTupbe6n/O6HmDGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590889; c=relaxed/simple;
	bh=PadryAYe5IvvuZswPj3rCvIkA/JvLb2HKMdzZLuY6Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cnE1uWjJlPPFFf89lKGDbSHg4jXs+LtpGRdRIBthcUiIhZbzryzHsIKnJKZjL+rBc6zNTIIHMm/Wn/LUl7dLDyPFF+51ocOaARlVQapbWR4Q9TzhQ6U+qEAJ+xM9gA13kKdNMi/jMjxAo+3JKxNLlkOQtfOhtWVwQhtAr1/fGXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QvrJvF7y; arc=fail smtp.client-ip=40.93.195.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QvrJvF7y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRzRVUuDCGNvlrbIUiq8VYL1iBldMJVcwMMbqgILFCP7GZ4nbvay3BT/TW6IdHhPVZ3CZ4FbJd8uf6XvY8+qJdTrMlRQogPFWx84JILn0WyF3ZFZizFLpJGXxfmyLDkQyLbU6livkT4qvsQfFVLiiYpEHNYNmgMuXZhPt0c+0U//q1cUkzxSWi97OcLbmROcCIs708JbNJaq8jHRcylSBffdPkeSWr9XzYrK7VpwkGgqLufyv7KGynH9eCCrQVqqPbkRcBiROzBYRsAqB0G7UAs1svh4nKl4/qLJuC26/xaKRNXHEH92sNIcpoWuTQhwPOfWqJSgu1Eh6r6S2R5ocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cB6P2+tyZTLKtGoy6mgG/qD4+1j9y5ubF2jkRvopps=;
 b=uf8PR+cpwXjDv72mD8Ec52q6/dIoM+LNir0ZiMAu6uwwUm9TYJinE1wA3PXBBiRSXL9Ncm5C3zhNEurflBefgc9lFKqBwpzH1VZuBxLSGx2xE3FV+RHMlI9g4m1yLjFIX8EBR/r4Ekwg/eSeMs70NmyC+B49bAdMQLT9+JfaYi/tELsosfPNYdSRh9+kFWiiB9XOKe147r0bqGhMlA5Jby/keaWpNMMD46LHTblpnQEhfnGQORYzHd/RJsTJScXqeIl/DTdz/ICTKRfKtNGc1Se+/FS/lH4QZC5RIfYVBAO6l296gXqZ5woHhiC6TlSnuI/HLKPBuVVjLAqN8AHg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cB6P2+tyZTLKtGoy6mgG/qD4+1j9y5ubF2jkRvopps=;
 b=QvrJvF7yO0WApNXzzxrUooQb8qSCSw+Cpc1ROmZF3HXKbZW7r2XQctc+eTM5mm0hJYL+sUZGOei7aFzmEgMGAT5iWXOzZzyWpog+EiFtzWvXNVjVbVPTSN3n8kR0VtyGmCZ13w3LWbsIzvApxX6j6FYNGVTIqBUcQSlHtr170xY=
Received: from MW4PR03CA0160.namprd03.prod.outlook.com (2603:10b6:303:8d::15)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:21:24 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::6a) by MW4PR03CA0160.outlook.office365.com
 (2603:10b6:303:8d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 06:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 06:21:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 01:21:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 01:21:22 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 01:21:22 -0500
Message-ID: <be23dd53-78a2-0753-26bb-76b9ef7dbe02@amd.com>
Date: Mon, 15 Jun 2026 23:21:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Use caller client for debug BO sync
Content-Language: en-US
To: Shuvam Pandey <shuvampandey1@gmail.com>, Min Ma <mamin506@gmail.com>,
	"Oded Gabbay" <ogabbay@kernel.org>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <178155468039.81818.12173237984867749651@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <178155468039.81818.12173237984867749651@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: cce13be2-ea2b-4522-2ebf-08decb6f7d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Ci5bvn0TmayUn+ynqyxiXG9Us4DAGcr7OC2A32U8rbFQDWOG0MbpW8VFgDVptTz/vHWoMuJ3idAt2FrIQwpPaBYIONVS56PRvXKdhDtQP5uJxGqawG2cbYdtcEfaXiUt3N+NhhrIrilZpRUDSwN0ZYA8sMZGrdixv+1nRSuAGgooh/BuFoMZmUs5bwoGGVFP7af75zcxB5+T/C7Bmk6tA/OHyZqYH5bvsN7e8oTRuaELgPUvmg8gubI0lIIvbsigIie/vq46AGLw7NM7zNY2JPyAQp3fE8/r1NiCgxwu/lin44t6lKuae1Gv94yNmGHt/1cyTE/mgtLxQgFgg6m3EKjOBQXpKTBdUhNfpFE6Njx4GXAvUtlRdaf84GIiyQZHV+lDXc3X5sHnAQcN04ZbQOwFaK+K+gRz0jON+aKFof6x9T8KAsF0fHyflq48tvjTTYMq1aWdAT9UR9O/TDjgaf+hz+TucI1QAhV8tWiLW3+Ho6AkubYLNNh+C8oJwikKE24hEkVG9GgQATF8pXmWXlpBvUSSOOwpfklu/SF57JLK6a4m4jdjFi1M8vWkIqmRFKNPCArZLMVQqLOkjtl7bNK9JdRNAnQ3k392uwubUIfNDB4dT7Ruj09rYAw6Q5V9BJW/JE9IgHNPi0XBhSwLQdtGtW0ufNH54bRy85WSwcXNrATinkUqY2HTFN/0iIPb9wVkJWiTVi5srXvnVVxFVE6LlG56jPJW5i8b8tZzKZo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T92CPbzbncDncsQjjsufw+TbbC+mu7zsTs5e5lFewKpJx9ERgKBn9+oKpubntxEUidqiaZ1JbHGRcImm9ti+L37AJNkEdWu2cQZlMUxZMg4E5hSXUFXUQW7SAHNusnIvmHLweoMzIFLs+E0/4EQGnoASuLoksXcDiYjPz8bE2eWfy2ZKwdhaR1wO/rLYXqzH+jrmds3UIB96VmkJgvwg1IaEIb85NIgEv1kgjQYL5RQfLUp6Tvvai86FCsPCdAeM3FnI8WWfZkIXDbsvZsIuLz1weFOLaouIFHpc7velsAKUuQ8IBQ8jV+stKLEMaSvMCdaPxB1RsZxcLeRhGTVAE5F3Q77Zh2TD0YlgYuyxBriduryFnoKGXRTugkcKQ0duY67r9Bu/xMHq+12o3ZraZw5M0I9KFyKVAs2y3TWWs2Ml706CHvYLCLI9Pap8w22u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:21:23.6638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce13be2-ea2b-4522-2ebf-08decb6f7d54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234


On 6/15/26 13:18, Shuvam Pandey wrote:
> amdxdna_drm_sync_bo_ioctl() looks up args->handle in the ioctl caller's
> drm_file. For SYNC_DIRECT_FROM_DEVICE, it then calls
> amdxdna_hwctx_sync_debug_bo(), but passes abo->client.
>
> amdxdna_hwctx_sync_debug_bo() uses the passed client both as the handle
> namespace for debug_bo_hdl and as the owner of the hardware context xarray.
> Those must match the file that supplied args->handle. The BO's stored
> client pointer is object state, not the ioctl context.
>
> Pass filp->driver_priv instead, matching the original handle lookup.
>
> Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
> Cc: stable@vger.kernel.org # v6.19+
> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 3 ++-
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 6e367ddb9e1becb8d03cb4badec25deed38a851d..6c16b21994abc8f0ce58ee6dede219a84ade6825 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1027,6 +1027,7 @@ int amdxdna_drm_get_bo_info_ioctl(struct drm_device *dev, void *data, struct drm
>   int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>   			      void *data, struct drm_file *filp)
>   {
> +	struct amdxdna_client *client = filp->driver_priv;
>   	struct amdxdna_dev *xdna = to_xdna_dev(dev);
>   	struct amdxdna_drm_sync_bo *args = data;
>   	struct amdxdna_gem_obj *abo;
> @@ -1061,7 +1062,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
>   		 args->handle, args->offset, args->size);
>   
>   	if (args->direction == SYNC_DIRECT_FROM_DEVICE)
> -		ret = amdxdna_hwctx_sync_debug_bo(abo->client, args->handle);
> +		ret = amdxdna_hwctx_sync_debug_bo(client, args->handle);
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   
>   put_obj:
>   	drm_gem_object_put(gobj);
