Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793134926;
	b=bZ2pj2YjTp7RLUdweBq0Y6EPBnegj9BR6/jCpJaDao6jy7eco+fl9id7gqONdQ77Hsu7
	 kxjBM8GHTlLuf5v4vzxCPQpADoeSIlkN3IDPuiV+UaX5ILHzzWZHibG1ouJHmFZvYJuSX
	 FIqhfKM26UU2V6AawnsV+DLrTyMJ8xz6Y7DQXb/3bpfMxbgqTIsh+E4Wii9LhZuAhpyHJ
	 0jfcDE+7s6ZHDN3OhtM0kUHeuXC5fJ6hwqE0WCXLeT/wOmmN/kWp+d+Q7fxvx3XvItCcc
	 BkZlPf/0Zvd5TxtY3qUxQR3+zJdZXw6zNW86fnHbo0jucDQThWEMg/XqPEpD5Px+hfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134926;
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
	bh=tX60HGk8mnxDRiyi7d2bcU4LNpFRQPx4s61MzX2vAz4=;
	b=q/w2M/rmS1/cqJBbT6HZwnRDQ0iCqK/f6R5KFpqCx9TC7nms4k74SE6ij3RQ3H7Hamf9
	 UteiyzevfH2HkTlH0HKRm1/bFfrg4NPZCj6AVnErk8C7ZI5KFKRJ9ERzn+RS8bF3n4sVf
	 pis7wR1wMPHcG0BsWea4CRSUslpcM3tsd15vg76clTAueNdzMfxpp36IwP/mk7BJHM3VM
	 RMWV2j/oxG5cC50qPVGjKWoqdkJ3Z7TwyA1lzp5NIBu9d5ZpfcmZ30LoMmP5ItRfyrNIu
	 EPmQWGRSQcCexYWxZPRuJHc//BlrgEdCFlXC/wOR+0tDnP4AoCejZWDQKqlcfRflqVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=k00cbHCQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.62
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F0606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C90F0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=k00cbHCQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywNFXec4P7Ah0HkyKSTZdsT1YugQFY/wgJ718qck34VYWoUdRSts6uwXE2cWjA6nnt7uKUFVJ0wMxiEmvveS5+fuusMI5en3phJ73MhxejGFsa0eQFsh1eo39crYB8lf+o6NyuSMBlmAFoR1MxtGv4tAtvzi8/0vfivEQPkDw8A7F8E/aZdbThEZua71gK2EBXXGspPHLL7NAavUMfq9KvzsmIfzw7JVDD/jGkKp0sX7lI9viCOs5+TIXbM7hERic/GVGxy0Tl6+ZA546PP/sGQnZWn9JO9YWzQBxStL4U0qPH2xWCTmHK1tn3qKFvDN0AE1fGWL86yBfF5dv7UeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX60HGk8mnxDRiyi7d2bcU4LNpFRQPx4s61MzX2vAz4=;
 b=yQYDz83ZH+Oux82xJ4YqY8+NAfZn3UP8pb4ihZkdvCzwFa2w8v8JzN9Thu3WfwCPn6vKmvJVJrsilnoSGpAsJp7wrf6QY/uiNP0r+5LIw0f8LCD7D2tEx2dRKdxAIb/sbz4+JFm05dzLPK50e2Zl22TV67MgvqgprqBSGx9fltz0qdi29dNkUBCY35LWBoTdSAu0zy7S8AFQB7ZRxRTTZH/VTpGBTa2hGiMsGU67JqdWdndPEe/FHFZsIW2b/PqetgGB2GwQRFthqB/VwdyeQCSsJoP5/aQJynSJTKMN7NNo1FqhkKhVOfg7JJ19ubu38w1mItaBj2fpp65IPQrB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX60HGk8mnxDRiyi7d2bcU4LNpFRQPx4s61MzX2vAz4=;
 b=k00cbHCQzb/brzYbJgF6EA/PHb2A3H1+Wc0P8eP/IW2O8GHTRzPlTwxgwiQluIxBwQtTXty0b/2iB+8RDf9+26UjwxhrImS3BRKgt+w82pA9zbDVOerqJ4UBAEw4Mr/SYm+5b94wD1nHKSmFDlikRMTyxP1Ej1hl4KrtOVbGnho=
Received: from CH0PR03CA0287.namprd03.prod.outlook.com (2603:10b6:610:e6::22)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:02:02 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:610:e6:cafe::80) by CH0PR03CA0287.outlook.office365.com
 (2603:10b6:610:e6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 21:02:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Tue, 27 Oct 2026 21:02:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 16:01:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 16:01:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 16:01:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<stable@vger.kernel.org>
CC: Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx12: set KMD_QUEUE for kernel gfx queues
Date: Tue, 27 Oct 2026 17:00:51 -0400
Message-ID: <20261027210051.2679583-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027210051.2679583-1-alexander.deucher@amd.com>
References: <20261027210051.2679583-1-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: a38b686e-0679-456e-eb91-08df346d8c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|11063799006|56012099006|261021121427099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0JyvEEpxa9iBl6kBCwOVoXafxoKMkVZeR/LEMIleFhQjf40Cc3MWWoj8XPuvlBeioUR45gr5RwiOEatt8cQgAXtWus0RruJFAnzWA/4XMo6XlUl/gLnnpSwR0dy1kxsm6XtaOUFHyUokvKWpYMCXTyQ6RJp2MWddo54sDGys8fbph4QrXwOZ8TNIiP8hopQrjdP3N9TxvPHju2CXP35+PbKZ/eitEEX7P4uAU6b3XaTwmeidcvJJwL8W3t2d/0xY9Z/YXM+df/qms9wzyS7cO+Azf6A3HxLXxlvGmAEUgHAQumbFuKYRDmgIvcpWC+URDLbQhmcoQ5HRiZncUWhnfvdZ1QLD5jU9Dr8R9zt05OU59wZ2tM3Go6xhkWNAJB6h/vmr2JH65rljS3diZCOFdngu3shi8mSS03gKiliAx+6DBF4WH7jyyAQP5Rpj3Dw4Fk8QkY3oNVpft542+Z5AgPum+HLm4rD9Gh86Z4Pc9sS5VDgZN5XCo3jIba+Jr69ow2fmpC1vKazCDSC8bjnflvUyUJGWWk1tjEg0RTQvoXUheFOm2zvAo1i7q+tYSdBCHnajmAlzwnu2k0ypX3Lnt+hXM0uIOlZ6qrX62rO7Mmmh2K4paa79sEHSLAnLe4SvdpoZRn95IL5i3o9tjCNY1HlrGF6/DN79KpgSCAVphtGS65kYMYOrD0tNSTk7Y0nFxXzDf+1jWmqPeeDQCXuLIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H9zf+vrd8idM8tBqbxjH7jTBPz4x4m0llTgMBtVElk1HQmSfzgu3SVr9OEsTRiNOQEQ1+oHio1MPhmDiSrdaQkebj73n0+l0dl9sDUqRBvC+KM3EekEMye3LkHoacA7aYPz9vSKIUnghTgdfuCjFXesU8IgIqNj++WaWQM9/vv408/YOrwbKeyIG0f0YxP60uxuyCcfhTuRtgixMixv6XH3R+rk0mhJEKCxJUKVevRyThy3ghNKO09JRGrdYbl9HFJ0s5YNZbIXWMqF9qIa344aatVNmSeGxzbLdTQPonqpv7ohCBIMaAzc1xsrSup5QNhIndWi3yxX0fqISoF8fFDQOXRbLr0xY0t1EZF7qWuUshiF/j9fGkA7rd95uVCpPKnYq0mmanrs4aQ8jL3XCXS2rO5TJ1vpvEPngyFfq03GT0BmZY6dVNQvS8GQnbItp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:02:01.4814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38b686e-0679-456e-eb91-08df346d8c06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225

From: Jesse Zhang <Jesse.Zhang@amd.com>

Set KMD_QUEUE in the GFX MQD and kernel ring control registers so CP
preserves kernel IB VMIDs instead of replacing them with the queue VMID.
Use prop->kernel_queue to distinguish kernel and user MQDs.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 14741c01680a803050e949744089b57fa53e02f7)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 433381f806b2..06fde713b922 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2733,6 +2733,7 @@ static int gfx_v12_0_cp_gfx_resume(struct amdgpu_device *adev)
 	rb_bufsz = order_base_2(ring->ring_size / 8);
 	tmp = REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
+	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, KMD_QUEUE, 1);
 	WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
 
 	/* Initialize the ring buffer's write pointers */
@@ -3025,6 +3026,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = regCP_GFX_HQD_CNTL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, KMD_QUEUE, prop->kernel_queue);
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
 #endif
-- 
2.56.0

