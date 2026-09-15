Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0E3B9D9A;
	Tue, 15 Sep 2026 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452680; cv=none; b=cG0DHMrTzer5c9odraDw6KVbflCa8OTcY1pmTtVf8hOGc/QpSnjwL5i2SzuQUggzx+QoUOhiDMX4i69rMG6NiibXr3kHPX1n6M38GcSVhc+AAMRnja/PyUj0JqodaCaNg35w1EoQuN8XQveEwJHKX/XqtLdNNxHjEzgcrjJZJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452680; c=relaxed/simple;
	bh=Pyi+YCESKx1JA4T3QEG+sxaewdJpycnVcgEzTRgWgFE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l2zUqwWd0Asg6b3yaIh045Ge0pO1U2wOml/t61B2E/RXgY7PWNK6Splkb2ouR9tOOGb34Ijq7195koYWxUZOr0ZR2edCQOIeaGg0kA6m3kKSemUWpPZvQWSalWYIk6ByTeaJ1HqetZpDTAm4vyN5j200lDv4KTZEllzw50c4iT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yUydxAS4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yUydxAS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEB11F000FF;
	Tue, 15 Sep 2026 06:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789452679;
	bh=xCk5bN9SaRWwllaiJGSLIbTGPxtbvtj0ZCgGZJ1Msns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=yUydxAS4vHPqlkHac9gwWXo4taASQ50/J9468zWaAbLsONKUVHdztIvnzYOPtAmF9
	 O6spzgv9H5BW8L8d2rCRVaZzuFds6hvGdRP2Ct3QPBpWELIu1r6ss8/scHsd87tvr1
	 d56QkOORK0havknyiEvujnExWzU0m6e2ggNB9JCY=
Date: Mon, 14 Sep 2026 23:11:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, liam@infradead.org,
 ljs@kernel.org, vbabka@kernel.org, jannh@google.com, pfalcato@suse.de,
 peterx@redhat.com, jgg@ziepe.ca, david@kernel.org, sashiko-bot
 <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] proc/task_mmu: handle special PMDs in clear_refs and
 pagemap
Message-Id: <20260914231118.ac170fb8c2c105412adfedd3@linux-foundation.org>
In-Reply-To: <aqjS0xWes7fhhI9A@gourry-fedora-PF4VCD3F>
References: <20260912122822.3348978-1-gourry@gourry.net>
	<20260914214910.a22cfcdc250bfbb6b14edaf8@linux-foundation.org>
	<aqjS0xWes7fhhI9A@gourry-fedora-PF4VCD3F>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 01:19:50 -0400 Gregory Price <gourry@gourry.net> wrote:

> > > Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
> > > Cc: <stable@vger.kernel.org> # v6.19+
> > 
> > Why cc:stable?  Is a crafted test driver the only way of hitting this?
> > 
> 
> Technically reachable via mshv_vtl_low, so i tagged it stable.

I have no idea what this means, but I pasted it in ;)

> It's hard to make a judgment call on some of these - so I err on the
> side of backporting.  Feel free to drop stable if you think it's not
> worth it.

I retained the cc:stable.  It's disturbing to leave known bugs in there
because we *think* nobody can reach them.  What if we're wrong about that?
