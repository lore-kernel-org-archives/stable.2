Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791294;
	b=MSnKSMJTdANSWzekTMoc9weCi0UzkwuyT/y8DduJ/SD+MSktO3dJFzsKCzzRh2udHeN2
	 TGpZeNf/3Jg/BMzW6Oi53TJrQa04lx1/VgHloghNi4O/mvlaIc/fXP51qRCIEcTQ5rl9v
	 pMn8kBZRAJgECEuj3LS5LUJi2LIdl1xz4DtIQOf2n4mKQW1MP5tEeOcBsvcGKF29ctBTB
	 cg2pDKG2BwBhKSnshNOHBatPCxOwx/eGVGIystJltV8TQoGPPN6/gdSJuPRm4EyurRzNP
	 k1g26mTxQalFm2Xc37h7dejjCgCjuZifWtlp0tYRtNyhnmbusMtogMCDCW32BjcVd5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791294;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QFL19kBq3rOfhmyISaz24p24MKE30w5leOlK2XZdXbc=;
	b=ieGvDdyW0D/1Gs4EN6lOOK0XiI+hPBaVCiCjPjXDRwNCFZh9UB9MLUxCSopfK8c7uj+U
	 YgCQlNuWgRnBn8pO89CmJDM5EdV8paLwVqrFo8bzIeV0gD93b+NgOdopCFMA05V0Ywm7x
	 6Ep8lrHxHP2wjEMh6RfB8pSQ5Wnie+vRrWk+oLm23Qg6+0rYs1Jju12Fxqtevx85UqmKp
	 OTaAelerDSJpTXIwNx9CGhSorOhk3FDwv5TKtObINcbnMZ0VxafpaGoCi5e4QwgSqaBwv
	 qQq8et61MZ162u8ZHRGZI0LhFOMQPeceCPuP5DabxJjG685dBkgRIM8EIbwdorNU98Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=3vAqdbiq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="GR/NBYrn";
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE6606A32F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FFE6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=3vAqdbiq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GR/NBYrn
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2FFF27A0530
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:54:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 27 Nov 2026 09:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795791291;
	 x=1795877691; bh=QFL19kBq3rOfhmyISaz24p24MKE30w5leOlK2XZdXbc=; b=
	3vAqdbiqe61Pr55q+39rT91XQw7W5vvUADu1GR04+JO99CkY0LxJ9TbX1CpjSYJZ
	yjIJNfAjaxcR9cm1o8ueC1uiz+gO3xwvinqlJTdtMy6P5LnrY1I7DesAH95SqW3/
	HGBCLA5QMdBvmpYe9DEbPayd4KzNssthjz9wg11cpzMM2Ex+2ucG9dZBzhnsiU9R
	Ujr/fYCooH9gQsunMRIw8yxaBh5MRPaHfYh4o4+saN8Fe7m9naccmnmTSgRfJqsr
	hEZH0ykKXqWhCSs7hrrSzgPTItGO+kp5H83Mt8lIsv8mPJaMRadI4J8qkCvptpJg
	zpD3M9nESpN7fMTMGvLg1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795791291; x=
	1795877691; bh=QFL19kBq3rOfhmyISaz24p24MKE30w5leOlK2XZdXbc=; b=G
	R/NBYrny6KqT3CYd3l3h6E0IJucLUhRxiBPktrZQZo2QsOPKlCWeQBLholdf+kMH
	3tY/uhFDOiurjAuxzMyjE/JguhEAVrVICFj0XJYp4PpsSb8eznKdsn8AIXBpK3Wz
	J7FpYxgtSz8qqG1yOKYnyq4CNrUq+sQvM/ir4ONYCt1J5loKUjcO1zCO4f0B+aXD
	N6Kj6ZeCEyYRtqC4NfJFwu6JFp2pKmcK6+ROaFsTHf5mzuDvd8tYKCxBcu42Se8x
	QK2Q2P3CF8w1mIx/xigAAk6nK7wsA0zlbKTCXotPhaeVwZ2kTMt2fkgb1KwzfpGi
	sIBMVZKrbqBJxW11aBnIQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795791291; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JGFNer7CgKgrE/cEq4HT/JeI5N3Oe1xOUePoOjHA98DP1aw
	p+a0IKdly4Q+AuEcKVmHDr0IOiyGXosukZI6BRxd/Tj5QF7X6QWZGnzOE04axRkc
	Ijt5BjQG45zkGczy0w7d34oq5FyKD09KrQM5vYj8atIsQM4qNHMsZmWQKjdcqaAU
	KAJM1FUgIHUOY5XRQt6OzZZTQN3vaN72T+QlgcMOe7z266epGHd3n4RsrWYf0Y+K
	eRYJz9ZV/DoF3C4S9MLanXz0kv5EYGxGd6X2htbQpEBj90wq/hFFJUoQq/KvZ3c2
	FnMU2fbqK9AH+BEpvElyLFJHWjPjPUQn5RMA9wQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:oAiC8nBEYHPc1Rpx40s9neGXyxNBOLL0ipQEvQkcuX4=:oPXB3UhlC1ZU3k7Gcs/3E+jdAo38rwqGNA1BeDVYTPI=;
X-ME-Sender: <xms:u5kJaxJcpinFiQHpClCJyh8boAYVrKTUWH4iVd4wBmUcv8NQQPmfhA>
    <xme:u5kJazLXJ4gAHIDYodWqZgMujg9K28VLKbjEhm5DFKYwi9_eE0JlmxAF82AOGa95W
    RibXfJokLpi_nnW3H_M_TL2jsPYeLOZlw2FqGdHfWP-wC8L1HGZtfj7>
X-ME-Received: <xmr:u5kJa0j1JRYsHPXEN4xBFF5ePkHwH694T9CKeADMsQ6OplaaD3LDXGsKQJXHOGgx4xhnaVtX4cYnB03fRf3pzUm5AvE_ccuraH-qqA>
X-ME-Proxy-Cause: dmFkZTGeYWoKyAfr5vcv4raxD8gT0Gh9NR5r8ffk50LVzuKIT+66Wr4tdKa6c2Vj+/mLlh
    iIG7tjLNT33rl3n6As7g+fEVTzgKpPZnnTtreZ5G8ElxVXpT0L4np7bxYIpHaIwOggi9Jf
    VWUZg7WkhOgW8sPBVpGj6JM4scCkA4vKFXyVdzqD6KSqGKqLnBC4inGs8WC0Pk32LOyXJI
    Dl7vpuNdDfXFTfd7zCdzF0030IJlA/XdBenLAPYWD/TmeLJxIyf8FEr2GI6sV+X7GrN7Zk
    w0OkZ/Bpq5bx8sUHYUyZ1Pgm05mwnE5PsRBm2Ks2qZKClG7PTVUIPkoYDExLFy07UV0KA9
    kV8AlTdT+N34YOlUXUseWtIxW+4kSB682rm3jHXzgLhkiv5nTut3FJfd8eg/nooHTvBTxw
    /uAU2az8x9QaWaQ5vdPxfiQ18ELpUauQUCsZon+46ORJ1uQ0kwvG14TSr4QV/raccSxK/l
    xW/a6huYUkMd59OZQ2YKzvxfk32C8n7YoD7vyvlWXcp00/TimqlGLb8DCrlqw9JTMmjPtR
    U1y67AMiGbzN8L9ygknrM+Z7zTHQK6AoxDaTziLjHlJ7u6G04T47AEPwkzTO1zofky/S7T
    bnbUos+XHlAyWTh9uaH8qrIw+L5ybpra9DbkmzOKsfYzM30UgiSLrqDEpY4w
X-ME-Proxy: <xmx:u5kJa1MwWtnZxHYXqBguENel71Yd4b6Cfo8BOCvsJMiI9qhA-8Ttqw>
    <xmx:u5kJa3rnz6IoX-0yZnZLu27tdcd2-ySso4-gaTJjRPiUowwF6xkYwA>
    <xmx:u5kJa_6wba9bNyQtdBOavYxtcGkV0vfbPudsEyqR3L6zaRP8uNBMJg>
    <xmx:u5kJa9jTLqR8fh3DzJS0FSHKCpN0Hyfew_U_Y57hxwQP_p1waVacOQ>
    <xmx:u5kJa9FDdYfRUZZrsgkmu2B-d9eWlfBkELEuggRzFq8fWOivtH3IbIaF>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 09:54:51 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Fri, 27 Nov 2026 15:54:40 +0100
Subject: [PATCH v3 2/3] net: atlantic: AQC113: Limit multicast filters to
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
Message-Id: <20261127-net-atlantic-aq113-apple-l2-filter-slots-v3-2-b5efbc124dcc@jannau.net>
References: <20261127-net-atlantic-aq113-apple-l2-filter-slots-v3-0-b5efbc124dcc@jannau.net>
In-Reply-To: <20261127-net-atlantic-aq113-apple-l2-filter-slots-v3-0-b5efbc124dcc@jannau.net>
To: Sukhdeep Singh <sukhdeeps@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6921; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=oPXB3UhlC1ZU3k7Gcs/3E+jdAo38rwqGNA1BeDVYTPI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhmzOmRt/5mbF/i1eJ/2AV61IPM+tYapBh0A6c/7RBy6rC
 tZ2997qKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJF9lYwMj8S/aJrKfMt9s7+o
 /ljbsgubf3DrboyKmnz4lfiaI9e9shgZFvwItus6WvBd9PXasxFck+avdnrFue0p0/2rUyLe8h/
 lYAQA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Since commit 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART,
L2 filter slot, MAC address") hw_atl2_hw_multicast_list_set() uses L2
filter slots based on the firmware-assigned L2 filter base index.
On Apple silicon systems with AQC113 the firmware returns
`l2_filters_base_index = 9` and `l2_filter_count = 29` which is
less than AQ_HW_MULTICAST_ADDRESS_MAX (32).
Add a new `struct aq_hw_ops` function pointer
hw_get_multicast_address_max to query the number of available L2 filter
slots. hw_atl_a0 and hw_atl_b0 will return AQ_HW_MULTICAST_ADDRESS_MAX
and hw_atl2 may return a smaller if l2_filter_count is smaller than 33.
aq_nic_set_multicast_list() uses the number of available L2 filter slots
to configure the packet filter to IFF_PROMISC and or IFF_ALLMULTI based
on the number of unicast and multicast addresses.

Fixes: 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h            |  2 ++
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c           |  9 ++++++---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c |  7 +++++++
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c |  7 +++++++
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c  | 12 +++++++++++-
 5 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index 338c956ad1f7..98b37d025e67 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -374,6 +374,8 @@ struct aq_hw_ops {
 
 	int (*hw_read_module_eeprom)(struct aq_hw_s *self, u8 dev_addr,
 				     u8 reg_start_addr, int len, u8 *data);
+
+	unsigned int (*hw_get_multicast_address_max)(struct aq_hw_s *self);
 };
 
 struct aq_fw_ops {
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 42e0fe9248f2..8ef54be36037 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -976,11 +976,14 @@ int aq_nic_set_multicast_list(struct aq_nic_s *self, struct net_device *ndev)
 	struct aq_nic_cfg_s *cfg = &self->aq_nic_cfg;
 	unsigned int packet_filter = ndev->flags;
 	struct netdev_hw_addr *ha = NULL;
+	unsigned int mc_address_max;
 	unsigned int i = 0U;
 	int err = 0;
 
+	mc_address_max = hw_ops->hw_get_multicast_address_max(self->aq_hw);
+
 	self->mc_list.count = 0;
-	if (netdev_uc_count(ndev) > AQ_HW_MULTICAST_ADDRESS_MAX) {
+	if (netdev_uc_count(ndev) > mc_address_max) {
 		packet_filter |= IFF_PROMISC;
 	} else {
 		netdev_for_each_uc_addr(ha, ndev) {
@@ -990,7 +993,7 @@ int aq_nic_set_multicast_list(struct aq_nic_s *self, struct net_device *ndev)
 
 	cfg->is_mc_list_enabled = !!(packet_filter & IFF_MULTICAST);
 	if (cfg->is_mc_list_enabled) {
-		if (i + netdev_mc_count(ndev) > AQ_HW_MULTICAST_ADDRESS_MAX) {
+		if (i + netdev_mc_count(ndev) > mc_address_max) {
 			packet_filter |= IFF_ALLMULTI;
 		} else {
 			netdev_for_each_mc_addr(ha, ndev) {
@@ -1000,7 +1003,7 @@ int aq_nic_set_multicast_list(struct aq_nic_s *self, struct net_device *ndev)
 		}
 	}
 
-	if (i > 0 && i <= AQ_HW_MULTICAST_ADDRESS_MAX) {
+	if (i > 0 && i <= mc_address_max) {
 		self->mc_list.count = i;
 		err = hw_ops->hw_multicast_list_set(self->aq_hw,
 						    self->mc_list.ar,
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
index 8de2cdd09213..6bc187153a9c 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
@@ -944,6 +944,11 @@ static int hw_atl_a0_hw_fl3l4_set(struct aq_hw_s *self,
 	return aq_hw_err_from_flags(self);
 }
 
+static unsigned int hw_atl_a0_get_multicast_address_max(struct aq_hw_s *self)
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
+	.hw_get_multicast_address_max = hw_atl_a0_get_multicast_address_max,
 };
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 6c25ad264b19..639ec472aa0d 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -1777,6 +1777,11 @@ static int hw_atl_b0_read_module_eeprom(struct aq_hw_s *self, u8 dev_addr,
 	return err;
 }
 
+static unsigned int hw_atl_b0_get_multicast_address_max(struct aq_hw_s *self)
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
+	.hw_get_multicast_address_max = hw_atl_b0_get_multicast_address_max,
 };
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 25dd7150aaaf..0b5a5bc420e9 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -777,7 +777,7 @@ static int hw_atl2_hw_multicast_list_set(struct aq_hw_s *self,
 	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
 	int err = 0;
 
-	if (count > (HW_ATL2_MAC_MAX - HW_ATL2_MAC_MIN)) {
+	if (count > (priv->l2_filter_count - 1)) {
 		err = -EBADRQC;
 		goto err_exit;
 	}
@@ -1602,6 +1602,14 @@ static int hw_atl2_hw_vlan_ctrl(struct aq_hw_s *self, bool enable)
 	return aq_hw_err_from_flags(self);
 }
 
+static unsigned int hw_atl2_get_multicast_address_max(struct aq_hw_s *self)
+{
+	struct hw_atl2_priv *priv = self->priv;
+
+	return min_t(unsigned int, priv->l2_filter_count - 1,
+		     AQ_HW_MULTICAST_ADDRESS_MAX);
+}
+
 const struct aq_hw_ops hw_atl2_ops = {
 	.hw_soft_reset        = hw_atl2_utils_soft_reset,
 	.hw_prepare           = hw_atl2_utils_initfw,
@@ -1661,4 +1669,6 @@ const struct aq_hw_ops hw_atl2_ops = {
 	.hw_get_clk_sel          = hw_atl2_hw_get_clk_sel,
 	.extract_hwts            = NULL,
 	.hw_extts_gpio_enable    = NULL,
+
+	.hw_get_multicast_address_max  = hw_atl2_get_multicast_address_max,
 };

-- 
2.56.1

