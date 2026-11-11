Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794388649;
	b=sNZht08sxOG+kdhYZZoNBflFF5BhOqZ2GX7H3VXtttV9Zgxdk4Wcz1pPxYgsnmhjT8Y2
	 aby+LoDoCRu+J5eRhn582tZNvNmYgMePYiVn7cC7Wh+kmhf0n9dPsa+SS2VNiETmuNgtf
	 39pj9IvvT6Ze66bNE7iix+dTmPAvyFWUvvypZCrgEY9y4aBmcRlRt/e94MPRh+LXqZ/nd
	 3BmeiuVJ2EjgGpQw/QbE2tBcavs5Rrh8U9LA69IjQ7crccHaGCihw1vRvbViUjAMRxOwM
	 Kf8L5s+C4nisE8wzcvyoO8QxjnmqgiburyuGoW8Iz3d08ah7vzLpjj12ISkcrLhro8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388649;
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
	bh=3SLDg622Qe29XpSTibPB3VdUrHoO8VY/AGAZWC6Oj+c=;
	b=ixqdkPkSBjd8MDSXtW+YcKJhRBwmFCc2d9u3NT99rBv74oZ3cl2JUF9o/4pLFE9QjaPx
	 2d2DjmBW2SpTftfmFQPHJUYObhoLEPJt2HFfjp3/54m+pYLdPV3RhOfqorbbl41CMP4Qn
	 ykF/Y7UkWwHuyzo6J5xoW9CBDuRt3UHmG+cdwFpSZ6ZVBfSHRPzo32mSUtqk1UWU+HhtH
	 O1bCEE26m1r86S8vJ1xOMSbx8Ts7UIMnYuCggRMY+Gf81tGgCnrN6cdOnyllI8GRXIuTF
	 dkOmkO8B9NOAGwodjqOIVQIXE8HyMnAwpt5MZiQcojOZpwa9zrdac43URnn322FCWEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qs1K9y8h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.63
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D9E606A327;
	Wed, 11 Nov 2026 09:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61D9E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qs1K9y8h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqFg21EyxGeLgffKBQPDhI4WqRq/nLN39B0cO1ruHys27T4GmsvnRx9+2DOnnIQqT78BX8prJrz3Q7BvjxZmeznVj0+aKgJu4iiHsBDmCUpNyQhGVYHAPstvyIQcU1hkBSzjYS7d/jVF6kJgqO1ztrhcsTLajI2+sBjhcOPqh+0JwKFwIxwnsZFKVJAl228BLmPoQTeXnR+o227SeVGa3dmpNmmK19E6Wk9+0GwTSWqq4YFnzm43ejX03UxcLmWaLEsju+7g3oA+h2IS1JzyoNgHtfYWwQ0btv44y2UyzH2yDRA+5BW8+coT+ePW2A/x7QE9KKr4aM2mbYo8KoRtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SLDg622Qe29XpSTibPB3VdUrHoO8VY/AGAZWC6Oj+c=;
 b=KY2e2zOtS+G3AJrt32iemtU5ohgLoTQiI8L/oMxWN/QWLX1WtHaBHNAbuaHExO4fZYMR82+0vpdWiwy2UOpDmQmDXVomaxTBBfQgSFchubXbYWuUJeoxsr7V6ysLy5ccrN0CtbyaAwXl3fv7YGwKK4mCwX4uCWt0tPeQqrnrmEO8pFAZqGZHDr6zTuRIGmACPMxZhWWjcgcQYk49r71ChYgHLsqHfzpB3ThWOzT9vR3jOeAWhqrbwRA5p/oETmH55LhXLblCc0ZyRRFtFlCcwYJFuiDLrDyWIbN4K7tA531bBCDSIE41pJH6kErqSRNoOi1rmzUbXHTIC1IrHn7NSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SLDg622Qe29XpSTibPB3VdUrHoO8VY/AGAZWC6Oj+c=;
 b=qs1K9y8h5IJYjmKDNOKJCYE+p8hpzH2miFYIwxfEzH/G17l5gkdWg5jBLxKx8/7PjI6rEYt6UPDOw2t8Zd7jE6vOUDRyJhRuwbNjcL3rxXTnG/E4DyR5nZaZL6n8neRXQll1wdG8VnTMfLdupfqdqVl3ND6Jib7RB0dnxH+xpRhkMGLj5SpugNEDWNkJ1z0fygu4hjLO0n+M7tBFZl32XY0z+sUJuZKEZ1qCnFTVi8oe2SCgm3+Z4DH9Y9jft3xdHxq18nXU8IBXpl92TAWUUoIbdyu3oFxLYBcnqi9HZxxv3rM+ofpNkBvQBXVDFq6JwOg4Cw/vps8k2jQ5eLe1nA==
Received: from BN9PR03CA0746.namprd03.prod.outlook.com (2603:10b6:408:110::31)
 by CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 09:17:25 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::47) by BN9PR03CA0746.outlook.office365.com
 (2603:10b6:408:110::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 09:17:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 09:17:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 01:17:07 -0800
Received: from r-build-bsp-06.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 01:17:05 -0800
From: Felix Radensky <fradensky@nvidia.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: Vadim Pasternak <vadimp@nvidia.com>, <linux-i2c@vger.kernel.org>, "Felix
 Radensky" <fradensky@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] i2c: dev: Fix duplicate chardev registration during module init
Date: Wed, 11 Nov 2026 11:16:44 +0200
Message-ID: <20261111091644.2499421-1-fradensky@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|CH2PR12MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: a666c3b5-66b4-489a-2352-08df3fd49973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|30052699003|1800799024|82310400026|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	d9PQM+TnvHZOawbphJAo8F2V4t8EIVFo1dkV6uaM0pL2rxvUuCvWk272PcIga4I6TCvbXg3/HZzEt78U8uhhoR2slFv3g9CHL/Zwc1L3ERp87qoagtgS19lcBR91RzER4lt5xfh702tj9NCp28FPWtSCb7nBtjiYku7JFV+D1rSYyXo3zaWUuk2f0Wu8jwohOiJ8+Xm4VThkKwbelaZElJQz+MldpDlUv3RCKsox7lsgfUO8YoDytVYuOe9viqYj2XOFBhrreI0pNOUAaUXfmxH5V4qnPB9xa95QNVLPkKxmOZbBj8JlFByJNhiuE78dxqgmp+HgeJWifqJyQkmIC1H8/6ORSQB8N4wLgjTCYYQa9gFt4WATZ9B0Xld0muXjfAMJ5SnI5pivB8tdxq+zYQWjoGFPUZ1CEa0CB7xTKwLJE73KAHUXILZIqTFTfR4lyK0wHiD3BivUTHHBMCvmSNgFJSn2c/BV+yGjAW8eIjSfyNX19XrRZZ8vXxhuKGY5l2wVB9KVzg4ReJXtAhc7eL9c7u/5RmvMF3IrckXafIX1QPlJVNIldd9g5wi+3J47w2X/3BbGjNxf1kuIc2SfPh3uYew0Noj0wEpd19K47al97mlaa6KLqD8xz3G7jrw1owMwua+HEdhFpd5K2kRAeWbQ7bb19lSCC+bhFEtnzKwcRFj3lra/vNhaam3bwIrVsp1xnjfiS6bmtkZ5RiL3NA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(30052699003)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2Mr2FR/fpX13NrqhfO2Gi+jScHfAExaTkIUX6orjCoj/5Vif4AMImI/4uw8aORAoL1cYdEptgnEVzeiA4ZHVALQ8BmsjN/bwEcb1ZOmY3aAi4psu0cup9aKmXl4YKSDMDoQE/e3fxkMCBEE3WaEfU6IddfNTZvp+VGkSOB9HBajB9Snp+DQg6YV5M2aWQON67NqImsWocC02euCSzCsyuNgmEvpqbWxUgGtiQBN+5tndebFpQ8zwJrWHAcZlHC94DZXAhMAjj8W7HOcfvlTjqpy3+/YcKy8k72k1VPhJogwQzny838tFt3AsPSCU0tNp8ydRG9pBN3Ezfky9LsKM300WPHbUlcowzzkoKziighLbVKF7b9LRLPcxoUnzR+X9xwiD8hG6YH1S2d5R/8HsN0UeGHf+MUPlLm7e8l3B7B8nVq205eWWXNNfoHzlsMKl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:17:24.8267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a666c3b5-66b4-489a-2352-08df3fd49973
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9457

i2c_dev_init() first registers a bus notifier and only then walks the
adapters that are already registered:

	res = bus_register_notifier(&i2c_bus_type, &i2cdev_notifier);
	if (res)
		goto out_unreg_class;

	/* Bind to already existing adapters right away */
	i2c_for_each_dev(NULL, i2c_dev_attach_adapter);

device_add() links a new device into the bus klist in bus_add_device(),
which runs before BUS_NOTIFY_ADD_DEVICE is emitted.  An adapter that is
registered while i2c_dev_init() is running can therefore be observed by
both paths: the notifier creates its chardev, and i2c_for_each_dev(),
which has no way to tell that the notifier already ran, tries to create
it a second time.

The second cdev_device_add() fails with -EEXIST:

  sysfs: cannot create duplicate filename '/devices/platform/mlxplat/i2c_mlxcpld.1/i2c-1/i2c-2/i2c-dev/i2c-2'
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5d/0x80
   sysfs_warn_dup.cold+0x17/0x23
   sysfs_create_dir_ns+0xca/0xe0
   kobject_add_internal+0xba/0x250
   kobject_add+0x96/0xc0
   device_add+0xe2/0x890
   cdev_device_add+0x48/0x90
   i2cdev_attach_adapter+0x137/0x170 [i2c_dev]
   i2c_dev_attach_adapter+0xe/0xf60 [i2c_dev]
   bus_for_each_dev+0x88/0xe0
   i2c_for_each_dev+0x31/0x50
   i2c_dev_init+0x77/0xa0 [i2c_dev]
   do_one_initcall+0x58/0x2f0
   do_init_module+0x60/0x230
   </TASK>
  kobject: kobject_add_internal failed for i2c-2 with -EEXIST, don't try
  to register things with the same name in the same directory.

This is reproducible on systems where adapters appear asynchronously
while i2c-dev is being loaded, for example when an i2c mux instantiates
its child adapters from a deferred probe.

Registering the notifier before walking the bus is intentional, as the
reverse order would silently miss adapters registered in between, so the
attach path has to tolerate being called twice for the same adapter.
Make it idempotent: look for an existing i2c_dev while holding
i2c_dev_list_lock, which serialises the lookup against a parallel
insertion, and let the loser return -EBUSY.  i2cdev_attach_adapter()
already ignores get_free_i2c_dev() failures, so it just backs off.

Matching on adap->nr rather than on the adapter pointer cannot reject a
live adapter that reused the number of a departing one: i2c_del_adapter()
returns the number to i2c_adapter_idr only after device_unregister() has
run the bus notifier that unlinks the outgoing i2c_dev.  The number is
also what has to be unique here, as it is both the chardev minor and the
"i2c-%d" sysfs name, and it is the key i2c_dev_get_by_minor() looks up.

Fixes: 9ea3e941d161 ("i2c-dev: Use standard bus notification mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Radensky <fradensky@nvidia.com>
---
v1->v2:
- Explain in the commit message and in a comment why the lookup keys on
  adap->nr and why that cannot reject a live adapter which reused the
  number of a departing one. No code change.

v1: https://lore.kernel.org/linux-i2c/20260908095016.1050174-1-fradensky@nvidia.com/
v1 received no review comments.

 drivers/i2c/i2c-dev.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index d219eb8..011fa95 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -67,7 +67,7 @@ found:
 
 static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
 {
-	struct i2c_dev *i2c_dev;
+	struct i2c_dev *i2c_dev, *tmp;
 
 	if (adap->nr >= I2C_MINORS) {
 		pr_err("Out of device minors (%d)\n", adap->nr);
@@ -80,6 +80,19 @@ static struct i2c_dev *get_free_i2c_dev(struct i2c_adapter *adap)
 	i2c_dev->adap = adap;
 
 	spin_lock(&i2c_dev_list_lock);
+	/*
+	 * i2c_del_adapter() returns the adapter number to the idr only after
+	 * device_unregister() has run the bus notifier that unlinks the
+	 * outgoing i2c_dev, so a match here is always this very adapter,
+	 * already attached by the other i2c_dev_init() path.
+	 */
+	list_for_each_entry(tmp, &i2c_dev_list, list) {
+		if (tmp->adap->nr == adap->nr) {
+			spin_unlock(&i2c_dev_list_lock);
+			kfree(i2c_dev);
+			return ERR_PTR(-EBUSY);
+		}
+	}
 	list_add_tail(&i2c_dev->list, &i2c_dev_list);
 	spin_unlock(&i2c_dev_list_lock);
 	return i2c_dev;
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
-- 
2.34.1

