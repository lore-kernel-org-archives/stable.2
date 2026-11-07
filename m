Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093598;
	b=scdRPfklhHuHlDJxl007+VE6jJnJ3Qv+KrWvrlOgHCSvYVKCHaXNKJHFqIXJ0U3godB0
	 LRPsTHUHyjaDF0Rl6TbMf5dX1D2PKIlkaTU8s3eQTRfSKecI/cgteRwGMo5BTsXxrc7j6
	 lRNOcQsnEGw0UGKg9/fpMxjGVr0pYA04PRTvO6DTiJYKZkW3cvGwXwv1nkKfLJDoTBOQF
	 KGeM57xKvzyIM51u90pv7hNtt5FhnyYq+QgDFhjPH+DSKSqFlM5WVAkuh4mPGpVSxsGre
	 3kBn2Sz+B8bDSfsZLDNztmfUuLqoS5sfb5wzH0cdhnHiyPR6NiP0tBZq1tkyxASTntA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093598;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=6zG30gWR6ekS6e4/ZjH/kEVl0yF14OdLK/7s5u2S5JM=;
	b=LD59a7BdsM1/mY6QmnD5R4FwKvl/efubX6HAuTQUP1d7NlBQbH26jL31kiFKCd9OYRON
	 A/rHhMRdJJqWiDKiGwWWlh/OQ9Es+GQ3MERGzArBb+Sp62bdAWG/WQ6cObXYaJYes6NfE
	 EnkcNYVTrmksusVdI0h8UAsqborVrXN8v+JXLpRcuL/70gAoQxvGi/mlPMuk97tbI1CX4
	 515DS/KmsDkPxdCv30gTVyBNXuluAtSQSPTsQq1KE8AelHuWBjkCmhQxeJsozJXuxQ1ug
	 cK1ApBNywUNeMQuEAVYZ9hkPjYLIfmG8IhixjKxqyqvu5kQ3hsrXwCC/byjy6B2RIiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=MnYA8sXF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=F2eAfZTd;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424E606A337
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4424E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=MnYA8sXF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=F2eAfZTd
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D0B97A00B9
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:19:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 07 Nov 2026 18:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093597; x=
	1794179997; bh=6zG30gWR6ekS6e4/ZjH/kEVl0yF14OdLK/7s5u2S5JM=; b=M
	nYA8sXFD8vPKSBJtXc0cM787bv0C9kaf5AAphOMDSsocePQDw2wqJMYuRRcxI6AZ
	Z7C+eqBbgqYVkyrcbtgYnERgFHjITX+yayan8+6heU8IC0asY14dfhGFdILkZPaC
	r9nhxjxe/Gar8+aLE9e8N9zay+dEnJI+OuhJLDwtT2wuFeR7wEB9a8t1FRtAp1sG
	BzZSqWH90sVDPItJYjaVISe1/V5wcDa7g9WryEy/1m6AsjJoK0jhAfZ3wf6iMK1p
	4keUwzsAHdk0J9cLE6VLV0L3OUmwRyRS8l/pE7VTyAFt5f8UAAppprsJ2DzF946Z
	/rMRQBTKtdMdMJMp4J5lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093597; x=1794179997; bh=6
	zG30gWR6ekS6e4/ZjH/kEVl0yF14OdLK/7s5u2S5JM=; b=F2eAfZTdGIGUc4UDI
	fctQOJIWI2ZtSVMUMROAG9gik4q12XT5NwRKPEOLWqL5GmXBH3du65+vJteyxsJJ
	MJKyim6BgT8JDGcOu5XMH0xDhd0CuGcI+zpMb7yHZLCj2w8eq9I4a6VUd32Fitkx
	Kq0yIA+sDolOWyA7YhwC4ogiK9oj+20Z1G4XOpPsxGiUocnAoGRdn9TTXZAzORMB
	Vim49N2Kh8YXmmairfJ5BKGGTnZLjlXNav5pE0r8NZIX32aBYVi41OXXJHU5yDIL
	Tis88pjrqbqGdNw1kWvwH5ej+OvIGf0xndaIEqqKfQ872DaNwQ/akL8xpXGYofw3
	oEVfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093597; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lEHDJ2i0LDeR2xg8dTMY1sjJSgPXZ3CI/kIcL6c2iJuowl2
	UkbBwsV7jT60Ztn47QNLdcBk+jj3shwXkgAJWcI991wFT5UvNWfCPNV/KxCRmHIC
	jeAQ5mLQfO9fb4ErG1kuosOiFUYZoN9POmq8oiTKoGr/mirpbWbG6HGa/h037LEK
	ejNGevV6F7SBpOFJJIWzcI6zmEpWxk2gMrF5oiEWXNkl1kl5YJXBwphXCBfgs2iF
	8QjUM31FcqP14PMwVhf/+oE8Sh8aXEr1p2a+Yg+DFZgbnCLZZTKE8skOLwahGznW
	TJqrVItFj5qhH8CLbgbH6TSje3dG3RB4sfAPQNQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:gugTHRkkz3DixShb7vGnKrVEdoE7GvyDoUolHBi7sf4=:RawdAA8mTBnsgOJjX8cXohwvUroNJxwx3iwlv6CfhvY=;
X-ME-Sender: <xms:HbLvavCjfbNfVwD9hynHmWp2Fl8FsyuZUEP4joO1jKaWcLHG0kp78w>
    <xme:HbLvargMnGeGj3M7QoN-Q7GXxzQB69bCEiR0vKnnCsZm7iluh1CnzLW0RRJvIDiBY
    JeaSZf5mlILnFvJP4APclTuJOQiAi4u1NxXrdBxdDfrNpNilb91oCZ9>
X-ME-Received: <xmr:HbLvaoOwx86nbUmCcleKz5Gzru6jeioXigTp5cFKq6ucb5v_HBklvO7eIj8T5-NnCrheH9s>
X-ME-Proxy-Cause: dmFkZTG4OKBtoL8ZCR/RILZ9HVIYsiyedYNwSoMK0fs3pjy1KoVI5QKNGkIR+qu2UJo0gZ
    HzA+zmsNEg69ZzY6X0FWa+zLkMFDxwNIsl9Ph4OTn+01QWTkR/Jo/5qW1rJ9nmoNurDIue
    QT+8hE5vQWriKMP4z24vPZOqUxClR8mW3s+b3sdgoVw/1pbgx+Rgr+CuyWm0Rw7VFfh3wm
    Ff/aXmVih5IN3xK3FyGhWQgzJM3srbjX1XKkRojmxjm98IEvfarefkGccvPNsccoj0M2Fw
    IAKskIg7qpYthFMz478vaSMrfqTxTgpU5kYVf4IOXxXEkR36tX+BOJ2DsnIOetXZBNvFiW
    wtn+OiTgWZSGSy4O3o8Bb6YphdxjT3uNdhaYBf4M9CDF6F5J/ZREscI3ehpJ1EKjYeCjgu
    CLfs6crF1pCGlLmM3thD1100n+/sQBkPOG1GzeLrloSrKIJ9t2J/M3Evf/fLH00oVrHcHS
    7PoibWrIatxIQsTix6mvoeD3eYqBHgGSlrvBBc+1W2KaVIkpQAkCX3iTnlpzg+ob7DsFkG
    BU8ALTF7WtgWlntMK454GDgU1MIOHazH543MgV7oaiWDp3xNLsUdqkEgJ2658REGI3BjEI
    yBR7+YtyAiL4Vf5CEeOCT6FhLX/Mp0/kqLcle0oiLEM3HFyMor7th2Sc/wvw
X-ME-Proxy: <xmx:HbLvas4iOu6DTpCiTn6LZqJOQnrXSPTrPQWzvYTFBzEwNDMTw2H1lA>
    <xmx:HbLvam1jtE15Js2VaLQtgd4Dqq4Lhg9aTjgslibier85yDtn6X5iLA>
    <xmx:HbLvatYuNvP5WKbY_Of11R88JKI8eHPMtv4TFbfJGhRW8KlZvedqyA>
    <xmx:HbLvauDnAtnCDuOj4K8ONH-A6XgSOEJthDDNJCpgmIe_iyvJfVB-MA>
    <xmx:HbLvanhVS5DgTXHaclclRMTcn65Z-vfK4Gnfdz0slx6Y-ySDeHNGmSFv>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:19:57 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.12.y 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Sat,  7 Nov 2026 18:19:13 -0500
Message-ID: <20261107231941.1871942-3-oss@fourdim.xyz>
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
index fa7124c32d91..2f107c036dd4 100644
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
@@ -4265,7 +4287,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		if (!chan)
 			return -EBADSLT;
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan)
 			return -EBADSLT;
 	}
@@ -4278,8 +4300,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

