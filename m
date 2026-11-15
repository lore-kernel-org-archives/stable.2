Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794728103;
	b=VFdPCwificgjqyxj/Q0SpN8Ti/sQdzkhPAydGEkbjmyC7s4vpDYJvc9ShyOtGYO60+cv
	 QNLGkS4mkWJIS17z0tkJGuqxyu9hQoMSMZHmGyYBBeD5rUEsmaCgb+FRYEAKNFhCA2oTP
	 VR/sC4Fdjyq2TdizbmfspZpRcqqDZzQ8bM+E6JwccNz3t4E8l9aqEWLAV4rxWP8cCgAjF
	 UHWPwlpFzUP9H/w22KWF0xSnWarFo24ARRBYvTVwGqjSINJ69Th2KvYb2Mn8vm6+nMPDR
	 qntWlgpEqM7dRAR7vBwOIQFF4X1VAvN0wF91PirZNeo2OUMFtJd3ySaxF9se7cvwTKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794728103;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=g339eJT0lkbTDdLzFfIhewJtg4bnqgvhpTinAo1j/lo=;
	b=RBr4Lwd/QB86RzncAZzHFFxI6qRgGIksSlKaKSP1z0D+zFkzWbiOKaSt0kyE/P5bCUfI
	 vTYvTeM66LTTpu4mbiUrXkscL7FvV5dCea6YLWhIRnwvpwBDV5yKBQRNG7FTiX4ZEhtab
	 bUh/2luuTi7AR1bKk0dl1zsuGE8DFcK5vgKKcJdZr4Yn/hiBGEcyldrWxqHu/kipAsT1u
	 vAj3RHvyj5b2Qoz3KxryLeNQpRgiZOmzoxQLgwstXmWFlSStcj0ibLyHGLnw7EMIz39o5
	 63h7uhwc1TrMulaDwIvbvNNXfVNa18+/5iJ/kM4fiam8GHd2KXs0SvykUUPqzfyGt5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fRkAFQf6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.1
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC4606A31A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 07:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADBC4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fRkAFQf6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nR3ALipCAn+1wktdeZvdESt0sQWjOXgU1Y305tbVX21xcHBdVltome2D2/S/J3iEXId0y3/72/ZWLnGIiuhI0WguA2UJc8JdR5DNIaFd8XSuPJemrkaqpWSrxPots485e+ghsSgkdHUBq+N//cdE7zzXBMVjEYfc0HndsYS+YtEobCy97s/t73ezJaL3LG80irFIrk7rA7HfrMmoXQDKWRTwvIazIhfBzUM38rqn9AWO+o/ltVnJ9Asfe6uH+ZsEkYtirCPZBtEN/ig9TtBNSwdECUBV9N5Nk+NKVxZxZuXSgf7CktMS1FX+3vQpAjjyCXeAWA44RSv/8GVqj2xUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g339eJT0lkbTDdLzFfIhewJtg4bnqgvhpTinAo1j/lo=;
 b=HWrupOlOlcz9e68h0rMpNVrr/3WJHAcEGiQu0AnjbkaJrOEygy/PePV9+MRk/NHkazTruPTAQTBl0n27UlBQiNnE3zUbjPkJeD7Zzvd10SB+YAcZ74uMNFek7gFWjaz2FJZg8DDrgxxVdYl5R3K0lcmQA242VGxpe9cUXsbeDbWx0+Ir2GbTEqRjbxhsvzEhEf3+1UNLwtIkqGMJMbpSsffPhr7exYTOCXJYoFQNDeh2zsMPGrTr6/I0fAYgYDvHwH0FFasenEJcwcw6rIpnUZjK9eWNAI0FgGYoUkokNwG2PmnuCdyXziqapZT/iXRriE/mMm7TZ36p8C8ql+3ZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g339eJT0lkbTDdLzFfIhewJtg4bnqgvhpTinAo1j/lo=;
 b=fRkAFQf6oYRI8f8abk2iHXPVyiwpQUidPWidpBS6HI8cVcEU1YLYvLt4s9HgBDBDgm8MmCd454K3jsnAXFYdKPY3EYZ32fFWyBb5L4ZKc/ocfHdGQx3ha/d45I1UuVjNy1fzatw14RAyhPcYsYymF5vXHGexT3F9On0/iB45AZM=
Received: from BN9PR03CA0946.namprd03.prod.outlook.com (2603:10b6:408:108::21)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sun, 15 Nov
 2026 07:34:58 +0000
Received: from BN3PEPF00022BC6.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::20) by BN9PR03CA0946.outlook.office365.com
 (2603:10b6:408:108::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Sun,
 15 Nov 2026 07:34:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC6.mail.protection.outlook.com (10.167.248.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 07:34:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 15 Nov
 2026 01:34:55 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 15 Nov
 2026 01:34:30 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 01:34:28 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Abdulla Bubshait <darkstego@gmail.com>, Harry Wentland
	<harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
	<siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
	<dominik.kaszewski@amd.com>, <dri-devel@lists.freedesktop.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: Abort DPMS ON when enabling the link fails
Date: Sun, 15 Nov 2026 15:35:28 +0800
Message-ID: <20261115073528.1476262-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028202641.549955-1-darkstego@gmail.com>
References: <20261028202641.549955-1-darkstego@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC6:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: ae629b8b-cf62-4741-13bb-08df42eaf311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|261009223027099003|13003099007|11063799006|56012099006|10067099003|261026121527099003|261022075727099003|261026140227099003|261022105027099003|261021123027099003|261102123227099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	QA3OULNf2QXiR2ki84z8TMeV+tfr0HkcHRHokTU7a5/eXjVRTv0uZ1BZ01HDMrak++an2VIQ2x5kAMvMa7Wy1ir3O/YVb6rZPvl7hWS3t/6Ob5K99tU2Qk7tQoTHkIQiu+HOF0yD8r/lVOL7AJxQWXZmhCozpTXUzqvSzliN4NOXgOphFIAxt5rxluq7a0nmY1tROSKfnW3JBCZb7qz3N5rNb1R+P4KmkMi1wL7GOeTlfS+RHhQKvbiyy42Vq4wfIDaIbhYHDfbLZED4n8IUsc4B68/XTY/AaCv2hGsiDCbxYrmxvQHyZi7FqPP485/2P65ihpRDDErCAPQ/XRKFgzfem2LNNq5gkpk1N5dmhJIRjoP9+PaomaR5OVUgwur6Xh2Ua+vw+UViO6tuSSnIwnC9iuP7g+gVI+z4gfeIeXAgNQTHLUdfCtLbi6xJ9V08AH5qUpJBWX6/a2EPzjoZRgoo9B4m4gDjB2BcFKBLr5NBt3GXRsUJSlDrPIgTlwEXkoXWc+MjvAXnM7kaHVDHC9yObo+plnIim/2VWH1qw5/+cVxffUE79ITbt9cOqBzP1jntZOaRiP6Hg3dTeGWNnxLHJmznczZBtt9P5L1jZWJxRyRN2DLeG3l2if9Tw9y87kq0k2+LbmWb9tz31tAw2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(261009223027099003)(13003099007)(11063799006)(56012099006)(10067099003)(261026121527099003)(261022075727099003)(261026140227099003)(261022105027099003)(261021123027099003)(261102123227099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fou+x3jMvITTHVubxv8NJ4nv+QemnY57AMWvqFkIQ/FdVKZqo+2jXehYUc+qnMlJYlpyXit5nyTDg1QhbNCsOWJYfYOMFl0ec/CKDD63jvqaC/1++hRBZJsXZHtq+Y6N415qeX6mIp5bedIW4fKI/SP6F33IpX+ZeGJkpxumg07WqHjE6ggyTGPqpv7XW+lxR5vHsGf2j/85H4aM9aGnAZ3nVbtXuwPKcgPtx9ASfecvfrb2nav0bAlsp9DZiiozCSPSIoPNev/Pz2vt6bVSvv4jvbl9ICqQyUcb4RkC5WdtmO0bx595PaWsz7mAVvEcSgYugwOvaAgcOY13dPF50k/h9a1/KwStAC96iAt6K30xxD1E/KM1yQT6g6JQ1b1hCnv7F/QJ+0wnFcOMKXRJ3wF0wGGJfDtoABtS5+pOhiN6eSsy2lFzNM4ViygE0fkD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 07:34:57.7243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae629b8b-cf62-4741-13bb-08df42eaf311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>

On Wed, 28 Oct 2026 16:26:41 -0400, Abdulla Bubshait wrote:
> Since commit 843049bac7c0 ("drm/amd/display: Split DPMS ON into
> parts"), link_set_dpms_on_enable_link() returns
> DC_DPMS_FAILED_HANDSHAKE when enable_link() fails and the stream
> enable has to be aborted: any failure other than link training, or a
> link training failure on DP MST. The link has already been disabled at
> that point. The step loop in link_set_dpms_on() treats
> DC_DPMS_FAILED_HANDSHAKE like DC_DPMS_SUCCESS and goes on to
> link_set_dpms_on_post_enable_link().
>
> Before the split, this path returned right after disable_link(),
> because MST displays can't proceed without link training. Now, for
> failed MST handshakes MST slots are still allocated.  When the link
> trains again later, the new payload starts after the leaked slots so
> ACT never completes, and the display stays black until
> reboot. Replugging or power-cycling the monitor does not recover it.
>
> Seen on Navi 33 (DCN 3.2.1) with a DP 2.1 MST monitor (Odyssey Neo G9)
> at UHBR10 x4 with DSC. Link training sometimes fails on DPMS
> wake. With this change, the failed attempt leaves no payload behind,
> and the next modeset after the sink reconnects bring the monito back
> up.
>
> Return early on DC_DPMS_FAILED_HANDSHAKE, as for
> DC_DPMS_SKIPPED_HANDSHAKE. This restores the pre-split behaviour. Link
> training failures on non-MST signals still return DC_DPMS_SUCCESS and
> continue as before.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6047
> Fixes: 843049bac7c0 ("drm/amd/display: Split DPMS ON into parts")
> Cc: stable@vger.kernel.org # 7.3
> Signed-off-by: Abdulla Bubshait <darkstego@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> index 75e232ebffe8..b355e29b178d 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -2813,11 +2813,11 @@ enum dc_status link_set_dpms_on(
>  
>  		switch (step_result) {
>  		case DC_DPMS_SUCCESS:
> -		case DC_DPMS_FAILED_HANDSHAKE:
>  			// Enum is ordered from "best" to "worst" results
>  			result = max(result, step_result);
>  			break;
>  
> +		case DC_DPMS_FAILED_HANDSHAKE:
>  		case DC_DPMS_SKIPPED_HANDSHAKE:
>  			return step_result;
>  
> -- 
> 2.56.0
>
>
