Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093433;
	b=0OU9nGn0CVIVpWf+ppTqA7JZwSSCiXZcc8s1JTnH003FT1UZuu/uRy7NvN7m9WgfY/vw
	 83fuEXDy/WO0N60KnvQb/HzjksEc847QEUXx3XIBpXX4PaQVyXw3oie7HgyItIUUSyHG1
	 h3S0shdEzEM4qH5Nuifbcj6n+1i9TRtha87b7anYyjFEA5ML/DKJdvRayQFGOMk6yrHlj
	 bjAaALoFs1pKvDjGKr2WO5Fqs0wJv6VyIPNUGHlJuO3vCGwNSsAWp/o0JVQ8ceg4uN0q/
	 5L2FSRUHyChWZe7me1dQsbHGhjfd+jFQbwh6ZJRCkwHblqnMEstQs6KvIp94CXcy+QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093433;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=boIspV7lBYzfQM0PzBLSwze9dRCFConGsWQ7g6FAAlo=;
	b=MrwYq5NjD/HRb9KUfvQrmrNuPb1uJfjygdPcBzQdeS04VDfKtw+ewlQfoApG1ry7vGvW
	 Tu73wR1/clyE9R4tfw+Itv1fkXmsuZ9uQ/ICrFpmWP8i301igBK4OxC6MM+zUNL34glrn
	 rFk4N1tDuzUYkdbND3pRbHTG10WffNBrTSfKdefNa9vYUaezauz83LafQadcq2ig1kKLk
	 WUMcRuXJcUCmWT/8Ouj4FiGfH5N1wveRkd4RjotS5FV5C9QTfaJVBNrB1oVnE0KsfKY0b
	 u6WzLJbNPvvKKBaJWhJSFhOAwsCGQ6VdPAZDLFbgLzgj4BFaV7hqI1EY91u1LFrAtvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=hguMPgnu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jiJf9eA7;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4115606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4115606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=hguMPgnu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jiJf9eA7
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B6CF1D00120
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:17:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 07 Nov 2026 18:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093431; x=
	1794179831; bh=boIspV7lBYzfQM0PzBLSwze9dRCFConGsWQ7g6FAAlo=; b=h
	guMPgnuek5MGi2U3Op/tQW+wdD/WNwPp6tCiwgTkYEm1sdxhbehVKoZrGqeLvXUG
	9zfZPxNTQ3pSRnQndlwkAQWzebcB02LcFoB1KbH+Pa0/lnsWek056Sw7hK4eCKZ8
	aQI+imNc8uCN1DJ6JMYAylSLCv1s1ahcA0yxG9PHGiXKSLAnSuXjB8FfhQO3ubQg
	AKAu4s239idGsv0cVWDzptlgRJMR417r5slL0EQc5HqdKZg+y0NkYI/3LF9z0nl+
	SLt8XEoM7mJ/swxdHWzRMbXPzqcPc2V0ASPzjZG4iSDazkMppPR4wAC39XccPHVo
	KtArR2lY7HVV8EJRKfrfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093431; x=1794179831; bh=b
	oIspV7lBYzfQM0PzBLSwze9dRCFConGsWQ7g6FAAlo=; b=jiJf9eA7AT8Lon4CF
	OYh9bpcY7qcIsn6G1HgLmoSDUircQEigm2E22n4BcOmvfAVp5GrO/cXeMfNQFEGw
	MT4tIwHGAxepj0gt57VPdscnU9hsQgjlyo49RHbZXmR9QzhPDLz60MJi2FiV2CXk
	pqWmpvQeGQ21VH8Yhy8ipBfdHa2Y8YMFJlSS3YvkelhOQmq3K3rci0ET2WpYiP6r
	P6I0iTU/CHajokC/iZrmhwjbbDEayK/SahZRQ6s8Q2tksplurZ/i15SHu4GLMYCI
	lkmTYokLFql8MvMSz15SIc5ijGUoEK2Xv27RT85SYhBlz6Qbu2LxROBV8MMu0gr2
	ncpYg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093431; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZCLemQWON2dWL9OgUImXZlTxJXenPNWcAkzD7ylafmhH6um
	YFw7vMeT3lvjUmT2MNafXjAAmTyOpZu2DoGR3JdsWy2wu3etI61dfh41rcki5/YL
	P0xf304TBkWZOtD8Dh4He8vimC4H7RC2BAaSSiuKQD/XfW05d8ED8N6EU2aSv6of
	WNcuZ/nHp6uAi1/Y8MMeJ96jAnmC4JUM0Hh4LLk1l3kCkdVV0L1xhvqF0QkeWnTv
	uAf/DBEXKLP815QBy1x4a0ptQMIqBl/EYh3e5f2+xKnP5LveWwdWQMSpv4WmYPgY
	dwP/w/qJHFE13sD6y0NdvWVss/xrXXgdg+7sfAw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3J4li2LyU77ktkB9BDTNNA+/8MURoDTrHbKDPLg5Djw=:PIGuM2QNIIvMupplbog0Sm/yZhVqDNUAPjb9n1diT3g=;
X-ME-Sender: <xms:d7HvahU5L59GcvvJ3WvyRfCKKK2iic0hfCaolM2DFX-H1jyLMs3JAA>
    <xme:d7HvannLU-JIgMOTkly1wHyFwcWl-TpigkLYIx0Mq4GU1CIiRm72dDxQay-58VoXN
    QTODLdrHPMnVVsB5xvEzTQ6AIjpgUxG1n6LxT1tVVM3wppYt-iSWSf8>
X-ME-Received: <xmr:d7HvarBOUVwCUH2MNy_GaC0CwN-0aG6PAejif931PKGn6vBjr5DEcgdKk2-88nJrLM4J_fY>
X-ME-Proxy-Cause: dmFkZTG4OKBtoL8ZCR/RILZ9HVIYsiyedYNwSoMK0fs3pjy1KoVI5QKNGkIR+qu2UJo0gZ
    HzA+zmsNEg69ZzY6X0FWa+zLkMFDxwNIsl9Ph4OTn+01QWTkR/Jo/5qW1rJ9nmoNurDIue
    QT+8hE5vQWriKMP4z24vPZOqUxClR8mW3s+b3sdgoVw/1pbgx+Rgr+CuyWm0Rw7VFfh3wm
    Ff/aXmVih5IN3xK3FyGhWQgzJM3srbjX1XKkRojmxjm98IEvfarefkGccvPNsccoj0M2Fw
    IAKskIg7qpYthFMz478vaSMrfqTxTgpU5kYVf4IOXxXEkR36tX+BOJ2DsnIOetXZBNvFWJ
    Ht0upL15FROcWvKHA7AFrkOXRzCHRBEgY8RfFUwlie2GUrBSvIRuut5zlV4gYcJ9D1g8+r
    I00u9WqusKoHeTyF83Pf/k0zV1dQ1KMPcES81jdozH9muFKL4OXzdikNMHUU62Gd91g8Yv
    fwy95NG/V2SrSSpuah7Z217E7xQoBUVt5EU4AfyqD8LDyeMyjwNT3u0M6Kf2hmZU9pTdPx
    LW2YzFhzKQ4B6jR8ZP8Iyn1A1iAEEMN7ZpmpB86HmYo8pgHvmWdQl7jFRosWInMZHDEQad
    wQCNrzKyWRiNqz2NICXThO0P55Y5aJXX4vImMKOjA4muuDLTdUT5wHBnYrYg
X-ME-Proxy: <xmx:d7Hvavfpaq0hz8UuRveUVm8RPYyt7uP-FfBzfpW5zmQ-92zQvGWMlw>
    <xmx:d7HvauIFNLCHCX1kpaq7WBnmMpuAK2G2PQZKPcyS86frDc9nZoI_3g>
    <xmx:d7Hvaqd4X8mVFATf1WI8soDG45Z_vC7HzDlM-XdnRKKLCp3JJ7tM0g>
    <xmx:d7Hvat0blWtrf640vj6HvzNyWmcsK-p1eDsHLcel-7DBDjNPtuUNlA>
    <xmx:d7Hvas0gMmBDLQfJOknD_jwUxKBdhLTS5gxQDIvzzRRToCryjWbnegDg>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:17:11 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 7.3.y 1/3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Sat,  7 Nov 2026 18:15:45 -0500
Message-ID: <20261107231558.1868970-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107231558.1868970-1-oss@fourdim.xyz>
References: <20261107050447-failed-7.3-6320736af7dc@kernel.org>
 <20261107231558.1868970-1-oss@fourdim.xyz>
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
index b86999899f66..3e57c605cf8b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4311,6 +4311,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4340,6 +4344,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4472,7 +4477,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
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
@@ -4520,6 +4531,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4587,6 +4602,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
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

