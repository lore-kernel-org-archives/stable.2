Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013029.outbound.protection.outlook.com [40.107.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051A52F7F09
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782324570; cv=fail; b=cpXq2cBbI+4WNm/hpVMEutDD/K0HKVqgxz2WK9TNSBNI3+ZwdG7B/r1zy6tvtIl5ZorhzWPd96F42axeIKo3htD+4iBKxVH7YD255/2DBIVq9o+57M2Zpl4+4pFlg0JyIInlYVflP8iTjZL1Yfpyo47+yU+iCbMvBJQgUV8+Y14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782324570; c=relaxed/simple;
	bh=FlnVSn56k2u46zSAqkL4s3tljbsAz56PfltsrYKDIYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HelnzQlNlExDymGXfQpyWJXwLIOYQdOTkda9D9V2C0roJzBVDiEqjjWOIU5/gNvAVmPva2M1GX9dGqncdCk4rNuAViaX5imMxW8Qnuajc7xzDNbHDlhVSSUjgR0WGMAlpQF2Ep8/GBVF6hUvZWd3N7Ae2+NfjBH94N+LM5D+Oao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CR2be4BR; arc=fail smtp.client-ip=40.107.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CR2be4BR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmFpOzC+uV5wD79gSm4cGcdJwW3lPNaFBZup/aXcK9jaRrfBA0tA6394Vq8DfVdYkIC8nYnSf5LQ378Yh1c5gn2LpzM0fP291k84WgZ1MLrB4C2A3C1q4w0qmNRpFCB9BoBFO3s1VTAKFG5XVvEYzoQ3LZ/fcZwxqpC4vlhUhOfxSe7kxGWbMIZY9CdjF6sRN+E+AzEYjzeyQcgAF45j7rifgkDa/TDfhYBGvKdEsONTGccdmKKTL9zb0I5YhgnviSXgf20N8llnlPe1gri7d0JAzBwYNMWgLu3qsaFn6qYJC7vMO/NaKkELhh3NioFLCl8uVXfOSqrdV1PKw6Uasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNwF5vGr9dO4MdCCQ2mgX9MnJl7O17sgIn9ZFaHqmvQ=;
 b=yV6dp5/dhzIuH3FSy/ICzJxWebkc41vJ/XhmHZhhixe32c+wEZSj5vB7gUUuB8/N4lbIslJL5nR0c6d72TXCIoSvakkgAGO5IY3ECccofEIdN2Zmsy3rs8Hy44+LCcaAqZay3Ki9sqULGq9DUlRPq3YrhQu+zNYTCOTGdQNEj6HlT6awm5fQAo5CxEOgAvMNgV/8ii+TkZ4qCMvn+3RDB02+K4+J48lC1Cj6oyAGpfEokhIUWVvDzgj/2N4XLey57OZZ79TIKUJqPCLNJSdM8mKF8IkjWBxPWRJlQ5JeweEgLqSuBegcUZ6wHMHCBoW1BVmoiKWUSTqI/RJcdJhNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNwF5vGr9dO4MdCCQ2mgX9MnJl7O17sgIn9ZFaHqmvQ=;
 b=CR2be4BRT9jbRns+4JrEbLxnfeULblZYSVKNtCnmSOGMx01CM0Q9DOqzqb95bkqd7sxn61wlkxRSslnWSC2jOKRtHePN/dNX14+j/jM/VZV+h13Qk+d1gExl1LQhf1msjMDo+iwRX4vm4vCiD0Cq8QpVbnpbtgo3Dse1gnlNUJ4=
Received: from SJ0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:33b::30)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Wed, 24 Jun
 2026 18:09:25 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::11) by SJ0PR05CA0025.outlook.office365.com
 (2603:10b6:a03:33b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6 via Frontend Transport; Wed, 24
 Jun 2026 18:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:24 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:23 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>, George Zhang
	<george.zhang@amd.com>
Subject: [PATCH 14/28] drm/amd/display: clamp DMUB AUX reply length to payload buffer
Date: Wed, 24 Jun 2026 14:03:12 -0400
Message-ID: <20260624180829.4775-15-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: b52a9f41-5155-4b9e-7ce0-08ded21bb948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+rd466j4z+ZpxpGW45+ltfqdKlwK9P0Fq0cTyzl6eMNKFR7V3ij36ZhFU7jJvGhSY49rrJS9DjGMV1JhGp7pdqyfBUEkI0UE4A77MRMvYk4aMBw708daGNtARkL+0crThPxJEbIoYRa928rDOlnb4YfgxPb9vCluA+Eh5J/HyIb9O8PzhkZsXAqmhUXjB42E2R0+4Qmdzvjub/Fq+kmZvTKx/ETlgN45m7Q5YX/r6MO3LLfv7SkOvO8jjdbTfq7IAG1h3BiY8Mkl2V34vL9p+86rWE1y9BcC/CR4029lt11UwGKTgEA9ARUK8tq13luPxSqMNXIClDZxZfTv9RNsFjxlRmbDGaGanZJ6qfqEORAxl85DW6mB4+20n+KX/5vjN8P7oUvfFodu5qA/SGyexU70p1V7OVNHKF/N2U9m8kiYIIogZiCYosGXjhrA5Bk0PBWa8GNps4+N/9Q2qucsOv5ffVW06V1InuyxyXBqCkFOxbx4QOObxk7jVFUt8jz4ISiKWpVmkdznTZUIiaNLXrWZ32nozk47VnlPAEuDy/Gssw5nmRn2T25NHaxNUJkbW0HYWYbXgpGNCfL+/lMiJmm0EJPlWKpfqywFLSUepran4iScoPFkiwq2HgQ+qegv1zt2AXDv1hgNcFQvFGwI5wxRI69HiK+0MsthdTi3JMnryufwO0VNTkDxBTOCXZqAA7ylxmgjn2inGHKAg0cZyQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0W6cKL/Y5U4sOHQpn9A5gYtDtE0WZaZLZaEMU3eZUeNfmL54b3dNgGoKyfxOj/b3HSqc3t9tHVvkl7qTLb5r/QPrBCS6qr7skrcDTH006TAOhcbda2c1QUcO26UfifnstWCb1XrtlwTeiAhJYIdxJR/78jDzZWHQLCJXLXv4b6F7U495mLFq9b5GdgNof7euljCwHCnqOKooyW7gGKW5zwb+q4C2Y2dlqh3C952FPtnfE1SKei/S2RmgqTk4QvP56NAHvY87rv0CtKJWxTn13ois481i80gIX/bh/g95AiJ9sVmQVYRoQGhds448/fLDXpC2P+p8b/KzUIVjRs3O2ZLct65uagvQ+WRAcl7X3bOSxkK1q3AiHuIYRzXYrBBbgxua1fcmmVofGkFDNw71vgKNaCp9wBly2JhfHkqb8xA3LkvKCVatvVgtlM41jDVe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:24.6964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b52a9f41-5155-4b9e-7ce0-08ded21bb948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258

From: Harry Wentland <harry.wentland@amd.com>

[Why]
amdgpu_dm_process_dmub_aux_transfer_sync() copies p_notify->aux_reply.length
bytes into payload->data without clamping. payload->data is typically a 16-byte
DPCD scratch buffer, while aux_reply.length is echoed from the sink via the DMUB
ring. While this is clamped by DMUB it's prudent to ensure we validate
this in the driver as well.

[How]
Clamp the copy to sizeof(aux_reply.data), the scratch buffer the reply was read
into, and use that for both the memcpy and the return value. For regular
transfers additionally clamp to payload->length to cover callers whose
destination buffer is smaller than 16 bytes. The write-status-update retry path
(dce_aux_transfer_with_retries) deliberately zeroes payload->length while still
expecting the partial-write status byte, so that bound is skipped in that case
to avoid dropping the reply. Also guard against a NULL payload->data.

Fixes: 81927e2808be ("drm/amd/display: Support for DMUB AUX")
Cc: stable@vger.kernel.org
Assisted-by: Copilot:claude-opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 97cb2a09153d..1f9830ce2ea6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -798,12 +798,26 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 		payload->reply[0] = (adev->dm.dmub_notify->aux_reply.command >> 4) & 0xF;
 
 	/*write req may receive a byte indicating partially written number as well*/
-	if (p_notify->aux_reply.length)
-		memcpy(payload->data, p_notify->aux_reply.data,
-				p_notify->aux_reply.length);
+	if (p_notify->aux_reply.length && payload->data) {
+		/* Bound the reply to the scratch buffer it was read into. */
+		ret = min((uint32_t)p_notify->aux_reply.length,
+			  (uint32_t)sizeof(p_notify->aux_reply.data));
+
+		/*
+		 * During a write-status-update retry the caller zeroes
+		 * payload->length while still expecting the partial-write
+		 * status byte in payload->data (see dce_aux_transfer_with_retries),
+		 * so only clamp to payload->length for regular transfers.
+		 */
+		if (!payload->write_status_update)
+			ret = min(ret, payload->length);
+
+		memcpy(payload->data, p_notify->aux_reply.data, ret);
+	} else {
+		/* success */
+		ret = p_notify->aux_reply.length;
+	}
 
-	/* success */
-	ret = p_notify->aux_reply.length;
 	*operation_result = p_notify->result;
 out:
 	reinit_completion(&adev->dm.dmub_aux_transfer_done);
-- 
2.53.0

