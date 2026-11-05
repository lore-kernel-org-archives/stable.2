Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881287;
	b=vZup4IRakbHo2nVh7OCVMdheOEJnge7+jWRHXEMi3EgUiBTK10T2I+dz8u6LTY+MieT3
	 WqvKaUuSiVuCRbmn2/iGWs0WteL8phQkbATKZjAarj7UvHE1j57qnSLGAzCB6+A6dkTIj
	 8sICL1YS65cuCzH3Og0mWnGdfQnTO5jBahBii4XGsTQfMYlq0WXLV5UWZE6ojyi65x6GG
	 F9PXfi7d3c+ysxfWgX8I/KkVxoEdeO5hZClo1ZdTjBFeoBhu8KOOkBrPbyWywzoTGB61P
	 LIaZ4J3LdHyBzVSq0G/eRW1WKh/RuzKwOe2y6rOWxrkwG1o7+42z87vqn8eOMO2BBhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881287;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UxiTS62BtQTEaQsj2KqI71K0t2BbsWQA2HZrTm2lC8k=;
	b=BMIsvdiaVKgAOlcDzLcpkRXbeoHLjTGNctKEEc1Slkg2mG9oFlD6YlO0EjLBVioW9S59
	 jSy5vBrhT39FHE4/pi9QVpfad/0B3y4+TA28kvKtzmFZg+5+o+voHHsiBjalhQkraZtT/
	 Jgh3TyexrW8+8svUQqBhM2G0mx6GVG71NAdRZ+Dg1gud3MGgBrlVU4vkSQ7VTKlonJ6h+
	 3EwGmPFv6Bl0ugGf80bq5VT2LAJGxOxW8ePj8fQaVUAgQZec+c/QE6P8YCx33vj3f9IdX
	 jB25xTdZlOzduVfVEzkSOTQ/jDMfWRzyaRXiBJy1mrUosacni/GHG7Bigdl29SqI24g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFYAVIqM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC62606D82A
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFYAVIqM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457A21F00919;
	Thu,  5 Nov 2026 12:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881286;
	bh=UxiTS62BtQTEaQsj2KqI71K0t2BbsWQA2HZrTm2lC8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MFYAVIqMJ3nq+Zl+IqmxwuDj1LF3clDz5O0TlBLcdVxD98SSdeDiKVUJ3RvmSBi4o
	 IStqTYPFDMc2Oor39Vuz0OC9xBepE9MCQfGyBofdRY1fnGe5gk0mrlXJKmOVQwxANo
	 rxH8YIs1RZpv2bCHE1PYzenw6FbY2EhLUji9PMb3nRnYLKZV+3R+NPL6dOcrc5OUaz
	 jkxp1Agv/hgj7w5qfHpjF2wKcXb4PI5H7LbwjR4iOvPitD7pIDTVhv+Ku2LWLzMP0+
	 qObt5ENwC5SzKR2kVoA5+mVre8OA4o+u19obXhpEciOn5um49Q5nghzIezryNoYkTY
	 JhCD/qNdJB2zA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tianchu Chen <flynnnchen@tencent.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] staging: rtl8723bs: fix protected RX frame validation in decrypt path
Date: Thu,  5 Nov 2026 07:21:25 -0500
Message-ID: <20261105121915.1233786-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110449-unleveled-simmering-935a@gregkh>
References: <2026110449-unleveled-simmering-935a@gregkh>
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
[ sashal: Retained the existing DBG_871X() debug message in the relocated decrypt-failure branch. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 25 ++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 0e6fb03ff85c8..8ed6ded1bef79 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -451,7 +451,21 @@ union recv_frame *decryptor(struct adapter *padapter, union recv_frame *precv_fr
 	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("prxstat->decrypted =%x prxattrib->encrypt = 0x%03x\n", prxattrib->bdecrypted, prxattrib->encrypt));
 
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
@@ -1426,6 +1440,11 @@ static sint validate_80211w_mgmt(struct adapter *adapter, union recv_frame *prec
 				goto validate_80211w_fail;
 			}
 			precv_frame = decryptor(adapter, precv_frame);
+			if (!precv_frame) {
+				kfree(mgmt_DATA);
+				DBG_871X("%s mgmt descrypt fail  !!!!!!!!!\n", __func__);
+				goto validate_80211w_fail;
+			}
 			/* save actual management data frame body */
 			memcpy(mgmt_DATA, ptr+pattrib->hdrlen+pattrib->iv_len, data_len);
 			/* overwrite the iv field */
@@ -1433,10 +1452,6 @@ static sint validate_80211w_mgmt(struct adapter *adapter, union recv_frame *prec
 			/* remove the iv and icv length */
 			pattrib->pkt_len = pattrib->pkt_len - pattrib->iv_len - pattrib->icv_len;
 			kfree(mgmt_DATA);
-			if (!precv_frame) {
-				DBG_871X("%s mgmt descrypt fail  !!!!!!!!!\n", __func__);
-				goto validate_80211w_fail;
-			}
 		} else if (IS_MCAST(GetAddr1Ptr(ptr)) &&
 			(subtype == WIFI_DEAUTH || subtype == WIFI_DISASSOC)) {
 			sint BIP_ret = _SUCCESS;
-- 
2.53.0

