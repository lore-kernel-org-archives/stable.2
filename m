Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CF3FE36C;
	Sat, 15 Aug 2026 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786777260; cv=none; b=YV+6/EvhEJ3cGH5Cl8dR9xYVPJHpAJ1oPF9f+Q52I5HMYIUUALrXd10W5K6lndBbbv7QT7lACnxb5dYbi2CmSvJd6TPVlBYBUePwvTrTk0Y4LOeIi8iKKBysAsvRm/jDn0kpOGMn7KXc8OXR0SW4NpU2id7rvPAup7S/a6hFMJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786777260; c=relaxed/simple;
	bh=6E7jYC6P6iChgo8q1rUcNt0PiVZKtVpvlKmu3pmV8yM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TQxtAmGs0mS4OZCKZ/ZOkNTiGGNUHGaLQKBvrL7r/JtGB/Q9sN4vyc4eLokgMz3GDPL/aQuFiC468vY8Qc7+YR344G8C/ZTX9SI+6FEEFFiLLXGX0gsNZ+Zn6VmeTMHb8iXRNrv6A7nsllUfEKjq0rMjiyrTA70aN9tKtRuLelk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3wbyuJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3wbyuJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2237B1F000E9;
	Sat, 15 Aug 2026 07:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786777257;
	bh=6bIKa1C8YV+phjLwmpOWB9F/COFEl8KOytnsdZZJAcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N3wbyuJIQ4CqRXvxvEocKP02Qs1p7BsahsTaaEverSeVlwU9opIlmpsW04IGKVKGi
	 9zvhk9TQMXvyVmM4nWdztV7J9ISq5qlUHzOOSwupT3tkX5T56oM6cnFGGTfveZIR4T
	 BUQSk23ob0/umlzqXPz8XVn6D9EFCNJtfJgjSaKqLLIA0CfDgk4MzDhXJaEgeK2izo
	 Ne2HCuojFm6Ig7Ibb2JvmhBIR4PRkS4j77sQ1F/U+u3EpYCzSn63GP8BZxi9wjt9gK
	 zvwZ8zw4DvNcJgXbDVyIgq9ac2M18pBUj/N16jydz+04LaSyNNm3nIMDcfziEM2egO
	 0k4n/dPcSUq1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199323924478;
	Sat, 15 Aug 2026 07:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf,
 x86: fix per-CPU address resolution into an extended register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178677721064.4103653.11399150021505971262.git-patchwork-notify@kernel.org>
Date: Sat, 15 Aug 2026 07:00:10 +0000
References: <20260814220254.3797467-1-vineet.gupta@linux.dev>
In-Reply-To: <20260814220254.3797467-1-vineet.gupta@linux.dev>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, x86@kernel.org, stable@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Fri, 14 Aug 2026 15:02:52 -0700 you wrote:
> The JIT resolves a per-CPU address with
> 
>   add <dst>, gs:[this_cpu_off]
> 
> but builds the REX prefix with add_1mod(), which sets REX.B. The
> destination is encoded in ModRM.reg, which REX.R extends, and the memory
> operand is disp32 with no base, so REX.B does nothing and the high
> register bit is dropped. Every extended destination therefore resolves
> into whichever register shares the low three bits:
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf, x86: Fix per-CPU address resolution into an extended register
    https://git.kernel.org/bpf/bpf-next/c/5bbbce02e500
  - [bpf,v3,2/2] selftests/bpf: Check per-CPU address resolution per register
    https://git.kernel.org/bpf/bpf-next/c/f61306e8c98c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


