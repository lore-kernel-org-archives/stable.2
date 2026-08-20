Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916373921C7
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250094; cv=none; b=IaauPQQ3/+cOoYNxZwoPxmZfEbiHaFyslv6QeU9lKK924JWDHPp+UwBYLIFJr7xhBFBFmRfwS5tfCU5x/D8JEubBev8ttWgNX9HKNGz8exsHRI5RSsaF9sDG8RLCpctOhOwbfnS096iY+jA9WqFYR9EFkvgvWv7/9W/d+PO+Uxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250094; c=relaxed/simple;
	bh=dW8AsQuFHCyfSA8kPZVHvQ2h7iRXcquypsxriDb5zFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f2KRFEnVGchmJ6j4jQ1RZ6eEYRPX2YQEIdPWbPvh1E1s/AhOTfCbPRZhK/8acC17VWAqv+OUm+wWavKWZkJGSEsEqOBXnBPXLxdwpmcrvAd44NKO2iteEqlLf673Bjp1yCwzuWEOiV/ORR2QUhRzythCDl4Uxgdx44ePKGAdwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rK1GCok1; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rK1GCok1"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e024d2129so160953b3a.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787250092; x=1787854892; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8uRtyP+BmPXejyGZnMV24TPbdVsG+TQpKLJCr2qOAFI=;
        b=rK1GCok1pa7D3m9fuy+Ykrw3wlboer79GpK2leBCdnkrm9LhzB26BA0Oyc9rcaOzab
         yCU3k/WRG3Hf0rYolEUuK2RvVp6YUVa0krrARsDcwqhVj+ZvIcAapJpK+D/mTM9KRCVk
         Io1QNuu2e6mHkpIf3qdCEwKktOOb3Nl4z48RH70BhxzIvd6r50ak1vMiaXxpUAQsnx8c
         8KcQjyBiba1q2R87xd3rqJW/7tc9Lv+7V/XgOpEJz0qVUAZH2W+kvgqX5t5b9CqzEIXV
         GkS9KC7+xkoaWyAjPugXE97Q4Otd5ZUaaKrKlJFXnLSDx112jA7SI0C8x/H2TitoGByr
         lD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250092; x=1787854892;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8uRtyP+BmPXejyGZnMV24TPbdVsG+TQpKLJCr2qOAFI=;
        b=IAp7cESUZmTXBNOTGNTztBdZzFbw86m/ysADAq8CPOGWYx88j7SxJSihocX7Ph6I/p
         JcxEnXRwNuheWKJ6JGjtikZMo6qQbkCCwqLwOYvpDd8VvAqbhK7L32HMUU8+ppTpT1IG
         JGHyCifA09l+b6aLnCfJBso73RvztR24a+PM4Ufa4ZGOUvT3LRLOIaJFXS0ICPyR+x4L
         PuudyhABiZzzgjiDR6rZzWbqGtR2/Jp1lu6Ptv8P0/yVm16wExVURucmsbavW9pIA9B5
         HWg7Kpd/0qui94l5F+n6dbyARwTmgIGPYx8jHTbtBAr0vmee11Nyy3VEmrjH20X6SZCx
         lOPQ==
X-Gm-Message-State: AOJu0YzeiJpDPlUvEz13xpBJlWnZBNvZsIHoymvDhF1UWUAN30CfBhsH
	iJfXeA+B3uLVTkoYVk0CCaK6CJGncXq8ck+/9UFYellJ5UwUDzA90yvXfXgSsIoyI9PLvrytJDo
	iwl4yaq+jPnEx4oTA3zwbsvMU5suz4PTnRCEq2g2znjLUxvrCx/nIVLPKSIunRCRMMBTSDu3J7F
	hDaFcJLj59yD1B8zzDTfDwmIXFGfQpjAAvV8vB/COwrM4XFPPK53o9utJQUy09CeY=
X-Received: from pfgt21.prod.google.com ([2002:a05:6a00:1395:b0:84e:1951:8efd])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:10d1:b0:848:5540:2377 with SMTP id d2e1a72fcca58-851d3a7b9bemr23710139b3a.17.1787250091329;
 Thu, 20 Aug 2026 11:21:31 -0700 (PDT)
Date: Thu, 20 Aug 2026 18:21:28 +0000
In-Reply-To: <2026082058-encrypt-lividly-0296@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026082058-encrypt-lividly-0296@gregkh>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260820182128.750922-1-hramamurthy@google.com>
Subject: [PATCH 6.12.y] gve: fix zero-length skb frag with header-split
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: stable@vger.kernel.org
Cc: Jordan Rhee <jordanrhee@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Harshitha Ramamurthy <hramamurthy@google.com>
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
Link: https://patch.msgid.link/20260807224315.234152-2-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 6bf14575c65569dcded90ef78afb8a6d57323f04)
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 3655f48e9b46..839222ba9e91 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -850,6 +850,12 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		rx->rx_hsplit_unsplit_pkt += unsplit;
 		rx->rx_hsplit_bytes += hdr_len;
 		u64_stats_update_end(&rx->statss);
+
+		if (!buf_len) {
+			gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states,
+					      buf_state);
+			return 0;
+		}
 	}
 
 	/* Sync the portion of dma buffer for CPU to read. */
-- 
2.55.0.766.g2966f0265a-goog

