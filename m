Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093547;
	b=xFHuvgHODo7+MzmrX71GOpmVEZdV69jTw6gBMt2Hw766BXxQQcqZfmLTJJ3Ubb5qpOVd
	 a7tKj6zBwPioMc93R9qDFkkJqVeaqb7tkjcYoh1PzNULnxTmMWwSRBQWLF1z7DQiAELuR
	 /eda9uUSOhDOotTL+xi4SmSlfvwBSYRu4G6HoxQZgnKFdGW5Yo97sboUQXuPnbaUL3Npc
	 smkprJZRG19UAg3wzrJmJDBnimvBFFex/+j7uKp+gn71QaWh4ENS1wM3xSNq4GwJ/cZPP
	 F6deDDXEccB6G3+7ASln8E/yZf+8m0HgjDX8K9NANRfJbZwxuLENjQpqI+so4FbOuPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093547;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=fDJAUpJ7M/4KDp5sSOHtNGp9K5bqiJo41IJC80sEyNY=;
	b=Sf5z2vnDQjnvyzqjsQw3plqEsQJY3IfTZBmHwHHTSuuIDMQh08/WGulziVwWGeaVRUeX
	 /FjpcpiIxjTANDOXwXCbGyXk+62df8bOcJRFW8sjhppmV8lfaElyqJ810P190h9kBC5vx
	 5XVtNONH7SqgBOQg9ZhBMRAtE8T32Ee9FBdqv300/qOyeQi0MA0VUK2sGE7IuY044WE1q
	 NdvUnwhD7+eziIYkL0AfTv7Z8QtilhuQPRbTzgzVvibx5MEmaf2Gd1yRC94GyINihKC4w
	 +76ZU+/huJdUir2XD4kFbSkztRUBbowl7zX8zujgXJvwoS3SGqxMT9vpw6iH34AZ/QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=DBAIvY1B;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IDBhk4SY;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FCF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=DBAIvY1B;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IDBhk4SY
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D724C7A00C5
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:19:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 07 Nov 2026 18:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093546; x=
	1794179946; bh=fDJAUpJ7M/4KDp5sSOHtNGp9K5bqiJo41IJC80sEyNY=; b=D
	BAIvY1BiH/HlHVPtULjkSyIUHt/0H6+UmvhQGXg+3t9lxSIuN/F5/5svs5lQ/JpF
	yHMzRJFObqu8r+TZOIgBgcZguZ91NyIwwaqWNY5r2wWgtWjOiHZxnRsLvl8BoGkj
	A8YOgYuEK3o5ofiZA2QSxVkBl3zjbi3QiLxNORaoPp+C4qxCgo90tSjMpfI2flm6
	xMseMrwFv5KM2362gREhm+U10sIddcv0F6oqi8lWjU0C8e3MoJN2HlrwMH5k5imX
	7w//WsaclAM/haFtr9GuL1671kmt37XVaOuzB6PZr6QorsoqEcY7AOK+ZfAGv69a
	ln6ZsfR1a0vxTeH9IMJ6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794093546; x=1794179946; bh=fDJAUpJ7M/4KDp5sSOHtNGp9K5bq
	iJo41IJC80sEyNY=; b=IDBhk4SYEb18QNPWvXOy9sh9flc7iU3kt3IZkhGXXuJ5
	3r9LOZAGbTliz3rLX/CsPacrwJwxQytUeeSWrhWglcERp3T+z40zrIVKFlb006vf
	AtRmbG5IpTCBg2fDEpR5O+ckrZmdcqhvlWIN/Zg5B4TW8fcbiBWN11DknBNrdfV6
	pdDRxtZjzQEgcbjGzOu1yDtfAbFB9y2Roahw95g+ya6xSqHV7PALh6XHrUtt+0wH
	khZGq/KuiI2UIz3QSqR7HhCXyTsk/vIiIrWdqyfZHsJybmF6NEnWoI5u8X5VI41Q
	M8lxPgTlF78fk9kS5YNkKCDrBJCEixPe7NTDwbsy6w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093546; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:O+cm2AgzXznskSzWi5p2u+nScAIuqbzZyXJW76YN7jRVHGE
	w96WBe60HPsxgC8lFG+BC87+MNnvUVJ79BSUhrku/wBVq5dRb5+6R1A8Umn1xtDW
	jzJGSoykKGVUdkaR9UAcOHm5rd2uTKlZsM/wMJHQFf4r6klz3H2UfnQoiq16GAjM
	QcW5gF7g99YWS8NAGlGw4+dmNpdJ4FicXQ5j8uQCt0BsGUwEdi2jVhBW5kNtC+Gs
	hQkLWlWSXPj9DSTVX6LHm9iurtk1/Lorg4L6RdQUW+SboFscj+nrv98atKatwCM5
	cmxYiY2mtClZQCXzPPXaq9p/b/r7R3LUFkGq0Yw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:g91YVj3s/gKiPpJzHPwd0GWPAJfaldENmSV4zD3MLJA=:FPTFSEhBaBT2O5BfGLumps2GdD5rbc9XcJhIDN+8g4w=;
X-ME-Sender: <xms:6rHvah7BOajlDYQ9YlvBvpfcCUMrtRFgJ4RgmdwV3WuhHR2FtoMkSg>
    <xme:6rHval1CYDZnnK2TDwMW4Q-SIH0KeNHyfzAGYDYxMjOXKO-7TUb-F8cL5MBPcPVQS
    Gx1jdWTRejugf3YsKVioWpY_r-rBUxUtZK2oWAvzPS90GFZlV-ERAHm>
X-ME-Received: <xmr:6rHvauE6evIcOOe7kFlujxwqQQsBUHresIi0Nz6aBoMyxt0v_2XG_-mVQKSNAS2dVc0iiAo>
X-ME-Proxy-Cause: dmFkZTFAFlDOvFwFUeAmNt0h0VqaTvV6TfMYwUU9FIzaVcnVOYbqdI1eimRdqxtvED64gI
    lEB+HweWXG1aCxz3xxaPJjHdKp6SXazJ9B3Jf/VpshJsi7GsfCwlarIK8CHnerjMJvIL4k
    O5Gz3IwLkEGO/mHiT0+10Pspgi4ay8DCJyj+rUktftbCK+zdqx/7t0WJD4nf0Vse/zEygf
    ZaBrfmhT8rTjh+f/HZX3l04oZro7HXU6KfLUcIBYR7r64s6bP1q68oi0XMfM2FhSJKQH5D
    ikz/BqR4dRVskz9ViQFNx07fOy4g9IuZh02tJGcWjUOXKD7m++ZSCtP7bMlFPf0FzpOKqB
    6JzQuq2c+xBzU1dXU37MfB4IE7mPatbDZfcoH5pMdD4AE2wuSTH0bP7YVZU/Ik4quZZ4lC
    6U0b7cl7Hxnhn6zhtoO5fQ/+2efrpcEGSH1ANzuefEpkqqVWHw7VqkKYK1C66DaH3gsq7m
    j1IvALUyMeTy0MSuZrWSgFW4QgfvZgERWNY89ZmYlb+kfn4P833S96kmdzaaONA1DD+Wq4
    /GUqN2awD26gcSjARw9bTXIvur2d8yczJL8P0fQkxhUjQLyPdOZQ1w5m9C6V7GBKoPUN/Q
    1OJlJGxkCYnSVqDj/Hk3qz0KVLESvEU4Tf6XVLv+K5vcVZJORo1wetPkW4Iw
X-ME-Proxy: <xmx:6rHvavS40tycKnmUYdnI2KZ4hkFWvEBlfXqtjbuak2MfFo_sS5YO-g>
    <xmx:6rHvalDt-BGNMdBgOQFh-UxTwH3Gc_oii-02PQAisOXTHlafIAG-sA>
    <xmx:6rHvav3XnTOvgAVTeRmoTkoc_lsxR-owugAuWuLyd2wR2gVhtmDyyg>
    <xmx:6rHvajVOfVziKR5goV6cy0ZM5A4eusr6cdRDlLf0qp5aNh9bXVwdEg>
    <xmx:6rHvamYtd2cDdKQJf8R_x1jC9s5UgqzAqBotKY_u8JunEn9pmSLt4lZQ>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <stable@vger.kernel.org>; Sat, 7 Nov 2026 18:19:06 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Sat,  7 Nov 2026 18:17:17 -0500
Message-ID: <20261107231852.1870314-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107051130-failed-6.18-6320736af7dc@kernel.org>
References: <20261107051130-failed-6.18-6320736af7dc@kernel.org>
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

Backports of

  6320736af7dc ("Bluetooth: L2CAP: Reject signalling responses in invalid states")
  a518b9a9ef6e ("Bluetooth: L2CAP: Only accept connection responses to outstanding requests")

which failed to apply to the 6.18-stable tree:

  https://lore.kernel.org/stable/20261107051130-failed-6.18-6320736af7dc@kernel.org/
  https://lore.kernel.org/stable/20261107051136-failed-6.18-a518b9a9ef6e@kernel.org/

Patch 3 is a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection responses
with wrong ident"), which tightens the check added by patch 2 and only
applies on top of it.

The series goes on top of the three L2CAP patches already queued for
6.18.y:

  c1398cf11b31 ("Bluetooth: L2CAP: Reject mode changes on connected channels")
  c5ebb0245fe9 ("Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests")
  226fa3b676cb ("Bluetooth: L2CAP: Use default TxWindow for zero socket option")


Jinwang Li (1):
  Bluetooth: L2CAP: Ignore connection responses with wrong ident

Siwei Zhang (2):
  Bluetooth: L2CAP: Reject signalling responses in invalid states
  Bluetooth: L2CAP: Only accept connection responses to outstanding
    requests

 net/bluetooth/l2cap_core.c | 47 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

-- 
2.56.0

