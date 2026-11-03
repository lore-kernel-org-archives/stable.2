Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701605;
	b=ycN6MjWLZ16Hzr+aBG2Cro1GZXZOSg7sw8fxj/LUWppLsYec7E2xYNRiRbG00ACMewII
	 JL0yUSgntMfPVO182JuaWAiMeA9Ojj7DPeY3t8mAqULQCHD8qqpoTNpNzwzSMDtZ27YJh
	 JQ0AMSF3iOrjW+OsJOX+eojYwgE2hOowcaLrVeJrbYqr7HMZgF83LmmZgkqEa1Lw0NBTG
	 Hc570EiERiMnfhaqFhZ+Ft3WD3uyzlS53jOkNS8oUPqvlsdl6qB9yKlRQ4On+SROuzJem
	 jpqTAYZu6X4SEWTo+92kj2xcIdfjoG9kit5hZXExXqcU2ww5Zk237pCZqot+/ESm6wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701605;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VmxLDo/TdeVfYhwrkZhELn8JbsYNyhoY5uMZbWl0UJU=;
	b=qxSS018f+l9dcvtW3EiOpKNmOjduggrgD+lXHRl0juAo0itgRZNMbRCqjrpZ/dJRFF7h
	 qtBsOXPKNmQED45ubHCwi7IXjbChD2HD8AVHLj7sKsq+/jcmZmc6JcTSZ4r829EzyyeFA
	 HH0496Q7OaVsSz+8wHQRR8z2yAU1WGk6daXe92MkeeEviKk92W2+95tZzq9vSMA+wzqSs
	 1rBkxZTpwbjydb11g5R4JF51ocbp6OwTNTyql84jf8e7OF1ewYnz6EPd0csoU+umwagY4
	 BKWRAZ/HY5ool4eAo63bhnXIPpRLhniCecfUhTfB976oFhKo72LjPi5ukAWw1t3755Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1unw18q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7075606BF93;
	Tue,  3 Nov 2026 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1unw18q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD1D1F000C1;
	Tue,  3 Nov 2026 10:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701604;
	bh=VmxLDo/TdeVfYhwrkZhELn8JbsYNyhoY5uMZbWl0UJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P1unw18qbzpVpfhRt9DNcaH68tl2s/dZgfDRh2EYDPuBnyt6R4+FvZeBmZ0HtnlfS
	 zpfnYtjmHywf8ZEQecRratEo31K+jAKoq+/qICv7VhEAWxkDLXQxgUWkEgWkm+Y3wh
	 v1bsOseS7FpaCpivKHdhoGeMUrzKrDROI0ENsMmnmYx4nIlijYb1VDbu0ZZbJO1Qeo
	 NbcZ588Vvj3PagiUwvlSmbadlXQqbho3V5isW/Xt5NE+ec0ztcNDUErL6t7L9VWNDz
	 xqca4Z5lTIDJpvpAVN/mKcHydJ5NRa6+idVWEjn6RLu9cjZt7WNzZ5RzI0JxRrqXsT
	 sTk0yjTbbDlXA==
Date: Tue, 3 Nov 2026 11:26:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, linux-media@vger.kernel.org, 
	Michael Krufky <mkrufky@linuxtv.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: cxusb: fix URB leak on start-streaming error
Message-ID: <20261103-heavy-tangible-axolotl-a26ea7@quoll>
References: <20261103094624.1289527-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103094624.1289527-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:24 +0000, Wentao Liang wrote:
> When the allocation of a stream buffer fails while fewer than two URBs
> have been allocated, the error path jumps to ret_freeab.  That label
> only releases the shared auxiliary buffer, so the URBs and their
> transfer buffers already stored in cxdev->streamurbs[] are left behind.
> 
> At least one URB can be allocated on this path, and vb2 does not call
> stop_streaming after start_streaming fails, so nothing else releases
> them.
> 
> Jump to ret_freeu instead, which frees the URBs before releasing the
> auxiliary buffer.  It is also safe when no URB has been allocated yet.
> 
> Fixes: e478d4054054 ("media: cxusb: add analog mode support for Medion MD95700")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/usb/dvb-usb/cxusb-analog.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
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




