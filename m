Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217430D3E2;
	Thu, 13 Aug 2026 01:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582856; cv=none; b=rldnh7M6rxD/kf2Pl93VOyfLG9FJ1uwLq2440JkFCag9gyTNewCX6TIOoYiXk/2TRm2UHeG9lQt0pu7Y81VZKANEbNR+7dawwvQ5M0MBoRkFzGel+h9hPS8OZUmGBD29xkigrvUMYWx/pC+Z29DA88cOLRupUobR8tkLxCxfSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582856; c=relaxed/simple;
	bh=L0sd/XWrAQ/aG3GU9qfMLBRUQjgi1pYtCBXu8H7grfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RbIjL17SvPCvgiZ1ARaroGDfEHTzTom6FLHNXRs+5KrYySnFE7e33fVuncCpCo0OvqJ9NO/AKWCcRC9LZ/gJGUOvMkVtp1YpNK4ImVYXDSc/Fq/gJcyvAOqd7nov9kV5E++irxXvtkuxUnw2QDI6IOC7puCp2GzBKz0lmWEMfJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or2f3zDo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or2f3zDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30871F000E9;
	Thu, 13 Aug 2026 01:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582855;
	bh=Z1qdc5dzE2Ugi5PO7Tw2p4z1qJ/OJlbg558wHGsrVYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=or2f3zDoydYggF3CbUwVxP05NQ8TLQh+/lIc2BWbvavfghUf34iHzsf/JpVnG/0dF
	 hRnE2KPcdZn2s80Xy84paTkanarCLB8qjWtVZZQ7phlp5+p9BKVmTEZQSNVDhRoTj5
	 kRywOUH1ZIsB2vGCFO4oKurwUAAQfyJgx06be0CSLfpNeX9b1bVTjIB6HfLIbHCuf/
	 pv6avs7UH0rMSmcbnKvKHyFPuI7jezx/ei+kGcL600J/EMFfwjskSIhfcSRyCge8C7
	 u9i2eGlZ/qlvYUfYRUrl0sc8+pwZdk0EsBR9sn2hMz08YSslOqg76DgiR4GyGQQdLB
	 OWzwyMSIqUgEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19802380CED0;
	Thu, 13 Aug 2026 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8169: give RTL_GIGA_MAC_VER_EXTENDED a distinct
 value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178658281064.2171351.14292582236575256726.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 01:00:10 +0000
References: <20260808101941.57666-1-kmehltretter@gmail.com>
In-Reply-To: <20260808101941.57666-1-kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, javen_xu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  8 Aug 2026 12:19:41 +0200 you wrote:
> RTL_GIGA_MAC_VER_EXTENDED implicitly follows
> RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1, so it has the same value
> as RTL_GIGA_MAC_NONE.
> 
> rtl_init_one() therefore sends unknown chips through extended detection.
> If TX_CONFIG_V2 reads as zero, they are misidentified as RTL9151AS
> instead of being rejected.
> 
> [...]

Here is the summary with links:
  - [net] r8169: give RTL_GIGA_MAC_VER_EXTENDED a distinct value
    https://git.kernel.org/netdev/net-next/c/d77f3f016826

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


