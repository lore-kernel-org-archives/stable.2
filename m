Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2112F47F2EB;
	Thu,  6 Aug 2026 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031475; cv=none; b=CVpW09pUD/zyui4XjCqedFRIQ+JM5nod7N3d4Q7Tacfhofir/Munys5WO3GFPiFJtuCYL0GtJG5BZYhDAwHCU9ZxHOYB8l+PPL0HMSArWyS5C9sHSUmWKqLRXzNRW2Z0y9atXu9ljaq5/1T15pdtpm3nPd40aFdNp5WxZVdru8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031475; c=relaxed/simple;
	bh=lTf/WzEencw4fMDBNkWKQyUC5KKzcR2ZSXVn8D06zjg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aONNnwuBfGiimJ7JW0dMQopd0FfIlzCXdH+s7SyasbbLK1kt3RgpapOzlTe1HMebtnc96fNXE9DhNB5C9v+EG3J7lTtt0+MNwH3GMaNm/FecKuqLga4sdp3B5L71OAJ+BBGPzTt4mG57TCit3R0lMEQmOvIDpaySu41Ukt5LGBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcQRdOXi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcQRdOXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ABE1F00A3A;
	Thu,  6 Aug 2026 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031462;
	bh=0YkuvbUNUoMYFw+6i4h4rbeB4K95U4aarWRNfWOdHVA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QcQRdOXiJzMLmp66O7T7Iarwdj/m/mF5w15BN5gCR9adbMRL2+sn0wpCfy6vcYR8O
	 VcbPnUR3US2zvLO6SfgHON/KkN7j7bD0R4KMk2s1sY1BO2DWc+yojuXx6YYzUSZtr6
	 /ReUmXmhadIANAsIqPr3Pj8r8SBv/FZUdxbvqyYRcHodst/lA+o0/1UNm2nk9k5Y3o
	 ax7gbF91pOs7oezEGl8i+UYjwJfiKnfpZzJn7ehu2wnZmw9fJSFgkw9Z/rm0mDTXlS
	 3A9XFOUDMnouQ/mfkiCrMYPJYHWZ1DG9hZR4RwxhGVS7r0q/vJ9aDt6V2yLwrLlbLm
	 7VkgTzH57gPPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B80380820D;
	Thu,  6 Aug 2026 15:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/8] mptcp: misc fixes for v7.2-rc6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603142138.1348318.7580608127608923718.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 15:50:21 +0000
References: 
 <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
In-Reply-To: 
 <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, dcaratti@redhat.com, fw@strlen.de,
 cpaasch@openai.com, luoqing@kylinos.cn, yangang@kylinos.cn, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, shardul.b@mpiricsoftware.com,
 kishen.maloor@intel.com, bronzed_45_vested@icloud.com, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, n05ec@lzu.edu.cn, dmytro@shytyi.net

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 03 Aug 2026 18:16:32 +0200 you wrote:
> Here are various unrelated fixes:
> 
> - Patches 1-3: harden incoming MPTCP suboptions parsing by rejecting
>   non-combinable ones. Patch 3 removes unreachable code after patch 2
>   added here for consistency, and to reduce comments from AI reviews.
>   Fixes for v5.6.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/8] mptcp: options: reset DSS fields in case of unexpected size
    https://git.kernel.org/netdev/net/c/35772b4981f3
  - [net,v2,2/8] mptcp: avoid combining some incoming suboptions
    https://git.kernel.org/netdev/net/c/b6ee36152464
  - [net,v2,3/8] mptcp: remove MPC && MPJ check
    https://git.kernel.org/netdev/net/c/900e6d80548e
  - [net,v2,4/8] mptcp: pm: fix data race in add_addr timer callback
    https://git.kernel.org/netdev/net/c/a7aad5b69d3b
  - [net,v2,5/8] selftests: mptcp: join: mark tests with data corruption as failed
    https://git.kernel.org/netdev/net/c/ca318e7bbb77
  - [net,v2,6/8] mptcp: pm: fix memory leak from alloc-during-teardown race
    https://git.kernel.org/netdev/net/c/efc33b5102ff
  - [net,v2,7/8] mptcp: fastopen: only mark MPTFO subflows with SYN data
    https://git.kernel.org/netdev/net/c/e00b63056fb4
  - [net,v2,8/8] mptcp: reclaim forward-allocated memory on RX path errors
    https://git.kernel.org/netdev/net/c/41b49a8b914e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


