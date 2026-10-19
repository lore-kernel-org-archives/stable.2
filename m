Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792424417;
	b=Fd9p7VgzOi31RsLncKXxMVIg7x0LxwF7ZmVRH5+g+tvRCGdN6LY/JNeaWDIRDGXTNB5o
	 acuz7qsZW13Bl2g/PcihtOs8zlo/WxwxLM1OPS0e0xxsrnKZ8xHovp4bnUT81s2ga0p6i
	 y8hsqpvH42MCXqVQdrp7cQ5aatrnTFFvENnuZHglJyhLPM5iPHNVks1xGpQ3ycqZYz2Ke
	 I7abneT2MdlPzCrIVD/tQg262KhJidc3p45WFhZIBJM97ufrIMYms67A47+rqd4N+hN9q
	 m6ULazo6Ms8wkmtE0SeNCcMW1f58fvEoRW9yA7wG/6zxaOyeNwoLDE4VEh16Z+P9j8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424417;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
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
	bh=yN3pUTgg/eFr4wScc577eV0g/fiSYisSUGEJiGw+EC0=;
	b=ez3pcjyZhi+T4UF6A+iSjIClzM8J9gDArKo0ef6Nw1HvG52fDZLpwZk3sQXgMjpj2vs/
	 cQnm56Q8m47R+sIIiLw9ikYmQfaGZWOKF0kqO8oCKpGZT49GHpN2ZiC2Sp/qQqBbRlHNY
	 ZKStbaym5C2gCB4zjrlJqlUTVlTJmqzFAcAoHEYBLNsg7XaxPre4hyRdw/FpdmfnLfRy2
	 tsB/YTqBbxqHdmbK7H5ZF5j/F7h2pNozNbtrYSG/7Jg4pWqBbZ07NloRbxfO6FpD+ZuEM
	 aekqxxDlMfaVsaYXIodOmCrw9vKZ5wmhKFObaMLUaYBTswORd7TvtOQekq6U2X79ffw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=r+JIyqOt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.24
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1FF608484A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E1FF608484A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=r+JIyqOt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXEmdxBnVXo09ba5iiAnHBJap+3JpHRkxBxDTBXTydULVkPKeXoaSGJTm+J0iG8YRAcal5C/oU9yTDuTmAHEL1z2benf9FXWZ8Bj4ZU+FcCmsadoEycnZ/hJvT5WFYqVpvErp/REb0QrGpnW0kQktwH/if+p35J6VzBOEaoay77ZjJ7GMo1H4mHpQbgqT2Uud8awsbtL6n9fEZ6MXoUz1Lhc8QsvSoveKwRWEgFMzv23hD0B3ozoNaGraButVj9c5eOBVBpxXE8rR3D2ZO7bX3TYukCznhAj1pdr/sQ1cudG1S/LPgFSaNt5V+3lafYhx5RnqxqIgnKrprkXyy59BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN3pUTgg/eFr4wScc577eV0g/fiSYisSUGEJiGw+EC0=;
 b=R2yay0P6O6AaWdS0zIkUDlEwo9u+Lie6toHoeYuFJ5wrZhLkBmv6AOOTQbaLymK50D4tpnWhK16weiazQVI2VVGxspsw9I/7vDRK0R4b3tGrC8UdtfB9Ckmu0j+sKsbmDyIQCzMv2/xuirLma5c8EVPsi4IF/Rq1jzclV/i/IX5nTi2P05CqolnFujDpCqAixNcOx4oU67NH6FC7BcAUHEU7+MkBJaZvQRWoe8p/LEYf46GWmnhNyThTzLxoZBeBW05F5/iq8T4QVDQaksPjAtRMcZoRuI/IhXN5F2oCgKeanYodZtRA9Zd5Fs1PWfapqnjkFWx0oUR3Nw7uGnnaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN3pUTgg/eFr4wScc577eV0g/fiSYisSUGEJiGw+EC0=;
 b=r+JIyqOtGD6ONmukGKIceA2+HYlOLuBGHymxdzAZieMASsBi9soN0Wh+eClmd9Nisp+tzWerKZZ9RDSbhVmQ0JKw/CBDcj0pZ8zwIJgG/6EX0gpyxLwvIiobVgRJvUoXZNu4sDCDkCVueapS+KrG+6RlUkVGG9ZmiQ7RwRCuISE=
Received: from DS3P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::7) by
 SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 15:40:09 +0000
Received: from CH01EPF000BE945.namprd02.prod.outlook.com
 (2603:10b6:8:45e:cafe::58) by DS3P221CA0006.outlook.office365.com
 (2603:10b6:8:45e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 15:40:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE945.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 15:40:08 +0000
Received: from ubuntu-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 19 Oct 2026 10:40:00 -0500
From: Leo Liu <leo.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: call hw_fini for IP blocks whose hw_init failed
Date: Mon, 19 Oct 2026 11:39:42 -0400
Message-ID: <20261019153942.4067-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE945:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b5923b-6ae6-4a49-f9a9-08df2df7415f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|42112799006|82310400026|1800799024|376014|36860700016|13003099007|11063799006|5023799004|56012099006|261009223027099003|261009221727099003|261009220027099003|261009221227099003|261009223327099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	J/5iDizy/KXhso/YgwWAY5Vn+n3FqiX+B1pqRLlQQIV453M9i5BdlZPtIf9iSMxg9FDRh//D8JD2Yj8jMc+q5c3tgysDCcrw+PYLm02ztJG5Y6eczJJp10YA87CZqtrbv+H82dgBnL3Eud3RfdLq+u13w+74AmxTD8F+rRErKmfzjSMxyGmfH54/Xt+o5JPnq17l9VJnYOIv4JQSKuPlF4yDQ8w2XAcwA7QMnhHrBaa+TOvLbInG/t/2VW2SuquU1ZHrBhLGKdpxFSmNJbu/RAp3+R86XA2THuJ9D042TCxdboVSYxDxzO+tb1JdYVukBHPUYQRWI+keAIeeAsqmVjRkDhPnlH490dRimh8EyCUQzgbSsg81gHkQGbg8LJyGv3NydbDk6CBaDTaxJYJYenbY/rAWzvaLpdKA2C+vEXkkCdN2RQce4kg9gIqGwRIBNzl13OEe6yBHQPf4zV1tocmQpobQWv3o9WVsg7NQj2pXvG96Q3sUMmiuZ9xrrpXehwV+tiuWE6EgwGXCsRdAFzW3i/bPw3alZGZLZdzj7utxP6zZ6kfOGh+hkWKWTrIHeCLYfX8EkvdX0DaarRsntafTH5JxKngjkX1EqSbqwlM6985GttToBLyHE2hiWDYiYKTwaK8Yfd6sXOdCpNqqPBSVYY87QxdXkgvF7ajxp6i5YwZzb+zkU0+kpI1rsJMTDhmIWl4bXbMZDO/6LdLjgQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(42112799006)(82310400026)(1800799024)(376014)(36860700016)(13003099007)(11063799006)(5023799004)(56012099006)(261009223027099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223327099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5N34LtcNfWmCuT5Habu/gKRAjc8BoE+m9ucvIMJ8ImWKTDl6HrdTZmPSZ5/5ERssV46YX8hQ8lkPTqsAe/4mec66OXfc8euHeMMOKjxlOqHTWALHr5tIjZDH/FWD5JomfyFv4h8zR9hdoYr9o6FDGxPAmi6tf9ZnrFa2RqXr1E4Rv4WQKepAldEP4f/rY7VamyCTTNmftyIhyXvQpGTeDL6yz7QnCs9w7hzg8NlG3aaLrzSOh2HumHhyEhbXOaxftZQL77krRxve/2MEgOg9FsVqlNidpP/4IvpYtksmEcXUjhyyJ7JkVhQph64zJf5DfSUzy51699shQWIM+FMFlikRf0JioarUhUDdAKjN3XmpyC0mT+pA62szZlXxn7yaEKx45M0ZEaVB6+8pcffxr+FYPY5qvqkx4yRSuFHzcvNK1tPDutJxsvObUQ5AVuzZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 15:40:08.6328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b5923b-6ae6-4a49-f9a9-08df2df7415f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE945.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946

When an IP block's hw_init() fails, amdgpu_device_ip_fini_early() skips
its hw_fini() because status.hw was never set.  For VCN, UVD, VCE, and
JPEG this leaves their idle work queued after sw_fini() frees the adev
state the handler touches, causing a use-after-free.

The bug was reported on MI355X after unloading GIM then loading amdgpu.
GIM's teardown resets the GPU, leaving VCN unresponsive.
amdgpu_vcn_enc_ring_test_ring() calls amdgpu_ring_commit() — which
schedules the idle work — before polling rptr.  The poll times out
(-ETIMEDOUT), hw_init() fails, hw_fini() is skipped, and the idle work
handler fires after sw_fini() against freed state.

The ticket (Link below) suggests cancelling the idle work on all
failed-probe/sw_fini paths.  This patch takes a different approach: the
idle work cancel belongs in hw_fini(), which is already the correct
counterpart to hw_init() for hardware-domain cleanup.  Rather than
scattering cancel calls across sw_fini() or every IP's hw_init() error
path, we ensure hw_fini() is invoked for any block whose hw_init() was
attempted but failed.

Add status.hw_init_attempted, set it in amdgpu_device_ip_hw_init_phase2()
on hw_init() failure, and check it alongside status.hw in
amdgpu_device_ip_fini_early().  This causes fini_early() to call hw_fini()
for the failed block in its correct reverse-order position — a single
change in one file that covers all IP types without touching any per-IP
code.

Link: https://github.com/ROCm/amdgpu/issues/234
Fixes: 416e1fab4752 ("drm/amdgpu: drop redundant cancel_delayed_work_sync call")
Cc: stable@vger.kernel.org
Assisted-by: Claude:Claude-Sonnet-4.6
Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h     | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b74f9136aa2e..e267fb3774c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2233,6 +2233,7 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
 			dev_err(adev->dev,
 				"hw_init of IP block <%s> failed %d\n",
 				adev->ip_blocks[i].version->funcs->name, r);
+			adev->ip_blocks[i].status.hw_init_attempted = true;
 			return r;
 		}
 		adev->ip_blocks[i].status.hw = true;
@@ -2902,7 +2903,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_smu_fini_early(adev);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!adev->ip_blocks[i].status.hw)
+		if (!adev->ip_blocks[i].status.hw &&
+		    !adev->ip_blocks[i].status.hw_init_attempted)
 			continue;
 
 		amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
index 5dd6273982c4..bfa27ca05dbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -99,6 +99,7 @@ struct amdgpu_ip_block_status {
 	bool valid;
 	bool sw;
 	bool hw;
+	bool hw_init_attempted;
 	bool late_initialized;
 	bool hang;
 };
-- 
2.43.0

