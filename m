Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690824;
	b=i2BT7R4SP2Cpnh115IJqwFrSsxyH5G9b0C3MCmaJsT7bV73Ai/UqsJtjkrrPZnvoW7As
	 F+AWC1+NxGV+kkgW1UaPRIp8VgFyBIcvSSyQYtq/Qp82UNFg3Li2zOKYRjHcOPrifDXVn
	 eYkH5T85lXeRYnVC5af0x/LOxF3wtkQsW332BLUsRrQiu0R7lf0q3z0sZLGJojb+aDWQ7
	 E9PhNSgkFZvHm/gWEiXGOysY7xUI04DzwvhWBWY3e8Xn2J5Rc8ap4AL60ZRDw+vk7tLlC
	 G/gDS6bnvtopBOXh0zjuqvQuCiw1faiz+kKDEMxDJ85Veia9kJ+QUWFvchipilZsr7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690824;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2UnuvNTwSNhA/b6GJllR0EE5L47EKTxjsVEy/FAQlXI=;
	b=m02ndrF9VcnIybxDGFBnF+s0XeSeHYlR8cS++V+7tQjcw2iVz0pgvfYjxiAELqdRdZcf
	 L1K9wk5PfuCkfXDHiO1ZkLteANHIp/Zt7RaE5wnZ5e9kVaGV2/PnZ+OsyFVhJbIK+vfy9
	 iqSlVhfAT3JYXPnD0GhmNMg3s6HsgxvBd8n1rOCDTJwJaUx2tUl10yyBdJgoKjIg805Hv
	 o9paro84wzPebiKGAu9YbXnx1IlnZFcVR3DQuUOSFX558K2r2gGov4MA32fNykRNmB5GR
	 u0FiTYLqAXI+MdnIdKK9jKOVrdwveywsZkDBEh8Udh++FSaFSKQduo6W58aJX40eFJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIiyxDSn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6D2606A32F;
	Tue,  3 Nov 2026 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIiyxDSn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCB21F000C1;
	Tue,  3 Nov 2026 07:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793690823;
	bh=2UnuvNTwSNhA/b6GJllR0EE5L47EKTxjsVEy/FAQlXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NIiyxDSnojE1F4PCwK7yqKFa+jsgtfS5tsZ52Il6MxHOgyuEgSdh4TI8GPt9M6uJm
	 52ZHO5L0CImM4bwOnbMppBktyOrU+4rs/Y3zFtjs7JB3Nj5fJ4f8a6y2tnj9igylnj
	 PtC/51vZJ06PyYvXKUQteHnWeJgg3dyXtKqC7dlLTvmQdokfMQSc4XxhxlDP7vzXSF
	 2aFDKKWCAj54sPez+fvBoQ/Yyr+KmRnpGVM0e9X97vAtw6VSaOpC16d973rW5iNdcU
	 fGNPl97f/lq/27kXaKbbu4iNVDNbPLPXqcRxnm1BtaahCP82hbhpf4yUXfbJ67ec+N
	 nRtY/EvAt2Dyg==
Date: Tue, 3 Nov 2026 08:27:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: tursulin@ursulin.net, jani.nikula@linux.intel.com, 
	rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/selftests: Put GuC test contexts on early
 failures
Message-ID: <20261103-careful-honorable-earwig-cee583@quoll>
References: <20261103065554.1073445-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103065554.1073445-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 06:55:54 +0000, Wentao Liang wrote:
> intel_hang_guc() creates an intel_context before changing the heartbeat
> interval and initializing the spinner. If either operation fails, it
> jumps to err without dropping that context. intel_guc_fast_request()
> also skips the context put when spinner initialization fails.
> 
> Release the context on these failure paths. The existing put after
> igt_spinner_create_request() handles the later paths.
> 
> Fixes: 69142c0a5f9a ("drm/i915/guc: Add selftest for a hung GuC")
> Fixes: 706785c19fe9 ("drm/i915/guc: Add a selftest for FAST_REQUEST errors")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/i915/gt/uc/selftest_guc.c           | 1 +
>  drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c | 2 ++
>  2 files changed, 3 insertions(+)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email, thus I doubt
   that we speak with an actual person.

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
letter), how to document usage of LLM and what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof




