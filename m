Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00512314D1F
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778604; cv=none; b=jZCtWQ9HFdXzxIkRz2ntEmLOF2bjbDnCx/VCiQ/wSzUbRMn0zz2IslG16SM4ce1HbvIVkRtNi9DoLuL1KWXZp96wIIdSbIRPo+H/jo6pDEwPEfeGphrpURToIw7pS564pup6xZBhU9UY9FSM/xeE5bc3DCEM33vi+wtZHKuJh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778604; c=relaxed/simple;
	bh=sQrj9NtsIHkxF9w49pSeMNv9N9eQxQbKMSBF5j2fiVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQSb5tlS3ag8fTQjSVCya89oiC0O/wqvr3uYPBeMyS+DFxOCBN8wp72aVYuzlvwDvMap08nKusysSSX2AF54SW99hldKRH0Bd9ngF+fbE4EacnIvbL9KHll7TOMRsGmj8p7KXgLF284TDofavPNTRrf1EYQXaV2++yCue3H5kuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=x8Vos/3A; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="x8Vos/3A"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e618db81c0so12582255ad.2
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 21:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791778602; x=1792383402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EMjXa7fPM07GEuEQK3ZTCMVcOkPQnQoQnjCjmIDRcqQ=;
        b=x8Vos/3ArQXH7ozq2MhfZZcBKIpHhdhsdOHUoRlOz/1CBTS8k8UU5VFep0BygGr/50
         lOTwOaGgsWBnCx+KYAMgbVGo3t32Xw7DdWuVTlgoy34YT8C5WKdl/0oR5ONkQVbLPp/D
         2K0Ai+3F06MZujNzI7O7EpQid4OTVy8EPqUiyTR5yKO2ZOT9BA+MjPb9f/D6lZXxmNyE
         BFJm1bbrljGBlITbVEbDdtUzJ/hsdZIhRRmWuB6fJUmWP2NwSbb7QrBvqb9stJlpjWtM
         dnZKbOvvY3cKndt237sPG9qHnBuyZvpNSTrdVx6CF0Cr3mq2ClR22en96F0FJUCoIFxq
         zTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791778602; x=1792383402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EMjXa7fPM07GEuEQK3ZTCMVcOkPQnQoQnjCjmIDRcqQ=;
        b=FLMRSee2qXorTwH6e1EgwlqYmchZY5uJ4vmfNy20KpuLnKNeSTKcUn09j9G2oFNuqO
         qn9nwg+OWBLwmls0+lNvdH+t80Qcll8TmniE6mzw68YF0fIDWESCeNLiQw2UZk8qkXfe
         aV5JevMuPRgZJvLheINbELrTPkRBR6ETexalHw17KhyAldAP9oHPlkjTO232qjMr8In2
         WHtvFOC3MEVkXAQCK1lGFxbg6sEyzILJQo1Z8/03qOLVlsUmVyUPK2IDVmNXjLJTaDsK
         Gj3lJNtwYBHzgP72wv5lJlfR0con/KxT8D99NLvHraDW7VPNJxJkptpONU/bCWHSITeq
         4xbA==
X-Forwarded-Encrypted: i=1; AKwUvBw9huOVfkgzUKSeWN47at1mx6m7f55y23k3IUGPO1b1/Va1dUZMvcIJ9TsRkos4LZHciD5WZk8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0NqVVG7ui5/l3+QGScbyDTcd1x2/IsAd2oUporBwVl+ELQ3bY
	z4r6NGw/lun+mTjNaG8hOgxhFj7/NyvAPaoXYCT9sxbGMKxZxiPEoc+9u/yuB6YFFI8=
X-Gm-Gg: AYBFou0ozg4o+BOTZOP+782FY4hhKXpZME99CqjOZHwi3cBvpk5/j5RCeBz7a9GnUDT
	2lg7jX9U7OXkaz3v5uQMe+TPMC0d67nhkBCnIZdGiKrmygeW2Ub423buLFQgzaYLo+WB7xrQg0c
	a4WUE7kwdOoHCi2jZDdYrtPKsVfZrWqvxCxjaIBdDmBlaNDg70LcZSt0X5r4Abbsep+J3g2VOT+
	jWyECRBDBvXnujKS5pYO5jLauqi7YVetJmHOfz3c2E+dXCeAx5hp8vVstK23ZDAwrymNbj/Y3oi
	cOWVvoVD+X2zH8chKJn7t/yRhyxZ006HQR6n5VTUenqWfsx8KwK9TpazFgvDtmlvoaDdAt5uN3Q
	WjaQvCcXXjK+vTuMMdAIkHy/hm1exkVbgne652CLoJkEC1SRf9X2tzyH07TBPdzb5fOwo+hOtIw
	2aoTWL+67rJKNqJVmFI0pAxWf/zWLO/ECCAeKh7iX0uTZQJCEnMzckufiUJrasrTudUm5MwYc95
	Xv5NEp+sSi9wPlf
X-Received: by 2002:a17:902:e790:b0:2dd:ad74:ac1d with SMTP id d9443c01a7336-2e842cfc98dmr74612865ad.24.1791778602300;
        Sun, 11 Oct 2026 21:16:42 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421af46asm38240025ad.39.2026.10.11.21.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:16:40 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v3 4/5] eth: fbnic: return the page reference taken for a dropped Rx fragment
Date: Mon, 12 Oct 2026 13:15:59 +0900
Message-ID: <9d77812119330cd316b7eea7fd35fa4038ff86a0.1791775409.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic_add_rx_frag() takes a page reference through
fbnic_page_pool_get_data(), which decrements the buffer's pagecnt_bias,
before handing the page to xdp_buff_add_frag().  xdp_buff_add_frag()
fails when the buffer already holds MAX_SKB_FRAGS fragments, and on that
path the reference is lost: add_frag_failed is set and the frame is
dropped, but the bias is not restored and fbnic_put_pkt_buff() only
returns the fragments that were actually attached.

The page is then never returned to the page pool.  A device that keeps
sending payload completions for one packet past MAX_SKB_FRAGS leaks a
page for every completion beyond the limit.

Restore pagecnt_bias on the failure path, the exact inverse of the get,
so fbnic_page_pool_drain() reclaims the page.

Fixes: 61f9a066c309 ("eth: fbnic: Use shinfo to track frags state on Rx")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 47ded7a9e0a81..7a9bd91bcc41c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1171,6 +1171,8 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 
 	added = xdp_buff_add_frag(&pkt->buff, netmem, pg_off, len, truesize);
 	if (unlikely(!added)) {
+		/* Give back the reference fbnic_page_pool_get_data() took */
+		qt->sub1.rx_buf[pg_idx].pagecnt_bias++;
 		pkt->add_frag_failed = true;
 		netdev_err_once(nv->napi.dev,
 				"Failed to add fragment to xdp_buff\n");
-- 
2.43.0

