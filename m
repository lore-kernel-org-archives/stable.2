Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E93EEAF2;
	Wed,  5 Aug 2026 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964894; cv=none; b=RAtwd7HXSBUxhMeT107EIM2YhodsDAGA/YoqzlLBoUrM2F9RWoZSve+JLvALLTun0XrQ/k3WkqELK76Hv5M1xRBJumGhCLW3NF+2+JGOuuUYKtwaEIcf8O++ONn5lpZJ5Inv+jqzNHDcAIlKj2EHhUPrMw2mw7xwp31gjbykFL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964894; c=relaxed/simple;
	bh=til7cTjEolDQFSgtr36sIyqUxJHnhVUft6DyImAteec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ClP9X3hGAOIWAnTWoVjHGxo3x+WUOVkgJllK+kHbVH7hAUKiKrbvIJLKMLfxX7JxWcmmnPBmTRhvetp9CP1a9vFm9+o0guuINz9iBKIODG0ta38rp+QqBinbz9YgxBK5KAeH2P2l4BUbzKglr7sUa55kl6/m8FuJB9pfBYh5JME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLwZ4cxd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLwZ4cxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE1A1F00A3D;
	Wed,  5 Aug 2026 21:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785964883;
	bh=wVs5OyaU31crQ2f2MSijF9cXIf5yFZ/8WkVx/f/KyIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JLwZ4cxdyWeUPlGMHe85aErKl/QexHKhFjpIH5i0LwtY7TMybeK9aAJ4btS3ks3io
	 sKXdaVnQC5/1sMKL8vKt9oJ/CRG/AuwZjl7DcPf+7M5W7gk7O0E8KpU627J+sICO5j
	 TkirZXdP8BHkS+ntW0VNRW/bVsSqcg1cn2ZrauY+/LAye/+IDdxVrSf+vlvmjMRDif
	 UGIvNxdmDMa9gyWJZd2jNisNEEtJUiixxZtQBFLVjrH/+IOSh++mXJOgWIkkigX8cV
	 FzaQgG0Gz1+r6X9Wu8BFuCT4VpuG4pYjy4en5U7TZceSnZ+Rfzvec5txf4b1oiXtv7
	 pvmsksASoZzmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A6C392FFD1;
	Wed,  5 Aug 2026 21:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: dirty directory inodes on mtime/ctime
 update
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <178596484313.530543.9698147873901986563.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:43 +0000
References: <20260623063428.222361-1-joannechien@google.com>
In-Reply-To: <20260623063428.222361-1-joannechien@google.com>
To: Joanne Chang <joannechien@google.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 23 Jun 2026 06:34:28 +0000 you wrote:
> Xfstests generic/547 sometimes fail with mismatched directory metadata
> before and after a power failure. This happens because when a directory
> entry is added, renamed, or deleted, its mtime and ctime are updated and
> the inode is marked dirty via
> f2fs_mark_inode_dirty_sync(dir, sync=false). The sync=false flag means
> the dirty inode is not added to the global DIRTY_META list. Therefore,
> subsequent checkpoints skip flushing these updated directory blocks,
> causing directory timestamps to revert to stale values after a sudden
> power failure.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: dirty directory inodes on mtime/ctime update
    https://git.kernel.org/jaegeuk/f2fs/c/9ec09d5f4b31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


