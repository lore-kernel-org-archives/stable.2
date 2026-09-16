Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52DB501F5C;
	Wed, 16 Sep 2026 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567746; cv=none; b=BOJQuypHACLw22zlsazK/BzptYn6AGGBTDjgCXzQJWrx8McrzKt4juGxdS0dqDpMeJ8FJvwteR91okMRHYDt5+/TWqefZ/MD1gWUDeccmWZDLxZFqX1rc7qh8t+ZRG53ImWKElYjkF6lm5Y/74nswzCOjXjlnOspX8DH1cRUWEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567746; c=relaxed/simple;
	bh=cMk/DPSonQx3LZYIuqxOrXxZJw5cg+Q7dRye5NtN0Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8yIjF/CRs+LpDkPMjRjdrsg7VtJ6G1k3HfB3tBdWxcwEwi0fv/rSEjL74+LKvj8EHR+VwwOkjDILpjyZ98JtTp0brXXwFbZWc8reFv8jrOJtJurqxlRtQIbxnVw9JBHqPG0RpCgdElFq96eBiAwpidEYBeLyo7eDjNG6xxGezo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3IOKsrV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3IOKsrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB6F1F000FF;
	Wed, 16 Sep 2026 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567741;
	bh=P2FyxGgw1ikYY2FCX/RdMpWGC88woDzIrvMXKz3/vl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k3IOKsrV9yyi/4efi5YTBfCdN6BT4WiFqtM9xMibfeZ8L1JLvwZnt6FH4xJ5EPlj7
	 fbcF7iBBEBjlNYvZH0Zl1AevtDgRZ+t/3/Wo91VAtHPzDOSH6Wbo1AyjsPi8xrWtS6
	 f+9fp1cRGGUS8dJV3qx2C2524oHeoyofz1cnix+QBGaaZyEXNVK1m5aY0eFnWS0HfT
	 WG/4Lbir4gbnFT/FxZOTj8JXJEu1ogRq6aeB3Si12XyNlz3aybYnQiqy6A9LCcTkLF
	 BLGY4dBxqbXGvK3jCfMxqNgl/TzycjY5J/AsYTyFaXLDTJ/L/r9ytSIv6NIFFLCx1L
	 xJ3iqBqVDOtPg==
Date: Wed, 16 Sep 2026 15:08:55 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, wangjiexun@tinylab.org, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqqi1KWDD9KMa0FO@gremlin>
References: <20260912110832.3203902-1-gourry@gourry.net>
 <aqloB0zm3RjJ47m1@gremlin>
 <aqlzzwLOVT79Ti_7@gourry-fedora-PF4VCD3F>
 <aqqTtW3vjfzH8bcY@gremlin>
 <aqqgeOtYBcRdVqmI@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqqgeOtYBcRdVqmI@gourry-fedora-PF4VCD3F>

On Wed, Sep 16, 2026 at 10:02:45AM -0400, Gregory Price wrote:
> On Wed, Sep 16, 2026 at 02:18:36PM +0100, Lorenzo Stoakes (ARM) wrote:
> > >
> > > relevant meme: https://i.imgur.com/W0N40BK.png
> >
> > Content not viewable in my region :'( seems I do not have a loicense for
> > that!
> >
>
> google "reading other people's code meme" and find the comic with
>
> // this is bridge
>
> :]
>
> > >
> > > No argument here. This function in particular is really horrendous.
> > >
> > > I think i'm now 4 or 5 stacks deep on the "Thanks for fixing a bug, but
> > > while reviewing your fix sashiko found yet another CVE-worthy bug".
> >
> > Yeah, I WISH it wouldn't do that.
> >
> > I mean it's helpful to some degree and it finds real stuff.
> >
> > But it's _where_ it does that and the workload++ aspect of it.
> >
>
> In some senses - yes it's annoying.
>
> In other senses, it's saved me a lot of pain debugging my new work, and
> I'm willing to do some cleanup on the way to new functionality.
>
> Someone's gotta be the janitor I guess.
>
> > > I suppose reasonable to say the goto is worse.
> >
> > Yeah I know it's all a bit much of a muchness, and obviously my suggestion
> > _duplicates code_ which is also not wonderful.
> >
> > But the control flow in the function I think is a bigger issue.
> >
> ...
> > > I'll spin a v2.
> >
> > Thanks!
> >
>
> Given i already started rewriting and validating the entire garbage
> pile (see other response), mind if i just leave this as-is?  This gets
> completely replaced anyway and i'd rather not have to go backward at
> this point.

Sure

And feel free to add:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

If I didn't say already

Because the code is right (or so I convinced myself) :)

>
> ~Gregory

--
Cheers, Lorenzo
