Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82135C695
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883301; cv=none; b=lStg88kB4DEzg83OIQ5IXFZ44rnO4bUwrHBaIYDst0QhVUWRVBX6ZuqAlwO7mtJCeCt5esmXxN4WNYY/Hjf0ZqRp1kf9N6hBhF07LCGGUWL+E02D8e0x3ZuT7NieIaxCSQlwO4vU/fbXA81meTlcKvFfOZRx4+/LhRKqMOAJtAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883301; c=relaxed/simple;
	bh=d9W5L4RIzBfVbpORFZdV6C/IBlObrldyKI+7kp9ipic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhUe2WI3gSBm1ROwOYGM0O++61Z+OVXULGv0TADDkydwi3JxBYIRoESQyOcmst5kwEF9Eh0jVTT82S4zkCC38n8OGf1mrdIzfJgUv0mr/RjfWxXTJh0sCPo1fm6nRc5JL794noY1ve7sRQECwrrGE2Ecqcv8nENRRf/ebbWcQOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBTnzjk5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBTnzjk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396861F00A3A;
	Tue,  8 Sep 2026 16:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883300;
	bh=7Elw6b0plunHSKmEDtj7Bz5RqzByzTQrJjZ5eOOf/TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VBTnzjk5WcoKTrT4SCme30mI1uESt3pVHDyIEmF3/KTiBhmUBi2DikDgMbHnsdewH
	 lYBWhZTNWpR+zkbldXL1/C0Fo4WaIU95GBY6APRTrQDvmUh/vgHBjpcrDYmnR/8w39
	 Nh1pBbLBfWQPxYZSx4Busl07aZV5SpTJWYsEC4KHCUshlsAnCz4oYrdBq0dQKY6gey
	 jqVpS+zcTtO9TQvVCiRvzK/YrfPavktCc9cBr8wP2ySoIBPOKCTFT6oyehmrI7N56p
	 iWlOk2dyl9mcSqC4en1RLIDakm50tC78DYJuJMxlT3ajqbDH4XckAV+Ynk6h+vQrUg
	 BGZn30N6laU2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Tomasz Wolski <tomasz.wolski@fujitsu.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] dax/cxl, hmem: Initialize hmem early and defer dax_cxl binding
Date: Tue,  8 Sep 2026 12:01:35 -0400
Message-ID: <20260908160137.2549229-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090359-scale-swell-330d@gregkh>
References: <2026090359-scale-swell-330d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit 39aa1d4be12bf9f685adaa06aa2d997c1c611b16 ]

Move hmem/ earlier in the dax Makefile so that hmem_init() runs before
dax_cxl.

In addition, defer registration of the dax_cxl driver to a workqueue
instead of using module_cxl_driver(). This ensures that dax_hmem has
an opportunity to initialize and register its deferred callback and make
ownership decisions before dax_cxl begins probing and claiming Soft
Reserved ranges.

Mark the dax_cxl driver as PROBE_PREFER_ASYNCHRONOUS so its probe runs
out of line from other synchronous probing avoiding ordering
dependencies while coordinating ownership decisions with dax_hmem.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Tomasz Wolski <tomasz.wolski@fujitsu.com>
Link: https://patch.msgid.link/20260322195343.206900-6-Smita.KoralahalliChannabasappa@amd.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Stable-dep-of: 775d0f4558f4 ("cxl/mce: Make the MCE notifier per-region")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dax/Makefile |  3 +--
 drivers/dax/cxl.c    | 27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
index 5ed5c39857c8b..70e996bf15261 100644
--- a/drivers/dax/Makefile
+++ b/drivers/dax/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-y += hmem/
 obj-$(CONFIG_DAX) += dax.o
 obj-$(CONFIG_DEV_DAX) += device_dax.o
 obj-$(CONFIG_DEV_DAX_KMEM) += kmem.o
@@ -10,5 +11,3 @@ dax-y += bus.o
 device_dax-y := device.o
 dax_pmem-y := pmem.o
 dax_cxl-y := cxl.o
-
-obj-y += hmem/
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7a..a2136adfa186e 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -38,10 +38,35 @@ static struct cxl_driver cxl_dax_region_driver = {
 	.id = CXL_DEVICE_DAX_REGION,
 	.drv = {
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-module_cxl_driver(cxl_dax_region_driver);
+static void cxl_dax_region_driver_register(struct work_struct *work)
+{
+	cxl_driver_register(&cxl_dax_region_driver);
+}
+
+static DECLARE_WORK(cxl_dax_region_driver_work, cxl_dax_region_driver_register);
+
+static int __init cxl_dax_region_init(void)
+{
+	/*
+	 * Need to resolve a race with dax_hmem wanting to drive regions
+	 * instead of CXL
+	 */
+	queue_work(system_long_wq, &cxl_dax_region_driver_work);
+	return 0;
+}
+module_init(cxl_dax_region_init);
+
+static void __exit cxl_dax_region_exit(void)
+{
+	flush_work(&cxl_dax_region_driver_work);
+	cxl_driver_unregister(&cxl_dax_region_driver);
+}
+module_exit(cxl_dax_region_exit);
+
 MODULE_ALIAS_CXL(CXL_DEVICE_DAX_REGION);
 MODULE_DESCRIPTION("CXL DAX: direct access to CXL regions");
 MODULE_LICENSE("GPL");
-- 
2.53.0

