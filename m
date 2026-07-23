Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02AC35CBCB;
	Thu, 23 Jul 2026 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830256; cv=none; b=cuyn/gifjDjXe49VZ9hteuvs3WC3Vp5MMgljcKO15rijeVX1eH2jrnsco+Xigw57oDpacOqRwssBpwsZGBao8nXbDAVgjZT12JF745hDzK1imP2cv0IBIHJg1ECZfUJI2Du0halqSuyFM35Erf3zY98eF8yg0CI9LiV9xSA+Ft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830256; c=relaxed/simple;
	bh=T+sKmDflaGuwqt//UsemMY/PXVcNsUaCy7NTBJKauwM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vr1fLpuFijcT5Pz+j4GaRCzIzM0t5fU+YTtIVc6CBxSGioC6yx/9M9E/70ptB/d4pmd4WUHtro+u+1Muol6oWRd5JJhM750nChWL7Xq9sxolJ16FdhYEx4o54GCAPEg3+0Dk7vhFXBtf9tyiEiIF+N/ByavnpoJv4jxysBGvRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B801F00A3A;
	Thu, 23 Jul 2026 18:10:55 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BEE39244D3;
	Thu, 23 Jul 2026 18:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mptcp: misc fixes for v7.2-rc5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178483022038.2811828.15250921296237732246.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 18:10:20 +0000
References: 
 <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-0-6fb595bc86ef@kernel.org>
In-Reply-To: 
 <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-0-6fb595bc86ef@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhaochenguang@kylinos.cn, stable@vger.kernel.org, luoxuanqiang@kylinos.cn,
 kalpan.jani@mpiricsoftware.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, frank.ranner@intel.com, lkp@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 00:14:37 +0200 you wrote:
> Here are various unrelated fixes:
> 
> - Patch 1: decrement extra subflows counter in case of errors with
>   passive MP_JOIN. A fix for v5.7.
> 
> - Patch 2: fix use-after-free in userspace_pm_get_local_id. A fix for
>   v5.19.
> 
> [...]

Here is the summary with links:
  - [net,1/5] mptcp: decrement subflows counter on failed passive join
    https://git.kernel.org/netdev/net/c/f3ca0ee2cc30
  - [net,2/5] mptcp: pm: userspace: fix use-after-free in get_local_id
    https://git.kernel.org/netdev/net/c/9bc6d5e4ca9f
  - [net,3/5] mptcp: fix stale skb->sk reference on subflow close
    https://git.kernel.org/netdev/net/c/bd7aae448f6e
  - [net,4/5] selftests: mptcp: userspace_pm: fix undefined variable port
    https://git.kernel.org/netdev/net/c/e3213292c4fd
  - [net,5/5] mptcp: fix BUILD_BUG_ON on legacy ARM config
    https://git.kernel.org/netdev/net/c/133cca19d75b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


