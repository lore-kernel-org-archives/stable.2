Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795693;
	b=0/MzUNv0lSBjgSDHyHux+/91TKVtmQ1npqyG5djyM95p1PKddwUVc5q2fywLO12y/81/
	 TNkPQjAnhsgJLkF90mSkHs1MDm66gnIM5mLECkn6pNcCdrfH5F7d7kpDxP/8ETPkKzBCs
	 aghThcc/gdie/efrHA8au4434kqaWY3kw5D27LIociFLItTgR+lr/650PVs2igASce9QI
	 fDcvYfTuC2VJnh9r1cqrCbXOsUCaezrh7o32TjDDmOCHLg5+z6zHb3dp1OuGC98WhzNeT
	 yenXHiLyfXafKqZ7DnLSgFtCxHiVH3P57xOWt4VC+oEXCGZ+COZABfqnC/OiwpUS/Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795693;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XTqrcgRB76wYzP87xai+N/ckpVG15bTxN+bKetQXfgs=;
	b=Tzdo8iY6P2tBBJ+iucwfUlGpP5meTGeZ2by2Y7vR5siwIXU08fGi2GZVLebqZqAv6Rhf
	 lWMTLsEierrdYlLZZsbThgNsjn7CXtJ/A8hu0wzghvg0WOtKx1QVV8UYu7L+dWa0dWdG/
	 Ii0FdmuS78rMe4/QiOmASePM5kSouzVAOoeTUU6KGQ/QxosXqUBYidzBtpKDhIfZYiZaz
	 Wkr5Y4aH4g/+5vMKoUXwnhSjZMxtAdT/SeC718dM+yWS2mwA8W1W+L9aeCC6gN4uwK0WW
	 VJbOdpKDElMxNO0CamJUGRk3lsWwPuVgDdaet5Ag0i3kyYO7/w8P1zw5HzjiVDGHReQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jAWHpioQ;
	arc=none smtp.remote-ip=91.218.175.114
Received: from mta0.migadu.com (out-114.mta0.migadu.com [91.218.175.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA6D606A324
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 16:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DA6D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jAWHpioQ
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6RNB7N0/otlPYlDWppGx8VvcotVx4MUqa6ZJF+cWIno=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795795689; v=1; x=1796400489;
 b=jAWHpioQzYhjOA2AbYJjk00AraY8kTXWFScZb8aHx1CwbLdtys1kIHXCyc2YR6O2/yOcmfzk
 Xnx4qkldHlLj7inO45BxAUTOwLXhYaMBc2CThAYQy+xRlZcnJZqXdNAbMj7tY08oVD0QTPidM/T
 ZQd8hGcVMODj9w9ecoAR41mA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id de26b562f168ec27;
	Fri, 27 Nov 2026 16:08:09 +0000
X-Mizu-Trace-ID: de26b562f168ec27
X-Migadu-Flow: FLOW_OUT
Message-ID: <78e175b3-7f97-422a-928a-a05616f9c445@linux.dev>
Date: Sat, 28 Nov 2026 00:08:02 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] pppox: only wait for a grace period for lockless
 receive paths
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 James Chapman <jchapman@katalix.com>, Willem de Bruijn <willemb@google.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20261127152822.2098330-1-nicolas.dichtel@6wind.com>
Content-Language: en-US
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20261127152822.2098330-1-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/27/2026 11:28 PM, Nicolas Dichtel wrote:
> Commit 92c1bf630abf ("pppox: drain queued packets on channel handoff")
> added a synchronize_net() call to PPPIOCGCHAN, so that the receive paths
> that observed the old state finish queueing their packets before the queue
> is drained.
> 
> PPPIOCGCHAN is issued once per session by PPP daemons, so each session
> setup now waits for a full RCU grace period. With accel-ppp, the PPPoE
> session setup rate drops from ~1100 to ~250 sessions per second, and the
> latency of pppox_ioctl() goes from a few microseconds to 4-8 ms.
> 
> The regression was triggered in CI testing by a PPPoE performance test
> (accel-ppp server in a VM using ConnectX-6 VFs, bngblaster client) on an
> unmodified kernel. It was validated by reverting 92c1bf630abf, which
> restores the v7.2 setup rate, and by measuring the latency of pppox_ioctl()
> while PPPoE sessions are being set up:
> 
>    bpftrace -e 'kprobe:pppox_ioctl { @s[tid] = nsecs }
>      kretprobe:pppox_ioctl /@s[tid]/ {
>        @us = hist((nsecs - @s[tid]) / 1000); delete(@s[tid]); }'
> 
> Only L2TP needs this grace period:
> 
> - PPPoE receives packets through __sk_receive_skb(), which takes the socket
>    spinlock and moves the skb to the backlog when the socket is owned by the
>    user. As pppox_ioctl() holds lock_sock(), pppoe_rcv_core() either
>    completes before the PPPOX_BOUND transition, or runs from release_sock()
>    and sees the new state.
> 
> - PPTP never queues packets to sk_receive_queue: pptp_rcv_core() always
>    hands them to ppp_input(). Moreover, PPPOX_BOUND is set as early as
>    pptp_bind().
> 
> - pppol2tp_recv() tests PPPOX_BOUND and queues packets under
>    rcu_read_lock() only, without taking the socket lock, so it can race with
>    the transition. Waiting for a grace period is required there.
> 
> Add a lockless_rcv flag to struct pppox_proto, set it for L2TP only, and
> wait for a grace period only when it is set.

I'm going to remove the serializing __sk_receive_skb() from PPPoE, then 
this issue will resurface.

Please consider either using the non-blocking call_rcu(), or just 
dropping all the skbs in the receive queue.

Best regards,
Qingfang
