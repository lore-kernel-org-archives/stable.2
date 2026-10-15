Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6352D0602;
	Thu, 15 Oct 2026 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792034885; cv=none; b=i+gejINqq3hCXJwz9zrKJILV+vp3dIOv7Fb6yMb8ShfdInZ455ce0KbUcfqVEB4vbiNrWntvmLJwGb80eP0Z3iGTNsPQZVc1D6uVU7Vl6jq7Vo7Vq1OPTbVIjRXm40Bxst6dLiukFjUbQkHCzdrldtAp/KTKELQZpK1i2gbiyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792034885; c=relaxed/simple;
	bh=hkdg5p1XC4oETqECRvlqxviCIJvZUjr2oqQDc43GPpc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RDzXFBAepRd2YjRjU4Eu2mxqTKBi+BBRVDEHUyudsCJ/tyjbfjykHz8AFwkOk2/scTO60w3F4XxFd38alYHMR/YdakzmGbKMNObf0PuOIqiUakxw1LonkLNCBb15F7kS3DkWE4d+N+pLwT0U9LG+Vjl9ZE4J+NZk98mw3SYdC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvKPJ4i9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvKPJ4i9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FD41F000C4;
	Thu, 15 Oct 2026 03:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792034884;
	bh=THrvGhaMruo3uO4UuSuqySwQUJkWS/AIHlJsZDp2/MQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=bvKPJ4i9BGnucKtrHJlFlwwuGfjmt2uyvv5bE6/KNt2m8EoBd8ikKv5s61fUCHE3A
	 x1Wnq0ICn7tV8y2L8Iaw6muvYcDo3NZPd2VKzc2jyw3Qmhaqkhsf68jEuF42qTckV2
	 mB2O+rU2eSFNtpvLLBBd7d/cEa/fsOHkrJ45GjqS+JhjQM+IEB7W0e6ivesGrrC+ms
	 uUXSQQkEmOgEKTV7XBxsHetrXdMryZm/SBRCRDOjMY6UYT3fTgpKLP63rmaSb7d96M
	 5w2fuBNra+4GU35gCLXSTEHKNQXpf5Zx9zv2m7fLFLBoP6mmo791Jk5nsZBnYBCJbs
	 vCnCgwK1cryDA==
Message-ID: <d58c66d6-0163-4084-ab79-560513108e9b@kernel.org>
Date: Thu, 15 Oct 2026 11:28:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>,
 stable@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: release a removed xattr node in
 roll-forward recovery
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261015025732.1564032-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261015025732.1564032-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/26 10:57, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When xattrs shrink enough to fit in the inline xattr area,
> write_all_xattrs() truncates the xattr node and clears i_xattr_nid. If
> the file is then fsynced without a checkpoint, only the inode block is
> written, with i_xattr_nid of 0.
> 
> Roll-forward recovery starts from the checkpointed inode, whose
> i_xattr_nid still points to the old xattr node.
> f2fs_recover_inline_xattr() copies only the inline xattr area, and
> f2fs_update_inode() writes the old i_xattr_nid back. So the inode keeps
> the stale xattr node:
> 
>  - The node block is never released, and fsck reports "nonzero bytes in
>    xattr space after end of list".
>  - If the inline xattr list ends exactly at the end of the inline area,
>    its terminator is read from the stale node, and the removed xattrs
>    come back after recovery.
> 
> When the fsynced inode has no xattr node but the checkpointed one has,
> release the old xattr node as truncate_node() does: check its block
> address, invalidate the block and drop its node cache, which may still
> be dirty.
> 
> Fixes: 28cdce0459cc ("f2fs: recover inline xattr data in roll-forward process")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
