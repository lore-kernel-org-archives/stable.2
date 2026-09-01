Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B6473C65;
	Tue,  1 Sep 2026 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306200; cv=none; b=CwlNRlltTZ14Gj5pyqSyR1db2uM7Yv7otrhY495Zt/TAdqQa+3RPqhGe4AdFdyACdNSpf1fVjiwN6J8v6MUqW5Wxt16Z19ngR0ZGitCVI1oCz8E9dB3ghCErHYb8cfYBAJEKJsmzFpNKniMgzTijnqPack6xdstzFADeEigO0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306200; c=relaxed/simple;
	bh=f3hDoqQQZ6E3UtV7iDJbCgMiPOrej6NW5ioW9NE92Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmEh00P+Osaw0kBKSSm3fWnpUPAOlLHUbZOFHoFVYwpmgUMZ++/dF/kM2/yao+2yAn+YygeurMGCxMaRmng0m2QPBiz0KFuu0p4Kho/+YhJInLm2sr1Rf1KzPFP3Rg0GKNCH+Xo5r+wI6/O5bEe6Ukj72l5c1xgUGPNHdBH18Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCbR7LTi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCbR7LTi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788306199; x=1819842199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f3hDoqQQZ6E3UtV7iDJbCgMiPOrej6NW5ioW9NE92Ts=;
  b=QCbR7LTiM/AeCXuLwCYcMU7UG43jGYca1TjbTCFLTfLIhWh8GZKQjvl9
   iPtaupF3V5oomSGHOTTZQw6KDkZFRRQ2XrsGY5cq31um9GwS/j1LVPRk1
   NMaNiIXAkWIvzq7UHS+6Ok9etyZfOsUMubDIP5XfQZ6Ga9gdMZECnwuTl
   cpgDyYtrUT1Nb1ev7bE0KzP3HzVFO0BgG6ppsrr4NCJFUrwmRhaou6oR1
   CByT2KwvFT42CdDJ/1f8JvM2mUjrfeAWdw87T7FgIZheE3j9TFvZYNerf
   8suMjlrQfngvclsbL6Cm3VCtzXWy4+xkf1nEsFjyLJaivC8mmB55sss8c
   g==;
X-CSE-ConnectionGUID: PpeKUv6eQgGtzbca+tiGQA==
X-CSE-MsgGUID: 0Va/iHw7QX+p8Pdgt/1Dpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87891871"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="87891871"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 16:43:18 -0700
X-CSE-ConnectionGUID: VP+xokYwTAu9n0eLool9xQ==
X-CSE-MsgGUID: mGJXpxTRQs6rVyAjOyL2yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="267469882"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa006.jf.intel.com with ESMTP; 01 Sep 2026 16:43:18 -0700
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
Subject: [PATCH 2/8] x86/microcode: Solidify base_rev= option parsing
Date: Tue,  1 Sep 2026 23:16:27 +0000
Message-ID: <20260901231634.714144-3-chang.seok.bae@intel.com>
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

After base_rev= has been parsed, the remainder of the token is still
compared against the other option names. Along with this, the substring
check strstr() may also produce a spurious match.

Move on to the next token once the option has been parsed, and use
str_has_prefix() instead.

Fixes: 43181a47263d ("x86/microcode: Add microcode loader debugging functionality")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: <stable@vger.kernel.org>
---
 arch/x86/kernel/cpu/microcode/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 0dd0c7241c57..303b0d0b4573 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -146,10 +146,11 @@ static void __init early_parse_cmdline(void)
 	if (cmdline_find_option(boot_command_line, "microcode", cmd_buf, sizeof(cmd_buf)) > 0) {
 		while ((s = strsep(&p, ","))) {
 			if (IS_ENABLED(CONFIG_MICROCODE_DBG)) {
-				if (strstr(s, "base_rev=")) {
+				if (str_has_prefix(s, "base_rev=")) {
 					/* advance to the option arg */
 					strsep(&s, "=");
 					if (kstrtouint(s, 16, &base_rev)) { ; }
+					continue;
 				}
 			}
 
-- 
2.53.0

