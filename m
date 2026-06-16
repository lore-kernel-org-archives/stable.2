Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC131DF254;
	Tue, 16 Jun 2026 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570414; cv=none; b=Y+l/E3eIqcDuK/muN5ZvG2GKxp9NdQnnVZVuI1n3N/6fRHxTxIYcOI+JD7tTw2jNy/lE8CgheHjKfcGUmyQ1IHeQyXOk2Cqt/Ox10XOqBOwNS2o39Ewi/OiGqTIxcyvKCs/SrbQOJ5BI3Ox/EguFFSzA0ZtvVq45kehxQ6pY0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570414; c=relaxed/simple;
	bh=y64Hdsminmjx9W7ytFK33QvspXrgwqvY1MAxeWoKCYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8mgYFpbktLHEwgxnQL2sY+4VPJN9BtB8r5VAX7RV4CmiAtaZyCcAVNTWSyCM2Qg24OFO6Y0i+AlUyE9Hal9Ppgb5NEhG70IrMJX1SCRAqGXlryKLuX5eyW0NElNeKPyJUIWTkNvTBJyA1nVkeTm7rXa9GPJEgL5LyBaoG7dFm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46CE1F000E9;
	Tue, 16 Jun 2026 00:40:12 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	flavien@nus.edu.sg,
	stable@vger.kernel.org
Subject: [PATCH 2/2] cxl/mce: Serialize the MCE handler against endpoint teardown
Date: Mon, 15 Jun 2026 17:40:07 -0700
Message-ID: <20260616004007.4186004-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616004007.4186004-1-dave.jiang@intel.com>
References: <20260616004007.4186004-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL endpoint has a shorter lifetime than CXL memdev state (mds) and
the MCE notifier is part of the mds. The MCE handler needs to take
a reference on the endpoint in order to keep it alive while operating
on it. Take the cxlmd lock to verify the endpoint is still valid and
take a reference on it before accessing it.

Reported-by: Flavien Solt <flavien@nus.edu.sg>
Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mce.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
index 47566015eb00..e684e411921b 100644
--- a/drivers/cxl/core/mce.c
+++ b/drivers/cxl/core/mce.c
@@ -7,13 +7,27 @@
 #include <cxlmem.h>
 #include "mce.h"
 
+static struct device *cxlmd_get_endpoint_dev(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint;
+
+	if (!cxlmd)
+		return NULL;
+
+	guard(device)(&cxlmd->dev);
+	endpoint = cxlmd->endpoint;
+	if (IS_ERR_OR_NULL(endpoint))
+		return NULL;
+
+	return get_device(&endpoint->dev);
+}
+
 static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 			  void *data)
 {
 	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
 						    mce_notifier);
 	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
-	struct cxl_port *endpoint;
 	struct mce *mce = data;
 	u64 spa, spa_alias;
 	unsigned long pfn;
@@ -24,8 +38,13 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 	if (!cxlmd)
 		return NOTIFY_DONE;
 
-	endpoint = cxlmd->endpoint;
-	if (IS_ERR_OR_NULL(endpoint))
+	/*
+	 * With the cxlmd device lock held, check the cxlmd->endpoint pointer
+	 * and then take a reference of the device in order to keep it alive
+	 * while accessing it.
+	 */
+	struct device *dev __free(put_device) = cxlmd_get_endpoint_dev(cxlmd);
+	if (!dev)
 		return NOTIFY_DONE;
 
 	spa = mce->addr & MCI_ADDR_PHYSADDR;
@@ -34,7 +53,7 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 	if (!pfn_valid(pfn))
 		return NOTIFY_DONE;
 
-	spa_alias = cxl_port_get_spa_cache_alias(endpoint, spa);
+	spa_alias = cxl_port_get_spa_cache_alias(to_cxl_port(dev), spa);
 	if (spa_alias == ~0ULL)
 		return NOTIFY_DONE;
 
-- 
2.54.0

