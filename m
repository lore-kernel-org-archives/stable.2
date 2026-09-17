Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63899372B3C;
	Thu, 17 Sep 2026 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611071; cv=none; b=p0i+b1qFNWtq0HAIsvnJersmhj0oNEK0nXJ27nhy0zypjiOZYGaa0+IR/SCofPpjuO5zFxjUbf/+YB6JeAWuN0mhpMmMC4M9BwKVSni85skCeovhAN6IQoifWOoPW9hq2tZ0FAtrJ3BB0DyIjclrQZjIhNi332jZHT4lk+4QdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611071; c=relaxed/simple;
	bh=pfYLdSbo0gC3ychPqOBgADrXbdwni0bly+FmWJ2vAXQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tarxl8sauOi+vt6+qZ5IBQ6NzCr4EheatxAkinoGOOJE1ek8TZgk3n+FFNyOgjn7NtJLngQulAM0YUWEPCh0ReNCcXwNB9pQaPoG4fL1O4DxuEAOa3oL/2L61BF64TyttTSPwWI9aimQsf+oQS8B6ejKBTRetaEQ7LsWtqUKUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEfkZHgV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEfkZHgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477A11F00893;
	Thu, 17 Sep 2026 02:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611070;
	bh=al+yatvliCzGcaszhwibAHHAVzRkEiefpeUnPBY1amc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BEfkZHgV8P40VnPpX9DAblxKihl9UBT5kzLQua9n/WA/aqFtdpoIJ2q18FeHvthXu
	 kFRp8Kl8Xg6C5d/rjWunQzxzRcsMQ96dudN79FKsVNth3vrEleAC9x9MEUCeDBJKyH
	 yfyK45Qb/x616KFfHIjKvQMpsxVjfGdm5lmR/R7eHrA/a3k3k8hnXzhL1UnYAyFKlL
	 7B2vQ9epcaUb/eAQGH2aHIuWMaFmgbStza1nZwCbajtminfBAXafLlFshq0KubMjzT
	 TjXGEkXwcgX1LWHZatzmthBDsQU7Bmk+FGyfiR2zakpLe8jnGLo5+qRHja8TuOLxKc
	 bct0gzGI6c5yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C7B39E9609;
	Thu, 17 Sep 2026 02:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] net: wwan: mhi_wwan_mbim: guard against a cyclic
 NDP
 chain
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178961100420.3376729.9937883497154765056.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 02:10:04 +0000
References: <20260911021734.1396599-1-zhugl3@xiaopeng.com>
In-Reply-To: <20260911021734.1396599-1-zhugl3@xiaopeng.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 chandrashekar.devegowda@intel.com, haijun.liu@mediatek.com,
 ricardo.martinez@linux.intel.com, johannes@sipsolutions.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Sep 2026 10:17:32 +0800 you wrote:
> The NDP traversal in mhi_mbim_rx() only stops when wNextNdpIndex is
> zero.  Nothing requires the offsets to advance, so a modem that
> points an NDP at itself, or at an earlier NDP, keeps the loop
> spinning forever on one CPU.
> 
> Break out when the next NDP offset is not larger than the current
> one.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] net: wwan: mhi_wwan_mbim: guard against a cyclic NDP chain
    https://git.kernel.org/netdev/net/c/5d063822ac51
  - [v2,2/3] net: wwan: mhi_wwan_mbim: check skb_copy_bits() return value
    https://git.kernel.org/netdev/net/c/31550d585589
  - [v2,3/3] net: wwan: t7xx: validate the netif index in t7xx_ccmni_recv_skb()
    https://git.kernel.org/netdev/net/c/c7ead9704249

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


