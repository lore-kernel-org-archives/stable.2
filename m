Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697691;
	b=5Vorg0x90dpKdz7tWs/ZCqFn1yanwWbXmqFAHm0DnFrKK4+dolYDy6lwETfOeQQAognn
	 MQstADcx8Ko1AWlXwWCWy1oM8SaDLKl9JgD3d6oSj75SPQHRcajRjEDalrIJJ0vOrA8oG
	 Xjx13S+3sR0ZUNbQ/AYhW4z/SoJ72nkIpNLFxsKDDSovx8X5fqAg5QRN7/97rZDNlsCNo
	 yjYTzBTCmPQ+lqnKnbHiGNy7G/qHINC42fx/+D/ZFa6VbFp1wDQgYyw5h7SU2MQR2en2c
	 xbTlALPESOIg4l/y2xtBqi0KBvFBxn0LbVXJkkQ2Bsj0vlFw8yudGKt9qa6OR2FUriA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697691;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ra7fP8C7bsgcxqmhSZXP2416uNz7g2e9Zbid3mgPbE0=;
	b=MJpMU2/s97L/nZenFmxa21Xc4O9F/gJIhsme8j535aZSjFO8cj38b+aVfxur8zGfwRWd
	 3fD8dUea+DmlKMLv6CSnnU0QIEjdBCKpEXYBSBdH4cyikT2lDTa3xjV4ChSCv5i80RCwd
	 ChKB7aRDG2D8oGYR9Yt8Y+BnIlSIfcCsjearKgBAoRSIYPdEaKQw+ntRAEsmcxOXcnuXd
	 oE7SMN9zRvocLivAu7u6f+c3cv7VO1sZxnTGW6tXXTLjt++Tu6bYfHW67ax0z5tgK8Qrb
	 VLZuWStqZgASxIXP/EpfzieH3Qv2fZFtbwbbrRJud9T9gyOToXSDChrp4ySuIrB787w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYZri6FI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54ED606D830;
	Tue,  3 Nov 2026 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYZri6FI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986F31F00A15;
	Tue,  3 Nov 2026 09:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793697690;
	bh=ra7fP8C7bsgcxqmhSZXP2416uNz7g2e9Zbid3mgPbE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RYZri6FIRAO5xWFUVpmiFTenaZwZHFUGnDF3uE5fEhkXNvzejXmS9uu26QhondJ0s
	 iLymzG5HpKDHpFWP3sRkfCnXDxgVk8YZRnmW1f1665XghU+HBYpGmK/6G3/1SoA91v
	 FfhGo1fSRgovGigWnpicIEpOO5vOW8kSIx3XsHLcNM6AhGWsdpx6rxD6OHetV0BKLy
	 0t1wDAkuox0P8uNozxhP3zaY1V6Hta3lLGD54V8Zuh0LrXCXp2ah+vdSjpFROlxCqd
	 uOBhkp4AGKkb+uXuLfq3XaTYMyNJG/Ta3pHtgVoG9KrJHtdC7XkKGZ7pOBc38SdvmT
	 5WpkT+clWdlIw==
Date: Tue, 3 Nov 2026 10:21:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-media@vger.kernel.org, stable@vger.kernel.org, 
	sakari.ailus@linux.intel.com, vladimir.zapolskiy@linaro.org, mchehab@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ov6211: Release controls after control
 creation failure
Message-ID: <20261103-wombat-of-eminent-courage-b0d7fe@quoll>
References: <20261103083417.1175861-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103083417.1175861-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 08:34:17 +0000, Wentao Liang wrote:
> ov6211_init_controls() returns the handler error directly when a control
> cannot be created. Controls that were successfully created earlier and
> the handler's allocation are left behind. The probe caller powers the
> sensor off on this error and does not free the handler.
> 
> Use the existing error_free_hdlr path for this failure, just as for the
> subsequent firmware-property parsing and control initialization errors.
> Save and return the original control error.
> 
> Fixes: fd7cb868e309 ("media: i2c: Add OmniVision OV6211 image sensor driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/i2c/ov6211.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
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




