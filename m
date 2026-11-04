Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802054;
	b=Sb398nlAUG22lni7HrKPuOMP/fXzD14fRAfFegm18xnUBawBjBsCX4QzK2PLdUCPIXY2
	 tzdxdL7Nq30XxL4LUnI9Rbfy73CHsKaQ/MwUmjb5WjWlOxK0VDj9N54XRtkOt7dW7odRb
	 M6SZlfTZ7BrRv7DibuDEo4YRKlIe7kYnNXfWJeADBzkXfn04Ba5Q7Z/1SnVxKEpe80yKi
	 iarKET3p+B1emDW12AGcTE59TN99RrOs8ecHVgml0iazjVg/owtDmjqe/QAfzdczC3P0R
	 6iB9Scfv1hnulseICS62o1tU8/DfoSLDa7Nm6foNNodUVhYo4ONTJ6RBVdeS5htIMbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802054;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nr/EiIhThjqznpDXQ2/qVqrtUajWcViSHOtmgWFbgLw=;
	b=ZxZ6GdwK6xwrMVFXtqo9IKG2tehiPm+PemO9pTyI7YtEc2+gxDUHJjIePTK/stWHeyVW
	 GliHDKsGzwDVmKWiyiticdIsvA4MYB0toFr8C2ICBxRHHyiA6GcpL+gzXu9n6XQF9D4aM
	 nFbqlnx5RIAKEcPisVHyht90SpifrOhFNwu+piQQoYi+nTIIcHmyP9cgb20aztcsKfhvZ
	 GfpJ1mFQWsK7I55bk9r0nyjE2CxCdwgiKINlH3OhK1CZjIBXA6KkCUohCTIAOo95wt09m
	 QGrYSgF5EYetcmj4kQ0i4GgOqbBObqI8CUTq+tQ3iXtuRio9EopPUJyHh/1Z7R3Jrtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kkNlbm3T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA11606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kkNlbm3T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCFE1F000C1;
	Wed,  4 Nov 2026 14:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802054;
	bh=nr/EiIhThjqznpDXQ2/qVqrtUajWcViSHOtmgWFbgLw=;
	h=Subject:To:Cc:From:Date;
	b=kkNlbm3TCCGWihFxA0n4rt4agPlSqNNbPRLXMssUlw55OJ//VXuoDKrhaZlTKxSS+
	 JQQsRQAekax15M78j1/dWsF+GT5sXu2M/cOdN58RXAFGXDfEeQd3K5vh1UMn6VpEhW
	 lFuYPshtc8upE+wokdWz+N8duoPb6nZFWwVW0haY=
Subject: FAILED: patch "[PATCH] staging: rtl8723bs: fix protected RX frame validation in" failed to apply to 6.6-stable tree
To: flynnnchen@tencent.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:20:48 +0100
Message-ID: <2026110448-mowing-much-b943@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 495cb31c791bdf3f9efef255a9587b05b0526c9d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110448-mowing-much-b943@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 495cb31c791bdf3f9efef255a9587b05b0526c9d Mon Sep 17 00:00:00 2001
From: Tianchu Chen <flynnnchen@tencent.com>
Date: Wed, 9 Sep 2026 08:06:26 +0000
Subject: [PATCH] staging: rtl8723bs: fix protected RX frame validation in
 decrypt path

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

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index dde66b68d5e3..0434c2166837 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -416,8 +416,21 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
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
@@ -1358,6 +1371,10 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
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
@@ -1365,8 +1382,6 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
 			/* remove the iv and icv length */
 			pattrib->pkt_len = pattrib->pkt_len - pattrib->iv_len - pattrib->icv_len;
 			kfree(mgmt_DATA);
-			if (!precv_frame)
-				goto validate_80211w_fail;
 		} else if (is_multicast_ether_addr(GetAddr1Ptr(ptr)) &&
 			(subtype == WIFI_DEAUTH || subtype == WIFI_DISASSOC)) {
 			signed int BIP_ret = _SUCCESS;

