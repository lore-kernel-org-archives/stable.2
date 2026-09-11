Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976963D9525;
	Fri, 11 Sep 2026 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168742; cv=none; b=ExPQhgwfVlQblCjL2IighRrqrjMkLNYgbDLKRGiUcXecVQANAmKglfYTmOADLx675Hy0/cEd5ZTtNv4GHdH0dBaZiP/oWi1vSn3oEUWpqnJ5VfM+GMQoIyLCYsnC37k3AzhB2vFMNQI+ihtvhgEI3Rw+EorEkvJkJBdSxrHEoEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168742; c=relaxed/simple;
	bh=QwScFegLsxIqF0iKbcJ7rF0B0bePh6ihsm6rx6RXbV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgL4zB9Wk6NkYOfqiTGA//pFpJBeLj62X7f1tlD3aJTMP/ZmMDXgDHW+mzYq/r2I6H6c8ilXfx/w3xnkyFBqOo158nT6wC9vCmpGK8fchutQXENTPP7jnbRryqBqt8VTNTL16Y5q7UxnBBQPPo7VR2x5+eI6PEfsD3zYDvAiyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evFPWynS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evFPWynS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0401F000FF;
	Fri, 11 Sep 2026 23:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789168741;
	bh=x0F8Cq4vE2ipjbE7OGMrkuxINuJJZQrLVw1+hTkEp0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=evFPWynSSw5Is0fBSkwCJx0Ix5VJo0fxamZD6YBWtSpmjc3+95t6dBcEHw/eUtwSv
	 9I285kJ/AzqsFWRoxDq/4GHrNZ23lJNxsV0ick0JWMJeDGPVdzjIuFjZbFm8zEwJob
	 EW0BUNUgi3ckInNT+Dg6JNg/8YU//H892SJu5bQcrYlRhBBmGDwWy2pfd1k+Je5fn4
	 Ur/WPeJK3I/RE4GCFExHmFGQR6BokxSnCVe/vLyqHYOWr47h270R7Tj6LTkrQRZCSm
	 80lG1phvPwVtvSZKnJV3jIBQQUZnc3EClkNfk7qhYc9HM+Qn08f23Y8BHqr5iITkKk
	 7D4Ay7SszaJIQ==
Date: Fri, 11 Sep 2026 16:18:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, Vega
 <vega@nebusec.ai>
Subject: Re: [PATCH net 1/2] net/sched: codel: bound the dropping loop per
 dequeue call
Message-ID: <20260911161859.793ed689@kernel.org>
In-Reply-To: <CAM0EoMkzo3s7QTLm=w4RkyAbKat3iVZ89dPtPeQoFRvqigs_4Q@mail.gmail.com>
References: <QDISC-1L5H.v1.20260903184552@mojatatu.com>
	<CANn89iKFVvFaNcZyGOxmyPbpc6ax49ZqwMWDeBAsH5dav-y-SA@mail.gmail.com>
	<CAM0EoMn5M__WHkniZLw8GNtHpTresTC2dQuL6brmAzUXH1YUKw@mail.gmail.com>
	<CAM0EoMkzo3s7QTLm=w4RkyAbKat3iVZ89dPtPeQoFRvqigs_4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 19:12:28 -0400 Jamal Hadi Salim wrote:
> > > SGTM, note that this line breaks RCT.
> > >  
> >
> > Grrr.. it was in my brain to fix it, but my fingers didnt get the command ;->
> > If needed, I will send a v2.  
> 
> Should i resend this? sashiko-nipa never reviewed and other one found no issues.

Yes, let's get a repost, I'm losing track of all the outages..
This is getting a bit old for SUIE to track tho, so repost is better.
