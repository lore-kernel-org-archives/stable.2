Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8713D411A;
	Tue,  4 Aug 2026 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854447; cv=none; b=oS9LcL7dq8ipz+z9uCuzD012wdNEsOvP0rmAFJoZWgsisdASR0CW85YzELvczpZW7dfiPjpNo2GMVOZ4+g6b9rQgrJ/XdGOS2klBdQ+n9cZpuP8P8Y6euqNQHZGtcfZHtCyxhcrPAcJBgmPV6HLVBfF2mvFdmVsJ3YKRYW3YJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854447; c=relaxed/simple;
	bh=+VGIxFNn5Gc9BOztHj0i89JOCrQYWDuZFBMkYKCE78U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hNOcMOkEGb8fkikOL9eGyAc/Zxfa39e5819BodOnad/7+INQawNCFPTNRVjsKk8glAo5UVSaCMuhJEofCY5+EIWq0enD6RmuWWZlM9JRa4nFlSwEdL2nYcXtuieMAsoc0qHECybO7ARZ2AdDu/B++oST3CisBh/fKFBRRbyrHvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVPUj5ij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVPUj5ij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871301F000E9;
	Tue,  4 Aug 2026 14:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785854445;
	bh=cQE037OPRmV/zTYpHD/oFrqG/KQdTLmKYARhOLKqRLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nVPUj5ij/s233XWrTXBaMO3MqOpL+WtB7b9cvbxot1sIsKIhNddD01wJVYwIEZTtb
	 kvr/rUA69+oW2TdpY8xJzc3Kas+nOGuMYYTuK3Zb72H6qEaX/BIGTr3VKQuZuvmQhM
	 RA3/2dVLKMNu4EkgJOP/FM6VobmBPa5zvsQioQHkZI5OB9lT/eaIsb1e8ldMahIMeT
	 ZT03x9cr0Bw4nahxaiEYz/vH/wrnUjhf2UATeUa3iXN0dRGL6q/7d13M+byrE2okpD
	 3AilgwuPhh02E1JZoF470ysJy1PBH2k+NVTba6ftbTNYNvJPP2TPNgRJM1YTjySOoK
	 wRgbipqlknqxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5693B39253D0;
	Tue,  4 Aug 2026 14:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sched: cls_api: Always acquire rtnl_lock when
 destroying
 locked classifiers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178585440589.3186075.1456142899655290504.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 14:40:05 +0000
References: <20260801125632.360365-1-jhs@mojatatu.com>
In-Reply-To: <20260801125632.360365-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, security@kernel.org, stable@vger.kernel.org,
 feng.xue@outlook.com, vladb@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  1 Aug 2026 08:56:32 -0400 you wrote:
> Another challenge with unlocked filters.
> There is a short window in tc_new_tfilter where a tcf_proto can be found
> and briefly referenced by a totally unrelated, unlocked classifier's request
> and cause a race.
> 
> Feng created a poc which created this race with two threads, one creating a
> u32 filter and other a flower filter in the same chain/prio:
> 
> [...]

Here is the summary with links:
  - net/sched: cls_api: Always acquire rtnl_lock when destroying locked classifiers
    https://git.kernel.org/netdev/net/c/a347304b2ca1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


