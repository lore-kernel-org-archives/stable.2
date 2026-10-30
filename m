Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327595;
	b=WDnfOcBVFrk9tOkIoQ+PrVy+u6vgIlacihLGPawMBoBd2mcn5NA9Sj3j3gNIbpS8/YiG
	 sCuZA5XnLgSoTpNFxTI5KIyPDiBdFyzVinUgDc58vixh9OCcW8CZE4JkxDAqxHmZsAfiH
	 nS7wL5Bp/gnKks5+cBJOOG1XAuiPI5sjNWE0K0UIAGJ1JLq+ishuoLKJz1078ma7RNKsU
	 MVUnB6GDNX8MPRV+Asiqi/u/GqCb3lI+yKmPWROdzsqP2v5VcZHSugMZr6XTdMs0aHhoS
	 +YnLQy++3RlOWprb8QQTO4rEO5OEUNmlBZRQMkKT0YumkX4YIGGL0bX6e6Y2jhnyYNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0K6cB7nWKEstKbBLqxn1nNdZR7J+XsbPrVECCeNP37U=;
	b=1Wj/CKTnCFHBlTggxj2Kb4MMiQtqeSm+2hsCc1B98ybVkCReyK+wr+nF6CSJiATvGV0f
	 Dza9C4V9bhByoYETaPS/8uGEXj2VV8d8yeWXdZvy4iaiRJ05/8sHOQvN4afksMJS7TE3q
	 GG4IdstI6v7GoXN3+Yy2LhVdwqJWrIiEHcRePAVuBNusLUf/f1HXDLwTh/3Uijrdzen/O
	 zf5izQYTt7iywtzEP/su4uKLKs/40X5EDlgpGQnbU285PunWTM6kLXkRx1xhhTLWX7Vgm
	 GOVVq+BuOZGl82uJmTsBeR0gRwrCbLrsLcRyH7bYwDsVerWxPwWXm7wVptHHaXTA/3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhYKW89r;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA41606A31F
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 02:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA41606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhYKW89r
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2ea19bc317dso1905805ad.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 19:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793327594; x=1793932394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0K6cB7nWKEstKbBLqxn1nNdZR7J+XsbPrVECCeNP37U=;
        b=hhYKW89rmpWPjeNPAnddAC7iekEyhHyPOLk3bx5Zyi7zRxBi5YHhvlwIBH596UeZSP
         3Eoe/gsSM3CFvkotK7eYB+amgOhQnCrbpmrpEeQimCx2EH/Xn5diQkRNhranXK1rmVaQ
         CWC2a/cfXOn/EmXfErq/nXr6WQak7XpPfkCGEpgTEjB0dqB1KIOP4bJBeGlZ0px86Fhi
         o3bRatvSSDymt8e6VDQY5F2jfNVsnYRPs022fiItSvBWlxw5uGmu0nwPYCq71YEoi6p7
         KR+atXRjfG7BW2rIjWLLd1CxPm4oFwgyFcMGbAZa5F/yaW9CXh0eMHZfIHRLCj/BYr1v
         XDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793327594; x=1793932394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0K6cB7nWKEstKbBLqxn1nNdZR7J+XsbPrVECCeNP37U=;
        b=jfV3iEHgUQ/2c6hLr7fwHmXSyEQ/SJJHR4L01nTUKEPT2mWDBjiXlUezn8caNFEtNt
         cxsXsnxKevTep8vBLrS8m2UetGBYKNvsdwVFWI5JcnoNauvsfzKA0WlL6ED8QNVzBUhG
         sKjPUWxTZoxTSeOu8N1w9/2j8uni4HSK01U+oMsK7m5oN0cbYzx8piGnkh3JKFFRKFHk
         1vWqMryDK3dKMYW9EWAKS5c/9B7+PmgLiivwvNF4IYvXWpcmB91urEL2/9gx0rO1uPyD
         ekZP1QC/mVLj+zAlYinq5mhGsJdc2ELX8SJrR56z1bLMdNEZZ6nlNAxUf3Ig9RA5SB8s
         xZcQ==
X-Forwarded-Encrypted: i=1; AKwUvByjkrfxIlUnHCiD7Ukxf7eC1RKsB+oR1+9ctrYBcmk6oRf1ablXfkhK8YcsdV+cuUI0FOinnX0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL55MgVfMhcwEbEucPiJk/S4MUlnKL6we9Y02HUTbXv+t3I9OR8
	omUS15wKTna8v4A3Ad/6DjpjIFJPPxf0E88b3I8gH/xUobnCRtFxnDyo
X-Gm-Gg: AYBFou28oXTcQHRAXY68YYnnsgVucDvYnfQTSizRjpE7VTiS0fj5MsUwHgC4EfCrMFB
	jmtRmovTDvAjjax0tWUJhN+lnwMG0bD+j3OYjCsQQIAtWb3c6RWeBlzgJlf1YJSOBu6D9zv0H3U
	bYaxbOa0ZxVJByMzJwktGT0POYqFfawlhNbiL5MI+ATDryDXC0Aqh8Y0px/awG0iw1Sax7YLV9+
	wBEX4FAkIO/1XMOL4bWtz6ge13oy8pbozhiSnGNnQcVnys4itoI407lsEa9RvqAXKPQPAtHa7oQ
	M7nksslnmG/Qyu3XVq56QhsRUtABhIkWszUa0ii8P/618zgnihUxdbO8q7KvIWHHUUZ9u+u9HZF
	AMmDA8Hs5/n4edGb+m3is1hEoRHTQo0UX0ntnNc6eplwtHhIjhl02Q5GnxcsVyzlf6AFxFfZTh1
	fYUnGuow8l2abwQ1OmC64vbfMsFOea/w32i6Rd6SVqctyxtVmL7Z5tiRTqfpyUI6fiXssWgUIKC
	L0pUORneN6aN+Uedz+8/JEtRL+A9bUvD3T3LSaUNzQwZt7cdYk1Qq5YXCDbN4j2tS6BNFCIXqSO
	9pvggJWpp1GzTvk3BLmjYEPYCILgRPgZMxgxb3vQCR5d9eUHNOwpoA==
X-Received: by 2002:a05:6a20:c70e:b0:3c3:875d:c52f with SMTP id adf61e73a8af0-3e928784774mr903179637.10.1793327593925;
        Thu, 29 Oct 2026 19:33:13 -0700 (PDT)
Received: from localhost.localdomain ([58.247.233.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef95f2dsm152216b3a.10.2026.10.29.19.33.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 19:33:13 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v4 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Fri, 30 Oct 2026 10:32:48 +0800
Message-Id: <20261030023248.78802-3-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261030023248.78802-1-testwrzwrz@gmail.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com>
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

Extend test_xdp_metadata to send the same UDP packet using every descriptor
count from 1 through MAX_TX_DESCS (MAX_SKB_FRAGS + 1), and to run the
existing metadata and checksum verification for each case.

Build the packet once and write it into the TX descriptors in a loop
instead of using a flat two-descriptor layout. Keep the first descriptor
large enough to cover the checksum offset; the remaining payload is split
across the continuation descriptors, with the last descriptor taking the
remaining length.

Reuse the existing AF_XDP setup, packet generation, completion, and receive
helpers in xdp_metadata.c instead of adding a separate test harness.

Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 147 +++++++++++-------
 1 file changed, 92 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 5c31054ad4a4..17da0a145666 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -18,12 +18,15 @@
 #define TX_NAME "veTX"
 #define RX_NAME "veRX"
 
-#define UDP_PAYLOAD_BYTES 4
+#define UDP_PAYLOAD_BYTES 32
+
+#define MAX_SKB_FRAGS 17 /* minimum CONFIG_MAX_SKB_FRAGS */
+#define MAX_TX_DESCS (MAX_SKB_FRAGS + 1)
 
 #define UDP_SOURCE_PORT 1234
 #define AF_XDP_CONSUMER_PORT 8080
 
-#define UMEM_NUM 16
+#define UMEM_NUM 64
 #define UMEM_FRAME_SIZE XSK_UMEM__DEFAULT_FRAME_SIZE
 #define UMEM_SIZE (UMEM_FRAME_SIZE * UMEM_NUM)
 #define XDP_FLAGS XDP_FLAGS_DRV_MODE
@@ -56,13 +59,13 @@ struct xsk {
 	struct xsk_socket *socket;
 };
 
-static int open_xsk(int ifindex, struct xsk *xsk)
+static int open_xsk(int ifindex, struct xsk *xsk, __u32 bind_flags)
 {
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
 	const struct xsk_socket_config socket_config = {
 		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
-		.bind_flags = XDP_COPY,
+		.bind_flags = bind_flags,
 	};
 	const struct xsk_umem_config umem_config = {
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
@@ -133,31 +136,35 @@ static void close_xsk(struct xsk *xsk)
 	munmap(xsk->umem_area, UMEM_SIZE);
 }
 
-static int generate_packet(struct xsk *xsk, __u16 dst_port)
+static int generate_packet(struct xsk *xsk, __u16 dst_port, u32 num)
 {
 	struct xsk_tx_metadata *meta;
 	struct xdp_desc *tx_desc;
 	struct udphdr *udph;
 	struct ethhdr *eth;
 	struct iphdr *iph;
+	u16 first_len;
+	u16 pkt_len;
+	u8 pkt[256];
+	u32 offset;
 	void *data;
 	__u32 idx;
+	u32 addr;
 	int ret;
+	u32 i;
 
-	ret = xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
-	if (!ASSERT_EQ(ret, 1, "xsk_ring_prod__reserve"))
+	pkt_len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
+	first_len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph);
+	if (!num || num > MAX_TX_DESCS ||
+	    (num > 1 && pkt_len - first_len < num - 1))
 		return -1;
 
-	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
-	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + sizeof(struct xsk_tx_metadata);
-	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
-	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
-
-	meta = data - sizeof(struct xsk_tx_metadata);
-	memset(meta, 0, sizeof(*meta));
-	meta->flags = XDP_TXMD_FLAGS_TIMESTAMP;
+	ret = xsk_ring_prod__reserve(&xsk->tx, num, &idx);
+	if (!ASSERT_EQ(ret, num, "xsk_ring_prod__reserve"))
+		return -1;
 
-	eth = data;
+	memset(pkt, 0, sizeof(pkt));
+	eth = (void *)pkt;
 	iph = (void *)(eth + 1);
 	udph = (void *)(iph + 1);
 
@@ -180,18 +187,43 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	udph->source = htons(UDP_SOURCE_PORT);
 	udph->dest = htons(dst_port);
 	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
+	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
 	udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
 					 ntohs(udph->len), IPPROTO_UDP, 0);
 
-	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
-
-	meta->flags |= XDP_TXMD_FLAGS_CHECKSUM;
-	meta->request.csum_start = sizeof(*eth) + sizeof(*iph);
-	meta->request.csum_offset = offsetof(struct udphdr, check);
+	for (i = 0, offset = 0; i < num; i++) {
+		u32 len;
+
+		if (num == 1)
+			len = pkt_len;
+		else if (!i)
+			len = first_len;
+		else if (i == num - 1)
+			len = pkt_len - offset;
+		else
+			len = (pkt_len - first_len) / (num - 1);
+
+		addr = (idx + i) % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
+		tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + i);
+		tx_desc->addr = addr + sizeof(*meta);
+		tx_desc->len = len;
+		tx_desc->options = i ? 0 : XDP_TX_METADATA;
+		if (i + 1 < num)
+			tx_desc->options |= XDP_PKT_CONTD;
+		printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx + i, tx_desc->addr);
+		data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
+		if (!i) {
+			meta = data - sizeof(*meta);
+			memset(meta, 0, sizeof(*meta));
+			meta->flags = XDP_TXMD_FLAGS_TIMESTAMP | XDP_TXMD_FLAGS_CHECKSUM;
+			meta->request.csum_start = sizeof(*eth) + sizeof(*iph);
+			meta->request.csum_offset = offsetof(struct udphdr, check);
+		}
+		memcpy(data, pkt + offset, len);
+		offset += len;
+	}
 
-	tx_desc->len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
-	tx_desc->options |= XDP_TX_METADATA;
-	xsk_ring_prod__submit(&xsk->tx, 1);
+	xsk_ring_prod__submit(&xsk->tx, num);
 
 	ret = sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
 	if (!ASSERT_GE(ret, 0, "sendto"))
@@ -224,24 +256,27 @@ static int generate_packet_inet(void)
 	return err;
 }
 
-static void complete_tx(struct xsk *xsk)
+static void complete_tx(struct xsk *xsk, u32 num)
 {
 	struct xsk_tx_metadata *meta;
 	__u64 addr;
 	void *data;
 	__u32 idx;
-
-	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
-		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
-
-		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
-
-		data = xsk_umem__get_data(xsk->umem_area, addr);
-		meta = data - sizeof(struct xsk_tx_metadata);
-
-		ASSERT_NEQ(meta->completion.tx_timestamp, 0, "tx_timestamp");
-
-		xsk_ring_cons__release(&xsk->comp, 1);
+	__u32 i;
+
+	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, num, &idx), num,
+		      "xsk_ring_cons__peek")) {
+		for (i = 0; i < num; i++) {
+			addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx + i);
+			printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx + i, addr);
+
+			if (i == 0) {
+				data = xsk_umem__get_data(xsk->umem_area, addr);
+				meta = data - sizeof(*meta);
+				ASSERT_NEQ(meta->completion.tx_timestamp, 0, "tx_timestamp");
+			}
+		}
+		xsk_ring_cons__release(&xsk->comp, num);
 	}
 }
 
@@ -325,7 +360,7 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 	ASSERT_EQ(meta->rx_hash_type, 0, "rx_hash_type");
 
 	/* checksum offload */
-	ASSERT_EQ(udph->check, htons(0x721c), "csum");
+	ASSERT_EQ(udph->check, htons(0x1c8f), "csum");
 
 done:
 	xsk_ring_cons__release(&xsk->rx, 1);
@@ -361,6 +396,7 @@ void test_xdp_metadata(void)
 	int retries = 10;
 	int rx_ifindex;
 	int tx_ifindex;
+	unsigned int i;
 	int sock_fd;
 	int ret;
 
@@ -398,7 +434,7 @@ void test_xdp_metadata(void)
 
 	/* Setup separate AF_XDP for RX interface. */
 
-	ret = open_xsk(rx_ifindex, &rx_xsk);
+	ret = open_xsk(rx_ifindex, &rx_xsk, XDP_COPY);
 	if (!ASSERT_OK(ret, "open_xsk(RX_NAME)"))
 		goto out;
 
@@ -462,27 +498,28 @@ void test_xdp_metadata(void)
 
 	/* Setup separate AF_XDP for TX interface nad send packet to the RX socket. */
 	tx_ifindex = if_nametoindex(TX_NAME);
-	ret = open_xsk(tx_ifindex, &tx_xsk);
+	ret = open_xsk(tx_ifindex, &tx_xsk, XDP_COPY | XDP_USE_SG);
 	if (!ASSERT_OK(ret, "open_xsk(TX_NAME)"))
 		goto out;
 
-	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
-		       "generate AF_XDP_CONSUMER_PORT"))
-		goto out;
+	for (i = 1; i <= MAX_TX_DESCS; i++) {
+		if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT, i), 0,
+			       "generate AF_XDP packet"))
+			goto out;
 
-	switch_ns_to_rx(&tok);
-	if (!ASSERT_OK_PTR(tok, "setns rx"))
-		goto out;
+		switch_ns_to_rx(&tok);
+		if (!ASSERT_OK_PTR(tok, "setns rx"))
+			goto out;
 
-	/* Verify packet sent from AF_XDP has proper metadata. */
-	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk, true), 0,
-		       "verify_xsk_metadata"))
-		goto out;
+		if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk, true), 0,
+			       "verify xsk metadata"))
+			goto out;
 
-	switch_ns_to_tx(&tok);
-	if (!ASSERT_OK_PTR(tok, "setns tx"))
-		goto out;
-	complete_tx(&tx_xsk);
+		switch_ns_to_tx(&tok);
+		if (!ASSERT_OK_PTR(tok, "setns tx"))
+			goto out;
+		complete_tx(&tx_xsk, i);
+	}
 
 	/* Now check metadata of packet, generated with network stack */
 	if (!ASSERT_GE(generate_packet_inet(), 0, "generate UDP packet"))
@@ -518,7 +555,7 @@ void test_xdp_metadata(void)
 		goto out;
 
 	/* Send packet to trigger . */
-	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
+	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT, 1), 0,
 		       "generate freplace packet"))
 		goto out;
 
-- 
2.39.5 (Apple Git-154)

