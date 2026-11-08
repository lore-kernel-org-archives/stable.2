Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096399;
	b=doPxO5MhTvXUI3EV6KnIcpsIngj0w0+f/tN5VeijjV9XQOirqx3mc/oCpQd1BCzVgPaw
	 zQ2JCA6ib3bIHcNRnKkiRY74fWppRBDh9b9KZ7F/CsJhymDBwF3xAhwIiR66553rg99lb
	 49a0+WEPf/1Q58/2FZsR/nm1aNwvqIyw/oY2lMKALytNdspe01aQzmEuGs01+242+bsyd
	 UnLEm9iVxWgVTwfHGVPQhreeryWUvVpaWzVf+gwLt0C3iSOgR7z1K5CRctL+HlfWlSjTX
	 zgbp+JEvIKXY/V+ZlQfQdes3ICP1PtmKMkb/gjUnEQ0H8vFSonwNeRXAFzN5dV9ZFWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096399;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=XOXcmaKGRGE3JDox1DRADQDwfl75lkNJsi1z4S+ZW6k=;
	b=uZEZnO2nAqZo3nNLbSf0l1vF//V45wv0DGohdwuYuGOns3ppne7P/wVwm1NmoEht7uB3
	 RzCAVQ+0EI0bRaH3VFp+/Nej2cKORXDb+B+zkUdT73wRgd272vd4GBmr36uXUgN/vfN1X
	 hxmXjGep9dSrlNKR20zl6zjhQRIj4bSEcoxSLTGICtfPbNO2m+hsPIDm8qNvHMSnhN1SH
	 MosSxPLOhAR5+1DMtlrH9d2T7u4aWZg270v6GcHyvNPxtJdVi1vimpaooFtBQT5NHID0q
	 xZxA4ELh0UA6LNZeTcHTCUrmWiBvwuXBHjslC6EXbaZFysOI5Cqw4JNoU54sPqas+aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=SiJnf9ZI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Pd7bjzG9;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA04E606A32E
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 00:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA04E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=SiJnf9ZI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Pd7bjzG9
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 14862140007E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:06:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 07 Nov 2026 19:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794096398; x=
	1794182798; bh=XOXcmaKGRGE3JDox1DRADQDwfl75lkNJsi1z4S+ZW6k=; b=S
	iJnf9ZIjdCJW3L2u8KCOXC1eG3F3tWIPhXKd3kQlj7AQRQsQby1P5aYkhZ/7QdDI
	UcZDTHC9rapxrHbQdT+XJ8nVVF8XZm9RrAGMHkus6Bj+dhks5pMOAImqWkR7iSE9
	hGjuQkrbTPCVkqdp9d/WeRXIzeFCjbLUa3suOh4W7iaVUcXiau97s1fycmtJuLTK
	RoHTGv9a7z7XArakNPwGWTfkYVmL/nm6fnDBdDEv3L1V6s9oCyqSyAsBaPYe4Wb9
	g1uKEFbFke27ioknx+rHMm9IEDrOkBdjRWgB5wo1XRj6iOfZuPoI/5dnpRsd9L5y
	S/I88haR70rKiDZ1S2NBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794096398; x=1794182798; bh=X
	OXcmaKGRGE3JDox1DRADQDwfl75lkNJsi1z4S+ZW6k=; b=Pd7bjzG9OodrCrwxt
	XwT6YJsOifMdNRHlyCMUmU2zqI78uDhknHQAx6+78XblrtNy/bjQXtkcSYYQZTmh
	tYCwmAKeDt4+iLc2IKxMAET4DGML75IqO14uacVjXcgT7jERebDh2FLembKfBj4L
	Ddysf57UI7lKBSewiKRaTdL971mqCgXo8UfEf/qOKT8vxEP+mULqaF/H/jWKLtyc
	NxDgb/UWDPLOVlFmxYAmb2B84hcBEnW1/QINvcu36GOr373XGm7dKReerldPN+RV
	hcwtxqBfgQY3A7Mth3veV7O6nSW402rdmT5V39KvxlnqzmSmsNl9I4KesTkJSKTd
	QYwiQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794096398; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZdU0LVXUYAd6cWXiYR1pGl4Gf2Klenkl1ZzD5QPUohAhT8v
	N8UGfPz4uhd5VvSBZUh0J4icNBziNswf+lz5XufsWfoNCq4vAnpylihS6ygtI86Q
	tVQAJhQbyU//7EXPBbW+YfPH2BO+1pElmcy4AZT63lTIzRJ5o+4Y/1ZICwlB82gB
	2RozVBtK2evZFbT8xBu8+D4HKydoWm18RysfZgv6Rr0X3V+Bglr8hB3ZNlsxRZ6s
	qRdCX8VcDXgROLrNN6ivmxXdhTJjRNSTiwaw8FKEArQg2q+pcP4aCSgU7ESKDaz1
	7iiqMm1v12eAA1AsbDV3a9RUaTZSztN8hCo7dLQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ng6ygD/EhJz5OKxw5a3ajAemVMytB2CRIuzN3ZdLsb4=:CgyV7ouykAgA7lM+i5bIU9SZQk/vrz9e0qejcC97oyw=;
X-ME-Sender: <xms:Dr3vaiTqeM_n7OEulZmrHac0y4d7FHIUT3AJZPi2DY6TLF54-lSsuQ>
    <xme:Dr3vatyom-IaIx55FEf2CxuC6aPiwd9NNhJTJjb4cFTG3PqSUdGJsNmG9Fc8lJz8f
    wo6dey8GjG2aGS-T_pRbzs5VpweJmNzwPQ-UwCGzyPCz4g952jCl9Ef>
X-ME-Received: <xmr:Dr3vateDFf1EE8vmm5foCM_vP37l8GoqUqlAkEUm7OUMKMZ0RPi_JwiaRs_mujMeYBeZFes>
X-ME-Proxy-Cause: dmFkZTGkTzGGuyrIkn6usfbBBSincUXi0nfoPtzCMgd9kL9Qy/rXcq0PyCI8Y9HnuyKlf/
    ALvTAEnP2e7yuUPdYFoUfdhwnokfpMSkRudiqO8uEsNULeQRomrNWK4AXqIt3HgYiOwL1o
    MxBxgroDXIVmIzAeNZPY7845pyMpPmejrekFkhPkGDOOGTR4ye+CXGEh7pXFnVNpoH76bg
    /MwEpo1S86rqRqStSpc24OFUjJ1T+mZ3cD59FxAuAHLREcXxxt1rufW2UWueT585/yMSWV
    MBq8x1uu1V0TDeWhXwvtJmPan0zB+7wr/hy9/N435ieetz+KFcMB9llgpgIdftJv3rdwiu
    wK34+LXXZNugvFLl++09p5HZKDe0sphEN1dfd/qENLezIKqQgIqFv2iBU5l4PT+DHIusA6
    I/9ugjjCisWsPaSJITTXUwbptOX/dxrwFnb7LDOBLZM2hHkqAP6znVvNgKSYx1u/n6R5eY
    bEZnab1sTX3brIHJCH9wnXUljAMQktQRqQNVJwOhqEkGsc8IWrg1fYh1Iw3dd8o7zx/Ogq
    kc8Z1wOtkEri5JZn7rd2bPxkWpl35VQ6zmPf/pW7Pl/3ssXyCX7ED6I9botV5E9/PbXghK
    2e3hKwfQNKNOn/Xj2bW41HOf0U3H4UwQSymIADaaVx+/42/kZua0M7+22E0g
X-ME-Proxy: <xmx:Dr3vapKVqjrcuUSxk1Vt1RGP2GaUBGK3hXcvIKdK7DMbOtDKId539g>
    <xmx:Dr3vauFYYaXNx3OSJ1td5zZ4KY3MT8axbfU7eDQKrJqLpJshy8U5jw>
    <xmx:Dr3vajrpUIu4XLWzGrxBh91pYxQ4nrSxwIAneozorTQdR1sUHxVpHg>
    <xmx:Dr3vanQcCiyT53IIfhJIAJsOHywcjsu5OFUzqxSwiL1JFSfDTfCpQg>
    <xmx:Dr3vamzqafCdMOma85HCNQfIisv-7922UQKWqKCjIeTVunQK5ad7Yqr0>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 19:06:37 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y 1/3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Sat,  7 Nov 2026 19:06:02 -0500
Message-ID: <20261108000617.1969616-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108000617.1969616-1-oss@fourdim.xyz>
References: <20261107062323-failed-5.10-6320736af7dc@kernel.org>
 <20261108000617.1969616-1-oss@fourdim.xyz>
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

Stable still has AMP support, which upstream removed in
commit e7b02296fb40 ("Bluetooth: Remove BT_HS"). Close the same holes
there:

l2cap_logical_finish_create() answers the peer's configuration request
and completes configuration once the AMP logical link is up. Only do
this in BT_CONFIG, so a channel that has not been accepted yet or is
being closed is neither marked as configured nor made ready.

l2cap_do_create() moves an incoming AMP channel to BT_CONFIG and sends
a successful create channel response once the physical link is up. It
only checked that we have no connection request outstanding, so a
channel still waiting in BT_CONNECT2 for security or deferred accept
was accepted, as was a channel already past BT_CONNECT2. Only do this
for a channel in BT_CONNECT2 that passes the checks l2cap_connect()
makes before it accepts a channel.

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
 net/bluetooth/l2cap_core.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index de97a746bb38..6b13f6784c40 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4478,6 +4478,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4507,6 +4511,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4642,7 +4647,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
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
@@ -4693,6 +4704,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4767,6 +4782,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
+		if (chan->state != BT_CONFIG)
+			goto done;
+
 		if (chan->mode == L2CAP_MODE_ERTM ||
 		    chan->mode == L2CAP_MODE_STREAMING)
 			err = l2cap_ertm_init(chan);
@@ -5180,6 +5198,12 @@ static void l2cap_logical_finish_create(struct l2cap_chan *chan,
 	chan->hs_hchan = hchan;
 	chan->hs_hcon->l2cap_data = chan->conn;
 
+	/* Only answer the peer's configuration request and complete
+	 * configuration while the channel is being configured.
+	 */
+	if (chan->state != BT_CONFIG)
+		return;
+
 	l2cap_send_efs_conf_rsp(chan, &rsp, chan->ident, 0);
 
 	if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
@@ -5290,7 +5314,17 @@ static void l2cap_do_create(struct l2cap_chan *chan, int result,
 		return;
 	}
 
-	/* Incoming channel on AMP */
+	/* Incoming channel on AMP. Only answer it while it waits in
+	 * BT_CONNECT2 and has passed the feature mask exchange, security
+	 * and deferred accept, as l2cap_connect() requires before it
+	 * accepts a channel.
+	 */
+	if (chan->state != BT_CONNECT2 ||
+	    !(chan->conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) ||
+	    test_bit(FLAG_DEFER_SETUP, &chan->flags) ||
+	    !l2cap_chan_check_security(chan, false))
+		return;
+
 	if (__l2cap_no_conn_pending(chan)) {
 		struct l2cap_conn_rsp rsp;
 		char buf[128];
-- 
2.56.0

