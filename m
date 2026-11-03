Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701616;
	b=EWRVqzYmhX4doLqyrQjUp+h0hZGCnCYGvFMQA4kOxGTOw6l+4llUXw7TREU5HAneBdnx
	 f5hesDHpeZlHczM3f1yfLWYdntPAQDIHBXL6kE0khD23I9PpUI3T4/QsqmtQqQbOCejre
	 vnLvDpQDC/VI9yeqy32COTByiHvFJzOpC48434kudEzTFXr66MFszhKAPx/SenRhcSSpz
	 jgREy4rMecIurpJGKygMHLjX8Or7iBpwWy0+Xoee5pxBwYok49FIPaUj45eJbbYqUzoci
	 unHpCy/8TD7QnLiIBE8RTyKRrfjonhfDx3+l4Rix/38DK37BU9ae8MjCNI1qO7m+Hog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701616;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vF8xG9Wg0/iR0LYUbbIhgD9MY7+21+7qiT7sQpnMXI8=;
	b=d+cUViFGs93QHMRwWLIkKWmr5gjA523S0plBw23dBJstdW4X9qZFwQhxSIpmMyF1RYim
	 qdXKIWGtGx8GcZ8qiC/TzbdG+VzZBRlVUX9X15SL9whCVJAvarMKhZxuZ/j+eR5m9iNiP
	 6VTriROCJ9fLznG55vv8f2ncql6G9c4oUjjk3Lmy7DXnyQGsr2G+SLjoTwfVydFruJCf6
	 rN8osM6axMIqsJ1QxRC6nRMrsIKS2gPw6IsP264E7NiX58c/3ziHzKjM2ovg4A+c0Wrwl
	 3ZSbggY7Vz/FoMzFM0DzhknR3c6FJsJHqZW4Xpoq9tge6bjtyOK9UWwIuZ8IlNngETA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AgGIuc3i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA1606C580;
	Tue,  3 Nov 2026 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AgGIuc3i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B98A1F00919;
	Tue,  3 Nov 2026 10:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701616;
	bh=vF8xG9Wg0/iR0LYUbbIhgD9MY7+21+7qiT7sQpnMXI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AgGIuc3i/+pEZMq8Ko91aA5O3SOhC42Fu/wTLmdPjmQWZKruH/btztx6oYySW/I1E
	 dPqizGAIInK3ymc/fa7u93E38cbR93+Z6Ar7k1Yas2EE44BW46sESs8AzjtvodKU7p
	 TfBqBXMjj12KDWMnYZQF8IgIQAnj3BGQPUZCnwAweYmWpwd+FNHC9DsiS3Ou4Q5dms
	 AayCEZnMuqJbcWWmhEB+y6MJok5KTbnFfuilA96pwxF0bDaYOyibDJdyvfMnq/TCM2
	 v5CLb0WmpgrufPTbYiGDLWP2/gdDh3lb1BTzDZw+CNp9KqkYZ2VOg9+t75Eua3PP7I
	 GdKWemYdsJeZQ==
Date: Tue, 3 Nov 2026 11:26:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Peter Griffin <peter.griffin@linaro.org>, linux-media@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: exynos4-is: Free control handler if fimc-lite
 subdev init fails
Message-ID: <20261103-macho-determined-woodlouse-b1ba77@quoll>
References: <20261103094617.1289377-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103094617.1289377-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:17 +0000, Wentao Liang wrote:
> fimc_lite_create_capture_subdev() initializes fimc->ctrl_handler and adds
> a control to it. If the control cannot be created, handler->error is set
> and the function returns after cleaning up the media entity only. The
> control handler still owns the memory allocated for its buckets and for
> any control created before the failure, and fimc_lite_probe() does not
> call fimc_lite_unregister_capture_subdev() on this error, so that memory
> is leaked.
> 
> Free the control handler before returning the error.
> 
> Fixes: 4af813108b88 ("[media] s5p-fimc: Add support for Exynos4x12 FIMC-LITE")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/platform/samsung/exynos4-is/fimc-lite.c | 1 +
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




