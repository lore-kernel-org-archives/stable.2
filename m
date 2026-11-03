Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701614;
	b=o4rllJVTAHg/TWfWmvV8FIXLmdI279Civ3yODH5hSfvQ5O6zd8GZQvHqSEYuur4YAo9d
	 1AWLMkfrTVuwKtNSZ/ZJXMk8IUJYLsVH4hWBCiCjhftLYZKd1bSEzb+EfVoXC2+D3zMpE
	 nSxkMAstGpHO+6/Hjhi4BBoa1nZR97P5Ps8mL51BXtrhzR4vcWMfdI1XzkDVCNpbCvaKh
	 VayFf251VJ28xSKETFX6/gPrZUFmm9F3UPrj9q42g9XlFdXQfnlNnKp1HcS1qWCDNshi3
	 dhGCTG6uxW6aDmUR0Y/ceOoLIStyWoFhd+H+G0B7G0cnKrdkFbeWK8wO4Bc5TSgoQ6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701614;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pAA2pPk+afBztX5eNyJacgXN6L4iMe5ZdmO4GlWGlOU=;
	b=Xai6eoxqr3WDqV44SOZ5w/WesbVALQIgpWNE2VsmT63QDc9V2XoiAdwAo2BLr13wSPI+
	 wFbS91aKwb8a2ol4vJgm4prQtMl15XATITx5haqAdggoQq5COPbCmWIHm6DGhLfs2iCkC
	 omenk1nZfZpOSSXNTh7lMKIaBbuawsJ+EfafZJk+di/hw5nBSsEVcPXwX3yjjcL0MsTcH
	 n7FB0T8cwFFY8CZlUbflySRkNjC5MS88AClvBZsUMLzDAualay4e3cQxV9DUOdCG5LSKi
	 4h7P8PK6RaMJupn0aImzKNHgBggvaX0Ti3PmUV1xI409CEQCQgkENgee90sJBLIjLkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PdbV8+Lk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044E56085094;
	Tue,  3 Nov 2026 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PdbV8+Lk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065061F000C1;
	Tue,  3 Nov 2026 10:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701613;
	bh=pAA2pPk+afBztX5eNyJacgXN6L4iMe5ZdmO4GlWGlOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PdbV8+LkbSU0dBkU1ZEx1iP3GlillZG6aeaMT6VSaHcbzQpSOSkC6XkvQJq/TmdLy
	 z4KfogUMmWjvp4mRp8xHY+UYPnBQFTaQmcnnf++zBmGO/i13DuoTvO6Noi2TCjNQU1
	 LmcIUFajyT9ohOYAOe30dAWlD/M23NRd5OTwuBh3Q2zMpMDZpJeWdmixm0tEuqaMYV
	 HgsIWb3zvOR6PXu/iS6BWk8YPYYMijIiQrY0MpCletZ++IX1/w0EkKcgzAPcSi/XDz
	 GHvJSjlY6Hb+gZcC3gKXPdbDXVJ4j23LSn8liychsSMw6/8iM5xKiYdZnYDN+y5HEc
	 vLrNTGBudp4wQ==
Date: Tue, 3 Nov 2026 11:26:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: radio-sf16fmr2: Unregister v4l2 device on probe
 failure
Message-ID: <20261103-rapid-awesome-crocodile-2df15e@quoll>
References: <20261103094620.1289464-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103094620.1289464-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:20 +0000, Wentao Liang wrote:
> fmr2_probe() registers the v4l2 device and then initializes the TEA575x
> tuner. If snd_tea575x_init() fails, the error path only releases the I/O
> region and returns -ENODEV. v4l2_device_register() takes a reference on
> the parent device which has to be dropped with v4l2_device_unregister(),
> but the callers of fmr2_probe() only kfree() the card. The reference is
> therefore never released, and the v4l2 device stays registered after a
> failed probe.
> 
> Call v4l2_device_unregister() before releasing the I/O region.
> 
> Fixes: d4ecc83b79cc ("[media] tea575x-tuner: update to latest V4L2 framework requirements")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/radio/radio-sf16fmr2.c | 1 +
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




