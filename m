Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849212;
	b=lp8WLcc+xQk3D5hSqQPToF0UJPUkBC22hOvLDE/q1Bur43kROpVmAK/9KuySvsbNJ/sF
	 3elhn4h3Jzk8rLj+a2Fmqph1qdfeRQ1yCIkcD2De2vkvtsPFSsRnSyvD1Nl0JHczBerkx
	 lc5sJY+5p9aDwMrBW53fdGhRClypLp5zWki9szbXnhD6wqZx+4cRvTjyVCtrgzdiBc6iq
	 eRdcgCGxcMRZxTDlrAPLUFDsncq9ZlEKr3snBicLKBY4Q7kQmgT8onJ7XWuc1C7z8lv/Y
	 eMt94neHa72Wr7sNcfBS4hlseSZ7Ss90kTVtuockNiq1vu5N/Q+eXmPE3ChgWe350Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849212;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RWp05zSuTLckD2XbGOUgcRGftb3tKX5HGB2WfcRVBcU=;
	b=D/HyHkzruuM9UNvCZ0PL+hq1TAUBuAtS/H8zK/KVUFJV2B0yQIRWR6whxmr6RkV0lmgU
	 bCq//WcKSdVvwS1hFMLzwIsi+2fYXfxPNRZr6N1/1VoenG7c3BCz2H75hkeoZY4Yvm6gY
	 SPUxm1a5x+rGAgu0djI7mSXboBBhXprXRhLDC+H7fBUFg4/66LzTuaq3agXdHGxzON3LW
	 REbrJatG8cNDUKzWP1nOMm7FIs0d8ZbGtx1QHx9VUvlbKM4sO8vGsJV2FzkBADmM43A7Y
	 rXK45TrmdhnM3J0JNdnrnynxnU/Zn7PIbdQSVuvYLOFkaAaKQ84TYZwmpFYQfA3uFLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AcJzGFZF;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C8606A88D;
	Mon, 16 Nov 2026 17:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 574C8606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AcJzGFZF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794849206; x=1826385206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ufd7VHhRdJ8Z2xXLnwdABLAsG/JTa8YUbM9noHPQpLY=;
  b=AcJzGFZFSWL/JKD1LMslq2rihP1GCzWI494Uei/WVJ4lyFyQ80fVsgXo
   pRczrtAcjWJmmQU9D+N4tTa1Ub0D+AGyvGBScUSirBOVZR7jmQRFJCn2i
   04vhnu5mX51MQF8RXhDR83O1rMghNyk3lZ+wsABNMwSX2gT4lCqJ2ZkCg
   pmAldHfRQl7asFwNs3Yj4LqlA+FPo6QaF59R8F4coraOQKZxbnR10bQB8
   zpjuWlCQvyfmwB7qiVaMxmVq6R8qHnbKnYhh0Osy6jyjAGxwE3MXGVMQH
   aqMPH4/utI6penBvfyGUuyQppefOLGQixY8fjtkbPhLhDjuHoZY1AiLyl
   g==;
X-CSE-ConnectionGUID: MsFYJEKnRfmauC2QkMgXGQ==
X-CSE-MsgGUID: kyUc3FO7RZqVk44aqrAQ1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3627185"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3627185"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 09:13:25 -0800
X-CSE-ConnectionGUID: 0t6ZuwbOQzuU/beobJHwHw==
X-CSE-MsgGUID: 5ruZVBGBQ72y82jBdtgjgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9491505"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 16 Nov 2026 09:13:19 -0800
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
Subject: [PATCH v2 1/7] x86/microcode: Avoid spurious base_rev= match
Date: Mon, 16 Nov 2026 16:45:42 +0000
Message-ID: <20261116164548.900486-2-chang.seok.bae@intel.com>
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

After base_rev= has been parsed, the remainder of the token is still
compared against the other option names. Along with this, the substring
check strstr() may also produce a spurious match.

Move on to the next token once the option has been parsed, and use
str_has_prefix() instead.

Fixes: 43181a47263d ("x86/microcode: Add microcode loader debugging functionality")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: <stable@vger.kernel.org>
---
V1 -> V2: Clarify the subject
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

