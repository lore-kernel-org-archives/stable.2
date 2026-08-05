Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21EB3DE456;
	Wed,  5 Aug 2026 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920573; cv=none; b=cqRoAWUUqHQiNaXc/p63XaDtfNP7hDMdah+JxeStaNjBZMmcSauze8llKI0H8kasUQOGjVOMJXGLs9DrFKIG1ND0P1CVRN/bzZz3bph3fxQS1CjsxNS19v8qCmRCFPrWxE5mz6HloIshVCzTrMOb3C9wIBUQru8HYbRh67NBQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920573; c=relaxed/simple;
	bh=qMhCSAKFfiAndLVKQP6UQS3BNBu9Vqc65SlpTlRR+IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/W4SetcbRf/ELcARXaRJZzPGSDI3iI2F/sjogX0WPqPaI0xMfFW0SlnWiTFu/hyk4nDPEuJzePA+kR90mBuH2ayNT3kE4CmHpNMZOowsA8bsSAM7p61x21fpYE6blmPlCL3tCj2oAszwez7h4BoXCdgqto4gTLHv4QjXJsszd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6UtHSVt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6UtHSVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920573; x=1817456573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qMhCSAKFfiAndLVKQP6UQS3BNBu9Vqc65SlpTlRR+IQ=;
  b=a6UtHSVt3lt1MbBTTGiMFo78ORAazu6DBpVfhwqLN5jmwgsulscJZee6
   xPm4UJ0ByK2gZ19Q+FfIJqUGYqG4d7BlXEUR5x2wATyrz/xkUBKCAKhpV
   xgk5UY28aTk84Iguwn90+ho/FQIrZgvcQ4soDTiUL0oVpmaHKHk4+HfvJ
   70sRCIM2U+TdRux30aFb5K4mNmMAXqGvrwOmj/T5axiFzXgQB4rnFtXSj
   wY+DjPfCxzXJJ6D01wO5IxSB2ikn6zTiSjNGMa2U8W4wN2LERepYQ4giO
   uB63gYQYfVydROrcIuVutZLypt6u1ibV/LtqoS25TtQZMJFQYd2D1sCjG
   Q==;
X-CSE-ConnectionGUID: qKZPoob/SqeBlD1FE51OrQ==
X-CSE-MsgGUID: Ngg2BVeWTYi6t1Dw6eQfrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842848"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842848"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:53 -0700
X-CSE-ConnectionGUID: mcS0cyWKR2+aYc5czoJt3Q==
X-CSE-MsgGUID: O4UXni1JT2uTbSuq1EFFuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261814160"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:50 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Shuming Fan <shumingf@realtek.com>,
	Jack Yu <jack.yu@realtek.com>,
	Derek Fang <derek.fang@realtek.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 16/17] ASoC: rt1318: sort the register default table
Date: Wed,  5 Aug 2026 12:02:39 +0300
Message-ID: <20260805090240.16991-17-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805090240.16991-1-peter.ujfalusi@linux.intel.com>
References: <20260805090240.16991-1-peter.ujfalusi@linux.intel.com>
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

The 0xdd93 and 0xdd94 entries are listed after 0xddc8 in rt1318_reg[],
which leaves them unreachable for the binary search.
regcache_reg_needs_sync() then cannot compare them against their default
and reports that a sync is needed, so they are written to the device on
every regcache_sync() even when they were never touched.

Sort the table by register address.

Fixes: fe1ff61487ac ("ASoC: rt1318: Add RT1318 audio amplifier driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt1318.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1318.c b/sound/soc/codecs/rt1318.c
index d13fd0e14125..55607f1b9a1e 100644
--- a/sound/soc/codecs/rt1318.c
+++ b/sound/soc/codecs/rt1318.c
@@ -337,6 +337,8 @@ static const struct reg_default rt1318_reg[] = {
 	{ 0xdd08, 0x40 },
 	{ 0xdd12, 0x00 },
 	{ 0xdd35, 0x00 },
+	{ 0xdd93, 0x00 },
+	{ 0xdd94, 0x64 },
 	{ 0xddb5, 0x00 },
 	{ 0xddb6, 0x40 },
 	{ 0xddb7, 0x00 },
@@ -345,8 +347,6 @@ static const struct reg_default rt1318_reg[] = {
 	{ 0xddc6, 0x00 },
 	{ 0xddc7, 0x00 },
 	{ 0xddc8, 0x00 },
-	{ 0xdd93, 0x00 },
-	{ 0xdd94, 0x64 },
 	{ 0xdf00, 0x00 },
 	{ 0xdf5f, 0x00 },
 	{ 0xdf60, 0x00 },
-- 
2.55.0

