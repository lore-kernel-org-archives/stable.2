Received: from mta0.migadu.com (out-138.mta0.migadu.com [91.218.175.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE092D7814
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349766; cv=none; b=Ey5LmAhqwViiuZnNxLbPbD3XCGNcr4R4vJNUYiJ82paoJAKGN3hH/QYdmZptQM2zFBqsTo2dvdmcDTCAuaC/udV/IvLlZCjI8dc4BRimVIJgC6S46vBThf+5X0kaSmJbK2zZ354USfsN/j71E+ZXX7b+uSREF//8ZGsf91yiBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349766; c=relaxed/simple;
	bh=jptbH70iXgdreHi9nRKzywgG6n8frLVlbAd3co9U8wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5YLON+m7/97O/Gx3psCIiaNV38Pl4xS7D8E7ZcEri6ONhihB5YyT1uOR/UBXtpdS0psOIsj8vwCkoTpDKY8BzrDX0eDSMQBNi4kdmgGJJpXY2uXCCJEuU/ErEgwLMmH7+vlSoj+5+jpqrDo14J8ITrrK2mCPXke4hA+32fMIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TnOapCAM; arc=none smtp.client-ip=91.218.175.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TnOapCAM"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jptbH70iXgdreHi9nRKzywgG6n8frLVlbAd3co9U8wY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789349760; v=1; x=1789954560;
 b=TnOapCAMj32zHMgzSDcpLEOmvtfn3vf1JtFG9g41KbTnYv0S/3El/MAbQHgI1t6Nmw8GEf8o
 RfNfl4OjYlCkaNhV3di+1rys3ajdLZiJ0Kh2u8cYTcl7hu/+4ZExfZy9J15nQGHruYq+jJG9txT
 Qbepl6gMd8mXiR3kHzay/C3E=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id dc709e117764e5a2;
	Mon, 14 Sep 2026 01:35:50 +0000
X-Mizu-Trace-ID: dc709e117764e5a2
X-Migadu-Flow: FLOW_OUT
Date: Mon, 14 Sep 2026 09:35:37 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Gris Ge <cnfourt@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net v2] net: ip_tunnel: initialize `options_len` before
 referencing options
Message-ID: <aqdPaYCTbB6cjnQ3@fedora>
References: <20260913090851.468216-1-cnfourt@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913090851.468216-1-cnfourt@gmail.com>

On Sun, Sep 13, 2026 at 05:08:50PM +0800, Gris Ge wrote:
> The following command triggers a kernel panic:
> 
>   ip link add d0 type dummy; ip link set d0 up
>   ip route add 10.30.0.0/16 \
>     encap ip id 300 geneve_opts 4660:66:11223344 dev d0
> 
>   memcpy: detected buffer overflow: 4 byte write of buffer size 0
>   kernel BUG at lib/string_helpers.c:1044!
>   ...
>   ip_tun_parse_opts.part.0.cold+0x10/0x10
>   ip_tun_build_state+0x116/0x2a0
> 
> On kernels built with GCC 15+ and `CONFIG_FORTIFY_SOURCE`, the fortified
> `memcpy()` got 0 sized destination with request of 4 bytes length:
> 
>   static int ip_tun_parse_opts_geneve(...)
>   {
>       ...
>       attr = tb[LWTUNNEL_IP_OPT_GENEVE_DATA];
>       data_len = nla_len(attr); /* == 4 */
> 
>       struct geneve_opt *opt = ip_tunnel_info_opts(info) + opts_len;
>       memcpy(opt->opt_data, nla_data(attr), data_len);
>       /*     ^^^^^^^^^^^^^ 0 since options_len is assigned afterwards */
> 
> Fixed by initializing the counter before the options are referenced.
> Matching what `tunnel_key_opts_set()` already does.
> 
> Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_tunnel_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gris Ge <cnfourt@gmail.com>
> ---
> v2:
>   - pass opt_len into ip_tun_set_opts() and initialize options_len there,
>     matching tunnel_key_opts_set(), as suggested by Eric Dumazet.
> v1: https://lore.kernel.org/netdev/20260912055304.1415016-1-cnfourt@gmail.com/
> 
>  net/ipv4/ip_tunnel_core.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
> index 5168d546ea2f..bab42b9e277f 100644
> --- a/net/ipv4/ip_tunnel_core.c
> +++ b/net/ipv4/ip_tunnel_core.c
> @@ -680,8 +680,14 @@ static int ip_tun_get_optlen(struct nlattr *attr,
>  }
> 
>  static int ip_tun_set_opts(struct nlattr *attr, struct ip_tunnel_info *info,
> -			   struct netlink_ext_ack *extack)
> +			   int opts_len, struct netlink_ext_ack *extack)
>  {
> +	/* `options_len` is the __counted_by() annotation of the `options`
> +	 * flexible array, it must be initialized before parsing writes
> +	 * into it.
> +	 */
> +	info->options_len = opts_len;
> +
>  	return ip_tun_parse_opts(attr, info, extack);
>  }
> 
> @@ -712,7 +718,8 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,
> 
>  	tun_info = lwt_tun_info(new_state);
> 
> -	err = ip_tun_set_opts(tb[LWTUNNEL_IP_OPTS], tun_info, extack);
> +	err = ip_tun_set_opts(tb[LWTUNNEL_IP_OPTS], tun_info, opt_len,
> +			      extack);
>  	if (err < 0) {
>  		lwtstate_free(new_state);
>  		return err;
> @@ -753,7 +760,6 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,
>  	}
> 
>  	tun_info->mode = IP_TUNNEL_INFO_TX;
> -	tun_info->options_len = opt_len;
> 
>  	*ts = new_state;
> 
> @@ -1006,7 +1012,8 @@ static int ip6_tun_build_state(struct net *net, struct nlattr *attr,
> 
>  	tun_info = lwt_tun_info(new_state);
> 
> -	err = ip_tun_set_opts(tb[LWTUNNEL_IP6_OPTS], tun_info, extack);
> +	err = ip_tun_set_opts(tb[LWTUNNEL_IP6_OPTS], tun_info, opt_len,
> +			      extack);
>  	if (err < 0) {
>  		lwtstate_free(new_state);
>  		return err;
> @@ -1040,7 +1047,6 @@ static int ip6_tun_build_state(struct net *net, struct nlattr *attr,
>  	}
> 
>  	tun_info->mode = IP_TUNNEL_INFO_TX | IP_TUNNEL_INFO_IPV6;
> -	tun_info->options_len = opt_len;
> 
>  	*ts = new_state;
> 
> --
> 2.55.0
> 

Looks good to me.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
