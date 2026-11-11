Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794361494;
	b=ByYJOlyRnDXuptGsaEnaVG8qDD7h1YFpaGjdzMYGQTtBXqYVhuG2yfPGJUuPOADril0n
	 rx80SWCSCc4GntpjI+bTHiPjZyz1TMueEcFvuOdMVgPxg9QHGT1FqBHH3p8GYjMlY4xhC
	 UD+g2JjpapKHXGl+ypMyyarnWU4du8dUP0d0nVIZQfjCNHVfvWuXp/2tLQ4fWhOM/4B5i
	 XJmJY+Dh+Z7hKoPCPOnGCagLsv22lM6bQVuCOBZSdT1w6/axJvpvWYtK9F46WAkCBCc8p
	 Ar9ZZ7gnfY3o2hcKS+mj2P1hw1UHeKB/CdF/cop8P3UBHyTtvF/vPnKAiZqdyFkT2lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361494;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
	bh=V/X6QKLy0fkSkIHIsTgGELjckId/eH534uykQq/Lcbs=;
	b=mu4gu4bRRrLu+5r5/oW3Xo8kwFYA4lwgAZiA5LgyswgHC1QiQGKRlsYmgB5MHBhGCcZT
	 Ck5Z+UjOQ1tT4Z1ZnqQ+3bEi/Xj03oIBrHLBSePZGXtJxhgiZo3YrpxwuFOBAtTKCIRyK
	 NyXo4vWSaNA/eBqAbdK+IJh8mYZSntgAFDUf+U9b2rdOhDW4Sl1zfanbTm2LcFu4NFAqw
	 jsDljdXhDWGvCdEQ2/fiQRDAiZ7QhhMUXDYFwYUQNprU9jcFsadimDJAcleCF7pT/nX2H
	 xM9JSEQsTi4dKve6+Z4hGeq1H3uaDYrCiJ4o3GqHRS7Sqon7VdzsTuVacFny5HSPk4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QKa+BJ7B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.44
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14959606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14959606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QKa+BJ7B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7T3qR4OyqS5dmv9cDUwgdJqPUQ+DZGXVqkcNeC6ySJRcO3TIFRhRX8NzWgLn/Lc04pO7Ka8ULCFmQJy76jcJLa6TetWujwJdhSOnqK3XRzCY9YzkQC6qk53mIjzL5HmmEQsijQrQn8N3k8hJXD9rLXoTqkp2IRK9dDHeBE91OnGmuQwdrwTzw0z19mi5s9sBkY93mLaMCKuM9Fuf7u+OXXqO1YlI0dUTooL0H5jN/eFwzp5ILTTo0SMf0gVC3Bo/mD48u3Vuj4TKPgwCCwGWPyWgoSpeRdfT9XkwO903GzclCkM3RtsW2kDphSH3NHvnAooqXgIkfy1UCUluS5efA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/X6QKLy0fkSkIHIsTgGELjckId/eH534uykQq/Lcbs=;
 b=cOZA9PAs/xJzqnA2veQZ3nYnZvS3Dx61zPehw2Ph2HVL+kEAAf4ZMZqtuPXyvqX0sqhGeW5dTKi+PucS6WHmVGYBfIQ4oLNuIWosAg7L/tIrSYJ1V9VwBI/icSL2AtAvscqT0Y6OjlmJodaq8+iz2krV+PxdI5zW5TX344oIcb6jZwxtIFaqcFgEaBttPz8B0Hi4wb9TnF1udpMZHxqktrwEP/qjKsgGhVqQAg7KnGE3kPOchA3H9K+DIx3hgjdemOjMbcJj8Xv4uNgsZB/YLkEsSw30j3cjzeDq6HbO1DqizCFDONTjcWrZJkoBmmmLikx9rnhIQw04ntzAghcNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/X6QKLy0fkSkIHIsTgGELjckId/eH534uykQq/Lcbs=;
 b=QKa+BJ7BprDcMPSFiXdwMYx9YAIbwRJ5QwCTbk9xjl6xjPkrhZRlnxjKYlft9aSbQ0MxWfTSDbwcWb1bzBynKtiJFty0dt1HvqR+ijoiQmq9WSoPmVPsRuEmaBLPAPrWJRC5RBHhg3ohuCj5lAFuHHcOGI3dCtniPF9DvF7evkk=
Received: from SJ0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:a03:33e::30)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:44:43 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::5d) by SJ0PR03CA0055.outlook.office365.com
 (2603:10b6:a03:33e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Wed,
 11 Nov 2026 01:44:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:44:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:42 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:44:32 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Allen Pan <Allen.Pan@amd.com>, Dillon Varone
	<dillon.varone@amd.com>, Charlene Liu <charlene.liu@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Wayne Lin
	<Wayne.Lin@amd.com>
Subject: [PATCH 62/74] drm/amd/display: Update DCN42B stutter latency to match DCN42
Date: Wed, 11 Nov 2026 09:29:08 +0800
Message-ID: <20261111014100.3596072-63-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 28507e30-9ed6-4156-b676-08df3f955bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|261009223027099003|10067099003|261102123227099003|261021123027099003|261021121427099003|261026121527099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p3JOtXrN3CtxQxitlyGWF5SzaYAMSzM1V7VOUrOlUP7RKTVqfeipdMA+v4ZoS02BF7MQtKZCI7eZLLYLBoXmTpImyMSYQdVFNNXVuu6brtATBJ0htjp4PFdyF5pWh4azw29JV5f2fJc6G3D7u+unxgm85r6kNb+CQAxXdZnwkei3XolonnCQxsbJqLw6o10IorJbx3DWYK+NDZtX2N3XkLNTR/YD9joSfaDai5DeX6JpfDelu1e2aZ3EaHB4dO1WMYR6NjW0IoB9kZanIyeH2462mVDUherUd5SqKMWK8rkND2PqBveq3FJzNFZlVmA0Jq9pVxS8xSeDoKXZf3g5DSt0mJl/DtffvJGmBi1+2uJRQH3uYxHMKyCSDr8aLMajWr/jie/ITDDwrnJ0BkEG1ukD6vv1ds+Q95BSFTNEeqXi0ChugWYSpJCEMafe4nCA2gEWANAyH4KthEwYjPp9QbhMHFYyfrJvifZTt7kT1aib22f9t+gEC1JAVwzoDt1E6k2C5DQ+vePlACnyBXvRaPMtXG1G8yoETLzxcPGBwYe7uYYUWsuSJ4xUlJX5BEcIFs6L0LxoImsq1KIZ7DtbkREvR7oheUTxdC2aq6U5xtjUqGJAU2KtNFo2sXd5auYAQQYzeYADXV0Tq8FirAHjDa6MdXAf2mpksyceCPiUI5K/gItDaWXW5eZuEKuPKEJ9TNFPsJjil0BSlANUG9Mp/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(261009223027099003)(10067099003)(261102123227099003)(261021123027099003)(261021121427099003)(261026121527099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/lzuTzsgczFfmjCLp1OoSEcWLKacH7WE1A2EdfSwk+28kFBrQwNyjgATZO6j8+p+p/D37Z1Qc9UpYH4MGKaMUhNFKC30U+a54C+tUb4ca0ggJ2IM9IjmZk7KsctjZ30DF90YvJwUBhmSTYOR0Ls4erjvJz2CINdgJi8u92yiw1Q3A8vqfCVBjOFBpKywBPFwdLKH3nc10k4CwjdmR03DILemcJIG/qCoDQzSu1ZQGAAnVtVFNY3oh9IBYwlujDgrHocyhXgsjum2cGaPSeNJNLAiB4T8Rn5jiEb/yxZip4IHhED0hhNuID4Ci5YIzYbVZ7qC96pjGDwHaKeGr3Z/q0tAPT9OUg4BcUqA1iEtPZobp7RZEpdfEhKW7gODhSHPOLQNw0ADsNh8p/NIkn7Yonjsp/bKFd+3/EaQdWIeu3jzDWi5lkdUBC7b97SBIbtq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:44:43.0326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28507e30-9ed6-4156-b676-08df3f955bbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429

From: Allen Pan <Allen.Pan@amd.com>

[Why]
The DCN42B stutter latencies do not match DCN42, which can lead to
underflow and stutter issues.

[How]
Update the DCN42B LPDDR5/LPCAMM2 stutter latencies to the same
values DCN42 already uses.

Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Charlene Liu <charlene.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Allen Pan <Allen.Pan@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
index e83a9ac018db..07f1bffc75ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
@@ -188,8 +188,8 @@ static const struct dml2_soc_bb dml2_socbb_dcn42b = {
 		.dram_clk_change_blackout_us = 36,
 		.fclk_change_blackout_us = 0,
 		.g7_ppt_blackout_us = 0,
-		.stutter_enter_plus_exit_latency_us = 14,
-		.stutter_exit_latency_us = 12,
+		.stutter_enter_plus_exit_latency_us = 15.5,
+		.stutter_exit_latency_us = 13.5,
 		.z8_stutter_enter_plus_exit_latency_us = 300,
 		.z8_stutter_exit_latency_us = 200,
 	},
-- 
2.43.0

