Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665386;
	b=cUbLWnRIHI+Ub55vYYkNdrMwD480osrS805ab+VpITtZBNPfGnMVRs/GcMwSkqktsM0J
	 BiT7CxInwmChUa4/oVv6wIsON2pyEYMdsrx5Jw4ECtITxHW7mVr9U6MhHp9tb+QjSvW7k
	 xl4reUIoXUURqVGTfF3d8c2Mw5jzrn2K/i8VcNuTcgVevRm1Wvx/7/4kq3qcMeMOTGWCw
	 54CuNlzBZ4TYEDf/ZVgmL51HIvILvSyOzwJXm4Lw5TpSciMyo0ZlEnZvX4p97vDacXKOO
	 6OoWvgHEzjRwSzUaVNbbdnkWMAGfEPBndQLgJZnAtS4nCj1UNfWHHKSZNt/4rcszmVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665386;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=43GQKuF8gnWzeMixXIHR+gqzDOYo2CW1whq/gMMSMBU=;
	b=XZm8p4DeOKC8g+YYx2bcNdammnSmrODXNxr//dQQk3Crg3UlEqgesBkrmFtnW4LgeUIB
	 TuH8xc7/HiGO3jmqwhYp8GtkYxKGEw7sbbbMcDs0NJkh6DihrtxRXIlKhaNIL9BxyQN1g
	 SWDk7I/Ax1NNKt2vYRa2QlF4Mg0rUmEACTYAxXxeJQ2w8YfOIJ7GD96A+lYWi7/E/a9Ag
	 KlJ6yOdRFb2NkU0YZgQ0/6Lim9C3/s+zxMWzt5MqvDKvrYOR2PT/nn1L1i4ygz8Lnq2ee
	 8I8AJbnPxFSzkJYmeQ5P6mMW6Ag9nQ+7CbgeTVLwPYScMgqhMzOuSJShVIRL0JRRX0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=t1nwqyHJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D783606D809
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=t1nwqyHJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9FC1F00A02;
	Tue,  3 Nov 2026 00:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793665385;
	bh=43GQKuF8gnWzeMixXIHR+gqzDOYo2CW1whq/gMMSMBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=t1nwqyHJ9/PB3Pu8mlbhH+QgW8T8h2UH42XScBdEdhYy/NwJCYK5nsll4EyNe6sUt
	 LZSvhF6cMqpKA/wtqDwIrfh7NPzFceszEPqj481hJKQpALL9zUBAWyBJ4NnCksks6G
	 fuwujKkAWNlXn80RxjDNHRW/ZCskNJMxftbU0sWg=
Date: Mon, 2 Nov 2026 16:23:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, David Hildenbrand <david@kernel.org>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
 <osalvador@suse.de>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm/mremap: fix accounting on a partial move
Message-Id: <20261102162304.c3585fc3fb88644118c152d7@linux-foundation.org>
In-Reply-To: <20261102-b4-mremap-pre-split-v2-0-d281dd11ad7d@toxicpanda.com>
References: <20261102-b4-mremap-pre-split-v2-0-d281dd11ad7d@toxicpanda.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Nov 2026 23:45:56 +0000 Josef Bacik <josef@toxicpanda.com> wrote:

> I went through the callers of __split_vma() to see who can't cope with
> it failing, and mremap() is the bad one.  If you move part of a VMA we
> don't split it until the very end, when we unmap the old range.  By then
> the page tables have moved and there's nothing to go back to, so we fix
> up the accounting and return success with the old range still mapped.
> 
> Lorenzo recently added a way to split ahead of the move for the mlock()
> + MREMAP_DONTUNMAP case.  This series uses that for every move that
> unmaps its source, so a split that fails is reported before we've done
> anything.
> 
> Doing that turned up a real bug in hugetlb.  We take the reservation map
> away from the whole old VMA before the part that's moving is split off,
> so the parts that stay never give their reservations back.  That fix is
> the first patch so it can go to stable by itself, and the second patch
> is a selftest for it.
> 
> The next two fix the accounting for when the unmap at the end does fail,
> we either charged memory that was never accounted or lost track of the
> charge for the whole VMA.  That gets a lot harder to hit with the last
> patch but it's still possible.  There's also a test for an old size of
> 0, which nothing covered.

Thanks.

So we have two userspace-visible accounting fixups: htlb reservation
leak, Committed_AS if mremap's unmap failed.  Yes?

How come the first is cc:stable and the second is not?

