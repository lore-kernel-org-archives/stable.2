Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E8E36195A;
	Fri, 18 Sep 2026 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698080; cv=none; b=bbPy6wg1ouslYuQNNaX65jNyDd8McFb00vyJ3QVRNMl8JQBzghX4bVEb5+N0Rvrx/pCnX2F/cZHdSD/zhe5kiD8U8WnDFjx20Uary3Ep86ZB0aidDxxZWFiq127C5olRG57b1i73G2UTeTobqw19aT4vhmyiD6et9gsYjq8ht64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698080; c=relaxed/simple;
	bh=iPPicN9ox2TKyniGFk1Re7j1rvv5TIgFdrSUY8pSOrU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JpAPiV+6cdgkfFgzaqd5X1UDT81Akq7E9HEamVbtZuur60ANrpJCSfE9wzq3Uxu/GM3hI1ejF/ewv8E2Ax2rYvqVPrpV0GuyR/mHPkSVL5ZXyz4CrxZzT7PnZJOvurBKY55MACmVaSgtgguSs9TMsC8yd0DCVZLYcBwym5OM+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keLOILlG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keLOILlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7993B1F00893;
	Fri, 18 Sep 2026 02:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789698072;
	bh=5ozNbeuk4U8g17BkfMkseX/ATONJrNLPfUSS9Svrwxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=keLOILlGcvXn/TtA1eq9K3vNN2co9clIGEvkcJAR9l2F2BRaPyaa/U6cn/wxdRtAf
	 CZgSBL40LyUUPZrAd1AoFrZHoh5Suu9UXxRDgspYPSSSz9+v8WHieaMCm9GwiInKKk
	 eOeHFWAu0nIWfbm7KQd+rAnKRO45xOw/HwVfJYRB0GuO0wPBVLuMd4bo7ahqIW3uZO
	 OQhwfEoS/ImrfKT2UvuFk33ksau0cWg6saT4fjaB3GUaO0jH3059Xp/5iduRDKaSZS
	 WccBoPq9zKj3IDlciP4Fgx/3VN9vF+P2UFreETnav1RUyOggJhBeMGFeEN0hOpDu8R
	 YRYz4t9Vvh7eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197FB380820D;
	Fri, 18 Sep 2026 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: txgbe: fix FDIR filter restore for VF rules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969800562.233063.9027842901959042931.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 02:20:05 +0000
References: <20260911091123.798931-1-zhangyunfei1@kylinos.cn>
In-Reply-To: <20260911091123.798931-1-zhangyunfei1@kylinos.cn>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Sep 2026 17:11:23 +0800 you wrote:
> txgbe_fdir_filter_restore() reprograms every filter from
> txgbe->fdir_filter_list after a reset. It extracts the ring part of
> filter->action with ethtool_get_flow_spec_ring() and maps it onto a
> PF rx ring, silently dropping the VF part of the cookie that
> txgbe_add_ethtool_fdir_entry() stores there (input->action =
> fsp->ring_cookie).
> 
> [...]

Here is the summary with links:
  - [net] net: txgbe: fix FDIR filter restore for VF rules
    https://git.kernel.org/netdev/net/c/651010592bdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


