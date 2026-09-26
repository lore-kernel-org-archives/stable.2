Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E972741A0;
	Sat, 26 Sep 2026 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382681; cv=none; b=St9fKP537laa0liuTdax032R5zD4p134Gw/MmFpG885bCtsqVtwQ4ljmYg9HdMnYzbphqVBUtAVTyCLG1XDMpTvJec/R4aKy/ZQVhodBe9AgaDBP4Q52UV8tcc6ccn3XSkoSKAD31cTM3Qgqi0BWRzDCd0IFX3cFavfh/j3+JFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382681; c=relaxed/simple;
	bh=64OyEdHC+11cThvtMQ98CorMKnBMdqfIgcZAuJJvIzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pyv9MAAGwTeYGHyexTFI+V8CAaMT9orFOaWYMErtL0LOwDoPU+KolFc0DpVPdbNyV04sW2hjZSUFwB7m4uz4t5yGumHq6geSwnRCvO+iwAKeUEb0I7hiOeijZYO5/LRCwUcau6L0bJ0RHcBK1AsyMBpPyLalyprL8/FZWTtNKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf37jIRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf37jIRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8661F000FF;
	Sat, 26 Sep 2026 00:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790382680;
	bh=et7FIy8XevNndOdMWhULMHU+2jmlWoTxz0kZSHuk5v0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Cf37jIRxB/XYc02+xBziFfGFTm89/1vLUEko8eGgB4nnUX0E1nuMYYOFavVkN4jyK
	 611lF31xyIMLb8RL79rp0T0bc9DwsZJEsCzI1U4AlBi5hfC/wZW957URSNdA6NUcHJ
	 co9eohmW+tTdn1GJnQoKEoptW0x7zhxC/PcGSEWB3kve1jkTGJ/8VCIozRgezwY5Ga
	 3Ue0FhSMAH5GLlKp5rwbzCAjIwvBvxtNqsc4noDHCpQqfsionmtdvn039axYl4jgax
	 TYIJCGprKEEIKP1ZH2PNBRzJu9XK5DAXMXW04wH23bl+vokGNwFlEX96czz+72KuJ2
	 YUQLrpHMrT/lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197163809A04;
	Sat, 26 Sep 2026 00:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: cls_flower: exact-match ERSPAN key when
 no
 mask supplied
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038260764.3219877.17958595042468339868.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 00:30:07 +0000
References: <QDISC-4CSL.v2.20260924114800@mojatatu.com>
In-Reply-To: <QDISC-4CSL.v2.20260924114800@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 lucien.xin@gmail.com, victor@mojatatu.com, stable@vger.kernel.org,
 sashiko-bot@kernel.org, hybris@mojatatu.ai

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 08:18:41 -0400 you wrote:
> Commit 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
> removed the unconditional memset of the erspan_metadata mask in
> fl_set_erspan_opt(). On the mask-parse pass, when userspace supplies the
> encap option key but no mask (TCA_FLOWER_KEY_ENC_OPTS without
> TCA_FLOWER_KEY_ENC_OPTS_MASK), the !depth early return leaves the mask
> zeroed -- a wildcard. A filter keyed on an ERSPAN index (v1), or dir/hwid
> (v2), then matches every ERSPAN packet's values instead of exact-matching.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: cls_flower: exact-match ERSPAN key when no mask supplied
    https://git.kernel.org/netdev/net-next/c/e0edf25f141a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


