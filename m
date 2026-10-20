Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501096;
	b=jWq3sQcGhQUNT9x2uhYhnl7/wNCYpfpy3r+NSbMWCMSiBq/SRluRfRpg9RH0wbuFXCm8
	 vNJFX7mffzhAPGmHikHmvFbS7I/3SypVgAT3AQSnyXAHxqOY8AF18XjcQ4n6PMnKamNTH
	 mdU3bWd9iXGMNcpo3Ymqmsu4IMQK5BDtMXwGgVcp+UW4neCma7Hu2yb/q17KGoxSzR4h0
	 g2Q1w388/3M9m+KlYkTSnY72GeCeRmh6shbF+6/NaQsBQ9Hiy14NA+Dzho88OnbWug+M8
	 vQAwcNv+icZIX17dQwAwfYf1S8FgsU8qZZtqGZQDgcHaJ9eGno1/gl5/5aM605YL7XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501096;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vtCP26DpY2c2hU6zTLzJyhbg9JoBerPpCuydmwi/Jm4=;
	b=VWgqrEwoB49WOYLagZfzjfZFtO01NTWcSHod+h+eaE9lBvqfsNsxDaPCzlM8FpiAr2WO
	 YFhFCyoRNQtwdf449wzaFMKMoQGAEhx8s53df5L78TUuAGZJBGXh91tbEgLRJBS0RcCPL
	 3HjP80o62YROkTC/6hvbpX4SxpKaabwivrK+6MHvHDgQ04Rgs3R5MdYMJ8TJgHML3w5ds
	 p60W9bGzDIzwORjhS1iekVYLm6KNd+gwZK/TI1znFrZRmB9M3FYPqrrZGGcbyEnH/F5oC
	 O0Hi0pYngi4yROXedrLezHcdnXYupExRBJtEEEZgZ0w017Gd1a7GgFY21TOwBagqV7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F93BkvAO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45367606A319;
	Tue, 20 Oct 2026 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F93BkvAO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1E61F000C4;
	Tue, 20 Oct 2026 12:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501095;
	bh=vtCP26DpY2c2hU6zTLzJyhbg9JoBerPpCuydmwi/Jm4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F93BkvAOG46lyanKv3X1lsqp/Hk7tg2FhdDJp1RACJ7ZUs2LTzlE40qHBU700dGO0
	 GT26kZMmUI4o8Y0VUk4x+InI96SRdn9/yKwdiBkebsm0YIdhUFOfbIeWD7eiN/zzle
	 rS4fK9B6xGojaSLhYTM9sbwomeSjBoCLTsbLR2bQfufgwWEP7VO27lSQx/OTp89Nww
	 cW3aOWnjuecpBv4KIboMRJWFnEbR3H19M2oTH4RS9+PlFlQtmOnqykHGkrZMeMGzR6
	 F7cj4DJjUfoSPjVLYGsRAxJj/g9agxZMNR8iX395Jknycp4x/6KmLoE6OQ3opRcdiG
	 KjmzjA5kVxGbg==
Subject: Re: [PATCH net] net: qrtr: ns: retry service announcements on -EAGAIN
From: netdev-bot+sashiko@kernel.org
To: 26rote@gmail.com
Cc: mani@kernel.org, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, christopher.lew@oss.qualcomm.com,
 deepak.singh@oss.qualcomm.com, pranav.phansalkar@oss.qualcomm.com,
 andersson@kernel.org, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
Date: Tue, 20 Oct 2026 12:58:14 +0000
Message-ID: <179250109438.3135.5278679700614096504@kernel.org>
In-Reply-To: <20261016124600.31-1-26rote@gmail.com>
References: <20261016124600.31-1-26rote@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix only covers one of the two paths that send NEW_SERVER.
- [Medium] The new retry loop in announce_servers() (ns.c:232-236) can
  stall the whole name service for about 10 s per remote HELLO.
- [Medium] The NS side gives up after a fixed 10 s, but the core keeps
  retrying our HELLO with no limit.

Pre-existing issues:
- [Medium] A retry can re-advertise a service that was closed during the
  retry window, and the remote then keeps the stale entry.

--

net: qrtr: ns: retry service announcements on -EAGAIN

This patch makes announce_servers() retry service_announce_new() every
100 ms, for up to 10 s per server, while it returns -EAGAIN. The goal is
that NEW_SERVER replies to a remote's HELLO are not lost before our own
HELLO has gone out. It targets a modem watchdog reset on Kaanapali when
rmtfs registers before the modem comes up.

> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index bcb090ee79d49..33a9c4449d6f8 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c

[ ... ]

> @@ -226,7 +227,13 @@ static int announce_servers(struct sockaddr_qrtr *sq)
>  
>  	/* Announce the list of servers registered in this node */
>  	xa_for_each(&node->servers, index, srv) {
> +		unsigned long timeout = jiffies + 10 * HZ;
> +
>  		ret = service_announce_new(sq, srv);

[Severity: High]

This retries the unicast NEW_SERVER replies sent from announce_servers().
Can the broadcast path still lose announcements at the same HELLO gate?

Take a local service that registers after the remote's HELLO has been
handled, but before our HELLO has gone out. It is announced from
ctrl_cmd_new_server():

net/qrtr/ns.c:ctrl_cmd_new_server() {
    ...
	if (srv->node == qrtr_ns.local_node) {
		ret = service_announce_new(&qrtr_ns.bcast_sq, srv);
    ...
}

That reaches qrtr_bcast_enqueue(). It skips only nodes that have no nid
yet, and it ignores the return value of qrtr_node_enqueue():

net/qrtr/af_qrtr.c:qrtr_bcast_enqueue() {
    ...
		if (READ_ONCE(node->nid) == QRTR_EP_NID_AUTO)
			continue;
    ...
		qrtr_node_enqueue(node, skbn, type, from, to);
	}
    ...
	return 0;
}

qrtr_endpoint_post()->qrtr_node_assign() sets the nid when the remote's
first packet (its HELLO) arrives. From then on the node receives
broadcasts, even while hello_sent is still false. qrtr_node_enqueue()
then frees the NEW_SERVER and returns -EAGAIN:

	if (!node->hello_sent && type != QRTR_TYPE_HELLO) {
		mutex_unlock(&node->ep_lock);
		kfree_skb(skb);
		return -EAGAIN;
	}

ctrl_cmd_new_server() sees success. If node->servers was empty when the
remote's HELLO was handled, announce_servers() had nothing to retry.
Nothing calls announce_servers() again once hello_sent becomes true.

The same window opens again after qrtr_endpoint_hello() clears hello_sent
on resume, because the nid stays assigned. DEL_SERVER broadcasts from
server_del() are dropped the same way.

In that case, wouldn't rmtfs (or tqftpserv, pd-mapper) stay unannounced,
leading to the modem watchdog reset described in the commit message?

Could this be handled in the core instead of by polling in one caller?
For example, packets could be queued in qrtr_node_enqueue(), or the
announcements replayed once hello_sent becomes true.

> +		while (ret == -EAGAIN && time_before(jiffies, timeout)) {
> +			msleep(100);

[Severity: Medium]

Can this stall the whole name service for up to 10 s per remote HELLO?

announce_servers() is called from ctrl_cmd_hello() inside
qrtr_ns_worker(). That worker is the only reader of the NS socket, and
it runs as a single work item on an ordered workqueue:

	qrtr_ns.workqueue = alloc_ordered_workqueue("qrtr_ns_handler", 0);

While this loop sleeps, everything else waits behind it: local
NEW_SERVER and NEW_LOOKUP, plus the BYE, DEL_CLIENT and DEL_SERVER
cleanup for every other node and port. Stalls caused by several remotes
add up one after another.

hello_sent can stay false for a long time, or for good. When the remote
rejects an intent request, qcom_glink_request_intent() returns -EAGAIN.
qrtr_node_enqueue() reschedules say_hello only on -EAGAIN:

	if (rc == -EAGAIN && type == QRTR_TYPE_HELLO)
		schedule_delayed_work(&node->say_hello, msecs_to_jiffies(100));

A HELLO that fails with -ETIMEDOUT or -ENOMEM leaves hello_sent false
for good. After that, every later HELLO from that node costs the full
10 s.

Control packets keep arriving through sock_queue_rcv_skb() while the
worker sleeps, from both qrtr_endpoint_post() and qrtr_local_enqueue().
Once sk_rcvbuf is full they are dropped, which can leave stale lookup
and server state. qrtr_ns_remove() also has to wait in
cancel_work_sync() for the sleep to finish.

The commit message only says the worker "can sleep". Could the retry be
moved out of the shared worker, or at least could the commit message
describe these effects?

> +			ret = service_announce_new(sq, srv);

[Severity: Medium]

This is a pre-existing issue, but the retry makes the window wider. Can
this re-advertise a service whose port was closed while the loop was
sleeping?

Sequence:

1. announce_servers() is sleeping in msleep(100), with srv pointing at
   local server S on port P.
2. qrtr_hello_work() succeeds and hello_sent becomes true.
3. Port P is closed. qrtr_port_remove() broadcasts DEL_CLIENT to the
   remote through qrtr_bcast_enqueue(), which now gets through. It also
   queues a local copy for the NS.
4. The NS wakes up and sends NEW_SERVER for P to the remote.
5. Later the NS handles the local DEL_CLIENT. ctrl_cmd_del_client()
   calls server_del(node, port, false), which sends no DEL_SERVER.

The remote is left with an entry for a closed service. This is not a
use-after-free, because only the NS worker frees entries in
node->servers.

The same ordering race already exists whenever the NS worker handles a
remote HELLO before a queued local DEL_CLIENT. The retry adds a window
of up to 100 ms right after hello_sent becomes true.

> +		}
>  		if (ret < 0) {
>  			if (ret == -ENODEV)
>  				continue;

[Severity: Medium]

What happens if the remote accepts our HELLO only after the 10 s
deadline?

When the deadline passes, ret is still -EAGAIN. announce_servers() then
prints "failed to announce new service" and returns, skipping the
remaining servers. qrtr_ns_worker() only logs the error.

The core keeps retrying HELLO every 100 ms through qrtr_hello_work(),
with no limit. So hello_sent can become true after the NS has already
given up:

		if (!rc && type == QRTR_TYPE_HELLO)
			node->hello_sent = true;

At that point nothing in ns.c or af_qrtr.c calls announce_servers()
again, and the remote's HELLO has already been handled. Wouldn't every
service registered before then stay unannounced? That is the same rmtfs
failure this patch is meant to fix.

On glink the firmware controls this delay. qcom_glink_request_intent()
can wait up to 10 * HZ for each intent request while the HELLO xmit
holds node->ep_lock.

The first service_announce_new() blocks on that mutex at the hello_sent
check in qrtr_node_enqueue(). The deadline was set before that call, so
it keeps running, and one slow intent round trip can use up the whole
window. The window also opens again after every qrtr_endpoint_hello()
on resume.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016124600.31-1-26rote%40gmail.com
