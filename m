Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093593;
	b=svpX1bDkc1FWVJeZptvmaIdAMuely41yj/V7rtMgWay/im/Lnzc+4mCunwKhIBnsRuX3
	 nvFw3TLD0WeUWnp9SbgHTXGqRuKyTRSY7Fs4tHA+3wDFl7X8gKzS6GDXI1G7DFW9HE4WD
	 7KCvRomuEj2a5PnLEep0Rwh50A4hAb7UVtsbNhYltKORbWFvYbwuFjulWvOaoTJqLSAJr
	 YLBlwG8f8CxxODIITvOcXSfkxfo/QtB0MFoU7Kct/ZLEXuae2plHib86P+xKxZJQkwPLQ
	 axdNOv3i07wLA5I4iEPtmJtOBwbu36lmmCfanM4GP6fSm5Dgh4vOX9HiIaDihIpoTsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093593;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=hGrLVH1BlchFattWDn+R0YVHzglShyYtV7XYqAiG4RY=;
	b=Ht9Id7wSIYWxcYHQ1uhbqHB8WLNVl5G8beTr+I4SW7TNq9FFD20L3wg8RVLnnXnfTnDy
	 msNe+G7ufxcQRhIZaZj3xPYMYxDWnF04hbDSqQ0jO0swyyRwxd0ttaptNpCyZRTV8O9yG
	 P88YJUgFORdpHqiIgfbnCOAwiRxbQQyaXEXT1XKaSWHYcydawY7TZCxv8bqrwHsjoBLzn
	 eczYNpumIn1lQ7ezsB2IJZ+5bfoQThe7mtTDSnot8yK79AOIDPZClOVWF8YkL+D9T/78T
	 4sTw+9/oiJyVkJh9GnwbTQV49pgSDridgBjMH2twm3/lpxdTqgAqUCfXRm167pIFgdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=qRz41pQH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bQFxrjsE;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1FB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A1FB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=qRz41pQH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bQFxrjsE
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E99D1D00113
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:19:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 07 Nov 2026 18:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093592; x=
	1794179992; bh=hGrLVH1BlchFattWDn+R0YVHzglShyYtV7XYqAiG4RY=; b=q
	Rz41pQH2dllbx6/XpIs/ap5vaV3ZVIyEzH24tiB4SF2/pjPUjv9cJvNv0Gh/d5St
	fBY3sKX7wXybOheKKC34AU0UsJR1zne08qDUC5tzkPfgJN0WMhMyeH0ySsKgE2Rq
	4H5h6cvTjPjvKZQXpj+zXueXWJRODLdvqe6m1uM4LdSk/hPJsRBWqpfKJTcE/FUC
	sLvnAXGx9xsP5VEveb6Kb2uu0Zi6XhkortVKJ3tAmYqSH6RI68Ph0Gs8+gq2Qnc7
	ODm0tLQA22YsqZPI8Y3aL99RqJyiJjW6Lk49OrFkoaicWDTepczHZnOGqYjyaRDk
	NRH6l+mVHD7DMwctwCuRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794093592; x=1794179992; bh=hGrLVH1BlchFattWDn+R0YVHzglS
	hyYtV7XYqAiG4RY=; b=bQFxrjsEVgrvNEEkZm+A5rRPwxBKVyq2g5TAXLyDgl03
	rtlmymfVrPM9m2Xgm/T6WirtJewtwCa2MeGC/2qi1LrlTg0x+S4UN8MpmeIzgKM7
	/+OV7JsO2JRZeh66WnIki1djeVVH0iwZz+IZ7Lw+IVhcJrPP+6u3l9q2S/M/CguE
	Ig+1c62GiqUUCGEpAy+ZaG4zm5YZyjk5KEk6Zr0qAbCCKhkTewAs5DOppNHl9Ahq
	aYvJLQjyLEhVEY7wVPG/XfPkfrg3Tu6aQtqJBvVYGABHkXd24yUnVOlVLMHbR9ND
	YLrJmN2DU3qRV7hccL/Z+GVMWVhQbIPpAbBJf9N7OA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093592; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Avy03a10gWb76p69X3MUYsVQJyEuzvAJPnuNbTDpG/DHZ5v
	EX48fkOeyIj/rdFoINXplOBAARt1bUHJ5SngjcmvJSIlz+E70yzLR3oTEsIZCU9R
	EY1QvqFK4DkzXqC01XqlQfCOaAM4WQoUBz9DltMnZxQ5UDKpwH00uzjfe7oQ6L+G
	IWeMzNTQYueBnqSeLSnTneBDHVuBU4D7fwEIfVPCB46DW2UQND/pk4fiYepgI5aC
	motvf5pz2HaPhkvq3YpC9/DZa8OJPnFa6i6iFikr8vifBB7xVgEWWzs5/pYzX6eV
	me9bZetznxDLsvm+DpWXGLeUZ+X+bM2pZ4W/QVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6ykTQ17Z4Y+UosfVpyc67szv6e6xFVmMmKkiukeW6Nw=:19mJGyS7QTV0Wc/ZBlERB4eyM9fNO5oAEEhRkY8meMQ=;
X-ME-Sender: <xms:GLLvapj6RuReia2zFBgNk6VHW0JthJl__upLZ_WxCx9lua0dUne9kw>
    <xme:GLLvak9XHXL1aaEIxvwot9Ro8Z4-oKvptfwaFCXVmzPrD0I6q8G-84ybALzjdjZTT
    2f0Ubg2QHaHovQe0c3gvVfJxOht1BniDO5a6pRiHePXjJku52u7j2hY>
X-ME-Received: <xmr:GLLvauuR5W3AtyUQwIZfiry_HCHs5DfKRyfvnJMgpzPokgAAYJprAM3eEsYLtSd-voeXL2o>
X-ME-Proxy-Cause: dmFkZTFAFlDOvFwFUeAmNt0h0VqaTvV6TfMYwUU9FIzaVcnVOYbqdI1eimRdqxtvED64gI
    lEB+HweWXG1aCxz3xxaPJjHdKp6SXazJ9B3Jf/VpshJsi7GsfCwlarIK8CHnerjMJvIL4k
    O5Gz3IwLkEGO/mHiT0+10Pspgi4ay8DCJyj+rUktftbCK+zdqx/7t0WJD4nf0Vse/zEygf
    ZaBrfmhT8rTjh+f/HZX3l04oZro7HXU6KfLUcIBYR7r64s6bP1q68oi0XMfM2FhSJKQH5D
    ikz/BqR4dRVskz9ViQFNx07fOy4g9IuZh02tJGcWjUOXKD7m++ZSCtP7bMlFPf0FzpOKQY
    Jekm+qDbUZuM2pi6JnH2JWm6mL0e8Z/3tyOQAeF/Jm7nhg10d2yg7AGrK8eY5QVlXrciHg
    gIDmsaO2u4A85HnpyJv7qrNAd5zew7CUM/yFKBVoyXU6HggtNSccCZaKHWdVd+YAPtKzUq
    Ir+G6NvrfnmYMUXZHexxWjf6QSHFTnrOaN2BDn0GvLBBUuBKq1BD+MsHTvOnRB+tMt7QYX
    cW/z+MuTAFWLkYRyhR+Zd/bEDktPUxCkP727oDz00IkNFMsQROyzuJsY3xWH5Az3ytS0bt
    aRFx4iI5nXmxWZro1irGUo244anFQDab/8o7ZYgVdLokb+LoncBIY5NyRw7A
X-ME-Proxy: <xmx:GLLvajbE8cIM0ol4cAi53_wzPxokMLX9brzeHD2Th-OG-XTIV8VZ8Q>
    <xmx:GLLvamoEJo439t_AopK6uTxy_L8zGpaQ4KLYZHmqwmMCdu0u9H0xvA>
    <xmx:GLLvag8Kim3CMIIhdqnmgYivQt9ULVfR0F0Sb6nmVFaSkfFn6uM-Mg>
    <xmx:GLLvat_Lov8AAG8g3PKrvwjTJiEInfM2EuGwsh0k6c5TbJ1Frys5bw>
    <xmx:GLLvaiiNV-3X4ipfQSIHZ33Nx9z42yXJYWlYI45F-80zU26ahGVdkae5>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <stable@vger.kernel.org>; Sat, 7 Nov 2026 18:19:51 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Sat,  7 Nov 2026 18:19:11 -0500
Message-ID: <20261107231941.1871942-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107052252-failed-6.12-6320736af7dc@kernel.org>
References: <20261107052252-failed-6.12-6320736af7dc@kernel.org>
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

which failed to apply to the 6.12-stable tree:

  https://lore.kernel.org/stable/20261107052252-failed-6.12-6320736af7dc@kernel.org/
  https://lore.kernel.org/stable/20261107052248-failed-6.12-a518b9a9ef6e@kernel.org/

Patch 3 is a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection responses
with wrong ident"), which tightens the check added by patch 2 and only
applies on top of it.

The series goes on top of the three L2CAP patches already queued for
6.12.y:

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

