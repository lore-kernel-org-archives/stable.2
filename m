Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629607;
	b=dAQknozzccIZ0leXfh52PpCnlpTfxkqmeI2fG1f5T4LTRR4acYku9FRu5Vwe7fvs140W
	 R6lDFe5jxQ7vxrlkI5JVBlMFJFEqEhyaKzXiW85UwXGL0SEf/CQqz2x4eZE2fqkJrLkae
	 WRQZWO62SPj01NWdl73En9TR0/8OZwxgnss4TiPpLxBt1ECGujt19iG4Y5tGMy5VIYZKW
	 w5bP4JjILL7xTSCHSvxZeq0WfnCViIeW03ktuipLb0F3dCUseDcgP02gi5UO6BfyXBtBf
	 LazYoW1XPtIIlI86By1riatI2wxQCnQFUrPfWZat04G6HJL+RukEtNrGcBggjPTLq7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=klp9h556s2dmmsj3dIxpAq/gnwvQTRBEk3BCnmqimjQ=;
	b=2Az4PCP+z1rcomQWG+gjaBHVCMDepp+Zd/MWHKyp6l26cBBdVrLI38o+F+uxXDqcayXg
	 vUFxSp3eMvEMZdGR825JsrJF5w8HGG4aqJSfHKzhyGddp6q0tQu18yocOCBeTqx02Usfz
	 8xAnbV/VWvX2ZfXj+LiIUZWqth4AI5FhIsPLqhRrKEkM6RdqhmOtIYDpZvE/ZHfwde5T9
	 1a1tNFNmnMlpW++jtO7kdVJHko5Z2Up0pgFUpifsIZFamdT/SmLoMFTTImUH/Frd/6Hp7
	 aBDBuQW+/E9FSXUqzX6YNXlcf30yBy6AyipOFm2NN44UXS4Wty3HuNMz/GMtPxkjZ4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJFzU+j+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3CE606A329;
	Thu, 22 Oct 2026 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJFzU+j+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454691F000C3;
	Thu, 22 Oct 2026 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792629607;
	bh=klp9h556s2dmmsj3dIxpAq/gnwvQTRBEk3BCnmqimjQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dJFzU+j+Ojm+kqvGzgUK2upk7XOosNqQ94rKuHbC/83jXPCXYbs+NQ0lBxzU7ASNG
	 d4Q0DdTUoMcOHtaij9+d5vomwQziECmWzWbfV9VYCuFSuOfdqAfFpYPyM23ilptOgQ
	 KRgAjZSgisgLW7NOlaOdFENjJh8MXkU6ReR0NpSgcW2RbnXzrK4LfMyOXj5LLsHnFn
	 yJov5jaerk7Itxzb/GK379iEtVoOT+P2EtHpVFfnGQCyD0r7zBGOmTGpV7tt8/a3BF
	 zcAgiDX24lSCek+kgZNMzif9M2o9h8QTaFtd7QgKYaO5wU1F1lTsryHwmd1buNOh/U
	 r3SdULZQdCUgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A385380A963;
	Thu, 22 Oct 2026 00:40:07 +0000 (UTC)
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
Subject: Re: [PATCH] net: wwan: iosm: validate msg_head before indexing
 msg_ring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262960577.1381785.17602246093034540225.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:40:05 +0000
References: <20261020094254.4017726-1-liuc63@xiaopeng.com>
In-Reply-To: <20261020094254.4017726-1-liuc63@xiaopeng.com>
To: liuc63 <liuc63@xiaopeng.com>
Cc: m.chetan.kumar@intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, fangxy@xiaopeng.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 17:42:49 +0800 you wrote:
> From: Liu Chao <liuc63@xiaopeng.com>
> 
> ipc_protocol_free_msg_get() reads msg_head from shared memory and
> uses it directly as an index into msg_ring[]. If the head is out
> of range, the subsequent memset() writes beyond the message ring.
> 
> Validate head against IPC_MEM_MSG_ENTRIES before using it as an
> index. The ring is a circular buffer, so a value outside the valid
> range indicates a corrupted head pointer; report the error and fail
> the allocation instead of writing out of bounds.
> 
> [...]

Here is the summary with links:
  - net: wwan: iosm: validate msg_head before indexing msg_ring
    https://git.kernel.org/netdev/net-next/c/46cbf85155e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


