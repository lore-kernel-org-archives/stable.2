Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68726B742;
	Tue, 30 Jun 2026 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803235; cv=none; b=lkf7ISdCpLVo8YtcBO49wrecOoPHBzNIBF3Qc20Lj0GwsCKluStFfmppCRXNkc61JKnZ92siNpJmHjRd4PPerygublb9pB44wN3cN/chN9ydOPKwDicm+WBgfV2ebAnd3h91gKI48DyKpJZFF86TBBw5lD+c4B06RH2bsRGj72c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803235; c=relaxed/simple;
	bh=jqOZxiKqWFL4dZin6A17Mr4lhTs3cQNmTdplb+0bYN0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=NHEzE7nK8USruYKclhschZLMZaPVvvPdp4YjKUfmdX4/M9yE9sVPc8IzXUsxOa40nFgj6/g5YfyyI9rywdg6NspCFgnc0BbX+B3C+58KGzU8qjPjbpb8psLpPTYbQXem9iQts8rBY5UdFOD5mcDm8g+iVY4LVwgkvBJ7y/mvBQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8VSrwGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8VSrwGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BB21F000E9;
	Tue, 30 Jun 2026 07:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782803234;
	bh=LDsCz5y+7w1jNDwo+8D2q4p3sHLHroeeuG4x4G+LvAA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=j8VSrwGd0XX4/ITZJrTQG/z6cNW+/m2rNHXtEcXl77LvDTHlAwZLAPuErSz+p0Ui8
	 1bPrPROAZCvJFuT6lbPrjL22u6DcAJHFTsFIj0LbrERE7XtnnMueRb2DkFPWgR9INv
	 HyfRhkPO0Kqr/jTcGvwtXoj0w/UXWTyLCg396LLo/zrC/Re72cdS82PR35mHRrzvCh
	 uft/Il7/F8Zs4vCzpzRvFNMhyBxRLRy34mIkSjKjSqERiT3kc9x5JNEPCRD9i8h6s9
	 VEmgPH/Uc2NbnrSuw7uhb1k9HLHv9PF6jvPLTUCFsT3FqY5Pelesy83lL4cCwFhQcM
	 xo25TJFN6myoA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm: do file ownership checks with the proper mount
 idmap
From: Christian Brauner <brauner@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <akK4CRgiv9G29UiM@pedro-suse.lan>
References: <20260625153853.913949-1-pfalcato@suse.de>
 <s6mr3j7gew2cgerzrvqzenjctctrtnhvlynmcccxb24uszcauz@5iapd6wnbfxg>
 <20260629-sektor-gaben-gepokert-58db0a3528a3@brauner>
 <akK4CRgiv9G29UiM@pedro-suse.lan>
Date: Tue, 30 Jun 2026 09:07:08 +0200
Message-Id: <20260630-zerzausen-galaxie-gelackmeiert-faf65e3defc2@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2435; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jqOZxiKqWFL4dZin6A17Mr4lhTs3cQNmTdplb+0bYN0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5Z8vt6lsgIrN1xQ2N2heOq5fPebDp8y6JM3Z7k1/O/
 7G955FVeUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE2M8y/C/JiNmzgWfF8v3t
 oal79uU23xStuXxHMmVN8cuoFgPR9a8Y/jszvdqm6GAscPTOxyjr2ydNU40KqozF/qY5GNvEPnD
 YwQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-06-29 19:30 +0100, Pedro Falcato wrote:
> On Mon, Jun 29, 2026 at 02:15:19PM +0200, Christian Brauner wrote:
> > On 2026-06-26 16:19:18+02:00, Jan Kara wrote:
> > > On Thu 25-06-26 16:38:53, Pedro Falcato wrote:
> > > 
> > > > Ever since idmapped mounts were introduced, inode ownership checks
> > > > (for side-channel protection) in mincore() and madvise(MADV_PAGEOUT) were
> > > > done against the nop_mnt_idmap, which completely ignores the file's mount's
> > > > idmap. This results in odd edgecases like:
> > > > 
> > > > 1) mount/bind-mount with an idmap userA:userB:1
> > > > 2) userB runs an owner_or_capable() check on file that is owned by userA
> > > > on-disk/in-memory, but owned by userB after idmap translation
> > > > 3) owner_or_capable() mysteriously fails as the correct idmap wasn't supplied
> > > > 
> > > > In the case of mincore/madvise MADV_PAGEOUT, this is usually benign, because
> > > > file_permission(file, MAY_WRITE) will probably succeed, as it uses the proper
> > > > idmap internally, but it does not need to be the case on e.g a 0444 file
> > > > where even the owner itself doesn't have permissions to write to it.
> > > > 
> > > > Since this is clearly not trivial to get right, introduce a
> > > > file_owner_or_capable() that can carry the correct semantics, and switch
> > > > the various users in mm to it.
> > > > 
> > > > The issue was found by manual code inspection & an off-list discussion with
> > > > Jan Kara.
> > > > 
> > > > Fixes: 9caccd41541a ("fs: introduce MOUNT_ATTR_IDMAP")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > > 
> > > This looks good to me. I'm a bit curious why Christian initially (in 2021)
> > > used init_user_ns here instead of the file namespace... Anyway feel free to
> > > add:
> > 
> > Back when this was added only the do_mincore() codepath existed and that
> > was intentionally left unconverted because it exposes the cache
> > residency status. So it was effectively a massive side-channel.
> 
> Hmm. I'm not sure what you mean by this. Wouldn't it be more correct to respect
> the mount idmap (given that a mount-ns-capable user mounted it with an idmap for
> someone else, or itself) for mincore? Am I missing something? Or maybe I'm
> misunderstanding that paragraph.

TL;DR: It is unclear to me why mincore() would actually be used in
containers.

