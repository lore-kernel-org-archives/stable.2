Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793178358;
	b=2KbS6hiKuazBeObZCX2JHi2qI6bzHwap3M0ndBLe9uV+PkozreTXBzJY7thVYGKMGDhn
	 FeH63jNXu+T8xxJsxj23Ir5pysWG5v9TU8u5ztiqpkVzlNE3346iYu477MpBUF7aciedo
	 yQHLjYtOx5ckEWANCsuUzqzrvM/I+58WHSdUX75QCxkvlEPzq9HqJooRUD2zZriGOXp++
	 y/gFyLn8q08Gq8ga6wO/Xd05qNRljCDEWm9SODrw628H1bUiiRb6PvSDtdb1Ubs+wjIGD
	 Sz4dDJyNgI+3949i24WV8bSgFwar38/8SWy5mmX//WzahntbnevSBxX634mWkK1U6RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178358;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=GP87V0isCS9npBsUJzfzavKuNiOHWjoeDoQLqqwgJds=;
	b=Bc4aLblZIYCPtHxYQeyVoT/pxrvKgQlhws+oeRBQhfitttgvueA/+Y2R7J9htPWMWJWV
	 YSnnosXJcw2Qj3TW99qh3HaYJ8kKxG9z09xeLakB/MKyRTpCRcg0sPS0bWdUCnfKOOvn0
	 mK/JObTpPzKisA0M+esuL2QYdv1xb4uIjsJ26iS6E1SkCToKTwcZo35+5G1lxXS+psYgi
	 8ptTJpmmdu3DTb1pQaVLY5kHEZmIkynfUo9FbWYe51eSu1xUtHkHISuKCD7F1DqdcTRcd
	 eVju9PzPT6ov1rQcoqhSnnhlNXKjYSocJPItfXTgr/PsrSs26FRmNK+qkBxgnXHS2Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=pDof7GBD;
	arc=none smtp.remote-ip=117.135.210.6
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76053606A31C;
	Wed, 28 Oct 2026 09:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76053606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=pDof7GBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GP
	87V0isCS9npBsUJzfzavKuNiOHWjoeDoQLqqwgJds=; b=pDof7GBDaWXL3uDptu
	p7woJJuDQ930CWjRgR0+CEeJFipKk43uTZkpglPzlkjsoIyoYpCi26fCgrq4jhg2
	BXRnZBEi8+rhl924WKU5xUz+PVN3j63IAll1b7TDIj7wRVfbvhBfEzpXEGFy8wPd
	fk1R6gcgqbm8v6jDX9uylDEIM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3ZyS4uuFqDbDtCA--.6527S2;
	Wed, 28 Oct 2026 17:04:58 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net 2/5] e1000e: do not cache the hwtstamp config before it is applied
Date: Wed, 28 Oct 2026 17:04:55 +0800
Message-Id: <20261028090455.2291659-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wD3ZyS4uuFqDbDtCA--.6527S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF17Cr47CrW8WF4rKFW8Xrb_yoW8try7pa
	17CF90krn8tF1aga97JFy8Cr98Wan7tayY9Fyayw1Y93s8Cry8Cry8KFWUurWjyrWkJ34q
	qrn5Zw12grs8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlhFsUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRrvxmrhurr6ZQAA3O

From: Linkui Xiao <xiaolinkui@kylinos.cn>

e1000e_config_hwtstamp() stores the requested configuration in
adapter->hwtstamp_config right after the rx filter has been
translated, but the two register writes that follow are verified by
reading the registers back and each of them can fail with -EAGAIN.

When one of them does, the driver is left holding a configuration the
hardware never accepted:

 - e1000e_hwtstamp_get() hands it back to user space, so an
   application that reads the configuration back is told that
   hardware time stamping is in effect while it is not;

 - e1000e_systim_reset() re-applies it after every reset, including
   the ones the watchdog triggers, and keeps failing;

 - e1000_watchdog() starts polling TSYNCRXCTL_VALID for the cached rx
   filter, and e1000_xmit_frame() still parks skbs that ask for a Tx
   time stamp because it only looks at FLAG_HAS_HW_TIMESTAMP, so they
   are eventually dropped by e1000e_tx_hwtstamp_work() with a
   "clearing Tx timestamp hang" warning.

Cache the configuration only once both registers have been verified,
so that adapter->hwtstamp_config always describes what the hardware
is programmed with.

Fixes: 62d7e3a2d006 ("e1000e: Validate hwtstamp_config completely before applying it")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 35f5590228eb..7ae33273734f 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3715,8 +3715,6 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 		return -ERANGE;
 	}
 
-	adapter->hwtstamp_config = *config;
-
 	/* enable/disable Tx h/w time stamping */
 	regval = er32(TSYNCTXCTL);
 	regval &= ~E1000_TSYNCTXCTL_ENABLED;
@@ -3763,6 +3761,8 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 	er32(RXSTMPH);
 	er32(TXSTMPH);
 
+	adapter->hwtstamp_config = *config;
+
 	return 0;
 }
 
-- 
2.25.1

