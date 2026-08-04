Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32065225791;
	Tue,  4 Aug 2026 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812646; cv=none; b=WkY+ke4vRLrU3HmEp6WfZeTmJopk0CiOJysQIqbj/XwMlEnRu42Mm9WZilYbM6PW0Pq/dHTMdrduGtouFBF3tkTWX2W2K/9D4SLbntaBrBwKRE7diASTewLTBF11WFlV+1Gwoqa9mUGHYl/BXytBnbcYAKKQazifd1nGndDxUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812646; c=relaxed/simple;
	bh=j5qtUy7ODOvKHcirpmDeYnhjzJKBSG80aSpIZBvYENg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZgre0fyLmcI8VrN1CmaEYCEwMz3a/OGgyhG+tcNVc+PnV0WTVmEGdlqEAFy+BHky5+4xUeabb++A6qQsPVkmXdCYVEGGFQWpXRPICBh9YWHTh1d8dEnt5FgaILNll4Mv+jJNsgV5ooTjiFHRJ7rLkIvamPC2JXQEe5sFx5h+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6AWTy0Y; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6AWTy0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785812646; x=1817348646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j5qtUy7ODOvKHcirpmDeYnhjzJKBSG80aSpIZBvYENg=;
  b=L6AWTy0YbwUv0BQZv8i4d9O0lAHOmCT68Qqn63Z0J7gIF/y81lAtBaQA
   f38Jop9mfApz1xqIe6u8c3ds9F8zebAVkz8SdtbkdFY78cM7plCW6iX9s
   8RDMGwNq2rbAcinB2n2BqYgHybofEbaublEQ0PdEMrxP8FwG6DCcC/dRU
   EsCb0W1TbH7hApfB+0Ml7mKAmzmAbqcjKvkGCFs5hnceQAqO1MRSsa/jU
   MO4x3liKtcRSt2ctzsbHBY0+1EKCogRR9w0ONLytu5Kx/a9jezzEnrE0H
   8vUftBwxS3HZpJ63whZu+Cp+fzUXtDOq0EsxgpSf48qw2grSbrcasO5o3
   A==;
X-CSE-ConnectionGUID: Wg9rs6mVQf2HlYxddJgmUQ==
X-CSE-MsgGUID: 6jcPh63NTvOtvkNWsbgSvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103759432"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="103759432"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 20:04:06 -0700
X-CSE-ConnectionGUID: M82TH8EDTGWddIhK2wQ5UQ==
X-CSE-MsgGUID: Q2Hn4vrmSgaE3PgIVBIyFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="260139984"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 20:04:03 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>,
	stable@vger.kernel.org,
	Junjie Cao <junjie.cao@linux.dev>
Subject: [PATCH v3 3/3] backlight: aw99706: Honor the core blank state in update_status()
Date: Tue,  4 Aug 2026 11:02:55 +0800
Message-ID: <20260804030255.1934470-4-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804030255.1934470-1-junjie.cao@intel.com>
References: <20260804030255.1934470-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junjie Cao <junjie.cao@linux.dev>

update_status() passes props.brightness straight to the hardware and
ignores the power/blank state tracked by the core. Writing 4 to the
bl_power sysfs attribute or blanking the framebuffer therefore leaves
the backlight lit.

Use backlight_get_brightness(), which returns 0 while the device is
blanked.

Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
Cc: stable@vger.kernel.org
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 drivers/video/backlight/aw99706.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index 6ec49b6cb14c..c4a66b59ecf1 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -340,7 +340,7 @@ static int aw99706_bl_update_status(struct backlight_device *bl)
 {
 	struct aw99706_device *aw = bl_get_data(bl);
 
-	return aw99706_update_brightness(aw, bl->props.brightness);
+	return aw99706_update_brightness(aw, backlight_get_brightness(bl));
 }
 
 static const struct backlight_ops aw99706_bl_ops = {
-- 
2.43.0

