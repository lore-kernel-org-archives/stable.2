Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FBC54788;
	Wed, 23 Sep 2026 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130075; cv=none; b=nfIDYr0e9nh14o8pjcKHGQlrFS1ew6XAzrUxw3El92tpB07kgV5WIQaC2Qwlk9l0R0S3dSqpnYFB2/H30dDmz13k7Kzn/8I/Sfo2tGotPFgNvYWZy75U0/n56vZ62v7vGN03dSuSE4mJmbDryOnKvaNjD+GUvTb7dmmAEUiEdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130075; c=relaxed/simple;
	bh=JlcDx+90faiWzvsk2tJ/fkffK2A+Mb/XOMT4rI9UbBM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h7MW7xmHT3DP1T9p2rpa5nlh126EXvaejsybJ4DnZSTVJwZiLVYRPxV5/ieW+ugGNny4SVXiFX9kdNeyEoW79DDoIpbA6gCE4Izz7pH2W/nfLEJdTlT+MjsnazPrjbEgYtjzBbXyc9yGfaGV+NFLnBdBRD55FFqTNQumdTI17Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEIIkXDR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEIIkXDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B701F000FF;
	Wed, 23 Sep 2026 02:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790130074;
	bh=Ji7+MiaFmb72MV99NdoFp+cfoihFAO/nWtWdpd1qMPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PEIIkXDRA41qx3Xx4Wy3TusrbvPMfFSRc/kqhesaMP3RWx2reHeirUxgc0jix3mmg
	 dXOQdDa0/G3vIGbXPpYFxVxg5fe86aTJDA5ztJbUcG788ojFLBcrVjnOUjGsanCUsg
	 cHlJ7HxXOya8lLs2mmn6jonTVZbE/T4qwFSJhpYQ5n5gPtdznVkEHdiYFSlHD9R/1Z
	 QJbuTZXEBqJpbfMMZWpdsEnrv8Kzd+Ha5cupV0hajAH/sHm7IUPbeSsICkyPS0WTd9
	 k7U4grJO1NHrBn0b528j9GcqAJoT0o3wi0jEwR84qu6PdpXHDFTWWNlvcyPtnYUtkt
	 vmPdyv/vI7S7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A983924472;
	Wed, 23 Sep 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 RESEND 1/2] bpf: reject dev-bound-only programs on
 other devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179013000490.180033.16817680789297827753.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 02:20:04 +0000
References: <20260920132303.4109240-3-bestswngs@gmail.com>
In-Reply-To: <20260920132303.4109240-3-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, co+ac0a8c41de69121d@bugs.sh, xmei5@asu.edu,
 stable@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 20 Sep 2026 21:23:04 +0800 you wrote:
> __bpf_offload_dev_match() falls back to comparing offdev pointers after an
> exact netdev mismatch. Bound-only programs normally have NULL offdevs, so
> unrelated netdevs compare equal. A bound-only program on an
> offload-registered netdev can instead inherit a real offdev and match a
> sibling port. With CAP_BPF and CAP_NET_ADMIN, a caller can use
> bpf(BPF_LINK_CREATE) with a different target ifindex to run metadata kfuncs
> specialized for the bound driver on the target driver's xdp_buff. Running a
> veth-bound program on tun reads beyond tun's bare stack xdp_buff as a
> veth_xdp_buff.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,RESEND,1/2] bpf: reject dev-bound-only programs on other devices
    https://git.kernel.org/bpf/bpf/c/6db1ce73e985
  - [bpf,v2,RESEND,2/2] selftests: net: test cross-device XDP dev-bound attachment
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


