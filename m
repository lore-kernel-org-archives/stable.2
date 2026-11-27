Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795777816;
	b=1tFgU+Hn54J3NCDqzOvroCIBodvydXLsBnsFWVQ8TDZkS6pkftcLJV2kYt5qH3CdIo8s
	 VrW5gK+E+Lp9CJew7wn2XouIp8raOUOQVMIi7dIxmRQEbmAAV50xjXNBDZ3UlTaa+E8lW
	 j6Z0NorUaM0GFRFVqRzIBA9OxZYupckqTmQVvkuLodcEwiDUEKRqbUJs8aj//z5kAS/6P
	 3vxX7hvS04E/+7XBEXKWYPf8RPvFpsZZCxwn+QvU76aDurlWaynaG82L79zl90F3D9Twb
	 Z7UNo5rSlyEgsgbXXCz/7OT46pkTg9XlEm9aIqk01ARgzVGfpG8xf/C8LIoIObycPbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777816;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yAseJCXCkp3H58r0OVANX+f+65Cd2MGF7drdzRohz2Q=;
	b=RmAVmZDEvJD2zMhODrvwRlXkaRVIXVOz8yVPRWG3Lryqh0yqIv5yr6C8sL3+1EC/gVMt
	 rNAe3gNKLlQD/RYv+kd+ZqG0G3v4pW4WUIYVBTmF4oeGSvoiiolLKBxtymrASJUddWHUG
	 OZguUyROXCXrgJ/KZ1RMQ5gBbLyNyhyT1Dm6r5SErQGvp2vmaqENSug6y/lornFZwAUMh
	 luGd8BlgQAxI02wySg+oZHi+yimYVgGVyraI/LyQ/bMtvEtI4OFJZnUlhC7SJN34N7veZ
	 Nn//I03Qn1UKVdYhABCZmoHJrq11XRD8DspKx+q4RZfQnBL/+mfvHU98Ia2AM4pvqPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JvhWZiNV;
	arc=none smtp.remote-ip=95.215.58.198
Received: from mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C35606A31F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9C35606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JvhWZiNV
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=N8t62i7CUa3ZOxo+eFaX+w6ClZWF5P21IBj52O6aWrk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795777814; v=1; x=1796382614;
 b=JvhWZiNV4UtpPEstZuQFbQgfMJCbWsCIZazyWrKiRij/2Ta1dvq1SbkJj7ABMY/Q4LIPyWC7
 Ya1Nyar4cjr+RqDhySbAsbyJTNhYMr5hkCz2O3CyItm5Lo+pkSWHv1L+nOB5yOT7tYVFoILTnxc
 HjUKxgpnBLasnYLpNJ5Rd9Rc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b147367c39aa5312;
	Fri, 27 Nov 2026 11:10:10 +0000
X-Mizu-Trace-ID: b147367c39aa5312
X-Migadu-Flow: FLOW_OUT
Message-ID: <da0323dd-441a-46a6-ad9a-39def5fc08dc@linux.dev>
Date: Fri, 27 Nov 2026 19:10:01 +0800
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
Subject: Re: [PATCH net 10/10] tcp: do not pass a BPF reqsk to an MPTCP
 listener
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Christoph Paasch <cpaasch@openai.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 Davide Caratti <dcaratti@redhat.com>, Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Martin KaFai Lau <kafai@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
 <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-10-278042217e8d@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-10-278042217e8d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/23/26 9:24 PM, Matthieu Baerts (NGI0) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A slab-out-of-bounds write and a panic can occur if a tc BPF program
> that validates SYN cookies assigns an ACK to a TCP listener, and the ACK
> then goes to an MPTCP listener of the same SO_REUSEPORT group.
> 
> bpf_sk_assign_tcp_reqsk() attaches a plain TCP request sock to the skb,
> and returns -EINVAL if the program passes in an MPTCP listener. But
> inet_steal_sock() and inet6_steal_sock() select a listener again from
> the SO_REUSEPORT group of the listener that was passed in, and the
> result can be an MPTCP listener. cookie_bpf_check() then passes the
> request sock to mptcp_subflow_init_cookie_req(), which writes to members
> of the larger struct mptcp_subflow_request_sock, so the writes can land
> in the next object of the slab.
> 
> The fix used here is to drop the segment in cookie_bpf_check() if the
> listener is an MPTCP listener. The connection then fails, instead of
> corrupting the memory.
> 
> This issue has been found with the help of an LLM, and reproduced in a
> VM, with the reproducer shared with the original version of this patch:
> a tc BPF program validating SYN cookies -- the one from the BPF
> selftests -- and an SO_REUSEPORT group with a TCP listener and an MPTCP
> one, the latter being selected. With KASAN, the original version of this
> patch reported:
> 
>   BUG: KASAN: slab-out-of-bounds in mptcp_subflow_init_cookie_req
>   Write of size 1 at addr ... by task python3
>    mptcp_subflow_init_cookie_req
>    cookie_bpf_check
>    cookie_v4_check
>    tcp_v4_do_rcv
>    tcp_v4_rcv
> 
> Without debug options, and with request sockets of half-open connections
> next to the corrupted one, the kernel panicked a second later, when the
> timer of a request socket fired:
> 
>   BUG: kernel NULL pointer dereference, address: 000000000000058f
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 7.4.0-rc1+ #1 PREEMPT(lazy)
>   RIP: 0010:tcp_syn_ack_timeout+0xd/0x30
>   Call Trace:
>    <IRQ>
>    reqsk_timer_handler+0x22e/0x500
>    call_timer_fn+0x2a/0x140
>    __run_timers+0x1f7/0x280
>    run_timer_softirq+0x49/0xf0
>    handle_softirqs+0xfa/0x300
>    __irq_exit_rcu+0xb5/0xf0
>    sysvec_apic_timer_interrupt+0x73/0x80
>    </IRQ>
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ Shorter comment. Commit message: how the issue was found, its
>   symptoms, and that the connection then fails. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


Actually, we still have a few issues with bpf_sk_assign semantics...

> ---
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Cc: bpf@vger.kernel.org
> ---
>  net/ipv4/syncookies.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 89169c82431c..f39600ee3f17 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -312,7 +312,8 @@ struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb)
>  	skb->sk = NULL;
>  	skb->destructor = NULL;
>  
> -	if (cookie_tcp_reqsk_init(sk, skb, req)) {
> +	/* reuseport can pick an MPTCP listener: req is too small for it */
> +	if (sk_is_mptcp(sk) || cookie_tcp_reqsk_init(sk, skb, req)) {
>  		reqsk_free(req);
>  		req = NULL;
>  	}

