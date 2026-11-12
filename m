Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474927;
	b=WAgmbFqs5mxPD7z6uHt9dYoINisLCOiZPqcIh7dn+GeOJwemOMNe4DbJoabdJP19sVLf
	 F9nlVjWvXe5o5Troo0PLhqqoa+sY2PoFjhDgTSV1fooutkBNL8eM5mOghwtqm5AFl5Z1r
	 E+oa7WR2U4Q4E7IOt3lfcgjVDkpTxx7wuJKgtXUnNDabrv+gJkgVoSvEXQ/kfe03mGlOq
	 /zd3UttjIL+8raYiVEHbkNVhGBK85L9JiKuEDCIiWMv5J9inOpnBiivCYg42GetHUIu99
	 fHBkbsmyYyv13viNaD21UUCF4XkhVFcLzZqEDvD2v1zBLPHSPz9OT/wcu65v9kygEsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cEN7d+jyurewLFa/LuiPLiAZonMx9OftX2NbfIlKgdw=;
	b=KNfa19ECO0ZThBShiHLAqAiTtpdrPbujPg5Xd35SBDh+57zfBL7fVW/NVUYs3jX1f1bp
	 9Saa5tbgCEA2FWMB7uD41LpURM63/9zaanRrZY2AMbIo949Nqy1f8i9Ljcq6IvvBL42S2
	 5hJmlPCJaTASH5yX1t3WaZVw+MOFPGybHCcSd399izdajX1d0LLh/NpzAbvn9yhAYxtvF
	 FfLVicwdaGQ+5nsb/rU3hO0OXn2HIDhv5QwU6VGxBqYSgl2ENzaxUj2EpHHRbBOdEtSB3
	 In6zhBJTND64OOhHPF6DStV7p6b9iExrbwXRgtz0W2YecZ+7bSpHUjGpTDPDCtpMXTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RdELOKkG;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345E606A330
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8345E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RdELOKkG
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so6096188eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794474926; x=1795079726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEN7d+jyurewLFa/LuiPLiAZonMx9OftX2NbfIlKgdw=;
        b=RdELOKkGhI/YuUC1xnfrm+5EXnd8mmiRPEm4bZGtKq8StrF+btPPCAlsUV3okt0tpU
         JmJ4jZG9ZqPA4105qLMh4EKJsPIAQAtMuGfMFB1PNMjdRKgccORMbGJEdHd38dhZYob1
         CUUY/6UmSXOm1ZApgLezphXnJIf7TaTeBdV2fGjdLahhS1BnM6KmeYygB/icQXnOr804
         52EwsS7iHDyY4FEPgiTh8RnkXWGW6RbuFcEuarHwbbS2+qIVxhV4RzRduneXq/kRCKye
         P3YvP7ReONvCelis5BZGSZ3f+f8kC/z+jk4mqQXDtUOPGhzhtfaa54W67JHaSFXcZd49
         0VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474926; x=1795079726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cEN7d+jyurewLFa/LuiPLiAZonMx9OftX2NbfIlKgdw=;
        b=ny5b7YL+TpzDQgfWB/6ic2agrgkuJHe3GR02Pbi3Mb9JfJ9vsMKXR/eYaGZ8Dsq+le
         Bd09sbt3PC9LzKAJDP8QUn4BQPwfDSxrBOeytk8eNSKsSVYmENf9x6ZHrZuevfAcT1F6
         BroVx/ZQHd5t/qJfg2Ro2QgZHEGErTqseTd3M8MLMJ/hkItbMAGabwY8+8lt3wX/b1yx
         V3HwJg/T/l+/tHScPcD2ZBNdnR3k8/bG38vA5nqFoF/fZOKsvOXvjChBzpaQNoQhLj5M
         hJ/yqJ/4xgL6yoSMxjF0Fer/CkufPpRVwUaQycmsAHBSwM4pp5dzif0uxwUfUfdO+IUa
         3O8g==
X-Forwarded-Encrypted: i=1; AL+hErFg8rLQULVEq/nMMgn/fp84UUnSBjjsb2KG9+SFBk4a8mLcr4pdbI+EFTolKmhpieDSbPtCOyY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/U7YoHEDdqKFnpgGZUAJcvuWeq7Mz5JkuSDFJNqNT72s7Fc6k2
	ql0AYJzqgzvMrEoL5ylpB7m0Emdu7glEehnAIYpki2TxJvzOxnb0veyj
X-Gm-Gg: AYBFou0Kmo3cOoWmfownxW2mXppEqAXJ/iGQwAmLMhQ0Wu1hRV6DOdJ1YsMhyKVxTCG
	xwsTtRzwUHD9h/40eLc129nzjLA2laYErQq5H3i+Lf+JfSWjitzJSzNqC0+PqWO4+MskS/c7c4l
	UQb0fLGTsvmd7zoPSPEGxBKJDBPSTwmgbFuLhZYThuDgzXDmCJW1LVnHSYL1lqWPUefpyHD/SOw
	vdOgAR+fOfURfuy4R+OYn5eIP/UscKOkRcJbsgfqnVfJr9kjvsq8P/2cT+QJQ0vNzCfajmULtKn
	6kG0PP2AhcnZBROHa9HBME3BpVV6rbX0RMgSYgBd16WfslDkYTAq0IhMl5Paji35AH+TekthIlN
	cVFn23DDKka/fnaz/55ChP+QKgVxAJ7QUuaQE1WS/BzPTDnyiXK3YyKhReRA4F2DTGNxK1pqITP
	tkmDqNIzI4bfm2hOIjqIc8OoVqbrqXbNIdldI2uDLR6bnfXiRGhmqJhhoMOU/V2O471ikH/0hlm
	FR5dEnCk7d1SyTRGFv06QeWXU76yZxOtOLFPaoCE65MaUESklccAQbHwOCH3lsZUPz7aJBr/k9s
	fpLn3OZeoQKLDAlUjWUbOyB33Yn5pZgRby6ZMY9nwpak
X-Received: by 2002:a05:7301:514a:b0:36a:7b3c:4e0a with SMTP id 5a478bee46e88-3768675676dmr5379824eec.24.1794474924729;
        Thu, 12 Nov 2026 01:15:24 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:27a4:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e7d24sm40096319eec.22.2026.11.12.01.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:15:24 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	nktgrg@google.com,
	maxyuan@google.com,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>
Subject: [PATCH net v6 1/2] gve: refuse XDP on queue formats without XDP support
Date: Thu, 12 Nov 2026 14:44:50 +0530
Message-ID: <20261112091451.22969-2-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261112091451.22969-1-amaan.cheval@gmail.com>
References: <20261112091451.22969-1-amaan.cheval@gmail.com>
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

Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
verify_xdp_configuration(), which until then refused every format but
GQI-QPL. Nothing replaced it: gve_set_netdev_xdp_features() advertises
no XDP features for DQO-QPL and GQI-RDA and gve_xdp_xmit() rejects
both, but the core only checks that ndo_bpf exists, so a native XDP
program, and an AF_XDP socket on top of it, can still be attached on a
queue format the driver does not support.

The DQO-QPL RX path was never written for that. Its page accounting
assumes the driver keeps a reference of its own across every handoff:
gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
recycles it with gve_reuse_buffer(), so a redirect target that releases
the buffer synchronously, such as an AF_XDP socket in copy mode, can
drop the page's last reference when pagecnt_bias runs out. The page is
then freed while it is still DMA-mapped and registered in the QPL, and
the driver posts it back to the device.

GQI-RDA is no better off: an XDP_TX there goes through
gve_tx_fill_xdp(), which copies the frame into tx->tx_fifo, but a
raw-addressing TX ring never allocates that FIFO, so the first XDP_TX
writes through a NULL tx_fifo.base.

Refuse XDP setup in gve_verify_xdp_configuration() whenever the driver
advertises no XDP features for the current queue format, which today
means DQO-QPL and GQI-RDA. A zero-copy XSK pool bind is already refused
by the core for the same reason, and a copy-mode bind never reaches the
driver and is harmless without a program.

Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ RDA")
Cc: stable@vger.kernel.org
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
---
v6:
 - Say the check also covers GQI-RDA, where XDP_TX writes into a TX
   FIFO that raw addressing never allocates (Sashiko). Message only, so
   I carried Joshua's Reviewed-by.
v5: https://lore.kernel.org/netdev/20261109100437.331423-2-amaan.cheval@gmail.com/
 - Check dev->xdp_features instead of queue_format, and reword the
   subject and message around that (Joshua).
v4: https://lore.kernel.org/netdev/20261106114551.212675-2-amaan.cheval@gmail.com/

 drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 2437cd8ba633..fe560f5c5408 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
 	struct gve_priv *priv = netdev_priv(dev);
 	u16 max_xdp_mtu;
 
+	if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "XDP is not supported on this queue format.");
+		return -EOPNOTSUPP;
+	}
+
 	if (dev->features & NETIF_F_GRO_HW) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "XDP is not supported when HW-GRO is on.");
-- 
2.47.3

