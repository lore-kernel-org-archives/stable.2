Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828DD4779A8;
	Tue, 16 Jun 2026 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627649; cv=none; b=nnoDpfOx28TLzTmgFgKvK1DvE9UaTtDbArxT4brsh9L+Asynop5QqMuMjosAyUwzRKlwXqUXGWAaoIOIERgCb/Ba8mbJ0GbDO3V6WJ1ReriiMQkWoChNfdjTUzSpbCcJRG/yFaSel97WYhQfTMA00TYV3UojeuPYvgBU1f2Bef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627649; c=relaxed/simple;
	bh=/lzeg3xG55IT6R69PR5BS8EpqwfeQh+NovbQ5847Y6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpYem8QGTtmJN+beMgjfByF5+eGEdFTAXs1yTVMC6fe/QWMfkcvo/RDuNvKwUPVqYOgeQ4XBkKlGS09GfC4StOyhIAjaRmn2ytSYKkBWdCfpIw+/cnodV7S3ufBPloSNPpWG6+ptoXEuBbbKcNTApWlidfLb3MfIWmpFKaR+oDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aosnHVQ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aosnHVQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0901F000E9;
	Tue, 16 Jun 2026 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781627648;
	bh=8Jqh3XV9rmSyWZWNxZuPuAUlmfCecefCbbbBGdwDnyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aosnHVQ6DjHHznUHYXoTJg6sbEmsT5RzlaS+k2wK+52SNPreY86c1qqgUiyaerE/h
	 VLj0Rphd1xC8+5EBpPJDWD+V+cVB3/ttt1aq1+4ixUm7Tql96JjhfZzPK3XZM383Fr
	 sjbyiVu28OAOFb0b9SR8yYbBwxPyQnVN+NoVCYr04Z64VNWl+PoEjtPkj1XYV/huHn
	 8zpXrfWwLtlCGf5BxqeVs1JQQLEw+GgqpkEuEvK1DZhqXdjGMxpexHUfSX+8rt0RRN
	 YEZNYL7D88X81gcJRBbDn51aWPZS83qfk8IXKODYEbuQ2pOR63JGrg7MFLNJ+GR8RD
	 ukCsT104fU3rw==
Date: Tue, 16 Jun 2026 17:34:03 +0100
From: Simon Horman <horms@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>, Kito Xu <veritas501@foxmail.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] appletalk: fix use-after-free in atalk_find_primary()
Message-ID: <20260616163403.GA827683@horms.kernel.org>
References: <20260615103930.1484-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615103930.1484-1-zhaoyz24@mails.tsinghua.edu.cn>

On Mon, Jun 15, 2026 at 06:39:28PM +0800, Yizhou Zhao wrote:
> atalk_find_primary() walks the global AppleTalk interface list under
> atalk_interfaces_lock, but returns a pointer to iface->address after
> dropping that lock.  Both atalk_autobind() and atalk_bind() then
> dereference the returned pointer without any lifetime protection.
> 
> The interface can be removed concurrently through the normal AppleTalk
> interface ioctl path.  SIOCATALKDIFADDR calls atalk_dev_down(), which
> eventually reaches atif_drop_device() and frees the same struct
> atalk_iface that owns the returned address field.  A racing bind can
> therefore read from freed memory.
> 
> This is reachable with a configured AppleTalk interface; reproducing the
> race does not require a malicious device or driver.  The configuration
> ioctls require CAP_NET_ADMIN in the initial user namespace, and
> AF_APPLETALK sockets are limited to init_net.
> 
> Fix the lifetime issue without changing the returned address pointer
> type.  Rename the helper to atalk_find_primary_locked() and keep
> atalk_interfaces_lock held across the return.  The callers now copy
> s_net and s_node while the lock is still held, then immediately release
> the lock before doing any further work.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 30a6dc06291c..4d6576cd0ae8 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -351,7 +351,7 @@ struct atalk_addr *atalk_find_dev_addr(struct net_device *dev)
>  	return iface ? &iface->address : NULL;
>  }
>  

A kernel doc for atalk_find_dev_addr which describes the locking
expectations is probably warranted here.

> -static struct atalk_addr *atalk_find_primary(void)
> +static struct atalk_addr *atalk_find_primary_locked(void)
>  {
>  	struct atalk_iface *fiface = NULL;
>  	struct atalk_addr *retval;
> @@ -378,7 +378,6 @@ static struct atalk_addr *atalk_find_primary(void)
>  	else
>  		retval = NULL;
>  out:
> -	read_unlock_bh(&atalk_interfaces_lock);

This function still acquires atalk_interfaces_lock but I don't think that
asymmetry is justified. If the critical section needs to be expanded then I
think it would be best to both acquire and release the lock in the caller.

>  	return retval;
>  }
>  
> @@ -1132,20 +1131,24 @@ static int atalk_autobind(struct sock *sk)
>  {
>  	struct atalk_sock *at = at_sk(sk);
>  	struct sockaddr_at sat;
> -	struct atalk_addr *ap = atalk_find_primary();
> +	struct atalk_addr *ap = atalk_find_primary_locked();
>  	int n = -EADDRNOTAVAIL;

We could take this opportunity to move towards reverse xmas tree here.

>  
>  	if (!ap || ap->s_net == htons(ATADDR_ANYNET))
> -		goto out;
> +		goto unlock_and_out;
>  
>  	at->src_net  = sat.sat_addr.s_net  = ap->s_net;
>  	at->src_node = sat.sat_addr.s_node = ap->s_node;
> +	read_unlock_bh(&atalk_interfaces_lock);

The unlock_and_out label applies to the critical section which ends here.
But in my mind the goto construct is best used for handling errors 
that apply to, and in general accumulate during, the flow of a function.

Combining that with my earlier comments would go for something like the
following (completely untested!). Similarly in atalk_bind().

	struct atalk_sock *at = at_sk(sk);
	struct sockaddr_at sat;
	int n = -EADDRNOTAVAIL;
	struct atalk_addr *ap;

	read_lock_bh(&atalk_interfaces_lock);
	ap = atalk_find_primary_locked();

	if (ap && ap->s_net != htons(ATADDR_ANYNET)) {
		at->src_net  = sat.sat_addr.s_net  = ap->s_net;
		at->src_node = sat.sat_addr.s_node = ap->s_node;
	}

	read_unlock_bh(&atalk_interfaces_lock);

>  
>  	n = atalk_pick_and_bind_port(sk, &sat);
>  	if (!n)
>  		sock_reset_flag(sk, SOCK_ZAPPED);
>  out:
>  	return n;
> +unlock_and_out:
> +	read_unlock_bh(&atalk_interfaces_lock);
> +	goto out;
>  }
>  
>  /* Set the address 'our end' of the connection */

...

-- 
pw-bot: changes-requested
