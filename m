Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704206;
	b=m8q9L5mgVqpcmLZuSQ5oKiQTJzIQ1hS7Iit9oi25AGBtTaIc7IBn8vrwNshPZdGtKQ9A
	 gL+Tl3wzdQJp+ErLc2Q46GvS2iA3zDTU0m9uT2vAcjVdcH+nVnMLliSo+mQW7wcJF3INN
	 /2y2theFVgqUKxthdbTpUfLU/aXVCMGb2GxObKedwrkeVBaG6gN4LQ8+QoyGC9rZqos99
	 YDmXpVJCMRvYn+v3PgBd2FMlU5CpdZk1M1UsZz9TZS7D70BdS5QPu7V9lEHsBcbIn8+TZ
	 8l1avE7HR3S3ylnTb4r8uWfJKgv7COr0M5uVFk8HpGAVTWLqvCbGbEBwxZkqNNJf+Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704206;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dmCkHOV816s90fZumZgoW1aA+6XuqGyb3DqgAN4i7us=;
	b=WTb7Sg8OBrg70t0NHoxZWGVPvSPngYVirm4v6JTJPMwHEDPCN9KssZpMLn2CF0j0EHL6
	 rGDmGxJ8TgZDRDQtwXiWFp81nPw2ceEq6rvN6uvxRxFihrzYvJ2/y/9/r1tEs3tICJ3qv
	 jx9Mg48dz43DWhF9BzrbpDEpSCsTAtJcBo960l8vJh/RIlvJSr8qp0PpFxRcQLQUG9wHK
	 BMSKsw6nGYSBTd//k3tq4Ssq3WoPx2DgUvRs2e6xuZZ4hA06KHTDA9Xh0npap55RaGpKb
	 bxbvOj9KCY0QOdRXZJSMQbG5Pm/fA1F9wy82NVcGtG2Z11Dp8muyk3+tUGXWdmvCWMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRvlmla3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44894606BA6A;
	Tue,  3 Nov 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRvlmla3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE941F0093A;
	Tue,  3 Nov 2026 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704206;
	bh=dmCkHOV816s90fZumZgoW1aA+6XuqGyb3DqgAN4i7us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WRvlmla3zRoX5UXLTdHUHRWq8TY8FpNCzJ6AeUW0WO003l71vJYkvFPS8cRg6EeGQ
	 IYDZgmB5+/ONmO6GRLQ45BIGzM0AtUzWHD0gLeN+YAXhA4wgowBG7ocfK92J3mcHmx
	 e4rdp8iBkI4YO2mWT8GRFsFCl4JlyPbBrvPycJYX4wrcm3IV+y6yqIhHMVie55RWW+
	 a3PWUukMRvAV/WHDsvpzJv6i5wddXGhJwJkWV7ky6pWxq2Yly7025MC0K9EnNG0WUo
	 pTViXFLffe6Rg4yirRyZHTCzDKzQRijUUPxt0QbI44Mtc4vnBBjcqVZN6kDanlxGnt
	 6ahJFDEjoVzMw==
Date: Tue, 3 Nov 2026 12:10:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Hans de Goede <hansg@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: pmc_atom: drop the PCI device reference
 after setup
Message-ID: <20261103-perfect-tungsten-junglefowl-ded7fd@quoll>
References: <20261103105545.1394600-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103105545.1394600-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:55:45 +0000, Wentao Liang wrote:
> for_each_pci_dev() walks the bus using pci_get_device(), which takes a
> reference on every device it returns.  pmc_atom_init() returns as soon
> as the PMC device has been matched, without dropping that reference, so
> the pci_dev is never released.
> 
> Save the setup result, release the reference and then return the saved
> value.
> 
> Fixes: 93e5eadd1f6e ("x86/platform: New Intel Atom SOC power management controller driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/platform/x86/pmc_atom.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
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




