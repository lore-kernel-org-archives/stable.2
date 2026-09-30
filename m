Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7BD3D8908
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794109; cv=fail; b=JAIBo2Sv9A501d6W4lJt41wW+vNbrB03XchOq3tgIJuIgblK8GR+OmbjfPkHGxPozg0LEqyC5gHS5Gr8edk0fn4u2uVbgb7lBYJnAIj6rY6M00OKrWKSktwtqRDLs/qSHV703gisgtQ8dQsblHVcWyWYdLnqZuTMWuUTfGkHUPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794109; c=relaxed/simple;
	bh=McPXm5Gh4wCqqwz0HYouowgYVKySS6BOSNpGhY7mZfI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f0VLYOeO4wZiN4BizNOmFyV4czY/3K/gzf5X6ItuBXfpDEaXjTtU/M8iJ7rt6aO4tJ26Opl5hP8C+lhDKolxbRR51035E9qEeNn++3CBCDYtb3hKfFfUC9ccf4y0h10JT8xTVfEGL+eSGyoYkKBaIGLr75M1vqk+ExG1+u9FzIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g6s1oz4y; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g6s1oz4y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1PMskoNTKKibIeVNAXuxN5ZC1ustwDxU6EdULou5JHts1pwYC6lf0yTZJ/MqoBjmkZBXR4WyEJI07BogbHy4UWBGg9yj/tsqHYWmvu2J6n6CkeP0OV3y+C+0i4kVCOLCNTl1b3vsEykwcenad/CzgdYSwZp8G8FtYIr1kw0qWHx1VmUzb5PQGHvGKcCcjcglEThABIlCksiTL890QQ8dc40u86JazxUQe1CuCvo1D1bgOudZarZhsrb54Je2QeAgzR+ApvBbFXpyKd+SJJbfTYsMDhXnAsqOIkQ8wf1UifuNPCdeAliVQ6hR+4tOx2ZNUile4UdG3pMIqEGY+7peA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rijV1xuIzNoQb0VjLoZ/F3DZmcTT8a0Quii1FD+NySg=;
 b=lS4qJSMk/sd+koAD7JaxUz0nAqudE7cybMg/wl7SnG65i2vUutDD9xa3By/Yg8Ik6tn7sGIG2aF13VhBrcQB9KyABlqELr5gbk89GQyNFYMWkEQ80V5ieJsutycyiAQfKgrUhiuC52VT7qchr0d6c19r6B7FEkt6dKPZ/vFlz7sK/dAvelvc4MzsLK23y4SwAEHNgD6sSCHaiD+HQvO34hXDOkEo0v4OFulXVww/dyt/HQfik+rhPvahT7za5vnLhyRgady8c09sruKIrazj6niocUV0l02i8nLd6mGQPsYqhBmKdf3k1QpYmgk1a8TaGLAjjmLlW7DhHJk7yS+sOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rijV1xuIzNoQb0VjLoZ/F3DZmcTT8a0Quii1FD+NySg=;
 b=g6s1oz4ySFmv5LHvkL8WP8W0euCzL42DrB/mGnKOyCW180P/zMiK+zth7jisX7B7xs7OkbZ812Xg2++l8Zqqa85z6bCqPi+PgExa+oALA5WHr2gDR16rPLPcdRZ7khfws9MIjX9bSrTxvUxY89c0RQMpX46zSRSd9kGuvqwA9T0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 18:48:00 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 18:47:56 +0000
Message-ID: <1242b36b-dce8-4f53-83cf-f1252d8e1523@amd.com>
Date: Wed, 30 Sep 2026 14:47:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: disable self-refresh on tearing flips
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: timur.kristof@gmail.com, alex.hung@amd.com, chiahsuan.chung@amd.com,
 ray.wu@amd.com, stable@vger.kernel.org
References: <20260930163222.557757-1-sunpeng.li@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260930163222.557757-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0401.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::25) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb78a01-d40c-41b2-c4bd-08df1f2357af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jnBLFT5hKGp5zlWyIre0g+DgsRUmfJzsmct3RVozRpsnirjvyvGkyUwGYrl5JSzTZm8k6XWyiG4nEl4r0zwDbvSQqN6OOOVKQhgt+l7pW1AA7OdZRU8V6grMPL/Zbk033RBedVJlVuuZZEv2DC4n3wEQ+DV0dEreEkZpn6/4v7uxoeJybiXGJ+R3xDx3hA0E8DNX83y3KlGS/gDqRiwIzR2f+bUL5uNrJXgj95JqrmWMero+zeyUOZtFlkI75P7oKleD4d3hIYjTbsOe4PuF2eHBya25Xe99o7Uq9EdEI4b+Z96P799hjh3DRMdUXGgOE88+rXvtzfXSVf1WMBMK4xF2nj3m/7PHayI/O5upiibPV3Qb/qy+iG3HtIWTxLilsDZkGIpPGNnzHLuQ5OMt7XdsK6XgfLVjX0Il6CHcwzv6NIG8eCPu+9Y0Yzr3iTNXqsZZCg3dAduByJb8CIhJ0vGtb0C4+HKJejBfmsFk6eNDPIHIhTTjiRxXsDkRsUfOUjLCr3EDaDc5JrzJ/uC3/hUejgN0MygHDVr39i6V5EY+r0z7OY2mG9cYheVg5o1o3wfAQO7oiidiKWL9MC3vx0d25E7eRqHfVKVNxo43K8B+PToPCOVBB3/rd7C1b/A+nRh9Xas8DqJH7moKopAsieZfLi9jbKa9pKG4rj5+eoo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7007.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TExWM0dxQXNuS1FRN21XYTZRZkl4V08rOFBKMGFuRzcwZEFqT1dPTmhuT2Rw?=
 =?utf-8?B?eENNd1FSYmpJaHgrTGRrM2x3L1JEVEtObm81Z1dKa1FIZWExMUx5MWRscFdI?=
 =?utf-8?B?Z1lhZXNnTUU0VmRqaUxVd1BKaG1IVmxVOE5semRrUkxCTkwrNG1QMDlta0Yw?=
 =?utf-8?B?SWc5Z0JYNWt5L2hQVzRlc1VRb1dqOUp1a1BGWHJycERsaDFtZnpheUlOdmZZ?=
 =?utf-8?B?U3hYbjdHME5peGxhMkNYS3MyU0N4RUtQdVRNZlAwaWxYNTdhQ0xodVJXVDVK?=
 =?utf-8?B?V0l5aVRIMnM5RllCSE5tSEdHNWY5Y3NVS2dBTVBESDExVVJRRnBRclFWY0Zt?=
 =?utf-8?B?ckFScWUwSjEva3NzWFBSWXYxYVRiTnlLdy9hZDJxekFheFN5ZTR5cWZlRUh5?=
 =?utf-8?B?SDAzUVZsN1lTWlhrWnpIU2pLNnUyK1VKYnU5ZXhlZHlOK0dBdW9nZStXM2xi?=
 =?utf-8?B?VGpES3M5TG9YcWw1aGNXbU8yMU5PWGtpRnhaa3pkZFlPalZZeEg3eE5RMXRn?=
 =?utf-8?B?MEU4bEZwVW9rNHIvVXQ2NVF2S093NU1YaExCNnZRN3pIT29Sb3JxazkwWE9m?=
 =?utf-8?B?Rm5XTjJRdmZCV0hzUjZYWllrVUZtZDNpWnQ0YlNKbVh3K2VHdDNKSzVId20r?=
 =?utf-8?B?NGh2emx4U2VFdVNhSmZJVFdIOHZ0M2RCTDJ1OEJXak95N0FRZ0xiT1l0bE41?=
 =?utf-8?B?ZERvWUpuZEJuVlExRkRsdmp2c2tKc1NkUW5Ea05KVkRZdnd2NC80Vk1JOURw?=
 =?utf-8?B?bEFWL2tXbEZwR1czckpNeDZPSW5QTmVJd1d1NWF6TWxPSEEwYnFQcEN2cGFU?=
 =?utf-8?B?RHZQS3QrNDdiY0RmV05XNU1lL00zdVdGZ1FFQnRodkZKbkNRTE5qWjVIcjRy?=
 =?utf-8?B?eERkWXpZRnlUcEhxeXFyaWptbCsxUlhmOG4xbnNsdFhPVFFPKzgvaU40V3Jo?=
 =?utf-8?B?b2t3WjRLWWpQTmdoRWJLZnRqT1RSVGZkNzdveTRQdWdmd1JPTUhqWXdBWDlB?=
 =?utf-8?B?azJNVVBIa1NKZnZwNmFNUEFJV0IrK0tlWDBmb1hRUU5Tdy80RDZNNkVMMGtj?=
 =?utf-8?B?bGkvUitHb2g4U05pWG5mdjdWWGMrNXQxOG9POGRNR2xqNk5YUUpRWC9CbW9D?=
 =?utf-8?B?UWszcDhnWklNajhuZWZ0T2N0ZXlkQU9vT3Q1WDU4TVFPbkhtVGNGUVkyZ1Rj?=
 =?utf-8?B?eXVkNG93alFnOHE0WU1UVy9BMFc3ZXZ0MHdOaGs5YVk1V2s0TnhGL1pmNlNr?=
 =?utf-8?B?SjUrYko0RWJKeEdmVllRaE1TZTRYSGlsbGNFaXA0ZHdNUDVENE03eHVtUWl3?=
 =?utf-8?B?MUlZN2Z1VytneldCMDZYZ1gxTDErNnNrSk9UcGZPVGJ5VFJiRFA5T29FeEh0?=
 =?utf-8?B?UktleUpPR2d6TkJuNFlWazdkNGYwdWhaREoxZnBKSmFUMlYyUHIvS3FZNnJK?=
 =?utf-8?B?blRGTHFhSWNZSnZMWnlabnNtQVBJMk9uWHlOYm1hbURTMWJMOW9YalhKemp2?=
 =?utf-8?B?aHc0M2orQ0xXeW9sQTdjbExudW1NczQ0QmxjR3ZLWG55alNsNWY0MEdYK2Fl?=
 =?utf-8?B?Y2ViaWJSWEZ6NG9oZDZ5RXBtT0cyVFNkZEdVMkMwQmROUmdPQWtTN2hFRkpn?=
 =?utf-8?B?M2RkVTQ5NWxHemJjbHJKbzBNdXc1SFlwSWVQUXRJUll2Nm42RGZyRVhGRFBW?=
 =?utf-8?B?UnJ1RmRsekpwYVZhRXhBNFBGTjV3cG4rSzZwckZBN25oSFF4a0xDdWR3a1Vx?=
 =?utf-8?B?cUw4cHhCN2dvaGREdmZlYXFFQlFFcGtYYnF2VEg1UTZ0OUlCYWFFVEFvVWtF?=
 =?utf-8?B?Tm9CTE9JYzNvVEFKd0YyMG5wSWREVkF4SVZyTitweTB5T2lKeXFvNCsxTWhP?=
 =?utf-8?B?ZHFlWklldVNTaWJtRU1DUTBmK0xRdUlyZXl0b1lXWGJhSFh4OEM4OC9qTDJZ?=
 =?utf-8?B?bUhTb0w4UFV1M2Vsc1ZFZHcxUTFyVXFnWGM3b0U5Sm4vTGcvbFEvYlZ3Y2ZN?=
 =?utf-8?B?TmIzQkh2SGJPbWVPWnZjWDRtTk5VbVZKUXhEWFlmNERHc0oxWU9YUzRMdVp4?=
 =?utf-8?B?Wm1ZUHIzYVRraWdMclJxTGxhb2hiYzRvUTZUM1p5NUVvT01LMnY2Vko5cGkv?=
 =?utf-8?B?REpHdTkrU3dId2ZLSjg2U3JjK1VxNE1xbHlTeEpsekRXTGNCeGtZVUNKQnFx?=
 =?utf-8?B?Z284cU1DME4xQUYzc0cwc0ZscUdXc2R4aWtNQlpRemxmVGhmeWRGejE3RXVI?=
 =?utf-8?B?UnNBZ3FlTCtHQ21PL0twZ2NGSnV5T2poSEpnVFVGZkI0cVhzTEtyY0ozYUp1?=
 =?utf-8?B?NGU1eVFJeDVvK1NmdENDSGV2alZOQUdjT0V6TDhaODZKQWpOZzJ2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb78a01-d40c-41b2-c4bd-08df1f2357af
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 18:47:56.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRZnFzgk+is1wD4/OUxwRKwWDsftxd7swdvEhOcCpYiYrrukNl83o271aOZJ70YpzmEoBx/wK/bAwRnU5sA5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114



On 2026-09-30 12:30, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why & How]
> 
> Immediate (tearing) flips breaks self refresh state machine assumptions,
> so disable PSR/Replay for them.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6e5dbe0bd82e5..d4c814eeb56d6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3764,6 +3764,13 @@ VISIBLE_IF_KUNIT void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manage
>   	struct amdgpu_dm_connector *aconn =
>   		(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
>   
> +	if (!acrtc_state->base.async_flip) {
> +		amdgpu_dm_psr_set_event(dm, acrtc_state->stream, false,
> +			psr_event_immediate_flip, false);
> +		amdgpu_dm_replay_set_event(dm, acrtc_state->stream, false,
> +			replay_event_immediate_flip, false);
> +	}
> +
>   	/* Decrement skip count when SR is enabled and we're doing fast updates. */
>   	if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
>   	    (psr->psr_feature_enabled || pr->replay_feature_enabled)) {
> @@ -4218,6 +4225,18 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
>   			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>   		}
>   		mutex_lock(&dm->dc_lock);
> +		/*
> +		 * Tearing (immediate) flips cannot work with panel self-refresh
> +		 * features. The event is cleared by
> +		 * amdgpu_dm_enable_self_refresh() once async flips stop.
> +		 */
> +		if (immediate_flip) {
> +			dc_exit_ips_for_hw_access(dm->dc);
> +			amdgpu_dm_psr_set_event(dm, acrtc_state->stream, true,
> +				psr_event_immediate_flip, true);
> +			amdgpu_dm_replay_set_event(dm, acrtc_state->stream, true,
> +				replay_event_immediate_flip, true);
> +		}
>   		update_planes_and_stream_adapter(dm->dc,
>   					 planes_count,
>   					 acrtc_state->stream,

