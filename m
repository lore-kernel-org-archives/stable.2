Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353F27FD74;
	Wed,  3 Jun 2026 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511023; cv=none; b=kJMf6RRpYj6dxHBRhFhqlCRC+M7dZzBoMaAXZ5AmKIE7kP/BmMymIKQOYUwCZONu7Z13jGSEajdqBktLC5NOdrOcDaj6Q/vgiXr5ZDrVLBqQDVYCL9v1CCeeHdeLK95KnoPbhQgCcAwW/PV//o58ZncYJweXc6qz2copLoS0S4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511023; c=relaxed/simple;
	bh=M1YowgIYjAh0hzgnKhmU6Mu62pO822F6M+nhazDmeAw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ow1kr2+N7XYZPaccgS2XpMF0EVJNMzm/Fj73BfU0hOJcfLctUC48N0gIiZ3b2+Z8k8uc92LcsdhQUH1Hce+zzzal6K/Huo9AGB2qbfCIWs3WJdti511nyoj1JczHTc/vWP6nDwVsc1YoDfRomWB4kEInmMWluY2gSgSh5oUYgbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EHqJlmRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EHqJlmRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C971F00893;
	Wed,  3 Jun 2026 18:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780511022;
	bh=XaS4Z/cDlFhn664QfkkC4ehdFJgpU2L+6N9wuaksiC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EHqJlmRxS9TnC0oeUTgnlP4CIOiUGgmKgro752fBbGmgXzWoL24MK6lmqjI/6wXvJ
	 ZO4n/zU80CfBeFdXK68SZNPgk7lpMXjRDzccvWusxFrN3Ck5VwzzfqffqB9fS+gRB2
	 ngm7NGjiLKL2JjAzAcL5Zix82etOfUbykzi2FH2g=
Date: Wed, 3 Jun 2026 11:23:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 stable@vger.kernel.org, jannh@google.com, liam@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@kernel.org,
 chrisl@kernel.org, kasong@tencent.com, baoquan.he@linux.dev,
 youngjun.park@lge.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/mincore: handle non-swap entries before !CONFIG_SWAP
 guard
Message-Id: <20260603112341.1d1355a1e1e3a656665a9192@linux-foundation.org>
In-Reply-To: <aiAYt2pNBVAIBaFg@lucifer>
References: <20260602172247.279421-1-usama.arif@linux.dev>
	<ah8XqXQycZdbYFG9@pedro-suse.lan>
	<bcf95603-a04b-489e-8edf-b6bc4a42192c@linux.dev>
	<aiAYt2pNBVAIBaFg@lucifer>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 13:07:04 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> > >> Fixes: 1f2052755c15 ("mm/mincore: use a helper for checking the swap cache")
> > >> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > >
> > > LGTM, thanks!
> > >
> > > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > >
> > > Maybe Cc: stable@kernel.org ?
> > >
> >
> > Ah yes, I have cc-ed stable in the reply to this email, but probably that
> > is not enough?
> 
> Yeah I think a Cc: in the body is required,

It's required for MM patches because we've asked the -stable
maintainers to not auto-pick everything which has a Fixes:.

> but then again Andrew does add Cc's
> for Cc'd parties so maybe it'll be automagically sorted out.

cc:stable management is all manual here.

> Andrew - probably we're good here but just checking to be sure?

Yep, I'd added it thanks.  But please always do check!
