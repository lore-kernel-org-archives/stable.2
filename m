Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67D390615;
	Tue, 13 Oct 2026 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921042; cv=none; b=fREzjomJtZL3ZfF3Sn/tC2WNCPMj78BfphxArPRH2LLJMtKzm1HM9quJK4T82rl8VoKj5yeACxXSS0BOo8tR9vu8cvRP6FPEAkmjl3OPkz9ka7y9YadZxM92rXonGK0IoE8CSRyKjwGjUE4KkoeutNQlOLYDLsfwgnJ8v6cafnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921042; c=relaxed/simple;
	bh=zfp3QTAVDB7Us/Tj3COiXiTe0bsauGFQmFOWT9PU0hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRInRXPvUbzOQGRwt54BxKAtf7ZvoWQPDFW9u67jodJQWhoGc9nH5igOZhtrINdlu3K8qrEEKI5/x65M3/6lZVz6cauVWHMuKFIEjCsfKSa5G6JDTavHQ/T9nRkBD6NDmO5tkjs1IXnqIFrInw4+Ka0qfdekhQ7rHhzOfTDDvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDs0LkBZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDs0LkBZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791921039; x=1823457039;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zfp3QTAVDB7Us/Tj3COiXiTe0bsauGFQmFOWT9PU0hA=;
  b=cDs0LkBZq+k06Lr3+lR20gYhJs4M77ixjEY6EnQIwezut8uAAg4jopSM
   HNUCeoyZ5dVEr8nYIh+uP2MxlRLBzey/kynYKQpumNqF5rYiV0gNhahiJ
   n0uX8NM5o/hIyJA5PVHLeMOuyhTluFEo58iSkW8vjibQLGsidIdl3xClN
   msGvtKz4n0t5AGPzuuoz/XU+QBTpFM8xoXI0S2upNIyz3srpZHqItyTxM
   XbqTZAiJ0b/3Ui7UACI+m6aYYjrJ1k62RoLfFCPT9kO8HYAuLp9o7K1aq
   /R2dM4mDPKhxM8cnvfuJpo2FGG66BilKoMIISiJ1QOHRThrlzuIPAWX4k
   w==;
X-CSE-ConnectionGUID: KreLLAqyTwyBRXqtrrMFHA==
X-CSE-MsgGUID: 1YBZlFODSsi2aIuRjDvYVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="668006"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="668006"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 12:50:39 -0700
X-CSE-ConnectionGUID: 8nzlnYWzTi6zDH6pY1AN/A==
X-CSE-MsgGUID: xUAcx0OIR2eYoWsPcNYmCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1608135"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 12:50:39 -0700
From: Zide Chen <zide.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	stable@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Add Granite Rapids CMS PMU support
Date: Tue, 13 Oct 2026 12:40:05 -0700
Message-ID: <20261013194005.96615-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the CMS (Common Mesh Stop) uncore PMON unit, shared by
GNR, SRF, GRR, and CWF. One CMS box exists per CHA box, at a fixed MSR
address: 0x3400 + 0x10 * unit_no + <reg offset>.

CMS is not enumerated in the discovery table, so it is added as an
extra MSR uncore type instead of going through the normal gnr_uncores[]
array. Since the CMS unit numbering matches the CHA unit numbering,
build the CMS box rb-tree by mirroring the discovered CHA (die, id)
pairs, ensuring CMS boxes only appear where a corresponding CHA exists.

Make generic_uncore_msr_ops global so the CMS type can reuse it.
Opportunistically add the intel_ prefix to match the naming convention.

Cc: stable@vger.kernel.org
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore_discovery.c |  4 +-
 arch/x86/events/intel/uncore_discovery.h |  1 +
 arch/x86/events/intel/uncore_snbep.c     | 81 +++++++++++++++++++++++-
 3 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 0a22edf4d509..170f299385a0 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -532,7 +532,7 @@ static void intel_generic_uncore_msr_disable_event(struct intel_uncore_box *box,
 	wrmsrq(hwc->config_base, 0);
 }
 
-static struct intel_uncore_ops generic_uncore_msr_ops = {
+struct intel_uncore_ops intel_generic_uncore_msr_ops = {
 	.init_box		= intel_generic_uncore_msr_init_box,
 	.disable_box		= intel_generic_uncore_msr_disable_box,
 	.enable_box		= intel_generic_uncore_msr_enable_box,
@@ -743,7 +743,7 @@ static bool uncore_update_uncore_type(enum uncore_access_type type_id,
 
 	switch (type_id) {
 	case UNCORE_ACCESS_MSR:
-		uncore->ops = &generic_uncore_msr_ops;
+		uncore->ops = &intel_generic_uncore_msr_ops;
 		break;
 	case UNCORE_ACCESS_PCI:
 		uncore->ops = &generic_uncore_pci_ops;
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 142e1b56cfc2..cececf6ecdc5 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -151,6 +151,7 @@ void intel_uncore_generic_uncore_mmio_init(void);
 int intel_generic_uncore_msr_init_box(struct intel_uncore_box *box);
 void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box);
 void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box);
+extern struct intel_uncore_ops intel_generic_uncore_msr_ops;
 
 int intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box);
 void intel_generic_uncore_mmio_disable_box(struct intel_uncore_box *box);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index a97cd029db36..3abbc1bbf577 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6492,6 +6492,32 @@ int gnr_uncore_units_ignore[] = {
 	UNCORE_IGNORE_END
 };
 
+/*
+ * One CMS box exists per CHA box, at a fixed MSR address:
+ * 0x3400 + 0x10 * unit_no + <reg offset>.
+ */
+#define GNR_CMS_MSR_PMON_BOX_CTL	0x3400
+#define GNR_CMS_MSR_PMON_CTL0		0x02
+#define GNR_CMS_MSR_PMON_CTR0		0x08
+#define GNR_CMS_MSR_OFFSET		0x10
+/* Type ID for CMS */
+#define UNCORE_GNR_CMS			50
+
+static struct intel_uncore_type gnr_uncore_cms = {
+	/* Keep the PMU name aligned with the published CHACMS event list. */
+	.name			= "chacms",
+	.type_id		= UNCORE_GNR_CMS,
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.num_counters		= 4,
+	.perf_ctr_bits		= 48,
+	.event_ctl		= GNR_CMS_MSR_PMON_CTL0,
+	.perf_ctr		= GNR_CMS_MSR_PMON_CTR0,
+	.ops			= &intel_generic_uncore_msr_ops,
+	.format_group		= &snbep_uncore_format_group,
+	.attr_update		= uncore_alias_groups,
+	.cleanup_extra_boxes	= spr_extra_boxes_cleanup,
+};
+
 static struct intel_uncore_type gnr_uncore_ubox = {
 	.name			= "ubox",
 	.attr_update		= uncore_alias_groups,
@@ -6595,15 +6621,66 @@ static struct freerunning_counters gnr_iio_freerunning[] = {
 	[SPR_IIO_MSR_BW_OUT]	= { 0x2e0e, 0x10, 0x80, 8, 48 },
 };
 
+/*
+ * Neither the free-running IIO counters nor CMS are covered by the
+ * discovery table, so both are added as "extra" MSR uncore types, in
+ * addition to the ones enumerated in gnr_uncores[].
+ */
+#define UNCORE_GNR_MSR_EXTRA_UNCORES	2
+
+static struct intel_uncore_type *gnr_msr_uncores[UNCORE_GNR_MSR_EXTRA_UNCORES] = {
+	&spr_uncore_iio_free_running,
+	&gnr_uncore_cms,
+};
+
+/* Build the CMS boxes rb-tree by mirroring CHA's discovered boxes. */
+static void gnr_uncore_cms_init_boxes(struct intel_uncore_type **uncores)
+{
+	struct intel_uncore_discovery_unit *cha_unit, *cms_unit;
+	struct intel_uncore_type *cha;
+	struct rb_root *root;
+	struct rb_node *node;
+	u16 num_units = 0;
+
+	cha = uncore_find_type_by_id(uncores, UNCORE_SPR_CHA);
+	if (!cha || !cha->boxes)
+		return;
+
+	root = kzalloc_obj(*root);
+	if (!root)
+		return;
+	*root = RB_ROOT;
+
+	for (node = rb_first(cha->boxes); node; node = rb_next(node)) {
+		cha_unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
+
+		cms_unit = kzalloc_obj(*cms_unit);
+		if (!cms_unit)
+			break;
+
+		cms_unit->id   = cha_unit->id;
+		cms_unit->die  = cha_unit->die;
+		cms_unit->addr = GNR_CMS_MSR_PMON_BOX_CTL +
+				 cha_unit->id * GNR_CMS_MSR_OFFSET;
+
+		uncore_find_add_unit(cms_unit, root, &num_units);
+	}
+
+	gnr_uncore_cms.boxes = root;
+	gnr_uncore_cms.num_boxes = num_units;
+}
+
 void gnr_uncore_cpu_init(void)
 {
 	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
-						UNCORE_SPR_MSR_EXTRA_UNCORES,
-						spr_msr_uncores,
+						UNCORE_GNR_MSR_EXTRA_UNCORES,
+						gnr_msr_uncores,
 						UNCORE_GNR_NUM_UNCORE_TYPES,
 						gnr_uncores);
 	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
 	spr_uncore_iio_free_running.freerunning = gnr_iio_freerunning;
+
+	gnr_uncore_cms_init_boxes(uncore_msr_uncores);
 }
 
 int gnr_uncore_pci_init(void)
-- 
2.55.0

