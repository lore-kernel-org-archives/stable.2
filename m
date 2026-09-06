Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15939060B;
	Sun,  6 Sep 2026 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788698664; cv=none; b=Mc6UOD5OYvDIlb8Aa5zazBQgcDfttWQqsaz0Rgi14rfIAQFCqGcSSO9p3+Es30MW9Mc3Kl/ZExHCnvaXwR6RckqZYR2WXi5OefM0xNE7JxQJRBhosF5BuEFEXVIy54E0UgeEzCz808Qvu8bUyuuuzAm/3TmKt14kiltvaun9r0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788698664; c=relaxed/simple;
	bh=5Y93s/HJbpEPs/aw4WKDgIPyeY2bANXzBY4CJWfQvQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyVCNEMUtEzI3wkHBAJ7wy0hHLgAQ/ZgLOjYh4qh1uj1PSuT4eInZVXT2Y/46yaI+Is6thCNDMom7GWMEccKapU3KK03t7H+bqPkuJTiA5Fjp1OPZN0Ivb5FbokBGWj1LDg3sVyAFjTw1lCvHMOy+V/0QXzkqfis6SHZXT6NH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m069aXCa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m069aXCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641C81F00A3A;
	Sun,  6 Sep 2026 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788698663;
	bh=kdJchHujIqlY4ASX/PdT49wmnGXAhAsntDvHZ9XWfLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m069aXCaPj79nPGPY6KzL1d1HyIuAivYQc0mRNex9dlpARTHBWsxWyxdgXK/ISPE7
	 DMb+zuI9QHTyxJfuKM8ImtgVbN0IraADEI6h3ebt1jc5sV+wm1cmFiCIgWnD/Fpsww
	 FTqDkmg/yfOQKU513Go2w/ND0DuNqo7A163wsMoWoI8Nr4RUDSPFyHbYt0W0mNSGcp
	 7kfrlwqQkQHQeDv3RYC80biRceOEc/Su2L/XbO/9yfjPb6UFUPAS8BExCMVQxYwHkd
	 JQv1SEKYTdteXwTv0ssiXZL8ejHdiWvzsAhkStLZUTUTrFjNTxBvTxETqXUN+ZeU+a
	 jNnH+itQZar3g==
Date: Sun, 6 Sep 2026 13:44:19 +0100
From: Simon Horman <horms@kernel.org>
To: zihanx@nebusec.ai
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kees@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net v7 1/1] llc: fix listener child socket leaks before
 passive open completes
Message-ID: <20260906124419.GI40544@horms.kernel.org>
References: <0b8964c9cd294898c9657fd34c9d04cec77782eb.1788414881.git.zihanx@nebusec.ai>
 <20260906101149.215761-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906101149.215761-1-horms@kernel.org>

On Sun, Sep 06, 2026 at 11:11:49AM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/#/patchset/0b8964c9cd294898c9657fd34c9d04cec77782eb.1788414881.git.zihanx@nebusec.ai?part=1

Sorry, I've made mistake here.

I think the issue flagged below is actually out of scope wrt the
progress of your patch.

What I meant to forward was a separate AI-generated review at
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0b8964c9cd294898c9657fd34c9d04cec77782eb.1788414881.git.zihanx%40nebusec.ai

I will do so in a separate email.

> ---
> llc: fix listener child socket leaks before passive open completes
> 
> This patch addresses a child socket leak in the LLC subsystem during passive
> opens. It ensures that children are only created for SABME commands, avoiding
> leaks caused by non-SABME frames that never complete the connection. It also
> improves teardown and lifecycle management for incoming child sockets.
> 
> > diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> > index 260460d50f54c..092625e28b3bb 100644
> > --- a/net/llc/llc_conn.c
> > +++ b/net/llc/llc_conn.c
> > @@ -88,6 +89,13 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
> >  		 * skb->sk pointing to the newly created struct sock in
> >  		 * llc_conn_handler. -acme
> >  		 */
> > +		if (sk != skb->sk &&
> > +		    atomic_read(&llc_sk(skb->sk)->incoming_state) ==
> > +		    LLC_INCOMING_PENDING) {
> > +			sock_hold(skb->sk);
> > +			atomic_set(&llc_sk(skb->sk)->incoming_state,
> > +				   LLC_INCOMING_QUEUED);
> > +		}
> >  		skb_get(skb);
> >  		skb_queue_tail(&sk->sk_receive_queue, skb);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is it possible for an attacker
> to exhaust kernel memory (OOM) via unbounded SABME flooding?
> 
> Looking at llc_conn_state_process(), the new connection skb is queued directly
> to the listener's sk_receive_queue without checking if the accept queue is
> full (for example, by checking sk_acceptq_is_full(sk)).
> 
> Because llc_conn_handler() allocates a new child socket for each SABME packet,
> could a flood of spoofed SABME frames from the local subnet cause this queue
> to grow without bound?
