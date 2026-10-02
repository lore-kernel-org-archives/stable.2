Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6E368D76;
	Fri,  2 Oct 2026 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790977577; cv=none; b=i0BKLKzItGrFtv5b32zRq3gpzPJNnnQHs1EPxbU+0kkOeXqGdltMD0kkXKLvsMgg003L6OADG5X+mkVjbza6pbx/+U4LuupRJcHEcATXiVHFl9+0Mro6XkngFWA/XlUCqWffRV7QXp7rTNEfbHwxo3FTxH37BpBAkNlcWbmwRPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790977577; c=relaxed/simple;
	bh=gMQyt8qyh3fHs5DSKmwSyeO2JYfLaqwSGCkf/FSyijg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KebeaVZpDaqYea7L3j8gg/UakIt5hmXx2KVRq/QZPkM7F1j0ih/1qriht6a6GRHuWx4E+wnEBKLBktJoadCaxlqmaBfYueskBsggBFfU+aPnkEgnO2a1IFKAset+fw5J0HjCf8vilQDnxRxcnMO5/eUL/OTBR6+yzZWJjtRvW68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHwTIiTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHwTIiTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562BD1F000FF;
	Fri,  2 Oct 2026 21:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790977575;
	bh=DYXkUlAMM/fGenjhkdGX7aKdCPOk8yqgAxmnLIYl0s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hHwTIiTrtciVfO4uMc/oAnCPtbBguuh7R4GNpeHFs5Jbetiy2DOP9tBGKyVROKz9D
	 Jdr4aubN3OcPol7db6mC/zJXkG+h7HTyLQCEQWlniG7J2wM368V2vhIhaen2ngu7jI
	 WHHTB/afr0LP90KYMtRAtQ+udgH04bbP1+46pjLz6ZeqyoyvywOLQv4/XbYuSFZckb
	 VCgujKQ+iYxbqrKlWY71+VoqtpAylCtgL9r7w0m96A99loGe3fpwMKIouEp2OkvFxv
	 A8NzazKrgGqOQKPdXOZAoYWaMdAul7c7F5laN89diO5tgbWNQpblyHgqvKsXau6DLH
	 3UzsRbw37NQ0g==
Date: Fri, 2 Oct 2026 14:45:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Subject: Re: [PATCH] fsverity: RCU-delay the freeing of struct fsverity_info
Message-ID: <20261002214551.GC3006@quark>
References: <20261001171349.81454-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001171349.81454-1-ebiggers@kernel.org>

On Thu, Oct 01, 2026 at 10:13:49AM -0700, Eric Biggers wrote:
> __fsverity_get_info() calls rhashtable_lookup_fast(), which just uses
> rcu_read_lock() and doesn't directly synchronize with
> fsverity_remove_info().
> 
> For the same inode this isn't a problem: its fsverity_info is removed
> only at inode eviction time or upon failure to enable verity, when the
> inode no longer needs its fsverity_info and it will no longer be
> accessed via that inode.
> 
> However, this is broken and can cause a use-after-free for concurrent
> __fsverity_get_info() for *different* inodes.  Those rely on following
> fsverity_info::rhash_head in the rhashtable under rcu_read_lock() only.
> They also use fsverity_info::inode to do the key comparison.
> 
> Fix this by RCU-delaying the freeing of 'struct fsverity_info' after
> it's been removed from the rhashtable.
> 
> Fixes: f77f281b6118 ("fsverity: use a hashtable to find the fsverity_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/verity/fsverity_private.h | 15 ++++++++++++++-
>  fs/verity/open.c             | 13 ++++++++++++-
>  2 files changed, 26 insertions(+), 2 deletions(-)

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-current

- Eric
