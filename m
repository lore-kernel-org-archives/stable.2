Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A13D6CB2
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589320; cv=pass; b=t36uLWKnqy0lNdZW46LgMAf2UfhN1w+ARLWRN+o35Tq2o7wAcp8HxD0talBR88fr7wXIvsOAX1zGh68hPygWQfrkQIqP7XCwlUpAcZslt6GOJMhxQfj8LU4mgoLLPdWq97Q22yCFAAxJRUbNPUJE9BswvMUO+HWecAhOzloUzWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589320; c=relaxed/simple;
	bh=Z3jnfgMw6pkdUvhW4Dhi6EEA51GOG97KK4o3VGAeE+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pItxQMcvpn74tzTUnYLEljqXgZF7RFwHGGHQQ/rUDYN1WBINO1Ib2K4ceb4zI1mikyUPfrjlRZU0uYtRCEFeJ1NLDP8Cc4FY6QosDzpsQrtbNcshYu9O79xgk3nN3LceW0VDG5+j3TnbRNvWjXhRGXCHBqFCIdaKaXn3r00b+Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UosNyJBx; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UosNyJBx"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa7a7ad4d3so3615946e87.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781589317; cv=none;
        d=google.com; s=arc-20240605;
        b=ZqovddjcSVxIFU0iIoq8OorjpRAgeUxIIZ62O/N9NKHvn21Rwi0brub21VjoWvYc+v
         igmJ2pBbdhex069RHc6wAek/nKuphQjdQKt6JcEjMDRjbX7kGVyuQoZBKzUzoaHs44fe
         GsIhvVTgezGb0I6/gVjSgZUJnzje8x69fkOyu9a0hlaXdBhTkYjrTwGYypAYzMcUJIDP
         9hv1FzjeRf3goilEFfluQurzHFqZNP2bMx9JsLGc2/p8DZXD36b+Krq8R9MqVf5O9a4b
         SgBX0rEm3oJWUFkUQ/WoARZcRvZa+4cTbqPCI/ucCxHVAU2MM/UZmcTkLEG8EtBWeFrC
         4zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=86O3OSyFfFjtEnp02Mufd0amyT+kxpMUNNgqXPU8C3s=;
        fh=Hhj31Y0K6SBAut0CYC5nc2SjAlRnoPJy6mL/TczdNXs=;
        b=QgEFer9QDtXE6Bvf0qX50CWUwogpVIzibZlR8CxXBy//0RE+MlgWTV3wkilJSpY3DV
         RePL88xWSfDMvHZEMV0KeKSreVrqcF4S+8XPG63wIp7Xa0BFlalpPeN+Byib2cqfFJHi
         hCd0v18x1/yAOzbxP89Lm51nquAxwRmvRm2b+akMeDjEpaWUg8+LcKsKNSzRzy4Loq3e
         AxCdObeW15/uUzeQiKxKv3UIUMJ4j2YKvpmCV7HlIYRY6NUvqhoDSgUUUOXkTDvt1NVU
         lQ5HyF0jza1XiQNa10vJUAjPCqSpsUBaI4lQGbL52xUpaUokfZNmGA4Fgjzeho3M3zCO
         w+KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781589317; x=1782194117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86O3OSyFfFjtEnp02Mufd0amyT+kxpMUNNgqXPU8C3s=;
        b=UosNyJBxSsaEt0xGrFGBSiWiREpMC13dBwx0YjyGBdb1kpz1W/FGir2lpqC40xx6kL
         eDP9ZI1XSWg9aHOHp1UdbPPL22Vxmo9TykNhl4PjVQYx2dSyKU3YvLxA4RM48GSaSFBW
         G1+bxmdfJCFo6ERajHvUDNkXYqlHK0eCOJ6TaPD008pI45I+OJ+bYmw31qtypMyn21+d
         PAWi+8ljGQhiaMw7d5AI/RSVPxn1sKbWcl2qd8QQuoZG2qQh9ztspPGh7IvavPiSxVMf
         zA/4M6BZfGUV88BZuVPCO6ERTcP0dEWb6K51LNpyzyJU8Wbjvq7IJYiQxqm6VzeU+md4
         VMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781589317; x=1782194117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=86O3OSyFfFjtEnp02Mufd0amyT+kxpMUNNgqXPU8C3s=;
        b=Z/CbnLz/b7/93SLzamo5dYeRZ/w8IjgQFZs3z0/vFwaXFPhTHmhjfxPWVleM45ewBt
         j4ifEJKYQtrKx8R8lYOeJQvhuGOUNUg2TIGSIKd0qdtq2Sce8Xc+oiLCSpd7r0HC5g7/
         O9C1xuTh3nP1D9D1oy48EqH+H89VlhSiTmu0UAoTCBxo8D5SOi3qxgClUcBc8add4OCC
         ejmreO6RUCnV7x3eH06XrhRfTfZAosgPUdQg3g19QXsLJjINIOgSmg4QI0WOhcUZ3pNw
         zM0uWraXG+lWx8buR30XlVcSCt8RYoPVkNyKTbax8Cq56JLMahrjNzqTGal8lYQFTOYx
         Q4hw==
X-Forwarded-Encrypted: i=1; AFNElJ8b5i7k2cOZ+71ric24B+kUBXgtWN/Zy88Vl3wgMPvbpAupYqMHIDYWnCAeOPYuPk6YY+T14tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+VL6KGAckviKoU2ooEwvIjIGY1cqJXTa/96wWzoVq5Ytwq0SU
	jVk2V5zvvv8h4Tn54r8XkOmEuRjhR33Q2a1Qk7gIIAiIbC8VvnR+nUCe/EINQTeKsr7cezkfc1t
	8Fcjx7ijGQSYZRIhE1HsiU3d96maI+eecre66LWM0
X-Gm-Gg: Acq92OEwLn/cZruXbAZLunEGTIWE7sMZIr1TMJYDjWIqleScNh3b1ROOMWFvQ8A+dXC
	xaF6LMWNho3kQQSsCKIvyYiuVwMwQP1dL46WUWy8k3fif+JYlSOPs3rXLZC3GeR8Nfuhp4LaEcv
	u3b+c8+PJVnT0aGENg5W3crEMhxKflKxwdgpe807sRgIglO02O6U4gEB8Rt681u6Zi4CyiuOK9R
	Tene/YU7TOdxzzaCEMBFGTTqxriY5UlS9PRbn6FylF4kkUjCV4SxuKWtc3li4oAFsqA947VMVmE
	++CSnw==
X-Received: by 2002:a05:6512:118c:b0:5aa:671d:9966 with SMTP id
 2adb3069b0e04-5ad43216586mr600774e87.6.1781589316489; Mon, 15 Jun 2026
 22:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpSM+TbMOPL93CkWtrYjYW+T+Q+iWuo+ZhfutYNFOuOCBU5fQ@mail.gmail.com>
 <20260506202842.1788682-1-kpberry@google.com> <20260506202842.1788682-2-kpberry@google.com>
 <2026061617-flyable-civic-a986@gregkh>
In-Reply-To: <2026061617-flyable-civic-a986@gregkh>
From: Kevin Berry <kpberry@google.com>
Date: Tue, 16 Jun 2026 01:55:04 -0400
X-Gm-Features: AVVi8CdwOzb5NX-Ni6CO2HpFzYvlbxAuOLezHmBwTkmzUTMm8Y5ZFVZ_KXaIg4Q
Message-ID: <CAMAJAJE+w+vYwcEzkZoNDwoAC3PzJ54sGGr7s+5edBW3JJFKHQ@mail.gmail.com>
Subject: Re: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: xmei5@asu.edu, bestswngs@gmail.com, chenglongtang@google.com, 
	joneslee@google.com, pabeni@redhat.com, rnj@google.com, 
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hm, looks like the patch context changed because commit ce7a381697cb3
("net: bonding: add broadcast_neighbor option for 802.3ad") was
applied to the 6.6 stable tree after I sent my patch. With that,
though, Xiang's original commit 2884bf72fb8f ("net: bonding: fix
use-after-free in bond_xmit_broadcast()") applies cleanly to 6.6 and
should fix the double-free. Would it be possible to cherry-pick that?

-Kevin

On Tue, Jun 16, 2026 at 1:13=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 06, 2026 at 08:28:42PM +0000, Kevin Berry wrote:
> > From: Xiang Mei <xmei5@asu.edu>
> >
> > commit 2884bf72fb8f03409e423397319205de48adca16 upstream.
> >
> > bond_xmit_broadcast() reuses the original skb for the last slave
> > (determined by bond_is_last_slave()) and clones it for others.
> > Concurrent slave enslave/release can mutate the slave list during
> > RCU-protected iteration, changing which slave is "last" mid-loop.
> > This causes the original skb to be double-consumed (double-freed).
> >
> > Replace the racy bond_is_last_slave() check with a simple index
> > comparison (i + 1 =3D=3D slaves_count) against the pre-snapshot slave
> > count taken via READ_ONCE() before the loop.  This preserves the
> > zero-copy optimization for the last slave while making the "last"
> > determination stable against concurrent list mutations.
> >
> > The UAF can trigger the following crash:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in skb_clone
> > Read of size 8 at addr ffff888100ef8d40 by task exploit/147
> >
> > CPU: 1 UID: 0 PID: 147 Comm: exploit Not tainted 7.0.0-rc3+ #4 PREEMPTL=
AZY
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl (lib/dump_stack.c:123)
> >  print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
> >  kasan_report (mm/kasan/report.c:597)
> >  skb_clone (include/linux/skbuff.h:1724 include/linux/skbuff.h:1792 inc=
lude/linux/skbuff.h:3396 net/core/skbuff.c:2108)
> >  bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5334)
> >  bond_start_xmit (drivers/net/bonding/bond_main.c:5567 drivers/net/bond=
ing/bond_main.c:5593)
> >  dev_hard_start_xmit (include/linux/netdevice.h:5325 include/linux/netd=
evice.h:5334 net/core/dev.c:3871 net/core/dev.c:3887)
> >  __dev_queue_xmit (include/linux/netdevice.h:3601 net/core/dev.c:4838)
> >  ip6_finish_output2 (include/net/neighbour.h:540 include/net/neighbour.=
h:554 net/ipv6/ip6_output.c:136)
> >  ip6_finish_output (net/ipv6/ip6_output.c:208 net/ipv6/ip6_output.c:219=
)
> >  ip6_output (net/ipv6/ip6_output.c:250)
> >  ip6_send_skb (net/ipv6/ip6_output.c:1985)
> >  udp_v6_send_skb (net/ipv6/udp.c:1442)
> >  udpv6_sendmsg (net/ipv6/udp.c:1733)
> >  __sys_sendto (net/socket.c:730 net/socket.c:742 net/socket.c:2206)
> >  __x64_sys_sendto (net/socket.c:2209)
> >  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_6=
4.c:94)
> >  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> >  </TASK>
> >
> > Allocated by task 147:
> >
> > Freed by task 147:
> >
> > The buggy address belongs to the object at ffff888100ef8c80
> >  which belongs to the cache skbuff_head_cache of size 224
> > The buggy address is located 192 bytes inside of
> >  freed 224-byte region [ffff888100ef8c80, ffff888100ef8d60)
> >
> > Memory state around the buggy address:
> >  ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >                                                     ^
> >  ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
> >  ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return valu=
e error bug")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > Link: https://patch.msgid.link/20260326075553.3960562-1-xmei5@asu.edu
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Kevin Berry <kpberry@google.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/net/bonding/bond_main.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
> > index 114ebaa284da..6484ba1ab14c 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -5280,18 +5280,22 @@ static netdev_tx_t bond_xmit_broadcast(struct s=
k_buff *skb,
> >                                      struct net_device *bond_dev)
> >  {
> >       struct bonding *bond =3D netdev_priv(bond_dev);
> > -     struct slave *slave =3D NULL;
> > -     struct list_head *iter;
> > +     struct bond_up_slave *slaves;
> >       bool xmit_suc =3D false;
> >       bool skb_used =3D false;
> > +     int slaves_count, i;
> >
> > -     bond_for_each_slave_rcu(bond, slave, iter) {
> > +     slaves =3D rcu_dereference(bond->all_slaves);
> > +
> > +     slaves_count =3D slaves ? READ_ONCE(slaves->count) : 0;
> > +     for (i =3D 0; i < slaves_count; i++) {
> > +             struct slave *slave =3D slaves->arr[i];
> >               struct sk_buff *skb2;
> >
> >               if (!(bond_slave_is_up(slave) && slave->link =3D=3D BOND_=
LINK_UP))
> >                       continue;
> >
> > -             if (bond_is_last_slave(bond, slave)) {
> > +             if (i + 1 =3D=3D slaves_count) {
> >                       skb2 =3D skb;
> >                       skb_used =3D true;
> >               } else {
> >
> > base-commit: 258cf62a6dfde3c6a39d120a56a298f2ed6a8901
> > --
> > 2.54.0.563.g4f69b47b94-goog
> >
> >
>
> Does not apply at all :(
