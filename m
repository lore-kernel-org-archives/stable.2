Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847228;
	b=xskt0qUdVL7WrYpOQ6zRfnmK3i1uxQduDcbU0i37yajczgvcTI82rL7T003/oHJptdL1
	 lRClJwiuWErIQZtp2xG5ewuYtLCL0qqLotKs4PCZIOkyG+m7QrPhYuIPN8TaKWhHbSKTV
	 vkpCf9eqwV+2te5Ev+1qnYZDEOrqrIlVohqwrQakSKc16fyX/Bfgz8kt1mnSgeJ12UbuE
	 Xt3vKdy3X+HZaTXTy7qZb+OSQTwEir3Xe/uX2Wa9qPtnYHS9ZSl1QeVOK8JhVz1MCAoZ/
	 CJrx79twM2OALzqWqSpDLKtwbyqYtIpNsyRoFBdYUDo6uWWw4PjlafyCu7jEtSbhhYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847228;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xcT5tiixZNHCrX+aTAltCReAjjb1g0dELGZX+pJHXSQ=;
	b=vsM3miC9z5xWtay8PC73bPfLD/OgxBX4y4E1k8FiroLqmXqOKALYswo1v01uzoSBxKdT
	 /N1AgOVBtjCbHj+Y5Ts9EEBArxAEe5U0W/5PmIJFQFAaBrUX7lEkZdAqypDX5T/LRu/AR
	 tvH6RO+QljJGMT3dM/M7/PrOpkKBdewZzUmEHy2AvZVgm38ThI3lqs0LAo427+w0R8Tcy
	 LrBddHvwjWvrHF02QjvOGuS72X5fKQqDOU4y0wxwxDA8TmmvMXgzqryJiXbPV2BlE7RbV
	 gGcymR5Ae5pbggesSBaTFLdxfcwGdTflCS94f9k46MCXntXOZ1en2l+ZMc3eTs7p3Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iI5ArQ5F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DEF606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iI5ArQ5F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D521F00919;
	Thu,  5 Nov 2026 02:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793847228;
	bh=xcT5tiixZNHCrX+aTAltCReAjjb1g0dELGZX+pJHXSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iI5ArQ5FVFb+6uiySAXuhQ9LQ4f5ACn5oX6AIeEwyhIlrY9zaBhqKmiMez6y2NjyX
	 +myJXy+Y9MAFSSPo6tvOYdELRkCbBjM9hVjdPAHB2+6tgui7H56w+n/z6dD47mRjAs
	 F873nhyjEpTOrJ6uJXEqqxikFV9abmiC1nlasArn08a7GxMdD8U9KsEsp7mH4sA8QZ
	 dk7eQqyKGMOIYUrcn8RDDNeYhfOi2JYl+C6D8aW1dk31xZmAgHRkMps8/fX7XvBn5X
	 5hhraQiCTDh+79RFGdeMOx8Xcb/ZkD4/ZaPUnp/1sDlFgTKsb5tr5HMNl2Dv56nCRt
	 7Cx9OcnpmGwDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tianchu Chen <flynnnchen@tencent.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] staging: rtl8723bs: fix protected RX frame validation in decrypt path
Date: Wed,  4 Nov 2026 21:53:46 -0500
Message-ID: <20261105025323.1174871-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110449-rekindle-unhappily-b3bd@gregkh>
References: <2026110449-rekindle-unhappily-b3bd@gregkh>
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

From: Tianchu Chen <flynnnchen@tencent.com>

[ Upstream commit 495cb31c791bdf3f9efef255a9587b05b0526c9d ]

The RX software decrypt path mishandles crafted protected frames from a
malicious AP in two ways:

1) decryptor() never checks that a protected frame is long enough to
hold the 802.11 header plus the per-cipher trailer.  All of
rtw_wep_decrypt(), rtw_tkip_decrypt() and rtw_aes_decrypt() compute

	length = hdr.len - hdrlen - iv_len;

and act on the result, and recvframe_chkmic() similarly computes

	datalen = hdr.len - hdrlen - iv_len - icv_len - 8;

for TKIP (the 8-byte Michael MIC is not accounted for in icv_len).
A frame shorter than hdrlen + iv_len + icv_len (+ 8 for TKIP) underflows
these unsigned subtractions, turning into a ~4 GiB iteration count in
aes_decipher()/arc4_crypt()/rtw_seccalctkipmic() or a ~4 GiB crc32_le()
length, causing out-of-bounds reads/writes of up to ~4 GiB starting from
the rx skb.  Reject such frames in decryptor() before touching the IV;
this covers all three ciphers and the TKIP MIC check, and also keeps the
unconditional iv[3] access within the frame.

2) validate_80211w_mgmt() keeps using the frame - two memcpys through
the stale rx_data pointer and a pkt_len update - before checking
whether decryptor() returned NULL.  On decrypt failure (e.g. a unicast
protected deauth/disassoc/action frame with a bad MIC, which this path
always software-decrypts) the skb has already been freed, so this is a
use-after-free read/write, and the caller's error path frees the frame
a second time, drifting free_recvframe_cnt.  Bail out immediately when
decryptor() fails, freeing the temporary mgmt_DATA buffer first.

Discovered by Atuin - Automated Vulnerability Discovery Engine.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
Link: https://patch.msgid.link/8ee3bdd1c45034200cb1aa9a7e9b575b9584643a@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: Adjusted context for older syntax while preserving IS_MCAST() and rtw_zmalloc(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 5b0a596eefb77..f6585c034a902 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -392,7 +392,21 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
 	u32  res = _SUCCESS;
 
 	if (prxattrib->encrypt > 0) {
-		u8 *iv = precv_frame->u.hdr.rx_data+prxattrib->hdrlen;
+		u8 *iv;
+		u32 min_len = prxattrib->hdrlen + prxattrib->iv_len + prxattrib->icv_len;
+
+		/* TKIP appends an 8-byte Michael MIC that icv_len doesn't account for */
+		if (prxattrib->encrypt == _TKIP_)
+			min_len += 8;
+
+		/* a protected frame must be long enough to hold the IV and ICV/MIC */
+		if (precv_frame->u.hdr.len < min_len) {
+			rtw_free_recvframe(precv_frame,
+					   &padapter->recvpriv.free_recv_queue);
+			return NULL;
+		}
+
+		iv = precv_frame->u.hdr.rx_data + prxattrib->hdrlen;
 		prxattrib->key_index = (((iv[3])>>6)&0x3);
 
 		if (prxattrib->key_index > WEP_KEYS) {
@@ -1374,6 +1388,10 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
 				goto validate_80211w_fail;
 			}
 			precv_frame = decryptor(adapter, precv_frame);
+			if (!precv_frame) {
+				kfree(mgmt_DATA);
+				goto validate_80211w_fail;
+			}
 			/* save actual management data frame body */
 			memcpy(mgmt_DATA, ptr+pattrib->hdrlen+pattrib->iv_len, data_len);
 			/* overwrite the iv field */
@@ -1381,9 +1399,6 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
 			/* remove the iv and icv length */
 			pattrib->pkt_len = pattrib->pkt_len - pattrib->iv_len - pattrib->icv_len;
 			kfree(mgmt_DATA);
-			if (!precv_frame) {
-				goto validate_80211w_fail;
-			}
 		} else if (IS_MCAST(GetAddr1Ptr(ptr)) &&
 			(subtype == WIFI_DEAUTH || subtype == WIFI_DISASSOC)) {
 			signed int BIP_ret = _SUCCESS;
-- 
2.53.0

