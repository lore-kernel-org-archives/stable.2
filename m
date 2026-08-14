Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B493921F0;
	Fri, 14 Aug 2026 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671917; cv=none; b=LGjXhmcoMOwdkRmPMbMX3LBdJAqumKc59g/hJlhbjKSGQ2qXN1dS/mjC1188rM8GpcjTab/jGL/Kq/ucYULCTFW2kHQqG8SBMteaW9tdptZ9XN0zd7QkrHM4i+9JNTwGh2pK8kdQg4kor/gfWnpJFe1kx1Unwpb69FOB/Ahz1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671917; c=relaxed/simple;
	bh=GXFFhloCGbs4sqU/P9e8lS/6Y3PLaT9OPNhwuF8I84w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLBHlA7SrwZ7hM0QxzHnKpBJfqB9XvYudp5W5KfVgafNw+ErlOGg9LY9NGh7rFCaXJrjzFah1hqUIdvowAntnfJClVjfS2ylBbLBolRZsAIQivJbihoy6Hlpu7G9PCO07vol+Bu9UJ9IEkKAsJqdo4MC5ocuphjfcW/xozNLDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZaxolr9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZaxolr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF611F000E9;
	Fri, 14 Aug 2026 01:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786671916;
	bh=+aCQ7WwaNKEAJqECTzc95Y7IBc2HhIdscohPvyAgMlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aZaxolr91wSl57JifgnHMQado72Y24nMplmYnHNQzss5rwmQCrNCrC14V8BjXmhlc
	 1zE22Q8zHBG5KlmrKfiSjBY2HhJan7PPfxXXZ2I3oRW6tzLR23JoiB0d7ffYdlxH1v
	 xhjNYZhcVyHKeffB2vUQvAOkDKnMM9HPaAyon2TK5AmE7VlKrENBFQAIvz2Y4/UTl2
	 emkoLR4c/FERkJZeMRHPbAPPJj2jXhMfT27if0UlYPT0NNjTXTRpbeUOiT5a058MsD
	 UAFHS2v5JxOY/zxGz8/dt0voTFWOHUqPPh+26VMHw1DRMOLwDJHtcqKWIWWeOojhIF
	 XIB3R4+8n6ydw==
Date: Thu, 13 Aug 2026 18:45:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, netdev@vger.kernel.org, Zhan
 Xusheng <zhanxusheng@xiaomi.com>, stable@vger.kernel.org, vega@nebusec.ai,
 Victor Nogueira <victor@mojatatu.com>, David Ward <david.ward@ll.mit.edu>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net] net: sched: gred: fix 32-bit backlog wrap in
 gred_enqueue
Message-ID: <20260813184515.16a874d9@kernel.org>
In-Reply-To: <CAM0EoM=6zZVucSOUDi7pJiGhkoeTJ-PN9M18DnPWSpfH4GP6=A@mail.gmail.com>
References: <20260809091657.879929-1-jhs@mojatatu.com>
	<20260809094325.2069096-1-zhanxusheng@xiaomi.com>
	<CAM0EoM=6zZVucSOUDi7pJiGhkoeTJ-PN9M18DnPWSpfH4GP6=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Aug 2026 05:56:01 -0400 Jamal Hadi Salim wrote:
> > The gred check is the newer of the two: it came in with a3eb95f891d6,
> > the commit in your Fixes tag, while the bfifo one goes back to the
> > initial git import, so there is no useful Fixes: tag for it.
> >
> > bfifo also has more ways in than gred.  sch_red.c and sch_tbf.c install a
> > bfifo child through fifo_create_dflt() -> fifo_set_limit(), passing
> > ctl->limit and qopt->limit straight from userspace; tc_red_qopt.limit is
> > likewise documented as bytes.  Since this is heading to stable, fixing
> > gred alone leaves those paths unchanged.
> >  
> 
> I should have paid closer attention instead of focussing on the bug report.
> Since i already submitted, we can wait to see sashiko says - if
> requires an update i can include the others; otherwise it will have to
> be a followup patch.

I _think_ the Medium severity issue Clashiko called pre-existing is
in fact a corner case missed by the fix? Please shout if you disagree..
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809091657.879929-1-jhs@mojatatu.com
-- 
pw-bot: cr
