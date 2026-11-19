Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114210;
	b=Aa6+Adgf87eLrPffBu24FSr6Gwb4whygYhArM5YJ+rHh5799M5w0cwFCMzmyqM8nmrlR
	 zNvB7ZVdrQmmPv7RIYZPyWLFDsXGYXJx5e+WErXhLYhUUWsz5yZZUqbkNgEuogNs6bZ13
	 fWktbYjScDe0IrTq7r5aMgil/qO+HZe2kN22MnzAYsjfySsFYXZ02qvFLzqQrP71Za5KX
	 tKSYnNZx+EpeCyMIckdk3pV25XhcoLBZ2mQw4AqFUOhmfNX4IvCvcQzkmjHAvnc8172Fc
	 GSkpOnZKfUz77L/Ye0QfcdcvVXLyLqSjdrfeDbdmEA4EC+Rglv95yo6M8UugeMEWq8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=SEng61Wrb2C3bN1Xh8nAH25a1rusHKxxyYG6W94V4yA=;
	b=cSauFpEfxC/8FWoLGLz1DseGBCo/rOWas3rExop6WPDMjfY+bmpYGzwZs2z4CAwsvEMf
	 0EP1WP3TBgK4sSTuca6PR7E/pLFbvNUnUMllN4c726mN62zH3rjgVfNnABmhxo9/Ss8Gm
	 1rWbJdIAP38r8DCtIL2ZV94CVOlUhoJKIM0EyPU+8tuhvNOoBI+jf+CfXEIciXqMUsD7b
	 FXz4kvUwOWl+39BIwPT34N283TZP8z2Jz74q4Gb9WKXfPP3jsmExei0uedTcCUVz2QrYD
	 sxZdczXDuBtq+rv3SD50wrMsyQFuzSBwtdaQ1+fVuLqmmxMd9ydIP5TqGsdagrgAoJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CaFYX8lA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9939E60A2608;
	Thu, 19 Nov 2026 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CaFYX8lA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E971F000C7;
	Thu, 19 Nov 2026 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114210;
	bh=SEng61Wrb2C3bN1Xh8nAH25a1rusHKxxyYG6W94V4yA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CaFYX8lA6Ee7+CcY/TVc/zeYzspIilGmC/EUK38Y7S6GmUqWhbhf7Fg59aKXeBVOw
	 qNZcPf6/xCtnzYVofzC6Y3M5QRwdkMCbdkUoIW5FsmfAuRj08hhrHy2FFWlVKzKmMS
	 Jvoo5WpDoM7F1kYjwWvsJaPk9J4zBx0da6RRPLq3aUVZKR3T3cMFDnSd71w67A5MBb
	 Q1VNMxguXXmddu42mvtMVy58GtkJj4V4w8t/8QwJu7pdPJaxnF3nKk7oRJ5EyFvgHQ
	 0x4OXGNa/XwE+nDKLN7IZ0l/Ss/0IEnqL9zDnZgie6GY+muYT5iiXyGfRXUcAMoIMo
	 l6g2uvIlU1G4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2E73808210;
	Thu, 19 Nov 2026 18:50:10 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: MGMT: Retain the selected legacy advertising
 schedule ID
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179511420877.3743161.3171281660123127409.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 18:50:08 +0000
References: <20261119112359.34543-1-enderaoelyther@gmail.com>
In-Reply-To: <20261119112359.34543-1-enderaoelyther@gmail.com>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 19 Nov 2026 19:23:59 +0800 you wrote:
> Updating the currently advertised legacy instance can schedule that same
> instance again instead of the next selected instance. Add Advertising
> stores the selected ID in the original request after mgmt_pending_new() has
> copied it, so the queued callback still reads the requested ID. Add
> Extended Advertising Data never passes the selected ID to its callback.
> 
> Pass the selected ID to both callbacks in the pending command's user
> data, and keep the request ID for the replies and completion cleanup.
> Extended advertising controllers do not rotate instances in software, so
> keep scheduling the requested instance there, as both callbacks do now,
> without cancelling the rotation timeout or looking up the next one.
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: Retain the selected legacy advertising schedule ID
    https://git.kernel.org/bluetooth/bluetooth-next/c/5052141b19fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


