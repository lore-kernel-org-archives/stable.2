Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094D3750BE
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778599; cv=none; b=WRkJqn0ocO5V9M0Kqp3aIzqRvVHhpoqpaHCr9H+Y07+NqD0SYZ/UJskKy6tAVm0YBOQI7VrGSiGuOjFQBYsLe5OgYSEqz7U8pU0xY0AuFy8HH81cr6CRIlFVhJTGgQEYX7V35yZrJ5g6275PiNm3dhefcHwmhRX3f/LzeCafnAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778599; c=relaxed/simple;
	bh=YQaGRylIUdDFcPUitGbK2CzCGwIGvThJblHLN5RMhBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFYWUQH3eM15Snf/ZAMxzpOCrY+cM38ZyQ4LShS6yfgkZjQPS9b4vCBCqbtC08FiOJfjyZY7rHFxC52CgymwWCVbmysuqLuuXn+iX4kjtb7nssCYJvZhyYWZQhN7bhSI26b+FIIsxXDbSyevcRSwP9sjpziUcWcgbdJVIiMubpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=H8SmtG0U; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="H8SmtG0U"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2dd9cbb661bso10795185ad.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 21:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791778596; x=1792383396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92mwmyUTtXBrrkUU1Kt+mlj6dDxLQ8K0k1LROD62i4E=;
        b=H8SmtG0UiKktKj4B45uJukiKVqdRyUgwcAHQEy8ZP4uhwBa3ymS2RAilbXfriPHtlI
         imAMPcsCszH+NnuP5GYQB52Q0j3tzQAKHsHbl0GUjOWcuzOggQaRSmoecD3eVuVIk+2P
         A6VjSA7QdmU9az5nbBKzrGtX70VHH9YF4I+0vR8FJCA4pt34MnWQJ4mAbis0X1FMy+y/
         orLQMUFx6AhZeIM1+lPqnZt3a/EFdW1W47Xe6mP75+LZo0hn2TZ5nribE8SJSSIbFYrP
         QzP753PZoBwm32fQrbqh3gK41oaEWxK7L6N3lkbRACK3RaYGfh2dVVPKklyJR3O/JOZK
         7bYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791778596; x=1792383396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=92mwmyUTtXBrrkUU1Kt+mlj6dDxLQ8K0k1LROD62i4E=;
        b=wcpWAsFqO1bdEeDjkBox9aVDGH+X66Ffe66ZtilnhZmKKMG1oI+811U7mal9OzQlZQ
         /se9hpVlM2qn8duNp9Vep0ntJvOKNvvcXjccP5nItTaF78hoe5GxGOddxSjhdcxckvJj
         2FfKLp3VXpDnewWutnNEZaqfxeK9QrOQu4gKEwZGoLvxdvxkWzWgPBvzZT/Y/oovvOkI
         PWdm79T81tXiiu78jQ8zEXNBhftYl53+03AKXFTfDvN0Qzmgvgv+ZLur/dK/yDDsSaEi
         F4pZCYzReN5VYP7laSJ3wb2Qx8jaB1XwQZwm2XxmzMCuZ7qd+v3MSY8JA4pIhO1ox13u
         HZpQ==
X-Forwarded-Encrypted: i=1; AKwUvBykIDYyW+KZxAiuQlBL6WcTG2QRif6EyvHuDqUq04uMxiUusU6EsieYSTEfWKB8enyyai5qNMc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+4WEII57BXbm53rS+Rn9VBOa99k/RcXD5MeExduX9KIMOA7Bm
	DpCs6J5diYD0Dh3xok/XTIav1QJph5MiZXhmX1eRrhR9FoBl7CGkf2v94pIHH9Qyazq7NBMZprg
	l1PQfyro=
X-Gm-Gg: AYBFou2/NqOgETkKEzw/rgFU64DIaGBXFDeAZ6NLszH/tQS+kKMEwY8hCHLu1ns7Lj2
	ECZzF8NRc87pQfpzuB6MGMojZHPzAWqMEpgO3F7YacSCax42lMyG0h69gi6kh/2X5LEHmrNf/jB
	KS9jnDJpIx2vlQ3ruI/lQTvQwf4D/Y7OVkvkToiewnM0owVM601iVvg/AHCtVkI2+r8Z20Pq0ce
	Jf/L6oNYl2vjjf6HZhxXYXnQPllkr3d7kpwU95GtFaij7YMuik9b229VGy3xu+puJBO+f2GLdkc
	V0UAZMkq/Ue8mzgDANGwNPMUZJhMr8HRDYMKVWCxKd6JNaESy4j21Za/ppPANRRN91mQLKA9LX3
	z79pGoiTFKleZW3LzygXwd9y4TMq9LKren2uHmQH9hBo1kgMrs36OQ8kVje9w3zjKWUicKUg350
	XxXiKYdkUN6L/dayF6mpCZL/pm0kxoMGy9UQkVZJHYI5wzKRUCx57kVYm+72rr01I03r44hYT46
	DRqEkfsH2NhAOnq
X-Received: by 2002:a17:903:8c3:b0:2e4:a338:3658 with SMTP id d9443c01a7336-2e842bbf5bamr75162065ad.42.1791778595822;
        Sun, 11 Oct 2026 21:16:35 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421af46asm38240025ad.39.2026.10.11.21.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:16:35 -0700 (PDT)
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
Subject: [PATCH net v3 3/5] eth: fbnic: return a pending Rx packet before reusing its buffer
Date: Mon, 12 Oct 2026 13:15:58 +0900
Message-ID: <dc2fd0f8b4ff068c3919444d7b4a88ad55e5831f.1791775409.git.yhlee@isslab.korea.ac.kr>
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

fbnic_pkt_prepare() starts a new packet on each header completion and so
far only warned when pkt->buff was still populated from a previous header
that no META completion had finished. The stale buffer, and any fragments
attached to it, were then overwritten and leaked.

Return the pending buffer to the page pool before starting over and clear
data_hard_start, so the META drop path does not release it a second time.
This leaks memory rather than crashing, so there is no oops to show.

Fixes: a29b8eb6e533 ("eth: fbnic: Add basic Rx handling")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 62 +++++++++++---------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 7dda59bba14ee..47ded7a9e0a81 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1014,6 +1014,33 @@ static unsigned int fbnic_hdr_pg_end(unsigned int pg_off, unsigned int len)
 	return ALIGN(pg_off, 128) - FBNIC_RX_HROOM;
 }
 
+static void fbnic_put_pkt_buff(struct fbnic_q_triad *qt,
+			       struct fbnic_pkt_buff *pkt, int budget)
+{
+	struct page *page;
+
+	if (!pkt->buff.data_hard_start)
+		return;
+
+	if (xdp_buff_has_frags(&pkt->buff)) {
+		struct skb_shared_info *shinfo;
+		netmem_ref netmem;
+		int nr_frags;
+
+		shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
+		nr_frags = shinfo->nr_frags;
+
+		while (nr_frags--) {
+			netmem = skb_frag_netmem(&shinfo->frags[nr_frags]);
+			page_pool_put_full_netmem(qt->sub1.page_pool, netmem,
+						  !!budget);
+		}
+	}
+
+	page = virt_to_page(pkt->buff.data_hard_start);
+	page_pool_put_full_page(qt->sub0.page_pool, page, !!budget);
+}
+
 static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 			      struct fbnic_pkt_buff *pkt,
 			      struct fbnic_q_triad *qt)
@@ -1025,8 +1052,12 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 	unsigned char *hdr_start;
 	struct page *page;
 
-	/* data_hard_start should always be NULL when this is called */
-	WARN_ON_ONCE(pkt->buff.data_hard_start);
+	/* a new header while one is pending: release the old one */
+	if (unlikely(pkt->buff.data_hard_start)) {
+		WARN_ON_ONCE(1);
+		fbnic_put_pkt_buff(qt, pkt, 1);
+		pkt->buff.data_hard_start = NULL;
+	}
 
 	/* A buffer ID we never posted cannot name a buffer we own, so drop
 	 * the packet instead of running off the end of rx_buf[] or picking
@@ -1146,33 +1177,6 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 	}
 }
 
-static void fbnic_put_pkt_buff(struct fbnic_q_triad *qt,
-			       struct fbnic_pkt_buff *pkt, int budget)
-{
-	struct page *page;
-
-	if (!pkt->buff.data_hard_start)
-		return;
-
-	if (xdp_buff_has_frags(&pkt->buff)) {
-		struct skb_shared_info *shinfo;
-		netmem_ref netmem;
-		int nr_frags;
-
-		shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
-		nr_frags = shinfo->nr_frags;
-
-		while (nr_frags--) {
-			netmem = skb_frag_netmem(&shinfo->frags[nr_frags]);
-			page_pool_put_full_netmem(qt->sub1.page_pool, netmem,
-						  !!budget);
-		}
-	}
-
-	page = virt_to_page(pkt->buff.data_hard_start);
-	page_pool_put_full_page(qt->sub0.page_pool, page, !!budget);
-}
-
 static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
 				       struct fbnic_pkt_buff *pkt)
 {
-- 
2.43.0

