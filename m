Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4823B47F9;
	Tue, 15 Sep 2026 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438276; cv=none; b=F8Tkx353Zr9aCLgDpZemxAPSe7NQzq/5wtSll7DwdFhZGrMbw5kjlyQU+PfXHnxDF6FspHYPv3f5Dq81z2zo5wGG7b0Xo4rLZ9y93V1IbMpaaN78k/lOG2pcVVOMlrTDzWFdv9Otwg8chLzeXs0uVcnDQzhlrW4LMnSdUZBJhO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438276; c=relaxed/simple;
	bh=YhHQKPH26nJFuTrPS5P+swEIolxE0dngsOf8QiFa4Gk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ibaPX7PXEyqU6SqsT/CtJwdYSuOJru+RlGJZWdMD8fmyvLOAdHin+Yg5Jfw+Eax39UtO7sav357gSZbYVxD4PLWXOUFArJmyTNTutU5pPTg/sza/o+KU5vTAxk1rbAKJDqAnNPu/SUieqcyWt+7mODzlmxdO6RkgGpF0LBdPpOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O27Gy+Rj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O27Gy+Rj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBAA1F000FF;
	Tue, 15 Sep 2026 02:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438275;
	bh=xlk1XRCTICWATLfvf0LvgViORyT2d+O2KFYf4jvuo5c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O27Gy+Rj4vsdJmbyEdYuCO3rOHWTvWA+50USgcaRtwF5M5O609simhts7+yyxYGfY
	 J75KFC8/+KRtRF2r7QmrGbH9ZU8EB6eMnqTuLsy8QInBAwSNWnLukZjxNsGzWjX0QM
	 2hM+fs/Y2TfTYgYQrxYnb+0iLUJn5U9Nr1e0ltZusnNbtl//6jfMYiATKDZQRUn069
	 LjhmpMhvH8NjqCuCSoDjx+xthQ5EixMYPqsvDjx/3hH79yKDlT9I8s5RIwC4q8iOjU
	 MIt8WSKgXT2xHwH6kRISEHzrJsLwnLT3tzEgDmiHjjZJFKFBJ4HiSd1iuTxSMUn5I6
	 YK4mJTYF1YlJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CAC3924FFE;
	Tue, 15 Sep 2026 02:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] rust: net: phy: fix off-by-one bit positions in
 device
 status accessors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943821064.1315233.963613512821734944.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 02:10:10 +0000
References: <20260910055110.167110-1-springbreeze@stu.pku.edu.cn>
In-Reply-To: <20260910055110.167110-1-springbreeze@stu.pku.edu.cn>
To: Chunfeng Song <springbreeze@stu.pku.edu.cn>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, rmk+kernel@armlinux.org.uk,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 fujita.tomonori@gmail.com, tmgross@umich.edu, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Sep 2026 05:51:10 +0000 you wrote:
> The hand-written bitfield offsets in is_link_up(), is_autoneg_enabled()
> and is_autoneg_completed() were correct when the abstraction was
> merged: at that time autoneg, link, and autoneg_complete were at bits
> 13, 14, and 15 of struct phy_device's first bitfield unit. Commit
> 2796ff1e3dca ("net: phy: add flag is_genphy_driven to struct phy_device")
> later inserted is_genphy_driven just before autoneg, shifting the three
> fields up by one, so the accessors now read:
> 
> [...]

Here is the summary with links:
  - [net,v6] rust: net: phy: fix off-by-one bit positions in device status accessors
    https://git.kernel.org/netdev/net/c/6fb0a9d9071f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


