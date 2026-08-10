Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A563D9025
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365550; cv=none; b=bXioidZcoHNMiukrQw9YqryVKFuOTdPU5GUIzMKO2diW9Mq8yxAxstmuWUJlDwPG/f9bdAwXnYwFMep680kV7JFQVXLT5uSJ2vUDYvi3BAvCS8pJP0HK43P9jHoVXGJfUq1H2N/5OPxROl6GDtGyD61CzH3pzkmmAgJjBS6nhR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365550; c=relaxed/simple;
	bh=RiauInVACv9oIOx+NqLlF7ICmj/eQk5U/vnXep2iR8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MENyLmziAykJHeuShS815XZ/h4oo+7HjpIuYIKtmUrRdnnGcYyW5fDmuuegVC01msxHqxCcyfLDILbpj4Th76BQmgIN8GzDvm0tczEkl3rDIsUmFhN8/PVwgF56rgY8uSZB1o3lcphM0zEQ8lBvp3P9zH9jyXoHHyjYm7prpNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqEySO9w; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqEySO9w"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4980dc26022so18763395e9.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786365547; x=1786970347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZEdQ2A6GGoHnGpTa3UasQyiE4AH49ki9i07irxjtKrk=;
        b=UqEySO9w3x8xyMDxGmoCOf81zMDxJzL1AxZapNkzrESHXKd6vViKBPmixI3F0xUOAf
         GMQ5VyUtscAY8SgvrHS87OsaqF5eZME7O0Wu0lYxGYlP1i0vc6eVMM0JVRXnk2rycDya
         +fO6cC2OKwsoyDv/lj6cKztKe9Z4tS1eeU1b9SPDtNZPYmoV2yJyMg5dpOru/w/HmFux
         a5FnfDAi+GGv391g18L2XaYjhNYUkyX4FmS3eNCN6UF7h190ZxXWkTiT4NY1TqkKP0r9
         s0HUm2QxwrKVgLJbMFpj8nxNgfaYqvjuFGMJcWPBrYdHf4bSTt0g2rY9uhk7b/0Bbqmh
         JF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786365547; x=1786970347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZEdQ2A6GGoHnGpTa3UasQyiE4AH49ki9i07irxjtKrk=;
        b=IHhKtQV+eM6BUAa6X/YdE10ObuZgIGHTaG28tUjfH49vdRLuiV1A6Nv0rs3MHFIWBa
         ZPj60vpeLc7LYOteTxtDpjfuouptxymq3VrUduTXnHqOv7yuUPvcM0e0OE9PKFPqpA9J
         1S3H3JM1xyHM/i+2rFT2uVsbVQNpCUoS/FvbDRlfak+hMO8oREHHW1aneicjL139A/c6
         bgGxaeJKXAJoEIJ4+MC5zppeldh168w3fVoU5XzSqjU35gDDHbYoQP0WYq06aMnrcXmN
         7JX30fY4S93CDcg+QjDT5zwNZXU5vIdSortWqAJE/B2I/5qfEG1agf+CGdfKo3BOyjAX
         Yicg==
X-Gm-Message-State: AOJu0Yx6QLErN43FfC330E5VtH7HcOo1U+qr55I4S1UZRDJbJ9QJbdNX
	uW+X2N8wzGbzFsbRoZMUyOv1S4XNK2U4+XZpLH70ygkX4u6IlB1tqLrdj0MvnCU/
X-Gm-Gg: AR+sD12X2IW9i43gC+cwjgWLYcwMLADKw5mPEWeF1prTWDvJbNX8cc6psiKWr2mxS5o
	i1fRKmo4eJasuAJAS4hfQCGSvFfqN9DarOXaXFRBmPNERMkid9AosrdF8T1prGXjLXwOyvPXiWz
	Fkmp2bTWE2fwG5Lz2yrSECneOhwecxUMmadZlbjCTNhUKh5/8YRqF9HCTAvx+22Zc0DVCWW6ZIi
	+UAEo+tfj/qbB4kcZ6gled/eqvip5mJzRmvfmuCreULMYoGn6qzMYzrHo3FPYk9LDND2OpiQ7ON
	+X967uhP9JfkEc/WBnvsgLb2eXU+CTeIRBDz5CSSkJfmSNOM6JTQ40f2zOgJYfIyzS8/fmPQfKm
	b2ttLNanldGZCNkbwCcPPrwmbxwq69R5F38p5Iz1EjEfl2gJRGdLZggQYyXxnIU/90bChoO6aH6
	CDRAx72z0bfgvxkt1+c21O/NB07VKNMeQtRZpHJGbHm6BczmrzYTtIksEOxQHWbE76qoo=
X-Received: by 2002:a05:600c:4f4d:b0:498:ff3:71ed with SMTP id 5b1f17b1804b1-499727b9053mr17974925e9.17.1786365546389;
        Mon, 10 Aug 2026 05:39:06 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm421460675e9.10.2026.08.10.05.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 05:39:03 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: stable@vger.kernel.org
Cc: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.18.y] net: fec: do not release NULL pages when RX buffer allocation fails
Date: Mon, 10 Aug 2026 14:39:02 +0200
Message-ID: <20260810123902.2611897-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

fec_enet_alloc_rxq_buffers() leaves the loop as soon as
page_pool_dev_alloc_pages() returns NULL and jumps to err_alloc, which
calls fec_enet_free_buffers(). That helper walks the whole ring and
hands every rx_skb_info[i].page to page_pool_put_full_page(), including
the entries the allocation loop never reached. Those are still NULL,
because the queue was allocated with kzalloc(), and
page_pool_put_full_page() dereferences the page, so an open that runs
out of memory oopses instead of returning -ENOMEM:

  Unable to handle kernel NULL pointer dereference at virtual address 00000014 when read
  Internal error: Oops: 5 [#1] SMP ARM
  CPU: 0 PID: 384 Comm: connmand Not tainted 6.18.43 #1
  Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
  PC is at fec_enet_free_buffers+0xb0/0x2a8
  Call trace:
   fec_enet_free_buffers from fec_enet_open+0x1e0/0x504
   fec_enet_open from __dev_open+0x114/0x238
   __dev_open from __dev_change_flags+0x190/0x208
   __dev_change_flags from netif_change_flags+0x1c/0x58
   netif_change_flags from dev_change_flags+0x44/0x74
   dev_change_flags from devinet_ioctl+0x3a4/0x768

Seen on a Colibri VF50, 128 MiB of RAM, on the first ifup after boot.

Skip the entries that hold no page, and clear the ones that do after
releasing them, so that a later failed open cannot release the same page
a second time.

Mainline is not affected. Commit a2ae70c0efe4 ("net: fec: add
fec_alloc_rxq_buffers_pp() to allocate buffers from page pool") replaced
this loop with fec_free_rxq_buffers(), which skips and clears the empty
entries. That commit is part of the XDP zero copy series and is not a
stable candidate, so this is the equivalent minimal fix for 6.18.y.

Fixes: 95698ff6177b ("net: fec: using page pool to manage RX buffers")
Cc: stable@vger.kernel.org
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3341,8 +3341,15 @@
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
 		rxq = fep->rx_queue[q];
-		for (i = 0; i < rxq->bd.ring_size; i++)
-			page_pool_put_full_page(rxq->page_pool, rxq->rx_skb_info[i].page, false);
+		for (i = 0; i < rxq->bd.ring_size; i++) {
+			struct page *page = rxq->rx_skb_info[i].page;
+
+			if (!page)
+				continue;
+
+			page_pool_put_full_page(rxq->page_pool, page, false);
+			rxq->rx_skb_info[i].page = NULL;
+		}
 
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
-- 
2.43.0
