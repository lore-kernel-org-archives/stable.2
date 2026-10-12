Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F462429CE8
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807191; cv=pass; b=BXBoGS696ovPOb/CAlnmpnAUbV/ZSJ1hyN1V34OLNhhk9JjKSXvUNPaGePUAsh01UCcGO+BVHXrxbAlDo2t5xmS8xj/APKNhacPtZw3UBws/5dn+3fSfs9Ir2xgSQmkj42e3sfwGsJmHzTR8zPVAMzoY8vPcolhB3EJq+di/kgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807191; c=relaxed/simple;
	bh=8Opd7Cq32kNN1tAXUcE5jnkOnV5c9r0rjNQueMhZQLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRXqUYkR0mM3sD8nlWaO+U1xtqDQsE3m9A1LaSb5IZHfD+n/+IRzkg8SdNAtbiMVE8O8Gy1SFlodWJMq6i+W2QTwBWoCFoQBk/jw5lHbk6dM7Gi71mf2fJ20uJzftwXsAZih2HF9/c3ShFfslGa0t62wV671CFnc3XdUAkookI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=s0CWtPK4; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=5k0dwQcI; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="s0CWtPK4";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="5k0dwQcI"
ARC-Seal: i=1; a=rsa-sha256; t=1791807005; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SsblR9RuWZs/Ku2RPD60RsMB5QDMjPHjxNfNG3S6Vf4E/LMJsvkzmcLZE85Yn6BBwB
    q2gaaBhsQdY/gmpidxVuXNzFfA+FVuIvG2eMUKqObT+yt4KfVAXW/P547dATbdiGvvId
    DxfSHmiNTI8ZDCc2XQCZvh4MWyH/sD4GrWicTW+kte0yuBgo0TNa88tB3SUOmDOibMmn
    6JdGd5MjUW1r6Nz0HwXECBum/g9bN3h23ngtHhJhZlo9tIlmCjpb3xbytV+QT+wQ2xCH
    9WnLNEUPgEsusTOGPR2tAV8X83mxTiu+XTwVDCGlelD284OapGy2OITEutoksY5JMJz9
    EBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791807005;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AcjSWFjqZl+AiFb2XBTYDP0jKD5Ac5wAbhmo3K6t1Dk=;
    b=jCH7B6LMayHRhWbXgPcetlZUC96y/H0tpqpVj94ikvPSBfgqgNBtbyd861VRx5keK1
    8EWJs7M3cjVYS9BcaumYQKd2i7eAZiPA1quMgIfZQUzLwbMvf6psB42TrgQWVxCTiXwm
    lHs8ZJ3nxwXunqSDFgtcy29ceF/UO6CAiUuzNn7f0hjoN1bPa0Hldc+X3QXC54kaSaOv
    +kC6nZYgM4INQGTpS0FbVXeR18H+UCFg3bqrHsBKuJOnQJrVSU/2HiziZfGqLfCXkf6V
    0JZE8WuRZJaF/IdSPgnYjiY/t+6wfLal2aZXFge44KFQwuNKMcP5gDM68jTqwsZ32/cE
    MwXA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791807005;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AcjSWFjqZl+AiFb2XBTYDP0jKD5Ac5wAbhmo3K6t1Dk=;
    b=s0CWtPK4jk4lc/UvHMf9cSICqXoR9hF6owrGlr0h6r/G7refeYJ0S5caPFAdMux+c6
    VHwwUOO10szX/ZGakWpfmIYn9JS9bymbA/+xpp7AGYNYAPTWQd2FOhWP46Lbbye2wKkJ
    hYJIPNxlwDeYPxFY+Zh5uzXMQ+z3CsvKt6WT93aXpySmjcEhLWOgzjMzTDQ4DJgecq+d
    qGTd7/isUyzkjpVaOoa6OEDuVSaQJQiPA0UnAau9o4BQlS/OvFDw8OyG89WN+OeOt0LL
    6W8UDdVqbaEMI4Xm9KYStD67nh7FbJhXFhfsmAnk67LGYC5DjS28hXYHveooY45T71fG
    SWtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791807005;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AcjSWFjqZl+AiFb2XBTYDP0jKD5Ac5wAbhmo3K6t1Dk=;
    b=5k0dwQcIDz4E1tB772v/IB5HtgFllIEHzq0DeZ610t1CSNx/w/X7ciCk7R8YTuLXCL
    0W4bn8Jw5kj3kYubQTDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a29CCA5f5w
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Oct 2026 14:10:05 +0200 (CEST)
Message-ID: <b0a7ec4c-0dad-4545-9661-3740b5be90bc@hartkopp.net>
Date: Mon, 12 Oct 2026 14:10:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] can: fix unique skb identifier regression
 under RPS" failed to apply to 5.10-stable tree
To: gregkh@linuxfoundation.org, joe@clnt.de, mkl@pengutronix.de
Cc: stable@vger.kernel.org
References: <2026101253-guzzler-atom-1993@gregkh>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <2026101253-guzzler-atom-1993@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12.10.26 13:33, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 7093c3b8314a4ef7405c4066a2521398c455efe7
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101253-guzzler-atom-1993@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'
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
>  From 7093c3b8314a4ef7405c4066a2521398c455efe7 Mon Sep 17 00:00:00 2001
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> Date: Thu, 1 Oct 2026 13:57:24 +0200
> Subject: [PATCH] can: fix unique skb identifier regression under RPS
> 
> Commit d4fb6514ff8e ("can: use skb hash instead of private variable in
> headroom") moved the per-skb unique identifier used for raw_rcv()
> duplicate detection into skb->hash.
> 
> With RPS enabled, get_rps_cpu() calls skb_get_hash() before the frame
> reaches the CAN subsystem. Since CAN skbs have no L3/L4 headers, the
> flow dissector assigns every CAN frame the same non-zero software
> hash. can_set_skb_uid() only generated a new identifier when
> skb->hash was 0, so it kept this constant hash. When the SLAB
> allocator later reused the same skb address, raw_rcv() mistook the
> next legitimate frame for a duplicate and dropped it.
> 
> Fix this by storing the CAN UID in the CAN skb extension
> (struct can_skb_ext::can_skb_uid) instead of skb->hash, decoupling it
> from any hash the network stack may compute. can_set_skb_uid() keeps
> its "assign only if unset" behaviour, which preserves UIDs set before
> transmission (e.g. by isotp to identify echo frames) across the local
> loopback path.
> 
> Frames whose extension is shared with another clone (e.g. via tc mirred
> or netem duplicate) are given a private extension copy before the UID
> is assigned, so that independently received skb clones from real CAN
> interfaces (can_skb_uid = 0) don't end up with the same UID.
> The limitation that tc mirred/netem skb duplicates might be dropped in
> raw_rcv for looped back isotp echo frame skbs is accepted. There is no
> valid use-case for tc mirred or netem together with isotp which is not
> capable to operate on different CAN interfaces simultaneously.
> For routing and modifying CAN frames together with isotp use can-gw.
> 
> can-gw and vxcan additionally clear the UID of forwarded/duplicated
> frames so each newly routed frame gets its own unique identifier.
> 
> Fixes: d4fb6514ff8e ("can: use skb hash instead of private variable in headroom")

This patch to be fixed has been introduced in 7.0 - no backport needed 
for this kernel.

Best regards,
Oliver

> Reported-by: Joerg Willmann <joe@clnt.de>
> Closes: https://lore.kernel.org/linux-can/2859AD3D-C805-41A0-9036-C5E8EE152419@clnt.de/
> Cc: stable@vger.kernel.org
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Tested-by: Joerg Willmann <joe@clnt.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Link: https://patch.msgid.link/20261001115724.27192-1-socketcan@hartkopp.net
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index 9e2e25d02471..51148a81d1d9 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -79,6 +79,9 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
>   
>   	/* reset CAN GW hop counter */
>   	csx->can_gw_hops = 0;
> +	/* start with new CAN skb UID in the other namespace */
> +	csx->can_skb_uid = 0;
> +
>   	skb->pkt_type   = PACKET_BROADCAST;
>   	skb->dev        = peer;
>   	skb->ip_summed  = CHECKSUM_UNNECESSARY;
> diff --git a/include/linux/can/core.h b/include/linux/can/core.h
> index 3287232e3cad..2de74c2b78b6 100644
> --- a/include/linux/can/core.h
> +++ b/include/linux/can/core.h
> @@ -17,6 +17,7 @@
>   #include <linux/can.h>
>   #include <linux/skbuff.h>
>   #include <linux/netdevice.h>
> +#include <net/can.h>
>   
>   #define DNAME(dev) ((dev) ? (dev)->name : "any")
>   
> @@ -58,7 +59,7 @@ extern void can_rx_unregister(struct net *net, struct net_device *dev,
>   			      void *data);
>   
>   extern int can_send(struct sk_buff *skb, int loop);
> -void can_set_skb_uid(struct sk_buff *skb);
> +void can_set_skb_uid(struct can_skb_ext *csx);
>   void can_sock_destruct(struct sock *sk);
>   
>   #endif /* !_CAN_CORE_H */
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index a70a02967071..5d27843862fc 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -43,8 +43,10 @@ static inline struct can_skb_ext *can_skb_ext_add(struct sk_buff *skb)
>   	struct can_skb_ext *csx = skb_ext_add(skb, SKB_EXT_CAN);
>   
>   	/* skb_ext_add() returns uninitialized space */
> -	if (csx)
> +	if (csx) {
>   		csx->can_gw_hops = 0;
> +		csx->can_skb_uid = 0;
> +	}
>   
>   	return csx;
>   }
> diff --git a/include/net/can.h b/include/net/can.h
> index 6db9e826f0e0..2b8af2598732 100644
> --- a/include/net/can.h
> +++ b/include/net/can.h
> @@ -17,12 +17,14 @@
>    * @can_framelen: cached echo CAN frame length for bql
>    * @can_gw_hops: can-gw CAN frame time-to-live counter
>    * @can_ext_flags: CAN skb extensions flags
> + * @can_skb_uid: CAN skb UID for raw_rcv and isotp echo handling
>    */
>   struct can_skb_ext {
>   	int	can_iif;
>   	u16	can_framelen;
>   	u8	can_gw_hops;
>   	u8	can_ext_flags;
> +	u32	can_skb_uid;
>   };
>   
>   #endif /* _NET_CAN_H */
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 7bc86b176b4d..34fe3b28d576 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -641,13 +641,10 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
>   	return matches;
>   }
>   
> -void can_set_skb_uid(struct sk_buff *skb)
> +void can_set_skb_uid(struct can_skb_ext *csx)
>   {
> -	/* create non-zero unique skb identifier together with *skb */
> -	while (!(skb->hash))
> -		skb->hash = atomic_inc_return(&skbcounter);
> -
> -	skb->sw_hash = 1;
> +	while (!(csx->can_skb_uid))
> +		csx->can_skb_uid = atomic_inc_return(&skbcounter);
>   }
>   EXPORT_SYMBOL(can_set_skb_uid);
>   
> @@ -662,8 +659,6 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
>   	atomic_long_inc(&pkg_stats->rx_frames);
>   	atomic_long_inc(&pkg_stats->rx_frames_delta);
>   
> -	can_set_skb_uid(skb);
> -
>   	rcu_read_lock();
>   
>   	/* deliver the packet to sockets listening on all devices */
> @@ -687,8 +682,10 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
>   static int can_rcv(struct sk_buff *skb, struct net_device *dev,
>   		   struct packet_type *pt, struct net_device *orig_dev)
>   {
> +	struct can_skb_ext *csx = can_skb_ext_find(skb);
> +
>   	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
> -		     !can_skb_ext_find(skb) || !can_is_can_skb(skb))) {
> +		     !csx || !can_is_can_skb(skb))) {
>   		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
>   			     dev->type, skb->len);
>   
> @@ -696,6 +693,14 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
>   		return NET_RX_DROP;
>   	}
>   
> +	/* create unshared CAN skb_extension for netem/mirred skb clones */
> +	csx = skb_ext_add(skb, SKB_EXT_CAN);
> +	if (unlikely(!csx)) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
> +		return NET_RX_DROP;
> +	}
> +
> +	can_set_skb_uid(csx);
>   	can_receive(skb, dev);
>   	return NET_RX_SUCCESS;
>   }
> @@ -703,8 +708,10 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
>   static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
>   		     struct packet_type *pt, struct net_device *orig_dev)
>   {
> +	struct can_skb_ext *csx = can_skb_ext_find(skb);
> +
>   	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
> -		     !can_skb_ext_find(skb) || !can_is_canfd_skb(skb))) {
> +		     !csx || !can_is_canfd_skb(skb))) {
>   		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
>   			     dev->type, skb->len);
>   
> @@ -712,6 +719,14 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
>   		return NET_RX_DROP;
>   	}
>   
> +	/* create unshared CAN skb_extension for netem/mirred skb clones */
> +	csx = skb_ext_add(skb, SKB_EXT_CAN);
> +	if (unlikely(!csx)) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
> +		return NET_RX_DROP;
> +	}
> +
> +	can_set_skb_uid(csx);
>   	can_receive(skb, dev);
>   	return NET_RX_SUCCESS;
>   }
> @@ -719,8 +734,10 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
>   static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
>   		     struct packet_type *pt, struct net_device *orig_dev)
>   {
> +	struct can_skb_ext *csx = can_skb_ext_find(skb);
> +
>   	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
> -		     !can_skb_ext_find(skb) || !can_is_canxl_skb(skb))) {
> +		     !csx || !can_is_canxl_skb(skb))) {
>   		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
>   			     dev->type, skb->len);
>   
> @@ -728,6 +745,14 @@ static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
>   		return NET_RX_DROP;
>   	}
>   
> +	/* create unshared CAN skb_extension for netem/mirred skb clones */
> +	csx = skb_ext_add(skb, SKB_EXT_CAN);
> +	if (unlikely(!csx)) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
> +		return NET_RX_DROP;
> +	}
> +
> +	can_set_skb_uid(csx);
>   	can_receive(skb, dev);
>   	return NET_RX_SUCCESS;
>   }
> diff --git a/net/can/gw.c b/net/can/gw.c
> index 0ec99f68aa45..5793cb2420ed 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -527,6 +527,9 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>   	/* put the incremented hop counter in the cloned skb */
>   	ncsx->can_gw_hops = csx->can_gw_hops + 1;
>   
> +	/* force a new CAN UID generation for the routed frame */
> +	ncsx->can_skb_uid = 0;
> +
>   	/* first processing of this CAN frame -> adjust to private hop limit */
>   	if (gwj->limit_hops && ncsx->can_gw_hops == 1)
>   		ncsx->can_gw_hops = max_hops - gwj->limit_hops + 1;
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 155530aedce2..f5dc9d04bd68 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -891,7 +891,7 @@ static void isotp_send_cframe(struct isotp_sock *so)
>   	csx->can_iif = dev->ifindex;
>   
>   	/* set uid in tx skb to identify CF echo frames */
> -	can_set_skb_uid(skb);
> +	can_set_skb_uid(csx);
>   
>   	cf = (struct canfd_frame *)skb->data;
>   	skb_put_zero(skb, so->ll.mtu);
> @@ -917,7 +917,7 @@ static void isotp_send_cframe(struct isotp_sock *so)
>   		pr_notice_once("can-isotp: cfecho is %08X != 0\n", old_cfecho);
>   
>   	/* set consecutive frame echo tag */
> -	WRITE_ONCE(so->cfecho, skb->hash);
> +	WRITE_ONCE(so->cfecho, csx->can_skb_uid);
>   
>   	/* send frame with local echo enabled */
>   	can_send_ret = can_send(skb, 1);
> @@ -969,18 +969,22 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
>   {
>   	struct sock *sk = (struct sock *)data;
>   	struct isotp_sock *so = isotp_sk(sk);
> +	struct can_skb_ext *csx = can_skb_ext_find(skb);
>   
>   	/* only handle my own local echo CF/SF skb's (no FF!) */
>   	if (skb->sk != sk)
>   		return;
>   
> +	if (WARN_ON_ONCE(!csx))
> +		return;
> +
>   	/* unlike isotp_rcv_fc()/isotp_rcv_cf(), not already under so->rx_lock
>   	 * (no isotp_rcv() caller here), so take it ourselves
>   	 */
>   	spin_lock(&so->rx_lock);
>   
>   	/* so->cfecho may since belong to a new transfer; recheck under lock */
> -	if (READ_ONCE(so->cfecho) != skb->hash)
> +	if (READ_ONCE(so->cfecho) != csx->can_skb_uid)
>   		goto out_unlock;
>   
>   	/* cancel local echo timeout */
> @@ -1222,7 +1226,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   	csx->can_iif = dev->ifindex;
>   
>   	/* set uid in tx skb to identify CF echo frames */
> -	can_set_skb_uid(skb);
> +	can_set_skb_uid(csx);
>   
>   	so->tx.len = size;
>   	so->tx.idx = 0;
> @@ -1261,7 +1265,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   			cf->data[ae] |= size;
>   
>   		/* set CF echo tag for isotp_rcv_echo() (SF-mode) */
> -		WRITE_ONCE(so->cfecho, skb->hash);
> +		WRITE_ONCE(so->cfecho, csx->can_skb_uid);
>   	} else {
>   		/* send first frame */
>   
> @@ -1278,7 +1282,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   			so->txfc.bs = 0;
>   
>   			/* set CF echo tag for isotp_rcv_echo() (CF-mode) */
> -			WRITE_ONCE(so->cfecho, skb->hash);
> +			WRITE_ONCE(so->cfecho, csx->can_skb_uid);
>   		} else {
>   			/* standard flow control check */
>   			new_state = ISOTP_WAIT_FIRST_FC;
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 82d9c0499c95..0acd4f6c6dd6 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -77,7 +77,7 @@ MODULE_ALIAS("can-proto-1");
>   
>   struct uniqframe {
>   	const struct sk_buff *skb;
> -	u32 hash;
> +	u32 can_skb_uid;
>   	unsigned int join_rx_count;
>   };
>   
> @@ -133,12 +133,16 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>   	enum skb_drop_reason reason;
>   	struct sockaddr_can *addr;
>   	struct sk_buff *skb;
> +	struct can_skb_ext *csx = can_skb_ext_find(oskb);
>   	unsigned int *pflags;
>   
>   	/* check the received tx sock reference */
>   	if (!ro->recv_own_msgs && oskb->sk == sk)
>   		return;
>   
> +	if (WARN_ON_ONCE(!csx))
> +		return;
> +
>   	/* make sure to not pass oversized frames to the socket */
>   	if (!ro->fd_frames && can_is_canfd_skb(oskb))
>   		return;
> @@ -165,7 +169,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>   
>   	/* eliminate multiple filter matches for the same skb */
>   	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
> -	    this_cpu_ptr(ro->uniq)->hash == oskb->hash) {
> +	    this_cpu_ptr(ro->uniq)->can_skb_uid == csx->can_skb_uid) {
>   		if (!ro->join_filters)
>   			return;
>   
> @@ -175,7 +179,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>   			return;
>   	} else {
>   		this_cpu_ptr(ro->uniq)->skb = oskb;
> -		this_cpu_ptr(ro->uniq)->hash = oskb->hash;
> +		this_cpu_ptr(ro->uniq)->can_skb_uid = csx->can_skb_uid;
>   		this_cpu_ptr(ro->uniq)->join_rx_count = 1;
>   		/* drop first frame to check all enabled filters? */
>   		if (ro->join_filters && ro->count > 1)
> 

