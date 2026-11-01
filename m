Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793576185;
	b=Fyx0KyNSoq5Div8TU+RpfxjyARtiL3empmR263LBSxQhRZnccUxb4sycZMxKZj/TIv8K
	 smDdFtqe4Mc/I2QfdzDgUasiSWik3AGK5WnAEFiwg0ZnX98X0VxYyB0fsgzAZu6og603m
	 4a3Lr/6KiTozqahcAxPNqj8XT30o4rCdWDg9JCK3kxA7z6OmIX3bTL1wB1p42KHzHUFK4
	 c8swg3waPY11QIRz+qYwaRCZhIbW01/pfgZGPEdWGckljnIZqxcUjxtMpB/e7I4eyd/U3
	 rxLxbiVV+KoAh+4fghe7tw87+U5L292TUyJ5qL9EGh+QlhfuKZ586kI7sK5Dr45OfIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793576185;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=ey9NG0HNZ68k2ywfFfBKJVqpuijTLNdK0lfA6urOnrg=;
	b=nIeN4sqBsvSTuvmf5A+uWDl0KGcE2SzAJR4furrO1QC7SJI6R1TMSXy4Ich5tK8Trnd6
	 +9oT3TJMCvWgA4xPxRvRNzSxxeRdeUf2NbxsHCyRECNfH5lklJlz3ctjSSfXb7KhWoxvz
	 a2M0Vk3RccJbHNx03Nt7imsEtLXmfWv20VdQdLWOJ4yi1NCBGxg6aY98MHEju63N2NI6Z
	 yaF/6ENImaOTtXEDQqPrGc9R4n6tG2KRIkPjX5PTT9UCKoHPieyehuSzKgZsranOfs52g
	 PpTXI1OQc8oID2adWUlXGfF0qNHjA9O6hR0Oh9Bm6gNN/gOjS+z4v6hE0ITsMVYrinQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=kTLluWtm;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFBA606A324;
	Sun,  1 Nov 2026 23:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EFBA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=kTLluWtm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=ey9NG0HNZ68k2ywfFfBKJVqpuijTLNdK0lfA6urOnrg=; b=kTLluWtmwRQg1FXQPkAfOrV/r9
	BKK5W57cqXkCe9gqQDtm0Q8YyZSvruzYTmjJnjVPPWvVdiWTQmUu/TbSAumOfAJRTsr56rSrtYANB
	U+09gYo7m9050sNezqF4YfwQ/yDlJ14dnrBuONBVPHRu3nk1giY+TrezpSTx0UBvtIaRrsdHMDD3A
	2/pIiO/UvyPPk1dD10EkjHzwPTZISI5s3qbYTFm5CokUbPLvrR8GuIftcgguP1SKyw6So3qayuOB2
	9Y98U5VbPgC8OujHcxP9WCn7LqXDBb2aghliLynQbcI/jReg/Um9fIDujlQsehmd9hXGy1FLeEucx
	VMKNd/WQ==;
Received: from [151.115.150.205] (port=55758 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xNf67-00000005EFT-3i5K;
	Mon, 02 Nov 2026 00:36:23 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net] net: qualcomm: rmnet: fix TX aggregation teardown race
Date: Sun,  1 Nov 2026 23:34:28 +0000
Message-ID: <20261101233427.2050688-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
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
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

There is a race in rmnet_unregister_real_device() because it cancels TX
aggregation before unregistering the rx handler. A transmit that already
obtained the port through rmnet_get_port_rcu() can wait on port->agg_lock,
then create a new aggregate and rearm the timer after
rmnet_map_tx_aggregate_exit() has drained it. The timer can later queue
work on the freed port.

Unregister the rx handler first so that no reader can rearm aggregation
after rmnet_map_tx_aggregate_exit() drains it.

Fixes: 64b5d1f8f2d1 ("net: qualcomm: rmnet: add tx packets aggregation")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 61b04c6c0390..2ff4b9519139 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -40,10 +40,10 @@ static int rmnet_unregister_real_device(struct net_device *real_dev)
 	if (port->nr_rmnet_devs)
 		return -EINVAL;
 
-	rmnet_map_tx_aggregate_exit(port);
-
 	netdev_rx_handler_unregister(real_dev);
 
+	rmnet_map_tx_aggregate_exit(port);
+
 	kfree(port);
 
 	netdev_dbg(real_dev, "Removed from rmnet\n");
-- 
2.47.3

