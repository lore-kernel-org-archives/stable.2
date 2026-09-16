Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26E4B0E35
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576434; cv=none; b=PmPNvjrXgAHixGAfQ2ChgK2C3ImE+1aBTUyDVBPZkDY8PEJVIL3JrhKAS9BXMAV1fI9WMdCjD2tFlWw8auzQ5lpfYFrEEBNdlWmNQGIZfOjHFTjCW3OsQJuA7rxHCo7Rtgl9bj/TBmGl1cVKI21+pv9F5jgGYc7bmc6QKJ5za5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576434; c=relaxed/simple;
	bh=DNbxHAa5m+FBlc/POCSh2p8TjaDwKfuIfmSEmnyXWJw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iWJolFG7IGhmA/AtHt9BZqDCf4FxlqeH8ZznFzmCESl2K6//V5HZuenCQJUv0LiwLTbrvzODxecVKebPrZPWTs2/LcPYkRXR0Z6m0FcLWaOuUJvKzUGQ6Cm1MlPy682im8QBMWjZLn45xD8DceaQ4XoGITUiKz9WGXe9ckXpF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sN6pFQJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sN6pFQJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459B81F000FF;
	Wed, 16 Sep 2026 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789576431;
	bh=OdUwuz7H5ubHq9w79A5CDJ947gYNnx83dKPSEtf03TU=;
	h=Subject:To:Cc:From:Date;
	b=sN6pFQJLGBktA7j7QOj2lB6SPlee4agI4h75LvGNyrq1ezJACf1lvq+nDd6oigrEo
	 34K2gB0EI2CFZnK4Lv9t1rDW7yXIiXoMDibV6dhtGXAFFNrweGZ/ah5mItaV7hyhlx
	 17LUGr1407D2M325eNCquxdtVlI1Qu5Wt/RKg/oU=
Subject: FAILED: patch "[PATCH] bnxt_en: Propagate TPA buffer allocation failures in" failed to apply to 6.12-stable tree
To: joe@dama.to,pabeni@redhat.com,sashiko-bot+sashiko@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:28:38 +0100
Message-ID: <2026091638-excretory-liquid-7149@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b814dfbfeb0a68c9a52073f2caa05a2d5247a329
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091638-excretory-liquid-7149@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b814dfbfeb0a68c9a52073f2caa05a2d5247a329 Mon Sep 17 00:00:00 2001
From: Joe Damato <joe@dama.to>
Date: Tue, 1 Sep 2026 18:56:46 -0700
Subject: [PATCH] bnxt_en: Propagate TPA buffer allocation failures in
 bnxt_queue_mem_alloc()

bnxt_alloc_one_tpa_info_data() returns -ENOMEM as soon as one allocation
fails. This leaves the remaining rxr->rx_tpa[] entries zeroed.

bnxt_queue_mem_alloc() discards that return value, so the partially
initialized ring is installed by bnxt_queue_start().

Since the agg_id is picked by the hardware and bnxt_alloc_agg_idx maps
it to a SW index in rxr->rx_tpa[], it is possible that an uninitialized
slot can be chosen which would hand a zero DMA address to the device.

Fix this by checking the return value of bnxt_alloc_one_tpa_info_data
and unwinding, freeing the ring buffers.

Fixes: bd649c5cc958 ("bnxt_en: handle tpa_info in queue API implementation")
Reported-by: Sashiko <sashiko-bot+sashiko@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
Link: https://patch.msgid.link/20260902015652.2421609-4-joe@dama.to
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index aaf658976865..ae7150c7de1f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16402,11 +16402,16 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	bnxt_alloc_one_rx_ring_skb(bp, clone, idx);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		bnxt_alloc_one_rx_ring_netmem(bp, clone, idx);
-	if (bp->flags & BNXT_FLAG_TPA)
-		bnxt_alloc_one_tpa_info_data(bp, clone);
+	if (bp->flags & BNXT_FLAG_TPA) {
+		rc = bnxt_alloc_one_tpa_info_data(bp, clone);
+		if (rc)
+			goto err_free_rx_ring_skbs;
+	}
 
 	return 0;
 
+err_free_rx_ring_skbs:
+	bnxt_free_one_rx_ring_skbs(bp, clone);
 err_free_tpa_info:
 	bnxt_free_one_tpa_info(bp, clone);
 err_free_rx_agg_ring:

