Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08584479873;
	Fri, 31 Jul 2026 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541247; cv=none; b=Y5YuntadumqGNTrjfSSyVd1NrEltGOWfhx+6scatp2RZN7HzQnQBnRhmCyyB7ROYbo4eHMBXDYy2r6UC5o0OA12QOBaKMvlbIvrNylVRVVUtdKvTgJiwtli1Ds3X5hjZknzjFolrfn5FhSeRkrSJ1LDdVS6/vw4hbdDprtXk0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541247; c=relaxed/simple;
	bh=/tnOcJlUu3HTyfOd8NtmThhDh9F02Evyd1mJGYlcCTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tnuEh8trwRybTxrjq9xYJouxuaqlj9AX64iDzFM2UsPfpP0WoDv8wNEZFrRWCUZdQxV1WXgmcm36wGwPTEba8Y21ndPbRDIBNGgSawLws/vACYlpqB8RRE1qetwtCWVLoaaMDdW3+nu3lJOIaxxYznXJqpMJejmWBy0qgGXpFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ateVAUWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ateVAUWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E111F00AC4;
	Fri, 31 Jul 2026 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541245;
	bh=j4ljSAYseqtpPgeA7I4xE3UCbNvewZstwDijy6KcpUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ateVAUWGQpN6XJwOa+AJwpYPzF1Nhn4SmrjMwL9IHL6ZZX4n7hiaXLD7l7eyyQpwf
	 63v9wYopnnmG0KDz7oKnUTKX+H7pWQ7doOBs4RDHMsx4zySZZ3omtrhFVYm7Lh7GKD
	 msA7+/BO4cbqYRV31X4s/12bR3sRBQLkeXVbNEv3nepeKA8MXflSqZnO3qywPhC4nK
	 XQ6bKGW2bdfPcd/rAJ3KF+vcHopeQO06zWil4bG/c0weE2kLL/P3g6TXziyK7/2h+X
	 aicf+q76z2v66P1/JeABx6cjWEaxFEK9rdsEfhWTsOQ7Bb6fW3FwWXJ/iTW+9+a6Ix
	 Emw2P6FC7xZHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0995392665D;
	Fri, 31 Jul 2026 23:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bridge: mrp: fix uninitialised bytes on the
 wire
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178554120838.949682.13580127258909324306.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 23:40:08 +0000
References: <20260729131941.10254-1-baul.lee@xbow.com>
In-Reply-To: <20260729131941.10254-1-baul.lee@xbow.com>
To: Baul Lee <baul.lee@xbow.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org, razor@blackwall.org, idosch@nvidia.com,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jul 2026 22:19:41 +0900 you wrote:
> br_mrp_alloc_test_skb() builds MRP test frames on an skb from
> dev_alloc_skb(), which does not clear the linear data area.  On the MRA
> ring-role branch the sub-option TLV header is appended with
> 
> 	sub_tlv = skb_put(skb, sizeof(*sub_tlv));
> 	sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bridge: mrp: fix uninitialised bytes on the wire
    https://git.kernel.org/netdev/net/c/63488dba65ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


