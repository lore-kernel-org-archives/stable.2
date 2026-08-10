Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD925DB0D;
	Mon, 10 Aug 2026 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786382908; cv=fail; b=mQYupL2/G7Qs+tFlUzWtV4vbe8Ip4jzYI5YV1nKmhURg+5rdHvpRwWU5uVvtYkdpMFk0DnRdYjgDgboSgVkCYDd4VHpE1GvTOrQ1eXLOxfJrBNz0AbDzqXnS3LtmzhFaFucNprB4AYSoGRtUuVvzzw3e8iKRmtg+6+1pVAHSIPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786382908; c=relaxed/simple;
	bh=GaB/de+0h4cnv21mhFnxAkiabYN8GBpMk3JLv7ACr+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XHjO4nbpOUbqEqHWIWJM6KTXkGnOa8OF7DZ4MjAdc/+2uuqsMqLNYSrBGUaI9wih+lfGMRR0FWFHJsXA03N5KWdCiOpa2BYGMkzAJ6uPzhyDfRgea975UyuehMx+WavAN6EwiHG1D6sveOPdXGKWe+3qnXSvshAyb1fwgWZ0kMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FBHlM6lI; arc=fail smtp.client-ip=40.93.195.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FBHlM6lI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhAr6CRqdE2ZxqWkCNZ0OfXD0Z9w2acF1SJWtYPnG8GCI/HBqvesPq0Cuna1VE5bYVEfqz447KasoPmFqY+SaqbLzFrUGZ6ub2oOhyYkbu8OFxcrugUn4tCJRn3c3AOL8htGBm4gPMTuFx496JbLMY0WU3pxvlLCBb4iSu8N+7nkmAqwtMQXjv9yfPNCsOsUW7EvkUrEL6k2zKCiH3JQea6buKonP5Q5ppNMb/5CGWMNtBLlI/YMebKp7jrejoB1t7IvAo/JIUtzZNbXEdheFaPqIIdcVekYKz5gsHUy1/EEWBO6hQnRwd3bd5cLVGezDgWBuLjL267hnKSFT4tMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdEIL05RpG1QSjwM+t3NhRwau9Zy6k9ppnYl/LjkV80=;
 b=GMm29tehxnsQg2k+IXYe08/AKhnNzJiwO9UrNF3QUvxkAoZ1SzAEkmtCxS28keL8v5vqR1lyspzLY4xvW7CWAa+okeJlyyLdYQ4O2fNB8f1sc3aD5rVSs1dp588Zpb8sy3WsIbCEFHj5Ptom+qd1Uge6xPuJIjydsB/JVfGvS9p528X9RyVsLyUcKXKWIZew5rg7S8H+SmsF3IbN6g7C8KjkpLDri3WpRl64L5l5185OuVasr5/q3kdzrZ9LlSSpY0OCCSn177fZSpz9aWNHTduOLBQVMkZty0y51DOEc1otnWlrGAto00gD2UT2Op4GykqwCZ7/CE+rB46li8VOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdEIL05RpG1QSjwM+t3NhRwau9Zy6k9ppnYl/LjkV80=;
 b=FBHlM6lIf12ND5DcLUwYyFsmxtu/UHHp1qnLk7i1wiyMqDc88/tVKyM6P6wTQutZwchgHwoyWCTi9iK1rtjEURm7mtds7e0F3mkGFAfaL1D7Cl8POlcbDoz60CJPxZ/ss2EuvPWL4JrXTCE47PIdgF0yql624KiFKAZeF4egBMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 17:28:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 17:28:22 +0000
Message-ID: <01a00d60-a3ae-44cf-a963-6baccdac32f1@amd.com>
Date: Mon, 10 Aug 2026 19:28:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amdgpu/userq: bound the eviction fence rearm
 retry loop
To: moonafterrain@outlook.com, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Junwei Zhang <Jerry.Zhang@amd.com>,
 =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Arvind Yadav <arvind.yadav@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, Leo Liu <leo.liu@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
References: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
 <20260811-amdgpu-fixes-v1-3-4954a417b8ff@outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260811-amdgpu-fixes-v1-3-4954a417b8ff@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 366f6da5-2ead-4190-c02c-08def704c734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|921020|22082099003|18002099003|56012099006|10067099003|5023799004|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4caNLgYbVBNiHmiaZ+00uqRrn/oqELW2Fh1TJCFtwVbVj8XM1DB1z+T3UfCz4gfR7FkyZ8edbhAahRrFwLwwzPLuEzafh2SzYZbGJn4MVUGL58cUGvWSq1UPSdYTetox4d6LqDYyj8QHOEl62+9jpAPntttiSBNjVFrIQ3UHryuH57Oq6tlflxgMWUP0N0s10Xtei6YcYeYgHYbaARLWWgB83kL3tugMucxy/DATOu06uuH7Z0MUKVstA7Js1a+oQY8GXNk1hg9IVvHo4T3iOCz9GzwgNBkqllge/WlMG22h3CP2tQV+QAuzGk6D0L0eXI76mDLouh5fy7UoNvgIx3zFqeNvM7/2AA4Vazdps2nh3/LcNSDu7ytE3WEpMgs7W4rlndqAjVIXkfhLo3ovasTUkujSIew5K9anPUzlhmJH/O+XRi4Yagp6tTnk3Zv3xJgfzZ1bqt1A9POLWBnFIJaWPqJxJCTFqfoyXNaM35SwDpN76Xf3ntfq8471gKuDLmqnJSaG8DuVHzZC2NGBdJugwSq+qBwW+4nSlAQ+dKQX1i7lKa0hAJT1SZ8QnXiu56PI1HFW0tuu0u4vv62jO1r/dFbhS+5vUu+vEdF1WnMLOaHqg27E/M+G+lAz4JZFIqb12TpGHsjLNcPxemNXs+5ZNMOSuk7Q586iBLJte0ofe04iWd6itotOm0Jgqj2/SVYGpwXRaWBooBPcRcu0VA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHBjVlRsbEVndHRZaWk2TW9TUDRaZUVMU2NIdDBySHhGeU8wWFRTVFhYNW9Z?=
 =?utf-8?B?WnJCSGhxekZNMlJkUUtOdDlsM1V0dHFnT1djb3FQcmdWY1kwMkVjNnpKMWNi?=
 =?utf-8?B?U2ZZN1FVZ1dkazdIc2JhQVdVYmVCMnhuZFMvSWlHWGcyNjhkRHRSaUVvSncz?=
 =?utf-8?B?Q1BLWnBTZjF3TXpxVU5YdHBrZm54T1plZVRRL3lEQmhYT2ZEQ3k1VC9YSFpn?=
 =?utf-8?B?NHBWbXF1UEUzS0NudEhrWXRTOWpyaWp5akRrYUJSMW53QVlTcUVGSjhSL0JK?=
 =?utf-8?B?V3pLeFhvQVFyZXd0M0p3ZkpweSt5TWN0N3AzcHVPdTlMNUtDNWxFRHh5K2hL?=
 =?utf-8?B?Wk9jQkpyY1NCaEZKNUVLd0pmYWNzUTNSYy9xWXZ4S29TTHlNK3JHaExTdDZE?=
 =?utf-8?B?VER1Z005WHo4RDNnZWE4WFV3L0hGd2FTNDFnQnhsYW5BVDFKN29uNG4xYlVC?=
 =?utf-8?B?OS9IU3RsQVN1MEY5c2N5blB3Qkl5SExnaUpMVzRoMUZmK0E4UlFLbEcwOFVE?=
 =?utf-8?B?UWNYMkNORm0vREltQ3NBeVI4V0dFeGgzNEx2dytibWU1NWg0cHRMT05vOHAw?=
 =?utf-8?B?dWt5UTdWbi8zbUFqK0hSNW9wbmtzekFXbTloalo4azF4ZTlRdTJaQ3VsM2V3?=
 =?utf-8?B?YWtiTkFpOFNGdVI3UmdEd05PUGlZSHJkYUJ5dk41VUR6SHFlSGM0b2JtRDlv?=
 =?utf-8?B?SGVnOGlxdnBUU0lqcHBmdkM0aG05aWI3aEovUVNMNHJrZDg2SFI2NXBrNjZM?=
 =?utf-8?B?WVJ6eWxZTTkvbllRaGdmNURkdVBLeTV2cWJxN2o3ZWpHeFlaR0FyQndmMUJr?=
 =?utf-8?B?V2hPdEh1L2JDSjQxU1piUTI0YWlCMU1jb21naTFEdXdVc1F6WTlCNDVGMFR1?=
 =?utf-8?B?d20vOUc2SkVFYkt5OXBsNE9pdlZ5ZEpzTWgrUVlXYUtwUWUzaS9ZdUJNQ1B4?=
 =?utf-8?B?TGpwK2dnTUdOb25lYUVhL25mdDFLQWxRY2FCSnByZWtkZ01EaFh2cHJTU3E4?=
 =?utf-8?B?b1hOWUNFSzN5NHJyMVllY2lEQXB2dWk5N3ZJd25wZzZFNExVZlJwcHA4dEFu?=
 =?utf-8?B?VlpieXZjeFZaaWVYSlovbTV5SzVpaFgyYzNpbFhVS2phWlNQTlRRUDlicmVD?=
 =?utf-8?B?K3hHRk1IYVhYTzlHOFY5MHhxbnh5ZlMrYnF2NFZnYlBZdWN4NWxZa3dVZ0Na?=
 =?utf-8?B?ZlFMZERUOWk5SHhOUDBPTFF5NHpPZ01BOHl0WFVLZDFJL09LamNlL1pNZnFV?=
 =?utf-8?B?YjQrdWhBTDJQRjRrdVhYUWNlemh1QlBjNS8zSmVGanh6UXhGTFVVR3ZlUHdv?=
 =?utf-8?B?UWdOZzVFd3c5Tk5FM3RUUThUV0Vva0JabW1sdm1RYzhVZnRUK3hnSlcvMTVr?=
 =?utf-8?B?NFF3SWdURmR2RmNISU5Jdkd5dHlHMTU5aFJFRzNERTA3c1RML3M0Vk5Qektk?=
 =?utf-8?B?R0pxZmhQVG1kdmRsRWFCZytnL2EvVEd2VnZCak9YWmZQazRvQnpCYmNpeDho?=
 =?utf-8?B?bzZqUnl4NUF2OENzdmU0c2dSNUQ4ckNiTkhYZTJoOXl4dWt2cDFMMitJem96?=
 =?utf-8?B?SHR4Z3AwT3JhV3k0ZEY2QkluaFFITGc0T1RjZVpiWjBuMWNzN1hWSjV0VjFx?=
 =?utf-8?B?N0IvMDlYSWxwUFl2bEpJeVpTeE5yVnEvTjVrZFlBYnlBWHhKR3I2aFZpeUV1?=
 =?utf-8?B?MXFWSEZZZEhLclRkWEtQUkZoRU42aHd6UE5oSmNucFRQdzVzR1lFNGMrTTN2?=
 =?utf-8?B?VFBQVjNwMU1Qb0FoVmROeDQ0bEF5TU5vbmVhaTFncTVYS2hvK2MrVzNOUWxt?=
 =?utf-8?B?SmZRL1diVlpTMUZXL1ZoWlJSZTd5Q3o4NzdESll5TEpmS05kaHZDQ1BSYkVa?=
 =?utf-8?B?akFaeEdwaDhzZDVneVZEVVlZZmZsR3hQeC9kMFJaalNaVWNpWGgzUTY4SURN?=
 =?utf-8?B?Q2QxZ3NSc04xanI5S3RkYzBxZnJVbC9wbUgwVGVxWTBPSGM0cDdsKy9aYWpD?=
 =?utf-8?B?UzJSODlESHhLODlmdzh4ZWhSTHRmekRSeGZ4THhsaDVWakN0dnM1a1lXSkxF?=
 =?utf-8?B?M2ZhZThENFBqKy9WTXJUbWtOT05oTEtGdUdCMThkMERZWDdkdFN6ZFVJVHh2?=
 =?utf-8?B?ZE9EWDZ6bjZ2dHJiRjdvenFGWTVjcEFnS0kvMmNiS3EvMnZpaGxXTEc3aUdt?=
 =?utf-8?B?NUxnK2gvK3Blek05MnBzU0tYMWNvN3QvSHZJN1V2MEF5RnpSTzgwNXAvZmVm?=
 =?utf-8?B?Vk84V05aZnE2UGk2VmV2S05QTG5NM2RRSDdqRFlCQkNWTjNMaUdoZnhLblM1?=
 =?utf-8?Q?qJtdO7fWEOiUg3K+04?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366f6da5-2ead-4190-c02c-08def704c734
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 17:28:22.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hl9t4+t3QUv1shlipj6eH1/mNOmbST8XL3uXsTqHHSW9pdJJZtEjYF5A0Chud0l6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464

On 8/10/26 18:13, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> amdgpu_userq_ensure_ev_fence() loops until the eviction fence is both
> present and unsignaled.  The only producer of such a fence is
> amdgpu_evf_mgr_rearm(), which runs as the very last step of
> amdgpu_userq_vm_validate().  Every failure point ahead of it - the
> kzalloc() in the rearm itself, amdgpu_hmm_range_alloc(), the
> ttm_bo_validate() calls, the GART binding of the wptr BOs - makes
> amdgpu_userq_restore_worker() give up with only a drm_file_err().
> Nothing propagates that back, so the waiting thread reschedules the
> worker and flushes it again, forever.
> 
> Both flush_delayed_work() and mutex_lock() sleep in
> TASK_UNINTERRUPTIBLE, so the looping task cannot be killed and the OOM
> killer cannot reclaim it. An unprivileged render node client
> reaches this from both AMDGPU_USERQ and AMDGPU_USERQ_SIGNAL.
> 
> The eviction fence sequence number is already bumped by every
> successful rearm, so use it as the loop's progress condition: if a
> completed flush of the restore worker did not move it then no rearm
> happened and retrying cannot help.  Return -ENOMEM in that case and
> let both callers report it to userspace.
> 
> Fixes: a242a3e4b5be ("drm/amdgpu: simplify eviction fence suspend/resume")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Absolutely clear NAK!

This functions needs to loop forever should the rearm worker fails to re-arm the fence.

The only thing which could potentially get out of that is to kill the process or maybe that the eviction fence is signaled with an error.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 21 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h       |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 10 +++++++++-
>  3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index bec107216811..208b53ae5bd1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -448,12 +448,16 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>   * Ensures that a valid and not yet signaled eviction fence is attached to the
>   * usermode queue before any queue operations proceed. If it is signalled, then
>   * rearm a new eviction fence.
> + *
> + * Returns 0 with @uq_mgr->userq_mutex held, or -ENOMEM with the mutex released
> + * when the restore worker could not rearm the fence.
>   */
> -void
> +int
>  amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>  			     struct amdgpu_eviction_fence_mgr *evf_mgr)
>  {
>  	struct dma_fence *ev_fence;
> +	int seq, prev_seq = -1;
>  
>  retry:
>  	/* Flush any pending resume work to create ev_fence */
> @@ -463,7 +467,16 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>  	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>  	if (dma_fence_is_signaled(ev_fence)) {
>  		dma_fence_put(ev_fence);
> +		seq = atomic_read(&evf_mgr->ev_fence_seq);
>  		mutex_unlock(&uq_mgr->userq_mutex);
> +		/*
> +		 * The sequence number is only bumped by a successful rearm, so
> +		 * if the flush above ran the worker without moving it then the
> +		 * restore failed and looping again would never terminate.
> +		 */
> +		if (seq == prev_seq)
> +			return -ENOMEM;
> +		prev_seq = seq;
>  		/*
>  		 * Looks like there was no pending resume work,
>  		 * add one now to create a valid eviction fence
> @@ -472,6 +485,8 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>  		goto retry;
>  	}
>  	dma_fence_put(ev_fence);
> +
> +	return 0;
>  }
>  
>  
> @@ -747,7 +762,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	if (r)
>  		goto clean_mqd;
>  
> -	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> +	r = amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> +	if (r)
> +		goto erase_doorbell;
>  
>  	/* don't map the queue if scheduling is halted */
>  	if (!adev->userq_halt_for_enforce_isolation ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 6412a7f7b6ef..c35909bf7ceb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -164,8 +164,8 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>  
>  void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
>  
> -void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
> -				  struct amdgpu_eviction_fence_mgr *evf_mgr);
> +int amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
> +				 struct amdgpu_eviction_fence_mgr *evf_mgr);
>  
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev);
>  bool amdgpu_userq_enabled(struct drm_device *dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 7e80442ec3e5..1c287ce59736 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -523,7 +523,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  		goto put_queue;
>  
>  	/* We are here means UQ is active, make sure the eviction fence is valid */
> -	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> +	r = amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> +	if (r) {
> +		/* The fence is not initialized yet, so unwind it by hand */
> +		amdgpu_userq_fence_put_fence_drv_array(fence);
> +		amdgpu_userq_fence_driver_put(fence->fence_drv);
> +		kvfree(fence->fence_drv_array);
> +		kfree(fence);
> +		goto put_queue;
> +	}
>  
>  	/* Create the new fence */
>  	amdgpu_userq_fence_init(queue, fence, wptr);
> 

