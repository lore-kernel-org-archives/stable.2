Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120764;
	b=uvb6wzg3mnp1CVAQgSbxHP0ifQDQMvV6gvlEqr4OG9H3o7XsB0kumT6n8q4M3vFdaG33
	 qMSPBAnTaZ+d7zLFd1iOUNBYldBuMq66i71YRutFNnI/OdsfVUGc7xhI+vRVy3dHDKm3L
	 lR0Ebts8pZoYZ7gE4ns7KHGjKiKTjv0HgUTlLP0YsAyORjjKmIq/UhFcLab2rcPsBZAPp
	 S+xTYIfkVx6G6iYXdCXmxUdhL2dXmH6Ora6eSxAWUcHGlkDqjmr91MGROL/ycRnDwyS5N
	 iMvBaxcm4nODNZsyai3ULYq1J+HBZklUprwE4a/+JBQLRfdzCefvUZeTHeXHv7sQuiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120764;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=NiJG49YIGt6cGj3vHRjvqFXGLnaGbrbtoOVYPf7BcqI=;
	b=pqaUykibfb+CHZZWJYBxoyFUWiCA4e2LmwddmXLydJOlgw82ZErcy9BIRvGp6tZqcJHd
	 IByM/wn8jpvw2LsNb3Gfh/btw2RWQrpa10kNIfXPi5cP86El87rLfUlo26PThwdbmLawR
	 I6/wUOQladLZbuPfozleQJX6dzgG/QA1xAR+BRssqlybNESi9lCW7/1UfPPx0EFSXGA2i
	 HotFJO3v9A7T/WhSJ3Y5aA7nCFkGo4L0O4hYWSTcKhXO9XRMwQWPD53GuI02H5AHnWXTm
	 VrfZorUKtOKFnjypNMCUrSTFpMHst4L7BrmvY12g6mycXbTGPbtIovNAkiSZ72D1e2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE2vjouc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33849606A93B;
	Thu, 19 Nov 2026 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE2vjouc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237021F000C0;
	Thu, 19 Nov 2026 20:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795120763;
	bh=NiJG49YIGt6cGj3vHRjvqFXGLnaGbrbtoOVYPf7BcqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aE2vjoucHVMu99mqIHXkQMpgcCdBKjdSn1nEJf+7ZQv7NKNUnC1I3vzp0YXgewM8n
	 ibPydMHLMBCvLApdiaN5OGORQszcuUtfhEsi20qdH26K1Z2knbrtM8j+FfbXb7aKQG
	 Two08rO5aFGERZ/ISMTXfRdFbURAFFSlXhskC96Z68Xj4zH7hEgGDT6xdNg5vzp68V
	 ThUpdEvk01ZTO374LwIyTg77b8wazmMpskGilnnZmbShiXyE4pxahd3LbYQJNwW2Kx
	 ONkqkAsKQ5O9fbHQ1vhHPUvvHQz6mzRPClOGsYg+62IGbURuUdc6PnJozHJMqCnD19
	 qJFwvGm2/vdbQ==
From: Sasha Levin <sashal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	Yufan Chen <yufan.chen@linux.dev>,
	dev@rebasedinc.com
Subject: Re: io_uring/eventfd: registered eventfd signals only once after the cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
Date: Thu, 19 Nov 2026 15:39:21 -0500
Message-ID: <20261119203921.972086-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8e8bd832-ead2-4d77-9ca8-48274637d26e@kernel.dk>
References: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com> <draft-agent5-0001-re-eventfd-signal@kernel.org> <5d92861f-9a4d-4810-8700-b9e457ed9c86@kernel.dk> <2026111605-deskbound-clobber-a4a1@gregkh> <07947062-2974-4630-90db-1556e25b50bb@kernel.dk> <avxLtZ2YLHdbeZxC@laps> <8e6c1d69-9910-4c89-832a-34ecd65a0ca7@kernel.dk> <avxPlrd77WiXagvs@laps> <8e8bd832-ead2-4d77-9ca8-48274637d26e@kernel.dk>
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
Content-Transfer-Encoding: 8bit

On Thu, Nov 19, 2026 at 11:10:03AM -0700, Jens Axboe wrote:
>But apparently nobody looks at aio?!

We do :) Here's what happened with each of them:

>Commit: c03ce4173c7b
>Date: Apr 13
>Fix: Ring mapping inherited over fork

>Commit: 3adf7ae18bf4
>Date: Apr 18
>Fix: Partial mremap of the ring

Neither has a Fixes: or a stable tag, so they're not even in a stable tree.

>Commit: 398e3fa789aa
>Date: Aug 13
>Fix: eventfd/epoll recursion on poll

>Commit: d53b5aa5cfae
>Date: Oct 29
>Fix: Fault races ring truncation

Both shipped last week in 7.3.4, 6.18.63 and 6.12.117. My LLM review
flagged both as CVE worthy. The 7.3.4 batch hasn't been assigned yet.

>Commit: b44341e39d85
>Date: Oct 22
>Fix: Request count overflow in ioctx_alloc()
>CVE-worthy? Not in my opinion.

Agreed. No Fixes: or stable tag on this one either, and there hasn't been an
AUTOSEL batch since it was merged, so it isn't in any stable tree.

>Date: Oct 30
>Fix: exit_aio() returns before complete()

I'm assuming this is ac4b449b39e6 ("aio: don't let exit_aio() return before
complete() is done")? It has a stable tag but only went into v7.4-rc3, and it
isn't in a stable release yet, so it hasn't come up for review.

--
Thanks,
Sasha
