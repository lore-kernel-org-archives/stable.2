Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666420;
	b=GpxRDS78kNZRDt9xXGUAItTIo0yy1nFkhsCkqbM9QS5psSWfgb/qPVAb0sw9kNubeKe/
	 pW4b5TzDgtyK5a6d9sxpqsP4FUhugBbyltKn1hJjVWWjQXSfXuPQKUFYg7m3ktx5qrriw
	 j1mPBgwRl5J7NFQ61BNzzBjtF2lwhkxDynUlPHgzGoap2iXHQiba/dU+KjLarrF6ZnqC7
	 j9UeIqqfUvRHn8b0Nzekhj4gHDjEFrA16FwIBNa1DTHlz1s6BbPs91xzOJoWmNR8Y4+sW
	 GsCZxNezl7O5ufe1cP+vMpHhTwhSsri5aFSoSjuANMnbHkiHYZNcyOTtxPOwBvlQxkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666420;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=whe/9x+rc26pzbBKiFHALFIMRF+zF1J8ZdVakLWuBL4=;
	b=YQaOgSw14RbyRRc+PIYUlCZ3veL62rrGJ+XpVvfkmON033xrMiZcHwwQzGzRyfKN9+uk
	 gJ5Sjn69E9VroQHOeftAUPeksRNvFoeILHaiNTzSMmK4AB6igzyJKVybtQh7egrJ935qN
	 nrhJ0kfqnMxH2joakIuMnPDob8nxNOTH8QF1SEQLwi6Frog/bWAyVerDMP+K/MpifRaU8
	 yTsQW1GZoNOL2MyksBuIIe1QYtZhTBlRPY/qQGoXrf6DjHu7KfYAOIzJHeNHxuvLyg7Xp
	 kYoCXQKeZL6iC5O5soyineMTBl2J2afqnIw0b8uZVXd9Lt25dgPGeCI/OyG+5zOQa8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvzmRmgH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6092606A324;
	Tue,  3 Nov 2026 00:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvzmRmgH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194AF1F000C1;
	Tue,  3 Nov 2026 00:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793666419;
	bh=whe/9x+rc26pzbBKiFHALFIMRF+zF1J8ZdVakLWuBL4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OvzmRmgHAQk7FVrpxi/rbL4/J01oaROSjqRzKLZ+rRb2Pt3Tp0+IoQNg9t4FBphDY
	 HgSmd0PVbq4/bguWqJGCMvjgfzUrMb9TJaZZC4AFJ54OM+/sme1rUMVzKma7ir+jO4
	 xtgf4eaMvEbJ0P2PtgMvfhi8y7jVDw9353q6iIMD0RnManbZS1GQx6evvew0M2D5rW
	 A4RA6L5q48sjrSft3OndjMUejBx0QYh92xhXQqLj4sFPt+XKbtTZ5oWirlboqNXZp8
	 Gp1WfGvFxDQsZuChYBomBIJxI2yivDSoMH6eFfxBHSWCX/3+wbdIy7iBVUKKaDLkBG
	 Ppyjww2qZZR7A==
Subject: Re: [PATCH net v2 3/4] net/sched: sch_teql: reject qdiscs from
 another network namespace
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com,
 davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us,
 kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com,
 thomas.goff@boeing.com
Date: Tue, 03 Nov 2026 00:40:18 +0000
Message-ID: <179366641863.488856.17368571591466000274@kernel.org>
In-Reply-To: <SER-NSBD.v2.r0.20261101171325-3@mojatatu.com>
References: <SER-NSBD.v2.r0.20261101171325-3@mojatatu.com>
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

- [Medium] The fix only enforces the master/slave same-netns rule once,
  when a slave attaches.
- [Low] After this patch, tc-testing case 124e ("Try to add teql as a
  child qdisc", tools/testing/selftests/tc-testing/tc-…

--

net/sched: sch_teql: reject qdiscs from another network namespace

With this patch, teql_qdisc_init() rejects a teql slave qdisc whose
device is in a different network namespace from the teql master. It
returns -EOPNOTSUPP and sets an extack message. It also moves
skb_queue_head_init() ahead of all validation, so every constructor
failure path sees an initialized queue.

Link: https://lore.kernel.org/netdev/20261022144830.67948-1-shawnq1@163.com/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v1.r2.20261031160050-3%40mojatatu.com

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
This checks the namespace only once, when the slave attaches. What keeps
the master and its slaves in the same namespace after that?

teql_master_setup() does not set dev->netns_immutable, and sch_teql does
not register a netdevice notifier. So the master can still be moved with
"ip link set teql0 netns X". __dev_change_net_namespace() only refuses
the move when netns_immutable is set, and it only shuts down the device
being moved:

net/core/dev.c:__dev_change_net_namespace() {
    ...
	if (dev->netns_immutable) {
		NL_SET_ERR_MSG(extack, "The interface netns is immutable");
		goto out;
	}
    ...
	dev_shutdown(dev);
    ...
}

The slave qdiscs sit on other net_devices, so teql_destroy() never runs
for them. m->slaves and NEXT_SLAVE() still point at devices in the old
namespace.

After the move, teql_master_open() takes its MTU and flags from those
slaves and teql_master_mtu() checks against them. teql_master_xmit()
also sends the master's traffic through them:

teql_master_xmit()
    struct net_device *slave = qdisc_dev(q);
    ...

Doesn't that bring back the cross-netns master/slave state this patch
is trying to remove?

There is also a way back into init_net. teql0 has no rtnl_link_ops, so
when its netns is destroyed, default_device_exit_net() moves it back to
init_net:

	err = dev_change_net_namespace(dev, &init_net, fb_name);

Suppose root gives teql0 to a container netns B. The container could
attach a slave in B, move teql0 to another netns C that it owns, and
then delete C. teql0 would end up in init_net with a slave on a
container-controlled device in B. That looks like the case the commit
message describes.

The first move out of init_net needs CAP_NET_ADMIN in init_net, so this
patch does close the unprivileged reproducer in the commit message.

Could teql_master_setup() also set dev->netns_immutable = true? Another
option would be to detach the slaves when the master changes netns.

[Severity: Low]
After this change, does tc-testing case 124e ("Try to add teql as a
child qdisc") still test the root-only rule?

124e requires nsPlugin, so $DUMMY is created inside a per-test netns.
teql0 is always in init_net. The root-only check and the new netns
check both return -EOPNOTSUPP. 124e only checks the exit code and an
empty matchJSON:

        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:1 handle 2:1 teql0",
        "expExitCode": "2",
        "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY parent 1:1",
        "matchJSON": [],

If the "teql can only be used as root" check were removed or broken,
the netns check would still reject the command with the same exit code.
The test would still pass.

The v2 notes say:

  The cross-netns check ran before the "teql can only be used as root"
  check, so every case it did not catch was answered by that check, masking
  the assertion that tc-testing case 124e makes.  The root-parent
  validation now runs first and the namespace check second

The new order only changes which check fires first. Either way, 124e
cannot tell the two checks apart.

Could 124e run in init_net instead? It could drop nsPlugin and create
$DUMMY in its setup, as 84a0 does. Alternatively, it could check the
extack message.

>  
> -	skb_queue_head_init(&q->q);
> +	q->m = m;
>  
>  	raw_spin_lock_irqsave(&m->slaves_lock, flags);
>  	first = rcu_dereference_protected(m->slaves, lockdep_is_held(&m->slaves_lock));

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v2.r0.20261101171325%40mojatatu.com
