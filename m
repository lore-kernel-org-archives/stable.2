Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969521;
	b=mR8ftTcATpbLwfThIfPh7+YgLDIa5seLkFnbGVizkas4F4rfdLORjNFGW/ZvZNTvAGys
	 RhPi44AAK3lXoEZX1aB1UHIIBJ/JkHY/l1IFuchABf+oBRAa1kYYEJXWclp50ni7MUZyv
	 E93g2wZB5OMTPpVzEj1eE6fN98M98yoM0sQOzh9f4GKi8+m6A8LcweFkNGSxZXrkaGuuh
	 KZlWGWOi5js8MiYC5UrLut8k5FVYdavhdPe/yEWvCtusQgo0CQe6HYajXMxloRIqETYl3
	 OOkNGPTXZEB7rdcF0hfj0ohfhKLxZ7A++2nRQt9bgSheiU48VrmgCzcy2sA2oU7Jppg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969521;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=UojQJjLQNvXk+5B0a+UP65mEhQAd42ztdOq8LyS7tRjUGNqsEOz4JyjMRsdXgO19pV9Z
	 vwFNwdcG2yKYjkbwTzJYcyAWmFi1UwCyNy0zlEtQKSfrN30Xe3aDqTZWF88cZS3x/ca5/
	 z4paz0ceCBRWzOEkH5XAqvW7odtHYbA+1FpVTo+GPRrElsF/l6JZN9unqKDFLm8JoVLGX
	 rSTRrqCzos7KZp9uuJksBtXXQ0cxZM0AbdL4vweOtaisMyPFMbIwEn6IUvwCEr9jIhEP9
	 fplvwF0QOU6NtRy3uX8/lpGRqJVi/JsdFMdZlNaVSoQ9fQ3lWM5XBUgUsPCKzuejmNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNkB8maR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5F606A329;
	Fri,  6 Nov 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dNkB8maR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941B11F008A7;
	Fri,  6 Nov 2026 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969520;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dNkB8maRDD5sk7+SeIaDMFRc9m/oHDU4QWywBPH22fiCxajQXRBdsQdsQTcZ9Mz5U
	 ZTrjREREOoNX3Y7Fmb1rZRcMmbK+H9iOCxwwr2CKoc9lo4kCHsbo6mYM1RdAfEv+k1
	 8VNmZgxu3/D+QO6kcJCogKJh4C7/nlWpeQt3wICkWSFUs5O58qidKReCxBTw1oUVLJ
	 11ER189MKk4N8tFUzOPEelSWHvCqP4XXi0RmRQXZlDEgJTu7PrXcNnasjR+l9hQUo1
	 +K8Ah1wbHVdU2s00NPG6Ejww4AkxidWnOskryDuNTDhwBN02lNqLD+d1fn2oGNZp4C
	 6D/M8jDYo1FdA==
From: netdev-bot+sinfo@kernel.org
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, n05ec@lzu.edu.cn, ylong030@ucr.edu,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sashiko-bot@kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] vlan: prevent cross-netns MII register writes
Date: Fri, 06 Nov 2026 12:51:59 +0000
Message-ID: <179396951913.488859.6939446723200882827@kernel.org>
In-Reply-To: <20261106124639.12584-1-dennylin0707@gmail.com>
References: <20261106124639.12584-1-dennylin0707@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
