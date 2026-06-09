Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D29047F2D4;
	Tue,  9 Jun 2026 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018966; cv=none; b=Rp+HSKhPWZD8HLZoxEUXLqSXtK0B70jSJhopgfcXHZExzjsElpFJPUzKxce6q//t0y7TXxiQsbY/OwhRhIZsOznDNqmK+eSPZ9Lv2awhPiKAaxFJFK9hJW/OR2tRYPFZMsj4SvgCgp5zMqpmyrIolSuxwNhJX6XUoKvAavtdBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018966; c=relaxed/simple;
	bh=Hf3NUFTPdlpBckTP5tVrDmcFEZZmCKf1Y+qeXrTx6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kdK/W2NgbUa3ShAkTSbUM/wMx2LVIig4nWdS3O57nY4SFzruPDvLXrv6wlH3Adx/fG2PSWEpYZNPiTx59KukuunFrbdVggScg3OnFl6DYkhmSq1MTWvROvhgKXy9jmjrTFtcvMfkqwx6Annhc93k7a+77xudIP7g+VHScHMZDRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=Gpdm53dH; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Gpdm53dH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1781018962;
	bh=Hf3NUFTPdlpBckTP5tVrDmcFEZZmCKf1Y+qeXrTx6lQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Gpdm53dHk42Xo4ZX2nd8sW92GOs5ztQb9unPiXuQ11pbqgoKraldRUxfeKq34WFEr
	 zKtW9yR7StSn8L0Bu46FgiDi8LcRFUI/M1Me/Y2XylhHZ2SsX/qZNLLECEOfjS/CvC
	 R4oCXxPP1HAtgkL5yYfbU/MdDAQ1T4m+WvJWc/Ds=
From: Paul Cercueil <paul@crapouillou.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Paul Cercueil <paul@crapouillou.net>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_fs: Fix DMA fence leak
Date: Tue,  9 Jun 2026 17:29:05 +0200
Message-ID: <20260609152905.729328-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ffs_dmabuf_transfer(), a ffs_dma_fence object is kmalloc'd, with the
underlying dma_fence later initialized by dma_fence_init(), which sets
its kref counter to 1. Then, dma_resv_add_fence() gets a second
reference, and a pointer to the ffs_dma_fence is passed as the
usb_request's "context" field.

The dma-resv mechanism will manage the second reference, but the first
reference is never properly released; the ffs_dmabuf_cleanup() function
decreases the reference count, but only to balance with the reference
grab in ffs_dmabuf_signal_done().

The code will then slowly leak memory as more ffs_dma_fence objects are
created without being ever freed.

Address this issue by transferring ownership of the fence to the DMA
reservation object, by calling dma_fence_put() right after
dma_resv_add_fence(). The ffs_dma_fence then gets properly discarded
after being signalled.

Fixes: 7b07a2a7ca02 ("usb: gadget: functionfs: Add DMABUF import interface")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/gadget/function/f_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 75912ce6ab55..7cc446502980 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1704,6 +1704,7 @@ static int ffs_dmabuf_transfer(struct file *file,
 	resv_dir = epfile->in ? DMA_RESV_USAGE_READ : DMA_RESV_USAGE_WRITE;
 
 	dma_resv_add_fence(dmabuf->resv, &fence->base, resv_dir);
+	dma_fence_put(&fence->base);
 	dma_resv_unlock(dmabuf->resv);
 
 	/* Now that the dma_fence is in place, queue the transfer. */
-- 
2.53.0

