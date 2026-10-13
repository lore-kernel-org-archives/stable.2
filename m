Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A35F3998B4;
	Tue, 13 Oct 2026 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888100; cv=none; b=S4bEGNvv4/QwQiOUNme2i29mKfZkDYctJRgA3qoV3uPhIt9lTiicxMyJUmRHGRnEXCZJxLdHX3FKzYgEnfvXMmi8G0NZyxyKB1U2DXqd+B9HDUoJSMNWrli1Ty+53YMtMM1FASaOF1BAXTGWS21GtUgVWBQFWU3B5VA6icXV22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888100; c=relaxed/simple;
	bh=71BsLK8ebqaTOxFvbmGZxoh9rmrlmOI7KUumGHN2rw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpWvg2BsjilkzHCtrOOWzpCpuZPhz2g24zk/2nwczkfQ/iaFAzsoChzSBEX3CEuh60YDlpkCJwXaiMtTOzYlu7sBHt7PAUjRGBbfm0mt8ySzZ6cay8ZIa+fcCPwU0ZZA6suC6CyFJWkSbWDkXboq9/Zvgh95LivM6gduMucwmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=dfIjaEGB; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="dfIjaEGB"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1791887548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VmW1Mk++o+vHDf7lQbc0Lnrv6OPA0Ilhu/jNTKAd+LM=;
	b=dfIjaEGB82c84y/QUnSCpqY5ZMDIrzJGv2zO4BXk+Dzjk2yNGvKWTCSH5lZoLoSJuGI0Go
	z3T5RRfwwC7UmdxihwZZY5LUNts2wySbSi43WJVF9sAT+uCL0HJ1YBC7pIWzK2P0hT1VIK
	p0QQeDDmaB2LQY1OfVMMYDU2McaGkfo=
To: Sean Anderson <seanga2@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: sunhme: fix infinite loop in unmap_partial_tx_skb()
Date: Tue, 13 Oct 2026 13:32:26 +0300
Message-ID: <20261013103228.37430-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unmap_partial_tx_skb() walks the TX ring entries between
first_entry and entry to release the DMA mappings of the
fragments that were mapped successfully before a mapping error,
but it never advances first_entry inside the loop. Whenever the
failed fragment is not the first one, entry is ahead of
first_entry and the loop condition first_entry != entry never
becomes false, so the function spins forever.

The function is called from happy_meal_start_xmit() with
hp->happy_lock held and interrupts disabled, so the infinite
loop leads to a hard lockup.

Advance first_entry with NEXT_TX() at the end of the loop body.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ec1f1276022e ("sunhme: Add DMA mapping error checks.")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/net/ethernet/sun/sunhme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
index a70f704eb9f3..544eb43af125 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -1965,6 +1965,7 @@ static void unmap_partial_tx_skb(struct happy_meal *hp, u32 first_mapping,
 		len = hme_read_desc32(hp, &this->tx_flags);
 		len &= TXFLAG_SIZE;
 		dma_unmap_page(hp->dma_dev, addr, len, DMA_TO_DEVICE);
+		first_entry = NEXT_TX(first_entry);
 	}
 }
 
-- 
2.43.0

