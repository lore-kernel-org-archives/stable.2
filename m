Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621674;
	b=hmlLQhQG4Xm2iI3oV7mZvSPDWrY0uJdxY6u6Gy4AixWzHzXIx2a0jW29Mxgc27Wxex+M
	 XIAnZ5yHn4/bc0fYb+LQ/5H5C6f4puYPDaWwjybl3qSh80S6dYwCZ1g6jwqY0Qbcqnvmd
	 RZnw2gjR7ChWN2mmRPveSL+pkzasaWudoTfSgFN4kXHtjR8V+DxIHICttVHAb05pwyIJE
	 +UDqp/6GuyCFmWLDSwXmGyXTVHzDRTNGGb3db/6cBjpU/8rPIRgSnNNgDDt3f00GYUvaq
	 DNkIDQ+t4ULu5YC4ShF+uD0GXn6rkJLPU+PoOhYkhCeYhsDC8cvS8A4XcnekUVDxQIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621674;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=izQ+mn1OPcrueh6P9muuFpCjsbwxazi4SS2qD9fRbm8=;
	b=VcT9q1ikHxVB00KxzQ2VrgYQIlFPjaWgHMFV4qm0IyWZzw+Ci37F43MQTY2zlWnqjcep
	 mvGvXDblMdLasjZo/JDr796ZADTmJYdPWLgoeSRCTOHNE8teSkPm6JClQcQKlCpkbSved
	 FPSLcVwav20mRDfkiGQneo+XqUq++7uWUo2qRgKtMWD0nvSDYvcsXqzOVrV9En9U3m4PX
	 sfcLfboOvHCg/U4gNUp0ZkCSiLUlQ7jB59copovGrZGWCqZEuyxhhVijO676y+Z/hcdOv
	 c+EmpGm5TsUO5TcnvewdvSkqBfFrVxvQCpPeXIdVTWJwYyPFYgF6o5avJzAOpXAPTOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAdVwGob;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E89606A683
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAdVwGob
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18A61F000D0;
	Wed, 25 Nov 2026 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621674;
	bh=izQ+mn1OPcrueh6P9muuFpCjsbwxazi4SS2qD9fRbm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UAdVwGob6zwNhv1QOq86PUyxJld2cjf5uyNZkqRmM2RWSYOgzzUJc1ppk/omNVk5D
	 lVolexAOV2FxmCeHbPlc0esYLk2F94LqomquGTZZL5UGjF6WZUSBn2ItYcR6GTz0qR
	 fZgHuSvkhscoPJXj5JxGM1xpYzXm0PAHoA2HWAtpFBHi3l9RIcnkeJwQ7aWKcaIpxR
	 H69+s5YZhyYTtcCNim0FTWbQuxvy2k0IPX8jRvvLCrdRQC31weXH5K4jf0n1dAAyjN
	 vylu94v230FJeLkCDDWJBYjXLsSA1FXdn8ss8LwP7x96wdYdneT6bNvNxmGKfM84eB
	 zU6UeUj5e4OAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tim Hostetler <thostet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Joshua Washington <joshwash@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] gve: Wrap struct xdp_buff
Date: Wed, 25 Nov 2026 10:47:47 -0500
Message-ID: <20261125154711.373322-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125154711.373322-1-sashal@kernel.org>
References: <2026112542-scrunch-president-9d95@gregkh>
 <20261125154711.373322-1-sashal@kernel.org>
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

From: Tim Hostetler <thostet@google.com>

[ Upstream commit f356a66b87bb19e5370dee469ec32e0094ac9da3 ]

RX timestamping will need to keep track of extra temporary information
per-packet. In preparation for this, introduce gve_xdp_buff to wrap the
xdp_buff. This is similar in function to stmmac_xdp_buff and
ice_xdp_buff.

Signed-off-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Link: https://patch.msgid.link/20251114211146.292068-3-joshwash@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: edc9a730ad3c ("gve: Block invalid ring sizes when device options are 0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve.h        |  5 +++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 16 ++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index f0bc910dd6d44..184b40f953a3d 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -209,6 +209,11 @@ struct gve_rx_buf_state_dqo {
 	s16 next;
 };
 
+/* Wrapper for XDP Rx metadata */
+struct gve_xdp_buff {
+	struct xdp_buff xdp;
+};
+
 /* `head` and `tail` are indices into an array, or -1 if empty. */
 struct gve_index_list {
 	s16 head;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 49ae40c72013e..1eccf63bd283c 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -898,23 +898,23 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 
 	if (xprog) {
-		struct xdp_buff xdp;
+		struct gve_xdp_buff gve_xdp;
 		void *old_data;
 		int xdp_act;
 
-		xdp_init_buff(&xdp, buf_state->page_info.buf_size,
+		xdp_init_buff(&gve_xdp.xdp, buf_state->page_info.buf_size,
 			      &rx->xdp_rxq);
-		xdp_prepare_buff(&xdp,
+		xdp_prepare_buff(&gve_xdp.xdp,
 				 buf_state->page_info.page_address +
 				 buf_state->page_info.page_offset,
 				 buf_state->page_info.pad,
 				 buf_len, false);
-		old_data = xdp.data;
-		xdp_act = bpf_prog_run_xdp(xprog, &xdp);
-		buf_state->page_info.pad += xdp.data - old_data;
-		buf_len = xdp.data_end - xdp.data;
+		old_data = gve_xdp.xdp.data;
+		xdp_act = bpf_prog_run_xdp(xprog, &gve_xdp.xdp);
+		buf_state->page_info.pad += gve_xdp.xdp.data - old_data;
+		buf_len = gve_xdp.xdp.data_end - gve_xdp.xdp.data;
 		if (xdp_act != XDP_PASS) {
-			gve_xdp_done_dqo(priv, rx, &xdp, xprog, xdp_act,
+			gve_xdp_done_dqo(priv, rx, &gve_xdp.xdp, xprog, xdp_act,
 					 buf_state);
 			return 0;
 		}
-- 
2.53.0

