Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082372;
	b=uOQ9sF8ETDLkyku7qGTR1RTA5Tjc5H8Gc0Xn/2eMVKf4YL9aL6zwtTR6JcODNhAiEdTj
	 2UyFV6so2Dt7RXY3T7rgKHBqw8+yyU0i7vegr6xTEbiyqyCTI5vfhxLvKL+CMxDMsQzp6
	 61fRJbmN7dyUHDFvE2dYAqFnUFDMP+pm9pjcG+F36lm8VFNiOMxpb0X3gdNGl6+3WJJ85
	 T3ZBPvajBbyoGCZpFZA07e3Fg28cXYlkEovi7Mro2Na4JGuH+Vi9coXec+5cxBV1LkDG/
	 TdUxlbeaZ8s+6vIEmklflxU9Kr6N57ZW0s3gX65oGybHlagmY4fcwAfnjJdF58pTMiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082372;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UfRoCSvszEcn+i4obulDa86KaHs4sDTjW2MMeP/gVfo=;
	b=XC9KgvoMUctvxGBRRsbnFGk0xpqtcSed5vOU6Z0rzDVrDrh2G7uGsapT4sPezFgIhQNd
	 tMe2l12YOVKuJseNwf+YzvF4DsU26/OIeg6NizS707wS0Ylxse76WCPahnAr3FM0tF00P
	 R67xnAPg/PgmqYD3phxIzVtXQ1Rk49Q3xPDhN0POG5wqmy9SVeSwE8/HWl1tZEzjoyotw
	 JxSxxQMvKkWd/duaGERHEGvO6BusX2TKg2cxPZ82BR8F7HadJ/zTS+aMO8SUJ+qHVG0lN
	 QOC+1yXoqV3KrE+/GulElo7RgxuhcT/yujc3FwZjPUCTlezxrfkwNIXb2ggLHY3TI4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=GXs4QxkN;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18B8606A324;
	Thu, 19 Nov 2026 09:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D18B8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=GXs4QxkN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=GXs4QxkN0YTOLm+nrJ/ZWk0Y9Dg6yjpsTljgCkvZj/bfpWw4Mh412JXhUvyR/FVkXSfn6lvRq73I7
	 PfXzXjubm4tb4q+V8kzkFK2uhDuKY6O+ClDYm7h8SqBtBykKagQ2UK7bxJIe2+taNLbxcKR8yWPIBS
	 v6QdwaM1TXISIN28=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26afec87e297-59830;
	Thu, 19 Nov 2026 17:59:26 +0800 (CST)
X-RM-TRANSID:2ee26afec87e297-59830
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.112.32.189])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86afec87d45e-61d0e;
	Thu, 19 Nov 2026 17:59:26 +0800 (CST)
X-RM-TRANSID:2ee86afec87d45e-61d0e
From: guohongyu <guohongyu@cmss.chinamobile.com>
To: jeff.chen_1@nxp.com,
	francesco@dolcini.it,
	johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	13057616121@163.com
Subject: [PATCH v2] wifi: nxpwifi: validate tid in the RX reorder-table lookup
Date: Thu, 19 Nov 2026 17:52:14 +0800
Message-ID: <20261119095214.186808-1-guohongyu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111085700.109141-1-guohongyu@cmss.chinamobile.com>
References: <20261111085700.109141-1-guohongyu@cmss.chinamobile.com>
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

The RX reorder code uses the tid passed by its callers to index the
MAX_NUM_TID-sized rx_reorder_tbl_ptr[] and rx_reorder_tbl_lock[]
arrays.  Several callers take the tid from a received frame or from a
firmware event and never validate it, so a tid >= MAX_NUM_TID accesses
the arrays out of bounds.

Validate tid in nxpwifi_11n_get_rx_reorder_tbl() itself, so that every
caller is covered.  Also validate it at the entry of
nxpwifi_11n_create_rx_reorder_tbl(): when the lookup returns NULL, the
create path adds a new entry to the tid-indexed rx_reorder_tbl_ptr[]
list, which the lookup check cannot cover.

In nxpwifi_11n_rx_reorder_pkt(), the out-of-window drop check bounds
seq_num by TWOPOW11 rather than by win_size.  The window advance that
follows keeps the computed pkt_index within win_size, but it does not
trigger when win_size == 1, so pkt_index can still run past the
win_size-sized tbl->rx_reorder_ptr[] flex array.  Bound pkt_index by
win_size before the array access.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: guohongyu <guohongyu@cmss.chinamobile.com>
---
Hi Jeff,

Thank you for the review. I have analyzed your comments and
updated the patch accordingly.

Changes in v2:
- Move the tid check into nxpwifi_11n_get_rx_reorder_tbl() so that all
  callers, including the uap RX path, the RXBA sync event and the DELBA
  and ADDBA-RSP event handling, are covered, as you suggested.

 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
index 87cf2ec85991..115380a2219a 100644
--- a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
@@ -182,6 +182,9 @@ nxpwifi_11n_get_rx_reorder_tbl(struct nxpwifi_private *priv, int tid, u8 *ta)
 {
 	struct nxpwifi_rx_reorder_tbl *tbl, *found = NULL;
 
+	if (tid >= MAX_NUM_TID)
+		return NULL;
+
 	guard(rcu)();
 
 	list_for_each_entry_rcu(tbl, &priv->rx_reorder_tbl_ptr[tid], list) {
@@ -266,6 +269,9 @@ nxpwifi_11n_create_rx_reorder_tbl(struct nxpwifi_private *priv, u8 *ta,
 	u16 last_seq = 0;
 	struct nxpwifi_sta_node *node;
 
+	if (tid >= MAX_NUM_TID)
+		return;
+
 	/* Existing TID/TA: flush and move window to SSN. */
 	tbl = nxpwifi_11n_get_rx_reorder_tbl(priv, tid, ta);
 	if (tbl) {
@@ -492,6 +498,11 @@ int nxpwifi_11n_rx_reorder_pkt(struct nxpwifi_private *priv,
 		else
 			pkt_index = (seq_num + MAX_TID_VALUE) - start_win;
 
+		if (pkt_index >= tbl->win_size) {
+			ret = -EINVAL;
+			goto done;
+		}
+
 		if (tbl->rx_reorder_ptr[pkt_index]) {
 			ret = -EINVAL;
 			goto done;
-- 
2.43.0



