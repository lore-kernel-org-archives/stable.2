Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704228;
	b=EGDJ//y1Zx1eRZS6x4TDChZnZui7uzObAGLlHDlFXWmsU8ufhFmFqpk5f0DX7Q/jKXhZ
	 mvIAEeXouxfyN46BrCMmslrz0qfnCJVlCghu9jFb/Qz8/iHTA7Qodo3hfI8SHEhONPdPs
	 S4T1LpssyAB+Qs/5RGiXNOUnSJopKSSuWB6tmad7v2zRUumW8YeZdggItA3JbrlldUDCH
	 QxGWROCh9UNLUarPx/XAhVEh1Jn9LoZWCchM/MugKHqj1YmpNZPtT02PaBxVgcJ75/7xC
	 yhis41GwdvgnziYR+2/PeXliQ7gL3JdxiD1skQOmy3vimCDZHOQxbeZEcSc5lH01dQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704228;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Eg5BCPoUEY1h1ZeGRosbdkm/MueH10ESc7FjY/jtN2g=;
	b=1SHDOAaj+4YJPgGtmwYiGF2AcLPFbrujw1zxvLdeC4jl1P6dFUx5onBFE1nyOrvYNTnf
	 0TxJfwBkhlqWMiD0I54xSt0daJJ4ied5D4TgC4BBOmZUcKEbAtWGjHp80jWBcd/uz5X5B
	 nDsUsQG+lD763T5qHMMmc1LJJrD6c1JCXqm247xfz/J8C7G1Rx5efOIQgZycZoUHPvg0M
	 i0Zr5m1C5fDjq1XVeUXNu/j6q/ou/DQQLBKpSkCGEj8WDs3Wnn+G+hza8lGITa5EMjNPc
	 ApIvpH4kJDDQQyBmSh5w46QbRsMSWFt4MMvl00rt26NK9diFO7IOABr/yxmbXU/qELA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtajaLg6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2FC606C59A;
	Tue,  3 Nov 2026 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtajaLg6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830CA1F000C1;
	Tue,  3 Nov 2026 11:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704227;
	bh=Eg5BCPoUEY1h1ZeGRosbdkm/MueH10ESc7FjY/jtN2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DtajaLg6MxpaExN7h4KTy0DlAmC7uYw3sD7pvl2yfDaYG+/URx62mIjDmKhmtv0lO
	 HHE39gN5w5wF3gBr7UhQMHRnJnsyiRsVh5e1F/+898TQ9bH1FJ3EJY5zY6wnRuHSnz
	 2TXXbvqL7dYDivjByVEY4iyMHpDzLzR3MjvLu+aGiWBSw/+qFGiWULXCYlE5kW4dl7
	 quYlw8d3WExHYdSCUj4a8cEYqjeiKBrzTCYvXsDSItYA6xQA5u84Ld7ZJ5Rhkgm2S7
	 eBzkbXsV0gF44AwJa2CdVMOjcjHWPr4e9M/bJzg1zplgQnKoUpUHr0k33tNaLA8y1V
	 JbeQKobt/h37w==
Date: Tue, 3 Nov 2026 12:10:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ray Jui <rjui@broadcom.com>, Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH] pinctrl: bcm: release the NS2 pinmux controller on detach
Message-ID: <20261103-colossal-snail-of-energy-3e55c9@quoll>
References: <20261103104242.1373883-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103104242.1373883-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:42 +0000, Wentao Liang wrote:
> ns2_pinmux_probe() registers the pin controller with pinctrl_register()
> and stores the returned pinctrl_dev in the driver data, but the driver
> has no remove callback and never calls pinctrl_unregister().  The
> controller is therefore never unregistered and its memory is leaked
> when the platform device is unbound.
> 
> Use devm_pinctrl_register() instead so that the controller is released
> automatically when the device is detached.
> 
> Fixes: b5aa1006e4a9 ("pinctrl: ns2: add pinmux driver support for Broadcom NS2 SoC")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/pinctrl/bcm/pinctrl-ns2-mux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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




