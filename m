Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B633AEF22;
	Tue, 28 Jul 2026 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237137; cv=none; b=cib0IeTRcngXT/JNOTrUdHJWTQ1V4qg7bewxGm+NECG50RQ/4h4MbVKdrK6CATS+KcVnteh6KNo8VvN77XVwPyoLON6sxwYKPQu7fr7RR6RnDTITuLPdX8AwnplHdpm5U6/9mLs150Bgzxbg2enSD38DUpe3EVB38Fj7zBIyKBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237137; c=relaxed/simple;
	bh=4/iuaphxtLtk6W3Cixj6Wqje3ZyUlzHGiiL5n+pg2JI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bgfFtrKqB8Ypm+L8stNppwP+4UZ0SWahUeXMmfctcfpQNJbw/FU5CiVHUm2PukZJjSiOgCwJ8wFMXA93YIlrHvOmVMhzO2cqx2JYP0darqmSWEtV0KVraxUs/OM3+HCjMmdtG9hc2PHjShJtcWYB9g0abILo4cprj95dZO6zvLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oc0/CEoc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oc0/CEoc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785237134; x=1816773134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4/iuaphxtLtk6W3Cixj6Wqje3ZyUlzHGiiL5n+pg2JI=;
  b=Oc0/CEociKjQPMDlxrYz6ZcfnL6X1OAOg85e9i6GY1i7oHU76AS6OwON
   cPKpOfXJ5VgNRGZLzQL3vJNonMdY8+MNXAxXBxXPT0zgWhS+Z5pJu/PoY
   H2s/I0aQFRk1oticX9jNO4fIaf+bCvaiVhZa8VM+TDsNxyTnVCIutIo8U
   pSst+az+xeKRfF1i1N0PArMG0lCMOfHRZK1T7gDobTA0kBzEDyMyhtE0p
   TzjApkd5LVuaIBOfDSk1Nl7KhXu0sd9gpylldFodPGy/CBy7As3xC4e/G
   QJcLnclazR2/W5lQ9W97eM/Vc4lBtIgNsNCbQ+lbt4kbNZu90vF43b/rz
   w==;
X-CSE-ConnectionGUID: I4WFoSXaQKqIrdDGzsdPqw==
X-CSE-MsgGUID: BDVPPF3kQkGN0prGf4+9bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="96972504"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="96972504"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 04:12:13 -0700
X-CSE-ConnectionGUID: Ppo8S1cIQ++1lpuy/eKbMw==
X-CSE-MsgGUID: MP9hGryVQCSRsfB7sXqnjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="261648879"
Received: from gklab-003-005.igk.intel.com ([10.91.173.16])
  by fmviesa004.fm.intel.com with ESMTP; 28 Jul 2026 04:12:10 -0700
From: Konstantin Ilichev <konstantin.ilichev@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.korba@intel.com,
	aleksandr.loktionov@intel.com,
	stable@vger.kernel.org,
	samuel.salin@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Konstantin Ilichev <konstantin.ilichev@intel.com>
Subject: [PATCH iwl-next] idpf: add Packet Builder (PKB) timestamping
Date: Tue, 28 Jul 2026 13:11:57 +0200
Message-ID: <20260728111157.1793073-1-konstantin.ilichev@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milena Olech <milena.olech@intel.com>

PKB timestamping is generated for each packet on the transmit queue, and
the PKB timestamp value can be read directly from the completion
descriptor. There is no need to enable PKB-based timestamping on the
Data Plane side. The only condition that needs to be fulfilled is to have
VIRTCHNL2_CAP_TX_CMPL_TSTMP capability negotiated with Control Plane.

PKB timestamps are less precise than the PHY timestamping, so if the
PHY-based timestamping is enabled, PKB-based is not handled.
PKB-based timestamp value has a given granularity. Granularity value is
negotiated with the CP and represents a left shift applied to the raw
23-bit counter to obtain nanoseconds (one hardware tick equals 2^gran ns).
The CP signals PKB timestamping is unavailable by setting the granularity
field to 0. Based on the negotiated granularity, the Tx timestamp is
extended to 64 bit - similarly to PHY-based timestamping - and provided
back to the skb.

Extending PKB timestamp value to 64 bit requires PTP support.
Add unit tests to cover PKB timestamp extension to 64 bits.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Co-developed-by: Konstantin Ilichev <konstantin.ilichev@intel.com>
Signed-off-by: Konstantin Ilichev <konstantin.ilichev@intel.com>
---
 drivers/net/ethernet/intel/idpf/.kunitconfig  |  10 +
 drivers/net/ethernet/intel/idpf/Kconfig       |  13 +
 drivers/net/ethernet/intel/idpf/Makefile      |   2 +
 drivers/net/ethernet/intel/idpf/idpf_kunit.c  | 312 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    |  84 +++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  22 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  68 +++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   9 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  21 +-
 include/linux/net/intel/virtchnl2.h           |   6 +-
 10 files changed, 528 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/.kunitconfig
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_kunit.c

diff --git a/drivers/net/ethernet/intel/idpf/.kunitconfig b/drivers/net/ethernet/intel/idpf/.kunitconfig
new file mode 100644
index 000000000000..35a1ae4ef449
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/.kunitconfig
@@ -0,0 +1,10 @@
+CONFIG_KUNIT=y
+CONFIG_NET=y
+CONFIG_ETHERNET=y
+CONFIG_NETDEVICES=y
+CONFIG_NET_VENDOR_INTEL=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PTP_1588_CLOCK=y
+CONFIG_IDPF=y
+CONFIG_IDPF_KUNIT_TEST=y
diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
index 586df3a4afe9..fb9ca41eab1e 100644
--- a/drivers/net/ethernet/intel/idpf/Kconfig
+++ b/drivers/net/ethernet/intel/idpf/Kconfig
@@ -25,4 +25,17 @@ config IDPF_SINGLEQ
 	  wants to work in this mode as it increases the driver size and adds
 	  runtme checks on hotpath.
 
+config IDPF_KUNIT_TEST
+	tristate "KUnit tests for the IDPF driver" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit-based unit tests for the Intel IDPF driver.
+	  This builds the idpf_kunit test module used to validate internal
+	  helper logic and edge-case behavior in a controlled environment.
+	  The tests are intended to run without physical hardware and can be
+	  executed under KUnit test runners (for example in QEMU).
+
+	  If unsure, say N.
+
 endif # IDPF
diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 4aaafa175ec3..68c6485ae079 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -22,3 +22,5 @@ idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_virtchnl_ptp.o
 
 idpf-y				+= xdp.o
 idpf-y				+= xsk.o
+
+obj-$(CONFIG_IDPF_KUNIT_TEST)	+= idpf_kunit.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf_kunit.c b/drivers/net/ethernet/intel/idpf/idpf_kunit.c
new file mode 100644
index 000000000000..676ed1ab6819
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_kunit.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 Intel Corporation */
+
+#include <kunit/test.h>
+
+#include "idpf.h"
+#include "idpf_ptp.h"
+
+#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
+
+struct pkb_tstamp_test_case {
+	const char *desc;
+	u64 cached_phc_time;
+	u32 in_timestamp;
+	u8  gran;
+	u64 expected;
+};
+
+struct pkb_tstamp_negative_case {
+	const char *desc;
+	u64 cached_phc_time;
+	u64 current_phc_time;
+	u8 gran;
+	u64 expected;
+};
+
+/*
+ * KUnit tests for idpf_pkb_tstamp_extend_23b_to_64b().
+ *
+ * The function extends a raw 23-bit Packet Builder (PKB) timestamp to a
+ * full 64-bit nanosecond value using the cached PHC time.  @gran is a
+ * left-shift that converts the 23-bit raw counter value to nanoseconds:
+ * one hardware tick equals 2^gran nanoseconds (e.g. gran=7 - 128 ns/tick,
+ * gran=12 - 4096 ns/tick).
+ */
+static const struct pkb_tstamp_test_case pkb_tstamp_cases[] = {
+	{
+		.desc		 = "gran = 7: same bucket rounds down",
+		.gran		 = 7,
+		.cached_phc_time = 0x25,
+		.in_timestamp	 = 0x0,
+		.expected	 = 0x0,
+	},
+	{
+		.desc		 = "gran = 7: reverse small delta",
+		.gran		 = 7,
+		.cached_phc_time = 0x85,
+		.in_timestamp	 = 0x1,
+		.expected	 = 0x80,
+	},
+	{
+		.desc		 = "gran = 7: forward small delta",
+		.gran		 = 7,
+		.cached_phc_time = 0x80,
+		.in_timestamp	 = 0x2,
+		.expected	 = 0x100,
+	},
+	{
+		.desc		 = "gran = 7: forward wrap across 30-bit ring",
+		.gran		 = 7,
+		.cached_phc_time = 0x123fffff80,
+		.in_timestamp	 = 0x0,
+		.expected	 = 0x1240000000,
+	},
+	{
+		.desc		 = "gran = 7: reverse wrap across 30-bit ring",
+		.gran		 = 7,
+		.cached_phc_time = 0x1240000000,
+		.in_timestamp	 = 0x7fffff,
+		.expected	 = 0x123fffff80,
+	},
+	{
+		.desc		 = "gran = 7: delta == half-range boundary",
+		.gran		 = 7,
+		.cached_phc_time = 0x1220000080,
+		.in_timestamp	 = 0x1,
+		.expected	 = 0x1200000080,
+	},
+	{
+		.desc		 = "gran = 9: reverse small delta",
+		.gran		 = 9,
+		.cached_phc_time = 0x255,
+		.in_timestamp	 = 0x1,
+		.expected	 = 0x200,
+	},
+	{
+		.desc		 = "gran = 9: upper raw bits are masked",
+		.gran		 = 9,
+		.cached_phc_time = 0x255,
+		.in_timestamp	 = 0xFF800001,
+		.expected	 = 0x200,
+	},
+	{
+		.desc		 = "gran = 9: forward wrap across 32-bit ring",
+		.gran		 = 9,
+		.cached_phc_time = 0x00000001fffffff0,
+		.in_timestamp	 = 0x1,
+		.expected	 = 0x0000000200000200,
+	},
+	{
+		.desc		 = "gran = 9: reverse wrap across 32-bit ring",
+		.gran		 = 9,
+		.cached_phc_time = 0x0000000200000200,
+		.in_timestamp	 = 0x7fffff,
+		.expected	 = 0x00000001fffffe00,
+	},
+	{
+		.desc		 = "gran = 9: delta == half-range boundary",
+		.gran		 = 9,
+		.cached_phc_time = 0x0000000280000200,
+		.in_timestamp	 = 0x1,
+		.expected	 = 0x0000000200000200,
+	},
+	{
+		.desc		 = "gran = 12: same bucket rounds down",
+		.gran		 = 12,
+		.cached_phc_time = 0x2555,
+		.in_timestamp	 = 0x2,
+		.expected	 = 0x2000,
+	},
+	{
+		.desc		 = "gran = 12: forward small delta",
+		.gran		 = 12,
+		.cached_phc_time = 0x12345000,
+		.in_timestamp	 = 0x12346,
+		.expected	 = 0x12346000,
+	},
+	{
+		.desc		 = "gran = 12: reverse small delta",
+		.gran		 = 12,
+		.cached_phc_time = 0x12346010,
+		.in_timestamp	 = 0x12346,
+		.expected	 = 0x12346000,
+	},
+	{
+		.desc		 = "gran = 12: forward wrap across 35-bit ring",
+		.gran		 = 12,
+		.cached_phc_time = 0x00000017fffff000,
+		.in_timestamp	 = 0x1,
+		.expected	 = 0x0000001800001000,
+	},
+	{
+		.desc		 = "gran = 12: reverse wrap across 35-bit ring",
+		.gran		 = 12,
+		.cached_phc_time = 0x0000001800001000,
+		.in_timestamp	 = 0x7fffff,
+		.expected	 = 0x00000017fffff000,
+	},
+	{
+		.desc		 = "gran = 12: delta == half-range boundary",
+		.gran		 = 12,
+		.cached_phc_time = 0x0000000500001000,
+		.in_timestamp	 = 0x100001,
+		.expected	 = 0x0000000100001000,
+	},
+};
+
+/*
+ * Negative tests document expected aliasing when the cached PHC is too old:
+ * if |delta| exceeds half of the modular range, extension cannot be unique.
+ */
+static const struct pkb_tstamp_negative_case pkb_tstamp_negative_cases[] = {
+	/* gran = 7: |delta| = half_range + quantum (closest ambiguous cases). */
+	{
+		.desc		  = "gran = 7: stale cache near-boundary far-forward (half + q)",
+		.gran		  = 7,
+		.cached_phc_time  = 0x1234000000,
+		.current_phc_time = 0x1254000080,
+		.expected	  = 0x1214000080,
+	},
+	{
+		.desc		  = "gran = 7: stale cache near-boundary far-backward (half + q)",
+		.gran		  = 7,
+		.cached_phc_time  = 0x1234000000,
+		.current_phc_time = 0x1213ffff80,
+		.expected	  = 0x1253ffff80,
+	},
+	/* gran = 7: |delta| is well beyond half_range. */
+	{
+		.desc		  = "gran = 7: stale cache aliases far-forward time",
+		.gran		  = 7,
+		.cached_phc_time  = 0x123fffff81,
+		.current_phc_time = 0x126011ff89,
+		.expected	  = 0x122011ff80,
+	},
+	{
+		.desc		  = "gran = 7: stale cache aliases far-backward time",
+		.gran		  = 7,
+		.cached_phc_time  = 0x123fffff81,
+		.current_phc_time = 0x121fffff01,
+		.expected	  = 0x125fffff00,
+	},
+	/* gran = 9: |delta| = half_range + quantum (closest ambiguous cases). */
+	{
+		.desc		  = "gran = 9: stale cache near-boundary far-forward (half + q)",
+		.gran		  = 9,
+		.cached_phc_time  = 0x1234000000,
+		.current_phc_time = 0x12b4000200,
+		.expected	  = 0x11b4000200,
+	},
+	{
+		.desc		  = "gran = 9: stale cache near-boundary far-backward (half + q)",
+		.gran		  = 9,
+		.cached_phc_time  = 0x1234000000,
+		.current_phc_time = 0x11b3fffe00,
+		.expected	  = 0x12b3fffe00,
+	},
+	/* gran = 9: |delta| is well beyond half_range. */
+	{
+		.desc		  = "gran = 9: stale cache aliases far-forward time",
+		.gran		  = 9,
+		.cached_phc_time  = 0x0000000100000000,
+		.current_phc_time = 0x0000000180000200,
+		.expected	  = 0x0000000080000200,
+	},
+	{
+		.desc		  = "gran = 9: stale cache aliases far-backward time",
+		.gran		  = 9,
+		.cached_phc_time  = 0x0000000100000000,
+		.current_phc_time = 0x000000007ffffe00,
+		.expected	  = 0x000000017ffffe00,
+	},
+	/* gran = 12: |delta| = half_range + quantum (closest ambiguous cases). */
+	{
+		.desc		  = "gran = 12: stale cache near-boundary far-forward (half + q)",
+		.gran		  = 12,
+		.cached_phc_time  = 0x1234000000,
+		.current_phc_time = 0x1634001000,
+		.expected	  = 0x0e34001000,
+	},
+	{
+		.desc		  = "gran = 12: stale cache near-boundary far-backward (half + q)",
+		.gran		  = 12,
+		.cached_phc_time  = 0x1234000000,
+		.current_phc_time = 0x0e33fff000,
+		.expected	  = 0x1633fff000,
+	},
+	/* gran = 12: |delta| is well beyond half_range. */
+	{
+		.desc		  = "gran = 12: stale cache aliases far-forward time",
+		.gran		  = 12,
+		.cached_phc_time  = 0x0000000500001000,
+		.current_phc_time = 0x0000000900002000,
+		.expected	  = 0x0000000100002000,
+	},
+	{
+		.desc		  = "gran = 12: stale cache aliases far-backward time",
+		.gran		  = 12,
+		.cached_phc_time  = 0x0000000500001000,
+		.current_phc_time = 0x0000000100000000,
+		.expected	  = 0x0000000900000000,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(pkb_tstamp, pkb_tstamp_cases, desc)
+
+static void test_pkb_tstamp_extend_23b_to_64b(struct kunit *test)
+{
+	const struct pkb_tstamp_test_case *tc = test->param_value;
+	u64 result;
+
+	result = idpf_pkb_tstamp_extend_23b_to_64b(tc->cached_phc_time,
+						   tc->in_timestamp,
+						   tc->gran);
+	KUNIT_EXPECT_EQ(test, result, tc->expected);
+}
+
+KUNIT_ARRAY_PARAM_DESC(pkb_tstamp_negative, pkb_tstamp_negative_cases, desc)
+
+static void test_pkb_tstamp_extend_23b_to_64b_negative(struct kunit *test)
+{
+	const struct pkb_tstamp_negative_case *tc = test->param_value;
+	u64 true_time, result;
+	u32 in_timestamp;
+
+	in_timestamp = (tc->current_phc_time >> tc->gran) & GENMASK(22, 0);
+	true_time = tc->current_phc_time & ~(BIT_ULL(tc->gran) - 1);
+
+	result = idpf_pkb_tstamp_extend_23b_to_64b(tc->cached_phc_time,
+						   in_timestamp,
+						   tc->gran);
+
+	/*
+	 * Result is expected to differ from the true quantized time when stale
+	 * cache makes the extension ambiguous (> half modular range).
+	 */
+	KUNIT_EXPECT_NE(test, result, true_time);
+	KUNIT_EXPECT_EQ(test, result, tc->expected);
+}
+
+#endif /* CONFIG_PTP_1588_CLOCK */
+
+static struct kunit_case idpf_kunit_test_cases[] = {
+#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
+	KUNIT_CASE_PARAM(test_pkb_tstamp_extend_23b_to_64b,
+			 pkb_tstamp_gen_params),
+	KUNIT_CASE_PARAM(test_pkb_tstamp_extend_23b_to_64b_negative,
+			 pkb_tstamp_negative_gen_params),
+#endif /* CONFIG_PTP_1588_CLOCK */
+	{}
+};
+
+static struct kunit_suite idpf_kunit_test_suite = {
+	.name = "idpf-kunit",
+	.test_cases = idpf_kunit_test_cases,
+};
+
+kunit_test_suite(idpf_kunit_test_suite);
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+MODULE_DESCRIPTION("KUnit tests for IDPF driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 71fe8b2a8b4e..e9da88a4a19e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2024 Intel Corporation */
 
+#include <kunit/visibility.h>
 #include "idpf.h"
 #include "idpf_ptp.h"
 
@@ -326,6 +327,23 @@ static int idpf_ptp_gettimex64(struct ptp_clock_info *info,
 	return 0;
 }
 
+/**
+ * idpf_ptp_update_phctime_txq_grp - Update the cached PHC time for a given Tx
+ *				     queue group.
+ * @grp: transmit queue group in which Tx timestamp is enabled
+ * @systime: cached system time
+ */
+static void
+idpf_ptp_update_phctime_txq_grp(const struct idpf_txq_group *grp, u64 systime)
+{
+	for (u16 i = 0; i < grp->num_txq; i++) {
+		struct idpf_tx_queue *txq = grp->txqs[i];
+
+		if (txq)
+			WRITE_ONCE(txq->cached_phc, systime);
+	}
+}
+
 /**
  * idpf_ptp_update_phctime_rxq_grp - Update the cached PHC time for a given Rx
  *				     queue group.
@@ -369,6 +387,7 @@ idpf_ptp_update_phctime_rxq_grp(const struct idpf_rxq_group *grp, bool split,
  */
 static int idpf_ptp_update_cached_phctime(struct idpf_adapter *adapter)
 {
+	bool pkb_ena = adapter->ptp->pkb_tstamp_ena;
 	u64 systime;
 	int err;
 
@@ -398,6 +417,15 @@ static int idpf_ptp_update_cached_phctime(struct idpf_adapter *adapter)
 
 			idpf_ptp_update_phctime_rxq_grp(grp, split, systime);
 		}
+
+		if (!pkb_ena)
+			continue;
+
+		for (u16 i = 0; i < rsrc->num_txq_grp; i++) {
+			struct idpf_txq_group *grp = &rsrc->txq_grps[i];
+
+			idpf_ptp_update_phctime_txq_grp(grp, systime);
+		}
 	}
 
 	return 0;
@@ -599,6 +627,62 @@ u64 idpf_ptp_tstamp_extend_32b_to_64b(u64 cached_phc_time, u32 in_timestamp)
 	return ns;
 }
 
+/**
+ * idpf_pkb_tstamp_extend_23b_to_64b - Convert a 23b raw packet builder (PKB)
+ * timestamp value to 64b nanoseconds.
+ * @cached_phc_time: recently cached copy of PHC time
+ * @in_timestamp: raw packet builder timestamp value (at most 23 bits)
+ * @gran: granularity shift, number of left shifts to convert
+ *	  @in_timestamp to nanoseconds
+ *
+ * Hardware captures PKB timestamps with at most 23 significant bits, with
+ * upper bits being zero. The @gran parameter specifies the granularity shift
+ * needed to express the raw value in nanoseconds. The resulting nanosecond
+ * value is then extended to 64 bits using the cached PHC time.
+ *
+ * Return: PKB timestamp value extended to 64 bits based on cached PHC time.
+ */
+u64 idpf_pkb_tstamp_extend_23b_to_64b(u64 cached_phc_time, u32 in_timestamp,
+				      u8 gran)
+{
+	u64 in_tstamp_ns, delta, phc_time_lo, tstamp_mask, ns;
+
+	/*
+	 * Convert the raw timestamp to nanoseconds. Mask to 23 bits first,
+	 * then cast to u64 before shifting to avoid truncation when the result
+	 * exceeds 32 bits.
+	 */
+	in_tstamp_ns = (u64)(in_timestamp & GENMASK(IDPF_PKB_TS_BITS - 1, 0));
+	in_tstamp_ns <<= gran;
+
+	/*
+	 * Mask covering all (23 + gran) significant bits of the timestamp.
+	 * Used to extract the matching low bits from the PHC time and to
+	 * keep delta arithmetic within the same modular range.
+	 */
+	tstamp_mask = GENMASK_ULL(IDPF_PKB_TS_BITS - 1 + gran, 0);
+
+	/* Extract the lower (23 + gran) bits of the PHC time */
+	phc_time_lo = cached_phc_time & tstamp_mask;
+
+	/*
+	 * Calculate the delta between the lower bits of the cached PHC
+	 * time and the in_tstamp_ns value.
+	 */
+	delta = (in_tstamp_ns - phc_time_lo) & tstamp_mask;
+
+	if (delta > tstamp_mask / 2) {
+		/* Reverse the delta calculation here */
+		delta = (phc_time_lo - in_tstamp_ns) & tstamp_mask;
+		ns = cached_phc_time - delta;
+	} else {
+		ns = cached_phc_time + delta;
+	}
+
+	return ns;
+}
+EXPORT_SYMBOL_IF_KUNIT(idpf_pkb_tstamp_extend_23b_to_64b);
+
 /**
  * idpf_ptp_extend_ts - Convert a 40b timestamp to 64b nanoseconds
  * @vport: Virtual port structure
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
index 785da03e4cf5..0a01f9b6da67 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
@@ -6,6 +6,11 @@
 
 #include <linux/ptp_clock_kernel.h>
 
+/* Number of significant bits in a raw PKB timestamp */
+#define IDPF_PKB_TS_BITS 23
+/* Maximum supported granularity shift for PKB timestamp extension */
+#define IDPF_PKB_GRAN_MAX ((u8)(sizeof(u64) * 8 - IDPF_PKB_TS_BITS))
+
 /**
  * struct idpf_ptp_cmd - PTP command masks
  * @exec_cmd_mask: mask to trigger command execution
@@ -172,7 +177,9 @@ struct idpf_ptp_vport_tx_tstamp_caps {
  * @set_dev_clk_time_access: access type for setting the device clock time
  * @adj_dev_clk_time_access: access type for the adjusting the device clock
  * @tx_tstamp_access: access type for the Tx timestamp value read
- * @rsv: reserved bits
+ * @pkb_tstamp_ena: packet builder (PKB) timestamping enabled
+ * @tx_compl_tstamp_gran_s: number of left shifts to convert Tx completion
+ *			    descriptor timestamp in nanoseconds
  * @secondary_mbx: parameters for using dedicated PTP mailbox
  * @read_dev_clk_lock: spinlock protecting access to the device clock read
  *		       operation executed by the HW latch
@@ -193,7 +200,8 @@ struct idpf_ptp {
 	enum idpf_ptp_access set_dev_clk_time_access:2;
 	enum idpf_ptp_access adj_dev_clk_time_access:2;
 	enum idpf_ptp_access tx_tstamp_access:2;
-	u8 rsv;
+	bool pkb_tstamp_ena:1;
+	u8 tx_compl_tstamp_gran_s;
 	struct idpf_ptp_secondary_mbx secondary_mbx;
 	spinlock_t read_dev_clk_lock;
 };
@@ -283,13 +291,15 @@ int idpf_ptp_set_timestamp_mode(struct idpf_vport *vport,
 				struct kernel_hwtstamp_config *config);
 u64 idpf_ptp_extend_ts(struct idpf_vport *vport, u64 in_tstamp);
 u64 idpf_ptp_tstamp_extend_32b_to_64b(u64 cached_phc_time, u32 in_timestamp);
+u64 idpf_pkb_tstamp_extend_23b_to_64b(u64 cached_phc_time, u32 in_timestamp,
+				      u8 gran);
 int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q, struct sk_buff *skb,
 			u32 *idx);
 void idpf_tstamp_task(struct work_struct *work);
 #else /* CONFIG_PTP_1588_CLOCK */
 static inline int idpf_ptp_init(struct idpf_adapter *adapter)
 {
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline void idpf_ptp_release(struct idpf_adapter *adapter) { }
@@ -368,6 +378,12 @@ static inline u64 idpf_ptp_tstamp_extend_32b_to_64b(u64 cached_phc_time,
 	return 0;
 }
 
+static inline u64 idpf_pkb_tstamp_extend_23b_to_64b(u64 cached_phc_time,
+						    u32 in_timestamp, u8 gran)
+{
+	return 0;
+}
+
 static inline int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q,
 				      struct sk_buff *skb, u32 *idx)
 {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 9d9448cfd68b..24135013e256 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1441,12 +1441,21 @@ static int idpf_vport_init_fast_path_txqs(struct idpf_vport *vport,
 {
 	struct idpf_ptp_vport_tx_tstamp_caps *caps = vport->tx_tstamp_caps;
 	struct work_struct *tstamp_task = &vport->tstamp_task;
+	struct idpf_ptp *ptp = vport->adapter->ptp;
+	bool pkb_ena = false;
+	u8 tstamp_gran;
 	int k = 0;
 
 	vport->txqs = kzalloc_objs(*vport->txqs, rsrc->num_txq);
 	if (!vport->txqs)
 		return -ENOMEM;
 
+	if (ptp) {
+		pkb_ena = ptp->pkb_tstamp_ena;
+		if (pkb_ena)
+			tstamp_gran = ptp->tx_compl_tstamp_gran_s;
+	}
+
 	vport->num_txq = rsrc->num_txq;
 	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
 		struct idpf_txq_group *tx_grp = &rsrc->txq_grps[i];
@@ -1458,6 +1467,13 @@ static int idpf_vport_init_fast_path_txqs(struct idpf_vport *vport,
 			if (!caps)
 				continue;
 
+			/*
+			 * For PKB timestamping assign granularity negotiated
+			 * with the Control Plane.
+			 */
+			if (pkb_ena)
+				vport->txqs[k]->compl_tstamp_ns_s = tstamp_gran;
+
 			vport->txqs[k]->cached_tstamp_caps = caps;
 			vport->txqs[k]->tstamp_task = tstamp_task;
 		}
@@ -1995,6 +2011,39 @@ int idpf_vport_queues_alloc(struct idpf_vport *vport,
 	return err;
 }
 
+/**
+ * idpf_tx_pkb_hwtstamp - report HW timestamp generated by packet builder from
+ * completion descriptor to the stack.
+ * @txq: pointer to txq struct
+ * @skb: original skb
+ * @desc_ts: pointer to 3-byte timestamp from descriptor
+ */
+static void idpf_tx_pkb_hwtstamp(const struct idpf_tx_queue *txq,
+				 struct sk_buff *skb, const u8 *desc_ts)
+{
+	struct skb_shared_hwtstamps hwtstamps;
+	u64 ext_tstamp;
+	u32 tstamp;
+
+	/* Return if PKB timestamping is disabled */
+	if (unlikely(!txq->compl_tstamp_ns_s))
+		return;
+
+	/* Read Tx timestamp value generated by the PKB from the descriptor */
+	tstamp = (desc_ts[0] | (desc_ts[1] << 8) | (desc_ts[2] << 16));
+
+	/* Extend value to 64 bits required by the skb */
+	ext_tstamp = idpf_pkb_tstamp_extend_23b_to_64b(READ_ONCE(txq->cached_phc),
+						       tstamp,
+						       txq->compl_tstamp_ns_s);
+
+	hwtstamps = (struct skb_shared_hwtstamps) {
+		.hwtstamp = ns_to_ktime(ext_tstamp),
+	};
+
+	skb_tstamp_tx(skb, &hwtstamps);
+}
+
 /**
  * idpf_tx_read_tstamp - schedule a work to read Tx timestamp value
  * @txq: queue to read the timestamp from
@@ -2119,6 +2168,7 @@ static void idpf_tx_splitq_clean(struct idpf_tx_queue *tx_q, u16 end,
  * @txq: queue to clean
  * @buf_id: packet's starting buffer ID, from completion descriptor
  * @cleaned: pointer to stats struct to track cleaned packets/bytes
+ * @desc_ts: pointer to 3-byte timestamp from descriptor
  * @budget: Used to determine if we are in netpoll
  *
  * Clean all buffers associated with the packet starting at buf_id. Returns the
@@ -2126,7 +2176,7 @@ static void idpf_tx_splitq_clean(struct idpf_tx_queue *tx_q, u16 end,
  */
 static void idpf_tx_clean_bufs(struct idpf_tx_queue *txq, u32 buf_id,
 			       struct libeth_sq_napi_stats *cleaned,
-			       int budget)
+			       u8 *desc_ts, int budget)
 {
 	struct idpf_tx_buf *tx_buf = NULL;
 	struct libeth_cq_pp cp = {
@@ -2136,13 +2186,13 @@ static void idpf_tx_clean_bufs(struct idpf_tx_queue *txq, u32 buf_id,
 	};
 
 	tx_buf = &txq->tx_buf[buf_id];
-	if (tx_buf->type == LIBETH_SQE_SKB) {
-		if (skb_shinfo(tx_buf->skb)->tx_flags & SKBTX_IN_PROGRESS)
-			idpf_tx_read_tstamp(txq, tx_buf->skb);
+	if (unlikely(skb_shinfo(tx_buf->skb)->tx_flags & SKBTX_IN_PROGRESS))
+		idpf_tx_read_tstamp(txq, tx_buf->skb);
+	else if (unlikely(skb_shinfo(tx_buf->skb)->tx_flags & SKBTX_HW_TSTAMP))
+		idpf_tx_pkb_hwtstamp(txq, tx_buf->skb, desc_ts);
 
-		libeth_tx_complete(tx_buf, &cp);
-		idpf_post_buf_refill(txq->refillq, buf_id);
-	}
+	libeth_tx_complete(tx_buf, &cp);
+	idpf_post_buf_refill(txq->refillq, buf_id);
 
 	while (idpf_tx_buf_next(tx_buf) != IDPF_TXBUF_NULL) {
 		buf_id = idpf_tx_buf_next(tx_buf);
@@ -2179,7 +2229,7 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
 		return;
 	}
 
-	idpf_tx_clean_bufs(txq, rs_compl_val, cleaned, budget);
+	idpf_tx_clean_bufs(txq, rs_compl_val, cleaned, desc->ts, budget);
 }
 
 /**
@@ -2964,8 +3014,6 @@ static int idpf_tx_tstamp(struct idpf_tx_queue *tx_q, struct sk_buff *skb,
 		return -1;
 	}
 
-	off->tx_flags |= IDPF_TX_FLAGS_TSYN;
-
 	return idx;
 }
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 93547597efd2..985101c2e823 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -140,7 +140,6 @@ do {								\
 #define IDPF_TX_FLAGS_IPV4		BIT(1)
 #define IDPF_TX_FLAGS_IPV6		BIT(2)
 #define IDPF_TX_FLAGS_TUNNEL		BIT(3)
-#define IDPF_TX_FLAGS_TSYN		BIT(4)
 
 struct libeth_rq_napi_stats;
 
@@ -629,8 +628,11 @@ libeth_cacheline_set_assert(struct idpf_rx_queue,
  * @xdp_tx: number of pending &xdp_buff or &xdp_frame buffers
  * @timer: timer for XDP Tx queue cleanup
  * @xdp_lock: lock for XDP Tx queues sharing
+ * @compl_tstamp_ns_s: Number of left shifts to convert Tx completion
+ *		       descriptor timestamp in nanoseconds
  * @cached_tstamp_caps: Tx timestamp capabilities negotiated with the CP
  * @tstamp_task: Work that handles Tx timestamp read
+ * @cached_phc: Cached PHC time for the Tx queue
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_tx_queue_stats
  * @q_id: Queue id
@@ -704,6 +706,9 @@ struct idpf_tx_queue {
 
 	struct u64_stats_sync stats_sync;
 	struct idpf_tx_queue_stats q_stats;
+
+	u64 cached_phc;
+	u8 compl_tstamp_ns_s;
 	__cacheline_group_end_aligned(read_write);
 
 	__cacheline_group_begin_aligned(cold);
@@ -718,7 +723,7 @@ struct idpf_tx_queue {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
-			    104 +
+			    120 +
 			    offsetof(struct idpf_tx_queue, cached_tstamp_caps) -
 			    offsetofend(struct idpf_tx_queue, timer) +
 			    offsetof(struct idpf_tx_queue, q_stats) -
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index cc5aeec3d00b..f1c268261f7a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -562,7 +562,8 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
 			    VIRTCHNL2_CAP_PROMISC		|
 			    VIRTCHNL2_CAP_LOOPBACK		|
-			    VIRTCHNL2_CAP_PTP);
+			    VIRTCHNL2_CAP_PTP			|
+			    VIRTCHNL2_CAP_TX_CMPL_TSTMP);
 
 	err = idpf_send_mb_msg(adapter, &xn_params, &caps, sizeof(caps));
 	if (err)
@@ -3136,10 +3137,24 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 	}
 
 	err = idpf_ptp_init(adapter);
-	if (err)
+	if (err == -EOPNOTSUPP) {
+		pci_dbg(adapter->pdev, "PTP is not supported\n");
+	} else if (err) {
 		pci_err(adapter->pdev, "PTP init failed, err=%pe\n",
 			ERR_PTR(err));
-
+	} else if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS,
+				   VIRTCHNL2_CAP_TX_CMPL_TSTMP)) {
+		if (adapter->caps.tx_cmpl_tstamp_ns_s > IDPF_PKB_GRAN_MAX)
+			pci_err(adapter->pdev,
+				"Invalid PKB timestamp granularity shift %u (max %u), disabling PKB timestamping\n",
+				adapter->caps.tx_cmpl_tstamp_ns_s,
+				IDPF_PKB_GRAN_MAX);
+		else if (adapter->caps.tx_cmpl_tstamp_ns_s > 0) {
+			adapter->ptp->pkb_tstamp_ena = true;
+			adapter->ptp->tx_compl_tstamp_gran_s =
+				adapter->caps.tx_cmpl_tstamp_ns_s;
+		}
+	}
 	idpf_init_avail_queues(adapter);
 
 	/* Skew the delay for init tasks for each function based on fn number
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index 39fea65c075c..bf79f82f2257 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -221,6 +221,7 @@ enum virtchnl2_cap_other {
 	/* Other capability 20 is reserved */
 	VIRTCHNL2_CAP_FLOW_STEER		= BIT_ULL(21),
 	VIRTCHNL2_CAP_LAN_MEMORY_REGIONS	= BIT_ULL(22),
+	VIRTCHNL2_CAP_TX_CMPL_TSTMP		= BIT_ULL(23),
 
 	/* this must be the last capability */
 	VIRTCHNL2_CAP_OEM			= BIT_ULL(63),
@@ -513,6 +514,8 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_version_info);
  *			 an LSO.
  * @num_rdma_allocated_vectors: Maximum number of allocated RDMA vectors for
  *				the device.
+ * @tx_cmpl_tstamp_ns_s: Number of left shifts to convert Tx completion
+ *			 descriptor timestamp in nanoseconds.
  * @pad1: Padding for future extensions.
  *
  * Dataplane driver sends this message to CP to negotiate capabilities and
@@ -561,7 +564,8 @@ struct virtchnl2_get_capabilities {
 	u8 min_sso_packet_len;
 	u8 max_hdr_buf_per_lso;
 	__le16 num_rdma_allocated_vectors;
-	u8 pad1[8];
+	u8 tx_cmpl_tstamp_ns_s;
+	u8 pad1[7];
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(80, virtchnl2_get_capabilities);
 
-- 
2.47.3

