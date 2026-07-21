Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74997207A20;
	Tue, 21 Jul 2026 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597452; cv=none; b=M8+ueIcLVsp1ICFMNHtqeOU3Nt51szCHb7QHubz/nv7viEaAFNmfwvsyBUvedicG8re5hyib9QKy4POL45bFxarpBMJ8Wgg1mWAd7Cdr1cQFKIs3cQKthZBC6sy3T4F6eAlyZp1fcXCHl8L3EQycirTeRuaXba67ZusRG9Ntuwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597452; c=relaxed/simple;
	bh=g23jdba3nmHcsCA6LzNHEvYkosA651heKOJmRAJJZ5Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CUX3yK2ds3dGBwat8HjhHUIWLEpEETW9+Q+yS9UwhpficlE1A93zaUTRUj9LfSBDwJ2NPb8pP2NP5XLU+qVbKDIRXaKSt4Csabgy2WY7iA/czb65MjmXFTs5nvPsGkerTjFDO3NsekTI1VS9vpwTXgadFSrNdxIejTFdeZTCaiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/IvdhQ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/IvdhQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7A61F000E9;
	Tue, 21 Jul 2026 01:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784597451;
	bh=XzKLbH5MbcvDifjWMdLUrMEvWfg2qi5UMDrR0U0NQnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z/IvdhQ0cYcJPzIoBQd4bxIOHbh3TmNIBqikSXzXK0DGeSk6gG0239ZKiX7vj1Ctr
	 MOJtnUe4wMIz1z8BDUfYRNWNSLXa19193CoD+cpjE65N3xygzyN4kpy76z/k2vbr2c
	 xwgZtyVauJFvBbFD4OAP6pdeg70+drSFlLnOwJJjcmt8LIQXMIzRMimnO/KHH/matr
	 EKxI3GEMlHgRhnKzyKu96CramqmhwIHU9bXGOe6A6z6r7F24O7lY6BgzLtw3EqJdKj
	 71dGwNkU30sR0ON3sFFA1dfL7tgMpMSIWROLttz37BR+wiGjCDtYcge/mcGbSPBJh/
	 B2kNyLhBSEsrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A2239244E7;
	Tue, 21 Jul 2026 01:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] bnx2x: fix null pointer dereference in
 bnx2x_free_mem_bp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178459742089.39048.16271527643824505578.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 01:30:20 +0000
References: <20260707054618.932108-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20260707054618.932108-1-nihaal@cse.iitm.ac.in>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 maciej.fijalkowski@intel.com, stable@vger.kernel.org, sashiko-bot@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Jul 2026 11:16:16 +0530 you wrote:
> In one of the error path in bnx2x_alloc_mem_bp(), bnx2x_free_mem_bp()
> may be called with bp->fp uninitialized. And so, there could be a null
> pointer dereference in bnx2x_free_mem_bp(). Fix that by initializing the
> fp_array_size after the bp->fp pointer is correctly initialized.
> 
> Fixes: c3146eb676e7 ("bnx2x: Correct memory preparation and release")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> 
> [...]

Here is the summary with links:
  - [v2,net] bnx2x: fix null pointer dereference in bnx2x_free_mem_bp()
    https://git.kernel.org/netdev/net-next/c/e354f7d60f14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


