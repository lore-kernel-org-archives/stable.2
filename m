Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6752D6407;
	Fri, 19 Jun 2026 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781831422; cv=none; b=rHQH5FrLIwAsF43gEqvtoAFHRjQPSPzdlaGfzSLLTGOe3JIthp4DN9wNGP8tC3UdGGv9hoRfLjP1y2Lc6a9mzsC7gOFnUrdt6XNX5YeGYoscVXPqd56JqEEUQmQpboDOJASCGho81iI/54TsobkyZMEFkT97R1X7aEzJSDJL/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781831422; c=relaxed/simple;
	bh=C731szEcLMQTrjR/1bZjDp/qC4OFao+RLHBd7f/kZ7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fLsV+1rhPaq1Y/p8ODt97mwap6oaq6YDphSgtp0ZK7jTPCGrkEeobLIf6MvbE4tPe8tlnIJSYl/l6+F1h9/ecpFiZLhr1epvu4ZxvoPgJeaam2ZEKUM9V9QIXKT968utj8T77Ep+fcYrqzRUWC0SuYBJ7NHCO0NOxsod10mpt3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el748I06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el748I06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510681F000E9;
	Fri, 19 Jun 2026 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781831421;
	bh=XH2TlmF8HA4ZQ7a2qf1eNcA3yx46MIM6GnDpVdR8JdU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=el748I06c7CvAxSrPOGD6h9NSJiHNIg+K15MoHt+ULQHilBn0gL9wQGpv/6u+HNUb
	 LTAs1Hk/L4SRYs4qHRt3bsibcjVjo0m3zYqNMC21Y1l9F3TqET5Tf4MXcB498Lo6GI
	 XltrP4bk22f1Zg2bY1SjGuyXnmRdSeUOxqRzWl4wEx8sYy3oPqw/7ojLY4R4lDavhT
	 AIIcpSORwOuaitqMBFfJhC6lK+XHe1vYvheoJd9LtkTxyLOmsJ4ETbTPDQ8JFkV0r4
	 N+OqI601fHYhWub52t2iT/+Wq/4PRZSJj+6SF72zzqlIr5VnVNb8VTK4/KOywwkvuR
	 FW1r33Gvp2sUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C943A78A7C;
	Fri, 19 Jun 2026 01:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] octeontx2-af: cn10k: restrict VF LMTLINE sharing
 to
 its own PF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183141438.3148637.10208616732049079838.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:10:14 +0000
References: 
 <SYBPR01MB78811656934E713B77DA6CEDAFE62@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: 
 <SYBPR01MB78811656934E713B77DA6CEDAFE62@SYBPR01MB7881.ausprd01.prod.outlook.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, danisjiang@gmail.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 23:04:27 +0800 you wrote:
> rvu_mbox_handler_lmtst_tbl_setup() uses req->base_pcifunc as a direct
> index into the LMT map table to read another function's LMTLINE
> physical base address and copy it into the caller's own LMT map table
> entry. The mailbox dispatcher authenticates req->hdr.pcifunc from the
> IRQ source, but req->base_pcifunc is a separate payload field and is
> not sanitized.
> 
> [...]

Here is the summary with links:
  - [net,v3] octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own PF
    https://git.kernel.org/netdev/net/c/8cdcf3d2caac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


