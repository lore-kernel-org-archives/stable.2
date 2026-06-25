Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F832DC350;
	Thu, 25 Jun 2026 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412146; cv=none; b=kTD0MftIHg129wat/P8plpzy5ZKeBVaq6tbDpntmd591j67T2N96OLI+WdsNVzYrh5JxLmwH6Zb56165LSJJ6K7qNVc6XLl8w163L4cI9pJIkDEPIhRb7CnG/P36e10fX6l4JgqzDz2yHZoCx9PgkAY7bzztW4aB4PJKb8MgS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412146; c=relaxed/simple;
	bh=icMdpMpf1QK3lmefJTdmGkJNNSKXid0+x+tLMbAmkLs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N1aS3yIqqcDzuI0aeMJzGf8QQTedgqECco7ByU5Bv2e/+dCe7DHtGLMXm2ywda8BAuCpoYfRfOAF7lBCsNLBChSPrF6xYstfZOdzPABWZ1k4PooHPDRj1uNeSWGM0yV5P3QfzmECI0RHjQrIlTOGa37fki7o7obXOzDx0zK0iLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aucTVLfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aucTVLfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5954D1F000E9;
	Thu, 25 Jun 2026 18:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782412144;
	bh=Gz9FOGPa7qqQY6AQKnjVfyoG9EY2IZ8jwVG5z5C3WNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aucTVLfSiI88uOQgXNeZHAfDomgg19wlc87GHYGd6G0AdUvLe5znczySG5wXLXaJx
	 BGotTj2TypYkC8zXApQLuRCbbi3TIYgr+1X+MqKGfpkiFMfwQ1rZlxc80uaZc6D6tV
	 R1We3MX22LSUnvhKAN/NFfmfUzDrdiBq0fJEtGl4=
Date: Thu, 25 Jun 2026 11:29:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Liam R. Howlett" <liam@infradead.org>, David Hildenbrand
 <david@kernel.org>, Jan Kara <jack@suse.cz>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: do file ownership checks with the proper mount
 idmap
Message-Id: <20260625112903.f961fc41a0b0f8dd1f1a9fdd@linux-foundation.org>
In-Reply-To: <20260625153853.913949-1-pfalcato@suse.de>
References: <20260625153853.913949-1-pfalcato@suse.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 16:38:53 +0100 Pedro Falcato <pfalcato@suse.de> wrote:

> Ever since idmapped mounts were introduced, inode ownership checks
> (for side-channel protection) in mincore() and madvise(MADV_PAGEOUT) were
> done against the nop_mnt_idmap, which completely ignores the file's mount's
> idmap. This results in odd edgecases like:
> 
> 1) mount/bind-mount with an idmap userA:userB:1
> 2) userB runs an owner_or_capable() check on file that is owned by userA
> on-disk/in-memory, but owned by userB after idmap translation
> 3) owner_or_capable() mysteriously fails as the correct idmap wasn't supplied
> 
> In the case of mincore/madvise MADV_PAGEOUT, this is usually benign, because
> file_permission(file, MAY_WRITE) will probably succeed, as it uses the proper
> idmap internally, but it does not need to be the case on e.g a 0444 file
> where even the owner itself doesn't have permissions to write to it.
> 
> Since this is clearly not trivial to get right, introduce a
> file_owner_or_capable() that can carry the correct semantics, and switch
> the various users in mm to it.
> 
> The issue was found by manual code inspection & an off-list discussion with
> Jan Kara.

Do our idmap selftests tickle these issues?  If not, is it hard to add?

> I noticed there are a couple of call sites in fs/ that could perhaps be
> cleaned up with the added helper, but I'm skipping that for now for brevity's
> sake.

You could do this as a 2-patch series, because:

>  include/linux/fs.h | 5 +++++
>  mm/filemap.c       | 2 +-
>  mm/madvise.c       | 3 +--
>  mm/mincore.c       | 3 +--
>  4 files changed, 8 insertions(+), 5 deletions(-)

it touches mm/ but ->Christian, please.

(or I can queue it with Christian's ack, of course)

