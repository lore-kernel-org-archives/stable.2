Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793402422;
	b=hv4n8mMDvn3XhXipnYhkP3XonM7qp4KUjuDZJCV7A9++HvZQueuDeuV/XlOjTD3C9UP7
	 se9Fdc3/8GLM/WOzYAGktNBtHjfLL5gtYq0YV+o2L2D6Yz2jrVGaVBV4jJuPDtTO6cV9I
	 0WFiNtK0wxIb3AnFmSO0Sf/IKu2dPGTXR9PIUbFR0F4TcOhmgeq3tw/UBzXXkasWSsnX6
	 wIhuRb/pZVleAHBh7NiD0iF4xQiAMuKU6n2a/YSJQXd5BFGmeF5GIfXNs6XDeYgNG6XJq
	 7BKnTE4vJ40M4AmNVarAIhwpA5lXQWC9i7DkNzOEOLohDtFeot0FX+zG2KpnglYQiBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793402422;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=MWaX5dyd2Adm4zsMFXFtEklW6gVBSAQKnGqgpC3V5mE=;
	b=oNXYPxaJmMVW5krJXLf7B1TnlU2LI7DSb8MJFf1A0q2YxSg9tWhZ6cqxw5/okGHwVvn5
	 XhLFRCxOeCmQNp/8ckrnQvmZx7ZTJintVjdZrbqzLoXWrsEGXJY8hFmgruDOb5vO1izzE
	 09/vBXhKSDVZJGHEnMZUUAe8ebG7XSv60klNgm8QdOlfF+VT8uMcJMiKnyGBDPfX/0k09
	 q5dS3HYcFiZbQ4fj0uWjfGCNT9AuEWEjcaGiiCVoemrYvglo0x4MhcB28OiY2Ck1d9IzF
	 xHlYsolp7YfwKO9gycUTfS8KthGlfdZ4TiQOIcEnPLwsFLvstQSBByaWPNg+5KXt2/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgIVu2a4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256E606A33F;
	Fri, 30 Oct 2026 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgIVu2a4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BE71F00A02;
	Fri, 30 Oct 2026 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793402421;
	bh=MWaX5dyd2Adm4zsMFXFtEklW6gVBSAQKnGqgpC3V5mE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FgIVu2a4FjAtstcm6wbUBEuvd/hn7qzmVRIHQeceWWLJkw4kSBzXiR8sZcN2H0eLA
	 XqpeUcKTB0EhAwJ+gr2grqmFBYBvshra1CryuirkOnzN2I0UjNfSxFpBlIESy/EXIZ
	 VEjWYi37DWKPDpk06DUSz6qSddMIYkuPVTA36wq5Wa0vxYkNvsFSR/JjhaEZLCZ4AN
	 KkASyvfGaVlScP493aGWVbONYPhx/cZMlmPgbl8cKmuxQ35/YmHCeuP95d5wYLlxf/
	 TUYWHhroRGyHWf/m8waw9lIMpN/bx6fG0iumj80VoTeA5VBxbbvLIWj9sIGqUmrGoN
	 Yanajm2wP0AJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401F23800478;
	Fri, 30 Oct 2026 23:20:21 +0000 (UTC)
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
Subject: Re: [PATCH] ptp: fix use-after-free in extts_fifo_show() reading
 tsevqs
 unlocked
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179340241979.1826218.15128975775519489276.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 23:20:19 +0000
References: <20261026100535.68114-1-yuz08559@gmail.com>
In-Reply-To: <20261026100535.68114-1-yuz08559@gmail.com>
To: Yu Zhang <yuz08559@gmail.com>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 20:05:35 +1000 you wrote:
> extts_fifo_show() walks ptp->tsevqs with list_count_nodes() and then
> list_first_entry() without holding ptp->tsevqs_lock, the spinlock that
> "protects tsevqs from concurrent access". Every other accessor of the
> list honours it: ptp_open() (list_add_tail), ptp_release() (list_del
> followed by kfree of the per-fd queue), ptp_clock_release() and
> ptp_clock_event() all take tsevqs_lock. extts_fifo_show() is the only
> one that does not.
> 
> [...]

Here is the summary with links:
  - ptp: fix use-after-free in extts_fifo_show() reading tsevqs unlocked
    https://git.kernel.org/netdev/net/c/603a0c40d414

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


