Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E95138888E;
	Wed, 22 Jul 2026 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754040; cv=none; b=qCirVnltxdvRWOQLqsw+GQEE0EfwpgLp+w6eL9WLGtJ8dmBFnaluDchZC1K3PNW+hkW1x0PYhW9q0HoCBN38eIJEDDDrn2k/kgcxmUdRYImmHVIg2eHB/jRN6Zj71coVB40NUVxYHNlNpAanZta0F84MUjNN0JLc3cjjoQ0mwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754040; c=relaxed/simple;
	bh=/Rae/DoT6Yjm6B/TwGNwsBjjMKKQoz2fECR00sTjV8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=as7WRmkoTQYmThqDvLzqSk6QRmwdqneXMV3LQA+7WMkzX4I1BcPS65DMpwSX/u3rILRwf0q4VV19a0NGtkOvmEEm+g0I9HbssISHaoLBzh/OJCnSmWtcat7rdFiDspBy+wqRfubz/qUL9Y2wOS3jeSQntpJlAX0pj5ORNw8Zld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lqo7X56T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lqo7X56T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E549B1F000E9;
	Wed, 22 Jul 2026 21:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784754038;
	bh=nczCwjOja0W2RJd255Uy/4ytPzbOxBXktF6nqQMOUtw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Lqo7X56ToZ+fJmfZ39zKedDThHo8wIPphJ85KJnXEgl60Z8gr93jwjIZQa7UZheRU
	 4AQP1dQ+aSwiTlaUnoRPvWzKb034weQnAq1XyUhBxsgKLKBxvzC7XiVG1aMYADS3cv
	 YEpqU32b+WoCXOZozwEIpAL8Zan+tjklizMtNG5JEzagd8W2X7Aann6K6iK1coqvxa
	 Qod2gVGD+mdpKuinDFjzJcyN2PsRTGCMvo37XRqXF5xXqPGE19GccT88H5gAzkytzJ
	 KZSAHXDBKvjUdkZYl1YXvJov6YI8+mVjk2eqg+AZgbOzGlrvEOS+uG8menrhvw4ism
	 MNNWbUxZKQhaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0978380CED5;
	Wed, 22 Jul 2026 21:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vxlan: mdb: Fix source list corruption on a failed
 replace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178475400739.2022998.13699263721848648039.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 21:00:07 +0000
References: <20260720160428.249356-1-jamestiotio@gmail.com>
In-Reply-To: <20260720160428.249356-1-jamestiotio@gmail.com>
To: James Raphael Tiovalen <jamestiotio@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 stable@vger.kernel.org, kees@kernel.org, razor@blackwall.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Jul 2026 00:04:24 +0800 you wrote:
> When replacing the source list of an MDB remote entry, all existing
> sources are first marked for deletion and vxlan_mdb_remote_srcs_add()
> is then called to add the new source list. Sources present in the new
> list have their deletion mark cleared, and any sources left marked
> afterwards are removed.
> 
> If vxlan_mdb_remote_srcs_add() fails partway through, its error path
> deletes all entries on the remote's source list. That rollback is only
> correct for its other caller, vxlan_mdb_remote_add(), where the remote
> was just allocated and the list contains solely entries added during
> the call. On the replace path the list also holds pre-existing sources,
> so a failed replace tears them down together with their (S, G)
> forwarding entries instead of leaving the entry unchanged.
> 
> [...]

Here is the summary with links:
  - [net] vxlan: mdb: Fix source list corruption on a failed replace
    https://git.kernel.org/netdev/net/c/dcd9b4659654

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


