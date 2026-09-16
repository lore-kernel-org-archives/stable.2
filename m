Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48B4C957B;
	Wed, 16 Sep 2026 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601186; cv=none; b=IEzBoHoOEutqKBgk+Wb8dxe+cFvRDEBdbNZ/Xa7Vcp9pQL1dRDVI0mUm9EOEPiZCelp+ulCFOyEvj+bXcOeL38map0y7FPdGB4sCAbHoBSgE65QLp3LPQ4C5iybKs7Mjp5SToqO8vdSSdQqIacSNGIdu/LselWbuoCEhMdySf+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601186; c=relaxed/simple;
	bh=iAECNsv0Lwxzy8dLjWkZQlyTMj+r/7qE9/C97BfwrHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cs+fp93HVj2ep5zBxMuXHRSCGq0p2hGWuzYBY2iKGjLQtF05QMOde3c0Easq38Y72WLlpL59aOcARQQyaABe9hzxT08q+893pGLPd6Z12DK2tzz3oCdTOpatrs8r68T2lw/a6GtPtNGpbEorq43Xy8CKB+mxbXrKXrcZ30Pf0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htexgVkY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htexgVkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789601185; x=1821137185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iAECNsv0Lwxzy8dLjWkZQlyTMj+r/7qE9/C97BfwrHw=;
  b=htexgVkYZwOTqCLy48nq3cLKmcnz0ucMafxQcVeLaaDnbcJUbQAVngnU
   dkaDdMeRLmNrH0tc2dH4XTU5aSnrIXgVwfOYmUPillm033kbmP+0BhBzP
   tZu3wPUVLiPfYKrDa0WqGUMzcGSmyWEe0QZ+vGD50pgMuv5DeaH3ZA7Do
   wn+9iVFOxHk+IQXNxSHySx4jk66Y2M/rOJCJFzHla+lnBN0k5CVRgIp4q
   NZWssJdLBaxabMRfrv8P7TbcSm4VLXTV4OHzqPFQz/rW8OmkjFDam6Cct
   YvL1PYqulqZ2CE0NiFzjMuEJEiupulGRQFvS020YiRto7azh5beRx6prb
   g==;
X-CSE-ConnectionGUID: 87n4lvSDRTChcGfP48214Q==
X-CSE-MsgGUID: a65iJeOkT+GDwO6ONEQlwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112756636"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112756636"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 16:26:24 -0700
X-CSE-ConnectionGUID: hCOZOQCFQ1CGz9GLoa3Bsg==
X-CSE-MsgGUID: pNN7kIJCTz+MdsTRp4upVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1697194"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa011.fm.intel.com with ESMTP; 16 Sep 2026 16:26:24 -0700
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
Subject: [PATCH v3] x86/microcode/intel: Reject problematic loading on Granite Rapids systems
Date: Wed, 16 Sep 2026 22:59:39 +0000
Message-ID: <20260916225939.1144524-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908223209.916758-1-chang.seok.bae@intel.com>
References: <20260908223209.916758-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microcode updates can usually jump revisions. However, there is an
erratum on Granite Rapids systems. If they "jump over" revision
0x1000405, they result in #MC. Avoid it.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <stable@vger.kernel.org>
---
V2 -> V3:
* Shorten the changelog and rename the function (Boris)
* Reduce the code comment (Dave)
* Allow 0x1000405 loading. Thanks to Andrew, this fix got attention.
* Collect Dave review tag. Thanks, Dave!

Note:
* GNR98 currently describes loading 0x1000405 itself is unsafe, but it
  will be updated to say okay with that. I will watch out the GNR98
  changes.
* Jumping from < 0x1000380 to 0x1000405 was identified as an issue, but
  0x1000380 is the first revision as GNR products. So loading 0x1000405
  in production systems should be okay.
---
 arch/x86/kernel/cpu/microcode/intel.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1142183c950c..30a22388d4b1 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -309,6 +309,26 @@ static void save_microcode_patch(struct microcode_intel *patch)
 		pr_err("Unable to allocate microcode memory size: %u\n", size);
 }
 
+static bool revision_is_safe(struct cpu_signature *sig, u32 rev)
+{
+	u32 vfm = IFM(x86_family(sig->sig), x86_model(sig->sig));
+
+	/*
+	 * Erratum GNR98 can cause #MC's if "jumping over" revision 0x1000405.
+	 * Avoid the jumps.
+	 */
+	if (vfm == INTEL_GRANITERAPIDS_X &&
+	    x86_stepping(sig->sig) == 1 &&
+	    sig->pf & 0x95 &&
+	    sig->rev < 0x1000405 &&
+	    rev > 0x1000405) {
+		pr_err_once("Erratum GNR98: skipping revision 0x%x.\n", rev);
+		return false;
+	}
+
+	return true;
+}
+
 /* Scan blob for microcode matching the boot CPUs family, model, stepping */
 static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 						     struct ucode_cpu_info *uci,
@@ -330,6 +350,9 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 		if (!intel_find_matching_signature(data, &uci->cpu_sig))
 			continue;
 
+		if (!revision_is_safe(&uci->cpu_sig, mc_header->rev))
+			continue;
+
 		/*
 		 * For saving the early microcode, find the matching revision which
 		 * was loaded on the BSP.
@@ -878,6 +901,9 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 		if (!intel_find_matching_signature(mc, &uci->cpu_sig))
 			continue;
 
+		if (!revision_is_safe(&uci->cpu_sig, mc_header.rev))
+			continue;
+
 		is_safe = ucode_validate_minrev(&mc_header);
 		if (force_minrev && !is_safe)
 			continue;
-- 
2.53.0

