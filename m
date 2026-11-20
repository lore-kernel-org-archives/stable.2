Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199688;
	b=sJMk+eT0+n+Ms+2ppvskhgdLSo8Za1Cgp33Oi5e+JXYmhkZv9mblLftjjf8jL3/38u8T
	 SjmWk2tsUpCzxztRS8F04zHz8EzqObq4kaNNmlb3m/4+rGeihJrjfncCwgYwlZZa8GG89
	 fSugbn3biumVrcfI5nEeb/OgGOYuzU0bA3Et/mUGNNorRAbpEFP822LGulsqU0PH3KmcG
	 9ZDn5FWHwi7jH2U5yojecjMnzyl73ZF5n1uN7qda8DcObhYVOs8jNSEYqwkPn/RU7wCXw
	 H517M/cvgUGR624vc21b+PCwTQVa4aIYvbGXeV4HhxJj6jh8UDtezv2XvQDvTcAGDjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199688;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qB+H610s9ZzCf1qnPAPGdFN5sY489ZoUD1VKUQW1JR4=;
	b=1cUGqEVW3NoSPuGEuTudghNssfCWg0sggbGY1J4uJAsM4ojyxL9gt3Uq4UCXy1KRjH7t
	 x90Mp3kqapH4x94nkuba41hwJTCJ6B+Qa9CbhKsY7di/aVuHT1VGZUtj4uqKrSGu577lp
	 xa4WJocBlmjM0ccgnurI1v6csjOAhhuktg6pF1Q0+myWxErZBWuUkqz5AFOFCG55PNF/s
	 Id++2fVLdjVWkuzB056HDP7npyzU5UAOVzCNTqYcKRtKM5pi5cSHLmMZ27C8HWqx6Bt5F
	 62ybjdvOIV3VvU329+cyYN9Ev5LzwA2mO+JYumBDx3FGEje6aJM/ryTGUkMxKMG573g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=uOVLV8dq;
	arc=none smtp.remote-ip=203.205.221.209
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D560A2618;
	Fri, 20 Nov 2026 18:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 698D560A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=uOVLV8dq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1795199682;
	bh=qB+H610s9ZzCf1qnPAPGdFN5sY489ZoUD1VKUQW1JR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uOVLV8dqtqmqNaoOOKEZGGoazyyys6gZSKyoa0YOapwXjezAHfT8Dvf0aBpabK2uZ
	 lzyIh+yDPtMcaxS0jXwqu8D+RfvqjGVx0RmVUTG4kpyBlfwXwAgoI5rm9QMdRvQrRt
	 TZYcoD4EG3XB6N/71MruDXapa0lCePP7G4+BT9iY=
Received: from localhost.localdomain ([240e:3bb:3013:2171:4526:e32a:3de3:2a2d])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 8A7300B3; Sat, 21 Nov 2026 02:34:39 +0800
X-QQ-mid: xmsmtpt1795199679tdb1zza87
Message-ID: <tencent_3C8B79F98D619AA20768761A53496A7D6E05@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCqxY1Okdmd8MNOQZ/eQAtb7GNXRvlTz5qhivJsJFSD1x8UFU3Ng
	 lnD8NRu8EUWuL5WsANJsW/4Ud0cE7eb/fyxXvbM/0q0yRfJFNWPyZJhJXQRj1y7lo/9ARTYpvdjM
	 +X/qVHQUKP0pPwWJ2yIIvKhlncehKVzSEY0ErcEYZGEEdQFtkT229P4O8O5GSjU3zGOLuthRSMKK
	 x5GUz5KhxR7zpOcWD/BfMI4I1TP2jqZhR6DePnWR0t8U5cv4L5sN9Ywq00tU6lkbPxHRq4pq7/ZH
	 LkAkl2DxQA5OkFtB+5pjF3OPL1EqdjB7w9LhCXwcOSW8JNyKmKSH/lEobhf157W/xwLpiFXZ2HLh
	 97hFp36wQTOOu9vEiriHqAFbDIxTW2sx8VpqhQM3LioOpZWoSt4WUg104o6bDwn2OFBN3hda3lY4
	 IBmfOgXmeYZFNJVUlmdpFyL7bVKPajbFgfj1vXW/t7QKN294nx7/7pr9kecm/W3HbelSpm0jtJP8
	 eYtEpldRKEIv/5LWUjq9XO5LowJMBKrg6IPWSinW1G2/NgOu0g3a1ABad0fOYnTiPOboaVb5yfUI
	 SsvJXX7tohRK20sYvxRgX9CI+IY5QSOZQe48UE2ArxLf2lOApXfEAPWGNJaJIhH8jlTVx5RY1+15
	 yrBWThzrNA1sq50qg1sPsmAVpCU+wM6DVhbbVKa09RVt+algjiTDpiqKLk+i2JXgI+zgN5Cj9EJT
	 L2L2+qko+ZbGawCAtVZ0yYXn+Q1BHV7rva6U9++MQDJqyl8rKwdc6MGIUkN29Gyi+Qx/gjydwfjX
	 wiwgzWYuffl165R92gyJy9pvuPHCpJll1rZ7nncFvSZpmqWOw21WKKtrBT9QF3JzsTA1MYpKEcJx
	 exIH0G4lSR5DtWCtD+HPfU3blwKZb9BwmMVAm+7sXaHQvKAPKy4rhIFcvGul4rzyPaTqyYiQICc+
	 1m9n2sMPp/ALBm7bDwMsTtHd/mXgvwA8n+ahUD7LH8pyUCtaMkDxfI/dVzNaA+rHMMWJpmEEuO9t
	 yKSMyfX8449eLKjob4v4MUL34ZQHvXZ2/iSRxQOljgLO2RjpeOUoBCSS8r6Wd27VNLqKl3Xg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: memoriaru@foxmail.com
To: heikki.krogerus@linux.intel.com
Cc: linux-usb@vger.kernel.org,
	badhri@google.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH usb v2] usb: typec: tcpm: align SOP' Soft Reset handling with SOP
Date: Sat, 21 Nov 2026 02:34:38 +0800
X-OQ-MSGID: <1795197300.a1b2c3d4.tcpm-v3-plain@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <awBIRnc9lBkdVhEK@black.igk.intel.com>
References: <tencent_443620EAE95525A375BB2D8A653406630A07@qq.com> <awBIRnc9lBkdVhEK@black.igk.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

Resending as plain text -- the previous two copies went out in HTML
format and were rejected by the vger list infrastructure. Please use
this one and disregard the duplicates.

Hi Heikki,

Apologies -- you are right, and thanks for catching it. The patch
doesn't apply because I generated the diff from inside
drivers/usb/typec/tcpm/ and shipped it with the short paths (a/tcpm.c
instead of a/drivers/usb/typec/tcpm/tcpm.c), so git apply fails at the
root of the tree. I had not verified it with `git apply --check` from
the top before sending. Lesson taken.

The base itself was the real tree: the index blob bb90211 in the v2
diff is the master tcpm.c blob, and the two hunks apply cleanly and
build with the corrected paths. I've verified v3 end to end on a fresh
master tree: git apply --check passes at the root (forward and
reverse), and with CONFIG_TYPEC_TCPM=y the patched tcpm.c compiles
clean (tcpm.o, zero warnings).

The rebased v3 below is content-identical to v2 (same index blob
bb90211 -- the base was the real tree, only the paths were wrong):

From: Zhang Hewei <memoriaru@foxmail.com>
Subject: [PATCH usb v3] usb: typec: tcpm: align SOP' Soft Reset handling with SOP

The PD message duplicate-check and the SOFT_RESET state handling treat
the SOP and SOP' channels differently:

- tcpm_pd_rx_handler() exempts PD_CTRL_SOFT_RESET from the MessageID
  duplicate check on the SOP path (USB PD spec 6.6.1.2 note: a
  Soft_Reset message always carries MessageID zero, so the duplicate
  check must not drop it), but the SOP' branch of the same switch has
  no such exemption. A cable that sends a second Soft Reset over SOP'
  (MessageID zero again) has that message silently dropped by the
  stale rx_msgid_prime comparison, and the cable-side re-negotiation
  stalls.

- run_state_machine()'s SOFT_RESET case resets message_id/rx_msgid but
  not message_id_prime/rx_msgid_prime, while the initiator path
  (SOFT_RESET_SEND, SOP_PRIME branch) resets both counter pairs. After
  a responder-side soft reset the prime counters stay stale.

Reset the prime counters together with the SOP counters and exempt
Soft Reset from the SOP' duplicate check, aligning the SOP' handling
with the SOP path.

Found by code inspection; a software TCPC stub was built for the
responder path.

Fixes: 6bd181ba60 ("usb: typec: tcpm: add control message support to sop'")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index bb90211..95f748d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4200,7 +4200,8 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 		 */
 		switch (rx_sop_type) {
 		case TCPC_TX_SOP_PRIME:
-			if (msgid == port->rx_msgid_prime)
+			if (msgid == port->rx_msgid_prime &&
+			    type != PD_CTRL_SOFT_RESET)
 				goto done;
 			port->rx_msgid_prime = msgid;
 			break;
@@ -6193,6 +6194,8 @@ static void run_state_machine(struct tcpm_port *port)
 	case SOFT_RESET:
 		port->message_id = 0;
 		port->rx_msgid = -1;
+		port->message_id_prime = 0;
+		port->rx_msgid_prime = -1;
 		/* remove existing capabilities */
 		tcpm_partner_source_caps_reset(port);
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
-- 
2.39.5 (Apple Git-154)

