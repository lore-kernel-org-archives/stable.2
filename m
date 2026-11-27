Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781893;
	b=oRzJYptfFkLV/WWKUp3weaRLw5GoCwC9dwUNFTJxSWSmdnNL+LgiubmXS0rhxqXZn7dy
	 gvumL2bjG5n77yrpdKrSMp5cBmhEhuqk8g4Mne+HqZxeD5Ltxed2M+IMHAT9Z/GYZgnjK
	 8o7rwBML9sembpQH9UiEwxyyAUmE3qHlvmgFlmxniSZan8GEduLLxvhPxacHctC8CaZA/
	 ngq7/H5aZvgPGLd0U7hVruzxVljfo4laON0WrNGJhRj7nnMXbq1ZIcc048m4ukLZxVj31
	 hfuKvrPWVgQQrf57Ro03WB0mKBe23FFIbHkycqDp6QuiYfypTX65BC9puhgG2TKTDLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781893;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AYmnSmOyzTORRbbWg9y2f9ifyuR757SQQxA5HcEM1t0=;
	b=hbcLX86I9+Yyp8W/ui4zgPf/gpQH/5e1S5Zy8dX/g/iSA4friMogD76oExq3WwDcBDYX
	 /mDnakhL8HcTNftllo+E8m6GYZbR7RjUmmVMLrIVp64061+Peir8hmPTs49Fc9ROeAC5h
	 v18wd1kVU3HDBDWrytxLVo8oh1ptkEGD6S1lYxg5SyiH5fpICw1OtZA149T35NhbGIxn1
	 ro22UueRyUij1tVUpaAwH0p7bKRHP1GN5LE5ivNzjysFmfiC5n4lYr8hywzSUjzYSbvoQ
	 7XPpMOjBwDWufmY6NoHf9I0MkIs/59NjcXq53NQecWJiLXLn7jKqAlUbeKDOjJqIoUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Z1lZ/1sd";
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D8E606A68E;
	Fri, 27 Nov 2026 12:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02D8E606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z1lZ/1sd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795781893; x=1827317893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XxG5U8Zq4bGeAhsq/J6HHln+SH4CW5M1BgqW7WTuZJ8=;
  b=Z1lZ/1sdfIj/04S45eFMxgS5PjO2kffMW5fuPuSWv41H6fiz/X2sxHAd
   T3ohzS0hiJOathz054RKi1ULE1UWeEo8pWczbxWhidxPVDqcxctzJCfRr
   dp8nzN+6i+2aO+FyMpm0qEnuy8oNfxcIg5+W4XEn84oyrp5QnQq8Jdj4n
   OBAtSizzKzX5J145Vr8TG2S6DvklPImV0ijNZ0OUvoWqMWXusl4QvnKA2
   as4UmhqDgPsA+aFkykIgkJnDXWs/MyAgiOCB42EXRQVybrXcwD0rsp/7n
   JZN2jLx13O7uVOYjzqGC3GyKc73+Jq956NCI1zekCPFqUCarx+bJXxwQz
   g==;
X-CSE-ConnectionGUID: 4jEH3QT5QzKfalyFqrItcw==
X-CSE-MsgGUID: JzDiJn3SShObTdhSy1yBOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4577847"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4577847"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:13 -0800
X-CSE-ConnectionGUID: QYrts+GVTCqw7GFArvnFdA==
X-CSE-MsgGUID: b2Map2ifSeKfYqdAUq8ddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12270668"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mnyman-desk.home) ([10.245.245.45])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:12 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Chien Kun Niu <rickyniu@google.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 03/10] xhci: Give back URB under lock in xhci_urb_dequeue()
Date: Fri, 27 Nov 2026 14:17:48 +0200
Message-ID: <20261127121755.281420-4-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127121755.281420-1-mathias.nyman@linux.intel.com>
References: <20261127121755.281420-1-mathias.nyman@linux.intel.com>
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

From: Chien Kun Niu <rickyniu@google.com>

Before commit 36dc01657b49 ("usb: host: xhci: Support running urb
giveback in tasklet context") set HCD_BH, usb_hcd_giveback_urb() ran
urb->complete() synchronously, so xHCI had to drop xhci->lock before
giving back an URB. That commit updated xhci_giveback_urb_in_irq() to
keep xhci->lock held across usb_hcd_giveback_urb(), covering normal
completions, xhci_process_cancelled_tds(), and xhci_hc_died(), while
the open-coded err_giveback path in xhci_urb_dequeue() was missed.

Dropping xhci->lock between usb_hcd_unlink_urb_from_ep() and
usb_hcd_giveback_urb() breaks per-endpoint giveback serialization: a
concurrent xhci_urb_dequeue() or xhci_hc_died() can acquire xhci->lock
and queue a later URB onto bh->head ahead of this one, completing URBs
out of order. When spinlocks disable interrupts, unlocking first also
causes a redundant IRQ restore/save bounce into bh->lock, and without
an IRQ-safe bh->lock it exposed task-context unlinks to a same-CPU
deadlock.

Move usb_hcd_giveback_urb() before spin_unlock_irqrestore(&xhci->lock,
flags) in err_giveback to match xhci_giveback_urb_in_irq().

Fixes: 36dc01657b49 ("usb: host: xhci: Support running urb giveback in tasklet context")
Cc: stable@vger.kernel.org
Signed-off-by: Chien Kun Niu <rickyniu@google.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index b3df40f22d55..d55c8b7058ce 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1891,8 +1891,8 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	if (urb_priv)
 		xhci_urb_free_priv(urb_priv);
 	usb_hcd_unlink_urb_from_ep(hcd, urb);
-	spin_unlock_irqrestore(&xhci->lock, flags);
 	usb_hcd_giveback_urb(hcd, urb, -ESHUTDOWN);
+	spin_unlock_irqrestore(&xhci->lock, flags);
 	return ret;
 }
 
-- 
2.43.0

