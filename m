Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141806;
	b=XMwIabkVb/wjixTQaz/qexW9YO0Hlb1mstFsBgkYklR0/RoC5MeEmyqG5zu/4WOgyAwS
	 4A9lTr3c4C8+Xyk9IUbiLyt74uDWmi6nnmFDNZcSNDUb1xuc1R379iKZpJYPh+Tt34KRO
	 QB/N1qiKvuaFKwansBd+6C7cgfwd23PkCuGyip/xGDB+9sBm0hbZcsY/foL/SWIoleTFW
	 7N31vIVXesxCvypGq/SpKPAWu8DUMz6KwrWZq90yGbz8pqHMOFrk+ZIaFXgul3dXKg4pi
	 88Okq/3yMwpyJV19709TWH+3VhEtCG3Dqg+QbQVDD7QKtqmo1jCsqJH5jx+5iW88CtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141806;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=s9QIa8+7f9x5TzsO+OL6plhe3L6scFovhOu5A4lig90=;
	b=rMZsMe8SZgyLTWrMfJaVw9YUcE6fzY1Rn+S8RVWPKUjd5yYhTG4EcTeKnnPXSszv6isV
	 mS1tuglYaFRwogHXaDkE9qtjYVv96neqHKBJDPeaQYA6hurQ6x3ByrEoSXxYGX9Qn6KFP
	 A/p1Tr7Rcggu5mt+p8hoxXEwKMNG7qVSM3TAf7oe4G+DVr0PnHydabHXexeET5+V00uO1
	 m07PkuB5qvFUOYCXbeUyauNyg7vKUdIjX0RqzAHM3VxXGr7GFLNCCZHWgPO6Lvvo6NoKl
	 KR15S5pMunSX7uFBI8rvzFGMqQxLcBQvyH3hCLHDAVMLAesf5txtP0+WAOWutAJOT0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=ozBbpMkA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UYmpYOKn;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18593606D816
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18593606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=ozBbpMkA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UYmpYOKn
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 818011400098
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 07:43:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 08 Nov 2026 07:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1794141805;
	 x=1794228205; bh=s9QIa8+7f9x5TzsO+OL6plhe3L6scFovhOu5A4lig90=; b=
	ozBbpMkAzeF1FJJMig6rNU7METT9tfyI1KIg5bWqvXvGptpU6+WIpsIrj2a77XBB
	5aK0Ulclj0RO31xoghusM73MCjsODOWrtPNLUIfORi5tPQHdHcnZMyI1dANDr6dI
	IkCe8PAFdoidTf8q5PonO7INPvMmTWiEthAuSYsyGg9rdc80PO5E7RF1npww//TS
	YBbHEK1ig2wHOmSl/5fOVQCnZ6uESNF7BIskbhwDh2QnAsi3A50WMpR4twF7ljRh
	gT80mDLSJonjxh1lHfkIXtjws6SsrZl+cyiHSx9O51rJViv0dMT+Abj17iz36boE
	wNP8spRMPciUWVCUCmGJhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794141805; x=
	1794228205; bh=s9QIa8+7f9x5TzsO+OL6plhe3L6scFovhOu5A4lig90=; b=U
	YmpYOKnCXvmtzIw9JcypbP2UcV3XwZTLUHiROPu5VqZQGz/QU55Zb7iQnRcxoM9N
	+QBywmConYnF5xzlrzUHG+c0QPDcMLzJwPrnpaOT9PHviXYWwC3bD7in8XekG0/o
	YvMEkWK+n7nX+upY3o4HyrPMaOremgbn9vzCzvxgG2eZq68SX8xVusNVXFXMWESg
	fQSGrW8ObMtRfTVYNLBpiUJD6OPDVuefBB+k5lybgTiEYwAZnAHSC0e91wLE72JQ
	3TfDvZvrEDCxJDtKbVYXfDNAC+ygQtpr+0mmlLlFUC5hEmAN1j1NJklvNIxBS0bz
	aMvrvPso9G3GRiDaa3b3A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794141805; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:bNFNFMxTHZZYeIVgCq32xwii407nOR1NRIdj+PdnWe+6vo/
	fnJsoZuyuueFON3Vicozgl8o5m9ItFT9H/uh6BKIBawcoIaYVBE9BbMPqjOgSXQE
	Y+5Iervb9lqGfnn09xYA4jscphyfXJMXrjOQzU/KrdyNQ3sunAsrqmHG/4TGew8v
	NXWTsex2RlyyrUp0vqcYWz6UuiRTQjFCPT2ocDUh8Pngy186RDQTpyEhnV3yqw9z
	avEo6KZ4ztE5YmjK0kGYTqhyVh1FuIPNO2Ut3FFXm62/zuPZQYVmNXIcM4yjSfUq
	01FoIt40j1/ekwsex9no18fU1HNbqqh3btMDeeQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kk1UASHmQuIheuacUzNh0kjfvNA6LVLIglo1aVI6dY4=:zjxwKrwgoQ1CDaw6s5gNTvt7+O4eaXf6uL9MVFCJTAc=;
X-ME-Sender: <xms:bW7wauSKaPt3VJ-NIFFUwmuT9MFmAwmWkpAhuIOXZlxwDnI-ikMuFw>
    <xme:bW7wapxyfpMjpHeluokIPgcveT66hlXAnTKIpf6d65jYSP07MWLBJe7uefMpCRMEQ
    DDMPiH5ckIeVB8kg0aIaFhyCiHFZuKtqIQEqYC04wYOv4eW9KLLX9QP8g>
X-ME-Received: <xmr:bW7wampdX-t62TydngDlUw4GB8HzZOpCQdAXl3Pm1cTEDspjodGCnD7dS2k6yxeU8Jw8ZLHKD7-xh5vPTiQatsYMST_jHclqQAUeIQ>
X-ME-Proxy-Cause: dmFkZTFvpcRF2U5Eqq2oGivzePSyI52xcgAkdznKLWpxb3H76ey6ZgBIPA4VdqYaDnscX5
    rw/WiyxacwJRwb4wAJziiEoDZPJqF7VpDXRzryvYOE97JvMlI6gHJJwukuX5E3aGQfUrhP
    zcspf6iBJbC2JfcDbk0W2z6dMhWrS9LB/KyyX0W304P6wlYIn2Gs96QFYrkqheZA3EJsQH
    HruypYwUGAt7hJLh+hZo8jHU9U40FuNrAvm1F/O5S6gO11QtROXNs/qiYLSb0VNyhdWq3Y
    ldj+KznwwpIPuZF4KvrXrj5qmTsj0TUMEsb+cZ+X7RL6ZwAeAY1//VENmnWPj8YQY02Ihq
    TvsITiC7QGebRNCbF9yrcpR2FRJ40iLArz8VyKbybSgFQ2B9TzGUopOzBptPwvnOtiaRvg
    e2aWEw487LRp0pu81WQ7ts7TMRIQEu/c2zVLigCNK5MDWaJD468DHFaxQYy2LoxwHIkMkd
    S5SDxcSxls7+rIMNV4F0MT/nYa8kWfqYal8Gdbw1W+CMS024oG+/xVYRXKUVmHs2gA/n37
    rJf8AR9v4pI7ZwJ0f45i26iUcz8hR5KoxHDX0rCvbGn/KBpl6JmQC+LK9Q4x2r25utr6qI
    kgfUPEhPRsry/jY8Q6Dia1Dh31pZun3J5sbBky98iVCP8PyOjdOMxWn2O0nQ
X-ME-Proxy: <xmx:bW7was0SsrEYOJGnnbnOxQ_E9bABuoQ6yrueiBPOdYrs7MQImYw-Kg>
    <xmx:bW7wamzxLEpmyQoZoN80Z4Xiqy3yMmF9TpTmuexJPrKlAicU3x1RQw>
    <xmx:bW7waghZEpDNa0LGcfPsQek6AEej1r6_v-EATZNp8gUUIYXkvjhVQw>
    <xmx:bW7wahpce85y6VJoRco2dB_JHxGQXyUGZ-CZ3ea7WpnSyJtIbGWNqQ>
    <xmx:bW7wakORrmniPEli4o-0kwvIVSdrteIFwTSP5o1D6KEn8FPgbxnOP4A3>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 07:43:25 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Sun, 08 Nov 2026 13:42:55 +0100
Subject: [PATCH v2 2/2] net: atlantic: AQC113: Limit multicast filters to
 available slots
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
Message-Id: <20261108-net-atlantic-aq113-apple-l2-filter-slots-v2-2-0b988d031c78@jannau.net>
References: <20261108-net-atlantic-aq113-apple-l2-filter-slots-v2-0-0b988d031c78@jannau.net>
In-Reply-To: <20261108-net-atlantic-aq113-apple-l2-filter-slots-v2-0-0b988d031c78@jannau.net>
To: Sukhdeep Singh <sukhdeeps@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6933; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=zjxwKrwgoQ1CDaw6s5gNTvt7+O4eaXf6uL9MVFCJTAc=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqwPeWm7lQQF7v5P18tLX3ZVcNKjBVfOLbmv+8u4XngX4
 xkPPlmmjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABMxaWVk6FAtSBObGNacOynt
 3ku5mF631mttTLbL8ueKcAU5mCb5M/wz2ekhO+WYfCVfwTfeLsuVPjaXD+Ryb+h++7vv4on7m4X
 5AA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Since commit 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART,
L2 filter slot, MAC address") hw_atl2_hw_multicast_list_set() uses L2
filter slot above the firmware-assigned L2 filter slot for the MAC
address.
On Apple silicon systems with AQC113 the firmware returns
`l2_filters_base_index = 9` and `l2_filter_count = 29` which is
unfortunately less than AQ_HW_MULTICAST_ADDRESS_MAX (32).
Add a new `struct aq_hw_ops` function pointer
hw_get_num_multicast_addresses() so that atl2 variants can report the
lower number of available L2 filter slots. Use this potentially smaller
number in aq_nic_set_multicast_list() to decide when to switch to
promiscuous mode.

Fixes: 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h            |  2 ++
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c           |  7 ++++---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c |  7 +++++++
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c |  7 +++++++
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c  | 11 ++++++++++-
 5 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index 338c956ad1f7..3a4465c11768 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -374,6 +374,8 @@ struct aq_hw_ops {
 
 	int (*hw_read_module_eeprom)(struct aq_hw_s *self, u8 dev_addr,
 				     u8 reg_start_addr, int len, u8 *data);
+
+	int (*hw_get_num_multicast_addresses)(struct aq_hw_s *self);
 };
 
 struct aq_fw_ops {
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 01792f7abf96..a05e12e8661b 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -973,6 +973,7 @@ int aq_nic_set_packet_filter(struct aq_nic_s *self, unsigned int flags)
 int aq_nic_set_multicast_list(struct aq_nic_s *self, struct net_device *ndev)
 {
 	const struct aq_hw_ops *hw_ops = self->aq_hw_ops;
+	int num_multicast_addresses = hw_ops->hw_get_num_multicast_addresses(self->aq_hw);
 	struct aq_nic_cfg_s *cfg = &self->aq_nic_cfg;
 	unsigned int packet_filter = ndev->flags;
 	struct netdev_hw_addr *ha = NULL;
@@ -980,7 +981,7 @@ int aq_nic_set_multicast_list(struct aq_nic_s *self, struct net_device *ndev)
 	int err = 0;
 
 	self->mc_list.count = 0;
-	if (netdev_uc_count(ndev) > AQ_HW_MULTICAST_ADDRESS_MAX) {
+	if (netdev_uc_count(ndev) > num_multicast_addresses) {
 		packet_filter |= IFF_PROMISC;
 	} else {
 		netdev_for_each_uc_addr(ha, ndev) {
@@ -990,7 +991,7 @@ int aq_nic_set_multicast_list(struct aq_nic_s *self, struct net_device *ndev)
 
 	cfg->is_mc_list_enabled = !!(packet_filter & IFF_MULTICAST);
 	if (cfg->is_mc_list_enabled) {
-		if (i + netdev_mc_count(ndev) > AQ_HW_MULTICAST_ADDRESS_MAX) {
+		if (i + netdev_mc_count(ndev) > num_multicast_addresses) {
 			packet_filter |= IFF_ALLMULTI;
 		} else {
 			netdev_for_each_mc_addr(ha, ndev) {
@@ -1000,7 +1001,7 @@ int aq_nic_set_multicast_list(struct aq_nic_s *self, struct net_device *ndev)
 		}
 	}
 
-	if (i > 0 && i <= AQ_HW_MULTICAST_ADDRESS_MAX) {
+	if (i > 0 && i <= num_multicast_addresses) {
 		self->mc_list.count = i;
 		err = hw_ops->hw_multicast_list_set(self->aq_hw,
 						    self->mc_list.ar,
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
index 8de2cdd09213..1d69710c6be7 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
@@ -944,6 +944,11 @@ static int hw_atl_a0_hw_fl3l4_set(struct aq_hw_s *self,
 	return aq_hw_err_from_flags(self);
 }
 
+static int hw_atl_a0_get_num_multicast_addresses(struct aq_hw_s *self)
+{
+	return AQ_HW_MULTICAST_ADDRESS_MAX;
+}
+
 const struct aq_hw_ops hw_atl_ops_a0 = {
 	.hw_soft_reset        = hw_atl_utils_soft_reset,
 	.hw_prepare           = hw_atl_utils_initfw,
@@ -978,4 +983,6 @@ const struct aq_hw_ops hw_atl_ops_a0 = {
 	.hw_get_regs                 = hw_atl_utils_hw_get_regs,
 	.hw_get_hw_stats             = hw_atl_utils_get_hw_stats,
 	.hw_get_fw_version           = hw_atl_utils_get_fw_version,
+
+	.hw_get_num_multicast_addresses = hw_atl_a0_get_num_multicast_addresses,
 };
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 6c25ad264b19..252455cfd106 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -1777,6 +1777,11 @@ static int hw_atl_b0_read_module_eeprom(struct aq_hw_s *self, u8 dev_addr,
 	return err;
 }
 
+static int hw_atl_b0_get_num_multicast_addresses(struct aq_hw_s *self)
+{
+	return AQ_HW_MULTICAST_ADDRESS_MAX;
+}
+
 const struct aq_hw_ops hw_atl_ops_b0 = {
 	.hw_soft_reset        = hw_atl_utils_soft_reset,
 	.hw_prepare           = hw_atl_utils_initfw,
@@ -1836,4 +1841,6 @@ const struct aq_hw_ops hw_atl_ops_b0 = {
 
 	.hw_get_mac_temp         = hw_atl_b0_get_mac_temp,
 	.hw_read_module_eeprom   = hw_atl_b0_read_module_eeprom,
+
+	.hw_get_num_multicast_addresses = hw_atl_b0_get_num_multicast_addresses,
 };
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 8d7a489aa5de..d0dc72bd098f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -810,7 +810,7 @@ static int hw_atl2_hw_multicast_list_set(struct aq_hw_s *self,
 	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
 	int err = 0;
 
-	if (count > (HW_ATL2_MAC_MAX - HW_ATL2_MAC_MIN)) {
+	if (count > (priv->l2_filter_count - 1)) {
 		err = -EBADRQC;
 		goto err_exit;
 	}
@@ -1635,6 +1635,13 @@ static int hw_atl2_hw_vlan_ctrl(struct aq_hw_s *self, bool enable)
 	return aq_hw_err_from_flags(self);
 }
 
+static int hw_atl2_get_num_multicast_addresses(struct aq_hw_s *self)
+{
+	struct hw_atl2_priv *priv = self->priv;
+
+	return min_t(int, priv->l2_filter_count - 1, AQ_HW_MULTICAST_ADDRESS_MAX);
+}
+
 const struct aq_hw_ops hw_atl2_ops = {
 	.hw_soft_reset        = hw_atl2_utils_soft_reset,
 	.hw_prepare           = hw_atl2_utils_initfw,
@@ -1694,4 +1701,6 @@ const struct aq_hw_ops hw_atl2_ops = {
 	.hw_get_clk_sel          = hw_atl2_hw_get_clk_sel,
 	.extract_hwts            = NULL,
 	.hw_extts_gpio_enable    = NULL,
+
+	.hw_get_num_multicast_addresses = hw_atl2_get_num_multicast_addresses,
 };

-- 
2.56.0

