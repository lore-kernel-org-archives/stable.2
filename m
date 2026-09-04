Received: from mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238FC377ABF
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489755; cv=none; b=g9zjPteauApaImv1+p3781osMaL80OMPZFDWnVBA55ixLAqTFvxynv9l3ertNl8CUScxHN5Zsnn71/ilvzMoymGbYJQcsCFEX+aBRGOW3+S4D9hgAL7M0OjYX8BoojM3LpRGFvRX5YJI34h+wypnrQXca2coLsR6Z5WakN/WqGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489755; c=relaxed/simple;
	bh=lDr50yiDvYV5VZ9MgxKYG1BSJ1Fz54tjH96Y89/BBrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SavXSryUNYt3vrb3YOKr9xSWO0CwQKMUhzDxvAUJioxT7pa5nnbTe5BITbCJliDJfxhJ5KLMgcDvbBc9r8yi/9IHxVZWYT/C8SFy3V4PjTj/sCucXNVYcyCFbLT7cWb1Bt5dXueBHXQiZpzBL0C+4o98nZfz/1A52Vye+KJuWYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vYlW6SLb; arc=none smtp.client-ip=91.218.175.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vYlW6SLb"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lDr50yiDvYV5VZ9MgxKYG1BSJ1Fz54tjH96Y89/BBrE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788489751; v=1; x=1789094551;
 b=vYlW6SLbzNKW+pHHzcR7iohGmohEfVftqzata+lCbaR+wPStWrRUnbMCxStQk66YCaQAe0fP
 sUl1FLbluXfNM41mItlmJpek1MEDGBpcfq9F8/fKEQsjvk0Dd6sCAfphjpjqHpfE57A8BeBfamz
 ezWwxmVFkN1WlLvLAI6h89Ss=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3a4ee7a862d7483b;
	Fri, 04 Sep 2026 02:42:30 +0000
X-Mizu-Trace-ID: 3a4ee7a862d7483b
X-Migadu-Flow: FLOW_OUT
Message-ID: <2e302fc8-b3ed-4441-bb62-9e509baa3868@linux.dev>
Date: Fri, 4 Sep 2026 10:42:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/tcp-ao: transfer tcp_ao_info to the TIME_WAIT
 socket
To: Xiang Mei <xmei5@asu.edu>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Salam Noureddine <noureddine@arista.com>,
 Francesco Ruggeri <fruggeri@arista.com>, David Ahern <dsahern@kernel.org>,
 co+2c72469dbbec34af@bugs.sh, stable@vger.kernel.org
References: <20260904005851.149071-1-xmei5@asu.edu>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260904005851.149071-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


on 9/4/26 8:58 AM, Xiang Mei wrote:
> tcp_ao_time_wait() gives the TIME_WAIT socket a reference to the full
> socket's tcp_ao_info but leaves tp->ao_info pointing at the same object.
> That is only safe if the full socket is going away. On the tcp_fin()
> FIN_WAIT2 path (and TCP_CLOSING in tcp_rcv_state_process()) tcp_done()
> skips inet_csk_destroy_sock(), so the socket lives on in TCP_CLOSE with
> its fd open while the hashed TIME_WAIT socket reads the same tcp_ao_info
> from softirq, serialised against nothing.
>
> An unprivileged user can turn that into a NULL deref: tcp_disconnect()
> does not clear ao_info, so connect(AF_UNSPEC) + listen() reaches
> TCP_LISTEN where TCP_AO_DEL_KEY accepts del_async=1 and NULLs
> ao_info->rnext_key, which tcp_v4_timewait_ack() then dereferences
> unchecked. The triggering segment need not be authenticated, as
> tcp_v4_rcv()'s do_time_wait: path skips tcp_inbound_hash().
>
> The refcount keeps the object allocated for both sockets, but nothing
> keeps its contents coherent: the setsockopt writers hold the full
> socket's lock while the TIME_WAIT reader runs in softirq, and no lock
> spans the two. Make the transition a handover, as the sk_omem_alloc
> charge moved here already implies: clear tp->ao_info instead of taking a
> second reference, leaving the TIME_WAIT socket as sole owner. Such a
> socket no longer exposes TCP-AO state (TCP_AO_INFO and TCP_AO_DEL_KEY
> return -ENOENT); that state describes the finished connection and
> belongs to the TIME_WAIT socket that keeps updating it.
>
>    Oops: general protection fault, probably for non-canonical address
>      0xdffffc0000000010: 0000 [#1] SMP KASAN NOPTI
>    KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
>    RIP: 0010:tcp_v4_rcv (net/ipv4/tcp_ipv4.c:1055 net/ipv4/tcp_ipv4.c:2333)
>    Call Trace:
>     <IRQ>
>     ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
>     ip_local_deliver_finish (net/ipv4/ip_input.c:241)
>     ip_local_deliver (net/ipv4/ip_input.c:262)
>     ip_rcv (net/ipv4/ip_input.c:612)
>     __netif_receive_skb_one_core (net/core/dev.c:6264)
>     process_backlog (net/core/dev.c:6728)
>     __napi_poll (net/core/dev.c:7787)
>     net_rx_action (net/core/dev.c:8007)
>     handle_softirqs (kernel/softirq.c:645)
>     do_softirq.part.0 (kernel/softirq.c:546)
>     </IRQ>
>     <TASK>
>     __local_bh_enable_ip (kernel/softirq.c:473)
>     __dev_queue_xmit (net/core/dev.c:4961)
>     ip_finish_output2 (net/ipv4/ip_output.c:236)
>     ip_output (net/ipv4/ip_output.c:437)
>     __ip_queue_xmit (net/ipv4/ip_output.c:533)
>     __tcp_transmit_skb (net/ipv4/tcp_output.c:1716)
>     tcp_connect (net/ipv4/tcp_output.c:4383)
>     tcp_v4_connect (net/ipv4/tcp_ipv4.c:345)
>     __inet_stream_connect (net/ipv4/af_inet.c:684)
>     inet_stream_connect (net/ipv4/af_inet.c:755)
>     __sys_connect (net/socket.c:2183)
>     __x64_sys_connect (net/socket.c:2189)
>     do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>     </TASK>
>    Kernel panic - not syncing: Fatal exception in interrupt
>
> Fixes: decde2586b34 ("net/tcp: Add TCP-AO sign to twsk")
> Cc: stable@vger.kernel.org
> Reported-by: co+2c72469dbbec34af@bugs.sh
> Closes: https://lore.kernel.org/all/YG9s0PiBKJZcXAKld3MToa1IVRJOUoKiaA57%40bugs.sh/
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>   net/ipv4/tcp_ao.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index bb7bbc20ba3f..27525f90398b 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -428,7 +428,7 @@ void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp)
>   			omem += tcp_ao_sizeof_key(key);
>   		}
>   
> -		refcount_inc(&ao_info->refcnt);
> +		rcu_assign_pointer(tp->ao_info, NULL);
>   		atomic_sub(omem, &(((struct sock *)tp)->sk_omem_alloc));
>   		rcu_assign_pointer(tcptw->ao_info, ao_info);
>   	} else {


This looks like the simplest fix.

But this fix moves ownership of ao_info. Before, when a socket reconnects,
we didn't need to add new ao_key info — we could just reuse it. Now 
after this
fix, we have to re-add it on reconnect. I'm not sure if that case really 
exists.

