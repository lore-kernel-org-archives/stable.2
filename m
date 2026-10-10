Received: from mailfilter02-out30.webhostingserver.nl (mailfilter02-out30.webhostingserver.nl [195.211.72.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200D4BFE84
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.211.72.193
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661238; cv=pass; b=dYqhac9vnwn5mPsjmn59TOofZVmdzvE1TBU4OOcLMWBrq4IHCKW+4gHdtXFzfdjS2IzItP8GCRn85iIsqRh4snf5pStnx+LH2xu5orzvuNi+VYWK6nLfte5Zt4zmhBCiOC0Ji6xqbGf+tIKBxGcz3BA8246fyWzaKE+TBxuEJTQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661238; c=relaxed/simple;
	bh=k/0zE+mpbcaCWS4J7eInSaDNJol/x9qXdkh/tRfx32U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uEvd24V9q8fjCv9M3JquYtXfUzr/7EtL6JEFsMiPZ+MWJoUAFSWip/Tm3kRwJhErwd5XD0qpnd0+N05XcNsYTpJmOyh1son1aTUycakw8aAEVHyjKRwiacuewjyD2FXng3HZfZxCQiUDKGr85AwytRPj0XqdEqm3rhWcOVnfgdk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl; spf=pass smtp.mailfrom=exalondelft.nl; dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b=oNIuwAUS; arc=pass smtp.client-ip=195.211.72.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exalondelft.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exalondelft.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exalondelft.nl header.i=@exalondelft.nl header.b="oNIuwAUS"
ARC-Seal: i=2; a=rsa-sha256; t=1791661157; cv=pass;
	d=webhostingserver.nl; s=whsarc1;
	b=bEoZUKb1q9W5C339vGnmC3FkuMXuG0btCeTCW78+doj7VctyntYj5SsAC/qDgXoAAzui9+0Zn/WYX
	 FHSqVQLL2ABMk1CYxFi6DXqJ6nM0wNMeZZY/44E/N5F01DwtzdRwTZ+kE2CKw6PMBLUaCmXqg0KdFw
	 p85tkvIyMOi5k86Ma/NSwQb//KJdonx7Km5EXmEaR0pPmL1RzsxJZV65mxtN6TVXfuiPGbx5pHMUUa
	 9HxR9/PkqhSM5GYr324knjLnnWGIIC94BvkjpnXOni5xN/zl05gpS930Evah3ZB4zG9qt4janqGBaa
	 klY9TS5zUiEiu+5x1waPYg9TbJlW5BA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
	d=webhostingserver.nl; s=whsarc1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 dkim-signature:from;
	bh=Gsgp9tM9e1vhAPkIjoBTu9Bl+2xqVcbGFvF3ZGmMaY0=;
	b=rMmbRs9tRlVvfc6Qwh+CMHy5ACrFj/j9IMyjo5GiE9nS2xrM0pzBY26APLLIqhNIhhxIeUPRq98JH
	 4tL4hvYWvSABzZgdKZYe1QOHAjMCL6KV8XYeO8UbrYqZJefynAQDBpD6G+qhnwC/cuGkITnG7awH1e
	 PdWPgV3v0aFB/Z7jX6S0UQzzhoihdEjUmkZt+UNQwK8sbSAHEzvC8PRorOoiu+MYMIeh1uCSwKIlGk
	 BiXRU0h5KfgJENn6Jq151PocGMHClMURHsWKWjVsn+IEgdACY9VchPwbgiymDtuwFpPJM5klUhJTUZ
	 hrZ92eTUaC3vJD1wJk8IMld1vKNFfOQ==
ARC-Authentication-Results: i=2; mailfilter02.webhostingserver.nl;
	spf=pass smtp.mailfrom=exalondelft.nl smtp.remote-ip=141.138.168.154;
	dmarc=pass header.from=exalondelft.nl;
	arc=pass header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=exalondelft.nl; s=whs1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=Gsgp9tM9e1vhAPkIjoBTu9Bl+2xqVcbGFvF3ZGmMaY0=;
	b=oNIuwAUSt3wKS8v4QJP/MmRWvwnJZ8BEp6MPGmPBxeQnz+vEDGidcYNAGYuiSMWRK2DG//lyh/mrr
	 InrqxbkaEdQPP3+m8Jj5y77hNHh8baVhog4l+zGDHlPx7Fyz6HoPP7AavBvx0pF1xci2TgyE3GVBPq
	 I5X59Y59FMACUMpydCqFw+3lxgZFcCbB/MFWN1TObLbOHlqhzLkclTQWliz447V92oiELKpYl/NZgP
	 t2MWIS7xi2zDXf+ac+zX3ywyNLzCJ/d3sKJ6UOAg/AmlSt2yMG0NSi8bkIxQlHDLbawkany2H9M3RZ
	 U4X6ndCzNELyz/psUyNOHb2ZHRBQYDQ==
X-Halon-ID: 4688c69e-c4e2-11f1-b65c-001a4a4cb922
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
	by mailfilter02.webhostingserver.nl (Halon) with ESMTPSA
	id 4688c69e-c4e2-11f1-b65c-001a4a4cb922;
	Sat, 10 Oct 2026 21:39:15 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=webhostingserver.nl; s=whsarc1; t=1791661155;
	 b=zJKbJtRFPacOuEK4xI7KNkvj9jZVyX8OMpPi1RMGemJiZ6bBFBzlsnz20THjlcmegk8WAzy0UF
	  kRkGemAkNRjH0rVssZKEx17FTUQsJGAapjlx6+ZBBjgamnIT4XVjqED3x2D2CpRYXUaNWzaHeq
	  DmBrKSHh2yAEFyLEIEEEX1RcPXbZWdKva9zZYoUJs8XBqM9SRHTYH3XnRf+Fk9KsATDBteNG57
	  E3ci61Nz5L+pgKoz3iXTotiPJy4XcP8KzyiK4rkY50jBBKHbU9PjGXQf5nBoiz45m523XJ5xVR
	  Rxf13jT5RWsTpEBXAFQ3T6cC2fz/Yrvd5NiTYeQnUDEByA==;
ARC-Authentication-Results: i=1; webhostingserver.nl; smtp.remote-ip=2a02:a466:68ed:1:4b1e:abe0:4124:3c9d;
	iprev=pass (2a02-a466-68ed-1-4b1e-abe0-4124-3c9d.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:4b1e:abe0:4124:3c9d;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=webhostingserver.nl; s=whsarc1; t=1791661155;
	bh=k/0zE+mpbcaCWS4J7eInSaDNJol/x9qXdkh/tRfx32U=;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From;
	b=IF2j1HVpN7j1CkWMht9PXXhLVEFbz4mbmHep87ConlZhlEjuEOWWCwImwAtf87yKVpCTIBtHpY
	  2GTSBCZMqsphyst7ddEjP8An9m3cINJvVejZYaRU5hyGpYVlpiIQJx1UFR04D50fpUm+iPYPil
	  Z6F2dY8V81TCIj3pG4ox2+0c973SQ8cLuGmdv50+A1wjUdUbqF4rhWuob+GnY2B56zbnMYGViC
	  DoVW5kAPG+ir9oqa86B6u+WwzNfVvGSQlJo+hp/0DdDGWrlMIkoYukyFgdL0KYVu9aWwEU05TV
	  3lhTjCIueLOGy6eo+flqPrigXzcImWnv4T8tlxwI+Ga+7A==;
Authentication-Results: webhostingserver.nl;
	iprev=pass (2a02-a466-68ed-1-4b1e-abe0-4124-3c9d.fixed6.kpn.net) smtp.remote-ip=2a02:a466:68ed:1:4b1e:abe0:4124:3c9d;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=exalondelft.nl;
	dmarc=skipped header.from=exalondelft.nl;
	arc=none
Received: from 2a02-a466-68ed-1-4b1e-abe0-4124-3c9d.fixed6.kpn.net ([2a02:a466:68ed:1:4b1e:abe0:4124:3c9d] helo=submission)
	by s198.webhostingserver.nl with esmtpa (Exim 4.100.1)
	(envelope-from <ftoth@exalondelft.nl>)
	id 1xFcuY-0000000FlNz-3TS3;
	Sat, 10 Oct 2026 21:39:14 +0200
From: Ferry Toth <ftoth@exalondelft.nl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Ferry Toth <ftoth@exalondelft.nl>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] Revert "serial: 8250_port: Drop duplicate NULL check"
Date: Sat, 10 Oct 2026 21:37:56 +0200
Message-ID: <20261010193755.187706-2-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

This reverts commit 7885af04df6e4efd72910200c1bfc079d61202e4.

Commit 7885af04df6e ("serial: 8250_port: Drop duplicate NULL check")
added `up->dma = NULL;` to serial8250_release_dma(), with the stated
intent of making sure DMA would not be used again after release.

However, up->dma is assigned once at probe time.  serial8250_do_startup()
only calls serial8250_request_dma() when up->dma is non-NULL, so after
the first close the pointer stays NULL and DMA is never re-acquired.

On Intel Tangier (Edison) with HSU DMA this causes a regression: the
first port open uses TX DMA, the second and later opens transmit in PIO
mode, producing 64-byte FIFO bursts with ~50us gaps between them.

Fixes: 7885af04df6e ("serial: 8250_port: Drop duplicate NULL check")
Cc: stable@vger.kernel.org
Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 38fa45e74a37..19d0663ee756 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2428,8 +2428,8 @@ void serial8250_do_shutdown(struct uart_port *port)
 
 	synchronize_irq(port->irq);
 
-	serial8250_release_dma(up);
-	up->dma = NULL;
+	if (up->dma)
+		serial8250_release_dma(up);
 
 	scoped_guard(uart_port_lock_irqsave, port) {
 		if (port->flags & UPF_FOURPORT) {
-- 
2.53.0

