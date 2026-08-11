Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53094248A5;
	Tue, 11 Aug 2026 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486529; cv=none; b=E2SrLBqk3OcqtkS1u1XgooA6CEz443L6nafLm4sMZZhA3nVvgTKRg1B4plaihnulW2ePC6GEkYgxdeOe8FVOGb30nlpyKUXD9FnLOE16xPTFISG68LuQa4ZzLxXuJa+aJrlZgcEbM2Q+2bXGeEfaW3lQJOOBjG8unbiUec44bVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486529; c=relaxed/simple;
	bh=+Z5PrPij/vJLl7b55IH12036cCYoVOXTzcAKG7vSSTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG2ZpwXGwXo5G+GHSbmdki31jZ55m+IiVw37ChOJuJ/7oVwsV7i39FABQy3sHdnDvUusJDuB4cdMKrQYoTvm138N3bKMzq4IggRcMpk/zGJL4Zvl6IEizPF8fbYIizP2NtLGsUxJ27slCZphROMlTchFepFv5nBzvPn5dgMR/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClgtwQs+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClgtwQs+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786486527; x=1818022527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Z5PrPij/vJLl7b55IH12036cCYoVOXTzcAKG7vSSTk=;
  b=ClgtwQs+cz8PCXrc8E/kGFZGgSOhJAVYPDvwn4leSPAAlTODOISMPLRu
   7KwHzR/jTL6Y1v6qEWJfsIwfDZo+ql6e2LU3AtCxNTwEIFVVjUkwPokIN
   dyKpFVJfrCtsjkqVlHdGba7QAyZyQ7oNWcCZ9kauq4rO7KfQ97mRdR0i7
   n9bOcLIiw7XJSmhPx1sUJ+wZsR0uKWDWwCsRSuDIq1sZnPvANX9GEbn3w
   o/u2YSQvEJMbkdspwhXLTJvPAvEteCC6X36bckeMp5x0GbDFFmORqOF7M
   njnHCZ5AzbUV5Vc8Vvt3q7gUVc84xBE8R3SfmLOON77Q6yoaIHpDlI1sb
   g==;
X-CSE-ConnectionGUID: GLuS2PJxRPKSrZ75XlR1Qw==
X-CSE-MsgGUID: A3HlSZc1QFSa6+lR9YNNAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97374775"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="97374775"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 15:15:25 -0700
X-CSE-ConnectionGUID: 4jTF4Na4QZuYzC3ebNgjBg==
X-CSE-MsgGUID: aWKbrJVJTeGag199POGvQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="262138181"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2026 15:15:25 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sammiee5311@gmail.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/6] platform/x86: ISST: Validate max level for set feature
Date: Tue, 11 Aug 2026 15:15:10 -0700
Message-ID: <20260811221514.3905817-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811221514.3905817-1-srinivas.pandruvada@linux.intel.com>
References: <20260811221514.3905817-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate the level before setting, so that it fails early instead of
failing later when checking the bit mask for allowed levels.

Fixes: ea009e4769fa3 ("platform/x86: ISST: Add SST-PP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index a5ab3be92afa..7be50d4167be 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -947,6 +947,9 @@ static int isst_if_set_perf_level(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (perf_level.level > power_domain_info->max_level)
+		return -EINVAL;
+
 	if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-- 
2.53.0

