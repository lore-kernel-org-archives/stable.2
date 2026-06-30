Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802263C2BBA;
	Tue, 30 Jun 2026 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838359; cv=fail; b=AfX8RCB+VqNjbdl//B82NuX3yjzyqg7w0J2DN3lKMB31oXrkzbu7O4AtfjkaPSpEbncWLfXCEau0vp3sUXZx5Z5gXq7KH5+7V70eTgqUNF3zz4FQiYauny8sH85zrhO8tb9OiHEFiL9c0rFQoMfVaGZ2jS3mENxJcnX3Uu/R8YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838359; c=relaxed/simple;
	bh=aeBjYjgexK2yComLyW0nrMYBOyFIy0h2XsGpT2OyNJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uw/HSiPpuAw2MTjEDKd9AchGMI+jHcG/CYL5MBPan7gJR8gn08Usx+MZ019nz2bF+EuPb1cwRPetAzpJFX7zN9uYsAIkDO/pKYMrC/PTxp7Tc1XnQq+hr3WVM2Iaf8Kl5Paw5Dm0jJMa43XCO8fYFXlOKY5DqRvUJfEzSXk7/hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q7KptqYC; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q7KptqYC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPrRWvCOoggsU3BResvZatTXw2rVb2r13ybxikhwIT35Jb76JSqi4XPCo5aoVC9o4iuMYL/yqysfLsBmYj3zxyfIwz5Kt6JqzE9/sOUpfGJfWU3zKEHzlquJ/GEOa0Zn7frZYVhR2mAxBf+dk8N3Ow0NDlvZW/c1Kzxnk6do0MAoAM0JrXx5d+qAgBcKaXcCrHjkOW5cExH8LVYyMWY3bX9NTdSLRq5ZQqtnUBNJ1UI3swxNM0sYnVTCq6ONHJrrZD3mI8048HDoZTi3ca7WPUCq+T3lyQYhplkkyF2krZwLvHF669rSg5TXbOkg85OROiZWhFYkkKxeBwMpf77FZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xp93eoBT/3mWkYReg1XvEGMLcuCAYD4Wn47k/18IfL4=;
 b=x6vDt6ku5h+roiPjfZ+FsmGYqBJXbdLyKWNXglbIFugngMVoFvRHIyIaniTjtdW4Y27NfHHItDAyVg5zKiE/1L9ZxmidvRoVb3DMXZFzRHEgkdt6C8wH1rwUEiRT+gupZK2dQiQCLhweu3vCgHoTiqHFGK1/uZmUezcPWtx0aq9CFcxFX72Dei8ruj1q6cRZEiZ6uNG24/uXwdKM4LCuzrMKfYcyGjNyk7Y3bjlTcQHFW6EG+fogc+pJE/Rb+4/b0lndBlnqQnknoCIBaGQ2lkDn0fU1fYD3d3QbNc167Er9A2CromtvFoLwrlsZPKIc4KWJlrnL04q53OJJ7ONEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xp93eoBT/3mWkYReg1XvEGMLcuCAYD4Wn47k/18IfL4=;
 b=Q7KptqYC2T9XHkVs1iYLkGkyYDO9m7ILxS3OEVPPuTePhvSji6d4LPLAzWLGYX0PdzSlhkmuv5qp65nV4ynz7fIC4/LL6OXXFo14RrRfcsa0FXU+RTCsF4XvBJA8Awq7yD5rIvcCpmVN7UpIVnR2euMnIZyEq8po7y30jbe6U3Xbi77lF2V4g1v7j5Sa9//T84Q26ivtNxzwttWzHHk//s7geA2YLu8CtAzNsPQK6Mx7B98jFhpg9JB+XGSAhht+jQ27QfXWPmwIM7lO7JB5mqWRbzygE+DxUOh36XfoOSkWNlvE3n8UuoAg4EWHi8IXYnuEngHc7WkslPbIt52srQ==
Received: from CH0PR13CA0033.namprd13.prod.outlook.com (2603:10b6:610:b2::8)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 16:52:33 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::36) by CH0PR13CA0033.outlook.office365.com
 (2603:10b6:610:b2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 16:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 16:52:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 09:52:10 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 30 Jun 2026 09:52:10 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<stable@vger.kernel.org>, Nirmoy Das <nirmoyd@nvidia.com>
Subject: [PATCH net v2] selftests: net: make busywait timeout clock portable
Date: Tue, 30 Jun 2026 09:51:57 -0700
Message-ID: <20260630165157.3814871-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5a17f5-1e88-472c-0961-08ded6c7fac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|13003099007|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	rZFcg43MljeevmyxriATaxTCXYgBTDXObAe7spu9z8NJ890MOaPWdnKSiiZ2DB+qogi+qUirjstYGoV7NxzjePhdsj+pWOAB67V7dmlwJBGEEfHB1MKJVdKa8ocKLMe5mt36s2aF4cBJQSspKBD3D8Mj3QfVuPNIP5OPWSr/src8byqtD9LZdM3WTbBvQS+9+djehzPHVnn5w2pYA1W6k/3aDXVppsuNJqXb2D0mjSK30Q5oy93NJhZEoIfDzVrZ7h19Ec1T2PIWS7t+iG+oeqkgGax9+/g1wKZvPS5SoNR6HfI26J+RBLM1awJoISsuvo0vFwAj2MvnlsaNxad9Q9RIny1t0YMLiVMDbhko22Avt9RfryFqpgRvWGx4yLqWQD78taw585HLp7Q6JE9nNGIp3FAYSj582FHHdZAHCAwMwLCWRx6fzoSKU51yWjEkrcNeZDpa/eB4vl6z1pdhRFOnDO0jz4VRZB2x2r/IkFVZ6CUf0q3+JUav8gANVWhR1bfCTI5d56+T58Re9Beb7rXzs3tjN3nI+oD8eAQQM54U0zO8A+vsdapAvLzBTVwlEa+QfxeShBpEQGuQRtp32JYxWoFsKG8BIBUeSjTCKI27ainIdEABhyvkduGn+hat5V6olMQb87zu6+y8DGx+pSYhxqsDj/RXUmJi/MmNb4CjFzl1HA0Hf6WRbEguuBCmh5/85h+42HTlZI05mklIfw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(13003099007)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Yfd5rvebk2dDLobXH53MMCNK9zwuoH5lx3SucW6oB4g+qUrMok+ptZ6Cs+YKc1SQ0lS2Bm5CQoYLEbkR1TwD36J5giHky0T7Y6mFmFqQ18QYk/rhU8U/eTtTsdAPd8+1Jt3/HGPL+dboUB0avaAP2URRNkAOS0sfL9+BCLT/5oDZ4cjms5yaSMHMosmjHAEjsi0If3Lf8ywrFvXCDACSfcXlFl6gL79mg8qP+2OSKnQ5qduw68d+I2e23pEqot+xCxTtuV1OCynTCYFIXOTQmFHo+duy6HrnDRWRcvzHOfGd8AtairJOTz4LNxyH1FUFtJKgxYaUVpj4d1eIYeh55YL/KirBEa10j2K1Na0X4h0N8+m4n+p7oeCL7jTstH5Ef3eWZ9b7BIzLpeYr+DE7XDFM1nQ74U253nR2BuL7hpVWL5mRjM9sdb5vytpY9Qvj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 16:52:32.5523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5a17f5-1e88-472c-0961-08ded6c7fac4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900

loopy_wait() expects millisecond timestamps. However, Ubuntu Resolute
can use uutils date, where `date -u +%s%3N` returns seconds plus full
nanoseconds instead of a 3-digit millisecond field. This makes
busywait expire too early and can make vlan_bridge_binding.sh read a
stale operstate.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Cc: stable@vger.kernel.org # 6.8+
Link: https://github.com/uutils/coreutils/issues/11658
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
Changes in v2:
- Declare variables separately from command substitutions and propagate
  timestamp failures, addressing ShellCheck SC2155.

 tools/testing/selftests/net/lib.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index b40694573f4c7..d030d45c0e603 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -70,12 +70,33 @@ ksft_exit_status_merge()
 		$ksft_xfail $ksft_pass $ksft_skip $ksft_fail
 }
 
+timestamp_ms()
+{
+	local now
+	local seconds
+	local nanoseconds
+
+	now=$(date -u +%s:%N) || return
+	seconds=${now%:*}
+	nanoseconds=${now#*:}
+
+	if [[ $nanoseconds =~ ^[0-9]+$ ]]; then
+		nanoseconds=${nanoseconds:0:9}
+	else
+		nanoseconds=0
+	fi
+
+	echo $((seconds * 1000 + 10#$nanoseconds / 1000000))
+}
+
 loopy_wait()
 {
 	local sleep_cmd=$1; shift
 	local timeout_ms=$1; shift
+	local start_time
+	local current_time
 
-	local start_time="$(date -u +%s%3N)"
+	start_time=$(timestamp_ms) || return
 	while true
 	do
 		local out
@@ -84,7 +105,7 @@ loopy_wait()
 			return 0
 		fi
 
-		local current_time="$(date -u +%s%3N)"
+		current_time=$(timestamp_ms) || return
 		if ((current_time - start_time > timeout_ms)); then
 			echo -n "$out"
 			return 1

base-commit: e7cffd183c128af12683aba28ba163017ea2b192
-- 
2.43.0
