Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795141327;
	b=xKk21sHVEf8EYPERtqcKWMRW6TuYygh9Y3chdAEKtKH0Xtcejn/VUdx6D5Rkh+558DJ3
	 Zy9GnX/3GtuZ4v8HziAACXU7CUUZ70uApUHQufIkzDSqcao0PasUj6EMUN7srhntySku9
	 W4PDxgB+RC2fg+3aLq+scJMFzuDqYCrpRijGE8Q7lqbkPCBE6GWV6AF/Ph44OhzZcOi8+
	 pGg89Qh+BD6tXVk7LUhLxCAoXnFjhNkAo3Ttrf+/ZKJ4WoxI3c7hqCx8EePFUaodFtrFi
	 tWjz8LokUROOomHMjwdhjbxdbYQcJoQ1YwcvZGWrhAvIheYrk3RA0kBQpWa0w5qBMLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141327;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5dvu3zNUsJdRmPMmPyJKE6OQ1/TPrIM97wi+LUF7hSs=;
	b=4wN4R5Aczdt5GRNn4vI6FbnL1kNNjgyb+oOkkdrt38L3B8P0YJMJLWaD7aFmUIvel6d+
	 xCCIYkYrnrJPBm/yJBG5JcGi6le31QpxTotLD1VaL1HiEPNyfymWjvsSfk/egK7om4x9V
	 r5aHmgBmEEpOjUXaGLrs1l/3rSMUq3a3DlEF0q6DTpxdgjXjfmwOvtFSXLni4dPeNauLH
	 5vUfGGC/XQx6L9xGFDYSxzoa+g3G+v3qSiRLlpc2juwt9yd6m7qYKHQp7ztXRU/yLjsqv
	 H3rvz1n0jBdPkxTrP0MQQ+d3jd3s9ykzTkU0Pms5XHIh163rtSsgbD8tE4UKpSTLsxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FahRO3RF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D960A2617;
	Fri, 20 Nov 2026 02:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FahRO3RF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7281F000C6;
	Fri, 20 Nov 2026 02:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795141327;
	bh=5dvu3zNUsJdRmPMmPyJKE6OQ1/TPrIM97wi+LUF7hSs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FahRO3RFt67vKK1SWuNVpSW+qqt6m+bvoWT63PmZZgW5OBzuPHdL2u/GneW8ijRC2
	 2JbsTCQ0bQH392x+uqWC7gh3Z8acm8P02m1UwQb16ItCDpgkcXwm7oD9qsUKY0B6WT
	 csgUf0aBzlAZYJeI3sebK0CD9qU4loWHuDVNFC434N82OjJZgWDi3hBcq/AF6JzHEl
	 wGP4rWMNYXk/zXBf78aY6ybtui+TiuNstmevtjCcIKXREcXHJeCxMqut0M+0Onh0L2
	 Kz318/3uerFVjUCbDLK1XlbGrkvQxcM9FFZd5X3h2iD3IU+jijRtuMyHa/bWBsPynT
	 BO5kdV/lheWsA==
Subject: Re: [PATCH net v10 4/4] selftests: net: hsr: verify GRO policy and
 ordered forwarding
From: netdev-bot+sashiko@kernel.org
To: xiexinet@gmail.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com,
 lukma@denx.de, fmancera@suse.de, danishanwar@ti.com
Date: Fri, 20 Nov 2026 02:22:05 +0000
Message-ID: <179514132547.3136.13495496804508264681@kernel.org>
In-Reply-To: <20261117141922.20-5-xiexinet@gmail.com>
References: <20261117141922.20-5-xiexinet@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The single-producer ordered cases in hsr_ordered_forwarding.sh
  can fail even when the kernel is correct.

--

selftests: net: hsr: verify GRO policy and ordered forwarding

This commit adds two HSR/PRP kselftests, and both run one shared Python
helper. hsr_gro_superpacket.sh checks the GRO policy on HSR members, the
refusal of unsupported port types, and TCP forwarding from the interlink
and from a PRP SAN. hsr_ordered_forwarding.sh checks the ordering of
local and interlink data, supervision frames, concurrent producers and a
sequence-number wrap.

> diff --git a/tools/testing/selftests/net/hsr/hsr_gro_superpacket.py b/tools/testing/selftests/net/hsr/hsr_gro_superpacket.py
> new file mode 100755
> index 0000000000000..17055d9329b3d
> --- /dev/null
> +++ b/tools/testing/selftests/net/hsr/hsr_gro_superpacket.py
> @@ -0,0 +1,1468 @@

[ ... ]

> +def ordered_send(lab, sock, producer, first, count, port, segment=0):
> +    """Send count datagrams, or UDP GSO aggregates of 16; return the payloads."""
> +    expected = []
> +    if segment:
> +        sock.setsockopt(socket.IPPROTO_UDP, 103, segment)
> +    blocks = 16 if segment else 1
> +    size = segment or 64
> +    for number in range(count):
> +        payloads = [ordered_payload(producer, first + number * blocks + n,
> +                                    size) for n in range(blocks)]
> +        body = b"".join(payloads)
> +        require(sock.sendto(body, ("239.0.0.9", port)) == len(body),
> +                "short UDP send")

[Severity: Medium]

Can the single-producer ordered cases fail on a correct kernel because
this sender is not pinned to a CPU?

ordered_send() runs in the main thread, and the main thread never calls
os.sched_setaffinity(). Only the producer threads in ordered_concurrent()
are pinned.

The frames go through the veth t0 to the interlink dil. There is no XDP,
and GRO is forced off on HSR members. So veth hands each frame to the
backlog of the CPU that sent it:

drivers/net/veth.c:veth_forward_skb() {
	return __dev_forward_skb(dev, skb) ?: xdp ?
		veth_xdp_rx(rq, skb) :
		__netif_rx(skb);
}

The netif_rx path then calls enqueue_to_backlog(skb, smp_processor_id(),
...).

Threaded backlogs are always used on CONFIG_PREEMPT_RT, and also with the
thread_backlog_napi boot option. With them, ____napi_schedule() only wakes
the per-CPU backlog thread:

net/core/dev.c:____napi_schedule() {
    ...
	if (use_backlog_threads() && thread == raw_cpu_read(backlog_napi))
		goto use_local_napi;

	set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
	wake_up_process(thread);
    ...
}

As a result, sendto() returns before the frame is processed. The same can
happen without threaded backlogs when NET_RX is deferred to ksoftirqd.

Suppose the sender migrates from CPU X to CPU Y in the middle of the loop.
The backlog threads of X and Y can then run hsr_handle_frame() for dil at
the same time. They take seqnr_lock in arrival order, so a later send can
get a lower HSR sequence number and appear earlier on dil, da and db.

The test still requires the exact send order in ordered_data():

    require([row["payload"] for row in incoming] == expected_inputs,
            "actual UDP ingress input set/order differs")

It also requires it through verify_udp(..., input_order=True) in
ordered_data(), ordered_supervision() and ordered_wrap(). ordered_wrap()
is the most exposed: it sends up to about 65k warmup datagrams plus 256
more, and all of them are checked with input_order=True.

Would pinning the sending thread to one CPU for the ordered cases, or
pinning the whole process in ordered mode, avoid this?

> +        expected.extend(payloads)
> +        # Keep capture receive queues bounded throughout long wrap warmups.
> +        if number % 8 == 0:
> +            lab.observe(0)
> +    lab.observe(0.1)
> +    return expected

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117141922.20-1-xiexinet%40gmail.com
