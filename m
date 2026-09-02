Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDF1244667
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 03:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319783; cv=none; b=M05z3r9CQFk5ry5z61qonkf1FDhhNsqT8C6sO8ZcCGV8BllXayMR6EB2aJpwAqH0FzGf+8+b2F0hxF9WBLug/oIZwuQSSeOU51CZHTTWDwAj43tVle/nhgnU3J3q52ZHPixCsA9hwub7rfODbndGycEoiR2h21+/fCuDO4Wgbp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319783; c=relaxed/simple;
	bh=/1OZA9qEsYS5HsyLx/+pnRV1ACZsZhwQDFIpOl0PXqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ud/dCF2U5MajCegF/hoxlpZLmO8MJpQkv4XeajhE+5gFmaAPCMNqvi1DlljX/FvPvC6QI3XpbEy6DyPhr5fl+EYvVIp30BHwwfVfsPgOUGI3M4A2ensA8O3SpDlsaagD+ddBvXPM6UXiwoxH8jNpPawIWFtjIhEpg0vKDMiDggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQ05jFBk; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQ05jFBk"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso469261a12.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 20:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788319781; x=1788924581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gZ0kKM6EGOh/iG6MobiDle5RWpCCg6ryEvbje4v46XU=;
        b=FQ05jFBkohpHj2zKC+POaPKx5dUiQRkIUvy9XUpXSBa+o6jqOynHojFaQqelPOYGIJ
         lEEeDh13zGA7orB80XMk/h6eM8s4uwf9ldT47mO75rnB6l96k/ebmlYYcgGKTE8bgEGO
         LL7bflhZueo39UK9zPAehGordcGi2H5W7TuR5XjQOq+sjGOyS/Gc13h61N3DaJiZ/RVX
         3i8g8mZxr9l/wXaKZfi/Wo+4ouqABVEiq7ARC3gIbdpGwXK+U8NQp0FQxJFCezll8SCa
         tL5LvWVoL18WbBhHVkbb/Lj1pBolS/K4mGYYTeeQxRx1883fjgOe5ATxYClWdw6tMWGx
         Xn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788319781; x=1788924581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gZ0kKM6EGOh/iG6MobiDle5RWpCCg6ryEvbje4v46XU=;
        b=ZktYnHdRi5NvX2rppVyScSxidDABHJ8FdU6HSHEq+n0Y+6/j1xskq5TTJCGZW1LEwD
         dlycdSwUiXVCRfYblWGf8lEobeLKD48jxRaP2hWWItpJYEgHe2v9OhNMhgmF1faKw/iF
         jPd8x1HG1ulodw6sJlMRdhTs27/lbEbFB/mnU6dzOEjVXT859URlrMc9Qn5ipdu28pYt
         5AMcVc7AcgyXcGYdRzr/RFdNaiRpaXnB0YqTJBXNQbi1yNaiW0zt5+7qBHLQxIcQu8FH
         qcNmOL0OnMdw9PxyEV0gkB5KAqbk/Kk460vUhDlFDrKxUVEQLPD7FRqFP8JZeXYme/o8
         CIvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTTTpMgP2y2rbyvSqzvO9Wfgv3LpgnpvTOsSgf0GSxmNjon6/zS5lojesKI7X9cdV/C+NsWHo=@vger.kernel.org
X-Gm-Message-State: AFuF++lNWLkSE6PjxFgXdkuBxk0QKC1AX9manJqI+D/1ujwM+zX93z1i
	1DsXbLL7nhXQgx6J2Fk8dRzYjcEJzdzWoaujtgWBdvntR/z0GGt+oVcb
X-Gm-Gg: AYBFou02zuIc449BFenPKQFiKBTN5pjcuNQzj61BYjNXyOyxHeFHFrWA35iad7qScwP
	ky/QCLO5ldDSh/icGXhGBQygQdXIrELu6Z6jEiwBtAWG9b/t5qtFli8w9RSOnHu/HXuqFNiNZfO
	908bzYMho+n4SK8uvba0fHlOEkB3wFfwKiww1XvdE6bK4DWs9QnYBQhHaClRzkDHalGAs3gAze7
	4GmdYMtGFubuWgaGL3sGhkNFXPMBP4BM8b+Y5qwlppydKgR8D9phy+RcblY/hVQ6jYdpWvBf4We
	ipdJkyB6E2guf/tYalPhUZqW4z2GnDzmAzKYpknGOKKw6kt/qbLwCF+0P39Id7U8IyU988wrgoJ
	NHgnfHnyD8/IcCtfopZ5sCGCd7ZowdHemYhVeXISi8z9acOqKUUH6NBRYA2qQ7g3Ism1hSoT9Jl
	zhbJOgfaJM3Pu7VpzFPPAbB5jQBHMuse2w8lsQjSMcj4EuhtOqBzk=
X-Received: by 2002:a17:90b:5606:b0:398:9be6:f996 with SMTP id 98e67ed59e1d1-39aee1115e0mr2822094a91.21.1788319781337;
        Tue, 01 Sep 2026 20:29:41 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07baa594sm3099307eec.22.2026.09.01.20.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 20:29:40 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Vollrath <tactii@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net 1/3] e1000e: fix Rx skb DMA map error sentinel
Date: Tue,  1 Sep 2026 23:29:11 -0400
Message-ID: <20260902032913.661570-2-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902032913.661570-1-tactii@gmail.com>
References: <20260902032913.661570-1-tactii@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upon encountering a DMA_MAPPING_ERROR during skb allocation and mapping,
the driver would leave DMA_MAPPING_ERROR in the buffer_info->dma field.
This would lead several buffer_info->dma == 0 conditions down unwanted
paths:

* In e1000_alloc_jumbo_rx_buffers(), it would not re-attempt the failed
  mapping and instead write DMA_MAPPING_ERROR to the h/w descriptor on
  the next allocation call. On cleaning or teardown it would attempt to
  dma_unmap_page() DMA_MAPPING_ERROR. This case would only be
  reachable at MTU > 1518 and page size > 16K.
* In e1000_clean_rx_ring(), it would attempt to dma_unmap_page/single()
  DMA_MAPPING_ERROR (unless cleaned by the jumbo path first). This case
  would be reachable at any combination of MTU and page size.

Use buffer_info->dma = 0 as the sentinel for "DMA is not mapped." Set it
immediately upon detecting the failure.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..26f45ee8c7e7 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -691,6 +691,7 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
 						  adapter->rx_buffer_len,
 						  DMA_FROM_DEVICE);
 		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
+			buffer_info->dma = 0;
 			dev_err(&pdev->dev, "Rx DMA map failed\n");
 			adapter->rx_dma_failed++;
 			break;
@@ -791,6 +792,7 @@ static void e1000_alloc_rx_buffers_ps(struct e1000_ring *rx_ring,
 						  adapter->rx_ps_bsize0,
 						  DMA_FROM_DEVICE);
 		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
+			buffer_info->dma = 0;
 			dev_err(&pdev->dev, "Rx DMA map failed\n");
 			adapter->rx_dma_failed++;
 			/* cleanup skb */
@@ -877,6 +879,7 @@ static void e1000_alloc_jumbo_rx_buffers(struct e1000_ring *rx_ring,
 							PAGE_SIZE,
 							DMA_FROM_DEVICE);
 			if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
+				buffer_info->dma = 0;
 				adapter->alloc_rx_buff_failed++;
 				break;
 			}
-- 
2.43.0

