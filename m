Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530415;
	b=LFbHeSI73QcR8XzoDfq5BTHYcJc6wp6qcSgSnWv+lLULzH38ly6o+Q+zmcAbkPiPY6Rw
	 GuUC4+ZQHxBaqcY8FrQBDzisQF5FXQIeAWZlmkGTBHV+xJUxvXpcAwtjs8nvBwRCgnikX
	 IzNOZMzr/0rQs6u2gMMbHwZkIcw6CUsjXPQnkMxaFVwP9vs5TOzlAyuHUWZCFte/xhG1b
	 dcnaOZ6BMgBikd0wnaEmlZ4/Y6zLx6ShCzXUl106zmYiIDn4N1vuwTo4bYF6bP8qdThFE
	 qTSVD+zQGRMPCYZJLN79zGVe5M5HPaVq6wnjBCuVy/iA127VAQ0lt3/5OpqobKRbpFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530415;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2W98WMA2F89UxTt3tVs6ea84R2YSQk6xYZ8adTkQopM=;
	b=yBGPOIJQwbs6Dx42ucGiuzdKEDvZFdf0cmzZwusXCeRlwIQR1CX2TxHRNUoidphuP5IX
	 yH/iTGUAC+2VTGmxu2+dv0fUWITwsk4Jmu1km0z7UgurBusi1V21B+uP8GETZXj8hcTY6
	 CrP3DSDKh6aA+f5LU22BrYJ/5appB0FW6kRGQKXhtLf8UBCGqQJac5lYHh+C6OzL8enxT
	 RQfSchHvkcBlK4b3IYcEY6PF9azwWE7qudf2Ihc/NTp/1b97EWK5qm8+vFli9Um5N2t1u
	 GtjKvcRa7tAJmNyjBf64q+MRzql4VjrLTZKFTdTuzwrJ1r1sIEJsXabB3BMlpf/UCxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dq++lBKt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4F606A33D;
	Tue, 24 Nov 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dq++lBKt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13CC1F000C4;
	Tue, 24 Nov 2026 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795530414;
	bh=2W98WMA2F89UxTt3tVs6ea84R2YSQk6xYZ8adTkQopM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Dq++lBKtUX5wfJnxdHuFpToVWB0ZydGzynS/vzx0AEKYTDuLPay7ijxFed9yV3DJV
	 CoyzyOYQpkBfDjkbBuypkByfC1sBIhIEv69xwvKTI1k51TYgtrSpvtTL/ktV78W7sf
	 wf5t28+QAZ0hXNgMtiRO8Pt6FszQGtfJKL4VjnHFAkcE63jnccsH/GZcV7fQbl204H
	 3S7vfHnVLzmHw8127+1ovl9FfUxABf1Bh9qBC4UjrLhCQ2JtcdDNt4KF8wS6ow18or
	 M6Ugnpe1N05a2QW9egUxOQnWhN0KL6Ip5xKcFhZYoazOihmA+12umIBdQDlenoBiV2
	 bi+i+x5innaRQ==
Subject: Re: [PATCH net 08/10] mptcp: pm: don't let listeners pin their netns
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: edumazet@kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, horms@kernel.org, martineau@kernel.org,
 geliang@kernel.org, cpaasch@openai.com, fw@strlen.de, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, dcaratti@redhat.com, mason@kernel.org,
 stable@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, kafai@fb.com,
 daniel@iogearbox.net, ast@kernel.org, martin.lau@kernel.org,
 bpf@vger.kernel.org
Date: Tue, 24 Nov 2026 14:26:53 +0000
Message-ID: <179553041337.3135.9610172277728846515@kernel.org>
In-Reply-To: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-8-278042217e8d@kernel.org>
References: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-8-278042217e8d@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The netns leak this patch claims to fix can still be triggered
  through the SYN-cookie path.

--

mptcp: pm: don't let listeners pin their netns

This patch stops the subflow of an in-kernel PM listener from taking a
netns reference when its MPTCP socket is a kernel socket. As a result, a
"signal" endpoint with a port no longer pins its namespace. Children cloned
from such a listener in subflow_syn_recv_sock() now take the reference
themselves, using __sk_net_refcnt_upgrade() in atomic context.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 20d5062350742..3e674c21bdb2a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -912,6 +928,11 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
>  
>  		tcp_rsk(req)->drop_req = false;
>  
> +		if (!subflow_child_get_net(child)) {
> +			subflow_add_reset_reason(skb, MPTCP_RST_EUNSPEC);
> +			goto dispose_child;
> +		}
> +

[Severity: High]
Can the namespace still get pinned through the syncookie path here?

mptcp_subflow_create_socket() no longer upgrades the PM listener ssk, so
every child cloned from it inherits sk_net_refcnt == 0. Here
subflow_child_get_net() runs for every owned child, before the
!ctx || fallback check and the mp_capable / mp_join branching. That means
plain-TCP fallback children and MP_CAPABLE children of a PM listener also
get a real netns reference. The commit message only mentions MP_JOIN
children needing one.

On a pm_listener, MPC and plain requests are rejected only at SYN time, in
subflow_check_req():

	if (opt_mp_capable) {
		...
		if (unlikely(listener->pm_listener))
			return subflow_reset_req_endp(req, skb);
	} else if (opt_mp_join) {
		...
	} else if (unlikely(listener->pm_listener)) {
		return subflow_reset_req_endp(req, skb);
	}

mptcp_subflow_init_cookie_req() has no such check. It picks mp_capable or
mp_join from the options in the third ACK only:

	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK);
	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK);
	if (opt_mp_capable && listener->request_mptcp) {

Syncookies are in effect when net.ipv4.tcp_syncookies=2 (a per-netns
setting) or when the SYN queue is full. In that case, could this sequence
happen?

1. An MP_JOIN SYN with a valid token passes subflow_check_req() and gets
   a cookie SYN-ACK.
2. The third ACK has no MPJ_ACK, or has MPC_ACK instead.
3. cookie_tcp_reqsk_init() leaves mp_join = 0, so fallback_is_fatal is
   false. In the plain case the child falls back with ctx == NULL. In the
   MPC case it clones the kernel listener msk.
4. subflow_child_get_net() sets sk_net_refcnt = 1 on the child, which is
   then returned with drop_req == false.

tcp_get_cookie_sock() then puts the child on the PM listener's accept
queue:

	if (rsk_drop_req(req)) {
		reqsk_put(req);
		return child;
	}

	if (inet_csk_reqsk_queue_add(sk, req, child))
		return child;

Nothing ever accepts from that queue. Only inet_csk_listen_stop() drains
it, either when the endpoint is deleted or from pm_nl_exit_net(). But
pm_nl_exit_net() can't run while the queued child holds the netns
reference. Doesn't that leak the namespace the same way as before this
patch?

The setup is the same as the commit's reproducer: an unprivileged user in
their own user and net namespace. That user can set tcp_syncookies, get a
token from a loopback connection via MPTCP_INFO, and use CAP_NET_RAW to
send the MP_JOIN SYN and a bare ACK. While cookies are active, a remote
peer that knows a token could also trigger it, and so could a middlebox
that strips MPJ_ACK.

The later patches in this series, "mptcp: initialize drop_req in
subflow_init_req()" and "tcp: do not pass a BPF reqsk to an MPTCP
listener", don't seem to change this.

Could the reference be taken only for MP_JOIN children that get attached
to an msk? Another option would be to reject non-MP_JOIN cookie ACKs on a
pm_listener in mptcp_subflow_init_cookie_req().

>  		/* we need to fallback on ctx allocation failure and on pre-reqs
>  		 * checking above. In the latter scenario we additionally need
>  		 * to reset the context to non MPTCP status.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d%40kernel.org
