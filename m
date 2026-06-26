Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B935535DA69;
	Fri, 26 Jun 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782494686; cv=fail; b=ijQ2O4o3iHx3zrm/odA8i5vDmWyUPmOk5h+9dupxCWHt2+VzI+fFi1v7yUX6Z48eLUSCJRQW1XJJoHUHfbV/YhymOw2oSmrbx2tT/Xu9dgt6XGNQHrm/DgYJxl0b2CDrKGl9QuDWP9vPLMT4cOqn4iDH8ukQlhA2kyZ7Nave0C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782494686; c=relaxed/simple;
	bh=vRnm1otLWrp9A5Wl9ezkZtHQurmV4kmSUR97g18ChxM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=et4YPybEqQyhXAHO1M7EPEjt4lP5yLj9YJgWtakdGvcm3OxGLgQppcO/Rl9ZqCuEIg0TD0JPsiJxXwNZ1cpHrfhsYoFzyJ2n1BlNaRwrlHinvRALlkb4rli/kxF7cwe07UYFAIGBpwky2tLiyZbhjX3ZTdCK88B7jDgbz1owxqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ACSgK6cd; arc=fail smtp.client-ip=40.107.209.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ACSgK6cd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lN1Z81gBJpv0ZHEWvK8F9pWjReXdQWeMDXNifCIczi+FYnWQLlA/rrsj3OUlsxEM/eoVcfXXhUT1QgcQnobTDgbsR5m95dWn5JFRM9HEVlInt7Awq5po0AlqqET7TYHfAY2Nbe6KCNS8ZtCJZvcmLms4XUcAIj5Ak1HNea/HKf4lsvNS1sDENedY8t2yHyx0KedZKoBj5m81ZiD8x68tZkLPP06w/X/M7cB+JPRJ7RtzRtZM64NWZ5I5A81hEqcL/NNOnnMC8eSG7AbCrtw/0fw6DsywCXccDaQ4WBLyyobEbt/26bh7Jm0AeD01QhJS5OjSNF6N2FQYojXZam00rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvPpf2lruBpYrAYz2xYPfvzciwA5+9cOoa1tV3Bqkso=;
 b=N7QWmTndaFVNDi1R1uR0z9Uh3BBf9AVyY+yME51LWNVZwpz25DBFZGkZAR09Odn/WgoqHfLyT51G9kX2nb8NXebwi7cYH04BBdkTlvROGmQ5l9sP6SvlqeJOemUhs6FIo9LmptblIQXufMNWHjFOfC1cWICltnmkyllLQ9O34B43LcfnrhZ/DiAVBSnhWo5T63nnTm3sd1croU+jTcj3IGN7TD7pU9WxnlpztaBUohs6F1c0QTLgipyiQL/cx/OeQz49y2Mqw5D+SRoVQECtLS70m/4xzqkBmNu/bQXuB2NJk00VTwCSlhQHmrwNdqZguxxM+OH8uVnovgLMPhmgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvPpf2lruBpYrAYz2xYPfvzciwA5+9cOoa1tV3Bqkso=;
 b=ACSgK6cdA9WBPlzCxig/tmswtIYbtwHsxlkNIZ1aBfWcvj+YMwS+uws+gap4HzDbOpNNwbGtblCIBq1KlLJG14U/QRqTI+uFpSXCqklTAw9poNWhx9Grn3xYY7OQVH6xoDjYlCu25w7/G3JSqXUNdw0QZlxWM7k8aVo63/Shank=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 17:24:39 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 17:24:39 +0000
Message-ID: <6f93acaf-7483-42d4-b29d-72b3b9933fe9@amd.com>
Date: Fri, 26 Jun 2026 12:24:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Fix dangling pointers in state reset
 functions on allocation failure
Content-Language: en-US
To: Evgenii Burenchev <evg28bur@yandex.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, superm1@kernel.org,
 timur.kristof@gmail.com, ivan.lipski@amd.com, ray.wu@amd.com,
 aurabindo.pillai@amd.com, chen-yu.chen@amd.com, mripard@kernel.org,
 Dillon.Varone@amd.com, mwen@igalia.com, chiahsuan.chung@amd.com,
 kenneth.feng@amd.com, srinivasan.shanmugam@amd.com, contact@emersion.fr,
 Alvin.Lee2@amd.com, chaitanya.kumar.borah@intel.com,
 dmitry.baryshkov@oss.qualcomm.com, pierre-eric.pelloux-prayer@amd.com,
 ekurzinger@gmail.com, HaoPing.Liu@amd.com, Tony.Cheng@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260626133859.21492-1-evg28bur@yandex.ru>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260626133859.21492-1-evg28bur@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:610:11a::11) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2ac424-e142-4340-77a4-08ded3a7cd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	pLbN7iOXZ5C3YckikebK81+P+pGXXT9SI6nnH3tzbDudhFk3g04kgA7+TbsX8g4ykFm8LumyDEEeWvusvsDLiOsAFxD8z+sHym6b7celWCHah5KyDbqRUw2wEk8noV7E+Xa04h+odBgtFbW8xavDaa3Vx0nyzDXbbhCtCb31V27gs37TiotLwQOgdQTTmj5bEi7kJ7XKM7XJBDxOvQQTSaZjtV3xAbYpfWbjZ7dS6FYtOs6LOVmVdHJfzqpqMfXykuSDHmQUKiVJMxdpBLanVaj96aMc8M9Ec6eQHjfEVARUrALn3nafjJ55fVMcsq70kefGpGCvCL4wHWCXHYGnE7ObMQgYwWlxDTcEN9o28cAOQwqZiuh8dUAu9akefmbwhZpGY3nSDcgxoNe4077CLcWCNr1GODwTzDonv+KzKC4NZBAwdNyZ/LT572b+l0Udx93iptbSQ0YhzMSKPziq7zgKPiWHOsTeKJUPuytd4QSHRO/vyF7og20ekwzqmsH/xlMjNmHBeKUUrNFU/xN3FPTr1iwwMNp3D/1edMpbtNDYpDdOc3pfIUbZSBghZtQIGkJ1KskHkLbc1Y9ceJWtpVKyAdEYkaLBwNAq4rkKjNMuwTEzRoAQF/ysmc0EkvFMwnq4tr0hDvnoCM/b+0j6KuWT4JIhJKypFPK/+5nq5Qg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akJWVlB6UEpuVFdmaW83TUtiYkdDcjBYcDdxWUlKamM1MnlrcGNXcTFJUFUy?=
 =?utf-8?B?ZWl1Y0tvR0Z3RzREWW5maG9xUGc0RFFrT0xIaTFqVENoTFo5OWNPcXpRSWs5?=
 =?utf-8?B?UVB5cEpyVktoNHQ0NmJTTXQ5eSs2VFFsTkJsVXhJUDcxMFA1KzNVN3YrQUVn?=
 =?utf-8?B?NUhKcnBHOHpJNWFOb2tWNEx0NzVuOEt2aHM1aGJuVEFlSVM2Z3hyNVQvRXFM?=
 =?utf-8?B?TWRObHFaQXBhN05vQktpWjJsN3NxL0NaYWtON0tWampLOVRJeXUzMDNmdExP?=
 =?utf-8?B?OEp6aHlnc1pBV1ZyS3UzaUxpVkR6SmhvaVhHSE15RnVOYWE0bE1iWjJWa01B?=
 =?utf-8?B?R2x3WkM4Y2tQaHZndUtVazVRMXFyalNlTUVrSGdndGtYMEVLNk4xZTBBTFA5?=
 =?utf-8?B?WHo5ZGZQclV0c3YvdEZ0SGJYQlhRWUlFdE02eFlnaUYxZHlicFFVclQxRDRN?=
 =?utf-8?B?Z21xc0dyK3g5Qzh4ZG1BOTU5N2RVT1NVMEw2VlVXakJNaStYamFCUHloMXpW?=
 =?utf-8?B?NmI0VEQ4NXFFOU44ajFKNjZXbGhLTnZBMExMMm9OeVc4MkQvYU5xVWhrT3Jy?=
 =?utf-8?B?RzlhK2trQWM1NVcranA1cXdiZDl6TnZDaW1NSXNhSk9nbWpwVnNyelk3NWIz?=
 =?utf-8?B?emxZaGhUYkhWUlQxU3NZVEE0eTVsU1g2RGFtbVF6S1BMY04vNTJBaElaTEVo?=
 =?utf-8?B?TXR6TGF3M3VhNzB3OS9XdWo0cHlIbjJrNTdhVldUY0lJaUxtTDhTTnovQldS?=
 =?utf-8?B?RlBybXk0djAzTnRTYWsxZGdYTnBFdmUvWUNPNXlRSVpvVno3dmRCYWY4Zmln?=
 =?utf-8?B?K2tFek9FQkJLQXhJVU1YQmFxdVBvZE9jaXlWQ2tURlZEM09RdE9ZVFVOTFZH?=
 =?utf-8?B?M1BwelhJeWxZZWV2UEZyRW1ZdjZFM2loRzV3NG5raEcrdldNTGlzeFRsN0Vq?=
 =?utf-8?B?clpHaDZvWDF3OExDM3BpOVhGVmRFYy9VUDFpcm5XRmVjZ1B6dU1TV0pOOWZH?=
 =?utf-8?B?RlRITC90ZTNnOU1QblVOQXlTc0J6bmhmM1o2MXpvVXpHWUh4L2VJa1Z2eWlJ?=
 =?utf-8?B?UVN4Y00rVEZqN1hFUWxvVjZ2TkpNZ01VR0hDNmtMamJXRjVmdlp0OW9zQ3Zs?=
 =?utf-8?B?N2cxYUMrckwrOXBwWndEejd2NncxUjdCNjZrRDE0VGl6OFNSVXJ4MXNxd0Zw?=
 =?utf-8?B?bFdveXpuQldYUVZBU2FmWGVBcEZXY2ozeEE1b1FLeHdXd2h2Y1V1WlV2Wnlp?=
 =?utf-8?B?WVZNU1dPOW1NRHM4Mzc5UGdicitjWk55WDEyN1gxSkZZNGw0U3JUOHpDa0Zw?=
 =?utf-8?B?d2NPYXdMRGNWODhWUE5pUXFubFhrV00rTnNkQThlbVdHMk9CdFh5Q1FpK0Zq?=
 =?utf-8?B?aTBFMHNSVWRaZ1BEbHlMV1MzZlYwZEpPQTE4NUVLU2hyclpZYXpvNTlQYUJ3?=
 =?utf-8?B?blNIVmdvL2YwOWlvdEFsZVRYcVNkb0dlOVE4WE5WN0w0eldwb2Q5WFBZMjBn?=
 =?utf-8?B?WkhFUU9ENWNtWnFqWlJZZzVmSVFrV3R1OVoyQnIwTXhnOXpGcVllT29NODlJ?=
 =?utf-8?B?NnRBcEZzQXVMb1lpTllYelVodjJ2aHFRczFZczJoVUl1a0o0RForaXN0bU53?=
 =?utf-8?B?ZWpyaElTUWlkL2RqaXFDMFVmTlduNlpuZVR2N0ttN1BWUEljOUlKT2JncXRH?=
 =?utf-8?B?UnRjNnI0NlRWR1czbitKOUd2OFduZDRzTUU2c2RwUE9YVTc3ZGttdnFLTW91?=
 =?utf-8?B?OWpjTEZJNzBZM0RzandqVTc5OVFOWFZRZjZqL3hEQnpmd2FaRU9nSGVpSDFm?=
 =?utf-8?B?TW9pZXlTSnZpYkYrdDZ4U2VBU0o1ZExKQ3RtQWhZdzRWVTA0OWp5Nm91Tk5W?=
 =?utf-8?B?SWJIaWxLY09jZU41enY3VlY1YkRNTlhXUURsODk0Z0F4eC82NXlBUFlTZkpu?=
 =?utf-8?B?d3pXa08wRkZmcU1CLzVSU2tSYjl4Q3FwZUNON1kzeVhwMmxZVUxLZzZxU0VJ?=
 =?utf-8?B?RUJnTTNzV1dqZURISGRUUUNtakNPWXNkRjUvdFd2SEF3WnNyZ0loV1hwZWhL?=
 =?utf-8?B?WDQwc0pUTU5PYzE3Vkd1clN5OFY0YW91Qm9XWGlKaXZwQjczR3FyQWRFWFNM?=
 =?utf-8?B?T1JydjdNUkxZNkNnNVozRUhKSWpqekw0MUU4RDVUZG1ReE9CZUl4OVZpT3ho?=
 =?utf-8?B?a20rdHhwMDBMNjNhSEFJbEplNWhUVHFPTURJSVVPTVFtM2lBeHdHUHR3YlpS?=
 =?utf-8?B?akEzeXd2VTlycUFibVJaaVR2NkF6WjVVdWhyYi9OdVZRa0lubGhOTDVCYVBi?=
 =?utf-8?Q?Ei9hoHmQuRreXuWnZD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2ac424-e142-4340-77a4-08ded3a7cd67
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 17:24:39.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bumvIlyNoFF/nYwvz5PpUeEY+zR44GtdEy/eZ5PjK6sxRsp9sGPbjIWwzDPwoUaFMdu5F80Yt+/71moFfCn1DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203



On 6/26/26 08:38, Evgenii Burenchev wrote:
> Multiple reset functions in amdgpu_dm free the old state before allocating
> a new one. If kzalloc_obj() fails, the function returns without updating
> the state pointer, leaving a dangling pointer to already freed memory.
> 
> Fix this by allocating the new state first. If allocation fails, warn and
> return without touching the old state, as it remains valid and the caller
> will handle the error appropriately.
> 
> This affects three functions:
> - amdgpu_dm_plane_drm_plane_reset()
> - amdgpu_dm_crtc_reset_state()
> - amdgpu_dm_connector_funcs_reset()
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 5d945cbcd4b1 ("drm/amd/display: Create a file dedicated to planes")
> Fixes: 473683a03495 ("drm/amd/display: Create a file dedicated for CRTC")
> Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_types and amdgpu_dm")
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
> ---
> Changes in v2:
> - Also fix amdgpu_dm_crtc_reset_state() and amdgpu_dm_connector_funcs_reset()
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 48 ++++++++++---------
>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  8 ++--
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 14 +++---
>   3 files changed, 37 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 97ab1e83b318..6ef1b07ec251 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8151,33 +8151,35 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
>   
>   void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
>   {
> -	struct dm_connector_state *state =
> -		to_dm_connector_state(connector->state);
> -
> -	if (connector->state)
> -		__drm_atomic_helper_connector_destroy_state(connector->state);
> -
> -	kfree(state);

You seem to have lost this kfree() in your refactor.

> +	struct dm_connector_state *state;
>   
> +	/* Allocate new state first */
>   	state = kzalloc_obj(*state);
> +	if (WARN_ON(!state))
> +		return;
>   
> -	if (state) {
> -		state->scaling = RMX_OFF;
> -		state->underscan_enable = false;
> -		state->underscan_hborder = 0;
> -		state->underscan_vborder = 0;
> -		state->base.max_requested_bpc = 8;
> -		state->vcpi_slots = 0;
> -		state->pbn = 0;
> -
> -		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
> -			if (amdgpu_dm_abm_level <= 0)
> -				state->abm_level = ABM_LEVEL_IMMEDIATE_DISABLE;
> -			else
> -				state->abm_level = amdgpu_dm_abm_level;
> -		}
> +	/* Destroy old state only after successful allocation */
> +	if (connector->state)
> +		__drm_atomic_helper_connector_destroy_state(connector->state);
>   
> -		__drm_atomic_helper_connector_reset(connector, &state->base);
> +	/* Let DRM core install the new state */
> +	__drm_atomic_helper_connector_reset(connector, &state->base);
> +
> +	/* Initialize driver-specific fields */
> +	state->scaling = RMX_OFF;
> +	state->underscan_enable = false;
> +	state->underscan_hborder = 0;
> +	state->underscan_vborder = 0;
> +	state->base.max_requested_bpc = 8;
> +	state->vcpi_slots = 0;
> +	state->pbn = 0;
> +
> +	/* eDP-specific initialization */
> +	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
> +		if (amdgpu_dm_abm_level <= 0)
> +			state->abm_level = ABM_LEVEL_IMMEDIATE_DISABLE;
> +		else
> +			state->abm_level = amdgpu_dm_abm_level;
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 3dcedaa67ed8..6146fbc528c3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -437,13 +437,15 @@ static void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
>   {
>   	struct dm_crtc_state *state;
>   
> -	if (crtc->state)
> -		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
> -
> +	/* Allocate new state first */
>   	state = kzalloc_obj(*state);
>   	if (WARN_ON(!state))
>   		return;
>   
> +	/* Destroy old state only after successful allocation */
> +	if (crtc->state)
> +		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
> +
>   	__drm_atomic_helper_crtc_reset(crtc, &state->base);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index e957657b06c7..eb1c0a26f20d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1488,17 +1488,17 @@ static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
>   
>   static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
>   {
> -	struct dm_plane_state *amdgpu_state = NULL;
> -
> -	if (plane->state)
> -		plane->funcs->atomic_destroy_state(plane, plane->state);
> +	struct dm_plane_state *amdgpu_state;
>   
> +	/* Allocate new state first */
>   	amdgpu_state = kzalloc_obj(*amdgpu_state);
> -	WARN_ON(amdgpu_state == NULL);
> -
> -	if (!amdgpu_state)
> +	if (WARN_ON(!amdgpu_state))
>   		return;
>   
> +	/* Destroy old state only after successful allocation */
> +	if (plane->state)
> +		plane->funcs->atomic_destroy_state(plane, plane->state);
> +
>   	__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
>   	amdgpu_state->degamma_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
>   	amdgpu_state->hdr_mult = AMDGPU_HDR_MULT_DEFAULT;

