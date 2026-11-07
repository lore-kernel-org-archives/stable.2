Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093682;
	b=Okmb0+ESG5Q/g00Zxjuafj7OSNNUX/hLEzbB8dvXbSjM6gyxPegm2IAjQ33pB0pH0BEK
	 vgUc4AsLFSZ8TKWiEyJbxvY8xOhYgYdqqN6K+RzCoA2C9X2MTVx3ulPuHJjUw5bdOguLc
	 UvxjyDIqAemsU7T6FGkPBF/fcluhWIfmYOIr6JgFlH1nlKpd2BAgZOjGoQapRZJcNinuL
	 el/rLrFWLdnX3/Lz6D+rlLmBHtj7O3fyzZHPKM/d7huCdouCOB067GetY24AnOOuXDs9f
	 27lAsRLTFdZfN9rywPCI5m0auWCoXohrkZ1MQYQkTB9lmW8W/dmuf8/Bh2ap2DWO2uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093682;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=t6nLD3BM8ss/8uYn6Z9jmZe24wmzZU4fuiHfLCwvYHQ=;
	b=rHdJ2ZIMf3PKJKwSzSDJHyjqvymDnH/OiinGCpQOMd13GuFKnVQb387NY7pcFcACEYdq
	 SBELx8zr+7MJ4DxyJYJ6oMcuyId0T9NBDaPQ70TqeHe6MDHweZ+z9k2yt6gZQtpaHQRna
	 2uPVKKHQD7rI8yEiEL4kDqBbs7oJ9TPpCpzLGch1FxUoTBjwJ/4VfOOaI86016agUO+Qz
	 o6tyzV5O3g0b4Ldpmznb3bCMFzyYc5Ogwh9Y042FiJMb44mVs199dtOBFhlBv9poK4qxO
	 pp+RgMeU2hOzCRt/WzQ8MLlAwoqjeHjUXvA3uNFtClz23cqWAC/O0WNGIHqMsYH9YFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=BCR0Aeti;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dm59oqxo;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3DD606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A3DD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=BCR0Aeti;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dm59oqxo
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BD0701D00113
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:21:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 07 Nov 2026 18:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093681; x=
	1794180081; bh=t6nLD3BM8ss/8uYn6Z9jmZe24wmzZU4fuiHfLCwvYHQ=; b=B
	CR0AetiEYpVVXeKEVmECfeMxXceqSyN+EGmlu/r45pbBoDOemQZLdfACkVVV0r4J
	fK1D7hNK5IbitP45qyPbcrNnNSrxQO/svl/SZZZx4bdrdREQDENyCnM6ioKzKegP
	JfjMteUFeSG6l2vrN7PE5sI3bFlOC7U7D1LPfVJhFJkZQxQt8zb/2GlYthcG92sq
	rsff6CpBK39BEjkEwUNl86yrWQiH4epVMpBNmXC+98hw7mgXZj8g773Fbibatdb2
	IeRzjbyL1w7lHWqqS6Ak+CdlNgyCezieQ3pYOU8O8+pupUVi6swRSluupPqQB2qm
	geNJpoqUL0Q4+1sQ2xx0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093681; x=1794180081; bh=t
	6nLD3BM8ss/8uYn6Z9jmZe24wmzZU4fuiHfLCwvYHQ=; b=dm59oqxoa7QbLgvCB
	nYytQU/aOEW+1Pc2FQVlydpfLdc7tqemkvcTQ/BJEwuNyW1kau7m1V7sgbA2lGz+
	HydadXaNDau8XzX3W9XBF6NkZw3TwuanPrPypPe51PINxOBfze+2QQZXC9+5tgg/
	YAnPqC+nXUM3Dad/tIvxrO+ov8gLdtEEjfalm7f56wE1p99IyfaPZMnoC0LNCBt2
	EpZXdhrkMlVtKL8bvPomQUuC69iDvBKxJXsXQGu70JFOjoRhwcdjYoSIWNmavxMB
	KQ0WQIh3nppPUE4CT/8kY9QXAAlFyw7Jkrz6s0AQh5PIS8yDGl18Iej6wB4asD2T
	gzS1A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093681; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:f1nym4HrLXyG9n67+C71NQuGTg8dpP1+Pg+eitcBsUpvmBF
	9BwHz2FlTIjIrR90QquLZIKJVxbtGvudCTNhY3bCEFwNytQDs0q56MN+6dMjhZ1V
	YkgnD0c8yl3jUJTjrN5fycadC3swxmZtPjUTyWLWkI2BBlyqxwAC9DTg8mlZAep2
	DnOYjaa7YCb6fOmq7JvAX2APfsKzflFlk1Y2xMg7k9pgugfxvTPd8nqviY7GnLYM
	ViDGpBY3FpnkDMAKvOJqU/+9WajJtrkcqo5Vgvv6zRQ1bNXg4/fuGru5yChgO0b1
	wv1mLx4jh0MixhIvb2tpomyLB8eEYkP8BPxqJVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ebNxjzYDWAqrn4DenBFAL3M0PcUrM09MMRnxWHztyPE=:WPgjY9mLngV39uK1hoUwdxeYxL/lw+TGEr1ZJ0Sn/VI=;
X-ME-Sender: <xms:cbLvakNrrEC0D5Gp_hk-jBd7h63ix3g2W0iC4CnxAR5HpVcVGzH43g>
    <xme:cbLvag99H0Z-eXDH8cMPmur_nBa4hRfXW-c1pBNjFQG9RA0zr2dBqgvvRIgGLcyk0
    EfQvsAZ4aY8deK_VeCJJb3Inqo9iRB0tybFPjA1dIawQXIGhXQ5sBwC>
X-ME-Received: <xmr:cbLvao6v4KWYTYJp588qBB9P-U6RhGBD3qjRzv8-mIBU2GHlwdiE2uFblnsBmQosGe_IVIk>
X-ME-Proxy-Cause: dmFkZTEyHr9a2H52dZiXldINwgAmMbliY4hKpPQ/QkEZhCAVXoXiuYB3LSyDobwGk8hHnk
    NoAlNVvOiFraoY3fFd29j23OqbgqSJ8gt755gr06EWsG8BYMPUeaTaOdGu58kkdi+sLBZi
    2zWQiATsuMp2jW2MZe1ir5phpmn4EI6UFYftUMAh1tuElZEdCNy4HsV5tNZLWneJuBFsPO
    K8dMt9z+EqlB9zFudNO796pv3RyIav4KW9F8aUNJ52f4Dp7e3WeNlqYzZDqgESkRP3vLlT
    KtaCr2CZigrJI+i0jl4SwJS0sDoKpKlYnEj6pvQ6h+ZfcHNvp52mlmwDz/yeRxITZpcWAL
    250dzB8cnzAHRy4AqVJ/i6CGI40S9o8QZslCKX0dYMNn69AZKMBOAxBuW0Crcv95oV27zV
    mALXdBB0OBrH571JnEODThcwLXzlTK7DIu/mGmSQkeBQoCIlGQA6hHae1YStV4nerdeZUg
    nayN/00oap9j4GAtnn70WzxCdEkWjnM07Dtzfz7mvRklUj1abd+2b6+wbfSLAl0YsOxpNK
    TJnHNQY+av+J9UJBvW9/xz96yBEc7emWDRhMFjMp+C/2nnbe7QIjyo4R7gX/Z2y+QmU7P6
    cLBKQ4o9OvpFzM3oVw5DE7KOC8v5bsvHttDplzNrp9sMG4bYD32wZPvLx4XA
X-ME-Proxy: <xmx:cbLvan2cJqFI5yECZBWtv5V9n2BMBo6SYJwPa9RqADO5HgrnPsn6cg>
    <xmx:cbLvavBsC-Emue_PoykzBqtuQFr-7k2vKxHtYNXn2I0863D1weIPXw>
    <xmx:cbLvap3tlEDSgeZ4Z96KAL-w7bYvKeuH8jII47dXN_SYSoRZ_KBGew>
    <xmx:cbLvapvsNFvsN4djOdEiZlG4hDKC1j-IY1iBLbayhsQCUU4wbqfOEQ>
    <xmx:cbLvahtrSnxo4chM9NVSZ1OfYBA7uyewgMROhL5AMqM5YHS9IyTRulHB>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:21:21 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1.y 1/3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Sat,  7 Nov 2026 18:20:53 -0500
Message-ID: <20261107232108.1873786-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107232108.1873786-1-oss@fourdim.xyz>
References: <20261107054925-failed-6.1-6320736af7dc@kernel.org>
 <20261107232108.1873786-1-oss@fourdim.xyz>
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
index 3a4e5aa26f9f..1af89b301174 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4297,6 +4297,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4326,6 +4330,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4461,7 +4466,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
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
@@ -4509,6 +4520,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4576,6 +4591,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
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

