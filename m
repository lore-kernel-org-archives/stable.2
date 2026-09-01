Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D647B43E;
	Tue,  1 Sep 2026 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306203; cv=none; b=btoh+KIWUiiLTi4oFhdyaqRH1AgSH2mYMGNlnWcxBgh5YYgyUBwHkXD567PJYCAhgf3n++twtf5GaoRDiOaqoWdCLZNEOsqruHIlsNfsNSEePTcaJ7ru021J7ZARlL3iSAaZTqaE4MhqvU59sUm/c8shhmmrnydNY1mUyxN28Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306203; c=relaxed/simple;
	bh=qgjMoEhsz5XWG3TKtELCp4LZvgsKE9DAoHw3iYFjrDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHzkYyISsb1Dtftr7i7x2mIdIQTkit158z6XaphM0BIIxnCKrB3uX+VdAM3UTkAZUBTB3hqa0XUk1ApmR6tZh1AikXd+NuRFaGT30/IWShtic2tGE6C62lhkC2Pcxkd300YyZCQsqMSJ2z2a3irtourGsZ4szegir+6dJQTok20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Im3L93Mf; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Im3L93Mf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788306201; x=1819842201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qgjMoEhsz5XWG3TKtELCp4LZvgsKE9DAoHw3iYFjrDo=;
  b=Im3L93MfrvOyGmyAYQ8EWkxUrcNt0e0h9cb0iNuYXYvdOhWyZCA/tdMx
   inz+TJFDfBKQOxRhLOoqEjSA5ZzM9F/rik/FaXnPfEzDCwqN9XCDUhA3K
   +9mh4iReDIYpMAzQ0cBupybc//s4yaH230TwjaqFduJrg6VNHEF/mcsPS
   JAEFILe/EIJFm/kcLZJc/V0MKiqc3sMgGTv5LltQPfKIWNShS6o7F91Kg
   zLeDINLYo0DKbU9HUlSk2yDSkAf08jHLJTxxs+4fP5c5sbtNhKIg5Eb8k
   rcU8vJvfRVXTtYCXeOp0/2bo4ALzmuX9iYdGUtoIeBv7EURLhFKZaPOmu
   A==;
X-CSE-ConnectionGUID: zgXkM91YRg+89K04sZ8Y5g==
X-CSE-MsgGUID: VqT+TzAZTCSZLS7PSMzSTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87891878"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="87891878"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 16:43:21 -0700
X-CSE-ConnectionGUID: NjCiAyMaTWq/6V1lKCJ5yQ==
X-CSE-MsgGUID: Tg9RllEtTxeDxcw9RVntig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="267469888"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa006.jf.intel.com with ESMTP; 01 Sep 2026 16:43:21 -0700
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
	Sohil Mehta <sohil.mehta@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/8] x86/microcode: Accept a boolean for force_minrev parameter
Date: Tue,  1 Sep 2026 23:16:28 +0000
Message-ID: <20260901231634.714144-4-chang.seok.bae@intel.com>
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

The microcode= command-line option allows controlling all microcode
loading options. However, force_minrev can only enable minimum revision
enforcement, not disable it.

The previous microcode.force_minrev= option accepted both boolean values,
and the current behavior differs from the documentation in
kernel-parameters.txt.

Add `force_minrev=` as a sub-option to explicitly enable or disable the
minimum revision enforcement. Update the documentation accordingly.

While doing so, wrap strsep() in a descriptively named helper.

Fixes: 632ff6170647 ("x86/microcode: Add microcode= cmdline parsing")
Reported-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: <stable@vger.kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 ++++---
 arch/x86/kernel/cpu/microcode/core.c            | 15 ++++++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..cde092017cd8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4071,9 +4071,10 @@ Kernel parameters
 
 			dis_ucode_ldr: disable the microcode loader
 
-			force_minrev:
-			Enable or disable the microcode minimal revision
-			enforcement for the runtime microcode loader.
+			force_minrev[=<bool>]:
+			Enable or disable microcode minimal revision enforcement
+			for the runtime microcode loader according to <bool>. If
+			<bool> is not given, enable the enforcement.
 
 	mini2440=	[ARM,HW,KNL]
 			Format:[0..2][b][c][t]
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 303b0d0b4573..af7196d94540 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -138,6 +138,11 @@ bool __init microcode_loader_disabled(void)
 	return dis_ucode_ldr;
 }
 
+static inline void advance_option_argument(char **s)
+{
+	strsep(s, "=");
+}
+
 static void __init early_parse_cmdline(void)
 {
 	char cmd_buf[64] = {};
@@ -147,15 +152,19 @@ static void __init early_parse_cmdline(void)
 		while ((s = strsep(&p, ","))) {
 			if (IS_ENABLED(CONFIG_MICROCODE_DBG)) {
 				if (str_has_prefix(s, "base_rev=")) {
-					/* advance to the option arg */
-					strsep(&s, "=");
+					advance_option_argument(&s);
 					if (kstrtouint(s, 16, &base_rev)) { ; }
 					continue;
 				}
 			}
 
-			if (!strcmp("force_minrev", s))
+			if (!strcmp("force_minrev", s)) {
 				force_minrev = true;
+			} else if (str_has_prefix(s, "force_minrev=")) {
+				advance_option_argument(&s);
+				if (kstrtobool(s, &force_minrev)) { ; }
+				continue;
+			}
 
 			if (!strcmp(s, "dis_ucode_ldr"))
 				dis_ucode_ldr = true;
-- 
2.53.0

