Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702470;
	b=rS1LIym2PYJr+3ix/bwX1yWjDpi83WJURq0EIkxkgmemLtJ8aCTJliZJMhJVU14VdjkB
	 cl+Pt3oAjtKFJczgrQGdN3UlPrViz7bRLDpWwnGfrxE+9/otaT1gLGN2koIFIdIXrbxmR
	 5XpDUOAkw2+swkIk8y5yuU2En2FvmUEiD+3Uu9gy/GgnbgTjsnRqZgGltGYdKs8qcqlGl
	 akceKFykSMuAo2WsFm1OvY7aOo0dZO6ywRyNpYzUMlkJ51Gt+mVsXCSFqbE+gO4qeK8AK
	 uGmcS0gJusNfWFz5ftas4mcGYAFo/lPsI9CCMpWxS+3SdlLTvE5rlQ9jZbZQNOu+sfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702470;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2ZChROafYGqElVUd4oASxYtU7K3gh3Nswh9EtnpMFEw=;
	b=M77NK3c2CNjLVX8UELcI95bR62qiHOj4OiLWX1ot8zd7hkzeILFVmoceCnE0CD8oMlLK
	 ooG9oBroEiBRrPAxXqF2UFK7dIRMuYtYTH8TATKwG2lCAmOhyVfQcVS66gzhLgjh+OMe8
	 9GKUJYO0/NfLlLwlAMXZVwB/4NcybjOVqeilj5ZmGXXHKLkj4s/emKokWeosBzGhlHdoR
	 GiU/Hiwrzfvjcudz0QTLrW/0LzdPGEeqUPA0s7mZ/ZFFo4TbgjVAkkPcEcbjt+jTtGS2s
	 jJBkmg6/LdXfD/YYUI+n7w85QuEgwkTZANJQ4331UXLqI0MRLqVOVGNHm5dne5morwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DNi7+NKi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E16082BF4;
	Tue,  3 Nov 2026 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DNi7+NKi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F371F00919;
	Tue,  3 Nov 2026 10:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702470;
	bh=2ZChROafYGqElVUd4oASxYtU7K3gh3Nswh9EtnpMFEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DNi7+NKi5mqwTRs7wbCDFlBB32pwn0Zp8J2ZkOcIMYJi4eFXeiLDwB/1ze8ZMMfsc
	 Ky/qOhent2cDlgDpDPq+E5PVY5FhIXibKfYrhBOwa0Kgmf1ZO/WeQ4X5KVoSEhjpnQ
	 RsiGQ/Nmrop0L/X3n06UuKP5TP0EnJAWdZ2sIPRjhBt9mUjZOuERbbzoVa9vxA7SWP
	 aXLiK6X24wEcQ1dtfzFGY3hDsm4OaPVyE53Q1MSdAhlEU1SJxwRBW0hDFdxFZdNIPP
	 nZGom5Rrz1a2gg3VfBTr3aG8gJtz6o4kQtxOvB9HZiozu76zNzTRbtQFQno2zov5Jb
	 NZo8DZmTdrYsg==
Date: Tue, 3 Nov 2026 11:41:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, stable@vger.kernel.org, Hans Verkuil <hverkuil@kernel.org>
Subject: Re: [PATCH] media: cec: extron: release the v4l2 device on disconnect
Message-ID: <20261103-screeching-llama-of-action-dbde2b@quoll>
References: <20261103102850.1340434-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103102850.1340434-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:28:50 +0000, Wentao Liang wrote:
> extron_connect() registers a v4l2 device, which takes a reference on
> the underlying serio device. extron_disconnect() never unregisters it,
> so the reference is never dropped. The extron structure allocated in
> extron_connect() is not freed either.
> 
> Unregister the v4l2 device and free the structure at the end of
> extron_disconnect(), mirroring the error path in extron_connect().
> 
> Fixes: 056f2821b631 ("media: cec: extron-da-hd-4k-plus: add the Extron DA HD 4K Plus CEC driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  .../media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c   | 2 ++
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




