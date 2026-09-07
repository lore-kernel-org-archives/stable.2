Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB23F107F
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 04:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753753; cv=none; b=bdEW8umLb3gm/T/mUk1/IkMdCHky4j5QvYxkvhqsCmFjfqb/5l9ALzz9aea5uyzy9xylPRXQ6ms5uWyvKmDXdyUSyIwChfzrPYhZoOL8hIVJVTJAzn+ThmF3auJjXSAwzcpZBj/Al4u14rZbus1zUtEvlpDbtl4J/lxuyce1C5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753753; c=relaxed/simple;
	bh=FwQfEMYNPRIrcwaFprMgtujfRrZMCC7ioLNPaqd6GGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HwazL6lvxll4mU91xjbHoQXAkulWgd94wToiI/XdhPIxjLOya5sy567w5SFdnU1H3HD6qPHQR7rWw8T5lITnuDmWGfmiqdKyArbeLUyPJQfFN81O+YcM0C9C++j9chrWwCfjrMOFkqVLL217/sPnUpi+F39sQ6olF4sOedwxhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMTV1TfX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMTV1TfX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788753751; x=1820289751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FwQfEMYNPRIrcwaFprMgtujfRrZMCC7ioLNPaqd6GGs=;
  b=jMTV1TfXjP2BC15/zwApGflEq9GqY2neEKM0/Gwg/4jVLEPQuuwVgkSU
   QDupOgY6XgJ7CA7VNkLARIwMJkHjaEzEas9yFvPxEYIi5K09F6GPpjG7e
   igs+P/FuqUwXZQenC484nj7gxido37DgjRJBzgJe+dyiMxCar6S6SiKD9
   tRvO4wX6uR4zMI0QUVIhMFEVspFGvLIu6/SEzUG/MsFUqTpYzjovEPJUl
   RVNrPDz+QedApcsfYqmd8owwIsi+EMyEBLDJhbD5CdEaFDtcwtFOcjnoj
   sjL3XrhYfBFH4VHbI20mtf8uPrhjVqe8MVujAN3vCDGzsz0HCSDy2j9dd
   w==;
X-CSE-ConnectionGUID: F4pG4RNZROemhbg1ux9D+Q==
X-CSE-MsgGUID: OhrULDyTRI2WLpfyUVUe0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="88912605"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="88912605"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 21:02:30 -0700
X-CSE-ConnectionGUID: qfvQWliNQQicJyEIThJ8tg==
X-CSE-MsgGUID: hESR8OqHQFuQilmnrl/Y6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="268857555"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 21:02:28 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com,
	ville.syrjala@linux.intel.com,
	annoycc@gmail.com,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus 14-ew1
Date: Mon,  7 Sep 2026 09:15:55 +0530
Message-ID: <20260907034555.2753846-1-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The eDP panel on the HP Pavilion Plus Laptop 14-ew1xxx advertises HBR3
while leaving the TPS4 support bit clear. The output however flickers, once
link is trained with HBR3.

Until commit 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink
doesn't support TPS4"") such sinks were capped at HBR2 by the TPS4 check
which incidentally kept this panel stable. That check was reverted because
other panels legitimately need HBR3 without advertising TPS4, and the
per-machine QUIRK_EDP_LIMIT_RATE_HBR2 was introduced to handle the affected
machines instead.

Add the machine to the list of devices that need the
QUIRK_EDP_LIMIT_RATE_HBR2.

Fixes: 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink doesn't support TPS4"")
Reported-by: Annoy Cc <annoycc@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16743
Cc: <stable@vger.kernel.org> # v6.18+
Tested-by: Annoy Cc <annoycc@gmail.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 33245f44c0d5..7d7db774d8c7 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -257,6 +257,9 @@ static struct intel_quirk intel_quirks[] = {
 	/* Dell XPS 13 7390 2-in-1 */
 	{ 0x8a52, 0x1028, 0x08b0, quirk_edp_limit_rate_hbr2 },
 
+	/* HP Pavilion Plus Laptop 14-ew1xxx */
+	{ 0x7d55, 0x103c, 0x8c31, quirk_edp_limit_rate_hbr2 },
+
 	/* Xiaomi Book Pro 14 2026 */
 	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },
 };
-- 
2.50.1

