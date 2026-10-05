Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8013DD87B;
	Mon,  5 Oct 2026 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234203; cv=none; b=Fw0eAahwoPIJnJq5iAa7d4KC6l3Wk+4pUOwK72GkB5o6emSr/gzENWlcwdxz1EHbVPZFbHF6AeqxIvA5LKs157a+hRBPbe7yJzMAWkB0eEccLjFWCF6CQ1l7U3H9lhywkQ+pFLVO7VqrQ+E78uCXHeU2WKXO3QNsk6HY8hCuyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234203; c=relaxed/simple;
	bh=aVX6Ao29QGAf3mitZkGZkzKlwKGwrMO8++0iOj1DtyM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G1vTKKaE9Tot6y/XRFuEf83o3GqlRcp1AJyo9IsrQXFe6nvo6X0bo+kXgQTpec+DsYPGx94eEUn42oD1qWhiXRS35IbQyPfkqPSrYcG7BAOTSAs38xAIZ7SrfoRaquKhhln/jS4OPJHJKCMQCPAFdqfRj1SU7IBiNOWuuvNrJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpnjAp0k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpnjAp0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149901F00893;
	Mon,  5 Oct 2026 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234202;
	bh=cK7MK+kzcK8gWwXWnBrCk7CQu8mValjttqE5AbyN8Co=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HpnjAp0krZaHmORh3OkprUKk+ci7J50Wc6YkshN9+R3QR/Sts930MdL3bh3Dr9GNb
	 sJSTuSgOPqLnmaFxLmfiBxvCiFZndFWZkpcOlmwVJVcSQnxmcLqcQjIqtF7PgI5bZZ
	 nLtavcU78dnycQLRSqjxkEjkH/UwNlexFwQczJRa1oWTQpM72ijWNkPRULi34IbX7L
	 2ZzJRJ/GgrR82a+S2OFTDjKrDZ7XFeTrobcvXgzTDMNO4plg0RPZ6b4ayjmGjbKus6
	 tMaDj4S91mLCHkHNoVjxvPN8dv9EVEXLFp0mPiIyLBjK0aPN+5Q0dPEf6QmqD6CYiu
	 1WZqUD2T7xw4Q==
Subject: Re: [PATCH v2 2/2] tipc: fix use-after-free in netns teardown
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: tung.quang.nguyen@est.tech, jmaloy@redhat.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Mon, 05 Oct 2026 21:03:21 +0000
Message-ID: <179123420166.434549.12436565517014196849@kernel.org>
In-Reply-To: <20261004210016.3051310-3-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261004210016.3051310-3-Jeremy.Jean@oss.cyber.gouv.fr>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] After this patch, `struct tipc_topsrv::idr_in_use` is dead state.

--

tipc: fix use-after-free in netns teardown

This patch stops the listener and cancels the accept work before
tipc_topsrv_stop() walks conn_idr. The walk now goes forward with
idr_get_next_ul() and uses kref_get_unless_zero(), so it no longer takes
a reference on a connection whose count has already reached zero.
Connections are disconnected before the workqueues are drained.

> diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
> index 01dd34b758f4b..f3f32fd8134ac 100644
> --- a/net/tipc/topsrv.c
> +++ b/net/tipc/topsrv.c

[ ... ]

>  	spin_lock_bh(&srv->idr_lock);
> -	for (id = 0; srv->idr_in_use; id++) {
> -		con = idr_find(&srv->conn_idr, id);
> +	for (id = 0; (con = idr_get_next_ul(&srv->conn_idr, &id)); id++) {

[Severity: Low]
This isn't a bug, but this loop condition was the only place that read
srv->idr_in_use. Is the field still needed after this change?

It is still declared and documented in struct tipc_topsrv:

 * @idr_in_use: amount of allocated identifier entry
 ...
	int idr_in_use;

It is also still written under idr_lock. It is set to 0 in
tipc_topsrv_start(), incremented in tipc_conn_alloc() and decremented in
tipc_conn_kref_release():

	s->idr_in_use++;
	...
	s->idr_in_use--;

Nothing reads it now.

I checked whether dropping the old termination condition removes a
guarantee that all connections are gone before kfree(srv), and it does
not appear to.

tipc_conn_close() unsubscribes synchronously via tipc_conn_delete_sub()
->tipc_sub_unsubscribe() before it drops its reference. That
unsubscribe serializes on sc->lock and calls timer_delete_sync(). The
get/put pairs in tipc_conn_data_ready() and tipc_conn_write_space() are
bounded by sk_callback_lock. The remaining final puts run from
rcv_wq/send_wq, and tipc_topsrv_work_stop() drains those.

The old loop also held idr_lock while stepping over empty ids, so it
could not act as a wait-for-empty barrier anyway.

Could the field and its kernel-doc entry be removed in this patch? If
it is kept, could the commit message say that the old idr_in_use
termination condition was dropped on purpose?

> +		if (!kref_get_unless_zero(&con->kref))
> +			con = NULL;
> +		spin_unlock_bh(&srv->idr_lock);
>  		if (con) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004210016.3051310-1-Jeremy.Jean%40oss.cyber.gouv.fr
