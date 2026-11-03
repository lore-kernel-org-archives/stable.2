Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701622;
	b=x2uTThTmlxpnuA1hFGrBLe8NSBbvaBdfGMUNRPaLHYQXKgCsMhES1MdN87QUjdbuOIr7
	 SYE7GHv3X7V1N03J/VMTi8SfPF86edEb0jnuh5Wbave1WW0x9tb9/L/hjoz4zNgscmYmr
	 XRug+RFqppl0VBZpWuUKxU9SWe8fcY/oMy9BoRHILOmx3qMJFmSE8Rv2XJQDsIFgVnyNe
	 EpTzvwXb05BwwtoZ+izwOd8SVh2cb/QAx/4OrjP1G7FOqqWPvlnvp59sZXRAq48np42Qd
	 tdijn+DhZ/OffGEVgRw9CA4EoO6HaRKH3HhKuECFTZ46lmk2GGwp4g5Y6HuvouwwzFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701622;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Kscpnze2DihFqQD9KJv4DVZc3CpyOiRtlqpKtxfOoeA=;
	b=IjCCY2Dq74ajfM9dKciiYSyWK2C/H7idEwALjp84s8ZYLwCSNz9yt08o4B/pP4J8zScI
	 BP9hsBDZlxvKUUY/vRt0mc+gahaLheA6DTn7v1MhKIfWJpaujzG1TWF8jzNd0xdMKq26k
	 Xs7xSVyb/KdAVPxOPm0AtuLkcSwZVO3d66We4W0Ig+KHOoqCS2I9VI/pFeg6Jj4c07OSZ
	 YToZc7WMe8f/1/7wxsA5Hb9o+Z57kATBwd4MCpmTojMTWMj8QrFGTrobNdMQ6TspTt7kn
	 QfDW6dGkEXVfu3PBz/iYEDKYCh7skIS8dscYEy41tgA2fiaAa2nZHQ7unkiJFT9wxVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XS1GXljn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E6860850A0;
	Tue,  3 Nov 2026 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XS1GXljn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FA61F0093A;
	Tue,  3 Nov 2026 10:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701622;
	bh=Kscpnze2DihFqQD9KJv4DVZc3CpyOiRtlqpKtxfOoeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XS1GXljnAKfkvxZdnKyj+KiEIT7Ry0hKN51P6osuui0Nfbax0JhpvujzaC+DzNu3F
	 EP3E1Jx8Z27pbx1ni92MuctOFf0VWtom7xBbAoMvZhTEBidkSeFaOeMfIHNWB38PTY
	 dWWlsMDdYNuX3CrI2Ta5ZZM8RWW6FnItzUy9IWYpqd3lXtA+5kkXsXOKucVl8STtR6
	 ARFwoz794BQvF3RAemMvsEYRDx4hdFU52smlLqIRlTmEH8jOuo4utpdQl+2U1brOUE
	 KluSSN5cfUNBzgizZc8Kt0Ud9J2OibSlfrEf3WweEqxmmYzdxfXf9zsx9Ju+B9RIrO
	 srZYTA7r4yTXg==
Date: Tue, 3 Nov 2026 11:27:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, Hans Verkuil <hverkuil@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: radio-isa: Unregister v4l2 device on probe failure
Message-ID: <20261103-aromatic-strategic-mastiff-e62aa3@quoll>
References: <20261103094618.1289428-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103094618.1289428-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:18 +0000, Wentao Liang wrote:
> radio_isa_common_probe() registers the v4l2 device with
> v4l2_device_register(), which takes a reference on the parent device. If
> creating the controls, calling the driver's init callback, setting up the
> controls or registering the video device fails, the error path frees the
> control handler, releases the I/O region and frees the card, but never
> calls v4l2_device_unregister(). The reference on the parent device is
> leaked, and radio_isa_common_remove() does not run after a failed probe
> to release it later.
> 
> Unregister the v4l2 device in the error path before releasing the I/O
> region.
> 
> Fixes: 137c579c12bb ("[media] radio-isa: add framework for ISA radio drivers")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/radio/radio-isa.c | 1 +
>  1 file changed, 1 insertion(+)
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




