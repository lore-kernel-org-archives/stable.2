Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B67545D9A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082388; cv=none; b=epEHT9m9AHThIV1qmjWCGtfdOMjDCB1dRlxWTCQC7k2gMqVnWedo5cR5s8RP/fDt53pMou7geQagfKrn44Zd9SsQMlwTynzesOjJFsPmhpOEbqsfQCZO09yvDAAe003MKjy3jIK9HrXNvjSoQ9SmBEwEnXj+4uHwuCVdwCt6XS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082388; c=relaxed/simple;
	bh=gYPcD4fJC7rXLcfIUmPD6UUPilc2KRNC7fDFaVPrxmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQmGr4laZlBn5il6WwnPHTYv3JjDQ0qXEypz3mfV2pxnDz/hSj7fO/eWP0AsH8KdjAI9aIRvSsZhqocoi8Wa2+C54L7dXO+UFj0unwAtoZia3Nz9I4UjE6p46A0EYq27glhacDIvI1o7gm5XnosE7EGTJ+O88Zbt00Kjd2OQbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkLzhHxy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkLzhHxy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DE71F000FF;
	Tue, 22 Sep 2026 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082386;
	bh=oWEEE4GCAhzyZxI0sLSAiXKm3jYsU41/OLIbUf7yXqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QkLzhHxyEXvaXx76j5If6ZIlwPvpohqfu1DR6d+lZIS3oYCjNKhdpr1vIT/wLW6gy
	 1izAQ4S/oqGoZVF9n3Yuxd06NZRbrJYYYjadoVbr1gseVsKzyMtBftloLkyToK/WN5
	 KSEjg2ka2KYtGGi/g1NM+DFYOHN/t/n4rcKuGS68k9Kvpdyl+zI6IKdtme9BYaR5ty
	 jL11DNUxV9Mv5kXwsOT+At6uIZ6XWm/90pjdxoUamjfP/NBzP86Pzdv/tk9F2YdHPl
	 l86rMpwyka21w9ww+7dp4HxCFgDVZC6sAvfqNe5ouHFAJGabme7Vbre1ILBG7P9p9K
	 zlcBbHkozeSaQ==
Date: Tue, 22 Sep 2026 16:06:22 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dairui Zhang <zhangdairui@gmail.com>
Cc: security@kernel.org, jgg@ziepe.ca, w@1wt.eu, stable@vger.kernel.org
Subject: Re: [PATCH] IB/mad: fix UAF and double-free in RMPP receive
 reassembly
Message-ID: <20260922130622.GH563127@unreal>
References: <20260921193238.1420558-1-zhangdairui@gmail.com>
 <20260922114719.1465335-1-zhangdairui@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922114719.1465335-1-zhangdairui@gmail.com>

On Tue, Sep 22, 2026 at 07:47:19PM +0800, Dairui Zhang wrote:
> mad_rmpp_recv.state is protected by two locks that do not exclude
> each other: recv_timeout_handler() (port workqueue) checks and sets
> RMPP_STATE_TIMEOUT under agent->lock, while continue_rmpp() (CQ
> softirq) checks and sets RMPP_STATE_COMPLETE under rmpp_recv->lock.
> Nothing serializes the check-then-set sequence.
> 
> If continue_rmpp() passes its state check while the timeout handler
> sets TIMEOUT and waits for the in-flight reference in
> destroy_rmpp_recv(), continue_rmpp() then sets COMPLETE and queues
> cleanup_work, after which the timeout handler frees rmpp_recv and
> the rmpp_wc. Ten seconds later recv_cleanup_handler() runs
> spin_lock/list_del/destroy on the freed rmpp_recv (UAF write,
> double free), and the already-freed done_wc is returned to
> ib_mad_complete_recv() and freed again (UAF read, double free).

Please ask from your AI tool to change this to be function ladder
instead of prose.

> 
> This is remotely triggerable: kernel RMPP reassembly serves the
> per-port sa_query agent (malicious or spoofed subnet manager;
> hi_tid routing is predictable and SLID/GID is spoofable on RoCE)

This requires being part of a trusted InfiniBand network segment, which
should not be the case in any real-world scenario.

> and user_mad agents registered via the legacy REG_AGENT ABI, where
> a remote RMPP DATA MAD on the request path starts reassembly with
> an attacker-chosen TID and no in-flight send required. On RoCE this
> is plain UDP/4791 with no authentication.
> 
> Unify state transitions under rmpp_recv->lock in
> recv_timeout_handler(), keeping list manipulation under agent->lock
> (which preserves the agent->lock -> rmpp_recv->lock ordering used
> by continue_rmpp()). State check/set in both paths is then
> serialized, so the loser of the race always observes the final
> state and bails out. recv_cleanup_handler() needs no change: with
> transitions serialized, a cleanup_work can only be pending after
> COMPLETE, in which case the timeout handler exits early.
> 
> The race is as old as the RMPP implementation itself.
> 
> Fixes: fa619a77046b ("[PATCH] IB: Add RMPP implementation")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
> ---
>  drivers/infiniband/core/mad_rmpp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Please clean up the commit message and send the patch to the linux-rdma
mailing list. We apply patches submitted there and do not accept any
non-public code.

Thanks
