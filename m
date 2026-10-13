Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98B1566C64;
	Tue, 13 Oct 2026 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930650; cv=none; b=q8T26kqu6FczLQ/MDuDc+D/tNzpJZKYwCRLzk/VOqiYjcPeRsnjM3AQI+KwrD9/m6qAMAcmqqfX7u3vbj3Io7ivAt4xbdLOJe7WjekmN5AA+Qsl9EPvvxjKSLSXNsCG80GqamIQ2XBwj1lW6NMbSH0rgtfgjqNIFMZKFDapJA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930650; c=relaxed/simple;
	bh=MC3x2DbFp75QbpUukqMti/4XxFrD2F9LOtVc9bMnXds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bMw4ZzQKUR+Mp8FGQLmOT3xRNNeF82lrlkDz8yKHgsx30CxFveTFK2aUHBmJfDBFCeX8icYzj/5YBz/2211JaPvs9rJ4a6pL7PvXSDIz3HfWW+IpOlxxOXPUIG3t/SrWgePszduhWiblflo0haSfBx1q/ItmXBO4T7yVKEeb/BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0x98hh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0x98hh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D7C1F00893;
	Tue, 13 Oct 2026 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791930642;
	bh=Np9xnuu6XiKVbwBFAPp4t+RIdjq2sSckN1p0VTuLUy4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F0x98hh7uT1ubqr+v607DM8Rr1PmR7VGfeYXqxvRC7tV9dIbNtW2y1s6DQ1v4Op6J
	 2p28tYI8elZQsW2Ljm+Phd49zJujU+tbOo1ESV4T+bb9z9FXfRqUET09v9yFFy0Le/
	 CJ5dBVK/mqbZRXqcnqHtVCQjrk2VEPxnh6fLzDlJI0P9fYMuQiGoHHTrNUBkAXiw0d
	 HdGe8PQ0E7SshVeBxC8piArbmjJH/bxZtxnI9torn8jt+IQmo5ZdHi5V33KTxVLbGI
	 FXRMI/3XAtm7mwtvsl1fKvxFs7owhgyNhTpVJ/dwxu5N4M20APnAr3knRiET6CuAPu
	 /qjU9/Vdvelgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773B639E4DBA;
	Tue, 13 Oct 2026 22:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: zone: fix to avoid bio split on
 sequential
 zone
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <179193064101.1493834.14246878856998575721.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:41 +0000
References: <20261007101812.2348510-1-chao@kernel.org>
In-Reply-To: <20261007101812.2348510-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  7 Oct 2026 10:18:12 +0000 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> In the block layer, bio_split_to_limits() splits a bio if it exceeds
> any underlying queue limits:
> 1. queue_max_sectors: Splits bios larger than the transfer limit. This
>    limit is set by the device driver/DMA controller (max_hw_sectors) and
>    device-mapper targets. When flushing dirty pages (governed by VFS
>    writeback_chunk_size() and f2fs nr_pages_to_skip()), f2fs merges
>    contiguous pages into bios up to 512KB (1024 sectors) or more without
>    checking queue_max_sectors, which will be split if the device or DM
>    target enforces a smaller limit.
> 2. queue_max_segments: Splits bios exceeding scatter-gather segment
>    limits. f2fs allocates bios with up to 256 pages, exceeding the
>    128-segment limit of DM targets (dm-default-key/dm-crypt) if pages
>    are discontiguous.
> 3. chunk_sectors: Splits bios crossing chunk/zone boundaries. In f2fs,
>    section_size strictly matches zone_size, and block allocation never
>    spans across section boundaries, so bios never cross chunk_sectors.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: zone: fix to avoid bio split on sequential zone
    https://git.kernel.org/jaegeuk/f2fs/c/b9b036bd1e2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


