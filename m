Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D8367B98;
	Thu, 15 Oct 2026 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048126; cv=pass; b=F0wWTMTce7m4NhnG7TYnI9eSS4IaGp6TuSGr3GByoK8rRs7uUFQ7tenZ9kqI/Lv2ND5wxt66mU+0JSzHLnN0nOXPcGYIJRG+SKM5VwVgqZ1tuwbAtW6iAmdeIfanZTAytBcl5GIe51RWYrCxlX8bHLII4zWOdoWZ90vFJF2aeJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048126; c=relaxed/simple;
	bh=M6RZT5jRHtkbSqddt9/p+HYLPygwtK77RP40wkql4WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Amf/zqVItYLGSOyMYMTptB8ZpS/ldb06nQnZpcvVTX04ZOQCnqzh+nWqG+ccG9/ShVTSyNmdVox/lSOVNYsI4G2ccGi619SfA/7KT7tKKtEM+eAsrd8q9ifavt1ck3Zkv9xB3C2bGWdmaUEOSasG30CCie+GuWBJH7IO4I7BaBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Dq1r5sw1; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=0GEB+WuA; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Dq1r5sw1";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="0GEB+WuA"
ARC-Seal: i=1; a=rsa-sha256; t=1792048106; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=i2QZOxOOnRtqua9wPvlmiuPb8b0fWmLhwY7FdiHa6Vc5LIPFxjfLGE7EKKRg40fhCh
    NGd/VsSpCGvi0XpyI0UuOQnvRE0DlEcXw0otj9fMyfn3NhS+UWeaFZqCLFvJjJ756NLV
    W82mOxPJ0fnYkGVF6E0SsQ+yT147W883C7twBBaY3xG9yKChLhf8eIHxkRCNYMVkIBdM
    2+e+UkLxLolvMixxk1O2YqWiSzkibnH1NALlBDc8dcQywyTktVweI5tMB1Zra8RbhVnN
    TbocGFcCN6MpZ/xWDzRDZllpe/SWU7V5UvbHhswjva0q+YXm9XjyaBrTwMgVkNgQ/sNX
    VcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792048106;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+RUWTXWMZVYv6/mFKNY/zQeDKOR4iAXiWK6Z3ZvuI+Q=;
    b=hxC6rJwPmOfar4HOUy32rHIIYddebjX7mL7vqsy2EayCG92vv+0MNUeHFcQxdAutA8
    q6k8OMFKe0sgikHlYYfA//63ovSmtqVfjBbiubMeF94S6J5tmovhth1zA1DMmUhlwSwU
    po6k8i63/JcQ5xwO5zAIPpbBryNIo48CKFSmmoQC69zFm+n91wJtzw63YSWJ3K+/qFlV
    k44W1BnFfWf36zcyGzRHfiP/p9b5FNiwGqMRDi8n+572n/pZ+z/AGXaKQVSEsFu46pnV
    nJ6wbt9L4LCOP5unJMXR67+JAUoaFPrQHGmI/mA1RO3JgpY6Un9cmcjyWKqoJXcFymoS
    L/4g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792048106;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+RUWTXWMZVYv6/mFKNY/zQeDKOR4iAXiWK6Z3ZvuI+Q=;
    b=Dq1r5sw1R8unxoa4FfHenq9eJJFS0VhpERXLwxz7+L+BCOxsOnJQUl3JL9PrHsepVH
    +/YPDLxA+yNB18H2G9/KmhAvHJmL4zZ7guJTQIeQZ8SdOUclj7QvMc2ZpWv8OAIi12aw
    ZSQVwEY1RM1FetWZ8AoGUdIB0UUWOdIW+FkFHj6MM7p/cDbZDmkDjk6f4hWFe/PrweRD
    vc9dLA4xlWFviUZOdsYlHmpLOoVNMVEmqlEFm6NsRVd20xXnRAyz2AXsjGMFT9CDgcTa
    5RZ7edR37jsaGqA9Fz7qMe5UfAEeVSDe4zRwdGwKABaMP1SZJG9ClbWq24DWjAuQUj9M
    hcnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792048106;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+RUWTXWMZVYv6/mFKNY/zQeDKOR4iAXiWK6Z3ZvuI+Q=;
    b=0GEB+WuALGnrfseUYxm7oYpD+yto1N+85Bf5l7AXu6ZkA8KLQo/RAnuvYZmHfqYlHx
    utHSd2l6zI7g7hmE7FBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29F78PG7Q
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 15 Oct 2026 09:08:25 +0200 (CEST)
Message-ID: <f9623129-9ee0-4ab7-b38b-6e71b1cc9d10@hartkopp.net>
Date: Thu, 15 Oct 2026 09:08:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: bcm: fix filter removal race between release and
 netns change
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, norbert@doyensec.com, stable@vger.kernel.org,
 kuba@kernel.org
References: <20261013113628.104020-1-socketcan@hartkopp.net>
 <179202558650.1406898.13261480758347943519@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179202558650.1406898.13261480758347943519@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This is an old feedback.

Corrected patch based on this sashiko review is already on its way:

https://lore.kernel.org/linux-can/20261014142114.280279-3-socketcan@hartkopp.net/


On 15.10.26 02:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] bcm_release() now holds RTNL across remove_proc_entry() for the
>    per-socket /proc/net/can-bcm/<ino> file and across the whole tx_ops…
> 
> --
> 
> can: bcm: fix filter removal race between release and netns change
> 
> This patch takes rtnl_lock() in bcm_release() before the socket is removed
> from bcm_notifier_list. That way bcm_release() and bcm_notify() can't both
> skip removing the CAN filters while the bound device changes namespace.
> RTNL is dropped before synchronize_rcu(), and the busy-wait loop on
> bcm_busy_notifier is replaced with a WARN_ON_ONCE().
> 
> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 3d637a1e0ac1a..4765c14947fc3 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -1926,12 +1926,14 @@ static int bcm_release(struct socket *sock)
>>   
>>   	/* remove bcm_ops, timer, rx_unregister(), etc. */
>>   
>> +	rtnl_lock();
>> +
> 
> [Severity: High]
> Once rtnl_lock() is taken here, RTNL stays held across lock_sock(), the
> procfs removal and the tx_ops teardown. It is only released by
> rtnl_unlock() after the rx_ops unregistration loop:
> 
> net/can/bcm.c:bcm_release() {
>      ...
> 	lock_sock(sk);
> 
> #if IS_ENABLED(CONFIG_PROC_FS)
> 	/* remove procfs entry */
> 	if (net->can.bcmproc_dir && bo->bcm_proc_read)
> 		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
> #endif /* CONFIG_PROC_FS */
> 
> 	list_for_each_entry_safe(op, next, &bo->tx_ops, list) {
> 		list_del_rcu(&op->list);
> 		bcm_remove_op(op);
> 	}
>      ...
> }
> 
> Can remove_proc_entry() block forever here while RTNL is held?
> 
> remove_proc_entry() calls proc_entry_rundown(), which waits for every
> in-flight user of the entry:
> 
> fs/proc/inode.c:proc_entry_rundown() {
>      ...
> 	if (atomic_add_return(BIAS, &de->in_use) != BIAS)
> 		wait_for_completion(&c);
>      ...
> }
> 
> bcm_connect() creates the per-socket entry with proc_create_net_single()
> and mode 0644, so any local user can open it. The entry is not permanent,
> so proc_reg_read() holds use_pde() across seq_read(), and that includes
> the copy to the user buffer:
> 
> fs/proc/inode.c:proc_reg_read() {
>      ...
> 	} else if (use_pde(pde)) {
> 		rv = pde_read(pde, file, buf, count, ppos);
> 		unuse_pde(pde);
> 	}
>      ...
> }
> 
> A user can stall that copy, for example by reading into a FUSE-backed
> mmap buffer. The sequence would then be:
> 
> socket(PF_CAN, SOCK_DGRAM, CAN_BCM)
> connect()     /* ifindex 0 is accepted, proc entry is created */
> read() of /proc/net/can-bcm/<ino> into the stalled buffer
> close()
>    bcm_release()
>      rtnl_lock()
>      remove_proc_entry()
>        proc_entry_rundown()
>          wait_for_completion()   /* RTNL still held */
> 
> Would every other rtnl_lock() user on the system then hang behind this
> close()? That includes ip link, netns creation and teardown, and device
> registration.
> 
> Before this patch, the same wait ran under lock_sock() only and affected
> just this socket. bcm_notify() already calls remove_proc_entry() under
> RTNL, but only on NETDEV_UNREGISTER of the bound device. This path can be
> reached from a plain close().
> 
> Even with no stalled reader, the tx_ops loop runs bcm_remove_op() under
> RTNL, with two hrtimer_cancel() calls per op. The RTNL hold time therefore
> grows with the number of tx ops.
> 
> RTNL only seems to be needed for the bcm_notifier_list removal and the
> rx_ops can_rx_unregister()/bcm_rx_unreg() loop. Could the procfs removal
> and the tx_ops teardown be moved out of the RTNL section, either before
> rtnl_lock() or after rtnl_unlock()?
> 
>> +	/* The netdev notifier chain runs under RTNL, so bcm_notifier() can't
>> +	 * be walking bcm_notifier_list and point to this socket. The spinlock
>> +	 * is still needed as bcm_init() adds sockets without holding RTNL.
>> +	 */
> 
> [ ... ]
> 

