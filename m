Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90B3EB0F3;
	Wed,  5 Aug 2026 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964893; cv=none; b=VVa/rCCe/srxX0KYvoX2Tf6ggN9M+fqBmxXRPv19lj6M4gHkUGM5UZMPVpDfazG3PLABwJo5CpvZjSrGK49B3VtVSMTJdUpz2Ln1wPHBXfXDKjgnHEg3hUn4TR/MbNFqQ30XY2jfDCphHxhFa1J5F6D1rhkrMom7FrFqWvFf/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964893; c=relaxed/simple;
	bh=k1AtrWdekpGDx3JYL/5jJ0dU7ztHCvArXmzLW96TUCc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jTaPMjJ+DLY6IvwShB4QC+CL4QXsx/1ba9vrIXe/cP7S2MIxD5P9O86lHf3GMgrXvwYbdOJ2zgWaLSY0TeL4/TvI35Bj+i4ECUKNL9VJYBojbszja9WlKu6FFSQz5V7OVQSQJeB5vmppjhPwaS3cD67lflSZlKIyQMTPnK45+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxiVkdsU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxiVkdsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140CB1F00AC4;
	Wed,  5 Aug 2026 21:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785964888;
	bh=VBAfDmBTrS4RbICPXLAAqohn/AEjIYJN050Ab/3SqCo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nxiVkdsUe2VaL/LOJ0Oi2Sbt8/nLaJM9sf6MdSr465ZMGBP6pczxhT3PkwlW+rq3V
	 5/2LV0JihhEzJ4e4DFrJUzziS13+YcZBiUj++HGgL14ZYc7yh8uH1lyar2CBjCBhhT
	 2sb5/8GgQfxNQ00soe5whGTL2hanxSf4BcYuJ48eiF7u5Cs2WK120+xVHuhF6HK/5R
	 7rfupX2A7Y9xdG5GCRJkTgdjfF05N1iD2Ro530E1pkuBQfvu2HLHN7VZusZk3b55iO
	 3ZzWqF1qhaHvoCILnFgpvfacj67tK4eUzJaXlCvE8BY3cPZo9kascn0ndaVdHoeGev
	 hQfUu94W5LEDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19827392FFD1;
	Wed,  5 Aug 2026 21:20:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix valid block count leak on data
 block allocation failure
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <178596484763.530543.1976176179653312885.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:47 +0000
References: <20260804005402.13026-1-chenchangcheng@kylinos.cn>
In-Reply-To: <20260804005402.13026-1-chenchangcheng@kylinos.cn>
To: Chen Changcheng <chenchangcheng@kylinos.cn>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, ccc194101@163.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  4 Aug 2026 08:54:02 +0800 you wrote:
> In __allocate_data_block(), when allocating a new data block
> (dn->data_blkaddr == NULL_ADDR), inc_valid_block_count() is
> called first to increment total_valid_block_count and i_blocks.
> If the subsequent f2fs_allocate_data_block() fails, the function
> returns the error directly without rolling back the
> already-incremented block counts, causing a permanent leak.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: fix valid block count leak on data block allocation failure
    https://git.kernel.org/jaegeuk/f2fs/c/0f9af07ecc1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


