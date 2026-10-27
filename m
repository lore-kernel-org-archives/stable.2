Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059585;
	b=kutnKJvPVFwZMPtiW0LyD16M7uyz9Qw0THIBp+ohi2ohPwiYe/REvIm4d3xnfiQsQHvk
	 247pvnN5+vEDmk+IgdFGOd/mA6aQoeaWltIUqvjp6ABoiVuFDbup5J2bmBqbiMUVeY20l
	 1n9Zv4QK2uUWPQ1QYxTOSa/TQfphU9zIIXHgeNfk3cNgZFX6QFMWkhRCorbqyB4T1XdB/
	 dFLTqoJMuci1dIbsnq/WXRtKhFm5bbm7nHZcgPCgSe+6NiT9sHcTghYGzuhJrx+F5MC5k
	 2Ps+CYdBAOKO5JMdFY79BmlieqHNTwBvgi4TYIqRV9TRzXLwlYv5SBeE6UjvC9BYxIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059585;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H2Ogge+YlKva4/OWSPzQ/Pw5emMiiypoqA3hsC0HokQ=;
	b=Ec3OqXXDvRw+aWLs0dVIWM9bg3Gs3ZkxjZUr70TOSvzaXntm1xqkGiu1dvX3vldS3Cp+
	 rp38R2S/b1OnMMQzanlF+GPlfGxBO4EjG+efMHPwwb1w357PpRS2EHvPUC6JIezusu4uO
	 yyVptUGbWdHpwNcCmu4/mHYe2k1rw9ZR2wddr4EY2QZwXU/ALd+Ar/24+J4FPCuH4F/8z
	 DER5Ir2nh/+9BNx9C0ZqcrGr4d3IUOpvPMLhlSbaDbKNmv1uixeJmh1jFylrnMDLmXiKZ
	 aSani0mrac5sVBu/9IMLJuw4U5Ee0CHmqqqKFPCpKKWIvrO+9I8yvzAI0lQN30TLHbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QkOLfMlz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E89606A31B;
	Tue, 27 Oct 2026 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QkOLfMlz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80331F01825;
	Tue, 27 Oct 2026 00:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059585;
	bh=H2Ogge+YlKva4/OWSPzQ/Pw5emMiiypoqA3hsC0HokQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QkOLfMlzsLkpneHFEytiK8w/aQUdinJpiYzkmIALzAiffAzFQZHFg0Zz2qvDNf5ee
	 BiG+Rc5BBXKvxTAEy59IsDTRWONsE0lNO11uHExhNujpWgyFGqWsKYEKI9CufpFt8r
	 7y2IwMBMO6WjzstMSXar5n9XF62FL/kyEEt2jiOOKTOiy5GLlFt6gqDl1Xvd1mp05D
	 ZvvvTC/TGyXxOpV7VBFRxz0qDtSlnFvfsfED6SPtLTnCoaMl538sj2OvNUi7uR+S9r
	 K4MKfM4bNZYGFA8RLv+4vOnHzOtSG+v6SlElUYPLcq8D+mh9r6FylgfvPQbxRhgB3f
	 AcsRc7JFGHZFg==
Date: Mon, 26 Oct 2026 20:06:23 -0400
From: Sasha Levin <sashal@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH 6.12.y v2] mm/damon/core: error
 damos_commit_quota_goal() for zero target_value
Message-ID: <at_q_2pemJCnUvBZ@laps>
References: <2026-10-26-1-daily-reply-0007-damon-zero-target-value-6-12@kernel.org>
 <20261027000120.156623-1-sj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261027000120.156623-1-sj@kernel.org>

On Mon, Oct 26, 2026 at 05:01:20PM -0700, SJ Park wrote:
>Hello Sasha,
>
>On Mon, 26 Oct 2026 18:55:58 -0400 Sasha Levin <sashal@kernel.org> wrote:
>
>> > Also, the upstream commit on this stable kernel can fix the issue for
>> > parameters commit paths but DAMON start path.  That's because DAMON
>> > start path does not invoke damon_commit_quota_goals().  To fix the path
>> > with minimum change, add a new small validation of quota goal target
>> > value before damon_start() call.
>>
>> Queued for 6.12, thanks.
>
>I'm sorry but could you please unqueue?  Sashiko found [1] a bug that can leak
>pids.

No problem, now dropped.

>Also, could we avoid queueing DAMON patches that marked as RFC in general?

Sorry about this. We don't normally get RFC tags for backports so my brain
didn't register this at all :)

-- 
Thanks,
Sasha
