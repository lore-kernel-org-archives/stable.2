Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451835;
	b=W+f2eHMkPU3nRUNXekNsSarNi1h+7fhhwfbc/AUqB28pC/h+NwhEvmfz1uaPEuqLuv1U
	 Fquhc0t3XD0j/kb8aXaZauR5EABq/bDasAY+XzS98xiRRfZgJZqj1E3OMaqr9I+pYfodm
	 GhCkTDqs4QmTWwhJGMNTNdIye86Fs0CLkt+VGu88MfvmnsZ0I+wEHSKbayQaS704q1D6B
	 OTC03GWpIXamesu43jvFQ3Wt2tAnvvyyA/Gj6R6Zq9bP6GYkVLUrv+SIWvyyTJvDJkLqw
	 nndVpFyY270oRYfq1WjazbD7gplc52Y6Lyxy6AaRTmomOd2ikwl/vCRPMez7tsXdzZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451835;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=maHRWreeb2G3YvT5kykQ/D3QqVJ5ukp4L45ZlwGXvs8=;
	b=yggeLxL8SRd6HsyQeQKizuq+iocXL30yB+1ZV2EFsPMpunMSv5m7a2Wtvp5w6KCE1RcV
	 dAV/YQtepLOUYnZlSIskXqRZ63SM4WYJpsuPV0ADrQmnOZdjtSAOs6F9c5kIeF9LhK1EQ
	 am2ugwqha4uoku3agsQLrwx31CUqmQ18cr7f+YtGGMgNRBZ/H8LJO0l+rfG4zvVzBL6kl
	 GESYy2umNeVdq4SoVi1KaGR3MA2NQPOCDg+aFvvT9f+hP23/xWjcqdC2ZeI6BVRnlL/OY
	 p+84ShiScrxa1xMkEzrjmYRwYnJ0J90YfV74GD6FOGxBdWnBq7CyyNCmFUv+sdAlnkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=rKvgCkeF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F0606A332;
	Thu, 12 Nov 2026 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=rKvgCkeF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588EF1F00A08;
	Thu, 12 Nov 2026 02:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794451835;
	bh=maHRWreeb2G3YvT5kykQ/D3QqVJ5ukp4L45ZlwGXvs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=rKvgCkeFyP/AtoPWnaPDas/2Aky7LOPJG73HO5N8j9JBljhGUctT2/GnAu3coNHoj
	 HwnL/C1/pqXAGUuGjcIAB5xNF1SL8O7n3N+dG+oWBNe8P/4ZsYPRIBJ3PAcBaTKMds
	 V8DyKKgm7OukZgP+gQpiu3VyZTFEQHrMWUiiXb4g=
Date: Wed, 11 Nov 2026 18:50:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, workflows@vger.kernel.org,
 ksummit@lists.linux.dev, Bradley Morgan <brads@mainlining.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Mark
 Brown <broonie@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Leon Romanovsky <leon@kernel.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Thorsten Leemhuis
 <linux@leemhuis.info>, "Michael S. Tsirkin" <mst@redhat.com>, Kees Cook
 <kees@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dan Carpenter
 <error27@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, SJ
 Park <sj@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v5 3/6] agents: add a skill to determine stable tags
Message-Id: <20261111185033.694802885eb0934ed7452d6a@linux-foundation.org>
In-Reply-To: <avUlMcKIeJgmCg5J@laps>
References: <20261111225940.1573565-1-tytso@mit.edu>
	<20261111225940.1573565-4-tytso@mit.edu>
	<20261111171055.527b4bf3da705367bc78a64c@linux-foundation.org>
	<avUlMcKIeJgmCg5J@laps>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 21:32:17 -0500 Sasha Levin <sashal@kernel.org> wrote:

> On Wed, Nov 11, 2026 at 05:10:55PM -0800, Andrew Morton wrote:
> >Marco had some thoughts on this just today:
> >
> >https://lore.kernel.org/CANpmjNMvM_TCs7Fao9+gM-NNpQyBKYumSuWOt_03ZX+tLwbjWw@mail.gmail.com
> 
> This makes a lot of sense.
> 
> >And Documentation/process/stable-kernel-rules.rst does ask for real
> >things, not theoretical stuff.
> 
> We've actually dropped[1] the "theoretical" part.
> 
> The problem we were seeing is that bots were sending real fixes, with a solid
> changelog, but not adding the stable@ tag.
> 
> Apparently our wording is pretty strong: unless you can prove that the issue is
> real, it remains theoretical. You'd have to either show a real case where you
> hit the bug, or to have reproduced the issue and can provide a way for us to
> reproduce it.
> 
> Most bots can't actually do that for technical reasons, even if the bug is 100%
> affecting our users, so they don't add the stable@ tag.

OK, I can see that's a problem.  The theoretical userspace-effects
statement will help here.

> >Also, I would keenly like to see changelogs clearly explain *why* a
> >backport is proposed.  As I have said 1000 times, "when fixing a bug
> >please clearly describe the userspace-visible runtime effects of that
> >bug".  Can we pleeeeeeeeeeze get this requirement clearly enshrined in
> >this patcset somewhere where the LLMs will read it and comply?  It's
> >really simple for the LLMs to cook up a paragraph for this, if so
> >directed.
> 
> This is a great point, and would make our lives much easier too.

Oh bless you, yes!

> It sounds a lot like something that humans would benefit from hearing as well?

Humans don't read stuff ;) But it would give me something to ask them to go
look at.  And to make their LLM go look at.


I picture some poor downstream person looking at a screenful of AI
babble wondering "should I add this to our kernel and if so why".  We
should tell them!

otoh, downstream people have AI too, so they can do what I do 5-10
times per day:

describe the worst-case userspace-visible runtime effects of this bug
<paste>

> If so, I can send a patch tomorrow to add it to
> Documentation/process/submitting-patches.rst and refer to it explicitly in the
> agents file?

We can't restate this too often IMO.  It's maddening.  So many
changelogs follow this form:

- here's what the code does
- here's why that's wrong
- here's what I did

So I sit there staring at this thinking "OK, but why should I care?".

Also, what's wrong with today :)

