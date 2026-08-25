Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D23D8122;
	Tue, 25 Aug 2026 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654462; cv=none; b=Ue5n1+dtzf8e8onPp6q0Z77PsOQ2n5rWcxmd6C5AuL2SP33nyDZFccCKQHzpb1Fyt+f5KTVqbH+p7Zo1AzRCKTEkiDU+Q3X88400XZub5gCPdZ7OZnGxxSP7IJqCAl7VnRqsSf5RDkLbkXLOuW1/OXARu6vIuSYeL8Zj3/o1mE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654462; c=relaxed/simple;
	bh=+zpRH85+sAhfTt9EQMlHrIaoyUL0LBo/ll0Y22TeK1k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZURatbcL7eWwnJzi22aAwkzKpu+7rIFXgTudEcdOR3rWaqKD/+SBWqsZMHRGlmvjxbg/ikdKnXSIi+xMkn8Bes6Jb3b9uY1o4yzg1F5QGLBa2ptpWuJpi++QpWbSr7h/7S0IBiSYLRysY9vG06sFjCiuX0jS6FRusCIPB6P+XN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or9bE07A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or9bE07A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9193B1F000E9;
	Tue, 25 Aug 2026 10:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787654461;
	bh=1X7G8zBp06e+0PyVhCy6ixlu+CAbl1w2N9HeCduh66I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=or9bE07AVT1eFuLgmd0jUJZILA8W5Sh475hj7ATWS5HRODQM2EUoitDOTqvOlSiYT
	 Tmd2AJIuEg7HsMX2uGB+4+yuIg+qZ3gGD052eQ5iH+B5mOyaprj+Fh6roqW9kjNZ+r
	 ZyEpBaTjw0kEZ5ig12x+PpKdPSJm8xRr/TON9jfKTgXBY0ToZbMy3KoP1Szjl+IsGl
	 h33kcP4tTd7xs7asn7XMXYQRvpWXd1/lMfh/BOxZRr3zCdkQtJCn7mdh9wFn2mL7yy
	 lrbXG+yniuGW5kH+O3CeCSnQe2pVgz+LQyFlve/UZa9gK1iIIqKPlfhCvr2eWvzrgj
	 m8PixrwFp+TQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D094A3924A7F;
	Tue, 25 Aug 2026 10:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/virtio: flush works in dependency order
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178765440842.3381513.12080866327704897722.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 10:40:08 +0000
References: <20260822164556.3750959-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260822164556.3750959-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, asias@redhat.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 23 Aug 2026 00:45:56 +0800 you wrote:
> virtio_vsock_remove() stops the virtqueues and then flushes each work
> item before freeing the enclosing virtio_vsock.  The current order does
> not account for dependencies between those items: tx_work may queue
> send_pkt_work, and send_pkt_work may queue rx_work.
> 
> In particular, send_pkt_work can set restart_rx and release tx_lock.
> The remove path can then stop the queues and flush rx_work before
> send_pkt_work queues it.  Although the later send_pkt_work flush waits
> for that producer to finish, nothing waits for the newly queued rx_work,
> so kfree(vsock) can race with it.
> 
> [...]

Here is the summary with links:
  - [net] vsock/virtio: flush works in dependency order
    https://git.kernel.org/netdev/net/c/728836ebca23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


