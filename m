Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794728090;
	b=V8QhM/V0uwrbFUWkvTEhzN6FHqdKXADylHXi41uqD8TeNacGfX5aHnhF4WT6BHd5OPuk
	 vQBdqso0iF3+uI93wuGVdlTeh6kx1enwdjbSmKEcfwpYRHUh4J0UVQmKASunxsbTKX6TA
	 EkO/lHrCmF6Tjh48YKJF8CsAc/1PLOhX9sYNR6A0VOZ4B57Oi/JkAEQT95fsDiPMzXnLD
	 iMRXQcCgdllPwKTMyAQnB7k0AJyqYRYSkB5KieJssxL5dkqGtR2gYE3H+9l7SEFswlZFF
	 r8mutfYw9xIgs6KSWuDHXkCwoty8c+4E/SchaNpVIEC+P1EvKjqrvkwLklM99nEM4sA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794728090;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=timNZLT0duMFMtYDBuRsl1BtmgVw5bpHD+YLnA4La70=;
	b=hmnvP48xDDSr+g4RMhXNRR0AYOcEDxqYGYGhiTa3T5px3Zj0UxJUDdrE79cJVs3/ewxf
	 rCS+/LcoaQ3LXPxrrvkgDRtJtMjg2ZnIjCSRYTSMN+IqknilMufNovan7ngbr2G0FfpLv
	 h16WtKNspl4TOWPNh2exXqWjYtmybNhHLk/9Xq6UV2aErS8gEp9+vUnrM0ivmediZMYOy
	 LyH5i8GZn2voDX8f1yeSauiobHC6KldGGx/PCqIYHATEjHhHWsYd/UGBDqFwkzGVv0kUj
	 HW/EUgJJ+DClLa8R6RtSgA6iGGVFQLniHqn3advegQbuoN5Tz88xDRLWrfO2snKCcuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KR4b8ktd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.4
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC1606A31A;
	Sun, 15 Nov 2026 07:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EAC1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KR4b8ktd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGwjScOhpfgGX4FrtvzVjxF/8m59Ee/CrNkQ8FDqpoUK5VId7zS1e3+yYrbeK7mp8dNPcVil6FfY7AZSb716CW6UFmOvfO6ly4TCW5hYq4vfBg1smBXkV3Vboknq0pyzyREbXc6TnspFRQg6wJPVHa7xfXihbH18+d3NLweaO3DfSTV14mmPV00zw3BiR0+CkrqU8BnLOPY3HLEA3nygT22RfgSGMFVRQ8hF/b3374z4VrVTF0vt85HjWtMtBg2fp9Ha3l7eJUWE0wtyWbNe6h8+0zpluukZNQ1J8Z7VyrlGUv7ZC5oYWkFZg/+RWMVp9OGaIIkzVXACwv+rmLUK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=timNZLT0duMFMtYDBuRsl1BtmgVw5bpHD+YLnA4La70=;
 b=isasvz5lTR1X1gBRW7xNc8pfU87fT9Y8l83RwPcBJcIS1fN0vRSGnnpJKtonvAGhC9wckrPuiA9U3RctaPr+/plOdUlVyDByM9BxlElPXILCWpaTuGv/izoI1/zhBww5F5wmFs454g9OkVJQ2CMWHLjQ8E9V1WN1D6iCZ7/k7dx82H9vY88+cpYVjdSagUb5RQbFdg/6UGyDy4U1HanlJq4f+hHyli7JcoVWukTjO03uWLqVO12SJ4ed0aVN150KnzWVHVOn2C4ln5zCvBhEFrzGq2I1znYQoFppC5JFeaveqP3Yzp9D3NrPUe1qeFoQAae6wswCoxbBypC1A0OuCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=timNZLT0duMFMtYDBuRsl1BtmgVw5bpHD+YLnA4La70=;
 b=KR4b8ktdKRW3E76Dd4keHgNXg4Sv4dl9+YW4dDrN5G4NZG7M3Q+7qr7CWbWgPBpZVO301MHjFkdo9cdXmoO3RI8x3oDsl7G5lKMTFmiPCQvwpcScygJJ0lJ6car17vivJkEPwB8/zzo8UsqjJoBtJEqaVJHDoJB4XQaldPFjm1Y=
Received: from CH2PR14CA0014.namprd14.prod.outlook.com (2603:10b6:610:60::24)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sun, 15 Nov
 2026 07:34:42 +0000
Received: from BN3PEPF00022BC2.namprd05.prod.outlook.com
 (2603:10b6:610:60:cafe::98) by CH2PR14CA0014.outlook.office365.com
 (2603:10b6:610:60::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Sun,
 15 Nov 2026 07:34:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC2.mail.protection.outlook.com (10.167.248.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 07:34:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 15 Nov
 2026 01:34:38 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 01:34:36 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Adrian Betschart <adrian.betschart@cinemaone.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Harry
 Wentland" <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Rodrigo
 Siqueira" <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: Apply the HDMI RGB range default only to HDMI signals
Date: Sun, 15 Nov 2026 15:35:32 +0800
Message-ID: <20261115073532.1476282-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029074558.41383-1-adrian.betschart@cinemaone.ch>
References: <20261029074558.41383-1-adrian.betschart@cinemaone.ch>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC2:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: ca473c1b-fa8e-49a9-7933-08df42eae92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|5023799004|56012099006|261028144727099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|261021123027099003|261026121527099003|261102130727099003|261102123227099003|10067099003|261026140227099003|261009223027099003|18002099003|22082099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	m7C/QBsX2pWeqZV+VQRR7gntFev3s7BJOSeRK22A0ctwDTZWFQHErBlgEtTvamWnHkexGnyGUEI9k4tYmchJR6aDuXodjNYKhLq4bwmLygltLNvXB8EIu2ZDa0WDNm1pjuQoKkT6gI3Yq7vPliVbKkbfkZoQEV21jP3/h9EBpJTGxvmK5b4wPzc4IlbdNlxUEKm33ZqZz8+lYUSwSUORmOSBeRim8vVU7Wcag3mcT+/WSK3Qgir2Eoboek9S7k+3nzLSWDkiM8fp4eTmeyojZtGFKkZrZCegcuZ16AnnDMNsYQiI5zpjselCCdb1sLFpJ6Njo7RCSPwOrqimZjKvglziEU7++aGTSipyq6QC3rOGk0m4846zdAFsUNkoTMkkOl0iRVUysHv78XepIoy/knCiO2ACCSTKZBPl7HTm7PJDQv2Zuwxy+FSLIEDTfiIVRnVcLelRGrLlEsFKMuTMVs6loHSc3pNDMHsFLQLv6LehZ2fPMO7qpCJP/sBPPKaqHCiv1c4XoZHwAcd92XIlAqF14/e0u5XrMnCGw0qiYiJFfR7N8lWo3KkYLyjqTs8DpbYRc4BihfbncuhYBfN1IdOf1I2sRwpOwNg3pyZkdPdSphfO3acuuyQNrobX8VhX4Px1pIitzx4eigjZHlEYOw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(5023799004)(56012099006)(261028144727099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021123027099003)(261026121527099003)(261102130727099003)(261102123227099003)(10067099003)(261026140227099003)(261009223027099003)(18002099003)(22082099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cbGSkl3Z+K29n/TZ5XPB/lrVzbYoXK98wa92wdXVk4FlNmqgELGw547yyRTnMAAphhwcsb1+PywBq64ig+F/Ch0ohIPDxk/qjtmz41HYVJ5DEFx0ha4KVczX0NLP3cMXc4wpnPS3FJXvQggBoKl3Pbd4My8T+pCnIBmDGgkeogab6aLKXo7lyuzDXZikDi0lnz+G+rV8jX6kvo6OtL/ReTKmUyNlSx1O3+RA1fLBYQeMGejjBGJ8G4T4U4avhjyQPpEcOHtlMHoAoxRQpLVpQFao/I5aAqrYMjYyArs0O2UQ+f7ge0p4Onno8LHnqwhiI0oSIOOI9guygflPWtX3GIkVS2RQHp8CvDvDGqEvvN1izN8fprjR2IhLCKK5kbfryj6URUKGO4uTZ4a36+L3iTzy9UtAtKyB5KnlJxKqHBLfd8/DAEux/CYSmahk4F/p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 07:34:41.1119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca473c1b-fa8e-49a9-7933-08df42eae92a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>

On Thu, 29 Oct 2026 08:45:58 +0100, Adrian Betschart wrote:
> Since eb5650d1f367, Broadcast RGB "Automatic" selects limited range on
> CTA modes when display_info.is_hdmi is set. That flag comes from an HDMI
> VSDB in the EDID and says nothing about the link, so a native
> DisplayPort monitor whose EDID carries an HDMI VSDB now gets limited
> range on CTA modes too. Monitors that ignore the DP range signal show
> grey blacks, where 7.2 sent full range.
>
> Require an HDMI signal as well, as the original commit intended. DP++
> passive adapters drive an HDMI signal and keep the HDMI behaviour;
> native DP, DP MST and active DP-to-HDMI converters get full range again.
>
> Reported and analysed by Andrés Rodríguez in the issue below.
>
> Fixes: eb5650d1f367 ("drm/amd/display: Default HDMI RGB output to limited range on CTA modes")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/6052
> Cc: stable@vger.kernel.org # 7.3
> Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
> Assisted-by: Claude Code:claude-opus-5-5
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +--
>  .../display/amdgpu_dm/amdgpu_dm_connector.c   | 16 ++--
>  .../display/amdgpu_dm/amdgpu_dm_connector.h   |  3 +-
>  .../tests/amdgpu_dm_connector_test.c          | 90 ++++++++++++++-----
>  4 files changed, 89 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dfbc384fbbdb..4f6d31812447 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5216,9 +5216,11 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
>  		scaling_changed = is_scaling_state_different(dm_new_con_state,
>  							     dm_old_con_state);
>  
> -		if ((new_con_state->hdmi.broadcast_rgb != old_con_state->hdmi.broadcast_rgb) &&
> -			(dm_old_crtc_state->stream->output_color_space !=
> -				amdgpu_dm_get_output_color_space(&dm_new_crtc_state->stream->timing, new_con_state)))
> +		if (new_con_state->hdmi.broadcast_rgb != old_con_state->hdmi.broadcast_rgb &&
> +		    dm_old_crtc_state->stream->output_color_space !=
> +		    amdgpu_dm_get_output_color_space(&dm_new_crtc_state->stream->timing,
> +						     new_con_state,
> +						     dm_new_crtc_state->stream->signal))
>  			output_color_space_changed = true;
>  
>  		abm_changed = dm_new_crtc_state->abm_level !=
> @@ -5240,8 +5242,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
>  		}
>  
>  		if (output_color_space_changed) {
> -			dm_new_crtc_state->stream->output_color_space
> -				= amdgpu_dm_get_output_color_space(&dm_new_crtc_state->stream->timing, new_con_state);
> +			dm_new_crtc_state->stream->output_color_space =
> +				amdgpu_dm_get_output_color_space(&dm_new_crtc_state->stream->timing,
> +								 new_con_state,
> +								 dm_new_crtc_state->stream->signal);
>  
>  			stream_update.output_color_space = &dm_new_crtc_state->stream->output_color_space;
>  		}
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index bc5745a5ba37..f663daf19d6a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -739,7 +739,8 @@ EXPORT_IF_KUNIT(get_aspect_ratio);
>   * With Broadcast RGB left at Automatic follow that default, as i915 does.
>   */
>  static bool rgb_output_is_limited_range(const struct dc_crtc_timing *dc_crtc_timing,
> -					const struct drm_connector_state *connector_state)
> +					const struct drm_connector_state *connector_state,
> +					enum signal_type signal)
>  {
>  	switch (connector_state->hdmi.broadcast_rgb) {
>  	case DRM_HDMI_BROADCAST_RGB_FULL:
> @@ -747,14 +748,16 @@ static bool rgb_output_is_limited_range(const struct dc_crtc_timing *dc_crtc_tim
>  	case DRM_HDMI_BROADCAST_RGB_LIMITED:
>  		return true;
>  	default:
> -		return connector_state->connector->display_info.is_hdmi &&
> +		return dc_is_hdmi_signal(signal) &&
> +		       connector_state->connector->display_info.is_hdmi &&
>  		       dc_crtc_timing->vic > 1;
>  	}
>  }
>  
>  enum dc_color_space
>  amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
> -				 const struct drm_connector_state *connector_state)
> +				 const struct drm_connector_state *connector_state,
> +				 enum signal_type signal)
>  {
>  	enum dc_color_space color_space = COLOR_SPACE_SRGB;
>  
> @@ -777,7 +780,7 @@ amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
>  	case DRM_MODE_COLORIMETRY_BT2020_RGB:
>  	case DRM_MODE_COLORIMETRY_BT2020_YCC:
>  		if (dc_crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB) {
> -			if (rgb_output_is_limited_range(dc_crtc_timing, connector_state))
> +			if (rgb_output_is_limited_range(dc_crtc_timing, connector_state, signal))
>  				color_space = COLOR_SPACE_2020_RGB_LIMITEDRANGE;
>  			else
>  				color_space = COLOR_SPACE_2020_RGB_FULLRANGE;
> @@ -789,7 +792,7 @@ amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
>  	default:
>  		if (dc_crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB) {
>  			color_space = COLOR_SPACE_SRGB;
> -			if (rgb_output_is_limited_range(dc_crtc_timing, connector_state))
> +			if (rgb_output_is_limited_range(dc_crtc_timing, connector_state, signal))
>  				color_space = COLOR_SPACE_SRGB_LIMITED;
>  		/*
>  		 * 27030khz is the separation point between HDTV and SDTV
> @@ -983,7 +986,8 @@ STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
>  	if (is_hdmi_ep)
>  		adjust_colour_depth_from_display_info(timing_out, info);
>  
> -	stream->output_color_space = amdgpu_dm_get_output_color_space(timing_out, connector_state);
> +	stream->output_color_space = amdgpu_dm_get_output_color_space(timing_out, connector_state,
> +								      stream->signal);
>  	stream->content_type = get_output_content_type(connector_state);
>  }
>  EXPORT_IF_KUNIT(fill_stream_properties_from_drm_display_mode);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> index 7bfbb6853833..496d2037e0c0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> @@ -129,7 +129,8 @@ int amdgpu_dm_fill_hdr_info_packet(const struct drm_connector_state *state,
>  
>  enum dc_color_space
>  amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
> -		       const struct drm_connector_state *connector_state);
> +		       const struct drm_connector_state *connector_state,
> +		       enum signal_type signal);
>  
>  struct drm_display_mode *
>  amdgpu_dm_get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> index acde20241f43..f2d9798667d8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> @@ -422,7 +422,8 @@ static void dm_test_output_color_space_default_rgb_full(struct kunit *test)
>  	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
>  	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_SRGB);
>  }
>  
> @@ -439,7 +440,8 @@ static void dm_test_output_color_space_default_rgb_limited(struct kunit *test)
>  	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
>  	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_LIMITED;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_SRGB_LIMITED);
>  }
>  
> @@ -457,7 +459,8 @@ static void dm_test_output_color_space_default_ycbcr709(struct kunit *test)
>  	timing.flags.Y_ONLY = 0;
>  	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_YCBCR709);
>  }
>  
> @@ -476,7 +479,8 @@ static void dm_test_output_color_space_default_ycbcr601_limited(struct kunit *te
>  	timing.flags.Y_ONLY = 1;
>  	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_YCBCR601_LIMITED);
>  }
>  
> @@ -492,7 +496,8 @@ static void dm_test_output_color_space_bt601_y_only(struct kunit *test)
>  	timing.flags.Y_ONLY = 1;
>  	state.colorspace = DRM_MODE_COLORIMETRY_BT601_YCC;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_YCBCR601_LIMITED);
>  }
>  
> @@ -508,7 +513,8 @@ static void dm_test_output_color_space_bt601(struct kunit *test)
>  	timing.flags.Y_ONLY = 0;
>  	state.colorspace = DRM_MODE_COLORIMETRY_BT601_YCC;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_YCBCR601);
>  }
>  
> @@ -524,7 +530,8 @@ static void dm_test_output_color_space_bt709(struct kunit *test)
>  	timing.flags.Y_ONLY = 0;
>  	state.colorspace = DRM_MODE_COLORIMETRY_BT709_YCC;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_YCBCR709);
>  }
>  
> @@ -540,7 +547,8 @@ static void dm_test_output_color_space_bt709_y_only(struct kunit *test)
>  	timing.flags.Y_ONLY = 1;
>  	state.colorspace = DRM_MODE_COLORIMETRY_BT709_YCC;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_YCBCR709_LIMITED);
>  }
>  
> @@ -555,7 +563,8 @@ static void dm_test_output_color_space_oprgb(struct kunit *test)
>  
>  	state.colorspace = DRM_MODE_COLORIMETRY_OPRGB;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_ADOBERGB);
>  }
>  
> @@ -573,7 +582,8 @@ static void dm_test_output_color_space_bt2020_rgb(struct kunit *test)
>  	timing.pixel_encoding = PIXEL_ENCODING_RGB;
>  	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_RGB;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_2020_RGB_FULLRANGE);
>  }
>  
> @@ -590,7 +600,8 @@ static void dm_test_output_color_space_bt2020_rgb_limited(struct kunit *test)
>  	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_RGB;
>  	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_LIMITED;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_2020_RGB_LIMITEDRANGE);
>  }
>  
> @@ -611,7 +622,8 @@ static void dm_test_output_color_space_default_rgb_auto_hdmi_cta(struct kunit *t
>  	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
>  	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_SRGB_LIMITED);
>  }
>  
> @@ -632,7 +644,8 @@ static void dm_test_output_color_space_default_rgb_auto_hdmi_vga(struct kunit *t
>  	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
>  	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_SRGB);
>  }
>  
> @@ -652,7 +665,31 @@ static void dm_test_output_color_space_default_rgb_auto_dp_cta(struct kunit *tes
>  	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
>  	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_DISPLAY_PORT),
> +			(int)COLOR_SPACE_SRGB);
> +}
> +
> +/**
> + * dm_test_output_color_space_default_rgb_auto_dp_hdmi_vsdb - Automatic on DP stays full range
> + * even when the EDID has an HDMI VSDB
> + * @test: The KUnit test context
> + */
> +static void dm_test_output_color_space_default_rgb_auto_dp_hdmi_vsdb(struct kunit *test)
> +{
> +	struct dc_crtc_timing timing = {};
> +	struct drm_connector_state state = {};
> +	struct drm_connector *connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
> +
> +	connector->display_info.is_hdmi = true;
> +	timing.pixel_encoding = PIXEL_ENCODING_RGB;
> +	timing.vic = 118;
> +	state.connector = connector;
> +	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
> +	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
> +
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_DISPLAY_PORT),
>  			(int)COLOR_SPACE_SRGB);
>  }
>  
> @@ -673,7 +710,8 @@ static void dm_test_output_color_space_default_rgb_full_hdmi_cta(struct kunit *t
>  	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
>  	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_FULL;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_SRGB);
>  }
>  
> @@ -694,7 +732,8 @@ static void dm_test_output_color_space_bt2020_rgb_auto_hdmi_cta(struct kunit *te
>  	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_RGB;
>  	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_2020_RGB_LIMITEDRANGE);
>  }
>  
> @@ -710,7 +749,8 @@ static void dm_test_output_color_space_bt2020_ycc(struct kunit *test)
>  	timing.pixel_encoding = PIXEL_ENCODING_YCBCR422;
>  	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_YCC;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_2020_YCBCR_LIMITED);
>  }
>  
> @@ -729,7 +769,8 @@ static void dm_test_output_color_space_default_ycbcr709_y_only(struct kunit *tes
>  	timing.flags.Y_ONLY = 1;
>  	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_YCBCR709_LIMITED);
>  }
>  
> @@ -748,7 +789,8 @@ static void dm_test_output_color_space_default_ycbcr601(struct kunit *test)
>  	timing.flags.Y_ONLY = 0;
>  	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_YCBCR601);
>  }
>  
> @@ -767,7 +809,8 @@ static void dm_test_output_color_space_bt2020_ycc_rgb_encoding(struct kunit *tes
>  	timing.pixel_encoding = PIXEL_ENCODING_RGB;
>  	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_YCC;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_2020_RGB_FULLRANGE);
>  }
>  
> @@ -785,7 +828,8 @@ static void dm_test_output_color_space_bt2020_ycc_rgb_encoding_limited(struct ku
>  	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_YCC;
>  	state.hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_LIMITED;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_2020_RGB_LIMITEDRANGE);
>  }
>  
> @@ -802,7 +846,8 @@ static void dm_test_output_color_space_bt2020_rgb_ycc_encoding(struct kunit *tes
>  	timing.pixel_encoding = PIXEL_ENCODING_YCBCR444;
>  	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_RGB;
>  
> -	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
> +	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state,
> +								    SIGNAL_TYPE_HDMI_TYPE_A),
>  			(int)COLOR_SPACE_2020_YCBCR_LIMITED);
>  }
>  
> @@ -10058,6 +10103,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
>  	KUNIT_CASE(dm_test_output_color_space_default_rgb_auto_hdmi_cta),
>  	KUNIT_CASE(dm_test_output_color_space_default_rgb_auto_hdmi_vga),
>  	KUNIT_CASE(dm_test_output_color_space_default_rgb_auto_dp_cta),
> +	KUNIT_CASE(dm_test_output_color_space_default_rgb_auto_dp_hdmi_vsdb),
>  	KUNIT_CASE(dm_test_output_color_space_default_rgb_full_hdmi_cta),
>  	KUNIT_CASE(dm_test_output_color_space_bt2020_rgb_auto_hdmi_cta),
>  	KUNIT_CASE(dm_test_output_color_space_bt2020_ycc),
> -- 
> 2.56.0
>
>
