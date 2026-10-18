Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC3413786;
	Sun, 18 Oct 2026 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792348686; cv=pass; b=HLaD8PNV+1x4mGJMU6h6HYqgcxY6tD1gnufiIgGqt8c0N5URWrcSeVG0ueLR8L02dECxpWP+OM08zxsQSsNgATUUk2XR1MZvpYGAUNTRPAjAaFVV2LzeIQoHrBagnmz8Jz1hZrhwakxMJujKzMKoWEFhEdtphsE+z2gHxsjrFAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792348686; c=relaxed/simple;
	bh=FGIVEt/9qthgGJHC6e+UlQXfofGpRRSjNyYMhdZpaZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPLbMSBwYbkag1TnYHHF3BM4iXK2CkpAknjqGB4Tsup0oB5uW13Jb71bJxyqTh6sAFyh3IlenPmL/Y+j3zh17YA7gYXA/WIZoZUGlLGSGg6vtfGbQsInIod1KSVEjV496urWeS4h5wjRou4inStYl77b62k9wanP4X+5qlz78Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=b2EFU9kD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sB+z3IEG; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="b2EFU9kD";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sB+z3IEG"
ARC-Seal: i=1; a=rsa-sha256; t=1792348668; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YfsUkwxNHA+VWb5UXaaSDydT9hD4cHLjH30Dl4ekfhVYFvMnIwm1elAnUZIswpHARl
    JhSmaECA2qMPd7EodFvBo+eL0Gl7fdctk5iuBs1TKmhMsf6fHPTy8hKghw0PgLDgvnsF
    o26vF+cYomK/CBFJSoyRjAh5VZnI9bc08QIjurRS+AZI5q53buvzQ+9PuF25Gq+NTOL+
    1LcrDTUgtOVU6tsBxJWDvf3N9kiA5UgTLXCxO4yp4itIeycUK5doZZBb23csPriOyTdM
    ua9+Vnn+mAT/Q4pikyT+Jdh+Pd8PY6jy5KzeRuSJgrwXYNkU3AGJJYmc9MH6O4e/MvgX
    WaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792348668;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5xIq3oj8bC0jMcqyuVy3xjDqqQHdsrX9uoFsUgJ3a4Q=;
    b=mi+XU4YtYnKnC1HcgMaVmruZmOC6T7BB84WeI14NmG3bNE6fLftfh/FPr4Eb5V6HpT
    75trH7UiW1vND49iA25OFbNuajg5fEaJdibCxhevG/p4ag9dREu/HB9op3WsFYPaMsJv
    3Y/GLUkz/MUjIweomt2MJK54x4zwlbwM5w4V1hvB9TcjT3Ppw5oj0l6RBAcvYhwk0X6B
    RLV7qRgoimIF8HYt7bJPYTjBe2WAhFJkPhNFuEh1iabKzYdhzF4kwvkjEknRJKY/goRA
    /embgxCToMfTO8Nolxu85+2xhhy3KPnxeSktQisBwIKd0yf8RmMhWs20RG5/NNa/H+e0
    zBMQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792348668;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5xIq3oj8bC0jMcqyuVy3xjDqqQHdsrX9uoFsUgJ3a4Q=;
    b=b2EFU9kDHZn//2fRL/+W8DBzV8C1ijl7oBjgl6DFHrquoIz+ylEsC+ckBiBtpBV50k
    R4Cb99K0QGnAg3KoZU4oPju8MXbGpvS3QRGsNtMpPALic+x8oAliSegV9G0Xu+BEgZao
    XTZoTyDKkrcBSCdy4x/rQ6f7xXaymE8NNEhyYul93Db99V/X8ezVCFSxi7xy6G0Aqqv/
    vjwkxtUC+naXAaX6pjAX/O/AUE/O3ekIm5rceMQE2f8wMNhmW5f+0bkwst6YyuFrVkol
    r1O5X8Wl1bZl7WQV8Sj9ql7DKRpTlEUfFN9+OC1g3Onr48kokLgnSGf0LRPFunhiEthn
    8Kfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792348668;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5xIq3oj8bC0jMcqyuVy3xjDqqQHdsrX9uoFsUgJ3a4Q=;
    b=sB+z3IEGxe3cvpj5AYCH1Fh7jlZx7y+XjxtrkScMGlVTQOb1WCTClewSc177gw+wOB
    jlDxhGxMfmTkZynMS+Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29IIbmTEg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 18 Oct 2026 20:37:48 +0200 (CEST)
Message-ID: <088cfba9-f0c7-4f51-a9a5-4e1b28b8e90b@hartkopp.net>
Date: Sun, 18 Oct 2026 20:37:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/12] can: bcm: fix filter removal race between
 release and netns change
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Norbert Szetei <norbert@doyensec.com>,
 stable@vger.kernel.org
References: <20261018164417.1540449-1-mkl@pengutronix.de>
 <20261018164417.1540449-7-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261018164417.1540449-7-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marc,

sashiko-bot complained about problems with the rtnl_lock() usage in this 
bcm patch here:

https://lore.kernel.org/linux-can/99fed91f-dbc5-4029-8a34-7e0113acfe13@hartkopp.net/

This problem applies to all of these fixes:

[PATCH net-next 04/12] can: isotp: fix filter removal race between 
release and netns change
https://lore.kernel.org/linux-can/20261018164417.1540449-5-mkl@pengutronix.de/

[PATCH net-next 06/12] can: bcm: fix filter removal race between release 
and netns change
https://lore.kernel.org/linux-can/20261018164417.1540449-7-mkl@pengutronix.de/

[PATCH net-next 08/12] can: raw: take rtnl_lock() before leaving the 
notifier list
https://lore.kernel.org/linux-can/20261018164417.1540449-9-mkl@pengutronix.de/

They all correctly fix the race when moving CAN devices to other 
namespaces when releasing sockets - BUT with the cost of rtnl locks that 
can be triggered by unprivileged users.

"Taking RTNL in these release paths is no option: raw_bind(),
raw_setsockopt() and raw_release() already hold RTNL while adding and
removing up to CAN_RAW_FILTER_MAX filters per socket, which unprivileged
users can trigger repeatedly and which makes RTNL a global bottleneck."

This patch

[RFC PATCH can-next v2] can: protect the receive lists with a per-device 
lock
https://lore.kernel.org/linux-can/20261018180739.689750-1-socketcan@hartkopp.net/

replaces those three patches and removes the formerly required increased 
usage of rtnl_lock() by adding a new can_dev_rcv_lists::lock that is 
placed in ml_priv and is device specific (independently from namespaces).

I've worked on this patch the entire weekend and tested it extensively.

I would suggest to replace the three patches with that single one for an 
updated PR and let sashiko-bot take a final look at it.

Best regards,
Oliver

ps. I did your requested instrumentation and found a missing glitch 
which is the reason for the v2 patch. The v1 will get its sashiko review 
today at ~10pm due to the 24h embargo :-/

On 18.10.26 18:41, Marc Kleine-Budde wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> bcm_release() removes the socket from bcm_notifier_list before it takes
> any lock that serializes against the netdev notifier chain, which runs
> under RTNL. A socket that leaves the list in this window is skipped by
> bcm_notify() and has to remove its CAN filters itself.
> 
> This fails when the bound device is moved to another network namespace
> in this window: bcm_rx_unreg() reads dev_net(dev) without holding RTNL,
> and can_rx_unregister() silently returns when this namespace does not
> match dev_net(dev) anymore. The op is freed anyway and the remaining
> receiver leads to a use-after-free in bcm_rx_handler().
> 
> Take rtnl_lock() before removing the socket from the notifier list, so
> that bcm_release() and bcm_notify() can not both skip the removal and
> dev_net(dev) is stable while the device specific filters are removed.
> As the notifier chain is always invoked under RTNL, bcm_busy_notifier
> can not point to the released socket anymore. Replace the now dead
> busy-wait loop with a WARN_ON_ONCE().
> 
> RTNL is only held for the notifier list removal and the removal of the
> device specific filters. Once the socket has left the notifier list,
> bcm_notify() can not access it anymore. So the procfs entry, the tx_ops
> and the filters for 'any' CAN device, which live in the socket's
> namespace, are removed after RTNL has been released. This way a stalled
> reader of the world-readable procfs entry can not hold up RTNL, and the
> removal of the 'any' CAN device filters does not delay RTNL anymore.
> 
> Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
> Cc: Norbert Szetei <norbert@doyensec.com>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Link: https://patch.msgid.link/20261016091128.325332-3-socketcan@hartkopp.net
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   net/can/bcm.c | 47 +++++++++++++++++++++--------------------------
>   1 file changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 6759662e024c..fbc79da4e4fc 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1926,17 +1926,30 @@ static int bcm_release(struct socket *sock)
>   
>   	/* remove bcm_ops, timer, rx_unregister(), etc. */
>   
> +	rtnl_lock();
> +
> +	/* The netdev notifier chain runs under RTNL, so bcm_notifier() can't
> +	 * be walking bcm_notifier_list and point to this socket. The spinlock
> +	 * is still needed as bcm_init() adds sockets without holding RTNL.
> +	 */
>   	spin_lock(&bcm_notifier_lock);
> -	while (bcm_busy_notifier == bo) {
> -		spin_unlock(&bcm_notifier_lock);
> -		schedule_timeout_uninterruptible(1);
> -		spin_lock(&bcm_notifier_lock);
> -	}
> +	WARN_ON_ONCE(bcm_busy_notifier == bo);
>   	list_del(&bo->notifier);
>   	spin_unlock(&bcm_notifier_lock);
>   
>   	lock_sock(sk);
>   
> +	/* Remove the device specific subscriptions under RTNL */
> +	list_for_each_entry(op, &bo->rx_ops, list)
> +		if (op->ifindex && op->rx_reg_dev)
> +			bcm_rx_unreg(op->rx_reg_dev, op);
> +
> +	rtnl_unlock();
> +
> +	/* bcm_notify() can not access this socket anymore. Release the other
> +	 * resources without holding RTNL, e.g. remove_proc_entry() waits for
> +	 * concurrent readers of the procfs entry.
> +	 */
>   #if IS_ENABLED(CONFIG_PROC_FS)
>   	/* remove procfs entry */
>   	if (net->can.bcmproc_dir && bo->bcm_proc_read)
> @@ -1948,31 +1961,13 @@ static int bcm_release(struct socket *sock)
>   		bcm_remove_op(op);
>   	}
>   
> -	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
> -		/*
> -		 * Don't care if we're bound or not (due to netdev problems)
> -		 * can_rx_unregister() is always a save thing to do here.
> -		 */
> -		if (op->ifindex) {
> -			/*
> -			 * Only remove subscriptions that had not
> -			 * been removed due to NETDEV_UNREGISTER
> -			 * in bcm_notifier()
> -			 *
> -			 * op->rx_reg_dev is a tracked reference taken
> -			 * when the subscription was registered, so it
> -			 * stays valid here even if a concurrent
> -			 * NETDEV_UNREGISTER already unlisted the device.
> -			 */
> -			if (op->rx_reg_dev)
> -				bcm_rx_unreg(op->rx_reg_dev, op);
> -		} else
> +	/* 'any' CAN device subscriptions live in the socket's namespace */
> +	list_for_each_entry(op, &bo->rx_ops, list)
> +		if (!op->ifindex)
>   			can_rx_unregister(net, NULL, op->can_id,
>   					  REGMASK(op->can_id),
>   					  bcm_rx_handler, op);
>   
> -	}
> -
>   	synchronize_rcu();
>   
>   	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {

