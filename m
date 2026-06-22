Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B629271450;
	Mon, 22 Jun 2026 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158436; cv=none; b=dZtFSQdPVfdRGSK0FhXjsHW3GB0FI7kSD2LjFYgq6LTdm7fQY2OmpQQS9sgOvDuQ02847MQ7/GkNWyDTwMWN+yvyoj1EEKnEyoK8x1QEsbbVIjG8Vs4ky1G8kAONmDXtXdBJEEsyXqNkcacuI9fK+tW+3Q5FEfZFzrAwM8DMadU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158436; c=relaxed/simple;
	bh=xS1SRtk2zP4w+bRHIp8ngFVPw59e4HhZFgx364vIZCc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PBqsZ6BxmXMYHm2w1aC/r9Aeu+M71pWgIt3jlXg4jAO74mJPmHMcrBz9SbihCtYXTT6nzMLWBAXJn5zMSJ/XK1o66GYDFW79uViTHa744brSydsRg/15512IKMsnQ4AS1f+ilVuL17sN7vUFjLB3dSPQh1fpaC+hzI2x+2wTuqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdM8tScx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdM8tScx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F781F000E9;
	Mon, 22 Jun 2026 20:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782158435;
	bh=KfLlXYdrlVbzJTmUN+eGVpPezTEpeOIqk0/nC6FBssU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QdM8tScxtpEgLUU1RtI6PVUI6C9kKd99gsZiCn+jH52lYx9YehTuIJyJHwzA1kRN3
	 gmI9QaJZP2FQNKbwxHY3R4ZykwtRTWAQJ9h3YHZ0M/oc1Hy8Q/98REYHKd+GxZ2Wx0
	 vgJG9podwCZU2wDQy9Kp25wLkPy7G24LjSM/fbMAiNIbLdgzap+6E7NOXAOhpAGL8t
	 OcNPXvbbc/X0SWur1u+HB0RgrBL2Zjzh3BDmZzuPfxT3qb1AIgWhVMNgwdxzeOyyUU
	 uiT7Q5c37GPk/RY00HUchwtxpjzf+IxHzuVev0/N9Dq73hU+I2kr+ADYEA0nS7WDdn
	 b+YzUburBk1pA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93E123930922;
	Mon, 22 Jun 2026 20:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to round down start offset of
 fallocate for pin file
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <178215842604.1396481.3503226882368736427.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 20:00:26 +0000
References: <20260622052817.3972188-1-s_min.jeong@samsung.com>
In-Reply-To: <20260622052817.3972188-1-s_min.jeong@samsung.com>
To: Sunmin Jeong <s_min.jeong@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, sj1557.seo@samsung.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 22 Jun 2026 14:28:17 +0900 you wrote:
> Currently, the length of fallocate for pin file is section-aligned to
> keep allocated sections from being selected as victims of GC. However,
> for the case that the start offset of fallocate is not aligned in
> section, the allocated sections can't be fully utilized. It's because a
> new section is allocated by f2fs_allocate_pinning_section() after using
> blks_per_sec blocks regardless of the start offset. As a result, several
> unexpected dirty segments may be created, including blocks assigned to
> the pinned file.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to round down start offset of fallocate for pin file
    https://git.kernel.org/jaegeuk/f2fs/c/d2134b45eede

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


