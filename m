Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D83B19B5;
	Sun, 16 Aug 2026 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786914164; cv=none; b=dqeVCW4ST02qXXCnVzscL/UVVLKsn+Ve994el0yWl59dDm9jbhP4PIGaD9w0xULUtNofac2ENyqUFnWUM2NjEkg2bv6Go1kkRxjOQW45n6kfCO/oyc4+T7N1ZMIdKvga9pvUFHjXidgignsr9NlAGogxFNW9r1aVcbNOTxjrIE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786914164; c=relaxed/simple;
	bh=zB+bLSx2ZDwxjjitDphKtVLI6sAuY5BuNf+XJgmiv0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROpvRMo+Xt3Bahz1TajRnOdVdaMWMQKRWvpKjdRGSRfmv+B0fcVtm+JYALtYN1SGySJzOS/fiWEZA5n7gjxngjolFBGKSueLiFKsImQm6Bra/Iqe+YUBm59sj+uXzzY8a+eSLMRsrFjgqZBGz1hJMpSMq5wPOgfAeC2NzRgIZdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=a6xXXiFA; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="a6xXXiFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1786914150;
	bh=RQDgQIDpq2a95XlpjXPV52Y4fURSPzXkE3dG47J0Rhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6xXXiFAb795zWbC9VDi88AjoYoyA6na2Z00HTHv2QnJfq1Qx1VTuf28vOP74WDEs
	 3zSgUOMTop4LnnOvdWArttddCzu8zHKHVRwC7SgFEo+66S6l2EanmDcPvwK9YRTf0K
	 8Cq64ZE8gXG+UkIOH5cItXfVcATp/suhAQxh6omtqGNBsmtZqHwZA218Zgk7t/1NnE
	 GXSBqYwACeYCv7SSbkyw9A5uzc4+cQg4QrIyMduADhD3qFMNdIUpu3CfLPYuE8VB6B
	 lNmVlEku/zfsY0S5daTY548jF8AH3OBgHKLmR5KNsPmUgqzJoGWIVGzQYwA1a/daGz
	 zZKZaQF1Tcw7g==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id B838D6005E;
	Sun, 16 Aug 2026 23:02:30 +0200 (CEST)
Date: Sun, 16 Aug 2026 23:02:27 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Qing Ming <a0yami@mailbox.org>
Cc: Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, kuniyu@google.com,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4] gtp: serialize PDP context updates
Message-ID: <aoIlY3NaRtICIQZV@chamomile>
References: <20260814031526.118216-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814031526.118216-1-a0yami@mailbox.org>

On Fri, Aug 14, 2026 at 11:15:26AM +0800, Qing Ming wrote:
> PDP contexts can be deleted through GTP_CMD_DELPDP or while the GTP
> network device is being unregistered. The latter is serialized by RTNL,
> but the generic-netlink delete path only holds RCU.
> 
> Running both paths concurrently can therefore make both paths delete the
> same PDP context. The issue was found through static analysis and
> reproduced on a KASAN-enabled kernel by a simple two-thread program
> racing GTP_CMD_DELPDP against RTM_DELLINK:
> 
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: maybe wild-memory-access in range
>          [0xdead000000000120-0xdead000000000127]
>   RIP: gtp_genl_del_pdp+0x1c1/0x420 [gtp]
>   RBP: dead000000000122
> 
> The second deletion dereferenced the poisoned hlist pprev pointer.
> 
> Serialize gtp_pdp_add(), gtp_genl_del_pdp(), and gtp_dellink() with a
> shared mutex. With this change, the same reproducer completed 50 races
> on a KASAN- and lockdep-enabled kernel without a KASAN report, oops, or
> lockdep warning.
> 
> Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Qing Ming <a0yami@mailbox.org>
> ---
> v4:
> - Replace guard() with plain mutex_lock()/mutex_unlock() in the
>   GTP_CMD_NEWPDP path.
> - Narrow the RCU read-side section in gtp_genl_del_pdp() to
>   gtp_find_pdp(); gtp_find_dev() uses dev_get_by_index_rcu().
> - Add mutex-aware lockdep conditions to the shared PDP lookup helpers.
> 
> v3: https://lore.kernel.org/netdev/20260811022012.5416-1-a0yami@mailbox.org/
>  drivers/net/gtp.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 9a12cc53da00..ea83a6b6aa1a 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -12,6 +12,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/skbuff.h>
>  #include <linux/udp.h>
>  #include <linux/rculist.h>
> @@ -108,6 +109,7 @@ struct gtp_net {
>  };
>  
>  static u32 gtp_h_initval;
> +static DEFINE_MUTEX(gtp_pdp_lock);
>  
>  static struct genl_family gtp_genl_family;
>  
> @@ -151,7 +153,8 @@ static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid, u16 family)
>  
>  	head = &gtp->tid_hash[gtp0_hashfn(tid) % gtp->hash_size];
>  
> -	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
> +	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
> +				 lockdep_is_held(&gtp_pdp_lock)) {
>  		if (pdp->af == family &&
>  		    pdp->gtp_version == GTP_V0 &&
>  		    pdp->u.v0.tid == tid)
> @@ -168,7 +171,8 @@ static struct pdp_ctx *gtp1_pdp_find(struct gtp_dev *gtp, u32 tid, u16 family)
>  
>  	head = &gtp->tid_hash[gtp1u_hashfn(tid) % gtp->hash_size];
>  
> -	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
> +	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
> +				 lockdep_is_held(&gtp_pdp_lock)) {
>  		if (pdp->af == family &&
>  		    pdp->gtp_version == GTP_V1 &&
>  		    pdp->u.v1.i_tei == tid)
> @@ -185,7 +189,8 @@ static struct pdp_ctx *ipv4_pdp_find(struct gtp_dev *gtp, __be32 ms_addr)
>  
>  	head = &gtp->addr_hash[ipv4_hashfn(ms_addr) % gtp->hash_size];
>  
> -	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
> +	hlist_for_each_entry_rcu(pdp, head, hlist_addr,
> +				 lockdep_is_held(&gtp_pdp_lock)) {
>  		if (pdp->af == AF_INET &&
>  		    pdp->ms.addr.s_addr == ms_addr)
>  			return pdp;
> @@ -220,7 +225,8 @@ static struct pdp_ctx *ipv6_pdp_find(struct gtp_dev *gtp,
>  
>  	head = &gtp->addr_hash[ipv6_hashfn(ms_addr) % gtp->hash_size];
>  
> -	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
> +	hlist_for_each_entry_rcu(pdp, head, hlist_addr,
> +				 lockdep_is_held(&gtp_pdp_lock)) {
>  		if (pdp->af == AF_INET6 &&
>  		    ipv6_pdp_addr_equal(&pdp->ms.addr6, ms_addr))
>  			return pdp;
> @@ -1555,9 +1561,11 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
>  	struct pdp_ctx *pctx;
>  	int i;
>  
> +	mutex_lock(&gtp_pdp_lock);
>  	for (i = 0; i < gtp->hash_size; i++)
>  		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
>  			pdp_context_delete(pctx);
> +	mutex_unlock(&gtp_pdp_lock);
>  
>  	list_del(&gtp->list);
>  	unregister_netdevice_queue(dev, head);
> @@ -2053,7 +2061,9 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
>  		goto out_unlock;
>  	}
>  
> +	mutex_lock(&gtp_pdp_lock);
>  	pctx = gtp_pdp_add(gtp, sk, info)

This does not look fine, it should protect the entire section where
this pctx object is used.

> +	mutex_unlock(&gtp_pdp_lock);
>  	if (IS_ERR(pctx)) {
>  		err = PTR_ERR(pctx);
>  	} else {
> @@ -2134,9 +2144,12 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
>  	if (!info->attrs[GTPA_VERSION])
>  		return -EINVAL;
>  
> -	rcu_read_lock();
> +	mutex_lock(&gtp_pdp_lock);
>  
> +	/* gtp_find_dev() uses dev_get_by_index_rcu(). */
> +	rcu_read_lock();
>  	pctx = gtp_find_pdp(sock_net(skb->sk), info->attrs);

Same here.

> +	rcu_read_unlock();
>  	if (IS_ERR(pctx)) {
>  		err = PTR_ERR(pctx);
>  		goto out_unlock;
> @@ -2153,7 +2166,7 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
>  	pdp_context_delete(pctx);
>  
>  out_unlock:
> -	rcu_read_unlock();
> +	mutex_unlock(&gtp_pdp_lock);
>  	return err;
>  }
>  
> 
> base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
> -- 
> 2.53.0
> 
