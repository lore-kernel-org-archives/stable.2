Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2424E2F3C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592233; cv=none; b=Pka0uXGYIAMvNvlHGmie7q3mNd1t/Bfh3vyP31EQl5VCQW9WJNu8KRM2u3Gnes6OIb7B3oVUbMqBngkC0wrNdQZlxuAo0S7txXiY/r0MKPEuRJkTr43S3lIslZIqOGis4W2IDeYhyJK12Jt6H2/J3CnkYZXRWszUdTmru/CK9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592233; c=relaxed/simple;
	bh=RppVRDd+YrHzQvvZN1le+JYQpQjCQxKe0LfhqimuI4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3/Ht3PybNXPPJjrD85DamKclmC3fLcZ1+3PahuXRIwUvbKUAjWEeCPQ/iiibmjorXZw7nIBU3dl6nxDsdL+pv+wMX6+g5j/gOO4nOLdJaZh7lYKzDA6CZGMiX4A00JKwu8PCHQqv9QvzpuBXqEsGMUqNQvJAxMR51j1XNuYbDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuzGAu0W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuzGAu0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AE31F000FF;
	Wed, 16 Sep 2026 20:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592211;
	bh=EGrOX6JxGyGWgbklCme2s5kXALpwVHmytPQP2EpF3VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IuzGAu0W47aBs20Vz8LnRoKGZjCYM8itambybgDDlh9pC+8tHwUvPgS26lSzajhJe
	 ZqShi/ST6ctUlS8P5ZIXI+ZFOZn95pEGM//WuM6sUC90QM+pplm2+XA5zDilzs41fO
	 ApJIXIQDnTt/odE714dIngoQUHP+Hy9CYwoteo0nC2b1p4neA80bbzzHBDe9A6kfZQ
	 Lg21PzarTpPqygOFxyBiQHaBaCQ3vWEPWr94pe48T0ulPlqm+PZjG6YFO3MfUFC09W
	 famdIP2vv5DaV9O431RHG0ccJCVv/uaz8y/Vh0mEKw/tn+X1zL92ew/3Wdorvw7wXH
	 w83BCBfx33j4A==
Date: Wed, 16 Sep 2026 16:56:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: stable@vger.kernel.org, Daehyeon Ko <4ncienth@gmail.com>,
	syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com,
	syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com,
	Oleg Nesterov <oleg@redhat.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 6.18.y 3/3] exit: hold a reference to thread_pid across
 proc_flush_pid
Message-ID: <aqsCkQKOgLUtjml1@laps>
References: <2026091657-curry-myself-be92@gregkh>
 <20260916203656.2689289-1-sashal@kernel.org>
 <20260916203656.2689289-3-sashal@kernel.org>
 <E01AAD86-816E-4B90-9D5D-E4281573ACBA@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <E01AAD86-816E-4B90-9D5D-E4281573ACBA@mainlining.org>

On Wed, Sep 16, 2026 at 09:47:29PM +0100, Bradley Morgan wrote:
>Do you manually do all these? Or use a AI program to do these.

Some LLM, and some other tools that don't involve LLMs.

>If you use a AI program to do automated backporting, please add something
>like:
>
>[LLM: Thing it's done to fix the conflict]

That gets added on commits that get modified by the LLM to backport cleanly. An
example would be:

	https://lore.kernel.org/all/20260916204117.2702377-1-sashal@kernel.org/

In this instance, there were no LLM tools involved in the resolution of the
conflict. Instead, I took two prerequesite commits which allowed this last one
to apply cleanly, thus there is no backport note on it.

-- 
Thanks,
Sasha
