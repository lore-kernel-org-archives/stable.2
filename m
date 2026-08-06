Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3062447127F;
	Thu,  6 Aug 2026 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026103; cv=none; b=R/InEcJzcHmykK1IyZh/eatvHu78SLhi+SH2crwsRbetuVIJ/VuYrkU8T0xSB2aI7UDbxMefBfPPliZRl8pJqVxHXa4s74jCoKBddNUr5c/ec0TJscU4SZhBcGu37N50xaA7E+2L70DYLhL0yUmZ55BOkmbgMbuSoXkkLXAKMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026103; c=relaxed/simple;
	bh=w3ygO5z5sMqVWRS2GIQ8mTVjSZjqXQbhSxMcMGqmSPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1x7lEV6dHR+wsG5n5Cr3Te+5zTHWA6sh8Jq0G68WnLGCq0vrTu3Oc2PtxhqyJViRYm4xAAzzgJLG2Oq5oh1HIE/D2PeT7pD1/QwYCJP3j88WAG7r3/SGiU+D+WL+3wdRVNA4zm/Cy7cM8cODyzLNOiKLyNItFN8N7CSd766ItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObWo/nCJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObWo/nCJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786026101; x=1817562101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w3ygO5z5sMqVWRS2GIQ8mTVjSZjqXQbhSxMcMGqmSPg=;
  b=ObWo/nCJ9HAtzY3Id2t0i+zFlf3d3iaAMKiTbHmMe3JCTq5sqwi2vr6j
   X/TfDAIP9rhYVXeE86QQ9Ux8NQaGDmTQ38FRwtfOz+i02I427kCxdgT29
   iecdnCpj3j6DGFZZK4D2R9zFRiBoZaMYur01BIrZvAuNYqxWBQwbgZgEB
   mT3vbXeEivZ+pNvt7baT0sv2uR2QMcMJS644HpTKOrcdQz/VWv6Lelorg
   w1DH9iP/oPEummTj5umOA/e2cQy01hPuEBFQqOWyIYztbXavKhCkTYAts
   D9Y/rcHo5iNCbi5hMqhSI18TV6hZJ4LskmSoIA1gFBuhX5r4Cryalomaf
   g==;
X-CSE-ConnectionGUID: eoreGZ0TTIav3rTgwF8IZA==
X-CSE-MsgGUID: JJS7qhYMTaWbK8Is/Fd58g==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97268160"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="97268160"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:21:37 -0700
X-CSE-ConnectionGUID: u0CrnhkYTdKc6rFz5uYjLQ==
X-CSE-MsgGUID: wn92UkvfS7WGI56ATyFfHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="285500419"
Received: from amilburn-desk.amilburn-desk (HELO mnyman-desk.home) ([10.245.244.235])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:21:36 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Lucas De Marchi <ldemarchi@nvidia.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 07/17] xhci: dbgtty: Fix unregister on tty_register_driver() failure
Date: Thu,  6 Aug 2026 17:21:03 +0300
Message-ID: <20260806142113.2436238-8-mathias.nyman@linux.intel.com>
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

If tty_register_driver() fails, it drops the reference, but fails to set
the global dbc_tty_driver to NULL, causing the unregister to be called
again when module exits.

On module unload dbc_tty_exit() only gates its cleanup on the driver
pointer being non-NULL, so it operates on the already-freed driver:

    module_init(xhci_hcd_init)
      xhci_hcd_init()
        xhci_dbc_init()                       [return value ignored]
          dbc_tty_init()
            tty_register_driver() fails
              tty_driver_kref_put()           -> driver freed
              (dbc_tty_driver left dangling)
    ...
    module_exit(xhci_hcd_fini)
      xhci_hcd_fini()
        xhci_dbc_exit()
          dbc_tty_exit()
            if (dbc_tty_driver)               -> true (dangling)
              tty_unregister_driver()         -> use-after-free

Fixes: 4521f1613940 ("xhci: dbctty: split dbc tty driver registration and unregistration functions.")
Cc: stable@vger.kernel.org # v5.10
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lucas De Marchi <ldemarchi@nvidia.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-dbgtty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 2e7384c6b6ec..01decd46f313 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -651,6 +651,7 @@ int dbc_tty_init(void)
 		pr_err("Can't register dbc tty driver\n");
 		tty_driver_kref_put(dbc_tty_driver);
 		idr_destroy(&dbc_tty_minors);
+		dbc_tty_driver = NULL;
 	}
 
 	return ret;
-- 
2.43.0

