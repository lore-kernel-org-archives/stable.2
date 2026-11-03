Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697680;
	b=jzUuMWcn9UNc9gKOEvJR2tiyKF9H5m05uK6O8QpOJQVlZXeCYcgdBq8c+DAPM8DQxsfn
	 ew4aFvbytsOXdT5IBEkU5YfXEmQP8zPkiDTS8kC+6Bya0zY22jVoOR2H7b4Um3r5NaGzn
	 I/ar6GBcWAxcsxaUyvoVuerhA0zi8eZ86/PHkFqMyGf4+c1BLoC992iVSOsT0KmwzhW3i
	 wUTkKzDl4Ptbe4wiLexK1X6d1O85wGnjg1HMvJXAukx1WvRh4ge/UUx8Tr8nRhYlyGXJS
	 pLLlfECIU9XQuZJglpgMEy4HNHfqBLJu0s67EwoC8xyWyisI+35rzePs8wUWLH2kspA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697680;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8ff+Ldb+j3rIyThs2zVt58hJSJJjlNUoF1vfWcjecx4=;
	b=4e4RW4h1OZS3IbHLVblMRwYKjHivTwGL8n8of7nKaH3zqD8uoLt2nGAisasuPb5rQz3L
	 dptYTjUnRf1d6hvab+S/uz/RI2ohDEiZIV02DR9Dc/1vnuOCcYf8cG/B+31ZKnT6uGdbl
	 sVS8F7lG3MXfDA8Xnpguo1q2+lOjbDHuEUOHw7Bm81UXBQ8aR6v+VgIwpU0LjUoeRf0J6
	 YuoMN5PfZ+xcHqm0KkZFZ9uqVojXpOn2EsBRXsVMv09QPUVqy77amZ3WXJYJqqFsCrpX7
	 tHyem01kImzQlPo9I/gNncS1p1J2k3FqpD8UctVe+EWbnnYVyEtxJbvfD6XEBy22Pow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWfFpU+a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CB606A334;
	Tue,  3 Nov 2026 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWfFpU+a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910D81F00919;
	Tue,  3 Nov 2026 09:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793697679;
	bh=8ff+Ldb+j3rIyThs2zVt58hJSJJjlNUoF1vfWcjecx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jWfFpU+aR4y2vaJG/o8Zxih+deVBBi55FV9p9y1sP7KWAqD+Gnf0af1aJw8T6QWId
	 02cEEwKtjpVCEUl2mZ6jOGTQXVkueZb/KOYJ6u0ITXYsYuTF3tXLiJW5m4U6kCoMFo
	 F66SVUEIAEn0J9fVkYq8RrOMFOk12a/19FLi98dVylfY+GIdVWStW6x4IziDKUHrJL
	 Ajaqsw1sRZUQZuECpUPFRUMrNLF+utaRY4I6+wCRL8bHqq+zvp4dDdJeBc7AKjwCDF
	 P2xHglgbR+uw0aqQWbkye2ONpRe8ZN4T8GAcUUOel2DmyxOdvUrhQRns/d+pDj8+ti
	 ckh6EH2nVbt9Q==
Date: Tue, 3 Nov 2026 10:21:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: peda@lysator.liu.se, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, stable@vger.kernel.org, wsa+renesas@sang-engineering.com
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: Release pinctrl handles on
 deactivation
Message-ID: <20261103-diligent-taupe-seriema-e3fbd9@quoll>
References: <20261103082905.1167633-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103082905.1167633-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 08:29:05 +0000, Wentao Liang wrote:
> Each master activation calls devm_pinctrl_get() against the parent I2C
> controller device. Switching or removing the demux only releases the
> adapter reference, so the pinctrl reference and its devres entry persist
> until the parent controller is removed. Repeated switches accumulate
> these entries. Activation failures after obtaining the handle retain it
> too.
> 
> Use pinctrl_get() and keep the handle with the active channel. Release
> it when activation fails or the channel is deactivated, before dropping
> the parent adapter reference and reverting the device-tree changeset.
> Keep the no-pinctrl case working by storing NULL when get returns
> -ENODEV.
> 
> Fixes: 50a5ba876908 ("i2c: mux: demux-pinctrl: add driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/i2c/muxes/i2c-demux-pinctrl.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
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




