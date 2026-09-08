Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB939E19A;
	Tue,  8 Sep 2026 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897671; cv=none; b=E69Bj8qoJkyrYQWx1nW3bJHe7smFSTjK6j4g9pJkWIgY3DkY5PucaHWQOpImm5tnTAWcYFVOucfR/JYqmydvyAedFFsuvu41xNfaNzzCZ8tTUacDJI8C+i1QYpOpADG4R3GeDSM8dOhZvbXzCrsV9QhQu0ezY0ajR08tetfdse0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897671; c=relaxed/simple;
	bh=avzkFG75eoL711X04gLfwmDG6d9k0HbHjq0/Cneajm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LK5Wtb5+peKE1/cy9kNYGYa7TTfDwiGPq1J/smVlKJz2xLguVUZoZL3MD+MR3BJBCZbGJP6Gp85Ic0AorMBhnpqkq1z+ojtBRuo64uHnjxlzHb5W3B5mAuPaRWyZAIXLFBJ2nSVs+B+Eeo7kFqwT83u83erhBZAHmloVAFgIpn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRPEra+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRPEra+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DB31F00A3D;
	Tue,  8 Sep 2026 20:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788897669;
	bh=Mn2z802etyyKFuQdlZgVT3N2OhEpwVAgB4Jn5ZVA/UI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lRPEra+rmdTi5LkKVLuU4FRgbKIynMb4corkf4RBuMGsJGIzXCzwAqmGhGizciJDe
	 cQ6bxi/wBslbGqyHkmsGEd1WV0NMIGvvS7W1lONEjmOd+N47Bn9Al97RFQLau+oqI/
	 2Z1UDXSArHsZlhbxhxSdz5a1QQ4un9tB3yHQCC1BW1P62iAQR0Vo8IFJQbO/G+ZsSu
	 0n9Vc/thbN26lelWGC2ZumSd7wDMkOfM71C/DMQEIxGD8tflMEr9oSRYKT6dEolYS3
	 dKCGO67i2YqqakOz+sn0jU9hNC31UdADi7YmqTcPDCfp2fj99/0tzylCvv6i2Y8GHh
	 hN7D+Wqu2Bjhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56927380820D;
	Tue,  8 Sep 2026 20:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: drop pending discard commands before
 reserving device alias
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <178889760788.3720652.6767085616150933422.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 20:00:07 +0000
References: <20260903161031.1280195-1-daeho43@gmail.com>
In-Reply-To: <20260903161031.1280195-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com, stable@vger.kernel.org,
 qiwenjie@xiaomi.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  3 Sep 2026 09:10:31 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When reserving a device alias via f2fs_ioc_reserve_dev_alias(),
> f2fs_reserve_device_alias() bulk-marks all blocks in the target device
> range as valid in SIT.
> 
> However, if the device was previously in the released state, stale
> pending discard commands covering that range may still exist in dcc->root.
> When f2fs_issue_discard_thread later processes those commands,
> __check_sit_bitmap() detects valid blocks in the discard range and
> triggers a kernel BUG().
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: drop pending discard commands before reserving device alias
    https://git.kernel.org/jaegeuk/f2fs/c/5200186c8cf1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


