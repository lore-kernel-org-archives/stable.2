Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434892;
	b=Bt2455XVScmygNJWmLxYC3jsJuZJ1lFqQSTMLSTUm82RJeksLpQbQx12DEq9Ru7LVdS4
	 OhGpCM/RRhIWwL9+zCx2PT+Z0aOLff3sufogGF/4foYmyO8oM44pXCENfmoHCmX38CLHm
	 pcnHds703+nDWXFflykIS5tE98iNIiPEo77YeU5H3UePlHRQMFJ2mXsLuQg9htHDaj/Oa
	 99zH1ObDsambKiUWGCv66WGedgVA2ZkmiFeseTYxQhaNLB4d45PrzfyvqW9hCG8l5/GBj
	 T28q+MKw0cwfIKHeSwgMmQ7Jhr4bKM3bCivdh8HbkUDlVGhYFtZe6yR1uHU/ftgVQhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434892;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=XD0piRZJDpfcTEsXCOawd8yZ3bWoJl9tPaV7fQHz4jQ=;
	b=12dll/QWKDZRdsxaNwLLU4PgaACempe+aH8Uo6kezxleUtGvdJetgIlTOmdqGT7aoaar
	 uERqkq2ISUJ7S/eZEeJsK9vYfeQiwysVldgD9aDgM5zqnjOUlGWYScyOKKARDuTvD4zuG
	 wegGMmVIbYdpBRzovqd1Sc2NKBnT0GcawUSu2pM6oXUpFxcZNW9HXfGdh5Jfxq0rgJmzq
	 ojDqtL6I8Enuco786kQjpc9TnW67SeEx7cHAdleQVG+KTmuOtxnsBR5SHNRWaFNkIx1zP
	 QRzkw/sqODDDsb0ieEZzulILfggh9+YMWdRxFzB0YwmGBWk2KMCX7nFbToUu4No6ZQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=U4Uwc0eP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=327cWQAb;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F92606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06F92606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=U4Uwc0eP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=327cWQAb
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 494A37A01C4
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:08:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 17:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794434891; x=
	1794521291; bh=XD0piRZJDpfcTEsXCOawd8yZ3bWoJl9tPaV7fQHz4jQ=; b=U
	4Uwc0ePqbhT99lenCCLOeZ/A4L/socaQkclJhYiigZ2jgErjy6KcWa/NA+FFVyRr
	kvUtml94fYq7WNgjflj9glcTVqHej4W+Iq6n2LyYzE7MQWRIE0chT6QM9tK9aA1s
	AyTXlQvaM4EoUQWtuqIyP6aANJ8eEESj52I2/taoXgUBkeXJXWyKR+J17oJ6km8c
	TarVwm74IQlEauBbNjPWw+D46R87A02yqz5gaC27snZPk4RPFnUuz6IJJM2UwjOk
	YKaZmZFNPX7FuY4XDyq9O8aD+ebeIdZMbmxvdvS5xzceuLUgU+m0Nol/urB6lo66
	QVdRahHGHB4C/HHi2bRwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794434891; x=1794521291; bh=X
	D0piRZJDpfcTEsXCOawd8yZ3bWoJl9tPaV7fQHz4jQ=; b=327cWQAbiEvGqfdKH
	9c+OnNhlOUdGDmqxA7UpaWK9zi/V07lt/IAXBGnOI/akH7HBRG4/b1jITaVv0sPv
	LEjKS1SU4zytGcswPqp/kuexDd7pGBBLlJuQhJxwiRah9rId04m2Z2H0xOviHnEQ
	fvx1/UdQfhNlbW9zDCKmXw8tDFAq7GF68wFpfX6Pec+/MTOGz9J3LDzopQY74+WE
	hcRaDlLrUafdIfrD08DtUNCV+RRKcRnF/KINDod5EIASeG/pckGZUNn8UFzF8nTn
	5MdTfZzBuPa7zCxRvY4q6aDy8M7wPxsFTL6qXcYpo64TZTteftxLp16sRtUR97F/
	ekJEg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794434891; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ApI/vGDb9XE311bbdxkuQaPcUpk9gItzy5c7cCklHPdakzH
	bCu+yAO4hwl4TjM641dUvd7+dyTfaGQL6UF8xLahfXDoR+hMi0Ks9Vr2kN0PQDuF
	VMIDcGrQ8SBFduRXTC9FXbqja1uBbj4VLbmlYHAPcXO1ogKUO3zYPjtuQ28zL1EU
	RnnFXCHYKzhhMQOVU8EAmk1Sekm4o70/Zf87YT+L8c0+TuPJz3jLSjflXdK1F0pY
	EOEQnBPpA4a8eq9H8gZkNVu2JgYeKey9I3l0Kj4GjaU1PaIcKIiJKcNZfHslZIR5
	GuCUyP9pf6NhrVcUWf+UrgICILVAzEwq4YNjZEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Ku4Rs1neDARo6Hid3DxPnKc880lD/+CCyuwJBKMH65U=:iKo/0jJSNPKmFt1Z6B2i01fihiB/Zw8LeEmemX2dwh4=;
X-ME-Sender: <xms:S-f0ahJv9VrKWSgkyNOMelzKH0OlOh2mwu0FkgPonJwi7uT-MicBug>
    <xme:S-f0ajIWdhU_c5K6TzN-BsoeSskoYkb1SbAmY-NNXywsEV1pfWiue7GAIYeE-QBc9
    cDSc2fWj3der7od7C3GGKVqghQZku_Dy0ThXpNSuq_ZriI2ope7k4-E>
X-ME-Received: <xmr:S-f0anVVmUEcCHvVvrQvlKAbTLo8wB8XIaWDn9d0JJzfmnE69q0Jdy91vd9oc6i7QVT58RI>
X-ME-Proxy-Cause: dmFkZTEijvUOy5pjvmxPmfqPx9Fpjt4e0UrFH6WaW7CRlfYuyZxNmM3WEUBk/qgMqrN5gM
    vOynFiAr2CIW4EgWmJRvIWFajStHGruHWY92Z5tdci9MXse4PJoXvI0K6OfsNHCXn6NYxm
    HLRCAty6RiTwsPpgyT2kmi5AiAujM8P5DJuZVhttuHLQLUbgnO7e0DnoLIvSPPd1xcsIZL
    9RTgX58CUMbZpVlBhq8D3962Js+dGOJ5I7zyNqmj/xGSBxS6HxAfdI4mEpyWvxzn01YDqa
    nk5DoeuAwLh8dlJXs0Ea5i8Lqv5phtKFwN+371XAa3Zkb4GYYZ5NUrYrUNJYfAAAC9gpNi
    uoK/Qm74QMz/YZXc9vk86XKonqq0Hg4I1pyGXfkE41KabeO9h1X9JCmaHq+kTL8tiaj3d8
    hmzGFruBQ1jGdVB9QcB52zd8vyRErmF+GXT1oBh1nTlCYMaW44gpOh0BBO8/q2V7ulDEwW
    ZLx8CFtggnZmOHVBmeRhlWfDOv9Fm1RTJWR/dQnsPalguOd4Zr5DpQB2Duu+5IhfYnEY2f
    wdH1F3XHh+IsUzm0XpkGTuBoJIsb2FUQG8OOuAT340qadGgaXtcygvaqQcGo4JiflWEjYj
    SCPnrJDcczWbOpAQRL87YHUsZJlRVvz5Dq9Z3r7aw6Pp1Etx1JhrR0ZoBE9Q
X-ME-Proxy: <xmx:S-f0atjJxhaN6hjtPsG3ITz5cdPUZFrxz5zdh4t2qNPSHD4TmB5M5g>
    <xmx:S-f0aq9-4pgvDrmnb2fhTnbXoH9aBA5HH02sjVOxSjLReh3R2hGBDw>
    <xmx:S-f0avAVLb_-fD-38v8lXKPnMZZKqjzgkMZdNYJlcetNJlVKU_mfqQ>
    <xmx:S-f0avKpvBzSrWnFnQ7WryqrjuP2lMJYSklenONpyE01TaiqHPCXWg>
    <xmx:S-f0ano7AK811TDj5yaYczb20AqAVVJU8Y7KooTyXk2EiI3FZ6wQbiqx>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 17:08:10 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y v4 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Wed, 11 Nov 2026 17:07:12 -0500
Message-ID: <20261111220745.3075256-3-oss@fourdim.xyz>
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

commit a518b9a9ef6ee3b18ecdf6ba5360c608aaf969e9 upstream.

Adjusted context as stable does not have the lockdep_assert_held()
call and the __must_hold() context analysis annotations, and
l2cap_connect_create_rsp() still holds conn->chan_lock and returns
through the unlock label when the channel lookup fails.

Stable still has AMP support, which upstream removed in
commit e7b02296fb40 ("Bluetooth: Remove BT_HS"). The response to an
L2CAP_CREATE_CHAN_REQ is also handled by l2cap_connect_create_rsp(),
so set CONF_CONNECT_PEND in l2cap_send_create_chan_req() as
l2cap_send_conn_req() does. Otherwise that response is dropped and an
outgoing AMP channel hangs in BT_CONNECT. This also makes
__l2cap_no_conn_pending() see the request as outstanding, so
l2cap_do_start(), l2cap_conn_start() and l2cap_security_cfm() leave
the channel alone until it is answered, as they already do for a
pending connection request.

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
v4: Set CONF_CONNECT_PEND in l2cap_send_create_chan_req(), so the
    response to an AMP Create Channel Request is not dropped.
    https://lore.kernel.org/stable/2026-11-11-1-daily-reply-0023-a0d5fd86605d193ae993@kernel.org/
v3: Drop the AMP and A2MP changes, which are not in a518b9a9ef6e.
    https://lore.kernel.org/stable/2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org/
v2: Pull the payload of an unsolicited A2MP Discover Response before
    returning from a2mp_discover_rsp().
    https://lore.kernel.org/stable/2026-11-08-1-daily-reply-0003-l2cap-a2mp-5-15@kernel.org/

 net/bluetooth/l2cap_core.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9a883e476684..75c2ab39be16 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -185,6 +185,28 @@ static struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn,
 	return c;
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
@@ -1329,6 +1351,8 @@ static void l2cap_send_create_chan_req(struct l2cap_chan *chan, u8 amp_id)
 
 	chan->ident = l2cap_get_ident(chan->conn);
 
+	set_bit(CONF_CONNECT_PEND, &chan->conf_state);
+
 	l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CREATE_CHAN_REQ,
 		       sizeof(req), &req);
 }
@@ -4426,7 +4450,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 			goto unlock;
 		}
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan) {
 			err = -EBADSLT;
 			goto unlock;
@@ -4443,8 +4467,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

