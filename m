Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A7536AB4D;
	Thu, 15 Oct 2026 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064648; cv=none; b=Pqk8zFl7/tQb8QTtAwocqdHaFH0WuXuDMRxsIb5D/fA3qDsK7tyzUqId3/Wbxws7/kLua0fBegAL8j9b4TQA5FrE5EG4njIFI9RsAn/WtimbJ9N12GbTkoE5C8V6XYQlJDu5wlvpDxWZkVoqd0kv21qZDtsP6M4sGAKlMgpAq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064648; c=relaxed/simple;
	bh=9c6JEiSgFPakxmdJs0ZAkTrShsy5QShGFbTtNBf+F0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5SucFqtV2u1542kfBA+xd//9KXnBvCozS6diqwddORrjKyXU+yeuuMpgQwGrcqS4vFsHLfw8lt6qqbCWsNStTkNXUqpcwtjcqCOp9JkGmMfE63qzKoP78cMkkSRS/8t9Jt9sKVlWGYNEXwbe3Y5YFuPoPQqjbzbtUqzBrN/bpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=CArCQ/vg; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="CArCQ/vg"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1792064636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T/Iqe0SLMtqQgTZdOI0rXsVX8Tkc2D9TkdCWhyGDXxY=;
	b=CArCQ/vg7LuJMn9XFKEHtq0t4q40OWShqm3W3oyXygsqPgjEM4YlPnL3J2uRIQVe8DtgYq
	BEXSCYqNSuiZCoHQrEg3vNWb7aoWoUg4G7LiVX/XWQz2oLFymveQTjwG7M/UOshROPLHLB
	wb23tJt2X1lrqSu/3QsIS7ArlSxw5ME=
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
Subject: [PATCH net v2] net: sunhme: fix infinite loop in unmap_partial_tx_skb()
Date: Thu, 15 Oct 2026 14:43:54 +0300
Message-ID: <20261015114355.14906-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unmap_partial_tx_skb() walks the TX ring entries between first_entry
and entry to release the DMA mappings of the fragments that were
mapped successfully before a mapping error, but it never advances
first_entry inside the loop. Whenever the failed fragment is not
the first one, entry is ahead of first_entry and the loop condition
first_entry != entry never becomes false, so the function spins
forever.

The function is called from happy_meal_start_xmit() with
hp->happy_lock held and interrupts disabled, so the infinite loop
leads to a hard lockup.

Now that the loop lockup is fixed, a secondary bug becomes reachable:
the function unmaps the pages but leaves the descriptors in the ring
with the TXFLAG_OWN bit still set. When the driver subsequently
processes a new linear packet, the hardware MAC will advance into these
stale descriptors, causing IOMMU faults, TX ring desynchronization.

Fix both issues by advancing the entry pointer using NEXT_TX() at the
end of the loop, and clearing each descriptor via hme_write_txd()
immediately after performing the DMA unmap.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ec1f1276022e ("sunhme: Add DMA mapping error checks.")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
Changes since v1:
- Also clear the stale TX descriptors (hme_write_txd(hp, this, 0,0)) after unmapping them.
v1: https://lore.kernel.org/all/20261013103228.37430-1-arefev@swemel.ru/
---
 Compile tested only
 drivers/net/ethernet/sun/sunhme.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
index a70f704eb9f3..dace94841a6f 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -1965,6 +1965,8 @@ static void unmap_partial_tx_skb(struct happy_meal *hp, u32 first_mapping,
 		len = hme_read_desc32(hp, &this->tx_flags);
 		len &= TXFLAG_SIZE;
 		dma_unmap_page(hp->dma_dev, addr, len, DMA_TO_DEVICE);
+		hme_write_txd(hp, this, 0, 0);
+		first_entry = NEXT_TX(first_entry);
 	}
 }
 
-- 
2.43.0

