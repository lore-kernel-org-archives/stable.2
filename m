Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C603BBFCB
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022197; cv=none; b=fVjEtSSmHugP3XtplHVBJUX1WV6WHsErf3e7HqZy01C9xPckkQYJ0iCHU3lG9uVSD137CA09ntGldl4XU7wyReKMjiCZr4hUfkgheagCWLFk0u88Db0CcdmdSDgXSnjcB21PttjdfjXu5Hz6eITmEaU/7j6+SdbU1xAw6wUcT7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022197; c=relaxed/simple;
	bh=g2n9jPDJv7Yg/Kci9vpp+7RyXthVdrewD7AqiLqXHNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNvI6kibLjXJ7ErYJdpf1umSxnMSCpjke6269DlV/yQsT6QpfJkfsUWTq7C8rvX2dHJ/W6MsGoQYGTuoiArZ/wfIH4cA9gEtD5vDjhZG2g5hEwPByJcn/whxgOJ7YqvcIuHLPU2T4P5c5jaX4PzN4wDD0J8EZ1d3JMa2UVqxmDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhCdztQf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhCdztQf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso65966455e9.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 23:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789022194; x=1789626994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5RphlSgPaAb08rqh1mbaOb5Pr3zjR/JphX049e0NllI=;
        b=fhCdztQfKmvfH5I11MgvKXaWDVNyL8thhmx8AwtykPxp8/cQTa4B1147QzmCMFvAYG
         tbqiPAxz+P5aCd+I5Nga3L3660KmRGbL8Z0nW9B8jfYh/F7G1h+RFA2eUdkymryT5AbG
         Gm7fEWv073dQNCO9jHqg1xFy2oMt5UZ0cBwT7TjHVT0ubyELu0+4HSh9bNvtHiY8Bzfg
         cvdkJpRg8qYL37nSgox03g6USeOG0OVwxTB29iQhTkaEVTe5Dwrfm4ATJaGcZV5YxJBF
         asH0QP6SbbvfCYPVK9dThPpZNAMxRID/rILrKm9S+TyHW6y/B2aQAB6BDPcQ8Pb9P1hZ
         96QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022194; x=1789626994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5RphlSgPaAb08rqh1mbaOb5Pr3zjR/JphX049e0NllI=;
        b=WZQTcE2ZBdJiMg02qw6Gs9+SBDW6eJZzxA4zOfh92/JQVn1bYI5z+I8GhRxnTCwJks
         5+qTur1Jb6GiaFsiJusu1d3oz+4kO5OHSvPkNnlc5YK9cD6+c34Xp9H+W4b2CmOFeq1b
         J5pYLVXLjOLXnVhzt0AlD5dGkHfXWSNDe74w3cYGARcyTQVCp0qdx36cRBa++Dce6LC6
         2eyybnq1AMtlaqxCEYFXFwHmBSSndOmEjl4VeDuZ790bG6Kz5bDj/rURt3KXcScidyVf
         7iZkg5xvp3wX/FxhgjfS7/qO5TO4BHupTl0XYEa+9FNF/fd2CAFOc+ZEVr/OWWkYRcv0
         +3UA==
X-Forwarded-Encrypted: i=1; AKwUvBwf41f5rmVUChzc567wCUR5vV9Rzl5hvzGbJpicKBkH+Nh88GbFD6majhnok59IdA5NOGIeIvM=@vger.kernel.org
X-Gm-Message-State: AFuF++kgSh5FtICXC+oTTvc21N8ydbmag8O+ERdZhjzOVMaWyd87Tyap
	uwLPxIfvOodKqNJilzj/VAfMcm/5X+3GCaS41CtKUkHZLI7Jkza+JSHFJooB5x1s
X-Gm-Gg: AYBFou2Ji2KDeqVBSGCvIaJyh2IsGF08NknzO2oiorwenXNWKQslJC/+Ah4Dzvyf9i3
	yjiWFfxqiZMPm5Etz50s+KA5LJK3XXd3Y/3DDD22UD1dkk+hPMJ8Xn5BULmT+9yyJVpcHOj55iA
	2idJYScAU7/SG+xk9kDo1QS56Vfg6Whof9qJjuhhf1KI7O8Ml+PZkWxmVyqv7L5dcWBsa8ar5Xy
	TgD2AXe407w5osP0IgBmjphpzWzGBszL2wfDUCsj+JKuYDEE3Ni+BpH5a5OYWGieeH6Jb8zul/x
	5fBVrK171aOhHdDVMhxvuRRJMW4entOXK6lYX6GkTw0BAk+utHmsPHXVZFrKm2I8zJ/hzm5g7hL
	XzU8zI6oZG4t7UHe779PdDK3xiwgDlwnmuufiA+1NfNlWNnSg98jWXHx8XZADguB9Aci2of0snO
	VPWv7J/o/pu52spIt2rN/xJEkoG5GNIj8Af27GwOqBYeb2mPxmYECP8NvVF5HcDRspyCeamCJWZ
	cRXdYNig4NQ4OxQrfZn1EJrJRjhO+yNR+FJf04x6Uqz/jdwJGcbxwFXsMpRL+Y/Lyn3nPhXPnDX
	2YACnsQXMzKrNO3hetd2TQJ62+Sy6dKvSPlsS3m67ZIKkEb+OglKFLKFQjihOf6E/YU4KHZeEpo
	Q0dkYc2K9/O8OHE4=
X-Received: by 2002:a05:600c:a44:b0:49c:dcec:bd27 with SMTP id 5b1f17b1804b1-49cf821e7a5mr369870615e9.8.1789022194212;
        Wed, 09 Sep 2026 23:36:34 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b3d9-b901-0402-5aad-0ef4-88ac.310.pool.telefonica.de. [2a02:3100:b3d9:b901:402:5aad:ef4:88ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26bfdb4asm47766655e9.11.2026.09.09.23.36.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 23:36:33 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@lst.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ARM: dma-mapping: preserve DMA_FROM_DEVICE buffer contents
Date: Thu, 10 Sep 2026 08:36:19 +0200
Message-Id: <20260910063620.17768-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260910063620.17768-1-kmehltretter@gmail.com>
References: <20260910063620.17768-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The v6, v7 and v7-M cache backends invalidate DMA_FROM_DEVICE buffers
when ownership passes to the device. The common outer-cache path does
the same. On a write-back cache, invalidating a dirty line can discard
CPU-written data. If the device writes only part of the buffer, the
untouched bytes can expose memory contents older than those present at
the handoff.

A mapping-only test on an ARM11 MPCore (ARMv6) system reproduced this
through the v6 path. The existing code lost 402,080 of 409,600
CPU-written bytes over 100 iterations. This change lost none.

Clean the inner and outer cache lines for the buffer at handoff. The
existing completion path still invalidates them before the CPU reads the
buffer. This matches arm64 commit c50f11c6196f ("arm64: mm: Don't
invalidate FROM_DEVICE buffers at start of DMA transfer") and adds no
cache traversal.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20220606152150.GA31568@willie-the-truck
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm/mm/cache-v6.S          | 2 --
 arch/arm/mm/cache-v7.S          | 2 --
 arch/arm/mm/cache-v7m.S         | 2 --
 arch/arm/mm/dma-mapping-nommu.c | 5 +----
 arch/arm/mm/dma-mapping.c       | 8 +-------
 5 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 5ceea8965ea1..149042bac423 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -283,8 +283,6 @@ SYM_FUNC_END(v6_dma_flush_range)
  */
 SYM_TYPED_FUNC_START(v6_dma_map_area)
 	add	r1, r1, r0
-	teq	r2, #DMA_FROM_DEVICE
-	beq	v6_dma_inv_range
 	b	v6_dma_clean_range
 SYM_FUNC_END(v6_dma_map_area)
 
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 726681fb7d4d..22897f98cc95 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -441,8 +441,6 @@ SYM_FUNC_END(v7_dma_flush_range)
  */
 SYM_TYPED_FUNC_START(v7_dma_map_area)
 	add	r1, r1, r0
-	teq	r2, #DMA_FROM_DEVICE
-	beq	v7_dma_inv_range
 	b	v7_dma_clean_range
 SYM_FUNC_END(v7_dma_map_area)
 
diff --git a/arch/arm/mm/cache-v7m.S b/arch/arm/mm/cache-v7m.S
index 7f9cfad2ea21..3ea5f047f43e 100644
--- a/arch/arm/mm/cache-v7m.S
+++ b/arch/arm/mm/cache-v7m.S
@@ -432,8 +432,6 @@ SYM_FUNC_END(v7m_dma_flush_range)
  */
 SYM_TYPED_FUNC_START(v7m_dma_map_area)
 	add	r1, r1, r0
-	teq	r2, #DMA_FROM_DEVICE
-	beq	v7m_dma_inv_range
 	b	v7m_dma_clean_range
 SYM_FUNC_END(v7m_dma_map_area)
 
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index c6a70686507b..a396bbceee73 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -18,10 +18,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 {
 	dmac_map_area(__va(paddr), size, dir);
 
-	if (dir == DMA_FROM_DEVICE)
-		outer_inv_range(paddr, paddr + size);
-	else
-		outer_clean_range(paddr, paddr + size);
+	outer_clean_range(paddr, paddr + size);
 }
 
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7761099dde9e..e2df8b680bd6 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -681,18 +681,12 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 {
 	dma_cache_maint_page(paddr, size, dir, dmac_map_area);
 
-	if (dir == DMA_FROM_DEVICE) {
-		outer_inv_range(paddr, paddr + size);
-	} else {
-		outer_clean_range(paddr, paddr + size);
-	}
-	/* FIXME: non-speculating: flush on bidirectional mappings? */
+	outer_clean_range(paddr, paddr + size);
 }
 
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 			   enum dma_data_direction dir)
 {
-	/* FIXME: non-speculating: not required */
 	/* in any case, don't bother invalidating if DMA to device */
 	if (dir != DMA_TO_DEVICE) {
 		outer_inv_range(paddr, paddr + size);
-- 
2.53.0
