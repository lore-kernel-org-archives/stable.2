Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571390;
	b=dDntn0GPp56wng/7NI+SDjvfMd0Bibb8r1v2jtp3gMH/vB90ip42yjBsZ+l+hh7rWIWG
	 PrGYug4/ElbOL2VeOj9waEQZiGZGs6XleAAmC97y02dCHX/fgblpBHsSj3nvWm3U0WRMP
	 L0fcRODuZtyo4kZGdmcEA3I9S6JcCtiGWfa+yCKvtmBLbSEQeyhGMj8dL/LgVWvIy9q1Z
	 dryMFFzPGvotrkCmt/gYJ7Ml3FQAtlkfqZi4DoVFwxg/spCp2ZVFuA1+lNuglqu6ZK8wL
	 SsMTdxrW6Cn0aw//oVPlkIP3Khzm60hsv9c+uuBLP+xnuzkr0GehN903wH1u+edWxwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571390;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=kd1+6McIMPpXCjM/eK1XnUd0MHKq5CNasIzBEPub8/I=;
	b=qq9D7pfpH65u+G4zyWKzEOHW0THcah1m7sen2xw/kdvl+6r0gTm8spq5x1EprwywyTfC
	 EBcAkRK4cI/KbThDdjZvaaDxBCdVYmy7c7Z/GLm0tmSURAkOzAekejMG0UZtRNHAOxv1K
	 6/Hn4h2BzfQhhVbiC6vlHNkv7grx4zmNantIeINkYFCur+rhAPeM7BkWkZBpM3tLH9iUB
	 H2F5qXS98pFn0ujQAKOF92gJb8hFSI3dVeNWsTYcguQrn3mwj1ZREBrUvBRn0MTsok5fD
	 yg2zd1iZxNr+O+Kr0EYzHKv5+6PaBvJdZjPlAKAaxTfoYMzfhnQ4pjuhNJNp+gNVXcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUlLLBZ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF6560A2630;
	Sun,  1 Nov 2026 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUlLLBZ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79751F0093A;
	Sun,  1 Nov 2026 22:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571389;
	bh=kd1+6McIMPpXCjM/eK1XnUd0MHKq5CNasIzBEPub8/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YUlLLBZ6pm30l0+huWgQS5KFcpacV3sIViYlLlgtZBTFchxrnyS8Bp46ptx800GpH
	 ms0tcCCwnBu8jhUpAixHI2ZMpbJ4BXne5Su4dMXO/7bUCVl9AQVIuUBLP4vl7wQZgv
	 rZUklVe7MxMb57TOckoPSQz/SDQn9b5pexQYQ6rnr5y2PQEq0m0iBuIwllJyuFYCPt
	 FgWrKGlFZ3mCBkOH5hjwzxX8senRjOfUuL2jk1ZgZ27JyA3nz0QEa+hdXnKH2Ks7cd
	 yjsnEcGAfd78jUx35wSizQNDIH/DFAduRns5hrtdjcBw963LMRfCTmY/LrgNPoYmff
	 gPp6G7yyQ4ZFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1F138003B8;
	Sun,  1 Nov 2026 22:16:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] riscv: dts: spacemit: k3: fix IMSIC num-guest-ids
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357138858.2624073.15621784518365922237.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:28 +0000
References: <20260817033038.2286436-1-guoren@kernel.org>
In-Reply-To: <20260817033038.2286436-1-guoren@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 dlan@kernel.org, devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 junhui.liu@pigmoral.tech, stable@vger.kernel.org, docular.xu@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Yixun Lan <dlan@kernel.org>:

On Mon, 17 Aug 2026 03:30:38 +0000 you wrote:
> From: "GUO Ren (XuanTie)" <guoren@kernel.org>
> 
> The initial K3 device tree used generic/placeholder values for the
> IMSIC guest configuration:
> 
>   riscv,num-guest-ids    = <511>;
> 
> [...]

Here is the summary with links:
  - [V2] riscv: dts: spacemit: k3: fix IMSIC num-guest-ids
    https://git.kernel.org/riscv/c/69f95409f005

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


