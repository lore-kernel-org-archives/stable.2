Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283845DF6B;
	Wed,  5 Aug 2026 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932931; cv=none; b=Fq1GQL+cPtbcLmi21bJjLBwvMjYE2bPOjmL3iIOBfqnFwjj9DUAMhLqAyV3DwJGznNxHnVk5BDw+RE/7KtUHU8Mqu/9Z5VhPnfWX2u4pWyEmpoDSRkwJZa6zF8h+Ni2Oyji3u4s78zkArCXDgZxEZx+uYC3sfVZSq6Tr502PBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932931; c=relaxed/simple;
	bh=7chqYAWwczHNTyuBKJsnb7+C6GAbm2IhaxI58Ywl5/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRTNdacTLtZC4kR4bOGTFHIFShBz/UNn6x3QFhK1v6fmNcyXjNHWq6fFuownsvdHBHOd4e2ZpAb/13HCaY4aT9QixazmwFTwjHBaPzeTOsdLOMy1+GiMplPtHsXgcT/uGoAkjpPDz2wpfi4T1slXHJDP87Nqfo8miJwK/R57+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ztkv31Wk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ztkv31Wk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785932931; x=1817468931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7chqYAWwczHNTyuBKJsnb7+C6GAbm2IhaxI58Ywl5/U=;
  b=Ztkv31Wk4++bB3R9JktYLZElxJg3og1r1j0ecFmCwBVmuYnv5iD+NRWa
   mkSGcAX8mT92N318iFlA6QlLOttoy1Gr/8+9L5884vxRJBV6IGv/YqhBJ
   EJlPtzYvO9HH66kCvK4TO0tgFisUkH2pdiNCc0NQwDZPDivVAhRxQuby+
   GXXM5c9ytCqIQDClTDJ0KPM8GYFpNiOGOakm+GPvMYkEaCdpPP4MvBfKK
   A5a/HgfC397lHhWYFqf+hpJZm9Rn1aUW54UWSBap85UCmHWMrlySsKdbP
   a78IaFY//R6sihhxRjsLGCQ7QVzUmJPgD5FhLQ9OEwvpYL9ls/sP2YrxY
   Q==;
X-CSE-ConnectionGUID: hvQ+ifzuRjG6HpYGkbuKcA==
X-CSE-MsgGUID: 7KF93zJUTWSN79s4qSwYkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86706858"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86706858"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:42 -0700
X-CSE-ConnectionGUID: Fq1M5UteQsStVdZqsVAhBQ==
X-CSE-MsgGUID: rSaptBnOT9elxnmcdHj5ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="285165315"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:40 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/4] ASoC: max9860: sort the register default table
Date: Wed,  5 Aug 2026 15:28:10 +0300
Message-ID: <20260805122811.13713-4-peter.ujfalusi@linux.intel.com>
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

MAX9860_PWRMAN (0x10) is listed as the first entry, before
MAX9860_INTEN (0x02), which makes MAX9860_INTEN unreachable.
regcache_reg_needs_sync() then cannot compare it against its default and
reports that a sync is needed, so it is written to the device on every
regcache_sync() even when it was never touched.

Sort the table by register address.

Fixes: 3b2af7f79968 ("ASoC: max9860: new driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/max9860.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 0d7ac37850bb..20e288e38669 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -48,7 +48,6 @@ static int max9860_dvddio_event(struct notifier_block *nb,
 }
 
 static const struct reg_default max9860_reg_defaults[] = {
-	{ MAX9860_PWRMAN,       0x00 },
 	{ MAX9860_INTEN,        0x00 },
 	{ MAX9860_SYSCLK,       0x00 },
 	{ MAX9860_AUDIOCLKHIGH, 0x00 },
@@ -62,6 +61,7 @@ static const struct reg_default max9860_reg_defaults[] = {
 	{ MAX9860_MICGAIN,      0x00 },
 	{ MAX9860_MICADC,       0x00 },
 	{ MAX9860_NOISEGATE,    0x00 },
+	{ MAX9860_PWRMAN,       0x00 },
 };
 
 static bool max9860_readable(struct device *dev, unsigned int reg)
-- 
2.55.0

