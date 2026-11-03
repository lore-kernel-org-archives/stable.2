Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704231;
	b=Vouy6MIz9Qv/u2oPYnIlAWq7Mkn0BmsaCs/PnjuZMjfK6UEn3+IdQJZDiZf46HKtaY9x
	 YspYTxP7ndnInhEBpr3CcHnS6H0vT6MAT/P0JWObMBjmpa/Cdfi+ogs33n7uytdMFpZuc
	 KbA2fv8vAA8+9at24ycbhI1c5N7LpRqG7nwtGU4aHv6fpcxW2uQB/Fyj60NB1pYAPi3ck
	 qu2yy2qNPeqxZznmYsS3HWpUpvp0jSAbaTUN3ZrNvM7XJNdxnJSpFysKRchbDuA56IVVW
	 dIAsekHA/d2ES5FaOB5F69f9t3yItG1EsUO0Kv8jGOcOiD5mqm1NK/lt4YDRszvnxqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704231;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wwG22fdJmBwOmg0TU45Al3Kqsr0pJf29eGZ38ZwAb+M=;
	b=OnPGyKCpVNMpeUgBDV2rrowTDSCrvUXFI/s62mR/1Ocw6SlR0uAdZEiaUEvOyq9gDfkC
	 G7pnsarQ3gEZtH/7IsgRTvCAzYbG94t87AGEC+O+ACVZg7LNO2i1T5LRRJWj74/dyEEHy
	 3WzaDqqAvJEbu1saW4cnC3NJJmseKp8FVcAQjd1hVOo96NzvvdxMVNrI73lOozq54XZrn
	 aguQrAaJ7bvJaEEidVG52uyNXKicFhCTQQu9g6hr0xVeSsGTLII+DabG9YhHUSixYY5fy
	 hwjIq38gU63dv7s1T4f+chbOKGxowrdbnvglheb0FxLArbhF35LvoWRAnUMYZ4YN7fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyJEK7l3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1988606D823;
	Tue,  3 Nov 2026 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyJEK7l3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2211F000C1;
	Tue,  3 Nov 2026 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704230;
	bh=wwG22fdJmBwOmg0TU45Al3Kqsr0pJf29eGZ38ZwAb+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RyJEK7l3bCWre+kk38VuCHDdjcz94HTRlWD/3iNu0Egasa3PUHwaMAoKuKIpVgRTJ
	 Iw79dsNijHqIitkKAz5Zy3bTj/UnXFr2rh6Jsdbc5u3eAxRAfr49WmTA16RbckPl5z
	 dY3or8QA2kyymOeiE54ugE5kC6NprP8spi7gyJJYhO74HgGHaJsONgBxBCZDV65wYi
	 n6GSTQrFznedeN0hz2fzTiuZtP4fmLVy/T2i8KqFPqGteiGdyYNshb4UIzCmuqdjCZ
	 NCBJgzsFRYcmQsnv1/xYYUOJWjHCPSQ0m1MUNfBRDrRkX2lPUESXVgxX8fnAAVwkk/
	 tjgu4LhuUEoXA==
Date: Tue, 3 Nov 2026 12:10:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, stable@vger.kernel.org, 
	Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Justin Chen <justin.chen@broadcom.com>
Subject: Re: [PATCH] phy: broadcom: use devm_clk_get() in
 brcm_usb_phy_dvr_init()
Message-ID: <20261103-hulking-tuscan-emu-e5ff7e@quoll>
References: <20261103104240.1373792-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103104240.1373792-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:40 +0000, Wentao Liang wrote:
> brcm_usb_phy_dvr_init() obtains the USB 2.0, USB 3.0 and suspend
> clocks with of_clk_get_by_name() and clk_get().  Both take a reference
> on the clock that the driver never releases: the error paths after the
> lookups return without clk_put(), and brcm_usb_phy_remove() only
> unregisters the sysfs group and the PM notifier.  clk_prepare_enable()
> and clk_disable_unprepare() only change the prepare/enable counts and
> do not drop the reference.
> 
> Use devm_clk_get() so that the references are dropped automatically on
> probe failure and driver detach, and drop the now unused device node
> argument.
> 
> Fixes: 49859e55e364 ("phy: usb: phy-brcm-usb: Add Broadcom STB USB phy driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/phy/broadcom/phy-brcm-usb.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
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




