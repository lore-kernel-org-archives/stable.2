Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48337C93F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082049; cv=none; b=lvxgr1flz5C17UZxBJrMbnFRoBPvGuWhPXq9V7wzeVp4Ggx7tMkbk315icCoPRVoylW+Gz4giflOAcO9y5dD3xmtibmohmvJhq55aB/UjBjTZ3UkreavofT3htATLu3d4gVtXD/2Kf+sKhwYAC0TTnO/I+4jCXm606oJj0wgokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082049; c=relaxed/simple;
	bh=ImMK4mcH1Y1VoDsvqq+9Jdwp821vUOZvfhYMZ2UEkuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6V4yrymx/Zw0sy1sRrzKUA9llb/quLQWpbztR1TMg8PiSdqCKasLC/+PAx8kx9t79p9WOO/2rT7TWR9WkglJWfjh3M8pd5SC6nM1v1MMRok9aCzadA6yLLIEUx3gNtZzTy02U9RgfTNf8/9kRvG+RrQoCDK2mSuYx6tEOMyrv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhiUD1k3; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhiUD1k3"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ef1d1so5768001cf.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789082047; x=1789686847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kocMm2XO+eODS6jg8KDsoCI9b/NcjZhZ8Qzw5ERTUwQ=;
        b=MhiUD1k3dto3IznuBEFveN7ehjP3ugJyCSiuZjE07myFuvlbb0foPugN499J6/kXrz
         28Uin+QC9ZmlpWfrZQZpyq8y7cTNgYS5GrlbHT4qbbbKHbEYSWfBYHMpAfTEl+qbZole
         U4JA2q7M6pKXWGNKbx/d5i3pANoe6WkZqixkK3i60GI7Qub7mmD5JpxtwW5YBnflw7Q7
         U5miC6mNzTYruS7ListdCV4xpkASHVsFooJ1dVSiHV6236G1Pu0wrvKC0UtgR/0PFtqZ
         SrwSGPHbkfrSyEcv7IkXzp6rPahcWQbcRiYp7IsmHws9+l02hl0z8A37ma6SqVnOEF+V
         Pg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789082047; x=1789686847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kocMm2XO+eODS6jg8KDsoCI9b/NcjZhZ8Qzw5ERTUwQ=;
        b=nxp/QNPIEMyILHzEPhVMnfKOs8q+MaRHEByZi7/ttwmybRmzTW2aq4SJ25lM6SZCHv
         0pAUp0WNS9I1SzEqBILtJfciwvf69J1xCDjMRJzF1PQM41NFx2gALRSdbvbVUYEr4F+w
         iSWdNjPOuNZTJOcWs0o55KEaqNk6n+/55XVv26R3MzLBMl8b+bLduLLNHT0vv3k0IWmm
         nIL2KikxUaXVEBRVa3JRSjJZkkUlJjpT5vZdSRW5pavGKR0iIQ/ndDjm5KeXPKhdvnnd
         7Tz+eY5njMqJ/9NKwI3KKu/Wd+9yH182TYFTUg4YOwawu1nT2UpFfL3IefOj6LIRtKnE
         OzZA==
X-Forwarded-Encrypted: i=1; AKwUvBw0RXcngR3UWKZ3Sg3IRfup7c8SW9HIeMNPr0AUZJk2zM4OsHNoUGfd74r0lYd+BrfrMrDCyNg=@vger.kernel.org
X-Gm-Message-State: AFuF++kMWujA9FZ2LAj6bPgZrrbGkNikhVuB6I+y/Z66KnSglW1SXv5w
	IaRAiK73fS3oq4D+AIzilR2NpWatYGIRwTsS7sp0AEfanHkyXoH4bSo=
X-Gm-Gg: AYBFou1s7PZEMuRyL2mRfsSr3QTNGyqxz1HTM/7Lb0DP7CHLImGhhIBobPa4cCU9iTi
	0uKgTd3xpTUY83dY9fxUvEzg9oTya8MotB1aprWY4cv7TJC2KsrTXNmlFT18c6Ka49Ef2EeIll8
	pI6N6CPRiKra9fRlm5EX4BmY4wit+z5BRRVRjLm2QWB2Obb2+LMm97mB4ZRnHYAey0cq11sBeB2
	MZAfQh0rCqhNvHGtbWvO/wGakKSOEgMdAjStkAV/idCdfac2y3CmQ2fPkoSv9da9sTP5l8MaeMQ
	iaSxgG+nr04b8psGgetR8ivzKswGInPnkkaWJF8M5thmMZ+/w6zMVvHbPvTihU8MpoDht4XDeW9
	stEGThcpRDs+NIUwTOC384vbiDVmpJSUvEiPtw2oMQU9SGuasmk/IAl30dYuJP+uH45DzoNY8/E
	uw8DrYl5+OaW1xIv6OPpdi3ssLjQiM7cC7sv1dBqRRn6pEal67hrK4XD4bjR6ORzSt4URcBtKE6
	26enKy/MUw/f64XkhOLzVDzFPdIrH19d9/v9NsnIAYds38Xp0EL0y3tuevUaFHKJMF3N3muv7xW
	rjIa3yz+FvCzDlENy89OWFO6j38mUBBYUw==
X-Received: by 2002:a05:622a:390:b0:530:9c9e:d9e7 with SMTP id d75a77b69052e-530c85293aemr28082171cf.5.1789082046602;
        Thu, 10 Sep 2026 16:14:06 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca103b90sm5778121cf.0.2026.09.10.16.14.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 16:14:05 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] net: 8390: pcnet_cs: release PCMCIA window on setup_shmem_window() error
Date: Thu, 10 Sep 2026 19:14:00 -0400
Message-ID: <20260910231400.31919-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260731161740.44955-1-mhun512@gmail.com>
References: <20260731161740.44955-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup_shmem_window() acquires a PCMCIA memory window using
pcmcia_request_window(). If pcmcia_map_mem_page() or the subsequent
ioremap() fails, the function returns without releasing the requested
window.

pcnet_config() treats shared-memory setup failure as non-fatal and falls
back to setup_dma_config(). Probe can therefore continue while socket
window 3 and its reserved iomem range remain unnecessarily held for the
rest of the bound lifetime of the device. pcmcia_disable_device()
eventually releases the window during teardown.

Route error paths after a successful request through a new release label
that calls pcmcia_release_window(). Fold the existing buffer-verification
cleanup into the same path, keeping iounmap() before the window release
when a mapping exists. Leave the request failure path unchanged.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Clarify that the window remains reserved only until device teardown.
- Make the DMA fallback and continued probe description conditional.
- Avoid claiming that every request failure leaves no resource held.
- Restore the surrounding indentation for the new goto statements.

Link: https://lore.kernel.org/netdev/20260731161740.44955-1-mhun512@gmail.com/
---
 drivers/net/ethernet/8390/pcnet_cs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
index 19f9c5db3..0cf3c0f3c 100644
--- a/drivers/net/ethernet/8390/pcnet_cs.c
+++ b/drivers/net/ethernet/8390/pcnet_cs.c
@@ -1434,14 +1434,14 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
     offset -= offset % window_size;
     ret = pcmcia_map_mem_page(link, link->resource[3], offset);
     if (ret)
-	    goto failed;
+	    goto release;
 
     /* Try scribbling on the buffer */
     info->base = ioremap(link->resource[3]->start,
 			resource_size(link->resource[3]));
     if (unlikely(!info->base)) {
 	    ret = -ENOMEM;
-	    goto failed;
+	    goto release;
     }
 
     for (i = 0; i < (TX_PAGES<<8); i += 2)
@@ -1452,9 +1452,8 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
     pcnet_reset_8390(dev);
     if (i != (TX_PAGES<<8)) {
 	iounmap(info->base);
-	pcmcia_release_window(link, link->resource[3]);
 	info->base = NULL;
-	goto failed;
+	goto release;
     }
 
     ei_status.mem = info->base + offset;
@@ -1475,6 +1474,8 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
     info->flags |= USE_SHMEM;
     return 0;
 
+release:
+	pcmcia_release_window(link, link->resource[3]);
 failed:
     return 1;
 }
-- 
2.47.1
