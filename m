Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634607;
	b=Guv4gBTjoI5zGOWnvTrQAO+Kd8GdJj0boArVveK1WVaf+Rq8cCzHp3R8QVOj1QCmZbTS
	 JdSsoTn3G30/coJ0TRsDvhg0UUJZKVXFf3j0S3rLkZXjlR423/qx+ydUrXHBQRoPiUfC4
	 YtFj876Tbv3UNiFcudTR2hhd8ThLLWfeU11wFhFjis53sK5v0SlNAYe/yCk2QhemOdhgJ
	 mPKi2W9FeFpmDdKmh3kHnkJmlgxZ0W5VRsKaOj4onVG0KU0wy491HEnGXqfcMpavVZqOa
	 iYcgB/isPsAPCPh1an68h+84uJ8tPJXbKtMjf9zdmm780iU2gL0IrYXf8zv9VLC4hfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=R2uyw2KBqv+ypQbVU09qhOx2qFtMrReMIQ4NGIDJpHQ=;
	b=gnYXsx9kDXvVItsWOIWyNGhECqeKlsZvmLB9FTXJhZPnb2r5ogmhVY5lPpB9cPUQMbPt
	 geAehUaRcYsVvh/ehVy4f7G09pVhON4dOMYR9u4JSHExN/uWZyUAthZP7hvErDhuAjrqO
	 +4NTFSVXQuWAIWLQVUZ0wkrg00rXnFixiW6eCZ0aCiGWrXo1xysz9fl+YA2WbVrFVe4xo
	 zlT3rmZhW2WOXjQAEVIYQmbisHM8sCe8U+h6TlTlGkmEm9gc/XkpV0bWccd0++l1z53uj
	 kK6HABLxLIcFLNbxIZu8405l0ObeAPkB2a68eFF69G5vGHZ7p8AwY9wcDrvrjlBf8Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hS35RL8z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2690606E00B;
	Mon,  2 Nov 2026 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hS35RL8z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B32E1F00A17;
	Mon,  2 Nov 2026 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793634606;
	bh=R2uyw2KBqv+ypQbVU09qhOx2qFtMrReMIQ4NGIDJpHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hS35RL8zc3XafEK4uVAAAOr5x3paiuif0AeEiObrgvShqxfPc+iLC8f/T0qFTQvtV
	 Nf196dqd+BoVhtXUAOMkMIeolLqu/KTJFoAA6M9KPSiMKkY2VvtpbJdrHpxcbY4Skb
	 YqG28PMVCYC1uUNDh5XIA6uKEnLec60Dmqg97E4uNzbDMF3IhlX4cp7pC8U1NZQnXy
	 JjywUBDdOfYqnItbOTO9C8JED8uiB9jqpUN+MuEwrnyxBm2h2kuMnAAr+GSpqQwAHC
	 okNrU53dAn6ZigTY5aCYkJL717hxDBDtqF/diCjBWbpKpfH4K0fK+qLGOgi1ZbGXcx
	 N3GU6/lxqDwUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401EC380821F;
	Mon,  2 Nov 2026 15:50:06 +0000 (UTC)
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
Subject: Re: [PATCH net v3] net: qrtr: announce local services again once our
 HELLO is sent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179363460505.17619.12560693477467946976.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 15:50:05 +0000
References: <20261029105142.2503-1-26rote@gmail.com>
In-Reply-To: <20261029105142.2503-1-26rote@gmail.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 christopher.lew@oss.qualcomm.com, deepak.singh@oss.qualcomm.com,
 pranav.phansalkar@oss.qualcomm.com, andersson@kernel.org,
 effeffe99@gmail.com, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 19:51:42 +0900 you wrote:
> Since commit 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint
> register"), qrtr_node_enqueue() drops every packet but HELLO with
> -EAGAIN until our HELLO has gone out to the node. When the remote's
> HELLO arrives first, the NEW_SERVER replies from the name service are
> dropped, and so are the broadcasts for services registered before our
> HELLO goes out. Nothing announces these services again, so the remote
> never learns about them.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: qrtr: announce local services again once our HELLO is sent
    https://git.kernel.org/netdev/net/c/743b5c86276b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


