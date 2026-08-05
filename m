Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8030F957;
	Wed,  5 Aug 2026 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920539; cv=none; b=n5SIzOeKL6nd7MfNpwLLubpVXNxbDUMU8DapCaIphISIrpqv3nqC5DYzZVVWmFOxofbx8xxyBVxzp10yRCsI/2zwh2sfbS1mAQkH1otp/HbRUmu+9tAHL0qRma3CAqyEgfycJVhv9JGr+6/dndhzwGQvj2RyIzczErDH6EL7eDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920539; c=relaxed/simple;
	bh=Sod7gup8GczBJbkKbU0t8ZXW+L5UhrsdkgiVM5bE/hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vs3XIoyOwSVY7ZDQL/RNw3xEHCHykvVn7XirZO2l1pdh9NmtZF7HCasUPiN+7weZx+Z2RPMGdCNVEKLFAtev7ZIwhMdroHVUy6DhzFuG3n6jvTWjXEbLS3QSHT2NT4Gp0WKBHHlKKca5v8A3YHaaEUhNcvM5icqh4TTjHiMU4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFV/OwsE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFV/OwsE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920538; x=1817456538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sod7gup8GczBJbkKbU0t8ZXW+L5UhrsdkgiVM5bE/hA=;
  b=DFV/OwsEUy1d+iZV1QNL0U2fnlRBu9LeitasiBFcVskBUxbKYUCUyMnv
   tjZ8TUIcowbgi1nhKYw/bA3uCqrFDp4ZECpx8ubHpqD/QUUHZcyIlDYJO
   jcQW52vZxzFiI1+GWcr5eZNnzBd5b4ajLclPZFC0Qr43rBFzK+ST+80gk
   p7LZAt4xgEoxolkCxEao0lRUzvdvV+xFQmmecFc5Ck+os190fXBpWPBKG
   2Ri4swuMgpPlDY/mlrpAcch8e2IEhi7c9FKO9GET/4aApEGBs/T5tvYOU
   R14Z9cfVI0y0n1nWeRwXprbhTy2xyTqGhPOoQj5se00S0kxexBO6XhnK8
   w==;
X-CSE-ConnectionGUID: dcpyEYhmQES5EfFILsjGuQ==
X-CSE-MsgGUID: AD1obX7qQzy88dgCeZbw9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842719"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842719"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:18 -0700
X-CSE-ConnectionGUID: RJ7NaoaxTGiVE3rdwglHfg==
X-CSE-MsgGUID: VvWi943qT6uR3KLv+xZKlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261813975"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:15 -0700
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
Subject: [PATCH 04/17] ASoC: rt700: drop duplicate reg_default entry
Date: Wed,  5 Aug 2026 12:02:27 +0300
Message-ID: <20260805090240.16991-5-peter.ujfalusi@linux.intel.com>
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

rt700_reg_defaults[] lists register 0x7303 twice with the same value.  The
identical rt711 table has the entry only once, so this is a copy-paste
error.

Drop the duplicate.  No functional change, regcache_lookup_reg() only ever
finds one of the two entries.

Fixes: 7d2a5f9ae41e ("ASoC: rt700: add rt700 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt700-sdw.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt700-sdw.h b/sound/soc/codecs/rt700-sdw.h
index 4ad0dcfd16fd..d2e7381d03b8 100644
--- a/sound/soc/codecs/rt700-sdw.h
+++ b/sound/soc/codecs/rt700-sdw.h
@@ -313,7 +313,6 @@ static const struct reg_default rt700_reg_defaults[] = {
 	{ 0x3122, 0x0000 },
 	{ 0x3123, 0x0000 },
 	{ 0x7303, 0x0057 },
-	{ 0x7303, 0x0057 },
 	{ 0x8383, 0x0057 },
 	{ 0x7308, 0x0097 },
 	{ 0x8388, 0x0097 },
-- 
2.55.0

