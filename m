Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E235C6AB
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883303; cv=none; b=uR3+wDTJTEPz69wdVYbijzqG6QxlIG+C7VosXo9UhZL+c1WEy+HS2psiXmkNoFfsuOhqE5vsilLhHIyVTcZQNJDfLchpqJPJJifs8N9QtXatHAvx39ZbhLAihV8KARCcRNwsW9+/Qoy8QBUOzijiE9AYGsgFGZj5uhzxSLM7QAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883303; c=relaxed/simple;
	bh=K8LcY6Icn6Ml3QE+bzp3vYwR6d3E2ijiDl3Qg5IW/jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgaphaZjW2MgzjJkiz+CQY5QoQ9PPdkUdRVh0F07BKHm4dDZ3DsJGn6IeH6RDn8CvluZdYHF3YUsi6Zz3NsKn3a5NfnkhQ9StSOEZ+zBi1RjprArlNHCDbueiGgAJpu51lO/PsQ++19WirZ4VaiOgMSJXsLd2OZXlMCW7Tz4hG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYvu0yzh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYvu0yzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDA41F00A3E;
	Tue,  8 Sep 2026 16:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883300;
	bh=ojASoIOnSr6cBQF1WINE7vqXatELSBt2jG+wvyCeTMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hYvu0yzhVCiQGjssH4l9psbBFNXvMCglku6NoIObwTcYlIbHBgeWDnUMCv09MPRdn
	 Zfx/109p6OnOBh2dGwqUwFf+R4CwgDOcqD6SMiQ/M85RZKEu98kFC5bHAdffz846Mh
	 hY8lUvSEKa8V2iKaI+rG9S2BCb/o3f1jrh4+A4V/PlcsKC1bmxE2NGLxopBbk+ZeJB
	 X8MVczJHPzqYhLlnvXhxeSExkQF5AXauwZrAKIerVkAFDZu8n8dLHVqCK9+edhBpM2
	 A22QhlcLGk21Yjk2HEUgFs7M/1ovgI/fsZpKV/zRAMRQOOjm0wPi6CGy5E1M4gqGBH
	 hkCr7yWgjO3Eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] cxl/region: Add helper to check Soft Reserved containment by CXL regions
Date: Tue,  8 Sep 2026 12:01:36 -0400
Message-ID: <20260908160137.2549229-2-sashal@kernel.org>
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

From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

[ Upstream commit 8e65f99b525b3f49b87db0db0d0e0fc1a0c53e40 ]

Add a helper to determine whether a given Soft Reserved memory range is
fully contained within the committed CXL region.

This helper provides a primitive for policy decisions in subsequent
patches such as co-ordination with dax_hmem to determine whether CXL has
fully claimed ownership of Soft Reserved memory ranges.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://patch.msgid.link/20260322195343.206900-8-Smita.KoralahalliChannabasappa@amd.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

[ sashal: Reduced backport -- upstream 8e65f99b525b3 touches 2 file(s), this
  backport carries 2. Not backported here:
  include/cxl/cxl.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 775d0f4558f4 ("cxl/mce: Make the MCE notifier per-region")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/region.c | 83 +++++++++++++++++++++++++++------------
 drivers/cxl/cxl.h         |  5 +++
 2 files changed, 63 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 41b64d871c5a1..7048bb8f84ded 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3751,6 +3751,61 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_region_debugfs_poison_clear, "%llx\n");
 
+static int cxl_region_setup_poison(struct cxl_region *cxlr)
+{
+	struct device *dev = &cxlr->dev;
+	struct cxl_region_params *p = &cxlr->params;
+	struct dentry *dentry;
+
+	/* Create poison attributes if all memdevs support the capabilities */
+	for (int i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
+		if (!cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_INJECT) ||
+		    !cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_CLEAR))
+			return 0;
+	}
+
+	dentry = cxl_debugfs_create_dir(dev_name(dev));
+	debugfs_create_file("inject_poison", 0200, dentry, cxlr,
+			    &cxl_poison_inject_fops);
+	debugfs_create_file("clear_poison", 0200, dentry, cxlr,
+			    &cxl_poison_clear_fops);
+
+	return devm_add_action_or_reset(dev, remove_debugfs, dentry);
+}
+
+static int region_contains_resource(struct device *dev, const void *data)
+{
+	const struct resource *res = data;
+	struct cxl_region *cxlr;
+	struct cxl_region_params *p;
+
+	if (!is_cxl_region(dev))
+		return 0;
+
+	cxlr = to_cxl_region(dev);
+	p = &cxlr->params;
+
+	if (p->state != CXL_CONFIG_COMMIT)
+		return 0;
+
+	if (!p->res)
+		return 0;
+
+	return resource_contains(p->res, res) ? 1 : 0;
+}
+
+bool cxl_region_contains_resource(const struct resource *res)
+{
+	guard(rwsem_read)(&cxl_rwsem.region);
+	struct device *dev __free(put_device) = bus_find_device(
+		&cxl_bus_type, NULL, res, region_contains_resource);
+	return !!dev;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_region_contains_resource, "dax_hmem");
+
 static int cxl_region_can_probe(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
@@ -3780,7 +3835,6 @@ static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	bool poison_supported = true;
 	int rc;
 
 	rc = cxl_region_can_probe(cxlr);
@@ -3804,30 +3858,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	/* Create poison attributes if all memdevs support the capabilities */
-	for (int i = 0; i < p->nr_targets; i++) {
-		struct cxl_endpoint_decoder *cxled = p->targets[i];
-		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-
-		if (!cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_INJECT) ||
-		    !cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_CLEAR)) {
-			poison_supported = false;
-			break;
-		}
-	}
-
-	if (poison_supported) {
-		struct dentry *dentry;
-
-		dentry = cxl_debugfs_create_dir(dev_name(dev));
-		debugfs_create_file("inject_poison", 0200, dentry, cxlr,
-				    &cxl_poison_inject_fops);
-		debugfs_create_file("clear_poison", 0200, dentry, cxlr,
-				    &cxl_poison_clear_fops);
-		rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
-		if (rc)
-			return rc;
-	}
+	rc = cxl_region_setup_poison(cxlr);
+	if (rc)
+		return rc;
 
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1f00a07f9c339..304df0dbdb621 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -887,6 +887,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
+bool cxl_region_contains_resource(const struct resource *res);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -909,6 +910,10 @@ static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
 {
 	return 0;
 }
+static inline bool cxl_region_contains_resource(const struct resource *res)
+{
+	return false;
+}
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
-- 
2.53.0

