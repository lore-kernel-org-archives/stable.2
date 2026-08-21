Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC03947B438;
	Fri, 21 Aug 2026 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327464; cv=none; b=GbUImFsUlOpRk1LenwZaO3IiTkJ3uIMDQRttCe0t2X3dc2ZKXzQxlaI/IKSupfwIwUtmGbdA6WA6HfKULZHCOUpVGM2Win78qpRFgn3aPLafikcWbnvl4IwfpVco+dBqzLBJj0M8FceEr2ar5OzIy72b/Rrp8aWSpN+mUPO/CTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327464; c=relaxed/simple;
	bh=IaC8tMW5U9S/PogF1BdgHeYdRkUF4Kx41VANNqXG9jg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=psVOG+eGv2t+Z1ftrjzX2LvWWh6d32Ui0Ze1NZBhaMMp3UkaL5NESjKg0t4D19vdHZmMY9Z4oQv8DVSiSD/YMKOm4L4KOtme6zvymwufYDcmClpI4W/qEEZ5L/QKTF57z/b1/tF9KykASB7rYfR6jzRbXdIGPL3r/QcI5Q4LjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgcjubUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgcjubUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F76D1F00A3A;
	Fri, 21 Aug 2026 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787327462;
	bh=B6wjr2t+T2ZZEmurJBrGQ+M266u9ejT5M+O+ELQ+F1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DgcjubUhknuv2a8Ok9VR9MHPQG4MAP+cIusaJgkOAm8E4DWlnwznJfNEL0XIcfbat
	 nspjOig23dnxLZPZX47yPqxmXXcwe7sVhUluZP/D9ZY1jFZt4MuZzNyjwfeTC5RyGC
	 2Q/HRCeDzdRthF123N00Y2oLvjqt0iGfHblCp5CCQL92CiY/GoIJ1j/moddwXPkvVF
	 uLwQHiD4nn56HGHR94cAr95gT2uCjdd92WhSTSVA0Pz9xoCcTDM60It3a2zRzNm+LS
	 NDKShjEgnSILJTaNDSMf/yi6lwW5/dyM0wKrMkkFIb/jdHAdKLlaSJEXbhSziCWstf
	 A9wFWAupvbS9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19840380A979;
	Fri, 21 Aug 2026 15:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix i_size when pinned fallocate
 partially fails
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <178732741163.1339488.13084551475061126977.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 15:50:11 +0000
References: <20260818145535.449055-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260818145535.449055-1-zhanxusheng@xiaomi.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, zhanxusheng@xiaomi.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, sj1557.seo@samsung.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 18 Aug 2026 22:55:35 +0800 you wrote:
> From: Zhan Xusheng <zhanxusheng1024@gmail.com>
> 
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> Commit 4275b59673eb ("f2fs: fix to round down start offset of fallocate
> for pin file") moved the allocation loop's start down to a section
> boundary, but the error path still converts @expanded against @pg_start,
> which holds the unrounded start.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix i_size when pinned fallocate partially fails
    https://git.kernel.org/jaegeuk/f2fs/c/0f448bb3767e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


