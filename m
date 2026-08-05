Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E5466B13;
	Wed,  5 Aug 2026 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932929; cv=none; b=gOAAZxFgtH8Kln07ZwFytvZkGZzTgEb5fNBXvW6pJogcM38XvlTGipjoT0tDhUZ/WNZdbatCUNbsyOOaEraP5BrtMFCAuEAh7yBJPA60PssX3nRTqd/NFgE6Ki+bvwHmoC6hUCAc/QjJXnOeLdqjuHugvG7FaJk7LEzyhCxiPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932929; c=relaxed/simple;
	bh=uTIPz/qBwW0vW67U7DYrl0QqhTeTjLV78/k5i1PHOQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1I613YKKgAD718F0m60RigHsXCwvR2hhf1m04JrE19eSpN7TE85fZlke3AIEFhSBX0pzzmQji3VWaFTyX7tG3NRBDNYwXZUwYh6Mpxvo0na9HXmsSK7EECAwBZJULz54gGIS6/6yhG7z9acNJZvgJE+a1y+zxhWvrJk3AV43zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R1ZoXI7U; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R1ZoXI7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785932929; x=1817468929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uTIPz/qBwW0vW67U7DYrl0QqhTeTjLV78/k5i1PHOQg=;
  b=R1ZoXI7UBKigwr02szXzgTXc7F+qcjmDSAgOU4DJ05e3ybvu5PVwdxvq
   wSu3v/7+jvwcxUBlV/ycGv3zcGLlwj4T9YtQdkq9LnnLAlnM877yL8Z50
   3QTZcnobX2up2M0fNKFGZ6fcPBH3r9GI3Q7UQ8zR71rcZ2M4OeYl/tUQY
   qlgLpO3N+hUEexusblC/YnquoVMEsTZUz+sTD13tUvWoUFw5Lb4lK6qzd
   zWFOUvHUvnPH4t5fdlD5vYr/f6pRAXHCC5JZ7zz/bkUfW1XNp/7TuPP5S
   edUHBzVN+beN72YTFgUZjexyAQRjwz7ALQpHjLLUPkgUeaMIsGu7rmHnI
   Q==;
X-CSE-ConnectionGUID: W/BXsVh5T86WXYyyNCUwJg==
X-CSE-MsgGUID: cjU3aDEBQNqBTPAi9W6bqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86706848"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86706848"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:39 -0700
X-CSE-ConnectionGUID: WkfbZ+YaRA+MjElp2Q5C4A==
X-CSE-MsgGUID: 40kT9VwDRr6zGOSdU0aHXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="285165310"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:36 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/4] ASoC: ml26124: sort the register default table
Date: Wed,  5 Aug 2026 15:28:08 +0300
Message-ID: <20260805122811.13713-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805122811.13713-1-peter.ujfalusi@linux.intel.com>
References: <20260805122811.13713-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reg_defaults must be sorted by ascending register address, as
regcache_lookup_reg() locates entries in it with bsearch().  See commit
fd80df352ba1 ("regcache: Add support for sorting defaults arrays").

The Mic Select Control register (0xe8) is listed in the analog path
control group, between 0x5a and 0x60, which makes it unreachable.
regcache_reg_needs_sync() then cannot compare it against its default and
reports that a sync is needed, so it is written to the device on every
regcache_sync() even when it was never touched.

Move the entry to the end of the table, where it belongs by address.

Fixes: d808fe9f3e7f ("ASoC: Add LAPIS Semiconductor ML26124 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/ml26124.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index 8a14626d43ff..7209b47c2029 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -224,7 +224,6 @@ static const struct reg_default ml26124_reg[] = {
 	/* Analog Path Control Register */
 	{0x54, 0x00},	/* Speaker AMP Output Control */
 	{0x5a, 0x00},	/* Mic IF Control */
-	{0xe8, 0x01},	/* Mic Select Control */
 
 	/* Audio Interface Control Register */
 	{0x60, 0x00},	/* SAI-Trans Control */
@@ -287,6 +286,9 @@ static const struct reg_default ml26124_reg[] = {
 	{0xd0, 0x01},	/* VIDEO AMP Gain Control */
 	{0xd2, 0x01},	/* VIDEO AMP Setup 1 */
 	{0xd4, 0x01},	/* VIDEO AMP Control2 */
+
+	/* Analog Path Control Register */
+	{0xe8, 0x01},	/* Mic Select Control */
 };
 
 /* Get sampling rate value of sampling rate setting register (0x0) */
-- 
2.55.0

