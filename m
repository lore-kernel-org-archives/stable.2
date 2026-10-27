Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106200;
	b=RiGzaZQ5KPlRSOggNgA2gjkTX4Pvx2Csaa/LmIQ0RYDN2VHIrAf25/eOp8vbOguVZBND
	 hbOQdABmF9kRW5gFAhn5XLusiC63pHr4aJtPE7A/+SJUq5Lrgl3hLmr/BTUeErwqeiiry
	 oo2CHqL69IjUQtTtIppSwOYO8McoV0k//tRuh0XDQfnKt6WZx5KpaUv0qNZ+jdzGKMPoK
	 LTolae7SRM/7mXcC5FFZrCuCmYNmmWxMPt+mM/Fa1YdvCxFMxRkSCcH5ekDWzAz3tcXnm
	 QMSwY8NbfmzV69aNVoTrXO5aPi6C3EZ5crUKLa+418i159YCdPcrMehuzAkTkdEzf1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106200;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gmp1+598YRgh8xV6vRtgePkT+IRpuCg0m/DIj26GqFI=;
	b=kyk4fNwEThakbOz6nDVSZCH2yC6lrep2j2nkdnVmmggNrDz1MCmdboMWVf0Xa3e6eTVc
	 wFc86Cr1sBwWC1YgPBRHlKaws9PJ2WawmZaOzD/m97XcB86tTo3+AMPRDqDqw+/C7INEz
	 U3DffC4x06PxGwgyW2peUZPysBxH8hCv6pXHsGkIGiiAHOmLOwwR+YwVL9qnqKPNiefs6
	 +ymWFTeFXDeuQH/BYOlS8b0m+lOT6NVXS77nJmcBeHSy5dm3dUJ4tBNOz2FdOjnDZFRoo
	 2leKrTYdbW4MQlXRWWL5b08I2tdsTVK0EMEtxpTHrzh8KDM06Rp60HQTNeUP9DKw0/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zb0+D6Hm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18AF606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zb0+D6Hm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543391F031E3
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106194;
	bh=gmp1+598YRgh8xV6vRtgePkT+IRpuCg0m/DIj26GqFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Zb0+D6HmPiKSpTqonVpxXsiXeOTH+oqCk7Iio8ruOww1rFr+CxM/ODGBvWpPShKKD
	 pwjhdNOVMw2TkdrfC52ZMGS4M5aUkXRAn6pqS0bUi8kZi1KBBQRHI9SpBahgNb4vVb
	 BVaoij/PjwaH265ov6Fg9UIteyUiAhqj3Wl5HieRgALSFvnInFjy2iXjg74p76ioCq
	 mcVn/yDAQ5hGXbmWasSqWpRo8SGZKkF4cj7oGNovdscP5UFxl/I5iYUIKZQrG0l/Pi
	 +qcccqgFa/b1Fj9IdD1r1HD+Rp0ViROdkJqHhWSFd/Wsu4MRdcNphCVJ4aGhO1Kf+h
	 cbcIJISxCLX3A==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ac65e845a8so10346761fa.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 06:03:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw0qX1xrkVti7pwmAbarBy0cWGiFdqaSjjs3kMvx8wPmk9kS6WW+55OY6yt/8Y3eP6++DcXTyI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9pP3duJn+ADjpmgfuUHVNfzArTKEJAFL2y8y6L0CRg8BRBQkM
	0ODi9JO4yUn5225pvuJnmV0B1IMUbVybK+gy8hCOiTRnN6du5jKDQjB7Mp7+RPM+XGogRnLvTIC
	GCE++NRhIqROTCLnfLsAvFL4iKvyD7qY=
X-Received: by 2002:a2e:be90:0:b0:3ab:1dcd:934c with SMTP id
 38308e7fff4ca-3ac9085cd16mr5034811fa.1.1793106193067; Tue, 27 Oct 2026
 06:03:13 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
 <20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com> <e25fd292-5391-41fc-a324-0ec260828415@linux.dev>
In-Reply-To: <e25fd292-5391-41fc-a324-0ec260828415@linux.dev>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 14:02:58 +0100
X-Gmail-Original-Message-ID: <CAL4Wiip=TkP2hmOFR-1Y-CU4rYHY_q=TBDhK6RmTj9UEMQ95Gw@mail.gmail.com>
X-Gm-Features: AclHuK9rU7oOToqigMxIaaqt9b1_ic_1sOzFF6P0HJqOg7YsuT6ZI5h9HNYfk2s
Message-ID: <CAL4Wiip=TkP2hmOFR-1Y-CU4rYHY_q=TBDhK6RmTj9UEMQ95Gw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] Revert "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU"
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: echoowall@gmail.com, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 13:45, Jiayuan Chen <jiayuan.chen@linux.dev> a =
=C3=A9crit :
>
>
> On 10/26/26 3:23 PM, Esko Mobius via B4 Relay wrote:
> > From: Esko Mobius <echoowall@gmail.com>
> >
> > This reverts commit 2640e6419594 ("net: advertise TCP MSS from the
> > configured MTU, not the learned PMTU").
> >
> > That commit stopped the learned PMTU from lowering the MSS we advertise
> > in SYN and SYN-ACK. For symmetric paths it argued that "the peer runs
> > its own PMTU discovery and usually already knows the real path MTU".
> > That only holds if ICMP "fragmentation needed" can reach the peer. When
> > the peer sits behind a firewall that drops inbound ICMP, its PMTU
> > discovery is a black hole (RFC 2923, section 2.1), and the smaller MSS
> > we advertised was the only thing keeping its full-size segments off the
> > narrow hop.
>
>
> A client that cannot receive ICMP is broken beyond this: QUIC's DPLPMTUD
> hits the same black hole, and nothing the server advertises can help it.
>
>
> >
> > Inbound ICMP filtering is very common in enterprise and carrier
> > networks, and it is pervasive in mainland China. We hit this in
> > production after the commit was backported to 6.12.111: TCP connections
> > that reach a server through a relay with a smaller-MTU hop complete the
> > handshake, then stall as soon as the client sends full-size segments.
>
>
>
> The learned PMTU is keyed per destination address. If your relay
> masquerades the clients, the server sees a single address, and one
> client's download seeds the entry for everyone behind it. That is why
> this looked reliable. Once the clients are spread over their own
> addresses, each one needs its own fresh entry and it falls apart. The
> old behaviour was never a mechanism for this.

Hi Jiayuan

You are right on the technical side, and your patch was correct
from an RFC point of view. The old behavior was a side effect,
not a designed mechanism, and the reporter setup only works
because the masquerading relay keeps the exception fresh.

But it did work for them, for years, and it stopped working after
a stable update. That is the part we have to fix first, even if the
setup relies on an accident. MSS clamping on the relay is the proper
long term answer for them.

This is partly my fault: I reviewed the patch and did not object to
the Fixes: 1da177e4c3f4 + Cc: stable tags. A behavior change like this
one should have stayed in net-next.

> Maybe a better way out than a plain revert:
>
> Revert in stable, and in net-next add a sysctl, something like
> net.ipv4.tcp_advmss_use_pmtu,
> that decides whether an endpoint uses the PMTU it learned on its send
> side for the MSS it advertises (even though these are two opposite
> directions). Default on keeps your setup working, DSR-style setups turn
> it off

I think we mus take the revert in net as well, so that
mainline and stable trees behave the same, and the stable
backports do not diverge.

Then a net-next patch is welcome, keeping the historical behavior
as the default. Before adding a new sysctl, please check if the
existing per-route advmss metric is enough for the DSR case,
as Esko showed in the changelog. If it is not (for instance because
it is too hard to deploy on many routes), a sysctl sounds fine to me.

Thanks!
