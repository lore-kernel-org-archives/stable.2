Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6BA3BBFBF
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154406; cv=none; b=szPDyk6WEEUcAZ/Ett/hD6SutRHWbTAOIjb24t3RTBO3AvEaWVErLVPhHZPv5ncxoVG6QjdOm1eUXnZzjUjxEWY30vj5upjCuPf9OUpp500bGnF2uGTHHa8LiUQLZGbsNob8E/Jw2B41WJGqFRk965duAggqr4ezSi3jNx2OOTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154406; c=relaxed/simple;
	bh=M9vXjhu8UFIq4tIgHbam8WG+pM5/wbm5hBHL1H5GNg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsHjWmjjsW7IPIVXHyaZqYQ6mCZ59hY1C5AB7eCs8tQ2JhK/WbyUBqZ2rXjOM5X6u8Fg8zZFWKo0uu6QOYsx0x7kcJ5gSTgwV9GeDfz3fC+4JOpldONmR8Jy0h4bIhlSHd/xNQN8suXf/rhk9QADg7O0AXlB89djhjNAqo+p+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=o1EJZ9CA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qMmJYHM+; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="o1EJZ9CA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qMmJYHM+"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CA661D00094;
	Wed, 15 Jul 2026 18:26:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 15 Jul 2026 18:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784154404;
	 x=1784240804; bh=dv1hX7CNOS4HOYDJ0+sOHbV+oANNXcw8M/NokfVc+JY=; b=
	o1EJZ9CAqC23G/bv/W11aKBtVs2BSWSujW5MWs3wRBy0HCqZyw1k6ag8fLHD0zs+
	wvKKLOvaStuyUl8kP9b7SIs2D1D+QBG4tBoDFHznW4HSe5JTiqAKHuSDtI+0TKXx
	DO1yuCN9+d9D1mcdlw0kPy5Mc8cSdX8YmNCvOe7Hy11myOT7XCfvFaAdew785GFf
	CR0VX/OsJsbiZUtdDIGR2JYx8vMOZn2WYWrZRtWFfZgDK8KddHrD1TZ8mamxu0GB
	14W360o7GKI0q7zEtTBNEg2m2i45ZRk5vv8xpox1a0zVe/fzszCJ0OkeWix8qsI3
	uamS4/LfE2nbmU+8tKRazw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784154404; x=
	1784240804; bh=dv1hX7CNOS4HOYDJ0+sOHbV+oANNXcw8M/NokfVc+JY=; b=q
	MmJYHM+cikbbYCyP/Y0HXynlC+8edDVz5vWip6Eo3ZlGnGcIRYAfk0M2DiSmf5hD
	JcRQHyTwOTJ1QbOZxcGYVXaxPz6RywSUbYQJ0mXUzXYxCuQKQOBzeJmPpb3RpyOP
	a7nXXBpkh1Ppq18X8Zo5zvE8CBDuYt2k5mEueX+o9OZUVRpOYSDhMhoxTCd2MlQM
	FDozdJBGBQY6JTlQbVJLZdsFbzYC8hGwCEpcb6QiqWNTdtMzQ3n7JN/HC2VVVuGI
	zfSolum+G7I+L4n21FZ+3aWTUnQwRXAd3qiewPI7wuqtHdzLwttMqwTGvPXAulEE
	ZjdWJDQU7au0wJcJH7fHQ==
X-ME-Sender: <xms:JAlYahI482zhe5z3YQ_HkYSddsFwccGyC32-Qs74IzO6luNs6V3DMA>
    <xme:JAlYaq8Zpw21_WI1hwc6F5gAlratg9JpNNEpm3KuEWsxQLsDVqcDLhIW8rMVACzl9
    QKZerRFexn4R9iWMZEfYVJ_cO1c5FHcEoWWj_X14s51PmI0Ieq9>
X-ME-Received: <xmr:JAlYakJfzg0lubxjXhTBiOnhKM-9g4JJf_Jm8jZc_1NqUe0cEtVYviBAGdcjFRfg4sGwdekIHAzW2qJTEzgbaWGT5ST3Ngf_PU-OhEMZq7ueApIivbs3Ge_RVsoD7YDg2CyD4373yY9QZRujuXRqhOT50g>
X-ME-Proxy-Cause: dmFkZTFrQPi2r9LvrSd3M9uw4mX6Pju4cKA0WKIt7a5sJXFNrtJWCbotVqVQiRRZImryOZ
    SMQ8tTKOPWuiUs1hkiZdxpES2UA1jP7wTv1CkwdS0Dyh/Gn2wiLu8hmgh4PGqMgzpnjUq1
    M5O2zfhbiWZs14CiluPBhecopW43qmb/U0YEUGb3hHVeHHJb7ZDb4t+09+CRp5zo1XTDMF
    nLRg5dnlT3Z7lRi4c4MTVUmE6zqWJTsGGPoYpwlkG7KnvBmlfxXfk+9MEWsgBhTdR+1bYU
    Uuwav0WsVi3IQ3vWZE+dQILMFTkMiydI4raQvO5DsYykcwjUSMiC+BIfREYEHnJ/PcmcFH
    lIikswzH7vHsxplv5E2LEinqpaAriLHEh1jZHldOc/O2vxpsm7XR2LaMdgGWXiFdDyvd9S
    ivKwUiXEPCtgPjFtn4HFSmEfDTWfjJu4QdGWD+dVv4yygDuD5zmABxxdl7KMuwQxk+Mowz
    wGX5Qb2lJNmeGEDVZnVppsfCfZ/KjGXqJlqYnj/AqL8SuVzQ5yYjvJhJf2DssantiFEuID
    vk7vE+KVgip+D7Ddslu9/xaRqqHO5ZiwmNsjqhQ61hBukBXd8hDCedOfk5tlSKSFxmV0N+
    /douSvOSXGd5E6YO0335m8ISE/2gA89MyD4SJwj3OQWBy1o7mjxpQ32Vy9hA
X-ME-Proxy: <xmx:JAlYavko4qVe53aGjJXNkpV0QKj6XWH4BUV-1tvt7ausWgPtQKJ6Ew>
    <xmx:JAlYaoM7kg3FD17jpJclXdu59eTyLibpYLBFQTup9Loqw0ckWK-wFg>
    <xmx:JAlYal3vq7qj2sRdVWVyM1kkBfXELe-5_c2Ft454pXdsLAAnM2r5OQ>
    <xmx:JAlYankLEeclu54Ctzq-AvKTRjPz7m1gy05LCgMwQJEYEV8TYxMmSg>
    <xmx:JAlYanUXb_YxoTajck1OKDhJvUozi7wxwB-8ZBw11rrOslTypqKKib6J>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 18:26:41 -0400 (EDT)
Message-ID: <17c5a1f5-0743-4c06-b771-2562ed6d45e2@bsbernd.com>
Date: Thu, 16 Jul 2026 00:26:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] fuse: fix missing barrier when checking io-uring
 readiness
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev, stable@vger.kernel.org
References: <20260715174305.336261-1-joannelkoong@gmail.com>
 <20260715174305.336261-2-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260715174305.336261-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/26 19:43, Joanne Koong wrote:
> fuse_block_alloc() reads fch->initialized and then fch->io_uring.
> fch->io_uring is set before fch->initialized, ordered by the smp_wmb()
> in fuse_chan_set_intialized(), but fuse_block_alloc() has no matching
> read barrier between the two loads.
> 
> This may lead a CPU to observe fch->initialized=1 but fch->io_uring=0,
> and skip the check that blocks request allocation until the io-uring
> queues are ready. This can reintroduce the lock-order inversion deadlock
> that commit 3393ff964e0f prevents.
> 
> Add an smp_rmb() barrier to pair with the smp_wmb() in
> fuse_chan_set_initialized() to prevent this.
> 
> Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring init is complete")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 5763a7cd3b37..b70c536d7e25 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -85,7 +85,13 @@ void fuse_chan_set_initialized(struct fuse_chan *fch, struct fuse_chan_param *pa
>  
>  static bool fuse_block_alloc(struct fuse_chan *fch, bool for_background)
>  {
> -	return !fch->initialized || (for_background && fch->blocked) ||
> +	if (!fch->initialized)
> +		return true;
> +
> +	/* Pairs with smp_wmb() in fuse_chan_set_initialized() */
> +	smp_rmb();
> +
> +	return (for_background && fch->blocked) ||
>  	       (fch->io_uring && fch->connected && !fuse_uring_ready(fch));
>  }
>  

I wonder if we could remove smp_rmb() in fuse_get_req(), it follows
fuse_block_alloc().

Otherwise,

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>


