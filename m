Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D8B385D7E;
	Mon, 29 Jun 2026 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782766350; cv=fail; b=cCl/jSglI3ehp3pbZYeP8wUn+2IZiOIMTbEc1heGNMKa2qyr3TIOa5JlzOA/JkEz8KD7UrMZhlCIBRGj1RxPBKnGBTNIAx8Xz1IW+ZGJXpb/MWajWlS4hjJx9B35AiALHiEZxfL/gi/Fpyz/DNZ70v94Wn+nebQCsyvOiNuaCQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782766350; c=relaxed/simple;
	bh=m05m8jMISF+qaZDBf0rPXsIvv7VarPqP2UQctE0bWMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p7HscvXRzmNNEjZFxVXw+EPdqd2lyFp0UmQxitNGLnO29B6Hl+X5jdrfLgyx+YuptmnwGrQt3iOh8PVRjmCUkp/t4MaW+Gvtt7RF+YFBR4E5uyXeDceGbLHvpXZddoI3Rlxfbu1jWZ/+PzpO/kiKB9k0tW35pDIKx5RY447beDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1mhLwo/B; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1mhLwo/B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4nS58LnjhA6oPkmvTvrcazm6dybqDAl29WoOE9p70GBUJ3mbg/LMsdI0I78TJUDgPtGxM20BV0/KqFWkocLp4/bdfFHUXR5Y2nH4biq2FxL7QGofMmmOTB88JP4IcrIuiUIGtw7tlIKPYGdsGPiUVIiSsTGgx881HRNSZmakeiT0rBGY8O29OasWDUit0D5vefspgeI09vrThrpUVFtE0Fk5/HVgKOWiN3dnxK8+4lW6/LBswObdBvH9H8RYmrpiy9e8MRRV5vS0tMZ0ow659G/9cMjBHazb02I4nncFe8vSBm1A29Kz4bKOBGeuw6CqoOAR5nVTkUUTaVTgeDAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9xV+OpTqq/kKC1iLVdzKFUIdOtWOO0cJtQKxHUNkiI=;
 b=HrGNmHJqYPCNtFwEqA9H7io7ejgBH5neTTWHkBirQCu6CG5lCGz48MwlfFTvHJv8OHKWOyfxPvr1Qksxw6bBhQweL3uymXu2rmGCZeTXeMfkF925Hbbjo7NMmEgomJNDDm+QD11nmwAGmhOrjxeGYN7EXg6fOa5WSXb1Th2kc4ORRr52q9GDoOqmfI/ajIcVKJeSWndAdOy/Tfrta+yDSo3o+xj3wIgIs9QDCV4LGjAXnabp0FcAXpwPzbCLlDREJ7D3YKj7GOTN5fHbkqicsto74ZM7vrNv3nBZR3u/X47D5Tqio80g7jHCeE5I1sFluSZmXISHopKack3FhSGg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9xV+OpTqq/kKC1iLVdzKFUIdOtWOO0cJtQKxHUNkiI=;
 b=1mhLwo/B5dchvvVEVA63/EGNz/6ybTumM5TD207DUI9NunH2x4aZCWKqoUL+7RyQ4LGg3VYT/NyoAq5WYL3Qonitv7EgzuHZwlaJGQPnX95mn+rRR82LuKQaXIzLVSxq6MRCT59+Lr5LcEiDw7DLFSmdYotpS7pBGM2XCwS1x6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 20:52:25 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 20:52:24 +0000
Message-ID: <ea17cfdd-b43c-4efd-a208-3c86e9d4e8b5@amd.com>
Date: Mon, 29 Jun 2026 15:52:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] drm/amd/display: Fix dangling pointers in state
 reset functions
Content-Language: en-US
To: Evgenii Burenchev <evg28bur@yandex.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, superm1@kernel.org,
 timur.kristof@gmail.com, ivan.lipski@amd.com, ray.wu@amd.com,
 aurabindo.pillai@amd.com, chen-yu.chen@amd.com, mripard@kernel.org,
 Dillon.Varone@amd.com, mwen@igalia.com, chiahsuan.chung@amd.com,
 kenneth.feng@amd.com, srinivasan.shanmugam@amd.com, tzimmermann@suse.de,
 Alvin.Lee2@amd.com, dmitry.baryshkov@oss.qualcomm.com,
 chaitanya.kumar.borah@intel.com, ekurzinger@gmail.com,
 pierre-eric.pelloux-prayer@amd.com, HaoPing.Liu@amd.com, Tony.Cheng@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260629090435.9729-2-evg28bur@yandex.ru>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260629090435.9729-2-evg28bur@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::9) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: a038ccfb-1195-4bd4-b7f3-08ded6205272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|6133799003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5R0D1pu2HLXmR5oKftbheJR9Mfwp7GstSfC9KJ5VUOfHCsYk8WcSJjYAZCa/jsLGRg7ODNH5vDZNOH+J8ad6cT9SykfCg47vSlhONxPKyvQVfkNfhKFNshfcsNZ44EOg7XPCfvscAjgcDnEFsFTfTAroTw9fGqmZuRnGdUtRmUuWhqka6i9w6dFOZpnMpY1/ypoImi77aBsldU1kv3XOyIBsoz3s7HIIT1QzPnGte+yrhZvgHEv+BB2JYWOMsHMyODSmwDKASS49tdt2fntn2B1PBZ3AO2GZPs/em9AlgEI7X6IjcDdwUtknpqJ2Ge0oe+fKEZvk6CzvfIXjWdZTJ/eHmnFdULoY0lkxICOlhSWYdsdpV270d13FJYdOBIAIsJ2bbF73HjJe1yBnUssKGy5PuNy9/W4GF8A5rB0QZ9Lq/vRu6p/rG8wMIZ3Dit++blB17qUabq9bzqfNuTEIXvW/jXSxTVt+/P2G34qanVw0Rz0YvWZfc+ogY4inhD9KNatK4eMw2OtVYzKakuDtQ2LDOVO92MRca7SUvopT/SohU2ISlZVNbzVQFS+Y8WTvy6C2lovhNuHwr2a0a5xO4l0yHGDvuvDAa/2Ry3LHMhJWETe0fdawFk1FIk5IvRb4GteFet7IlnzyF9czgutRpl8mRm9J5kWvaot9yHuFfKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlBvVGZyeGt0cG40Z0FTNHorRlc0ejVTN1l2NS9aT1NnZHgydThMdWtOTnl2?=
 =?utf-8?B?aW1ucHEvRktBN0treXZNeW9MQ3FaOTJSMzNPUWZHcFRZUGRxbkdHd0FHd1I2?=
 =?utf-8?B?YXE2NkxnMHNva1NsSzFGaWZsbW84N20wdCtMOStKZkxHT0U5UW9INEhVd1R4?=
 =?utf-8?B?eWIwSWpqZi9JQmxhRWNCRFgwb0hlWGhIRko3TFFkM25UWXJMSjhHK1hiampX?=
 =?utf-8?B?U2VWREF6dFp0WmU2TXdhOU1MajlhWHdkaG53R2FITEduZmVYUHNPQ3hHbWlV?=
 =?utf-8?B?bEd5L29Kd3QzUElrSm5IRXB1WnYwbjZrMDZHdHY4RlBtZ3VkNUpvZ04yY00x?=
 =?utf-8?B?cUZWSmRsNEFjdXVxdWVkWGlGUkRIa0JCQ2RJTXZrTjhaQXY3c2FmUlhMdGdD?=
 =?utf-8?B?QUVMM2ZkU1RnVmFFU3FwRER0UjliUUFVLzlmRERqWVF3TjJIQ1ZaWCtnT0p3?=
 =?utf-8?B?SnVsN3c3c0tsTWpNMWpSdXVnc000VkFNNHZRZXNkVEpZT2xWcnFDdG1YRnZK?=
 =?utf-8?B?RzRGUlhDUkpQc0czOFM0NGprblZ0ZnNUWVJBOE9nbkpKQjltYkdjWFVObWli?=
 =?utf-8?B?MHVza0Q0dmhVckNkVUx6b2pGa2s4UGdlRTYwVklFT2NGelkxNDBvUXEzaEF3?=
 =?utf-8?B?MXdrVFdTeThHME9Ic2had1Y4YXpZdDUxcjY2TVYzc3UxZnJJRWEyWVEzS0Q5?=
 =?utf-8?B?bS96eVV0d1BvVVI5cjNVRFdQQUFTMlFsdlpITVk5MHVEWnpRZXN5Y2FwZ0FQ?=
 =?utf-8?B?d1VvemV2QUNDaWZLWnFoYm9TTVNrYVh0MGJ2dWdqdmRhaVhBQ0NMSndxeDNH?=
 =?utf-8?B?MGYxVDhxdUV2SjJ5SjNzdlJRSUR5QzBTM1YwYnloVUNQLzF5Z2hLMUdwRFB5?=
 =?utf-8?B?cDJnZUZGS1NYclZtNjlJb2VwTkZleGtkbmVVQ3BFRExnMFVSb2ZoK3FYOVBt?=
 =?utf-8?B?b3Z6L1BCV3JyWHlOa3pqSlIreHJYN2dDRTJ3STF4UitPcGsvcEpKMHI2YzVJ?=
 =?utf-8?B?ZmtzSlVYdm12Zis2UlpINGdCK3dCZU9FK05ncHpWTGVVbVhWN2pHOTlPZGpp?=
 =?utf-8?B?Tk1La3RJcEVyU1dRZm9BdmZxbzB1eWxqK2loOFQwUCtwKzJtYy9ZR0c1Qytq?=
 =?utf-8?B?UmMveWplZDZubHB4V1hsZWY5eTBmNnA5ZUtNdm9iS2VGSmVtVlFUSlF6NEUw?=
 =?utf-8?B?eGIyd3dML3FIS3U1RUhSaWRPaDZwSHVEYnZ0S3NOVTdaRzl5SjJ2QVVvZkFH?=
 =?utf-8?B?dURtRERoZnNyamE0aEdvZEZ3ZUVRTjRYZEZVVjFxQjFPOFJmZDRuL0JKZ1Fx?=
 =?utf-8?B?WFB3U0FRdCtCUEZOOFcxdkVkY3drRjFMWG1ERTNWRHY1dDk5b2UydlFUMDVx?=
 =?utf-8?B?K1NrNGJMQk54dFNrbTFBTjIwbU5iVlBFU2U5YXBSdTZoMlVXeTJmYjk1V0s4?=
 =?utf-8?B?c3o2aVlUcGJObWZhQnZYenZobm5Cd0o1elp0eHJJRVZ4VVFzWHhpR01LNVky?=
 =?utf-8?B?d3NpT3luTjFpOEs2ZE51SWN3RDZTQ01IYUtCSWE1TG9OaEZhV1pBYVRPZFRL?=
 =?utf-8?B?WXluSlV1WWdRckFmSDdNVU56aXV5QnpTczBXK0hCRG8ycUdiK0hWeW1pNHhn?=
 =?utf-8?B?c1BkNzRMYVI4MmtldVhzSUJXU0VkNmtFOXpQdXlXa1pSNEJ0ZkhWdHk0L0dT?=
 =?utf-8?B?VERKOXZsdXdrRmtDMlo5dWZSUXRxbmNPRVpaM2F2TVIzcGVFYjdwWlNRd09i?=
 =?utf-8?B?ckxocDExYUk0RTByd0hsZEJueDRKNllMK3N0bHpRcEpCSUtJTGJyQ3lVdHBm?=
 =?utf-8?B?dzVMeDhwSlhQU2MzZHJyUEhSM3dscUtuTS9oWHpDNmFROUdJSXowY1diSTZV?=
 =?utf-8?B?NGpTelFSeWJIdFMrQ1hTMW5pQkZZbEd0b0NxTmM4Z0NKR0JESzBIMjFBTnFC?=
 =?utf-8?B?S04yTkxyMDByUHppS1hnckVyTEpYVkIxRGpJN3YvQnczRXlaN0pzMGRmSzhr?=
 =?utf-8?B?ZkRLVVdCc2IrRGhQQ1p6WTJTMm1kbjZNbHlLbFlCRVRpZG8yWWZqclJibHpk?=
 =?utf-8?B?WVpDb0E0cDVCYmIvWHpKdjd3eVM0QXROQThWRmdIUy9FdGpIMlhiVUpCd1dx?=
 =?utf-8?B?MlJKdlNtL1hGWEVmYnZ6alZJb2l1cnJPakFUMkd2ZGU0V3RrdHlHQkh4cmRj?=
 =?utf-8?B?Tk5TTWdsMFQxQ05ybWhRSjFXMzVUMHMvMmMrbnAzVEFlSVZoQUEwNlczT2lk?=
 =?utf-8?B?YXhJay9iZzR4RnZ2OEdMbWFqNUExTDA1ZytQUkV2bDdPZURxbXcwSE9QTVRF?=
 =?utf-8?B?UGtOZTI0NCtsVitCREk2cncvdnR6bWk2V2crdDBsOVNHTndRbExiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a038ccfb-1195-4bd4-b7f3-08ded6205272
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 20:52:24.5269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GH/QbvcrJ2lGF+JA3o6lDCkgJAhKVUamigHwRj91N2borXHz7/rVTIOQ1nCyuXu5vaSGl4CYg1y+rGNNxxCkyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916



On 6/29/26 04:04, Evgenii Burenchev wrote:
> This series fixes a dangling pointer issue in three reset functions:
> - amdgpu_dm_plane_drm_plane_reset()
> - amdgpu_dm_crtc_reset_state()
> - amdgpu_dm_connector_funcs_reset()
> 
> Each function frees the old state before allocating a new one. If
> kzalloc_obj() fails, the function returns without updating the state
> pointer, leaving a dangling pointer to already freed memory.
> 
> The fix is to allocate the new state first. On allocation failure,
> the old state remains untouched and the function safely returns.
> 
> For the connector function, additionally restore the explicit
> kfree(old_state) which was lost during refactoring.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
> ---
> Evgenii Burenchev (3):
>    drm/amd/display: Fix dangling pointer in plane reset function
>    drm/amd/display: Fix dangling pointer in CRTC reset function
>    drm/amd/display: Fix dangling pointer in connector reset function
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 39 ++++++++++---------
>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  8 ++--
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 10 ++---
>   3 files changed, 28 insertions(+), 29 deletions(-)
> ---
> Changes in v4:
> - Split into three separate patches as requested (reviewer Fedor Pchelkin)
> - Remove WARN_ON on memory allocation failure (reviewer Fedor Pchelkin)
> - Remove redundant comments (reviewer Fedor Pchelkin)
> - Fix empty line in local variable declaration block (reviewer Fedor Pchelkin)
> 
> Changes in v3:
> - Restore explicit kfree(old_state) in amdgpu_dm_connector_funcs_reset()
>    to prevent memory leak (reviewer Mario Limonciello)
> 
> Changes in v2:
> - Also fix amdgpu_dm_crtc_reset_state() and amdgpu_dm_connector_funcs_reset()

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

I will apply the series to amd-staging-drm-next and it will come in a 
future to drm-fixes.
