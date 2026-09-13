Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097E2381EBC
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319791; cv=none; b=tIsivaV9n3QSwBBkny9gqeq4KNXr/BXcv2tCq/k7oJPdLuun4O2mAkTKc08LfBMX4+b/ZETYUIliLJ5qVbHPMABI6kcnThqGiKe2N9IDuCHa5P6Jm3ROsY88AFq72iKZRJlP2d0kaIMuJQlUrHehWHYuIbJZ2LZN1ERnPueKR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319791; c=relaxed/simple;
	bh=oEcgvmIyfYBLevyhw2K4Zwm3fUR/mdJbCzW0J0IO+e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKoueOkuqspwXlKMfiHooWoGBFtt6Fx7Frm7yjYabGThn2FKPYHVbqyJo+M0KplYI5xJleRHv0eIHf4wCFGWXg/2llG/jlSO82fCxYRz0E6Ig2r5Is4Ezac7AJbiFul78s81+KFnvqLm6DDBCWqjVGVHEOEe60kJ+FY90ZSPAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoDboo+5; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoDboo+5"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43ac8d1dso5145967b3.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789319787; x=1789924587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nm14xqAcjp/Z6XZ00s6jk3HYTG3m5Se93UscFbQ0Cj0=;
        b=QoDboo+5LAC84Ww5saQwQ2DL6XH043BO7qB8Vr6NOYiHqT0T4FQwQx+E1lPWKglMt8
         a218Gr6FsUtVYA7X7H3O37G0flb3sEypI1fVxl+P0VJu7Eh91ON4CfI6uVO1KMOxikwP
         7pBXo7Y6JOhZeBwrXay0CrIyfELzlBT803qYVaa6Hm4rOMDZ0KRY6oQ85vmi9a+f3WuM
         v+GRgdKNRbe2oPKradHO9Glr4pUZst09Epk7drVGIqpj0SuyWbroiP7LnCcx55bFJ70f
         wF0AWumtCk3WvL4tGVJ3WzLeHBEkNiZ/D26OxB/+DrXCOd7RapiX/pZdXBHXkpH2h76W
         jHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789319787; x=1789924587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nm14xqAcjp/Z6XZ00s6jk3HYTG3m5Se93UscFbQ0Cj0=;
        b=T+gfjqbAFMk+quO9GvvGcHBvo5Lqwr4x5HeIj40U3TZHzbeR3q4VC+f4bC3R2zsvbc
         y5oB9Q4rAth0cc5RIM1kS9VmsnZFLhjgpbsBj2hiTCd2nI177+vGSZSJWuswIa3SFrpT
         dXDpYomTdSiMwu9yh1R1OrwsFiEYRTh/YDeQN1J//f4DHI5zP/dmuFrj5JMlMZKao5XS
         1QkeuYNJfjm2r1f2Z9UsVJ7CF5TdDRKgKkUc7y+13U5efwDSqI719B9OPcbTKCisUVD8
         yLHhPwIpliRAoSt24HLyo2qZlWKmTm8IGcBObb4IhAshIEJx4ZxqBya5P3oiXtjuMfiN
         q1Ng==
X-Forwarded-Encrypted: i=1; AKwUvByvq54C+qsHEruAf0nK3/R+CervDribMj1OdoKradmqL4Nmc4Ps4vIrniGM2hyQTWRarh+v1IY=@vger.kernel.org
X-Gm-Message-State: AFuF++mQkES6T9C4T3oFNahFn3S5tlmT1BvuqBCCbhkVYgZx93TTS+7o
	iZL5iuqASbgvYTsjKpamJ/YFA/eBcJVIPsgf7CG4p7GxEXQjr2FAoY+u
X-Gm-Gg: AYBFou2T9rX7B2b9wevXFcAYrj8j/aJZibEyMJiEovGDDKLuPwebFkLn1p8yO4cAe27
	IF/cxF2Cs0QxbXg0w1yRTz0FuZPcSecSnwwq7/uNb64dqnstonjnke1dUuLWGInYOBuzhbUpaJx
	2DYtNeuNqtBgJ5bSaLuXK/XgUOmnFKy4OUHkA3C9okLzS0LQG/NvLa7YbM+eSfgJOBWvJ3av7FZ
	jWeeAK8yk4ig5NsnvwHnZ95sd+w0xhDaFoSb7V/XvmWAosdjtxR2d42BSNTgin2nRW6QIDTKaEh
	3BhK9wbBYoQmMDVS+pg+twLxG58OVi7EobfTJwtUgekKFWUUDhqJzxem3ve5V6uhx2ajxSLeLjl
	icaPF+XaQooVsvrX659f/b4kZ7WybL4ZIPQK+TpgrG8rZ39xjk08yr/30eLNpKDXeyKl8WIkm07
	oGoaNAFGiY0svor36eDZdVeOfnpThDwc3tMzPHXQlEpDB/ujPR+orv4XC+bOikcUox11JE7oYL
X-Received: by 2002:a05:690c:6b01:b0:873:5c0f:28c with SMTP id 00721157ae682-887ae01b17cmr16218647b3.54.1789319786757;
        Sun, 13 Sep 2026 10:16:26 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8847db4476bsm29210607b3.5.2026.09.13.10.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 10:16:26 -0700 (PDT)
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
	Matt Vollrath <tactii@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v2 2/2] e1000e: fix ps_pages DMA map error sentinel
Date: Sun, 13 Sep 2026 13:15:55 -0400
Message-ID: <20260913171555.89537-3-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913171555.89537-1-tactii@gmail.com>
References: <20260913171555.89537-1-tactii@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While allocating packet-split buffer pages, a failed DMA mapping would
leave DMA_MAPPING_ERROR in the ps_page->dma field.

This would have two consequences:
* The next attempt to allocate that buffer would write DMA_MAPPING_ERROR
  to h/w if all pages are allocated. If the h/w uses that buffer and is
  handling a frame large enough to touch the affected page, it would
  cause a DMA fault and be dropped. The driver would then call
  dma_unmap_page() on DMA_MAPPING_ERROR and unknowingly send the
  uninitialized page up the stack as part of the frame payload.
* On ring teardown, dma_unmap_page() would be called on
  DMA_MAPPING_ERROR.

This condition is only reachable when MTU > 1500 and PAGE_SIZE <= 16K.

Fix this by setting ps_page->dma = 0 upon mapping failure and separately
testing ->page and ->dma during allocation and teardown.

The rewrite of the ps_pages section of e1000_clean_rx_ring was necessary
to recognize the case of an allocated page without a valid DMA mapping.
It also fixes a separate bug which would potentially leak pages on ring
teardown. The cleaner stops cleaning pages when h/w reported that it did
not write to a page in the sequence, leaving the following pages
allocated and mapped. The teardown would then break early and leak the
unused mapped pages. If the ring is re-constructed by down/up with
similar configuration, it would reclaim those lost pages. This would
only affect configurations with rx_ps_pages >= 2 (MTU > PAGE_SIZE) and
the same condition of MTU > 1500 and PAGE_SIZE <= 16K.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
---
v2:
* Reword last paragraph of description.
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 26f45ee8c7e7..063fc8cd2673 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -759,12 +759,15 @@ static void e1000_alloc_rx_buffers_ps(struct e1000_ring *rx_ring,
 					adapter->alloc_rx_buff_failed++;
 					goto no_buffers;
 				}
+			}
+			if (!ps_page->dma) {
 				ps_page->dma = dma_map_page(&pdev->dev,
 							    ps_page->page,
 							    0, PAGE_SIZE,
 							    DMA_FROM_DEVICE);
 				if (dma_mapping_error(&pdev->dev,
 						      ps_page->dma)) {
+					ps_page->dma = 0;
 					dev_err(&adapter->pdev->dev,
 						"Rx DMA page map failed\n");
 					adapter->rx_dma_failed++;
@@ -1722,13 +1725,15 @@ static void e1000_clean_rx_ring(struct e1000_ring *rx_ring)
 
 		for (j = 0; j < PS_PAGE_BUFFERS; j++) {
 			ps_page = &buffer_info->ps_pages[j];
-			if (!ps_page->page)
-				break;
-			dma_unmap_page(&pdev->dev, ps_page->dma, PAGE_SIZE,
-				       DMA_FROM_DEVICE);
-			ps_page->dma = 0;
-			put_page(ps_page->page);
-			ps_page->page = NULL;
+			if (ps_page->dma) {
+				dma_unmap_page(&pdev->dev, ps_page->dma,
+					       PAGE_SIZE, DMA_FROM_DEVICE);
+				ps_page->dma = 0;
+			}
+			if (ps_page->page) {
+				put_page(ps_page->page);
+				ps_page->page = NULL;
+			}
 		}
 	}
 
-- 
2.43.0

