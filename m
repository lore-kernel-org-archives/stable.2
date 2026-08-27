Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010024.outbound.protection.outlook.com [40.93.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722D1A3172;
	Thu, 27 Aug 2026 03:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787799690; cv=fail; b=fSr7sHS8dcEWpmJvwpOA8nK+ww0MOXNzBaiVdf2EaZJy+zi8J7ko+hTukU1fnve/8qMrB5hllIR8Y+1c3RVhMbEQ3A6K7U8mcBGgSCcE2VT1OKT/699OESKqeQcYzzNonYm14K2VHcihE9NVGjcOVNxO9qLwcpu315bm/hkm3/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787799690; c=relaxed/simple;
	bh=i/nouQuNZfL/RW9cK8mv/B54hU/Vx+G2CqaLeSYRrrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bNNmjxBogO8v4Q0BvYWXIfdBiUeIiBDPR6RmwnzpI2g8/Z0s2k2NvVyjcSMK4vDUbqy64C4z6/GZkQgdlUt33xTCww/UfkMP+y0AS7VlKfng3k+7/1Tv/8+ktLtlGHr96twnGhTo5kafHLzDEpI8GeGBxVO9Uz6F/NsyVRlyH68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f6GI9Q11; arc=fail smtp.client-ip=40.93.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f6GI9Q11"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEG1KcesolbqDPAh0g9OLujzqwYJWHQEfZyB9MM2clnp7dDOMdU5kOOVxJcR0tJCysa9n+Docv455t6tnhiNhjLJHMoiMFmZcmLA6eJyPL2G9vNGU6/2lRofAJ49Pv9O6Z7ui/ZQvDSyX2l6suM4Bqfq1om01/HeP9zDRD8Y+02lpAymi5fqv5P/n4lu0rdYfBoCSB2XVaPaExkwmCNsqOB7VsRKz5tYVzWA1WigbhkZYsi3cDOvHkQ6O7a1Z0zk/zzw4bZyZ5fvDgJHa+J68Mu5CInkwFRcoXDTpwYUF3OUiw+aMbsF1m+hUQEMdl+f4he6UeApp4l/0NxmLtQU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3ZZUkmK04DKjFoIgqEAIGSuSWtEY5RORdDek5yqRdA=;
 b=yFsDAtPKrGQzBwdCqe4qSxPbzYFHcyQqGvUUPQ7zqCYcZ5PmDZ4hR6CkMVgXnBc6Oj1jvhiTrSQcbOMneBn5oWq5iV0p8NVaR3GmX5V6g/+l8cyPmNmuhj170P7n7TuU5yiGWKEHsGGg+4x3tWR1cEXqV6KUR9HQqYmBCzoPDmRjPTPmwSzQbRLggHe/M7RxCJFGgeZAWHtrqbgJbM7jyHggypTlcEnT5piq9ARQhI6HqSM3v5LBDs9K5oroF+x5VnLeELvnqrOTFozsLiaJhaOTch/Z5JRKMCo6QuCRCn2Oyvxx1n3woBCWPFowcVYfX5kh8nJE7te1SXCD4b0bGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3ZZUkmK04DKjFoIgqEAIGSuSWtEY5RORdDek5yqRdA=;
 b=f6GI9Q110G54BB1SV4rbQh0D5tPzWngLe+MDtf4x5kyzSe/kHxOz3ls1NOK2XVJHaUbmP6jXS93pf2CrAXInGxqKCfOQBzjzo1oC9XxKYgVTS7UXJgAneACxeuME8lrWAbtDxKHBg4El2KS6qbH7jofKfUHNPUE+Mor/faXd8UnmIAfpPIYseJokUuPgJPb3oAohYns/d1DgP9vc0DTrP8qGW5Jks5N2QGq2bXGC+59Ani1JAET41wXCoLMmdktICAO2iArlJmn5lgsvy7bds5omixjt30zUM/ZXHd5i9zPvhnHLlE1Od7/F9v5gX9EBKWHtgmmO24Q/GMKeGWO4Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 03:01:23 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Thu, 27 Aug 2026
 03:01:22 +0000
Date: Thu, 27 Aug 2026 11:01:15 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Gregory Price <gourry@gourry.net>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Anisa Su <anisa.su@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/events: Bound the event log drain loop
Message-ID: <ao-m-aFBvwCn4sus@MWDK4CY14F>
References: <cover.1787768932.git.anisa.su@samsung.com>
 <20260826184417.1042-1-anisa.su@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826184417.1042-1-anisa.su@samsung.com>
X-ClientProxiedBy: JH0PR01CA0108.apcprd01.prod.exchangelabs.com
 (2603:1096:990:59::11) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 732940e5-bc1c-4bfe-35ab-08df03e77928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|6133799003|3023799007|56012099006|10067099003|4143699003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	F3hs+cpoSMPQCywCetNxt24T7hWr8BridGOIhb3mXzQ7rmGxtE7tOqi62E2CYD9eA4rVkqYVGIcUt6LKDqdZacfR5hRFuk4hmkyF7IBNjk454jeqUumWzE0LYjsSzUamLLZHp4Hcsrtfzl8EdcPn2Qn/35Ezh776Z10sJM7pz5F3wQOwhOs/UHZjAM66zTzZ+72jvw2w/WIL6Hc5+GI0j2N7pl4ZOugJJIqcYxf4g2TH9rpVmSSteDp5pZzL1WSWdHbQ5FZEDh6RjPnn/AagfOlRcHeU0BmltaU1YATaE8Wz/vk3TRx2de/VCnm0B/dczQLu+0rVEw91u4OItLA9dOmbJtGe4zSf5rh6WqjSjrxekpNrYaMbqyOu3Ubw2fo73LPUKVZFCd7ertalLEYxrMyraSP9q27pZh9bmC4NyU+Idw6BMZnyJ8Nhj1nql5dv3gvxUmjYTkx4cBqkwCMk6vj5VEg3hxfhc6UhacPAd8wJEKM7RGAM/RTVqCMV9+yhawazf9VAr7WjMfDLLe1Vg1VVCUsPNhD0qM60Tf0AHJc3hMao/K9kaccB0lCCVaLtUfJT5IzQW2/KdpabyL82nNtAC0yMpFPD7jxrQ+nAd4TQFEKZDaUa1erS53nLi+B2c1LPGRR2X6515B3eshVtknI9n7wWba47CWGEHe/LIxI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(6133799003)(3023799007)(56012099006)(10067099003)(4143699003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ENhNs1U36xVYlFNmxSVCnsYM36eeOmXn9Jov7fu1FdkdLKwP1fDgPb9g0HS?=
 =?us-ascii?Q?ebjymg5GcjhE9sq78BrZeW3x5OeH7sRX2VA0Ss4CdKAyJ/esupbvwtRo36cR?=
 =?us-ascii?Q?CrsmLes+4TrWN58vZ7GYT/UCzxOpNPmrejTNJ4PUb8oXcXzpILJKo89hiB2F?=
 =?us-ascii?Q?kjFCnU7bv4cucGCvQd0PX7G5h3ENdKQusVf+QdjJ1pkC/E5Be6+S9AKcyP+T?=
 =?us-ascii?Q?teIVk7rvdi0xGdryWb3UacKrmqqrxWm+RTLojp8U/Egy03785gqYr17ENBZG?=
 =?us-ascii?Q?7RV6tYNs/bmQTdVHvXPJjv/FBQN95sbsbyFv3nxjuST/8PKXlCHQWjyn5ivx?=
 =?us-ascii?Q?Hdrj2/euUqaXQJMr/30qZMU3nIuNCOQJZvveaUSJffWkNkhjj83WMbcqEYYW?=
 =?us-ascii?Q?oROb2aBwnTIOL5a1w5D3zumyYAJ9ZEwqrxT6bHihctXSI3CpO3wtbWJ3drm8?=
 =?us-ascii?Q?SuKBDJIHbknGWcOHdSczOY6pv3cLKSIXGq9x/8N1Fp/7BzBV12B4y1mGoxQI?=
 =?us-ascii?Q?cf8cJcga2zUVzYhLkEHJKcl0haoEHolZ52Kf6yTMux7vh42/0oKwPEgcURTv?=
 =?us-ascii?Q?50x7qKZcvlKQawxjBX9igBpA7+xXp4KIdRcWZGVEFEqGB4tsG9qPlNJnMtmQ?=
 =?us-ascii?Q?2mALRuauLyNQvUHaUU/gH3LslGu/ohEoTR++vXd7MGoewXwkgaBHlnQ2ToVn?=
 =?us-ascii?Q?bIoFBmsrh332diRjzxQUBvZxnOZQ/Y7aMRrewYb+qdqOU74qC3qnQCCLiWeS?=
 =?us-ascii?Q?NUxvqchdAJArfQ+jEHFUHKChwn+RrHBjlUiTE6hLWqc836j7hsY4i43Ypjuz?=
 =?us-ascii?Q?ufitpMBtkT46/UAYnFCR/BfFC9uOYAOdSipbSGs/SP6bdmZhwekI8pps5PdP?=
 =?us-ascii?Q?rxgHtA1PBOppa485W8K8iQJPe+36TlXZWQ1P4JeaB86SK6PxNIB5habh/yYT?=
 =?us-ascii?Q?7RVssgz3CGs2eqiYaSxSuvMcEMpzkDZtqZVNKm6Gw/TKEtEpYuUImsdG44B0?=
 =?us-ascii?Q?o+6w7FliB3onj6EVcCTc81XbEV5BpX51aAPV2GNj1Wd4/8e4OV98xG3EzJHf?=
 =?us-ascii?Q?i0UEAuOgk4q6MpdzFZeH5cXdgT35v/iLt50YdM1vjIHqhusnHejL+Olowpg3?=
 =?us-ascii?Q?CE2qhjYEXDKsgErJsqQevtDJz0ixw3Abb35Y0G8nxo/auSlgT3veVCr3n/xH?=
 =?us-ascii?Q?GJ6tuzVQD1ojDN/5pjgCHPJ7bNk+ulbCyEmKArv//4zhVEU0Rma9fcYVAhgI?=
 =?us-ascii?Q?F3rJ50vAxmHn0igdLIqZzMkFxGyjoDz7p8bb6fhQPHkK+xNd76m3T0wEmBdV?=
 =?us-ascii?Q?hLIgtBJIf9nEKNSvRNm3ocoNLt+WhYeNW235U5aDKdRiU2ACljrRV06bGHAX?=
 =?us-ascii?Q?LtKg+P0QN8p6e+q+cPGzUnSNdE/60IJg4x/ue7uNwDlFRfY2lbfXphIYnG04?=
 =?us-ascii?Q?7SldDLWKbSlzFChymbIFfedD60iujGzfEreCpmfmoOFV8z9P4h3jrDSGaHXL?=
 =?us-ascii?Q?PQDXAuQ8DQ2wfM1Av1FGwE/EmK1aNTVg+r8vqMrO/VelI10amZS3JW3j2jYC?=
 =?us-ascii?Q?TRAULfGvhllgGLru2hAdQHzWfY3gpsQK72yJZqDGiEy18GB3+Yxq07v9JR8F?=
 =?us-ascii?Q?uj213vWFhY0TsJecHWcaruFb8qPPZzv5loST86M+sW9r0SH9RgDKN1kg3AFf?=
 =?us-ascii?Q?aFcVAVwpInwVdPl6Ctv3kKfc3WJlXYf8tZTSfR0snA++HdTUbnF0T9Go+Nb1?=
 =?us-ascii?Q?p0y1+lXKPQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732940e5-bc1c-4bfe-35ab-08df03e77928
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 03:01:22.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLYas26gW51mznBapbXni6S9OgtnaG3DFboBSmGBqJu8WSZHgg5ru+n3Sofof/FtOniCDO5WzVy2DZkvDqTOIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489

On Wed, Aug 26, 2026 at 11:43:08AM +0800, Anisa Su wrote:
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

Hi Anisa,

IMHO, this new error path might leave an event log permanently undrainted.

Now cxl_event_thread() breaks on any error returned by cxl_mem_get_event_records(), which incldues a temporary failure e.g. "Retry Required" from Get Event
Records or Clear Event Records. In that case the log ramain non-empty.

CXL event interrupt are generated when a log transitions from empty to non-empty,
so after returning from the handler there may be no subsequent interrupt
to retry the drain.

Maybe we can use a bounded retry for retryable failure ? or schedule deferred
retry work before returning ?

Best regards,
Richard Cheng.

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
> -- 
> 2.43.0
> 
> 
