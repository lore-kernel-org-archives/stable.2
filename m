Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660207;
	b=DXkBnxZbHns+Fp4NzZBpIYLwQ9dq8onuzkx202R5V+VkKS0G/9zstNjQ3rRLGGqQVcyT
	 QgrjrPX9g0Dz/Lnf2ByQhKQ4wol70ZuSX6jHRv/fthvC7emxaH9XFOx8reY8AHXND2/QI
	 3FP6hN/VsA3Q8xqeHVNfJmJEY6G6Ic4v/RmRNPWNjQPlvdNOcJCz3LQU7w7dDtOGKoeRM
	 TctVmTJKneL9xmIAFqUU03bdiy2mcjVpjNxjsVZvCFQErMLoVeZXpuxgr42SopPr+4XFi
	 P2AhozsSudyKsd4WlHqUAeqwtVMssAFUFXyRbEJ0gz8QRZ17dJyC5onEXjNdSKZI8Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=pfjhQGxprB6OEE7+13kybOYl138N6Xpw872x1WZ4avA=;
	b=mZEcpO6KamvuXF2Nkafp+hDWkM/Zs4DkhCmQgGi+5YbzUtHyA98xGAdgx0HXRc4YFVlb
	 L8VfYClBBF0wmEX48QwVJRpkJpTW/NE/e7tsD1rCviUsVy6ngCgCnkbWp0qsU5L9JKFtC
	 yhSTYhNv9BMSiXpKyRIRfcXiYPd4pNhQpV+0kGvDB3G+CaM6qCyscqc6I3x1lGE8WjcoA
	 3K3YfVGUMxV+FLMJDRoV7jiqMOXe5BaCl8ozxmCMMc3XfGv/8w78yq+bOIoTlYk1P47+z
	 fBSbh2z4nPzYSmtRHWWu6GcnVBw4DFeqM6OaaB7LRHDnDNus3OB2TVL3iGpT+czz6GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgAuUTg5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FDA606A325;
	Thu, 22 Oct 2026 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgAuUTg5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BEE1F000C6;
	Thu, 22 Oct 2026 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792660206;
	bh=pfjhQGxprB6OEE7+13kybOYl138N6Xpw872x1WZ4avA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hgAuUTg5qk+4RgfNZeek2sT1nzMJQuk+QHlXgxWQ+l3QcAJ+xaT3DIz4gTe3hXYcJ
	 FE+AV5OqpdwHlxrC8HYehvBZExca53cDcVUoFqiyDvIAGzCUCPMWRmGye92KWT7vEz
	 yC/1sCz6NxiMDqtvNp5rBZr87vVhSQD4FeklbtN6dtg5LC8s210dWhqLLqZtTqgBgY
	 JYjfYIpVIcxupWVS49dcXxEd8hdUjTNNe2siqk/A8UfGr9UjlQ62dFS7OJk6ZTJJQi
	 S2pI7D7vAb1FAiaB41VG8U9tYi69lat1aiXNYs+ZGCOFQcifQ6UBmf1c2BJu/1Noqc
	 SozgKJAQ29f9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A206380A97D;
	Thu, 22 Oct 2026 09:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net v4] tipc: fix broadcast sender hang on last acker
 departure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179266020503.1559266.4916570736972457348.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 09:10:05 +0000
References: <20261019115859.3471295-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261019115859.3471295-1-bsdhenrymartin@gmail.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
 kuba@kernel.org, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ying.xue@windriver.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 19 Oct 2026 19:58:59 +0800 you wrote:
> TIPC group broadcast senders are blocked while a replicast still has
> outstanding member acks: tipc_group_bc_cong() returns true as long as
> grp->bc_ackers is non-zero, and clears *grp->open, which is what
> tipc_poll() uses to report EPOLLOUT (via tsk->group_is_open).
> 
> When the last outstanding acker departs before acking,
> tipc_group_delete_member() decrements grp->bc_ackers to zero but
> never restores *grp->open.  As a result poll(EPOLLOUT) never fires
> again.  A writer blocked in sendmsg() is only released if some other
> wakeup happens after the deletion: with TIPC_GROUP_MEMBER_EVTS the
> leave event delivery calls sk_data_ready() and wakes it, but without
> member events nothing does and it sleeps indefinitely, since the
> default send timeout is MAX_SCHEDULE_TIMEOUT.
> 
> [...]

Here is the summary with links:
  - [net,v4] tipc: fix broadcast sender hang on last acker departure
    https://git.kernel.org/netdev/net/c/f4377bf85887

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


