Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690816;
	b=ymjat0USP5tLq9zKqpw6+BK8G769p08pKCqGTgLZx2N+hMhAdL/8fPsXEKGWKcWZx+/x
	 AOJmhnCr/G4Ft+fBFf4KznpCH66fBPwAMhG8dihlFBDV5On5vVQm26y+i5Y6tfYLhg0iK
	 XNbbp0hHRFmD5sg08/83uWTDjmzRNXaNuPxgpus+150KrE1idnVUnq1/oWFfj56lM3Y/i
	 3Qcd6ayYMpSPvQGW5wlp10Gn0H9lOp10ikqwV2cnba5njYrTv10Vf7cc4BtUuyw5RsD6Z
	 db1wep96UKFet8hXA4XnhkcvjD+HrcOQa1LRNK2XyD3Q2HGja8lvpKF3ma2vcUb8J3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690816;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1W+dLatY9nnSDyIP/7UDjOZciumv9YU0Js0RJ5PhO4s=;
	b=ppXvI56MQLhyBpIxIzu5IuPLwWTqoIoqOx9SU9NGbR3RwAWaQsYRP6m7QrUSnkE8SGF3
	 VRu5fHzRnEd62Qz4vFM8lIYoG9ysH47TQhJaMsLZ/Vxiuoonfv9hwxHYnvAP39Rn8m0bS
	 IiC+IWYRoJzWyVkvdG7YJ9Ukpbdg4pp7fJ/0SBXoMqPhEnSv4C7kVTJmqbDl9kN4Tr1Tv
	 oiUoPqyQ5hhmG0CTPm9LyxX9jpONFevuAhs3eeRtO8W6qExsCHYcDySZrdQhC7zHZwYtP
	 ZsgzPtvxs5Ii1nQtp2gcYsd9E4FuKaMklvkcSnRTzLRFnD/vBGot4HhoJ8L0RWI1FEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0v84Ky3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F58606A337;
	Tue,  3 Nov 2026 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0v84Ky3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400BB1F00A16;
	Tue,  3 Nov 2026 07:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793690816;
	bh=1W+dLatY9nnSDyIP/7UDjOZciumv9YU0Js0RJ5PhO4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b0v84Ky3dU/Duc4o23FRWcU5iuPmoE2POmJhnPd7BAea3aNMxLwvz5rXBkmS8Nt/n
	 +IyIiw3aa+YmlBx1hOP02leHB9bhbAERAhf75pBpHrFLAuLmfGUXBHEFQJPmpuzczZ
	 ZymLKjUKF2VA9fUcL97G2zPUbW0Y+1cabTzb0x8a1ZD288i4/u5JfuF6uGgUAnn3Xb
	 u/uD0w4ECgP0ZyNo8pQOYlaG3VSeruzMccIdsdY2KZM48zehBhvjg5x1KDUbAWr3tQ
	 XrAA0MFc1zWm4wTimoEZt84qhXlkg2/9Xa9RDqoRZzBm07tDbAIq7u/7MlGPPNSMCG
	 GqqA4+qhdTW1A==
Date: Tue, 3 Nov 2026 08:26:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, dakr@kernel.org, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, lyude@redhat.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/nouveau: Remove the audio device link on component
 unbind
Message-ID: <20261103-hungry-fearless-hummingbird-dc7d80@quoll>
References: <20261103070331.1079868-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103070331.1079868-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 07:03:31 +0000, Wentao Liang wrote:
> nv50_audio_component_bind() creates a stateless device link from the HDA
> device to the GPU. Component unbind clears the audio component pointers
> but never removes that link. Stateless links are reference counted and
> must be explicitly released by their caller, so repeated component binds
> retain a link reference on every cycle.
> 
> Remove the link after disconnecting the audio component in unbind. This
> also covers a later failure of the HDA component master's bind callback.
> 
> Fixes: 742db30c4ee6 ("drm/nouveau: Add HD-audio component notifier support")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 ++
>  1 file changed, 2 insertions(+)
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




