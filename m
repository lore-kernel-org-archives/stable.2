Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794086795;
	b=ElU+YKUnuSDJCiflXILr7syMMlWjrdxIZheFYKJNsxXoG6m8hppySDCY8tr0NAYjTC9P
	 iRJhpISvyH5mzphp6MUySi6u9zHE/H3yabLccnnZ1uk549A2Qav6QJNajVgUjOigBTLSI
	 5mxiyeLXo+a+glamVaveIdyyMQXrrlwTVQsxNgPOnJncvMtehk45aKK2QZ0Ftv0DFs5s4
	 NXsP3xlatkd3WXQyIDTAZYHQKRZTQpjCaeFPuvozuW7FEqyf4IT/+9ZczMrdWXc3d+LWJ
	 XRYRfSJXOoFCINMF/hcebEs0JFWB7lQNwUJbdxuWG3hLqO4ZQQm/5Kta9bvKXuNR90Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794086795;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=69MWQh9fCfHjWDR1xs54PIi6M8hjigsYHAcOsJGTTgI=;
	b=5PTcfSEoCTz7413XinXQMr1nrGbZN065CXbGe1fQOy3yzTR3KnNmP9B58OHQSRAp5VAC
	 WPFhETUompJh9eEucneFkRFaN91nZ6RYUsKoRBLbevzG3ssexyg5FiLOAf72Gk46h/1Y3
	 FiFyoEioM6mO2Gx68hPIa/+ZhwLbTVpbtPmeCQs3WYWpMsyc/9JdG7f0bYmOfcsRwc1oc
	 yRfRqESXv5qfgOhYxnwD1ktFblntusCc96uOCg8wYwWHshxqSpmT4msNRyljQR+QQUq+3
	 SXCOmvpNKPzXjN9sypDbEWimy+y4vnvZCJ10W+v2wBO40OK3Sh9IpMfumzjoa7p7ERQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndlSdUQs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E1606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndlSdUQs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832711F0089F;
	Sat,  7 Nov 2026 21:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794086794;
	bh=69MWQh9fCfHjWDR1xs54PIi6M8hjigsYHAcOsJGTTgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ndlSdUQs7oWac0H8X0Bvsj9nKrqZ1RpCcLV8sncyP9XeYChP47shNtXJYhf+cwM8b
	 20eRA9cTITUAxFObwhJ7UaeQagbixj0dYE/AMY140g8eR6aBW7JM9whDIE/E/+UItf
	 qs9Q4+yuIL2okY0m7GCp1yXuutrlcHZ7bs10XGRZqWeaFyVhRCHTRAqpR+scj2UcM/
	 YR6JyKx9BZ0QffAvxS7NwM/YgIEayAx9OIrt/H10rx8vO93vbo7ebm94pizb0eU43h
	 9EGox5iYJnDLwcHfRV7oexSyfruGzOgN8ZWcIvBkuCcLBeY59uGHiJalbpima4gVv7
	 tItqxf0pD3NHA==
Date: Sat, 7 Nov 2026 13:26:33 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: aalbersh@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] fsverity: Explicitly require FMODE_READ
 to retrieve hashes" failed to apply to 6.18-stable tree
Message-ID: <20261107212633.GA137269@quark>
References: <20261107051544-failed-6.18-1acb4fd2d011@kernel.org>
 <20261107190447.GA6049@quark>
 <au-Ux9Sunxhat_jo@laps>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au-Ux9Sunxhat_jo@laps>

On Sat, Nov 07, 2026 at 04:14:47PM -0500, Sasha Levin wrote:
> So I feel we have had the Cc discussion quite a few times now. We really have
> to limit how many mails end up going out: this last release had thousands of
> mails which took hours to send. Adding more lists will simply kill the mail
> server and will harm everyone.
> 
> We have solutions for that!
> 
> See Konstantin's writeup[1] about lei with filters like dfn: or dfhh:.
> 
> We're not going to change this on our end: the kernel.org folks will complain,
> mails will take days, and people will be grumpy at us.
> 
> If this is really not something you can work around, then we can figure out a
> filter to exclude your patches so that all of us can continue being happy going
> forward.
> 
> 
> [1] https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started

I've already started to use lei to work around this issue with the
stable process, but everyone else will as well, which seems unlikely to
work well.  This also effectively means that subsystem mailing lists are
deprecated, as some of the development process is happening off-list.

- Eric
