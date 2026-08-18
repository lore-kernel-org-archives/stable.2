Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C15530D3E0;
	Tue, 18 Aug 2026 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787074767; cv=none; b=l7OT+4BtoRftLX77arjXStp5eFfaSz20MYK8E8MuNTZQ39znEHl5X59KwwPE7zRblESwWLJzCiCRUf/4BGYoxJJBzSRhEshe60tgZxsSJKJ/riXBtX3inbON6Ok3BiswDg2NkJMVqHqHzYf1+5E9DE7e6x2F3BIwkEWghX4V5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787074767; c=relaxed/simple;
	bh=S3m+dUX5DvIumhyknMw3Bj+IVUe+BqD1uPOTav5B2KM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U9X5GGX2Me211V0JcARcCwijLouq5zecFstzOB8QV8ppDe7FwuebIfSPGildTxX3P27N5ez9xK6+9qZxi57hM1NUTvBpgusWLgavNWZn8xAG0hgWhkzFa/2cZsUjDxfZyEzitC0IPmv61KWL6ibBurzkkbOubEkWVaxwa7X4/xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfiyWiVM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfiyWiVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8981F000E9;
	Tue, 18 Aug 2026 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787074766;
	bh=P2jfVtVVMgmPti/mxygu6b8VQ9yP/XMG0s/OzqIKvAE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BfiyWiVMNtpYuuxLCzvRktuyz3pK/u6/nYdxKBzH/Ulph/5+J4TaVMeqg71GRK7DG
	 1p5XT72hVZks8e3+tUy6k5CjFmhZdNjSx1aSRow9dNWnNVLyMTHIQZ504eLN3Ck3r5
	 BWd91w8w+zrFWYKbX1LQwCMuff7gqt+2yLzVOMEFb4dbRkgIL0YZn8ijxlHddMWhid
	 kKkrmSsJ5c/hdp14S4f/T84iFu2n0erH9E8Lvj/3YkbekZVtUZBu8SvmchF4E1i7lj
	 Ua4wlJHMgNbRgLHkdj3cYPJAAMscC2TmYA0I9/SCHVyNxmcfgtoTu/NA5opgMwd05k
	 CsU3aO1Fca+vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A203927043;
	Tue, 18 Aug 2026 17:38:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: openvswitch: fix nf_connlabels leak in
 ovs_ct_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178707471727.2194892.12887232737858132657.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 17:38:37 +0000
References: <20260815151729.3757984-1-ruoyuw560@gmail.com>
In-Reply-To: <20260815151729.3757984-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, pshelar@ovn.org, yihung.wei@gmail.com,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Aug 2026 23:17:29 +0800 you wrote:
> ovs_ct_init() acquires a connlabels reference before initializing the
> conntrack limit state. If ovs_ct_limit_init() fails, its error is returned
> directly. The pernet core does not invoke the exit callback for the
> operation whose initialization failed, so ovs_ct_exit() cannot drop the
> reference.
> 
> This leaves labels_used elevated when Open vSwitch pernet registration
> fails for an existing network namespace. Subsequent conntrack entries in
> that namespace may allocate label extensions even though Open vSwitch
> failed to register.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: openvswitch: fix nf_connlabels leak in ovs_ct_init
    https://git.kernel.org/netdev/net/c/f9de5db270a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


