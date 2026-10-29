Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274006;
	b=xidZZl4iLRXovar+GNQqQVrSIw9Axd7YcwbawXh4qZcAysfPg8KqocLDBrHRoE7iIqcm
	 DrgTuYVH/oREvCoekM49qM4Nsj1KLzzPH5HjTLR7bYwdwAB7BZFgK4jeePLp0TqBeOZXM
	 smVqJZtYrQ4GjL7JwGwXFAywGGPhvX3Uo7KLUflr/CfV/hOwJw/uvXkkbduRPpDW8fsS5
	 yklcKuZHBu0T27BsYtCi3vO8cjim220mP79BHjGqHQ9yGAg3ZdNegO9SoYTm1COaUumWd
	 u6JR4qTfafbUg4UBZyXW30BEwApCOkCDtIJuOGg0T8UB8qfq5FvyUGe8nskWe1DiYAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TBOcWCeRyE09SQV0o/JzcTqZh/y/wDE6C2jnFIHWhYc=;
	b=bz5Be9sLlUbq20JDLxoO9VWjtTN5Ts3/EqucVpfPRoP5d0kzWDTuwXMsRfvkesv38wsI
	 +ROy9qiLMdIE6ARz3Hil6oTfl0dZXX4lqLAoHsIGV2R7lLv1Hxyq3G0y0swlnJVGi+AM3
	 Vlbzm2uWuNQUnu1p8ioR8ZpeDL8xge9c6ZEhF64u8CfDNTBuRFg1ZqyV3/nmNWVJXAeQF
	 3mJTPzglT1k/SD38eDiBet0XLKCFkflcq+rLA/7zoRbEXHcSJRnWEq6pz23qTAV4c9THs
	 OffxsePIyOm8FzTg/Y6aOEGpqJerDDNqY7cC35qP9LjZ8pqAlS6Rj1n6D2nZeoJQRLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebtBqStV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDE9606A31A;
	Thu, 29 Oct 2026 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebtBqStV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4C01F01825;
	Thu, 29 Oct 2026 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793274005;
	bh=TBOcWCeRyE09SQV0o/JzcTqZh/y/wDE6C2jnFIHWhYc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ebtBqStVzefn5r9pL2B+YSX4ivaLjiFbAjHRIUHa2j1ZiKtKCxtR0PPeDxwshLvfI
	 twUW6jLLjNClS63IE2sZCth9evRZSucCjrp0ZjLeNf77IVmqfsMNYUalKVtrQaWVOJ
	 UVoHQYr0SIsTLn7DbM1Whw1E7C5/+ORYBBWcF7rBcWPpg1HeAsPqnud/PQB/VowmzS
	 kzLacAKFIsJlh3SJ/5v0LAevl/LmMwzsLl9sl5Y6vvQvqhH/zz5ew6O7tb1S8fY9bk
	 TXEC/rKGM17E1Vna76DgkbMZhJIrElH+XgK7i84kmlT6yuGYpdcUPV4prYboEF34vT
	 kAsfI6IhHBXCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE5323ABD290;
	Thu, 29 Oct 2026 11:40:05 +0000 (UTC)
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
Subject: Re: [PATCH net] tg3: Invert restart quirk logic to restrict SNP
 power-down bypass
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179327400457.1773334.15430060848515366036.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 11:40:04 +0000
References: <20261026220955.473247-1-noam.d.eliyahu@gmail.com>
In-Reply-To: <20261026220955.473247-1-noam.d.eliyahu@gmail.com>
To: Noam D. Eliyahu <noam.d.eliyahu@gmail.com>
Cc: netdev@vger.kernel.org, pavan.chebbi@broadcom.com,
 michael.chan@broadcom.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Oct 2026 00:09:56 +0200 you wrote:
> Commit 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
> bypassed `tg3_power_down()` on system restarts to prevent reboot hangs and
> NMIs on servers where NICs were initialized via SNP (such as Dell PowerEdge
> R650 and R750).
> 
> However, skipping the power-down flow globally causes the ACPI _PTS method
> to trigger fatal PCIe AER events and hangs on other models. Commit
> e0efe83ed325 ("tg3: Disable tg3 PCIe AER on system reboot") attempted to
> mitigate this by adding an AER-disable DMI quirk table. Maintaining a
> growing list of models for a secondary symptom misses the root cause,
> leaving systems like the PowerEdge T440 (sharing the BCM5720 NIC) exposed.
> 
> [...]

Here is the summary with links:
  - [net] tg3: Invert restart quirk logic to restrict SNP power-down bypass
    https://git.kernel.org/netdev/net/c/d7314b51341c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


