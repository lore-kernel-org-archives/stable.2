Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.180.195.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623233;
	b=cK8JjdG04G3SxoV2avxmxr1dbeSCM8RxwQFQfJ5ctPwcLbTegI8Z2bSa5ZKPnzZELWHR
	 pp8K5d5oSSASG2LoyxqQyr4Yo7LLfakOyUaNzRRz63whEFc81uknXbe0Z/KtQLbgq/tLq
	 VwfPQupPc7BGNsfpCVmm9RhxbHkRy4EZdE1jhxt1EpC+UhjFcnmZKVIccr8UlxrEYfsJn
	 UQcoJZXDHwLxuvUMCEhyHwcQH1V4iZpK2fQztfSXv2P8AcL2xzJcRayhGTROiOmeYmY8j
	 mUlXHgZGsBrXfI+0/2YpkwbxL5d5uGjHvUSwVSarWGwnXj5c8SYKyEEGm+61B/og6ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623233;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=fKiB7MDV6K7Y+SUfBzfSXx7nhfpSuibLuHtz+aDsyHw=;
	b=dPnfxwIXPYI6Au9XiwSy8o90ShJLuoXYbVgK2dXk40ZilWH9B29wXbCKnTh/iuXTum+v
	 Sb17O0T7/sve6wlCcnECKVmK5NHSPO8KAejcVRlQVh143hmUCEZp0h7gNoWqSwJLav3Hm
	 0ePo8eWGYS9DCIq6n9ZoepVhRWg0OfTSGmwbMdu/NMzbF4/swYqx/ArTj4reZLUo9Wg6f
	 7FgweDhqqpFU+moAshGOGc0k13FHtDGqzfuwVWPBe3t6Y1eb65+0uC+Jh6a2GQ3jqRRxt
	 xi47qwKtx3cSXydT6uyFm6lAuU7KU7bIyKKkbY3K1HuGM4KPqpZ5NJRBmjDjtWd+3Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mkio.de;
	spf=pass smtp.mailfrom=mkio.de;
	dkim=pass header.d=mkio.de header.i=@mkio.de header.a=rsa-sha256 header.s=default header.b=X7lHcZcK;
	arc=none smtp.remote-ip=207.180.195.6
Received: from mail-relay.contabo.net (mail-relay.contabo.net [207.180.195.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C8606A31E;
	Wed, 25 Nov 2026 16:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D0C8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mkio.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mkio.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mkio.de header.i=@mkio.de header.a=rsa-sha256 header.s=default header.b=X7lHcZcK
Received: from pxmg2.contabo.net (localhost.localdomain [127.0.0.1])
	by mail-relay.contabo.net (Proxmox) with ESMTP id AECFD7C1861;
	Wed, 25 Nov 2026 17:13:43 +0100 (CET)
Received: from m2731.contabo.net (m2731.contabo.net [193.34.145.203])
	by mail-relay.contabo.net (Proxmox) with ESMTPS id 594247C1854;
	Wed, 25 Nov 2026 17:13:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mkio.de;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fKiB7MDV6K7Y+SUfBzfSXx7nhfpSuibLuHtz+aDsyHw=; b=X7lHcZcKEiNSISWcZYoOhSsVO0
	1BayDYDIOUM5iuY9j29Ku95s6BgKPaddCh1IDxeKtiHjdE5MvIKjeABwRYiAcA07V3mNwbbsvaQOk
	Az3NPJ+/z9bYPnWzXx6yZ99+moz1JZvJ1AnJVd5MvwwbvkHxfPUrtRlNyV+dVt58DrbLRitZBNzMo
	9YAW4W1p+ux7cxoeD2wBc1Ud1YjahOf3zIwWxppLNlWsE9jyhZaYyzDGvqnestXwl2Np0Nhjk9yXM
	ZthmN37PWbYrYz/oeP3CBFqEmj/obxjoKeaoO61X2NoxgKIksehCNi1qfWyY8kgPmCUjWwRDriIbu
	YVhyiW4A==;
Received: from ip-078-042-120-089.um17.pools.vodafone-ip.de ([78.42.120.89]:61715 helo=p14s.int.kistler.com)
	by m2731.contabo.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <mk@mkio.de>)
	id 1xWFct-00000005rgs-2UOI;
	Wed, 25 Nov 2026 17:13:42 +0100
From: Markus Klotzbuecher <mk@mkio.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Sahaj Chaudhari <sahaj123.sc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: omap2-mcspi: lock the DMA request bit updates
Date: Wed, 25 Nov 2026 17:13:40 +0100
Message-ID: <20261125161340.1218564-1-mk@mkio.de>
X-Mailer: git-send-email 2.53.0
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
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - m2731.contabo.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mkio.de
X-Get-Message-Sender-Via: m2731.contabo.net: authenticated_id: mk@mkio.de
X-Authenticated-Sender: m2731.contabo.net: mk@mkio.de
X-Source: 
X-Source-Args: 
X-Source-Dir: 

omap2_mcspi_set_dma_req() does an unlocked read-modify-write of the
cached CHCONF value to set or clear DMAR/DMAW. On full-duplex DMA
transfers the RX and TX completion callbacks both call it to clear
their own bit. The callbacks are invoked from the per-channel dmaengine
tasklets, which can run concurrently on different CPUs. One of them
can then write back a stale copy that still has the other's bit set.

DMAR or DMAW then stays set in the cached value and is written back by
every later CHCONF update. With a stale DMAR, the next PIO transfer
times out waiting for RXS and the next RX DMA completes early.

Protect the read-modify-write in omap2_mcspi_set_dma_req() with a
spinlock. All other CHCONF updates run in the transfer thread while no
DMA callback is pending, so only this helper needs the lock.

Tested on a TI AM625 with linux-stable 6.18 PREEMPT_RT, a device on
McSPI2 CS1 at 50 MHz and four spidev transfers per cycle, the larger
ones via DMA. An instrumented kernel that flags stale DMAR/DMAW on PIO
entry reported more than 720 stale bit events and DMA transfer errors
in 15 minutes without this change, and none over an 11.5 hour soak
with it.

Fixes: 53741ed8f0a3 ("spi: omap2-mcspi: add DMA engine support")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Klotzbuecher <mk@mkio.de>
---
Tested on 6.18.y with commit c126e07bde21 ("spi: omap2-mcspi: handle
DMA setup failures"); omap2_mcspi_set_dma_req() and the DMA callbacks
are the same on spi for-next. Compile-tested on spi for-next.

 drivers/spi/spi-omap2-mcspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 061d50c65dfd..b1d3b8447d0b 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -118,6 +118,8 @@ struct omap2_mcspi_regs {
 
 struct omap2_mcspi {
 	struct completion	txdone;
+	/* serializes the DMAR/DMAW read-modify-write of the cached chconf */
+	spinlock_t		chconf_lock;
 	struct spi_controller	*ctlr;
 	/* Virtual base address of the controller */
 	void __iomem		*base;
@@ -205,8 +207,11 @@ static inline int mcspi_bytes_per_word(int word_len)
 static void omap2_mcspi_set_dma_req(const struct spi_device *spi,
 		int is_read, int enable)
 {
+	struct omap2_mcspi *mcspi = spi_controller_get_devdata(spi->controller);
+	unsigned long flags;
 	u32 l, rw;
 
+	spin_lock_irqsave(&mcspi->chconf_lock, flags);
 	l = mcspi_cached_chconf0(spi);
 
 	if (is_read) /* 1 is read, 0 write */
@@ -220,6 +225,7 @@ static void omap2_mcspi_set_dma_req(const struct spi_device *spi,
 		l &= ~rw;
 
 	mcspi_write_chconf0(spi, l);
+	spin_unlock_irqrestore(&mcspi->chconf_lock, flags);
 }
 
 static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
@@ -1630,6 +1636,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	mcspi->base += regs_offset;
 
 	mcspi->dev = &pdev->dev;
+	spin_lock_init(&mcspi->chconf_lock);
 
 	INIT_LIST_HEAD(&mcspi->ctx.cs);
 

base-commit: 266ae6df1980a5a5c58735ae114ae62a2acad8db
-- 
2.53.0


