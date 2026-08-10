Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D963314AE;
	Mon, 10 Aug 2026 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786399822; cv=none; b=Zxks85xxEtkEcq8ILvpch5Lg9g+kUswlSGEjmRbHRzzm1mAoKxkdqt+8uzUQv7xzmQXYwmU0Hli5u2imzk9sFpPgSHYrrAJ5kEZoXs37UWCY8c47Bpf/mStSxFe11bXxz8z5HGBTRsyPTyUVDOzGE7ZFnGrRysN81OLQLzGs11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786399822; c=relaxed/simple;
	bh=cl86WJpRV6PMLZAFEECAt5l7yf/6B71fQ2/qvZHRsJw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=WcYaceihCVFXtXQCrbo1BBN2QTu+fpOiVC6WQ428XEHCe2Ii1GNHietVD0LKkG1vQCSl/tWq88bgIsKdybqTU5VhcY6zSPVxxdk3FAiAOHKzPYFvH7A0AsM/LVzfyqN4owrTgAB6UOwp/jKwoDr/b9Wpgv7M2CS02HoFwsXPxhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8MTnLD2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8MTnLD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433B91F000E9;
	Mon, 10 Aug 2026 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786399821;
	bh=r75NH5oDMxCq1MNL7IQM5MdFnqeCvhatiPsqDzJi8yI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b8MTnLD2Io/15ZnRgvooepuyNK2uBavmy/uGXaqGvg+o+u+OAMfwgIw8QcPWdTyYu
	 QK/q3ia1JGgTmsdAJlvVsvaWaAb7K4g/9W8PaG0jV1MePgEZwPrtQdwb8Ml4KBhEKS
	 S6kKJsLvFd74dhgI5UvYCW5XHgIB6z90nfaJBHVdr/eRlF4xwssnvdH4HvxJR6W45F
	 mXwEsDQs30sX9TbNrxDr/8mdRLnppX9bri6KZp0eNEGR0kAAWVJGconrVyYtxiVTXN
	 jaLjKPZGXEGsl1VanhQKMwHXqYl/63MsfIYEdbWhqimzBi4tGh32uwlb6AwWCiqt8P
	 WDz9Oat+fpLhA==
Date: Mon, 10 Aug 2026 12:10:20 -1000
Message-ID: <07a6cb06c1edc43bee7e8a2c20661a2c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>, ElXreno <elxreno@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/6] sched/core: Make core-sched flips wait for
 in-flight selections
In-Reply-To: <20260810111546.GV687043@noisy.programming.kicks-ass.net>
References: <20260807210221.232543-1-tj@kernel.org>
 <20260807210221.232543-3-tj@kernel.org>
 <20260810111546.GV687043@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Hello, Peter.

On Mon, Aug 10, 2026 at 01:15:46PM +0200, Peter Zijlstra wrote:
> I'm not entirely sure this is the right commit. I suspect this was a
> problem right from the beginning. This pick_next_task() always had a
> prev_balance() call that could drop the locks IIRC.

You're right. The balance calls could drop the shared lock mid-selection
since 539f65125d20 ("sched: Add core wide task selection and scheduling"),
so stable should target v5.14+. The sched_ext fold only made the window a
lot more frequent.

How would you like the two sched/core patches routed? I can take the whole
set through sched_ext/for-7.2-fixes, or hold the sched_ext side until the
first two come through tip.

Thanks.

-- 
tejun
