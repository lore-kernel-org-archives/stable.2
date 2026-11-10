Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337911;
	b=4PfbPUj84PTYqA/WnE8aNCA3ATfDzhRokcxX7GgbmARGc1rIfOnq180ELHFv8SPz2zWc
	 jMn9v808vstmoMzZtH5K7m06F1Z/eJEtVufQeIgQTUzuVIGAvKeZ+G/pnTX412V/wWvyL
	 a7+i0FrtWPrrAW9vwiusXqJKyJC9HFSsw6WS5ju8xXkKsIVxWp6NDnRjhN0EcdzaBjdBX
	 TmvERcxL/1FLTqAJr5N89ZMlZAkbXloq6peXwzFbrrwGZ16ugllmevx97PHsftqIiJKqx
	 WcWNuKDIlpaeL3tNoyBnAyvdWlWwCLcCeto/pXwU/HNFWIs5twU8/7NENNwzttRPm8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337911;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=BjM4MX2avmFjX/FvHwxT8oOnLYSRDmA3yRNJsb34sqo=;
	b=ZWRTkeeSpseSzvV+Zj+IC0QThHCeTw4k2C+hOdKEyrj3wAwajTYcnC3sj1nhSAJzOHJN
	 91ZKM4tm5lDSRdZkulA1Sj0xrPjYRzq3hUuDcMPq2covcg/0fjdLaWAbrCVkK8vO3Paom
	 Vqw3Q8V121iEmsIw3M9UErJ2Oo8o6kcJQPH4UpE6oDxSGua09k2+VxYEb/gDRVnvbwiYw
	 LnOS4YS+Dv4RYP62eWdNxJEQgVmHOkGLO+7ZoblOIIEBBlCV27WCTnGWBCGLWz3ROLJiB
	 w9ZGQAzDoVzljKMIr9t7SCmxJIFdm7H8tvVJKoLePlFL0V+1o0zHMyz2tCYxH/eje/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=Uh3Diwv8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="il4/QlA2";
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCBA606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCCBA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=Uh3Diwv8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=il4/QlA2
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 11FFCEC0752
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 10 Nov 2026 14:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794337910; x=
	1794424310; bh=BjM4MX2avmFjX/FvHwxT8oOnLYSRDmA3yRNJsb34sqo=; b=U
	h3Diwv8WI9gwbNFMUReBig4NEz8JH0mm1JdTOMs/yl27f2W//Kv14C7xk0c3GPxt
	MmIn3bylbTksKpq/A62YcBHxcnNCP1wLUrNhLV9koNZJe0HWjy5/JArYAjyjjziL
	7uJII8o4JDWzDv9NE0YBWnLtmX41/8pND4zY7h85n+gpSZRcZQ86r8SokZD3XmhZ
	UjFRMleZaToRGO/i7tnS/Iw2IMznVW8UV0P7b4Tp1lwjUJSw4VaEJxF/ciN7/LHs
	CTvg0jt4GIcu/s55s63IxACmmNQQgVQCLAbPqHAkX9MYs55KnGjpfpLYa539866F
	M7pKvp7SxM8i1Udwn3fww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794337910; x=1794424310; bh=B
	jM4MX2avmFjX/FvHwxT8oOnLYSRDmA3yRNJsb34sqo=; b=il4/QlA2bwHxxyeUK
	mY3SZ9SUBrraM3iNOoEwRPsLtypH4dLgJLVGuxn4Z0Ymb3nj76/8LoG9vBycimb0
	EFGrqeVCe9kkf5So5yj+Wm5an7ff4G79s9FdHR9gsdul1Qaju4usQeS0GyIAACwJ
	dm3XzeB+erj8STP+NbqtbHgB8ah9a6+xJws1RHB2ixnM2nDs5W1g2ZV8Z52rgytT
	x3OTGOM97wXlVNXooX/qwpUkT1ku1cjxQS+BulIpjJORV79+JuerP+IDvy+4Dj72
	WtSqk5atHjsacBRTA+0j8cQYRyf2RsIrOz2R3ttCIPyr/MZ4bbi6UB2Tf3cFtHcb
	YJJ6w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794337910; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Dge9gzbq2b1P+v6E8mNWu6mXBETbK9I3IBAnMarR2N+WNPo
	6yBvBz5p08YP7ab96huPQ3GVJ/kAwqxyQv97Wkn6A8kgA5qzv+RlJsQMj+wJNTi0
	IdAn7S3Jy1+hgxty1BszTVfXWck+Joh2DYIbxnAvbxPqR73dI6+7D/ALUFFzkKhK
	1UDFPrXZgQn8mAwXxSIUZ4n8cL7zrL9LzRfAMPu7GYsFDBvWRozlmQYcZvrGGXPe
	yt+Rio2WLtR4agfHxRyIFm0vQu/UgIGEqzBYg/sK+v4QlR9r56dfZvYA4z1IwH0x
	eGEPr8hTTeBMlJ7MJbLnXN9bEbtU9uYbSY+cI7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Op7y+LCaOnnD5XNKFeh/f4Ed7IGl8rLtg/jt2OFui3I=:ZshcpWmSnr+kwXpiGviNZLhNe8S72g0WxTNur3+5c8I=;
X-ME-Sender: <xms:dmzzauGC-Oq2ojfBFFJh4IKSjxag2kKaKq0LPizSfYQo13bkHagvig>
    <xme:dmzzalV_Ze8qAxAbN4Wp4Y3gI4dY-wyn8U2ErCtP37y4NB2K1JJq8aOeDMV6kBW2x
    NLAwiL88jygmEf8kTEYFX4wdwDIx_ruwkfZHt03o6usunR3WCS4d28Y>
X-ME-Received: <xmr:dmzzalyLQmsb6vnvz7X2odYBJT_jyrmLkBclkfWGRreC4qLO0OgafK3R88_wzyqy6k8vmjA>
X-ME-Proxy-Cause: dmFkZTEu9BqDtNH88eLZ+S8C5IYoX51v3p1TQB7sMGS0s/AXW/6Mp7qcLhxEuxj8b2Llo8
    oqfr8kgEgX4zVOHIe/M/BkRQ0mQK4aGxEIm+bHuzUJSWgY9Zrmop5IyPeTyaBUPVGeJSiS
    2KGNnnNnVcE6rfy1uqT1FNPEZ8nAvP7YwqVYtiWGvdMfrHbU7aXfNPULbwHPQ/f0fB/XNj
    bjTPa9upP+sLpukeD+yylxx/nvf8cYMui4+rpu/NboVBopNZ1ww5JLLBP/O4AXCUwtOpN+
    q1ztUB4zc8rCPIyKVW6eM6PyqvVJtcWxMFuOpvRVm4s/weTlUTzJG4ae5yARKrvDHqckQz
    D0gl0kF5vfTD2XpO+5mvXVJRty/PCkby/IaSUfnBObo40kE76nmtox7dMSN4+v+9xIbvaO
    D/MKZHqtFoz2ZfuPrFyWvL3zSTBMjdnNOR4x8sCUDr7QbE36HZs1Au+D5kfkfTbeCagnee
    0WHV7cQBRSYL9djYWrc1urmeku2nXX15iNwM4HJpz6w/MDuL2n9KF0VHq9+QOcO9UdHipV
    /1PJz65aU9lg6owls2qKUsylATtHGGV+j0RubUnJZBwkCilvaYKnxXdZL8Ij67FNEc8u8e
    J9dezC6i6Y0vc/O0ec9uAP3UtI+XJu9mLyMBGSZuhbIVzTFLLMEqnk/i0phQ
X-ME-Proxy: <xmx:dmzzajNHNN3xDb4JFRd0PgUVlx2Y3uj--aJz9F2CP--E_2nPuv3GPg>
    <xmx:dmzzam6gBO6lnSYAcLw_INJduJa1t_1s3EYV33Jf7PI6dX-ZUDTQVA>
    <xmx:dmzzakMOG2edXosruZo-F2tyMKuzM8lyPMjYE5Vl6NKfxuQO2HUKig>
    <xmx:dmzzakn3rVD40fE4FDVYOeIqw2Atn1NnhLNCdTfNTiEf5oDQTe2FDA>
    <xmx:dmzzatkbt_h7qNX5YgD58DOCVK8Gl5J2guA5feVxTKTeKD8dmFZpkvxg>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 14:11:49 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y v3 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Tue, 10 Nov 2026 14:11:25 -0500
Message-ID: <20261110191136.1748573-3-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110191136.1748573-1-oss@fourdim.xyz>
References: <20261107062323-failed-5.10-6320736af7dc@kernel.org>
 <20261110191136.1748573-1-oss@fourdim.xyz>
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
v3: Drop the AMP and A2MP changes, which are not in a518b9a9ef6e.
    https://lore.kernel.org/stable/2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org/
v2: Pull the payload of an unsolicited A2MP Discover Response before
    returning from a2mp_discover_rsp().
    https://lore.kernel.org/stable/2026-11-08-1-daily-reply-0004-l2cap-a2mp-5-10@kernel.org/

 net/bluetooth/l2cap_core.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5a24d655b535..0c081b8bfe63 100644
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
@@ -4461,7 +4483,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 			goto unlock;
 		}
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan) {
 			err = -EBADSLT;
 			goto unlock;
@@ -4478,8 +4500,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

