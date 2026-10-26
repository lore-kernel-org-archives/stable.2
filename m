Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023574;
	b=Se8ojdLfN8bCE91m7KM1EmiFM81hQbWRMOl7UbdodNjzQBu18h6Pj+NuJWk5YjMhwUBu
	 CbUEFDegeOYu1QMO5hOcBvd7gjqKzenAoLCtJ88QTOkM4BOOWaOG2XTgfjyl3XWL5++Wq
	 W4rYBybUl7TfeLboEIRJXwOKtB88Co5Sy675qMv8Ot+umh9sfW1RvqF9jukjv38tt6VF5
	 13lQI9eeqXAAavO+fOD8S0hRPFXlgN7H11LeZd33mJgvGLd/+YrC//2MeW+4QZJSGvpNw
	 SOH3d0YtE2ycACxyef/YLDv/kILxyJfDijFWIhsx5sHLVlY8cNgBUuZMHicsGNRnyvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023574;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=S+aChkfaMd9EivevKx38Q/7Syxky3lnzhcs/iXmA7Hk=;
	b=QwxLNJMtkXkRoboqGtILc6LEoQmnfbKCOmEZCLymAoqBi6RbaMLhnnHP7Fmci9WyxIec
	 lz+dy8AaaLVSzqnhfhKlKVHlFDGPnyVZqBdDAZQhilxGzkVsB1FX1NhpSAyf2NCp2gPLf
	 /zv6SPMZ3jzXEsbzB+vVfh9SiODOgzTy64Cq6g5bdgRrMrJqr3CqeOkEBVIL5sShJb7rn
	 XJz5UiFU9un1UMq0fDoBm2ytCUnGjXL2th6l9aFZkNr43jrxAwJ/96ct5aNg305hVxZSC
	 BSBC6JoettlRvRZyuDHebjPj9bHGgrX8Qxg22ih2kGwF/c9/D3W4EEdBkRvwIeJNivQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=UGmjf8VY;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b="tp/eiOPR";
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C65606A31A;
	Mon, 26 Oct 2026 14:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53C65606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=UGmjf8VY;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=tp/eiOPR
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69QE5aHh010301;
	Mon, 26 Oct 2026 15:05:42 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 8AE4F1203BC;
	Mon, 26 Oct 2026 15:05:42 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793023543; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+aChkfaMd9EivevKx38Q/7Syxky3lnzhcs/iXmA7Hk=;
	b=UGmjf8VYEjQ3iKMxhBykCXQ2zVJ0aAgYaycPpfcNB4aRZ9SJPM99SxoBW9h5/j5FNCI1jX
	G3aKXx7/2EAJL+Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793023543; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+aChkfaMd9EivevKx38Q/7Syxky3lnzhcs/iXmA7Hk=;
	b=tp/eiOPRb951NNKopf1HgWI0lb4Zs6BspwO+XzwB2jaDUstzbN2eXW0i7u0eX7/a3ivBQD
	vcBj+CKvtZIg64wYdSRZ9f3RhdeKCe0iaDwQHsbm2yDP1hC8KZx7ZY0cF7QSs6RxviAOeX
	Pie/ZdmIhSLLP9rfV+OU7dQo9SU3zbnlzx/FL7JSbEp2JB5SvX48W/tDe1zC72kg3Y21mP
	mU124AcC124ed4z3oko1LbXMgpf4/Zz7ADttTv0eM1UU6W6LE2EEa4PbCeyaERdr02643j
	dEsI56USpDzXKTGCYs8lo11ptlsipiiBM1HdUzhQKGKLeiaDZmymhH1wXt+YGA==
Date: Mon, 26 Oct 2026 15:05:41 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Tristan Madani <tristmd@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        tristan@talencesecurity.com, david.lebrun@uclouvain.be,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        stable@vger.kernel.org, stefano.salsano@uniroma2.it,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] seg6: fix tun_src RCU lifetime on namespace
 teardown
Message-Id: <20261026150541.a5a34642db9d1523f839f644@uniroma2.it>
In-Reply-To: <20261025222222.1064464-1-tristan@talencesecurity.com>
References: <179278529389.3327.1530536500905686255@kernel.org>
	<20261025222222.1064464-1-tristan@talencesecurity.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Sun, 25 Oct 2026 22:22:22 +0000
Tristan Madani <tristmd@gmail.com> wrote:

> Found by manual code inspection while auditing RCU lifetime
> patterns in the seg6 subsystem.  The issue is theoretical --
> found by reading the source, not triggered in production.

Hi Tristan,
thanks for the info.

The pre_exit in this patch introduces a NULL deref. It sets tun_src to
NULL before the netns devices are removed, while set_tun_src() can
still read it.

I ran a stress test on net with KASAN. A userspace program sends UDP
packets in a loop from init_net through a veth into a test netns, where
a seg6 encap route without a per-route tunsrc forwards them. Meanwhile,
the test netns is created and deleted repeatedly.

With this patch applied, KASAN reported a null-ptr-deref in
set_tun_src() and the kernel panicked:

 BUG: KASAN: null-ptr-deref in set_tun_src+0xd1/0x240
 Read of size 8 at addr 0000000000000000 by task udp_flood_user/379
 Call Trace:
  <IRQ>
  set_tun_src+0xd1/0x240
  __seg6_do_srh_encap+0x410/0x710
  seg6_do_srh+0x65e/0x6a0
  seg6_input_core+0x87/0x4c0
  lwtunnel_input+0x18d/0x420
  ipv6_rcv+0x44f/0x460
  __netif_receive_skb_one_core+0xd6/0x130
  process_backlog+0x2cc/0xa00
  __napi_poll.constprop.0+0x56/0x270
  net_rx_action+0x327/0x730
  handle_softirqs+0x15a/0x6c0
  do_softirq+0xb4/0xf0
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0xdd/0x100
  __dev_queue_xmit+0x538/0x1030
  ip6_finish_output+0x280/0x640
  ip6_output+0x118/0x380
  ip6_send_skb+0x99/0x210
  udp_v6_send_skb+0x397/0x760
  udpv6_sendmsg+0x1100/0x14d0
  __sys_sendto+0x219/0x2d0
  ...
 Kernel panic - not syncing: Fatal exception in interrupt

Without this patch, I ran the same test with 1000 netns deletions and
KASAN reported nothing.

Ciao,
Andrea
