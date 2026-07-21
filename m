Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F946D2AA;
	Tue, 21 Jul 2026 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652637; cv=none; b=KpWc86xVlVduV4ohcALU+SQpr+5Q0gyNdlOMpB3EkMwDFL9q3BYbs0gooqoOoLVOtwuSZJhjke0W91/kkQKYtN4Nv7iEAx2uSzr91NqkwC5bS1Sd+/0FE7WZrg64NT2387WPbq/nibSlH0O3PQaVGy1dohtqYXE5uv692D/3uQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652637; c=relaxed/simple;
	bh=x5UXAZ9QERpg4LYeqQuXt7kA4KbUb5I6NrayvIGgDuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KUdkky43/yGQpmdaA0mZuL/fzyu+ztRgCn9AljBwdHnFKBJkYD6qxlF/NDw6heduv8pUPZpxalTi3eV5E1DQRBzBYhiLxYvzEPMEi0xHuyJwtt7VIB+SEACR3Sy52r6EgRN9aUTHN2TyJZ5shgqocLIcg+0a64+dhkUXLA/nQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jea8m3++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jea8m3++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133361F000E9;
	Tue, 21 Jul 2026 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784652636;
	bh=1WST+8i8vmtdFREG4LjqX6DoxUJNBpudLQ+NMk06Ly4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Jea8m3++ppL5UFGy/2P3XSP0dp8UAJYXfaebnIpUCXWcb7Vta/yWNjDkcYUMqSEcW
	 7GI1MIcdMuQ/dCH7qH79UoCq9HrmDnmGxMrrf4epm2y3JlzY2hryBK7lHOrkr69tFM
	 lek+rWZmF/znHPKb9XGZ38lnFrCa7oGjUT0Gy9P2tAd+JmvX2eEvsjxL5NnWl/SPEy
	 YPgxO0V7iiTF4FMJllgqiSUzSRjOrOnN4i7Dbwwk+zvBw9Uhiv7N2ZA+Jha15xg6ix
	 8T4tttocduHYePuJVrKubTYdDsaNebmr3q5IpibutixNpNdhdHj78FsxslnwptuDYq
	 BRZL5S/WKnXCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D15FC39253C4;
	Tue, 21 Jul 2026 16:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] veth: convert frag_list skbs before running XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465260565.839953.7972365481675163007.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 16:50:05 +0000
References: <20260720140545.461747-1-matt@readmodwrite.com>
In-Reply-To: <20260720140545.461747-1-matt@readmodwrite.com>
To: Matt Fleming <matt@readmodwrite.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 lorenzo@kernel.org, toke@toke.dk, bpf@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org, kernel-team@cloudflare.com,
 mfleming@cloudflare.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 20 Jul 2026 15:05:45 +0100 you wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> A frag_list skb can reach veth with data_len set but nr_frags zero.
> veth_convert_skb_to_xdp_buff() only converts skbs that are shared,
> locked, have frags[], or do not have enough headroom. It later uses
> skb_is_nonlinear() to decide whether to set XDP_FLAGS_HAS_FRAGS and
> xdp_frags_size.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] veth: convert frag_list skbs before running XDP
    https://git.kernel.org/bpf/bpf/c/c3e0e81eec96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


