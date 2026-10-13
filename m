Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E977563FA0;
	Tue, 13 Oct 2026 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930623; cv=none; b=rNWwhfaTvObHvCYwuWLqytttkYnd9bm+rasuAKj4prpDZhHCVtjcSPpZrbFudJe/8TtSJ+lLaVqx3tiDxGMDnI8ONt6vls9gI2xbyPXdXd7xMlcRDRY9eRTDej2/yY8TIx8fiE85ToJFm0pt6yBLWbNeJ05sH/ChteB1F6R2gE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930623; c=relaxed/simple;
	bh=cU2kiM+CCwl8syPJtA4H5ObTQ2Ldq5L2EobSD62Z9os=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l5928Zdbyyo412Sxn3ud2+yyUiytZ7l9i0cWv8PCVljaRPkRS/lHK7mcNhws3nswNQOrRN0QLvRUT4R7jOc4kFZMkrtW7QChgOpbXquLXtzZw8h8fDYbwrjhC1ZP+1GxTXfeeFnzp/m+hf42cuqdtk+tb+yE5J6c47QRHiBv/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3d0R4rH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3d0R4rH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1051F00898;
	Tue, 13 Oct 2026 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791930618;
	bh=hwQirrEUF3uXN2QkIHd3xB/D0I8Glv1KEhePDFLUieU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j3d0R4rH/lAhx9C+iO9Jv0bY82aw0BRdC/XlXmdO+A5iokSiWXVNhe+XdlXwTGw4o
	 +YLydK1Hq7B605wzKvka3iC0ZVhnNChwctbV4AkabAVubXNNakODFNWd3qScRNQ0DB
	 tRLATbmssz60PLfZOe5N2rhuR6itgW5t8kIWa2TcywexlS59NlTcd+M+KTIWfRPfHo
	 A9G9pkMbWkLV4rHXLdN2vnHlzZDbAc26DoCmNJExXK1Jg0bmt+t+3LDI8FlsRQmC8H
	 rQ2oUQfDeDNX7rVQkT9qMLmGCgilFM8r9rUU1OcYfN0YBqnU+WscyTTTNY+lH48gee
	 2NjxzzZAjNQPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15D639E4DBA;
	Tue, 13 Oct 2026 22:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow empty strings for journaled quota
 options
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <179193061651.1493834.8828966574519236203.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:16 +0000
References: <20261010165750.509939-1-hengyul@cs.unc.edu>
In-Reply-To: <20261010165750.509939-1-hengyul@cs.unc.edu>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: jaegeuk@kernel.org, chao@kernel.org, joannechien@google.com,
 daehojeong@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 10 Oct 2026 12:57:50 -0400 you wrote:
> Commit 2a3db1e02ce0 ("f2fs: allow empty mount string for
> Opt_usr|grp|projjquota") added support for passing usrjquota,
> grpjquota and prjjquota as flags to disable journaled quotas.
> 
> However, it also replaced fsparam_string_empty() with fsparam_string(),
> which rejects an empty string. As of now, mount(2) and
> fsconfig(FSCONFIG_SET_STRING) reject usrjquota=, grpjquota= and
> prjjquota= with EINVAL, although these forms are still documented in
> Documentation/filesystems/f2fs.rst.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: allow empty strings for journaled quota options
    https://git.kernel.org/jaegeuk/f2fs/c/0354a04b8c34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


