Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022114.outbound.protection.outlook.com [52.101.96.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C148D862;
	Tue, 13 Oct 2026 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916974; cv=fail; b=i2NSEM/7SuxGgANbF9WCP3vg5OP2SwOJhdhjUfdF33kkzR2fOuPV0h3E0VkDoiPxJPD7qdT7y9GmD5wOEcXGIUmN78HGUh8BWYN0Xzsd7YmECLQAJFneiVm/dy18ajsI3aSQUuFC1fNGhk3I0w6o83nrGddJqiUtV6A3ejbglAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916974; c=relaxed/simple;
	bh=hL8PRmZvuNv7/8fhFVrnHH2IuceuykA+lchiImyBuK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SjKnDBwzNSjYVIbQznHd2hKIf7/CqXTttxMlMzzUqPldrobErCpoW8HUzRZlfHg+QdIUuCnKllKIRYgEVZ8GHuOqm3TZWYAsmiqx4weqbDXQJHVkWvc9Rdf/nNht375qmJTW72yKY2k839vSbeHBNSYMdlDHWmGlfErVk1MUGA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKva5EqjSbfEx7N1RS+FwOvqdTwjdGcA0JhHZsgxjcqqoqmkLtjUI4PY2VQi49Gizztp7SwxWc1Hq2dvM7jM0tvkvxy/ZvS2wZNJs671MmY+GhG3gm0MqTuaaHWGg3OBR0h8YCgtTYW7v4XH8NCtLIIaMEN2lVagqz842TGf9cZrQY9eVZOEOynJO7iqG7loxNzVsJQJWKTQMukccOSAQ/JGYsu8TaVG737iGOHc6D/XcLZleqfWUHhD5+Kkvl3YFLxRFGLUqhwn/RhYh1/tVkFGt49Pi+c+7CphR1qblQl2/sJeplFjRndyZvJ2v3laZs01G3rJRfNepR6talDGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=1spwJxz9aHNNMj7nO6eOlYSA/3Iph6sl48CvM7MZOnU=;
 b=ElJ0GbQ+PZUPRyULjnINoFnAXt668POREOE9V7GK0c9Jfk7QOQZgNldYjozhQu1rKSreJ96Omun3ueERZRU/vTLDcor7qKFImR6g4gD5GkrzJ3uWSxNvufV1L/LRVzjLECkXikJBzQDr+ml91Mkjih5P2OQ1tvbrNO2X1xzR4gfv2FDqNE9m5h1PNbsxnn84RQcNS4Lri12chHJDMtemVstkhsAeUJbxpb2VGxQzcNhYz4cff59+uunidW8wUuzYCfpHhJgyNPomelqCW5Pdw2bRfnwDydtDjS4PVGfHlBhiO2WqBWsE3Z3LifBo2jVK3EBkXFaHekIWi02vTqnWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB8803.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 18:42:49 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 18:42:49 +0000
Date: Tue, 13 Oct 2026 14:42:45 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: axboe@kernel.dk, hare@suse.de, sean@ashe.io, tj@kernel.org, 
	neelx@suse.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
Message-ID: <2eslgu6awcn6rltvbafpz54tbreyee7uqupnjiabkce54bqd3z@dz2f5wfg4gkh>
References: <20261012012905.267920-1-atomlin@atomlin.com>
 <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
 <o2hxbjxbkg3wv25lyj3nluwv4e6cb6q5qaukrhjzwg2hodwk5c@wgpc25peito7>
 <asxLLWOQQzolER0a@fedora-laptop>
 <pvnvyzf3cbebpxmobjntvovrruxgnygm7pwgx3tl2jczc7ji5z@ygmd6z4cfxh4>
 <as4j_Zk7zcNsBuo1@fedora-laptop>
 <i4xh6jsm222rtn7pka57fuo3scelrlzywrvq5kor5sy2jjlrmq@tkqbbrzimfrd>
 <as47Mma7pksi_i9C@fedora-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <as47Mma7pksi_i9C@fedora-laptop>
X-ClientProxiedBy: MN2PR18CA0002.namprd18.prod.outlook.com
 (2603:10b6:208:23c::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e5e566-7f01-42c5-038c-08df2959c7ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|10067099003|18002099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8qAIoEYWsmi0isbvK+OCHv8NcX2v2W0KwUbdd40CNES6KODspEGBn9/b0nywC6q4YlzGrsfOCXiCIVJeOD2K9cc/RsaE/6Wn0BsfHmZ5UQB0f9d/TDTedgqSjnfrNeBv1O+dRNR0f+RRA3vJxB/nWzBqbQm5M/DelOftzlZYEEroBwmCMndZgtJfksDaKtE+YOuHdP+g+kiHrusHmD8vACw40hLcIsX6WKgcBPSSQnTQ8g8bW/1vJPijxCf5nVjTcv8JdJIo2rthtoBB04R8RZpRbNfZNJ6lFbdpS1WUNGp7nkpgia3xjJZYaJq/WV5+gg/V+x6+XYKVZc9GwZUWRxuvnjTp/aIZsJhJpUGQHRFLghsRaiUsXiuw6TcDee+ueu4EZKM8spKGOU1pHvVif3GqDjbzxLrqUcddGT/jrpwmH22pCfqiLaKJYKNFILwRAHVHoN7dJeuMhz3qMQOZXxaz70PqN0gghlsF2KiLs9gVk5Q9X+Xm2JiIscihpjG8xFipUcFTEaxGoii2xjUEipd7CYFKXhli/H/OxEL8uYIW40PdpbJuU6Oim6Upex33yf9COvqUNOT9drGZbmJQubY4Mvl5yZFHfKRpNMqXGPj5siJQw2UOP3qfQzxI1FcsfBevRdOs9T15LbjEHKBYtSyk80vVtjbPN2TWTOx6SyE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(10067099003)(18002099003)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFBvWi9PVmVCMUhhd0d0bEc1T1dxeHp3ZXNGQTZuL1VzSXIxaVArdWVldkg1?=
 =?utf-8?B?WU9XL2RCV2p1NmdORjFPK3hzc2ZHK3ZBUU9pdmdYbVlrVFBSMEdEaXVPV01I?=
 =?utf-8?B?c3JNWWxYM3dtOWQ5ZU94SmFrajBES0pHUldwNzdBbHArNUt3Nm02L0JuTVJN?=
 =?utf-8?B?YXdLa3YzYWFBUDZJM2hSYk5LcGhHRERUNU9HcW1pSWtPZDEwNUlmTDNDTlNl?=
 =?utf-8?B?VU95VWsxNkozTXcwL0NDaUFSR3U3VlAwTUd4ZHZZQ0RONXJRWHRic3BKNkc3?=
 =?utf-8?B?Wkx1Z216TURzR2VHZDB0Zjd3ZkFsKy9Lb1FNQUs4T3JreG5hQ0FVZU4rb1I0?=
 =?utf-8?B?cG80RHgydHMvTXgxS2JHQlJIOHB1VUNORzZPSlZVbno2RTlTMC9wdWlBQUcv?=
 =?utf-8?B?aVpKbVRSSWlEa3RqZlNqTTRIL2VudmYrTzUrYzBTK0Z5bzRwVXA4bG5Gc3Nk?=
 =?utf-8?B?TmE4eEdsbXNIM1ZnbndLUk8yV2ltby9NMWpLRDNQWmZZb0N5ZElxVFlnRk9B?=
 =?utf-8?B?UktvZmJmMTRsakcyUFdMYXpJUGFmS1Z0WGlFN3RWT2RiS29KVGprMzF2UTE5?=
 =?utf-8?B?SUNERzhlZ3pzZ012bngzMXJjYzhuTnJVSzB5RytOcmtuUEdMOXd5Y1JVeTR5?=
 =?utf-8?B?ZGQvaDFTNGJOWEJGVWpyUGNRLzBsL2dLOUUvTnZWMGRWTWkwL1ZqZTRyZURl?=
 =?utf-8?B?elp3WXdpM3MyQWhyR2haOWoxaWlJVnVMeWlNNk5yVkVia2M2UG5XM0lGTXAv?=
 =?utf-8?B?YlFoMzVvdXlUY01uMnVGMllaaHBoOXF4bTdUR1J4aDRwOEk3WlY2SGJJSjVD?=
 =?utf-8?B?a0ovWmYwMVVyeXRlQ1dvUUYvYkkzL0lXV0RkQXpoeVJtNldOb1NxcHN6dXZi?=
 =?utf-8?B?NmZzaEpmTFo3V3V4WStzb0E1Y2tDZkJyRjhtcWtndnI0NGdzWmw4b093Tm5o?=
 =?utf-8?B?azRSdVRWM1ZnMk5oRWd5TmE2aFUvR2dteFJSS0VRMVQxckdPa2tWNVZ3elVl?=
 =?utf-8?B?Y05wMnluWlYzNzZRRkp0QVdTY3FWZ0NRMTQyVDdOZURsbTI4dFZmSzhIeEdu?=
 =?utf-8?B?OFczTlJUTWc0bDR5dHg2YTNrbEhpUEFubU1GK0NpSFVGUytZY2J4OVE2SXpy?=
 =?utf-8?B?WXJEZzdNanlZYjBwcjE4MEJPVnNUbXgrNURrME9wbGZoeEs1Um9iQjNVTlhS?=
 =?utf-8?B?ajkra3BydHlkWkgvOWw2S1hKRk9NQTYyNjdLLzd5OTkzK3lkQ1FTd2tYYWlB?=
 =?utf-8?B?N1QyNTFEc2I0OXZkV0FPZElDSlJGWGVESzU5ZlNBTnNnMVVZNCtVdFFVQnJy?=
 =?utf-8?B?SUE4alNiVGh1MTBPMWhaZzBvL3ZJcUlGS0doY3pEL2RkakZ0UXNIcHRyUllO?=
 =?utf-8?B?MXJmRnBHbEVvcVI2SWM2QVdXTjBZRE1Rek90Ym9BRC8vL0psZSswTXRrRWNT?=
 =?utf-8?B?MERScDBNWTVvT1QrdXNCcnNGZ1BnREs3SG5McHFBTWNJZ28zRUNJSWhTdEJw?=
 =?utf-8?B?cEZ2TktPTVlQU0JoNFJ6S3d3MmhJMzFSNndockpOTk9SSkFuNWZicG1aemI4?=
 =?utf-8?B?WkpvbmY2V0VBYjRxTzlQY2dwemQzbHNidW1TV0NaQUN1bzBMcUFDdnlNQmw2?=
 =?utf-8?B?OEtwR1MzSUMycmcrcnVxRUxsQXNDMmxoRVM5d1pFamhLNE9mdEhuenZId3BD?=
 =?utf-8?B?UGhPeDlTVTdMRUN1RTZydDZET0NzM2tzZlJseVlJeXRlREJHZFgzY3AvWm14?=
 =?utf-8?B?SW8vUCt3UzM0L1NnRjYrYjViaUxJcEJWUFhUQWZ0WFBnNGxkWkdTMWhUdVpL?=
 =?utf-8?B?YXhBeW5OU3JQazFRVlFJQzhRR05Sam5tQ3VUMzVzcklMNWtGaGpXZ0Y0TEVQ?=
 =?utf-8?B?SmRCemlkU0srclVlSkR2Mzd1bC93cVZmVnFOM1dDcTNGeGVJdVBRbjRFMkVu?=
 =?utf-8?B?ay9DMjFQQWRrVnFPbzVuRHA3Mm9BSzBZSFBEQ1lvWWJiZUx0ek1pdytCSWFa?=
 =?utf-8?B?TjFLMFBXQ0NRQzdjeWFJV056TGtFY2xCSnMwbGRQaXRDNFRXZTA5ZytSdGJC?=
 =?utf-8?B?ekh6SldUenAwTmlUUURadEp1NUtYMG9haGI5ZWV4bHpPTkMwZ3VXUlFpTE81?=
 =?utf-8?B?aTljWEVXc3A2cEVYdk5ldGJIMjdSZWF6WEZwMGh0MXZkWkhvOG1OaG5BckpQ?=
 =?utf-8?B?dWdGSXd2TVMreEhvektlYWhJOXh5NkIxQmFYZGFQYW4zNy8xb1k1dFNFOFdB?=
 =?utf-8?B?dVJQS2dlNVMzRm55QURGRXY0QW4ySllSOW0yeE1IRDdZZ0pmSS9Ma2I2dDBs?=
 =?utf-8?B?VkJ1T3V5YXZPTkNRV2pJSzF5ZDAzTHZDVkVUTCtramJ0Q1hvOUxxQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e5e566-7f01-42c5-038c-08df2959c7ba
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:42:49.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eb5NZqQL3YfUeb2vfoRCYGN96ADayyjwU0PmcH0RJuKB7LxkskEwY0JBGnOeIVNobZEdFytSIMlUxDKfZRr9Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB8803

On Tue, Oct 13, 2026 at 09:07:46AM -0500, Ming Lei wrote:
> Any user visible effect? Both are a piece of code running on isolated CPU,
> the choice is in application. If they want to run IO on isolated CPU, we
> do it in same way. Otherwise, we won't schedule work on isolated CPU for
> respecting the kernel interface.

That assertion is directly contradicted by how blk-mq is implemented today.
blk-mq already actively shields isolated CPUs from running kworkers even
when I/O is initiated on an isolated CPU.

Consider a multi-queue device where an hctx maps CPU 0 (housekeeping) and
CPU 4 (isolated):

    1.  In blk_mq_map_swqueue(), commit a46c27026da1 explicitly stripped
        isolated CPUs from hctx->cpumask. Thus, hctx->cpumask contains
        solely CPU 0.

    2.  When a thread executing on isolated CPU 4 submits I/O and calls
        blk_mq_run_hw_queue(), blk-mq checks:

           if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
               blk_mq_delay_run_hw_queue(hctx, 0);
               return;
           }

        Because CPU 4 is not in hctx->cpumask, blk-mq refuses inline
        dispatch on CPU 4 and offloads via blk_mq_delay_run_hw_queue().

    3.  blk_mq_delay_run_hw_queue() calls blk_mq_hctx_next_cpu(), which
        iterates over hctx->cpumask and selects CPU 0 (the housekeeping
        CPU).

    4.  kblockd_mod_delayed_work_on() queues the delayed work onto CPU 0.

Therefore, for any hardware queue with at least one housekeeping CPU,
blk-mq already offloads the kworker to a housekeeping CPU, completely
sparing the isolated CPU that initiated the I/O.

The only scenario where this offload breaks down today is when all CPUs
mapped to that hardware queue are isolated (blk_mq_hctx_empty_cpumask(hctx)
is true). In that case, commit a46c27026da1 added:

        /* Switch to unbound if no allowable CPUs in this hctx */
        if (hctx->queue->nr_hw_queues == 1 || blk_mq_hctx_empty_cpumask(hctx))
            return WORK_CPU_UNBOUND;

The comment and intention were unambiguous. However, because
kblockd_workqueue is allocated as WQ_PERCPU, WORK_CPU_UNBOUND inadvertently
resolves to raw_smp_processor_id(), dropping the kworker straight back onto
isolated CPU 4.

Hence, blk-mq's established policy is already to steer kworkers away from
isolated CPUs regardless of where I/O was submitted. This patch merely
ensures that the empty-mask fallback honours that existing contract rather
than accidentally violating it. I will send the next iteration for review.


Kind regards,
-- 
Aaron Tomlin
