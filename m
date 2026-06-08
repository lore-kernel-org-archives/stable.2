Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A0B2F872;
	Mon,  8 Jun 2026 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936760; cv=none; b=QBe4BX2lV9GU3f5p3SRULYNbDf8wYy1qyoXn+nlmmZ54frs51kAreLgj/OoRnRrpKz2rMGQCaSb6+nv6Zp6LD9umrna9WJC0m1nLSbVdj3pejYcoA+aFmQyr3/6DIZWL726qiLNblVa9Azzq9Y0bkluz5dmHaqOi/c+58IaLtlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936760; c=relaxed/simple;
	bh=me8qg487BzdyMIu5rxZr+8Jk+clScM1sGxugStWz2tk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A8ZPVOIYxaJ0zacsTrsl254/QywqQAJMFij8XH/m2WhcVmA0OFBGX6r11AZFYsUs+9pjJXAiEvJ6Cso2X1mgMPlpfKxLIEMALyBGPwZ2Hm0cHZ6Bi20mAhnU7H3gJY0MTzKeyOy/haSlhqfQtBZVmgupe1qj5YQTdTc4ctsV2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f4Lx+W5c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f4Lx+W5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4751F00893;
	Mon,  8 Jun 2026 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780936758;
	bh=kD4kOdeXpGWg7+OvwOcT8DNucWcPPZk1o0oeWyhgB9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f4Lx+W5c54dWT8s3MY3WYPtTSVdMDthJE0CLsW0n/ylTWV/exmlYu1OeWUwvlsnsN
	 avvCbIN2bTVjS9nfsjEkgcnGJHSuOkYmvAFKX2t+R4FmBuxaRuBg9oK6LRSpacDSHL
	 DqjhGqr8rPycNJSAjGkQDJsTISwJJWymWTXFUNo8=
Date: Mon, 8 Jun 2026 09:39:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, David Carlier <devnexen@gmail.com>,
 David Hildenbrand <david@kernel.org>, Heechan Kang <gganji11@naver.com>,
 "Liam R. Howlett" <liam@infradead.org>, Michael Bommarito
 <michael.bommarito@gmail.com>, Peter Xu <peterx@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
 <sashal@kernel.org>
Subject: Re: [PATCH v2 1/3] userfaultfd: verify VMA state across UFFDIO_COPY
 retry
Message-Id: <20260608093918.68ce9d7d5694380e3055e293@linux-foundation.org>
In-Reply-To: <aia8nKXtShnhQpVY@lucifer>
References: <20260527184751.4147364-1-rppt@kernel.org>
	<20260527184751.4147364-2-rppt@kernel.org>
	<ahhAHNSZOeW49ms2@lucifer>
	<ahhUM0A8-q0UqFv1@kernel.org>
	<aia8nKXtShnhQpVY@lucifer>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 14:03:11 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> > > > Fixes: 292411fda25b ("mm/userfaultfd: detect VMA type change after copy retry in mfill_copy_folio_retry()")
> > > > Fixes: 6ab703034f14 ("userfaultfd: mfill_atomic(): remove retry logic")
> > >
> > > Did we want a Cc: Stable?
> >
> > Andrew adds it when applying.
> 
> Hmm, I didn't think this always happened by default? :)

Nope, adding cc:stable is manual, case-by-case and the -stable
maintainers have been asked not to automatically backport MM patches
which contain Fixes:.

So this one snuck into mainline without the cc:stable tag.

Thanks for noticing.  Greg, Sasha: can we please add mainline's
85668fda932a ("userfaultfd: verify VMA state across UFFDIO_COPY retry")
to the backporting pile?
