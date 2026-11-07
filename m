Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093653;
	b=qeq+8eaknFVYiBMvted3rcN1uf/iLdXLcbqtmDt4MCaktnlsSNWb0hd+aBHbezHJDjYf
	 9H3N9Gal43QXYtTs55ski2TkL1vCqM88CzLVip5X2MI3Kwkl+ciJzlWoxjw5i3VteQ6zK
	 Q9VidbLQ3V1O+X1vwhj7In1pgYqL+fYPPD23o1rLSZkctBieO7Y29oceAj8DA28d3h/As
	 4fCxEJtbPRvVOafoTXOk0cw1+XRLz6EO+k4jYKyTzF3njs67rGrn7IAH/JWm10BWy/mru
	 E7KO/fc8o8+CmW5CDB87y25eKFfX7yqqIUFqGAwauu47hS3fVczPtUjh1sYlXL6wiGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093653;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=LVt1C2QJKj2WzS4MqLlPb2PiDiPMX9NBTMu3cyLV5GU=;
	b=jKFweZIdiBsLzL0cdyj8uIfBggTqIf0fudOWv/xpa8NRKDbmWg7u71yDNX8/aptgCYay
	 ipdvjaYcxCZcA4Fd5rbeufVfjf4hmB/XZbloCP4/tYESyga52dnv7XePKSpwHev/xxxxD
	 OAMIQaTZ6OG/eyrs3s/t3pJ9pWgETpaP56TpfETRV9x0Lq+tXu+r3J5DIlKI9ZF6X80fx
	 f0jerEotWy6/IFRcKsZU0SUJILoofdk7Q+ccD2Eej3GaOZbJOi+IkNxizP9V1bb8c1DSz
	 RMbrfAW7B3Gz4F6jlubMzaAFPclUmtT0ClBxpSlWJVmfToMJZgep8EL5qva0uBiiNZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=FuKqvhOq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zZRyu5vE;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D77606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27D77606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=FuKqvhOq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zZRyu5vE
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A7F147A00B8
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:20:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 07 Nov 2026 18:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093652; x=
	1794180052; bh=LVt1C2QJKj2WzS4MqLlPb2PiDiPMX9NBTMu3cyLV5GU=; b=F
	uKqvhOqy9V531OkmYxrtngyMajAkOIIVIYRluMUPtVvI7X+rebmZ4PGKXCRVql3R
	wjoPQ+w0KiWsDnSZh6tgsj6uC6KQtoLjh0i/unwud9yD3umV6snmyYdKAz9iFwfm
	MAqL+uSGTpIUAzPD+/T+s48LbYpulAZk7gj1bp5v5E+3TOjIg9+EhdDNZj+PJxWs
	tHdd3MzFNRt+B9PHwzep7CCsR26VTdG80YKBtGkvWRT7rudvGGYo/REMmUQHNmIk
	XqG1hXet6/IQSHjz3fr03ejex+p3SOXbX/5vcYkzP0+XrhhrXZ5oyeNa8C4FskvD
	JcYxiGb0djOPoYZSvZBCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093652; x=1794180052; bh=L
	Vt1C2QJKj2WzS4MqLlPb2PiDiPMX9NBTMu3cyLV5GU=; b=zZRyu5vEJZNDCQwhD
	pgTJxM/XbIX6DxI3CKl0kVD3YfrdmA2PkPc/sjC+1JTlT/zSFI2f1L9fhR00Ds0y
	sWD0ryS0qFBrlHv5sY3rUhUwB1/6nehAYECvZikHvebj2BxTMdVTRb2KHpdJ43as
	g7++upL3V4hpbTKNcy8pc8Mu3cSMAsdFvjcZ70Srl4JDR1kfEQYmrH9iGHd92zKC
	OpsV82gsOt6cc8a4kEt08sFeU1w8RK44McklYnZ1XSGJg+2NhQYjqXvFWKJ2hugX
	Qt4mFi0qhmbKHlA9l9ikptVFQuV7ZOAT4o9f4NQ+dPm2TaZnGGFNYhlGzd9kxIaK
	K7atg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093652; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ilUAhJD/LSZpE2E9gmM/ZvUV9Aj6s8lZZCbZdVfaqtLa2fE
	Va3PFRwJEoYrnCRkWe8seXFwnCdZ02rIOaR7a7k3Mi8dAH73pRmHG903Aufv4pRS
	ar+ekV8QLYrlPd/a2cDLaRmZTPBHefbUCE9v17cXXbgFVjRV2JvbqFdVYRjgbgmf
	UBv5hJCcsdPyG97AT8S/KOY54l9XFuuOZFCNUu+djaKKT4UgohH9JgW3G0J6XDCI
	SeOPecZKX7eSY0sZoAUE2+teAWoaY8FSlZd+jgZ1NwTzUOVpgfyIqbJv4A1TE0Eq
	V9U+7ffSxdvaAGFyF6gFuTIg70etdpPo8W82ukg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7aRhTwfLQL8Bk9qrr+o3mO72eUNTnygKU+CgmAEj+Ek=:wQQMtWnu5CmOiq1Nv0hfRXVGKvC6HlInJ1pVrwVPx2I=;
X-ME-Sender: <xms:VLLvah25tZBR77eyJ6tOfRCLeD05qtQrqDWDZw9ScQvFCOydmzX5_Q>
    <xme:VLLvauF-_4YWaz3ztzDf34RkI8UIDDYuvILmqKOHEMTBjonJXmKFOqQdsG8PyXtTj
    XiF59bOLMRVeXNT8HALQZiPWslRg9LJ1XV3pdp4hF-zdNTZoVqdb7ls>
X-ME-Received: <xmr:VLLvavghfFAcvdwtC660bUgt6tlkNOFL2AdrP3FyWLzJUWyMAeDp0yDGaxzA2JZD2Yksdms>
X-ME-Proxy-Cause: dmFkZTEIZBGCpisFY+fdhMhQMR/CwWUComkm9G8pkzgx+4rdsjDawZ1p/lM4mekr6Jrfa9
    t9lCBaxA62uSScJCDTVJZCvxUjTT8lXgI6y1ytbjQFdUJAQqlREN+nI/dOsRSO/gkOdRyc
    pC8LDxn6x3PlPwNH8xvIt2eqfa5x/4kvAkT6Lfkd9YAUm//zW+y5QQzyOpHdANNZLZMR68
    JqeYhLI84sK9usprfwwmkKl6Bsmrd+K1rmmi20p4W43h20l04EoN6alO8A20N0x3h2tOrR
    Hs+B6t0zXHZI5+J2tOJigPtsZ6jVQ/WVLTNyOGH6CZRUTfmKqjC10aJjkjpnPysWnz36h4
    mknI4JhbFb78mQQX4qmXb3bfzwa088PbM6pwK4qBySXW0fV7Jws1YnQMHFBPEZZFYpdGNs
    o087XwIBtnDITN6bo0qTML+krnXP5gySeX/xNh3xN4RTszhccGgkE3+IV0SQ2smOtIb+Z1
    0+skDzHgGRkt1bAZO8XZhrhYx3cw4C2rkNmqUEsQkvXpKQyxS5LwnrvRq1Y6IYEk4oowuT
    yDaJaqollrttz58LoQuUlK0YZSRrwQVe/rFPO2b4tqkMCZWwmoBU1R5NpvlgiFXFWSQgVH
    2lvjuf3wZdfzdBBDiKjrYZSrnbphFDSdfVGcckUMXjw2FS8W+/BHf8iIupnA
X-ME-Proxy: <xmx:VLLvap-P2VOAcBLVOI-CnZjB-TfVDjFWjAKKKJekhbppg5M_eJAcWw>
    <xmx:VLLvamp-BV0BYduk2k4dD2lbAmc4bd-IcEDl_NrQh-4-kpSoACW4UA>
    <xmx:VLLvao_6OZ5VYfM4zTbyMo2rqjGbBQlzcK61_hJX-R0-q9nCqVMCyg>
    <xmx:VLLvaqXbNE-AUCuzzMTBD1Hr0TTmb6Pt7qiG5co1xtc5cb6zW32XXA>
    <xmx:VLLvalWUmoFyRZyYqlOLo2Ue2IV6uo7zuC3fBZ14Bli_UC74kgFhpzYe>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:20:52 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6.y 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Sat,  7 Nov 2026 18:19:59 -0500
Message-ID: <20261107232033.1872805-3-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107232033.1872805-1-oss@fourdim.xyz>
References: <20261107053519-failed-6.6-6320736af7dc@kernel.org>
 <20261107232033.1872805-1-oss@fourdim.xyz>
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
index bb0b174462e0..24e72a40e61a 100644
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
@@ -4248,7 +4270,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		if (!chan)
 			return -EBADSLT;
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan)
 			return -EBADSLT;
 	}
@@ -4261,8 +4283,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

