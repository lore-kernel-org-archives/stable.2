Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839099;
	b=pfKF38u6c9MMYH1ROuBTLZjAh6sj/NzBEiFZD+XawuaWKFg4l5a0Rtd0eovkbmjC+Ttg
	 4OOdNvzhvegkZWNPGQcBdNaZ1QECmGT70n9Bs1M7LveLHr8ehZsvsLSx+9RvIbLTi42Zf
	 VtYlm6dk74X0pODYHb4tnQQs5XRaeWZKs7mC2uXrV3jgo1fmVIjMnBTEKd5dukMHhHsHe
	 6qz1oWr1FE0lHTPrk1hB6gT6DD3L+l6Sjrr8u3vOhrB3N3fOwRLizCqWrxZhk0IcZ38gs
	 yNBqeo5EJZiHwrSh2aCo1el/AcT8kWgnTX6RVWgsZUcAS0SF9+agISnF0c3phZpcYHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839099;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XLptSJXHkjqzU2v/pn4Tu6i5rN0k9JowvVcm2FMoiEs=;
	b=SDk1JkBOQAAcgBLcCRAIh1mBDChaOwnLuP/TDKiUTdBBWDcyEWOeiNf0ic3HgomiN0E/
	 BqqGRQ/yYRVh93vlMVKViavtBiWow54yl0SD/VwXcXA3nLZeO0YwLDpimLhRg7V/xgNlM
	 6km5NGrOSCSWo+2jopspPcS8UBthI+dnD0r2QKSWgNC4p0/fJY33ZyJ63edItAQyREu4i
	 LPxNGiiJKdtdoo5c32USFxAodKFgxTuFbGHm4b1gmN38ITDXkJYoHtIe2vrKu50mmbH8G
	 PX8W39xASgZeqyn0LTNS7pLjWI0sNQ56N3xuWsY/SZV/2909rdoU1t6wEOlnl7cKiLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oT3178eY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBB3606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oT3178eY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42481F00919;
	Thu,  5 Nov 2026 00:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793839099;
	bh=XLptSJXHkjqzU2v/pn4Tu6i5rN0k9JowvVcm2FMoiEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oT3178eYtDrg4jwhUrOrWtstDSAnxVrvutwHOrI328uKl11/kpGD9Uq4dxJyy++5R
	 8uh4LPfiLXU05LvXpCRgh0KNvr2eex3EY1J/Flc5vsWWYQLIvMpo5jgkiAVIfS6hPZ
	 19iIjExv4n6Q7t+Sv7/ANGqPXHJ1gvJTxBB2bTKTIQCRg75cQMYz0IYY7vaHXQzNZN
	 KYT1LGjY6dY/omcx+Tjl0KKdQOUipW5Ffa2PKPLCRBvQDKHGVT0c8afNK2RmM0xpsj
	 T27qcLSCSf+XBJfDImuqEJ8q3ZWIanGeGPuLaRHIPyH7wQVD9mZLs8NWQoP4+QdVHA
	 bTbav8QYW+vWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tianchu Chen <flynnnchen@tencent.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] staging: rtl8723bs: fix protected RX frame validation in decrypt path
Date: Wed,  4 Nov 2026 19:38:16 -0500
Message-ID: <20261105003739.1022584-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105003739.1022584-1-sashal@kernel.org>
References: <2026110448-mowing-much-b943@gregkh>
 <20261105003739.1022584-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 0697eeb9b3364..e2f4417dab5ba 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -387,8 +387,21 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
 	u32  res = _SUCCESS;
 
 	if (prxattrib->encrypt > 0) {
-		u8 *iv = precv_frame->u.hdr.rx_data + prxattrib->hdrlen;
+		u8 *iv;
+		u32 min_len = prxattrib->hdrlen + prxattrib->iv_len + prxattrib->icv_len;
 
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
 		prxattrib->key_index = (((iv[3]) >> 6) & 0x3);
 
 		if (prxattrib->key_index > WEP_KEYS) {
@@ -1372,6 +1385,10 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
 			if (!mgmt_DATA)
 				goto validate_80211w_fail;
 			precv_frame = decryptor(adapter, precv_frame);
+			if (!precv_frame) {
+				kfree(mgmt_DATA);
+				goto validate_80211w_fail;
+			}
 			/* save actual management data frame body */
 			memcpy(mgmt_DATA, ptr + pattrib->hdrlen + pattrib->iv_len, data_len);
 			/* overwrite the iv field */
@@ -1379,8 +1396,6 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
 			/* remove the iv and icv length */
 			pattrib->pkt_len = pattrib->pkt_len - pattrib->iv_len - pattrib->icv_len;
 			kfree(mgmt_DATA);
-			if (!precv_frame)
-				goto validate_80211w_fail;
 		} else if (is_multicast_ether_addr(GetAddr1Ptr(ptr)) &&
 			(subtype == WIFI_DEAUTH || subtype == WIFI_DISASSOC)) {
 			signed int BIP_ret = _SUCCESS;
-- 
2.53.0

