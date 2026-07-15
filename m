Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2928947DFBE;
	Wed, 15 Jul 2026 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784143992; cv=none; b=OSIpvqernGpCg5zHSx9LuJ59i5kOKpxGyr9m0RdApYlEZflsmNNbqNp5I2PkwOZsUNFvR/elUMtoiPBh5ntJHtg7n5xpQ0auhnAPC5Z2R5/CkSDVnxVNdSVZPtC9PQhV29PWWJfFlzIyf9rWHgn8M5JMDIOFBgVbSBMpl1S/4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784143992; c=relaxed/simple;
	bh=x+PjhVZXUzIFJVgkJzyIjZ0tdVKcwikIG+h59fqDvHI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AAkzy0wMNmcCwyDjSkLqJJ3Ag1D0AVaidpgbMrIsl5JNRmVbrkQ0SdHUyTgLZElbJ6eqAHa8JuztiP5bb01/g56f+L7ObSypG+S9b7CU67CQMO5NhFB28faG8XHheYKxW+klkL65d8B4CeusShQ7kv3wXrQSFMqKlzqJf9oAlYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vZzmcAqU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vZzmcAqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F811F000E9;
	Wed, 15 Jul 2026 19:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784143990;
	bh=JNgTwmxam6nd7h0Quf1kWnjF2oRJDHmqN2SP0HCpJIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=vZzmcAqUuhtTtgFOjBIROzyqMPic/9fHZY9lG8sX3dgSEhWI514lr8ha1A4xwlnNG
	 gwVsibhPJdVEtCLMn80evGYjHGZ5pnPIB+ze1PfbqqSW+FUg2agz49fq0UAjqARp8d
	 stOqxqz85f+2UBHAhV7g1jtwOpuJQ1VtBmZan1cU=
Date: Wed, 15 Jul 2026 12:33:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, Harry
 Yoo <harry@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH 0/2] mm/page_alloc: fixes for free_pages_nolock() on
 RT/UP
Message-Id: <20260715123309.621edcb4b5ed72499d31ec9a@linux-foundation.org>
In-Reply-To: <20260715-alloc-nolock-fixes-v1-0-fadc49952dda@google.com>
References: <20260715-alloc-nolock-fixes-v1-0-fadc49952dda@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 09:03:57 +0000 Brendan Jackman <jackmanb@google.com> wrote:

> First patch was originally part of a different series but Andrew asked
> for it to be separate:
> https://lore.kernel.org/all/20260710170311.e22bfd21c658e8357ceddeec@linux-foundation.org/
> 
> Pre-existing bugs found by Sashiko during review of this other series:
> https://lore.kernel.org/all/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com/
> 
> I have not reproduced these bugs, and I suspect there is no real-world
> user that is affected by them.

Right, thanks.  I'll stage these for the next merge window - no need to
rush these fixes into mainline.

And I staged them ahead of your "mm/page_alloc: rename FPI_TRYLOCK ->
FPI_NOLOCK", to lessen backporting hassles.

