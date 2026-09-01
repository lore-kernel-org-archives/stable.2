Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2353D567F;
	Tue,  1 Sep 2026 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306199; cv=none; b=Q4+VAT0WrTQEZz25nQx66KVY9BVPrl4oKt47a3qJ/iCr2vfYypDw8nGZyU3ewiNFLfl5bYkqjl5OWfBYuU1Tej037LjtjThKcpOxSlNMmGyzEEyBCOX2Op4f55ALiiRIJ3TTXI8Fo+UQyWcyjEgr7yf4a1sq0ehDd2EacTGNpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306199; c=relaxed/simple;
	bh=aNne2qQnrJg4PvKvtwhkwuzAaor7MUDU122PMGNWSP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDTUjkJnUoYNcwgZoiWGMXCJL61/PHwf7zXwunYA1hPO6vOWrjyFHBffNkybi7C2IKtEOaByllaAHPFScHqdX0KwYAlk5Y7PjL5bIRyU4IrsSoO6MzZEKLQ9mbu/5CSOYY4Ds3+EpMY/zAm1XfY0ZXJx+HiAZD9C7Csmo9S0cdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZxQSoI0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZxQSoI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788306197; x=1819842197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aNne2qQnrJg4PvKvtwhkwuzAaor7MUDU122PMGNWSP4=;
  b=HZxQSoI0Nj1EO9mJe1U+qeRy+3NL51alEObu3XQcBSaI+9TR8bmM+u5d
   jug1A0YuPptljhunvB3gHl+vymLv2p5zm5+UYS/twczi14YiTXUyMVUbE
   eTcM0IA1PjvhrtOpODhF0ybF1ekWDiUZIJZH1eIpe1/UUDNLiFmFtjmfr
   oeytsuGJrQ+nOCIB5V59MxH0lkjJXAf7yxvACcGWVRE02w6GUvl6OH8bd
   XVoc4uYUCWtkQZAq0uSdoafr0UcJ49HNYe5KqBKGSOIGhjBgan9jvM2OY
   SjMRuvoi5iohhj//AWd5eJAlB/JZDbzRqgpxRJri+Y9ujncxpH0Md234j
   w==;
X-CSE-ConnectionGUID: Yajtoyy3QymM/kEOpXEFkg==
X-CSE-MsgGUID: DblhapU/Ri68kdgCC/2Y1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87891863"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="87891863"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 16:43:16 -0700
X-CSE-ConnectionGUID: LVt2cL9dRb2r7JB353YNPQ==
X-CSE-MsgGUID: WGI/GBHvR8O2CWQwPQ1WJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="267469876"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa006.jf.intel.com with ESMTP; 01 Sep 2026 16:43:16 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	andrew.cooper3@citrix.com,
	arjan.van.de.ven@intel.com,
	chang.seok.bae@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 1/8] x86/microcode/intel: Reject problematic loading on GNR systems
Date: Tue,  1 Sep 2026 23:16:26 +0000
Message-ID: <20260901231634.714144-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901231634.714144-1-chang.seok.bae@intel.com>
References: <20260901231634.714144-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revision 0x1000405 contains internal microcode changes that are required
by subsequent revisions to avoid #MC during loading. This dependency
logically fits the minimum revision requirement.

The minimum revision check, however, currently applies only to the late
loading path, since the dependency was primarily intended for OS-visible
changes. The early loading path is therefore still vulnerable to this
issue.

Furthermore, one of the subsequent revisions does not correctly specify
the minimum revision, so unfortunately the late loading cannot rely on
that check either in this case.

Prevent loading 0x1000405 or later when the system has not yet been
updated to 0x1000405 or later. Apply this blocking to both early- and
late-loading paths.

Rename is_blacklisted() to is_late_loading_denied() so the new function
that covers both loading paths is not confused with the late-load only
one.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: <stable@vger.kernel.org>
---
The GNR errata page:
https://edc.intel.com/content/www/jp/ja/design/products-and-solutions/processors-and-chipsets/birch-stream/xeon-6900-6700-6500-series-processors-with-p-cores-specification-update/016US/errata-summary-table/

Thanks to Sohil, I noticed the naming guideline in
Documentation/process/coding-style.rst:
    For symbol names and documentation, avoid introducing new usage of
    'master / slave' (or 'slave' independent of 'master') and 'blacklist /
    whitelist'.
---
 arch/x86/kernel/cpu/microcode/intel.c | 42 +++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1142183c950c..c502138fd8e9 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -309,6 +309,38 @@ static void save_microcode_patch(struct microcode_intel *patch)
 		pr_err("Unable to allocate microcode memory size: %u\n", size);
 }
 
+static bool is_loading_denied(struct cpu_signature *sig, u32 rev)
+{
+	u32 vfm = IFM(x86_family(sig->sig), x86_model(sig->sig));
+
+	/*
+	 * Revision 0x1000405 contains prerequisite changes for subsequent
+	 * microcode updates on Granite Rapids systems. Updates directly from
+	 * an older revision to this or a newer one can result in #MC (GNR98).
+	 *
+	 * This dependency can be indicated from the minimum revision field.
+	 * However, revision 0x1000423 has an incorrect minimum revision in its
+	 * header (GNR101).
+	 *
+	 * Prevent loading 0x1000405 or later unless the CPU has already been
+	 * updated to 0x1000405 or later.
+	 */
+	if (vfm == INTEL_GRANITERAPIDS_X &&
+	    x86_stepping(sig->sig) == 1 &&
+	    sig->pf & 0x95 &&
+	    sig->rev < 0x1000405 &&
+	    rev >= 0x1000405) {
+		if (rev == 0x1000405)
+			pr_err_once("Erratum GNR98: 0x1000405 is not loadable.\n");
+		else
+			pr_err_once("Erratum GNR98: 0x1000405 is required before 0x%x.\n", rev);
+		pr_err_once("Please update the system BIOS or firmware.\n");
+		return true;
+	}
+
+	return false;
+}
+
 /* Scan blob for microcode matching the boot CPUs family, model, stepping */
 static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 						     struct ucode_cpu_info *uci,
@@ -330,6 +362,9 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 		if (!intel_find_matching_signature(data, &uci->cpu_sig))
 			continue;
 
+		if (is_loading_denied(&uci->cpu_sig, mc_header->rev))
+			continue;
+
 		/*
 		 * For saving the early microcode, find the matching revision which
 		 * was loaded on the BSP.
@@ -878,6 +913,9 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 		if (!intel_find_matching_signature(mc, &uci->cpu_sig))
 			continue;
 
+		if (is_loading_denied(&uci->cpu_sig, mc_header.rev))
+			continue;
+
 		is_safe = ucode_validate_minrev(&mc_header);
 		if (force_minrev && !is_safe)
 			continue;
@@ -905,7 +943,7 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 	return UCODE_ERROR;
 }
 
-static bool is_blacklisted(unsigned int cpu)
+static bool is_late_loading_denied(unsigned int cpu)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 
@@ -936,7 +974,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
 	struct kvec kvec;
 	char name[30];
 
-	if (is_blacklisted(cpu))
+	if (is_late_loading_denied(cpu))
 		return UCODE_NFOUND;
 
 	sprintf(name, "intel-ucode/%02x-%02x-%02x",
-- 
2.53.0

