Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E818FC97
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306171; cv=none; b=Deva1Kv/jqUwpPoGNwVf10aCnyuuOUAZSMMY9g8LhJ5lNZNX9aP9I8CF5Z++lkw4FxFlZfYY67/l6A36e528oc97dcOxhzZ7KiA/Oi2RL+1dZwKBFo4g6LRJmzkYlxHO/FC2+JGjmn4/x0WoCEXfiQnFVbXxpg/D7VHlc/RT2+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306171; c=relaxed/simple;
	bh=P62XFj3El1zqG9GGFEYXfqYzqOt/6OFbZEohx6gDRu0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RIdaM6y6SHK9I/shrCMPJn02heBnR6NsRh3VZmm7jdUmirJBCAWr9rX60he4/zqc0zCTcx+9BxvC0iuFDGRfeULaKEI8TRJCszlg4yMSmGaAzLFh4mVA2bdBg0CBho8+Im2bV7yotgz8+kaJnARXcpE3vjjzVpLgc8/pLH1ADF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=RvTmHaQS; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="RvTmHaQS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1780306170; x=1811842170;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HpjtZmFXsxidBZJjFQYAS6CBJU5vUaHDo+8aVLCph/E=;
  b=RvTmHaQSNMkKg3+uDEEi3xzUmM+l68AkvIjFJUHiY99MAziLvKDVQQYW
   BKuNL21cCgpMq4VtP5riUADpTrApqEG2A21DGrK4bx8X1ZydrxITrVYum
   7Xe4WzuSIYlVxupnD4SK7PvxgOj309L3fM00Afsdcs9N/mnOZNFjVPUoJ
   clts1yUaWIgF46Sw9zbL34MWYgWq3Tp+qsRLqTgT00Las+mOaWLrSPnO2
   TGHXpaQl9DewmYC9avEx2NCE0B4gzIpqG9ju9zZDIBDi5GNQID+vBXohs
   g2nYmOYP/ngeoqqoCuUCvS+I6pXu2xWpkVCrx3k2Zi7jMfmMz/1gZMkGo
   A==;
X-CSE-ConnectionGUID: paRINLUsTfCt7XNNg/2Yiw==
X-CSE-MsgGUID: CQMjXlMvR9aNle3Z+GucdA==
X-IronPort-AV: E=Sophos;i="6.24,181,1774310400"; 
   d="scan'208";a="20629402"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 09:29:26 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:16247]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.91:2525] with esmtp (Farcaster)
 id bb685c7a-870e-4d2d-aad3-f6d9fb73e6b5; Mon, 1 Jun 2026 09:29:26 +0000 (UTC)
X-Farcaster-Flow-ID: bb685c7a-870e-4d2d-aad3-f6d9fb73e6b5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 1 Jun 2026 09:29:26 +0000
Received: from dev-dsk-gyokhan-1b-83b48b3c.eu-west-1.amazon.com (10.13.234.1)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 1 Jun 2026 09:29:24 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sudeep.holla@arm.com>,
	<sebastianene@google.com>, <linux-arm-kernel@lists.infradead.org>, "Sudeep
 Holla" <sudeep.holla@kernel.org>, Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: firmware: arm_ffa: Align RxTx buffer size before mapping
Date: Mon, 1 Jun 2026 09:29:18 +0000
Message-ID: <20260601092918.11031-1-gyokhan@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Sudeep Holla <sudeep.holla@kernel.org>

commit 0399e3f872ca3d78044bb715a73ea645806d2c7b upstream.

Commit 83210251fd70 ("firmware: arm_ffa: Use the correct buffer size during
RXTX_MAP") advertises PAGE_ALIGN(rxtx_bufsz) to firmware when mapping the
buffers but the driver continues to stores the minimum FF-A buffer size
in drv_info->rxtx_bufsz which is used elsewhere in the driver.

Align the size before storing it so that the allocation, validation and
FFA_RXTX_MAP all use the same buffer size.

Fixes: 83210251fd70 ("firmware: arm_ffa: Use the correct buffer size during RXTX_MAP")
Cc: Sebastian Ene <sebastianene@google.com>
Link: https://sashiko.dev/#/patchset/20260402113939.930221-1-sebastianene@google.com
Reviewed-by: Sebastian Ene <sebastianene@google.com>
Link: https://patch.msgid.link/20260428-ffa_fixes-v2-9-8595ae450034@kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -2059,6 +2059,7 @@ static int __init ffa_init(void)
 			rxtx_bufsz = SZ_4K;
 	}
 
+	rxtx_bufsz = PAGE_ALIGN(rxtx_bufsz);
 	drv_info->rxtx_bufsz = rxtx_bufsz;
 	drv_info->rx_buffer = alloc_pages_exact(rxtx_bufsz, GFP_KERNEL);
 	if (!drv_info->rx_buffer) {
@@ -2074,7 +2075,7 @@ static int __init ffa_init(void)
 
 	ret = ffa_rxtx_map(virt_to_phys(drv_info->tx_buffer),
 			   virt_to_phys(drv_info->rx_buffer),
-			   PAGE_ALIGN(rxtx_bufsz) / FFA_PAGE_SIZE);
+			   rxtx_bufsz / FFA_PAGE_SIZE);
 	if (ret) {
 		pr_err("failed to register FFA RxTx buffers\n");
 		goto free_pages;



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

