Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7763B1EF2;
	Fri,  4 Sep 2026 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788563470; cv=none; b=eh6kH/UHsQK56rZWMN+0G5bhgalnCS02iGAsXpBjStF1qSkX4O6np+/Uoi0lmpQceTpQCn8iylyysSrVDKpjy/CS/L+VCEEQjyTPwIxqJ42wBE9b+ypUOxMOITgGA0/IN2hpyAWpp25jxmlMwGXsGD1kqCNAZK4fLKx6RjXKscg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788563470; c=relaxed/simple;
	bh=h2hiQ5sW7/daGg8SLKuhUlKDEXMO/W5Tk02g30EnTq4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DWm2w6NQR17Vy47cgEvZUSG2FzEtQS3nSG5dvX5PShi7yk58e1+YEXKXVi6O1i4b5MlasKyT4wyM2/af/XBBL8o2Dt7nH1c39+SeJQHHYVsZZmTgQjznH5rmYbOgJc+fykfABZM2NgQ4Waoov2HYcXflVyT4IJ2TCxsi8j+yeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDuZ/dT+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDuZ/dT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4101F00A3D;
	Fri,  4 Sep 2026 23:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788563469;
	bh=9FXJZMH+RXlL9ceBVMJnhF6S4ikewWtL/+4HhNblEvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UDuZ/dT+1QDI2UoEmV8Vgb2/dWPlRLfajn59t+oGzQaLLhMRzocWnzru4WTAJsjV8
	 OTB8K4koaSpvDYsadI0xxWH6TsPpwoCCKj1pKib8JlvOvXBqLHzDeLiqaUQZEgUlTF
	 3i8Kct/QMIHyh3BxefGuTM9BN3ZqyTbrMx43qjJK8twzlIy0TKjcFe5SrmIpbERCHm
	 clUzVmPAgTEnWQbhvt97Lq2g53XP0FuiSO4o9NOMuFJe0Dky1NFc6GlNgXUKa1Yjbv
	 gWFBPlTzSg3msWT7dlNBDuyFRTYrvFNIHDk0owzH7d7yKf3OJdOrdUGBOhfLImeUuu
	 h6M//V2tup1oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A653924A7F;
	Fri,  4 Sep 2026 23:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: mpls: clear inner_protocol when the last
 label is
 popped
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856340990.1009860.14708368396891138023.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 23:10:09 +0000
References: <20260902092719.2874481-1-fouriezhang@tencent.com>
In-Reply-To: <20260902092719.2874481-1-fouriezhang@tencent.com>
To: Fourie Zhang <littleddfu@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, jbenc@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 aconole@redhat.com, i.maximets@ovn.org, dev@openvswitch.org,
 stable@vger.kernel.org, corvus@tencent.com, fouriezhang@tencent.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 17:27:12 +0800 you wrote:
> skb_mpls_push() records the pre-encapsulation network header once, gated
> on !skb->inner_protocol. skb_mpls_pop() never clears that record, so it
> outlives the encapsulation it describes.
> 
> Open vSwitch can then re-push MPLS onto a packet whose
> inner_network_header still points at the older, deeper offset: push a
> label, pop every label, recirculate (ovs_flow_key_update() re-derives
> key->eth.type and resets network_header, but leaves inner_*), then push
> again. ovs_fragment() trusts the record:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mpls: clear inner_protocol when the last label is popped
    https://git.kernel.org/netdev/net/c/78a86d75a70e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


