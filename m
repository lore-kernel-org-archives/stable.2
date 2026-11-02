Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583107;
	b=YjFT9PKLYQWyqSsdclfAaJGfxYqACQdeimrHugOScaw19z57lTnUGaQYvXydwTa/RnYV
	 xaTstiUhrCLGRd4ol9suELmGTrcKnx+2sw4v7hZDduPka2YKDaOjuWjsCP1KXGgwtZveV
	 UyGT/RIUwbGV/eA07jWoky9JnGwnm/aX+gCbLcfJPBFALr/42ewoJIYMeyrbB2d/nrTjA
	 w3eA91ggxGDSH9eo1lhphfXIMNFU58a+hUzc7avzNvqjj7D4Sy8aD0qijp1cF9NrG+x4U
	 TC4Q3xpcCdnzLxudJK6Ec+0hACw1Q/wdHoAfGtciIfGBwVNffb7Vu/7E5MpIKQEHXCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583107;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=L1qln637r4iaxhU6X2qqgXPNtSD5t9x/HzmOPAimvzw=;
	b=lJcz0zptS8kl9G01gnWP6Znf6P5bOyLHYgOyjEtZvveYKWlDqtb13zrd9CBpH4a1uGgg
	 1DxTnpUjXrxSYx25yk3W8//JV6veqx2rr5trRZXnIIyXIu9ciakhIWIc1AEe68eohtB0e
	 gthwo57bDiT8RNX0wbDslfK3txg45YejdCw3Arr68tS9Uc8KZhqXm8DWCWhT62VAQRBEh
	 LOE6fXgSvDvAV5XN9IPDgFC1C2Cd5VrzB7HyNtw+J1WyFGkJBI2rIZkGJp6eOfM5cfA39
	 ufgrPT5xNFyYFLuHAJJe9IbsLKzTKqCJvc3IqwoYUT+8wItvkfXPpQUERADMjK0urMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KVXFclE1;
	arc=none smtp.remote-ip=91.218.175.98
Received: from mta0.migadu.com (out-98.mta0.migadu.com [91.218.175.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5878606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 01:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5878606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KVXFclE1
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=p/3iXpZzk7ktrVPH1x7dECGM4TyYW5DHZyEDipf4J6M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793583105; v=1; x=1794187905;
 b=KVXFclE1Z7CTQ/NTKVZrjdsDLbu9qZLu7NmzKY9yBSMHXV5T0GIYhLxfcUgLAkhJTkeWWuX2
 HVjPKgsRUeggtpBT7umyFO0I+3Xa8joYzo+WWg10+oIqr5qTSjQpD7FNQDXVgsmiu+WayUjOyW/
 Qncq0lHgHeFvFtrKH4uG9Rys=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 3bb2a1c69930a0d5;
	Mon, 02 Nov 2026 01:31:45 +0000
X-Mizu-Trace-ID: 3bb2a1c69930a0d5
X-Migadu-Flow: FLOW_OUT
Date: Mon, 2 Nov 2026 09:31:30 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>,
	Gerd Rausch <gerd.rausch@oracle.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Flavio Leitner <fbl@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 3/5] ipv6: restrict mld_qrv to 255
Message-ID: <aufn8jMjBc51dKXO@fedora>
References: <20261101061331.286404-1-jiayuan.chen@linux.dev>
 <20261101061331.286404-4-jiayuan.chen@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101061331.286404-4-jiayuan.chen@linux.dev>

On Sun, Nov 01, 2026 at 02:12:01PM +0800, Jiayuan Chen wrote:
> net.ipv6.mld_qrv only has a lower bound, but ipv6_mc_reset() stores it
> into the u8 inet6_dev::mc_qrv, so 256 wraps to 0 and the first MLDv2
> Query received on the interface trips the WARN_ON() in mld_update_qrv():
> 
> 	WARN_ON(idev->mc_qrv == 0);
> 
>   WARNING: net/ipv6/mcast.c:1327 at mld_query_work+0x1fd2/0x2cb0, CPU#3: kworker/3:1/2688
>   Workqueue: mld mld_query_work
>   RIP: 0010:mld_query_work+0x1fd2/0x2cb0
>   Call Trace:
>    <TASK>
>    process_one_work+0x93a/0x1b20
>    worker_thread+0x6d0/0x11d0
>    kthread+0x358/0x470
>    ret_from_fork+0x5b3/0x820
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> Make the sysctl a u8 like mc_qrv and switch to proc_dou8vec_minmax(),
> which rejects anything above 255, and document it.
> 
> Fixes: 2f711939d2ea ("ipv6: add sysctl_mld_qrv to configure query robustness variable")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v2: switched to u8 and proc_dou8vec_minmax(), as suggested by Kuniyuki
> Iwashima.
> ---
>  Documentation/networking/ip-sysctl.rst | 2 ++
>  include/net/ipv6.h                     | 2 +-
>  net/ipv6/mcast.c                       | 2 +-
>  net/ipv6/sysctl_net_ipv6.c             | 4 ++--
>  4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 4b19c8d3efda7..71f334f27004e 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2515,6 +2515,8 @@ mld_qrv - INTEGER
>  
>  	Minimum: 1 (as specified by RFC6636 4.5)
>  
> +	Maximum: 255
> +
>  max_dst_opts_number - INTEGER
>  	Maximum number of non-padding TLVs allowed in a Destination
>  	options extension header. If this value is less than zero
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 3de07e738538f..4901a92066e61 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -205,7 +205,7 @@ struct sk_buff *ip6_frag_next(struct sk_buff *skb,
>  
>  /* sysctls */
>  extern int sysctl_mld_max_msf;
> -extern int sysctl_mld_qrv;
> +extern u8 sysctl_mld_qrv;
>  
>  #define _DEVINC(net, statname, mod, idev, field)			\
>  ({									\
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index ecef55f261890..13f31132e0f97 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -106,7 +106,7 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
>  #define IPV6_MLD_MAX_MSF	64
>  
>  int sysctl_mld_max_msf __read_mostly = IPV6_MLD_MAX_MSF;
> -int sysctl_mld_qrv __read_mostly = MLD_QRV_DEFAULT;
> +u8 sysctl_mld_qrv __read_mostly = MLD_QRV_DEFAULT;
>  
>  #define mc_assert_locked(idev)			\
>  	lockdep_assert_held(&(idev)->mc_lock)
> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> index 1a0a36dcdabc1..f3ac04dbc71d0 100644
> --- a/net/ipv6/sysctl_net_ipv6.c
> +++ b/net/ipv6/sysctl_net_ipv6.c
> @@ -226,9 +226,9 @@ static struct ctl_table ipv6_rotable[] = {
>  	{
>  		.procname	= "mld_qrv",
>  		.data		= &sysctl_mld_qrv,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_dou8vec_minmax,
>  		.extra1		= SYSCTL_ONE
>  	},
>  #ifdef CONFIG_NETLABEL
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
