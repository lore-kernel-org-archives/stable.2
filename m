Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC547535E;
	Fri, 16 Oct 2026 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159742; cv=none; b=YHQj/VotkobYWi0imx6yZShSXoMbJdVxKy4f+4x2+1PSb1m537i2rIk3niM3lh3YFVUXELwUY9F5SX4ZM0aQUuWR7xDdlsBZbiOuMtSXHsh0KFR9kRvjMR0Bze/QWw9V8l689W+lWvUbwDNMASjE1JrLvakOrpP8YY4YzbWj5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159742; c=relaxed/simple;
	bh=5+jNcPrFVwyar2TgHXjQU7Gg8W4bNNaqqDwQA/tIK5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5mPdvp+ctiagRgavpMJdwumSObkfPPsfpw94tuV/pOJ4aZS4HZb4RMbVzQ/w8/309CnviOFibxZ+LxLTIcWQGCU23Og0PfBT/Dm0ztyDcRCwyag56HTs1+caKtlIVjB+dBmuTlAyqxiPl1Y9L2xsM1iWuHdy+7Z2wuN3ZMqHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=tzG6IAaL; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="tzG6IAaL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1792159729;
	bh=5+jNcPrFVwyar2TgHXjQU7Gg8W4bNNaqqDwQA/tIK5w=;
	h=From:To:Cc:Subject:Date:From;
	b=tzG6IAaLMLuiNDg/07xA+hyFpMX/8iTpk81K5XjQaR9wadIcObhDUp10NxdduxHX7
	 8AzPDdtWv6cwnlBpAnM415MV/f4Lqhllxs39EMfItPog7WBznCbN+z1e773jt5ggRE
	 ltNLRUQPfif0bnzT8z+plKfBG01NGr15DR6ixJokcdzIKZj7yB6VL1WKbLCOwXgdWL
	 LhyM/u0R5jTUCrfkNMcy0EonfwWAqnaKszsMMRBoDBheagthK4jMJLKgwGSe72wbPB
	 KAvTvIi8CnmwWscmQzvGo3B9Izw8m55sTmOipyhVVqZLdGoBulUXWLCCZCctYpkT67
	 VVDIWd0cLAx6w==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 05A0125D2B;
	Fri, 16 Oct 2026 17:08:49 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Fri, 16 Oct 2026 17:08:47 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.49.29])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4j5mdS38KFzY9W;
	Fri, 16 Oct 2026 16:54:20 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	Tobi Gaertner <tob.gaertner@me.com>,
	Oliver Neukum <oliver@neukum.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] net: usb: cdc_ncm: add ndpoffset to NDP16 nframes bounds check
Date: Fri, 16 Oct 2026 16:53:07 +0300
Message-ID: <20261016135308.600-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/16 12:54:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 127 0.3.127 0884f7b061fa529b810563f359267cd65d2ec05c, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;patch.msgid.link:7.1.1;astralinux.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206758 [Oct 16 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/10/16 06:35:00 #28691046
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/16 12:54:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Tobi Gaertner <tob.gaertner@me.com>

commit 2aa8a4fa8d5b7d0e1ebcec100e1a4d80a1f4b21a upstream.

cdc_ncm_rx_verify_ndp16() validates that the NDP header and its DPE
entries fit within the skb. The first check correctly accounts for
ndpoffset:

  if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp16)) > skb_in->len)

but the second check omits it:

  if ((sizeof(struct usb_cdc_ncm_ndp16) +
       ret * (sizeof(struct usb_cdc_ncm_dpe16))) > skb_in->len)

This validates the DPE array size against the total skb length as if
the NDP were at offset 0, rather than at ndpoffset. When the NDP is
placed near the end of the NTB (large wNdpIndex), the DPE entries can
extend past the skb data buffer even though the check passes.
cdc_ncm_rx_fixup() then reads out-of-bounds memory when iterating
the DPE array.

Add ndpoffset to the nframes bounds check and use struct_size_t() to
express the NDP-plus-DPE-array size more clearly.

Fixes: ff06ab13a4cc ("net: cdc_ncm: splitting rx_fixup for code reuse")
Signed-off-by: Tobi Gaertner <tob.gaertner@me.com>
Link: https://patch.msgid.link/20260314054640.2895026-2-tob.gaertner@me.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ mdmitrichenko: use struct_size() on the already initialized ndp16
  pointer instead of struct_size_t(), which does not exist in 5.10 and
  5.15; struct_size_t(type, ...) is defined as
  struct_size((type *)NULL, ...), so the result is the same. ]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-23448
 drivers/net/usb/cdc_ncm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 57b1e6dc62f0..a3d3f2b6cb1b 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1638,6 +1638,7 @@ int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset)
 	struct usbnet *dev = netdev_priv(skb_in->dev);
 	struct usb_cdc_ncm_ndp16 *ndp16;
 	int ret = -EINVAL;
+	size_t ndp_len;
 
 	if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp16)) > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "invalid NDP offset  <%u>\n",
@@ -1657,8 +1658,8 @@ int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset)
 					sizeof(struct usb_cdc_ncm_dpe16));
 	ret--; /* we process NDP entries except for the last one */
 
-	if ((sizeof(struct usb_cdc_ncm_ndp16) +
-	     ret * (sizeof(struct usb_cdc_ncm_dpe16))) > skb_in->len) {
+	ndp_len = struct_size(ndp16, dpe16, ret);
+	if (ndpoffset + ndp_len > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
 		ret = -EINVAL;
 	}
-- 
2.43.0

