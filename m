Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036378;
	b=La9CpjljLuGQb+RCWnbUKxWXVKNCHmerJeyCDUWjpj85Pc91qbpKrHm4cDD5q2cxHXuN
	 1L+mAahSMlFGAdVHHbF6BdWGuEw8gEekeyRfy5a9lFwkiEwRjXl9f91fbRONQVWdt0QZu
	 FbhGRNLSKewHnEkSIxQ/XKGXlbS3IFyiX2N5iGm56BOdohbX0c5APNGCV2GL2H7bjVywJ
	 4sVz5EDG6EZ4w4il9KzqJYLKR1fK2nBD2+B13jYUgop5EXCtojfzYmWMJORUbMKZj6e1s
	 4USncVyYRw0TNPxMwYqfJsUVxs1cwEDF+4WCaOTE9f5p0JGOvSaRHC1jSSg9AYS04Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036378;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=t8Or3b9/pQwlfW96GSEcWmN+qVfsQHETPMtYl66RaNU=;
	b=SFmYkTCbXXYGLMlk71ow1jbs5z+NOwYWff+3oqzPFIcUAUZu+G8QxZk9j7+FUGlAQfep
	 eRBQzt+p5/RbJCiIHb4s9y11ZTNmQSsbPSZ7qw9c+YeQ/I8j/LbCWJnHiWb905yplYfFb
	 XgttFyMy2vQ+DNs6wXtNyNkgNs1VESDukt8urt1Zd5Yw7rILv6wzs/Z7qXyHnL2taIW9B
	 cToi702ZHpOB3LV5HuOtTd9IElpPnZq42+QW82cB2awyOMBpqZqzWblW+uOzCYnF5sf30
	 yPlokzA1dAFzqLHS/8v2ejquKf70cs/0wyAcFfELlbZ7xMn0xYyLSdL7wNh5kRxiikA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DcTblxIK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D65606A325;
	Mon, 26 Oct 2026 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DcTblxIK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5C21F01825;
	Mon, 26 Oct 2026 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793036377;
	bh=t8Or3b9/pQwlfW96GSEcWmN+qVfsQHETPMtYl66RaNU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DcTblxIKUMbacZae6nQnDOLlJOAKsl2zHNVVwsdna3FHx04eCfESZinLgKdAHbSYZ
	 64UZ5OVpCPydLM1YFBWrtrLZwPPVErHRxJDTImnAEeD7fXh1Ci9rEDk42bj4e43yoJ
	 gn+1ghFxLMn62etYz4iP9fykfOHBE7dFRm/d0OtdoBBMyECoZzdO9Fy0S83XHDonR0
	 YMsH0lCbPkk31FS8MuyltKiDdLqA6FsxPFaACx7EhgEaZcL4XxwsRmJFLVcO2+3DcQ
	 M46gZMNrIsZ1waHdjY6XsECyPTVvMbtm7VqDdqRc9emfu/RDxpaAoJ2Huzf/Ve7m6Y
	 cFZACiDwD6Uuw==
Subject: Re: [PATCH net v2] net: qrtr: announce local services again once our
 HELLO is sent
From: netdev-bot+sashiko@kernel.org
To: 26rote@gmail.com
Cc: mani@kernel.org, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, christopher.lew@oss.qualcomm.com,
 deepak.singh@oss.qualcomm.com, pranav.phansalkar@oss.qualcomm.com,
 andersson@kernel.org, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
Date: Mon, 26 Oct 2026 17:39:36 +0000
Message-ID: <179303637610.3134.6464335759134048296@kernel.org>
In-Reply-To: <20261022163116.1042-1-26rote@gmail.com>
References: <20261022163116.1042-1-26rote@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/qrtr/af_qrtr.c, qrtr_hello_work() replays the HELLO
  once and never retries, so a failed replay is lost for good.
- [Low] In net/qrtr/af_qrtr.c, the new HELLO replay in qrtr_hello_work()
  is not serialized against qrtr_endpoint_unregister(), so the replayed…

--

net: qrtr: announce local services again once our HELLO is sent

The patch records that the remote node has sent a HELLO. Once our own
HELLO has gone out, qrtr_hello_work() passes a synthetic HELLO from that
node to the local name service. The name service then announces the
local services again, replacing the NEW_SERVER packets that
qrtr_node_enqueue() dropped with -EAGAIN before hello_sent was set.

> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> index e7b3647424b8f..508a2dd2d16d4 100644
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c

[ ... ]

> @@ -619,7 +626,20 @@ static void qrtr_hello_work(struct work_struct *work)
>  	pkt->cmd = cpu_to_le32(QRTR_TYPE_HELLO);
>  	from.sq_node = qrtr_local_nid;
>  	to.sq_node = node->nid;
> -	qrtr_node_enqueue(node, skb, QRTR_TYPE_HELLO, &from, &to);
> +	if (qrtr_node_enqueue(node, skb, QRTR_TYPE_HELLO, &from, &to))
> +		goto out;
> +
> +	/* Pairs with smp_store_release() in qrtr_endpoint_post() */
> +	if (!smp_load_acquire(&node->hello_rcvd))
> +		goto out;
> +
> +	skb = qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL);
> +	if (skb) {
> +		pkt->cmd = cpu_to_le32(QRTR_TYPE_HELLO);
> +		to.sq_node = READ_ONCE(node->nid);
> +		qrtr_local_enqueue(NULL, skb, QRTR_TYPE_HELLO, &to, &from);
> +	}

[Severity: Medium]
What happens if this replay is lost? If qrtr_alloc_ctrl_packet() returns
NULL, the replay is skipped without any message.

The return value of qrtr_local_enqueue() is also ignored. That function
frees the skb and returns an error in two cases. It returns -ENODEV if
the CTRL port lookup fails. It returns -ENOSPC if sock_queue_rcv_skb()
rejects the skb because the name service socket's receive queue is full:

net/qrtr/af_qrtr.c:qrtr_local_enqueue() {
    ...
	if (sock_queue_rcv_skb(&ipc->sk, skb)) {
		qrtr_port_put(ipc);
		kfree_skb(skb);
		return -ENOSPC;
	}
    ...
}

At this point hello_sent is already true. So this re-arm in
qrtr_node_enqueue() can no longer fire:

	if (rc == -EAGAIN && type == QRTR_TYPE_HELLO)
		schedule_delayed_work(&node->say_hello, msecs_to_jiffies(100));

The work only runs again after qrtr_endpoint_hello() on resume.

Without the replayed HELLO, ctrl_cmd_hello()->announce_servers() never
runs. The NEW_SERVER packets dropped with -EAGAIN before hello_sent was
set then stay lost, which is the outcome the commit message describes
for rmtfs and the modem.

Earlier in the same function, the first allocation failure reschedules
say_hello:

	skb = qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL);
	if (!skb) {
		qrtr_port_put(ctrl);
		schedule_delayed_work(&node->say_hello, msecs_to_jiffies(100));
		return;
	}

Should a failed replay also be retried, or at least logged? The commit
message lists duplicate NEW_SERVER announcements as the only cost. It
does not say that the recovery is best effort.

[Severity: Low]
Can this replayed HELLO reach the name service after the node's BYE?

After qrtr_node_enqueue() returns 0, ep_lock is no longer held, and
nothing here checks node->ep again. The GFP_KERNEL allocation can also
sleep. A concurrent teardown could run like this:

CPU1                               CPU2
qrtr_hello_work()
  qrtr_node_enqueue()
    xmit HELLO
    hello_sent = true
                                   qrtr_endpoint_unregister()
                                     node->ep = NULL
                                     queue QRTR_TYPE_BYE to NS
                                     qrtr_node_release()
                                       radix entries removed
                                       cancel_delayed_work_sync()
  qrtr_alloc_ctrl_packet()
  qrtr_local_enqueue(HELLO)

The NS worker would handle the BYE first in ctrl_cmd_bye(), then the
stale HELLO. ctrl_cmd_hello()->announce_servers() would then send
NEW_SERVER for every local server to the dead node id.

qrtr_sendmsg() then fails at qrtr_node_lookup() with -ECONNRESET. That
is not -ENODEV, so announce_servers() logs "failed to announce new
service" and qrtr_ns_worker() logs "failed while handling packet". If a
new endpoint has already registered with the same node id, it may get
duplicate announcements.

cancel_delayed_work_sync() prevents a use-after-free, so the effect
looks limited to log noise and extra announcements. Before this patch,
qrtr_hello_work() never sent anything to the local name service, so
this reordering is new.

Should the replay be ordered against qrtr_endpoint_unregister()?

> +out:
>  	qrtr_port_put(ctrl);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022163116.1042-1-26rote%40gmail.com
