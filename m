Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093551;
	b=tFNJLwl3cjegEnrrFmC7zO5boXGQoMFLUirwOj+/17+57a6Lh1tDYS+W74xO6hAFpS2U
	 3RLl/F4XiDK5YsNz6jGyMaSIrJIoGJC6SgN6RW9MF+PF+w1W5LtHap7lT2rfxFqQLcw3G
	 bSr+lmbXwKvwMcjBGkb/8gGYpk2tUwYtvntbP86K97NItVduywu03coz98uh6v7w8AqdE
	 gUOMx9fSG7Kq50zSQpIZCjWCuIKMNXDyjLEsPhd2Hm315T1HLdC8JbOf9SlUWBDpJwu3J
	 U6w5QDGwWD9fWSkn8btmu55CKA6ceBw9p34iKciSnOR2mNJ2hbV3TQ5yyLCXleVHBjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093551;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=bPOTanpQQqEfZ81uhUZH8x08Np2LeK6z8upl2PCapvc=;
	b=gmUd+sH2dT7e1sbUDXf1uTYreKVziiYjMp+NoQgVTB3RDMffzbTJ2jirPgWhHYJMxwp7
	 rqDr6CiF3wMYmqLmD1ohl95lcEK4nDCvh3YIESwB+dU+0F0AlMauN9XyJUrcFYoC+8VLO
	 2/h9iVpvfswLitxy1M5kHz1kPYJJJo8YOebyAu39M3WBx1Jaw0CmQa9lQgEkmic351xQK
	 OGS4kHiOCsQaG62bWE7AB6lHo8OeD+tyqb5FTkYD5q8552wf86zZDUKsPE1lj52lNLH0E
	 HXgQq8urtm0RhPTAv6wS6saWJ+VmpqmlzS/P53OddEKa9nWZ2ghe7eP/AE6yuZBZqlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=AgxSyYNq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=F4Xxjgc7;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA1F606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDA1F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=AgxSyYNq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=F4Xxjgc7
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 21D2E1D00128
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:19:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 07 Nov 2026 18:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093549; x=
	1794179949; bh=bPOTanpQQqEfZ81uhUZH8x08Np2LeK6z8upl2PCapvc=; b=A
	gxSyYNqtqRsXPdZ7SGtFsAH2RuO0UTx4RX5it6wdsLFQS4CU9fnKse/P78ZFnI11
	4H5W7k/b1riTA80+sBk4EtCNFkzb3s50wH3RE9l7nqU/KY33m8NqfCFArfvm+b/e
	qh4P9RkqvnyBdwM5dSV8xN5hlV4WMzxDcLcVAOs7uMunpI6SPKpl0ME4o+7P9F1a
	vjuiw+CSJzkPljGsM2lLgwwFkUdr7nEtaCorA9n7mW6sWYyiDEYXtyjpJ13aKrGq
	ga4AZ54DfAEPeyqlTfJGWlBkrxrBXcjNsHVg5lY3QTQkfQnKpgxkllWwNJlqBdQu
	hBhdAR+9Igw+yNY4++BUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093549; x=1794179949; bh=b
	POTanpQQqEfZ81uhUZH8x08Np2LeK6z8upl2PCapvc=; b=F4Xxjgc7zhINZd/h9
	Oc1+BWc21iCSejIvtlnGRa8G5pTEQrD1A60d47kT7IRdCwq9cQB69i9eqpRq+o1x
	u5Q8wsEX4mb5clGj3Q1Xt9nEEX/2850yBmSC9gOTml/y/VmhpR6kDCKkzK8bg6hn
	6LN8krap4XbZD6Nl2C0LwhDiPImdzSFvw+qz1H3W0J4Dhpy+4P+fftqgliQopUOF
	Cz8MCuzRoTGtwKu+NP0XEd3hms2MRzXuLHhzs7U+hHmfIpsMYOHutnCL4dVqolVk
	g8D4GfqGmu+V0QbKbaX9DeNkqnQezIbfzJIqIoJqeaLQTvsUiwWX88obQXJNnCHH
	S0r1A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093549; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RCTnv2RhsAFNcSeAXzM9h0hpKc0WesPgyPx4o7L7CE0epFI
	9ZEz3b/Dbl29EnmpUMEi60HFi6FHYzO1CbJxb+08SdJ/V2LJLZid9a06DEgaDpzM
	e+Lj5XPWVEHrcm8B0EQ5l+2kIeVDv7DlR1cX/xrfl0C5/Obvi8J3P5QSKt4eJL2f
	PiW2gIQiXT0JPIV08P0zWWmg/MnvzGaZMq6U++MkYqfYajqrZGFJHlidJYJhzj0p
	P9b+2t1j4CQRW1zzh0tOw91R9qITqJAm92pMCmZC1EygH1POwK0bQ/OL56uadPZV
	lrWuW75rJsPOrXMNUFCLlog5JlPgdK+LkLNW4Qw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:pweXw0OfYPpylpU8V7K1rVCwRJNP2JHujQLfYnxmyto=:+EqmoIHiSpq2UtFzFOMlBenuFoeVw+LIl6lxgIFlHVc=;
X-ME-Sender: <xms:7bHvapkijqqArYkLAwyEiF7HIKg4VTfJrR3KdJX8TEkCKxfQa8fWFw>
    <xme:7bHvaq3QOb1KjYyNFg-higMtB6T9gZxdQoWOHeVtobVIa7pODX5-AdNN3vtlSduPM
    NIKAHdTpJEARWLV-93lngyrgAQ-q5TQKizrmelZwuOwSftW9QNFTg_F>
X-ME-Received: <xmr:7bHvatQ93hxtVJ1JkY4krLngTDyw_Q7Hfs-HIYrDix8PtZfxqOGS5ut-o2rxcjozqf9PGA0>
X-ME-Proxy-Cause: dmFkZTG4OKBtoL8ZCR/RILZ9HVIYsiyedYNwSoMK0fs3pjy1KoVI5QKNGkIR+qu2UJo0gZ
    HzA+zmsNEg69ZzY6X0FWa+zLkMFDxwNIsl9Ph4OTn+01QWTkR/Jo/5qW1rJ9nmoNurDIue
    QT+8hE5vQWriKMP4z24vPZOqUxClR8mW3s+b3sdgoVw/1pbgx+Rgr+CuyWm0Rw7VFfh3wm
    Ff/aXmVih5IN3xK3FyGhWQgzJM3srbjX1XKkRojmxjm98IEvfarefkGccvPNsccoj0M2Fw
    IAKskIg7qpYthFMz478vaSMrfqTxTgpU5kYVf4IOXxXEkR36tX+BOJ2DsnIOetXZBNvFck
    bcPzpzFMmPxbanWl4eA6SoKeU3dZtF/1k86EtcC9DBDNZBA8umj+oFQT0BVPfp0qw2FyjX
    4W34pxQlY9DwaRTg0EcBGxD4KQedEYzmvAE5M1TGtq8/9l91llwFC0sudZmclWObOsK0Ce
    mf/7MeK0NJXUZjJqT7T18bvdQSDJ1D9l80/NNL8rCe9IrBDFJ0+C0yWti06DJcN4aJtUeJ
    NFYRH2iF6MLYkYAB86l5/hRn43xWq+FEprPLmBqz7y5E6vDO7DViIKnRV9zKpMN/l+WQLH
    qsu+x0CFe6yaDpwD/agZYFibjPj/bLdYv5nv7AEZiv2gVUgyGq3LiJUYCw+Q
X-ME-Proxy: <xmx:7bHvaksUd_V55JBTtJxK1ON5g-rrXXKNjepU7LFPWBJ1g9DVNVIh5Q>
    <xmx:7bHvaqaD2Sj5f9o-2LXD74rQWSlLMYNhtNdSG18er90Wg7c4eYVPig>
    <xmx:7bHvahsdhL9rRv1KfYymjSgilsv_-VPWLiC1GamDqIV6Iix_YT0IcA>
    <xmx:7bHvakFZ31fLT2rmV80yPLCPD1_sc0catirix3oehkpFaVwh9AfBAw>
    <xmx:7bHvahQo-48CemSHgotkWCA5ai211sTnSGWFB1DJeMnSrmWUdLIrTvfL>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:19:09 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.18.y 1/3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Sat,  7 Nov 2026 18:17:18 -0500
Message-ID: <20261107231852.1870314-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107231852.1870314-1-oss@fourdim.xyz>
References: <20261107051130-failed-6.18-6320736af7dc@kernel.org>
 <20261107231852.1870314-1-oss@fourdim.xyz>
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

commit 6320736af7dcb90da6ee9fd651ecc11c564d45b7 upstream.

Adjusted context as stable does not have the lockdep_assert_held()
calls, and l2cap_get_chan_by_scid() still returns the channel locked,
so l2cap_config_rsp() does not lock it again.

A peer can send configuration messages while an
incoming channel is in BT_CONNECT2, before the
security or deferred accept gate has completed. A
configuration response can then promote the channel
to BT_CONNECTED. Configuration responses can also
act on channels that are closing, and a late connection
response can move a disconnecting channel back to
BT_CONFIG.

Accept connection responses only while waiting in
BT_CONNECT. Answer configuration requests in
BT_CONNECT2, but defer our own request until
BT_CONFIG so configuration cannot complete before
the gate. Ignore configuration responses outside
BT_CONFIG and BT_CONNECTED, and only complete
configuration in BT_CONFIG.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0ba7b1ea435c..52ff1b8785d7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4310,6 +4310,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4339,6 +4343,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4471,7 +4476,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
-	if (!test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
+	/* A channel in BT_CONNECT2 has not passed security or userspace
+	 * accept yet. Answer the peer's request, but hold our own until
+	 * the channel reaches BT_CONFIG: the CONNECT2 -> CONFIG sites send
+	 * it. Connected channels may also need to reconfigure.
+	 */
+	if ((chan->state == BT_CONFIG || chan->state == BT_CONNECTED) &&
+	    !test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
 		u8 buf[64];
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 			       l2cap_build_conf_req(chan, buf, sizeof(buf)), buf);
@@ -4519,6 +4530,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4586,6 +4601,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
+		if (chan->state != BT_CONFIG)
+			goto done;
+
 		if (chan->mode == L2CAP_MODE_ERTM ||
 		    chan->mode == L2CAP_MODE_STREAMING)
 			err = l2cap_ertm_init(chan);
-- 
2.56.0

