Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434894;
	b=0cIciLh3+ebGRhQgLIjezs8zBIHT23QfIrDAqcb9UY6CwZPvUYVKydQF/f2Lx/2D3hjP
	 fIsRTPWWVN3mUs1Fhkjln13gu4p51bt7FDYwtLXh59sAMRiiQ5efDOpWobtp6X00XlW1H
	 sVUqAeNzNtODiJUzSgLvqHB+iKy+wtV9OvKo8j6JU5jbkpyVdcM4XAOYsFI62dm1Pa9tr
	 FTh9fNXg/1Orveyjyni3+xuZ1hUvTlMmgvmB+qJXLbcAwn286BJc+cjixXCcLYI9ZfQJh
	 AqHpy53/DJ2yHpdHRMekpba4Sxsg/mjze3iAiPFI/enYcrK4Il8uTuVTMEKal1nHGUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434894;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=IWzad5ei48og9LRXV6ggx52CRF2WYn4udgUXHT10dkE=;
	b=3pY/PDuCyYVualc8kccM/uoeU+PCiZRC4BqEt2Gfqxb3416tTRJLc1JQzm03RWvEA6+y
	 nAz01pVKvabsBTjD8nj2WE1hLuoBUs8GBDFZPfgcqOvhu8D6JGvfFh+YUaK1pXXcwLVGJ
	 b2x318ijx4BMSGAVKcxjIdY4FBe22O1FLzmPJAxSOzP8SDY8/utBY2gv+vGcAxCrD5n8+
	 HcyJ0Plr777T5yFvx/2dCky8FQCWHnfGqyuEdkUlHgWqy3REsuAvUz8jqz13MaWE5nGAv
	 9/vIRs3/ppzf1NyvYdZ2xeGUbbvYo4hpRYHi7p971VsIsHGMIu84Stej16ONuqF2Bsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=unUXcGAQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uLXF7MyW;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F5606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 200F5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=unUXcGAQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uLXF7MyW
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 796451D00136
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:08:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 11 Nov 2026 17:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794434893; x=
	1794521293; bh=IWzad5ei48og9LRXV6ggx52CRF2WYn4udgUXHT10dkE=; b=u
	nUXcGAQOt+SLszLV/zwHwVP1hfd5hC6LrYajcV38mwRQ9+5k4I0/ZDMrA3061v5p
	vCzzcB3KrHs1LI0F3pFzkeUGX2+FU0S9rof7mjeL842Xg24q+UbAFK0rUHyxZfF1
	4o81qedGeTaes9oJR1O46ducPrt1UvwoR0HJD3+MYU1M1hr2vAz0qZwx6Dgq9SOC
	xydOi/Xxloaprx3rPMvBXL9LuYZdkrHO7jpWoDiG8dTBAyLBC+K8dXssS/1K1Rfe
	/9Z98pjTdzgSICSBJ0O2vQngL7bNSVjlfQsNaPsoTPa8pFDzrP/wdrJkdBapdq/c
	NEOmng8/+EROxGeGQ71Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794434893; x=1794521293; bh=I
	Wzad5ei48og9LRXV6ggx52CRF2WYn4udgUXHT10dkE=; b=uLXF7MyWI11lrV3iM
	zUQNCk2/7YVPWFoHtQbNARrgQccdTUgnEQLRBENjWCCRm4p5f8Sm+ADrdYXHfMJB
	Zo8XZfzIFeKMQDqzlvWDwHeDnHZExo4y/FJd+b4KGd9woEigYI+wicbd5Uk6mjrk
	zpaLa5q7e7prIz2wlyPH0NG+3Tvewh/OBWzKabGV9nRLDcIJV8NSnOfOY07h9cd3
	UiGEyGJhznq4XVrI3axLC2j/mbDXaFKbn2wY+2FseBqrFnsFPPWTBiKZt7xpEyB4
	xh/ned5jtSJV1IgL4ZMOdVSVZZAAFwHb2fZkwLme7Sbcn9CcFCAxRpyPQ/vGx1E7
	OjOvw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794434893; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Nl326+syiwVnxD9nJxvjp4/502Dbr9RioTuPnF0+P4rYr4M
	D/4G5FtcesbWdmpnyeZGAvmIP/mlKcongCfNXfrpjdYJQU9Vb9WOhqQrCMB+7Rg0
	UcUmqx9/ko1ly7zJtT0eWXIkASLQjKIv1riOU7bAjNOYMfQusSSd/m9ZeQ4OG9/p
	LxHeUV/oHHY4I9Q+/S5lRLhG1V3ROJIcu/RTRL2n/q7CHAPT+1pmkadVpbTOYpQ3
	BLFahrfzT+ptu5iwOSoVy71U0vvMEHT46Zds64dqK/aUjh4md7TSpE7DhQYFGxIK
	lxIknuBhn9CcBdWv7FrACsX+0EbVMB5x2SxeQOA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JYoKP8kRAN/g86n6NxdUkKgkEnCYf+B40a3ULjJEM1E=:NbKpR+lAQXRkxHcyn8qAruhyCiI96cPZkcywdRpDACU=;
X-ME-Sender: <xms:Tef0arZHiZDdph3yy2acYaoVIccswaJ54CWvGipc8Lughn_Nm0ryGw>
    <xme:Tef0aiKQc7mCf_PaOQl-56hwxqQvVX2-DPuvpnISRHY4l_Q_odvQSloyzyfMHA14i
    PnuVpwILaLc9Vf9ZtCg5-klQEZK5e4FwaCwTgs0Usn_I7jSKMM6aqPPVg>
X-ME-Received: <xmr:Tef0ahBmbI9KHY5jH_VvccxmSTS2JemcPWbBanmXAXCHrysTcMiOiPyvEFHIJcpV81QXNY8>
X-ME-Proxy-Cause: dmFkZTEijvUOy5pjvmxPmfqPx9Fpjt4e0UrFH6WaW7CRlfYuyZxNmM3WEUBk/qgMqrN5gM
    vOynFiAr2CIW4EgWmJRvIWFajStHGruHWY92Z5tdci9MXse4PJoXvI0K6OfsNHCXn6NYxm
    HLRCAty6RiTwsPpgyT2kmi5AiAujM8P5DJuZVhttuHLQLUbgnO7e0DnoLIvSPPd1xcsIZL
    9RTgX58CUMbZpVlBhq8D3962Js+dGOJ5I7zyNqmj/xGSBxS6HxAfdI4mEpyWvxzn01YDqa
    nk5DoeuAwLh8dlJXs0Ea5i8Lqv5phtKFwN+371XAa3Zkb4GYYZ5NUrYrUNJYfAAAC9gpHB
    Vq7f9PndUWjv8LI6sWkbf/kc0DyLBBtSeLAE0S/RgD1O4YjqHWc73kg+jS1HOhIPyMzsSK
    5X2LplMyz1jQ5MQh3eaKkR5z5Gg9ZJws6bVt1UEn0VI6IjjNR6e0oT5RMBiWN1ac5PI9qq
    4JW2KQkB0wGuvI5s1unJKv0BUfvFFojHc7aiJNpJSkTeSzJLJ6bxmqc4yg0GRBOS6L/SFm
    /Qij2IJ3CFOENGXAUSYiAUhRW6SSRhsjTK1TeFrOSFkFmShnstBy1ycNTJ5C94b0OEWndM
    YYcRM+QyXPTruZfnN1DbaMbBX1roa67Xi7ra+0gCYOFBUipBmF3qEjh6HF2w
X-ME-Proxy: <xmx:Tef0avpVK3ZhWLkT41lia0pshwLA2M40YXlGUgQBmCZ8WeDsJYu9OA>
    <xmx:Tef0akhB_bvCAP8h13A9SOfd23TKlXiNWTSM7-9u24xoPAAzAyydDw>
    <xmx:Tef0akA8CpUeEOA1yXiOATvo3PevijfFapG1hFyXBpZdjZysQtEqlA>
    <xmx:Tef0ahE1ZyD5Z_N33OC1LW1xX4JbSIRb2X8J6BD847xnLiV7BZhkRw>
    <xmx:Tef0asqiIPI9Ng9iohEdZCgyyJeKDf5ej-tEMciji9PcwJIlQ_FIat3m>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 17:08:12 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Jinwang Li <jinwang.li@oss.qualcomm.com>
Subject: [PATCH 5.15.y v4 3/3] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Wed, 11 Nov 2026 17:07:13 -0500
Message-ID: <20261111220745.3075256-4-oss@fourdim.xyz>
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
index 75c2ab39be16..a25a13408786 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4467,11 +4467,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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

