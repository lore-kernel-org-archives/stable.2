Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887809;
	b=bckYPhSeHd1RgKrIFJXq4tCEk9MdjzFyFKQdmsdG2WvgSF6Icd9aZGmZjruHiUNPsJUe
	 IL6HpHrWl1GZhMMcyIhIOGiAt3j6F+hAEBCCExxTtOOsNWQs29Ho7hxDCfQfG1kt3UQq8
	 V/cazQw65rvDNA7uGiImuScB0K7Q7O9GIZTKre54dnKygPq/fOGNnEQ4Viez8jglnI+d1
	 d3fJA1vCW9GLSb3rdIW0FCLSCJtHeRFpYg8IvXETtfV0HmeiG7rH4/adSr2pCWH0znkv6
	 uuA+pTOKXn31fhAygMHFxeUqeI7TW2BzUHPRLrLpirs+4lmoRPktogetLAw0pSnVgfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Xx+Vfh7jrF1gF05UlkMCvhnqxtebQEJe8YY7pG2KVRQ=;
	b=4b8zXWK6EHz4HoIRVuqBfrPjS7ZnKKtf1rNMs2V5m7kLbJ9DLQG1S6IpZK0v/3sAI7j9
	 9o++hvu0UlwYqz2XCmqz1KmA5g0UOIMhm/BZBXmZHlrrafVtgEOmGxsPGX/GFp93yH6un
	 +C9heKsI71A1hQnxaZU3AZyuj14lMQQT55JhDtNPvU/ujozMlKXBiaDQ01HrTj0JejTi4
	 pGV3gACxFa1u/vsmgn7kAPGJhMr/mc1dCGfw2zoTBg5wiJ5cbYrgAxZZ/6kU0eWyPpF9m
	 jWmf8aNDkgZ02xBHxaSwS4XnMnk7Fp0XrZU9X5GKmCyUNrF01CcGTk1v2VEoLGL5unw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fuZOjHBS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4C6606A337;
	Thu,  5 Nov 2026 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fuZOjHBS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EF01F000C1;
	Thu,  5 Nov 2026 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887808;
	bh=Xx+Vfh7jrF1gF05UlkMCvhnqxtebQEJe8YY7pG2KVRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fuZOjHBSN0waoccOPH10JIUAKsxtKMaNyx4WxthifG6/OvvyN4P+0jmSctffSAItf
	 HQm2z7UUbfW6At1Ljj7e4vayJ9N5CdF1uhSu8z4HLzhD1f7tKQy6s8nxn5QxFx18yF
	 8m2mjT1uXkupkko6AIXvMS/v+XnZRAcEAUuztZXdF3bmcjD6s51GduX18GAZpQLJcd
	 wJG5JB+GPcZti6quyLeGNLoT0qWwfvj8WVRmYPgC4icfo2xpGE3Q/1sZ7jCPTKA7eg
	 O8YC2rYIwp1Zz95VdtqsP2Pb5aO+21C5Arx91jCPfNRtjnsQxra4m4ic2w4LFpTlMK
	 43TjxqPHGEBlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 58E9B391AF93;
	Thu,  5 Nov 2026 14:10:08 +0000 (UTC)
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
Subject: Re: [PATCH net] mptcp: pm: kernel: use RCU to free endpoint listeners
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179388780704.3729553.7318793746811801977.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 14:10:07 +0000
References: <20261104125327.1041456-1-edumazet@kernel.org>
In-Reply-To: <20261104125327.1041456-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 horms@kernel.org, kuniyu@google.com, netdev@vger.kernel.org,
 kylebot@openai.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  4 Nov 2026 13:53:27 +0100 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> mptcp_pm_nl_create_listen_socket() starts the TCP listener directly
> instead of going through mptcp_listen(). It consequently misses setting
> SOCK_RCU_FREE on the parent MPTCP socket.
> 
> tcp_child_process() can invoke the listener's subflow_data_ready()
> callback without holding the MPTCP parent lock or a reference to the
> parent. An authenticated MP_JOIN racing with endpoint teardown can
> therefore access the parent after its last reference has been dropped.
> The ADD_ADDR error path can also close an already published listener.
> 
> [...]

Here is the summary with links:
  - [net] mptcp: pm: kernel: use RCU to free endpoint listeners
    https://git.kernel.org/netdev/net/c/49b09ae0bf57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


