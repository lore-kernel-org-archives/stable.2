Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8699C3EE1FD;
	Mon, 21 Sep 2026 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994764; cv=none; b=lJwK8+u6w44NSSSFtNFWFyuX08gVTAYI75ePWYd7HsZUa0DvC8v5N3WtElVa0B7IGkoYSXS2G8Ay6tkWqzJg2oWnjYVHe+H/GJAaZdD72LqBJbuQw+ujAs8owdi5HhT+0yBqVLk4TZO0QEfR2QoZZ2i5O+V7NYZl4maQfHU6ZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994764; c=relaxed/simple;
	bh=6v0BTfsWzBfmZOHrEarD6fEFT9rqQmW59HdNCeYcKgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1Q+q5xQfvlWLOBW+Blo08Cr1uhizX+isP1Kd8AhuHIQxOyc3YaOsXX7/C55UiRWP28yum4MTgQr1wzjh8wFxerNFbLuEsjTWYjKPy1V/K182oe7pqdc1BCM1INriq1Bfi3neXIrO0PswmI2VHuuNdW7zQ1eMA/GV+SRZsnPyZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhso0QvU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhso0QvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9821F000FF;
	Mon, 21 Sep 2026 12:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789994763;
	bh=pifXzv2SvQy9LF/ukmnuB1/jrrwEMYs2agzZGCWrZdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hhso0QvU0W90ZixR5a7+GPaiQC5/MdwLtnn1UYIT6l6GjnjD0pxsAqfMb7I4H1l/W
	 hnBrAzN250T3L56CDxnR3n6TdgEsBGLBGK25m+bDMppwSMzRAy+9ZbRAiqZJf4kls7
	 +b2I7Y5ScS9g0ARjFF9ixcuMAuT30ZLq++TzsxhNrxVpVi9x/b6OnsLQMHN3kOGcQm
	 /PJrEr0ri4FSzb4GGmYbeH7rfjc4VWFUOIU6kIjsC3fK81Ef0rTsww5RGS2Lfd9n1n
	 evlkp8uJBxajXXpQP/7MNmiCirdhElNoH9QaU3hA7fQm9I/re2X53XFuoNO9TxVzs/
	 il+1WhB0UO7Rg==
Date: Mon, 21 Sep 2026 13:45:58 +0100
From: Simon Horman <horms@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	co+65e5c76b187f08b2@bugs.sh, Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] veth: manage XDP program pointers during channel
 resize
Message-ID: <20260921124558.GO13925@horms.kernel.org>
References: <20260917153923.904124-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917153923.904124-3-bestswngs@gmail.com>

On Thu, Sep 17, 2026 at 11:39:25PM +0800, Weiming Shi wrote:
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

Reviewed-by: Simon Horman <horms@kernel.org>

