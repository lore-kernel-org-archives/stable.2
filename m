Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF74CF499;
	Sun, 18 Oct 2026 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792332087; cv=none; b=rqBqVK1jz06mLNR9PmKa7ZASK+EaiuQIBQ0FLhTWUfHVEhX7aPYvChozfVNLk5mLE60Z/xyWFzW5V2zzHkz8Zsa0qR+vSqJCui3W1rZRmct0PdJHrxLKN5WqyVljurK/xWvNylSlG0E8PJU2GL1CjJVO/jOjB6kJdtyH0eRPDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792332087; c=relaxed/simple;
	bh=X/tZPcIcG5b5lbGINhooOKXr3pcp5Fse4ENDDkF5c5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjTrWuUnOJaIhV0iEhFA6ELIX6Oes8jealb3Q3YSR+UvuJPpgsy8CIKR72yBtJuNZVNHq3D611C/SpUcxn+k+8zp7/g90J9FVyiU6VW2RgKzDZDzILgujNcPP5VRYfhe23A18JHOWe3YK/0wVZDm71x9RPiF2Wqk5OAS10zlasw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7g3SqZN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7g3SqZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D09D1F000C4;
	Sun, 18 Oct 2026 14:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792332086;
	bh=1A30M50E1/c1dVJn3Z1v4PZSDvPxoNJCbANPRlKw/SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M7g3SqZN+uA7MiWS/yJuI6RQBk69bDELmgY+ybiQLbbUOPmgWUVt3WpOibqX4dN7B
	 EwvNhCvhaoUoqm5hF561N9PAMjk183fvHQPJMbS39qgGxCwbo/4+DPhNvRqWuE+db8
	 0+ZUW5Y+9YS71hCUKxFsK7B2JSZiNZOXOdxjWh2/fmy6LROzXIgsGM+V9h/T2YwwiT
	 rSDaRq9iX1r9YrVvi3DsK8P6dNcg74HK6S73HdDw3heSppMq6aV1HTgMF1jlrE4jYf
	 r0zFYHkUBj9MsbR16zvu9bhSk5VRt4UiJ8eDVw/iITQ+vqDCdc47geCZ/Nf1KxS5hX
	 22a3dNcD+n3Cg==
Date: Sun, 18 Oct 2026 15:01:20 +0100
From: Simon Horman <horms@kernel.org>
To: Vaibhav Nagare <vnagare@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, nagarevaibhav@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v4] bnxt_en: don't leave an XDP program installed
 when the open fails
Message-ID: <20261018140120.GJ503057@horms.kernel.org>
References: <20261012072802.2153706-1-vnagare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012072802.2153706-1-vnagare@redhat.com>

On Mon, Oct 12, 2026 at 12:58:02PM +0530, Vaibhav Nagare wrote:
> bnxt_xdp_set() stores the new program and drops the reference on the old
> one before reopening the NIC.  If bnxt_open_nic() then fails, ndo_bpf()
> returns an error with the new program still in bp->xdp_prog.  The caller
> treats the error as "nothing was installed" and drops its own reference,
> so bp->xdp_prog is left pointing at a freed program and the next XDP
> update dereferences it:
> 
>   BUG: unable to handle page fault for address: ff78ecc80ddd1038
>   RIP: 0010:__bpf_prog_put+0x5/0x80
>   Call Trace:
>    bnxt_xdp_set+0xad/0x1b0 [bnxt_en]
>    dev_xdp_propagate+0x36/0xa0
>    bond_xdp_set+0xeb/0x2d0 [bonding]
>    dev_xdp_install+0x1b1/0x350
>    bpf_xdp_link_update+0xc5/0x1b0
>    link_update+0x104/0x1e0
>    __sys_bpf+0x662/0xcf0
> 
> Seen on a 6.12 based kernel after bnxt_alloc_mem() failed an order-4
> allocation on a fragmented host:
> 
>   bnxt_en 0000:a0:00.1 ens4f1np1: nic open fail (rc: fffffff4)
>   bond1: (slave ens4f1np1): Error -12 calling ndo_bpf
> 
> Bonding is not required to hit this; a plain XDP attach on a bnxt
> interface takes the same path.
> 
> Restore the previous program when an attach or a replace fails, and
> recompute the page-mode and XDP TX ring configuration from it.  The
> configuration matters because bnxt_init_one_rx_ring() only assigns
> rxr->xdp_prog in page mode, and __bnxt_set_rx_skb_mode() derives
> dev->max_mtu from the installed program.  Release the old program only
> once the change has been committed.
> 
> A detach is not undone.  dev_xdp_detach_link() clears the core's record
> of the program even when the driver returns an error, so putting the
> program back would leave the driver running a program the core has
> already dropped.  If the reopen fails during a detach, bnxt_xdp_set()
> therefore returns 0 with the device closed; bnxt_open_nic() has already
> logged the failure.
> 
> Found in a crash dump; the change was not tested on hardware.
> 
> Fixes: c6d30e8391b8 ("bnxt_en: Add basic XDP support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
> ---
>   v4:
>    - no functional change.  Correct the comment and commit message: the
>      core clears its record of the program on a failed detach, it does
>      not drop a reference itself, and note that a failed reopen during a
>      detach returns 0 with the device closed (Sashiko AI review)
>    - the same review notes the rollback does not restore the RX
>      aggregation-ring mode.  That is real but pre-existing: without this
>      patch the failed attach leaves the same bp->flags behind and the
>      next open fails the same way.  Restoring it needs a snapshot of
>      bp->flags, the LRO/GRO_HW feature bits and the ring parameters,
>      which is a separate change for net-next
>    - v3: https://lore.kernel.org/netdev/20261001142516.1386525-1-vnagare@redhat.com/
>    - v2: https://lore.kernel.org/netdev/20260930070901.1218980-1-vnagare@redhat.com/
>    - v1: https://lore.kernel.org/netdev/20260928131458.1012180-1-vnagare@redhat.com/

Reviewed-by: Simon Horman <horms@kernel.org>


