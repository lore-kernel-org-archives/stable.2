Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831E46A5F4;
	Fri, 28 Aug 2026 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928892; cv=none; b=McynGhj5TE3z6d8nSvEOSD/4LhjnIkyxRk1VTVjy9Yzt8tNW7dJWK9MB1D5HaQL/wNbUzkUj4vw1MW8nypklfikJ4Ub3YhIlfdu/2qjIWzEGAsRJSrn0CBafC+tKdnBmCLTu/u0OuzfIBw1DQzNtEbFyoXBmSxEm9snBrM1VxEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928892; c=relaxed/simple;
	bh=Qi4fq5yRDYCm5yxBv2eI7oZYhUMCLweIkaX7hT0TbyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuQzfgKA8tWi9ntzh7yp9bJsbFFc940uee5FV7d5Cnox89HJgzpwpwqCNrBieeVVEW8WbiuDFyUKsrSRaOLUUS+KGnkggwZryiHtXsM+xreEOiFuYdY0cGxG0KSHZzoxxzsYlu+BPJurYVZM/bGZ54aZbIj8QCehfZN45O/LbLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVPmzN1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVPmzN1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0C51F000E9;
	Fri, 28 Aug 2026 14:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787928891;
	bh=afwzFz6pgw53RO7iRa3gPG8Bfet+3GwiW3Ldk6cTG3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UVPmzN1jqFjyEIF7uanEuZTXI3HpY1urU2eDK7IvUarAMM9v0W+P3WoohDmZ4lrIj
	 69Vl5iTP6p/XzITRAEsZMVIAZsvw/mMXKtq50hNhk2RRm/X9Sgc+3kqBHtzsgNrVri
	 DT7wSSfiTe5KyzsX2y+2uRFIDzITbyz5BbEIaaigJ4sM7K8YagTBOUianbXwcCsn46
	 +LlYMWYaPrGqseSw+IeEOyIEB+x2UoUb6h1w5lxinpq+ZPQQhZChJF+zje345WXxWO
	 UGMCHyZSrEL84ykBG4MdLm1LKMfFTjAcOxkBeFiJYKPyx5GXyEpEw1Mdh1PCevRR1n
	 h083g2aecb6VA==
Date: Fri, 28 Aug 2026 10:54:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org, asml.silence@gmail.com, vrazdan@openai.com,
	krisman@suse.de, io-uring@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Vishnu Razdan via B4 Relay <devnull+vrazdan.openai.com@kernel.org>
Subject: Re: [PATCH 6.6.y] io_uring/io-wq: fix worker accounting when
 canceling creation callbacks
Message-ID: <apGhOS6PQwdz1JW7@laps>
References: <20260825-stable-io-wq-6-6-y-v1-1-c9f890168485@openai.com>
 <20260827-stable-daily-0011-io-wq-6-6@kernel.org>
 <ea042ae2-f3bf-4f3b-bfaa-9a7676a9b043@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ea042ae2-f3bf-4f3b-bfaa-9a7676a9b043@kernel.dk>

On Thu, Aug 27, 2026 at 08:02:34PM -0600, Jens Axboe wrote:
>On 8/27/26 7:46 PM, Sasha Levin wrote:
>>> Decrement nr_workers only when the canceled callback is not
>>> create_worker_cb(). Continuation callbacks still release their reserved
>>> slot, and both callback types retain the existing running-count,
>>> reference-count, and create-state cleanup.
>>>
>>> [ Backport: retain the existing wq->lock protecting worker accounting. ]
>>
>> Queued for 6.6, thanks.
>>
>> I also used this patch for 6.12.
>
>Thanks for doing this - and I'm assuming the AUTOSEL stuff is both
>adapting patches so they apply, and pulling in prerequisites? If

Exactly! It can also do minor adaptations to the prereqs as needed (think cases
like tree-wide changes).

>so, I love it, imho this is exactly what it should be doing. Helps
>maintainers out a lot.

Thanks for the feedback!

-- 
Thanks,
Sasha
