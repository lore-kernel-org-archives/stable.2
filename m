Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013066.outbound.protection.outlook.com [40.107.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96983DD845
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782324576; cv=fail; b=MH5geruuLwS2xR2bL/GsPdgTxgbXSEUuZ9KC05PrHEfrkmAAGBl7l/uSasDfTQPTVIn4OYBUntmf8cWjLfmFv2B4MrxPPXLmPRLyGE5mE+5yY/V4G8VqnkoEUwYUzvpFIdmbSO/Nd9ZmhPoHv66gEukulIV7izQumVf624mh4tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782324576; c=relaxed/simple;
	bh=txyh4i56/vwWUhwq+MPAiZRH156ShPo/m1mNey6ymnU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ft2/c9zBcXIynoLZNpHm3+lLB41MiTp5ULIV5iraD8FmnskqVDpGb+UKYxq89wRdIBcJ91JRJoZgD20H0LIWvLZggTx92+VJG1uJ4uyORs0HTwQwY4rtTCKwV+NpVWDo9qV5pYK8Ib27SOBbVt5XIJBgeFcUvy50J6yP03ScNiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qFScMkFu; arc=fail smtp.client-ip=40.107.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qFScMkFu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAukMbE3htOPROZ+5G+cQxY8TvF0m3cCKPORkMk/HC4ieBBiwEl4GvQ98Z2L2St2Zz7A6j823y/d+Jke6J6ijXHfN/ku2pE/WBUGiG0TxpYjRrnmqxCVaxuYpA+7YePl7nGNn1it34hnusKOE6EVX7rWty7PrpXBM+rEIN36SAbUXh8nkxtv/KJ9FxCACdWc9uj3oVUw9Hx9nQJrr9UnndqX9p8xA9ZHEO/k2D9K06eQW8iJ/rMBrgYxsVziQ/Vt+LPo3og1qJACIAqoyQVpYBI3KcDxoyQ3dOWROmh/DH4wYzxMk5Z06U/GhuKl+lBXPXpAII0BpGVAMkRLUTzHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESEqE4gVGK54vqeSy4aWHNt1gMREVdCQhUoUmHZzBtI=;
 b=rEsLrHReaYU1m1ZefkgdCJAurVfiUrJ598YzdzAKr2cCtom0cN6TqWHgyU8LP0ZsTrv07nRydzFgKyX1IoV0kYrJku5YxxqkAFQR5/hNgxh/eJxHE9KUR3naOl+0sZMWovIX2MyPZ+vyC3TWIc4PILts3m0ackVbRhnF7Xto6XhUqfl1rSCKwE/2AOVh7vpYWMabHHzc/EvY8f3wRhlwQqpN4JEAyypWBrB675yuDJ3w8AU1lj9M6oa64M96zKi2N4C/fHv4Y61gB79dA/J7wTfCwkT2fQlBImKWeInaxmci1oVGe1FYmimYq4HL72qm9DNsIKSR2pRqe+0A+IlANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESEqE4gVGK54vqeSy4aWHNt1gMREVdCQhUoUmHZzBtI=;
 b=qFScMkFuQEM6vvwOulMMmR7LtnmDP/XhOhGqPW1XFfKENZRvbCq7HHcSM01XLU/ZHrAJUcobknsCf9p3iXpTp08Kdf/qQyOO1IXN4rgZ5uEWc+yy606V1b9X1xOmyuUXwnUT/0LQtKwWmK30B5b0+W+jLd1D8t8gC76nkyHcVN8=
Received: from SJ0PR03CA0039.namprd03.prod.outlook.com (2603:10b6:a03:33e::14)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 18:09:31 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::16) by SJ0PR03CA0039.outlook.office365.com
 (2603:10b6:a03:33e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 18:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:31 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:24 -0500
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
Subject: [PATCH 15/28] drm/amd/display: guard against overflow in HDCP message dump
Date: Wed, 24 Jun 2026 14:03:13 -0400
Message-ID: <20260624180829.4775-16-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4b97c2-741e-42f3-4e66-08ded21bbd6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|3023799007|18002099003|22082099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	BVY/aQERF5IILAdFxvvkcsyWmvjRx4mTUpchdhI17ukuQn5a5lOtxP20AiViu0ne9fTeSDQdHRS9jDluRAn1EpLpJsNxYXrm6HlfVs4O4ZFnO/FQHIYMIB3e7j7Vfhg0PIm1sWc88/4gInD3q5J0q8dtFQNXtKdMYdDZAtEF6PGXoCPf3o5Ni7sWUSqTfzMVT05MlrTUNyz8glnQ8DhY2T22yQdkxIL5V0hwrlPEZMK8suDuUOYHfxruUSXE7rjpTakceiIU0M0TMCvAI7keWAc0QhI/1kilSLm7xLYrdBpFCS3AX7tx7bnt/bSGnu5sFB3+BsJPVrezPuPtTsuH0Gn3tB5epJSrFnHYm2vXW6Gb8a6yR9gfUu99ms5drbu0BbDhBefO8SxFvK+Qe1ySV8I5lsNJetijYluoyQl0Hm/+CKHu3w/qkP7RpKPc78mm9udJLgLGrJVcdL34isiF14N23WIvxsv7Jn/6YKl2Trwj/0HoJHH5QSIeVg8vYOnFySo/kRRscodeQRd18QD6kKFy5RAmFFdKjy4jP2pvdvxVAg/xsvZ0fkR9x+g9ibpG4D5aennI/1wu7fWZV2KgUDMv3i4iZLDZigtUBieycjpaEowLJyNnHV+sYiLt/4b4+SL7qDTOBpXER5IMve5S7IJrD2Hxyfz/o3/pKktoSRNdViNQcDcRaRPepOmrMpE55CWsgOPbloKFdMcismdQMA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(3023799007)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ktjm5uk30UBbyG4+oWEDAdMIZyMD7c10l3P+A0c9Z25BIax4NOtaOBXCBj2DO8lHed/e4XDsRNjnJba7rRbarTOotRLtFnxxN6RnXsGSdIwZsdCDC2qS1f5hwHWKQYqQYTVDGYPa3FbpidzWcOmAQdk6Gcmy7exMzTZ9tn/+ReM5Z6meLlp9RNt26C6ADhxKTvuHqQnlF0wQg/K7Ogc3WTyRCd+feW+U81+pH121BswsynyorZWtkwTme0QMO7QUNR8jJXUG1I6ODAjYgjBDLQVwBn8SMMvrcH6o6ssm7WkNr1odrFE/QuhAY4g8AdU6ATNPCJelwYxjNlxtmJI6a/I3e+fLFRz8zbp2nbh87p0TEJOfA13hvLWGt7aziXdy/cuL1TTkrZI7b4cFsGfK1gWHgf0oE8Acw3AYWCQ9cUdO1UsdRxWksvFrtjn+keEg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:31.5897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4b97c2-741e-42f3-4e66-08ded21bbd6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233

From: Harry Wentland <harry.wentland@amd.com>

[Why]
mod_hdcp_dump_binary_message() computed target_size (a uint32_t) as roughly
byte_size * msg_size and gated the whole write on buf_size >= target_size. A
large msg_size can overflow target_size, wrapping it to a small value that
passes the check while the loop still writes byte_size * msg_size bytes
into buf. All current callers pass small constants so this is not reachable
today, but the unchecked arithmetic should be hardened.

[How]
Drop the overflow-prone target_size precomputation and instead bounds-check the
output position on every iteration, stopping once the next entry would not leave
room for the trailing terminator. This cannot overflow and, for oversized
messages, dumps as much as fits rather than printing nothing.

Fixes: 4c283fdac08a ("drm/amd/display: Add HDCP module")
Cc: stable@vger.kernel.org
Assisted-by: Copilot:claude-opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/modules/hdcp/hdcp_log.c   | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
index 1164fd96b714..f0f8e280ed30 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
@@ -33,22 +33,28 @@ void mod_hdcp_dump_binary_message(uint8_t *msg, uint32_t msg_size,
 			byte_size = 3,
 			newline_size = 1,
 			terminator_size = 1;
-	uint32_t line_count = msg_size / bytes_per_line,
-			trailing_bytes = msg_size % bytes_per_line;
-	uint32_t target_size = (byte_size * bytes_per_line + newline_size) * line_count +
-			byte_size * trailing_bytes + newline_size + terminator_size;
 	uint32_t buf_pos = 0;
 	uint32_t i = 0;
 
-	if (buf_size >= target_size) {
-		for (i = 0; i < msg_size; i++) {
-			if (i % bytes_per_line == 0)
-				buf[buf_pos++] = '\n';
-			sprintf((char *)&buf[buf_pos], "%02X ", msg[i]);
-			buf_pos += byte_size;
-		}
-		buf[buf_pos++] = '\0';
+	/* Need room for at least the terminator. */
+	if (buf_size < terminator_size)
+		return;
+
+	for (i = 0; i < msg_size; i++) {
+		uint32_t needed = byte_size + terminator_size;
+
+		if (i % bytes_per_line == 0)
+			needed += newline_size;
+
+		if (buf_pos + needed > buf_size)
+			break;
+
+		if (i % bytes_per_line == 0)
+			buf[buf_pos++] = '\n';
+		sprintf((char *)&buf[buf_pos], "%02X ", msg[i]);
+		buf_pos += byte_size;
 	}
+	buf[buf_pos++] = '\0';
 }
 
 void mod_hdcp_log_ddc_trace(struct mod_hdcp *hdcp)
-- 
2.53.0

