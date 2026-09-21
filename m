Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96121468C2F;
	Mon, 21 Sep 2026 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.198.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982140; cv=none; b=L51rNAyFXrGSFsAeING10JEen4Zziuo3rpk1Pg4CgXyubAg7UP0cq2kjYX86nBj3QwVm12f2VpnhinXJI4WHv2g+BJVH8EREQjPRHTXUv7BxvkP5vg9aHUzDJUtOyG5n3F7RLEaLprxUkULvZMkQIbqtNpoNaqga0GZ6SVSWsak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982140; c=relaxed/simple;
	bh=oXFx1YXt+xaIe4JMI/ge4AByv3hpdIZubFru4kJuJAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABjgctl4MueX+yPwA5bMO/Eydaqb4iC99R1dVilQJa+0DkkxCr8+Q3FCsrVl4fTDe7c1QqmEQVSZJKAR57n9LsG1uSl8vHNJvrtnDM0aHbh8V/AJkxftSsAL0IiQTDdN6SfxMvEGIxJK9mJC2Saqfm+8GKv8U4V49TDyQ4sqPXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com; spf=pass smtp.mailfrom=rimpianto.com; dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.b=lqwRSxxl; arc=none smtp.client-ip=46.14.198.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.b="lqwRSxxl"
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: =?UTF-8?q?Gajdos=20Tam=C3=A1s?= <tamas@rimpianto.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gatis Peisenieks <gatis@mikrotik.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gajdos=20Tam=C3=A1s?= <tamas@rimpianto.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] net: atl1: fix soft lockup on out-of-range cmb_tpd_next_to_clean read
Date: Mon, 21 Sep 2026 11:13:34 +0200
Message-ID: <20260921091334.3571525-4-tamas@rimpianto.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921091334.3571525-1-tamas@rimpianto.com>
References: <20260921091334.3571525-1-tamas@rimpianto.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id C865C182-7EAA-4089-A7CF-1E4542A5B920.4
	envelope-from <tamas@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Mon, 21 Sep 2026 11:15:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Cc: To: From; q=dns/txt;
 s=s20260314391; t=1789982136;
 bh=WIdms3fInvlDINNSk8nQtufSFWX3SIWm05qJbeVdHiw=;
 b=lqwRSxxl3A7GZmmQbPx0m8+qXBX0IhjwnmxANd3pf/RzOKJm7OEluHEMXCjHWRnioAnvXWMMz
 iO892bI28yWAbyRwf5MU+l26E/FRCY4Cxqlf0zErwd17IU9YxIr7GE3JERUar9S6KVDtJYHfosL
 fYMP5BagwirOuOTBANOB4yn2gClCyDdfHOakgCsS/qdya+mbzK7qKnxJ3CrguDpvtWzJjcKU9L9
 F+ANCjGCKMLdU/g+TvxKwB5jOGx2VdIUboIebwW5t0vhsLbdLzyGAOrhPzJ0mhN0QEF5JhCKkhA
 /Zq0UcU7ZeZReKtqXX4qz9UyOewKmBOiziwWwkJsZ9Eg==

Same issue as atl1c (see the first commit in this series, "net:
atl1c: fix soft lockup on out-of-range tpd_cons read"): the hardware
can report an out-of-range cmb_tpd_next_to_clean (seen as 0xffff)
while the PCIe link/MAC is resetting. An out-of-range value can
never be reached and the loop below would spin forever. Treat it as
"nothing new to clean" instead.

Fixes: f3cc28c797604f ("Add Attansic L1 ethernet driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Gajdos Tamás <tamas@rimpianto.com>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index 98a4d08927..957d5598dd 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -2066,6 +2066,9 @@ static int atl1_intr_tx(struct atl1_adapter *adapter)
 	sw_tpd_next_to_clean = atomic_read(&tpd_ring->next_to_clean);
 	cmb_tpd_next_to_clean = le16_to_cpu(adapter->cmb.cmb->tpd_cons_idx);
 
+	if (unlikely(cmb_tpd_next_to_clean >= tpd_ring->count))
+		cmb_tpd_next_to_clean = sw_tpd_next_to_clean;
+
 	while (cmb_tpd_next_to_clean != sw_tpd_next_to_clean) {
 		buffer_info = &tpd_ring->buffer_info[sw_tpd_next_to_clean];
 		if (buffer_info->dma) {
-- 
2.53.0

