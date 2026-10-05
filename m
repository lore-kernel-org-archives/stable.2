Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5B52DE709;
	Mon,  5 Oct 2026 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791169209; cv=none; b=XQeIjCWx+dE9xPRkTe4gb7Gugs9nmlyM76sIkpJg6E0S5FfMmkhcBZrhkLSW9F9rNOll/xBUGDtDOT04hmiYI8mQtYHfCXpzmW8SR9J5cdJbvNmF0Zxy6zxRJLhs7tUQFJlVQ2NEKnEzrwrbqxnvR7PAa0aYBlYAlHcW9Upgpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791169209; c=relaxed/simple;
	bh=5Q7x7OEo80zK/HpoBsQgszZkuak8WIzB/w4O3z0B2mw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JMW54ji2eRVwcFDRQr7v9SlSzrk79jXXggWN/fxJnkpwsCZfsyBp+3X2GtaCE7tSNaBzhFYtj2ZNAI17h84BwMugfR4gwjURWQgIZLoKiMgSSJEVZ6iWH7sY+8Vqt76qAoxUHZDAp76MSDFpdbgX+UGUm4KvHvfUE6bNZvnSjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpmjYbED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpmjYbED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0703B1F000FF;
	Mon,  5 Oct 2026 03:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791169207;
	bh=hkJHbTNZVUgNMyLsyy+h+fbjU0R4JLRIMOcMopTbZgA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WpmjYbED3OFRUBM7y4Ptfm6FEe7FEW8akW+zgSQwNlV9omLoM/aoi96WlNXFJtJI4
	 99Ea2UH7LR5WeK0zWnjOt2t7u74tte1qJy2wVDtM+vL3eD0PCvFZ4ufhW3WnX7FlrP
	 AxYqVDIbouHILIO+QLMC0QZiMq9TFJU/zh21fYowGothHVO8xhikdP7HCtMYBRRAjJ
	 hLNf3J4InA34j9degLq8vONRnORZn9wAlbcXVm99bTPG+py+ZSRYpYDsnbaYFrcCt8
	 HfepjwvhAtU7g00pFROEHTnXB0xD7JMGGfqid0GiDh452W3E84I6ax4xNtC29ctYXR
	 xv7J1FfTMWQYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F145E39253C0;
	Mon,  5 Oct 2026 03:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] openvswitch: fix soft lockup in the netlink flow
 dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179116920578.1072741.16152613062513950480.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 03:00:05 +0000
References: <20260929072519.2803304-2-den@openvz.org>
In-Reply-To: <20260929072519.2803304-2-den@openvz.org>
To: Denis V. Lunev <den@openvz.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 29 Sep 2026 09:25:19 +0200 you wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> A production compute node carrying a few thousand datapath flows hit a
> soft lockup inside a single netlink flow dump and panicked.
> 
> ovs_flow_cmd_dump() calls ovs_flow_stats_get() for every flow it
> emits, and that releases stats->lock with spin_unlock_bh() once per
> CPU that has touched the flow. Every release is a local_bh_enable(),
> and each one runs the pending softirq backlog in the dumping thread's
> own context.
> 
> [...]

Here is the summary with links:
  - [net,v3] openvswitch: fix soft lockup in the netlink flow dump
    https://git.kernel.org/netdev/net/c/aaaaf87ea99b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


