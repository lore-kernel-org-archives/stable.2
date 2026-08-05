Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745703EDE4A;
	Wed,  5 Aug 2026 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964888; cv=none; b=ETrlUH7t0MIQ5G6xSF7+MwCrFjRnlFd/586WP+gmKfYeY9chrQ/dPFkQkvMKUvr7DGNbJxx3MLSO21RKSs6PpfoKBeSF7JT7nAqdJS9Yo9XoP7JpBB0dWRocrkNIWL68WEBwd+4ofL+fyOotwyMM8fWJhUhudPptYgGW5kDOh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964888; c=relaxed/simple;
	bh=k4LGSmlJFw5rLUYn4YQZ7hH6wBKX+CmUcy3tDofvFaA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o7l31WMrGIghnVTQEGQBS6Ul7ouJt9EnL+XTqjnK2yH+c/6ImWGx9n0TG8KzFyQAID2RPH1Iwak8OeU+Did7rRVTbARfI9Th/VoNcnZgM2qQHNGIqnqcF+eKoLPSIaQcaWFOraOtZeb6UhZCWJ2TgGUb3UOicKb5XlLe3AmmY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMucsSXT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMucsSXT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9221F000E9;
	Wed,  5 Aug 2026 21:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785964880;
	bh=BL9OPYOJe8BM8zFJ/oNMfT3XXZLUPunKIA9orCeaaDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lMucsSXTUki+bteK8yIxGDpfhYQj1o5AEtcmZc6UoEhkH7LM4hLg9wFX9jf8Q5Ngx
	 5noBZVbRABTltiGM9W0oE36E5zejAi6Vjkw6PyU7cmmq8BA61593QrTW9jCXneyP/d
	 PH40MwFYfqxxAJJVUa4lMewbttaBXeouyvS4+vkZ3hAE4sHfVBaGR2DXslYFx4F68y
	 OuJyKHwPczEjxyfcAb/UVjutrq2ixbWow1JEIzcVMfqQpy5qNY7RxUfK3WkYz43+Q9
	 jwLDzmjfYv+/Ir08izvEDVcXcEyAI6wTRWNn8ufkaUJo6HumDpJiNUKls/mboBVGGZ
	 JyBTLFO0Xd/Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A56392FFD1;
	Wed,  5 Aug 2026 21:20:41 +0000 (UTC)
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
 <178596484038.530543.7575324835869629902.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:40 +0000
References: <20260716025908.608098-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260716025908.608098-1-zhanxusheng@xiaomi.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, brauner@kernel.org,
 zhanxusheng@xiaomi.com, jack@suse.cz, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 pfalcato@suse.de

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 16 Jul 2026 10:59:08 +0800 you wrote:
> f2fs_xattr_advise_set() calls inode_owner_or_capable() with &nop_mnt_idmap
> before allowing the "system.advise" xattr to be set, instead of the idmap
> that the VFS passes to the ->set() handler.
> 
> f2fs supports idmapped mounts, so on such a mount this checks the caller's
> fsuid against the unmapped on-disk owner rather than the mapped owner: the
> actual owner can be wrongly denied with -EPERM and an unrelated caller
> wrongly allowed.  Pass the handler's idmap instead.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
    https://git.kernel.org/jaegeuk/f2fs/c/a54ffce4637a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


