Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF083D952D;
	Wed,  9 Sep 2026 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984278; cv=none; b=Q489ndDUkUhuwJ7qaRpKsDJwwYNd+hTX8JgQDYFFjFPWRHHP4LkoFbbemJIdJ+nRzDbod9zesjdcBH1JptX+D+2IbAS0hxRLdTHWJbyhXv9bVQQRfvpWW6LzsG18O309n9XV0fh0QUyAGT9YY/nZaWdCpS697sYgLJkc7pzXC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984278; c=relaxed/simple;
	bh=9hPRffl4abURYcBOKDa61XJaquhMEphnvQparkU6PBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq0MNpnHIrWhjtofjUK1ecx4OIHyrQ5oq23PPnV24Pwct8rw/+vYT52TquHAq5ocwMnudgvrxOodZKrmC7AVkHdIYQl3tFpXh1qpkTCdcttZ0SIwrWFGX+b5q3Wfr9WxgX66+RAuy2eHKs2IRKLT0Mmy4yrVg0EHExgWlOnEvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLlY53+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLlY53+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275B31F000FF;
	Wed,  9 Sep 2026 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788984276;
	bh=SLJzOvq2lTU/gPH7GG13J+NOHP7NGQWtI8kcAjrL0Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eLlY53+nn2EkGwD7rnPr+MBoExpDQyKGtznMi4KcnhrUoOTe/ltuZ2DDnU1bHjGqY
	 ulW+FEWLQnu7xtdwcIX5lFMEfmGOhCjsTWvduhd4y6sEV6VHjyfMnpvgPwdZkqpQXu
	 X7dkbNEZmZtHKDItGrPPE1y7dAzg2PWshwIkN/N11jn5JPG/TU/QweVZdOnL9wlXfY
	 3Pygqfmc1zkBIrvijfmne25IUMN1+HkOERUmdo9r0xnDl4bL4EQv9BG3woZwRfijBQ
	 u5HmINyYKg9IZOMPmuIdNUd+dvOcwVxaJy+IkVMOXsdxX82uVCaZezTh43AjIJCpOh
	 1NdNFmcQVPA7w==
Date: Wed, 9 Sep 2026 10:04:35 -1000
From: Tejun Heo <tj@kernel.org>
To: "Patrick Lu (Anthropic)" <perf.patrick.lu@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] writeback: bound cleanup_offline_cgwb() rescans by
 rotating b_attached
Message-ID: <aqG708yDkaq7JjF-@slm.duckdns.org>
References: <20260909-wb-cgwb-rotate-v1-1-f2eb994d2a46@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-wb-cgwb-rotate-v1-1-f2eb994d2a46@gmail.com>

On Wed, Sep 09, 2026 at 06:50:27PM +0000, Patrick Lu (Anthropic) wrote:
> cleanup_offline_cgwb() prepares at most WB_MAX_INODES_PER_ISW inodes
> per call and is called again until the dying wb is drained, but every
> call walks wb->b_attached from the head. Inodes already prepared (they
> stay on the list with I_WB_SWITCH set until the switch worker runs) and
> inodes that cannot be switched (I_FREEING, I_WILL_FREE, !SB_ACTIVE,
> DAX, already on the target wb) stay at the head, so each pass rescans a
> growing prefix under wb->list_lock and a full drain is quadratic in the
> number of attached inodes. With ~17M inodes attached to one dying cgwb
> we have seen this end in soft lockups, with CPUs reported stuck for
> 21-48s.
> 
> Move every scanned inode to the tail of b_attached, so the next pass
> starts where the previous one stopped and the drain becomes linear.
> b_attached is unordered and isw_prepare_wbs_switch() is its only
> walker, so nobody else sees the reorder. b_dirty_time is ordered by
> expiry for move_expired_inodes() and keeps its current scan.
> 
> Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Patrick Lu (Anthropic) <perf.patrick.lu@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
