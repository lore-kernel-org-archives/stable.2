Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D714E7817;
	Mon, 21 Sep 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011640; cv=fail; b=JFTkSyUxLvnQWGtkNIJc723rqPw6OdCzM6ZigzOFtX92dhPLdKxPE0u+tYIVcJUOzyolb11VEhhYK2vBv0OfKYoo5GTyaOYi8nOofxIDoRsz/oO1gb2578E8sIWGAM18/IquLuEhcGLU8x1ZdMZS/lzv2S5jS9uxp4ZhESx0I8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011640; c=relaxed/simple;
	bh=BCumN4lkEFWTCdRoWjqvVzlfZ8x8uOfwFSeW6rIqMTo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fVznJcp12BQBRM97QuxuyN3iW/HOtYA91v8s65WOnjKXGzCboHsI+kWGBI4E44o4U86Dw20m64DM4J6UU7c0Q87v16FsocB6oiw4b4ubm9x/NnzMMHCo7XeJL7qlJkhU9qGoP0dWjRunog9uWpmrIcIuogoPMT5ZAMoPBasBzTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d3K8zx2v; arc=fail smtp.client-ip=52.101.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d3K8zx2v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObVGrnqyrK+cNact+dIzLsQFtLHTcOjcm7RHFdPYuh/O3uhUQSqMpSZTpgGufojhNjw0pgDv81cdA+OjLBlOH3imfRrUuyaqVY+KM1X4kjXyvFualPhTqm5a4JOziqMapDLjDwmddfcKaYKaoXBSsGGnyBe7x7rA2mHulOpBNps1ydqNV1X/pqX2r+9F1LqJGI1Qa8drudJBYXm8J1pLBi5CFUP+Qf0mHSQHIoCmnsEdmmzzCUApb522gg+p1HuZRobCZilZSbPxfJBxPoLsd/sviuQ5sfA8evCNEwWSTRN0Tedqd+LuUAybD+zYc11KQD7EyPbjDPjBeBVmAnL0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fz44fuSX3mV0g1c5ieGGS2gx+DIIXUpZazVaiyxwT4g=;
 b=MTB3YDMpglYRBm08endqm/DKv7p8OIPyw4bccvN+pgSjJi89xO/MkTI4DPCRz3kQ74YjWnfFVS0Fg1Ve3QWPwcHv+o+9wfNJwfLAqxifEcD2kgoXCc1wQkcO2+Khl26YY4WeBCnY+h0/Zb/n/XpDS5hY7OjE4t4buKqwmjaWhUPfAAXs72GOjwrXt8g+6X7lvLenfn5adLQigwg5yyPBJ8gMAWJI4YrMCnGDSJ85C3Z3JCaRPicM9z1WwTgBZxchQb2TstLZ8L9fhKlDo3VzNnrlAXzj8a7yt+ztpPAcPchEP+ko29HYQERyuctm3V8AgB0joXPOpNcL3g1W3n1gEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fz44fuSX3mV0g1c5ieGGS2gx+DIIXUpZazVaiyxwT4g=;
 b=d3K8zx2vlzP+SRvJXT1o2uGzz1z2Ev0oHBpoG7kss2PY0s9SjfquCv8k2ecZMKPC9kKFGUKKLX2rjm+fCrGpleBguURnW5+/4xlGyAir/bhhFs2mOhQ8cTWZeQGHFnHtSH4ntWl1sDN6AnVZi3OhJ6uoTfXzoxOghfAgVx/D1e0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:27:14 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 17:27:14 +0000
Message-ID: <8ce34344-4d09-4fe9-b356-101cb4d3679d@amd.com>
Date: Mon, 21 Sep 2026 12:27:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] platform/x86/amd: hfi: Fix out-of-bounds reads when
 parsing ranking data
Content-Language: en-US
To: Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <20260921170411.1149960-1-mario.limonciello@amd.com>
 <20260921170411.1149960-3-mario.limonciello@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260921170411.1149960-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::35) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: c821fcee-b019-4bdd-356f-08df180593e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DyxuYFzl7XAfXapDtugV2XPlglGd7LA+zasLXxja4weVpV0sb/ELoOiKx3Or2EjWzHSLu7FZ/U/U4P6wTtcSw1sM/6JEDjJCG/fFmbPb3HC5Xg1fBqdAAUegDgVAhKLAw6onxZyiXs43UvLWH0j0tYP1Pg8sbkEYsqMszN+2Tubr/s+jLHcTh+aMolJ79l54gp0b7X/ABvcsuV0wwl4Cqoeh5cbHwb1nBv27vBHOKsKb0d+z+NLEHx3z5d/Nbql2/m44XTQ+1tgmCCG/DbuSsgqaYAXxKvrZ6ialMGlG8clZVu5lhTl1DjNDPzEngn6E4RzgQ/8l2l5pz51xSbAzuBjyv7z02axvqDJKTlInDK8oCus4wEUzCMuP+p8psqaA+7lqVF5xBgXIUFa6pvwA4kiCPS+fKLtnsgjsKIxMD9vkhvkFivijukXJPRwo3pUTU8n3f8DmuZZs24l/qrEzRM6NrRRVotMuu0W2plfY2ouCehrNBCyGGJ+F3wawiqq+vQUNyS2Bh897nxSPneAFcQJZ3FD+tUfBBFWu3Rwk7b1EjhFIj35RGJ5luIlXsvNsTIiHqi81NkStmnR2iw8h4A5iqPeupiT0ljLDDpueJg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0tEaUUrUlZjMC8rZjFVTmZJQW41NlRvRlhoSGlLMnd2VE5xNTRzOVB2MEdI?=
 =?utf-8?B?RVdMRFY4b0VwN0l0emozK2FsMTBkdmw3TGQ3UE5BUWFtNXFUazBHTlM5RXF0?=
 =?utf-8?B?aG4rL3B5clo2anQ0ZVQrYXRuZnU5NUsyMlVxY3V0S29EWjllK253akFkaUUx?=
 =?utf-8?B?VUx3YUxMSnlEbktuaENjTXpES0tlc3ZzR3g0dnU5MnpwNC9DRnd0NEQyclEv?=
 =?utf-8?B?cG9hd0NGOWQ3dVNtZkJOOUozWjdEaDd5aVpTV0hiWm03aHh0aEk1NUFVeGVD?=
 =?utf-8?B?UXYxdFI5N1orWDlsSVdPRUdsVHJSUGl6SEpBWVVtRkkyZzlwYXQzT2FBUmIx?=
 =?utf-8?B?SlBNM1B0UWZBWk1iTGtCQXd0bFNnZ0YwckFXejVWdHErWnA0TjV4NG1SbkFy?=
 =?utf-8?B?bVdlSjlmbzhzY05kbHJPK0ZXR3g1U0JtN25XanZ3bmhMTE84T0x2MU9HTU1r?=
 =?utf-8?B?NmFtYXpXdXlIcUdEWjZtV0N5dVBJc2VUMnNISHRYeHRJL3BvM0s2Syt3NVov?=
 =?utf-8?B?Z2lFNm5iOEdyVUwwbGljektDNUNway9RTWszRXIrczVEZUUvZXJGSVVYd250?=
 =?utf-8?B?QWpaOGQrVWpwNUpyZExNMHp2MHYxdjRlL09kUnNNaUppSWh2NWdsQjlaNDgz?=
 =?utf-8?B?OG9nMEdKMnpLVmMrblZQZVVRelNmeHBtcDJJRmxSekZYSkw3cjVLWEtWcjJQ?=
 =?utf-8?B?MURLV3l4cC9qUDgvV2dZaURXY3VQM1FxeWh3U3NBRnpmQ3poNjV3WDQrdURF?=
 =?utf-8?B?VFVkQUdxSG9MOFB2c1JZYWJiUXF3L0xzM2tyTmVOMEdtd3dxNXgyT1NSTzJ0?=
 =?utf-8?B?N3RYNHhEOXgwcHNMYitBWGtidHRXektrNm4yTER3T2E4bDlWUTZOamcyT0Fh?=
 =?utf-8?B?VnA5djZWbnNYcUZsZXlCWFlhOHprZVArQm16SmRzVCs3Y3g3eEZra1krcWFY?=
 =?utf-8?B?OVFvb1pOOUpXcldta2ZrVDJxVmRDOWtncGxneVZ4c20wYnJ1NFB4NzBaVVNh?=
 =?utf-8?B?aGZYQ1lLd2Rxbzcxc2pDbDU3U2ExNWJ6Z0orSW56aGRlODlNU2YvREdiR2xZ?=
 =?utf-8?B?M1ZySU4vMHkyVzBpdk15ZmJJQzFrSGxJaFhVdDVnQlY5T3FkYVZCajlDZDZ1?=
 =?utf-8?B?UUF5WHRvbFRUNW5IblYxNkpBYWpSN0dYQllQdzhkQmprTloyRTErWmJNQ1hY?=
 =?utf-8?B?Umx0dVh6VUwyaWU1OEJyaWxrU3dmQk5WT2V4QWQ5cWxQTTh2QXZyWWRmSXZK?=
 =?utf-8?B?bi9sbGFCbFBaUUJ1K3F2L1ZPOHJyYWxOM3BpZWR3NXB5eURvTXpIQklpbjdE?=
 =?utf-8?B?SkVVelQ3aEY2dWF3K0srTEJmOGE4YVZCSmJJK1BzWW4rREhJckJ5QTQ4NS9F?=
 =?utf-8?B?TVZ4SnZEaFdkbFE5a0l0Zkp1QjVkWGt4ZWFmd1FodmxYNzNuUlYxSGxnRUR1?=
 =?utf-8?B?SUVBNnF2RG1MSEwxRUxHZ2dnN2lWamNyaE5ZU2lQSTdLM0FDUy9MZ0U1Vko5?=
 =?utf-8?B?RnpmZWVQWFBzVFhHbG0rVGxNUDdrRlJMaW5RNm5MRFRmV0M0bGhlMHVkb0Rs?=
 =?utf-8?B?M2ZUVkpXMno4bCtCQVF6c2dKeWdlamU2WTQwVzlKaWhHczI2SmtSZWF4bW5w?=
 =?utf-8?B?T0d2ZHJTOTkycjhrMGRXd0VnM2N6dGF5WXM1Vk9KdVVORmlGbUZCWE5QaXV0?=
 =?utf-8?B?U3FncWFUMGUzMU5MSjFQS25HWXcra3BGRHhUS3V0ZVBaKzlDUlBoWCtGUFZY?=
 =?utf-8?B?Tkc4cXIyb25EL1AzaG1ZL2g0N3BmYk4rY3VtNG11akhwSlVvUms0cFJiYkRV?=
 =?utf-8?B?RlZTNmhPWjRoNUQ3cVJMMTlINWlrVWFtWDkrNlI4aFZmTG1wWGxHQnBnNWcw?=
 =?utf-8?B?dFRyN2dLVUU4NzNRdXJXUHFlYW0rWG94RmF0UHFqQU0ydXFmdVgvdEswY0Rz?=
 =?utf-8?B?VHpYNlJuRE91bXYyaU4zY2NxRUVPTktUWS9FNVdyWmpQRVNDZmVTK3FBSUQ4?=
 =?utf-8?B?S3poQnM1SzNSR3haYUtjU3FhV2Y5ZkRKTGRnSktWVERCVFlEWVMyRDE4VUlS?=
 =?utf-8?B?b2lDZEJyME5NRWkxS2F6UGthYUVvMi9URWg2K3ZOQlgzazB5c1FUNldvMGtC?=
 =?utf-8?B?T2U0alNzbVFhZnZGT1JWNVY1enh0VlBkOU9UK3FQdkNEVk1kdk5nMyt1Nitr?=
 =?utf-8?B?bGdmcVJhNGlNdnpxRzgrb3RwS1VSTW1lL0dyZVliazhZaGV6STJTNWh2OGpt?=
 =?utf-8?B?RFErdVBISEVFeG8ydTdjRndJNUdGL3pSbjV6bXFEYnkrRjM2TWtsczFZQkpY?=
 =?utf-8?B?WmM0QlFnT2lzSWJwbHNLbmpremNQNUVjeDJQODZrS2djaG9zdi9EQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c821fcee-b019-4bdd-356f-08df180593e9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:27:14.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuaF4oJcxyVL7WeGaHuXgYPkAGT4Q1qNj3Y5KUtXdRRvK1TuTeVA81bQT8KU3g379RN3NHZMqrqJgdaTfK4tuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525



On 9/21/26 12:04, Mario Limonciello wrote:
> amd_hfi_fill_metadata() parses CPU core ranking data out of the
> firmware-provided PCC shared memory but trusts two values it should not:
> 
>   - n_bitmaps is used to bound the outer loop that reads the APIC ID
>     bitmaps from table_data[], but it is never validated against the size
>     of the shared memory region (pcct_ext->length).  A firmware-supplied
>     count larger than the region reads past the end of table_data.
> 
>   - When resolving the base of the ranking data for a processor, the
>     pointer is shifted by an extra "i * nr_class" term, where i is the
>     current bitmap index.  The per-processor offset is already applied
>     through apic_index, which uses the running count of active processors
>     (apic_start).  The extra shift compounds for every logical processor
>     beyond the first bitmap (APIC ID >= 32), reading out of bounds.
> 
> Both result in out-of-bounds reads that can corrupt the ranking metrics,
> oops, or otherwise destabilise the system.
> 
> Reject an n_bitmaps value that would not fit within the shared memory
> region, and drop the bogus "i * nr_class" term so the ranking data is
> addressed only through its correct per-processor offset.
> 
> Cc: stable@vger.kernel.org
> Fixes: d4e95ea7a78e ("platform/x86: hfi: Parse CPU core ranking data from shared memory")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: 
https://sashiko.dev/#/bug/linux-bc92228c-d783-4b4b-af53-d40a346c4b05> ---
>   drivers/platform/x86/amd/hfi/hfi.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index e1c776b71f3e6..6d1d3b6c28a97 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -20,6 +20,7 @@
>   #include <linux/module.h>
>   #include <linux/mailbox_client.h>
>   #include <linux/mutex.h>
> +#include <linux/overflow.h>
>   #include <linux/percpu-defs.h>
>   #include <linux/platform_device.h>
>   #include <linux/smp.h>
> @@ -168,6 +169,21 @@ static int amd_hfi_fill_metadata(struct amd_hfi_data *amd_hfi_data)
>   		return -EINVAL;
>   	}
>   
> +	/*
> +	 * The bitmaps enumerating the APIC IDs occupy the first n_bitmaps
> +	 * words of table_data.  Reject a firmware-provided count that would
> +	 * push those reads past the end of the shared memory region.
> +	 */
> +	if (struct_size(amd_hfi_data->shmem, table_data, amd_hfi_data->shmem->n_bitmaps) >
> +	    pcct_ext->length) {
> +		dev_err(amd_hfi_data->dev, "invalid number of bitmaps: %u\n",
> +			amd_hfi_data->shmem->n_bitmaps);
> +		return -EINVAL;
> +	}
> +
> +	/* The ranking data for each processor follows the bitmaps */
> +	u32 *table = amd_hfi_data->shmem->table_data + amd_hfi_data->shmem->n_bitmaps;
> +
>   	for (unsigned int i = 0; i < amd_hfi_data->shmem->n_bitmaps; i++) {
>   		u32 bitmap = amd_hfi_data->shmem->table_data[i];
>   
> @@ -192,10 +208,6 @@ static int amd_hfi_fill_metadata(struct amd_hfi_data *amd_hfi_data)
>   			info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
>   			apic_index = apic_start * info->nr_class * 2;
>   			for (unsigned int k = 0; k < info->nr_class; k++) {
> -				u32 *table = amd_hfi_data->shmem->table_data +
> -					     amd_hfi_data->shmem->n_bitmaps +
> -					     i * info->nr_class;
> -
>   				info->amd_hfi_classes[k].eff = table[apic_index + 2 * k];
>   				info->amd_hfi_classes[k].perf = table[apic_index + 2 * k + 1];
>   			}

