Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704216;
	b=wBSaZ+Z65W6pB40gUwrNSGQ9rRag+jTWsOovbo6a0gAUcJpg+vTaDDNj7wJLnACOO16M
	 0YrPDEcPWtMIFEC4+vMUX/0Siay0gzE/PKw9sA0Y6ASLZW+Kr3a+tVj9D6Z1BDthKvt+W
	 BQIWvyYj1wTpgbSGapCV07DH0+bCRlir4EfpPo1Ne9WJMpJnv4MFmPz2/YyPggUl5JSl5
	 8KUtNiZqbKRXZ4vghSSSpCrBR7Sp7POokYn6p3zno57GUmVEuPp3U0cj5muJ1jWRoRySg
	 JFZIDl8JbEQtOJe8hnjABNt7iJsKAK0MV9Am9gjnR5ACwSQrmqgou5fiP1+yjmPsdcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704216;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=X0rQYntPvjDDtupsZ2zaQsEpW0QXcX/75EIv4r8rIOg=;
	b=f88FNabzPs73qDIAhlzAulrJe20ENzaVisyfgkAZeqGsexWvQI29oKK/VNrrX3foyFQG
	 OK3p2Hv45K5YQ1VGdwAuK+cyG7fv4R6ECB/w9kfE5xGiKNGGbuzs+u0I4YZtZLtsBM5H1
	 5M25Ewi8+MSG+OaM86KtbtGSrdl9Qs8SAivfIDSb/uE9Qd2n7DoFGIlvMIqHlxaQh8YFp
	 BHMccyezBLakBLTQWV6PkL90beAEDVkJOELJW+jFE0Ro4l/HkaJW4TqHd/ecWWAuc8NF2
	 nCc6f63gViZ2XK7i+2RCTIUVxEhvZfvWHURJQ26N7tqvzoiTTT8Hze1mmpi0TWzcd2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPwFJXsI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF4606C554;
	Tue,  3 Nov 2026 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPwFJXsI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70F61F00919;
	Tue,  3 Nov 2026 11:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704215;
	bh=X0rQYntPvjDDtupsZ2zaQsEpW0QXcX/75EIv4r8rIOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aPwFJXsIBsH8GyVj2bxQIyyUi5/xoZS0EzVqlpzjf8lJBoPCxSQqUf3FNWj47VMK+
	 qDgssfjLo5IHx0Qz0B/gpSFYKQ6aU3cuQ8g9kvjIib0JqNc/BNA6jYSl5PM847xVLU
	 EBlt7ZKe69vot1hfnjM4Xy5CY4c2tPosPQ3DwOwcSjmD+uDr1VbqnmymqbWMXp8C30
	 COwA9V6VvZZ9OFYFCNG1QQ+XMkSFVtl+N5foPw46/2FHUCCpnsAOoBCnK7LZqtLHjL
	 krWJH6taUR9k/vaVHq7GaH5SBcbk9V0HRO8YgZBq/a7Kuxkdf7Ik3AF6e2KVkOSu3T
	 Y1d6++08GleOw==
Date: Tue, 3 Nov 2026 12:10:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: reboot-mode: drop the device reference on
 unregister
Message-ID: <20261103-enormous-tidy-basilisk-c8bebb@quoll>
References: <20261103105543.1394542-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103105543.1394542-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:55:43 +0000, Wentao Liang wrote:
> reboot_mode_unregister_device() looks the device up with
> class_find_device(), which takes a reference that the caller has to drop
> with put_device().  The function only calls device_unregister(), which
> drops the reference taken when the device was registered.  The lookup
> reference therefore leaks and the struct device allocated by
> device_create() is never freed.
> 
> Drop the class_find_device() reference before unregistering, the same
> way device_destroy() does.
> 
> Fixes: cfaf0a90789a ("power: reset: reboot-mode: Expose sysfs for registered reboot_modes")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/power/reset/reboot-mode.c | 2 ++
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




