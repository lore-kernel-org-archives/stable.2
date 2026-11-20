Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795151850;
	b=vaQ7ypht08Qe2eIcNar/tBp3DF6kS/cZXLjqrUWQg4t5NlauKFVMfplfP5nIWYYg8Jvz
	 u0W+JL89YwiKr+R+OYlHZZ/hFsNbW8GHCMjox14m0UGu0wtFMgxZb5/gOEgrgnHt2n9ar
	 3em/r4NixhEkyCiLX1oGbsY9UpfFUJHOcs93XB69yZub8yO5AJaLCPjKqEAXjH8krbbc2
	 BCzksdy4bnFhEoLX4XqFKNi+8XmZy/prc4E/qWtVcHGvPqyStCNs10xtn5g7Yd5BMUL7O
	 DoeJXHsloIq6xDwk143LUZcdAwcs9RaQ1PuIyboxpj5xzjAVeFUk66tapYWQ7RtOT6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795151850;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SvBuBP47XYJip63bYWp3fEZzePA8WsLHGVeFJHwV+J8=;
	b=LfKQMVSNhip0r33sjFrE6wFJlkZ2yvp8jXon1VhQ6/awK07pNK7MH0Ec0QLS6EMOEbcl
	 CMiIPdt9wNUW1CxBFmxgTZkgKOUOJQFgEEVvEae5+a41+RNGZ9fIFinbhvTwScPwGmxwM
	 cMaD2hDQ5uV6fgjxcSRN3GER0Nz3QskD/gLdEqfQ2OW79kZ3+6kCWndaTaLZDvYME1RN7
	 qVc538yGoa4mp8gfGe4thE+Tq+T/olxSjnV2CmaQPgu3pHwPy1dOT9C8kbv/CTLrMNnmb
	 N6ui12KmaqGAJDUW5VZZ84aaIWlKXGC6g+/mNgvA7f4JlZz/D3Lg/Er5EDsLTX/UnWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=m8vcRLTK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9F606A320;
	Fri, 20 Nov 2026 05:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=m8vcRLTK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7466A1F000CA;
	Fri, 20 Nov 2026 05:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795151850;
	bh=SvBuBP47XYJip63bYWp3fEZzePA8WsLHGVeFJHwV+J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m8vcRLTK0SjiT4l+ZZF2dLJvNayzYXGBod7EiLMT+V8S2LO7DbDO6aP+QVKxK2U6u
	 9P87Ty5kDdXfuqsju2b2h7BrzGFNtYriY+FuyXHvUOkVpftYy0c835HH9oHwwqKDPL
	 Ut+0P9mYpPuR4XVdgYxF6ALImhm4tkoY42R4GF9w=
Date: Fri, 20 Nov 2026 06:17:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	Yufan Chen <yufan.chen@linux.dev>, dev@rebasedinc.com
Subject: Re: io_uring/eventfd: registered eventfd signals only once after the
 cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
Message-ID: <2026112048-paper-radiance-199e@gregkh>
References: <draft-agent5-0001-re-eventfd-signal@kernel.org>
 <5d92861f-9a4d-4810-8700-b9e457ed9c86@kernel.dk>
 <2026111605-deskbound-clobber-a4a1@gregkh>
 <07947062-2974-4630-90db-1556e25b50bb@kernel.dk>
 <avxLtZ2YLHdbeZxC@laps>
 <8e6c1d69-9910-4c89-832a-34ecd65a0ca7@kernel.dk>
 <avxPlrd77WiXagvs@laps>
 <8e8bd832-ead2-4d77-9ca8-48274637d26e@kernel.dk>
 <20261119203921.972086-1-sashal@kernel.org>
 <981f45d2-c38c-4ac1-893c-17ce3a8c3f0e@kernel.dk>
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
In-Reply-To: <981f45d2-c38c-4ac1-893c-17ce3a8c3f0e@kernel.dk>

On Thu, Nov 19, 2026 at 04:25:00PM -0700, Jens Axboe wrote:
> On 11/19/26 1:39 PM, Sasha Levin wrote:
> > On Thu, Nov 19, 2026 at 11:10:03AM -0700, Jens Axboe wrote:
> >> But apparently nobody looks at aio?!
> > 
> > We do :) Here's what happened with each of them:
> 
> Good!
> 
> >> Commit: c03ce4173c7b
> >> Date: Apr 13
> >> Fix: Ring mapping inherited over fork
> > 
> >> Commit: 3adf7ae18bf4
> >> Date: Apr 18
> >> Fix: Partial mremap of the ring
> > 
> > Neither has a Fixes: or a stable tag, so they're not even in a stable tree.
> 
> Gotcha, that seems like a problem then for current maintained stable
> kernels, where any user can crash it...

Great, then someone should have tagged these for stable inclusion, or
let us know after the fact :(

thanks,

greg k-h
