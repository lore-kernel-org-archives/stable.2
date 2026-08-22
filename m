Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB831F9B9;
	Sat, 22 Aug 2026 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430064; cv=none; b=CxV3GY90FTYNVvWGF3oLSZcDvelFpKue4H7JYS0c8i1qepFsO6jizuS7kv13ZkkrBTd7NoQbKHhHgL5DUT46ogVBo0A7lHqmxvJ/vnq2yEg5Rm1Q6xXEd5hO5Xrl3W77qdT/h7DFLaQeWig8ToEut1fze+sQ9cAxNZBI+R5FOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430064; c=relaxed/simple;
	bh=9+1TDBnsG+FWf4XQ7S12IrVYXhoU9LCVr2LL4EjHkVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IN2oxoyC0smpZs8dHV+QGjs/dnJD5NPmBrMeiCw1oztc/8FLZkQaOuRnSDBRPTY7Pnxfk4FMIKzdsuw+4Dw9Sq1Aa7nY6H4pjIuYmOb1IfSZydQn5DMlrV1TnXhDBCVVOyd/Prqf3Oy2CHsg06CQ+C59gcpgLCh+FQzMNgdbZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf8+jqZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf8+jqZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4AA1F000E9;
	Sat, 22 Aug 2026 20:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787430062;
	bh=8k3SUTgoMwy801EzMwDrDdDqa4c3yN67qV9CCSnVI9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rf8+jqZXBL8kDiGAtA5OSKPV4NvnEMWAV6RmXhSf6wLk8MRx24Vms7MGteRhDZy7b
	 InDCus1rqe/sUIrPCTlA+hWUDDvtjSWzo1muwVRtZpI4MS20z6LAkEwSTdGPe+c+G+
	 /8BRh/4wkTttYrR3W4f6bygf9KHnjMNRbFFRsLhK4z4gEoskinbzGWZph3Gc3EkuH5
	 9oQ/Mu5W5CziSFUdE/J0+5cZAy3ttFCqBnkFfjBmesDqowIr+/WALKebG65rXgOrtd
	 cdSKeQuQYuQga8fXJrXY8IQb+UwotiJIe8UdjHfpNWUduE2bn3KsrIBVhI8ro+i79v
	 nHJMSpbcMw6dA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93ABF380CEF9;
	Sat, 22 Aug 2026 20:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xdp: fix zero-copy frame layout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178743001114.1816901.15925905192026012486.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:20:11 +0000
References: <20260818154516.793517-1-bestswngs@gmail.com>
In-Reply-To: <20260818154516.793517-1-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn@kernel.org, xmei5@asu.edu, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 23:45:15 +0800 you wrote:
> xdp_convert_zc_to_xdp_frame() clones an XSK packet into an order-0 page
> and advertises PAGE_SIZE as its frame size.  It allows the copied frame
> to occupy the page tail needed by skb_shared_info and records zero
> headroom even when metadata separates the frame header from packet data.
> An AF_XDP zero-copy packet redirected through cpumap can therefore make
> the skb overlap skb_shared_info or place it beyond the allocated page.
> 
> [...]

Here is the summary with links:
  - [net] xdp: fix zero-copy frame layout
    https://git.kernel.org/netdev/net/c/71283aaa6c65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


