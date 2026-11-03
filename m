Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701620;
	b=fATPUCaDOOL9bZ7gG/iSdD4iC0QuEKTPyuOnX5o6aWsvJROtnihesODff2bcwK138Dk6
	 CcMDbfScBfDPf8kcrkDOOHR0rmpRdxz1QdjkDu7LnOmLiFuPjOt2vNnh85WW/FFzIcJWC
	 foa0DU8nLaW897QAERsDLD5261oeY0p3suWPAL+BTdwCWtYR+aR8yF61pjUl/d7dv3yOW
	 fZHEex8QyjEtcEeGr1UTuEONBAOdJ+snOWlKaQdBYhv0nmS/jJcelcdcI29xlh1Du9g5N
	 +k59yfJIIFvUJVuv9dVhyRbAGGibYQkbounOJv/b5bEaCc8mAncJ6K6OuLi2G6JZ89Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701620;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RcMnyr+QZreXmLDunbGYb1afaYzZsEF958MXJawqWo4=;
	b=jU8aasIqnyqwHsVetvTbAeQ/B96tjfNNABF92rfsgY1R/z5S3r+1u17ZaLuujt3UAXkm
	 y/6DfyAaXzNcZI+6cPRIhyV+UXmJTylP0CjDJ+RaHKTMEpev/DxahW5+L771GVJAwtCRt
	 6sPv83WjNBZoUUMbD0B0Zh+Z38EdG6R/2YjVLhHNpsxpN7xYRKAlh6UaKwztuwfeWi1Um
	 McC8S9KCYw3NJSewf70Wp0lGS9WhABRqLlQi3oJpgb5+h6wCMAV5XhpROuBlWgFsBKQMZ
	 PeA4Pybai4pCVJCZDfD0nE+2lhW8b06ViHACIF8hsxDYVsKEvM6uW0Hv7fc5h/IBTQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cm4ZB0H6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19777606C593;
	Tue,  3 Nov 2026 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cm4ZB0H6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A3F1F00A02;
	Tue,  3 Nov 2026 10:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701619;
	bh=RcMnyr+QZreXmLDunbGYb1afaYzZsEF958MXJawqWo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cm4ZB0H6xvIjRkLwWHZrUWyyBc0FJ+PTttq5RDfq4yuewGn7EE9KyGRoxJ328hYYc
	 Gsad/KkeMKRTb5dAEUjv9LCFoMi/OZpjQELOYLvTywguTspaAM/oWotQ/LPFYIHfYQ
	 u32u705QUwmxzD6pNADK2gs3V7lclzEJtmvwHn2IgikCJMBNVnHEBnd4vbiN1G5p+2
	 V+Q4H36KfhsLUyVnfN3S8PcaN8cjd0VO+D8NpQuXdr1tj5rlPtU7V76UYWBhjSolkL
	 GAQSI7BiUnh0GlMVVFs5HBevmkHmNnVfuc0QAMeI0RH7YBQYKtsWz0WejFlgDekFDY
	 whZj99QsP/3vg==
Date: Tue, 3 Nov 2026 11:26:57 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-media@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: exynos4-is: Free control handler if ISP subdev
 init fails
Message-ID: <20261103-sandy-giraffe-of-coffee-b4ab6f@quoll>
References: <20261103094616.1289357-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103094616.1289357-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:16 +0000, Wentao Liang wrote:
> fimc_isp_subdev_create() initializes isp->ctrls.handler and creates a
> number of standard controls. If any of them cannot be created,
> handler->error is set and the function returns after cleaning up the
> media entity only. The control handler still owns the memory allocated
> for its buckets and for the controls created before the failure, and
> neither fimc_isp_subdev_destroy() nor the caller's cleanup runs on this
> error path, so that memory is leaked.
> 
> Free the control handler before returning the error.
> 
> Fixes: 9a761e436843 ("[media] exynos4-is: Add Exynos4x12 FIMC-IS driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/platform/samsung/exynos4-is/fimc-isp.c | 1 +
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




