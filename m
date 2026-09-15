Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87994472F9B
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468925; cv=none; b=ORs6ojMzn0esVerashCkWlLr2a6lzqycccjUrxC7juaBvu2CDv0XdTFBMkDk5B4AlSj5T6QA1rjeCNeUbWZzWIPQrRJFma2onj7vkdsowcL+Q7BlPPehVZHdb7WfvDQrOuGcR217Cepdx+ykGFVnY5oxu1FJxU80MLTjLWgVdLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468925; c=relaxed/simple;
	bh=PjiVsf5uMkbDp66AlJHnffbUEZZ1EH/IIrYenWWjkEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnKcCGBWM4gqMFK2bJRwzeE54t5mVgtS8oiXp9xaNccg4Qv860Ddg7ryvM0YcDdGYtGswgrwqIbj9eil0nL00SU00QHNC6pRRqhHnw2nibi+g+TvqTFx1t5ySIZGMpx2H0CwqJbLzNgEby1JYC33btc7RTcKcj+3OSVqcBTu5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IiYok/zJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiYok/zJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789468922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQizjq4Fv6xotoUqHmRQLNrfXJfgBpEXbkCd1IuA4Bk=;
	b=IiYok/zJafNmYmKNOHxq4MMZ5E643/NWz9j6OdFwtqnMohZG0yma74iesjULrq8lndl+JL
	XNwMCE7qKDwkih0yb0AXTLK4C6bl25DOJpOpxlccleDhEYX/FyK8QpoNk2+/csDobFSo5C
	S5ZeD+IO0L1m8jwNBpe42PPsVPG+PRY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-qM3KhJf6MTulpLWTFi-Gsw-1; Tue,
 15 Sep 2026 06:41:59 -0400
X-MC-Unique: qM3KhJf6MTulpLWTFi-Gsw-1
X-Mimecast-MFC-AGG-ID: qM3KhJf6MTulpLWTFi-Gsw_1789468917
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A62D5192DD6E;
	Tue, 15 Sep 2026 10:41:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E61BA1800446;
	Tue, 15 Sep 2026 10:41:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mhun512@gmail.com
Cc: qiang.zhao@nxp.com,
	khc@pm.waw.pl,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	adiupina@astralinux.ru,
	chleroy@kernel.org,
	ae878000@gmail.com,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 3/4] net: wan: hdlc: close active devices before protocol detach
Date: Tue, 15 Sep 2026 12:41:44 +0200
Message-ID: <20260915104144.122643-1-pabeni@redhat.com>
In-Reply-To: <f5f0519e82a7b8bbf314dc137470f7cf931e320b.1788128904.git.mhun512@gmail.com>
References: <f5f0519e82a7b8bbf314dc137470f7cf931e320b.1788128904.git.mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: wan: hdlc: close active devices before protocol detach

This adds a dev_close() call to unregister_hdlc_device() so that an up
HDLC device runs its ndo_stop and protocol close callbacks before
detach_hdlc_protocol() clears IFF_UP via hdlc_setup_dev(). The
detach-before-unregister order introduced by ff3516442768 is kept.

Link: https://lore.kernel.org/r/20260806020541.2011936-2-kuba@kernel.org

> diff --git a/drivers/net/wan/hdlc.c b/drivers/net/wan/hdlc.c
> index cbed10b1d862e..a38f90d3006ed 100644
> --- a/drivers/net/wan/hdlc.c
> +++ b/drivers/net/wan/hdlc.c
> @@ -263,6 +263,7 @@ EXPORT_SYMBOL(alloc_hdlcdev);
>  void unregister_hdlc_device(struct net_device *dev)
>  {
>  	rtnl_lock();
> +	dev_close(dev);

[Severity: High]
This isn't a bug introduced by this patch, but the new dev_close() makes
the remove path call into ixp4xx_hss's ndo_stop, and hss_hdlc_close()
sleeps inside a spin_lock_irqsave() section:

drivers/net/wan/ixp4xx_hss.c:hss_hdlc_close() {
	spin_lock_irqsave(&npe_lock, flags);
	ports_open--;
	qmgr_disable_irq(port->rxq);
	netif_stop_queue(dev);
	napi_disable(&port->napi);
	...
	free_irq(...);
	spin_unlock_irqrestore(&npe_lock, flags);
}

napi_disable() reaches napi_disable_locked(), which begins with
might_sleep() and loops on usleep_range(20, 200); free_irq() also calls
might_sleep() and takes desc->request_mutex.

Can that produce a "sleeping function called from invalid context" splat
here, and if the scheduler is actually entered, can the CPU leave npe_lock
held while hss_hdlc_dcd_irq() -> hss_hdlc_set_carrier() spins on the same
lock?

The same path is already reachable via "ip link set hss0 down", but the
commit message lists ixp4xx_hss among the audited-safe users:

    Audit all current users: c101, n2, pc300too, pci200syn, wanxl,
    ixp4xx_hss, fsl_qmc_hdlc and farsync unregister before releasing the
    resources used by their close callbacks.

Should the audit note this, given the remove path now runs
hss_hdlc_close() where it previously did not?

>  	detach_hdlc_protocol(dev);

[Severity: High]
Does dev_close() close the window this relies on for the RX path?

detach_hdlc_protocol() sets hdlc->proto = NULL and kfree()s hdlc->state
while the netdev is still registered, so hdlc_rcv() can still be reached
from NET_RX softirq for frames already queued on a per-CPU
input_pkt_queue:

drivers/net/wan/hdlc.c:hdlc_rcv() {
	...
	BUG_ON(!hdlc->proto->netif_rx);
	return hdlc->proto->netif_rx(skb);
}

The only barrier that drops backlogged skbs for the device runs later,
inside unregister_netdevice():

net/core/dev.c:unregister_netdevice_many_notify() {
	...
	flush_all_backlogs();

	synchronize_net();
	...
}

__dev_close_many() does not touch the RX backlog, so a frame handed to
netif_rx() before ndo_stop and still sitting in another CPU's queue can
reach hdlc_rcv() after hdlc->proto became NULL. The
"if (!(dev->priv_flags & IFF_WAN_HDLC))" test in hdlc_rcv() does not
filter it out, since hdlc_setup_dev() re-sets priv_flags to
IFF_WAN_HDLC.

Can that hit the BUG_ON above, or use the freed hdlc->state inside
fr_rx()/cisco_rx()/ppp_rx() if proto was already read?

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but the
return value of detach_hdlc_protocol() is dropped while
unregister_netdevice() runs unconditionally.

detach_hdlc_protocol() returns early when a NETDEV_PRE_TYPE_CHANGE
notifier refuses the type change, skipping both release points:

drivers/net/wan/hdlc.c:detach_hdlc_protocol() {
	...
		if (err) {
			netdev_err(dev, "Refused to change device type\n");
			return err;
		}
	...
		module_put(hdlc->proto->module);
	...
	kfree(hdlc->state);
	...
}

The refusal is reachable: hdlc_raw_eth's raw_eth_ioctl() calls
ether_setup(), so dev->type becomes ARPHRD_ETHER and a VLAN can be
stacked on it, after which

net/8021q/vlan.c:vlan_device_event() {
	case NETDEV_PRE_TYPE_CHANGE:
		/* Forbid underlaying device to change its type. */
		if (vlan_uses_dev(dev))
			return NOTIFY_BAD;
}

returns NOTIFY_BAD. lapbether_device_event() refuses the same way.

Does this leak the kmalloc'ed hdlc->state and the hdlc_raw_eth module
reference, given every caller then calls free_netdev() and loses the only
pointer to that state?

>  	unregister_netdevice(dev);
>  	rtnl_unlock();
-- 
This is an AI-generated review.

