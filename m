Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704234;
	b=SbC/Stc7dmOcdbhdC8PQgM+232aKXbxsVa+7GIdW6ax6a4knbMSp62H8oYoA2DEKSMCx
	 4CUSFY/qb3ICz7jBQvPBJ6WVq9MyVeReE8JyqGGDKNvmc6cY1DF2yqtAxf94f5w30cx9F
	 1xlMt/8DuzwxX80ltKYvo8xrbzCi4WonLmr1yZWZtRuqS9OF3qK3xtXkpkYBE1qhT5c1c
	 ydnSnnEJa3NA7X35W3HqxHDfm0zJf/ZGdTcJBXJTHi00YykUByTcd+ptQUb32aCo6Y+Ab
	 NdSU+au4ZAL+SXH+UMdB4YpBhGZJEoSSA6Vie31ldybcgT2Ynf/2D7HhQP1zXPe0faQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704234;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BC5ZWCqYDUyejAF6NFkt8ipXNaHStAN0cMKCsLvoZ0A=;
	b=aZBWNCHORt2l1bVF1PvgbqNzAbzBLolm8AUtWAtp4boVMaN72L24bD+c8vcLhY9/509X
	 Lm/uSIaUWXX3ImSS2pbFKBbZMc0NCJzEjiicAoMbf5fC2UvBrsVdseLX5+dumL0zQCkYB
	 ICTJjrS6zddm00WAIenKiJ8i/3En9yAbGitSer/+9JqXYz+CfouDi0FOOnoq7N5a5Nq/s
	 39LrQa8vsd7FzdkAUipiP0fZ5oEwAtK6TAVZEeop3NLnfBa2vOzT1uPEvRQItZO1mHLrW
	 4zFnOoWBfhXqCno2ewhlkvvdep7j7vKB1d3aBSnfbVqndy54X7anBDPB6lNdcng/Hzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krvoYdNR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB836606D827;
	Tue,  3 Nov 2026 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krvoYdNR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0B61F0093A;
	Tue,  3 Nov 2026 11:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704233;
	bh=BC5ZWCqYDUyejAF6NFkt8ipXNaHStAN0cMKCsLvoZ0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=krvoYdNRBDovEc4Qq0WzdzlwDT4b+cTFRhhU1fl89qM2313trWOslupTh0ffparZY
	 MHvkF9zFCRu1X6acvIpestjh+C09BjYbQvU2OO0CcxJV6NDyLn3Eh83lNT2Y+8083D
	 Z9XT3UdBQUMAirc7TNLscnnFaqiBMcK/nZF6+kgduZpG6JujRmyZiA/eTERJyp1LgU
	 dhn7d61NREojMHnEdJmTZayvFfnXTUSy+uDStt1OkyQ5Rs1C7MCvEtteuDL4aT+zv0
	 0koJSZXlGDQdZ0rBC7prC8pjAkDxeuy75ngPQXF/Wom83MXrG9FBQtuYMdTFJ4hAFT
	 MWxlC7YaKmT9w==
Date: Tue, 3 Nov 2026 12:10:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-wireless@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
	Mark Greer <mgreer@animalcreek.com>, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] nfc: trf7970a: release runtime PM reference on RF-on
 errors
Message-ID: <20261103-opalescent-sarcastic-impala-3a41da@quoll>
References: <20261103104240.1373772-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103104240.1373772-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:40 +0000, Wentao Liang wrote:
> trf7970a_switch_rf_on() bumps the runtime PM usage counter before
> validating the state and before initialising the chip.  Neither the
> incorrect-state path nor the trf7970a_init() failure path drops that
> reference, and none of the three callers balance it either, so the
> usage counter stays elevated.
> 
> Use pm_runtime_resume_and_get() so that a failed resume does not leave
> the counter incremented, and release the reference with the same
> mark-last-busy/put-autosuspend pair that trf7970a_switch_rf_off() uses
> when either of the subsequent steps fails.
> 
> Fixes: e6403b7c756f ("NFC: trf7970a: Add pm_runtime support")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/nfc/trf7970a.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
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




