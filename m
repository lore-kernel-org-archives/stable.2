Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C23B8921;
	Thu, 15 Oct 2026 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083627; cv=none; b=gjNIw3YHS4QyioEGVESNCgbtAFgJGvLhRAXGeiF47fbyW1kbMzaOluvN2jN8ufCYX8orYSg5DbmUpY3PChbJmwdeXvVflikCXV5d3YCA/VmmlSGA5ZdCvg9LzPE3kPHO1yF1B4Nzv81S9bMpHKL9+WICrBML5F8b87He2DHdb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083627; c=relaxed/simple;
	bh=qJgdy3I1ByCJiJIXwL1hieEsMZReHn0E2X2KaXsl2ls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ho1ccnjyZO+7QbHD7EfjaAfjf9c1gOrYD2x2unkqb3CD+rCL7jxiGA/MDBUTzP+hFrbkTW113IuaqoxAfRbmpX/spaCfJJc9tpDv532NeVAgQyHBkm7b7MacU+QB260i2deJuH2eQXiE3Uy4cA0uGY/gLN9csXODKeSoWvLsPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9PQoUqI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9PQoUqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B537A1F000C5;
	Thu, 15 Oct 2026 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792083613;
	bh=EnVH/El3lsJ985kz7PRqXdqaNI1QwQfIBF95HlvT3ZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Y9PQoUqIxmvwP8mQ/R/4JhtFogkE1llDXKwYJ6ygX5sMAIGy6jhxG4acFui/0OXlh
	 t3lqx22GfB5Z/NULaAjlm3MqqaLl05TKKXnL1scOfnncV0n2DgB6zMCamkcOiL8TC1
	 ENmAc0GAfUtVAnNy9ae1UgdeiLVDrvb+uRgGENZLyUWf8SeerYXgDrmkeURuCZGide
	 Oep26LsfiIj85cpOrBSxxy7RQ3tEQZ0+Bs1blCqRcjpbcZM+yahYP9P5MkTMpR5eil
	 UW7NTUehWC7d6EweMpIMfp1lF/fmoPaY4s4KTYLHnwXWEd79zwONEVGc3Dvk+y/OKZ
	 ONgz0MphxQj2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A98003808209;
	Thu, 15 Oct 2026 17:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: release a removed xattr node in
 roll-forward recovery
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <179208361251.4008483.14776408696216396844.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 17:00:12 +0000
References: <20261015025732.1564032-1-daeho43@gmail.com>
In-Reply-To: <20261015025732.1564032-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com, stable@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 15 Oct 2026 02:57:31 +0000 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When xattrs shrink enough to fit in the inline xattr area,
> write_all_xattrs() truncates the xattr node and clears i_xattr_nid. If
> the file is then fsynced without a checkpoint, only the inode block is
> written, with i_xattr_nid of 0.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: release a removed xattr node in roll-forward recovery
    https://git.kernel.org/jaegeuk/f2fs/c/3368225b737b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


