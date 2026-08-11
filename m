Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84617408611;
	Tue, 11 Aug 2026 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434304; cv=none; b=PEEKKkbVqlVX5d2fB1Elnmvm7wxZQVUFhQDBHk/pwPt/7U2zyRfMR+O+C1DPKdxgHhGcKKhh9dMsz9B64n4gBHUgC3J71fYh3pPEyN0J2TPu4a7T+3XdUnVfg7hjvAT6cBEmPJ8Mp+2f/QWmsuM/ixhUXFmXcKXd3qJLeI3ZPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434304; c=relaxed/simple;
	bh=dM15MnyhbigSaRydIPx3lRGnb4Dc6dfEqhk+EYYkLIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT4vwvmpVvdHY6v0F7BUvviUAwjVfKVB2LYXWse8BWVUxmdUcbqLHeec17z8np4EqUdyz2QIxvi236m9jJ0AZkE6TMbhc/YTfcJ/0skbWgh7R5Den/5URLBc5JQpgPtaQvAklnMxZpL71YqS57pDPqIrAedu21ngW2X8qUDHtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Az4KhZD6; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Az4KhZD6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1786434297;
	bh=dM15MnyhbigSaRydIPx3lRGnb4Dc6dfEqhk+EYYkLIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Az4KhZD6F7HDbvi6UX0y3RtP6EejRy7jXb/UyZ9dx1uGCWA53bnuX3tbKEBBLiGET
	 ZlqvOoYWcRqluwvI7wDJXl5V/T7AaxrakFmX0gLhYQYaY+SEAuDjj7SkekaNRSTj4y
	 0rUAFIIKZhtjzA29WnsSjoMnwPZcwg3Gvm3CI6q1/4yRLqAWhqhSwzdExQyeONX7St
	 A2yYHDPrl2pIuQKdOCC5jW1kv9Fg1USjTRn69IfAEeGU+UX3mIkbLG5Qeu68hVweKN
	 AZwUDuf9ZcFE9I0vg9SWXmB2P04TRDbLS/Eb9kQSA16cMmGrKwnc0Jub5e681lItjq
	 u5X4aFdpDm3Qg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 815FE600C1;
	Tue, 11 Aug 2026 07:44:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 8446C200264;
	Tue, 11 Aug 2026 07:44:11 +0000 (UTC)
Message-ID: <54866197-9523-41ca-b596-37f0c05b9e7b@fiberby.net>
Date: Tue, 11 Aug 2026 07:44:11 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tcp: reset late connection after listening socket
 close
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kristian Nielsen <knielsen@knielsen-hq.org>,
 stable@vger.kernel.org
References: <20260810205642.1611338-1-ast@fiberby.net>
 <CAAVpQUDGPtKhv9XfiKgKg7NOqHGzSb4vs7ApQ=rf-RzbaCDQWA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <CAAVpQUDGPtKhv9XfiKgKg7NOqHGzSb4vs7ApQ=rf-RzbaCDQWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/11/26 6:37 AM, Kuniyuki Iwashima wrote:
> On Mon, Aug 10, 2026 at 1:57 PM Asbjørn Sloth Tønnesen <ast@fiberby.net> wrote:
>>
>> In commit c82199061009 ("task_work: remove fifo ordering guarantee")
>> Eric removed the ordering guarantee, thereby changing it from a
>> guaranteed FIFO to currently LIFO ordering, in an effort to reduce
>> jitter.
>>
>> This significantly increases the probability for a race to occur
>> between a TCP handshake and the closing of the listening socket.
> 
> I looked into the repro, and the description above is too specific
> to your reproducer working on localhost.
> 
> In your repro, a server creates a listening socket, accept()s
> some child connections to get multiple file descriptors, and
> exit()s the process, which close()s file descriptors from listener
> (smaller fd) to child fds.
> 
> The last fput() queues each fd to the delayed work, which is
> currently executed in LIFO ordering.
> 
> The child fd sends RST to the client and later the listener is
> TCP_CLOSE'd.
> 
> On the client side, it tries to detect the server's exit() by checking
> RST on the established connections (child fds on listener), and then
> creates a new connection, which creates a reqsk with the alive listener
> but the last ACK will hit TCP_CLOSE'd listener.
> 
> I checked the last ACK generated by the repro fails at
> __inet_inherit_port() OR inet_csk_reqsk_queue_add().
> 
> That's why reverting c82199061009 prevents reproduction because
> it's too late to create a new connection when the client notices the
> listener's exit() via RST of child connections; new connection's SYN
> always gets RST with the revert.
> 
> So, I would drop the description above and simply explain it like
> 
> "When __inet_inherit_port() returns -ENOENT, the new connection
>   is dropped silently."
> 
> 
>> In that case the client sees the connection as ESTABLISHED, however in
>> tcp_v{4,6}_syn_recv_sock() the call to __inet_inherit_port() returns
>> -ENOENT, and the new connection is dropped silently by put_and_exit.
>>
>> A client may therefore hang indefinitely on a blocking read() if the
>> used data communication protocol is initiated by the server, like SMTP
>> and the reporter[1]'s MariaDB protocol both are.
>>
>> Had the new connection been processed before the listening socket was
>> closed, it would have been in the accept queue,
> 
> or inet_csk_reqsk_queue_add() should have sent RST.
> 
>> and been notified when
>> inet_csk_listen_stop() was run, and the client would have got a reset.
>>
>> The call to __inet_inherit_port() returns -ENOENT because
>> inet_csk(sk)->icsk_bind_hash is NULL, after inet_put_port() has been
>> called by tcp_set_state(sk, TCP_CLOSE).
>>
>> This patch adds a check on the return value of the __inet_inherit_port()
>> call, and jumps to a new label, where it resets the new connection,
>> before proceeding with the put_and_exit label.
>>
>> The blamed commit was identified by testing on ancient Debian stable
> 
> This commit should be more appropriate since __inet_inherit_port()
> did not fail (except for OOM) before this commit:
> 
> Fixes: c2f34a65a61c ("tcp/dccp: fix potential NULL deref in
> __inet_inherit_port()")

Thank you, for you detailed analysis. I didn't find this because I didn't
notice the error condition changing over time, and this being a v4.4 commit
while I was looking for earlier commits.


>> releases to get a rough scope of where to look, then identifying in
>> which release between v3.16 and v4.19 it broke, and finally bisecting
>> v4.2..v4.3 on a fresh Debian then-stable (jessie) VM with tooling from
>> that era, and confirmed by reverting it from v4.3, v5.10.y and net.
>>
>> Additionally the race can be reproduced back to v3.6, by backporting
>> the blamed commit. Beyond v3.6 there are too many conflicts.
>>
>> Reproducer:
>>    https://files.fiberby.net/ast/2026/kernel/socket_teardown_test.c
>>
>> Reported-by: Kristian Nielsen <knielsen@knielsen-hq.org>
>> Link: https://lore.kernel.org/87sf0ldk41.fsf@urd.knielsen-hq.org # [1]
>> Fixes: c82199061009 ("task_work: remove fifo ordering guarantee")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>
>> While the blamed commit properly only made the race observable, then
>> the commit that made the race possible is less realistic to track down,
>> and I don't think is worth the time to continue to the search for it
>> somewhere before v3.6.
>>
>> I'm not submitting a selftest at this time, as I have only found an
>> efficient way to often detect the issue, not disprove it, and I would
>> need more test data from different systems, before I can reliably
>> disprove it with a low runtime budget, without getting false negatives.
>>
>> Changelog:
>> v2:
>>    - Use return from __inet_inherit_port() to trigger send_reply()
>>    - Use req->rsk_ops->send_reset.
>>    - Clarity commit message, and update to reflect the changes.
>>    (Thanks Kuniyuki)
>> v1: https://lore.kernel.org/20260807194513.1263310-1-ast@fiberby.net
>>
>>   net/ipv4/tcp_ipv4.c | 8 +++++++-
>>   net/ipv6/tcp_ipv6.c | 8 +++++++-
>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index b8887cdd66c5..e0fba4579a57 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -1690,6 +1690,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>>          int l3index;
>>   #endif
>>          struct ip_options_rcu *inet_opt;
>> +       int ret;
>>
>>          if (sk_acceptq_is_full(sk))
>>                  goto exit_overflow;
>> @@ -1756,7 +1757,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>>                  goto put_and_exit; /* OOM, release back memory */
>>   #endif
>>
>> -       if (__inet_inherit_port(sk, newsk) < 0)
>> +       ret = __inet_inherit_port(sk, newsk);
>> +       if (ret == -ENOENT)
>> +               goto send_reset_and_exit;
>> +       else if (ret < 0)
>>                  goto put_and_exit;
> 
> nit: Please move the -ENOENT branch inside (ret < 0)
> 
> if (unlikely(ret < 0) {
>          if (ret == -ENOENT)
>                  goto send_reset_and_exit;
>          goto put_and_exit;
> }
> 
> 
>>          *own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
>>                                         &found_dup_sk);
>> @@ -1784,6 +1788,8 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>>   exit:
>>          tcp_listendrop(sk);
>>          return NULL;
>> +send_reset_and_exit:
>> +       req->rsk_ops->send_reset(newsk, skb, SK_RST_REASON_TCP_STATE);
> 
> Sorry, I think this can be direct call, tcp_v4_send_reset().
> 
> Also please pass the listener instead of newsk, it's more
> like a call in tcp_check_req().
> 
> Same remarks for IPv6.

Thank you for your very detailed and insightful review.

I have v3 ready, and will post it when the 24 hours are up.

-- 
pw-bot: cr
