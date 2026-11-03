Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704248;
	b=zEBK7AO0vyxZo1s7Wsl92lOja9WFr7AuScEc9DLmTKyMINcAJfV1ibvvN1R/rAOC4tPK
	 CM8gq5DiHQfrVii2rEa7dxQkb1U2I/9mpWvnEdkS13qsH80VfV3hRfJHo6ZXJUQ0XBKye
	 ShCmoZ/2FidK2YI02k7yWm3zGH5HlddrFA6yKOdfeHcHX8yZOwUo1H6WGS+sG3v5OK1Bf
	 oe1sANUIaZfX+35PIKAzSgrRsRHZxJf5vV42OEVL5cljc55Uts7yXWNw7cj8AJmpk5iuG
	 LWNrqTw3CpCf2lmtJzdOnhAu7cxPGky5TJc5OK9IkcmBis+jegXds+nDnE5XjT9VFqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704248;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=U3a4vIXiEGtL1/PeSnTPB5g6R0EJNMxhi9bu6NnV8rE=;
	b=jGWlxDkzFrB3GEF8ici3U9YsTrixOSU8IGt7JupE4Dwa3ze/HnCqebiBuHqQpB/d3Zxa
	 LJdtpo2wYthcESLCkz33DcydH5KJTNrSQwC7BBwej1uEaXkty+VUytOqm6gGcrigktmEv
	 C6r/mAnGKz8pe9hkuAJZVQbhqwrdZuduwqKUSIMCUajR7MR7eoJpZSu3fe9NblWILkRbe
	 od2Dd5KCk6acMeZKM6WlnWrS4nrM9ativNYlQzBfiUDcNRLBQS50jnCHT8gHnnWSbYB7f
	 sctz8+1avCgmyvxgXrgkbrT7IxrO+Au8MjPmg2PXpZdiA3ut42HMkkPB8mLrPTOTfqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLc0Xf4g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4C60850A3;
	Tue,  3 Nov 2026 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLc0Xf4g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67611F000C1;
	Tue,  3 Nov 2026 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704248;
	bh=U3a4vIXiEGtL1/PeSnTPB5g6R0EJNMxhi9bu6NnV8rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eLc0Xf4gELp9GPTXowoGCu175no2Mh1097F+4J0/CdZghDIzoUUbyP2Cw8Yt8uLOz
	 xWFp9vo6l/GqUWFY+8dSawSD6ycyL/8c529cqSEHDhxDhU5rWMiUkLZImTICoJx41c
	 Rm8tZfOC0mbOjQzhDxtRqx6xhBww2TE3C/oEf9XWS8unxFOFkl32G6Z7inzfacjbs7
	 aE3E5Nf0XFcyNAOfT0Pu8ZI9UkG2hhnZiH6MGaSgyzjc4XwUliXcAx3WdbRzp/2iW4
	 sp7xmxMRVvbPuVd6BuWT52mRRl4NDlESKgzZzNHrW6lIqyd25NSyB6jV6+G0fVcK1L
	 7tbpzSBRbQLdQ==
Date: Tue, 3 Nov 2026 12:10:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	stable@vger.kernel.org, Saravana Kannan <saravanak@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: unittest: fix node leak in
 of_dma_get_max_cpu_address test
Message-ID: <20261103-premium-brainy-chachalaca-a3b6ac@quoll>
References: <20261103104234.1373570-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103104234.1373570-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:34 +0000, Wentao Liang wrote:
> of_find_node_by_path() returns a device_node with its reference count
> incremented. of_unittest_dma_get_max_cpu_address() passes the node to
> of_dma_get_max_cpu_address(), which does not consume the reference, and
> then returns without dropping it.
> 
> Release the reference after the check.
> 
> Fixes: 07d13a1d6120 ("of: unittest: Add test for of_dma_get_max_cpu_address()")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/of/unittest.c | 1 +
>  1 file changed, 1 insertion(+)
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




