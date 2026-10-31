Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468406;
	b=VRjlLrQHcwr3XeAsGLP9UqWRwJx/mcaDY5DlPN0wRY6py99RuYxY7BRAsp9mkwBSP5db
	 zW30me6Y3mQAC1UdQ2aX6LCpltn/BS8wbsaweW3gkxTtNaT9Ov/8BZDUDTJPxDGJFlNy6
	 GJ9BnG5JrC89mpRlFWc+QBE8wmLQL4TYZm/Tx0EExoTs3rw6h7UOnv6j5GHR1fkHfPxcT
	 ldKuNrhhr3rGwKX8KcMlqlulH4J9JWIG+myzMcHfWt97OShcE7IA6nrsFElk/+L6TyEyv
	 nXVeudXPk5jy+BlWa7UgZue0RkjHgerLf/pj1ltncist3bOM0EY/BYzny6KmWtLU9ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h+VQh/AmL38ZCMvqzeydsTBuUNxyHdWMzBjWeSKxMc0=;
	b=2n//HKU54BlqwenPEFkXxer/oo2XfaOF5PUYxPnZJkYum3X/f59xbcGWAuRARNEBxRFn
	 R1Qz3GmZ6EWb3iJ7Ln7d140TGEZ9oDl+TLJfGynTD4fKqX3JEZ4y+kuzJNFwf4XpRsVZZ
	 UPcGEZcQNd2970NTCSCWJRulQVuhAOQXY6rUHqMhW2bQvVktxdVUKQUIdCz3URZLWpjJy
	 F1uWfM0D3mkQf1XFOE3ktHMxDWCqp+Om0basQu6rI0DKQcPAOUImydvbO8ODDgmiGdrxm
	 2aon7x0AzzzPetUr8sUEhtqKX98AkXDW9BwKiMKzwpRKUDetaZmDebH1YLvfAdhrGlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="JGRW/2AM";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300C606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 17:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B300C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JGRW/2AM
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-353804b591eso2842879eec.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 10:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793468405; x=1794073205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h+VQh/AmL38ZCMvqzeydsTBuUNxyHdWMzBjWeSKxMc0=;
        b=JGRW/2AMeLNySqBe7BDRSGF8sZGlwaRlOclOiqJeJl6Gn6CSX+8lZHX+1zvL1qGGCm
         WGWgUP1m8VfPe2MSWHHtUqNOqVxwDeWHJkwy3GLSIlOnm6C1fINb47is5eX5lXLvW3PU
         OHlwOEJRw6uOf/taRkZwpwOHN3bf/P9Th7X4YrEaO1doceMhAhEngG5c8wYLDKFbYhBu
         g7UngjbOyEdba+Rzo7rnzLRD6hiOwH84SzdDJ4xr3iQo5eGQAh8LPGvLAZhCizOgEbEq
         7KXgrQhDayXGbFetoF+HFvxTtyh/Zrl/cKdMtljRm0bheY23Un/jpLCIa7whQWD3c/gw
         whVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468405; x=1794073205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h+VQh/AmL38ZCMvqzeydsTBuUNxyHdWMzBjWeSKxMc0=;
        b=znHXHlSPLwe6z/yUWk544RI9hHWTdIQAfQqpIwqHguQWNgEksXcHzDVat2WbaCilHx
         +uD9n8ShAEo02ROXKsxVF/6NBfhyVuQpD+CrNC6rqhcKiUFM8oAHdJQXeFRnUR9XU88Q
         /rcS6ffJUiVdQFCa23SM0xNp95I75FSZYg/U3BcQsrq/no7HnBBZ5wIhpOfhjQumaqkS
         brFnEhWudS7bTHWLb2UpyHFSGbZJgmMlVxGQ0lkesu+nNiENQ8NKcwXh0CVMC6UYGd6x
         C/eqQcsEc3veb2dt0n5hHLpCnhybjzT17Yo7A09hlk/W9tMJi8tTC9yvOz/vQ23hK/CL
         hnSA==
X-Forwarded-Encrypted: i=1; AKwUvBwcMN6JMI5WCRha2VDwW3EGKRCzPtLjVXEXhTA9Mendwey2bErBzJ/MHrAt/fcUKasjqrM4Q+c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzL55rTFpsOFRHecNw6ShkYyuY0t5tmGFhbtI95g7vw7ek9CF4
	pghFLT8DNGqvK8XDpFiChNUVpn9iiVznKOXV/wqd4zjo+EyU0F1E83Hn
X-Gm-Gg: AYBFou2HxTrbNFOjzA/2GaQD2JVA5Q8ZGFFeGjhpK5uHL6BK6WCfGoMn4BoJeIzUrgJ
	AKKQmMy/stQBc2Xu3YBwjNUrhISq5PI3GPNKRAHJ2B5LiCSTPOVvuimoNJeO2DOr0cQTfxN8n6g
	yysq4ci9n+Jdm6d8wEjbQONndqevrRhrKG61LPHpRllbVds+cczFjDYyTwll+O8AgK5lGDvsIRn
	qmj3ehAmobvR4+NtXIEVWjb2OD4RHsq7cbkebkD2Y6yO9DQWUfgBawRX+WpwvxkSqI5OGB8kCwI
	Fy3gyDXZCMchBMPRj8B3k3dKkkdsEHd2X/fbnH4kz6Yh9pEbOswyvvtsKWqswZDoSnekyBcBqlS
	rpbnEW3jIwvZ7aPGOK2USE5jgK4z+pWMlIMIo20cvI2JwKXVRDECY9cCm4tGOQK5MLaYZ7nyPS5
	MHtwkvdcDEoO4PrdBjnwnShN0cqt6fzZ398/EnMlRSes8qDNRsqkElPvg9JTqLw3iAbpL24ikXy
	Oo87MeWXsq0S3oqsWGNSSc/qhZcv3PiQWgOJzs/Z2cXWN3yakgaICzz5TUkM/mrBUqbawV0iUIn
	C+M6LHvfM2Whw/iBgSY0rkDCs9FGnHkI1HU+cuRKnKJ+OA==
X-Received: by 2002:a05:7301:6787:b0:361:306f:c32a with SMTP id 5a478bee46e88-36a42345b05mr10664935eec.11.1793468404548;
        Sat, 31 Oct 2026 10:40:04 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:51:284f:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a96172sm17207026eec.27.2026.10.31.10.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:40:04 -0700 (PDT)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>,
	stable@vger.kernel.org,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zhiling Zou <zhilinz@nebusec.ai>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net] gve: leave refcount headroom in the RX page bias
Date: Sat, 31 Oct 2026 23:04:43 +0530
Message-ID: <20261031173449.2439047-1-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
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

gve's GQI and DQO-QPL RX paths set every RX page's refcount to INT_MAX and
hand references to the stack by decrementing page_info->pagecnt_bias, to
avoid an atomic op per packet. This leaves the page no headroom: while a
fresh page's buffer sits in an skb its refcount is already INT_MAX, so a
single get_page() from the stack wraps it negative.

splice() of received TCP data into a pipe takes such a reference, and the
onward splice into a socket then fails: skb_splice_from_iter() sees
page_count() < 1, sendpage_ok() fails and the send returns -EIO (since
commit 2e910b95329c ("net: Add a function to splice pages into an
skbuff for MSG_SPLICE_PAGES"))

tee() of the pipe fails with -EFAULT via try_get_page(). On GQI the reuse
check gve_rx_can_recycle_buffer() also sees page_count() < pagecnt_bias,
WARNs and calls gve_schedule_reset(), so a task that merely pins a fresh
RX page (e.g. holds spliced data in an undrained tee() pipe) can reset
the NIC.

Use USHRT_MAX in a u16, as igb, igc, ixgbe, i40e and hns3 do: the bias only
has to make the per-packet atomic rare so a small value leaves page_count()
ample headroom below INT_MAX for the stack's references, and the u16 bounds
it. Refill by adding a fixed batch and setting the bias to it, which keeps
the rule `references = page_count() - bias` intact.

Reproduced on gVNIC in GQI-QPL mode (GCE n2-standard-8, 6.12), no kernel
changes needed, with relay.py -- a small splice(2) TCP proxy -- relaying a
download while the RX ring is refilled with fresh pages:

  ethtool -G eth0 rx 512 && ethtool -G eth0 rx 1024   # fresh RX pages
  ./relay.py $HOST 8080 &                             # splice()s both ways
  for i in $(seq 200); do curl -so /dev/null \
      --connect-to $HOST:80:127.0.0.1:8080 http://$HOST/file; done

Most downloads failed with EIO before the fix (tee() with EFAULT) and all
completed after it, including with the bias forced to 1. Built allmodconfig
W=1, no new warnings; no selftests run. relay.py is at the Link below.

This bug was found and fixed with the help of an AI coding assistant
(Claude Code) over an interactive session; it read the driver and
splice/pipe code and ran the tests above.

Link: https://github.com/amaanc/kernel-bias
Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
Fixes: 58401b2a46e7 ("gve: Add rx buffer pagecnt bias")
Fixes: 82fd151d38d9 ("gve: Reduce alloc and copy costs in the GQ rx path")
Cc: stable@vger.kernel.org
Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
---
 drivers/net/ethernet/google/gve/gve.h                |  2 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c    |  4 ++--
 drivers/net/ethernet/google/gve/gve_rx.c             |  8 ++++----
 drivers/net/ethernet/google/gve/gve_utils.c          | 12 +++---------
 drivers/net/ethernet/google/gve/gve_utils.h          |  8 +++++++-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index b7ce6e8632db..18d7edbf4b3b 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -119,7 +119,7 @@ struct gve_rx_slot_page_info {
 	void *page_address;
 	u32 page_offset; /* offset to write to in page */
 	unsigned int buf_size;
-	int pagecnt_bias; /* expected pagecnt if only the driver has a ref */
+	u16 pagecnt_bias; /* expected pagecnt if only the driver has a ref */
 	u16 pad; /* adjustment for rx padding */
 	u8 can_flip; /* tracks if the networking stack is using the page */
 };
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 6880d1531ba5..571f851d6dcd 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -149,8 +149,8 @@ int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx,
 	buf_state->last_single_ref_offset = 0;
 
 	/* The page already has 1 ref. */
-	page_ref_add(buf_state->page_info.page, INT_MAX - 1);
-	buf_state->page_info.pagecnt_bias = INT_MAX;
+	page_ref_add(buf_state->page_info.page, GVE_PAGECNT_BIAS - 1);
+	buf_state->page_info.pagecnt_bias = GVE_PAGECNT_BIAS;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 81ea800e66e9..6533fff06155 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -152,8 +152,8 @@ static void gve_setup_rx_buffer(struct gve_rx_ring *rx,
 	page_info->buf_size = rx->packet_buffer_size;
 	*slot_addr = cpu_to_be64(addr);
 	/* The page already has 1 ref */
-	page_ref_add(page, INT_MAX - 1);
-	page_info->pagecnt_bias = INT_MAX;
+	page_ref_add(page, GVE_PAGECNT_BIAS - 1);
+	page_info->pagecnt_bias = GVE_PAGECNT_BIAS;
 }
 
 static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
@@ -230,8 +230,8 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 			rx->qpl_copy_pool[j].buf_size = rx->packet_buffer_size;
 
 			/* The page already has 1 ref. */
-			page_ref_add(page, INT_MAX - 1);
-			rx->qpl_copy_pool[j].pagecnt_bias = INT_MAX;
+			page_ref_add(page, GVE_PAGECNT_BIAS - 1);
+			rx->qpl_copy_pool[j].pagecnt_bias = GVE_PAGECNT_BIAS;
 		}
 	}
 
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index caed38cd5f2b..cb6fba3122d5 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -93,15 +93,9 @@ void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info)
 {
 	page_info->pagecnt_bias--;
 	if (page_info->pagecnt_bias == 0) {
-		int pagecount = page_count(page_info->page);
-
-		/* If we have run out of bias - set it back up to INT_MAX
-		 * minus the existing refs.
-		 */
-		page_info->pagecnt_bias = INT_MAX - pagecount;
-
-		/* Set pagecount back up to max. */
-		page_ref_add(page_info->page, INT_MAX - pagecount);
+		/* Out of bias: take another batch of references. */
+		page_info->pagecnt_bias = GVE_PAGECNT_BIAS;
+		page_ref_add(page_info->page, GVE_PAGECNT_BIAS);
 	}
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_utils.h b/drivers/net/ethernet/google/gve/gve_utils.h
index bf2e9a0adb36..316f97607351 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.h
+++ b/drivers/net/ethernet/google/gve/gve_utils.h
@@ -25,7 +25,13 @@ struct sk_buff *gve_rx_copy_data(struct net_device *dev, struct napi_struct *nap
 struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
 			    struct gve_rx_slot_page_info *page_info, u16 len);
 
-/* Decrement pagecnt_bias. Set it back to INT_MAX if it reached zero. */
+/* Up-front references gve holds on an RX page, so handing a buffer to the
+ * stack is a pagecnt_bias decrement, not a get_page(). Keep it in a u16 so
+ * the 32-bit page refcount keeps the headroom every page needs below INT_MAX.
+ */
+#define GVE_PAGECNT_BIAS USHRT_MAX
+
+/* Decrement pagecnt_bias. Top it up by GVE_PAGECNT_BIAS if it reached zero. */
 void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info);
 
 void gve_add_napi(struct gve_priv *priv, int ntfy_idx,

base-commit: d8a4f4c59da52b7c31ae337243b8473a19a3f819
-- 
2.47.3

