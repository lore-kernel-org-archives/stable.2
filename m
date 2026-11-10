Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338038;
	b=DR1thazJ/N5Rq0RILYuyVMj/5fB1S6NR/O9WkHcBXLwTr6h0CFxmKnGx6gWi5RT+Cygb
	 TeYAdx2H6QGPUj4Hj9nDoIK/fYBFVZ21J+3ib5RBgrH4gzsHfFX0OKgvIJjv/Mp12lIba
	 3uw/yigxD++FYL3nhyNbkcYDh/KyAkGL0xb+pMi4vemZjpi8+FspRSNUxzIdRar8MNnl2
	 hptdsWysNnqPh8hSAx/t+tkScPVQYlVT1FQuET2FbWaFYI/sPVuqdBfbZwegwMOFnQTWQ
	 n9mN8hWhr1jpBJr/Cl7wrUOqKTmo1W4c2Ohqb2li+dnjoAndrM2ecngPg2DUu4rOTFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338038;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=4bV+zRiJ72TGFxkbB472+Czu8JHxxmPgZ33eM0p2I3k=;
	b=imviqnJzJfW6smjMN/kRor7lX8adelodYbPYSu3gDgIRHBKDroPdI7aCOHfLFGQ0Nj+f
	 FicLBe8VIcUJfG08uMXlYt47o53tVgmnRQGV3UojkCJmIe0ZslEEVz63WVKbxiinRZ267
	 zLOuwoi/IurxI1VevuCV/QKIdDkp+AYoAhjiy/9sr0d8jKGVeVx5Msc9a5wb1acZ++6dN
	 SERe6N9jygvtJIAdq3b9gbUK+W9sFxhD9QH9DyM+cLspMyAeq3+67pnf26Eh/uFcoUQwP
	 KHCEke3F3uUZoYmJ945uZR8H22/3rNPn0V1blkzYGHuuNNWXaEN2zR2xO00wXoLKhAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=cWln7XVB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="l/klUr6P";
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3025606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3025606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=cWln7XVB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=l/klUr6P
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 046D9EC05D0
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:13:57 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 14:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794338036;
	 x=1794424436; bh=4bV+zRiJ72TGFxkbB472+Czu8JHxxmPgZ33eM0p2I3k=; b=
	cWln7XVBbhQWlVHS4pc2ujFpfrtnRoS9lP+MwXdxV4ptYNGa0YHxFnsz53ehYvYb
	G8q5T1R7NEEQn/q9eQs7ZRPanCztS5kIQcvccbM8QeTlcSBN/8lF9GREB+BnIBsQ
	zSvqfnJslUO0/QBbYiigclrIqiM/DQqwX6WWqlmNEA42GFlgAm7X4UEmJDZ/0tf4
	nvPjH+Xdjm0CXcPr1B06lKq85aRo8DeZZF00iPxE6dXE5cwtHqkdnvDBO+f7v8o3
	48Q+wyw9rXF40UYHT53cPwTdwIO9MjDGZI1Kz4jiL5qnreWYdpCgvPZJsUNzd5wz
	bAo7ztXbz6vs/Fj8JNdNkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794338036; x=
	1794424436; bh=4bV+zRiJ72TGFxkbB472+Czu8JHxxmPgZ33eM0p2I3k=; b=l
	/klUr6PCowgqcrAoWHQN0GnmypJoaC4On92+I9xAjirYXFF0B4l79iBmMTssw22W
	Ixw/CFnbJ/dLkX0swJiOMBkpFEZsYRtKigcT33rd3u9gVjC9Fz5NUMX00g1FsY3P
	WjghrEOGiwcg64ug+AbmcEklo29UNCWnSGJbAmNNos+jFwVchlkyZCK98/n4ETXE
	7vKW+dd46tKoaCpyZfW3Jy2QetoR0MbFuNUUsHmqhbpdlLRsdm+rGUvEgOjsbV6T
	A3GF68FxLSYUTtOpLp78IRi3FGNcCSbFfNdSH3eQRv4XWZT0IQOEMyYMkY9XWJom
	92Wa9TEygVZqNGEOaPflg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794338036; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:maTIhCkYRCGQymkipnZ3Jn5tfZL42JVdeQsJEJ57/cjQxlx
	36obWTh9eM7Hk01XB/yoru1hMZatQuTPElOFeUKXgX/Gf5nwWa3cXpfugei2+MWg
	gTNnRlJxYwDX+/67Fx/KHBk8bPaQgqxub2BNjGcYh2slnYSMhEnOpRLQy4uUF3na
	eCJBZzSpRfG5e94MD1/oFflJFOn1Eurig/xpA9ILZYKwmpsgh/ZFm/z6dm+Tr20A
	MAPPAGE+fnQjplfOfKCUvhW7lipgBwOZqC/pUmHpsKVzWC5iu0bEbLqi/yLLh5QV
	NBKi0yKOv6uHCX/MJdVhHnGmCHvLPI0RwIaje5A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tAa9xTOLPSbwHanMGhZrVdP3oCg0xFRbrtiaxGmRzOM=:PfI1OTgPcLk/yrbIP9HKyzvRt+6Aw1vGkqiEj3WQ4hY=;
X-ME-Sender: <xms:9GzzaqgChZn5N_O2rHNFiu9x3VL2TFoN_Z-9oxDWfF4RhNBp0zlOzg>
    <xme:9Gzzal3lc9yAWorQP6RFUu4_RmPgG6kdPug_YI3MUgfyLl5g5njO_fG0Sc0XKYkKb
    Ohuk6Fcv4fMDcUFeJ_Nb7rS-3zI2nl2GJogxZziCebDmu9VX5vuPDWc>
X-ME-Proxy-Cause: dmFkZTGRC30El+L2msUGwhD0Z8Zd/j6rXSdGrW6fpd1Ui4EWWQx7azf5/BN9fGLunI54f9
    qd2R6MeCVaSqW3rzC/klwQ+7LZ7piNWl4LhcNojtE4gh37v/2TcdWktBf63Pse1+hqQvhJ
    KeqEUE5fSJ2rq0CQOSIqfsIwAf+QfXOuo/X8KzifEhZLxLWxszAPoXg0foL1iEkQVDxn5u
    x8q6T0SO5rMn4KTuir5sDh3vYCOF2c8m3WYL/8GBQGOZBTVTgJKtGd2zvBf7BtXQ7s1zMD
    Opu1of42svQCiyiMvTBcxQHpxPFq9/PBXNgRHm0yFm1pQo5Fd0+f0WCgUwR3SVSDB7ksOl
    71JHJDhHQUvIREStbYzKqDQMqK+mBIYoFKsz/yZCpYhJGnD8nEbqWtKfPtzyuiNOYx3UPD
    jbK29iUmD5ld7zkMMCgJcgsBGtNNuFKtOsTnpJvFPUe1HmxOWp/y48/FHYYHGmqMSKZgEN
    GEaSmAlBB9EtuRKD0vkOOxWoOvNANlAyaXKEe6VFa3vf2WxugRltXMBv+95U16li2F31/R
    VHIqXHgr70D0uu8KPCbrDW2zTq+A2UnTSNHI6n5ITJ5WtljWfZElBdXsa0aunL5upnpXOq
    TWg5tBAzVRsI6Ef0rNo4+kLU3niyQvFUyVLrZ73aZPAKRtsap+p6/XisUVgQ
X-ME-Proxy: <xmx:9Gzzar_ErdTb9E8kbA0scU2k5GAkvroAXNdv-srlsIBoR6-UNfdwqw>
    <xmx:9Gzzavfinpd3C9_ow3EYMFOG8w7M3iOYQqmvvBF3rhKt1rB7U1GkMA>
    <xmx:9GzzasEIpibmKfKhor7XTXsjpYz-m_N50s9Q-rtxoaqZfhCxp47JEg>
    <xmx:9GzzalehDBtUZv2tC0ZeLYWnik3e0DqD9bnerkxNE31tEX9bxqTfvg>
    <xmx:9GzzakMGyR1uFk2vbfBIWxqwfsvAWDCyweDIPygAeWYcyNvav8TxglIZ>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BE396216008A; Tue, 10 Nov 2026 14:13:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A27n4ETjY7Bw
Date: Tue, 10 Nov 2026 14:13:29 -0500
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Sasha Levin" <sashal@kernel.org>, stable@vger.kernel.org
Cc: "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>
Message-Id: <8ebaae34-5380-438a-96f0-bc6d7fac4b2a@app.fastmail.com>
In-Reply-To: <2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org>
References: <20261109015902.3034747-1-oss@fourdim.xyz>
 <2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org>
Subject: Re: [PATCH 5.15.y v2 0/3] Bluetooth: L2CAP: signalling response fixes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Nov 9, 2026, at 10:53 AM, Sasha Levin wrote:
>> Bluetooth: L2CAP: signalling response fixes
>
> Thanks for the v2. The 5.15 and 5.10 series add AMP/A2MP hunks that are not in
> 6320736af7dc ("Bluetooth: L2CAP: Reject signalling responses in invalid
> states"), a518b9a9ef6e ("Bluetooth: L2CAP: Only accept connection responses to
> outstanding requests") or a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection
> responses with wrong ident").
>
> Luiz, could you ack those AMP extras? I will queue both series once there is an
> ack.
>

Hi Sasha,

I would like to drop these AMP extra fixes to make the changes consistent.
Patch v3 sent.

> -- 
> Thanks,
> Sasha

Best,
Siwei
