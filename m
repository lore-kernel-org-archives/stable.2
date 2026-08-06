Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818034582D5;
	Thu,  6 Aug 2026 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026105; cv=none; b=aH9N/pvMkTnABogWfaJb9x5pqeWbdsj0AV+N8DTuW4HobZOzpcwa1Z5F+YyS6vvF3W8fky5kTttUPHusEoKbmTvaDNxr6WPHTF7nDkXP37CGdzuU983mKA1Mqv+0NnGgj7nNHfeFTGhgxLIgkER2pfZFJBXZM0Pkh9FZjBYGAlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026105; c=relaxed/simple;
	bh=lGogclej7gRctnbuSY/T9WV3eK1poOJYqwXSILSbraY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEQUpSEsHdIL4kveMEeIKUX8Sx0oSCnTOd/uDYLsuNt0oepeOOSxQOTTg0I5786Ge6pEZY6KP3T+CXxnaxLm0ibs84RcSf7PCA2MZTkHNV2QLBTTD4lLdQoZw1R6ipEQXi8wAfLzOu4H1UbBJiirtjEPCV2NFtNrL8eX4TztwME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGVTQG4f; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGVTQG4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786026103; x=1817562103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lGogclej7gRctnbuSY/T9WV3eK1poOJYqwXSILSbraY=;
  b=nGVTQG4fBwpPhlriU4WnRTwmxy6VfbhefaefURmONKM50YOQv+bTvwWs
   Y/xhF+rg1+66ASAm9nQYMlhXYF4YGP+soUh59DZtixLx1Pcm8hNVmfpJz
   uvD1N+Ru52XCXAF8rFTH+vIYFDNgia2pwHlN++ZEP2TWguqptcMVVhYP9
   0OKcEDJxWgcAL0N/R70C/WtLIAUDcWUN7A/v3Zyvm8d5NGvDDkkA+UIxv
   1V7QL4f1i7g+FOHIWuHl3sBLmzBXROf1Bb+uL9iHQpjiN2R9TcQ76LYEu
   AtbdNbxm+GgdCvttGiAnS6EUAb4oWYVY9GGup2IYOAfzwQQEO01GsppZK
   w==;
X-CSE-ConnectionGUID: M3/75aDaQguDfJ92zzi+Dw==
X-CSE-MsgGUID: 5ugJfKKqSxKNnygdIEzfIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97268167"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="97268167"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:21:39 -0700
X-CSE-ConnectionGUID: 7R1uBYAITPu8QFBJoaXI2w==
X-CSE-MsgGUID: Ah8vJH+sQYSgs8dUWxufmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="285500429"
Received: from amilburn-desk.amilburn-desk (HELO mnyman-desk.home) ([10.245.244.235])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:21:38 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Lucas De Marchi <ldemarchi@nvidia.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 08/17] xhci: dbgtty: Fix unregister on tty_alloc_driver() failure
Date: Thu,  6 Aug 2026 17:21:04 +0300
Message-ID: <20260806142113.2436238-9-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806142113.2436238-1-mathias.nyman@linux.intel.com>
References: <20260806142113.2436238-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas De Marchi <ldemarchi@nvidia.com>

Make sure to set dbc_tty_driver to NULL to match the check in
dbc_tty_exit(). For that, make detached error handling path common to the
other branch in the same function.

Fixes: 4521f1613940 ("xhci: dbctty: split dbc tty driver registration and unregistration functions.")
Cc: stable@vger.kernel.org # v5.10
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lucas De Marchi <ldemarchi@nvidia.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-dbgtty.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 01decd46f313..7e44e62d6ea9 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -628,8 +628,8 @@ int dbc_tty_init(void)
 	dbc_tty_driver = tty_alloc_driver(64, TTY_DRIVER_REAL_RAW |
 					  TTY_DRIVER_DYNAMIC_DEV);
 	if (IS_ERR(dbc_tty_driver)) {
-		idr_destroy(&dbc_tty_minors);
-		return PTR_ERR(dbc_tty_driver);
+		ret = PTR_ERR(dbc_tty_driver);
+		goto fail;
 	}
 
 	dbc_tty_driver->driver_name = "dbc_serial";
@@ -649,11 +649,17 @@ int dbc_tty_init(void)
 	ret = tty_register_driver(dbc_tty_driver);
 	if (ret) {
 		pr_err("Can't register dbc tty driver\n");
-		tty_driver_kref_put(dbc_tty_driver);
-		idr_destroy(&dbc_tty_minors);
-		dbc_tty_driver = NULL;
+		goto fail_put;
 	}
 
+	return ret;
+
+fail_put:
+	tty_driver_kref_put(dbc_tty_driver);
+fail:
+	idr_destroy(&dbc_tty_minors);
+	dbc_tty_driver = NULL;
+
 	return ret;
 }
 
-- 
2.43.0

