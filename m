Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636E93630BA
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883304; cv=none; b=KHSuMfsB2Kx9ElXIbqDb48o8WtCp3cusj2CsSiFF5mbNgH8qt/+1QIcqqjRByvjgLbs/FInOHAvQnMp3QtQ8VkoqywJOUxW72aW8b6as6Pz5dUd+fnDF/HgkSs4rP7GC7s6CSNDIMHYLzkdWzeOtROPVIsx8WBXJYlwf7KzXBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883304; c=relaxed/simple;
	bh=bQeX90srQHBjSOweNwgGv37npsdbI+We4Br2efDV+ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eeypn7CM97XXtU2a2FDvMSIHAa/1+nvqCPA3jVFDlDrWfc9PoPIrMolNmRg7bqQQZZmbFWwY5cRUmRxpCrHDYgbOke9XbqjXb2dP7KoE8GS1jfhxCmoB8iADLuWRSUvs78ldsGAi1s1ZLldvoMydB11Cm54pj0LQlkAMdnoxnjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba6WLqJ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba6WLqJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FD81F00A3F;
	Tue,  8 Sep 2026 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883301;
	bh=KKV+jsMlsnKEh87yHr7mS4fLjqoyW06pVIIrg5ZkaUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ba6WLqJ3FyG9a8bdHvEB7UK3wa8i1GJtAmdnU7Bz0ZZkrL4zTWYT6xjhUeYHzQVdR
	 LDzOomqysBeovgXE2rogq050paemTM1OGyzxvV7u9xkSeOOob5C0/txskTQ2rAqoyC
	 YHtZ12hABo6qgMnn3Fh/dkYT9qS9MT1m02IH2bTbQjioTu+QKdV9jjZswNjc5oUwPr
	 52AhocjvTKF0NQEzlrNKzdEP2BN509mhI6Hz5d3MsOe0NWQYA8Xtq2KOiR9SqJwjEy
	 PoBAR3BY2Uyonn1UO0vqwkHIykcUFww9mWoCj9PgDiNMpVxXZcRoYU99v5ryT48s5W
	 5tpYNWA1/b/rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Flavien Solt <flavien@nus.edu.sg>,
	Dan Williams <djbw@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] cxl/mce: Make the MCE notifier per-region
Date: Tue,  8 Sep 2026 12:01:37 -0400
Message-ID: <20260908160137.2549229-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908160137.2549229-1-sashal@kernel.org>
References: <2026090359-scale-swell-330d@gregkh>
 <20260908160137.2549229-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit 775d0f4558f4cec0ee0c8966595d1add1791f36e ]

Flavien Solt reported lifetime issues with the CXL MCE notifier, which
can lead to NULL dereferences and use-after-free in the MCE handler.
The notifier was registered per memory device and stored in 'struct
cxl_memdev_state', even though it only needs the region state (the
region's SPA range and its extended linear cache size).

Instead of keeping the memory device and endpoint alive, the correct fix
is to move the notifier into 'struct cxl_region' and register it from
cxl_region_probe() as it should be a per-region notifier. Setup the
registration to only happen for regions that have an extended linear
cache as that is the only current usage.

Remove cxl_port_get_spa_cache_alias() as it is now dead code.

[ dj: Update dev_warn() when notifier fails due to kconfig. (Ben) ]

Reported-by: Flavien Solt <flavien@nus.edu.sg>
Suggested-by: Dan Williams <djbw@kernel.org>
Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Link: https://patch.msgid.link/20260616224912.2567474-1-dave.jiang@intel.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/mbox.c   |  8 --------
 drivers/cxl/core/mce.c    | 27 ++++++++++++------------
 drivers/cxl/core/region.c | 43 ++++++++++++++-------------------------
 drivers/cxl/cxl.h         |  8 ++------
 drivers/cxl/cxlmem.h      |  2 --
 5 files changed, 30 insertions(+), 58 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e7a6452bf5445..daee364619f92 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -11,7 +11,6 @@
 
 #include "core.h"
 #include "trace.h"
-#include "mce.h"
 
 static bool cxl_raw_allow_all;
 
@@ -1524,7 +1523,6 @@ EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 {
 	struct cxl_memdev_state *mds;
-	int rc;
 
 	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
 	if (!mds) {
@@ -1539,12 +1537,6 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 
-	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
-	if (rc == -EOPNOTSUPP)
-		dev_warn(dev, "CXL MCE unsupported\n");
-	else if (rc)
-		return ERR_PTR(rc);
-
 	return mds;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
index ff8d078c6ca1e..65fed913b2217 100644
--- a/drivers/cxl/core/mce.c
+++ b/drivers/cxl/core/mce.c
@@ -4,16 +4,16 @@
 #include <linux/notifier.h>
 #include <linux/set_memory.h>
 #include <asm/mce.h>
-#include <cxlmem.h>
+#include <cxl.h>
+#include "core.h"
 #include "mce.h"
 
 static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 			  void *data)
 {
-	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
-						    mce_notifier);
-	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
-	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
+					       mce_notifier);
+	struct cxl_region_params *p = &cxlr->params;
 	struct mce *mce = data;
 	u64 spa, spa_alias;
 	unsigned long pfn;
@@ -21,26 +21,25 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 	if (!mce || !mce_usable_address(mce))
 		return NOTIFY_DONE;
 
-	if (!endpoint)
-		return NOTIFY_DONE;
-
 	spa = mce->addr & MCI_ADDR_PHYSADDR;
 
-	pfn = spa >> PAGE_SHIFT;
-	if (!pfn_valid(pfn))
+	if (!cxl_resource_contains_addr(p->res, spa))
 		return NOTIFY_DONE;
 
-	spa_alias = cxl_port_get_spa_cache_alias(endpoint, spa);
-	if (spa_alias == ~0ULL)
-		return NOTIFY_DONE;
+	if (spa >= p->res->start + p->cache_size)
+		spa_alias = spa - p->cache_size;
+	else
+		spa_alias = spa + p->cache_size;
 
 	pfn = spa_alias >> PAGE_SHIFT;
+	if (!pfn_valid(pfn))
+		return NOTIFY_DONE;
 
 	/*
 	 * Take down the aliased memory page. The original memory page flagged
 	 * by the MCE will be taken cared of by the standard MCE handler.
 	 */
-	dev_emerg(mds->cxlds.dev, "Offlining aliased SPA address0: %#llx\n",
+	dev_emerg(&cxlr->dev, "Offlining aliased SPA address0: %#llx\n",
 		  spa_alias);
 	if (!memory_failure(pfn, 0))
 		set_mce_nospec(pfn);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7048bb8f84ded..a1141471b4586 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -15,6 +15,7 @@
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
+#include "mce.h"
 
 /**
  * DOC: cxl core region
@@ -3605,34 +3606,6 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
 
-u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
-{
-	struct cxl_region_ref *iter;
-	unsigned long index;
-
-	if (!endpoint)
-		return ~0ULL;
-
-	guard(rwsem_write)(&cxl_rwsem.region);
-
-	xa_for_each(&endpoint->regions, index, iter) {
-		struct cxl_region_params *p = &iter->region->params;
-
-		if (cxl_resource_contains_addr(p->res, spa)) {
-			if (!p->cache_size)
-				return ~0ULL;
-
-			if (spa >= p->res->start + p->cache_size)
-				return spa - p->cache_size;
-
-			return spa + p->cache_size;
-		}
-	}
-
-	return ~0ULL;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_port_get_spa_cache_alias, "CXL");
-
 static int is_system_ram(struct resource *res, void *arg)
 {
 	struct cxl_region *cxlr = arg;
@@ -3858,6 +3831,20 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	/*
+	 * Regions fronted by an extended linear cache need the MCE notifier to
+	 * offline the aliased page on a memory error.
+	 */
+	if (p->cache_size) {
+		rc = devm_cxl_register_mce_notifier(&cxlr->dev,
+						    &cxlr->mce_notifier);
+		if (rc == -EOPNOTSUPP)
+			dev_warn(&cxlr->dev,
+				 "CONFIG_CXL_MCE disabled, MCE notifier not registered\n");
+		else if (rc)
+			return rc;
+	}
+
 	rc = cxl_region_setup_poison(cxlr);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 304df0dbdb621..091c52111d949 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -540,6 +540,7 @@ enum cxl_partition_mode {
  * @coord: QoS access coordinates for the region
  * @node_notifier: notifier for setting the access coordinates to node
  * @adist_notifier: notifier for calculating the abstract distance of node
+ * @mce_notifier: notifier for MCE
  */
 struct cxl_region {
 	struct device dev;
@@ -553,6 +554,7 @@ struct cxl_region {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct notifier_block node_notifier;
 	struct notifier_block adist_notifier;
+	struct notifier_block mce_notifier;
 };
 
 struct cxl_nvdimm_bridge {
@@ -886,7 +888,6 @@ bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
-u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 bool cxl_region_contains_resource(const struct resource *res);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
@@ -905,11 +906,6 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 {
 	return NULL;
 }
-static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
-					       u64 spa)
-{
-	return 0;
-}
 static inline bool cxl_region_contains_resource(const struct resource *res)
 {
 	return false;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c12ab4fc95123..f7e3a33991b8d 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -484,7 +484,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @poison: poison driver state info
  * @security: security driver state info
  * @fw: firmware upload / activation state
- * @mce_notifier: MCE notifier
  *
  * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -504,7 +503,6 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
-	struct notifier_block mce_notifier;
 };
 
 static inline struct cxl_memdev_state *
-- 
2.53.0

