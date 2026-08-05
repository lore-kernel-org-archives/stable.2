Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F645FFA0;
	Wed,  5 Aug 2026 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932938; cv=none; b=ELVLuT35StvJ6HuQi69pIajIC/nGKlsodsWlm//lP/ynqJfCnSIPHPr+AuNnc+ih3mfHPRX0xWJBpLe+2FVdf3AQWzR5o9rSFuKIyYWTeWWxGeR1slfy4gqorBww4ntbxIX7BP4foUCiKlOq3is78dWwRxnvpf4p9CQkJlsC8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932938; c=relaxed/simple;
	bh=dMwHyV6rY35D/kcPEwSIFnPLaybDP98Pr9sZ7vVYoyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+j7EgBSiGOKuFDFkFca4JTcTM6JJavZ6VAvlj4jrCTCL8QfA/G6Ttr/5w55j5quhi3IAGVE22cBN95eqg579r0ErxpNPaboeAXpofkxHOTqji8B5g6EEKVgoISuOvuTf4jOy4X1pUJd20sM/WHuvXtyFsRTGZVmAy6nbbCc7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J406/MED; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J406/MED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785932938; x=1817468938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dMwHyV6rY35D/kcPEwSIFnPLaybDP98Pr9sZ7vVYoyE=;
  b=J406/MEDRZHJMWm84kXETBQYW5pVkUxqMphjzWwoF5zzo3wx/0f+Qfdi
   IfrbbsLnmaSB+SWp7fnOkQpOOXdVwckjYbmXgNHQ3F4xVZ5WikfYv20Xz
   wkcm2lER0T8R5udmlMcpyFihB+WTRthtXDdinWC7KKSFkfB6eym5+/3GF
   GRJG9781kO4DSAuwdNKka6YKgt7YYqAROYpWWSq7i9KwzLscWJtVoZzvk
   Pn+QUhj3wNTpb1BsKaME5+lD9guljrUm0druPqZV/GsKzmKy++lKayhOY
   Bb715nLeFMIPnK0PdfjdYUM4FY2vOCBAj+D2HDnU/BDjX8uSACmaj7FeW
   Q==;
X-CSE-ConnectionGUID: E7OWmZ/5R92iAWbhQc8QPg==
X-CSE-MsgGUID: sema92p3Tp62yVX6oKIjHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86706871"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86706871"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:44 -0700
X-CSE-ConnectionGUID: p7iFQu4FSDqJYeieNNJc4Q==
X-CSE-MsgGUID: TtTQEeaqQTaXPa77mqDz8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="285165317"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:42 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/4] ASoC: sti-sas: sort the register default table
Date: Wed,  5 Aug 2026 15:28:11 +0300
Message-ID: <20260805122811.13713-5-peter.ujfalusi@linux.intel.com>
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

STIH407_AUDIO_DAC_CTRL (0xa8) is listed before
STIH407_AUDIO_GLUE_CTRL (0xa4), which makes the latter unreachable.
regcache_reg_needs_sync() then cannot compare it against its default and
reports that a sync is needed, so it is written to the device on every
regcache_sync() even when it was never touched.

Sort the table by register address.

Fixes: 165a57a3df02 ("ASoC: sti-sas: clean legacy in sti-sas")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/sti-sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 4ab15be69f3a..b7eaf4795d8b 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -44,8 +44,8 @@ enum {
 };
 
 static const struct reg_default stih407_sas_reg_defaults[] = {
-	{ STIH407_AUDIO_DAC_CTRL, 0x000000000 },
 	{ STIH407_AUDIO_GLUE_CTRL, 0x00000040 },
+	{ STIH407_AUDIO_DAC_CTRL, 0x000000000 },
 };
 
 struct sti_dac_audio {
-- 
2.55.0

