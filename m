Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16E4B5146
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444932; cv=none; b=rqgqyRhMBfjTxehe9Z4S9xOm/Wg8Rukj3Q8G0Gwb9z7ZC0AI/WqeeTj7Qdr1V0ez6syZg/m+gIBGX3LJ8EVgLLruzPuIoZm90Zt1sO6zgh/3dZoBu7PvBBKmXaTlQKahV49Y75hC3SM350y2koq9F1TmYZ95P2XEA6yH2uFh9H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444932; c=relaxed/simple;
	bh=8JC0lTLa/DPFYYQaHeK2FI/KHNgMDxtkBmgX74gfT2w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MDopko+g+yl0zsmigQ/H3MZ7mTS3yqm6NzbNbtIR7MA+3WkONoARyjSwWFyw4Vl+uJG+bUGBlgWDuzK7Goo0ef2KXQQPiqBHXRXhyVhS1FOSD4xvgBvqU3cGRa+w5IzEzW5vP9O2/M+JU8/nVCHM+i1wRe4l9LvJlzlTNqpDE/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uRsGBETj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uRsGBETj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC261F00A3D;
	Thu,  3 Sep 2026 14:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444915;
	bh=4iRP2jQeXGmazAQgW+fIDKH+COJozr5AraPuUZ67RPs=;
	h=Subject:To:Cc:From:Date;
	b=uRsGBETjj+Iyl0lIGPAskv8AIGWHEUErVjgHRbQUwo+bSeOB33Nv7QSysaS9kNuOZ
	 QIaObfZ6eUHhYuQXK8V+DpiD96OEbsQpkZlwXiED6L3gRkRX4VgSwXW+A2x16wDk+3
	 HJOsSKHBaNL9JoMQ4te9DbwKkt8vJmwLtf3NT558=
Subject: FAILED: patch "[PATCH] cxl/mce: Make the MCE notifier per-region" failed to apply to 6.18-stable tree
To: dave.jiang@intel.com,alison.schofield@intel.com,benjamin.cheatham@amd.com,djbw@kernel.org,flavien@nus.edu.sg
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:53:59 +0200
Message-ID: <2026090359-scale-swell-330d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 775d0f4558f4cec0ee0c8966595d1add1791f36e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090359-scale-swell-330d@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 775d0f4558f4cec0ee0c8966595d1add1791f36e Mon Sep 17 00:00:00 2001
From: Dave Jiang <dave.jiang@intel.com>
Date: Tue, 16 Jun 2026 15:49:11 -0700
Subject: [PATCH] cxl/mce: Make the MCE notifier per-region

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

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d9cb02c9f72c..94b1f7167588 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -11,7 +11,6 @@
 
 #include "core.h"
 #include "trace.h"
-#include "mce.h"
 
 static bool cxl_raw_allow_all;
 
@@ -1522,7 +1521,6 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 						 u16 dvsec)
 {
 	struct cxl_memdev_state *mds;
-	int rc;
 
 	mds = devm_cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial,
 					dvsec, struct cxl_memdev_state, cxlds,
@@ -1534,12 +1532,6 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 
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
index 1e211542b6b6..578622240401 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -15,6 +15,7 @@
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
+#include "mce.h"
 
 /**
  * DOC: cxl core region
@@ -3859,34 +3860,6 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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
@@ -4217,6 +4190,20 @@ static int cxl_region_probe(struct device *dev)
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
index c0e5308e4d1b..bdd0132c999d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -478,6 +478,7 @@ struct cxl_region_params {
  * @coord: QoS access coordinates for the region
  * @node_notifier: notifier for setting the access coordinates to node
  * @adist_notifier: notifier for calculating the abstract distance of node
+ * @mce_notifier: notifier for MCE
  */
 struct cxl_region {
 	struct device dev;
@@ -493,6 +494,7 @@ struct cxl_region {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct notifier_block node_notifier;
 	struct notifier_block adist_notifier;
+	struct notifier_block mce_notifier;
 };
 
 struct cxl_nvdimm_bridge {
@@ -870,7 +872,6 @@ bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
-u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 bool cxl_region_contains_resource(const struct resource *res);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
@@ -889,11 +890,6 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
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
index 503ae2864591..c401e3a1af06 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -431,7 +431,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @poison: poison driver state info
  * @security: security driver state info
  * @fw: firmware upload / activation state
- * @mce_notifier: MCE notifier
  *
  * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -451,7 +450,6 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
-	struct notifier_block mce_notifier;
 };
 
 static inline struct cxl_memdev_state *

