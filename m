Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8004392C4F;
	Fri, 10 Jul 2026 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714230; cv=none; b=qkoo7VvDuBFmSKvtXdEBO6V/jYcxtvVmPpiuoy7sgxRknIWvcZF0SlZZtosTRYGO9ycpsJ1NOzcnZHFNQFvFEUBezmhRFsKQYYUFrz9PkWMGjBA4pcLfyKG3g/CIgTK09swGFYwE483BFugdYqDaz19wSBKlbaEXEdUB8OISzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714230; c=relaxed/simple;
	bh=jZIAEm0LzIEcZBtKbcx+mOG90RASyx5ppq/tnH0pX34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ApzFXI4FFzoKFxy72JCbEbwvT0I45Bku9u4aekyQHkEqc6OMSqQXM4Zu+7YUinUb7CduWwpx6auhUS/YjN7/hinI3otbYejNQa++LHoZQcxO3JOUQVvaS3PvQSzDIPMPJKwNL6hUTS75NRN5t02+NkCTtxSd4T6J96yn0phgvSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBPeHGWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBPeHGWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7936E1F000E9;
	Fri, 10 Jul 2026 20:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783714229;
	bh=xlDN542xXEMw45sKcUigc30whE2e9cufU6/XheKlFKc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZBPeHGWo47lz6QwGmdCK9KO2WaHHmtYw7FVaORoziGPZmJpYnQnkLYx9BfAXLLT9z
	 kVNGIdZnorvyHBCK2FBtpFfp4+d7OmNpOCdRqscJ7ufx0IWrvDzyEwYUxgvoKteQoQ
	 I6SiznyMmmOYxuTpqYEfYXYjD5f1zeyThdCLMGGaGugKwu7J1MAcAPw06wFCpiCcBa
	 trLDQIAygMhmV5ydyRPrce5i6GD3qVYm510b4sZJN8GgwZccaIMODeCHZBR7/JzG3h
	 uXsbvo0Pld9EaFY6SY/MbUCCirshxL8AjSrm3SXNPe9mFGE6u9TBS56W17Aw1/srD5
	 HPLDDdGg5r5GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569CE3924700;
	Fri, 10 Jul 2026 20:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrtl: validate firmware patch bounds
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178371420689.843459.7488755213090569844.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 20:10:06 +0000
References: <20260710172503.64964-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260710172503.64964-1-acharyalaxman8848@gmail.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Jul 2026 23:10:03 +0545 you wrote:
> rtlbt_parse_firmware() copies patch_length - 4 bytes before appending the
> firmware version. A malformed firmware patch shorter than the version field
> can make this subtraction underflow and turn the copy into an oversized
> read and write during Bluetooth setup.
> 
> The existing patch_offset + patch_length check can also wrap on 32-bit
> architectures. Validate the patch length and range without arithmetic
> overflow before allocating or copying the patch.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btrtl: validate firmware patch bounds
    https://git.kernel.org/bluetooth/bluetooth-next/c/d09cff8f7ecf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


