Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196EA4EE858
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890555; cv=none; b=Bo2sUTvGY0a8xlWnKmBXGJ3++EZ/6JxVPZLQlC1YPte8NSU7LzU9RDcAkq/zHRU5G2WNgt5l9gfmkiYGEoIINapIqlSD7/nmmjN2LGZYC55xUWw8fYvr6zZK2VKRUqy8+FknZB0JlBOxfV7C3uFgL54ssZLFh/Ok+p2Kl/GbE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890555; c=relaxed/simple;
	bh=1M7mf6W6AT+YhFmgqHiM7Rjylb/gJQG1ChQcM35QnBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCGY806RiM6s/vGknwcdzFHYfYOJYcy+HQU0GLtxikyO64/30YjIsZE6ZqXiDKcA43cpIMUCV7TQwZL8ToQxbDSSxyLqi0KKSZpRUi4iV+7P7uFAMubPibfyn+GSZt7vKqGSjwsDqglhB3TW9Mepb7/HDUlVOlxU1+IPZRPRoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZpNke+k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZpNke+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C9A1F00899;
	Tue, 13 Oct 2026 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791890553;
	bh=mtpgXdzPgdHugzEFbyFxgZF7cgPiieuUZpPezpahctY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PZpNke+ky9Mf0deSxyKCg4UUJbgy4KDId6WcZbWS72Gw5uU76oskxmdDSQvuFJF+Y
	 9iXh3+rKMIjDZK1kud0aBVXddZVH0FFcHyb+KmcFJfZKeRMLkRnhM6UG9xY/G5H/kM
	 TLPwGprXCFampSpBhxQACcJXsYhhl/+qaKTyf9qZKYl4h/G9QMolGRahO8jYj0mEXA
	 CP2l7avckvUe4j1+tIcK3IVjRmJsD5vJ4Qo+JrNj8q9PmTzpm8CwCrQNaAV19lwF0u
	 4dYr+ct2hiu0PYGUJFpKcguC0o3YExmBHFxMMmZ6HLipfZq42qTvZ9znoueyjfY9ta
	 N6AK75rGaod+g==
Date: Tue, 13 Oct 2026 13:22:28 +0200
From: Gao Xiang <xiang@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Gao Xiang <xiang@kernel.org>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org, Chao Yu <chao@kernel.org>,
	linux-erofs@lists.ozlabs.org
Subject: Re: Patch "erofs: remove fscache backend entirely" has been added to
 the 6.18-stable tree
Message-ID: <as4UdEWzIr2O_M31@MacBookPro>
Mail-Followup-To: Michael Bommarito <michael.bommarito@gmail.com>,
	Gao Xiang <xiang@kernel.org>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org, Chao Yu <chao@kernel.org>,
	linux-erofs@lists.ozlabs.org
References: <20261013020044.2527207-1-sashal@kernel.org>
 <as3drCZLoTUPS_oC@XiangdeMacBook-Pro.local>
 <20261013111011.2814836-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013111011.2814836-1-michael.bommarito@gmail.com>

Hi Michael,

On Tue, Oct 13, 2026 at 07:10:11AM -0400, Michael Bommarito wrote:
> For context, the original bug I found can hit both 100% deterministic
> local DoS and a textbook UAF on kmalloc-128 slab that requires timing,
> but I don't think an LPE can be ruled out...
> 
> Since it is reachable by an ordinary read() on Nydus or others that
> enabled ondemand in Kconfig, I think it is worth thinking about what to
> do for all of the pre-deprecation users (even if it's just comms).
> 
> I would defer to Gao, but I sent a minimal fix in June that can
> close the UAF without any other breaking changes.

Do you mean this one?
https://lore.kernel.org/r/20260619135800.1594811-1-michael.bommarito@gmail.com

As I requested months ago, could you please provide a reproducer first
so I can play with your patch.

If you provide a minimal reproducer, of course we could address this in
the stable kernels.

Thanks,
Gao Xiang

> 
> Thanks,
> Michael Bommarito
> 
