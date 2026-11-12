Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504006;
	b=x1PqGVuBreS53SWwNxSuqk46SA7FYVrFv6vvj/RKA5u19JzrHvKQ5XkSmSdq1/xu9CJX
	 Qk6IPUy7s5Lp9Jw0IAtIAmnA3F6FUabu+hMQtjhfcVRvea0yQfXuOLEESbwLg1Edbf8Xz
	 5CjNqqyQWicot8NKsrgOQltVvW3ZZKQDSzlkjUGhqP5d11BbbTzGziSNOdradm1XaDWIR
	 34djVD9687mQxwyaGE7eiJC53HkjfBNus8aPHFacLY1ec4M6wTnOXcF5k57q/dw1pV5aP
	 qSlKCwr0zVXSbARWpi7oLRVqgMOsND4D0Xq7aCfHxeYjQUpIRclq2lOSGK5hLQpT+3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=qS6fzWJciTtP2BqMr1B9alSuP1TE43oLife9LsW44uA=;
	b=A1yoac780j9qbD9sqTQdzmiTaDdQDjeCg8YUxXpHY8BfashHvx/YfLQvBDpPa5olybgf
	 YGBGWNb0kRpspVEY5P+LFsqO60zA4oYUy0/Sd2C2E1hoQx+acCDONGXD/IWXxbWOTxgUr
	 FnNM2zrFJuWe9Tc75SAFS9DM34YlUxmemvy4LAM2ADF79XDJujK9B768SRy1TpZz/hIaC
	 dMQ2oshzRF/Z/kyVKx/GzCxvegF86rs3m6/VT5Ka7Bh7687oeY3FJNPDDiGxfEj/l2Zgl
	 2OZSjvacbhR7eK9mkGjUqft6UVa+9/0/1zFJklSLTlk2a58n0a28hM2G/UVRTtvYsyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsNsZ81S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A81606A323;
	Thu, 12 Nov 2026 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsNsZ81S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441C31F000C4;
	Thu, 12 Nov 2026 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504006;
	bh=qS6fzWJciTtP2BqMr1B9alSuP1TE43oLife9LsW44uA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dsNsZ81SJ0u6/XjilXatuL6uaKKgcXkSMqlwN9jN7R4yXMFlQRv0pUvVT72i7eZfv
	 Z8/S6eJ4iRaamWs+isH5IytJqZcJzDD0s+cI4LmTBx0Fe+XZJmxGF8kxOhL8zWwT2q
	 QMfHPqEYhG2dBWoe5E9OvbUqUIUhGrvYEAHnmZ7I3+zC6BSS1w9RWn3A99AZ+up+BB
	 TlfG+/QBQxw71Q32IEroVUBlumEABafSZZUHKg2q67+L2bm+NndUEYf/bW6KE2cgm4
	 TnS+Vq5EbvzNDNwr33qQ3bSL4McVpF50jaesCgfL9KvGua3DrXTRlO6UlW0Azi4fH0
	 uCvbEtwcGegWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A395380AA78;
	Thu, 12 Nov 2026 17:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net v4] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450400478.546493.17448438717163223055.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 17:20:04 +0000
References: <20261109-vsock-restore-uaf-send-v4-1-1df8dfb5d5de@eldare.de>
In-Reply-To: <20261109-vsock-restore-uaf-send-v4-1-1df8dfb5d5de@eldare.de>
To: Jerome Mohm <jrmmhm.kernel@eldare.de>
Cc: stefanha@redhat.com, sgarzare@redhat.com, bobbyeshleman@meta.com,
 mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Nov 2026 20:39:24 +0100 you wrote:
> From: Jerome Mohm <jrmmhm.kernel@eldare.de>
> 
> virtio_vsock_vqs_del() frees the virtqueues but leaves vsock->vqs[]
> pointing at them. If virtio_vsock_restore() then fails, the driver
> stays bound with a dangling vqs[], and the next freeze or unbind
> passes a freed virtqueue to virtqueue_detach_unused_buf():
> 
> [...]

Here is the summary with links:
  - [net,v4] vsock/virtio: clear vqs[] to avoid a UAF on a failed PM restore
    https://git.kernel.org/netdev/net/c/2a24ba1694f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


