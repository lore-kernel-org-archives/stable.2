Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCE957C737
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963042; cv=none; b=BWRqOlyIUtYrqQB+VCvw6RoP7cKLDhI4Tc8iISD2QOfSTer2OdDa/PZrzkwkmY8A3rvMY3wfnjbOdv+fKnVM/HhmY/jWGch8nfWzk7QhxsIBi8t4v8KEcTyIPVmVKAZMnXQPnZfC3Ujs/AJuVorsImAISXgov+Kk/Zp7YcjmweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963042; c=relaxed/simple;
	bh=lZ1M2HAfQm/f07CT9doeigF/2cP0RbWk0e8My51kV1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQrb4im1AZrtvbxe62op7lfHwSG+RV6yV6jYG6P9LaZPK9lMt5Bd8VMMqbGeWsEVhmHNaI4VXRwygEjcuxPsxSs+qAerwo3Ulu6YzWCNrP9UWFN13K+czbu1ASP+D0ubNAbIi9NLcrpDNLFepSdzWx3rN20y5tqcJYgXjgLqi0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJdBcBui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJdBcBui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00521F00A3A;
	Wed,  9 Sep 2026 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963040;
	bh=RVbwfWInXf/GF/NxzZAylWCEg82Dw6AGVdBwBjatFlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jJdBcBuiQLPwU2wrJv+uwv7KWu6B0N0FPpRXkbRdI7QqHsQpmG/x9Q1uL7n7XcBgg
	 JpW1Vf8f+S04fEflL6J1pjjQ50/Zg5AyTuTBpSfQv0B+9eA+7uYbn0WUez2hPk154F
	 y0yQYhLvz1K6PYmx14oGsujKqhlS7Xdahf2O+kTjbD+M5wipmYfn35jW5zaXROogR8
	 Kp5hIbcXVSiYhRTdo+mSh74Zz6zJraRfaqa9nsxeF5pVTdRvcF5YyqOpIdnxHBKWGc
	 +NH2QI9zgVaPPJEsV7qNUFQG+NJMaQVEiaS/z3iKHcw5MUMYAovbAz1afAa0Us348A
	 RlP93eQ+XxC6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Steve Wahl <steve.wahl@hpe.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] iommu/vt-d: Move trace/events/intel_iommu.h under iommu
Date: Wed,  9 Sep 2026 10:10:32 -0400
Message-ID: <20260909141035.2381120-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141035.2381120-1-sashal@kernel.org>
References: <2026090351-clapper-monorail-cc3a@gregkh>
 <20260909141035.2381120-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 933ab6d30153f937ffa9471ce64207e6d9acf56e ]

This header file is private to the Intel IOMMU driver. Move it to the
driver folder.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220514014322.2927339-2-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Stable-dep-of: 607432b2618b ("iommu/vt-d: Force requesting ACS when tboot is enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/dmar.c                                    | 2 +-
 drivers/iommu/intel/svm.c                                     | 2 +-
 drivers/iommu/intel/trace.c                                   | 2 +-
 .../trace/events/intel_iommu.h => drivers/iommu/intel/trace.h | 4 ++++
 4 files changed, 7 insertions(+), 3 deletions(-)
 rename include/trace/events/intel_iommu.h => drivers/iommu/intel/trace.h (94%)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index adea04ac0bd47..37fc660634081 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -29,11 +29,11 @@
 #include <linux/numa.h>
 #include <linux/limits.h>
 #include <asm/irq_remapping.h>
-#include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
 #include "iommu.h"
 #include "perf.h"
+#include "trace.h"
 
 typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
 struct dmar_res_callback {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index bf97e003af1d8..9f1c30f254858 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -21,11 +21,11 @@
 #include <linux/ioasid.h>
 #include <asm/page.h>
 #include <asm/fpu/api.h>
-#include <trace/events/intel_iommu.h>
 
 #include "pasid.h"
 #include "perf.h"
 #include "../iommu-sva-lib.h"
+#include "trace.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 static void intel_svm_drain_prq(struct device *dev, u32 pasid);
diff --git a/drivers/iommu/intel/trace.c b/drivers/iommu/intel/trace.c
index bfb6a6e37a88b..117e626e3ea98 100644
--- a/drivers/iommu/intel/trace.c
+++ b/drivers/iommu/intel/trace.c
@@ -11,4 +11,4 @@
 #include <linux/types.h>
 
 #define CREATE_TRACE_POINTS
-#include <trace/events/intel_iommu.h>
+#include "trace.h"
diff --git a/include/trace/events/intel_iommu.h b/drivers/iommu/intel/trace.h
similarity index 94%
rename from include/trace/events/intel_iommu.h
rename to drivers/iommu/intel/trace.h
index e5c1ca6d16eea..25cb7f88e1a2c 100644
--- a/include/trace/events/intel_iommu.h
+++ b/drivers/iommu/intel/trace.h
@@ -91,4 +91,8 @@ TRACE_EVENT(prq_report,
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH ../../drivers/iommu/intel/
+#define TRACE_INCLUDE_FILE trace
 #include <trace/define_trace.h>
-- 
2.53.0

