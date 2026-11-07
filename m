Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063021;
	b=QU+YTzjwIUuhNckcyX2XwQq25KGcKOFMTvbSm5mPfKLa43UTgY4k4/0R7idfhbeh/Wl0
	 bG6AvaiArT8obGPad/DeCwZz3r+qHapZ0Q749vWZFLWbvYy6J4SttNhrb/EJDAvvkleJm
	 GHUEY1zrFc77M1wiS8BjZqD1RKOCKYv+ScK82b7liejnLq60M+CsaOIL8qh1uaxRRxrDS
	 DxMyqpWCXQ0jvD/NheU+iR2RskhAj17VToOuIHG1CB9+YHBpZHEs208IPgpw2jOp0iYHV
	 z+70R/kmUt7iS3mn+VL3UIDD5BJW5N0ln7AUOtQB2CmJSiggF8gyTdrUTCnKXKZIgAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063021;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xziTI3YYXoskqI56R/QdTymEmbBbGrcSZUWa4NYlYs8=;
	b=0FP0qq3NZgVwnQjCWMcbiYrUBZB7uRlooTvdezQnGR718qK5YIUT/U6FJc/7iFjUwvzn
	 GnAoXRbm6YIbqRxgQxCg+X4ejKCNe1KAgQanisUSVXar+GJik0GdJjPT44NCybiXErcsS
	 jMUd6zqTGyjMCxGsTb496GUCMN1qPVWe9QZPdTldL+sLPuFKNnbIZOTxPfsh8kG8b/PTi
	 OYcnD8APfl7xTPhMDG38VMvY73Mfn6qkGbtZA5C9qY1zsrVczB2fbQzuVGDNgKLQZox39
	 /BrjoXUMhT2cVBOZxO/lSv9afzOvlA7Ust90Oj3GJgt89OTvsLEsRnbfVyAK0xXQQIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHkhNWd+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1966B606EE90;
	Sat,  7 Nov 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHkhNWd+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C641F008A1;
	Sat,  7 Nov 2026 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794063020;
	bh=xziTI3YYXoskqI56R/QdTymEmbBbGrcSZUWa4NYlYs8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MHkhNWd+ccUY4Jd5KfYGhVuDD3ZCdTUJmjHuVlouN0Fdo1QjKGhA0qJgRPxcthDZz
	 xb28HTcUZmTFOpLTM04kxqzOMMcin7RNrmW+ziygyOVK4/MoV9gFZC/nVNFGcp5pOU
	 QxwxLmjyOteYomnqOCuPq421URTMldl+KaZ0z/Q+y85NG1aA5sW8g8febtuX0q33SQ
	 TdCkDOFDxAO0mVb74ydDN42XRx81DXxnngLx+TZ/0DH/6RhKEVh6jC76BwFZumseCU
	 VuHlC28SK6jmmlhGFVRtW/hngbE/KJeXUNud9SEymrE/eZuMECf3Tn8ZR2SLGay7lE
	 dsy3Dfg7lyH4A==
Subject: Re: [PATCH net v3 3/4] net/sched: sch_teql: reject qdiscs from
 another network namespace
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com,
 davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us,
 kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com,
 thomas.goff@boeing.com
Date: Sat, 07 Nov 2026 14:50:19 +0000
Message-ID: <179406301946.994134.7212801896124135602@kernel.org>
In-Reply-To: <SER-NSBD.v3.r0.20261103064310-3@mojatatu.com>
References: <SER-NSBD.v3.r0.20261103064310-3@mojatatu.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix checks that the slave device and the master are in the
  same network namespace only once, in teql_qdisc_init()…
- [Low] The commit message says only that a qdisc from another netns
  could attach to the init-net master "and change its MTU and flags".
- [Low] Moving skb_queue_head_init(&q->q) to the top of teql_qdisc_init()
  (sch_teql.c:203) is presented as groundwork for the new netns failure…

--

net/sched: sch_teql: reject qdiscs from another network namespace

This patch makes teql_qdisc_init() reject a teql qdisc whose device is
in a different network namespace than the teql master. It returns
-EOPNOTSUPP with an extack message. It also moves skb_queue_head_init()
of the private queue to the top of teql_qdisc_init(), so every
constructor failure path sees an initialized queue.

Link: https://lore.kernel.org/netdev/20261022144830.67948-1-shawnq1@163.com/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v1.r2.20261031160050-3%40mojatatu.com
Link: https://lore.kernel.org/netdev/179366641863.488856.17368571591466000274@kernel.org/

> The issue:
> The teql master devices are created once in the initial network
> namespace and their Qdisc_ops are global. teql_qdisc_init() takes the
> teql_master embedded in the registered sch->ops and uses it without
> checking whether the new qdisc's device lives in the same network
> namespace as the master. A qdisc created in another netns can therefore
> attach to the init-net master and change its MTU and flags.

[Severity: Low]
Does this description understate the impact of the bug?

Besides changing the MTU and flags, teql_qdisc_init() links the foreign
qdisc into the master's slave ring, or makes it the first slave:

    rcu_assign_pointer(NEXT_SLAVE(first), sch);

>From then on, teql_master_xmit() round-robins init_net traffic sent
through teqlN onto the device from the other netns. There is no netns
check and no skb scrubbing:

    skb->dev = slave;
    if (!netif_xmit_frozen_or_stopped(slave_txq))
        rc = netdev_start_xmit(skb, slave, slave_txq, false);

If teql0 is already up with slaves, the attach still succeeds as long as
the foreign device has compatible flags and an MTU at least as large as
the master's. A CAP_NET_ADMIN holder in a user namespace can set both.

With a veth slave, the netns owner could capture or drop part of the
host's teql traffic. It could also answer ARP that __teql_resolve()
sends on that device.

The code change closes this path as well. Since stable and CVE triage
depend on the stated impact, could the commit message describe the
cross-netns traffic interception?

> Initialize the private skb queue before any validation so every
> constructor failure path, including qdisc_create_dflt(), which resets the
> qdisc before destroying it, sees an initialized empty queue.

[Severity: Low]
This isn't a bug, but should the commit message say that this reorder
also fixes an existing NULL pointer dereference?

Before this patch, three returns happened before skb_queue_head_init():
-EINVAL (hard_header_len), -ELOOP (m->dev == dev) and -EOPNOTSUPP
(non-root parent). On those paths q->q was still zeroed. When init
fails, qdisc_create_dflt() calls qdisc_put(), which leads to:

    qdisc_put()
      __qdisc_destroy()
        qdisc_reset()
          teql_reset()
            skb_queue_purge(&dat->q)

skb_queue_purge_reason() sees list->next == NULL. That is not equal to
list, so it treats the queue as non-empty, and skb_queue_splice_init()
dereferences a NULL first pointer.

This looks reachable with net.core.default_qdisc=teql0. mq, mqprio and
taprio create children with a non-root parent, and
attach_one_default_qdisc() on teql0 itself returns -ELOOP. Setting
default_qdisc needs CAP_NET_ADMIN in init_net.

Would it be worth calling out the crash fix explicitly, for backports
and Fixes: attribution?

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index 70c948a26f809..dc21cd9704a25 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c

[ ... ]

> @@ -211,9 +213,12 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	q->m = m;
> +	if (dev_net(dev) != dev_net(m->dev)) {
> +		NL_SET_ERR_MSG_MOD(extack, "teql master is in a different network namespace");
> +		return -EOPNOTSUPP;
> +	}

[Severity: Medium]
Is a netns check at attach time enough to keep the master and its
slaves in the same namespace?

teql_master_setup() never sets dev->netns_immutable. That means
__dev_change_net_namespace() lets teqlN move to another netns while
slaves are attached, because this is the only guard:

    if (dev->netns_immutable) {
        NL_SET_ERR_MSG(extack, "The interface netns is immutable");
        goto out;
    }

The move runs dev_shutdown() only on teqlN's own qdisc. The teql slave
qdiscs on the init-net devices stay linked in m->slaves:
teql_master_close() only stops the queue, and teql registers no netdev
notifier.

Once the master is in netns B, three things can happen:

The owner of B, who may be root in an unprivileged user namespace,
passes the new dev_net(dev) == dev_net(m->dev) check. It can then add
its own devices to a ring that still holds init-net slaves.

teql_master_open() takes the MTU and flags from the init-net slaves.

Traffic sent through teqlN in B reaches teql_master_xmit(), which sets
skb->dev = slave and calls netdev_start_xmit() on the init-net slave.
Through __teql_resolve(), it also calls ipv4_neigh_create() on the
init-net slave.

Moving teqlN out of init_net needs CAP_NET_ADMIN in init_net, so the
unprivileged user cannot do this alone. After this patch, though,
moving the master seems to be the only way a container can use teql.

Should the master be marked netns_immutable? Alternatively, should a
netns change of the master be refused, or detach the existing slaves?

> -	skb_queue_head_init(&q->q);
> +	q->m = m;
>  
>  	raw_spin_lock_irqsave(&m->slaves_lock, flags);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v3.r0.20261103064310%40mojatatu.com
