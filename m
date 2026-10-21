Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792587331;
	b=qhYMEAUWXQQ9pj8mMUqoymy9/R0taLsALI1jR/nYLcGa5puOxgzQ0we1K5gcWYS8ZL66
	 nYXwYve0mOPrmeigIhkDVN8HZJ5RgCxY461HvaUbIbaFCEeksEp7X7Al62zpNwlCj5NaR
	 ezJlZ0B1w7TegVoWjHTj6eSd+hZoAZGNc1mOj0vNiaBZXsKYzo0h64NjrqV3hck9MObyI
	 ay8C/l/1lu12auVy9S3LeQSqLWIRPl0uHcyPOFgaGd/5brzLz8QCF/2rvwqAIS7lpxcFi
	 9b846qMlcOFSOuXF7xJEtS6FFcr+XbGhiA6aX+doIhaJ+5CiuE2cogE0g4vwn+97D1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587331;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=DvHNivsWdR1x61g8HgQTiclxwbleV9KBfDuKbiAtMSc=;
	b=kQSoXAFSrNragQ8sfYLTZ2pfqBxo2b0q+Z+6fhcyvUVTkM1Knsza5x9R33FfuTyvvt9s
	 WonTCsUfFKpdq2XPLVhCWTsxqOzBT+UtExuK7P3TRvFmbcrWz7QBq4tFS+KxL+ISCTF89
	 IddnPNgZA40mjazWerk5n4gGhQaTgcZeuS7gvo4FRurhJbaM3XDnLSKrtiXpDS8LZ/+Yo
	 71uJH7s7iGy1nnBR46u0ufYceSV6JETl6/IDxmf+rxJL7E12WnfoDzydTqnm0D0eSdyUX
	 LEqWhgayBrXhzbwXJVHrewKT0+zqAhJKQTfixT6YYmahNVh3/+JaeOf09J0LeEVXgjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fmEKrB83;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.38
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15592606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15592606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fmEKrB83
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOh++8IJRfDapU05+hb21HG4yZPBXdFNcWTkBiPMHrW6mEFIp4c1uongfhePt8kPMwcR0mmEYLgBZgdOOhZ4fbl/I4SgxlyYTuiOs6ENiy7/IRNbaxWa9k29xZpBmWH0CUipXWMfl1rWaWjkn7XOSgBxt/3CiiTEcU+dTD5P1RtF2h8JLWIZsrnIl9r/v1sCeoe1fM5zwZzkcqoJ8jo5FYGMwjdzphlxssik868aHRh7xNNEXba8b42T1MkljeMA9lJdcNGk+m9SRy7sTGW7GSTC8WdlVuXM/wPvxcmeFziVh+fo5bTZ6ogQt0efchCOvyfE54j3TAQLaJ8VvG+uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvHNivsWdR1x61g8HgQTiclxwbleV9KBfDuKbiAtMSc=;
 b=tTThhQ6PC+bjeKhE3i5SWeYHZlBskAqfHEg2P/9qDQ054PH6fRQ9jdU2wp5EFmYQhO/RdrG2WrmvTQufOuSCgLMoKe0MwnAlosp89j07dZct5/ZcKzGy6OWIJjes3juEUUxDrpfsDu4/+pGeb36q3MPYqIT63qUPfBwso75knZTbCLLQ3dcMU0+PXjqrD4uFM5PHpBi2Dn2P/Lpd1htThMWQAIJII3BsXSNfCIL4IiVrTZaAtm/zpwoQveOL9NDrWzv2pQB5P6a3woxXErtGTIpeHg9hoLcPFx/tj7fuPPZ8U1wJeE3f63fdZ3l73SAwmCg4lwjEpfVh+jsi4aUVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvHNivsWdR1x61g8HgQTiclxwbleV9KBfDuKbiAtMSc=;
 b=fmEKrB83vdoT/97I+ZlqUp0ev3eaIt0PC0TtmhOmMUBTvSTQNdwn6h+bSt1/+ue7s8Hlth96edMXLPdSVwjGjdyzT4bdy+nThH4mIzn4iP5mF5nyvXekicjIe21tWP/1z7mlcxrNBe+rIUpXFF2DbA+D4j0HC7My2w1JP/xeAUU=
Received: from DS1PR05CA0005.namprd05.prod.outlook.com (2603:10b6:8:457::8) by
 PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Wed, 21 Oct 2026 12:55:24 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:8:457:cafe::1f) by DS1PR05CA0005.outlook.office365.com
 (2603:10b6:8:457::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 12:55:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 12:55:23 +0000
Received: from ubuntu-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 21 Oct 2026 07:55:22 -0500
From: Leo Liu <leo.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: "Liu, Leo" <Leo.Liu@amd.com>, <stable@vger.kernel.org>, Leo Liu
	<leo.liu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg
Date: Wed, 21 Oct 2026 08:54:44 -0400
Message-ID: <20261021125444.27886-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020193212.19760-1-leo.liu@amd.com>
References: <20261020193212.19760-1-leo.liu@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da30586-d7af-4fa4-a81b-08df2f72924f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|42112799006|36860700016|23010399003|82310400026|56012099006|260925022911599003|261009221227099003|260925021311599003|260925021911599003|11063799006|261009221727099003|261009223027099003|261009223327099003|261009220027099003|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	cA2zwNFg/RSFCrUpxVuXyLAbe+wlicHWg9kNdxb+jnAGvbzoe5itx1zxVhyGANuPUSk3IpKaBYPHP/YdvXu0aezz1yLORhCNLbl+JN3TvH7dN1CKw4qyT0MdAwal5LOiCYhtVbkcLaNu5pj/ZjwTwyye2LguZ38OC8YyuoiapKJrAXnhlrtnviDBE8R7SqmhLCb2iq7k2GSehfm41oQ1TmRowWbGvObICQllPWf3GIgp+QPTNvV4NPPVXVBeWX5xPwEEPPuLxmjE53L4E60C3RpVRidkHyFUKgOYcx8c/6wO9FwRup59pKh7i/YmJigTp6X5piMdKDe3mIt/ZkwqAA2twuhgafRCXCt85Gm/wxeVung3kuW2dfVOld3cymVx0GJbfDLJgv8kluEz4CJl7jVg+Oin7tWALhVvH29TmtAH8ce1QUCsCklpXzmnNeseTRuWRjq2BNxbLK7nId9yjBZyBRA/XuIWGqusjT5VMQUalZelI41gSToRcxXrw+S5s38+l7zz4Y7hRgRsXLVLO0efk//REQ9Rezd7+eZNkBjjIn/XOrpbBB7QwPTPFoGXivSx9iW7FoTf4mvUsUjaSeL49epucO+IP/xInQHzazxFs1AjSq1Wc66EtU+52kaoKap86tvWwqjlZ9BM0w+m4XuWtP/kAdnT9MDB8M4LJ4D6KWlFs5jhDRt+HmvG40wDBmK0f+C9z7M2MkE0fIqqVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(42112799006)(36860700016)(23010399003)(82310400026)(56012099006)(260925022911599003)(261009221227099003)(260925021311599003)(260925021911599003)(11063799006)(261009221727099003)(261009223027099003)(261009223327099003)(261009220027099003)(10067099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qI2NdoeFAIuRAjnZMLlHT6xF/gfNsEtf+DjWLZeQ6t0/gx+HasObB2iGwHAucsIYWAVYmBKHw3/ganbKAxRnCSzeL8aO7nCuCAo/UF6a2HuQTeaNleeqXv35wqBTHwnK1J4UW4CmDZ3xoNTauIwYhkq6VQ+iR6iaZNR+5B0WAgiyRBsfhlc7cRTN8wv0zesIij5Aacept1hd1siM35p/qgxPQMNIUwv3HicwCmGqCJoJA8sDja+gGnlQbiXTz8I+zZs+qKk1dCFUe/ANkWGZVXfVmB03qFF4ibtl0WdsuFbhiBf444l2enFv7KD36kmjToLH5Nf21tAJnFGt9t0BzgmTJdXeiIjtzJXUAhhYXyk3zknY2rzenHOKdOFmhSPeN9eM9QjhqI6e6sqg92YQJO88S+lcPNTaWURUZ7lfD0Pzy8QzQzq96I0GnhEPFefC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 12:55:23.6587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da30586-d7af-4fa4-a81b-08df2f72924f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326

From: "Liu, Leo" <Leo.Liu@amd.com>

When hw_init() fails, amdgpu_device_ip_fini_early() skips hw_fini()
because status.hw was never set.  For VCN, UVD (including UVD ENC), VCE,
and JPEG, hw_fini() is where cancel_delayed_work_sync() is called.  Any
idle work queued during the partial hw_init() is therefore left pending
after sw_fini() frees the adev state the handler touches.

Cancel the idle work in each hw_init() error path, immediately before
returning the error, so that hw_fini() remains the sole cancel site on
the normal teardown path with no duplication.

Link: https://github.com/ROCm/amdgpu/issues/234
Fixes: 416e1fab4752 ("drm/amdgpu: drop redundant cancel_delayed_work_sync call")
Cc: stable@vger.kernel.org
Assisted-by: Claude:Claude-Sonnet-4.6
Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c    |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c    |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 11 +++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  | 10 +++++++++-
 29 files changed, 174 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 72069b77f6f1..7ce3396b1431 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -159,11 +159,15 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
+	int r;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
 
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 2968256d4cd7..46293664fd28 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -221,10 +221,14 @@ static int jpeg_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 564e40899df2..361d0f4b4bc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -174,11 +174,15 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
+	int r;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
 
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index b29ca3a49939..4e8eed2b62db 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -204,10 +204,14 @@ static int jpeg_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 0343a64595f2..1925d3092d02 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -435,12 +435,16 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 							VCN_JPEG_DB_CTRL__EN_MASK);
 				r = amdgpu_ring_test_helper(ring);
 				if (r)
-					return r;
+					goto error;
 			}
 		}
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 4da3f9c995c1..a1496412810c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -232,10 +232,14 @@ static int jpeg_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
 		ring = adev->jpeg.inst[i].ring_dec;
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index dcdb089b4308..1a4594d5d952 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -173,9 +173,13 @@ static int jpeg_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		return r;
+		goto error;
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index f2debf6b6bd0..efdc537ec81e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -307,11 +307,15 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 						    VCN_JPEG_DB_CTRL__EN_MASK);
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 		}
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index dd0abce73687..eb3dc9558e0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -280,11 +280,15 @@ static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 						    VCN_JPEG_DB_CTRL__EN_MASK);
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 		}
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 8ddd12740a04..0cbb2b8a7e78 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -156,9 +156,13 @@ static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		return r;
+		goto error;
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index ff7128a11cad..97c265daa2bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -710,7 +710,9 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 	amdgpu_ring_commit(ring);
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index cf304b489d87..90b57a08d6dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -198,7 +198,9 @@ static int uvd_v4_2_hw_init(struct amdgpu_ip_block *ip_block)
 	amdgpu_ring_commit(ring);
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 564d8fb58905..aa75b2691d57 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -190,7 +190,9 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
 	amdgpu_ring_commit(ring);
 
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index dcb8487e22b1..3016227cf0ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -515,7 +515,9 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 done:
-	if (!r) {
+	if (r) {
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	} else {
 		if (uvd_v6_0_enc_support(adev))
 			drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized successfully.\n");
 		else
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 46222fc30be6..48eac56f758e 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -583,7 +583,9 @@ static int uvd_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 done:
-	if (!r)
+	if (r)
+		cancel_delayed_work_sync(&adev->uvd.idle_work);
+	else
 		drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized successfully.\n");
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index b1428f5bbc81..0ba9bab7c921 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -651,12 +651,16 @@ static int vce_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vce.num_rings; i++) {
 		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	dev_info(adev->dev, "VCE initialized successfully.\n");
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+	return r;
 }
 
 static int vce_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index dd870ecac2a4..20a4cb6d17fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -483,12 +483,16 @@ static int vce_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vce.num_rings; i++) {
 		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+	return r;
 }
 
 static int vce_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index d5adccd3e689..7637305df7e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -482,12 +482,16 @@ static int vce_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vce.num_rings; i++) {
 		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+	return r;
 }
 
 static int vce_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index ee445d8abe47..4e1fbc7b50f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -533,12 +533,16 @@ static int vce_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vce.num_rings; i++) {
 		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+	return r;
 }
 
 static int vce_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 76793a5caa70..b3e63d6e79a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -252,18 +252,25 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		return r;
+		goto error_vcn;
 
 	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
 		ring = &adev->vcn.inst->ring_enc[i];
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error_vcn;
 	}
 
 	ring = adev->jpeg.inst->ring_dec;
 	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		goto error_both;
+	return 0;
 
+error_both:
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+error_vcn:
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 7d2b9e4b913a..12ac20484396 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -294,7 +294,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		return r;
+		goto error;
 
 	//Disable vcn decode for sriov
 	if (amdgpu_sriov_vf(adev))
@@ -304,10 +304,14 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 		ring = &adev->vcn.inst->ring_enc[i];
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 10ef5616b2f5..2b2abe689508 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -481,18 +481,26 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 
 			for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
 				ring = &adev->vcn.inst[j].ring_enc[i];
 				r = amdgpu_ring_test_helper(ring);
 				if (r)
-					return r;
+					goto error;
 			}
 		}
 	}
 
 	return r;
+
+error:
+	for (i = 0; i <= j; i++) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+	}
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 0f4f4d66e2e4..6543f21daa1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -417,18 +417,26 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 
 			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
 				ring = &adev->vcn.inst[i].ring_enc[j];
 				r = amdgpu_ring_test_helper(ring);
 				if (r)
-					return r;
+					goto error;
 			}
 		}
 	}
 
 	return 0;
+
+error:
+	while (i >= 0) {
+		if (!(adev->vcn.harvest_config & (1 << i)))
+			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		i--;
+	}
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 4b7f7bbe18da..8b5646297c2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -349,11 +349,19 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 		}
 	}
 
 	return 0;
+
+error:
+	while (i >= 0) {
+		if (!(adev->vcn.harvest_config & (1 << i)))
+			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		i--;
+	}
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 3f39aa83c319..0c58ca25d7b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -395,11 +395,19 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 		}
 	}
 
 	return r;
+
+error:
+	while (i >= 0) {
+		if (!(adev->vcn.harvest_config & (1 << i)))
+			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		i--;
+	}
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f30f80c1b07f..a6eaa57ec2ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -303,10 +303,18 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	while (i >= 0) {
+		if (!(adev->vcn.harvest_config & (1 << i)))
+			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		i--;
+	}
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 7b7c3bc9f046..055729a42094 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -267,10 +267,18 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	while (i >= 0) {
+		if (!(adev->vcn.harvest_config & (1 << i)))
+			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		i--;
+	}
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index c9e990ab297d..55a4b2f9463f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -342,11 +342,19 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 		}
 	}
 
 	return 0;
+
+error:
+	while (i >= 0) {
+		if (!(adev->vcn.harvest_config & (1 << i)))
+			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		i--;
+	}
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index ed47ddd5b08c..ea6cdbcb6352 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -257,11 +257,19 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				return r;
+				goto error;
 		}
 	}
 
 	return 0;
+
+error:
+	while (i >= 0) {
+		if (!(adev->vcn.harvest_config & (1 << i)))
+			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		i--;
+	}
+	return r;
 }
 
 /**
-- 
2.43.0

