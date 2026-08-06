Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C813329E6C;
	Thu,  6 Aug 2026 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033249; cv=none; b=UrftjdxpKpKIR+gsktCvUYRddtpGPaedNBU3dmxYGWKXfUvr9teZXYfqwLfQHCTSNTqLB4XvdTMGDlbsHYt3AYIe98J+kX81oqx+phvPvL7gx+mJTg99zq4e2tBFwCVOg83eYN3f4JEE29I7jDqEVtL3gqH+FXuJQOeQLVhjdGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033249; c=relaxed/simple;
	bh=VWI0LvsxHtOxI18cYl0A8R98KMnt+NEfyqzgWKvdkG0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PLO1AdzD6jCvWgXlUZpysPlNaxoizo5OzWQGcj1VW4V86CDhUCyEwWTQv4k6bwYztbQL/DHR52pseSLKT3o7ukwUxfCO9FRiRUPVoZ5jLxSoj6LBlwplQkIlwGfKaRKqQRlaVnS4Ioo2YMdQsAzfmhqyYuyG395o6Ic9Ulea9DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCftY2vS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCftY2vS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D938F1F000E9;
	Thu,  6 Aug 2026 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033247;
	bh=3wfwuJaizB1Ax1PGyBXIlHHtOtDsrvFHRb1n0WbrUJ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eCftY2vSSvtmW2OfQQpjSVtopchkz2PIGxHKnC+KGZZ1jKmQ4SHGt4r6zrUAtl86h
	 fQdJJ9PPYFAmgWGwrIoK1RXoVMe38lcJVqpxSGJXS8w6u4dopK4Ewp+ZjjaR04Umft
	 yvMA60vC1+CkEChN1htnjVfYKlcamDERXSs80fvoSZVQOX6zXIgWtdKl8i66/Ux/O+
	 czhpJooQMmKUPxpnrtI2YA1ORS7jvLHdXgXPdjspt7TuROX5Ci8TRAH7hDuNIaECE0
	 ibVQXJd/WhsKw+0Td/x3xAU3glWzKuKU/rjMWkMZBWgPICXfsdJqannbRNo/Y6BB0K
	 SsJuUVc7OggDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56811380820D;
	Thu,  6 Aug 2026 16:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ptp: ocp: Fix board ID over-read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603320714.1362900.13898682738421551895.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 16:20:07 +0000
References: <20260804210751.48248-1-ahmadexp@gmail.com>
In-Reply-To: <20260804210751.48248-1-ahmadexp@gmail.com>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 vadim.fedorenko@linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Aug 2026 14:07:51 -0700 you wrote:
> The EEPROM board ID is a fixed 13-byte field and is not guaranteed to
> contain a NUL terminator. Passing it directly to
> devlink_info_version_fixed_put() treats it as a C string and may read
> beyond the field.
> 
> Format at most OCP_BOARD_ID_LEN bytes into the existing local buffer
> before reporting the ID. Use a precision limit because the snprintf()
> output size alone does not bound the source string scan.
> 
> [...]

Here is the summary with links:
  - [net,v3] ptp: ocp: Fix board ID over-read
    https://git.kernel.org/netdev/net/c/6b69f2ef10cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


