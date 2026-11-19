Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046406;
	b=vPQbj4KEcg+Aax+RPGud9eWQCY5+neRDuMcTpPS9WZlGXUbMaab07u6bN7hNXGsE+qn5
	 KecpHxXyvKRjfFf6mgLLhu8VKSx9u/1/Qg0hC38x3v21EunwYCRJLu1bL6V9gSrBEH937
	 jw5Wy+y/InrRQMzi4Q4/Kyhs2DmWVtpSk5U8NsQnUvOx+sapauaixZmkvB0kIEYQ8xI7S
	 66EJgu+Pm0U/xV6caWrBdVKzbgdkXNA2ealnS8VOw/nlgqP8uuTt3+RD0rTijECVlfWMi
	 QG3SUuscCsh55/FDunPZ1Z1pe5iO2V85m1Tarug2yrfiVC87qF7AzJdLyoOYGwR4jIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1/9FVMg6kywcce5P8F50oXpupxOmDgZiF5njySBM1es=;
	b=wkXsqOSZHgpEiqMoIIPs7lxqJUPPcfcZhSrS3bLz06aACEuevSTNomUccbcRkxOIvcBR
	 A6m9qR9IDuHxdR+E5BS70n5BdUK7QfwY7al6yKJY+VoYNKIWoUZl+MOVQnXyGljCvAUqi
	 2Oo9JYEdcqoktwUMjND78r/DtynxpLyT1GurcZBXF1IJ7OHiaaUSY1yMIUXNiWXoeQtil
	 PoW159kserNw67SfaGMuty5IxKq/+8AgVuDUblgJSkvJ6N1zJUpqIe5fY5mYAwNMxlVqh
	 njQTitKJWjQM/l6OszfwWn/JEis+tcyZlYOlbXVE4aH+d20WGAJAj7FptGkg0QaW4oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fA+aN76e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2ED606A325;
	Thu, 19 Nov 2026 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fA+aN76e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F1C1F000C6;
	Thu, 19 Nov 2026 00:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795046406;
	bh=1/9FVMg6kywcce5P8F50oXpupxOmDgZiF5njySBM1es=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fA+aN76eXvZMhSHhMmaricbYXvgI4y198sLkyXqF54ORYmglTp/wE9V/2Q9J85OKD
	 gAY0l4YsEKQtbpzCBnLrf/qSVwv1v6yHIYSma/ad6Jdch8HHTB+N72wU71eso8pvwn
	 omPS9C0HDlhHBRmWsIhhbFhNqHn0uV88TI42f4Aef6jtQMBgWRT+lWRPwGbZKijFEa
	 e1i3ZMmiKZselfoJt6quqfCnesypkmzrB6SNWC8uJuEFksWfX5sfQ/Ch+MYBSpWewz
	 rgSQGWmKOcg0pv6YEVY0tzwnCB3W9+/8BTFuRI/cdAI5hAvbMjfkQ9hBXEgR9A90pQ
	 tkHrwZB9XG6Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7730F3808210;
	Thu, 19 Nov 2026 00:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net] net: stmmac: drop the rest of the frame when
 napi_build_skb() fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179504640528.2628008.5659141402667774044.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 00:00:05 +0000
References: <20261113-stmmac-rx-skb-fail-v1-1-fcaae89f2d2c@gmail.com>
In-Reply-To: <20261113-stmmac-rx-skb-fail-v1-1-fcaae89f2d2c@gmail.com>
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 Jose.Abreu@synopsys.com, lorenzo@kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lorenzo.bianconi@oss.qualcomm.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Nov 2026 17:13:40 +0000 you wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> If napi_build_skb() fails on the first buffer of a frame that spans
> several descriptors, stmmac_rx() drops that buffer but goes on with the
> next descriptor of the same frame as if a new frame started there. The
> rest of the frame is then passed up the stack as a frame of its own. A
> frame spans several descriptors when it does not fit in the RX buffers
> of one descriptor.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: drop the rest of the frame when napi_build_skb() fails
    https://git.kernel.org/netdev/net/c/ece404eac250

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


