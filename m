Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FF72F5337;
	Fri, 11 Sep 2026 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093070; cv=none; b=lNpWT0KMAsPKeuONujjp/O4K2RbanHaYUaMozXSdZo31N47wnzP2bEre67aJ0rQc22kJEfs3I0F376+JuoTz0kYjUZd/WXG3+fOGH6KpEa/bNpXdfcCkdzOXOi+5kE00ZnrtpZ6ELDb8gU4e1IB0KmJAA1oxkF7ItSkpNBT4mDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093070; c=relaxed/simple;
	bh=3+tnQ5BYa5PVuOobhEitKH0AxA5wA83jA3P7EeiXVQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+LYikkr2Sdg8uHidTEERA3ODVhujmQpTpuuGX94eeyAPta9vZBAZTcP1ILgwBJvOY0NKhItlnlBMZ9Sca/lg/nELZLc4A2NbJ7+o/AR+QEU9Zh1O+K1u1ZZWfes62R1/c+hnl2XaLMe4kPJxYyUDKVb/K4hS+oFO5ImauQQCvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=aBG6bXk8; arc=none smtp.client-ip=115.124.28.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="aBG6bXk8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789093057; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Su3jKz0LJj1JiZogLzcFp1cmOtMqUdinCFR1tQMNH+c=;
	b=aBG6bXk848RSKEsIYyksO4C1O3bdPDxBCBl7czC/5Z3RBjwtWpOvkKZ8UCOuXMc97wD2PLhOT8cegmYjmHAblrt2fXnQPoLU4cl2cV626BSFhX/NDKKvVEkAqs45484HXf25mrQmz3bva+0akk9JuIQjVPXQGNcuX+HabVT+oFU=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07440189|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0897427-0.00111239-0.909145;FP=13572140810037101666|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jArxPlD_1789093055;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jArxPlD_1789093055 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Sep 2026 10:17:35 +0800
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
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH v2 2/3] net: wwan: mhi_wwan_mbim: check skb_copy_bits() return value
Date: Fri, 11 Sep 2026 10:17:33 +0800
Message-ID: <20260911021734.1396599-2-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911021734.1396599-1-zhugl3@xiaopeng.com>
References: <20260910033356.1052661-1-zhugl3@xiaopeng.com>
 <20260911021734.1396599-1-zhugl3@xiaopeng.com>
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
Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Verified in a QEMU guest with a fault injector pointing a DPE
outside the received NTB: the copy fails, and the unpatched driver
hands the uninitialized skbn to the network stack (observed as
"unknown protocol" on bytes that were never written).  With this
check the failed datagram is dropped and counted as an rx error.

Changes in v2: factor the free-and-count sequence out into
mhi_mbim_rx_drop(), shared with the unknown-protocol path, as
suggested by Loic Poulain.
---
 drivers/net/wwan/mhi_wwan_mbim.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 5679948546..336f89756f 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -251,6 +251,14 @@ static int mbim_rx_verify_ndp16(struct sk_buff *skb, struct usb_cdc_ncm_ndp16 *n
 	return ret;
 }
 
+static void mhi_mbim_rx_drop(struct mhi_mbim_link *link, struct sk_buff *skb)
+{
+	dev_kfree_skb_any(skb);
+	u64_stats_update_begin(&link->rx_syncp);
+	u64_stats_inc(&link->rx_errors);
+	u64_stats_update_end(&link->rx_syncp);
+}
+
 static void mhi_mbim_rx(struct mhi_mbim_context *mbim, struct sk_buff *skb)
 {
 	int ndpoffset;
@@ -320,7 +328,10 @@ static void mhi_mbim_rx(struct mhi_mbim_context *mbim, struct sk_buff *skb)
 				continue;
 
 			skb_put(skbn, dgram_len);
-			skb_copy_bits(skb, dgram_offset, skbn->data, dgram_len);
+			if (skb_copy_bits(skb, dgram_offset, skbn->data, dgram_len)) {
+				mhi_mbim_rx_drop(link, skbn);
+				continue;
+			}
 
 			switch (skbn->data[0] & 0xf0) {
 			case 0x40:
@@ -332,10 +343,7 @@ static void mhi_mbim_rx(struct mhi_mbim_context *mbim, struct sk_buff *skb)
 			default:
 				net_err_ratelimited("%s: unknown protocol\n",
 						    link->ndev->name);
-				dev_kfree_skb_any(skbn);
-				u64_stats_update_begin(&link->rx_syncp);
-				u64_stats_inc(&link->rx_errors);
-				u64_stats_update_end(&link->rx_syncp);
+				mhi_mbim_rx_drop(link, skbn);
 				continue;
 			}
 
-- 
2.43.0

