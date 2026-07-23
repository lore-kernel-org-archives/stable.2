Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AD479862;
	Thu, 23 Jul 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814066; cv=none; b=khKVlSFcM+Y98uUQUbEP5ehnz4uRzPWnT1i9nQ3VtUvNiWMSqBhCUbIo08kKjdaCHMkkRwKjpt2bKe3JJ+qCna3pawHWXltNo2v/1lxFAMdZk3lvTfDX76tje2jpkdLAw180SOv/aRawioxGTsMbhg5AQlnRrLimmLYbBI/uD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814066; c=relaxed/simple;
	bh=BhkFA9vODK9gMT/BoA7IcFaEHu3GJOoVXWbMd6wpTSM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SahfGNN8F8jeSabzep7AhuSruiATO/A12kCnBfHQaE4vBiiB6sfqUxql03ccBJnHPLktVkhgjus7IOavSeO8tLFCnhmsrCUHw3iCqTWfnBERESr1AHZ+4qMFomuwocWyijAKf+XY/peAommp+NkKpW2Zz0bIhetOXLZOrkx3PbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GduH0QgE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GduH0QgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE0D1F000E9;
	Thu, 23 Jul 2026 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784814062;
	bh=eD3DjLDQXjRxJpwrn8QeuqMDI+RJmkeG6b0AN+bz9ZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GduH0QgE+dAvzWa3pYMSUQKj+gddyuEp6oOBnUbVF+nLU6TUx6uXfmItVcit4A+Vf
	 g/ggzVE6ekYwhrCWJAqH9exhmT6O8WpgK3dOPRcEKp0i5UoY+lV7krZtCPq6eATfcq
	 Pq9+Bxj6BZBmPSW/exLw19c8HHp11gMrx0+ZETG8wh7G+RybiYOaXQkidfBGP7bcLc
	 vd1DAewqRYUWwxdoiJS4hSBeoJcZKIqsS8YYKkK1mfwHpVWIGeevX9UYAsyJhfaLWn
	 Q7RuJtL5H5G8ijVtNuBdBZRVBu2mjiq/miU0EpUmFascnelpkdmYTDMNHyj6ElcaTF
	 EnLvOKpls/Xtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C403810902;
	Thu, 23 Jul 2026 13:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] mctp: serial: handle zero-length frames to prevent
 rx
 buffer overflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178481400840.2245010.10190562168875371704.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 13:40:08 +0000
References: <20260715082021.46315-1-doruk@0sec.ai>
In-Reply-To: <20260715082021.46315-1-doruk@0sec.ai>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 15 Jul 2026 10:20:21 +0200 you wrote:
> The MCTP serial receive state machine reads a frame length byte in
> mctp_serial_push_header() case 2 and validates it upper-bound-only:
> 
> 	if (c > MCTP_SERIAL_FRAME_MTU) {
> 		dev->rxstate = STATE_ERR;
> 	} else {
> 		dev->rxlen = c;
> 		dev->rxpos = 0;
> 		dev->rxstate = STATE_DATA;
> 		...
> 	}
> 
> [...]

Here is the summary with links:
  - [net,v2] mctp: serial: handle zero-length frames to prevent rx buffer overflow
    https://git.kernel.org/netdev/net/c/793b9b729f1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


