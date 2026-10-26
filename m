Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032012;
	b=t/ykfV/KmNOMUksIWxcTvn1KorrcEwrCBW9KTsunkfMe8jbmcPB0WluU5xtwKo4jKYZM
	 kQRsrFTOf+zc1KD/llW8VBskfgjuwUQkiYPDKzb32oysRBUG3yi23kQz248/OQXnvcDdW
	 X6yA4QyEtspLyN6VaQdZ5x09lFpmwC8BltbRIjbOfHIATRmz+4QJ6CF7smYe4ySAZT+7r
	 pc3hI2LQEaR4woXS2QZWA8z9A/V9M/WzZkB8fwBsTAGiuiBEkmvylMSgY8a3KOGzusIWg
	 eZ/s4jFSL+2Uwu4iG83LkAHeamHaaEgo/54Ib0vb26nFzGnpoQlsKGukcbpj1TGCClw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032012;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=v5/eiN+AAmFMXx9+44dNMnlZYUhVAO9q0k9ZrZf2VVo=;
	b=qJzPwTvflVtAocL7qCDh/02tIriXGyQvdxS0q6vSV6RVqBsfzI75g4gFFnKRzcGJY5LO
	 y1D3hGvPCn0vLAgxcuX+RGgHwH6e8YTGAzxw0QUg9Srf5UOjYSCkiaIDdTxWwDRm0dACO
	 asEUt9/zKdAkoPZ4hJclrrKE28ftoU7LkwMYdwQsaTdPP0FlFQ66YtgPiEhmnIltxmijL
	 R+zcEW9LenwU6Pcs5zNUM4WFOmwj8utSDzVOfYIhJVygQbOFfYO3UVMbhoZ4onIlMdPwD
	 tQcXEL8FdjO5slCl7S9iLpjyTfDd6ry1xS3WRCPk+qB2QGd6vB+OudduTDsr2zoFSzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=ICxllQTw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lFNljEV5;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0861606A331
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0861606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=ICxllQTw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lFNljEV5
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D598AEC0AB1
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:26:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 12:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793032010;
	 x=1793118410; bh=v5/eiN+AAmFMXx9+44dNMnlZYUhVAO9q0k9ZrZf2VVo=; b=
	ICxllQTwg9Lftgrt8ad9UCBEOjbQ2ENzWJr3GZtkCJomknEpg6pvnoal2HRATGMZ
	uWMpuVVVEmXFg+aT+uPuI0OPb1Z2zMCpUqO3/q++hM0Qq6rw4/fTny/eoLYgCkyK
	Q8bZO2VABbQ1x/m2PpJInExY51b7vksQKkWppX3ny4T9n3JmNgoKDc3jxBaxMK9P
	erLNFLUV3BK786dYBmZznSiOWey4zJrLeF7sJBbnLNVEIV/jPxRjbn+D4X42aNqL
	alqBJoQFPkRdXio56uSB4PPkbqfijTFpK0aBGxh2WQ+06u4RHZrzXgiR5H57xFqi
	X1L1jtF07O6ym9pzEF5/ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793032010; x=
	1793118410; bh=v5/eiN+AAmFMXx9+44dNMnlZYUhVAO9q0k9ZrZf2VVo=; b=l
	FNljEV5LSwPtntZ23N/p1p6snlqZbsdfr7ax10zklHY+JPjJVhJQa9ScYimHk/+M
	7y3Gpq856z/1gaxRu1o7twFsph7bGzuZHIzeHPP26li2r5GN4kgn+0MB4MCuJ9qP
	pbp6OEc8eft4WgqXE1TZMePW3JGUP1zYDnJNi5FZi4WOjgk+ccrgk6V1ONhh0af7
	bQwEoTfwesnGM6PBm9oXBpsFJiCwyw4BzB1UqlomKl4mbkFUhUJxJNgYHWm1OLvK
	W634ivXdm8ugoTGZw5TO1DK4+t7Ter3Ukue3Kjv5IMojtZsoG1LuYE79I3pqQXu4
	wf8N9QKFfx3K19OXPATcQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793032010; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:T5GKyOAVOlsi5WhE7wWlN0GmYgcFcXa7MBjhnCjrQCnZB+O
	DsyN5gfckbYdvxDNS/U+W7LywEDRV8nt2NOri/lj54+eimKoOfCezK+TnF0GJ32X
	iBoSFe5kD0q4VSlGz9mg/yKzmHk1uinWIrPX6evuj09F0tSMrzLP1nMx1c1Do/E7
	pzEiFTVWzd+7PYin2+gLivjO0gwDXHdZju9aeYbi0429UYfqlDdZEM1p6XKE+bFi
	ofFV1g/+KF31s1lrW/Q0+MTY5Tu5a3J7OaPKFwAdI2IunvXckRLrUZ9s26tGuSBG
	Vn3uPI1j+y3X1GJNmW0vshR3VU947tl0ZkN9D5Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/2j+pl3CO4qCHP03Nf/eC0I7uDT2ya4oGbVgICYKoDU=:p4AsKPuSZJBHU8NIV3zR8KMmRkLRfKbGhEsWcEswygY=;
X-ME-Sender: <xms:Sn_fanUJ5UHQqDvDyTAJreJ2cq5ulEQ6dcpkGrkSXVICs9SoPIHuhw>
    <xme:Sn_falmc4tuRZnX5jCjeAicPPMePxFesDcgMSecB_wBe0a465kAE57120jYnPl-C8
    xwYVeTuou_zHqFXq6wVPDSvdmtE6rGIpMEBmjlmSw06aW26ptPxMa1n>
X-ME-Received: <xmr:Sn_fauPwwBthFpdWJioDgB-Ywi_aaW0VuE8GdKURWHUlMN_fCRqLp883SZBY1129kfmypD4rPoffmkiZtkeGQt1THmHJ6G-oWvI>
X-ME-Proxy-Cause: dmFkZTEWkkLBT9rP3p1Wyz0X+m97kuBUnCDDnSBjZXGE+danOKcks90ZCL1x5kFWbQEwZQ
    C/LOTGnj005YKhoS9HeAw+Erp63RPnpthbHBHREmt9p/MFMd+Md/bpiYc1niUxBlZqQhAK
    59b6OQOTULM98lp1jRF041mVOgzZ4rG32mzoyxZ3yObBAyJagwqWtbE75lg1fpvOcZ5lbO
    nDixwRUg+66OBd8I+jfqYKPPDFhGEMx/7qUc6gwNZAe7hEqt97Wi99Wzb46e8o3Kmh6jXZ
    p7pCYaQY1WTE98lsHtyLyqqoeFi5HqK2hSD36I5k4XGS2xKmyAM1EHIH1fqMrzfu8JsVL8
    KPdO0ObxybLmXkZrL5/0EWWEWHCL1lHeRr+0cL7RZXtCMTmbRoESELYWJmjiozGDAfNhWk
    vnXJ3CI9Dj+mBFOVKfv6EoAm9ranFVAbNmw3DkcvxB81oO6eanzJ/i554q6ueNxkHmZr3V
    2i/xsy/F+fqdNa4YmjPqWtZ6flartFZuohz2/vHvhkBB8IPg+rch/3xDGKbACf+ymuz0Dr
    srgsRezdvrFbWLFeYGw9hBsJB06rpBHBf2DgNOwCiAKqV+QxrE+SLxVwKaIZrE3OV8SxYz
    EXWbZpFg14uLC2d+FIMah901gzOyPFKxgN2XwqAmGgvQm6RUgoosrLIbM36g
X-ME-Proxy: <xmx:Sn_falKTSNc5VI6S1ZCn1sM1RHDDed5jyaqS4M0nyFT4AWgCooIk6A>
    <xmx:Sn_fag0oVVPK6ldoBbkSvVRIHGXOaZmAjmtAgutsmZmwKPB8eQxXog>
    <xmx:Sn_fapVBspEE9dM4J03lBOY1-78a3x7x5x8dskP-04EiZPvN5iPNUw>
    <xmx:Sn_faiMOfNJoujGtTqKiuMj-T4UaUV211jyS-yfQ1f3Y8gynoPuvNA>
    <xmx:Sn_faqR_xzkK2my0GQf0wwxtLUzafA43Jm6FfD4LlhI2cgqSYIIjrFEO>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 12:26:49 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Mon, 26 Oct 2026 17:26:39 +0100
Subject: [PATCH 1/2] net: atlantic: AQC113: Fix hw_packet_filter_set for l2
 filter base index > 0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-net-atlantic-aq113-apple-l2-filter-slots-v1-1-d72e99b69583@jannau.net>
References: <20261026-net-atlantic-aq113-apple-l2-filter-slots-v1-0-d72e99b69583@jannau.net>
In-Reply-To: <20261026-net-atlantic-aq113-apple-l2-filter-slots-v1-0-d72e99b69583@jannau.net>
To: Sukhdeep Singh <sukhdeeps@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4506; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=p4AsKPuSZJBHU8NIV3zR8KMmRkLRfKbGhEsWcEswygY=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqz79a5RGxbbn4oK2RLi3/hwiVVn0qan+rf3S5ZP8dAqn
 HqyJle/o5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwEQOVDP8d7rvtXP/6v+6nP9m
 XAy2kkkM4M1Stk5OuRO/jkvvVk8JIyPDMj1JVvM1ep+rr3fx+zgpz1CMmno29lTGXoY1UX9PTK/
 hAwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

hw_atl2_hw_packet_filter_set() wraps hw_atl_b0_hw_packet_filter_set()
which has no concept of `l2_filters_base_index` and enables/disables
filters from `HW_ATL_B0_MAC_MIN` (1) to `HW_ATL_B0_MAC_MAX` (33). After
commit 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter
slot, MAC address") this may result in disabling filters set in
hw_atl2.c including the l2 filter for the MAC address.
The AQC113 adapters integrated in some Apple silicon desktop systems
report 9 as l2_filters_base_index which results in broken network.
The l2 filters set in hw_atl2.c are disabled after
hw_packet_filter_set() calls.
Pass the base location to hw_atl_b0_hw_packet_filter_set() to ensure it
neither touches reserved firmware filters or disables filters configured
in hw_atl2.c.

Fixes: 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c | 14 +++++++++++---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h |  6 ++++--
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c  |  5 ++++-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 6c25ad264b19..5c67edf8030c 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -1038,8 +1038,9 @@ int hw_atl_b0_hw_irq_read(struct aq_hw_s *self, u64 *mask)
 
 #define IS_FILTER_ENABLED(_F_) ((packet_filter & (_F_)) ? 1U : 0U)
 
-int hw_atl_b0_hw_packet_filter_set(struct aq_hw_s *self,
-				   unsigned int packet_filter)
+int hw_atl_b0_hw_packet_filter_set_int(struct aq_hw_s *self,
+				       unsigned int base_location,
+				       unsigned int packet_filter)
 {
 	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
 	unsigned int i = 0U;
@@ -1065,7 +1066,7 @@ int hw_atl_b0_hw_packet_filter_set(struct aq_hw_s *self,
 	hw_atl_rpfl2broadcast_en_set(self, IS_FILTER_ENABLED(IFF_BROADCAST));
 
 
-	for (i = HW_ATL_B0_MAC_MIN; i < HW_ATL_B0_MAC_MAX; ++i)
+	for (i = base_location; i < HW_ATL_B0_MAC_MAX; ++i)
 		hw_atl_rpfl2_uc_flr_en_set(self,
 					   (cfg->is_mc_list_enabled &&
 					    (i <= cfg->mc_list_count)) ?
@@ -1076,6 +1077,13 @@ int hw_atl_b0_hw_packet_filter_set(struct aq_hw_s *self,
 
 #undef IS_FILTER_ENABLED
 
+static int hw_atl_b0_hw_packet_filter_set(struct aq_hw_s *self,
+					  unsigned int packet_filter)
+{
+	return hw_atl_b0_hw_packet_filter_set_int(self, HW_ATL_B0_MAC_MIN,
+						  packet_filter);
+}
+
 static int hw_atl_b0_hw_multicast_list_set(struct aq_hw_s *self,
 					   u8 ar_mac
 					   [AQ_HW_MULTICAST_ADDRESS_MAX]
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h
index 5298846dd9f7..9ea469d3330f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.h
@@ -69,7 +69,9 @@ int hw_atl_b0_hw_irq_enable(struct aq_hw_s *self, u64 mask);
 int hw_atl_b0_hw_irq_disable(struct aq_hw_s *self, u64 mask);
 int hw_atl_b0_hw_irq_read(struct aq_hw_s *self, u64 *mask);
 
-int hw_atl_b0_hw_packet_filter_set(struct aq_hw_s *self,
-				   unsigned int packet_filter);
+int hw_atl_b0_hw_packet_filter_set_int(struct aq_hw_s *self,
+				       unsigned int base_location,
+				       unsigned int packet_filter);
+
 
 #endif /* HW_ATL_B0_H */
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 25dd7150aaaf..82be3bb2e76d 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -759,9 +759,12 @@ static int hw_atl2_hw_ring_tx_init(struct aq_hw_s *self,
 static int hw_atl2_hw_packet_filter_set(struct aq_hw_s *self,
 					unsigned int packet_filter)
 {
+	struct hw_atl2_priv *priv = self->priv;
+	u32 base_location = priv->l2_filters_base_index + 1;
 	hw_atl2_hw_new_rx_filter_promisc(self, IS_FILTER_ENABLED(IFF_PROMISC));
 
-	return hw_atl_b0_hw_packet_filter_set(self, packet_filter);
+	return hw_atl_b0_hw_packet_filter_set_int(self, base_location,
+						  packet_filter);
 }
 
 #undef IS_FILTER_ENABLED

-- 
2.56.0

