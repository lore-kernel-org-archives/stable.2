Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424248C3E5
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208214; cv=none; b=JifSNfy/AQbnSFsgsjkeimNc3Aqhcp6PMopKzsmNngNTNoM8ci4CAIvQQlVpR//lt+gjCxHlYxxwSSbryet2p5k6Rf5XDqSV7h2uqwlSV2lRMFJQSy7s0WSQeCy9XFd0GcxxCQVERmibGP6u2crUBCajONCQP4iQP4s2EESE6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208214; c=relaxed/simple;
	bh=kJoCLUlLH5c2PfLDEJkw6TF3W6aoKrKGlZJJKjuBdBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioe/GXqwApWP6MBMZbZNjq6jNRiXzwNjko+GN/soLhF/Nfti9ByWPplel/OjVDbsCLriDgN2odJrMyecs2kHFi4p/A6pG6z0pTwOcBKBoQyiziH3i1hPMkz8XVBlccsSh5KxRD0F6LF2IUVdmBnAS2yS0ECH33nNkihjD15V3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=V+IXxX8N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PHvscd4n; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="V+IXxX8N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PHvscd4n"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E6661D000F1
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 09:50:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 05 Oct 2026 09:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1791208209; x=1791294609; bh=7vETM4hDdR
	zBFCOcU0QImx6yNzrgqYDmlD5S3xflOCE=; b=V+IXxX8N6mCqoor8lXyrgigV3x
	eGBvq1HSMWc9QVW4X77bVOoAbT1Cvdb5XmsYyR4Vu/ZAMiTqqFCo8PQ9KmZMhbo3
	CkIJXt2smPPLW/+XvXN+VP8u9fsED1sd/etGXmGsA37VUesWrlhf05Ae+XhkwX6W
	fto8jyyxn1R35txld+eumFf2uxQBiwrW4V1wolzxW5zY58PO2J+3ywsIWzOS0Txw
	txwpyXkpPdmxBwDMP328ddL/77gGOKcygMKvXgOjGXGFKlqPYtBUq5+tZhvgi3xK
	c+fLpmPDkdQJ1GM/wbM2muYnO8E1AdFVff/sDmU80b1P6aJSxHIzpfIhTa+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791208209; x=1791294609; bh=7vETM4hDdRzBFCOcU0QImx6yNzrgqYDmlD5
	S3xflOCE=; b=PHvscd4nO2bSPijUTj5pbIK48cuLiTfLBaL9LuRoqdD9sgjze4t
	mf4plkSjgfsWgb4ODzJUi/9kN3MJksp6qimH0Vvcu8k6x99xStwJaX5VK3OohpHK
	z251wejPua2TipmC5Q2UJkgtktA4Enuncx9b9biCjMb1Apb3v7Wzh3o5qAnf1nYt
	kZDDXpJi9dDmHsQE13Xo3cZHUWqJWlWlkl0mBJ5L9MaN8H62CJ6VAjMXt1NdCpJG
	izgF+V8iHSXDy5u+tjldexFHrRl4fJVPLQp19rSm1FLSsQeovp+rIY2zBYFu8BjW
	uek/wokugt0NHmSaYF1jjU+a9PqRS2JeaOA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791208209; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:O9rj4wjAkeUzMIBii0+LzhSw97Ekdf5IjXkcOwVKQ9v/PGP
	xQIoZNvVavtIGXU1E5nMtbHrIcBVih0aU5D/ZywN/fraPVvbY8mE29uRegVAH/iE
	NEriEaYbmkgs8PaA0oUmrPV/PH19B9/pfgUUBrufQivwsmZ1dOFNEdvSwWjf4f8t
	Qn5R8MBtNHtHURTo08qR+3dRPb79tKGgGGT7jk2r78PP014prvNraggFsGg/KvQG
	XQkm3xaZTLeiGYyET3zVQ1wrp8v6MlMuZ9D+bGlk/u1P/C8219hBrz1AtayBDamS
	ZM1+RIg0WFCOpH4g463MwtVr613lZz5uJpAEZyg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:aI99KDTvcRx0wkfO5Sft/Vq5YM2KoIVwCZVsibUZ9HU=:kJoCLUlLH5c2PfLDEJkw6TF3W6aoKrKGlZJJKjuBdBc=;
X-ME-Sender: <xms:EKvDah90Yv0-c6x3vQCDdZFRNNWm3h8i3trrMAjJHVPbKHOxHdjA6A>
    <xme:EKvDajhZ8x6tNQutiOF4fyK-xS-nVkcIRtQsrRTEADozDk7cMQMgoiPLwX8yxOncu
    WUQvs3qqliyrbQBneUgnUVgiIb8YQlNtr8HKXzd32mSKyCFGeiciaE>
X-ME-Received: <xmr:EKvDapeCpkyGTjHn6DgBHMfdBUNauORKV2dUPT9m73zVLK_oVOhqhmlo3fvd>
X-ME-Proxy-Cause: dmFkZTEwSXeKQKe90U8Zg0ChVJ7PXvyJWXNdBjW8oqS/AT33NcUbOOkma2D0rwhuDmJGHs
    F7Y4BtRjrf9yOr78ZjhYJUsqbGba6pD/sxZ3/o5S3BZ5mHF+Dzzsyi7rOx80tS4nZkmd7G
    D4JUfCD8kB60MFCYuFSxI8o3eN0pd6LMzm4DgysIfUiHRUg7Pe1dfQdcFmojGmV39uEKYY
    hxXWxHUyB7fgknpamoAIib6hEU8IBPHwYMkJJhavUfTN3sZxMMAJtIgyrtGsLzdKzpvbbX
    2ow2AxIo3Tuh731gGq/kzShGm3/Hrvc7AjA9lQpwzJezoIAaus8SKEZtAtnlCXHMqwQ2US
    vpqh0S+ebL6XmPMWXposXj0xeKduhsVoGhEqaHbTiLwXMX8w+KwM6KKlONSOa2LunRsN6D
    SiXU50G0DKUxqwLQW7wN2mCG2CsAh02i15j4WKZ3487YuasHihGc5jDxrd9dMqqBHRgIk5
    UL6vVkTzGa7/QI4RCy3lwnrh+7Ygcl1kvgTr54dT+6dWuR3r092YrjerppifQyxBXzF7P1
    nlLXprwQ7+e5y48hgeTuxPZE6qdBzosCx6Z7iU0AVMRgQ5NeJzGKa9CmUhVMHxMS8zG2if
    bb5HaN/EW57XiOcC0br2aksZRSD09/NYazyecgBK6ygn3EPw8wWZgcy9yv8A
X-ME-Proxy: <xmx:EKvDaiqSA-C634I4hI2oxtSFwUN3pUNFR4vMaW-tDx-8815LXiQKQA>
    <xmx:EKvDamALeklern1QkNUhaSUJ5OcT4gk3z-KIfHaD3c15x46DLFt8WA>
    <xmx:EKvDanb-28Zvn_VEo9LvZGPJ4gYkE_nPHg3nvdjx2jU0na-qne_-Gg>
    <xmx:EKvDah7vI97vXT8aj8G64PeS48MkZUbCutb0HHf4h3kKonNlU18vUg>
    <xmx:EavDaq3LG-LHVTeWF04RGYnBWcGV-ZOI0Cd8K2w4n1lUFy8CdAS5PO1n>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 09:50:08 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] strparser: make sure __strp_recv isn't running before tearing down the parser
Date: Mon,  5 Oct 2026 15:50:02 +0200
Message-ID: <425d9d926709b542ed5331110c19fee4aee1f28d.1791206940.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment above strp_done() claims that if strp is stopped,
strp_recv will no longer be called. That's only true if the caller has
a mechanism (eg locking) to guarantee that strp_recv() calls that
started before strp_stop() have completed by the time we call
strp_done().

This adds a dummy lock_sock/release_sock pair to guarantee that any
in-flight strp_recv() (which runs under either bh_lock_sock or
lock_sock, depending if it's called from ->sk_data_ready or strp_work)
has completed.

Only espintcp can be affected by this race condition, but this patch
makes sure no future user of strp can have the bug.

This could crash on strp->sk ("general mode" of strp), but this mode
has been here for 9 years and has never been used. It'll be gone soon,
no point worrying about it.

Switch the stopped/paused/etc bits to u8's to avoid races between
strp_stop() and strp_pause/unpause().

A reproducer has been published and turns the possible UAF into an
exploit [1].

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Link: https://lore.kernel.org/all/aZLn2Faeg1FB7XOf@v4bel/
Link: https://lore.kernel.org/all/aZgpkyTDU3aXe_V0@v4bel/
Link: https://github.com/m0x41nos/RustyTux [1]
Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
v3: try to make sashiko shut up. drop reviewed-by tag due to code change.
v2: no code change, just add Cc: stable and Reviewed-by: tags
    f06217a9b95b7027286c7df21336e67e334c3e6e.1790674872.git.sd@queasysnail.net
v1: 4c80ea646f95abbd5beca2c081d129fe7d61a0aa.1790344112.git.sd@queasysnail.net

 Documentation/networking/strparser.rst |  2 +-
 include/net/strparser.h                | 10 +++++-----
 net/strparser/strparser.c              |  6 +++++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
index 372106b61e65..d0804c88ad0a 100644
--- a/Documentation/networking/strparser.rst
+++ b/Documentation/networking/strparser.rst
@@ -77,7 +77,7 @@ Functions
 
      strp_done is called to release any resources held by the stream
      parser instance. This must be called after the stream processor
-     has been stopped.
+     has been stopped. The socket lock must not be held.
 
      ::
 
diff --git a/include/net/strparser.h b/include/net/strparser.h
index 0ed73e364faa..881b7ae34498 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -91,11 +91,11 @@ static inline struct strp_msg *strp_msg(struct sk_buff *skb)
 struct strparser {
 	struct sock *sk;
 
-	u32 stopped : 1;
-	u32 paused : 1;
-	u32 aborted : 1;
-	u32 interrupted : 1;
-	u32 unrecov_intr : 1;
+	u8 stopped;
+	u8 paused;
+	u8 aborted;
+	u8 interrupted;
+	u8 unrecov_intr;
 
 	struct sk_buff **skb_nextp;
 	struct sk_buff *skb_head;
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index a23f4b4dfc67..d5b17d099a0e 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -505,12 +505,16 @@ void strp_unpause(struct strparser *strp)
 EXPORT_SYMBOL_GPL(strp_unpause);
 
 /* strp must already be stopped so that strp_recv will no longer be called.
- * Note that strp_done is not called with the lower socket held.
+ * Note that strp_done must not be called with the lower socket held.
  */
 void strp_done(struct strparser *strp)
 {
 	WARN_ON(!strp->stopped);
 
+	lock_sock(strp->sk);
+	/* sync with pending strp_recv */
+	release_sock(strp->sk);
+
 	cancel_delayed_work_sync(&strp->msg_timer_work);
 	cancel_work_sync(&strp->work);
 
-- 
2.55.0

