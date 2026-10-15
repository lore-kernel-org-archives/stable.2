Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9617735893;
	Thu, 15 Oct 2026 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792025588; cv=none; b=NfQ32YBHUa6C2x73ntoj3w0n/eolFxKudf9NyIExgZlKZ0XtmUybBQ7xYF90MVLg3/Z8TEkikoCRl3odei7Wr5L7s7Mj9VZYA7MxTMEsfkG0KjEJfeBd1SwDu+gzdIaS/HAgVVrXZjB5l8F0aUelB7QRmfyP7T/xeHUWj48vIxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792025588; c=relaxed/simple;
	bh=E7EnskHoVFJDOq/yZ4g/tAQFukU7Ur9O93djCRFzwt4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DJHmfZVMzlJ67XP5QwGm+cXXEzmFvpRSczBCKPKfQOVkoi0TeGZjrJ6Q2JOG+C3O3yo7Jta1M2B3K2LpUYkweg9RJHbapw8tgHbTWitZ5IMmxl0vbnCDgWw2NfW9UNGFZ9wf28jg1q3IuCrjcwwFXSJ6OHErrdXqWo4p198/lTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0UwTULL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0UwTULL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CE51F000C4;
	Thu, 15 Oct 2026 00:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792025587;
	bh=wYLBV9IqiMtITWWs+chk8oe2e6Yj6QQSCVIwnTRXAV4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D0UwTULLDS3drUhFqgOshuPnlolG6aVkOAqJaMJw+wPoFaZTtv/yFxTFEXirtjuso
	 mdQ/PISfPq//P+Ac6IyVmJZPY3TOkyDGM2ia75dWOJok+5Cny2qalmONX7b1cZqzEy
	 nZ16v3MN6CErXFeUWlYpQdnYBQSG7Am4L/q4rf9fQLkV8e2t00yL7FEMQVtKyUONoY
	 AxPpuV+yfoLbllcIaYzhoX9e1/FJrlDjVQUZ+ANRneZoSLv8uFJ37JXFHK9zDLugEf
	 epozhewQhuuOWXYzRp6nUWc1oZhxLv0LofKm58kUO1JN9Mjis5XrBb7hsFXyjy9Pkw
	 t3H9uOg9QpaoQ==
Subject: Re: [PATCH] can: bcm: fix filter removal race between release and
 netns change
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, norbert@doyensec.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Thu, 15 Oct 2026 00:53:06 +0000
Message-ID: <179202558650.1406898.13261480758347943519@kernel.org>
In-Reply-To: <20261013113628.104020-1-socketcan@hartkopp.net>
References: <20261013113628.104020-1-socketcan@hartkopp.net>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] bcm_release() now holds RTNL across remove_proc_entry() for the
  per-socket /proc/net/can-bcm/<ino> file and across the whole tx_ops…

--

can: bcm: fix filter removal race between release and netns change

This patch takes rtnl_lock() in bcm_release() before the socket is removed
from bcm_notifier_list. That way bcm_release() and bcm_notify() can't both
skip removing the CAN filters while the bound device changes namespace.
RTNL is dropped before synchronize_rcu(), and the busy-wait loop on
bcm_busy_notifier is replaced with a WARN_ON_ONCE().

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 3d637a1e0ac1a..4765c14947fc3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1926,12 +1926,14 @@ static int bcm_release(struct socket *sock)
>  
>  	/* remove bcm_ops, timer, rx_unregister(), etc. */
>  
> +	rtnl_lock();
> +

[Severity: High]
Once rtnl_lock() is taken here, RTNL stays held across lock_sock(), the
procfs removal and the tx_ops teardown. It is only released by
rtnl_unlock() after the rx_ops unregistration loop:

net/can/bcm.c:bcm_release() {
    ...
	lock_sock(sk);

#if IS_ENABLED(CONFIG_PROC_FS)
	/* remove procfs entry */
	if (net->can.bcmproc_dir && bo->bcm_proc_read)
		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
#endif /* CONFIG_PROC_FS */

	list_for_each_entry_safe(op, next, &bo->tx_ops, list) {
		list_del_rcu(&op->list);
		bcm_remove_op(op);
	}
    ...
}

Can remove_proc_entry() block forever here while RTNL is held?

remove_proc_entry() calls proc_entry_rundown(), which waits for every
in-flight user of the entry:

fs/proc/inode.c:proc_entry_rundown() {
    ...
	if (atomic_add_return(BIAS, &de->in_use) != BIAS)
		wait_for_completion(&c);
    ...
}

bcm_connect() creates the per-socket entry with proc_create_net_single()
and mode 0644, so any local user can open it. The entry is not permanent,
so proc_reg_read() holds use_pde() across seq_read(), and that includes
the copy to the user buffer:

fs/proc/inode.c:proc_reg_read() {
    ...
	} else if (use_pde(pde)) {
		rv = pde_read(pde, file, buf, count, ppos);
		unuse_pde(pde);
	}
    ...
}

A user can stall that copy, for example by reading into a FUSE-backed
mmap buffer. The sequence would then be:

socket(PF_CAN, SOCK_DGRAM, CAN_BCM)
connect()     /* ifindex 0 is accepted, proc entry is created */
read() of /proc/net/can-bcm/<ino> into the stalled buffer
close()
  bcm_release()
    rtnl_lock()
    remove_proc_entry()
      proc_entry_rundown()
        wait_for_completion()   /* RTNL still held */

Would every other rtnl_lock() user on the system then hang behind this
close()? That includes ip link, netns creation and teardown, and device
registration.

Before this patch, the same wait ran under lock_sock() only and affected
just this socket. bcm_notify() already calls remove_proc_entry() under
RTNL, but only on NETDEV_UNREGISTER of the bound device. This path can be
reached from a plain close().

Even with no stalled reader, the tx_ops loop runs bcm_remove_op() under
RTNL, with two hrtimer_cancel() calls per op. The RTNL hold time therefore
grows with the number of tx ops.

RTNL only seems to be needed for the bcm_notifier_list removal and the
rx_ops can_rx_unregister()/bcm_rx_unreg() loop. Could the procfs removal
and the tx_ops teardown be moved out of the RTNL section, either before
rtnl_lock() or after rtnl_unlock()?

> +	/* The netdev notifier chain runs under RTNL, so bcm_notifier() can't
> +	 * be walking bcm_notifier_list and point to this socket. The spinlock
> +	 * is still needed as bcm_init() adds sockets without holding RTNL.
> +	 */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013113628.104020-1-socketcan%40hartkopp.net
