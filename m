Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD67490BEE;
	Mon, 28 Sep 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588196; cv=none; b=c+mjiDTXti9mwldi/cgKCxnI7fqCnS9gXejLkR1Y19vw6ZMd4UMIJ1vyIiEYCegX0eU2cFyhVSDFki83ZcXaa8yP5/mHEa6Xv85SQbuYEBJ0wpbwWXmbi+J3zq+OvM4GDKyqtD3VVTkE1wo5NVp/vGoGAsvaVMBGMUEURmyadZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588196; c=relaxed/simple;
	bh=bYFzn9s+Nv0Pj7tYcNYAiPo84HKQzQEg3f6Qp3ROCdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP2qOPhhTNxbURAsyDr0+uUvh0IiMHRyDWduRfc1Wv0Ijowdy0dgCrqkPUaeSoMUGW8WVb1KeaCcsf2xun5lrvz9mx0DEeAzD4YjyMbyRZxe1WE2wDg5aaFuQfdA5PfiFAv5v/dAvYbvzocpfSrznY1TIwL4gOUxhT2UORm1QnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9xrThjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9xrThjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBE41F000FF;
	Mon, 28 Sep 2026 09:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588195;
	bh=XOs14AwKLFg4V8SGHzajS+S/B56ZsCGKEtjHhvvP85w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H9xrThjUBMJ7LZmiobzPWMU/VllhIYfd44Nk1Wu7/RNyY+O6j2hpW21HcmMjQkBAQ
	 qq7EWCYhvQ61UOtpfUwhkzev8ya3ALDNTc/2IRr/rtqEgRUy7VS3a4MTCJtUUGZnrL
	 bD5t9Xol4vn+BNuvD3QpI0vlw5j3+a0mYZ07K8E0bQPGNDLwMTfLuccBwcEqIveBzI
	 cWh3klHpBKhJ185m64p5zbFb86p/rTg62a06onmEXqn+9kQF1rQ97VlJYDOYDvVIGV
	 tk0RRlaaG72b3zvPFYFM8xr77JBpuiXX7NzRPppTWyCM6BrJ6v0Qvdss9gJ8nnmja1
	 +4zbBnkba8SxQ==
Date: Mon, 28 Sep 2026 10:36:28 +0100
From: Simon Horman <horms@kernel.org>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	aleksander.lobakin@intel.com, wojciech.drewek@intel.com,
	marcin.szycik@linux.intel.com, linux-kernel@vger.kernel.org,
	xuanqiang.luo@kylinos.cn, stable@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v2] pfcp: fix socket lifetime on netdevice
 registration failure
Message-ID: <20260928093628.GM13925@horms.kernel.org>
References: <20260924055252.33488-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924055252.33488-1-xuanqiang.luo@linux.dev>

On Thu, Sep 24, 2026 at 01:52:52PM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> pfcp_newlink() creates the UDP socket before register_netdevice().
> If registration fails after pfcp_dev_init() succeeds, the core calls
> pfcp_dev_uninit(), which releases the socket and clears pfcp->sk.
> The newlink error path then releases it again, causing a NULL pointer
> dereference. This was observed with failslab fault injection:
> 
>   FAULT_INJECTION: forcing a failure.
>   kobject: kobject_add_internal failed for pfcp0 (error: -12 parent: net)
>   BUG: KASAN: null-ptr-deref in udp_tunnel_sock_release+0x1c/0x50
>   Read of size 8 at addr 0000000000000120 by task ip/1037
>   Call trace:
>    show_stack+0x18/0x24 (C)
>    dump_stack_lvl+0x78/0x90
>    print_report+0x468/0x5cc
>    kasan_report+0xa4/0xf0
>    __asan_load8+0x7c/0xd0
>    udp_tunnel_sock_release+0x1c/0x50
>    pfcp_newlink+0x128/0x184
>    rtnl_newlink+0x848/0xe44
>    rtnetlink_rcv_msg+0x468/0x514
>    netlink_rcv_skb+0xc0/0x1f0
>    rtnetlink_rcv+0x18/0x24
>    netlink_unicast+0x4b8/0x558
>    netlink_sendmsg+0x2b8/0x584
>    ...
> 
> Return from pfcp_del_sock() if pfcp->sk is NULL.
> 
> Fixes: 76c8764ef36a5 ("pfcp: add PFCP module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
> Changes:
> v2:
>   - Use a NULL check in pfcp_del_sock() as the minimal fix for net and
>     stable. (Simon Horman.)
> 
> v1: https://lore.kernel.org/all/20260918123158.5631-1-xuanqiang.luo@linux.dev/

Thanks for the update, and the link to v1.

Reviewed-by: Simon Horman <horms@kernel.org>

