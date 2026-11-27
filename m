Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795812682;
	b=MxzuxrKKBT2aqeOasZJPnPjvP+tObGb0KtWmLQU0h3UFSKTNClGEXBQHKOV0mlp9TKiE
	 H65jWgrIiFPirPTtThK00YyzEIEmlDyEgqnx/qo916TdwMMvbzDU4Of1nbGgXBQd8skJK
	 Z7M546ab63T8pfqr91BD3dIFNUskTXKlPSjPNLoO3aMh8VP82srNdjFjmz762rUj4ApV4
	 b/1ps5Z10ae2eync36w+4kralayp0FkYV6GvdMrV8ZcDFy+aEAFWinrHd/T9xqNuRoFUs
	 HXfMZ+QIWmSAhRzbIVgF6apZBmMrQyqLv2jBr7M6WpL+t1i76/JxXDGhg3uWN57cBAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795812682;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=ptgUzi4jgya+J+0tEEGFtNkDJCO63O4I1/NxjncAur0=;
	b=inQXjfu2DQMwIsXJ69SBPPN0pFWgw4G7qF/LJYz43Byh0McCKZEI9Gr7iL91KSNbKXG+
	 HYFg+Fj3613qZ2UylemrFOKBk92cda1UQKl3r0v/XECykgqq+SjfyP9ljhFMlKqlN8/oA
	 legQUO95i3iKdNXkobEdXIOu9XT5D6IgmtAPzVwxzaVNrJI01ueq02Keb2PWUcJhVUoYI
	 T3ck8zY2/UhqKDOxBEN0GYpAWpdlBejUZNRT2SqJLbw0OMkTPKXem9OvAP8BkJ3OenFMO
	 sEdOJKOSDlpoEU7ahZFNUN+ckZsyhzKxWEgrqHYYztWFsvdDX+TRAEcX3e07+5URYrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.org;
	spf=pass smtp.mailfrom=fastmail.org;
	dkim=pass header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=ci0nzTXe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ESBlOQOX;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F88606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F88606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=ci0nzTXe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ESBlOQOX
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E33B1D00391
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 15:51:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 27 Nov 2026 15:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1795812680; x=
	1795899080; bh=ptgUzi4jgya+J+0tEEGFtNkDJCO63O4I1/NxjncAur0=; b=c
	i0nzTXepiUd9yly9h/WMwro84ENHZsBzawnFgdmtjcH+SOR5gx1EeajOaowq52+3
	fBmA9QAOIMj1gnTn+m1961vRKMOzR8uUE8IPW0EqVui19D0DSW9lh7QgyKHXwUIm
	Hw2aj08+NRFJO3iT6bbqdf04o57i0ov5bhZA40K9WBcNgDe8NwHDZx51Ww891Nq+
	mr6O1oP3nQochBAjHDgjdRPBxi95VSNXtfEgTxcWWf97lPnjYCoI0POXVtlUbq0A
	6FcfeFaEfUcWz6KBfr9+37c7ugv65E9Ablxwg9qqHECMtueeV0cjjJPNktlnIa2h
	vRqTrpnjUAsXC7xnPRQpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795812680; x=1795899080; bh=p
	tgUzi4jgya+J+0tEEGFtNkDJCO63O4I1/NxjncAur0=; b=ESBlOQOXJhjCWE0CS
	wPn/1lIcPAd9MkwBGna0XVeEG66gGIDghAopySjX2xStVJI66jZ/134p6VXyZNHh
	eVUlOB6DuHHhF1xmcZ4I/UMZLdrLS3VlS+OZ6QCmaQvrJfXb2kghiJNG/fp/mFBJ
	7awcrVi6BPh6GPil6yCNGULRv0nle5fRuESwzX/n6QiCZN8twepLucJOTeWXwlAC
	vHsEYL3BHhGn8nIXfpSObTEyMMD4p3sE4ah6953y/lgaEscPW3Aui+NbOzyPL7n9
	XmBXcFzgOGZBFgvSt4EmhgvSEAv4ggWsGTgpxWQsFy1yMIuBu1pUMDMSenmIG6Yt
	faR9A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795812680; d=fastmail.org;
	mf=PGljYkBmYXN0bWFpbC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:SX9A2XtlCZVUd8YdsoS3zug5Kfs2ca+ldn+OYej3ETzHw5r
	SzfbtSzbzN8bYYWN5Fb7LL/nplYJ42BIDesNBjLHlwrAQU7Pk1DhuCDPBBnabDz/
	ixjj8HPzYwDPjaBSnHf8yZ2U1WZ9DMQKKGCpgaxdmehZNFkALAg1quuuRezvtbNj
	Ii4U1/iORjuvII5Kl2qFMBk7tl2kh5TKx8HYT7C/w/O7+rMBsdjYiFpqQFi4llk6
	3NOVlDDH8soBDObQ8DC8vGghfQ9mJCdKe4oydcpR+rTBHNr7m93rJvp69Sy15zZk
	MFto2CtEiVgBKPuEJ4d+opJNj22RN6h/3BrNorA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:76SFrT/pWRiC6tG4+HJ7jETtMBnNWjG3ZVK8PX/Odyo=:ptgUzi4jgya+J+0tEEGFtNkDJCO63O4I1/NxjncAur0=;
X-ME-Sender: <xms:SO0Ja6O6emd2jakPpC4WkGPtZzUKtK-kWNi_4fqQPZTmC4p0yJ_HSg>
    <xme:SO0Ja-9gNpT4uO5sRQYsrJ9Nmgk6-7JXAS_fEnMof458QsjB5sX8XvfS_e9QFrLxQ
    qpFZObBMgTqZMHEtVC6azmGRwh-pnAkoDtznuz3HgISSi6g1QdasOxi>
X-ME-Received: <xmr:SO0Ja8FoUijM58jvSNp_zDFgNnCHAAPycPVGIs1rsrVcF5jvlEnwBw6xaExnUgvQ>
X-ME-Proxy-Cause: dmFkZTFS2sA51r7CNgZ0B6rBGyBSQ7gw7paxpu7V4h1MN/INak9SnqCAjwoGcb3vTOuWIw
    2JAf25VwmGuZPXuSAQL2RlRvt6egqYcoUjCKghOlKrpkkfOC9+mTuxdc90oVtN2VkXNYpI
    zbta5qozwmokZEPpwWFX15e3rDE7b0t8khm/t5PITtvcwOSxQY87Nu5CMc8vCffVgeOlv0
    b2jUFsWzT9xFU6wKRsp4542GFMDaeu/be4B+BCz4ZzCJU5hk4L46c8r8sIZ5smGevRexGk
    6wM6XqNS+WvOm9YsYqV5vfImO7G3IKcX8vTYQmTrdYI00GKQveOW/wbYzvsx+3ooc5wLWQ
    WKGoh6mkulWd8ErPZGVDR2oSWAaqXPAsrstf5BiTciz0Ya8SW9Kebx9RiTrMneszhyC45P
    TqiyvbEsZOftchxZ2cRS/lPx3Ka8B5xx1MZ2b/2RO7juTsq9959n8NGvo/KQt/JvzfLz2Z
    ylRPnsUTHgTyV8cmbd4XKkt6gWhSM34DDOLgRZUQYSSw+iUfFC+J0jeo8Ty7xLc3RZ/TEm
    NlA0wtW1A4KXWtguDaQknGmHRHy4LInqghhNDusuOULFzpXZk4PIb/cVwyGyV4L/49yzX1
    sf1zrfcFMhbVcMF9lg8NzD5vvq3UiOJRCExXwoaXkNAWUAdSGaMP+9/dk+dQ
X-ME-Proxy: <xmx:SO0Ja9gQkudw8QcFaikBGy-ciJnYVlx0hJl-pZcqbWyGBzKKC1WusA>
    <xmx:SO0Jaxv-7TSB7ByvQPPCNLynytMeq3eD0MSKYm0jmxNH398Am75MWA>
    <xmx:SO0Ja4v5_WhnbGY0Qn291wXAwuYzzsE3XuzhshiDrVSTX1Z_aQMnHw>
    <xmx:SO0Ja-FlyG_s96iQwj41bHL2rBOJeZMmmo_dXuwkuFDBnZSrhJiCaQ>
    <xmx:SO0Ja4ZcQXCfE_Fc_ucHAWHvHxTv-1KJ2xhuCYc356lzHA6lOgryf1id>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 15:51:19 -0500 (EST)
From: Ian Bridges <icb@fastmail.org>
To: metze@samba.org
Cc: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	stable@vger.kernel.org,
	linkinjeon@kernel.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	sashiko-bot@kernel.org,
	Ian Bridges <icb@fastmail.org>
Subject: Re: [PATCH 2/2] smb: server: don't leak the smbdirect listener socket on errors
Date: Fri, 27 Nov 2026 14:51:15 -0600
Message-ID: <20261127205115.1646407-1-icb@fastmail.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <17d7f96be20a7eb039cbb3833598f634d786a487.1795797772.git.metze@samba.org>
References: <cover.1795797772.git.metze@samba.org> <17d7f96be20a7eb039cbb3833598f634d786a487.1795797772.git.metze@samba.org>
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

I tested this patch on ksmbd-for-next 3dcffd93d4da with KASAN and
kmemleak, using soft-RoCE. I started ksmbd ten times while another RDMA
CM listener held port 445, and ten times while one held port 5445. Each
start logged the failed bind. Without the patch, kmemleak reported the
listener socket and its rdma_cm id allocated in smb_direct_listen() as
leaked. With the patch it reported none. After the other listener was
gone, ksmbd listened again, and a Linux client mount over SMB Direct
read and wrote data correctly. KASAN reported nothing.

Reviewed-by: Ian Bridges <icb@fastmail.org>
Tested-by: Ian Bridges <icb@fastmail.org>
