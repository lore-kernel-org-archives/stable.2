Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849218;
	b=pW4XpaeEZ5OvLUiM4AG5GpHhnSVBFT+RBNHWU7HnSKkhW++3znN0K1xbUVGBsNoZW7K3
	 L5MRRN8kFXcOq7PZsYY0bW9zZC0PBeB0/1F13NOB4tXZ2wLBbQJ5MM7ZUsCJ1xKvQZpn7
	 fPKAbHlfpQWWurt+6VwkA38Y9WAAnp2RSn0e6mHKw+tfUffiKQtlNcftG8ckvcUy39IbH
	 natxylMenhSEgUElyOkRr/iWAcmj4WbVrhFn5zF/sNF3V4kOR/vrtkm+qv8sFUsemODQj
	 iRhWoBDmS3+YC+FK3aFubkhFIOQ7EAyMGJcHwiPBr9WZxG2JeWZ8/Q1LivdcfS0KYzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849218;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=shD7TQdyrY//KXAdRt3/QqtehaN+j47EiX/0lzmZT5U=;
	b=tcsXtrI5SGtblLJUKzb/ThP6aDnS3VOb+BTIzfS9FnBEnzNFXEuUZphVhxA7fMitY+sq
	 rtBklGHHqOXGwKuW1vfwNvd4p9h3BUEOLwNgNAFbtaCSvpOEVhs4I8aUiUURBWWteCewo
	 awv3dv2PTh13FGSIKjh8LBFeJdeina6gY/iuTpyE9png4o3F4mtjM49gQKlloWmpqAS4t
	 wcjFjaxTP8szkTvMAva6G4e6WX9YlzC+zjD+Sih265WB4EGob8nDsriey7/57KMNm88nJ
	 R3ebqmqN+cUHMoA4JUXgl0LkQRJPr9MzoRojKcuFodgoYytNllUh4wYPkcTDGZdLl3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h1oJ5A2Z;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A7606A898;
	Mon, 16 Nov 2026 17:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 775A7606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h1oJ5A2Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794849208; x=1826385208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IVUb/8UhGxzbrGpp745Xo4gWp3uac57uzqgfFoMYaXI=;
  b=h1oJ5A2Z1FvNhKjioEBFMgwhQj4vnjKmhDJZ7o8mYVkQlY8+X8WdZlmV
   ZtpWisdUEncjKseZYT9qdIG0Ts/c57bc9ZSf+RdDZkqpTLy5LdxXm8zdf
   3HoK6l/oxsgKtOZPybI60gWQm5vEwFAwLRJwCukq7+568b8e2gB++lMIV
   MclU/BGEodIGmCLBfNDjKceirCe5FWYS90BZWjNrZdootqffGWvKRYzTN
   7/zC3MfXYUSP80FjzCsotWEIfu7nFxETqJtxrNAX3tSV/mqS02pbT/RMW
   2Fq/gSGuEKcp12bj9xET4xOHW5dOCWqUM55rI3z/GmckAK11bFOTPCfJc
   Q==;
X-CSE-ConnectionGUID: vkysCGrsRK+JESH5PjeqDw==
X-CSE-MsgGUID: rUl53sZbRG+TJNP/urC1JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3627196"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3627196"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 09:13:25 -0800
X-CSE-ConnectionGUID: je074InHSo2mkxa9dg+EJA==
X-CSE-MsgGUID: 4mXQyoDBSvetiYZPm3j2YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9491511"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 16 Nov 2026 09:13:22 -0800
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
Subject: [PATCH v2 2/7] x86/microcode: Accept a boolean for force_minrev parameter
Date: Mon, 16 Nov 2026 16:45:43 +0000
Message-ID: <20261116164548.900486-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116164548.900486-1-chang.seok.bae@intel.com>
References: <20261116164548.900486-1-chang.seok.bae@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
index 0b3c140babd9..a6d50cf6435c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4086,9 +4086,10 @@ Kernel parameters
 
 			dis_ucode_ldr: disable the microcode loader
 
-			force_minrev:
-			Enable or disable the microcode minimal revision
-			enforcement for the runtime microcode loader.
+			force_minrev[=<bool>]:
+			Enable or disable microcode minimal revision enforcement
+			for the runtime microcode loader according to <bool>. If
+			<bool> is not given, enable the enforcement.
 
 	mitigations=
 			[X86,PPC,S390,ARM64,EARLY] Control optional mitigations for
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

