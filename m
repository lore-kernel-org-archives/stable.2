Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D04B829D
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660440; cv=none; b=RXnAptdyw/jfN/8yncvzOnMhwUP2KxfHqSSLFnzfGjnrxadY8JF4U0IzmKOErYTgzyx3KCgNEcizQVWUYg2fl4kumPi+1rG3kdrwiWXxCT2z3WyzuwQmR2+W3n6GgGePdfAPzD43ZBR2He1uA6DU1GGVMjrA4b9vLqDnBiNAQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660440; c=relaxed/simple;
	bh=qX2vkMv2alDcVuZws/jtoJQZfCUu+xK7oFqiK0jOR5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uqeiw2PcYUdOw7s7HjXhTxvK9kToTS/z9WUVL4hHx/OkqIsPqrMWKmYXdini8YVopG8pa083n0IYu/PrYhxCqWkuwBAG703pwV8HyhYrdFj32+9bsWn3k1FnW1ePhcJL92u3lcF8rXaRJtDUy3pHGa3mQ4poLYgVcDnPgmI8dSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=ZTacB7jm; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="ZTacB7jm"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-354ba08cfd1so1346904eec.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791660434; x=1792265234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+jqZ8ErKDJ0L6+pcxEme+gGbHdqZV3pG5aqAtbxFAQ4=;
        b=ZTacB7jmdJmGKm89zLKBIOlAQ2YMZF63ckbXTKjuBGbQp+ygq6LKcaAOwXF/wTtl7U
         34GChGlP3glggeO4wo7uDsgLY9GWB/54wRIzolbGBysdA3wld+J6G0oefNPVrYVNXClU
         yGxpTZ6Phq+x8/kPmq03IZH4MOpuD0rXNl3a5imbaeClh08TJHJrUnY3FaEYt+e+QjPe
         vzDlBoI/R8gcF5p+djyj76PRiIPLXsLIcdWtMeKj4cyZL1vA3nuuWAq7cfv8C77T/0ic
         38TbYsU9y4Gdp/ji8HIv5XnL6TgeW9CHnjGTTd8gxaUoeaLHZ3OOpRATZg4Susi55z17
         AzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791660434; x=1792265234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+jqZ8ErKDJ0L6+pcxEme+gGbHdqZV3pG5aqAtbxFAQ4=;
        b=JvMmBVDzrjsLXTOVUP2ZXyEe6uRdQkGA3D1iDnq1NyHS/iLg//R2AJcE0m6qWbaki+
         k4SL99RhG9GJhNrAUT0q7+6xTsuQuOI26qoh5SKarSZgQiRdCOFKbv3hPgY8urYn2YI8
         C+6zhhKLW0AEOfmO2VLm+QU8NV4G7SWgLe/iy6LfXkmI7HmFCGexMC2qw+53imtJidAW
         lS+Vub98NVSD/WFIlohG9C3CGxJa0wJhFzRL0vhZGdY2h8nJnz3Qj+8UANpSxc1oKMvu
         3NHPHKD/yeBXjrpV+lXUa/sOvOvvAGmL99fn2xpYkgUPOIU+NdudmET9TbBkWasfHzyx
         L3Cw==
X-Forwarded-Encrypted: i=1; AKwUvBzWji+7wOO4qx0guU65XEwKvOAqqb2eiwNQf85g9Qhh7HE4NWksD/Qj9TB6tJJm4KL82KWKAf8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJONyyZWdVo6AuZlOnMNXPWDF8l6CMDJkvP6y5MpIWDSPNDTic/
	eP0pgKcGm1CPmavGFuLQ9kZYBCg9+1lQwmGosVsCLiPz6Gyd1IKncxk/awYyAqjp/oo=
X-Gm-Gg: AYBFou25EiwtikIjKve051Kx7i0SmkjoKNmQdB4/4uvlgE9KnjQ5PoX5PeU/Q6mAK86
	OjrUoMcd6Zjt6fy9H+cYLMnrdNFfH5T7N8CCBleO7gUT+EL9Fx4Vb1PwlG/1OYjqz+RYCvtxAVs
	uB+tT2FUMext7Itb6G5Flz4C36fD66W2uyAaBSTNgas1Mik2KKMbzsX3uSgUgkp3/Jm3BWYlXq8
	pPbnOaXOZtLZQvkPt42FauF2qPIus2qpBUxQqVWcZyi5CiMbJKHHc4AzMc2+uythZaMWZNdaxZV
	pTrbKbGA0duSTXTy1hLvLGs0lS5PJeQyvCldXkZ4JQit4R77y7uCywSf4frLzhVXZs+Yr5KH3tw
	RNH5yoC4zb6ec2pLmy+5xlS+0oZpUOHWYR+bxWDk8bWnhGWCyIubJ/o4QWNau6c8onTdqV1d2nS
	hPAlG9yd/iAyDr7WJ+HyqGIG6d8lYIAcUK+Pe8PFuAn3Sm+ejG7AcW5ENwFFhfnu3nD29uUv8wA
	JyKR0765EbFqT0TC5woFjpt1JBzC+QQxQ==
X-Received: by 2002:a05:7301:53c1:b0:351:5cb5:53f7 with SMTP id 5a478bee46e88-3537dedd531mr8037184eec.3.1791660433129;
        Sat, 10 Oct 2026 12:27:13 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:9657:9541:a576:7d2f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm18641806eec.10.2026.10.10.12.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 12:27:12 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v2 1/2] eth: fbnic: validate the Rx completion buffer index
Date: Sun, 11 Oct 2026 04:26:49 +0900
Message-ID: <5c05a7f423b5a0dd5e30d7dd8bac268da1289538.1791659860.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buffer ID in an address/length Rx completion descriptor is a 16 bit
field, FBNIC_RCD_AL_BUFF_PAGE_MASK being DESC_GENMASK(15, 0) once the
fragment bits are removed, so the device can name any index from 0 to
65535.  fbnic_pkt_prepare() and fbnic_add_rx_frag() feed that value
straight into fbnic_page_pool_get_head() and fbnic_page_pool_get_data(),
which use it to subscript qt->sub0.rx_buf[] and qt->sub1.rx_buf[], and
fbnic_clean_rcq() keeps the same value in head0/head1 and hands it to
fbnic_clean_bdq() as the position the device has consumed up to.

Those arrays only cover the buffers the driver posted.  They are
allocated with size_mask + 1 entries, and size_mask comes from
hpq_size / FBNIC_BD_FRAG_COUNT, so at the default FBNIC_HPQ_SIZE_DEFAULT
of 256 each array holds 256 entries of 16 bytes, that is 4096 bytes.  A
buffer ID of 65535 reaches 1048560 bytes past the start of the
allocation.

The fill side already masks every index it computes against
bdq->size_mask, and so does all of the ring head and tail arithmetic.
The completion side does not.  A descriptor naming a buffer that was
never posted makes fbnic_page_pool_get_head() decrement pagecnt_bias
through a pointer outside the array and hand the out-of-bounds
netmem_ref back as a struct page; page_pool_get_dma_addr() and
page_address() then dereference it and the skb is built on whatever it
points at.

Injecting an out-of-range header completion reports under KASAN:

  BUG: KASAN: slab-out-of-bounds in fbnic_page_pool_get_head
  Read of size 8 at addr ffff88800c719008
  The buggy address is located 8 bytes to the right of
   allocated 4096-byte region [ffff88800c718000, ffff88800c719000)

Check the ID against size_mask before it is used and drop the packet if
it is out of range.  Masking it instead would keep the access in bounds
but would silently attribute the completion to an unrelated buffer that
the driver does own, which is worse than a drop.  Set add_frag_failed so
the frame takes the existing error path.

fbnic_clean_bdq() needs the same value bounded, for a different reason.
It walks from ring->head to the head the device reported, masking its
own running index against size_mask on every step:

	do {
		fbnic_page_pool_drain(ring, head, napi_budget);

		head++;
		head &= ring->size_mask;
	} while (head != hw_head);

A hw_head above size_mask is therefore never reached.  The loop drains
every buffer on the ring, wraps, and comes back to a slot whose netmem
fbnic_page_pool_drain() has already cleared, so page_pool_unref_netmem()
runs on a NULL netmem:

  BUG: KASAN: null-ptr-deref in fbnic_clean_bdq
  Read of size 8 at addr 0000000000000028

Return without touching the ring in that case.  head0 and head1 are
recomputed on every poll, so the first head the driver can act on lets
the clean-up catch up from ring->head and no buffer is leaked.  Masking
the head instead would release buffers the device never said it was done
with.

Finally, fbnic_add_rx_frag() has to mark the packet when it bails out on
a buffer that was never set up.  That bail is reached both when a header
completion was rejected and when the device sends a payload completion
with no header completion ahead of it, and in the second case
add_frag_failed is still clear, so the metadata descriptor treats the
packet as good and builds an skb on an empty buffer:

  BUG: KASAN: null-ptr-deref in __build_skb_around
  Write of size 32 at addr 0000000000000ec0

Set add_frag_failed there so the metadata case drops the frame instead.
On the normal path data_hard_start is always set, so the bail is not
taken and the buffer accounting is untouched.

Fixes: a29b8eb6e533 ("eth: fbnic: Add basic Rx handling")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 38 ++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 10caacffee0f0..b4ca9f7e8bb2e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -882,6 +882,13 @@ static void fbnic_clean_bdq(struct fbnic_ring *ring, unsigned int hw_head,
 {
 	unsigned int head = ring->head;
 
+	/* A head outside the ring cannot name a buffer we posted, and the
+	 * loop below masks head to the ring so it would never reach it.
+	 * Leave the ring alone and wait for a head we can act on.
+	 */
+	if (unlikely(hw_head > ring->size_mask))
+		return;
+
 	if (head == hw_head)
 		return;
 
@@ -985,14 +992,24 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
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
 
+	/* A buffer ID the device never got from us cannot name a buffer we
+	 * own, so drop the packet instead of running off the end of rx_buf[].
+	 */
+	if (unlikely(hdr_pg_idx > qt->sub0.size_mask)) {
+		pkt->add_frag_failed = true;
+		return;
+	}
+
+	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
+
 	/* Short-cut the end calculation if we know page is fully consumed */
 	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
 		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);
@@ -1026,10 +1043,27 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
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
+	if (unlikely(pg_idx > qt->sub1.size_mask)) {
+		pkt->add_frag_failed = true;
+		return;
+	}
+
+	netmem = fbnic_page_pool_get_data(qt, pg_idx);
+
 	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
 		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
 
-- 
2.43.0

