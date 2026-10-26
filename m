Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024447;
	b=ZUKG9giVZ5G6LuAeBWi2e1XmhmUNv+3bEfiMkCV7eOt3G9J4dyFT8K3Z2UZ3Nq/gIf+1
	 rjD4GnwN274tD1Z/mbHv9edmB2b7oDmbT0ZDaXqdZtti2ET8QcuIbfottBppbRfpzuzoq
	 PxTfWbEWcOW80j5YX49hAykNKybrieCLvvL0HD9sSQ+GphojxOmexxnjR81aAOXe7808p
	 Y0IoBW6f+0RPPlgtV/6yVoGvElYdXDAnRjWygrJAGuPG6ewi2OkADGmlaZFfA4N8eYQzu
	 vPFGmqvUG5lypvUblaIxnP3wYZ/kOnNK4v8RqvQgix2u/1/giPjkaMn0qT8Pi/KsZQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024447;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AmlF0+0aAM2fRJ2RV4wjFXkBSJJqDWyBurX+4vn392I=;
	b=epRffEeVPH4sAkVtRF+qmM6XKeXf3jUQvtgur9VJ4FoQvVyuhmg4c7837G+2DwkFtkr/
	 4cCUtVh0IsUJ4iLe95Uzm07oD/RQmaXJsIXOVXBI+l5BvLB/TIArBy942gwC6+9aN0Ji8
	 M8cSvUgpuVyC4TOahWv63N6YS86WvYE0PDnQ3FaLB8WqF7P47AhBJ5Af5a5PvJXfJzVgq
	 nAAJBnhcSLmFYLK3rYfWjTE+mFD0lCQ3WFktU7NLeuugDLE05f0dHkCsaI7Z/uubu8Tet
	 vMc8YLpD8jkNN2PfvpKW0EHhI/G5x0qUCZtPZ4p4iRFqp8lDQfd6X3gpQ+vEJxT9PCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwrHKO5q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF6606A323
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwrHKO5q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC961F031E6
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793024446;
	bh=AmlF0+0aAM2fRJ2RV4wjFXkBSJJqDWyBurX+4vn392I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PwrHKO5qtJxFxRGL1vGL4JNW8fYL9264QY5VABTbch1W/dcwzLpgjUqGj/urzbo9E
	 0e2w6D5H9unmPYvIpHrm+qvIJW6BgV9qch9v/TWQ/uMoqRtPul6ao+kJRwJUGmNb10
	 GpX+/RfBNqRdOAxcFdo8ik4GWr089+Exfk9OHK3PquqEf19qG47JwzBLmA7gjzm+ie
	 HnRJNoBVVzGjl5I44Gd1rLthKrXjSL9DTz47XF/SdhbfV1Md5hQTV/K2GqxH3nOCqP
	 1SGaAQ87/uKKBq4FBrOujGqClneAKphm67ZhBntCtdKtN5loSvSMSvv0qMJ79FRDsI
	 fZPhLhUz80/iw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43bf9548df4so2717380fac.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:20:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw6HyHjCYOWXDV/6YPdoqS6HsJcdPG0hD16dbMlfQjmmNlh8PnshebmFmOXkdzJaX3Fkr9xvok=@vger.kernel.org
X-Gm-Message-State: AFq9FYJj94y3HXtklYeJGz0WJLTtaeFKID3hQgY5ei2ECwtv7V8iKo6P
	Yi/FPNmKEK0UZSXtYASrxRLxxks4A28ImbDhNBvYqsgSVyYsBbuZ1UMLXarxSywbpm4L/B/Cksj
	Wig3KFEEr4dWfFuN1q3/krgR0iUCXpL4=
X-Received: by 2002:a05:6871:419b:b0:49d:c9ed:21f2 with SMTP id
 586e51a60fabf-4a83f42e1c8mr3861088fac.18.1793024445749; Mon, 26 Oct 2026
 07:20:45 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179278529389.3327.1530536500905686255@kernel.org>
 <20261025222222.1064464-1-tristan@talencesecurity.com> <20261026150541.a5a34642db9d1523f839f644@uniroma2.it>
In-Reply-To: <20261026150541.a5a34642db9d1523f839f644@uniroma2.it>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 26 Oct 2026 15:20:34 +0100
X-Gmail-Original-Message-ID: <CAL4WiirtzVke8V8f6LJEWdOCDNevGxdQCFhXxEGiEMq-TNbsVA@mail.gmail.com>
X-Gm-Features: AclHuK8L92wlrbdXy0m1rYg5r51z1Kquhpb4YkZm0AcuyqBb82vwpDIOASY1obs
Message-ID: <CAL4WiirtzVke8V8f6LJEWdOCDNevGxdQCFhXxEGiEMq-TNbsVA@mail.gmail.com>
Subject: Re: [PATCH net] seg6: fix tun_src RCU lifetime on namespace teardown
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Tristan Madani <tristmd@gmail.com>, netdev-bot+sinfo@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	tristan@talencesecurity.com, david.lebrun@uclouvain.be, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org, 
	stefano.salsano@uniroma2.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 15:05, Andrea Mayer <andrea.mayer@uniroma2.it> =
a =C3=A9crit :
>
> On Sun, 25 Oct 2026 22:22:22 +0000
> Tristan Madani <tristmd@gmail.com> wrote:
>
> > Found by manual code inspection while auditing RCU lifetime
> > patterns in the seg6 subsystem.  The issue is theoretical --
> > found by reading the source, not triggered in production.
>
> Hi Tristan,
> thanks for the info.
>
> The pre_exit in this patch introduces a NULL deref. It sets tun_src to
> NULL before the netns devices are removed, while set_tun_src() can
> still read it.
>
> I ran a stress test on net with KASAN. A userspace program sends UDP
> packets in a loop from init_net through a veth into a test netns, where
> a seg6 encap route without a per-route tunsrc forwards them. Meanwhile,
> the test netns is created and deleted repeatedly.
>
> With this patch applied, KASAN reported a null-ptr-deref in
> set_tun_src() and the kernel panicked:
>
>  BUG: KASAN: null-ptr-deref in set_tun_src+0xd1/0x240
>  Read of size 8 at addr 0000000000000000 by task udp_flood_user/379
>  Call Trace:
>   <IRQ>
>   set_tun_src+0xd1/0x240
>   __seg6_do_srh_encap+0x410/0x710
>   seg6_do_srh+0x65e/0x6a0
>   seg6_input_core+0x87/0x4c0
>   lwtunnel_input+0x18d/0x420
>   ipv6_rcv+0x44f/0x460
>   __netif_receive_skb_one_core+0xd6/0x130
>   process_backlog+0x2cc/0xa00
>   __napi_poll.constprop.0+0x56/0x270
>   net_rx_action+0x327/0x730
>   handle_softirqs+0x15a/0x6c0
>   do_softirq+0xb4/0xf0
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0xdd/0x100
>   __dev_queue_xmit+0x538/0x1030
>   ip6_finish_output+0x280/0x640
>   ip6_output+0x118/0x380
>   ip6_send_skb+0x99/0x210
>   udp_v6_send_skb+0x397/0x760
>   udpv6_sendmsg+0x1100/0x14d0
>   __sys_sendto+0x219/0x2d0
>   ...
>  Kernel panic - not syncing: Fatal exception in interrupt
>
> Without this patch, I ran the same test with 1000 netns deletions and
> KASAN reported nothing.
>
> Ciao,
> Andrea

Right, and there is no bug to fix in the first place.

ip6_segments_ops is a pernet subsys, so seg6_net_exit() runs after
all netns devices have been unregistered (default_device_exit_batch()
and the RCU grace periods in netdev_run_todo()). At that point no
packet can reach set_tun_src() for this netns, and no socket can
issue SEG6_CMD_GET_TUNSRC either.

pre_exit runs before devices are dismantled, hence the crash Andrea
reported.

pw-bot: rejected
