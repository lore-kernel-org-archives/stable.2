Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901088;
	b=O3VoOLSEA3fn8nu7/ZAHJjjz30Yllpk+OMKzyA2xBxem3vCPo9QbRRZpbkH7PaSVrxmz
	 EkbkbBxpt4TUO/t//mjzxPuHwfsV5dUQhbhCqBUMDiBITHI7sez8AsF9ojUH9PuFKtfPS
	 soUcMKtHgtO1wsC3Ge29KgxSLCZe8Ys3XhTemhdsh5tPnXiSetay1l9+rybP3iAplNLgv
	 zXnD7tGXrM4INUyKNq0dgiI40QvxcUkQX9oKTxGlHbZ96Ax+nAqSVFxrh3lzoWSwvz2RW
	 h96LVJcRpX4k91uqlkxE/Hae+pC0OnUIcQMa9QDRTlzvVzllbiezDNqrq0od/ZQbNvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901088;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KJizlVtBLvzGN6fffR98BVrqK2zlPa9v71oTuZwwdI8=;
	b=W0aRD1L1cJTBJwoxne+eOoAaBKjHS1XVXPY2+N2FCLJTtbP4dXL2AsrlYcGKrt50+UJT
	 N8hNj6pJoOi9qPKg06b70ZZx8kchHoI2RMyZPtvZfql3tWuydO9DsUdaGu7xb9Yu2UeGv
	 7X4WXnjeYiJJISNfi3lsFbkIJ/Ima9uV6nBuoXpi2sycQFb7JUJFtlLAX85C9WDd1B8qX
	 x3zlqB7ol+ThHVqNdOmY+Ko8sYjAN73kr775tc58t8V8zPJv6RrdA8ZtAxEQBlgRDhfR1
	 PZU5XxY5UMXpftJqde430m/c2Mc2Xnm1thM+fnzp3xtHtVXkJ/ySwbtazvn/G8LjgWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hkd7bdBE;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193A606A333;
	Thu,  5 Nov 2026 17:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0193A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hkd7bdBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793901088; x=1825437088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BWER8i7SUATVcxdzh06wJWoUzJI5CFwAxDOJkt5Txq0=;
  b=hkd7bdBEhXuCC9cgDMTL6X6KL4Yy2/4mX5f9okj+aekdWsZOieSDhDo3
   WxmIrheHAKI/nfFT3TJSGmPzFNm955TiqCrMD+D8TPOgOivcqiyzVbJI8
   9Hl/cAZXWl0/3r3LN7NED7OqpAkw4tcIzq/iaAiDNqGunEpIm6gslc1SN
   XbLme/1A4XikVfu+y8Uibq4p0404sEFyywIMiFq58w5tv/3jP+xd5uYme
   LHPpjmZNpPfUvzYJKyXpsuAc7JY1tzUBGbciZa0kufIgU3LddhVZPRzU/
   SgyXCPN/zTaQ8r40O/odBBJdXe/MU1Qp5ueJJrWdfbxcHS/THs+KGilsE
   g==;
X-CSE-ConnectionGUID: 5ezkPAvfSWWx6+bizoFGvQ==
X-CSE-MsgGUID: kYarc4NmQjOuMoZrMAihjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2572539"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2572539"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 09:51:27 -0800
X-CSE-ConnectionGUID: IhHYZZPaQ6mI9dTOiuHkXA==
X-CSE-MsgGUID: kZNdolaiT1O3YI1/PgB+vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7064865"
Received: from amilburn-desk.amilburn-desk (HELO mnyman-desk.home) ([10.245.244.193])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 09:51:26 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Xu Rao <raoxu@uniontech.com>,
	stable@vger.kernel.org,
	Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 2/5] usb: xhci: disable the correct slot on alloc_dev failure
Date: Thu,  5 Nov 2026 19:51:03 +0200
Message-ID: <20261105175106.241182-3-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105175106.241182-1-mathias.nyman@linux.intel.com>
References: <20261105175106.241182-1-mathias.nyman@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Rao <raoxu@uniontech.com>

xhci_alloc_dev() stores the Slot ID returned by the Enable Slot command
in the local slot_id variable.  udev->slot_id is updated only after
xhci_alloc_virt_device() succeeds.

If endpoint resource reservation or virtual device allocation fails
before that update, the error path passes udev->slot_id to
xhci_disable_and_free_slot().  During initial enumeration this is slot 0.
When reallocating a device whose virtual device is missing or belongs to
another usb_device, udev->slot_id may contain a stale Slot ID.
The newly enabled slot can therefore remain active, or the wrong slot can
be disabled.

Pass slot_id, which identifies the slot enabled by this invocation.
xhci_disable_and_free_slot() already handles a missing xhci->devs entry.

Fixes: 3ffbba9511b4 ("USB: xhci: Allocate and address USB devices")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Reviewed-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index b50a582be1fb..94da0268b7b3 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4301,7 +4301,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 1;
 
 disable_slot:
-	xhci_disable_and_free_slot(xhci, udev->slot_id);
+	xhci_disable_and_free_slot(xhci, slot_id);
 
 	return 0;
 }
-- 
2.43.0

