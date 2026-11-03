Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704272;
	b=3lzTvUMRtwdBcaxXEk3LZ2WVyPEQ++a18vKWzvCWW+LV3gQgZw83/K1Hn+Mxy1athSsT
	 gQ4vusHrhBG7qR6FdByy9PK/PU2a5uyHFMtuCXAbUsHMkFNbsqNXMBj/ymqH0IUYZ0/XX
	 Li0n6hJOOl/eWaRgVdwzrar15b3AL0xKLSbjig8juknJAt3r4lahtKyCeP4lO1MoPS/I0
	 hZzJwgGhnZtDXv5ctP9BaM6HseOXremlXrNkn0KSTDzQ0xRQ7NJnggRxyYnZP5Un/XQlt
	 v3rJJXsMUvkwMrSc1Y0em0IPBCwWLfc0hXiA0tey0ZiWKKaa2yXY9lfyVAxE6lexzTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704272;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2ME5JyCxKMxf/pwrx0ni5cWoaFDGbuwJ8j4UWAQ8Xq8=;
	b=2oY84yG6qduRgVuKV9T8R86tJ6ALrGf8AeS/KY7NdWY5A5ZYUQBxvrpzNR6WUBxUg7nj
	 R7biC4DoPt/LxPv+l3+W6/hsFbo3Adv9NlODqCGqcRTvnfFksdOlP7ENmjHRe2kBgO83s
	 17CX+KD77+uoUCdHZ2Jeb9C82HnXxQEGM77ZrPrffkrjD3Oo8FdDx6xeEO8DxB+JWp2o3
	 sN1Ss9FJ7ULZQGN0scfd28FYJK9PiRIQmtgvtkg7kDKeqr6zN4GCiSc1hmX4bYQwC5dKf
	 Tef1oWTRcSjJcrrStFNCpHkeKbHQm9OJf5CgIM4TjdvMbxaAB6B443V5kxlmUxKeqlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFPsHcTo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BC60A5BDF;
	Tue,  3 Nov 2026 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFPsHcTo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E731F0093A;
	Tue,  3 Nov 2026 11:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704272;
	bh=2ME5JyCxKMxf/pwrx0ni5cWoaFDGbuwJ8j4UWAQ8Xq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KFPsHcTodsjT8/Aazn7U+epkvhJQACdLgFRsNLL9Gc0JWXy9CCLQkGq6KA1RkjrHr
	 1JQdQipvPJbBoK2rUEnimqRyX+3DgQ/A724Qlq01V3UrQlaa0xWIOjZauuslIyH0qP
	 /M0E8QmBzW0gtBRsKcGO0CTW/quSiAfjansBSQZPrm+sC8bH6HB6CAXNsyzFwVWyoe
	 iTYhRLNpr9EdTW6f1viDHP5HkUqDG4rBwpUdsiUBlH+wnXTQXvCME+bnBUuepvTFy1
	 GfZS6hkydKpF/P/bquu6oa7B8HYMP4h1GcxE2ctrK9cGrogrSPNQvwHrJ/Yd4hmT58
	 wxeg4YsbN28Bw==
Date: Tue, 3 Nov 2026 12:11:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: sunplus: spl2sw: release the port node in
 probe
Message-ID: <20261103-shiny-terrific-husky-6ab367@quoll>
References: <20261103102852.1340500-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103102852.1340500-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:28:52 +0000, Wentao Liang wrote:
> spl2sw_get_eth_child_node() returns a device node reference obtained
> from for_each_child_of_node(), so the caller must drop it with
> of_node_put(). spl2sw_probe() never does, leaking one reference per
> port on both the success and the error paths.
> 
> Drop the reference once the node is no longer needed and on the early
> continue paths.
> 
> Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/sunplus/spl2sw_driver.c | 4 ++++
>  1 file changed, 4 insertions(+)
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




