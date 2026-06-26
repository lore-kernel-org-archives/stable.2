Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400683FD94C;
	Fri, 26 Jun 2026 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485382; cv=fail; b=CtrDJXRX+p5PnDo0esdTzidazUQEzP3X+d396Zw56zaJiKykLg54BBEDCtqsMy62iHNNwbCi5SCZAvO2y6qoTzJud7uSvH6JtPuQYp6ESATe2pXGtFf+pBV6JswwQC81llSY+pbSluIciA884HlGGA5lwRteFTLYi9YhGWht2So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485382; c=relaxed/simple;
	bh=2el/4BSnbCVPGnK6IouuS3pTaumCujWrvsmZu8NMiAE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d34QIVhoycGNndxzpP9dZ7xaesknjoAysKtVsinSrN4cHh6IuMKTubfDoIb5Y9or9j4WH7PzxrYUc97ryXRba0QhS8hEaiIgvaCB5/eNWwX7SrHulZdomEcUbXX6cjIM/VIl9TaAuOEj7Nt4SpK0e+cn4o4FWrfcrc764Z7UqBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lor/uiPk; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lor/uiPk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpX77qq/I/pezLliAFF01XBYjOdeXnievymJYR/Aky5n6Gwi9TxjO9XRknsENv4RLIo7eU5/rBBSeNvblie2funwVCPOK7YYZ+BATKFJxh2bXozcay/FEX2aitLqNLjFsipBS723DXzrAM6FIBf1iNeh9SZX+w+rC9Q76GmoLncZ5KZ3rntmwW8wvqqQ0aPrc2u6QFXsksvGghN1/+IqWYpbg4XUPXvZRs+xxoNP30qmolPB06BWLKhyvRICSEwk84LYb/KtlWVGAVtFAm+Zmrtna23ARAZBqg5PLO/XCqRxXulMeqiVG4vPbcdTqL/1eMBSIeec61eMu6qSBVxjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF/L9eG6VKLkrq3rC39GxLpPmHsGXz2XN5aKGLq/lh4=;
 b=glZqK2hdyMg49Ie91tRTJT9bCn+KxJRy/VdEIu/ZrEUpMUcZQVc/N1yfcO+Tco0i9OjHPDmELhLlVWU1dLTukSG5aEa0LiOwt8iYr7rhI1656BKGiUSLWm9Z9QrKTGeFUVJK5oqCUhhjgZJS02M5F2hDQR0P9UnSA+d1yQipOuaCFyOev7FO0wSRLwd99xKcW21qU/zJFdK1yZgGmWE8e2YU35IA8/ieErE/2RMko0SxnZUWisTEPu/lzFd2Ubf5Vh5Q3jPks89eFAXi7pOI1ojb7Ayy8laLy63Bv9zRBGo8qfXVIB6HvHS9uu9L2oK3oD+Hqx9YhlTbbsrjcwAlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF/L9eG6VKLkrq3rC39GxLpPmHsGXz2XN5aKGLq/lh4=;
 b=Lor/uiPkCVRi24JbFpj9pFmAtUQFb3ANTzKNsGIHQpzgOslf7fX1pLfC6nGbIjbsGLLlQpKAh0IkvtkON5ecJsQgSXNChwYAM4hJr6YuwwsVuFg8wrUPwBqTg8oksMHZRu6e35nnobFyeHYbvVfkiNLnzh7KvNyFvh8Xe+yGhJuWJr5kTJ6EOiQ3z8grBuFVix4NMldR91HbkcKlPJZWVYqBVm91bXgU+cl9Iy8oV62baZl4GLmmklrs71PXmelyIwwpDUJV6N0moPI5OFrdr8VuCuNrbIAKkDGS4XOMWwI3iq4Pjm8qnjfWXv3BCE275oavu7dXKWRilLnkvbSRSQ==
Received: from PH0PR07CA0101.namprd07.prod.outlook.com (2603:10b6:510:4::16)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:49:32 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::a) by PH0PR07CA0101.outlook.office365.com
 (2603:10b6:510:4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Fri,
 26 Jun 2026 14:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 14:49:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 26 Jun
 2026 07:49:14 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 26 Jun 2026 07:49:13 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH net] selftests: net: make busywait timeout clock portable
Date: Fri, 26 Jun 2026 07:49:02 -0700
Message-ID: <20260626144902.3214350-1-nirmoyd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2766afe5-b29f-463e-7a72-08ded39221a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|13003099007|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	V7uTBBVskuTK27DeV0tRRPqRRo0svzNotpMolTLbvrPJW6SUyh7X5rIxiPfynPcyt4SoKvjR2XbQIKix3eTdRMfuwNCwRHxeNl8lPAE/Y/3RYrlWaNswCBvyEXi77OUYVUKPs4XU9vFfD8pp40mFKWfYlsHeBsEs6pAKEYVgrtiNkfN066YPxKiMKeX0mjrbFTlwabO8tFtvsQplx6GhKJjEfvajF41R4Azrvfc8R7WnE8sIAR58z6k3KIiJ1MN0c1RztX1fU9CButnA9HljG7qi9+5PGQzt9jhi9Ic+Rtb3AL8mpAPGpUTU/pLDxCgZm0twqbsoGVI/cYsI3C6lQW/xmwGT4SXdnQqYWNVjK863pRadndImoVRXBFHapSbRn/wvbko9wfrIt5KpQEq2WWeL/P6jUjllNmLDOj0qWmmtt+agsEJzpe9xjtuLmJNvWPoq26iFU8fNedri9+5L9Ue9ot0jd3PL/Iw/cZIdqhzFpjU/GjuBGNzo1g72LWsq7XbSSG8zisb2hpvNnNcdArEjGezQICOq7W01O5xhszRppHxDbublkrbfzwamPCo45Zg5LvWDMf/xcrZ5+c/bAKFBDGBAVJfRhEnaW5MeYtOxHyGYFfxaoWVmFuG6gqL0Qx4ag3ojmx5qohf2uEwS8HXttyq1t5ZSCyfFEwdODJB2MfRauOh+cTHuRXtfXz8VZSJ+9o2iw3U0aa9u0j5VEw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(13003099007)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tw9CnNB6YQgySXj8Al9HW79Wq8k+EzQdgLaEZ79darwv8y6sgjfBduZHn37PxzgNxAhqvCB1q5PDI8RyRH4zP2WLvjnDA7ZTjd7THEZryubCXsTYkr/Os8gXH5OFkVQJevONrk3X32MT0PtelS3EF6nmXwQz1/TtsNNN+qAW4IuelZsJGxXXjrbMOODnv7SDsPnc6I++XK32nfdnn37bC98R8cS312k9XfUF7HiO4Gh9q/Kenh63Q+MHPvbO6ogGLe13GzisB9xJ/gl5iDxfbqHAoun5j83YZEgxeB+5C5DBRReEVS84MSeYdvjwtd1uLFhdvy783H06akjY4ao0Bj7o8oI9vAkalJ19/ffon+51rjaFSptxh5r5v0tB3UVC19RT9q8Re1Iin2uiRhzNMDDVNIntulXBR11i7tcTDbhhvPr26sEXJmPDMIzBqd+I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:49:31.4568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2766afe5-b29f-463e-7a72-08ded39221a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013

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
 tools/testing/selftests/net/lib.sh | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index b40694573f4c7..fcaec058be6d0 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -70,12 +70,27 @@ ksft_exit_status_merge()
 		$ksft_xfail $ksft_pass $ksft_skip $ksft_fail
 }
 
+timestamp_ms()
+{
+	local now=$(date -u +%s:%N)
+	local seconds=${now%:*}
+	local nanoseconds=${now#*:}
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
 
-	local start_time="$(date -u +%s%3N)"
+	local start_time=$(timestamp_ms)
 	while true
 	do
 		local out
@@ -84,7 +99,7 @@ loopy_wait()
 			return 0
 		fi
 
-		local current_time="$(date -u +%s%3N)"
+		local current_time=$(timestamp_ms)
 		if ((current_time - start_time > timeout_ms)); then
 			echo -n "$out"
 			return 1
-- 
2.43.0

