Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792457408;
	b=t18QNDQ3TiDbkflA35ISVXwEBqMGSTQTE//5AxHC8ItOybptFB9pro6INuut70xnasrH
	 vlD2yHkIBU/UpP0dnW9OyKqp4QViR5GXlYXlsZOMOLCmvuym77AJK/kSdSL8BwV/dPrR4
	 RiDuGZfcJkUKpHAJSkQDnnxvgTC781NVGYXK64Ul7Kxx9nEYq0c7m3z95cPADt4U0th1y
	 3D0s15xp/EQbh7JWQln+T9ObP1pZvkMeI67ljuwDCl085uX7sNhQpfmiyNjkbNkB00Ug4
	 E1PJ+kuGpBObkVmLUg/JgLGwgqfflffHL0pqHwhR6AcVUZ0WbtEy/YyAIEcEFebkZag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792457408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=el9hJYBAjlZoS6JyxYpDl9voCiCbLdNbk8o8t7V70ZE=;
	b=JYel754mX/UYujX1n5f55MRGdQapHQYPBiKaqRCW8JEFUzXEBIZcFq1nUm87x71rrTA0
	 Fkau0r/Eu1E5pwB5Gx1RFtuKMC4D39MMiiyCU1C24nzgbagXvzs5rZ8q2dMx3/QTOxAxd
	 F8SaCbASAUjziUB33OrmOdJtwXBpqHnWL9fYrtv3RRtlmtv1Eg4iT8SxYsyypAvI1GdiZ
	 Z9aQl8IY3+VBvI3Ccw3LpOU77zUVcRbOvgY7lzf8lNAnOkNraVwmQdynIqXXeRcX/J9f5
	 yVmZDxNcwcPBrQqbEY2xxPm+fPWc2JjnfcFT2XqXmgRmV8mLC31Z9ho8GeEWpIiBzQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JeKPmpIb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D0606A31A;
	Tue, 20 Oct 2026 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JeKPmpIb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073BE1F000C4;
	Tue, 20 Oct 2026 00:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792457408;
	bh=el9hJYBAjlZoS6JyxYpDl9voCiCbLdNbk8o8t7V70ZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JeKPmpIb7rioVU8KSVMTaPEL4qrczdF7iOjohijyh7IRKnr4hC+HhAvNd+L4TyUAa
	 mYj9nK3+AkWuDVICQSrEX5wouJKb65VHUpLGfm+YZZ+sfusp09sW4bOs2vMKzhNM9u
	 hEvNxg72gLhb9akdTTjPUJfPE1nFmTB2IahrvBS5o7NxoAx8E/FDPBe1rfMWItzFYU
	 fNsOauJr/M6S1oaqjmGfr1oI+VBPhyF16WmUmFH8SomJ7gA+o0Vu/b0RuDCE/AboDg
	 cIbCxT+oeHh9w5yzBhj0HjFMTRVU4mfnR0Ket1ybdB9fADVYqSDc/eBYPeS2J3xeIG
	 bZYeJ8/Nr/sug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15633924A6F;
	Tue, 20 Oct 2026 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] net/sched: cls_bpf: accept dev-bound programs
 on
 shared blocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179245740678.3407717.8152429753344693059.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 00:50:06 +0000
References: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
In-Reply-To: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com,
 sdf@fomichev.me, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, bpf@vger.kernel.org,
 stable@vger.kernel.org, sashiko-bot@kernel.org, victor@mojatatu.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Oct 2026 17:02:47 -0400 you wrote:
> This series fixes the regression where a device-bound SCHED_CLS program
> attached through a shared block is rejected even when it is bound to a
> netdev that owns the block, and closes the bind/reoffload replay hole a
> later-joining device would otherwise exploit.
> 
> Patch 1 gives netdevsim's cls_bpf TC block callback the device-match
> check nfp already has; the callback is the authoritative per-device
> acceptance boundary and the defect there predates the cls_bpf core
> change.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] netdevsim: reject cls_bpf programs bound to another device
    https://git.kernel.org/netdev/net/c/5820ca58b409
  - [net,v2,2/3] net/sched: cls_bpf: accept dev-bound programs on shared blocks
    https://git.kernel.org/netdev/net/c/d305547d1632
  - [net,v2,3/3] selftests: net: exercise dev-bound cls_bpf on shared blocks
    https://git.kernel.org/netdev/net/c/866363c3cc40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


