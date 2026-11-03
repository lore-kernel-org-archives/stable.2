Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704203;
	b=bgZuiAK+D+DUm23zX5R++kAqltRE2YqJxKTurhOjFZWlf1AEfCEn7d1RM8PlwB9iej3p
	 VPvSBz902WSxQN3o606azH2H84UGMWnmM31ymkCCCwJOC8IviPp0NoHyvWCZDklK61E9G
	 CwT8BA2YpIkAYwrnRjYh0ftmmTyWgPtjt2fQ3LfpUhb/VuJaMUdepx2Noo7ITr9qF+4uv
	 7OoT6XL3dBZzKMv/fQCr1NtCMbhqQ0c3iQmKGDwR/enLt8J0K/7W/XuWxjy92yDcUTXUA
	 ThJqCQDILqciKC2h9owZmazqrewVP4PNFaX10Q4eOAU2TUH9ihMRdHoywEYnbQQ0kug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704203;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iVaqWCIvOxlTswj8zlqsLe/sDKMY0KDVW7ynZAQ76QM=;
	b=ISgU7+aCK9+ajUJ6ZamMUZclWHTiW6Rjuz9LRUmn6+TKcIeWiIGZe612afPhDtvH433H
	 thEmTUf3VHQBq21Gfz0M33l8y7kGNjmo8zzvN0GO45wBAY1EkESczNEPGF8soki6ej3xV
	 6NlhJ4zoZYCx4w74RVhJ1mGqfcUiflGqOZUYG0pCUbvNK2bUqCjbKPJ70enz70Oia+VAP
	 p22f35dfumRjZ4h3zcqobPikhZqv03V+jbulXkXKbQNYdGNK0CBYWoVLKq33tdboynT8v
	 fstvlZ3PyzfmNtqG3LRL/dUxv7RWkjKEFh73pNkmbZiB42EU1oMRGei8eJoKv/HrRCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eO+vDHHY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FC5606BA54;
	Tue,  3 Nov 2026 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eO+vDHHY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA06F1F00A15;
	Tue,  3 Nov 2026 11:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704203;
	bh=iVaqWCIvOxlTswj8zlqsLe/sDKMY0KDVW7ynZAQ76QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eO+vDHHYyHXIXO/jgynse3/Sp94LcLFR/kjfA062WAHHfA2W9w5XssbOHEjQisSJK
	 WuBPAvh78jQFhSIzWK3kP2ef3lbDSbPx8NrjUCvG/cQNbex9ZO6kZXmqI/nCkoepKm
	 edGMnC287tQxfEGtz80j6eCoZVw/eEdn3vmQKToLFV9dtdhJeapIb0a3UZmJzxjh0p
	 jCyyBh/GvcDf7LULllMj2tq7ykbfrMyDIb7rs2klHO51i6MBKGV7SUDIh4S0tQm7MY
	 weWsSRRwDOE5kJgu974OTcVfOqQKpK2iaa1YVTeWF3uRiDMbGt8+bkxEMgPmguP9N9
	 qeU/uBeR1LMFw==
Date: Tue, 3 Nov 2026 12:10:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] rtc: stm32: release the LSCO clock provider on remove
Message-ID: <20261103-cunning-mellow-gaur-ade1c5@quoll>
References: <20261103105546.1394618-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103105546.1394618-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:55:46 +0000, Wentao Liang wrote:
> The LSCO pinmux action registers the rtc_lsco clock provider with
> of_clk_add_provider(), which takes a reference on the RTC device node.
> stm32_rtc_remove() unregisters the gate clock but never calls
> of_clk_del_provider(), so the node reference is never dropped and the
> provider stays registered with a pointer to a clock that no longer
> exists.
> 
> Delete the provider before unregistering the gate clock.
> 
> Fixes: bb7b0df2be5c ("rtc: stm32: add Low Speed Clock Output (LSCO) support")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/rtc/rtc-stm32.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
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




