Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913579;
	b=C1QGEQa8K2kmm3Q7uYK31qJsseRaCjVlQBC3waLicego4dVT55xuo9dGf3fjEoCj2tz0
	 0YX40o4nSlnYra5vvb/WCYdKIlz3Xod6ON0kgeYCJiQ6k3EZ2F67m7gsAq6ees42I1k4I
	 Ct2Slvf85oCj8497kDIDZH66QKw+TaS95YcSqKnlDx2VOqzJMN6xFlpj0fxzpl3OyrLGM
	 kyNODtHDLuW/oorxbRM96rsesPcHRNj9FW6NO5eEt91moO8f6C+eMvUD8PC3/kwmN/fOi
	 ivhNB+mYDBYAyLpixmdD7JouEevHKrOTEB7PWTfkSWeUwhWks/pE306Z48TMgPUb23A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913579;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=y3gUkGRr0U1p2ZCNesM9xfptWY2/llhKtyiVyy36QM4=;
	b=TFHLXkGpfniMej5q3KpYnoOEBtiWiGozdDt0Fk8MYtapPQvYigBI+a4beFkr3qfTXkqz
	 1YZRC3I0a0+ZH+XK6Zv87fdPEwVzcAH575D8+lWabs/ziqKI3Uvy26yQmh4G8usi6RQ2l
	 E+9432zHOLXPb/2t44D8V/vYcNvknr86/wXatyOlJWv7oAOyleANMYLUiEWjtUUsOX43b
	 tEsrk0iZ4SarVrcncDZZRbRxny+8Ny90MBKj+I7owYq56AW2Fp1p2cB4gSl6OxYD56QSX
	 kIloLxNHFMps+tTFyL/mrv2eXPgw1N/eziKhzKeB+Ad4vzWRmgxTDLHV3rXgYQfU40w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yJNDrt6G;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35726606A31C;
	Tue, 17 Nov 2026 11:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35726606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yJNDrt6G
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B00D91A1605;
	Tue, 17 Nov 2026 11:06:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 74F095FC81;
	Tue, 17 Nov 2026 11:06:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D8A711BC0493;
	Tue, 17 Nov 2026 12:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794913572; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=y3gUkGRr0U1p2ZCNesM9xfptWY2/llhKtyiVyy36QM4=;
	b=yJNDrt6GP4E62RqG9gzmjY5xkLYVMACBX7hpOVMbd/yb3GDgPTc3Z+OHXJUSvjcp+GmfR9
	9yjBcGZ8XOEQrZcwL+i9MiMadJusbAnUczI+SDShsMcnWMVzQv1FAXiK00c8cIS90hq9r1
	xjr1wOuEEgPn5ErFtRKWVB+6IErAe2GJe8c4XPmrtnIiSORq9WRW3QTF45DEBWlsj4J6gt
	VRCQitDPrUDCtL6E8f1X1EppcQbjyyE3tlJk6twendRCs1TUxLWSbNlkUlHeNoXcn3WFR2
	5eRy8ly1H138an0K1OLpt8/qurzk6GQQl0Kj/WMOg8Sh9wSFGzKveo6RQkogVA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Petr Vaganov <petrvaganoff@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  linux-wpan@vger.kernel.org,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@kernel.org>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Phoebe Buckheister
 <phoebe.buckheister@itwm.fraunhofer.de>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  lvc-project@linuxtesting.org,
  stable@vger.kernel.org
Subject: Re: [PATCH net] mac802154: remove redundant security_enabled
 assignment
In-Reply-To: <20261116065235.27348-1-petrvaganoff@gmail.com> (Petr Vaganov's
	message of "Mon, 16 Nov 2026 13:52:34 +0700")
References: <20261116065235.27348-1-petrvaganoff@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 17 Nov 2026 12:06:05 +0100
Message-ID: <87y0arlntu.fsf@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 16/11/2026 at 13:52:34 +07, Petr Vaganov <petrvaganoff@gmail.com> wrote:

> During fuzz testing, the following issue was discovered:
>
> BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154/hea=
der_ops.c:54 [inline]
> BUG: KMSAN: uninit-value in ieee802154_hdr_push+0xa62/0xb20 net/ieee80215=
4/header_ops.c:108
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
>  x64_sys_call+0x12a8/0x3cf0 arch/x86/include/generated/asm/syscalls_64.h:=
308
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
>  x64_sys_call+0x12a8/0x3cf0 arch/x86/include/generated/asm/syscalls_64.h:=
308
>  do_syscall_x64 arch/x86/entry/common.c:47 [inline]
>  do_syscall_64+0xd9/0x1c0 arch/x86/entry/common.c:78
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Commit f30be4d53cad ("mac802154: integrate llsec with wpan devices")
> introduced mac802154_set_header_security() as the sole function
> responsible for enabling frame-level security: it sets both
> hdr->fc.security_enabled =3D 1 and initializes hdr->sec together,
> maintaining the invariant that security_enabled =3D 1 implies hdr->sec
> is initialized.
>
> However, ieee802154_header_create() was left with a pre-existing
> assignment:
>
>     hdr.fc.security_enabled =3D cb->secen;
>
> This assignment can set security_enabled =3D 1 (from a stale cb->secen)
> even when mac802154_set_header_security() returns 0 without initializing
> hdr.sec, violating that invariant. ieee802154_hdr_push_sechdr() then
> reads uninitialized hdr.sec fields.
>
> The stale value in cb->secen arises from a specific setsockopt()
> sequence: calling WPAN_SECURITY_ON (secen_override=3D1, secen=3D1) and
> then WPAN_SECURITY_DEFAULT (secen_override=3D0, secen unchanged at 1).
> This undocumented combination likely explains why the bug was rarely
> triggered.
>
> Remove the redundant assignment; mac802154_set_header_security() is the
> only correct place to set security_enabled.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Closes: https://syzkaller.appspot.com/bug?extid=3D60a66d44892b66b56545
> Closes: https://syzkaller.appspot.com/bug?id=3D23f21e76e9d2d1ed587cb5e715=
15260d6d025b63
> Fixes: f30be4d53cad ("mac802154: integrate llsec with wpan devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
> ---
>  net/mac802154/iface.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index f437b8daa00d..7b7332805ecc 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -368,7 +368,6 @@ static int ieee802154_header_create(struct sk_buff *s=
kb,
>=20=20
>  	memset(&hdr.fc, 0, sizeof(hdr.fc));
>  	hdr.fc.type =3D cb->type;
> -	hdr.fc.security_enabled =3D cb->secen;
>  	hdr.fc.ack_request =3D cb->ackreq;
>  	hdr.seq =3D atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;

There has been a similar patch in 2023 but it was never updated by the
author. Fixes tag is better here, it should be taken.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
