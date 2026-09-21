Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73351AFC1;
	Mon, 21 Sep 2026 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030511; cv=none; b=P385BNZFgCaoLaivCYY9f/9PRZOMVm2reQmyfrSEg044/iIsQpfG35+lvldhoVEm3PQVG4ebWGFQGX3vXI9jd513Cw1bMrnfRfkr4UF0ywUHYC9i1Lb7etSK22lf0mlORloZGdSkQabMm5oIDLQEHaIgrdvMgjO/4EPYdrOkOMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030511; c=relaxed/simple;
	bh=OBX7XpNtC+yrBEvD6sPv+E9K03bWHgqVaHlrEWl+1PY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGULqVant+5Wux78AKS+L6VAVM/zJSyttZ+aSyu+wH9Ac+evG2fE28s4xOQf3IScCqWndUue1EW5zSsMh/Pz+idZlSAXx4y8br1NXs0EYX4/A4IRcP2tZF7dQ15xxWr2tmEjny1Egb+km3d7GTHwWj48R+l1vnK5QPHzBTmn7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtldKd8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtldKd8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882FB1F000FF;
	Mon, 21 Sep 2026 22:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790030509;
	bh=dDu/I/jl47PhoBil2/ZTm2tiiw/rtG0yrhZ/WCeLz5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GtldKd8/h1XxhH/vDHRTecc1tObnZv9wXiSMh1EyiUfhQARiF0HxrNO8iNcSfAPz3
	 SBB4RpXgvPaKAEAtjGfhSmYtiIxIIiloKFZ6LZdhPnqZbDgjwAgRstFqIbUAmZ7aW1
	 mC8/Kmafpd15IpnvlHawqqV4S+1hDfKqFW4OEU7bLX8Qyo5v/UVIFLxr/fMWrH8M/1
	 B1ujLSiQM864nxLQTlNg0WQqUfnkW00nzvXbsocQBv22O/ZqhlPn7UOu8uKO2/zdYI
	 CbKO28k4/jArJ1pFG0JWtWxHH3xkSJtVEA53JR/hwPZ/1RtBlLeBvJ9FVRYCkny6og
	 7gdKVNjtoAd7g==
Date: Mon, 21 Sep 2026 15:41:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 co+65e5c76b187f08b2@bugs.sh, Xiang Mei <xmei5@asu.edu>,
 stable@vger.kernel.org
Subject: Re: [PATCH net] veth: manage XDP program pointers during channel
 resize
Message-ID: <20260921154147.4e1e092d@kernel.org>
In-Reply-To: <20260917153923.904124-3-bestswngs@gmail.com>
References: <20260917153923.904124-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 23:39:25 +0800 Weiming Shi wrote:
> veth_set_channels() tears down XDP resources for removed RX queues
> without clearing rq->xdp_prog.  If the program is then detached or
> replaced, those queues keep the old pointer after bpf_prog_put().  A
> later channel increase can re-enable NAPI and run the freed program.
> 
> Clear the program pointer after taking an RX queue offline, and publish
> the current program only after bringing the queue back online succeeds.
> 
>   BUG: unable to handle page fault for address: ffffc90000256048
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   RIP: veth_xdp_rcv_skb (include/linux/filter.h:779
>                          include/net/xdp.h:696 drivers/net/veth.c:820)
>   Call Trace:
>    veth_xdp_rcv (drivers/net/veth.c:941)
>    veth_poll (drivers/net/veth.c:986)
>    __napi_poll (net/core/dev.c:7787)
>    net_rx_action (net/core/dev.c:7850 net/core/dev.c:8007)
>    handle_softirqs (kernel/softirq.c:645)
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> Cc: stable@vger.kernel.org
> Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op")
> Reported-by: <co+65e5c76b187f08b2@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  drivers/net/veth.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 6ed3ee81153fb..ef7624bc2c0ec 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1247,12 +1247,15 @@ static int veth_napi_enable(struct net_device *dev)
>  static void veth_disable_range_safe(struct net_device *dev, int start, int end)
>  {
>  	struct veth_priv *priv = netdev_priv(dev);
> +	int i;
>  
>  	if (start >= end)
>  		return;
>  
>  	if (priv->_xdp_prog) {
>  		veth_napi_del_range(dev, start, end);
> +		for (i = start; i < end; i++)
> +			rcu_assign_pointer(priv->rq[i].xdp_prog, NULL);
>  		veth_disable_xdp_range(dev, start, end, false);
>  	} else if (veth_gro_requested(dev)) {
>  		veth_napi_del_range(dev, start, end);
> @@ -1262,7 +1265,7 @@ static void veth_disable_range_safe(struct net_device *dev, int start, int end)
>  static int veth_enable_range_safe(struct net_device *dev, int start, int end)
>  {
>  	struct veth_priv *priv = netdev_priv(dev);
> -	int err;
> +	int err, i;
>  
>  	if (start >= end)
>  		return 0;
> @@ -1281,6 +1284,9 @@ static int veth_enable_range_safe(struct net_device *dev, int start, int end)
>  			veth_disable_xdp_range(dev, start, end, true);
>  			return err;
>  		}
> +		for (i = start; i < end; i++)
> +			rcu_assign_pointer(priv->rq[i].xdp_prog,
> +					   priv->_xdp_prog);
>  	} else if (veth_gro_requested(dev)) {
>  		return veth_napi_enable_range(dev, start, end);
>  	}

This is pure slop, cramming loops into functions which have none.
Shameful, really.

Please test this and submit it if it passes the tests:

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 6ed3ee81153f..5d5e8ebce65a 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1054,6 +1054,8 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
        for (i = start; i < end; i++) {
                struct veth_rq *rq = &priv->rq[i];
 
+               if (priv->_xdp_prog)
+                       rcu_assign_pointer(rq->xdp_prog, priv->_xdp_prog);
                napi_enable(&rq->xdp_napi);
                rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
        }
@@ -1088,6 +1090,7 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 
                rcu_assign_pointer(priv->rq[i].napi, NULL);
                napi_disable(&rq->xdp_napi);
+               rcu_assign_pointer(rq->xdp_prog, NULL);
                __netif_napi_del(&rq->xdp_napi);
        }
        synchronize_net();
