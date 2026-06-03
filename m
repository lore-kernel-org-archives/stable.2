Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AE338E8DE;
	Wed,  3 Jun 2026 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519424; cv=none; b=Ki6YK9B7CGM6US7Pqt8KaGq05ok4LW/yGDif0RfTI3/4x+qhhjy/1guRhi/frTfJWs/4B9oYF7r0STxVzsYQ7XD/sPA1oRVGv7sy9xnE7b8651agT1SboB+weUv3hVc2/53uy5tU0J2E5w7Dl3gNAniUzlkHUB7nZVS3UjjTCJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519424; c=relaxed/simple;
	bh=YAuE18JhJwvr9gmCxZJUZme2L7djr5e1rC1+AF011+8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rFa1iFWVf5oMzOly3rFCBPEvEGIuwy2lEDECtTERj05ZWsFSAQXm2x9j4B7H8DsCSOaMkBU5BIEZ7I0qIz2Tr7o+00v8m27cYhbVzQRA73VFk9MJdGVCqKLbFrzTW1U9PqHMjaNCBiym1WSA4fZIcQJq161IIlHWf0vllToPUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yBdr+bJ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yBdr+bJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671A01F00893;
	Wed,  3 Jun 2026 20:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780519422;
	bh=qXt3HlkGjPjjBzajXWzeASZrNMEoMaOOwTld8L39WrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=yBdr+bJ3R9u2rDk5PgtPf0n4/DWOgv2ezwhc2Eed/mQYXPKajZ84o56T7yrPi8eYJ
	 2TOVLzPMil8VxdpdiVWZyV8fEzIsYE8RX+LkC/7urfMv9+aG76CPTgtZvy56WlL+Kh
	 7zRz0TsvrKJCynL8t4AnIgfZUZivZFMHTgYW+mFA=
Date: Wed, 3 Jun 2026 13:43:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Carlier <devnexen@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+deedf22929084640666f@syzkaller.appspotmail.com,
 stable@vger.kernel.org, Chris Li <chrisl@kernel.org>, Kairui Song
 <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
 <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song
 <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>
Subject: Re: [PATCH] mm, swap: free the cluster extend table on teardown
Message-Id: <20260603134341.41b8c34935efd448c3a16a1c@linux-foundation.org>
In-Reply-To: <20260602222358.49061-1-devnexen@gmail.com>
References: <20260602222358.49061-1-devnexen@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jun 2026 23:23:57 +0100 David Carlier <devnexen@gmail.com> wrote:

> swap_cluster_free_table() frees every per-cluster side table but
> ci->extend_table. That table is only released by
> swap_extend_table_try_free(), which the teardown path never calls, so a
> cluster can be freed with an extend table still attached.
> 
> It can also linger while the cluster is live. swap_dup_entries_cluster()
> drops the lock to allocate an extend table when a slot reaches
> SWP_TB_COUNT_MAX - 1, then retries. If the count dropped in the meantime,
> the retry takes the normal path and leaves the table behind, all entries
> zero; only the failure path frees it.
> 
> Since a swap_cluster_info is reused in place and swap_extend_table_alloc()
> skips allocation when ci->extend_table is set, the next user of the
> cluster inherits the stale table and its leftover counts, corrupting the
> swap count of any slot that overflows. CONFIG_DEBUG_VM catches the
> dangling table in swap_cluster_assert_empty(); otherwise it is silent.
> 
> Free it in swap_cluster_free_table(), and also on the
> swap_dup_entries_cluster() success path to match the failure path.

This all sounds rather horrid.  We have no description of how this all
manifests for the user, but I assume "badly"?

> Reported-by: syzbot+deedf22929084640666f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=deedf22929084640666f
> Fixes: 0d6af9bcf383 ("mm, swap: use the swap table to track the swap count")
> Cc: <stable@vger.kernel.org>

First merged in 7.1-rc1 so no cc:stable should be needed, if we upstream a fix
promptly.

> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -432,6 +432,9 @@ static void swap_cluster_free_table(struct swap_cluster_info *ci)
>  	ci->zero_bitmap = NULL;
>  #endif
>  
> +	kfree(ci->extend_table);
> +	ci->extend_table = NULL;
> +
>  	table = (struct swap_table *)rcu_access_pointer(ci->table);
>  	if (!table)
>  		return;
> @@ -1711,6 +1714,7 @@ static int swap_dup_entries_cluster(struct swap_info_struct *si,
>  			goto failed;
>  		}
>  	} while (++ci_off < ci_end);
> +	swap_extend_table_try_free(ci);
>  	swap_cluster_unlock(ci);
>  	return 0;
>  failed:

AI reviw flagged a possible issue:
	https://sashiko.dev/#/patchset/20260602222358.49061-1-devnexen@gmail.com

