Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A923EA94;
	Tue, 25 Aug 2026 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635652; cv=none; b=Abql/PPR6kN6pqVgL4ekKv1uSweFu2T7wNnpuP+cRVj0uLfu2gMLQLEEhyQaFvTlRE6KvOXovaTrdtXG/TtXKhoMHUY6vde4PzbuyU66BjHlRGOdpBrK25b7iikcAqDIYQiPETzIvs2YyAPp8DnyJkSYSeCFnYJjvHvaywIiHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635652; c=relaxed/simple;
	bh=hkCmFY+BfNeSgf8f4xLDWRYW3IRQkAbFqJJZE/peNC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfWGuB2YA6syl5RhOjP08wnzpJtEEzMvuerPLdISGRAcb9KbdolA1AmKqXR3QsCrzpr80qCQmt6qSnPtU6UbTsv+jCnXG6r7bpijraumPgGjYgS5yfcflMHNJooo0uAV6b578S4pwruKThpLe42e46GOl4OVLvBIDpvpMbSg1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yvrgEIOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yvrgEIOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F401F000E9;
	Tue, 25 Aug 2026 05:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787635650;
	bh=hhhseGFIlJwP2tkCZCo0qcr8dmfGNl3pqDAcJXuGnk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yvrgEIOEp4kHQ3eQH3RJc1ET6ZRIL1DbVnTktbSzazjh3S9+3C8kw8xmj8gK9udcX
	 cT4ZlWcKDNpgLYK8g3o/kjHII8q9XcclEJpThq6cI7PYrxc1llMG3aFwJ6WvA9nqHr
	 deSIdtXEkwERO9QkUDQkwd4/TnCD9rwgGNR6xcbo=
Date: Tue, 25 Aug 2026 07:25:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+9cb1ac7fce4944ba9165@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] klist: avoid accesses after waking klist_remove()
Message-ID: <2026082559-cyclist-annoying-7a55@gregkh>
References: <20260825040408.59225-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825040408.59225-1-kmehltretter@gmail.com>

On Tue, Aug 25, 2026 at 06:04:08AM +0200, Karl Mehltretter wrote:
> klist_release() publishes waiter->woken before its final accesses to the
> stack waiter and node. klist_remove() can then return, allowing the waiter
> to go out of scope and its caller to free or reuse the node.

But does that ever actually happen?

> Clear n_klist and take a task reference before publishing woken. Use
> release/acquire accesses for that publication and wake the referenced task.
> 
> The task reference keeps the waiter task alive if it returns and exits
> before wake_up_process(). wake_up_process() provides the full barrier
> required by the sleep/wakeup protocol, so remove the explicit mb().

I'm confused, what actual bug is here?

> Fixes: 8b0c250be489 ("[PATCH] add klist_node_attached() to determine if a node is on a list or not.")
> Fixes: 210272a28465 ("driver core: Remove completion from struct klist_node")
> Reported-by: syzbot+9cb1ac7fce4944ba9165@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9cb1ac7fce4944ba9165
> Tested-by: syzbot+9cb1ac7fce4944ba9165@syzkaller.appspotmail.com

Are you sure?  the whole bind/unbind mess that syzbot is throwing at us
right now is really causing people to go down odd paths in thinking it's
even a valid thing to consider at all.

Is this a "valid" bind path for this driver and hardware?  If it is,
then maybe we should consider this, but if it isn't, then thinking that
klist is where the bug is isn't correct.

I'm going to be submitting a "taint" flag for when bind/unbind is used,
as this all is a debugging aid that has gone rouge...

thanks,

greg k-h
