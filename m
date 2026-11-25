Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619830;
	b=LqnLFwqkIMdQgmXm+euig25UZQ2bmTskai0+wT1CA0RDhv7eL63pdAgyYy+cy+yWALVT
	 E1sIM0ThLKsrfa9zLyHaH/Kl2If0QkoPpIW7tB3tcJ53/XHcsTND09+eMXj3cZwK/Trdj
	 UZBJT0d4UiIdbfTS+yq7unb77698W/XdX/VGfohxZB6457Lp4FVquFdH20t6A5zVGwq90
	 3ecG3J/krgFx6P8/laQLvFgvOHqecgqgc5cZf847GiLwrw8pSR39sBePBz5/KINSqGTtC
	 xs8O6b9DsCDPSJn5oGZR5RZNsIe+ZGn5h3aO3FJdTj8e57KJy6jUaLv9Gocu/w2IMcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e32gEWVZg7BcY8epfV0PiShdGT9rPIlquU7Hl495hq8=;
	b=pjEhmwvSiPc3T9IAo8u+dP2Z+3xsGVlrxajmRXacR7F5ddnzrgDymBT+Iv7PywD5W8mT
	 LyYnbPwM36Z/30yAZdzVgbeBVUYV+l4Q7/HdPqHnZbUxF6/kFhbXhefpLX0OVM9KFK4aP
	 bm0YuByTFDtMBsv96g0lnGkT5RvcU0sth53lPAA8R0jVJz/Q9FTdG22xrCUfuVGDPKpna
	 vlDBJpNQWrPkYM2EHe4H8Bw2cv+b0SXWtQV+QZHv2E1NsLtX6sHhe02HDqJh6DTlp0/4R
	 NH6RrVhHwbtv05Z0yJONxdtIDwG4Y7tYV/eHj0uEzTm+SA9/+4AQiKSWCjjYtetV1MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grspAaYW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2743A606A331
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grspAaYW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00EF1F000C0;
	Wed, 25 Nov 2026 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795619829;
	bh=e32gEWVZg7BcY8epfV0PiShdGT9rPIlquU7Hl495hq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=grspAaYWeOyp/hxtKnUSv/YuqNDd6ieiRQsTEDZ8CM6Q5GnUb9Kp1uaMa0xHefdQR
	 VQAUBvy+NOYS5zoqm27S4wnn+a2e7fCVckI761Rd9g46NYH6482GUZhapcqvutbch9
	 kYgf0V8q1cmJiB+TECr4DeVQPaouA/reTWh82bksYIImyxMia1wRi8hESXIE+rPK5H
	 oUUAv+j+s4eaLrb05ExSVbEYR4i/Z4+LhinA+FXOLlbA89ioyATsXGM+aXouwy/eH5
	 0zMDWBIMMtaLivAHNOiDJhbc5BVTXQxfXzyMfTJfgeHaA3jSmiZla/k1kLp/6bgq7W
	 c+oALoKPdI/Qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
	Juan Vazquez <juvazq@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] hv_netvsc: Add (more) validation for untrusted Hyper-V values
Date: Wed, 25 Nov 2026 10:17:06 -0500
Message-ID: <20261125151652.51395-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112517-devotion-snack-1302@gregkh>
References: <2026112517-devotion-snack-1302@gregkh>
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

From: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>

[ Upstream commit 505e3f00c3f3648cb6260deb35e87fae1f64f5d8 ]

For additional robustness in the face of Hyper-V errors or malicious
behavior, validate all values that originate from packets that Hyper-V
has sent to the guest.  Ensure that invalid values cannot cause indexing
off the end of an array, or subvert an existing validation via integer
overflow.  Ensure that outgoing packets do not have any leftover guest
memory that has not been zeroed out.

Reported-by: Juan Vazquez <juvazq@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Link: https://lore.kernel.org/r/20210114202628.119541-1-parri.andrea@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 19a227903e65 ("hv_netvsc: Stop PPI parsing on invalid metadata")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc.c       |   3 +-
 drivers/net/hyperv/netvsc_bpf.c   |   6 ++
 drivers/net/hyperv/netvsc_drv.c   |  18 +++-
 drivers/net/hyperv/rndis_filter.c | 171 +++++++++++++++++++-----------
 4 files changed, 136 insertions(+), 62 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 6972601820e4a..2ca99be13620b 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -932,6 +932,7 @@ static inline int netvsc_send_pkt(
 	int ret;
 	u32 ring_avail = hv_get_avail_to_write_percent(&out_channel->outbound);
 
+	memset(&nvmsg, 0, sizeof(struct nvsp_message));
 	nvmsg.hdr.msg_type = NVSP_MSG1_TYPE_SEND_RNDIS_PKT;
 	if (skb)
 		rpkt->channel_type = 0;		/* 0 is RMC_DATA */
@@ -1354,7 +1355,7 @@ static void netvsc_send_table(struct net_device *ndev,
 			 sizeof(union nvsp_6_message_uber);
 
 	/* Boundary check for all versions */
-	if (offset > msglen - count * sizeof(u32)) {
+	if (msglen < count * sizeof(u32) || offset > msglen - count * sizeof(u32)) {
 		netdev_err(ndev, "Received send-table offset too big:%u\n",
 			   offset);
 		return;
diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index 440486d9c999e..11f0588a88843 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -37,6 +37,12 @@ u32 netvsc_run_xdp(struct net_device *ndev, struct netvsc_channel *nvchan,
 	if (!prog)
 		goto out;
 
+	/* Ensure that the below memcpy() won't overflow the page buffer. */
+	if (len > ndev->mtu + ETH_HLEN) {
+		act = XDP_DROP;
+		goto out;
+	}
+
 	/* allocate page buffer for data */
 	page = alloc_page(GFP_ATOMIC);
 	if (!page) {
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index f9f10800968b5..687357cc3c0f4 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -763,6 +763,16 @@ void netvsc_linkstatus_callback(struct net_device *net,
 	if (indicate->status == RNDIS_STATUS_LINK_SPEED_CHANGE) {
 		u32 speed;
 
+		/* Validate status_buf_offset */
+		if (indicate->status_buflen < sizeof(speed) ||
+		    indicate->status_buf_offset < sizeof(*indicate) ||
+		    resp->msg_len - RNDIS_HEADER_SIZE < indicate->status_buf_offset ||
+		    resp->msg_len - RNDIS_HEADER_SIZE - indicate->status_buf_offset
+				< indicate->status_buflen) {
+			netdev_err(net, "invalid rndis_indicate_status packet\n");
+			return;
+		}
+
 		speed = *(u32 *)((void *)indicate
 				 + indicate->status_buf_offset) / 10000;
 		ndev_ctx->speed = speed;
@@ -868,8 +878,14 @@ static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
 	 */
 	if (csum_info && csum_info->receive.ip_checksum_value_invalid &&
 	    csum_info->receive.ip_checksum_succeeded &&
-	    skb->protocol == htons(ETH_P_IP))
+	    skb->protocol == htons(ETH_P_IP)) {
+		/* Check that there is enough space to hold the IP header. */
+		if (skb_headlen(skb) < sizeof(struct iphdr)) {
+			kfree_skb(skb);
+			return NULL;
+		}
 		netvsc_comp_ipcsum(skb);
+	}
 
 	/* Do L4 checksum offload if enabled and present. */
 	if (csum_info && (net->features & NETIF_F_RXCSUM)) {
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 13f62950eeb9f..b26a354e1462f 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -130,66 +130,84 @@ static void dump_rndis_message(struct net_device *netdev,
 {
 	switch (rndis_msg->ndis_msg_type) {
 	case RNDIS_MSG_PACKET:
-		netdev_dbg(netdev, "RNDIS_MSG_PACKET (len %u, "
-			   "data offset %u data len %u, # oob %u, "
-			   "oob offset %u, oob len %u, pkt offset %u, "
-			   "pkt len %u\n",
-			   rndis_msg->msg_len,
-			   rndis_msg->msg.pkt.data_offset,
-			   rndis_msg->msg.pkt.data_len,
-			   rndis_msg->msg.pkt.num_oob_data_elements,
-			   rndis_msg->msg.pkt.oob_data_offset,
-			   rndis_msg->msg.pkt.oob_data_len,
-			   rndis_msg->msg.pkt.per_pkt_info_offset,
-			   rndis_msg->msg.pkt.per_pkt_info_len);
+		if (rndis_msg->msg_len - RNDIS_HEADER_SIZE >= sizeof(struct rndis_packet)) {
+			const struct rndis_packet *pkt = &rndis_msg->msg.pkt;
+			netdev_dbg(netdev, "RNDIS_MSG_PACKET (len %u, "
+				   "data offset %u data len %u, # oob %u, "
+				   "oob offset %u, oob len %u, pkt offset %u, "
+				   "pkt len %u\n",
+				   rndis_msg->msg_len,
+				   pkt->data_offset,
+				   pkt->data_len,
+				   pkt->num_oob_data_elements,
+				   pkt->oob_data_offset,
+				   pkt->oob_data_len,
+				   pkt->per_pkt_info_offset,
+				   pkt->per_pkt_info_len);
+		}
 		break;
 
 	case RNDIS_MSG_INIT_C:
-		netdev_dbg(netdev, "RNDIS_MSG_INIT_C "
-			"(len %u, id 0x%x, status 0x%x, major %d, minor %d, "
-			"device flags %d, max xfer size 0x%x, max pkts %u, "
-			"pkt aligned %u)\n",
-			rndis_msg->msg_len,
-			rndis_msg->msg.init_complete.req_id,
-			rndis_msg->msg.init_complete.status,
-			rndis_msg->msg.init_complete.major_ver,
-			rndis_msg->msg.init_complete.minor_ver,
-			rndis_msg->msg.init_complete.dev_flags,
-			rndis_msg->msg.init_complete.max_xfer_size,
-			rndis_msg->msg.init_complete.
-			   max_pkt_per_msg,
-			rndis_msg->msg.init_complete.
-			   pkt_alignment_factor);
+		if (rndis_msg->msg_len - RNDIS_HEADER_SIZE >=
+				sizeof(struct rndis_initialize_complete)) {
+			const struct rndis_initialize_complete *init_complete =
+				&rndis_msg->msg.init_complete;
+			netdev_dbg(netdev, "RNDIS_MSG_INIT_C "
+				"(len %u, id 0x%x, status 0x%x, major %d, minor %d, "
+				"device flags %d, max xfer size 0x%x, max pkts %u, "
+				"pkt aligned %u)\n",
+				rndis_msg->msg_len,
+				init_complete->req_id,
+				init_complete->status,
+				init_complete->major_ver,
+				init_complete->minor_ver,
+				init_complete->dev_flags,
+				init_complete->max_xfer_size,
+				init_complete->max_pkt_per_msg,
+				init_complete->pkt_alignment_factor);
+		}
 		break;
 
 	case RNDIS_MSG_QUERY_C:
-		netdev_dbg(netdev, "RNDIS_MSG_QUERY_C "
-			"(len %u, id 0x%x, status 0x%x, buf len %u, "
-			"buf offset %u)\n",
-			rndis_msg->msg_len,
-			rndis_msg->msg.query_complete.req_id,
-			rndis_msg->msg.query_complete.status,
-			rndis_msg->msg.query_complete.
-			   info_buflen,
-			rndis_msg->msg.query_complete.
-			   info_buf_offset);
+		if (rndis_msg->msg_len - RNDIS_HEADER_SIZE >=
+				sizeof(struct rndis_query_complete)) {
+			const struct rndis_query_complete *query_complete =
+				&rndis_msg->msg.query_complete;
+			netdev_dbg(netdev, "RNDIS_MSG_QUERY_C "
+				"(len %u, id 0x%x, status 0x%x, buf len %u, "
+				"buf offset %u)\n",
+				rndis_msg->msg_len,
+				query_complete->req_id,
+				query_complete->status,
+				query_complete->info_buflen,
+				query_complete->info_buf_offset);
+		}
 		break;
 
 	case RNDIS_MSG_SET_C:
-		netdev_dbg(netdev,
-			"RNDIS_MSG_SET_C (len %u, id 0x%x, status 0x%x)\n",
-			rndis_msg->msg_len,
-			rndis_msg->msg.set_complete.req_id,
-			rndis_msg->msg.set_complete.status);
+		if (rndis_msg->msg_len - RNDIS_HEADER_SIZE + sizeof(struct rndis_set_complete)) {
+			const struct rndis_set_complete *set_complete =
+				&rndis_msg->msg.set_complete;
+			netdev_dbg(netdev,
+				"RNDIS_MSG_SET_C (len %u, id 0x%x, status 0x%x)\n",
+				rndis_msg->msg_len,
+				set_complete->req_id,
+				set_complete->status);
+		}
 		break;
 
 	case RNDIS_MSG_INDICATE:
-		netdev_dbg(netdev, "RNDIS_MSG_INDICATE "
-			"(len %u, status 0x%x, buf len %u, buf offset %u)\n",
-			rndis_msg->msg_len,
-			rndis_msg->msg.indicate_status.status,
-			rndis_msg->msg.indicate_status.status_buflen,
-			rndis_msg->msg.indicate_status.status_buf_offset);
+		if (rndis_msg->msg_len - RNDIS_HEADER_SIZE >=
+				sizeof(struct rndis_indicate_status)) {
+			const struct rndis_indicate_status *indicate_status =
+				&rndis_msg->msg.indicate_status;
+			netdev_dbg(netdev, "RNDIS_MSG_INDICATE "
+				"(len %u, status 0x%x, buf len %u, buf offset %u)\n",
+				rndis_msg->msg_len,
+				indicate_status->status,
+				indicate_status->status_buflen,
+				indicate_status->status_buf_offset);
+		}
 		break;
 
 	default:
@@ -245,11 +263,20 @@ static void rndis_set_link_state(struct rndis_device *rdev,
 {
 	u32 link_status;
 	struct rndis_query_complete *query_complete;
+	u32 msg_len = request->response_msg.msg_len;
+
+	/* Ensure the packet is big enough to access its fields */
+	if (msg_len - RNDIS_HEADER_SIZE < sizeof(struct rndis_query_complete))
+		return;
 
 	query_complete = &request->response_msg.msg.query_complete;
 
 	if (query_complete->status == RNDIS_STATUS_SUCCESS &&
-	    query_complete->info_buflen == sizeof(u32)) {
+	    query_complete->info_buflen >= sizeof(u32) &&
+	    query_complete->info_buf_offset >= sizeof(*query_complete) &&
+	    msg_len - RNDIS_HEADER_SIZE >= query_complete->info_buf_offset &&
+	    msg_len - RNDIS_HEADER_SIZE - query_complete->info_buf_offset
+			>= query_complete->info_buflen) {
 		memcpy(&link_status, (void *)((unsigned long)query_complete +
 		       query_complete->info_buf_offset), sizeof(u32));
 		rdev->link_state = link_status != 0;
@@ -342,7 +369,8 @@ static void rndis_filter_receive_response(struct net_device *ndev,
  */
 static inline void *rndis_get_ppi(struct net_device *ndev,
 				  struct rndis_packet *rpkt,
-				  u32 rpkt_len, u32 type, u8 internal)
+				  u32 rpkt_len, u32 type, u8 internal,
+				  u32 ppi_size)
 {
 	struct rndis_per_packet_info *ppi;
 	int len;
@@ -358,7 +386,8 @@ static inline void *rndis_get_ppi(struct net_device *ndev,
 		return NULL;
 	}
 
-	if (rpkt->per_pkt_info_len > rpkt_len - rpkt->per_pkt_info_offset) {
+	if (rpkt->per_pkt_info_len < sizeof(*ppi) ||
+	    rpkt->per_pkt_info_len > rpkt_len - rpkt->per_pkt_info_offset) {
 		netdev_err(ndev, "Invalid per_pkt_info_len: %u\n",
 			   rpkt->per_pkt_info_len);
 		return NULL;
@@ -380,8 +409,15 @@ static inline void *rndis_get_ppi(struct net_device *ndev,
 			continue;
 		}
 
-		if (ppi->type == type && ppi->internal == internal)
+		if (ppi->type == type && ppi->internal == internal) {
+			/* ppi->size should be big enough to hold the returned object. */
+			if (ppi->size - ppi->ppi_offset < ppi_size) {
+				netdev_err(ndev, "Invalid ppi: size %u ppi_offset %u\n",
+					   ppi->size, ppi->ppi_offset);
+				continue;
+			}
 			return (void *)((ulong)ppi + ppi->ppi_offset);
+		}
 		len -= ppi->size;
 		ppi = (struct rndis_per_packet_info *)((ulong)ppi + ppi->size);
 	}
@@ -460,13 +496,16 @@ static int rndis_filter_receive_data(struct net_device *ndev,
 		return NVSP_STAT_FAIL;
 	}
 
-	vlan = rndis_get_ppi(ndev, rndis_pkt, rpkt_len, IEEE_8021Q_INFO, 0);
+	vlan = rndis_get_ppi(ndev, rndis_pkt, rpkt_len, IEEE_8021Q_INFO, 0, sizeof(*vlan));
 
-	csum_info = rndis_get_ppi(ndev, rndis_pkt, rpkt_len, TCPIP_CHKSUM_PKTINFO, 0);
+	csum_info = rndis_get_ppi(ndev, rndis_pkt, rpkt_len, TCPIP_CHKSUM_PKTINFO, 0,
+				  sizeof(*csum_info));
 
-	hash_info = rndis_get_ppi(ndev, rndis_pkt, rpkt_len, NBL_HASH_VALUE, 0);
+	hash_info = rndis_get_ppi(ndev, rndis_pkt, rpkt_len, NBL_HASH_VALUE, 0,
+				  sizeof(*hash_info));
 
-	pktinfo_id = rndis_get_ppi(ndev, rndis_pkt, rpkt_len, RNDIS_PKTINFO_ID, 1);
+	pktinfo_id = rndis_get_ppi(ndev, rndis_pkt, rpkt_len, RNDIS_PKTINFO_ID, 1,
+				   sizeof(*pktinfo_id));
 
 	data = (void *)msg + data_offset;
 
@@ -519,9 +558,6 @@ int rndis_filter_receive(struct net_device *ndev,
 	struct net_device_context *net_device_ctx = netdev_priv(ndev);
 	struct rndis_message *rndis_msg = data;
 
-	if (netif_msg_rx_status(net_device_ctx))
-		dump_rndis_message(ndev, rndis_msg);
-
 	/* Validate incoming rndis_message packet */
 	if (buflen < RNDIS_HEADER_SIZE || rndis_msg->msg_len < RNDIS_HEADER_SIZE ||
 	    buflen < rndis_msg->msg_len) {
@@ -530,6 +566,9 @@ int rndis_filter_receive(struct net_device *ndev,
 		return NVSP_STAT_FAIL;
 	}
 
+	if (netif_msg_rx_status(net_device_ctx))
+		dump_rndis_message(ndev, rndis_msg);
+
 	switch (rndis_msg->ndis_msg_type) {
 	case RNDIS_MSG_PACKET:
 		return rndis_filter_receive_data(ndev, net_dev, nvchan,
@@ -564,6 +603,7 @@ static int rndis_filter_query_device(struct rndis_device *dev,
 	u32 inresult_size = *result_size;
 	struct rndis_query_request *query;
 	struct rndis_query_complete *query_complete;
+	u32 msg_len;
 	int ret = 0;
 
 	if (!result)
@@ -631,8 +671,19 @@ static int rndis_filter_query_device(struct rndis_device *dev,
 
 	/* Copy the response back */
 	query_complete = &request->response_msg.msg.query_complete;
+	msg_len = request->response_msg.msg_len;
+
+	/* Ensure the packet is big enough to access its fields */
+	if (msg_len - RNDIS_HEADER_SIZE < sizeof(struct rndis_query_complete)) {
+		ret = -1;
+		goto cleanup;
+	}
 
-	if (query_complete->info_buflen > inresult_size) {
+	if (query_complete->info_buflen > inresult_size ||
+	    query_complete->info_buf_offset < sizeof(*query_complete) ||
+	    msg_len - RNDIS_HEADER_SIZE < query_complete->info_buf_offset ||
+	    msg_len - RNDIS_HEADER_SIZE - query_complete->info_buf_offset
+			< query_complete->info_buflen) {
 		ret = -1;
 		goto cleanup;
 	}
-- 
2.53.0

