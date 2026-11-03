Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704261;
	b=jJ65WYOxRSC6ozjZHfkWMWtXaX2N6S2Nex3hJTOI2VTfGcZ/pTxIqY+VQKuhi5hohfAj
	 8hrzuX1ksxqOtQiX60DCyRrQ83cSz3066HgAoWfY9oe2PUuiuNYWyc/11xNCyNu3yulmJ
	 WU4X/v4A7ot+7xabEaCdjTioY+4OkxO8j9EJM+KaX4QoCPcWUXXfBYtUCPuXaAIL3wTak
	 vG49fbWIrC3rpXfeZ9daqw9xM5ObO9l5Rkp9qm5tMP7AAsBebxI64PAcMl8owHjiT/bLg
	 xbEVPYHhZwKRbMkknVlz1tHno27aIAyp0uWaa0VuveOWG73pItepx8vtqiuyxC/5Ypw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704261;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=z0OPz57SZV2MJ4n6b+XxBbFka1xgskYRthtK4/qQk+Q=;
	b=fKyiHm8uMZL6lkUZKEDEzjGtcX6QdgWhY/NfckeL4xjSNPt96VsuLn8oL73DJsqZLwS8
	 +fXcmEr8zRROLz4Nw8Fj89z5FXxjNf2uHbdkrHWSbh6fYOlUegE5ktinLWblUW5awaO/t
	 Gz+22yzxXDlkVYWaqDGEFhoE5xfccyr4m+UTLQdNve2zn6zegU7PStO1cr/Sc+0/PAbIj
	 7lQ/ank5onKybTl7NIp8iMy5Y+iFVS/fm54wNSaImkKPetbIfVgCLHlNLj04SS7fhC0nw
	 dvoLhkBEFQ6Xw1YUaoQTHIGwryKNoC0FO0kWSNZdjlSqqtnuk5WA30gNHAGwvxW8SJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TI53Nr+W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0991B606F7D9;
	Tue,  3 Nov 2026 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TI53Nr+W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE981F000C1;
	Tue,  3 Nov 2026 11:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704260;
	bh=z0OPz57SZV2MJ4n6b+XxBbFka1xgskYRthtK4/qQk+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TI53Nr+WHijMPta1Xv6mUlNk3ID7Fg/LOppo0oNDOKFrTpaHwp7nOk31bq6oCTXAG
	 3s3c6ev5vp3PH04aHsPRbIXQV4CEu1OdvYqADgIlbcy5zmc+mnZuETUCWdMweFg/lq
	 avTCuK2ay7VjS4cFQdIXxnzZ3fVbnnbAxWmVmOOXu8i6fqY/kWniDwsQySi5AmPJen
	 rPXKqS+aC36unFKLfuHVjYEKH7e2KKiy/Uyb/2KJv5HoY4SUCMSwhSeID6BOiBWzaT
	 BErOr+H20HDhgv3OCxkqIesZVbTmOP+9X2IBe8KcRcgFRPI51mzvEKxsW26SJAlpOC
	 2H4A4xitkwD0Q==
Date: Tue, 3 Nov 2026 12:10:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: wcn36xx@lists.infradead.org, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: wcn36xx: drop the SMSM state references on probe
 error
Message-ID: <20261103-wooden-interesting-crab-d7eaeb@quoll>
References: <20261103102902.1340936-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103102902.1340936-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:29:02 +0000, Wentao Liang wrote:
> wcn36xx_platform_get_resources() acquires two SMSM state handles with
> qcom_smem_state_get(). Each successful call returns a reference that the
> caller has to release with qcom_smem_state_put(), which is only done by
> wcn36xx_remove() for a device that probed successfully.
> 
> Several error paths in between return without dropping the references
> already taken: failing to get the "tx-rings-empty" handle leaks the
> "tx-enable" one, and failing to look up the qcom,mmio phandle or to map
> one of the mmio regions leaks both of them. A probe that fails after the
> first successful acquisition therefore leaks the SMSM state references
> for good.
> 
> Make these paths unwind through the existing label chain and put the
> handles there.
> 
> Fixes: f303a9311065 ("wcn36xx: Transition driver to SMD client")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
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




