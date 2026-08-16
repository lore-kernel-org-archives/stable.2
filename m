Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012001.outbound.protection.outlook.com [52.101.53.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F162A3B38B1;
	Sun, 16 Aug 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786895388; cv=fail; b=cUZycaZvAMx5Ilpw24R4Mux5/lLb576ZsCwPN1FT0whwNJDYOYl6kx+9jpbSSdRfMvvX3n5fcirM+JCxP/qTabVGo1FXwcobuaHWheJKaJwjjYo83btTfkM+6SNG4C7Rfkyv+cpkI+8iOPuKO+Q8iNKQOuNrfvrnQoC4ebmzias=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786895388; c=relaxed/simple;
	bh=tXtFzgzRwDCoBIz7yUWi4LDyktAyPuM/UleZbF2G8EU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QCXhl7VPXfaXQLYbhj25Euep6HMZRnHj5neabUFkGO46nFgMXQBxXhj6NmPhY7RrOLHgG8w5ZSRBcWYQ1C576ahCINDUUluGIScj3j1ao1g57zZeTfsWNtDnRn1nN6dZ0LsT2/uXobTCHBitZRdfdXAvbDZu8OEpmp5ITcNh3VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ppMEn9Yp; arc=fail smtp.client-ip=52.101.53.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ppMEn9Yp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFeex23OlrMQpIfgj/LgH8uPlOG8JA5S+1+pmWSRbx6mWMp0DmASDS2yhxDg9/9rpTwaR0UkkkGJpMkzHJo4zg6dY+bW0NKgQmMweQthA0mCDLe1bqnKG2epm/Z9ulLPaguaXnwgvKBXGN+gbGaG64rQ1UwVo4r1B+hA87T1YBCTsbbbeLu+Dc1x96FSCuBrlGHo1GMlujkDHJuS9wGNolrLXvTsBVey/n4ncdV/6WkFVpTKOfO0lQUP78HXJOCMp4Fib82cVsN+2rQ2iIgnA/8GTFiwpT/eyyUL9iU98JMEjCuFRYaQbG3/TjuSGioS1tlR0dhnxURaRU4EGoLb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxxTVr0aLE2WJKC790igZe6Hds30nyDVlgVGwpefJLY=;
 b=thwp8/w/VbHFKcr5Ra2t2OXci11/zMnOgYDvTrQbNp9suC5ihRIkxhijunrrbi3gtxWsAYOpnajWgAb3eqUQGz93JnOO+8aE485WzMzuJZ9gpAzjfatss+CZjOmbVta6q7kLQohgIogNcMUi5KfWq9LgBQrULaIogoWYad+PHxuHxz7OcpfKcf2PmjABtALhNca4hTojQFLPk84muMI4ywRmvKQYzTu/a3mDoY2XH6kii52U9eP9EGI/SMLntd8HjvRKjTaDuhURQeaTO5Nu626ZkWmAbADxqetIT68PRquQCXQ3TrntGPPJAgHy/trXD8NRKPhBRfElRCIPfDyPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxxTVr0aLE2WJKC790igZe6Hds30nyDVlgVGwpefJLY=;
 b=ppMEn9YpvUB+g+TcItqf9oLPP4NCu7hKCZ2xK6r+A3fQ/6d25JOgyxcouUq/B4B7ViGZArMAUT32ZWcf3N/0NbfG3GzjkEC+XaV1OijUFf2OsLENTKAimmbgn1GKs4BjFb8LDlm1CcFp1c62t0J0VbllXW39qYTvIP2ELuU5rFQ=
Received: from CH2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:610:50::24)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 15:49:40 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::1) by CH2PR16CA0014.outlook.office365.com
 (2603:10b6:610:50::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Sun,
 16 Aug 2026 15:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Sun, 16 Aug 2026 15:49:39 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 10:49:36 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Sun, 16 Aug 2026 15:49:25 +0000
Subject: [PATCH v3 1/3] dmaengine: Fix device kref underflow in
 dma_chan_put()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260816-dmaengine-kref-fix-v3-1-7e76187145df@amd.com>
References: <20260816-dmaengine-kref-fix-v3-0-7e76187145df@amd.com>
In-Reply-To: <20260816-dmaengine-kref-fix-v3-0-7e76187145df@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786895373; l=1527;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=tXtFzgzRwDCoBIz7yUWi4LDyktAyPuM/UleZbF2G8EU=;
 b=DgXd9eN2BiPe/7JCjFTzq8eDmtCpm3UcAkskneEjJw3wJmxjTgDoFrz1DcJdGJi9/S6Va3Su4
 xKeJi93UWV7BLVHSGKjdZGPO0Gyx2wOzFVoti2L2ljgCfIC9jMspBPp
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: cda860cc-d4d2-40f7-8451-08defbadfb0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	PmSRRHSUS/dWfzIW8qhkPnQUHtzBKNvuU6ZpmFL48BqVbhq98IH777SoeuS57jaKwTcjuxm+G+lt6TlS6MqInI7ovB3IB6Y8xkCWfZAPJiAVAS283ypECXGh9TiELoZLFnjgJ/714/HPOoBt2+tyTRUKhdgY0Hp5zkUszwqfnwEVf5EI5xVR+le1Sd8PeSIo9q2yrNYzuNUrVKX+qa07LvoebM/3kGcBDwt5mBfqeibwQzWSrY+ffnpjCG9b1Qyrpvm1c5mQEve5jMjyI8jLgkpxeg3YB8+LgW5sXoMly6urKDZmDmlzXS9ex+ZfNBfLtkBg8p2Y8958Y2bUA96s/sHUQ5wToxv+fQ7lgK7oNkDoiknczusxOj5IIHcCi/x5mp75Pl/2qg/LKs3gNCCaS7731B6lU3jywBW7TE/5dLj0gMfGY98IGdHHp4czzsgEbxPKKVzOHQkCzeB/ZbIOFm2Ag1YBNeiYNo//iDeZnpEKohXJPlyzOaAdeXXw+WAm6Vt4L8BSLFTsAhNHMeWiMd0slUbgGdxZo3I4r8dMKvWoI3IvReLU6P1JoRILD+at/+ucPhmn8GQAKP0RC2Rij2YoMbO+KPHbRRKPtPpprqPCfK6Kd1ykl/85wjT+XCtMhH/VLVo/NFoEumSUvHW9oba6kIShr0NQ4FWA3yrtChH6o45v43Rsblyz5oDedRGstqvn1QV5n+/P3+gq1ON5dA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H/ZOi6jdJX3R94O15rHUHQxz7OZwsNQsRsfIMwXN77CX+7tjaHLihxyQaFgRndUw5luuHSUHpd0M3FaicNzZlzuy2kxrGNZqgUhCbyM4ojGs+rTvLIK2nGE7zJKj2/lOmFTLVPTAvfsOQ4b0YBf9O7AZ7lJxn8notpuYGRB7Uoqqgkw0bSnBnLJ6SFLP9mdWylN0yWifwyp5121v4+h5i4ocBw/WkqlgOJHKqI1+cFhokyo5Kq7wR+BjYPH5OFkWgFxrooHhb1dGomhHrShVFM7xO/xEHhFZ+9fVr4m3E7+7/7I+KgFo1nK0XtQgmIV8ioMilwSTmisEteI5HF3rdUs0U2zYbz1EvODzNHrltNIA/5U/8WLsxPteQvrBsR5Aupfjh6m4hAffxpCAbnFszTXsLR75WrbWnU/CPb3XuD2HUpzVUkKwplp/yqqH2TYe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 15:49:39.2540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda860cc-d4d2-40f7-8451-08defbadfb0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120

dma_chan_get() takes chan->device->ref only on the slow path:

	/* no kref on fast path */
	if (chan->client_count) {
		__module_get(owner);
		chan->client_count++;
		return 0;
	}
	if (!try_module_get(owner))
		return -ENODEV;
	ret = kref_get_unless_zero(&chan->device->ref);

dma_chan_put() drops the ref unconditionally, so every fast-path
get/put pair drops one extra device reference.

The bug fires when two conditions hold together: a non-private
provider has a persistent client holding chan->client_count > 0
and another client cycles dmaengine_get()/dmaengine_put().
When the kref hits zero, the subsequent dma_find_channel() returns
NULL even though the provider module is still loaded.

Fix this by dropping device->ref only on the last put, matching the
single slow-path get.

Fixes: 8ad342a86359 ("dmaengine: Add reference counting to dma_device struct")
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 6ffd8bd82154..516d6d933208 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -515,7 +515,9 @@ static void dma_chan_put(struct dma_chan *chan)
 		chan->route_data = NULL;
 	}
 
-	dma_device_put(chan->device);
+	/* This channel is not in use anymore, drop the device ref */
+	if (!chan->client_count)
+		dma_device_put(chan->device);
 	module_put(dma_chan_to_owner(chan));
 }
 

-- 
2.43.0

