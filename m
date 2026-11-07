Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093685;
	b=z4NH8cxQxgiQKIlUVoAO8AC2LQnNVqkPxR7rqWuo6INZUPF3m68W+qjlHRK0IATW4hV3
	 5cqDuRjjR1MFn47ILH/YqgcVW6qqz0cwBFUdCHB0ufG7Izi17L80PZxwrlZhOqqIU+FG/
	 qJe76jjdsyWiCtTpK86UOOTIJxPM6zmu+EbNhSVfDp3x7PWyv7g+pYaARVq63zXYVCyUH
	 cHZqeVwAj3mUewKoN6ocPu+2wji59vDjl0FoXSZQzUNvDNx69dvk7vTlDSY2kuPmZU6jn
	 LtlC4Gx6wUbGv0aEqSUTz8i4XknYbyrm4onkA0Nzn8Dg+stC8NR0Wz/jqM+Lr3GWXIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093685;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=2xozq/Wgz9bXsYnqNWd4UWbaskGTuoqeKddM4mDdZ6o=;
	b=ZJsaU+vRT5T90nwx3ndxDziKlTxjr39KAQzkaGUN9s9NAlZaeo5WoxUzADO9u56g+yxE
	 wdvY0OolbRSApQduHNLWifppRrAIaVCFM+Lz+vzP6ymsHmWh1T9ulw1qen3lOXZNP3EqT
	 Mgf1yAVv3wY8873pu0psu8+84ZOO2WShoPN03ncxpZP8wZaWeGilFM/kBJ8a3176aGVpE
	 g33IZ3pndgT7DdwmFGPLyQXTHxrs+DYTdzM5QA2l/7tfUWJfUwxdGKA2DJ3sAPzk/otS4
	 vezZlJWTT270DE+jrVPEAH4bmmwLhsG8LXHTqaupXyTz1uByMUuEcj/0mX9saVJvjKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=w7elAVUQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CsSNpqQj;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFCE3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=w7elAVUQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CsSNpqQj
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 076351D00113
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:21:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 07 Nov 2026 18:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093683; x=
	1794180083; bh=2xozq/Wgz9bXsYnqNWd4UWbaskGTuoqeKddM4mDdZ6o=; b=w
	7elAVUQEWNplBMgWiI3KECJ/at1oghiPiruyO7XIpnaOUJ2crougMHfc4kyMqyTi
	MOJXJn9CPEvr3ISGZBurocBF1wn8fcv7phlYHnJFlS0lP8soHfklKwFY3aOw5QWH
	ic2Y/qDob99k1nwofHy7SsUvXtGfNftu5/25mHYSlYTKXA72SysT5u0VzF8FS5jc
	FN4Hwy/Ro7CORHEmsoODJnaaO8GXtVVRXPcXXFJXKmQpFb4R24ytbVIW4rGBpTRZ
	jm8I+dXdiEijF6xCh0wtUyS4gJGCX1q8W1XCw8e8lQnwHYT2NCaPHbdIufXkyd2w
	UUggYEgK/eHFQZkbKH14Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093683; x=1794180083; bh=2
	xozq/Wgz9bXsYnqNWd4UWbaskGTuoqeKddM4mDdZ6o=; b=CsSNpqQj5zbm0cZio
	NUIX+tiiLJ4QRC2ircPwF8Q8Zx4Kxsv9Zs0N6/bhVOVpnvvNk06uj2pyik60tGDy
	rFaOnDJtQjzrN4D14NbQqGu08OKQ46pTbEwzXglXPOaRDf9wX1w7jHlLTOBmVfWy
	m/3+1yEqcC5mt9b8ddfiAtJLBpgo/qJwbl8nOPBC43G89dFQO00Xx8TwMOW2TUbn
	zmVTnS88D8+OcqpdQNW2H9MBYsx5O4WpFXF9vaqbojx16/TktddvaVX/wsXqPX8E
	5u59RX/uLK9T/oBmdL5r8rqa7iM+e/8dlSNrsDTmWqqjW2zGVuROm5qiJ9EX/IvD
	Ge+Aw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093683; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BU0HoxZoCt/hG/ZvTCahcWIvUWeVLzslmUV0gPNV7xKHhWx
	WE+BxvChxe79UWwb5nPFTkjHR8S8o2YFTLc1YAHFruI7BO8TYZKBdcWn/XfXMoLi
	Zdpjzf4VeoabECHFRwUXWjEsexCpsHd15+1eilBD+awxQc9O040ZLkw7MHpr9/jo
	ffxeHFhDWi8h6qsB0dTRD3Ynp2B39FIaV9BD38z7DFnzzWwtCVgcSi7rQxv4reja
	oIcrGX0/AJVonshHFJtTWLBxlmKf7sSC5mpRrRqxsrkVvZI/V57ghMnLiQk1jm3T
	kD0NGWPtduq+Hpz4HwK4Y9x30JpHwmf1GMMgR2A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:oXtVoCSFSUiGMb9QKVK2qdGFSEM9S6YSu5jJfkMzVLI=:F6nCh3QETuypmoJHxxhFhkdmGwzUTuJMKgIU8OyArlI=;
X-ME-Sender: <xms:c7LvanOkDdLu7oV_2EQ2CVFLvaqweYsiSbAhD5Xj1vQ8j0q-0Vavbw>
    <xme:c7Lvan_2Jd6rl4aJkTFLD2xo1td-W8L7FgAjuJRpsPQyV6Suz-x6QhsLbqIThK21w
    Mz6n4D4cAwbm9GPTt9fHHjPsYMGfcI069HV1a8AGwtxP64E6JZNRuPN>
X-ME-Received: <xmr:c7Lvaj4E_USIKRioObWqiuF306EB6NXaJRurUpVTA2Kh5bmD3dPlD6GawNh7Ift-1T_SWyE>
X-ME-Proxy-Cause: dmFkZTGOv3FqnFkUYxYhEjFss0292GBiPoK5m0oQElxYsNAGNXx+yDnxmMW5ov4HsJXwv7
    ElU76guExe7ddZxiH3TFH4gw201C6KoHl1PFtucTFym/xbcQfkoATfzdD8QLhqbGlFJ/hV
    YXLiqYGu34pUXVywB+Dj9E4RTSgtAPLil4ciU0P1AeSXWk2/AU1os6cwlYo3H+0kocI/Wm
    ddOkH8cnHf4nrh+uYcGKVVyISJ9Ne+c+nO5VuMbcldNWVVlXyxcctb5lBb6MeMq2IZLBvr
    k/tvEesZ8U4VBBJWyK5M0+23P7gKVpFtcGWXuDb6iGVmb9j9aUadYqrMAHqq9XEjum8IHa
    NyAkA2284P85y7gAut5ef45FXBLiNKytJ1xdBJSFaSyHaODvKLrh5Ef6r7AcraR2Okr+zM
    pvStsOEbNsrKPNCEhVIDQOTPsX7UMLoT16Xrd/GxjlEjg5FjQFxaEXRP5bppxL4h8fUC7T
    A+0od90osS1OBiYThEoxMsYvbwiLY9yW3vhn1Kp8LNWhOQ3Xtqsbteiqp+qGtL78kq1LKl
    NZHzT+RN8XKhh33lJwe6QTgMnMNIHcHyZ8tiSqWuO1ubPLXKAAQYakujrv4Gby24/aXJTZ
    fncTN5GJQz3mh+Bi5Xx+2vAl0I0r1b5EwvU9h3I43UI7tbY83ucsppP6SqoA
X-ME-Proxy: <xmx:c7Lvam3LjIZdP2M2A7oLM8b5rw3WHzvph11LP4o_KvTsODuhr4nUAw>
    <xmx:c7LvaiAJ-cCqPmRVBdl5mcXFJkRR1hDpg21QjAyU097S-mNbNGnyDA>
    <xmx:c7Lvag2OU6-ubw4FK1KvR2Vf6f3TmYcTIbdztYlViT9ykD8HK-X56A>
    <xmx:c7Lvakvcw80YksPj1tumgWVBRbOUfgALXV-KYqfJX8kpLU0jiAGz4A>
    <xmx:c7LvaktJPlllu_y3C5X6n9AjvML1gisd7uX9kS2cV0H3xjQDhewrlYK1>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:21:23 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1.y 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Sat,  7 Nov 2026 18:20:54 -0500
Message-ID: <20261107232108.1873786-3-oss@fourdim.xyz>
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

commit a518b9a9ef6ee3b18ecdf6ba5360c608aaf969e9 upstream.

Adjusted context as stable does not have the lockdep_assert_held()
call and the __must_hold() context analysis annotations, and
l2cap_connect_create_rsp() still holds conn->chan_lock and returns
through the unlock label when the channel lookup fails.

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
index 1af89b301174..174f7a513f9d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -165,6 +165,28 @@ static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn,
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
@@ -4280,7 +4302,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 			goto unlock;
 		}
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan) {
 			err = -EBADSLT;
 			goto unlock;
@@ -4297,8 +4319,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

