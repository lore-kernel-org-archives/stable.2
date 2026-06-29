Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE352BDC32;
	Mon, 29 Jun 2026 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740948; cv=none; b=cZG4QDRE4ESpaoF88U0wlu9ICTyXQGc3kQEO26ZoQPs+C/X9B44XPHid3qAG7USV1KrtuiguyFDPdYG5nHIBaMM0rllggVmdrPAKMZwObOrkMAesJCLwis2HgnMp700BnICVnSEdDjYjAeANe/o6oZjOhpAP/+tSAR/g+pFfUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740948; c=relaxed/simple;
	bh=7kehme2Dj91LKT+wh8yWxU1u6DztJFb0/uzCSwPEF8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdN1B9vzoZFRnfK4NpcKpbk+NWXwavQwvS17pc6metKi2gZhgGvvQPRPlMbCVyWUyjftP03gWICIvnk+xyx9fhPgPnuelr71Ubk0fDsqvCUViz8zb3X3+h7YxNxEDNttrGZtZ2S0ES0xuD4GUtGGtTggy6aIDhM2LjS9nibGXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=pMsb6iyw; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="pMsb6iyw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=c6xE9oUcApCll1T9nOrnwR4qaIH/cM6sH78RuKJwJHc=; b=pMsb6iywTQO3pBOOMGuTXZ2BMB
	ZNC0xJEDgBw7slDnuUha9MiiZbtwHqtv/S+z2QCbPeC6A5cApfXDdksdroFmKoLT0RfVkSNumw/rr
	a4NO1/Zw70WRd3W4jpPjwiq1UBH7bmgOOy/qTVoP5+mPvByDgey5KPzuznHGeex/2h+Gv97g96nYE
	BQX0y3H7zrGJxdos8bL+yxX2Z5DbUHoxAY0uDangeaqQJN4C0qRCnuL3yi7QrtHsK45ji7EGR47kk
	8jnjuuRloeRQwcxbOrPZXofoivi3uM6km6tlrSS7QETPCFzHprCBMLPnqZsjgItDeK5Ja7u2CawZ6
	i/thzu4Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1weCM8-0006MW-2M;
	Mon, 29 Jun 2026 15:49:00 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1weCM7-000NX4-12;
	Mon, 29 Jun 2026 15:48:59 +0200
Message-ID: <8a462b1c-b79b-42c5-8409-a36ad727f994@iogearbox.net>
Date: Mon, 29 Jun 2026 15:48:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3 v2] net: Extend bpf_net_context lifetime to cover
 qdisc enqueue
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 toke@toke.dk, Steven Rostedt <rostedt@goodmis.org>,
 Petr Machata <petrm@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, security@kernel.org, stable@vger.kernel.org,
 Victor Nogueira <victor@mojatatu.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20260629102157.737306-1-jhs@mojatatu.com>
 <20260629102157.737306-2-jhs@mojatatu.com>
 <a1a31c1e-b5bf-458f-a80a-bc324fc7a07c@iogearbox.net>
 <CAM0EoM=QsOZ+mbWk7Ysv8-UNMzbmzbYiNXvF9fjEnG1-bDv6YQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAM0EoM=QsOZ+mbWk7Ysv8-UNMzbmzbYiNXvF9fjEnG1-bDv6YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28046/Mon Jun 29 08:27:20 2026)

On 6/29/26 3:36 PM, Jamal Hadi Salim wrote:
> On Mon, Jun 29, 2026 at 9:01 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 6/29/26 12:21 PM, Jamal Hadi Salim wrote:
>>> The bpf_net_context used by sch_handle_egress() is stack-allocated and torn
>>> down in that function returned. By the time tcf_qevent_handle() runs
>>> current->bpf_net_context is NULL.
>>>
>>> When a filter attached to a qevent block (e.g. RED's early_drop or mark
>>> qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
>>> tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf helper
>>> bpf_net_ctx_get_ri().  That helper unconditionally dereferences
>>> current->bpf_net_context resulting in a NULL pointer dereference.
>>>
>>> Note: The same holds for actions that invoke BPF redirect helpers
>>> (e.g. act_bpf running a program that calls bpf_redirect()) during qevent
>>> classification itself.
>>>
>>> Fix:
>>> Move the bpf_net_context lifecycle out of sch_handle_egress() into
>>> __dev_queue_xmit(), so that it spans both the egress TC fast path and the
>>> qdisc enqueue.
>>> Note: The call is placed outside the egress_needed_key static branch
>>> to cover the case where clsact static key is disabled. Unfortunately this
>>> adds a small unconditional penalty to the code path _per packet_ only
>>> guarded by CONFIG_NET_XGRESS (two writes and one read).
>>>
>>> As pointed by sashiko [1]:
>>> The same context must also be set up in net_tx_action()'s qdisc drain
>>> path, since qdisc_run() -> netem_dequeue() -> qdisc_enqueue( RED child)
>>> can trigger qevent classification asynchronously from softirq context.
>>>
>>> This keeps all bpf_net_context management in net/core/dev.c i.e the
>>> existing boundary between tc core and BPF without requiring any net/sched/
>>> code to know about BPF plumbing.
>>>
>>> Reproducer:
>>>
>>>     tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 20KB \
>>>         avpkt 1000 burst 100 qevent early_drop block 10
>>>     tc filter add block 10 pref 1 bpf obj redirect.o
>>>
>>>     traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle() and,
>>>     on a redirect verdict, a NULL deref in skb_do_redirect().
>>>
>>> Fixes: 3625750f05ec ("net: sched: Introduce helpers for qevent blocks")
>>> Tested-by: Victor Nogueira <victor@mojatatu.com>
>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> Could we simplify patch 1 & 2 by just moving the bpf_net_ctx_set() and
>> bpf_net_ctx_clear() into a tcf_classify_qdisc() wrapper where we don't
>> end up having to touch the core TX code?
>>
>> Untested diff :
> 
> This is bpf plumbing which doesnt belong in tc really. You already
> moved most ebpf/clsact stuff into dev.c - let's just keep it there.
> 
> As a side note: calling a hierachy of N qdiscs we would incur N
> set/clear cycles for N levels — and worse, qdiscs like HTB and HFSC
> iterate filters while loop calling tcf_classify_qdisc() per iteration,
> so each filter chain traversal does set/clear per proto.
I'm just saying that this is a lot simpler and taken out of the core fast
path. Also, I think you forgot to Cc Sebastian on the whole v2 given the
bpf_net_ctx_{set,clear} dance. Imho, having them via tcf_classify_qdisc or
something similar would be the much better choice compared to sprinkling
ifdefs since you want to block the TC_ACT_REDIRECT from classifiers attached
to qdiscs.
