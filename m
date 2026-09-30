Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E95187EA;
	Wed, 30 Sep 2026 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788522; cv=none; b=tcM6pjX6rVHod7k7isTXX6A6EfJHrnhWs7Y2wsClNYxgPpqpUHB3AV+bW0ZzxpOum3OofC3GJii5z63xA+3ou4toCrkqxHPtmEaZULg3hjuU5FX3a+wJj/HSS+i/A9vpN1SiyGwt41fEwnBpRSEWHDsgVRSeaUHDX6P4Ez+HyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788522; c=relaxed/simple;
	bh=Wu7ulRziLcS27Zfc7dqxAoWNHVNjTkfkWKXx36sj64c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVzFX+KUUTjrV8dc8O+jHQ8E0mzWchhrM9co9jKHd/TF2Nw5VTM8dcqe4q7LbJxtpvxV4Pv3osojHFWqHMXyq2ahfrvtwscj9DjrNyxmhGcO0mL684kjjf/Ta7y4lilsuMrQl014UABs9II7/3aWDxxr9J9ixlF3wv0WgtPbVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evvh/Egh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evvh/Egh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816EF1F00898;
	Wed, 30 Sep 2026 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790788521;
	bh=7KKJP9qr0HOQ1QifqduNkacWuiGruyNWSL5MJp6keOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=evvh/EghcuuzAXNa6Of+sqibY2Sx2AwIzS54X993i9UeaYdP7iBurkqV0UmoExgRb
	 IAuSLYaJxaRNzWjwobIE3rmf3Ec+XFyXw2sddoiPEAVhrPnwL4kOdEH+oy/DjRDbH2
	 h22URUd93XqXVW9h9SIwGWYnheFKE5WAJCXs7qBtpM5H4vyiQY5vsvPraNJinjINsj
	 N2nZVfC96BaUD4mID4oJ+f5lVR0qM0+3jcvillgePXVvdkPzQEqTX13orEursa35kQ
	 jPKlsEbTeV3CJp6yJsA8gMjzJkDQaVLEVTxXK1nMDhlMExLK8BKynukNWvbsfweIlN
	 iSHdOvR4ZFPtw==
Date: Wed, 30 Sep 2026 07:15:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Hui Su <sh_def@163.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Hold DSQ refs for deferred reenqueues
Message-ID: <ar1DqN6Ek2VwYLwO@slm.duckdns.org>
References: <20260930143443.2862150-1-sh_def@163.com>
 <68e1d1e0cdfc633520a6593fdcdb3b72.sh_def@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68e1d1e0cdfc633520a6593fdcdb3b72.sh_def@163.com>

On Thu, Oct 01, 2026 at 12:20:49AM +0900, Hui Su wrote:
> Please disregard this posting. This was intended to be v2, but I
> accidentally omitted the version tag.
> 
> I am preparing v3 to address the review feedback. In particular, it
> will serialize exit_dsq() with deferred detach/reference acquisition
> using deferred_reenq_lock, and keep final DSQ reclamation out of the
> deferred path while the rq raw spinlock is held.
> 
> The revised design keeps a single DSQ refcount and the existing
> rcu_head, without polling the refcount from repeated RCU callbacks.
> 
> I will post v3 after revalidation. Sorry for the confusion.

Can you try to do it without refcnts? DSQ destructions are rare events and
we can reliably detect whether the DSQ is full or not. I'd much rather make
the destruction path expensive than adding refcnt to hot paths.

Thanks.

-- 
tejun
