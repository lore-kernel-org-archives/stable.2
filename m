Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697708;
	b=gJ8LcOa7CxdWr6c/+FFclI90Kgq6xM3dnptoyUdliObZeZOJfX45vLnfViu+WdIdxzMp
	 mL69vkWuPs1AwU6f3quXil1xzuV9q1TBXMynxNUkrKdx7uai+aUE81ryImchqvCX5ujrz
	 nhdsXXFuGlwb64+c3AcInvMIy2tXwlSBTbfzUkP9waQpqeRU9WUwF6ezNkXUFqiYWONwx
	 qYHCsEjPbxpTKemLaBNgqoeH8ql0gljpVl1MHpwtrSk3JEaMIsyUjp7YJ65YlqkDobSPJ
	 ggGd0fCUNRsPCUcBtvZanWhVU0TCpZluOBZrQpRUwbeVrURoUOuEu4zj125ExzAyKUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697708;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Nl8vNU0L6hN5oGlwxYaKhQs3x0kx11JFhc47Zg4ZFSU=;
	b=ERBcFH9E1q8sV4P1JZpyfHe7rrHz4YbcbLpndj5NsH5S2Wqv+F+4IFmryUYpJCV0wCCb
	 uClsE6dd9tZ87hHjETlotvOZTlrfcPhPM+bVNJcMG2FyX5F8cyZxnaiuHO8m5CwZOeEVP
	 SU3HyS5nH04B7h1tSUScaBdskUAwHfkd2Wa8SXUxL/Jm303WyejIkVx8RBnOE8exPxPd3
	 PeIJBTYlWwpruOLAL8fo1Or5Tor12d41BLkwmGKAdqE2Nh8eHWF+32Sanze9nkIn7to93
	 Q27/9CakrisqGrpb72a4JPKy5oXynGGNC30RJv288ZML2RumcYhhqXx1EGsBJS1S4bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcvreDjF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1E6082BE5;
	Tue,  3 Nov 2026 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcvreDjF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A451F00A1A;
	Tue,  3 Nov 2026 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793697707;
	bh=Nl8vNU0L6hN5oGlwxYaKhQs3x0kx11JFhc47Zg4ZFSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WcvreDjFEuUKl5HrFulwynlRAPT4P+qsjQEMm/JKfkcD2XGe8HydVS6jgO9GCMAFs
	 BJErznURg5nIw4IgipGyr7ZGXDSkP1CDgsw/ifZzhea0swOADiDI6CG1GD4hQg/vhZ
	 Ugf2BP+F4mSa8eOL6CX6hxlpG1VG0KSdvS4j/AB7l0ZGOHyE9XnNChcHLxT3CXmZ6l
	 juyXJOS0Xibbo/iJjR2xgeesO5c5e2rtyGf9QIfT6sUmX0yrXUuf9xWbakkTqep5Uq
	 4S/nORjhIvHPSIGx0s9m0QpFIXRtCVdElpe7M75PfqLGKzwMPmRNhwcUAxmuUqpKGb
	 TZoiVn1eCLunA==
Date: Tue, 3 Nov 2026 10:21:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	stable@vger.kernel.org, sakari.ailus@linux.intel.com, mchehab@kernel.org, 
	vladimir.zapolskiy@linaro.org
Subject: Re: [PATCH] media: i2c: og0ve1b: Free controls when control creation
 fails
Message-ID: <20261103-viridian-rat-of-exercise-e8eaa3@quoll>
References: <20261103082513.1162639-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103082513.1162639-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 08:25:13 +0000, Wentao Liang wrote:
> If a control cannot be created, og0ve1b_init_controls() returns the
> handler error directly, skipping the cleanup used by its later failures.
> The probe caller then powers the sensor off without freeing the control
> handler, leaking controls that were successfully created before the
> failure and the handler's allocation.
> 
> Save the error and use the existing handler cleanup path. Preserve the
> original error before v4l2_ctrl_handler_free() resets the handler.
> 
> Fixes: 25bf2e1925c9 ("media: i2c: Add OmniVision OG0VE1B camera sensor")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/i2c/og0ve1b.c | 6 ++++--
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




