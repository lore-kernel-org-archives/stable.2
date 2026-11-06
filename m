Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956206;
	b=eTjVW04nkHi9vRfS7dz6pofpHujuLT3IbO16Ad1o0natEI6GMh3+LxTpEvb5KyjvzMlP
	 GENe8fVPe+7x/rYX8ywwfiZ+rPDGY9Agp0IVG6x+2ybV47fmG/wENEBZXyzYZknNR9h96
	 +QlhbmoB08tUX8GbVvJCIyb4d2H15siiF1VorgccK2QVFQxPplnN4gFHcL1WwFbwFdgGN
	 kkwW3esUVbSiXptWECxgiVcSko+E72J+MhkswGQiXx+6thOb75z6LbhVnBtkFxVtZ8+Tq
	 JFUJG9sX7Ogm23tv6XIkjiRDxSwMV3PBEuXzOaHYpgXAI/CrKey/dr124Vsy/rJDySg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=WT7UUO2qRTyZeJPJSJo20gRPQbQTkOuKSKT9x7Ux1m0=;
	b=4C3W6MkhorUJ/fsT6OGAjCNZ/CuxlxZ89B+Yg2VkrTT/WkTWY+6qlUWWnHFyIZwVZPnU
	 QoRbog8SScR3iwufBigd5UVohh97TrCX2T4aa081t4Cv6Q+veiXtDus+NG7s9Lxuotl5m
	 p0AKs4XAu2davi0q5lUK4uFoVLEAfXcBKu0MKe1EL93g/2VkJAdiGcXHXKjssJiHE7t7M
	 ic+TDlKvuiFRd+stH55w4ERq+fT6QTDmfvFmmRY1AFwNqS48/iOHaSvoXYFtZc1sVtbUE
	 SKFJDwnrrsGSOsfCFun33wO3v5DfUZwmRd/eicNFAlNc0E4AHFUMd6hqI8XISiYnTNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYxmEhe+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893CD606A326;
	Fri,  6 Nov 2026 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYxmEhe+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D22E1F0089F;
	Fri,  6 Nov 2026 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793956206;
	bh=WT7UUO2qRTyZeJPJSJo20gRPQbQTkOuKSKT9x7Ux1m0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dYxmEhe+4b0Ast43BVBf3uxZiTx8LwFtUI3T/z/ZQ8feeJBSVpkH8VS6tGSWDRml3
	 2aW+wYepKNJeqPEdwyAHN7ge+TJwSGynvpsJ3Jn52QptML1DPcScBosLoXZn7mq8pA
	 iBhx3sgCQWv/HcbpXr8/vxjqYfZt3WkiG+YxIkvnaLCVdZOOdJWoUtGE99g0tCoQYU
	 +4J4D6X8wTeL4BPTxqAkazxNcliknJrsCy40rq2lZXE5OOmkFftgp8nQw3HGLhHtxa
	 8B466rW3iifOaQ42Z9wHgalPDM5OKkWJXm9v0PIRueulr5ijWXwY09Mhwq3g9+dhvB
	 g4VUySpNHb5ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2102F3924475;
	Fri,  6 Nov 2026 09:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net v2] openvswitch: advance by the real header length in
 get_ipv6_ext_hdrs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179395620493.468896.4953310434961799726.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 09:10:04 +0000
References: <20261102-ovs-exthdrs-v2-1-21ceef6a243d@gmail.com>
In-Reply-To: <20261102-ovs-exthdrs-v2-1-21ceef6a243d@gmail.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 02 Nov 2026 01:45:35 +0000 you wrote:
> From: Joas Antonio dos Santos <joasantonio108@gmail.com>
> 
> get_ipv6_ext_hdrs() walks the IPv6 extension header chain to fill
> key->ipv6.exthdrs, but advances to the next header with ipv6_optlen()
> whatever the current header is.  That is only right for Hop-by-Hop,
> Destination Options and Routing headers:
> 
> [...]

Here is the summary with links:
  - [net,v2] openvswitch: advance by the real header length in get_ipv6_ext_hdrs()
    https://git.kernel.org/netdev/net/c/dbce972650ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


