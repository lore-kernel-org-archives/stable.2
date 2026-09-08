Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC40492E21;
	Tue,  8 Sep 2026 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908337; cv=none; b=Y9eTV/KOEHoBW2GMbxBlyARXIC5qTpsRPCwqfpBDkMrV17HUcseiBfTHi6fQVnv79IBLlFKwriZ2wtLASOwB7MbIQUjX2SgBElrhVyyml0rZEjaDN7YaY16iLIat+eOILptYC6AtIiIl69VZ1ve4mT35fxlKs4iGHD9HXTcLOqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908337; c=relaxed/simple;
	bh=YQgM1KJ70BAmWSmNp9i9Gj4DimzaAi65Ceq90tR6OKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUUhJpACl9P7G6GH9kMu3o4BDBUaN0hcYn4b3b+0dvZljPU/C3vUQFzUaGjxA9JfJ/T1Su+CIIaCW9UofbD0KrQVYSikYguH29VxgueIeHUozhTiLHPSMH4uoQ3EiJnv1AEGlY3p/Pd6zFi0X2YsSE5tZp6iOmzOtNci+M8FfUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyvJ635N; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyvJ635N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788908334; x=1820444334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YQgM1KJ70BAmWSmNp9i9Gj4DimzaAi65Ceq90tR6OKY=;
  b=DyvJ635NuZm7l+M6LvY7h3H4sKOdXgFvNIoBpSyhd2i3LsoFIgk1vzmN
   riRzywsgSRnQUehnv+BMKRKEk1RWbRMpVi5+qXEF/Hwqc1X8w+XOXkoEy
   ElBwKC8Fe+tk7844TVGi3qbe7vhS59uslezgjc7s+F2JA4n/fAPhbYpna
   Pl2yv9tK5OTLrUIlKZRMA4VVIZUtVW3uB4U6S1MG0RlAhU6nx8IoCL+80
   nsiW3Dseee8SMnb0fL4LewMXOhVHSBGCHheGc06nnVagHGT9kWo3BNZ7B
   C/raZiIkLteHK7ogGeIngAoEtN/7mxn0k8biAOXRqGkHutIamtaFLTXZh
   w==;
X-CSE-ConnectionGUID: fryVAAxxSfeXg9QZimE6JA==
X-CSE-MsgGUID: WiAhZAwmQPGPtMheOAKnrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="99916601"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="99916601"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 15:58:53 -0700
X-CSE-ConnectionGUID: kYMS1yqSTw6qabhyCLD6vg==
X-CSE-MsgGUID: 4KCPMKVKRsKBzpcT61PU6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="309400545"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa001.jf.intel.com with ESMTP; 08 Sep 2026 15:58:53 -0700
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
	sohil.mehta@intel.com,
	chang.seok.bae@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v2] x86/microcode/intel: Reject problematic loading on Granite Rapids systems
Date: Tue,  8 Sep 2026 22:32:09 +0000
Message-ID: <20260908223209.916758-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901231634.714144-2-chang.seok.bae@intel.com>
References: <20260901231634.714144-2-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microcode updates can usually jump revisions. However, there is an
erratum on Granite Rapids systems. If they "jump over" to revision
0x1000405 or later, they result in #MC.

Prevent loading 0x1000405 or later unless the running revision is already
at least 0x1000405. Apply this blocking to both early- and late-loading
paths.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: <stable@vger.kernel.org>
---
V1 -> V2:
* Cut the code comments and print messages (Boris)
* Rename the new function and keep the old function as it-is (Boris)
* Rewrote the changelog (Dave)
* Add `revision` in the error messages (Sohil)
---
 arch/x86/kernel/cpu/microcode/intel.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1142183c950c..61ad280497e9 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -309,6 +309,32 @@ static void save_microcode_patch(struct microcode_intel *patch)
 		pr_err("Unable to allocate microcode memory size: %u\n", size);
 }
 
+static bool revision_banned(struct cpu_signature *sig, u32 rev)
+{
+	u32 vfm = IFM(x86_family(sig->sig), x86_model(sig->sig));
+
+	/*
+	 * Revision 0x1000405 contains prerequisite changes for subsequent
+	 * microcode updates on Granite Rapids systems. Updates directly from
+	 * an older revision to this or a newer one can result in #MC. This is
+	 * documented item GNR98, #835486 (Intel Xeon 6900/6700/6500-Series
+	 * Processors with P-Cores).
+	 */
+	if (vfm == INTEL_GRANITERAPIDS_X &&
+	    x86_stepping(sig->sig) == 1 &&
+	    sig->pf & 0x95 &&
+	    sig->rev < 0x1000405 &&
+	    rev >= 0x1000405) {
+		if (rev == 0x1000405)
+			pr_err_once("Erratum GNR98: revision 0x1000405 is not loadable.\n");
+		else
+			pr_err_once("Erratum GNR98: revision 0x1000405 is required before 0x%x.\n", rev);
+		return true;
+	}
+
+	return false;
+}
+
 /* Scan blob for microcode matching the boot CPUs family, model, stepping */
 static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 						     struct ucode_cpu_info *uci,
@@ -330,6 +356,9 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 		if (!intel_find_matching_signature(data, &uci->cpu_sig))
 			continue;
 
+		if (revision_banned(&uci->cpu_sig, mc_header->rev))
+			continue;
+
 		/*
 		 * For saving the early microcode, find the matching revision which
 		 * was loaded on the BSP.
@@ -878,6 +907,9 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 		if (!intel_find_matching_signature(mc, &uci->cpu_sig))
 			continue;
 
+		if (revision_banned(&uci->cpu_sig, mc_header.rev))
+			continue;
+
 		is_safe = ucode_validate_minrev(&mc_header);
 		if (force_minrev && !is_safe)
 			continue;
-- 
2.53.0

