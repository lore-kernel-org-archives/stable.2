Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8F71B4224;
	Thu,  4 Jun 2026 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539026; cv=none; b=ICogqLVXXWLx2nIwCMHxZI01k33GIzOH27OS5swymTvq9dXIthiiJDYVz0QeA6iYyOYfN5NpLVz9JLtvfzEiTYDjxsshRsm4yqt2Fdr/OIidRowmWlrwE0Vq0udJuCcpmikZMPpRW89Ky6ICRrpmQrTL3lqzduMo8yvzX0cyvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539026; c=relaxed/simple;
	bh=4DLDconD/2DGw3LHooyZ8PUWvQ0OAuqVemZ6dg8/ag0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eOtL8M5pZRY6v6VcwQeomJUJeyMCJ7b/Atxfmk2bZSW7y7YdzIeLMklMvw/Ck2W1hTCKyqRIIB1j6Rhh7O6q6SbjxA3hWmRjd416rVu/O1o8y3m3XmVZT1CtdU33W0ZMFD4AcTdDG0RxApq7slb1/Vy/9RaWNezoyYWQRsc+GQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfpdbyGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfpdbyGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FA21F00893;
	Thu,  4 Jun 2026 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539025;
	bh=pG79E8kqKE0hDvq0vf8BpvVSi3rFLjhO+VC4wu7V3go=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HfpdbyGwKQokHbllafN4TwAung9wwtQg/MLIVNKYj1dsiFc635nQBUUEUpc3S6GdO
	 qZiIiaxq2ld2N9V2rEPeQTnnw+h8VKeiKzLhC8PfT43z6LtdwLMI/tqs9IJaEeclWb
	 N78Sy7RYvjRmtZO+NZiIMVugT4r8hXrC1q4UchdMdcakdBr5l3ixtvk5mSEHeXKngb
	 H/+isGn7crOt3eEew153jeehsS+OLZgq08RnP3r8YKVofAEyCbvRm2ZI+MsiipQ2JE
	 WIOyeFnINnfMdtjwBybvGmfovc9MTbds6DRMA8l50wbveSXBCozUdsxHHphqeVQQL5
	 us2Me+wcG0U4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AC839308E0;
	Thu,  4 Jun 2026 02:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 00/11] mptcp: misc fixes for v7.1-rc7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053902614.2204548.2424372511848234047.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:10:26 +0000
References: 
 <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
In-Reply-To: 
 <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, cuitao@kylinos.cn, shuah@kernel.org,
 willemdebruijn.kernel@gmail.com, yangang@kylinos.cn,
 syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 02 Jun 2026 22:14:07 +1000 you wrote:
> Here are various unrelated fixes:
> 
> - Patch 1: fix missing wakeups when multiple threads are reading from
>   the same fd. A fix for v5.7.
> 
> - Patch 2: fix retransmission loop when MPTCP checksum is enabled. A fix
>   for v5.14.
> 
> [...]

Here is the summary with links:
  - [net,v2,01/11] mptcp: fix missing wakeups in edge scenarios
    https://git.kernel.org/netdev/net/c/9d8d28738f24
  - [net,v2,02/11] mptcp: fix retransmission loop when csum is enabled
    https://git.kernel.org/netdev/net/c/d1918b36edca
  - [net,v2,03/11] mptcp: close TOCTOU race while computing rcv_wnd
    https://git.kernel.org/netdev/net/c/8ab24fdebc36
  - [net,v2,04/11] mptcp: allow subflow rcv wnd to shrink
    https://git.kernel.org/netdev/net/c/da23be77e129
  - [net,v2,05/11] mptcp: pm: fix extra_subflows underflow on userspace PM subflow creation
    https://git.kernel.org/netdev/net/c/14e9fea30b68
  - [net,v2,06/11] selftests: mptcp: add test for extra_subflows underflow on userspace PM
    https://git.kernel.org/netdev/net/c/06fd2bec7aeb
  - [net,v2,07/11] mptcp: sockopt: check timestamping ret value
    https://git.kernel.org/netdev/net/c/57132affbc89
  - [net,v2,08/11] mptcp: sockopt: set sockopt on all subflows
    https://git.kernel.org/netdev/net/c/7690137e70ab
  - [net,v2,09/11] mptcp: check desc->count in read_sock
    https://git.kernel.org/netdev/net/c/c378b1a6f8dd
  - [net,v2,10/11] mptcp: fix uninit-value in mptcp_established_options
    https://git.kernel.org/netdev/net/c/5e939544f9d2
  - [net,v2,11/11] mptcp: add-addr: always drop other suboptions
    https://git.kernel.org/netdev/net/c/bd34fa025726

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


