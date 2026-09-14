Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523A483817;
	Mon, 14 Sep 2026 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399874; cv=none; b=GVXXCBP9OTKuZ/rka5JCBFl7GqOU8bRl4F3IPRNdgYiJEurdi60yWiXjCDF1aBHhVnInmdDwn+3K+TnC7iTtgWZReGbNGRDD1b6+EF4kcCZeNFW5nGNBoXo9Nd04Fp+95RxPnrLUiO4bp0gD0e4po2QZD46mWYF5afVlgdHNulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399874; c=relaxed/simple;
	bh=dHibTyz/FQavpIDAMGGkANkIWHNNJvPA1wzYTrjMY+Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CuvjIUJVrSNpLts37OeT2ggBg1MWgcDmm2/ZK4QMZNMxp52rRwFSUZvbNt1vZf0uzBK0W/cpw4TfASoLGXAQIlaV5W3RWsVoS+qe+U5puALuKJz4TyRnvyss8AOhSBR5K16int41mMbBLAGP/TFl8uAoQKB1ao/zvDFKBIheZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeX8xs9g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeX8xs9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99951F000FF;
	Mon, 14 Sep 2026 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789399873;
	bh=HpY76s3GnvgYwaOhvoeara9xLcQyChW2rfV0iG9R79s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WeX8xs9gBfGaaTuMrrISuW8ri4bHEZHRM7gyZyJSKwacYUn6fzMakRQ1lfmK/vRgD
	 Ivk+aNbHeaa8lpnC18Q2uKCn2CmT8ebd3u/yLxXXyfYGlrolYlmhoQ74/ENrvVjq7X
	 YAns5CutTvpYE0WQ/a60iaN4yJ7GD8r3uXVq76kYEWWFUsnNPrpYnwVowtAXs1bRz/
	 y6lyTy0nWuX3g5KKLtfKD9AYQNPDIXPPenIBtDU1zQhKvN/iPIONM5Om8y3LTifSje
	 jOR2Q6iRzJln9wzEfFw5Kx/EfM87q4/fz/+2Rs6zPrxTl0gQZgIl5jssfC3FMU5MfC
	 ek86ng5fJ0n5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A843924A79;
	Mon, 14 Sep 2026 15:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: force out-place update for all writes on
 compressed file
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <178939980787.647967.18277345902202465744.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 15:30:07 +0000
References: <20260907-origin-dev-v1-1-85ae7ebc8c98@amlogic.com>
In-Reply-To: <20260907-origin-dev-v1-1-85ae7ebc8c98@amlogic.com>
To: Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: jaegeuk@kernel.org, chao@kernel.org,
 devnull+jiucheng.xu.amlogic.com@kernel.org, jianxin.pan@amlogic.com,
 tuan.zhang@amlogic.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, tao.zeng@amlogic.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 07 Sep 2026 19:35:42 +0800 you wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> For compressed file, compressed write may fail and fall back to raw
> write.
> 
> -Thread A                                         - Thread B
>   - f2fs_write_multi_pages                          - f2fs_down_write(&sbi->cp_rwsem);
>    - f2fs_write_compressed_pages                    - ...
>     - f2fs_trylock_op                               - ...
>      - f2fs_down_read_trylock(&sbi->cp_rwsem);      - ...
>    - f2fs_write_raw_pages                           - ...
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: force out-place update for all writes on compressed file
    https://git.kernel.org/jaegeuk/f2fs/c/a64a3fec11e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


