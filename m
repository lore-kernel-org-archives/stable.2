Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E135397E89;
	Thu, 10 Sep 2026 03:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011251; cv=none; b=ktVDWb07U1pgMweYTPZhhQX4a15bd5B0nH1US2Pz5HZXl/dJk6pzTx4vVfklrIKjDFhjuzmqfHAlaRb0a932QtFW4ou6L0qiEyx62n55zEuyCS/Lklrt4WbD/pWa5q4A3xrV0gfp0rxNqEL8PogjPsH50/U+/AhOv7E1E4SoHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011251; c=relaxed/simple;
	bh=jp8pzy85oeH+2nf6KqwfuGOGFg08II0gPY4YMzg09SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpEX7ixnksc1Y0hACmjXLjNN17QqZKkmuxLTuyJTUTvYrB8k2rRHaB7xHihwrTX9DRPnODbClEYVxu51OeQHoAzMz//G+bxNEJoQ7IF8JTISNb4OWC4Gtl9PYTwuZJWrPPjH/XH7u1pfIsVll3rq/dbpr0IF9Q/Sfm54G3VNWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=Pm6REv9v; arc=none smtp.client-ip=115.124.28.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="Pm6REv9v"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789011239; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qFrIxb7x+vF+Dq9oyJ0wJ/Ld2doLns/4bCO2Co6mxM8=;
	b=Pm6REv9vru8+B3qQ7IsDgcdwa2elIE8QMgqFe/jZTfMce+qpUx9qEBff/hPjlfR5uDlfjvpeSa8OcVls8yJdw1tjyjTVS9AoczruzhB4NNzqyjas3Jx8Hipfe9WPJWMeVrgdq81YrBNMNdyDCVYvyIQ00otmTRiKNYad3MnAEjs=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08418837|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00427072-0.00064131-0.995088;FP=13567632778539344994|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.jA8N1JY_1789011237;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jA8N1JY_1789011237 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 11:33:57 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] net: wwan: mhi_wwan_mbim: check skb_copy_bits() return value
Date: Thu, 10 Sep 2026 11:33:55 +0800
Message-ID: <20260910033356.1052661-2-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910033356.1052661-1-zhugl3@xiaopeng.com>
References: <20260910033356.1052661-1-zhugl3@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mhi_mbim_rx() ignores the return value of skb_copy_bits() when it
copies each datagram out of the NTB.  The datagram offset and length
come from the DPE, which is only checked to lie within the NTB
itself, so a modem can point a datagram outside the received skb.
The copy then fails and the freshly allocated skbn is passed to
netif_rx() with its uninitialized contents still in place, leaking
kernel heap memory into the network stack.

Free the skb and account an error when the copy fails.

Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---

Verified in a QEMU guest with a fault injector pointing a DPE
outside the received NTB: the copy fails, and the unpatched driver
hands the uninitialized skbn to the network stack (observed as
"unknown protocol" on bytes that were never written).  With this
check the failed datagram is dropped and counted as an rx error.
 drivers/net/wwan/mhi_wwan_mbim.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index ef158edeb..71e700008 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -328,7 +328,13 @@ static void mhi_mbim_rx(struct mhi_mbim_context *mbim, struct sk_buff *skb)
 				continue;
 
 			skb_put(skbn, dgram_len);
-			skb_copy_bits(skb, dgram_offset, skbn->data, dgram_len);
+			if (skb_copy_bits(skb, dgram_offset, skbn->data, dgram_len)) {
+				dev_kfree_skb_any(skbn);
+				u64_stats_update_begin(&link->rx_syncp);
+				u64_stats_inc(&link->rx_errors);
+				u64_stats_update_end(&link->rx_syncp);
+				continue;
+			}
 
 			switch (skbn->data[0] & 0xf0) {
 			case 0x40:
-- 
2.43.0

