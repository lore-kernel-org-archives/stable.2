Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093600;
	b=DLpz1X00JPc8cl2pDlFMKWi9dwgFp0xAIMnq9/bO4mPh0RqZhdQxsHsIjIcGoeH6fYOP
	 TO0XnEm0sGd/UvE5c+gFA0uOBabFWBTSNqQ91zH1JnTXRsxBIzhXu4C+0kz1/9dzmwuIz
	 ixDhzyMFkdoeB675L/HlUA6kJzcbYfa1FsqM0jJAxJsygYjWTVGEe3y/xucW5WYHVSxn1
	 l7jefUzmT3Bg5NXtS+YtU+xQcWCAyYhGoVUuV/GS6mj0+RH+FfRWEdZl9PZd3I/UjYUwM
	 QW7Z6dCBvKb2SSam9hDIIJQnylv4ZshuiInaXOtJlmZm5WP3b/nJJu7EwctPJ3YQMFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093600;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=pTNm70DWfrDvepoiQbJT+UboTy2tn18I74wAUHhGreY=;
	b=mLzMunzvAFaVGoISw2ijTe5fZd7A/OVipMqT6uJ50BPC7WducudUsogDVESUWB5q53bL
	 38JSZRpULhdS6dwNrLGTR2BePhAORLBfrXw9v3aLyx2ti1uTvZ/kWQkWYg/Ln2+oF5Xlm
	 Rm+3FO5KHGw1aklk92VFQ2UgUXk67DI4Cx8da5Tfc8Oi31UK2wUjk/98j5va0fwYE2wP0
	 iYES35hJFbhWGX49ijTThnFJVdbrBjSjfzf4/3A9iGGKHFbrMAG0kyRS1fN7auuU/N4du
	 lKuaJ+dkMpvIOKPCwiMRdQJcWQN32a1tmeJm7jOfxuIixIOrVr/cSfx5/uygJ9efl/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=MbbtuSKG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="PUxqrBD/";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C720606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C720606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=MbbtuSKG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PUxqrBD/
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C6921D00120
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:19:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 07 Nov 2026 18:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093599; x=
	1794179999; bh=pTNm70DWfrDvepoiQbJT+UboTy2tn18I74wAUHhGreY=; b=M
	bbtuSKGpgWnjtsM24+zNoEMtismwhQvKbxJJm7v9wGTkqZ1p6ZU2fkyrkdNIxds3
	ngtk30wNx+mfa6dwBgmozI3N2VG09Pc8DHIIPJdHRf7KFXWYKqFjujIX7KZies08
	4ZiYb16w0KVhS1z9huZAi3Z04CN607cnGvX/bRnBF/2DJbNXJqADhd2fx32ZUYV7
	q3pXPkK+I1mnYWgiaLE/RD7Ukc4d5+Fd27Q5QguzPPXqP7GS1YzMU6UQge8Piyfd
	fCY+I9zpA0pQVcPFJ6aAtvGFCt9uhyDeBl8U1AdbFTnuTMj2sRErpnJC5YcmJ7+T
	koRrRnolEabI7UjwxUs7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794093599; x=1794179999; bh=p
	TNm70DWfrDvepoiQbJT+UboTy2tn18I74wAUHhGreY=; b=PUxqrBD/+u9vphJMz
	rlqPog+RO282FqZ03c0LOgfiOtMqz3i0xhZXOV8KicDSzuKX+xqebcoiO7OtjSGR
	eC4HTyMVuJNXZitHI+A0U0tMasDcPSBc6ge2OpxtQvpodc0zuGeCe62Y2NuOvg/u
	Mve6kLkHSIWpqbKwAfty5kIOOOC9fWWoJgEy5Hb89btYUc7qOo9Ixi04yy/MRiJY
	NUXxFN/uG6iED6iBQEda2D7D8CfPP7MWtdWgqMWv+hflyA1yUD8TWWhqGr7Tznf1
	FABODqiTri1HU5ls2H4tGLFbZtxUz1SbQpeX79YSgyDoaAfS264HhoWJ8ex2rEif
	n0KYg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093599; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rik2GbQnbx10Z66m/1LXnKzayHOp6PxcLeg9ODL4SBkzfIy
	a8668z/FGKIi7HsFb3F0OyMMfVZrAKzBEZLweQ+Sf76M96MGG7ZbDxWjaJI0uM4x
	nD3nz7GRJ9uho56CwGBdLYPf1kAZjuS83f94Zo7UsPEVqSruRpRkuaCa6W7pIG26
	8mmTKSzAIrcf8kL8rQ77SZtY28t0v0vchs1qhlZeVQoXmkWoSqAkwwlKgttScCPM
	n7AunlvBx36+EhNIH1D3qww1TA1ROR43ZiryM5gbFZhLEDkqtk0ikHBe1ulMoCHD
	ihVL/eVtnEvB8rzdFnCPoG1VJz6AY0uCWE37cCg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LKwDHOfjDKfUZtR8J62C38bB1saeO41ljasvHmtvBDQ=:R3VPiZ+u6KVa3COi0BW9qWEKE5rouQdZHLydMcfnr/Y=;
X-ME-Sender: <xms:H7LvaiHQ7x-rT6Qrh7OjQcB0cRZYQ0SCzMZ0-YuQ61X9XFkMiI6ecw>
    <xme:H7LvarHHT3N1eZJ1433PQrecIIF_6fMROJqBGKW5I7YCc-waUz9QuIwlqm8CpEiZj
    SJmt4KINF_DzYd7DYilksVJ6WBI8Qrz248WN1Dbr1dki0hsJ2OyFH_r>
X-ME-Received: <xmr:H7LvavOH7sVOHkFnO2KY7hKW8uvIPnjaBDgX9nTP6jEJrXU_SC73-5px-ehJ6PMUuggP3fo>
X-ME-Proxy-Cause: dmFkZTEIZBGCpisFY+fdhMhQMR/CwWUComkm9G8pkzgx+4rdsjDawZ1p/lM4mekr6Jrfa9
    t9lCBaxA62uSScJCDTVJZCvxUjTT8lXgI6y1ytbjQFdUJAQqlREN+nI/dOsRSO/gkOdRyc
    pC8LDxn6x3PlPwNH8xvIt2eqfa5x/4kvAkT6Lfkd9YAUm//zW+y5QQzyOpHdANNZLZMR68
    JqeYhLI84sK9usprfwwmkKl6Bsmrd+K1rmmi20p4W43h20l04EoN6alO8A20N0x3h2tOrR
    Hs+B6t0zXHZI5+J2tOJigPtsZ6jVQ/WVLTNyOGH6CZRUTfmKqjC10aJjkjpnPysWnz36nE
    PzcecjF6DtqJgcF2vGVgTbNxggpc2bMcyhVntoBHhzG9OQ0KAmTCimbP+FCVR7yvnDtklE
    ao5j6jcm2cyZnQjkTO4tIaJyoilnYCvCDbIjtqbQiftL0InkOxyHqfQ08vmsvU/ahV0X0w
    vr9h1ivn9ZhLkqVB/qNcF+6W00svgd8mA8f1dIVWQ6H7l65AzFa7iNvEdS9GEVoPfC/916
    YCRyS8wjGkosvuc8QB8pKVgKMw2FLywi+T80QZY+X/7fqp8Mk2uUllGpPRRKrwhXIx9Ddd
    2Vq+ukEZxm+bWGmGmZw9gDtL2Sgv2YvmL1ZYGm7yFM8Q7dkhOtQnsrk8Xabw
X-ME-Proxy: <xmx:H7LvaqG1Sa0jNGSPzMvAnWe15o22ac7UMqcZJFp4Kb7uyl_2ANxvxg>
    <xmx:H7LvamMF0H2cOa7J_oL9tV08WZavvI9Dz7V8_cmiPOs4_pVh7fsZXA>
    <xmx:H7Lvar_926pYuV8ezlFlOvZdXCZufX63-QDQBP_N-UQKTDguNyPxlw>
    <xmx:H7LvaiSyomGa_ik6cSPBmea5mKvkHs8zGCyq5cHv8Ktv4A8sWNlLdg>
    <xmx:H7LvaqkQf9tixn0Hw1miQuiAEV5U1IQ3JsqeCSkrghMHQIHPtDAiNY-t>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:19:59 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Jinwang Li <jinwang.li@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.12.y 3/3] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Sat,  7 Nov 2026 18:19:14 -0500
Message-ID: <20261107231941.1871942-4-oss@fourdim.xyz>
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
 net/bluetooth/l2cap_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2f107c036dd4..514abca6ed88 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4300,11 +4300,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

