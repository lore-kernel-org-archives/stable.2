Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393473;
	b=HmOk6167RLxtLCzYdDHc+d//WKvEFKPKi8kgO97QddmvB2LGkl/mLj6l79+NFoltd+2s
	 R9ffU4slu5Zi1yW2kJcm4BksbLYTh0BRhHKtwkkQ/Hpp5u6u5/y0QJ4jOKXZjLgL7RX4U
	 axpR7vayqSrmiVBQnpdoeFQkzZMUhdR5myMrFmn2mpqL6LMNdjyZwcoimjG/6+j5XTQwS
	 NIwyIFMksHJ/YsU3RM3eFvl0oNS5CApFKfT6yd9Hy9ihH8qdv4/u7f62TiD0YVP/qQhG1
	 gt1AUpagupo3p2ndxmu/qvcpcIXur1qsgkid6WijI+0fNmYAObJa8+JnHCEdLuuaVHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393473;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=28Q6WmpAlZrwLLkP6jX7TaLtLGOPmnTXA1hWKXPeSDU=;
	b=qAAmtuvRmVA1Kjw9EJhymLOf7/04Bbes04aRnsJUh5qDZxSkY6yQZpSORBz9v14ydZT/
	 83eZUpm2Ge6u2LGyjAgNRTu0QqziR7sbpsgyxqAf6eBg8ngcm8P+Rud+QkFMWp9EVBEZL
	 CnA0fyh2viAQFcbDEfjskTJ9EzK9FaPGUUjjCafKfWHhpl3vBTCSlOF/bwS2XRFygbNPI
	 QuI31QVFyFuMVzNHjGTA+BZHpghVLLCovT7d6SWP42xTK0FYzEPStfj7P355xAEeqc1Gv
	 NfRWCxiLfsRyE8FBqe3zMLYro5mDWukM+9xOLzM0kSWBdJUQ9mqnmZN0lu2PwrwtWcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CtHh7cAH;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD5606A885;
	Wed, 11 Nov 2026 10:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ACD5606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CtHh7cAH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=28Q6WmpAlZrwLLkP6jX7TaLtLGOPmnTXA1hWKXPeSDU=;
	b=CtHh7cAHJkPYY9WL+DH3iVnGvfzxo2PE9qflOAOQrqkgap9dbxBQcqxtRPqcyr
	HHgkgEd1rgXx57ECIWBF/ytPptsrzG9t98DE83Y985A1JQtKN5lsnp/YL1ST4XyX
	0uAu6/BZJynTlH6LnAl+PIpJv4Hp7YUFCdun/ludwj4c8=
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Date: Wed, 11 Nov 2026 18:31:25 +0800
Subject: [PATCH net v9 4/4] can: j1939: reject a CTS that names more
 packets than the message has
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-j1939-edpo-v9-v9-4-e779ca334a81@163.com>
References: <20261111-j1939-edpo-v9-v9-0-e779ca334a81@163.com>
In-Reply-To: <20261111-j1939-edpo-v9-v9-0-e779ca334a81@163.com>
To: Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-CM-TRANSID:PigvCgCXwCdwRfRqPGBrFQ--.14481S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1rCrWDCFWDGw48Kr15urg_yoW8ArW7pa
	9xKry3Cr18Jrn3Aws2kF1DXa4UCws8G347WFyjq3s3Kw4DAF13tayqqrZ2g3yDJF45u3y5
	ZF43Xwn3W34vg37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jz_M-UUUUU=
Sender: quchaosheng000406@163.com
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDABFFumr0RXE3TQAA3+

From: Chaosheng Qu <quchaosheng000406@163.com>

Reject a CTS packet number above pkt.total in j1939_xtp_rx_cts_one().
The function rejects a zero packet number and a window above pkt.block,
but not a packet number above pkt.total.  It then stores "pkt - 1" in
pkt.tx_acked, and the transmitter reports that value back in an
ETP.CM_DPO.

That value is what j1939_xtp_rx_dpo_one() now bounds, so an oversized CTS
is currently caught one step later and reported as a bad EDPO offset.
Reject it where it originates instead, with the abort code that describes
it: J1939_XTP_ABORT_ECTS_TOO_BIG, "ECTS requested packets exceeds message
size".

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fc2840f33..377991d36 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1512,6 +1512,15 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 		goto out_session_cancel;
 	else if (dat[1] > session->pkt.block /* 0xff for etp */)
 		goto out_session_cancel;
+	else if (pkt > session->pkt.total) {
+		/* The responder asks for more packets than the message has.
+		 * pkt - 1 becomes pkt.tx_acked below, and the transmitter
+		 * reports that value in an ETP.CM_DPO, where it would name a
+		 * packet past the end of the message.
+		 */
+		err = J1939_XTP_ABORT_ECTS_TOO_BIG;
+		goto out_session_cancel;
+	}
 
 	/* set packet counters only when not CTS(0) */
 	session->pkt.tx_acked = pkt - 1;

-- 
2.43.0


