Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4153C3164B4;
	Tue, 18 Aug 2026 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081327; cv=none; b=ei+lWWSpqebwKEEUVeOL9g99519iZ7uh64xnIidyo1KHN3IkHauOoJoh2JjsZXvUMYx4VR0J6ufeDMosnXAwT0xTv3/Qf7LlG1lPzCEI+W+eN1vRgm+VTapt9lxwvpha/lJ+um5VjNA/uqrLfRtFfeg4nBFgBAxE17yW8OEKvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081327; c=relaxed/simple;
	bh=0YPRynvB5m8gom/OB4bYqphbUjPq7tQZwiZrYQlrBKQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pvHE2PQMhBEDW7vj49CvSm4GatR7KGsHkidp3CpYgysBlg42ykjoqze0Nh/ZC2TxQjVTZ0iUHgM1zRBhEHukrJWUcO1zq7SB848n3aIOGov4zprREKAik12KvFn+BKqZNeg2FucD9V2Sv9xVu/BrFoxchddsiSjsbU7Hphshpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1Ch6BF2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1Ch6BF2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F77A1F00AC4;
	Tue, 18 Aug 2026 19:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787081325;
	bh=cZNjCfbYHIfdsRcFPvK2wydI/XjK8b1Rn1pUmZtlJeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=1Ch6BF2pzmORCdDXF6fKXUg5XWDOtX8jdXFDfkMCik+01vWgZJ1w55VmLqepohv8e
	 N2HH1+eTBtBJshqOcMJD8MKD4K+4A1/ewE4P/YoJeysTCe5hs8j82KO00EbkCu9jCZ
	 gfNDcrr3VEJKSxiqXZ5cWBQdlY6kz1nvQFfBsprE=
Date: Tue, 18 Aug 2026 12:28:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng
 Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, Youngjun Park
 <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, Miaohe Lin
 <linmiaohe@huawei.com>, Oscar Salvador <osalvador@suse.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm, swap: ratelimit bad swap entry reports
Message-Id: <20260818122844.71988535d6380ba67e8a2b1a@linux-foundation.org>
In-Reply-To: <20260818-swap_part_one-v1-1-a4fc58119fc0@debian.org>
References: <20260818-swap_part_one-v1-1-a4fc58119fc0@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 02:03:40 -0700 Breno Leitao <leitao@debian.org> wrote:

> A corrupt page table hands the same bogus entry to get_swap_device() on
> every access to the mapping, and every rejection is logged. One machine
> logged 6185620 copies of the same line in a few hours.
> 
> swap_dup_entry_direct() prints the same message from the fork path, once
> per call: the WARN_ON_ONCE() guarding it warns once, the pr_err() inside
> does not.
> 
> Rate limit all three prints.

Sashiko suggests that ratelimiting these might cause pre-existing
problems to become worse:
	https://sashiko.dev/#/patchset/20260818-swap_part_one-v1-1-a4fc58119fc0@debian.org

The problem it's identifying does require that unrelated things go
wrong first - get_swap_device() failed, swap_retry_table_alloc() did a
retry.  So presumably you wouldn't have hit this in testing.

Sigh, so much to fix.
