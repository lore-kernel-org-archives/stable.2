Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704266;
	b=R1hijyhDvkX0/Ub8tXQYogRKBOo8AEvOJGJ2G9A5ORGl5uBiEJ3+WQQHDE7b3WxNauU7
	 8n4/X5Skataj1AFU0F59VLbyk7ezDGgnrxXGWwLrAwXeawRc4RYua1Z7bfsFzCC6v+bS8
	 vU6Sh0YpoCoIaAcAJ6hBu5EGUMC3Wm1iYuKBoaGXxlMPdDo70uPk8U/xBLOEtHfooQPYd
	 7LEAEArirhxoitDmp5CvYlDQ87M5ZJpm8LTwyNw9wX12jOh33CtcEqbVhO8HkV0rZV6RI
	 2S3nWYo4SzOYDvJZWVLw+oHsrXoVXW2IV124Kk2O3+XL/K00sbTvInO62xkdyI+hFTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704266;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VuwVRdvDqCkcqJ5PJHMF6vUMeb8k7ai3Z7802NTQ/kM=;
	b=jTklxoZjd9VgN8HFtDBAyRDpiPj3NICSHlIWV2VNO6mE6WsHBATyU9tQfN7tTHwigUnR
	 LlWOWZgKdLN52EMLryzxleQfWz5IeL5prQCkbUZqmrlJlSN5J21wcLsalv5rvpeSu8fZZ
	 L0+z09wxQAnW4c5ZJ5Vg6zNHaA7+QCCWnau8n2PKPCb71ZL6EbKUgKOueckva159r5KpM
	 BqTHUgvGRxzs/HoO/3SHsPnBT3FanAPFgT0ixRVjE6GgGhH4psUI/Ts1KSBp1Wqiu4Ijw
	 QQeLyXo2d8F5GLmrh3PuZXnXKoQ+hm2k+p84Ri3+cUAIl84cqSEiEmTP3p0Ns/prc0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOUks73f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D86660A382F;
	Tue,  3 Nov 2026 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOUks73f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC9C1F00A02;
	Tue,  3 Nov 2026 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704266;
	bh=VuwVRdvDqCkcqJ5PJHMF6vUMeb8k7ai3Z7802NTQ/kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EOUks73fgJnqlSXAkmCa587RZrLJRZ0VTowmJ9cNDiCsu6A1RFVY/IjVjZdIdG/ms
	 v6vLmzgrlgZfPfznot5XJDQqmnmHBgV/OREOSQU9sRTSY/2h8Z1Cndmz2GcWv0130m
	 dO7iGATWSHLXZi0oNnu81o0RhaHwCpQDEtx96kcNasTzE+xaRBcZsIl9zwUDaqjrB8
	 1K5eHUexYg01hRlRjUHT2/ulCBDj/cXMFhAmebM9o8zp9cr2bNC+QSs9IX/RgbTvDg
	 4x1kEEaumt0//dpqA93XdGVcVCwejQTT+a2CDA/nDQlhNuW4A4VJkZyVxBKq1Xd7pQ
	 2Uz+AQpv9nrhg==
Date: Tue, 3 Nov 2026 12:11:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	stable@vger.kernel.org, Petr Machata <petrm@nvidia.com>, 
	Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH] mlxsw: spectrum_ptp: release parsing depth on MTPPPC
 write failure
Message-ID: <20261103-immortal-cunning-oyster-316afd@quoll>
References: <20261103102851.1340480-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103102851.1340480-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:28:51 +0000, Wentao Liang wrote:
> mlxsw_sp1_ptp_mtpppc_update() increases the global parsing depth
> reference count before writing the MTPPPC register when timestamping
> is enabled for the first time. If the register write fails, the
> reference count remains elevated even though no timestamping
> configuration was installed, and nothing will ever release it.
> 
> Drop the reference count again when the write fails. Also only drop it
> when disabling timestamping after the write succeeded, so that the
> reference count always matches the programmed state.
> 
> Fixes: c6b36bdd04b5 ("mlxsw: spectrum_ptp: Increase parsing depth when PTP is enabled")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
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




