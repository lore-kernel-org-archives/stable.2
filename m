Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64497484228;
	Tue, 18 Aug 2026 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073106; cv=none; b=A2L6+ZHl4wFVJNs14jztKt7rIaiMBtWBk+3bIEyGM0l9APya5uIRarRDI9rCJj+pZfXGOWOP0xH1vbsh4g1j18bmavlPqXMfZtxuies34i0RWKd+TkRMj0en9dBLCsat1/IVpJyU0t1h5NJ5NZ/BVoJL8aKeuTG6xctjKWqFTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073106; c=relaxed/simple;
	bh=iRjL7CQ/9qiYJG+p6sbaJtU+MejNOp1wOe3wVHCdk5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FizWHzVlmJs9d8tQ8odFKwn+sdE9zSgryrXVW8mBUga0BTB5iX00A6kH+Rpd6ScERb1WWqlHbIRBhSYA+o8PFDEShYbF4T3jMMdklSB05pzE2hjUNq3JxcSFdHZn5kVVuamHyTk2U1+KgBWW7pRGSHfAesxh2BtOVpGPVtlr1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbqCRuvL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbqCRuvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCCC1F000E9;
	Tue, 18 Aug 2026 17:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787073105;
	bh=3rt7Bz8hVlpz32G4OevkUCNAg1vhfGrk/4o+0BdeVZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LbqCRuvLslLJ+p7AbIV0aa634dwMGPmdWD4jHmNGYcAhGmU8f8385d4q+kdEf5SZU
	 uZnHyqkVgDnd9aljwe7BjdQXFi0tyIAi5H7TuR28Ue4Z6gCOIFnQnVmm2Ay0wPk1uF
	 FfF2Mvg+meIgKv18lh2HNx7pUsdk+LHXCgCASGfvuSAhuTEq+ygjIPVF3OnttnVYik
	 3TYHdlSPXypsNH2TxyNyqbecIOR38T4rhD8sP284sbikpqPw4aPuBSub730bEtUmox
	 xFl5xsE17keLuX9j+O9+HNXSzFTn7sMrxrPhMj89/mmanIUqU5P0f94oDYy/JY8qQ9
	 r3QrEvOf7c/nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A263927043;
	Tue, 18 Aug 2026 17:10:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: openvswitch: fix flow mask use-after-free on
 flow
 deletion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178707305652.2185737.7377408629239956089.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 17:10:56 +0000
References: <20260815005915.1097270-1-i.maximets@ovn.org>
In-Reply-To: <20260815005915.1097270-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Aug 2026 02:58:56 +0200 you wrote:
> The commit in the Fixes tag below made so flow->mask free is scheduled
> via RCU right after it is removed from the flow table.  The pointer
> stays in the flow structure and it can be accessible while in the same
> RCU critical section.  This is done to avoid requiring ovs_mutex for
> the ovs_flow_free().
> 
> However, while removing the flow during processing of CMD_DEL, we do
> not take RCU read lock before the removal, and ovs_flow_cmd_fill_info()
> uses the flow->mask pointer afterwards.  The RCU read lock is taken,
> but it's already late at that point.  The comment on that line
> acknowledges that the lock is cosmetic and doesn't serve a real purpose.
> 
> [...]

Here is the summary with links:
  - [net] net: openvswitch: fix flow mask use-after-free on flow deletion
    https://git.kernel.org/netdev/net/c/4e30317ff67a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


