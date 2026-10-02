Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E127FB1C;
	Fri,  2 Oct 2026 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905212; cv=none; b=AO5BL/xrjy7Zz2sxBU1HRMcdHxkeR5aNkkOTt5mCijH59AkP5nIeDdVGw/dxdkJa2A7VipbRf3dR4FX+ub2nyq7Ha4TVZfoBAqTppJvXLEUK7F5Xcp74RkqEQWPl7yuRiXOB8iN2a1lKIhCRWzL6Nxeb3RTaq9cSGn9l6n8wtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905212; c=relaxed/simple;
	bh=853QzxYt1EjXInLKdTXErNVw0NI3FrCFOiYgYw5NpyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UGAbajMz7JquQZwfduV9RlOJIZIHA6PMPTUShJt6VhrtXMaw5dm7Cx6BOQBGyWZ76UI4UsXDt1VjdixlO4XtCUTGUIFWZntCn1VQEZccAurTgxWPPNIUOZ3fJQteUY3bbdDBmoAbeTPGhIJJNzQiAAVkFP5Xk3AApNBraVeeqkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8DcqfaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8DcqfaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE9A1F000FF;
	Fri,  2 Oct 2026 01:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790905210;
	bh=X7/nyTHa2/+dLr1halIHM4WAUDbQKiN52oJvoOCum2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D8DcqfaBBt1W+XBrHwJFUHXDKHWnFoWqw8nkUM7UWXh6wnHNeYG9Q1hW+YuM5q1VO
	 +ZT3Dm6pVxxxpZYY35jq4N4qxTj8c2oZYvmauCexlisP0MSJCpNrAEyjdtipo/i+VS
	 n/6GdNy/NaG10K1vip0pQ/RnIho+JvokjWyGvFdKc4kx6QfAjPdu7sklhG0PH1za7y
	 q2SZALKa+fUGPTLC9LUesb/wjfwB5jqyF8qiXdPT8skITwPZnouWFW9z4z4BoE+vgD
	 CneM4eRvdxuPScU0oP+aWabLRbEK0P59ghfuqfRuD3g7w//bvtdnLYWoMWMZXbh0/b
	 CgTXlmfBfuIrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4607381197C;
	Fri,  2 Oct 2026 01:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net/packet: guard the ll header push in
 packet_rcv_spkt()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179090520927.3173528.8266337097472483332.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 01:40:09 +0000
References: <20260928113108.2127215-1-quchaosheng000406@163.com>
In-Reply-To: <20260928113108.2127215-1-quchaosheng000406@163.com>
To: Chaosheng Qu <quchaosheng000406@163.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mkl@pengutronix.de, socketcan@hartkopp.net,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 19:31:08 +0800 you wrote:
> packet_rcv_spkt() restores the link layer header with
> 
> 	skb_push(skb, skb->data - skb_mac_header(skb));
> 
> That subtraction is only meaningful when the device actually has a link
> layer header.  packet_rcv() and tpacket_rcv() both wrap it in
> dev_has_header(), which is also the predicate the block comment at the
> top of the file states the restore in terms of; packet_rcv_spkt() does
> not.  commit d549699048b4 ("net/packet: fix packet receive on L3
> devices without visible hard header") introduced the helper and changed
> the two call sites, and this one stayed behind.
> 
> [...]

Here is the summary with links:
  - [v3,net] net/packet: guard the ll header push in packet_rcv_spkt()
    https://git.kernel.org/netdev/net/c/28bc1ef69961

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


