Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C401A3B83E8;
	Mon,  8 Jun 2026 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958465; cv=fail; b=GK7oi36xQibFl/VCCRPycEyjCUUoKQUpO1Z5ChlOHl0dB+eaeKr+2jXGCrK31nH2qpJ8p8SFD+T4AMF5O89KW6d1kBEyPTpMlIyaqp7xKFvih8PecLOwdKKQzKjz5Ty2/RwWAnhg1iLju6tcYV279jIzgP/T/vD/ICQbUWyET7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958465; c=relaxed/simple;
	bh=Uvm2KDZv4Q6uTWecgmkVrhq/+1Ma9Wb28C8leOUF4nU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BRldpPVinFaru46WsD6xbQ9gzDfd/bDdOQlwaOgOigeplVAN1FPrIbH8yO1CCzHTx/StPAvc/7QMBzNHtT6me8j4mG0wraFxXE42O7jAG9YENIwvbbk24Lv0rGZEkDv5Oa/5Jf8DXTsf21cOZglGEuHyO4kZ4Roqjyp8TWxaP8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NoVENXOn; arc=fail smtp.client-ip=40.107.208.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NoVENXOn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfTZCiBOxGlyU0K9kFFhXHRiNKA1k/buhCT1r3UEBdnS8UhqTPiwW2VnxJFc7G5XY91pl98JoE/qb2fAU58ubWNxgwMWOSg5w1CMu8Qkt79u2Vg4qRk6XoZJU2o6tbfNWS0nyy0BjBcR3L4I2dlWH5g5Nt4R7MuICfytfCnrUd87F/FQAczwUAhPrCxsi7YJaYHMYepPxUhGbwjb4McEF+1gRMiNj62U/7CJMcWfNiJXHFCL1nIVxo9cez41Xtfm/rnwgPTYV9jBFffTWEAzvyq7cjxkWGJzSmnJdD8iiaiwPZ4HdaT+phFyJsrompf/dNoyl9C7gQlPSVk+h7aZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Xs4d0Wc1WTzE90RF7Uoip55b4wcpmV+NaQwnGW6Byc=;
 b=qmXnPG4FSi8US612S6Os7DT4Fct9gA38p7ieslylHt6OjX4VFE4yvLisQXpc6MtUBbCdLYIO0JDmAUaiS06KW4Fp4OXHfxInXMe144LhmEIvB+OMrR0SM1eJCQ5amoiUD51maOJwr+c189ZvgXfeOqP6jCibya9OZtYFYjJnFYtgay7yVUoMoSxg0ItbSReSfmHdhM76FFTWxVeMtAkiJ7xpXSih10L1Yt1hJKnNfDL082Z1bLsR1HKxx5S/PQBoMkxDhSFTKp56JHt5djd9lUzuuepQbywVDUlCP0x7ygrvdLPsVHVqGuW5vdfdKLbUNaOrJaB5EqMcU8g5gpOpEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xs4d0Wc1WTzE90RF7Uoip55b4wcpmV+NaQwnGW6Byc=;
 b=NoVENXOnQQmS4pdqMNtU215RSqKi/FXqra/aNQ+Gar+ZK9k6Y3DM5pkYVgr8+IQq86KZ2mRZIM4kgWdfQZfdkqjyJCIYhIMwxu5rnpIKdjReK7v5yN0hGEMP3kSi71CEvNwo7z4VN6lUHax29fOJA991Ac+PmTrdvc3/vpP2XC0=
Received: from SA0PR12CA0028.namprd12.prod.outlook.com (2603:10b6:806:6f::33)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 22:40:57 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::19) by SA0PR12CA0028.outlook.office365.com
 (2603:10b6:806:6f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 22:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 22:40:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 17:40:56 -0500
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 15:35:39 -0700
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <djbw@kernel.org>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Benjamin.Cheatham@amd.com>
CC: <Smita.KoralahalliChannabasappa@amd.com>, <stable@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v2] cxl/port: Fix missing port lock in cxl_dport_remove()
Date: Mon, 8 Jun 2026 17:35:33 -0500
Message-ID: <20260608223533.583278-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: ccfb115c-2a55-432b-83fe-08dec5af01c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|11063799006|56012099006|6133799003|18002099003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	jERXGp7nLLjuPee3BKV0wjyUsgqpB4FGTquBTK1sbiLKdKyRuF4tw/Gha46DZx/EdO+weOxhJ/8ROfoKrRMB4XNzRKw8xFXDAj5UlGjsBkMFCcms8fMsPgpVHrc7EP8kMLqHVNLYhXGzYQfG1uDjVELK5qWgnL0evnlhuZCYR25SEA53OwQZNeI2ADvXq59gtAkHratzjZ4zLeGy1RUlRzw9YMCgpYRd+O0TDdQmW1xNrZDfow35STK+pmphIqpzaRc627xu0DdzZx5h2y9A7KJrgCS+V4jR28GeJYsAD15r9yEb66UriDjP7DU8fUyEgxKVIR0o9ouINtGLpWMvwVdYq1eeTqo2fm5pVajJhfBvZ1+TGrN9zsvC0Oa5gy6DfbsXOCkVxtxG13EFFX6FDXX1fvXeSqsCmHYZ2vLblRz15cRHIGi4Qb8G+Vbu5PJ+dMllnd3zdVCFMzv2tC3ZKwp+QinE4T85mcqcCU34P2hafL6W3FuOskegu7Nl0P3dVw+FssRPFixM+v+f6BT5BYyI74Grg53LFy9edeJnXOkDx6W8dIjhAF9+j2eJvgMSrHxQo9gieHXBmbOPSHLcxfXskSwnfU4Kjg04r4VqA65DWCq6EurG4z0o19FEtGbW5Bg1oGGUTlCemEOVFJiWmYePwAd7huydqQXenl46dhSN59WIjHe1qAn3wheqdj1kG5PcBNu2fZcVTveh4RTVHeqte1VD2ck54QUa4iN2CP4AS5joWcUlm2516SnoDum/w9TwH0QSKtg0VBv7+s55LTLU/oMjs3o8Dw7k9xAazRc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Hsd4wJ7n9wEBOWuRXuOUqnJZYLrhxAw233MxhCu00vPUO1r2VYHZHI2VYYAq9LxYTC/EpdccgWpX5ZnnNsx8D6x/wvcDomh8IMTM2qhHZBp2zrLNzcSOVPoxHusa4GZtKTVD/tV1HejF0J11WPNZCXuNp/+sTgkzSOsu3fSothqwPVgC/Jzk7JzY68Z3o5k6CRvNjFAR6kAsdYSHo9+FrqjV97AL25U3kUCJgdgIfPosaRlQTPl+ijufzdCxBxi0AGa0n4BuXNwgx6e62l+vFZdl00uGq6YDXVyAMRUXtRF4ui1nXb+p61Vf0U6uh5PcENj67URmsA4bypEhMpCrWGheB9E49ScQFk/xrlBNYA5KDfkgVx/14siscsFsmnc5UNWIMkTnCPb5qWAdDtCt+nTr92ikKIvAiTC7kjDlToB7HZFAoTtG3bSC/EOJqBjA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 22:40:57.2300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfb115c-2a55-432b-83fe-08dec5af01c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845

xa_erase() in cxl_dport_remove() runs without the port device lock,
creating a race with any caller that does xa_load() on port->dports
and then dereferences the returned dport pointer. A concurrent
cxl_dport_remove() can erase and free the dport between the xa_load()
and the caller acquiring the port lock, causing a use-after-free.

For non-root ports the port lock is already held by the caller on two
paths:

1. Driver unbind: devres_release_all() is called from
   __device_release_driver() which holds port->dev.mutex.

2. Dynamic endpoint removal: cxl_detach_ep() takes the port lock
   before calling del_dports() -> del_dport() -> devres_release_group(),
   which synchronously runs cxl_dport_remove().

Use cond_cxl_root_lock/unlock(), which only acquires the port lock when
the port is a root port and the lock is therefore not already held.
This matches the pattern used in __devm_cxl_add_dport() for the same
reason.

The write-side fix to cxl_dport_remove() is necessary but not
sufficient. Callers that obtain a dport pointer via cxl_mem_find_port()
use a lockless xa_load() and must not dereference that pointer until a
lock that excludes free_dport()/kfree() is held.

For root ports, dport_to_host() returns uport_dev, so all three devres
actions (free_dport, cxl_dport_remove, cxl_dport_unlink) are registered
on uport_dev. __device_release_driver() holds uport_dev->mutex for the
full teardown sequence including kfree(dport). Holding uport_dev->mutex
on the read side therefore excludes concurrent dport freeing.

Fix rcd_pcie_cap_emit() by passing NULL to cxl_mem_find_port() to avoid
capturing a lockless dport pointer, then re-fetching dport inside the
uport_dev guard via cxl_find_dport_by_dev(). The previous guard on
root->dev was wrong: cxl_dport_remove() releases root->dev before
free_dport() runs, so root->dev does not protect against concurrent
kfree(dport).

Fix cxl_mem_probe() similarly: pass NULL to cxl_mem_find_port(), then
re-fetch dport inside scoped_guard(device, &parent_port->dev) for the
VH path, and re-fetch again inside scoped_guard(device, uport_dev) for
the RCH path. This closes both the TOCTOU window between the lockless
xa_load() and the guard acquisition, and the window between the two
sequential guards in the RCH path where a concurrent surprise removal
could free dport before devm_cxl_add_endpoint() dereferences it.

Reported-by: Sashiko
Fixes: 391785859e7e ("cxl/port: Move dport tracking to an xarray")
Link: https://lore.kernel.org/linux-cxl/20260505173029.2718246-1-terry.bowman@amd.com/
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c | 10 +++++++
 drivers/cxl/mem.c       | 65 +++++++++++++++++++++++++++++++----------
 drivers/cxl/pci.c       | 17 +++++++----
 3 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c5aacd7054f1..0b8f144596e8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1092,8 +1092,18 @@ static void cxl_dport_remove(void *data)
 	struct cxl_dport *dport = data;
 	struct cxl_port *port = dport->port;
 
+	/*
+	 * For non-root ports the port lock is already held by the caller
+	 * via devres_release_all() during driver unbind, which holds
+	 * port->dev.mutex throughout.  Acquiring it again unconditionally
+	 * would deadlock.  Use cond_cxl_root_lock() which only acquires
+	 * when the port is a root port and the lock is therefore not yet
+	 * held.
+	 */
+	cond_cxl_root_lock(port);
 	port->nr_dports--;
 	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
+	cond_cxl_root_unlock(port);
 	put_device(dport->dport_dev);
 }
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index fcffe24dcb42..345b56f215ff 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -70,9 +70,9 @@ static int cxl_mem_probe(struct device *dev)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct device *endpoint_parent;
 	struct cxl_dport *dport;
 	struct dentry *dentry;
+	bool rch = false;
 	int rc;
 
 	if (!cxlds->media_ready)
@@ -107,8 +107,7 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	struct cxl_port *parent_port __free(put_cxl_port) =
-		cxl_mem_find_port(cxlmd, &dport);
+	struct cxl_port *parent_port __free(put_cxl_port) = cxl_mem_find_port(cxlmd, NULL);
 	if (!parent_port) {
 		dev_err(dev, "CXL port topology not found\n");
 		return -ENXIO;
@@ -123,21 +122,57 @@ static int cxl_mem_probe(struct device *dev)
 		}
 	}
 
-	if (dport->rch)
-		endpoint_parent = parent_port->uport_dev;
-	else
-		endpoint_parent = &parent_port->dev;
-
-	scoped_guard(device, endpoint_parent) {
-		if (!endpoint_parent->driver) {
-			dev_err(dev, "CXL port topology %s not enabled\n",
-				dev_name(endpoint_parent));
+	scoped_guard(device, &parent_port->dev) {
+		/*
+		 * Re-fetch dport under the port lock to close the TOCTOU
+		 * window between cxl_mem_find_port()'s lockless xa_load() and
+		 * this guard acquisition.  A concurrent surprise removal can
+		 * free the dport in that window.
+		 */
+		dport = cxl_find_dport_by_dev(parent_port, cxlmd->dev.parent->parent);
+		if (!dport) {
+			dev_err(dev, "CXL port topology %s not found\n",
+				dev_name(&parent_port->dev));
 			return -ENXIO;
 		}
+		rch = dport->rch;
+
+		if (!rch) {
+			if (!parent_port->dev.driver) {
+				dev_err(dev, "CXL port topology %s not enabled\n",
+					dev_name(&parent_port->dev));
+				return -ENXIO;
+			}
+			rc = devm_cxl_add_endpoint(&parent_port->dev, cxlmd, dport);
+			if (rc)
+				return rc;
+		}
+	}
 
-		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
-		if (rc)
-			return rc;
+	if (rch) {
+		struct device *uport_dev = parent_port->uport_dev;
+
+		scoped_guard(device, uport_dev) {
+			if (!uport_dev->driver) {
+				dev_err(dev, "CXL port topology %s not enabled\n",
+					dev_name(uport_dev));
+				return -ENXIO;
+			}
+			/*
+			 * Re-fetch dport under uport_dev lock.  uport_dev->mutex
+			 * is held for the full devres teardown sequence including
+			 * free_dport()/kfree(), so this excludes concurrent
+			 * hotplug removal through the entire dereference.
+			 */
+			dport = cxl_find_dport_by_dev(parent_port, cxlmd->dev.parent->parent);
+			if (!dport) {
+				dev_err(dev, "CXL RCH dport not found\n");
+				return -ENXIO;
+			}
+			rc = devm_cxl_add_endpoint(uport_dev, cxlmd, dport);
+			if (rc)
+				return rc;
+		}
 	}
 
 	if (cxlmd->attach) {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bace662dc988..710a62a66429 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -708,10 +708,10 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
 {
 	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
 	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *root_dev;
 	struct cxl_dport *dport;
+	struct device *root_dev;
 	struct cxl_port *root __free(put_cxl_port) =
-		cxl_mem_find_port(cxlmd, &dport);
+		cxl_mem_find_port(cxlmd, NULL);
 
 	if (!root)
 		return -ENXIO;
@@ -720,13 +720,20 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
 	if (!root_dev)
 		return -ENXIO;
 
-	if (!dport->regs.rcd_pcie_cap)
-		return -ENXIO;
-
 	guard(device)(root_dev);
 	if (!root_dev->driver)
 		return -ENXIO;
 
+	/*
+	 * Fetch dport under uport_dev lock to protect against concurrent
+	 * hotplug removal. uport_dev->mutex is held for the entire devres
+	 * teardown sequence including free_dport(), so holding it here
+	 * excludes concurrent kfree(dport).
+	 */
+	dport = cxl_find_dport_by_dev(root, cxlmd->dev.parent->parent);
+	if (!dport || !dport->regs.rcd_pcie_cap)
+		return -ENXIO;
+
 	switch (width) {
 	case 2:
 		return sysfs_emit(buf, "%#x\n",
-- 
2.34.1

