Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793835991;
	b=evMPuX/oKXvbxXx042XUoMG9mcy3FwJUn+gS0LR6XphqOLNwm9P8ihtuNk1r7bw7s7R5
	 OYBWvSywER6a3dPbI2iEIYgia9oBxsBlDlPfsF0VYQzq/GO5N8lmT1aD670enUp+wRdIo
	 D62eW+PBneUpNu0LFWzR11JhWWZsGeS2Ff5d0vEOXlYm9PZo9HjDs9Ugm+b4H+08pIYbn
	 a4Qh0mXHQEHnEi8y7bK8Ss4mIcaQ40oSy5TXboFJ2QhvqPgzWo50dw4aI+vwG1hfW+mad
	 nKpzdH1mRlJkIraqP3lmSMMqk0OBImGZG5al2XtT6bJOlCnLlqULvUcEa+d3gou+Jaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835991;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WaDki5iflaF1gpBkOLCWiItVv0liaRuAFDb6zs0UdOM=;
	b=SKo1lP9+GlyCumhP+0X9IWckrxscb/8ojRtJHuwsubD2Vtpk+ueL+jR6HHmAOGHQfo1J
	 hYMv5Lg/A9EQnmZgfN9pG3NXU+XSr89QiUNRXxQZSdgUeLROG586y5pR8PpNl12MGowzy
	 M0c5rQD7yCe3po1TVYQ88H6eQpLP5EaSOkzZ5vlVQ0aF7OHBePbAjoXlMkkAfmgl2sm/u
	 IWrv/ZpjqHLRfkr0px8RQgz/J5jYeTIzWJvjeat0ZPKwe/wZzQa/QWRxoqReDmK4G4+31
	 4klDEXeqYmw7YUbkeV0uidyD7l3y5Hs/wQpTLBuUPSFTCujrbVFIg8WF8jtmi9UR5rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kg6hAPn9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C3606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kg6hAPn9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E680F1F0093A;
	Wed,  4 Nov 2026 23:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793835990;
	bh=WaDki5iflaF1gpBkOLCWiItVv0liaRuAFDb6zs0UdOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kg6hAPn9mC1xY1npR67Bsx+q6N2/hs15GsOXM03DmyH/KbIKsVgH1n6xoMUAQi8CH
	 yyQC3MtEWh0/Rwq4EEbinzIaP5kQQ+xjRijyNuFtNtF+gj2rmq5TypHjyW2Sz+JUFP
	 DkJ57Zcmg0red722XqKawQtRT4L1A8u5fLd4bAuYsg54Hg0IxI2luITSnq64y3M16t
	 RNI66awg9JysLdwGyUFKE5whcdtkfzuotPl9beEVv76878sPfjDkJlmAFEw5xmLXwm
	 RVh5ka/ZU/jbecxsA4GwgfRER5UwA1KU7g5DxHyo0A2htVpyecH4sVvI5xcmz5AYWl
	 1MPWPHljraMyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tianchu Chen <flynnnchen@tencent.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] staging: rtl8723bs: fix protected RX frame validation in decrypt path
Date: Wed,  4 Nov 2026 18:46:27 -0500
Message-ID: <20261104234538.932811-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104234538.932811-1-sashal@kernel.org>
References: <2026110447-escalate-hull-6ee2@gregkh>
 <20261104234538.932811-1-sashal@kernel.org>
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
index 9f9d80e42e4db..f8ade0bea1da0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -437,8 +437,21 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
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
@@ -1411,6 +1424,10 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
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
@@ -1418,8 +1435,6 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
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

