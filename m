Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE72A463B73;
	Mon, 21 Sep 2026 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.198.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982138; cv=none; b=LNsDv9PrULGDEK9nL5oVpTS+vUqzZx0JdS+aRe/F72/5AQ26HCPBBmknSHQNyzCNh4Sfr/kCLNQRprdSQpPzM6khPWTPNMQREalXJMl4e5RPEbi5AVJle77Z5x4kqrDVnCr5waArsjoKb8lhAghouF24kYoNASTKc/sVr70v+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982138; c=relaxed/simple;
	bh=RrmhCxTp1tw7yzpfL+BJQOikKGE/DiyOR2iXpwkZnms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPhZbSS0ggRbo4k5XUyp5IzGd6weOygl6jCA6xJzDO9K+Nqy0zrXd7FqRnPfX/4Iw4lO2nNY3vY/7BR1ef0MS3GxcvXZTAN4Lr1+Lr5ebLpqf1Yd9KrwHVZe5OvUYhxzhudmGavyyJzTM438VaiEdqGOScYYm2cpY6KsVgJmdP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com; spf=pass smtp.mailfrom=rimpianto.com; dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.b=Nc3faM3v; arc=none smtp.client-ip=46.14.198.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.b="Nc3faM3v"
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: =?UTF-8?q?Gajdos=20Tam=C3=A1s?= <tamas@rimpianto.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gatis Peisenieks <gatis@mikrotik.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gajdos=20Tam=C3=A1s?= <tamas@rimpianto.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] net: atl1e: fix soft lockup on out-of-range hw_next_to_clean read
Date: Mon, 21 Sep 2026 11:13:33 +0200
Message-ID: <20260921091334.3571525-3-tamas@rimpianto.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921091334.3571525-1-tamas@rimpianto.com>
References: <20260921091334.3571525-1-tamas@rimpianto.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id C865C182-7EAA-4089-A7CF-1E4542A5B920.3
	envelope-from <tamas@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Mon, 21 Sep 2026 11:15:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Cc: To: From; q=dns/txt;
 s=s20260314391; t=1789982133;
 bh=WgHxkwyke+FWVPlHkGovNc+kxZLwkXgI2p3A8p7y4Cc=;
 b=Nc3faM3vwYa7TKVXq2Yi3IDIkBu6SoelhIb6W6/d9bl9goR/c/5By5lI5rbvyaoX8tsD+Cr7J
 vX7ByM8ouZ52YZqUO/89pzjI93+XMhTReWZCiuwYyVULktzbtQ1I8j/+nFO9zTPWl47eQ/Mg23u
 nZcgwPJ3gBn7/ufEip2zx4M12M6ts/MhHfJccNrywG2ChyH/XBnVvl2a36NJtKN92GqqrfYQmpa
 H/O9oE6Pm/kqXeBIGQHrGvKqVt63wS4OuLxF5v9tO3qmAmnTziBrWAbC46S0MkOeZhBh8wBr1Op
 gdtEDCfy6OnioJ0SL6ViCSCRzdqJuEuZDc8z9KH+G8kQ==

Same issue as atl1c (see the first commit in this series, "net:
atl1c: fix soft lockup on out-of-range tpd_cons read"): the hardware
can report an out-of-range hw_next_to_clean (seen as 0xffff) while
the PCIe link/MAC is resetting. An out-of-range value can never be
reached and the loop below would spin forever. Treat it as "nothing
new to clean" instead.

Fixes: a6a5325239c202 ("atl1e: Atheros L1E Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gajdos Tamás <tamas@rimpianto.com>
---
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 4029002858..437989edb7 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -1234,6 +1234,9 @@ static bool atl1e_clean_tx_irq(struct atl1e_adapter *adapter)
 	u16 hw_next_to_clean = AT_READ_REGW(&adapter->hw, REG_TPD_CONS_IDX);
 	u16 next_to_clean = atomic_read(&tx_ring->next_to_clean);
 
+	if (unlikely(hw_next_to_clean >= tx_ring->count))
+		hw_next_to_clean = next_to_clean;
+
 	while (next_to_clean != hw_next_to_clean) {
 		tx_buffer = &tx_ring->tx_buffer[next_to_clean];
 		if (tx_buffer->dma) {
-- 
2.53.0

