Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434945;
	b=0Ovt2WkqOklEiqjkfYkbwF0NPjvwKk677+6YHEtI3kPS+rWyZej6ErIMd0rh4zrbURTY
	 lKe6YHD/b258WV3tnAkQkZp+wLv4igcJrum0nquBkwt2rENSg9pS0BJCM4TfiOimLoyae
	 di0J60hurUOzGSNQt4k2fd0xpdx7R+giHY/fUyDmwzcynNJA2PhlymO3D7bfzb7oEW8E/
	 22SFPbgsOZbC0fzLkqeoq7o+7yINV5XG6hy+1+LvJNvrQEeNGzOlTiuCDedV2v2wpR/9u
	 TmMdc1Bk9Wndh15IOYJ/dShJPb6/lKVgikRtZXSjNK2yK1IgeUjwvqLWeCU/Crrrlug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434945;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=XbHzB2YDe4odxV5UUPknSjWZ+uwFSXveUc5FThY/8ng=;
	b=0+JfJQiTPUunE/bW3WYLLMIeo4obTKt5gnJK/c1mPYdnXSx6OcwWndFQ2LBzHjfNKbUQ
	 6LJfbWq+hK5cLWfClIBBYIVeXHTb+vtmrEU8I7eX59lqM9rAwk8pzKN5u6NH/hd/mhbcL
	 8DcoQGdCS7/Px2o8Blmy2qFppoqNec/EBQ1eQ5OGYLSmGaFZFegCr92BWuIDulHmmMj6+
	 u5CaMu/kz2/wmI7sHdAFXyZaIyQHCKxmayF43U/GyR5giyzW1kDpptpywGYgG++9PxUvH
	 UgjXEq7kBG3rKvMX0N+ZIlsB6b3N8GGe14qgNfBwQJ15Bx8G2E4bkykVA5PsbKoJzTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=VIyeHMAu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zxrTi5L5;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D5C606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51D5C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=VIyeHMAu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zxrTi5L5
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4EB47A01DD
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:09:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 17:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794434944; x=
	1794521344; bh=XbHzB2YDe4odxV5UUPknSjWZ+uwFSXveUc5FThY/8ng=; b=V
	IyeHMAu5eKkAOtWA9RP22VPx1v1qNJDuhM7uL3dpZyQF2hVzzkUkq/r32RQR5RtT
	deb0kQp3amJ+t5e+5z7DRy/MYp1hCT+TC7p32TgASgeTWB0ExQJLC6/mGnoleDJt
	jqV8Wo0cbmxuguo0vqU9X1hDQEIcIoyeC4/7DGcFOQEIuyPHN+zfHemdtyvslfKI
	w2g3AndVkzCRewecucleoBgRNeZD1xz4EoUMpvpcQC/EkOp2eC42AEpiHPsNcfZo
	b/5x3QZ7vpnWRY60QulbEb5RMCBNte65g0NIbkrYji9LGnH74p4BkmSozEL2sI7C
	KrBo2O8AMEqQUVylYFULg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794434944; x=1794521344; bh=X
	bHzB2YDe4odxV5UUPknSjWZ+uwFSXveUc5FThY/8ng=; b=zxrTi5L5j8vklSume
	q6/yPa2NXsPgnQaHIJKemLOdOtAMMFDIS/UTVWVMGmJBpMLhfX8pVldSJTjxJRpK
	D8/7zcdgElH9eh2WBXl2iGwZ+cEgrGaTH0YA3dsu1rIDSaDfY7TNOWL9nKAN7p8v
	K/KFUa0WyCizP/5FDHH+tB3Xph2eNy9Gmq6dDV2bSMlmWmP6ZyFzmhRf7wGLV1g+
	rH6wmVdmfXm3K3HsXpEJZR7tNIOaxSqhoTRy+3FGowbk5lwW4UmxJpUi7FAJyvuJ
	rRPtTAQej3K1tZxjNrGOHpq2sl8NmoJZjdEW9zwBEK6N2KkebNsmHwCjtQ8RJ7DP
	FR9EQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794434944; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MjOEAWDUWDYOXBF0ZcnAne581R/0yQCr0DHDNeBvsuFgHE8
	ZRHz9jnAYUv2+Pw5mbT5eno8PL1w1VT8M5I98BYYoUeHRAKFSJi24nngQjw2oDzf
	u3Jtrmc6xFNYDt7CNJ9n+f0YRpr5qxXg3rBoCRTeaHBO8wPKVDhamm4Ry/Q/t5BK
	B3eqLP3kNST+/yfxEZLIi27AHUN0+P/AgqSy+XMffsKdvYrRc9HRMn1LeQXeB0TX
	dK5i08NO6M/9/jivGapgVkJxGVzkTW7kGy/ye1E1om4uVkAG6bBoK/LKSKy0JAhG
	V3PVnvdxcbjwzya4/aqxFV9hnmXmwJtNX8h0XdQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zKcBrO1tSepjoUWLf/qZ36ZLjPDsmr7eKzk45YUrNqk=:un5IHFhrCZWU/Cxm8gWHW8NVvXq2RRjftycL+S5aIak=;
X-ME-Sender: <xms:gOf0aoAR-YQWhCX5jIF4i2hu-LGJ8nbg_XQYSV13tGau41PQH9afmA>
    <xme:gOf0aiT3j25MjenP38cvmKcw8BqjE6aattpiqorjL1KEKvl2XiB5OX6cS0rJ1zyEN
    pQ7yMh5NcshyCtjEg-svqwhRo9XgQ-BPrfJub8ZkAGFSeBMItNhSp1s>
X-ME-Received: <xmr:gOf0auoN6OIBqswWpDuqCZuZVb9a_mI8k4An3TU7_3itr8dhn_6ATm-AqETom70wqxcyFyQ>
X-ME-Proxy-Cause: dmFkZTEijvUOy5pjvmxPmfqPx9Fpjt4e0UrFH6WaW7CRlfYuyZxNmM3WEUBk/qgMqrN5gM
    vOynFiAr2CIW4EgWmJRvIWFajStHGruHWY92Z5tdci9MXse4PJoXvI0K6OfsNHCXn6NYxm
    HLRCAty6RiTwsPpgyT2kmi5AiAujM8P5DJuZVhttuHLQLUbgnO7e0DnoLIvSPPd1xcsIZL
    9RTgX58CUMbZpVlBhq8D3962Js+dGOJ5I7zyNqmj/xGSBxS6HxAfdI4mEpyWvxzn01YDqa
    nk5DoeuAwLh8dlJXs0Ea5i8Lqv5phtKFwN+371XAa3Zkb4GYYZ5NUrYrUNJYfAAAC9gpZ9
    8NCw9WWjTmg745HUff0KMTiO6OdTm1k545MeFgfMxt5E2pC6VsOGv5aJuqNo3Cr+72ZzKR
    mXtTetBN/wwXsblfZ0a+YoOy/IWR9Y11Mdu2So1jEKIYnBALfpLuXr3u1vEbj8jrMFgQQV
    mfsnWcGiY5HPze9XZucnqj1ox4M4VV+LA6Hpx+2mqjqeiZ8q3HjcjnPTfDRqh9Fuy/yvAI
    xq0H4XeyN2Gvwa0VUpWuehwFWdJa5+Dc3Xd/yrRz7qatZ8+4xwW1HfXzKEEdo0g1jdS6LE
    7apPjkeBzehJNinZ0MqLYtag9cCpgRJnwPT/ujsjqnEHPawo0mMOdFmUqF7A
X-ME-Proxy: <xmx:gOf0asypl-MvnQJLcARPKDSRyqT24ysdJgnzlW8mGbO9jHtphgYopw>
    <xmx:gOf0arKdAwh7tlNbKfC9TFfalc9gIM0bxTxct3X2AMvEynQ2lCuG6Q>
    <xmx:gOf0amLRfsg1IonWIVKr2x7Zklw3oslNBJ_UzGH9uTNUM9usV52hlw>
    <xmx:gOf0aotAX75jLDPniTrV8HJ_gidZwWl3znDnHcjPbmZvtLvK3kFR6A>
    <xmx:gOf0aixT64Uq4hIj4SSpOlD5TnZrDcmT6Gvp_LRwE5qa2UsBoFCqiqH9>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 17:09:04 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Jinwang Li <jinwang.li@oss.qualcomm.com>
Subject: [PATCH 5.10.y v4 3/3] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Wed, 11 Nov 2026 17:08:14 -0500
Message-ID: <20261111220851.3076201-4-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111220851.3076201-1-oss@fourdim.xyz>
References: <20261107062323-failed-5.10-6320736af7dc@kernel.org>
 <20261111220851.3076201-1-oss@fourdim.xyz>
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

From: Jinwang Li <jinwang.li@oss.qualcomm.com>

commit a9f9eeb5344fc7dc625e5700ccf09891bc2603b5 upstream.

Adjusted context as stable does not have the lockdep_assert_held()
call in l2cap_connect_create_rsp().

L2CAP/COS/CED/BI-28-C requires the IUT to ignore a Connection Response
that carries an invalid Identifier.

l2cap_connect_create_rsp() only checks that a connection request is
outstanding, not that the response answers it. Add an ident check
against the pending request so that a mismatched response is dropped.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
v4: No change.
v3: Drop the AMP change to l2cap_move_channel_req(), which is not in
    a9f9eeb5344f.
    https://lore.kernel.org/stable/2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org/

 net/bluetooth/l2cap_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a44d4cce0527..98f82f4613e9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4502,11 +4502,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
-	/* Only accept a response to a connection request we sent and that
-	 * is still outstanding. A channel waiting in BT_CONNECT for security
-	 * or the feature mask has not sent one yet.
+	/* Only accept a response matching a connection request we sent and
+	 * that is still outstanding. A channel waiting in BT_CONNECT for
+	 * security or the feature mask has not sent one yet.
 	 */
-	if (!l2cap_chan_connect_pending(chan))
+	if (!l2cap_chan_connect_pending(chan) || chan->ident != cmd->ident)
 		goto done;
 
 	switch (result) {
-- 
2.56.0

