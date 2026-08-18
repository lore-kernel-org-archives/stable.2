Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD1B33D6ED;
	Tue, 18 Aug 2026 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044855; cv=none; b=q3cbGBCQ51F7gtjVEFYdap7i85d3XXDcBaUVTkv16d/nXkpoip0QChhVYjhpl6yUAQTLNCCiltxIg/YMtbQcESs2HPNeDnkkHgUoPg8ovdEcOVQ40CYCIbKi1vE8d9ZeCO4aWs3MKZF6ib8MnBglK1/5xxmhsnJ6ktwzMzdGf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044855; c=relaxed/simple;
	bh=ZylNTg6+HM5BLlTsVc5TmRKZMlfz8OtnC801+0Vk62s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E8r4629g/goNqkp0YH1r4cHRpVXBC0ISSlIJCvKUa+MIrAi5IXBz+dpdBKj1YQErCGdRQghdZkfKR66C3AJKyz9hE18iaD0fpeLuY4ZOsLYMl5OdUf84lBydxepTsD6Xr+Yq9UT4MeesXRm2EjRJ85bqcRBMitw/qqrln/uyFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXaEq6eg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXaEq6eg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B90C1F00A3A;
	Tue, 18 Aug 2026 09:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787044854;
	bh=pHv2Hx+LQiI8XnBzJl3aTm8n04fW2yMOaY2HMM1OQ70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EXaEq6egOFVUYrR5HnjLcVq6MtaDT+uI0C++5o3sxx8ZVifTVFKqGgVaQ0nXmZU2o
	 3AwenEu0dAV9WBkG5HQ6JO5noqXn8yJIAEv8DcJtJ699yMSwy8LY9tJ/mf2GHnB13X
	 kOSLcMcoDhO9Mxcizp+VrcK6E1jqSNw4np8TRZW8jSgIP3JrkS/vopxVDxf58GpggV
	 Y1qGyEUU28myG1KAIZavn2rves/CZErzYCSqFY+CHXGoyor/WCBS0IiATwW9V2+0hx
	 4bZX8FwkWRWaIkzIP6jdxdfqlVPy6bQNGMjKNAfpJMRtpnQm/PsDvnU3vaM8ZiMHqk
	 +XiOtrxLu2SVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987039263AF;
	Tue, 18 Aug 2026 09:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mpls: reload header after pskb_may_pull()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178704480565.1975811.9540207161896507600.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 09:20:05 +0000
References: <20260814095404.7205-1-a0yami@mailbox.org>
In-Reply-To: <20260814095404.7205-1-a0yami@mailbox.org>
To: Qing Ming <a0yami@mailbox.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, gnault@redhat.com,
 sd@queasysnail.net, dsahern@kernel.org, rshearma@brocade.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Aug 2026 17:54:04 +0800 you wrote:
> mpls_select_multipath() calls mpls_multipath_hash() to choose a nexthop
> when an MPLS route has multiple nexthops.  While walking the MPLS label
> stack, the hash routine caches hdr for the current label.  After finding
> the bottom-of-stack label, it calls pskb_may_pull() before reading the
> inner IP header.
> 
> If an skb is constructed with the inner IP header in nonlinear data and
> insufficient tailroom in the linear head, pskb_may_pull() calls
> pskb_expand_head() to replace the skb head and free the old one.  This
> leaves hdr pointing to freed memory.  The IPv6 path can invalidate hdr
> again when it performs a second pull for the larger header.
> 
> [...]

Here is the summary with links:
  - [net] mpls: reload header after pskb_may_pull()
    https://git.kernel.org/netdev/net/c/29e63b8d9fc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


