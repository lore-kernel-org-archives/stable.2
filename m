Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A73EDAC1
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142602; cv=none; b=GZRvG+TMKkw3bSN5IP3kj7Vd/ZVgFLE55kuGT1aXs9sU6otGtoEMiCzUTMKZdXLDq59PEjc6oHgwk391LIw6gSc00X7Gok2uIdiKBTQ1eh6hWZ8aj/t++TWUFvkH4TIfmGWe7yOpkexb/lftFEgNjO+ouB1ZM1G/KONtepU9PpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142602; c=relaxed/simple;
	bh=oo5BQ2YFA1BOj35K9sZFqQ90+w5btbGqx4A0gTKL8gw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OxTmwusgj1cu02J8aXTo+VV5AglY8YfjVRyqbw0CJMk5wqhzfbpBUPZxBLsBtPUI61lJp/JlV7surIOgaYKepV8kc00tSduBwg6mmU6nwz5AjlD56v4JPF9kQSis9S1gtaER5xnBjj9lIN0KpeszlftbwJ1ZR/Q/7Rf1/7TUtos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NPuYhLsI; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NPuYhLsI"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848568a6f62so84286b3a.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786142599; x=1786747399; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nVTmtHFgWt2omJAkKmGW8CxABaT9ZqlHPe4wJSsdn7Y=;
        b=NPuYhLsIzXE7X3+12SbyjEkyy1EV+M0oWMQnjIiLj/gGcZyS5JbPy/EDlv9c0ib8l3
         fddTpC8ezpFWtsC6dJWExmpbjEswukKNxkUlGl/HAl3aSjfjygQpnnPy7YwI+QKrO2re
         6hiGo33fGPYMsLZwFqYi/oNSP4ajymC7Nm4Eo2io3Xf2oBBq6rKWpw72hsWWaP5RlRc+
         dd9pP8ny9j6C4hq9CXlT0NHfqNud3jah7MUMQDDAgh74sh286VDgfF6wfuIU2liZKXLB
         OXD8XdU2YuuTNuDZYnUMXlKz4F9oC9AKUthmiECj8dJ8C7iQAjb2K7tWl5C2F1hAdBh2
         gKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786142599; x=1786747399;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nVTmtHFgWt2omJAkKmGW8CxABaT9ZqlHPe4wJSsdn7Y=;
        b=PZ6z+LDAq61vMViSLsuiLMWRTmaFBU00Ic6zX6pRKP0vkdQaQrnMyvvcSxMRHPILvy
         wTlky0/BtqPfGYiSNP15sUhoJIfpV8y6U85kMA84WqA8OtCnv+/w1MXwX4iz0HoIM+pX
         7kQ7TnfEVMC43/DduLxPif/yIxuUDdj6s3dO4+yP/oObalsUrNaAcdpFJA5DRl/7a/pe
         eRS+zV5Bcf1rWNFm4joCnDt6Z5r/KshwXIkXD2nb/Lg7dScI4z2XAsl08QIvHD/Re8Ad
         b3Lk5un8xmQUIHzd8v/mQGI7EbCNGhAnzvspzLcH94hxvms1Som7EIw6KGJ0W8lGIEaP
         /59Q==
X-Forwarded-Encrypted: i=1; AHgh+RoYmlN+wejmzbHWMEUe1F5jhH58HMYvnydyQbR22WMsppbEYf4EiDGIH1uW0yHV+f+mcgOR6wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxClkqA+GOWgrUFuWH868gv6Ziwq8o1rTqaJ4Kcf5kXEHvaLr4R
	LDfbWinlF3UcwfdyKU5AlLMVdGMmqBiSjKpOfWUXKF5NwrDYe9HMwC1WtPy61yiocvlhyiRfiAt
	LPC4hHF1IcV2U/1Ao3hcopdrNOg==
X-Received: from pfbcv13.prod.google.com ([2002:a05:6a00:44cd:b0:847:7f5d:6b90])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:c95:b0:845:3033:6cb7 with SMTP id d2e1a72fcca58-84f2dfc8ec7mr25536940b3a.9.1786142598735;
 Fri, 07 Aug 2026 15:43:18 -0700 (PDT)
Date: Fri,  7 Aug 2026 22:43:14 +0000
In-Reply-To: <20260807224315.234152-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807224315.234152-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807224315.234152-2-hramamurthy@google.com>
Subject: [PATCH net 1/2] gve: fix zero-length skb frag with header-split
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, thostet@google.com, jordanrhee@google.com, 
	ziweixiao@google.com, willemb@google.com, nktgrg@google.com, 
	pkaligineedi@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jordan Rhee <jordanrhee@google.com>

When header split is enabled and a header-only packet is
received such as a pure TCP ACK, GVE will indicate an
RX SKB with a zero-length fragment. If this SKB is then
hairpinned and sent back out, the GVE TX path will emit
a zero-length descriptor. Hardware considers this
an illegal descriptor and stops the queue, causing a
TX timeout and interface reset.

Fix it by not adding the zero-length skb frag.

Cc: stable@vger.kernel.org
Fixes: 5e37d8254e7f ("gve: Add header split data path")
Suggested-by: Praveen Kaligineedi <pkaligineedi@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 8271f731a91f..0ece2f6fdffb 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -886,6 +886,11 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		rx->rx_hsplit_unsplit_pkt += unsplit;
 		rx->rx_hsplit_bytes += hdr_len;
 		u64_stats_update_end(&rx->statss);
+
+		if (!buf_len) {
+			gve_free_buffer(rx, buf_state);
+			return 0;
+		}
 	} else if (!rx->ctx.skb_head && rx->dqo.page_pool &&
 		   netmem_is_net_iov(buf_state->page_info.netmem)) {
 		/* when header split is disabled, the header went to the packet
-- 
2.55.0.679.g6767b8d81c-goog

