Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704198;
	b=AtPSeNmbi1xdA+zA22VUTWdbomxfBaH1/l14z/zMO0oLm/u7uoOhZiRuRAwgzpmZibuG
	 N5eK/8D5+IoXLi47ymmfJvL6zCMiR+O6jl4wkd8EAl5MU5XBJxhRIgaUXMCXddmW3UKdN
	 XBsv7ur1yI2OwIy0kIUmYmCXsNjWnu8mT8wBDQxSjvHWbm9hePt4v/hXnVCwO5pJgx6Kc
	 zDYUfz8zjT4ifOu7mF17t7VFFdeOklLlJV5VtyhCrid7mWesxBpUQKHIu3/ZQtenrAEms
	 ZZc+Jk2nRz27TdxwZOx9gA6EmxmpUaikF9hEFWOF+OpoOSdEL8zaiNSj2o0wgrdU/bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704198;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aDcn00x3HCJLq7a35uucPjttQqk01CWu981mURwTv6E=;
	b=prgQBUgYXZPKBLEzEPpD7V0W4Ykn/0ymJxiwtZL0qvzRC7wNPWMxFR1o1Xrm6VAWb3Ut
	 YcM63PWHFTgy6xBvrXnbkZ+B7zF2oF20jvrPCdK8vxP7VdGyB/JiVk8kPUN9xLURWftkC
	 BB9DFakfKt1IyU12pnh+tucTLcJX214jK8X8YPhdTXq/fcoU4x+seHS29heqnwrvPNuIx
	 jG5MJBbkoQkSp4aymv6M+g8CWhkhfQ3Y4sB+1vSSL8zdcmzSG8urPYMm41z1tg85W7PZ3
	 BQAx9r2oadcrh/hh/RJf+cZSsh+6NLjiHkGL4QjCyX81I5lUSsq4AGFJ0TJNc3iKBVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C00YBWCH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E768606B11D;
	Tue,  3 Nov 2026 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C00YBWCH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D4B1F00A1B;
	Tue,  3 Nov 2026 11:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704197;
	bh=aDcn00x3HCJLq7a35uucPjttQqk01CWu981mURwTv6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C00YBWCHcRN3w3WEARmmeZzRMqYKfN2blSHKYeslzgwEw0yZLUe21YW8gnYBKtPD9
	 QUpjz3u5gDeH8iXWogZ/IFeAE5J/MiV26MHSAwj31SHS3M9a83zcqG5ROK5glr0RHX
	 UbjpqoF1Gi1t+12qvMrSsbB5PelzHX0aKrzBEyoSWI+aWxixhGgQGoczSlb0JKfNAf
	 iQ36pikIOsR0MwwG26gdRJiuXypquG+8h3+m+kUuPmUt3KJ5GZK0eFb9ELxR8i6k0N
	 fiZ+HbxVqOsKbiD7n22LiD7dmfdv5sMGey7igMmigL1DjUirmthDTvneAWsgPcVhiq
	 JGgvCDtb116/g==
Date: Tue, 3 Nov 2026 12:09:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/IOV: drop PF reference if max VF bus computation
 fails
Message-ID: <20261103-easygoing-imported-pudu-ce7e77@quoll>
References: <20261103104239.1373721-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103104239.1373721-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:39 +0000, Wentao Liang wrote:
> sriov_init() takes a reference on the PF found on the bus and stores it
> in iov->dev.  The reference is normally released by sriov_release()
> through sriov_disable().  But if compute_max_vf_buses() fails, the
> error path clears dev->sriov and frees the iov without dropping that
> reference, so the PF device refcount is leaked once per failed SR-IOV
> initialisation.
> 
> Release the PF reference on that path before freeing the iov.
> 
> Fixes: ea9a8854161d ("PCI: Set SR-IOV NumVFs to zero after enumeration")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/pci/iov.c | 2 ++
>  1 file changed, 2 insertions(+)
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




