Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7B306741
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079554; cv=none; b=Y3qN4qXtAdYIKt9S9Bj2YlXyk5y/6/N11hgGsdUyaKAwuAOU7WGM7edfU9NO9dB3/iKIw+JBXp60aiaBtaV7DAOe45I6MGRxd7aL1NgXY45W/pnzUT2B7CkNP5B1aD8lNuNQIeJP9ierJT2DmPWsiEX50S6YsyhWfBhAevCsckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079554; c=relaxed/simple;
	bh=VDzZW1SLo0LrhXrL1Prox9UoPkJ//vMG8wvbduzxQ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4hxz/bB7n1RqUXodnZM4S/9Xv0hQkHCHxJYZ7yxTcZnS2cjTwMJekMfanahVK09GFSsYtZlDllRwtkjIPwguqDq6z6f9ChvazFYpmiCm/FePZ/G6Kk+fcIB534iY0Y3Oq+qdC/cFiuIHCeYvTYiRoDpkJfBX+kvdqniFSlvalg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gW3tTTD7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gW3tTTD7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C425C1F000FF;
	Thu, 10 Sep 2026 22:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789079553;
	bh=AvaXwx2LcNRb7aleMdEJjUSF+MigurOCyRurKBuzJ8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gW3tTTD7xAgWUf3poPvahx39VxXOsCnnGGymP4z3rdxXzvuHYr1cd/ysJqDKY0Ify
	 +o8/qUIVV8jS2UCrfSlgH+afQbeZESOlvsfFghCqyN4bkflGgKnYBYHud3oV5UL5FN
	 EN5m5fbSzbDWj2Pok4JIErgF4Rq79ZLXZ7ypSpvAVjORdUFxlrvJYhzvanVG9kjK+r
	 IzFD//vk/zxWs/CkWESmhXx7CFOI8D9gmd4yk586iIBk85SjBZJe5u+xJ/K8fobfIT
	 zp1aVZT7PqMwuno+sf6IX6zCcdFvzAYbKDYWJNXLBa3ZYHIMfOBhsDFGWoKZcYbjnp
	 uHxrFEW7vgYhA==
Date: Thu, 10 Sep 2026 16:32:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: linux-nvme@lists.infradead.org, Greg KH <greg@kroah.com>,
	security@kernel.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix a hang on queue teardown with data digest
Message-ID: <aqMv_5u8KclzrGym@kbusch-mbp>
References: <20260901014718.2835558-1-kumar.shivam43666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901014718.2835558-1-kumar.shivam43666@gmail.com>

On Mon, Aug 31, 2026 at 09:47:18PM -0400, Shivam Kumar wrote:
> With data digest on, a command that has received all its data waits for
> the digest in NVMET_TCP_RECV_DDGST. has_data_in() is already false there,
> so need_data_in() is too, and nvmet_tcp_uninit_data_in_cmds() skips it on
> teardown even though it still holds the nvmet_req_init() reference. The SQ
> percpu_ref never drains, nvmet_sq_destroy() blocks forever in
> wait_for_completion(), and the nvmet-wq release worker is stuck.
> 
> An unauthenticated host on an allow_any_host subsystem hits this by
> negotiating data digest, sending a write's data but not the trailing
> digest, and closing the connection. Each leaked command wedges a release
> worker; a few stall queue teardown entirely, and with hung_task_panic the
> box goes down.
> 
> Drop the reference for a command left in RECV_DDGST from
> nvmet_tcp_release_queue_work(), before rcv_state is cleared. A command
> that failed nvmet_req_init() never took one, so skip it.

"I have made this letter longer than usual because I lack the time to
make it shorter." - Blaise Pascal

Take some time to actually write your own (and hopefully more concise)
message to demonstrate you understand what you're changing. AI messages
are overly verbose.

> +	/*
> +	 * A command that has received all of its data and is only waiting
> +	 * for the data digest sits in RECV_DDGST: need_data_in() is already
> +	 * false, so nvmet_tcp_uninit_data_in_cmds() below skips it, yet it
> +	 * still holds the reference from nvmet_req_init(). Drop it here,
> +	 * while rcv_state still reflects it, so the SQ percpu_ref can drain
> +	 * and nvmet_sq_destroy() can complete. INIT_FAILED took no ref.
> +	 */

Same here.

> +	if (queue->rcv_state == NVMET_TCP_RECV_DDGST && queue->cmd &&
> +	    !(queue->cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +		nvmet_req_uninit(&queue->cmd->req);

I don't think this criteria is even correct. RECV_DDGST doesn't mean the
command has all its data since that state is per-PDU.
nvmet_tcp_try_recv_data() enters that state at every H2C boundary, not
just the last one.
