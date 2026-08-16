Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0191F936;
	Sun, 16 Aug 2026 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786895383; cv=fail; b=Xm5HjTgjFIe2edq64vkcv4k0QFPUnA+j7OIrcVlhHwqU9/AtK3IZRS8q9cRXVhMOH7FADpxkuJD/h6x5fF9NlSqkoCSha5gfcThBT5ZV9ArPoG6MppEI5gDNqF4EFYnWTVCnlfXFgvG+Zv9JG1Uj/URu02O7OF4mCcmNtgN6uK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786895383; c=relaxed/simple;
	bh=5Bu8UNOUn/yQ5RyaUnqS5SJhjhsfHQrzs3brCkwb/g4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=AgVnSwSLJb75cGe2gSnV6AktDur6Pguar2+wzp9fLc3ejTBEuGGbx7vpcla4AuCnemRkJk6ExheL655YkD0qRFuqyPZkugAs8DWHq/hO9yqnbthSRsOCEw0xVFPd/DQslSkoicZWKkWaTSAy/6lGPqd74f6Js+zaMYxboOV7BmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nOKXdTZ9; arc=fail smtp.client-ip=40.93.194.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nOKXdTZ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6IS4ewqZu/QPgMPNdLJ6zPzwzc10Hb69He+VIIexx3KWnfaOBdh0AIfNFI81OZlWXKQ8CVdHo3znCwRy9aV1OroNue5zh4iSjjOlWNx4yyqCKi/sCNQvnz1prf5T9Ww9GNaAaVbdloTb7u9ni46RlZXK9nqmfEZqb/Vt30WYltNwUgMy3/5GFPlV+PqqXNcwbaEyTuFsCJCsBBlMnW6vE5/6L5UxtVXOfe5pwULvqr12bsnc7QLLYeC84AUg++gcLRVSKtX3/wfJ3M8SKGMQpx/sXOqxnu9sgW6meFyzYrxHCj4BLjPB2etZTTWNcrl4dbpTWL5HA3WZJYD5OTLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5GCrBCx387mmAmsPHobU1xgY88VHyME/cbH8vg0FSQ=;
 b=ynPbGEHzqKoNYP50pYj/qRL72ctzj+TSDNWXZ7nzZnd/aJFglGDJem9Ge5OUMwxvsAbdYK5uomftPF6C4+teelNbRI78ZzyJtPB6J8kHDNLvuu4te8EEerAs3MIOUNYoCR0KZonFRKM42PASIE8XDCNRFR9G7Tcob4f34JvEgBoLDMMcXvwqAmMRup0+USgjr5FVdhtUIwTaJzz/n69c/Qt3A/wcJLbK/ocxBQKa/qnu2o7zvbUeZ25LjuyelW62kRBqk7bPvbWRr1sOaZ5pcdcTQwjIT51VkB5aRqp3RQAoyCYuocDp1diuesKXG/mkqijjODL7Z2mJVrRnldZs+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5GCrBCx387mmAmsPHobU1xgY88VHyME/cbH8vg0FSQ=;
 b=nOKXdTZ9QfVMDaocbW4FKzlSac61K8CcwE5MTXZ18IB5kksIF8hZpzu4DH9J9x33XhClJR1DQeTZibch2arAL9ye0IxWNshq3wvOXxYYaXSljJVRRUZx0SQ3mvZ86J0p485U9rkzr1xU9okjlkadX52RnT1DDbJlEnYXbupiTK0=
Received: from CH2PR14CA0040.namprd14.prod.outlook.com (2603:10b6:610:56::20)
 by DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Sun, 16 Aug 2026 15:49:36 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::9a) by CH2PR14CA0040.outlook.office365.com
 (2603:10b6:610:56::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Sun,
 16 Aug 2026 15:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Sun, 16 Aug 2026 15:49:36 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 10:49:33 -0500
From: Shivank Garg <shivankg@amd.com>
Subject: [PATCH v3 0/3] dmaengine: fix kref underflow and UAF in
 dma_chan_put()
Date: Sun, 16 Aug 2026 15:49:24 +0000
Message-ID: <20260816-dmaengine-kref-fix-v3-0-7e76187145df@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAATcgWoC/33NSw7CIBCA4as0rB0DtNDqynsYF5RHOzEFA4bUN
 L27tBtdGJf/TOabhSQb0SZyrhYSbcaEwZeoDxXRo/KDBTSlCadcUsE6MJOyfkBv4R6tA4cztD1
 nSvf01AhByuGjLHDe0eut9IjpGeJr/5HZNv3LZQYMGiMZF7TpXN9e1GSOOkxkwzL/Arj8CXCgU
 BsnqXJKU2Y+wLqub3VGKSbzAAAA
X-Change-ID: 20260518-dmaengine-kref-fix-7b21acb09455
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Sashiko
	<sashiko-bot@kernel.org>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786895373; l=1135;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=5Bu8UNOUn/yQ5RyaUnqS5SJhjhsfHQrzs3brCkwb/g4=;
 b=qrw1vs88uyTspBgKK8+gMP1G0rNpoUMs4M/9M98YXDMA3Kmo6s6ZldE7qAmNXwVhtDv43sQIe
 klrS6VUDh+TB8IYm/U1iyGjrwGZiQFkPTFcVjEB4B6K9nvwoXYb3TD5
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fda872-bb09-435a-20d5-08defbadf984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|13003099007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	gTXyZqpqps4mHcW9kdWw69lWLwTkawlxCuAUhTI8s04/mEShOrh1v3oa33HfsotwtzJU9tHG7zaq4Kc5j+kJLMGs4YdEJ+4YPWHFC1PWfIbr81xaeh/NM49gyPdPWuDiId/MV3FHgZz9210twtOcwoLuXWD6GeehhFNEZj5inaeyIvy9+jIxZxXM7w/J2tNk687hgJJBy4wohQoGQcTo4bLIdVLCEafBoEIDpojZ2w25dSavOXj64U6PO4UbPT9x6SxZxecpq25UslIHjsdBqsGsYhoLsKrSVBdtu/myLulqurF3B11YF6Oiyy9EL3MiCCvfK7N5pwDOGPMmuN5XygMQ3JWiXQ/788NEV2PWWK38husjZUpyVQz4jCYCyhDPgG9YRKMQ0oNatGpeylDGREv4egGYcv5c9hAr+LvmJmVp5wD3+cwsSudDJq3fubtd4ntYRXM3Vowqomtosr9LxSTRQj680BO6J4HXkcjkaUPpkGE4k/7h0OkVjwYik1vFGwMIqEeVEMpoCxOwfYf0zUvQZ9nBoOetTzeec16w1MzuPUmXH2WiL19AjApLgUYm1d8muVJMJTFZ1TrLSUL/cF516duiVKQpiO28HmZ+kXitBvyWdZJIzv40sL4vqm4Ucpc/WNaZb7LGbC2vcMmJXEa1uRLfDxC91ksDD5W1xJoPDMWb/bYBBF2+PETvrhgWfTwY/TpIFpEdOdLTcVVBbw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(13003099007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vH/CeA/XO1xQ0jvI1n8hYWryb8jsxJdC3Vuc0nEdxBj40LSgWdK5v8rtGX7JwWRUmSWZMtLceoWd+uDscQsfFNjslNbalQPehSoMdR0amFMIlDBwZtrZ6PnTk9UUmUQLOwEGqxyquxkfgwpqP5RnSzEziKMSXTuRV2G82SjAMQSA/ZUXKdd0/wsQuJUbR/f1iHj78Y503lCldQZpnaqnqKaGcKuHp6PU0I0oC5d2Vuxa31cq6kLqeJv5U21rRBE9JbGvkqzSR4tcJ/gV2mqV9Jv3WMb456lDYk8eVVMNtu2jrUkVmzoMXWkKS7KpYwRG8fEBJHEwdjgOfJE2ZEXup3ArEVFEgNapMQPFBmieVrqCR3au8yLQevx829Uxp7slYo/xbtYLbrGCYwbJW7BixIv9qo+QD/EQpyb4VaPCXIgTA/vB6UjKeVr0vKMdgenV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 15:49:36.6729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fda872-bb09-435a-20d5-08defbadf984
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230

Fix bugs related to dma_chan_put(), found while testing with SDXI[1].

[1]: https://lore.kernel.org/dmaengine/20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
Changes in v3:
- Add patch 3: add synchronize_rcu() to wait for RCU readers to prevent
  use-after-free. (Sashiko)
- Link to v2: https://lore.kernel.org/r/20260526-dmaengine-kref-fix-v2-0-3df60afac01d@amd.com

Changes in v2:
- Add patch 2 fixing the dma_chan_put()/dma_release_channel() use-after-free (sashiko) 
- Link to v1: https://lore.kernel.org/r/20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com

---
Shivank Garg (3):
      dmaengine: Fix device kref underflow in dma_chan_put()
      dmaengine: fix use-after-free in dma_chan_put() and dma_release_channel()
      dmaengine: wait for RCU readers before releasing dma_device

 drivers/dma/dmaengine.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)
---
base-commit: 0d995da5fb97e8c312834575604d4423eb6225b7
change-id: 20260518-dmaengine-kref-fix-7b21acb09455

Best regards,
-- 
Shivank Garg <shivankg@amd.com>

