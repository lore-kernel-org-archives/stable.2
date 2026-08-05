Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103CA3EB815;
	Wed,  5 Aug 2026 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964897; cv=none; b=Fyc/rfohzQaxzstcaqrFlBqCNjFk1vzTZvbqx8VJ8mW621w/ZNu3BPquvSTJebrAXzHuDwbGstzRcERqsju/1VK9uMVz7I9Mc2b84/RSE2v3TzX7gCD4MhBFFaZKZpHTyZu+u/BQKqoj3BqpNRYNMAKCJbU/tnbN6CfsSDjE+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964897; c=relaxed/simple;
	bh=5NvPgxdI0okbTUm0YGSsiDVyyLhlkmDeuN5yP4qrACE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rOpUOtcPcJ0jdxRXyWDaIqB4UCdLSDTNlaEK+GpoOjjVyEDF1ggexvnM3BYMNClVJfsAwBq5Cuo65aPtXDKX79kV2yDgMc6vc2i7wzBs0oh0cJgT4DC1hy6MrJYpAR0OCrtnjtxNQAJ+FzRfz6XFfb+oT+TQ+7L56PROstDXmvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKrPIolg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKrPIolg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAF81F000E9;
	Wed,  5 Aug 2026 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785964889;
	bh=SwePjaVLbFYbaEqytLvqvghBaG+QqjlAawQwJa0aXoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NKrPIolgdsfSmBSKaRJPqFuCzL3EdETQVvmGo2Us7V59CpV/7L0l0hp375GCO9rnD
	 EhwpBBwefM8TKXjMTBMTlfgYbCx+qqqQ54RAg90cVWp01wohXriqwHndX7Uo0uklGf
	 hhYSo+PFUmlXEqcQyuREbyJ0pQmC9Lj5swvVcpMjvRaz8x+YivpVDeYrRkqeOq64z0
	 IXKLNakDXwC9oq6ck6/A4tfx9FdBzE20Sh+zt2/GzrtEpkpisaARr1Z4KxPz14G05M
	 iepIPk9/43r4qWzaO8jwdGg9kFlf83qnKdHWvTUBXp/k+ZZc+vb+McdT1TG0f0MuCy
	 wE1mPwawbHq0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93989392FFD1;
	Wed,  5 Aug 2026 21:20:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: reject overlapping move range after len
 expansion
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <178596484913.530543.1573788529936238876.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:49 +0000
References: <20260708065439.1139937-1-alvinhuang0603@gmail.com>
In-Reply-To: <20260708065439.1139937-1-alvinhuang0603@gmail.com>
To: Hao-Qun Huang <alvinhuang0603@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  8 Jul 2026 14:54:39 +0800 you wrote:
> F2FS_IOC_MOVE_RANGE treats a zero length as a request to move data
> from pos_in to EOF. However, the same-file overlap check runs before
> that expansion, so a request with len == 0 bypasses the overlap
> rejection added for same-file moves.
> 
> For example, with a four-block file, moving from block 0 to block 1
> with len == 0 is accepted by the old check because pos_in + len is
> still pos_in at that point. The code then expands len to cover the
> rest of the file and calls __exchange_data_block() on overlapping
> source and destination ranges in the same inode, which is the
> data-corruption case the overlap check was meant to reject.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: reject overlapping move range after len expansion
    https://git.kernel.org/jaegeuk/f2fs/c/28c1ef094e7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


