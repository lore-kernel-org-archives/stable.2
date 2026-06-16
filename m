Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8FA3A7F4B;
	Tue, 16 Jun 2026 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781650163; cv=none; b=NNjDWzLHtZe5R5IPglfaqmf9i9H69ljYIhrge32k2RcDDprlf71OIv7R0+OnKuo3NhHaxk2ATTwexvlvfBXqPCvL39fFoOZ65hjDCUMfe1NjYUbb2XPdYZ4FDyKTBbcZXJ6a3dJ19zta/7NrIsVKhpqA1NMcwb/E9baBhD0y0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781650163; c=relaxed/simple;
	bh=S20bU4hvD9Ax2g2IvNsmFgYXfPaY8NC2eZ2HPKYA06U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nfn1Ba61s2UJuAAkm7fH79hp+8ElohW5xuA9rscktQO/+ZA9xe1i3VzrOlUy6d1joCM0ql6cdhQr1vyzPAXN56R1XksqGWtSs33v/79kw8PyY1uJ/lyYRk+tLTXxYO1UeyQc9hnPzzMq9hl5KnoUluU9c8s2Srna6202KdPCWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49E61F000E9;
	Tue, 16 Jun 2026 22:49:20 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	flavien@nus.edu.sg,
	stable@vger.kernel.org
Subject: [PATCH v2] cxl/mce: Make the MCE notifier per-region
Date: Tue, 16 Jun 2026 15:49:11 -0700
Message-ID: <20260616224912.2567474-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Reported-by: Flavien Solt <flavien@nus.edu.sg>
Suggested-by: Dan Williams <djbw@kernel.org>
Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- First version for this code, but replaces the previous 2 patches
  as the fix. Replaces the series "cxl: Fix ednpoint access issues with
  CXL MCE notifier handler". (Dan)
---
 drivers/cxl/core/mbox.c   |  8 --------
 drivers/cxl/core/mce.c    | 27 ++++++++++++-------------
 drivers/cxl/core/region.c | 42 +++++++++++++--------------------------
 drivers/cxl/cxl.h         |  8 ++------
 drivers/cxl/cxlmem.h      |  2 --
 5 files changed, 29 insertions(+), 58 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7c6c5b7450a5..1fa1f78565e3 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -11,7 +11,6 @@
 
 #include "core.h"
 #include "trace.h"
-#include "mce.h"
 
 static bool cxl_raw_allow_all;
 
@@ -1526,7 +1525,6 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 						 u16 dvsec)
 {
 	struct cxl_memdev_state *mds;
-	int rc;
 
 	mds = devm_cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial,
 					dvsec, struct cxl_memdev_state, cxlds,
@@ -1538,12 +1536,6 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 
 	mutex_init(&mds->event.log_lock);
 
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
index ff8d078c6ca1..65fed913b221 100644
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
index e50dc716d4e8..79b497284a3f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -15,6 +15,7 @@
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
+#include "mce.h"
 
 /**
  * DOC: cxl core region
@@ -3809,34 +3810,6 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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
@@ -4070,6 +4043,19 @@ static int cxl_region_probe(struct device *dev)
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
+			dev_warn(&cxlr->dev, "CXL MCE unsupported\n");
+		else if (rc)
+			return rc;
+	}
+
 	rc = cxl_region_setup_poison(cxlr);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1297594beaec..a4c44b0cb3ae 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -462,6 +462,7 @@ struct cxl_region_params {
  * @coord: QoS access coordinates for the region
  * @node_notifier: notifier for setting the access coordinates to node
  * @adist_notifier: notifier for calculating the abstract distance of node
+ * @mce_notifier: notifier for MCE
  */
 struct cxl_region {
 	struct device dev;
@@ -477,6 +478,7 @@ struct cxl_region {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct notifier_block node_notifier;
 	struct notifier_block adist_notifier;
+	struct notifier_block mce_notifier;
 };
 
 struct cxl_nvdimm_bridge {
@@ -854,7 +856,6 @@ bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
-u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 bool cxl_region_contains_resource(const struct resource *res);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
@@ -873,11 +874,6 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
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
index 776c50d1db51..a5c1820beb48 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -409,7 +409,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @poison: poison driver state info
  * @security: security driver state info
  * @fw: firmware upload / activation state
- * @mce_notifier: MCE notifier
  *
  * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -429,7 +428,6 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
-	struct notifier_block mce_notifier;
 };
 
 static inline struct cxl_memdev_state *

base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.54.0

