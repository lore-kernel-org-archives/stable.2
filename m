Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434887;
	b=0Tu3u/my/kNC9rPl1IyvdHi59QwsuUwVg2xu8X7Dvls7hNrSdGMozM2W62P0RE/HlIlg
	 aftr9O1mYKJIMWBofoUnr+on+mxJmms0o4owF1OjB8iylX2jJICq+rPd1sH2WesImU6S6
	 BsTp+fNr/q6VQLnXy4sLTfOEj6s+xgkt/2CSHyKRucYdwVPRudesfc8M70q0pAXJVfuVb
	 LYn/UzdAvUN59NeTnGirJXNXqc4povsVcKXFUTLaUQI4kVju3EhoMGFkfZy4dstqBUy9j
	 5OsCrxLnk+1Y3QFlPgQu8JuNgR1e97OLNuqyPja7rbAFL1NSm2vMl2/tBdsbkhIUbeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434887;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=jIa37GXJNCWDaKxf5vK4PFD9/sbNRt5LIqZ9RdT80jw=;
	b=GvJ6aFr8J6MNpxVk8idvSgd7gh9B7CHhg/Q0g0OC8OEYjlLuEbZjzr3xc9hYFXIwu6ab
	 RPPNHbyn4uUx2Z/qDiFDCzBkWUyXoQF6HS2RgdKk4MCpzfWGHU74jdvVcWZuJTue9Ze7g
	 xR7hvhRNlIkK+nRYxvxR7jhEck798xQ4L2SZU4FrDMhEN2io6uzf8cZBGJf83pNaHc5h2
	 ea/c7vMumzg0V3NzZ3vh5M+DcA79/qt0YZYr5Tz5Ry5pnwXTHRuIKO0YnvaAo7BZe+rD5
	 9/30ngZ7h0HmLbUbPdM/lZK9/hlGZny4OjY3eepv4AqIbIzQ266Vv4qNuFheOEXjLXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=W5+TqklA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=18jy4VUF;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2C0606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA2C0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=W5+TqklA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=18jy4VUF
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 038421D00136
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:08:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 17:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794434885; x=
	1794521285; bh=jIa37GXJNCWDaKxf5vK4PFD9/sbNRt5LIqZ9RdT80jw=; b=W
	5+TqklAGzUowfe+oLI+ImSvRwzBbxbqNV8NYlxZkQdrJ7LO+3W+P8WfsuWdEaRMB
	f7XX+jwkomicl2k93ALiXdvK1ttG6+OM59aJClZm15Ont3fCOn96mNfVrlct4nBy
	6ricGI7K4nR6B2USfyl8J26xxvZQtJC+yJDAMNdNzSSkGRRUrtH1sdwQfN/M6M0l
	9mjTGBAEAsqATcUqy8WnNUUzgetmo0/5RQQICUcXp1+jJMu37zuB/l2cLxZV4Sj+
	R51TbHEO48/LKdTGdq0FQgeuS5Zmj3vpvyvMTs3ARtZh57zrouCXx2V4+4OkAAlK
	7ebJe/2M/v30J1UlVTGLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794434885; x=1794521285; bh=j
	Ia37GXJNCWDaKxf5vK4PFD9/sbNRt5LIqZ9RdT80jw=; b=18jy4VUFRkIXpi+rg
	omNUv04/H8P7DMWXBCVQPRvVLosOJ7DxuK7tjxZBh8m7xtpddt2MJx3uHY/8Qyl4
	Vxw1SI+ZWuW+RJZhEGSajr36vPfgefaZqAl4GHwaWdFmnJLCA2T7YpKJ2mqZiD+d
	2H7xDGxAb67/mOo/aoOlXscs7KZjK2gJRNmCjpdd1m7+F+PQlYody1S1c09fNinj
	fJg/gyxiuvkaIMvdQfqt/iqN+aTqsUs7/Bvz6Gt/DXfV+n25M3//DhLjh4nDVsgy
	L7PMELv8H33cDH3pFB6LtwoRB1FeZ2xbhXYQ9fs4GTIQy+ZMFDv2xV+iEUKoXQke
	QeNtA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794434885; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cnNgalDfE7FbSI+gkieE6RN5YHOk84IUqXDRcikNJAVCfMm
	iyMhISpHt7XNiEQe6cbut5zW7hi8x1N72QQ+4E19GOtQL1YOAw1ipRflt7dxNeQT
	rN+TBv6tg5tKChnF6dWFTarJDA8ZeFmmXe2y/Uc2CU4v9VpOIRH/Y+rrosiMHVwN
	Al3Hjz6+1xcCK+NYLTvSue76fqlt+fitxOTc5cIrY5pVwMwXs+on+/QAL9HEjO/I
	wv6QtqiGWCBiRErxuDJsvwtw9p4/eTwjeXT0ftD/409wqLJzct7cgC864HtU+a15
	A+xJiogmiGv7qwEkFFoJO2I5vRavNz8/pRccdNg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IUCnNqHTs17QkzQNaXWGrJH2qRotuwy+zZKs2lCdANA=:hEcjUIZQ1WaIc608MDS5HaN8TC9HJ/Bf8tT8xssfyGA=;
X-ME-Sender: <xms:Ref0aoKSYF4MifBE1D2bRYo78I489roCJ20S31fM5AvF-froaR1tyg>
    <xme:Ref0auLMKpdUIk5GRaUUox_HCfT_WVR5vk4_t3ppQArAWJPWrPJT6rwwk7qGS_Ec3
    w4qE2EQ89ZnClnZ59zgtuL_Ra5s1BnQQfl3HSsps3SaHoY6I4A3F8rS>
X-ME-Received: <xmr:Ref0amU-7eGufboNiMBogtQXDy0Py_Szlj3_CBjQeDDz8lseZrl2Ls58ll0srhfas77gd7E>
X-ME-Proxy-Cause: dmFkZTEijvUOy5pjvmxPmfqPx9Fpjt4e0UrFH6WaW7CRlfYuyZxNmM3WEUBk/qgMqrN5gM
    vOynFiAr2CIW4EgWmJRvIWFajStHGruHWY92Z5tdci9MXse4PJoXvI0K6OfsNHCXn6NYxm
    HLRCAty6RiTwsPpgyT2kmi5AiAujM8P5DJuZVhttuHLQLUbgnO7e0DnoLIvSPPd1xcsIZL
    9RTgX58CUMbZpVlBhq8D3962Js+dGOJ5I7zyNqmj/xGSBxS6HxAfdI4mEpyWvxzn01YDqa
    nk5DoeuAwLh8dlJXs0Ea5i8Lqv5phtKFwN+371XAa3Zkb4GYYZ5NUrYrUNJYfAAAC9gplI
    NxDwcbG93DCuzaKZ/4E62XISnr6AZYgqFOnkyqcU4IxgxTR2bXyVoeqLg6YSvB7SZ+F5xP
    Ik6W1ZUuGziQ/y/swlQeHwf1GMqs7NnyGATjmppqefbPKHcWfm7CczlfYDklz41UbserfS
    29fr+pGKYthxltycHT8U/s70LDc03uThDJHejCx+TrWuNdCY61TL/NVf2sOksWs5Jjv8gK
    CvBmlGbKZVsMDr14/y+YnTZTP6tzeeMKBnezIFLZnFanfegwj8C1bkMrlYRIBUUQm1zEyi
    38hCC9hVU5RCu+ByLoI8WVbcFPdG4NYlgGE3fvAWsP9EyH0c7J2i4dZ2a6ww
X-ME-Proxy: <xmx:Ref0agiYCJugVnHvg80h6e0mC6Gtzedn30MOnz4vFjgsGuVab49_qA>
    <xmx:Ref0ah9pZrxb6CYuPkYRRBLiVA2xnmhGzgE4f2rS7UKvRjbywnp3wg>
    <xmx:Ref0aqCHOKL22B_Abhrsbb0y4UYqMVSxPwjPUbuWgCPdSK2_OIwNCQ>
    <xmx:Ref0auIxAH-mnZarqS6onRoNpVSng3qPzcNvHDEPFGFJP1AMUJofWQ>
    <xmx:Ref0aur_T0Nv_Fi239xUBPMI769_tszq0FcptB5TmJhYNwDYiiw3CI0E>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 17:08:05 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y v4 1/3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Wed, 11 Nov 2026 17:07:11 -0500
Message-ID: <20261111220745.3075256-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111220745.3075256-1-oss@fourdim.xyz>
References: <20261107060628-failed-5.15-6320736af7dc@kernel.org>
 <20261111220745.3075256-1-oss@fourdim.xyz>
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
v4: No change.
v3: Drop the AMP changes to l2cap_logical_finish_create() and
    l2cap_do_create(), which are not in 6320736af7dc.
    https://lore.kernel.org/stable/2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org/

 net/bluetooth/l2cap_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cc49e651907d..9a883e476684 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4443,6 +4443,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4472,6 +4476,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4607,7 +4612,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
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
@@ -4658,6 +4669,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4733,6 +4748,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
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

