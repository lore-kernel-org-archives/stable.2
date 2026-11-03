Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701635;
	b=PRSj52V/4ZU18hqNaZ1JjYm7JA9GXKnmsP5+ix25pJ4wmzWWyLqFboOJpAOF1VhXLLgs
	 2RKymoteH9Dr7ZhmLCgtg/j7ADW3QpneuI72y+h1g9M7nvGgS77cTo6LIJqb2uoUk9oBH
	 oeLckrD+IDcl9lSrmmJl7P9nyEvr/4Rl2Byp/qnSC+QjpZRrfvds0YeY3W4vuBR9V3JLZ
	 n7q9br5peexF+WtgN2cxF5NjiDoY6pxWuuzTf4jzHtbmLH0B3pn3DfYHieXxOvbrTWhi4
	 hrJHenDpWCoXd18qGwizv7LObKClTf+oEBhTA7vA6EyWaN/EI3lXOcDaNSLymvR8JoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701635;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dbBqPt54DB+uHD8qf9foSNr730yTB0g2zDUcRBZu+nA=;
	b=jJzzeyGNxgy3Ij8XeVD7zKXhOSYSbhW60Mcv+1gxL+DKyhDk0Gb4noPl5VGydVcOL1vx
	 vof3fYB1Rs50XvaiPUnjMZalDYqJAXHtOKOayiGlNDLlyYsb0ICBFeSH4dtL+zPsxh71S
	 FdiAMOOHR3MkU+uj5gUbByGOzCsUIqre0UXI8M6SquDoHo1p8OdTDIyeG3x4ziINoFeTt
	 OiK4kUcoE0xQ8HwENNee4y92f4ljr7deUTRQYiG/psJDPtmXD4atbgfk9aqelh/S0bPjg
	 ruc6qFvYb2D9gvp/ktXcZ567We6svaiP1bM7rNcEsE5eLWumwz20hLc/YoYdmPJAvQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mss+YYjW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9646606BF9A;
	Tue,  3 Nov 2026 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mss+YYjW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6881F000C1;
	Tue,  3 Nov 2026 10:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701634;
	bh=dbBqPt54DB+uHD8qf9foSNr730yTB0g2zDUcRBZu+nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mss+YYjWny72SIbBtkXm9foHyh0guibPm4/sQJ7QhliljnEPweWGI2OHXWqoL+DI2
	 VIvS0i3NmPHhHCTBW2PvhBszbdsBQkD/6EPx4KBT0hmZ9Mddbg7ua64ThjkluuNmKZ
	 K4oPhf7H8uiFSSnf/RGN2aObhNpLBYpgMVYmZTktFwx80gr6Y56ag82jMKVSMpbJw+
	 fB+pwdG3PS+vVdDVfXNtwxzoZnR/K6m1+BX45SgTSGp6PBSUQbI/J/0aaJSG+Bwsr6
	 Qqsized+zutyoWs+M85R+aadMWKC8o7gBvWpPW/dF5hxIeKQZpr5plHUo5H0nXQzm1
	 thDKFBZxUIyXQ==
Date: Tue, 3 Nov 2026 11:27:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-media@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, stable@vger.kernel.org, Akihiro Tsukada <tskd08@gmail.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: pt1: Detach the frontend when registration fails
Message-ID: <20261103-innocent-kangaroo-of-foundation-906005@quoll>
References: <20261103094615.1289328-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103094615.1289328-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:15 +0000, Wentao Liang wrote:
> dvb_register_frontend() allocates the frontend private data and sets up
> two references: one is released by dvb_unregister_frontend() and the
> other by dvb_frontend_detach().  If registration fails,
> pt1_init_frontend() returns without calling dvb_frontend_detach(), and
> the error path in pt1_init_frontends() only releases the tuner and demod
> modules.  The frontend private data allocated by dvb_register_frontend()
> is never freed.
> 
> Call dvb_frontend_detach() before returning the registration error.
> 
> Fixes: 4d1f413e820c ("V4L/DVB: pt1: Support Earthsoft PT2")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/pci/pt1/pt1.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




