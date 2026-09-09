Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A213F581259;
	Wed,  9 Sep 2026 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969823; cv=none; b=nvFOyVRQvPG/00l9FVCPtKS1dmQfFyPn2hszUyFS4+ditPI/zcs+Xx9fk2sBrIj2ek9IExMDoeVEL5GLEWeYXEO77EeFLZXAtW7UutYx/0vP798DQN2NcjyLfzZT4Jx2PI6qGMZCuqe9enMc/Vyg4n2dGe5S1fiRLItuOE/5QoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969823; c=relaxed/simple;
	bh=kqM0IvWejEsjkX/KEwGnC2hfDsqWJl40BznTC+IWdIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nhOveetRpnFYspziRuJ1/U4VKbTBS+3GzZqWhOqqS67vDuBATZeBgVs235j5v3o7S+/XrmGJ07ZnYsjWqnzE7NCm0gapeoDPQnddAUrHm8PJJ0lkAJsjQRAzGKZFw0TVX+P2vySwN8U+e9HGJA4pbdXiNs3d6rL2ZGRD+FPXMDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDJoU9pC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDJoU9pC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E251F00A3A;
	Wed,  9 Sep 2026 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969822;
	bh=jiO53o/6b3A1fYKNO9P3aBULiE+yfbNyJZmlnemTsa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gDJoU9pC8tnzB5e12/nL5alSSmsnQh3ixgRlRWLKK4nFu8DAxxzx9gXYVpP6WI0uI
	 5CCqMOQHMl40+wwV3yNFdtID29F4euKjMLlkbx1prStNPsQ1/lvQeoUNpNx4IB6nO1
	 bGGoAEXcWqJzXJR/otBky4Lq0OKNHCCmGcGLLEjzBBsGwPF1nrunvMlxyIpYbHDprz
	 O2kmFDblfvyXVBy8yix8wgvyLCsfWbY56tVRB9m3EFJOcpqbpMaRgYtnyXKz8Civ1O
	 d0bicyG6dPdmVtclb8cdnrvgsij4oO9RMa52sf1BN8VyzdbGrNlovX+XYtX5VA0otS
	 Bv/TzQtO3gjsg==
From: Thomas Gleixner <tglx@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] hrtimer: Use hard expiry when updating timers on the
 same base
In-Reply-To: <20260909102749.7677-1-parri.andrea@gmail.com>
References: <20260909102749.7677-1-parri.andrea@gmail.com>
Date: Wed, 09 Sep 2026 18:03:38 +0200
Message-ID: <87v78eza1x.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 09 2026 at 12:27, Andrea Parri wrote:
> @@ -1263,13 +1263,16 @@ remove_and_enqueue_same_base(struct hrtimer *timer, struct hrtimer_clock_base *b
>  {
>  	bool was_first = false;
>  
> +	/* Set the new expiry time */
> +	hrtimer_set_expires_range_ns(timer, expires, delta_ns);
> +	expires = hrtimer_get_expires(timer);

My knee jerk reaction when reading this the first time was something
non-printable because the obvious rule is that you can't change the sort
key of a tree entry when that can make the tree inconsistent.

As the base lock is held and nothing can observe the potentially
resulting inconsistency at that point and the timer either stays in
place or is dequeued, this is safe, but non obvious.

So this really wants to have a big fat comment explaining why this is
safe to do.

Thanks,

        tglx
