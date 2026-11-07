Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093596;
	b=KgFMYzZUW35AvJFm/w40Mx2DKaOGVX6XKTXC38aVvruLmFxJzlESX3DmfLS2OOPjrmrY
	 2tmgdvP9INNyd8zlC2RJsdgrij0jFeigHcXFTLR5MEZNu4okOKfjCxuib3oSiFnKbxwkF
	 ivltEkLuvYceDOwhKzbzP14fOUeJwwkt05PouRoo8Vnu3IJIouLMvUZwcNuLFBwNjbHrM
	 tIxgSFA9Y4GxlAIcLeLUW3fyEUiCsQFYVJgQD8I2BloxREeH9PkuBzxUf9c+3vkxQOzeR
	 ZJMAn3dnimxSV6LmiGSHHvpQGZJBYUkfhPXdtzy9u4792ySlAjEeKp1giO3J2njtTVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093596;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=fX9K7MommWXCko1HCr+NaOAelkVqmpUMNLTfj3dJGRQ=;
	b=SaCP+lJSHyEVtIp3j7zPGI9F1YMIMcIU8K0lY8k/sRBhxI4YXyxW1OoJfzKukrkxsPvV
	 6Rc9Bt5gnU2I4zoOTyZz7Xb7vKdZe6ehzE5iirZgVbZVX+DwctDmc6bryNY1FlKgZ1yFy
	 OSB3JA5t1PiSuXR69JSFH2XndD0W7B4gHyxvL3yEiDz48hHgvczigKEQvTz/Kmazp4gV5
	 QqmFK4mGY3F8xz48G3gVeKBPnvKvrrKJnuv5Ajs+OW1+sshqKBWyqAxSvbCLSRfPS3Ic8
	 rQFzN05FwJyZF3O1YVcbw+E38L7EqOUXD00pirqgshQUswY8eZMnx9di3BraHLeOmCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=h6f2rbaY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HV6RYPVq;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF37606A336
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FF37606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=h6f2rbaY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HV6RYPVq
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1CD451D00128
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:19:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 07 Nov 2026 18:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093594; x=
	1794179994; bh=fX9K7MommWXCko1HCr+NaOAelkVqmpUMNLTfj3dJGRQ=; b=h
	6f2rbaYDB1ou2fCmhd9lwW407qOxbvHbIaCdkY6mkuUkMbD/v6Rfm8Uw07EGFqsA
	S8t8lpgJJfqN5aTihTy2wVXTvoWWqZE0rWbYqzBO3RwtP4R/ENa59Fu0MWKvp7xf
	gzitbJ3LWJEEdz+Z/oQxEKQzlEKO5NKxk/ei+CRH2GXJ1tlLjCVe5oLC/xoQ7JSX
	Y2cRdZooK6MT8Adq8exheyT0BVBvjNwyT7O27yf150ma4kLn90m7/uRcoJMkRdRu
	LI52CQx0dV2E3tQOAtKa3aaA9IHGw5VsxdkqaXOhPXdt8JoAdnMiT9/2W5VuzjEL
	AUSjPWgZuMa2ve/j//ZOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093594; x=1794179994; bh=f
	X9K7MommWXCko1HCr+NaOAelkVqmpUMNLTfj3dJGRQ=; b=HV6RYPVqdF0PDmo6V
	wM2RscbUiuKmrP8qQMIAwrONDJ1FWokrSOfPF4C5ihN5xPZ/hcWsT3GINb+9CqCO
	lT5SFJjUBzIfVpk+Z7NlSXlJCrJPqLYEPN0r2Qd0cmpcb2JZLy2wwzKNgQg4ctUr
	iLCyq/roxjfXK0sIthSh9eJTZ96fXmL8r3ChZ9Hj/sdt0MwKwSEdOiQPlT439VPK
	GVY1NxDf1c3ytZaEUBeP8c2obsusZ+G+PiRbeFgFOIktbPwuVV7GLN7vg3cR8fU3
	zT5YuGLD8q6hwvtSG9vk7AcTuVpf0NXdomGZukpS1XwxgdEMu8oIRZ/4fCqqS+dw
	r1vdA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093594; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CVJ0bYd4P4ieJKTetxfaY8RVtkJRZXpcnFOIC3er9+pAYfm
	r7rtpMrXmpODKiSuKCCW90W50klfG3Yd5pa03c+xDnv1zMxbm4BC9n0ea+HAKxWs
	ulsJYt+JzEguVNRqOwpOC1lrokLsZbxyvgWyR91PZRkwUY6DyweIKzjHqruexeZA
	+1sPTTLVKyx5DVQO0Uji5en6hmxY8x7PbXVf8prcDkNTGvT/gQ034MD05E95pwJL
	fPSatYk7FEiV0hhIN1czesRzDCabDbEdA803n7SzjrOBxea1rQZLQyKw4zX+VeAz
	V1LIrvXnbHFnnjSs4d8mw3cgmV+DqgCFLt9cr/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IpBRYPY/uxrfSzE5Wufb4aAPJXLm8ges68xLJWU/cMM=:mHtCaL/0E1qQrRHoDZaac6wC6l/hlqo88/9rmf0byN8=;
X-ME-Sender: <xms:GrLvaqi_EqrY6GuaYuk6tIpHJt921GNt-Q0SH8cKkqbtd3ijppkY2w>
    <xme:GrLvahAqoHmr2tSCdNjiSJ_XH53iPDpVspK41Jj5-cmXPTOXUHO_xaCmyadXvjj_D
    j-mSNnBQL8ueOBBTwszIhm6ENv9cxRXBHbVX-fvlG1Beu9rdw6xTF1P>
X-ME-Received: <xmr:GrLvavs-BYrea-Xdt-7q4NINOScsdLNuh3aaNgK3pN_Rmok254IEuN5AtS1F0Ddx9UWKXtk>
X-ME-Proxy-Cause: dmFkZTEIZBGCpisFY+fdhMhQMR/CwWUComkm9G8pkzgx+4rdsjDawZ1p/lM4mekr6Jrfa9
    t9lCBaxA62uSScJCDTVJZCvxUjTT8lXgI6y1ytbjQFdUJAQqlREN+nI/dOsRSO/gkOdRyc
    pC8LDxn6x3PlPwNH8xvIt2eqfa5x/4kvAkT6Lfkd9YAUm//zW+y5QQzyOpHdANNZLZMR68
    JqeYhLI84sK9usprfwwmkKl6Bsmrd+K1rmmi20p4W43h20l04EoN6alO8A20N0x3h2tOrR
    Hs+B6t0zXHZI5+J2tOJigPtsZ6jVQ/WVLTNyOGH6CZRUTfmKqjC10aJjkjpnPysWnz36Gy
    aaCOTZcs75Jf9gRu+o6k/MhaDYEKaNAIz+retldeBtmE+L0XZxkXJS9oFDw84/UK9k7OjZ
    svs+l5zpUclLwEnzrnOOJxDmEUG1+AVXKrbCCVNW22emu4fzibVBoKqb4C0Xu8x1oRmkIo
    kse0HCCT/SKDfU+H/G9gQDyAs6hn+VVMQ0/muiehQaDPUtMzlKldE2B6LBkPs649kxW429
    jOncLwnFxqTrRiy048toMtnhfeyFQtocHHntuxGllTMomvzPg74ZCljYE9oXeo1Nl5/6jK
    ZuriG9bAAJJ4Lxi+AW6AFaHcAxHlWYN22P1g8eCyqphst7oLAmXKNSytWmOA
X-ME-Proxy: <xmx:GrLvauabD1zh7c-aRHhjhzgW-4VlgbLfnvOEVNMKhyM_YiBKNEjc3w>
    <xmx:GrLvaqWChE6rIakpoqoQAQ0i7uh-pkUKkWqazHS9jpX2YvXQC_m28w>
    <xmx:GrLvaq7Jf59Dfpb1wyQ4H6I3hy86f2L45qbBnf74ul2aPYldc0jMkg>
    <xmx:GrLvatjll2RLIo989Zq4wlO4p6plEFnhYJ2QRSyV2NbtxTiRjpm-XQ>
    <xmx:GrLvarAhi55epRZ0AIGdQnsFMsYpQjj5pzwL-n60QMdQZ8pdQykEw6cO>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:19:54 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.12.y 1/3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Sat,  7 Nov 2026 18:19:12 -0500
Message-ID: <20261107231941.1871942-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107231941.1871942-1-oss@fourdim.xyz>
References: <20261107052252-failed-6.12-6320736af7dc@kernel.org>
 <20261107231941.1871942-1-oss@fourdim.xyz>
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
index d8c39a430686..fa7124c32d91 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4278,6 +4278,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4307,6 +4311,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4439,7 +4444,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
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
@@ -4487,6 +4498,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4554,6 +4569,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
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

