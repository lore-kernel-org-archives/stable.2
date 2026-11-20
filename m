Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182098;
	b=xRC2A3fe4jkIhmhnXqgc/zNu8TlCYQ2KEkSmPpmBmvPOFBIHvV3I5WA5pqAR8P2Brb7k
	 i8onf9OSZjKgF4TvSyRfgPP71fdYeauGLMar1wFonZOKJUVOUGPm/HdyAYcph75XtGdN8
	 uL5ajADxkJp8Z9E1i7uGzJueOTUy9do7Wntv2pMtgUTTiJDOydmoO6AGc8fve4KC7x/WV
	 c0vWyB/ufElsIp14zYSiYrNZ05r8mQTurx2gPBzpNz28JdnXlkWhKLstDKKtlBBCIkzv3
	 wxcx0cN8C74iJ29fIIQF1Efjbs406q74TQcXVIu+0zh9al4hNJogSRxDN+rS/wYOLjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182098;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=G0kPPdNTzeRCcZm0NzcTP3e6FuzOTd+f7at7BqtBxS8=;
	b=0oTnZDc1ySVc/UodeOcmrnmaAMr2DA+JzYrSY9Py3bflGPkVWlr0HR2zPGrnfzpbi8vn
	 8fp5mMqsZRoXI4fXfwvaW9hql4CcNommyUaZqTwvJVVF7v3gwrFmvfJxESzbFhviux/cE
	 H0an6z6RV79Q14rvLWYxq6VBd3D/h23ljzg4JRqFhUYygXUOC/Ai6W1HedL2taLppx6NT
	 ZeESYVUmoFkkf/r6UtjhReFTpMylUjFxSj63U4fhP2L4nfH83kGOH7kfE4YbSYBt34Hq/
	 pIfVEFq6ZP53FfxLxIjNWjbs+GC+shc0VrjftolN5He9307uv314GJZ4IfA1sP1rQNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EYscEoj9;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463860A2600;
	Fri, 20 Nov 2026 13:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9463860A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EYscEoj9
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 12AEC1A1748;
	Fri, 20 Nov 2026 13:41:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D2899601B9;
	Fri, 20 Nov 2026 13:41:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5554011BC01FA;
	Fri, 20 Nov 2026 14:41:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795182091; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=G0kPPdNTzeRCcZm0NzcTP3e6FuzOTd+f7at7BqtBxS8=;
	b=EYscEoj9YGnxqlJHMKsG6JZw95F1h+t2njcdESsHryNpDYMN7mkPyFtwVd0rnT4pSiRCXH
	Qs02vV6kGG5IRBy/26ighiaZbkvSX7cQf1ZeuX72BDUwvqWBlosmatNayyhKz651iB+S/5
	tgoTi5i9ta6xaUr0aJ/+1fPaX6TqxYhNwVvZJ7k2vrDvNHPUNZMtQdb9KcKvyJyS8pDftz
	pFQFO4aF1CYn2V0wxDdsGdWiqg+Hdrd30GHoxjWCNMVXVdUIj8BSnSZj1zrbLjtXbeAQ0y
	TffZmtSgHyQlIgxBxjmSR8Jsir+MgtIpdSKCQry2YX6uj40diKkzo/mhAl0KkA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Petr Vaganov <petrvaganoff@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  linux-wpan@vger.kernel.org,  davem@davemloft.net,  edumazet@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  horms@kernel.org,
  phoebe.buckheister@itwm.fraunhofer.de,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2 net] mac802154: fix uninit-value in
 ieee802154_header_create()
In-Reply-To: <20261120084537.31991-1-petrvaganoff@gmail.com> (Petr Vaganov's
	message of "Fri, 20 Nov 2026 15:45:37 +0700")
References: <20261116065235.27348-1-petrvaganoff@gmail.com>
	<20261120084537.31991-1-petrvaganoff@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Nov 2026 14:41:25 +0100
Message-ID: <877bi7boxm.fsf@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 20/11/2026 at 15:45:37 +07, Petr Vaganov <petrvaganoff@gmail.com> wrote:

> During fuzz testing, the following issue was discovered:
>
> BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
> BUG: KMSAN: uninit-value in ieee802154_hdr_push+0xa62/0xb20 net/ieee802154/header_ops.c:108
>  ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
>  ieee802154_hdr_push+0xa62/0xb20 net/ieee802154/header_ops.c:108
>  ieee802154_header_create+0xa83/0xd20 net/mac802154/iface.c:396
>  wpan_dev_hard_header include/net/cfg802154.h:525 [inline]
>  dgram_sendmsg+0xc6d/0x15d0 net/ieee802154/socket.c:677
>  ieee802154_sock_sendmsg+0x8f/0xd0 net/ieee802154/socket.c:96
>  sock_sendmsg_nosec net/socket.c:711 [inline]
>  __sock_sendmsg+0x2f3/0x360 net/socket.c:726
>  ____sys_sendmsg+0x960/0xc30 net/socket.c:2581
>  ___sys_sendmsg+0x285/0x3e0 net/socket.c:2635
>  __sys_sendmmsg+0x33c/0x950 net/socket.c:2724
>  __do_sys_sendmmsg net/socket.c:2751 [inline]
>  __se_sys_sendmmsg net/socket.c:2748 [inline]
>  __x64_sys_sendmmsg+0xc6/0x150 net/socket.c:2748
>  x64_sys_call+0x12a8/0x3cf0 arch/x86/include/generated/asm/syscalls_64.h:308
>  do_syscall_x64 arch/x86/entry/common.c:47 [inline]
>  do_syscall_64+0xd9/0x1c0 arch/x86/entry/common.c:78
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was stored to memory at:
>  ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:51 [inline]
>  ieee802154_hdr_push+0xa5b/0xb20 net/ieee802154/header_ops.c:108
>  ieee802154_header_create+0xa83/0xd20 net/mac802154/iface.c:396
>  wpan_dev_hard_header include/net/cfg802154.h:525 [inline]
>  dgram_sendmsg+0xc6d/0x15d0 net/ieee802154/socket.c:677
>  ieee802154_sock_sendmsg+0x8f/0xd0 net/ieee802154/socket.c:96
>  sock_sendmsg_nosec net/socket.c:711 [inline]
>  __sock_sendmsg+0x2f3/0x360 net/socket.c:726
>  ____sys_sendmsg+0x960/0xc30 net/socket.c:2581
>  ___sys_sendmsg+0x285/0x3e0 net/socket.c:2635
>  __sys_sendmmsg+0x33c/0x950 net/socket.c:2724
>  __do_sys_sendmmsg net/socket.c:2751 [inline]
>  __se_sys_sendmmsg net/socket.c:2748 [inline]
>  __x64_sys_sendmmsg+0xc6/0x150 net/socket.c:2748
>  x64_sys_call+0x12a8/0x3cf0 arch/x86/include/generated/asm/syscalls_64.h:310
>  do_syscall_x64 arch/x86/entry/common.c:47 [inline]
>  do_syscall_64+0xd9/0x1c0 arch/x86/entry/common.c:78
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Both ieee802154_header_create() and mac802154_header_create() declare
> struct ieee802154_hdr hdr on the stack and clear only hdr.fc via
> memset. This leaves hdr.sec uninitialized.
>
> There are two ways uninitialized hdr.sec fields can be read:
>
> 1. ieee802154_header_create() had a pre-existing assignment:
>
>        hdr.fc.security_enabled = cb->secen;
>
>    This could set security_enabled = 1 from a stale cb->secen (e.g.,
>    after WPAN_SECURITY_ON followed by WPAN_SECURITY_DEFAULT), even when
>    mac802154_set_header_security() returns without initializing hdr.sec.
>    ieee802154_hdr_push_sechdr() would then read uninitialized hdr.sec.
>
> 2. mac802154_set_header_security() never writes sec.frame_counter.
>    ieee802154_hdr_push_sechdr() copies it from the stack into the skb
>    before mac802154_llsec_encrypt() sets the real value. If encryption
>    fails, or via AF_PACKET taps in dev_queue_xmit_nit(), the
>    uninitialized bytes are exposed to userspace.
>
> Fix both issues by replacing memset(&hdr.fc, ...) with
> memset(&hdr, ...) in both functions, which zeros hdr.sec entirely
> before mac802154_set_header_security() is called. The stale
> hdr.fc.security_enabled assignment is also removed as it is now
> superseded by the full zero-initialization.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Closes: https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
> Closes: https://syzkaller.appspot.com/bug?id=23f21e76e9d2d1ed587cb5e71515260d6d025b63
> Fixes: f30be4d53cad ("mac802154: integrate llsec with wpan devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
