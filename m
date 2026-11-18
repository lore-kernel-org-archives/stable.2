Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966012;
	b=KTu5Rw7+Ocjdl9l7CFaBQ0KdPVVPPsqyrVbMFsjkQlibPbZFO0EpoAkzTt5AZF3/p4LN
	 pUNKwkmoAgA0jYYVuy3txVKELXRJoHmlUiBRMyBha0qJobp5J23OxWdrIqOar7MIXyzNt
	 Bxoa+qYHz5gQEv9VRe6ik3chDd3AJ9py3z+kfK2HfiJQjEK578P4M7Y7nYoU5MCbwjfOS
	 5ww8f+CA1grWfad24ihXvZUQtTgDq28M45cQRB0/iodj+5QjN9zJBoAMExA6HgYx5VrL5
	 gzuCvO7fv+OyMF3SJX8vmzJRTjxud+2Il0B3qPDKgKMDbtwIdghkiIOd4JmJriw2XIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966012;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=vL5OkuwMPJHHL+Z18/0s0h54ZXXuw7l3D9zbrrsuyh8=;
	b=I0X2OPNBTE9oqLKovMHaEEwWVOwPXSxY1f0YzG8w4G0xuio7TRWhmk25M2O6kPfiiMBg
	 8QaquE+GBlAYggrHQRrs1my1vqrtxMZAVb/7trIplOPV9TgkHPi3U8y1GWzZzPU/vcmmr
	 1PHSp77reqwYs19fyfe0mCM9tBmd66D2hcAmZOyeppX5kmR9ditvRO5QdgLSsLEOGwbAS
	 GEVq8mvSBqX01+Wj6lDjN0uxK+n70bRrz8MUCxlckJIGAbqJOfRf0ie58DqD3yRAPthSb
	 uBS6g4ANFq4OEEpFvn5yynCNiozzGgbEEc9JFNl0RKDJ/ze8lpr9zJf9cnptmbfy1pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJcDLp4i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0731606A336;
	Wed, 18 Nov 2026 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJcDLp4i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C053F1F000C4;
	Wed, 18 Nov 2026 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794966011;
	bh=vL5OkuwMPJHHL+Z18/0s0h54ZXXuw7l3D9zbrrsuyh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hJcDLp4iw2oGd/z1AxD7ukidBeTgUYwxkgQg6/joHr9oh2ygnCTLm54CempF4V1Pm
	 1lVWFCHbTY6BPMxIkqFSbDSVVFAMqbzSKV5MWycUxlQo+FeR2xvMfuy/NR0s0/GD3U
	 cZFa8bbph0IYQsBErZf1pc0fYVhzRmQmpDXrYXIdH9DLN6eoqEXskF1Quw3JYQARdn
	 9zhmI2l3rkZfY8A+MY4bsBJIIu2Ah2reVJb4kHkMSnzwv3mzWqtwbwYG2uqD3Kfmrp
	 A4j9ppAcww/9exTtHsYUpcpdPqYlqwJBaNmW9+imcQlRZDZ7xv0pPXkeXfDiDtWIGB
	 jDjCOvud7blbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4402392B1FE;
	Wed, 18 Nov 2026 01:40:11 +0000 (UTC)
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
Subject: Re: [PATCH net] mptcp: Avoid unsequenced accesses to jiffies in
 mptcp_reset_tout_timer()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179496601027.1396957.18033061948874182622.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 01:40:10 +0000
References: <20261114-mptcp-wunsequenced-v1-1-707a73a6c172@kernel.org>
In-Reply-To: <20261114-mptcp-wunsequenced-v1-1-707a73a6c172@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Nov 2026 21:30:07 -0700 you wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in mptcp_reset_tout_timer(),
> which can break the build with CONFIG_WERROR=y / W=e:
> 
>   net/mptcp/protocol.c:3044:20: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>    3044 |                         tcp_jiffies32 + jiffies + mptcp_close_timeout(sk);
>         |                         ~~~~~~~~~~~~~   ^
> 
> [...]

Here is the summary with links:
  - [net] mptcp: Avoid unsequenced accesses to jiffies in mptcp_reset_tout_timer()
    https://git.kernel.org/netdev/net/c/728a2abd15a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


