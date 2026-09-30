Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A026ED46;
	Wed, 30 Sep 2026 00:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728544; cv=none; b=WBy5YkIkefZ7NFPRYPwqE58Z4HdL3XBvuLAs3FE9YCN5IKoH9McECyet7jRD+huQAF5iBozZDBlxArAfE2zojqVwImhRNSCsIvrHdOEm4nyMjgFKUpH+BpuzpqBC+3ur4GWT4j6iLYMT+izUHaHDcssX4KZMJScDzWd17xUYfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728544; c=relaxed/simple;
	bh=UY4kEf4o17Ueqrxaz1S5FHuuiMkn/bARZckim7dOR9k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u40toExlUYuohr9Q87TpHAEN+/wIwWNP8IgT6W4dU6qo0Xan20sy/zIWLs62efHvu51pTaeN48dGN7eXk+R9R4DC6DpEtjSX4pkkCLnFPmAkPKbn6rC+Jt0aPQ2+VnIwptpYpJyp2PZL0zGQ1eEl+8tWQUocgSoQghg/xrI7Y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIfcwLnb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIfcwLnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401571F000FF;
	Wed, 30 Sep 2026 00:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790728542;
	bh=q0xMTP6T56JNk6y3Kd0qtlVFnQS8SfW8P8FGeo17Hbc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hIfcwLnbCWI1TbBkB5aZWKi1aj0fsaXErc09NdBrHodotUiSwiVmANi36SJxot/T3
	 n/Sjdj4r/ybWqb0/RgJDa7Yz0yg3wLjGi/tFYa0iGEbry/sNrTjJt5B+tIC7EwGagg
	 Q6malW8Mx18GCfn6vTE31Dbk1QgRex5T9pZOXAI7MBCdbqRUL0gbDpmeX2l3McLi29
	 wE+g33TJS664pBBh65RyHRBbSeHcYhFF+fU/pZtJGQ1TylWnsHSmy4sQON6cNmnOJ7
	 bPu76PrCLP00teKpyKJ20YSWm/Mixr1qDOj4lUddunu4UKj7usigVLCiIEsq5utOtH
	 4e2ANLk98QpOg==
Subject:
 Re: [PATCH net] net-sysfs: release the TX queue tracker before allowing reuse
From: netdev-bot+sashiko@kernel.org
To: nicoyip.dev@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, broonie@kernel.org, brauner@kernel.org,
 atenart@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Wed, 30 Sep 2026 00:35:41 +0000
Message-ID: <179072854183.434549.13632882104417529326@kernel.org>
In-Reply-To: <20260926173315.2452612-1-nicoyip.dev@gmail.com>
References: <20260926173315.2452612-1-nicoyip.dev@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch fixes the ordering in netdev_queue_release() (TX)
  but leaves the same ordering in the RX sibling, rx_queue_release() in…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the lockless
  reuse gate built on kobj->state_initialized does not act as a real…

--

net-sysfs: release the TX queue tracker before allowing reuse

The patch changes the order of operations in netdev_queue_release(). The
dev_tracker is now freed and an smp_mb() issued before the kobject is
cleared, and the device reference is dropped last. This keeps a concurrent
netdev_queue_add_kobject() from installing a new tracker that the old
release then frees.

> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 352173df75785..b9aadc4c000c4 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1906,8 +1906,11 @@ static void netdev_queue_release(struct kobject *kobj)
>  {
>  	struct netdev_queue *queue = to_netdev_queue(kobj);
>  
> +	netdev_tracker_free(queue->dev, &queue->dev_tracker);
> +	/* Finish using the tracker before allowing the queue to be re-added. */
> +	smp_mb();
>  	memset(kobj, 0, sizeof(*kobj));

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Does
the state_initialized check really publish the rest of the kobject reset?

The smp_mb() orders the tracker free before the memset() as a whole. The
memset() clears state_initialized, and it also zeroes name, entry, parent,
kset, ktype, sd, kref and, with CONFIG_DEBUG_KOBJECT_RELEASE, the trailing
struct delayed_work release. Nothing orders those stores against each
other.

netdev_queue_add_kobject() (and rx_queue_add_kobject()) reads the bit
under RTNL without any marking, then writes to the same storage:

	if (unlikely(kobj->state_initialized)) {
	...
	netdev_hold(queue->dev, &queue->dev_tracker, GFP_KERNEL);

	kobj->kset = dev->queues_kset;
	error = kobject_init_and_add(kobj, &netdev_queue_ktype, NULL,

On a weakly ordered CPU, could the re-adder see state_initialized cleared
while older zeroing stores from the release are still pending? A late zero
could then overwrite the new kset, entry, name or parent.

With CONFIG_DEBUG_KOBJECT_RELEASE and a preemptible kernel, there is a
second case. The old release could be preempted partway through the
memset(), after it clears the bitfield word but before it reaches
kobj->release. If the queue is then re-added and removed again under
RTNL, kobject_release() does:

	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);

	schedule_delayed_work(&kobj->release, delay);

Would the resumed memset() then zero a live timer and work item?

The plain read of the bitfield also races with the memset() store, so
KCSAN may report it.

> -	netdev_put(queue->dev, &queue->dev_tracker);
> +	__dev_put(queue->dev);
>  }

[Severity: Medium]
The same ordering is still present in rx_queue_release() in
net/core/net-sysfs.c:

net/core/net-sysfs.c:rx_queue_release() {
    ...
	memset(kobj, 0, sizeof(*kobj));
	netdev_put(queue->dev, &queue->dev_tracker);
}

rx_queue_add_kobject() uses the same lockless reuse check before it
installs a new tracker in queue->dev_tracker:

	if (unlikely(kobj->state_initialized)) {
		netdev_warn_once(dev, "Cannot re-add rx queues before their removal completed");
		return -EAGAIN;
	}
	...
	netdev_hold(queue->dev, &queue->dev_tracker, GFP_KERNEL);

RX attributes don't go through sysfs_rtnl_lock(), so the trigger described
in the commit message doesn't apply to them. With
CONFIG_DEBUG_KOBJECT_RELEASE, though, kobject_release() defers the cleanup
to a delayed work item that runs without RTNL:

netif_set_real_num_rx_queues()
  net_rx_queue_update_kobjects()
    kobject_put()                 /* under RTNL */
      kobject_release()
        schedule_delayed_work(&kobj->release, delay)

kobject_delayed_cleanup()         /* later, without RTNL */
  kobject_cleanup()
    rx_queue_release()

Can a later netif_set_real_num_rx_queues(), for example from ethtool -L,
re-add the rx queue between the memset() and the netdev_put() in that work
item? If so, the old release would free the new tracker.

With CONFIG_NET_DEV_REFCNT_TRACKER, the old tracker would leak. The next
rx queue release would then hit the same "ref_tracker: reference already
released" warning.

Should rx_queue_release() use the same order as the TX fix:
netdev_tracker_free(), then smp_mb(), then memset(), then __dev_put()?

>  
>  static const struct ns_common *netdev_queue_namespace(const struct kobject *kobj)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926173315.2452612-1-nicoyip.dev%40gmail.com
