Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E0E483BC8;
	Wed, 26 Aug 2026 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779738; cv=fail; b=Zuy+mrccHhdkKxaEubZvDoZOJjzYxQmP8eInstpsFtwcXW63gBXoaBmcAOJdTPe625TUIgAjE1iPXcxshLu7KLgGbrfgGXpmtxNUnHq97tpxqy1l5kHr2C5qqnATmZdcav2n5xshZJFAF4kqSAJfhvir7lGpgmL8p2VxyCz7oLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779738; c=relaxed/simple;
	bh=rDr50ZBocP5SjmZY1+c8PZZdZBFblt93FuVapPl4+YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UavlL3MkKH6i0/J+bo6VLFbXj92fsh4IWzAAQzLUOsYnfediczxAB7XPyPW4coT3uoTdJsx+Rzm5hvgPkJpqhob8pjwEOhNLvOE5bA/1Sdm9uYtpleLlR+NGncBieKDXrLOZrpNKwqjzNW2pUeaK9csPYv3sLRcrkBtkT4F2XdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PYJJbAh/; arc=fail smtp.client-ip=52.101.61.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PYJJbAh/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLGxDzDIiLxjyvZKOKogkS+qC4ZZ6MvGy5DrtRHlguwIi2Unidjl/kT2xRCGAxlsHgVB6XwLirtnzKrR7hslR6HNjfXmUaI/STQEkZmcwRVFNkWkSiuq7meVy85yauDXVJDIIRg2c10LrY1qyTU1WUwTc4Fjwpe8n/0w2v9uaJbne9KW2Fiz1+0Ok/1CxgHc+Oa4rKFrun3xDcJGTdE6SCVspWVA9yxX0K/wNyrRJiVMHeM51bChbM1C/Udl7cK376yAh4v0OEflFw/KFq/0m691TPw0sRAk4VljjRdJ3qyVY71lRJTPSTWNgK7HFo51u0coZ+oLT7QwLsxFGdNWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEDbEQsDJ2eRJ08X1LuCvB+W4qKNird1IlMERU9m46k=;
 b=uvF1lwrje8KRMUAqC5pCRYIppI+zpBSutNO/pJhCRpXcU0frOdMLgwx4Vp+Iqmb4p9u5ZUmTxXyz8bCue5O5bfIgW2Xsf/iQcxIImbjxBlgNpqC/wKWXE4pkOZxiiqX6seKyQH2HC/Rt+j6P19NAzta1875nZdTE22pa+oSHtI6/VxUPDJAVbw4PzkUp+YUTOfhaG697MB2CuwnkCU0mNjVc0HWSSsRjQe3kvzEYoNkizxUXg+375eRJOslsGnV/W/vuB1NVO1RM45pfHc6CZdHl52yxZ1AWg2sb5L7pG+8K6N+GmLR3rcZHbg5KncEfaAeDXN/yDs2EfC++HalktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEDbEQsDJ2eRJ08X1LuCvB+W4qKNird1IlMERU9m46k=;
 b=PYJJbAh/N19tVt99iDPHc8J7rFYgtlni8s+CmQKqQaFk2C516X8yZ+Y6y7wOp0UpxjmYAVtlnHSb33HNKLkem1bbdf7qkPuqEEuqYkr91LEtOpXkCjxyZKcg6DqBlwE5srKdili8doWAk7ydqmRVwSEIzc+CLp1GPxGjtJgakRc=
Received: from DS7PR03CA0348.namprd03.prod.outlook.com (2603:10b6:8:55::8) by
 DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.8; Wed, 26 Aug 2026 21:28:51 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::52) by DS7PR03CA0348.outlook.office365.com
 (2603:10b6:8:55::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 21:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 21:28:51 +0000
Received: from [10.236.182.15] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 16:28:50 -0500
Message-ID: <472850c6-0f05-4444-bc09-bd9f513c8838@amd.com>
Date: Wed, 26 Aug 2026 16:28:49 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/events: Bound the event log drain loop
To: Anisa Su <anisa.su887@gmail.com>, <linux-cxl@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Gregory Price <gourry@gourry.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Anisa Su <anisa.su@samsung.com>,
	<stable@vger.kernel.org>
References: <cover.1787768932.git.anisa.su@samsung.com>
 <20260826184417.1042-1-anisa.su@samsung.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20260826184417.1042-1-anisa.su@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: c80986d8-cbfc-4961-d25c-08df03b90626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|6133799003|22082099003|18002099003|56012099006|5023799004|11063799006|4143699003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	dZldIumYHWpsdr+lWOdEkbWryeMbSD5LL74PQg4q56kEaGTN1DY5qNFNpiNEB1xcRRFY1vVtvsTkP83n80IaUSACwPSS8nM2JbXpv4uPmXFSmkIQ9QZtYD4IO8lhjSyyErzPWIXm9wVPAI56HY1Ni7x17+bS5B/IKSt1tubSEdbMzS4s+mawTSXJpsLVB6a/P/TybJFWyivR+1/6P4HGW/fofS92/S28bljd31fYjv95QbMKCagcyHJGU5v1oEwmSGAPpfnWMcYS9qToYmxz/2sD+Y8L2OW6yak0A4MAfkV4endPKk6IhF08qCnECuLyiL49f0nHTWHYEris0LzIVobxbFSkUixbasbvGC2eNcQw/YHpqNMc5ARd7pyPB7JFZXgQenxKf94n6kOrN5bJ7cy2a6OwG9LIDWFLODv4oq0HFrHrw6iovq+bE3UhLft9bDqd3rn95TUPgtrn3YsgtivHzrfOHDzP5b4IFuyHppEF6/GxyUxCZsKizDdevHkWJ/tUWtNZ8IA//uf9WGjWyKA7S9ygptvCK+CAz65TXLL9tZgNUUeStOiGSgwzHfhPCnmWkXQsGq0taQ+15O1vadZec7h16uUR/ndXwuwuHD82sU02srjbjXw6P1C9e5GmqFbiOSeZUyMVFTzJoRlMEPntn1XAjWHKy73jBZQ5RMEXmH0ELSma1pbOf5CfpmOo48oj1Co9O64328H9gt22uA==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0n2SLMuTWVN1ByT3ff3rgYEqyE9OszLgQLGIGezYH4moF7TQWXkQ10ypKzv3WXBb/2YJDSsV08kD5BwIRJDcMx5AKHFNnPSrDRhDRI9RJGB9yAphRzoGfAG1wBLNRaNNWEKEVcjKNj2cwj6GJtPTn4L5nptWbc/G/NNYLaGneSXcubFFdzw34yCbUxA14Q0o+jlMx6o07BO9lCpXXKc/Q81KobcDaWEfxX/nhgjZEbsQ7L3Myj09+iKD4B/XUN9g2APERk8zP3PVrjlVS9fLfkZJtjflLWXT8sn/5Z7uojbRoW3gam2CJrnYHwLYF573YRryYvgkuQI2H3dpIBRu0bk69y5kbM9Hna8rnNeEa+Y0QoRTsuFPoULkGNYSQ80PftB8lEX+VjfIrRDuy08OhHIejk54M3bST1b3q07DajMdGrIk3ghqKqhrI5SspPBG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 21:28:51.6189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c80986d8-cbfc-4961-d25c-08df03b90626
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419

On 8/26/2026 1:43 PM, Anisa Su wrote:
> cxl_event_thread() drains every log named in the Event Status register and
> repeats until that register reads zero.  CXL 8.2.9.3.1 Table 8-203 marks
> the register RO and leaves clearing it to the device, so a misbehaving device
> that leaves a status bit set spins the thread forever, resending
> Get Event Records as fast as the mailbox completes.
> 
> Bound the loop on work completed instead.  cxl_mem_get_records_log() and
> cxl_mem_get_event_records() report failures and which logs returned
> records; the thread stops on the first error and drops any log whose status
> bit was set while it returned nothing.  Every pass either drains a record
> or clears a bit from the mask, so the loop terminates whatever the device
> reports.  Logs are drained best effort, so a broken one does not suppress
> reporting from the rest.
> 
> Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---

One nit below, but looks good to me regardless so:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>  drivers/cxl/core/mbox.c      | 58 ++++++++++++++++++++++++++++--------
>  drivers/cxl/cxlmem.h         |  3 +-
>  drivers/cxl/pci.c            | 39 +++++++++++++++++++-----
>  tools/testing/cxl/test/mem.c |  4 +--
>  4 files changed, 81 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..5954ba20f0be 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1059,8 +1059,8 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	return rc;
>  }
>  
> -static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> -				    enum cxl_event_log_type type)
> +static int cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> +				   enum cxl_event_log_type type, bool *drained)

Nit: Could this get renamed from "drained" to "got_records"? You use that name below when calling
this function and there's a bit of overloading of the name drained in this call path that makes
it a tad confusing.

Thanks,
Ben
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> @@ -1068,12 +1068,15 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  	struct cxl_get_event_payload *payload;
>  	u8 log_type = type;
>  	u16 nr_rec;
> +	int rc = 0;
> +
> +	*drained = false;
>  
>  	mutex_lock(&mds->event.log_lock);
>  	payload = mds->event.buf;
>  
>  	do {
> -		int rc, i;
> +		int i;
>  		struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
>  			.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
>  			.payload_in = &log_type,
> @@ -1094,6 +1097,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		nr_rec = le16_to_cpu(payload->record_count);
>  		if (!nr_rec)
>  			break;
> +		*drained = true;
>  
>  		for (i = 0; i < nr_rec; i++)
>  			__cxl_event_trace_record(cxlmd, type,
> @@ -1112,31 +1116,59 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  	} while (nr_rec);
>  
>  	mutex_unlock(&mds->event.log_lock);
> +
> +	return rc;
>  }
>  
>  /**
>   * cxl_mem_get_event_records - Get Event Records from the device
>   * @mds: The driver data for the operation
>   * @status: Event Status register value identifying which events are available.
> + * @drained: Optional mask of the logs in @status that returned records.
>   *
>   * Retrieve all event records available on the device, report them as trace
> - * events, and clear them.
> + * events, and clear them.  Every log named in @status is drained even if
> + * another one fails, so that a broken log does not suppress reporting from
> + * the rest.
> + *
> + * Return: 0, or the first error encountered.
>   *
>   * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
>   * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
>   */
> -void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
> +int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
> +			      u32 *drained)
>  {
> +	static const struct {
> +		u32 status;
> +		enum cxl_event_log_type type;
> +	} logs[] = {
> +		{ CXLDEV_EVENT_STATUS_FATAL, CXL_EVENT_TYPE_FATAL },
> +		{ CXLDEV_EVENT_STATUS_FAIL, CXL_EVENT_TYPE_FAIL },
> +		{ CXLDEV_EVENT_STATUS_WARN, CXL_EVENT_TYPE_WARN },
> +		{ CXLDEV_EVENT_STATUS_INFO, CXL_EVENT_TYPE_INFO },
> +	};
> +	int ret = 0;
> +
>  	dev_dbg(mds->cxlds.dev, "Reading event logs: %x\n", status);
>  
> -	if (status & CXLDEV_EVENT_STATUS_FATAL)
> -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FATAL);
> -	if (status & CXLDEV_EVENT_STATUS_FAIL)
> -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FAIL);
> -	if (status & CXLDEV_EVENT_STATUS_WARN)
> -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
> -	if (status & CXLDEV_EVENT_STATUS_INFO)
> -		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
> +	if (drained)
> +		*drained = 0;
> +
> +	for (int i = 0; i < ARRAY_SIZE(logs); i++) {
> +		bool got_records;
> +		int rc;
> +
> +		if (!(status & logs[i].status))
> +			continue;
> +
> +		rc = cxl_mem_get_records_log(mds, logs[i].type, &got_records);
> +		if (got_records && drained)
> +			*drained |= logs[i].status;
> +		ret = ret ?: rc;
> +	}
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ed419d0c59f2..cb5372eb2d85 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -803,7 +803,8 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				  unsigned long *cmds);
> -void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> +int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
> +			      u32 *drained);
>  void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 267c679b0b3c..3daf17835c06 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -514,21 +514,46 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>  	struct cxl_dev_id *dev_id = id;
>  	struct cxl_dev_state *cxlds = dev_id->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	u32 status;
> +	u32 mask = CXLDEV_EVENT_STATUS_ALL;
> +
> +	while (mask) {
> +		u32 status, drained, stuck;
> +		int rc;
>  
> -	do {
>  		/*
>  		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
>  		 * ignore the reserved upper 32 bits
>  		 */
>  		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> -		/* Ignore logs unknown to the driver */
> -		status &= CXLDEV_EVENT_STATUS_ALL;
> +		/* Ignore logs unknown to the driver, and logs given up on */
> +		status &= mask;
>  		if (!status)
>  			break;
> -		cxl_mem_get_event_records(mds, status);
> +
> +		/*
> +		 * A failed drain leaves the log's status bit set, so another
> +		 * pass would resend the same query forever.
> +		 */
> +		rc = cxl_mem_get_event_records(mds, status, &drained);
> +		if (rc)
> +			break;
> +
> +		/*
> +		 * The Event Status register is device owned and read only, so
> +		 * it cannot bound this loop; records read can.  A device that
> +		 * leaves a bit set with an empty log makes no progress, and
> +		 * only the device can clear that state, so stop polling that
> +		 * log rather than spin on it.
> +		 */
> +		stuck = status & ~drained;
> +		if (stuck) {
> +			dev_warn_once(cxlds->dev,
> +				      "Event status %#x set with no records to read\n",
> +				      stuck);
> +			mask &= ~stuck;
> +		}
>  		cond_resched();
> -	} while (status);
> +	}
>  
>  	return IRQ_HANDLED;
>  }
> @@ -682,7 +707,7 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (rc)
>  		return rc;
>  
> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
>  
>  	return 0;
>  }
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index a7da279aa3ef..87e01612cea9 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -372,7 +372,7 @@ static void cxl_mock_event_trigger(struct device *dev)
>  			event_reset_log(log);
>  	}
>  
> -	cxl_mem_get_event_records(mdata->mds, mes->ev_status);
> +	cxl_mem_get_event_records(mdata->mds, mes->ev_status, NULL);
>  }
>  
>  struct cxl_event_record_raw maint_needed = {
> @@ -1805,7 +1805,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		dev_dbg(dev, "No CXL FWCTL setup\n");
>  
> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
>  	cxl_mock_test_feat_init(mdata);
>  
>  	return 0;

