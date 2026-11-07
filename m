Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093553;
	b=H2L3CNiq0nU6vadVtdT7jdbJvDIqKcK2IK0/OJD0jFfXXCW5jik93lfBBgzuIFvf9c4V
	 unIRbbmJXZ68O2xm31XnsTF9r4IpDogKxjlrgNegAUndWdIdhftm7ApIKTyhLhNypkjQy
	 mzfeWyKB913rMkEna4fF/s/nyCpChK4DjFpcGQX4YZA17TQUegOrEjiwkgmThElrGHZQK
	 1ZCILkftUqZEGy54BUYE9SrInzlKoKwAK18RotIKZHpk0W5hmg3T4710rrWhp+DElwwlE
	 xNnFMPGCB5gtE0q1ZMZFHBisLh0eSSzv25/pOtnk0XVRLIQ7CCyRFXB52vP64AkCkIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093553;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=1VSy8o5Dn+pI/UKZfUkTqR0/8hKFWgl2+Kt32XOIdrk=;
	b=MWtnT+/+oRIGh58/c3EFP5kuWp2iRPNJSZ7GlySMPUzAodghqD7IVUPoRb/eLSAPvAqK
	 1F5RjUrNNBh7uEO8/HarYYoF5ZY3xJlQ1GS8K32iad3iQ3PFN4B94djWx+aygsuNj31q2
	 MenojW6GV3iZe8Qix6gEq8ZviItNL8YlE3/TwVJURTm/tz9t0hL5zmtjSKDN1svy6deeL
	 v0I8Mcc0Ltds3CqAfBG2ht74qNR+JfY+PkiFzxvixRiFyUb3qOjYvo3bqoPLIlujchlZ3
	 91HCA+Bs1M70vUNYbzpYu9AKd7SQOVKIDCJPHrDFMt+sTFPn+BoiqLZmap/Zwzil7sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=VJNExG9H;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q5VP5tqh;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E7606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD0E7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=VJNExG9H;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q5VP5tqh
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 355FB7A00B9
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:19:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 07 Nov 2026 18:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093552; x=
	1794179952; bh=1VSy8o5Dn+pI/UKZfUkTqR0/8hKFWgl2+Kt32XOIdrk=; b=V
	JNExG9HX3XvMGitTgWrDJEHwt4/nyA/2Lk1KzB15DQ7oCjuTkBE0BrmlTfR3jaQV
	9zLQGULhvKm0AxRWmmT4qP99l9DbrJvEicn8y6UasxxHZzJl8p9YMv/lm2nDvVf5
	XfsSYCrJLuXbMH9bYQWX6x6FXudL0fI8IZhm8Rq9RZkh6XqhIYZcLVGisAdqOx/Q
	Rx8lQx0Tbw+vF9j1Hb5sLS/aR+PEYIGAzh3Hc7W11RxmGRabijF2UA0r8b2XZp8p
	xZHpjQKjKcxOJmDSbLmuJKyrWqJgKYm1f+CV7Bpp35+GpI8X0ymra+YMh1R3h9xh
	zaoqnWbCVvJKCIrN+GTAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093552; x=1794179952; bh=1
	VSy8o5Dn+pI/UKZfUkTqR0/8hKFWgl2+Kt32XOIdrk=; b=Q5VP5tqh/5KUfz5Pu
	ZX6DhgpGRKSn1dScPlQA768DrCBf9v85GqIXGM6u2t+wejGbblwt22hPKryp+9Db
	ar+24ZnP/3kw8uDa1R/W6gPCYYzKA0oaagsTe5DzNQ25rePxqYKUgveicIQx7Yul
	OaMp3Ts+xt3lkQOeiLrI1Q401FT6ntKSXr7n9q1azrtomQFusC7IkCwVlN2oaL7S
	l5CETHwjf0rkFt30y3MXWE2nnog5kRUzYUBTDF9WhpskyJbrDnwpSZmT0Ee3hw6f
	JYitLUFc2GLr32r2Nodk6PPgu2fFJuEHKBQ0OGC9ypEI1kKNwNwCP5bLQ6wePuhd
	fri4w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093552; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:A3E6OeZr17RJx3Nfwr78Iem0dMkEQ9NixpD7oqqe0vD0a6J
	GwuxzzPp5zOJJ9rPZVFuFCqvGA2CinGJMmOlF0jokrzkA5xjvCv4QJJA//ur3emz
	PZQTOFoYPWnoaY3v2vjdhjuj3JmW0+bCngRSIH7hVeEWzCxs8KhphFUZCoFd9wtT
	v1m/DULBjEMo0Lc8M4HamSClG6NH6s368uIoI9oEFzbtzXvdMpBliND9YOwqmnjb
	dV1Czz0hPHNrOmQtlV9eSLMIJtTjxI7foKYbkbM4c42Ogpf88jtnqVdwuivZaxGk
	+r/YF+03cpliD6XUH8xxS4a5Tbf/HbJWlzgJ6Kw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Fro+l7mtZRJjxGncWKSevGdY3faOg/HCa/YfVxnnTv4=:Pk7OIS0B3hPMNB00edFoPU4jAiuWNSU/USC7OJ21ktA=;
X-ME-Sender: <xms:77HvakOfh7Wao71liP7f_AcslJCBL-Dq0CNzoItdUTAV-V-rVpmVhQ>
    <xme:77Hvag-hLOiFIOy9V3z8vwNWMZ9nkAKuukXTwbyQwV8IQ54_-pfnvmc9XRUFigTFi
    dPZxJAbKTyWFXYwWik2DgQrEeg8nhuU21FgJKpLAd01B-B_ftG4ze-m>
X-ME-Received: <xmr:77Hvao4D0aMWRdpEtEULC58EE-6w4muHQI5qw2Yrzdy25eHSS6_PyzVTvrfM27qNMBVGJJ8>
X-ME-Proxy-Cause: dmFkZTG4OKBtoL8ZCR/RILZ9HVIYsiyedYNwSoMK0fs3pjy1KoVI5QKNGkIR+qu2UJo0gZ
    HzA+zmsNEg69ZzY6X0FWa+zLkMFDxwNIsl9Ph4OTn+01QWTkR/Jo/5qW1rJ9nmoNurDIue
    QT+8hE5vQWriKMP4z24vPZOqUxClR8mW3s+b3sdgoVw/1pbgx+Rgr+CuyWm0Rw7VFfh3wm
    Ff/aXmVih5IN3xK3FyGhWQgzJM3srbjX1XKkRojmxjm98IEvfarefkGccvPNsccoj0M2Fw
    IAKskIg7qpYthFMz478vaSMrfqTxTgpU5kYVf4IOXxXEkR36tX+BOJ2DsnIOetXZBNvFd4
    KHFmrp+i06W/69Z3F6erUdDTvF60dqixbwUbMl5pQ4lHFJ2brEg2xF4ONa4tI6VgsXGdkl
    GhnkdOtDd9mHPKwjSGajy19H7q2N0RMKDaT6dloVUzywt+QQnzPB9Qvieuh7N4v1lumEMU
    MIQktjUeyO25kDYO0qI1R2ha6jLNwaEcJWyMGZHJzJq/KAaCFkEHYgCXdRBN+NGtQp15Op
    8cbtw3sfr1B5Dmlp9/swk38ntdAXjTP8yFQW1pE1wEJWU/BtycmcotmHvZFFcfjETmiR9r
    x2Vlp6VRZ2CINCHnZ7EfDFqTQyUDn4uIDAj3wHYmGFY97OOCBQ5x0Jo2sliQ
X-ME-Proxy: <xmx:77Hvan1g8hsv1bNxVam-i6j1tRyMHfEWnA4sMXlzHdSFoVre4esTMw>
    <xmx:8LHvavDg5euBHkXlsrZE7n3y1JEhXDedgRq0q-qAz4uFj_l-icsDIQ>
    <xmx:8LHvap1R0BMau5IZuSmWYOEU8L4Fqm92aJLdjG3PmJfJL9NwNGrwhw>
    <xmx:8LHvapuAVtfnCkY3DS6ILQDzx4zkxE8Ia3lRDeKQE7JxrnfknB5AHw>
    <xmx:8LHvahtfpFvj7FtbADA_1UU9YnvXPDWUO16xKiqvl5yxrIYwvKdiM81s>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:19:11 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.18.y 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Sat,  7 Nov 2026 18:17:19 -0500
Message-ID: <20261107231852.1870314-3-oss@fourdim.xyz>
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

commit a518b9a9ef6ee3b18ecdf6ba5360c608aaf969e9 upstream.

Adjusted context as stable does not have the lockdep_assert_held()
call and the __must_hold() context analysis annotations.

An outgoing channel waits in BT_CONNECT until security
and the feature mask exchange complete, and only then
sends its connection request. A peer can answer it
before that with a connection response matching our
source CID. The channel then moves to BT_CONFIG,
completes configuration and becomes connected before
security has completed. If security then fails,
l2cap_security_cfm() leaves the connected channel
alone, so it stays up on a link that did not reach
the required security level.

A connection response with a zero source CID is
matched by identifier. Another channel can hold the
same identifier for a response it still has to send,
so the lookup can pick the wrong channel.

Only accept a connection response while our request
is outstanding, and only look at such channels when
matching by identifier.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 52ff1b8785d7..22bac1222fab 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -161,6 +161,28 @@ static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn,
 	return NULL;
 }
 
+/* Our connection request has been sent and is still outstanding */
+static bool l2cap_chan_connect_pending(struct l2cap_chan *chan)
+{
+	return chan->state == BT_CONNECT &&
+	       test_bit(CONF_CONNECT_PEND, &chan->conf_state);
+}
+
+/* Other channels may hold the same ident for a response they still have
+ * to send, so only look at channels waiting for a connection response.
+ */
+static struct l2cap_chan *__l2cap_get_connect_chan_by_ident(struct l2cap_conn *conn,
+							    u8 ident)
+{
+	struct l2cap_chan *c;
+
+	list_for_each_entry(c, &conn->chan_l, list) {
+		if (c->ident == ident && l2cap_chan_connect_pending(c))
+			return c;
+	}
+	return NULL;
+}
+
 static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src,
 						      u8 src_type)
 {
@@ -4297,7 +4319,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		if (!chan)
 			return -EBADSLT;
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan)
 			return -EBADSLT;
 	}
@@ -4310,8 +4332,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
-	/* Ignore a late response after the channel has left BT_CONNECT. */
-	if (chan->state != BT_CONNECT)
+	/* Only accept a response to a connection request we sent and that
+	 * is still outstanding. A channel waiting in BT_CONNECT for security
+	 * or the feature mask has not sent one yet.
+	 */
+	if (!l2cap_chan_connect_pending(chan))
 		goto done;
 
 	switch (result) {
-- 
2.56.0

