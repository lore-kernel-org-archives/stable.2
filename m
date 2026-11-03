Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702459;
	b=YdL3mXuZa9obfzCvx6FhimxWq5iiNwH8s1MfYKNd1zfHgWY2qBmOcRL1yRmDxg4BZG07
	 c3kN48LTyrbDuoCLUEbyaJJkLE7ihDmmU9dwHGlao2QEYMYq8L6+sPqOG0JL37RiDj+4N
	 eRScWaws8SZ500dtweKgpFbgKKBISRERMkCevR8Nc4oaW5ZkPFoc+oeNNugNmDF0be8a4
	 Np+guoRQtmM8nm5mIFKEzp2gKoNqPds80TpOYqsxVXFhcKrxV2BmDi5nFJCNzOOfkKkck
	 sGAhjGcrWBNgC4BeCwhsbVjr15o2+78RBMxYymcR+lAtB6TTrG0MXpfd4msouFPC/ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702459;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iD8MUsnfG+gwEr4piWPtvFiUZsvtNz+QmKslAm5U2v0=;
	b=EZSFyYJiqkhafHw9tydVE1C8UcFzpvfIKxdD6rUIR2gUieqqcFaV39K6PvsjBu3HPKoZ
	 0QWc8ZOd7OxD6Yh6nnGxXQ19AAm4VITRY5w2ScwnBkVhtkU3U+TRyYAcLIzPeHrzd8igJ
	 OQL/HZhGcVWMJN6JBD3i6kxctqCqmDRbEPkN9wcoRuOqk3hq7brH7XjQw/BpYLU0qXa5T
	 6SzVDatsLshSY2Q4ZXBpc+4GhV1dtBceO3kiiobMqcV5RRMZ7Xu6uieY20+16i49It6N7
	 xj2SoWZSr1fD4/EWU9jUKTt1wPEElgbm5zvek2ZuW4tSYv6FoIp7Qm8cQ1HqhK8nsEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hf7vFOQQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4F60784B4;
	Tue,  3 Nov 2026 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hf7vFOQQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963081F0093A;
	Tue,  3 Nov 2026 10:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702459;
	bh=iD8MUsnfG+gwEr4piWPtvFiUZsvtNz+QmKslAm5U2v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hf7vFOQQ/d3CxJjXaTd4dJWmgKR9Frd7SHMnNvxpReYxf0Ps3shQxk644fYm8rMoO
	 W8NgG25Rkve1DLxCJce8dJ3GHJP/kb4s/3mqBlPeRLZZ55XAoSDL2zNYlrhM/hqrtS
	 RJcEpQU82Aoht3jeSs391paDKABAC+cCPDb6R+ecIYpL50V/bRXujKeXANOFamrggD
	 8O2SIZtAqSLyTDXC82D7vWkVg4L7I/RKOYVV0lFUZr07m0v3H108gbU9sLouBZJPF/
	 EOyVyBzFJatdVMU9z1S4JhhrN6GHGaSm081XBTgnlLvtTY4x5AvIW2niCMdYlvX8t7
	 vV1z6OSPFZalw==
Date: Tue, 3 Nov 2026 11:40:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH RESEND] wifi: ath11k: release the rproc reference on
 teardown
Message-ID: <20261103-tidy-mustard-moth-d5c3bd@quoll>
References: <20261103102915.1341148-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103102915.1341148-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:29:15 +0000, Wentao Liang wrote:
> ath11k_core_get_rproc() looks up the target remoteproc with
> rproc_get_by_phandle(), which takes a device reference and a reference on
> the remoteproc driver's module.  The resulting pointer is stored in
> ab_ahb->tgt_rproc and never released: ath11k_ahb_free_resources() only
> tears down the firmware resources, and the probe error paths after the
> lookup jump to err_core_free without dropping the reference either.
> rproc_shutdown() does not release it, it only drops the power reference.
> 
> Release the reference when the AHB resources are freed and on the probe
> error path, so that repeated bind/unbind cycles no longer accumulate
> remoteproc references and the remoteproc module can be unloaded again.
> 
> Fixes: ba929d6fe31a ("ath11k: Remove rproc references from common core layer")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
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




