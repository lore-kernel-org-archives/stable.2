Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844126;
	b=WUQR93w2nQ/GRLZDPaj9eTcPGloH4QnHW0s999BGAe3qnL4DsD4KZPRRNCrnW5ROVAh2
	 zgxKEUwxlBCOfWHJip7mo3XX49+j+hIrzOyucadnb7QDykUf6R0X+TnYjj/pBVFc164wx
	 mXYlDig2pKeYRFOhxAmoOh4DhxWn63H5EuceRWZ7JlZsImcpqfD1iOqT+UEjttPnpVpSC
	 +pV8HTg+2jdJueIhKYPnMIyuEeQ6Bv4BMA4i3YPLsUV6PXRFv74FKCld5KLSQW/7+aZ70
	 YgwDFokubHXNoYvzDOhtOaLGfkdmlSstG3h6xNzoKROseyqAwLzndfpSGPD87OD2OuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844126;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PcUNqNsKlsSM13jmAjx1E6TR+eJWfNHPxQuxelewDqU=;
	b=MEihJh54C2fv32wyt8Dz1QEuJo8GWB6WkV8FQpy2iyq7CgjKEa1msV+NvN0rpDz1G1dP
	 GmOd9jW2bK4VjKwFwoQnGB3RsFgRO6I9+W5vpvdTRIXHaGOsg45tXPKFlAS1p+qUoN2KG
	 Goe6EXv3OvcC2K/oDzfsl83+wyTCGFOtlFsoMWKJP+R6DpyLq2KYCJQGFnFZXdOxB8n2o
	 6boa0CfeGCie8MCq36dSBJBjyel+RhJDUkKjubEhGgzVOp4LsdNQbFlsun131r4gZKbdH
	 MAQYomD09XZST2sVVIJYOpkZbpK8QlCjJCfNsuqEkHbm5x7QEKqkKatvsZIOQnDi9tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFv7lOOz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602F6082BD6
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFv7lOOz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDF91F00A1D;
	Thu,  5 Nov 2026 02:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793844125;
	bh=PcUNqNsKlsSM13jmAjx1E6TR+eJWfNHPxQuxelewDqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GFv7lOOzmRgMEaYb+mLO2DcmBO/aYp5UfzktHK9mDir9vhK3Y7SSahiEKRmiV2fF9
	 wnbPeMJRWTTnzz1hT6smrkfm70sOqRMKEzlZw/sZ6jlRe71As77aPXN4I5iWKvV7jI
	 4dC47MaQbeb2+jgV9ANWw+/LGLUfqICwZqo7/zAMealJ47rh9u+g7yqfuB0GOE4K2r
	 nTAAoMRYCN98G1k1lBiPJWjfHTKIAFW273mBzLUiMSySzRF8WH7SQgNP0tCXXLed77
	 161gOE8c+UmMxTX9t5oNVo6BwTNwm1QoxyAoHlzQMUjwbiZ6cwurj4gznXcauom6qI
	 FWGZzjIioVKJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tianchu Chen <flynnnchen@tencent.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] staging: rtl8723bs: fix protected RX frame validation in decrypt path
Date: Wed,  4 Nov 2026 21:02:02 -0500
Message-ID: <20261105020046.1070470-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105020046.1070470-1-sashal@kernel.org>
References: <2026110448-heftiness-shed-a845@gregkh>
 <20261105020046.1070470-1-sashal@kernel.org>
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
index ebec2cff6a2b6..9004c3952a655 100644
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

