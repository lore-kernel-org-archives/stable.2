Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C23F5BF4;
	Mon, 15 Jun 2026 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531785; cv=none; b=O3yHFLFg+iwflERb3C+1+tnvnqzxujdpiVWasizE4ohtqljytzQgCePYbLpKjupw/mG/gnLvL4aRniQffJC5CD41cJkFLW6vw1nFkUbbLpoPUWKSMjMWjThGwv3FFQAWybUfjTIe9X+ugfjq6oxTH0cHpBgK3pBBeJOJtOhrRKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531785; c=relaxed/simple;
	bh=uj9NIq8r6WHz4ZTjCa33qlmfA1jc7S0pc1oPXLJuNzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz17OuxcrFBuIqwHsndoLIQpI/p74DIS2Q+dEeMP8ZFOAghIbBwl7JaYddSBS475Ffhb1pgRrJqg0mt3EWbU+AInL8OnYoLUR7RCZ/DP0O5sxP1CbMGIUBBT8NkysFBxAVj5NW5w2SdcR6dfvh2uxxZZyddC8VODa1LxVM33KIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qLnT0th8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hM8SaYOe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qLnT0th8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hM8SaYOe"
Date: Mon, 15 Jun 2026 15:56:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781531781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e96uEW7VnIfxNbDAhgYihyxwjM7qS3eYcktQktJk91w=;
	b=qLnT0th8ZvivaM9IVX4c3c6rEKp099DljMxaL5zB+6BGVll0uowsKMm3cvGBeMFpF8e8TW
	9p7s1YYOhKkJYqCIUGK+CU99h1ZV8lUmi6uOIBBLd9+F7T20lniE4s8n9Tan6hWsoI12Ew
	45vI45HqMvX1Drpe7sPwX1O8zuAuL9+5J8wAOwGIiGrcQFT3+S0iUdLwH0W4V7Mru9Mxy5
	GB93WE+AGRUkjO6l37LNW1dzDO6FlFdVt4Xc7UhIQh14UY23CraEfm5SiNxMR/lX2TTwx6
	///DNFOueB2yp4YUB6DU0ibeFdSExlxBplH19Vi9DqUxQPvOZTUbdJsQSFKpcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781531781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e96uEW7VnIfxNbDAhgYihyxwjM7qS3eYcktQktJk91w=;
	b=hM8SaYOeGyjsPp+DDUpdAj+mrdow+RUOknwn0oMVTBwATF3HCslWhHIw2p+v539Pm0Qte5
	U7qMCRx/ShwK2lDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vlad Poenaru <vlad.wing@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <20260615135619.OB8FjsCH@linutronix.de>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
 <20260611191114.5bc43a59@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260611191114.5bc43a59@kernel.org>

On 2026-06-11 19:11:14 [-0700], Jakub Kicinski wrote:
> Please trim the pages of slop in the commit message and the comments.
>=20
> On Wed, 10 Jun 2026 11:36:21 -0700 Vlad Poenaru wrote:
> > @@ -194,11 +194,56 @@ void netpoll_poll_dev(struct net_device *dev)
> > +	local_bh_disable();
> > + 	poll_napi(dev);
> > +	_local_bh_enable();
>=20
> tglx, Sebastian, are you okay with using _local_bh_enable() to trick
> softirq into not waking ksoftirqd? The problematic path is:

The I planned to get to this today but I won't make it. I try to get to
this as soon I can=E2=80=A6

Sebastian
