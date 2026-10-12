Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D883955D3
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778587; cv=none; b=Gn3+jZs6yWPAtNlx5gdh38kj6l1gACzHtfr9WfiuWAMiV8FjjO0IJxGopNTCvsJw8pVbMf+lITD0EGgMrEY/VyIC6p+DkfU91vzOEKezzDJaTI+56VvaJPlQseKh4Br74RpHyX63G7+wFF64sBpSLs/SlOGqLx1cXhHbsM0QgE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778587; c=relaxed/simple;
	bh=ik6Xbq3F+FFAo/jf+qyeXH66b6QWgVj/WZo2MGXe4N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrhD4jp7l0zADYbvdw7ObMRzdkGW7LcHNyV14rKJRVUwjXJ6RorACDUCCGVO21VIU9eauT3s+HgPpmnYRK9iNOa/RB1YKhbNdc7pQTByXgaLCpKfVT/lw3t+7Nf9eZhQqOCQDGkJm+lNFfSBf1SLRWgWm+/mh4fyilkRn2W1qlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=Eoq1n6ah; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="Eoq1n6ah"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e81738d24eso13324685ad.1
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 21:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791778584; x=1792383384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ozoBovyE5iIy57BdoSb6WWm/3cssooBkyf+Ta3lJtw=;
        b=Eoq1n6ahRYjnVdfMBI+pMK0Z91aJMcwpiwxgJVqqNFltykKs6ptiZS8yHcRcDKsYTG
         AgZ+U1wzQTxSGnyC6aSvXbjO54++/1SVkKUjfduyZiIj7FQazjvd3LCAr6UdmCjfaRX5
         Fs0PIlC5MekB1H2ydKgMhN8RIeYFSeyCzymxXLBCmeZZmlP2uGzEHa/IcgQDp8C07btD
         0s8P/xyis0RMHJjhciJJRa6XJtebmzuRJ8DdQHQi8YcE5rDVADOCv9UVjnLyyLTQYnNx
         ehvPX6+MUfcvfacxYmYS8+rSN3JZI2wRuGRRiq6ny5vmocyzOOug0Xj9TpHXT6NaOG4J
         0Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791778584; x=1792383384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ozoBovyE5iIy57BdoSb6WWm/3cssooBkyf+Ta3lJtw=;
        b=AZGTviwsipyNRD0+gidCnswEah/SSw5HsmExjkTA2Dv+qvpAuYo0ukM8YjkHpUZXny
         wislhiiwgscQYtTYnGl5bLfOrdvkHNP8AHcTCedjDEjTxJ/5UBIS0Tn0jbBqDLTBEh8F
         yosSBUKpA1AnYUPKJ0FL0OyERVPySeOgaG+1X236NnyEed2VTqSbROkXSnzHOeri2cyp
         WNV/mi7sX2vTv7MAzvOWpAP0cEi1Hx4jqwwqE+fd7qK9FvD84Z0MGw32zOAuIdfZ9r8Z
         4pQPjJ+ZIV/uFtZqiSsq1GYdcrIyE1RMp3dt1M0hTRTTrsGR48GaDF+l4x0QrV4LLJ7a
         +Q0w==
X-Forwarded-Encrypted: i=1; AKwUvBxN9jGVACuGFsQSo3/23al0OWsUl3sL2S8QJuKKHpxSKe7xJ8yVOXAniZfCMNB3IjlN4+6u2AI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcqYzZgs0user1sUTRcpjFWuw2zTM/yKKgFlHsJq3B+Dh6ucOm
	I7xrTm+fKVgbpOR7rMAInQ0h2wblTofbXHMSC+TOg4aLtejfd1bEnCue/cgIITH9cBY=
X-Gm-Gg: AYBFou1BcKhct2ueO7Je4lJjGpSTaj0JLPbawmZV/MtMJYMGptboQf4KvyNl6d1z+Mi
	wYyHKR5ehdjfYkNX9khCCou40YS3TE0XpCF5s+DybG0CkAGowK9fxXSZDkpesmVm1idQRHgkkhT
	HcBHCzMBQEd08JumnLVYN9WocrJdj2rNnUpnExy83UAwJpKmriZJ0rvMXRYVR8rfCT9n//MrDVr
	un1tR/LpxJC3xY6DT3MYLBn0OTn06B/PjCzWZnIfju7w4eikmcv+qKysF9MFImY7XHcEoIo4W8i
	JOqBM9OX8yqaUk3jM1iKq6Sw+8mcKOSmmDb3v1uQVAp237VLoZtWzIaAzGBZ8MbZLFGyAn817Ri
	huyx9M6gtg6jX8BjTIb62wV6EluZJQXO5eRgRx1mlQIcHKVdbyuHSXQ/A+ST3GcOCaGmfuXJbTp
	cfKVyUBQ/vZMJ9o13r9dgsWKeXassyozd9iUWzLe8zE6KzyNWOYBUXkkDHvxQsM+ojKXysc4PPN
	6OlGg==
X-Received: by 2002:a17:902:ec8d:b0:2e8:3cab:3af1 with SMTP id d9443c01a7336-2e842cfbc69mr72576765ad.23.1791778584424;
        Sun, 11 Oct 2026 21:16:24 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421af46asm38240025ad.39.2026.10.11.21.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:16:23 -0700 (PDT)
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
Subject: [PATCH net v3 1/5] eth: fbnic: only act on Rx completions naming a posted buffer
Date: Mon, 12 Oct 2026 13:15:56 +0900
Message-ID: <25ce85c9821fba5d94932b36b9c9afb9a2fbd12a.1791775409.git.yhlee@isslab.korea.ac.kr>
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

An Rx completion descriptor carries a 16-bit buffer id that the driver
uses to index the rx_buf[] array (FBNIC_RCD_AL_BUFF_PAGE_MASK). The fill
path masks the id to the ring size, but the completion path does not, so
the device can hand back an id that is past the array or that names a
slot which was never posted. An unposted in-range slot holds netmem 0,
and netmem_to_page(0) returns NULL, which fbnic_pkt_prepare() and
fbnic_add_rx_frag() then dereference.

Masking the id would not fix this: it aliases an out-of-range id onto a
posted buffer and corrupts that buffer's page_pool reference count.
Reject a completion whose id is outside the array or outside the posted
window and take the existing drop path.

The same id is used as the BDQ head in fbnic_clean_bdq(), where an
out-of-range value spins the cleanup loop; bound it there with the same
test. Validate head0/head1 in fbnic_clean_rcq() before they are assigned,
and drop a META completion that arrives with no header buffer rather than
building an skb around a NULL pointer.

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000004: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
  RIP: 0010:fbnic_pkt_prepare+0x1a2/0x5a0 [fbnic]
  Call Trace:
   <TASK>
   fbnic_clean_rcq+0x1ba/0x1350 [fbnic]

Fixes: a29b8eb6e533 ("eth: fbnic: Add basic Rx handling")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 87 ++++++++++++++++++--
 1 file changed, 82 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 10caacffee0f0..305fe6d2f511f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -797,6 +797,34 @@ static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
 	rx_buf->netmem = 0;
 }
 
+/* The device names an Rx buffer by its index in the buffer descriptor
+ * ring.  A completion may only name a buffer we posted, that is one in
+ * [head, tail), so test the index against the array and against the
+ * posted window.  The window test is not enough on its own: it masks the
+ * index, so an index past the end of the array can fold back into the
+ * window and run off rx_buf[].
+ */
+static bool fbnic_rx_buf_posted(struct fbnic_ring *ring, unsigned int idx)
+{
+	if (idx > ring->size_mask)
+		return false;
+
+	return ((idx - ring->head) & ring->size_mask) < fbnic_desc_used(ring);
+}
+
+/* fbnic_clean_bdq() is given a position to consume up to rather than a
+ * buffer to use, so unlike fbnic_rx_buf_posted() it also accepts tail,
+ * which is how the teardown path asks for the whole ring to be drained.
+ */
+static bool fbnic_bdq_head_valid(struct fbnic_ring *ring, unsigned int hw_head)
+{
+	if (hw_head > ring->size_mask)
+		return false;
+
+	return ((hw_head - ring->head) & ring->size_mask) <=
+	       fbnic_desc_used(ring);
+}
+
 static void fbnic_clean_twq(struct fbnic_napi_vector *nv, int napi_budget,
 			    struct fbnic_q_triad *qt, s32 ts_head, s32 head0,
 			    s32 head1)
@@ -882,6 +910,13 @@ static void fbnic_clean_bdq(struct fbnic_ring *ring, unsigned int hw_head,
 {
 	unsigned int head = ring->head;
 
+	/* A head we never posted cannot name a buffer we own, and the loop
+	 * below masks head to the ring so it would never reach it.  Leave
+	 * the ring alone and wait for a head we can act on.
+	 */
+	if (unlikely(!fbnic_bdq_head_valid(ring, hw_head)))
+		return;
+
 	if (head == hw_head)
 		return;
 
@@ -985,14 +1020,25 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 {
 	unsigned int hdr_pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
 	unsigned int hdr_pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
-	struct page *page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
 	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
 	unsigned int frame_sz, hdr_pg_start, hdr_pg_end, headroom;
 	unsigned char *hdr_start;
+	struct page *page;
 
 	/* data_hard_start should always be NULL when this is called */
 	WARN_ON_ONCE(pkt->buff.data_hard_start);
 
+	/* A buffer ID we never posted cannot name a buffer we own, so drop
+	 * the packet instead of running off the end of rx_buf[] or picking
+	 * up a slot we have already drained.
+	 */
+	if (unlikely(!fbnic_rx_buf_posted(&qt->sub0, hdr_pg_idx))) {
+		pkt->add_frag_failed = true;
+		return;
+	}
+
+	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
+
 	/* Short-cut the end calculation if we know page is fully consumed */
 	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
 		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);
@@ -1026,10 +1072,27 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 	unsigned int pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
 	unsigned int pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
 	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
-	netmem_ref netmem = fbnic_page_pool_get_data(qt, pg_idx);
 	unsigned int truesize;
+	netmem_ref netmem;
 	bool added;
 
+	/* No header completion has set buff up, either because one was
+	 * rejected or because the device sent none, so there is nothing to
+	 * add a fragment to.  Mark the packet so the metadata descriptor
+	 * drops it instead of building an skb on an empty buffer.
+	 */
+	if (unlikely(!pkt->buff.data_hard_start)) {
+		pkt->add_frag_failed = true;
+		return;
+	}
+
+	if (unlikely(!fbnic_rx_buf_posted(&qt->sub1, pg_idx))) {
+		pkt->add_frag_failed = true;
+		return;
+	}
+
+	netmem = fbnic_page_pool_get_data(qt, pg_idx);
+
 	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
 		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
 
@@ -1270,6 +1333,7 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	while (likely(packets < budget)) {
 		struct sk_buff *skb = ERR_PTR(-EINVAL);
 		u32 pkt_bytes;
+		u32 pg_idx;
 		u64 rcd;
 
 		if ((*raw_rcd & cpu_to_le64(FBNIC_RCD_DONE)) == done)
@@ -1281,12 +1345,21 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 
 		switch (FIELD_GET(FBNIC_RCD_TYPE_MASK, rcd)) {
 		case FBNIC_RCD_TYPE_HDR_AL:
-			head0 = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
+			pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
+			/* Only take the head from a completion we are going
+			 * to act on, so that one rejected ID does not discard
+			 * the progress an earlier completion in this poll has
+			 * already reported.
+			 */
+			if (likely(fbnic_rx_buf_posted(&qt->sub0, pg_idx)))
+				head0 = pg_idx;
 			fbnic_pkt_prepare(nv, rcd, pkt, qt);
 
 			break;
 		case FBNIC_RCD_TYPE_PAY_AL:
-			head1 = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
+			pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
+			if (likely(fbnic_rx_buf_posted(&qt->sub1, pg_idx)))
+				head1 = pg_idx;
 			fbnic_add_rx_frag(nv, rcd, pkt, qt);
 
 			break;
@@ -1300,7 +1373,11 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			/* We currently ignore the action table index */
 			break;
 		case FBNIC_RCD_TYPE_META:
-			if (likely(!fbnic_rcd_metadata_err(rcd) &&
+			/* A metadata completion with no header completion
+			 * ahead of it leaves nothing to build a frame from.
+			 */
+			if (likely(pkt->buff.data_hard_start &&
+				   !fbnic_rcd_metadata_err(rcd) &&
 				   !pkt->add_frag_failed)) {
 				pkt_bytes = xdp_get_buff_len(&pkt->buff);
 				skb = fbnic_run_xdp(nv, pkt);
-- 
2.43.0

