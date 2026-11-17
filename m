Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943156;
	b=scGG/zz7+uZ9ujxNZFGqnaolw7ODSZw+QC49KSa8dXFo2ZEFifY9PYjDhiaV8nJxa4k6
	 YzgCuii2WA+ZTc11mTzwvssJ6eQ1hX8UlkoQuGfmnrAfDyrHb19bxGu+qaB4Tn2XQSeEu
	 EbHly7/YjVS5Yu8FD9Wkof7vLsaNqCnAQgXURuqtM8JRlsBc+lClXkdP6FTi1Vj16ZTrX
	 wUie/hAbOLPbRkF0XaWlbvdo4c7yf4NKUy54l0OMn2Bun30S8TA34MsMH+OD9Drj2IqMi
	 5zT3LFZJNOm2BasFFN8iUDQDcobbzLPM74FbrtJGkclG6/0rzJHFYWKSyOX9ZtpW8ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943156;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=gh5+5/VO3Rlkvi8kJejK98jZTxK3UR2qJhPuluExq+c=;
	b=WCfsHZyc+l0eKpSgRq9Pus134AUqzRSOuFpf8a5+ARgZC5yR8ZVjxbBkq38ImzYoh13G
	 0RBd53pAcr9uAEsgl7noFqQ8vWzIqZO/hbSLgTJhUwZPHuJibJjhLvhiit7QnSePxtWvW
	 oaij/64Mq6Yut3j8WsZTRrc1W0rj/KrDLhjOzLKDQa7a6VUQXihbI5v0CjInGlKokAFvk
	 KoFecab1ljlfaynQupmvSGXztPJkikYPVLCSNYknCcaZktxj/VGyMLujl/0s9fPY6ySVa
	 BJZ0k6XqlKn88kjq0l8NE5FfVv8fJqtTWYbttNUiJCr256X55nr0qR2H/7vTKzcCUMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=K2UB3VqC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.43
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCB7606A31C;
	Tue, 17 Nov 2026 19:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BCB7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=K2UB3VqC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sp3JVnF06WM1l1t1b9B7ZyadQYqtbelS5GtTQpMAsDuHgsVISseIehG4Z3D+tTRlciqAkof5J9PLsO3x8RZ5RniSxLtBZvQloBSAj5Tal1PXqaspOZFvTK/3muxkKSdACXhn4pYFwheWU/p5r4Rl8rJQI2Jle8sE6an4p9q6mncbBDUE1JKTrJslKL41e+M/2KeobZJBUYVubZTmi+RVGUDRuKdllNHjkDpZ5zv/uknM/TvgN+E/PBmCdYjnhZjPZ6T4+fH3pmg4CM19oLNZ0ojc10esyija98RJl3KUt7tZf5+W0TmCccLICVknvL44inGXhJg86qwbuJ0PCwrXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gh5+5/VO3Rlkvi8kJejK98jZTxK3UR2qJhPuluExq+c=;
 b=K2vl9H6JMtRcXjp3sDR5BlRqRT30uDrVgQS18UVad7Y1zt9Y+uetgzCXfRdob4FsqBt+qzPbePPZ3/fbc3GbOMCsIefpd/WVqax9T0JBCgx9MTDp+KRJe/6EA0mIC0fPXb8dKjYjkBLCxK0w4nEnN143IQuzZ5sYw8jnQ7YrhLwifEZl9vso0+PJBLobvEpw1MZ/5tLEgycYEP9yLcXLfZuaQbvZ2i6ktrbCG906ClM/glsuQamCfkk6t/eMijdKKbIdEu6jvzebCEo4sIfPynYeCXEqkg0I4HG8QKJ2f/um6M1FytBpK3xUreuLwS9+H+/m3lCiwhgzA97QqTuwaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh5+5/VO3Rlkvi8kJejK98jZTxK3UR2qJhPuluExq+c=;
 b=K2UB3VqCRa2ImupwOJYRmeCi1FY7W5f4eiKMUXd6HYlLyLsnpZ/CT0KwZFsHlI01rDLlAAQCKd2EP6zUuKTYml2ZcTvuL4UzhfMW/aNksR8HZxJexkA6NEZVHckEy/VnNGk2CEUtLHgMx8xucW3qoDaXs9sbB77NuhZOLzCn1Ws=
Received: from BN0PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:143::31)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:19:11 +0000
Received: from MN7PEPF0000014E.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::54) by BN0PR10CA0001.outlook.office365.com
 (2603:10b6:408:143::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:19:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN7PEPF0000014E.mail.protection.outlook.com (10.167.254.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:19:10 +0000
Received: from [10.11.96.223] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:19:09 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v2 0/2] ionic: fix Tx stalls on TSO skbs larger than
 the Tx ring
Date: Tue, 17 Nov 2026 19:18:53 +0000
Message-ID: <20261117-b4-ionic-tso-max-segs-v2-0-f9792566c5d5@amd.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ2o/GoC/4WNTQ6CMBCFr0Jm7Zi24deV9zAs2jJATaCmUwmGc
 HcLHsDl9/K99zZgCo4YbtkGgRbHzs8J1CUDO+p5IHRdYlBClVKKCk2OSXEWI3uc9IpMA6MoKtN
 RY3vKG0jdV6DerefuA2aK0P5Cfpsn2XgsHtroOPrwOd8Xecp/jhaJAsvKqrzWhSlreddTd7V+g
 nbf9y+6AzpSzwAAAA==
X-Change-ID: 20261107-b4-ionic-tso-max-segs-057bde9cfe49
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Eric Joyner <eric.joyner@amd.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, <stable@vger.kernel.org>, "Nikhil P. Rao"
	<nikhil.rao@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014E:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f84c66-42d6-49fe-97d7-08df44dfa88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|261021135927099003|10067099003|11063799006|5023799004|56012099006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009220027099003|261009221727099003|261009223327099003|261009223027099003|261009221227099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	QucHyE/+JnKIeTAZdhPwzknVqrpqRliJyfqsYCyAzEBqj+XHBfqh9MKTyhY0LjAR6S4EFDQR0VA1blnfXqMC5PT1+Ck64nauyVoMdaJgx+ezP62qFLD81OD9NEjBuP6DnbFTd5c5+OoOSbJNrafYRxTCkeidItRKHj2JjxGft+gjHjPgHlsJa9rfATpcRUHcc1wYJ2eq30iMNenyfuypL4IcjAO9KerjochYulRmAWHKVB22CJm5UOTUm2P13IV6ZmDp2IB45KlzVt4oLCpj87mOMoD5OWnH9bmz1FMaEHlTSEPSHMgTakIj86xVeR0WQzEJL1WII5xTNjt/S0tRMA6m7TmtZinx5tCTnGo4DV23Cjyk2f59QAhlhXPN0GxORjJHpRDJtek4N/r/QnstN/SqRmuzdboONVNYgxNeu/ipEToZJDaQoMph0BbdNCv8peF8JxxeZpoW5FZ0v/2ebxrLqPoWkOkXTukulvJXFY2pJ5TEg2/PjjZiXtNRvN7YKR/9TnEoMlsthmO6c9eGhwcUr2Csuof+GCHM15fu3A6UWgtsHwBmp39RXXq8SgM0i8ftNe8XE/sM13SZDqb3gNa4L2XxZtPxqKl3aA5prtmkCRpaLavby1QFpKcr1b7RDeRZeEnxqOqZ63sLi+fWZA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(261021135927099003)(10067099003)(11063799006)(5023799004)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009220027099003)(261009221727099003)(261009223327099003)(261009223027099003)(261009221227099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x9IN1NEgQGZBNNlc5e5YIKkK7rthHIvIc2wZepS1whjZxo9iFIiF4TfFekqxf67ydIOrFrCegDPu2B/Wh1VYmFULvCkzps8b+YGS3CpkBPjL+lGjtbea6oCU061cP23ZMtuYHpdDOp/yoLbXxrG5U9SZB90HQW6qJ/1rlFOeGHXs2AeECGE7P6ryB7/idQcyGpX/js4IKnjDLS0/a8cTVPT/D7P3+yHsAAlQAFZAh+hwJ04lz0BLOaxKqCO3F35vZ4YnMB94xIHnBRdwshV8vXIIKsvWPUM+aLUEIwjvre7mIjcLoXQif9z217gSqv5lpu4pFHdNltzjNGD/4HQTSQwBRC7GPLmcapm1J6f1PpbC/DgY3YF2ZHXEBFzh9YgQPcSNz9StILBCVXIstV1mpZi9qrRt3wh8imSpbd2Ss726j7j6x3dKFp72gqu+16o1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:19:10.5765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f84c66-42d6-49fe-97d7-08df44dfa88e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN7PEPF0000014E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467

ionic uses one Tx descriptor per TSO segment but never sets
tso_max_segs, so the stack can build TSO skbs with more segments than
the Tx ring holds. Such an skb can never be posted: the queue stops,
nothing wakes it, and the netdev watchdog fires. Guest TCP traffic with
an MSS below 64 hit this on the default 1024-entry ring.

Patch 1 rejects Tx ring sizes below 64. The completion path wakes a
stopped Tx queue only once 44 descriptors are free, so a smaller ring
never wakes once stopped.

Patch 2 raises the minimum Tx ring size to 128 and sets tso_max_segs
to 127, so every Tx ring can hold the largest TSO skb and larger GSO
skbs are segmented in software.

The two patches fix separate bugs; patch 2 raises the Tx ring minimum
that patch 1 adds from 64 to 128.

Changes in v2:
- Patch 2: use a fixed limit of 127 segments and a 128-entry minimum
  Tx ring instead of following the Tx ring size, as suggested by Jakub.
  This also covers the hwstamp and kdump Tx rings.
- Add testing notes to both patches, and Cc stable.
- Link to v1: https://lore.kernel.org/all/20261107-b4-ionic-tso-max-segs-v1-0-67c248a5b681@amd.com/

This series was developed with the help of an LLM-based coding
assistant (Claude).

---
Nikhil P. Rao (2):
      ionic: reject Tx ring sizes below the minimum
      ionic: limit TSO segments to the minimum Tx ring size

 drivers/net/ethernet/pensando/ionic/ionic_dev.h     |  3 ++-
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c |  7 +++++++
 drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 10 ++++++----
 3 files changed, 15 insertions(+), 5 deletions(-)
---
base-commit: a2fd526d644233d6a892c28173f07c61e21e4c93
change-id: 20261107-b4-ionic-tso-max-segs-057bde9cfe49

Best regards,
--  
Nikhil P. Rao <nikhil.rao@amd.com>

