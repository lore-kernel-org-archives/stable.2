Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01294E4C22;
	Thu, 15 Oct 2026 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063649; cv=none; b=qFDnMHmR7xZUEF61HvtJBMhmeTzjOHUN5L5KA6FpNgE14ecf7NFsqUXER16UCgE2dwhWmo3D8k1OeD9y5ukR3dMXtqkUEMSGVl2euW6NhA4TqK8zAiKS6puYueRRNwGoCIkzPw6TdT+hfjtlvll1FnraWXxHhgjk/UsCADBQZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063649; c=relaxed/simple;
	bh=3osjqB5bBGFUGsomBmoGyCwjF6lhMg22z+jge/yMj3M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i/FCRfINJmGFmxSpP643CqxaVcq0xcBXbUtKVuY29b8RSdpZcIUbnXog+wA7ekBMXQVbr5A6X4BSoHs9lw6en9FmrZm/SY7VzRFGg8gohE5pkcadanpKph/A+sZVwTCPGKaOSPDkRSJRaOGCfNdDfKXWCR+JT5a61PnJ2DmasLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=d2WaIgAR; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="d2WaIgAR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792063643; x=1823599643;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c5MSEChHFaHzH315sZEHyXYQRaA4uc8oyDI0uBMz9mE=;
  b=d2WaIgARjayuajEVk+DZTTCMDBSoy2IIhkTvSdSvYbwV9/MbsK+HfwJ0
   mZaL5hXPk8oLLfxBYQppkoscqVP+rhuNMgMnfBuqPysdWHjRlk3721V68
   Ghso2F8XF96XCOOk4yMWHzt6RoexB0FXuNaJDj5KbqcjdF/ZwkUlgXMGe
   XSX1xqnsCPknL1jAYW80kpN0YwGB9rRgdbR8mWT2D1muLYAJATlrOpTBm
   9mmNoSAbUOXebUPnYm1ihjTy0TVEAj+eFo5GY9g0NBSV2bIXDNN2a7T23
   IHKC1XllGG/K8hHmv0AhqG3jgA27IH4ngMl3KSdArdIxJxRBS3nASbfNZ
   w==;
X-CSE-ConnectionGUID: /CqkO7PGTDSwI0pbMZ0JVg==
X-CSE-MsgGUID: PrJRhyXRTlWUO7N3MLHdxg==
X-IronPort-AV: E=Sophos;i="6.27,159,1787011200"; 
   d="scan'208";a="31126226"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:27:20 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:25661]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.190:2525] with esmtp (Farcaster)
 id 334e4de1-04d9-46d7-b7b2-49929fc3d3bb; Thu, 15 Oct 2026 11:27:20 +0000 (UTC)
X-Farcaster-Flow-ID: 334e4de1-04d9-46d7-b7b2-49929fc3d3bb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 11:27:20 +0000
Received: from dev-dsk-gyokhan-1a-87ab81cc.eu-west-1.amazon.com
 (10.253.85.128) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 11:27:17 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC: Matthew Wilcox <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Ira Weiny <ira.weiny@intel.com>, Helge Deller
	<deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Sasha Levin
	<sashal@kernel.org>, <linux-mm@kvack.org>, <linux-parisc@vger.kernel.org>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>, Al Viro
	<viro@zeniv.linux.org.uk>, Alexander Potapenko <glider@google.com>, "Andrey
 Konovalov" <andreyknvl@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	"David Sterba" <dsterba@suse.com>, Kees Cook <keescook@chromium.org>,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, Tony Luck
	<tony.luck@intel.com>, Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: [PATCH 5.10] highmem: round down the address passed to kunmap_flush_on_unmap()
Date: Thu, 15 Oct 2026 11:27:01 +0000
Message-ID: <20261015112701.650511-1-gyokhan@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

commit 88d7b12068b95731c280af8ce88e8ee9561f96de upstream.

We already round down the address in kunmap_local_indexed() which is the
other implementation of __kunmap_local().  The only implementation of
kunmap_flush_on_unmap() is PA-RISC which is expecting a page-aligned
address.  This may be causing PA-RISC to be flushing the wrong addresses
currently.

Link: https://lkml.kernel.org/r/20230126200727.1680362-1-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 298fa1ad5571 ("highmem: Provide generic variant of kmap_atomic*")
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Helge Deller <deller@gmx.de>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ 5.10 has no include/linux/highmem-internal.h and no
  kmap_local API, so __kunmap_local() does not exist. Therefore,
  I applied the __kunmap_atomic() hunk to include/linux/highmem.h ]
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
---

298fa1ad5571 ("highmem: Provide generic variant of kmap_atomic*") came
into 5.10.y in 5.10.270 (c1824fac30fa) as a Stable-dep-of 68d4d3e78150
("isofs: fix out-of-bounds page array access on empty zisofs block"),
but its follow-up 88d7b12068b9 did not. 5.15.y and 6.1.y already have
it (5.15.93 and 6.1.11).

 include/linux/highmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 5f7cd58db478..a2a252a93d76 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -218,7 +218,7 @@ static inline void __kunmap_atomic(void *addr)
 	 * handles re-enabling faults and preemption
 	 */
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
-	kunmap_flush_on_unmap(addr);
+	kunmap_flush_on_unmap(PTR_ALIGN_DOWN(addr, PAGE_SIZE));
 #endif
 }
 
-- 
2.50.1

