Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142609;
	b=VXgNUDLlGkEX+R/A/EDAMUwL3lqof0EOJarclma8Q1V3QUmFrnpZK/Yr0NYvarEnLFlA
	 ETEfz/hrAhpbJJ1pvrSQvVTrPU+Cs8Lj163PHLrf7qWb061200B3394jHG7iiBBTTJEdF
	 wno6Mc5RQukjeaH54VsexKl6Yt/YaOMjiEhgUhydg2VjNioAfMfPHnQuJTmn63a93xGbi
	 vHMJsSDuHrBSDJfTK5GypHOkXK+5fgTN9dwKPrk1eKpU5GlUazD9ScCqCGep5IqlTpqtP
	 CK/iu01PQKyJzrpenfFCxjKIVS401PN3HFb7TkXuUKckIrkVl26Ns722berOtacc6jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142609;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=aEYfgo0ajs1aVt9QsidrjQR2xD7y1in8x7mxlipZLAg=;
	b=RnCISxpDZAUXQa5bhcPv3k0QaImw3z2YeaykXmwQ6CdeW6mQ0YzRVKT5cJP7Omvpp6X1
	 MlctizVxTrVZCPDQYFZ6qGzB+EJDMRuOb2d9X4wrRDj1jBp06hJodKoTol3WNGY2BwcjU
	 FjXbgRdf/9m+C9QTpBVK80jD1Ey6kzXoOnSulc7J77YQLfT4MT0cht1f2BJP+zJENxPMe
	 LSKttIAyIhY4rRKHtoB0zNOQGVUU8CXYpUrJEYUG8v08cyQXvX+piXl2dPc9iQ3ykTgDa
	 5Ygv3qJ7eKIhKwij61ZHkHhJCpDM2j57iQkqENylC/fU4IH7IJOYUXALj3Vs29XAsxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7GfFskg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD16606A32C;
	Tue, 27 Oct 2026 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7GfFskg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF221F01825;
	Tue, 27 Oct 2026 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142608;
	bh=aEYfgo0ajs1aVt9QsidrjQR2xD7y1in8x7mxlipZLAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l7GfFskgIUa/eK56s5lGK9tbpkvOxu5tbSAD0Hak6CL4ik+asgg+kouXzQ4S10sZ3
	 PBOkynXcEi9/UHmAJ54RCI9ftoIlon2TtxtMfqEfKJ0lm39NcHdyNmPKAxfZXh1QRF
	 C/aZ0gIFmMlS+VK8kGyY7J4Q1y9wyOV3PYR2DQw2G+GWAesNDp1WfvV762ReGaj4Nt
	 NorlreBUdCLNeVXtiQ0VwzxsX0zHC7dkWNgz8rt3evv89I26Ec6XV2lSw2fgMpikpd
	 CYHkyB5LiFr4f7w6sTiQdXWyjfqM4dMjseorIjhkrLSsBSttQkOX2N5PTxG21QHIE1
	 BOESdoXgNn2YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 446893AA940D;
	Tue, 27 Oct 2026 23:10:08 +0000 (UTC)
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
Subject: Re: [PATCH net] net: hisilicon: hisi_femac: Stop the receiver before
 releasing the RX ring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179314260682.383254.18077445716959126506.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 23:10:06 +0000
References: <20261025182022.2959333-1-mmyangfl@gmail.com>
In-Reply-To: <20261025182022.2959333-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shenjian15@huawei.com,
 shaojijie@huawei.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 lidongpo@hisilicon.com, xuejiancheng@hisilicon.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 02:20:18 +0800 you wrote:
> hisi_femac_net_close() frees the receive ring while the RX address queue
> still holds every address that was pushed to IQ_ADDR.
> 
> A port that keeps receiving then DMAs arrived frames into buffers that
> other slab caches have already taken back; on an EC6108V9C (hi3798mv100)
> the queue still held all 52 armed addresses right after the interface
> was closed, and had dropped to 43 after 15 s of broadcast traffic.
> 
> [...]

Here is the summary with links:
  - [net] net: hisilicon: hisi_femac: Stop the receiver before releasing the RX ring
    https://git.kernel.org/netdev/net/c/d54b21d82430

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


