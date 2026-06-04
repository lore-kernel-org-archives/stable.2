Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856B02EA73D;
	Thu,  4 Jun 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571406; cv=none; b=XCGQ8QoQQJYSuKOmh0K9fWI0zmjCb98WXDHhnfSpPbAJq4szVlknwcyQVO1rNAjZodGPArE9XOvJgZWectOT1oEe989liY7XeMZ7XE8HnnHSWzbVW2y4iFgRsbIDEWOJ6eNBYhrIgJIEnfe8SbwlEp9/e9GtCTBznDxGTbe01Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571406; c=relaxed/simple;
	bh=ObNrt96l5SRoRQF0aBAf0g+HJXVqxVb64hZbnLkHy6I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tmn6X48O42Z/297cyQSTzoTRIIwPASidsm3UeBMIKOMdtfxsKKuR9wIHbNc+bH4jdYBnEItHPU0cLZJdThc9s7zZbczjNOu1b1aDAQLHKQmPXCMazz+xe41oYD6MWGyfZzqT6VHUn8kH6vYujaiwVPE2v6ocEbCMs4N9Dnq4fCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQBCLgSj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQBCLgSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210B81F00893;
	Thu,  4 Jun 2026 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780571405;
	bh=sBDHwF0A5ftXuY2RVhAcPuncgVJtUJv7SC8kcwkgTzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eQBCLgSj9TmlR/EMYl1Y8uW9e1GPmXso5kxKgDwwPlRNPD6A7UXnWlkXHcJy0PGQX
	 0viQBq/NWMVxxH+45ABxAcsq6cvVNTrRi2q6Txa3bWIH15SIYeg+pOfrcGSG+CyxbL
	 cILKAYCG7UAt+B/8UKAF15KTXJHYGVGtyA2yzkn8+OOWGT8ifh3EeyJDqsXtzsN35G
	 iMQ78WYngg1BHOa3lNS+pXz6+csokpp/ASJcFhE6TRM+v5JvohcQoZJ7Y+mW6h7zL+
	 F/l5mUyL/Qhxlws5ac7oyAcECmAyWWBo2SCTKr20jpTX6aBru27l8pIk8owzid0xz2
	 cyM+MI063oaCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568E83930923;
	Thu,  4 Jun 2026 11:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178057140614.2374942.1031115322455733862.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 11:10:06 +0000
References: <20260526104356.469928-1-rafdog35@gmail.com>
In-Reply-To: <20260526104356.469928-1-rafdog35@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, sgarzare@redhat.com, stefanha@redhat.com,
 bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 May 2026 10:43:56 +0000 you wrote:
> When vmci_transport_recv_connecting_server() returns an error,
> vmci_transport_recv_listen() calls vsock_remove_pending() but never
> calls sk_acceptq_removed(). This leaves sk_ack_backlog incremented
> permanently.
> 
> Repeated handshake failures (malformed packets, queue pair alloc
> failure, event subscribe failure) cause sk_ack_backlog to climb
> toward sk_max_ack_backlog. Once it reaches the limit the listener
> permanently refuses all new connections with -ECONNREFUSED, a
> silent denial of service requiring a process restart to recover.
> 
> [...]

Here is the summary with links:
  - vsock/vmci: fix sk_ack_backlog leak on failed handshake
    https://git.kernel.org/netdev/net/c/c05fa14db43e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


