Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764120;
	b=1EIQ8jjPki84t7GBj0wgsfOcIRBMrCcpwpZxpEQuDkQbp0bBg87QfINeTr1VFSZ1V9qB
	 bILbwRnEQnYONWNHVDpR4itNXbmOa3+r/FJXwQfLX7qRhDYOLlzPOa0+Bp7M4a/2nOI5u
	 QwdfI9yXNo7wwn+R8J5rxeVS3FXDX73tvzFLRvN/jj49NA4X2+7cv20bT3CqQw2IMQkX8
	 2+5Djt6azPDE+HuoJIX1XKfX0rE76QPjrY2rTO7oDUl14n8irGovaDgNQQ256Chj8xsV3
	 LAQMmpEDIwjGxzVSD6Hbd0CMG+Ir4Nz+McVwfw9PSml1jWJxpiCV2aTfOalHMPHF9bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WFO8J1ucI898mjdej6Y+DNeBq7R/vaD7rjRGa1QY3e4=;
	b=FfQtQEwa7M641l4sRby5INeyJPijvM1CnBDCANhSzfewv03aEExBTZcufX9VnLzzwjeb
	 jYo1mwxj7HztoSbT0SQRiYOJB1AmfI2i8M1F4sXV46rmxjH3uahj6V0641Nw2jagBVF9y
	 MaEVKsXQBFs8STOKzH/XwvLqGrxuPZH6cmLscOU/aEouF5oyPsVW7y+Q1YcSUGKAZd5+O
	 8RN5PRlJEeow/l7Z86pP9/WYgi6TOS3trTjGVwiHI8sz+G7Bdd8h5hWBHzTuI1NO/2oPO
	 PmGG5q8xps3BQ9BUTNsKh1Nojibin+UwMv2MxHB0uCs42Ki7B3vQQ7crEHVk/Cm3Fmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jwdKu59i;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ADE606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 03:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9ADE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jwdKu59i
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ae93a86008so204902a91.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 19:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793764119; x=1794368919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WFO8J1ucI898mjdej6Y+DNeBq7R/vaD7rjRGa1QY3e4=;
        b=jwdKu59isphCIRPMplBWCRGmAZ/SrNhqVe7GlzU0WKao5TK4j3njAIIUdz0YwAapXp
         ZbaOqZ+icCBzmYzYau6twWXQCuXQ2PnAFXATVy+y5NKli8tyPAL6gh2Dz5nuglY7YsyF
         hmkbJtPgcrpNvTHIULODtUEG69ahNEb5Hv1D5ZV5fzdhAqyldTC7ryVy6D8katJdV3Jy
         9G5uh5C6Kds+v3hP6oHG9wD+Ptj7Sfr+FcRkjTuRaspUyJcJNOQowlmkfbFfE1UQFgz8
         yV3xUzRbKunc7DYh3KQktL1QtsyYWWU5F9hnjo4yEx2geSqZtA0ytmIaUhqoMM5LhbpC
         Bd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793764119; x=1794368919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WFO8J1ucI898mjdej6Y+DNeBq7R/vaD7rjRGa1QY3e4=;
        b=ivznrV5rAx1sPXi2+wayuzdfyB7obGvaHYHFrGno0MNnyUXb7O3c1I46Gjaggkj7DI
         RKTuMtO/xhat+aEXL72+kpCFFtCsz+NI9mdzFnUoQ9LM/9YJDoKSdl+DNgA4AWrHhHsH
         IZdVBXDYqiGFbx0dtGPMhycHvTMeo0KVxv2Dkn2fVCr6kHmhNF951QfNuSdkjnAG7Ut7
         iln6nDlAN08CpS03RTtvt4jaQTdi2siJX3s6fqBfl1qpEZW/dhrTidTLSvZAlwOgv6t8
         QaficPv+ko4qjza50WwCRZKygjoFc+Zey0f1WjMxbo0g1hjlHnQoMqHmQA9miNlMIkvp
         NToA==
X-Forwarded-Encrypted: i=1; AKwUvBwUIxv/pxLMP5EMG4VjDjewyieozfr2tfsg2AICQCuxezMtIesg5BYXvM8/nBzzdp+JEhdDHTU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qACa7nNNylSdGZOobuBiNH/PFJaeysVuku4B5GcXmCPKd7BfH
	U0lGk/wHk3nuNsxtCpasSJxq4Ln0wfoTP4V901J35LjpYU1Vg6lj9tOb
X-Gm-Gg: AYBFou0XS8vOBcVsgIv9xHc5HCdsP3uJX6OSRZf35TwXZUHhCi01R3pcGeSdnx+Dv2G
	6ZOSsALpkhJmVAv/Oslm0DR22pOP4p7k0SkE0hQbTNc5OnMRFgUxwmLcF/hU2A43Z2tFjBXeZLE
	mbpc74wQuF2GgfALQPrNObGQ4NjLQki3kFkU2n9LUpJfPUMi0GtXFBnp32Bz6GCbI3ojEPB9+0j
	KnGEtcPWEM8FdKoa0+a/wn8T8fTCWUXw3TJf/t+ZHOrds4i4iE+vrB829BPmGZiz2Tp4xxv8sZK
	VvVilInt4bz7VSuHOOk1/Ej6tpGR5/7f2b8Z5Hm+8cluKKku4Y9snqQR/y0HnGVqajQLp3ZX38f
	7Zz3i/jMSNPosne6/fJ96loahlIVYPfBk7Ayo73gCwbS4TFjjvj9THsRxubM5YgiEspC+Ci2HW+
	x660R8P2wKxfNugysSC/9nE41NVONVapOMNzS9YBXCLoek1urp8t58XlWxibP1eH5VgGnwFRpmW
	+mUYIq21PPlFLh70YVeHtlpyEofh+s9b7OIo6yZs5cYE2pK/q2zMzc0mcHLb7un7WuJOy01KlcP
	15EaUtRN8nuLJFcMFCyyX8k97wb4jE232TapqY4rsEBsc6rFnMy3ANb6h9Yh/M0NkOpl6zr78Vy
	vbjKm2k+wj5YYWw==
X-Received: by 2002:a17:90b:5868:b0:3ac:945c:7f69 with SMTP id 98e67ed59e1d1-3ae8980a25bmr13103989a91.66.1793764118925;
        Tue, 03 Nov 2026 19:48:38 -0800 (PST)
Received: from localhost.localdomain ([240e:46e:1a00:3fd3:e1be:ed6b:40ce:8dab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944a0ff7sm1705472a91.10.2026.11.03.19.48.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 19:48:38 -0800 (PST)
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
Subject: [PATCH net v5 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Wed,  4 Nov 2026 11:48:09 +0800
Message-Id: <20261104034809.24545-3-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261104034809.24545-1-testwrzwrz@gmail.com>
References: <20261104034809.24545-1-testwrzwrz@gmail.com>
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

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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

