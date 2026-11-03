Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702450;
	b=WZ+mQ9rJrJnPE2cZtJGVkx/wjGMwvW2HvW1NK0h3e0Mp9qDBbComjbN+r9aRjQPWoprW
	 0t6XY4h81dVpj7yZcYJcPRqcZJQh1pM9fFz6gxrtbCNK1fCKLZPPkTxhtS4fMaBkEM9vX
	 qzIDIIkG6RsueneErf++nq1uvct8PCfLfP0XovZWrP/NLHpPrO1ctvB+YhR5tCGTcGVOy
	 BO7eJAGqRdW3B3JP8mwgLHsPuX+PWITGwPrJUTFWizybBfAPqxKhJ5xpb3Nz3MBYDAlLK
	 cSN1t8e+9z0Wwa9VC8Qb4E0e/DvJuCra30NakD5VWT/GPpTnszca5fYTYtwLax2Y6HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702450;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7cPNRbxb/LnDFsAuRuTFvSIWmpuJ575O0BiBLXgpNG0=;
	b=3LiNGQXwjgWPp5ewVpCRV06FFjs11Zt5RRuWG59qppxgBy75ReBIMosDkWfm3HrCpnrZ
	 8YNp92lRx1/zVI/IjZ/jfM6rJglIOqjOttr+rslDcgDrp9zBNls4a9iA1JUBwoJDczxbl
	 2q/d6KcLeZyXLzYS8QVF5a0tEodmJxWVFeqxMY/5BcazSvvWTtg2jR8zKh8eRSNrXtzRh
	 FS+sA0ZzpGEDIadPmOkj6IX2NnENEaUBymbpf9OabkqFrvIouP7QMgevxSnquY8W6bBN3
	 u9Zb4hmvR7xSbA9ZRg/8fZV+0mPECB8Mof5pOuMRJKZC3OQyMdii5ji8Y6cWytZTnlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikqYXyWm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C88606A820;
	Tue,  3 Nov 2026 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikqYXyWm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0894A1F000C1;
	Tue,  3 Nov 2026 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702449;
	bh=7cPNRbxb/LnDFsAuRuTFvSIWmpuJ575O0BiBLXgpNG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ikqYXyWmiVNGezDiwOm36/8kyY+VFgNVlAWXFCw0B0kR9QYG1J9Cp20Ckj2/RDlcv
	 z53sV4uKoMSdJXez1cH1ynNPuSHzEGMvz+2nk7uqR4pDFizoKbQam37kIf/XfqJCLL
	 YSaDBsn3gMa+wyUvdO9CmtN65xRpJ3ULe5mfhro6tZYzJ45XbscolFE9bL+TBZ0Z+P
	 xR5IPu8xylfHIw2lZlmt9rciBC3JOBWHy3Yz9N0f5yUFaic+QTyShEgPMTwvVyp8MQ
	 IlAcBLNT3CK7qHfVSzuN2TG1aX9BCa9gSH4HLEIDxU6u33NpkxdgVIyQCQJjVZ3wF0
	 5gxle4rhnnScw==
Date: Tue, 3 Nov 2026 11:40:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] net: ethernet: sunplus: spl2sw: release the port node in
 probe
Message-ID: <20261103-magnetic-fabulous-boa-c6fecd@quoll>
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




