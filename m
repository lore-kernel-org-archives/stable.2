Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA13EDE72;
	Wed,  5 Aug 2026 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964892; cv=none; b=bzQoBqZGlC7WIC9UbPv9wnNBRHCsQFh8VsmATRppHjxsMuyMQAQxcfk5pskugkXmpubVgm6Os9QMQZfiZkn4SKdPXTcT8vfRoBTI0efJLxeCkmbXMx8tRnsA1ydABzbdY7T6xblV2PTtGjC0cFL5/FR4s7ypHkkAlrSPdeTisac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964892; c=relaxed/simple;
	bh=MLVqhXy1aHbM69JMysKjljAE99zpmfGGYttGJXK3H2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tqYoJ4QDLWKxBw+3s8WqyXvy0St1ENrgOaw0B0cZeQrwGZ/aTOPuhFv4HXyOpCcVpLMV1KNyQaTX7g/qECSXrQLq4AlqgUPljjsVNq14UYscp8bknSCI1YOc8/Wmef36RcwRVFpG0S682Air0+4/JBtS+WflrhEfCziFMg7B0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaB0ohv1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaB0ohv1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170451F00A3A;
	Wed,  5 Aug 2026 21:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785964882;
	bh=0x6FWa3CcZ+trlpKog+0j1YzF5iFFxuOpBdpFBzJpTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IaB0ohv1/vKKZgeBUyFgY9cTwhRrwcrLPz+HpWZNdj5k3BAswITidOM4hRaBcY0q/
	 ha8wchlLDm2xY2sU1jmU8vHPeR3PZoOxSUSknZRGn9j8o6Ns6IsvvjlKHh8ct1QGu0
	 iPtsdqgGQaHNE4vmFvnnJlfavsEZISatH0wg01f8R7mgW8KfftyqlLKXsGhJATJ83X
	 Q4Fmc5AQoMHr6Ir9d1FZffibGKy9znVu5VkoKdWGKS2cfmdvR3lwvn4OkP5w7JnmBJ
	 o7P9KEJP3ofyt5M6IEY1ayebdsIxfq9nSa4IH3qDfe9k1KC8YOQJBVmrJCVEHlwEJR
	 vFuF/rSzYgSmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198D6392FFD1;
	Wed,  5 Aug 2026 21:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: use the mount idmap for the owner check
 in
 f2fs_xattr_advise_set()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <178596484188.530543.11645876783488345046.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:41 +0000
References: <20260729041656.51967-1-rochan.avlur@gmail.com>
In-Reply-To: <20260729041656.51967-1-rochan.avlur@gmail.com>
To: Rochan Avlur <rochan.avlur@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, brauner@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 28 Jul 2026 21:16:56 -0700 you wrote:
> f2fs_xattr_advise_set() calls inode_owner_or_capable() with
> &nop_mnt_idmap before allowing the advise xattr to be set, instead of
> the idmap that was passed into the handler.
> 
> Since f2fs supports idmapped mounts, this compares the caller's fsuid
> against the unmapped on-disk owner rather than the mapped owner; resulting
> in the actual owner to be wrongly denied with -EPERM. Use the idmap
> argument that was already passed to the xattr handler instead.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
    https://git.kernel.org/jaegeuk/f2fs/c/a54ffce4637a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


