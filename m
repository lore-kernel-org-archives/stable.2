Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA83377AAE;
	Thu, 10 Sep 2026 03:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011246; cv=none; b=f3FhbaX5DuTijpVghIVugWN2CZHJhEW39mgmR3yyAfzK88TxnLb94lT3zpz9By06wusrQx9elJiBaLh+iBiZFN4xALsjhonaXV9cYlSe3gw/tQo82TumzpyS+/MhRMm8c+Oghq8cbgHd2Nbze1yKXsVe4SYkGujShqwi0PQUxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011246; c=relaxed/simple;
	bh=AcBkXJVD/wLD7MTzpdJxhA0NWrAllR4cz36kz05aapQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmBrcHrPxv1GEgbCYW5NJkHx3pbI4Voqr7tLgK1i358NHyZzSOSM2D7w3G0k0T2cCUtIjbUjVNCO9L8+DhfIeLqO0V4g/dvIkOjRCSmpu7961ivbGkPtf4P/pMfQWxSI2QoFTBZ23nfmy/+PxNumDHlTWGz+GfHP7DFl8J+Hv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=BkZCsX/7; arc=none smtp.client-ip=115.124.28.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="BkZCsX/7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789011238; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0wxOVXUirLd7RUYWcuP2VR8q2GpwouTGf9mMSPnDDpE=;
	b=BkZCsX/7gdMPiae9j4udqBUgd/aPTC++xTwtubEMs/oXB7WSyhjvRmS3unN/wgYW18huTUzxBfUmoVr4aJxlfxTGT+4+iu0rgWNBdU/yKl42AJln+RgL0R737HZ6ZEL8R9jCYgbtYHr3f7uoZ87EoNe9xfiiqzJi+KhEZ/0K8cY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07863989|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.108035-0.00216925-0.889796;FP=12564465092511000738|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.jA8N1IH_1789011236;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jA8N1IH_1789011236 cluster:ay29)
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
Subject: [PATCH 1/3] net: wwan: mhi_wwan_mbim: guard against a cyclic NDP chain
Date: Thu, 10 Sep 2026 11:33:54 +0800
Message-ID: <20260910033356.1052661-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NDP traversal in mhi_mbim_rx() only stops when wNextNdpIndex is
zero.  Nothing requires the offsets to advance, so a modem that
points an NDP at itself, or at an earlier NDP, keeps the loop
spinning forever on one CPU.

Break out when the next NDP offset is not larger than the current
one.

Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---

Verified in a QEMU guest with a fault injector feeding the driver's
receive callback an NTB whose single NDP points at itself: the
unpatched driver spins in mhi_mbim_rx() with one CPU pinned at 100%
and the thread never returns.  With this check the loop terminates
within one iteration.
 drivers/net/wwan/mhi_wwan_mbim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index a94998712..ef158edeb 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -254,6 +254,7 @@ static int mbim_rx_verify_ndp16(struct sk_buff *skb, struct usb_cdc_ncm_ndp16 *n
 static void mhi_mbim_rx(struct mhi_mbim_context *mbim, struct sk_buff *skb)
 {
 	int ndpoffset;
+	int last_ndpoffset = 0;
 
 	/* Check NTB header and retrieve first NDP offset */
 	ndpoffset = mbim_rx_verify_nth16(mbim, skb);
@@ -265,6 +266,13 @@ static void mhi_mbim_rx(struct mhi_mbim_context *mbim, struct sk_buff *skb)
 	/* Process each NDP */
 	while (1) {
 		struct usb_cdc_ncm_ndp16 ndp16;
+
+		if (ndpoffset <= last_ndpoffset) {
+			net_err_ratelimited("mbim: non-increasing NDP offset (%u)\n",
+					    ndpoffset);
+			break;
+		}
+		last_ndpoffset = ndpoffset;
 		struct usb_cdc_ncm_dpe16 dpe16;
 		struct mhi_mbim_link *link;
 		int nframes, n, dpeoffset;
-- 
2.43.0

