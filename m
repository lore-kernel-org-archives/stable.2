Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C528840B39F
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713739; cv=pass; b=AeattRkG+jcTKXb1nNaSEyYCRKEK4LZlenpKoz5iHWKAQ4pg/8pq6yOeJpJvbpMAOTLfP1nC2DuoDlHRPa4+NClR7g0RR3g5/9spXJelioNglCLADkoAaG2e723PBHBs53gmI4+7nh70ZkxX1RtZLWF4Xd1zEzThRrUk7loKjqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713739; c=relaxed/simple;
	bh=KaZTyWh0ieerAlM3y6kVk1YPwIrpsV51gk6tzb642WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAjYIcAlgJo28zB1A584deGCtW6rv89uMjUgak6cyhR8yIxOX+aU1O5SmqWlBRii37otQwoG2mZVPisjDEimLwAamOZJEQyNI6xNtL+1Pbjz48GosCCwJ+tyQlRTqRfMzPGUOCYzvFzxj+7/Ls8VeaX5Q5kD8MRAXRa4N8C+tjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=R5bBumpQ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ERx2oU3u; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="R5bBumpQ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ERx2oU3u"
ARC-Seal: i=1; a=rsa-sha256; t=1784713727; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cRVgqDsi68DG9tfuq4Jp5CRHGqvjxvzRhv6YIr82dIo0Fv29SOXtlFo4aidPguWzFw
    +z+WVSYWpwKmp9fF07l2pWeLuKlFDHlaA2NASVYF9JgvlrwY3LQA43eddstiXYRXv/G1
    jKKwwjJhepoDrgrhcn7bxtLbuqNgAKB6X3+mVsFDIT1eUYlaknKND3hBUteDLI+vWsQ/
    m/cnK7KaOZZqawRU2kRiN+Ld71pKZvzaPAb68dI4I0c2AS669nh3PdrsuisO6DTbYQSI
    uXSAPDq6++IYm/Tb4BPOkFfeOZQ572jnEYezbSi49OwjfJOATYgB2CfGyOj3xrc/wFyG
    ggKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784713727;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=519kgEKGQS2TZ4zCIayEzPoP2owHchlG/PN+SE0gaWs=;
    b=N7uVYiCIGCAh9tDm3qdRW0WPMVQ1MggcaZJy+davRo1/NQea0wPrCGIIGUZJFWWurk
    XMtI2oTuAaDucLyRt58g2FGdicwGzsr8RZxecCFPfKs5aY81W+3SHSAGTKZV4YYSNWdE
    iHO9mVKdFcW5wXEdIgK4uWaEZgE5PLXtx49Yfi1lX1mR87UYErXavoMX5Ty584yBYc3r
    ak5RJdahXRQBzStSGRMYSFHrU1QqN4OWvIl4BpsMpyns9w6KR4S1iH06dv4P8iBuFWF7
    JtdzC7cwNoRRkVxG7vuSfTiXFTj1E70Dj+1MF6/1lgZE8SgNyoZ1DiFLezU78xwdL7xa
    sr4w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784713726;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=519kgEKGQS2TZ4zCIayEzPoP2owHchlG/PN+SE0gaWs=;
    b=R5bBumpQzmgZU5Xlp/MdQHBwUXKabuZTvg+SHWT/TxyOK2WIw9HsQTN0Abj4L7QHbH
    XI9LhADycEUyDKCau1rt8xIiJ0JJQeZTD0eNatu5J58lOOZBXBrrJ3vaRtOQLBKMNnzO
    n0XaC50fNFWaO4xA2Ecy4m6jxLy65H6QUB/LRtmvHJ7ahC6EEa+enQMb2XXy711g9e52
    Q79h22aIc2BSKab67bSJ3PPzh1DnGQSJddmOGGuC2bFpi0ncLg5mKhyoVYhs48jDw5uT
    j1oTMpyYvWiwAuRuMz76rscKVPiRkW/xGDCr2AfU8DDEefa4ibs+UmpWEzdC06tyzp3o
    txFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784713726;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=519kgEKGQS2TZ4zCIayEzPoP2owHchlG/PN+SE0gaWs=;
    b=ERx2oU3uc/LK75dvdFboGOpE+b0b+dBGoPWKZt0242OApnMgx2B+skNXyE+g0v1d/b
    XvFVoZNxuyNdt9azUaBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.219]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K5281926M9mk7tt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 22 Jul 2026 11:48:46 +0200 (CEST)
Message-ID: <99ae6366-3d14-4a5a-bec2-d5c43930a165@hartkopp.net>
Date: Wed, 22 Jul 2026 11:48:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] can: bcm: add missing device refcount for
 CAN filter removal" failed to apply to 5.10-stable tree
To: gregkh@linuxfoundation.org, mkl@pengutronix.de
Cc: stable@vger.kernel.org
References: <2026072041-silica-outing-8bb2@gregkh>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <2026072041-silica-outing-8bb2@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Greg,

sorry for the bunch of patches the AI reports and review results created 
for the stable trees.

Based on the patches, the stable trees and your status mails I asked 
Claude to create a status table (markdown):

| # | commit | file | message | 5.10 | 5.15 | 6.1 | 6.6 | 6.12 | 6.18 | 
7.1 |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | `9b1a02e0d980` | isotp.c | use unconditional synchronize_rcu() in 
isotp_release() | OK | OK | OK | OK | OK | OK | OK |
| 2 | `20bab8b88baa` | isotp.c | fix use-after-free race with concurrent 
NETDEV_UNREGISTER | FAIL | FAIL | FAIL | FAIL | FAIL | OK | OK |
| 3 | `cf070fe33bfb` | isotp.c | serialize TX state transitions under 
so->rx_lock | FAIL | FAIL | FAIL | FAIL | FAIL | OK | OK |
| 4 | `68973f9db761` | bcm.c | defer rx_op deallocation to workqueue to 
fix thrtimer UAF | FAIL | FAIL | OK | OK | OK | OK | OK |
| 5 | `d9b091d9d22f` | bcm.c | fix lockless bound/ifindex race and 
silent RX_SETUP failure | OK | OK | OK | OK | OK | OK | OK |
| 6 | `749179c2e25b` | bcm.c | add locking when updating filter and 
timer values | FAIL | FAIL | FAIL | FAIL | FAIL | FAIL | OK |
| 7 | `e6c24ba95fc3` | bcm.c | fix CAN frame rx/tx statistics | FAIL | 
FAIL | FAIL | FAIL | FAIL | FAIL | OK |
| 8 | `7b2c3eabc4da` | bcm.c | add missing rcu list annotations and 
operations | OK | OK | OK | OK | OK | OK | OK |
| 9 | `12ce799f7ab1` | bcm.c | extend bcm_tx_lock usage for data and 
timer updates | FAIL | FAIL | FAIL | FAIL | FAIL | FAIL | OK |
| 10 | `62ec41f36464` | bcm.c | validate frame length in bcm_rx_setup() 
for RTR replies | FAIL | FAIL | FAIL | FAIL | FAIL | FAIL | OK |
| 11 | `d59948293ea3` | bcm.c | add missing device refcount for CAN 
filter removal | FAIL | FAIL | FAIL | FAIL | FAIL | FAIL | OK |
| 12 | `3b762c0d9503` | bcm.c | fix stale rx/tx ops after device removal 
| FAIL | FAIL | FAIL | FAIL | FAIL | FAIL | OK |
| 13 | `58fd6cbc8541` | bcm.c | fix data race on rx_stamp/rx_ifindex in 
bcm_rx_handler() | FAIL | FAIL | FAIL | FAIL | FAIL | FAIL | OK |
| 14 | `2f5976f54a04` | bcm.c | track a single source interface for 
ANYDEV timeout/throttle ops | FAIL | FAIL | FAIL | FAIL | FAIL | FAIL | OK |

This will take some time but I'll send a patch for each failed apply.

Best regards,
Oliver

On 20.07.26 17:14, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x d59948293ea34b6337ce2b5febab8510de70048c
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072041-silica-outing-8bb2@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
>  From d59948293ea34b6337ce2b5febab8510de70048c Mon Sep 17 00:00:00 2001
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> Date: Tue, 14 Jul 2026 18:55:30 +0200
> Subject: [PATCH] can: bcm: add missing device refcount for CAN filter removal
> 
> sashiko-bot remarked a problem with a concurrent device unregistration
> in isotp.c which also is present in the bcm.c code. A former fix for raw.c
> commit c275a176e4b6 ("can: raw: add missing refcount for memory leak fix")
> introduced a netdevice_tracker which solves the issue for bcm.c too.
> 
> bcm_release(), bcm_delete_rx_op() and bcm_notifier() relied on
> dev_get_by_index(ifindex) to re-find the device for an rx_op before
> unregistering its filter. If a concurrent NETDEV_UNREGISTER has already
> unlisted the device from the ifindex table, that lookup fails and
> can_rx_unregister() is silently skipped, leaving a stale CAN filter
> pointing at the soon-to-be-freed bcm_op/socket.
> 
> Hold a netdev_hold()/netdev_put() tracked reference on op->rx_reg_dev
> from the moment the rx filter is registered in bcm_rx_setup() until it
> is unregistered in bcm_rx_unreg(), and use that reference directly in
> bcm_release() and bcm_delete_rx_op() instead of re-looking the device
> up by ifindex.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260707094716.63578-1-socketcan@hartkopp.net
> Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Link: https://patch.msgid.link/20260714-bcm_fixes-v15-8-562f7e3e42da@hartkopp.net
> Cc: stable@kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 2d9c9cd74536..25842061800b 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -128,6 +128,7 @@ struct bcm_op {
>   	struct canfd_frame last_sframe;
>   	struct sock *sk;
>   	struct net_device *rx_reg_dev;
> +	netdevice_tracker rx_reg_dev_tracker;
>   	spinlock_t bcm_tx_lock; /* protect tx data and timer updates */
>   	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
>   };
> @@ -937,6 +938,7 @@ static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
>   
>   		/* mark as removed subscription */
>   		op->rx_reg_dev = NULL;
> +		netdev_put(dev, &op->rx_reg_dev_tracker);
>   	} else
>   		printk(KERN_ERR "can-bcm: bcm_rx_unreg: registered device "
>   		       "mismatch %p %p\n", op->rx_reg_dev, dev);
> @@ -967,17 +969,14 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
>   				 * Only remove subscriptions that had not
>   				 * been removed due to NETDEV_UNREGISTER
>   				 * in bcm_notifier()
> +				 *
> +				 * op->rx_reg_dev is a tracked reference taken
> +				 * when the subscription was registered, so it
> +				 * stays valid here even if a concurrent
> +				 * NETDEV_UNREGISTER already unlisted the dev.
>   				 */
> -				if (op->rx_reg_dev) {
> -					struct net_device *dev;
> -
> -					dev = dev_get_by_index(sock_net(op->sk),
> -							       op->ifindex);
> -					if (dev) {
> -						bcm_rx_unreg(dev, op);
> -						dev_put(dev);
> -					}
> -				}
> +				if (op->rx_reg_dev)
> +					bcm_rx_unreg(op->rx_reg_dev, op);
>   			} else
>   				can_rx_unregister(sock_net(op->sk), NULL,
>   						  op->can_id,
> @@ -1496,7 +1495,17 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   						      bcm_rx_handler, op,
>   						      "bcm", sk);
>   
> -				op->rx_reg_dev = dev;
> +				/* keep a tracked reference so that a later
> +				 * unregister can safely reach the device even
> +				 * if a concurrent NETDEV_UNREGISTER has
> +				 * already unlisted it by ifindex
> +				 */
> +				if (!err) {
> +					op->rx_reg_dev = dev;
> +					netdev_hold(dev,
> +						    &op->rx_reg_dev_tracker,
> +						    GFP_KERNEL);
> +				}
>   				dev_put(dev);
>   			} else {
>   				/* the requested device is gone - do not
> @@ -1873,16 +1882,14 @@ static int bcm_release(struct socket *sock)
>   			 * Only remove subscriptions that had not
>   			 * been removed due to NETDEV_UNREGISTER
>   			 * in bcm_notifier()
> +			 *
> +			 * op->rx_reg_dev is a tracked reference taken
> +			 * when the subscription was registered, so it
> +			 * stays valid here even if a concurrent
> +			 * NETDEV_UNREGISTER already unlisted the device.
>   			 */
> -			if (op->rx_reg_dev) {
> -				struct net_device *dev;
> -
> -				dev = dev_get_by_index(net, op->ifindex);
> -				if (dev) {
> -					bcm_rx_unreg(dev, op);
> -					dev_put(dev);
> -				}
> -			}
> +			if (op->rx_reg_dev)
> +				bcm_rx_unreg(op->rx_reg_dev, op);
>   		} else
>   			can_rx_unregister(net, NULL, op->can_id,
>   					  REGMASK(op->can_id),
> 

