Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01402347BBD;
	Mon,  1 Jun 2026 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297097; cv=none; b=lJTQXp2TCx+lN4oIOycMjm9pYk56oJKpfAolGPlN/KyowTjUqeG7cYg8+r7+IY4ugrvpA7czS4Q4ZnY2b6fFDPP4UhW7BzvNm+8DCFqqiczAKhyLJ5NUhkYhaus5yEjFE3xtmYCHef8hFg9/uhiO3RsLpq/PsDa7szCL5MXXONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297097; c=relaxed/simple;
	bh=yJy0CmnIxJjAFp2xvW0lH2ZU1wwcYRyC/5qf0dtOaLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8eGHmq90KuXCMkVCPnC91orW5yYk59xMWW9Rr/kCDeX9RacMUe/Co1j+uScU1ja/FTJgzIrVmjzMIpepIK6GNuVUdlZixrOP5juEBSxOloGK66Uqinn1y9oNHChXuALaHQzrvmYlzRJzVEC2ck6w6fWGC1UHp5b3b+TNToDcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zORcKruJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0FcOzPlV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zORcKruJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0FcOzPlV"
Date: Mon, 1 Jun 2026 08:58:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780297094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJy0CmnIxJjAFp2xvW0lH2ZU1wwcYRyC/5qf0dtOaLU=;
	b=zORcKruJ9QJOtW4JL1Pm23rr8Nn7859O839uqpFCiRaLhnVpt3vH5A45v3oD0GwU5zEKFp
	5KoiJpX7ERkDuyC63RVc863tn+FhxNrbtSYDFuc9XRyXQKe098LP/duwnZ6B+DMlsG+va6
	gBMoGhERg8d+Qryv1wRUdCzFR/nyy6IWl7NJxOE3QEiINHdZOIDw93MtX4O/A0Tg2Zl+Ot
	VMBejWMXFzpGnedfK2hJIGqYdCc5QQYg+xqIBqUXRnN3N8J2NkblzOca2Dhpg2ox4QKjDM
	vZpyeqt2EeCZ++90Cu00ZypywIJUdXYBZVkgN7cYdaIuJqTu3S3KeSTLp8qWZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780297094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJy0CmnIxJjAFp2xvW0lH2ZU1wwcYRyC/5qf0dtOaLU=;
	b=0FcOzPlVIato7qS/odBjpYZVeForAreWqj7U1P+j8gvuU5FR/47koS4F5+qJ3QtgejkaMS
	lLIMMvRIEAawgHAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Hannes Reinecke <hare@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 09/10] mptcp: pm: avoid sleeping while holding
 rcu_read_lock
Message-ID: <20260601065813.Z8V8Tb6d@linutronix.de>
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
 <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-9-a5ae7791754b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-9-a5ae7791754b@kernel.org>

On 2026-06-01 13:10:05 [+1000], Matthieu Baerts (NGI0) wrote:
> sk_stop_timer_sync() calls del_timer_sync(), which spin-waits for the
There is no del_timer_sync()

> timer callback to complete on non-RT kernels. But on PREEMPT_RT, it can
> sleep. Sleeping inside an RCU read-side critical section might trigger a
> lockdep splat.

It can not sleep. timer_delete_sync() does not sleep. It can block on
spinlock_t and schedule but this is okay within a RCU read section.

Do you have a report for this?

Sebastian
