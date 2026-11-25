Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593342;
	b=K2a0JItIxF9nIzOyi4PoZi6rm+ETO7DemlE48RenKdjfqFKvxQMfU1a0DE00G+O2rCsH
	 bUhi+zBO72Fb15SrGFNLGXdj2MUTwrVBoWU0j0/mKr3PpMToHUscg2FFaz3uknJhHx4JP
	 cR88Zeqq1QBsTSsW/yVPB4iOn2xAhxQhGFLJko0936aeL246ngUxByDqo1p0LWGms51zf
	 xxcISBnVldNZTgG4odvA5eG/f0alLJXJy7UU7/6itiP9ComtgK2oBb02UqMBtIp2cvLcO
	 /MQAZAlHGpNlnCVwl9rxvPXhFx13xTs+Ao7SFYk4vL+6hJxLTgybKY1nZ6pwEZQRBpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593342;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID;
	bh=3TTqrvGLbHBqP1YUi+0AwZv0HDH1EAefXi4rL26IN/M=;
	b=3nat7MLybXqwBGUIJ8w/hXC7b/mXLl4VtYzVh2IKuO350noTDg34kHAugPFV22J1d2e4
	 7nCa3Fqbk9S1NoGBEvIIawprX+vI0NIs5ygJKAhCuLwBu6po0Qccjxy6QPVSzNiAOMCD5
	 oOulLxEItncPMU+eHQqgZ+wybDCxN/2OAiRXgHJGxcuh6PPlgJ0tdcYv7tW0vI8D/VkRW
	 TdTY75QsHB6jJEVYJop3VLi8B0sDH6XrUDmIhEmynsqWq7YwSEiKsqB/2reUPuKvj4VdF
	 AalMJcfvc1RcSZoPFZ9BnmXTqnny4omPoBH4ku5PgVZcASdND2eKRVDEppDeqwmSHVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=CaU98iu4;
	arc=none smtp.remote-ip=185.136.64.228
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07089606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07089606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=CaU98iu4
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20261125075533bd6b8dcebc000207e6
        for <stable@vger.kernel.org>;
        Wed, 25 Nov 2026 08:55:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=3TTqrvGLbHBqP1YUi+0AwZv0HDH1EAefXi4rL26IN/M=;
 b=CaU98iu43HqPZNX0crdrW46aUtVYj1nHLjiZybZl/O0QcL6ZB6Myf+wOvKDNEnnuYkPaUS
 UC/jU6rNuIj5oTX1JIGyHV9Zdy6qqtN0G/rcAAoLRhEoHk9EzHHVxEb1/aXaAPOL0DTFHvY3
 4yBLH1jG8KSuUajSVkJL/OQ6LInFTvU2z7LR6428FFaEJDrUDe+mLaMDyfd+iYTqpoHcBEKJ
 qucrpJd0MhS0oQwpcHDRDHCGIYI4sB0mC53dIBIxU5PQeIyqG2UWM5n33EeaRsuFW9nwW1yY
 tEfa90ek8tVmM+4imomLlBFZRmF5U11ggevnBBb4GXtrGEpAFmXtZUAQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: dmaengine@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH] dmaengine: fsl-edma: don't call pm_runtime_allow() from terminate_all()
Date: Wed, 25 Nov 2026 08:55:17 +0100
Message-ID: <20261125075525.2640884-1-alexander.sverdlin@siemens.com>
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
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

fsl_edma_terminate_all() may be called from atomic context via
dmaengine_terminate_async(), which the dmaengine API explicitly allows
(Documentation/driver-api/dmaengine/client.rst). pm_runtime_allow() must
not be called from there, because it uses unconditional
spin_{un,}lock_irq() and therefore re-enables interrupts.

Calling dmaengine_terminate_async() from a UART interrupt handler on an
i.MX8QXP triggers:

  DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
  WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4404 lockdep_hardirqs_on_prepare+0x1a8/0x210
  Call trace:
   lockdep_hardirqs_on_prepare+0x1a8/0x210 (P)
   trace_hardirqs_on+0x58/0xf8
   _raw_spin_unlock_irq+0x38/0x80
   pm_runtime_allow+0x34/0x140
   fsl_edma_terminate_all+0x1d0/0x1e0
   ...

followed by the IRQ core warning that the handler enabled interrupts
(kernel/irq/handle.c). Both warnings are one-shot, so this is only
visible once per boot.

In-tree, fsl_lpuart's lpuart_flush_buffer() calls
dmaengine_terminate_async() with the port lock held and interrupts
disabled, so the port interrupt can then deadlock on that lock.

The call has no counterpart: pm_runtime_forbid() is never called in
fsl-edma, so runtime_auto is always already true and pm_runtime_allow()
does nothing except the illegal unlock. Just remove it.

Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Cc: stable@vger.kernel.org
Co-developed-by: Alessandro Zini <alessandro.zini@siemens.com>
Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/dma/fsl-edma-common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 513b0f4e5be21..1f1f5fb353cc8 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
-#include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
 
 #include "fsl-edma-common.h"
@@ -274,9 +273,6 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_PD)
-		pm_runtime_allow(fsl_chan->pd_dev);
-
 	return 0;
 }
 

base-commit: 2e02fb103be058cf8b2fb24112a74a2715e090f0
-- 
2.56.1

