Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB986347FEC
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319793; cv=none; b=PRtxrIUNHP7nao5Pc7Fojw0d5DQTFnC8DZT0OADVAtbl+XClAERhqCVTHtkY3NCc0mBV3pXJXjV46EMfmMg+GKYRNGJ9u03Q7qbwGHE1ZvWSWrXojfeT08Icbq81ocoztIBw8MP04yz+NABI5VYIcwSQQs3MFzoJxc1Z5PZmkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319793; c=relaxed/simple;
	bh=Lht9vEQqB/Fmoa+XWhe3Q4RkS7MTEfMin0qo5+ocxBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOa9rPRZ7U+q0Q46I0BtP72qlheLG+22oDLAalDfsDW1UoS5HBlhn/5eyG9GDPtVSIE2/bKkhLv/4zyK6sHera0L8Lpmtm20lDEf7g6F1i7OH3I8Op69MZeBWsAYNUref1KiChcjJ8zuRc08T6UC5dhm2pFnlG9LijSfG83GfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qyk0b5J+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyk0b5J+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d71ae3455aso8491145ad.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 20:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788319788; x=1788924588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1ZdTa+YPG5R8JD3WrAQzRV0ImB3xHixQQQtd7zdN10=;
        b=Qyk0b5J+UwYync67VZuSuN1+YqLigQvCOUYPsfG7iDZcSG/E7u819tmxdQ/3gCvjEY
         Uv4EXRXlMNa/A92q7MT1BjOaqqyq2DvN3oV6m+vuwPEQDM1xSEv6k+a0FTH0iITemnu4
         i/tKLc/xcKEjLzqiOW9gzqhXQDI0di5jeOzeqdUeaV3MOQspd/XC9QiRdJgfNDL3KKSY
         YF7HIyeUMxWxq5U5jGQ5ITPkpYSpywHguXqCyvdnetG6Uf84BJR+VF4hY1p49MrTH5GV
         4QmVC7dxNYz0K2s9OUHeZr4fmKkYmW+7J8ExAPP9JSG0GTVbU01K6+vmeRq++cz0me4x
         mnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788319788; x=1788924588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U1ZdTa+YPG5R8JD3WrAQzRV0ImB3xHixQQQtd7zdN10=;
        b=UvDc++yrPMS5bIrw803ZMnnkf0JJ7Jv1PXfOAEc2P6/t0T9KNGLGEgrZWcSzJJGiHl
         2ZV63bbEEYMYZ4BdaLVfVW0su1jBpEGDfW3V/IqBNK45qNamJa7YnyRlHGgFQosIHvhl
         lEsJ2U9hdlverOBHK04WmXrufRl40oDDtIzPRGQPMZfpdxsGdJ34OUdO3ZnaryK7HsCD
         qe1MZ5fUzN+Jwn0TfVVVmJgZUWVbi0TU/EcvyJNBp7GX56yAkzJpSDNbtBpmn81+ixBF
         GGPSLi958qJJmq86pn+zOk1bFSrK+OaKXOJyv8zfiQJna27EvUCEYkTFE6XfgJ68mMEl
         pqCA==
X-Forwarded-Encrypted: i=1; AHgh+RqP4tntD2gKKRHBgR4KmzZD3ag26X5MAGTXFRiPQWtjwjCKlJEeU0w0sw7dWlTgAPzEqQM4Aq8=@vger.kernel.org
X-Gm-Message-State: AFuF++nZQLz4mIsMHuI7U1Dbr/aoRsDANiWJKCL3pZFl98FqyE2Nrktf
	R8Ov7nlqIR9HUEhvH4F/BWBy53Iu7eBMaGbsaDrvJJtMAYYNOaif0r1o
X-Gm-Gg: AYBFou2L8Z/3PnjAS8pVz+k+h5IYK3tC22AKIwVBn4uzQnWTlgj/nw54p5rrN+4SanT
	2mbHvKWwJGZhV4Cm1wwZK+6BjVS5sBCe6ofcBNRr1Gd4L/2OPC1OSyBt6kTKT/JR8VF9TkxG7a6
	XXipe2DxcAT+XN4qBRNQPfHsgLH3jk7/ZR0kKTDtCsLtF/SX2EYftWZy3fhPVCDqtMeXQPxUDY6
	qKDNRcxWMXYbhvtTjIUFcD8na9VIExgxm83GfqEpw8w84LmQg2eZ4+HVWZR0EniNysvSy8otYq5
	TG951pxYEDKoYKWJb2XpZ4Td6iRER+eP66TPv+N/fOMflqu45sbLxQnXDRmUCj/ylc6vDIac4db
	vMjwM4Ixn8tu61q7c4TCw7mk8xSWPTk4WdmVVLTl4fQYy0dk8DGbgsMcCR64RawQF9HCNrTa+6i
	WWXTlCPdrhaZ7Ueu8DvkNf4YlPJluMb97aYv2GhK2S
X-Received: by 2002:a17:902:d482:b0:2d9:1dee:43db with SMTP id d9443c01a7336-2daec7368famr25186725ad.15.1788319788333;
        Tue, 01 Sep 2026 20:29:48 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07baa594sm3099307eec.22.2026.09.01.20.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 20:29:47 -0700 (PDT)
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
Subject: [PATCH iwl-net 2/3] e1000e: fix ps_pages DMA map error sentinel
Date: Tue,  1 Sep 2026 23:29:12 -0400
Message-ID: <20260902032913.661570-3-tactii@gmail.com>
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
to recognize the case of a mapped page without a valid DMA mapping. It
also fixes a separate bug which would potentially leak pages on ring
teardown. The cleaner stops cleaning pages when h/w reported that it did
not write to a page in the sequence, leaving the following pages
allocated and mapped. The teardown would then break early and leak the
unused mapped pages. If the ring is re-allocated with similar
configuration, it would reclaim those lost pages. This would only affect
configurations with rx_ps_pages >= 2 (MTU > PAGE_SIZE) and the same
condition of MTU > 1500 and PAGE_SIZE <= 16K.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
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

