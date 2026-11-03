Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704251;
	b=YQoFmEKX3wtHyxnZsnDgNDDebhLplnYtEnvuaGXdWabGwiQV0BaC6iBcFgp0J9iYW0v4
	 k9grtfUVE3d00SWE3Ptd4TR9n2BJM194SCoBLuvs32+DZjMQMw/rTr4D5fOF0O0nsrc1W
	 uXWfICLE4Opjqy4/FQ68PoVzu5qcg80/E2HUPoKcQelGgGWQ2ZDXhycpDbf4mnE9PODtP
	 bzLwY213VTVveig2495pyFqrOd1OWhTCE/uckeLd2ivj3hCVk5x2rL1PEn0nRC1WZzBaE
	 aUNIBESzg3ccYZ4kqmc2DKYygYWwM/DDWehd05KaM9tud0uHPejrulvoclosloaECHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704251;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Yc/4P7ec9sPrnhW8lkXuZcqIhw+ZPNV2m2TwlrjiYjg=;
	b=e68/fIJle3SqJsqkLUne70GrJZ0yQw/TzdxCWIes5N1QC9UVpwIVGaPpsMyttuS4VwWg
	 rLKCi5a61mPiahSiFjVhcgWFDstka1+n3MD3O26ElJlaKAArJpYj47KIjpRmht7+cWTgc
	 zOSFSMZ/IW6VtYnA3W3io7unGFpEUtWjllswFBMIi3EiTT5clXdUuw3jw9WcsWKVIg/83
	 c/hnKPfvDOMLRPZ+gfIcnWYOFtgH3vDckCHZ3hzgNmLtVHT9KxS0RE1SF3M40u1y7LfId
	 Hy04GhYjuxVeDdWMfOK/2DkCBvyZ8SUAb2w0bPzVmsdOhfx10p1pXhk1E63Ds0uN7WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJ1UAi9m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060E60A2606;
	Tue,  3 Nov 2026 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJ1UAi9m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916191F00A15;
	Tue,  3 Nov 2026 11:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704251;
	bh=Yc/4P7ec9sPrnhW8lkXuZcqIhw+ZPNV2m2TwlrjiYjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XJ1UAi9mpNneNpGrFngBKLnAAQoITDGDRX7v4IG7AZyyyfA42cWofmwPqt48E9T0a
	 PLFWJv1Fu0Cs/qHNcyuY/WlX0vNKRz+zKevKXBB8/nqvidQOt5fEhxt61ey9kRtpNM
	 2SL4Q6Ie2OlnP8ByQ02yVZGsVN2w18YJ4bSSsDV+HMKrIXWAVRSN7S90a6SIYd+1qj
	 NwOFh35Q51WmE8OnvtWaKpggB4ojxT4poaHyuP3bdr7nQVvOkJQvkhPh2pgfXZl9C6
	 YxHUylOq3PVySM5dT05rNQPguMH/gTn/GskVIXQy96v2f0HuaiDxMYWZQg26+342Lj
	 14i5bqImHsfYQ==
Date: Tue, 3 Nov 2026 12:10:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, stable@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: cec: extron: release the v4l2 device on disconnect
Message-ID: <20261103-crystal-auburn-bug-b75e9e@quoll>
References: <20261103102850.1340434-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103102850.1340434-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:28:50 +0000, Wentao Liang wrote:
> extron_connect() registers a v4l2 device, which takes a reference on
> the underlying serio device. extron_disconnect() never unregisters it,
> so the reference is never dropped. The extron structure allocated in
> extron_connect() is not freed either.
> 
> Unregister the v4l2 device and free the structure at the end of
> extron_disconnect(), mirroring the error path in extron_connect().
> 
> Fixes: 056f2821b631 ("media: cec: extron-da-hd-4k-plus: add the Extron DA HD 4K Plus CEC driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  .../media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c   | 2 ++
>  1 file changed, 2 insertions(+)
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




