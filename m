Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434885;
	b=X3U2CFkGcvt7o76g3Bjs8X9DBoOQqPE6FSNS1tThjMVTdPPEg1ieDRCcHyl+kNbP7lsz
	 RQLKLmvMO2No+WwKx8Icw3HjAKFgHYLZ0qdfSx3RD1j/DZ+T/TYIAAXykCNDv6wDCROO1
	 MEj9M/av7FGcbNcJzrq0wvbqNVZb5Rl49tq0K3YZUqEPlaAnjoVnZTKsLAM/YNMC0gH3j
	 eZJ2D0zNK/ePkg1SJyxFPAcSKy6u2qPR6Zy11fQVwfO6di+gbomrXoHoY/iTSDYSxx3PW
	 cPf/W+Hn8dXVOcmiiOaEx9EKoE+Xk9SDrSVsj+LHiuT7M9Jfb9KP36NeSox2NIH22jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434885;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=OKy8gITiEOApS2aU2qiBAaOPI7OP2WWyqS3z4eU5XLA=;
	b=1TFJa4WdwVjZ1cbbjFVkyGbl695vw5P3htEH7V+94CmW7JzcJj8IBSZET6sJzM9EZY3t
	 y9YFgSO1NaRwUf7pjAQPdyLKc/vpW50SZQQnONvY4uk3gwYvBEYfqB4S/fmbyOC1ztl1F
	 7w15kz2B8NedrIMt5NlME802ghHJOiIWPA956SbxaY3f4ajQ+qYnwG1yXbOcZqGR0d1lo
	 +FFFNqYgs1gS/NJtpzWrLJQJ8ksq0NChDS7APT6Z5K+Lez750VPH0zufdctV1y2c18Jg8
	 LpMWLFzTLUnx5EEG8GCXyMxW2BVJh6AtPwBAqY557aepJMDJ4ABybdyZcv5Pp+pNdfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=VmfwKmdv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z7AWYs+u;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740CF606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 740CF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=VmfwKmdv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z7AWYs+u
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 615921D00136
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:08:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 17:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794434883; x=
	1794521283; bh=OKy8gITiEOApS2aU2qiBAaOPI7OP2WWyqS3z4eU5XLA=; b=V
	mfwKmdva5Aqt7OSeuJEwfl4/Yh0yRENyrgEMLKZaf1oLkmgJrf4xKCiB29lQ6LEK
	i+GDy+S8k/iXTs7gQVADKgofrlsM+8ZFvbWRZJrPWdD+K/65wID+6H+ek2G5hsW6
	gYfL8Zz9XAe2fj3R18L9RACWGYqDJvciIj+gHBaWvR58IH6I60TuwGE1gSX+ljOc
	A+p9x/Y1+7UnNa8oLr0WK8+g/dZS8U0crSmDtGPdoF9e9jEn45E4OOmZBqwxFDlW
	5vkK56CbEt8CI756b9W8DxXqy2nIcaanCvzUckLBrQdtZ1bLZkZ/6wXWZ2Si6rSg
	IFay3dETqqGfUfsgbdaSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794434883; x=1794521283; bh=O
	Ky8gITiEOApS2aU2qiBAaOPI7OP2WWyqS3z4eU5XLA=; b=z7AWYs+uepoDFV8mM
	IYZf/q+pXylVIIQQ1C/wyiIM9hjr1CRS6KnZMmu+7GmnHYiUoAPpkeol10qyAk8B
	27FS3178/fwY/3+y1LdKB0thGyxOAQ2H0h+o3pqQXeWqayunKaVCznydp72G5E/z
	8jEjFkleovHXbUyNOPFIn4VhxujesG8duQ0sCTQFMkItV5lvFvw2WH39TKKNdp96
	IiAZfqh0qnTrtd7njlsdK5N9dszEGYRPKHZviFxLO5Gvs7m+yMJ8OuKW90EyMhCu
	5FTEfB3hpbM2AD32EZtsKNKrET4CbK0K51XdROLReKHnrbPzh1o91JIaf5zV9zay
	hBTeQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794434883; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ndBen7JkIIGPJclokL4SSVtCbi6d5RsAFxgTiAnD8Abhsh7
	+bIJ+qiJc9xeu9j6MxKT4fItWeBI2r3tMtTHbCCicg8q95wF531B4NMeliXnFBwl
	9ePfZWKJfHJsL3rQ55wXwJXgtwltbNkmXjiNwzUP1d+3fpfixnTqdA00Q42ONxcG
	/13GIBxJPwjEVcxPexbqLmeeXf+BFnbfMg4ffPlqxhYz1yzjdoH9ZUkD98mopR9z
	PhIvGWq+FkfKVAvej8iyBHmmJSZeahR9Gvsi9trGR+Mat3PWm6ZeCSqy1lMf4Vky
	X8MuKnrqVQwucoawyPXR3OB344+y9RNNQ3LsSqA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ID+jz/UGuVvhNaiBe3uZIjzRaEJ0AyQd/jgG00YBSQw=:yvVN5Y3BWz2lnHyQ1v8/1xkA+n9ZqoSC212t/d5l++g=;
X-ME-Sender: <xms:Q-f0aqR7lfHdwsUCVjulGKR1YYE3zfhdbASqjEPvqtHYZ7syxDmGlw>
    <xme:Q-f0alycfjWnYw7_yk-qvTF6qOFl_MSUKMgxOHTXCGgYKt0PZmNDjs4bf4wByodlK
    up_DhISzrDry37yiOTvdm41KTqwOatJPkoPNLDIIkO3hgRfCmozBISX>
X-ME-Received: <xmr:Q-f0alcxfKhVFrkZ1qcmsAKo7e4NUFrkxP8N7nfdz3vrT5lLsH8hbjhUpZ03954EGqUxKyI>
X-ME-Proxy-Cause: dmFkZTEijvUOy5pjvmxPmfqPx9Fpjt4e0UrFH6WaW7CRlfYuyZxNmM3WEUBk/qgMqrN5gM
    vOynFiAr2CIW4EgWmJRvIWFajStHGruHWY92Z5tdci9MXse4PJoXvI0K6OfsNHCXn6NYxm
    HLRCAty6RiTwsPpgyT2kmi5AiAujM8P5DJuZVhttuHLQLUbgnO7e0DnoLIvSPPd1xcsIZL
    9RTgX58CUMbZpVlBhq8D3962Js+dGOJ5I7zyNqmj/xGSBxS6HxAfdI4mEpyWvxzn01YDqa
    nk5DoeuAwLh8dlJXs0Ea5i8Lqv5phtKFwN+371XAa3Zkb4GYYZ5NUrYrUNJYfAAAC9gpV0
    2JGMtLAbDPJamRjr1qZLMDjAuwU591pX5PMrGbqh5VvAqRcK76hgbpCnMJlmfmCG8eD7zT
    CO16Mp+IosszhtNk60VtN7/TCipLjPQEl1xfoj6uP1wG6WUd/ox5cfbc/feCMyD1wqDvvo
    tot59klp8oOnwFr2NIqoSRsEhwcZte7uIJfiMqWFoQEMQh/hln/WuzP1qt79ZlgthucDnE
    KD20aXSJ2H5U/9+5zHFb3wKSh2MuaZgCNibDyXZ8lUqXo3G0IFZIII2RSqN3CWZhasmiq6
    9UFxjP8LPZgoboqQamYnyZto7xk+uUF96LuRTZ27CaearQGQhB1nzHC/SKJg
X-ME-Proxy: <xmx:Q-f0ahJ1Q2e3PhnLclYMVg5cs_UNdD1nubmcXWMTJYCIKraGYX1cjg>
    <xmx:Q-f0amGCRQWaS7edZOh-yk7PwVY4y6HIo9-v9WZJdKcrTrLBIb9IFw>
    <xmx:Q-f0arqUv56VG11qSLHK4VjsQXUSZMFbA9kQD1hn5W31YTNZL5DyoQ>
    <xmx:Q-f0avQhPvpv8_jN_p0boAHoLaSEaXNOPXE0cBIOmvlNenTgQ2x24g>
    <xmx:Q-f0auwjw9tDbxSRjT32zkDcYNEsyL0fcNoX1tE8CApXUZTuF6udH7pN>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 17:08:02 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y v4 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Wed, 11 Nov 2026 17:07:10 -0500
Message-ID: <20261111220745.3075256-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107060628-failed-5.15-6320736af7dc@kernel.org>
References: <20261107060628-failed-5.15-6320736af7dc@kernel.org>
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

which failed to apply to the 5.15-stable tree:

  https://lore.kernel.org/stable/20261107060628-failed-5.15-6320736af7dc@kernel.org/
  https://lore.kernel.org/stable/20261107060634-failed-5.15-a518b9a9ef6e@kernel.org/

Patch 3 is a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection responses
with wrong ident"), which tightens the check added by patch 2 and only
applies on top of it.

The series goes on top of the three L2CAP patches already queued for
5.15.y:

  c1398cf11b31 ("Bluetooth: L2CAP: Reject mode changes on connected channels")
  c5ebb0245fe9 ("Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests")
  226fa3b676cb ("Bluetooth: L2CAP: Use default TxWindow for zero socket option")

5.15.y still has AMP and A2MP, which upstream removed in e7b02296fb40
("Bluetooth: Remove BT_HS"). Patch 2 sets CONF_CONNECT_PEND in
l2cap_send_create_chan_req(), so the response to an AMP Create Channel
Request still passes the new check. Apart from that line, the patches
only carry the upstream changes, with context adjusted as described at
the top of each commit message.

Changes in v4:
- Patch 2: set CONF_CONNECT_PEND in l2cap_send_create_chan_req(), so
  the Create Channel Response is no longer dropped and an outgoing AMP
  channel does not hang in BT_CONNECT.
  https://lore.kernel.org/stable/2026-11-11-1-daily-reply-0023-a0d5fd86605d193ae993@kernel.org/

Changes in v3:
- Drop the AMP and A2MP changes from all three patches. They are not
  upstream and did not get the maintainer ack asked for in the v2
  review.
  https://lore.kernel.org/stable/2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org/

Changes in v2:
- Patch 2: a2mp_discover_rsp() now pulls the payload of an unsolicited
  Discover Response before returning, so a2mp_chan_recv_cb() does not
  parse it as the next A2MP command header. Dropped again in v3 with
  the other AMP changes.
  https://lore.kernel.org/stable/2026-11-08-1-daily-reply-0003-l2cap-a2mp-5-15@kernel.org/

v3: https://lore.kernel.org/stable/20261110191058.1747963-1-oss@fourdim.xyz/
v2: https://lore.kernel.org/stable/20261109015902.3034747-1-oss@fourdim.xyz/
v1: https://lore.kernel.org/stable/20261108000542.1969015-1-oss@fourdim.xyz/

Jinwang Li (1):
  Bluetooth: L2CAP: Ignore connection responses with wrong ident

Siwei Zhang (2):
  Bluetooth: L2CAP: Reject signalling responses in invalid states
  Bluetooth: L2CAP: Only accept connection responses to outstanding
    requests

 net/bluetooth/l2cap_core.c | 49 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

-- 
2.56.0

