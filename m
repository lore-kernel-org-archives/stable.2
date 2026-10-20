Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792523145;
	b=oOnH4z6EuoiIN5+3OquIvbSyLlbIO1wAfJ2oWLZBdlpFWun4H13iITyvdWrkJLnq+3YY
	 xwkyB/7JJ00bdAJ1jrYF/4oQ2k3zZsPn2/BYZx5wozlgz1HWxanxzWmjFqWBSsFUnkGzV
	 Z1MsoXYr2mgCqVhNmjxMfvtgfBE43DXsucudtdHtbc0P3Vq+spxKO4oTihaoaCotVcNTr
	 p/v04XnRu6BnNA1/jStEbag+WVz1LgMMnYyItp7RxBg6eaxkgpD1ywU28oipaGpVXGyTT
	 ZynP+Qt+d/ENvzvDBIT9AkzwNeuxaJbWEyPykSAtxjyPpDDYXAqwEtbeCi6L3HOC/uA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523145;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=84DuYqgRB63EwlBZ+rtf1oK62VdWr/vyD33Zw1q2IXA=;
	b=tsrWlZyz4OQmDbCPntjVbOe/+ByTY8ldunEvfeBHEafvufkVGRqcniTDWwU7ltM4gMJj
	 0C/S+H4i+92VV1wcVhoqVX/f/Yz4j8b9HtuuwCMVOumkIsc26cTLfqgADGkpTSPN3jAIt
	 hKW4Q7R7OTz5NGpaVxJLofMQko3qwB7cDbisVk5V34jUgHJL8rGOMUI6fJCKyFBcrDMSn
	 J3+oksKY/gzD+mhiENuUeIF6E5XoB0H5zt6CGYW/DQdNXImMCWO2MpitRJziZ2cbYgxTz
	 JnCvZ8/1JiR9HWeDKnth51NzIM2ngkhpRq1Rb8Bm7kdLaXjhhVBnBjSXxpxbU6XijVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pIbGPXgC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.15
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08E3606A31A;
	Tue, 20 Oct 2026 19:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E08E3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pIbGPXgC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJtjIEX7RmhMGR9ZfSc7f1028kcOytQKegZ87yybEgQzzP0jf/Fp9WMyiqSU/n2V15VWG1qvVWTSTh+9v1eUsp4bbxXQQfDd4D0jW+xxfH9bjrlVq2sEyqb2S36GL3b178G4kM8qya9MEroYd+/Mlq60EGjEzzWexpXfM8efJBTL7CEJ9ZQK+mr4O65QIgxEs4e5Ew3h0aQOVmJI7WOGXUbhapbu0JbjWmcQAIOI4IzCh1bt48bcDBBeO3FNtlmPEeMUq83LsvsU583J028SX61yZJLXl8wO+yPn2luUtersPgmcO7zaNHBoVrN/bsNXdc2Wk3ppHufouDmd+3Rj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84DuYqgRB63EwlBZ+rtf1oK62VdWr/vyD33Zw1q2IXA=;
 b=bidD03hGNbXuOSBiTgB2voplLuxoZ6sLi1EJ2eQtKam7aA0YXwzDgdVP8JFPaa3jPfwnrm9I16ZueB4bwaWYmHph61p883tQYVUCWfFR3BVtbvyDl88RIz6QzFsE5pyRQRO9xZvKwzFMuZmSN9FeyaIzkjhvFBAxy8B4s2md5YttPuFyrEDPgGffE+M+VkJ7grOEvG3yg1dR9gArb3wEPUpiXAhPNPo+6lK/Sb9xj5qVR7WGkPbjrVBvtn564Q6oBQb35srdsfA1HhVpcGqNqAhTf9MJBpFVAgznLotHLBUaI/0Qb/U846BP64c6oRLy0FstC8t6RrU63BF+TBcRoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84DuYqgRB63EwlBZ+rtf1oK62VdWr/vyD33Zw1q2IXA=;
 b=pIbGPXgCF4k77eFk7J3oyRIeOjJiOdNE5pi8inpQefVhaRvrX4OxP2dUm4LJX/J3gpcZb0wjdqpvvxDUJu7mH4RaQZe4z4kWTrii1Znv3avcttaDBO85Y3SDUD9pXmZygy1eHC60Haa86qSdcPYDOg76MGZ4GjEkRI0i/xTgD6Bofi24SVB35BIhMiZ+8sszahVUDSzedLLnyym0Wkfj1+S1t7uN2PWqoOh8LhjCMX80UrD7tZGSGOwqyS2G+vFsfrDo2qD/fx6JqpJbzgXdEjUGtWlp1lQHHbQY9k3cYA/ARRyHXiRvAKMkpc9QGBQ87w3fZHldFxp1rW7QVAs0nA==
Received: from YT1PR01CA0082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::21)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 19:05:40 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:b01:2d:cafe::4) by YT1PR01CA0082.outlook.office365.com
 (2603:10b6:b01:2d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 19:05:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Tue, 20 Oct 2026 19:05:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 12:05:12 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 12:05:12 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: <axboe@kernel.dk>
CC: <tom.leiming@gmail.com>, <yuyufen@huawei.com>, <bob.liu@oracle.com>,
	<yebin@huaweicloud.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Nirmoy Das <nirmoyd@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] block: keep flush error across tag iterator reference drops
Date: Tue, 20 Oct 2026 12:04:26 -0700
Message-ID: <20261020190426.1073318-1-nirmoyd@nvidia.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a56c6fb-cd3d-4de7-d8fb-08df2edd21bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	InnAnVcXOb3laCjXVrrFOMoJPNqPu+c4uf2W6s5jed306UEeQOd/rcvy6n215O4mu8QvQlAo42JDcLXj8Qbj5/jCvbPqNjaAk8swsLFEPF18Uh6wLHx7OdCk5U4zzfI40DpKnX4OCgOU4jfGe0TRy0kCZbySOA5KnZa4JX9WtQn+P6acLxMRhN7eVLM+6FWNlyz0lo2uo6a3Tn5GL7qCiz8mETgsMIfK4IscXqWGhJNd2DGLAkUwMtyXTrUY0aNKnWxa160vhOnQjaKeAju4Uty+YOyYJvrg+ga9AZXmw4+o2f+cEK6uuvPzk4uhyMvI9uOPIdJCXJWl2Ehf7kK5GWgBNYLyxsM4qO2p+v2WtNFFEFPByo99MUi4juzZ0Nc9YbazkZRpdwXc5HNqF/ZRZJ4Zt8ytfm0CKXmkPnGE9CHC8fTP74+9EEGmK3W75FJI3Mzdef0A6wihoFW13/MFoTIEADvRDJDSIlH/Yu3A+DB3JGAXNpRoHXRc8kY4l4poHznQUUG3T4VnysVh4UHBJ+J6POAw9DhVLVlRS7Sj5trM3JjzJiAX4KMphPP6xVpF5W+141/jXwmqu/KSJ8fwfayRQUtybCLl7xHp6g3xV4yOE3Xrb5Ug3NNOrjGcBlbvhQIs1lJztIR5sVHG32Hg99C3BL86BOPN4mtqHMdat3ZXlcQ3evGBYovD4hYm0AfID3wAb0YI0C+J9z/xn9fT3A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cPSoNs7yYAgLieiMwTuC55OLBsoneBbosUBam4CVfF09ABY+yuIVwdUsIaA+1XG0OZezu6PjI6cvODHxWC368xV6qBv8q0OkSP2E5hm+kpmajW4xfV6k8uHT/T4d9zgxA3mU4iUztI6OU3/EhRDDndHdfXPzQ4PUY0QUg6Yvkf7wZtj/Q7+4Yos7qn+O1prKaXe/d+/RpqOmGzq9X5TWdp2NyDAcizIrF2AiqU5QasqyslBUQvtBiFPONBiVFYaut4qYUdY+bDJgbQGKIsaRsxOjQT8fyiiKf+aBtPyX2BSmSLrBdlFye9kCdX6/8xnNEUgs4AArDibAViZQTmWtOaUkld73uOpROIvKOiY1MeKeic9VZNMTS5BzIQwxAzxbzHEplGY00A1L99Hxc0MEUPG2IS/iJabP/pricGPI3bsUPbIsCLnKDhLSjvPaTuI1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 19:05:39.6790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a56c6fb-cd3d-4de7-d8fb-08df2edd21bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556

Tag iterators such as blk_mq_queue_tag_busy_iter() take a reference on
each busy request, the flush request included, and drop it with
blk_mq_put_rq_ref(). For the flush request that calls flush_end_io()
with a zero status. When that put is not the last one, flush_end_io()
stores the status in fq->rq_status for the last put to report, so the
iterator's zero overwrites an error the device completion stored there.

With two iterators holding references, the device completes the flush
with an error and flush_end_io() stores it, the first iterator drops
its reference and stores 0, and the second drop reports success. The
requests waiting on the flush complete without the error and fsync()
returns 0.

Only store a nonzero status in fq->rq_status, so dropping an iterator
reference can't clear an error.

Reproduced on v7.3 in an x86 QEMU guest with scsi_debug, failing every
SYNCHRONIZE CACHE through its debugfs error injection while 16
processes read /sys/block/sda/inflight:

  modprobe scsi_debug dev_size_mb=64 ndelay=100000
  echo "2 1 0x35 0x00 0x00 0x02 0x04 0x44 0x00" > \
      /sys/kernel/debug/scsi_debug/<h:c:t:l>/error

fsync() returned 0 for 35 of 18000 calls on /dev/sda and for 46 of 18000
calls on a file on ext4 without a journal, over six runs. With this
change every call failed.

Fixes: 8d6996630c03 ("block: fix null pointer dereference in blk_mq_rq_timed_out()")
Cc: stable@vger.kernel.org
Assisted-by: LLM Specula
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
Ye Bin's "blk-flush: fix possibe deadlock when process nvme_timeout()"
(not merged yet) adds lines right after the same assignment, so the
second of the two to be applied needs a trivial rebase.

 block/blk-flush.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 403a46c8641172d..65697e2efad290b 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -212,7 +212,8 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 
 	if (!req_ref_put_and_test(flush_rq)) {
-		fq->rq_status = error;
+		if (error)
+			fq->rq_status = error;
 		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 		return RQ_END_IO_NONE;
 	}
-- 
2.43.0

