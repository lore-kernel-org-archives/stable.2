Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461008;
	b=N56AUZtX9KB3MXA1HFANOnrvnEMth15+khdug5GqOeEMi3dGfvkIiWR0OTaV7XTJwlK9
	 DLEcDoe5vnLZgHNgDlENJI+g8qY20KOp97x39n/ag58DSoCBIPLRcMb31dOWBENDiF1sz
	 r8R3C0N7VitWnVVrbmT2aRtAHyKViobFRHSfbT+3KJVskxbwUkrCeBjQsBRAuXPvDYi+p
	 SfZ89wtW3a9ckC58kj6gAv3+Ym+IQe4/jodyBWVkPBew+yqW+6wwgt/y9tRpMCV5t3+Uv
	 X5RxsksNyat5wOZ8tK63XDsXnJuxON4ox6dqGkwpC1AkOp4C1EJLcaMc+n3kPir09Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PLR9fAF7UihRpSfvFC+5lJDzI6mgLhp/Cqwn4nFxS4U=;
	b=DTvcbdSr9yXuFWf0iYoOstND6mg2CgQaJBFzt+Nou+2BUEBUPWs/qPj1kcbggM/uQbkP
	 AMjH7IJo5qRch57yalVHq6NV2x4WidhRsWmx7FfEuqmHpRE6fyii+8ZpHuE/9968X2gON
	 eYKSu4cXNkaoNMpeJ4qVjtLH67euh63S/CWe29KKRYlQsnlQjfIpi6ij18yAWTf/tnmOI
	 le/oWxH5NVUXMtz9pYgUR64pt/5Le/nHLpf6WTzFF3nJioJvS0H5/Ru5xJtwLZNiMd6PM
	 VmjBJKN9h2nQa04Rw59cfE9SmtC6TBIJ5Tmln6TvWgXQgcxiYh1BHyNmMeD5idMajng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luOAJKOP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED6606A32A;
	Mon, 23 Nov 2026 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luOAJKOP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7421F000D3;
	Mon, 23 Nov 2026 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461007;
	bh=PLR9fAF7UihRpSfvFC+5lJDzI6mgLhp/Cqwn4nFxS4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=luOAJKOPl3MDG6Ezjs6EeLBXGcbTSGF0W6GXqMKYXF7AqUshGLuGypltMAyMOUPHO
	 2Xg91oaFankRKUH/JRAFK6XlTgyacEDbtaKRlIU4tepkdxW2XnldVQPg/bZpZABIGq
	 eIPgOmE0ithXLWCjMo2q3BE3epy6ewRv0WXyUgd+ZI6/YRTrQSqd8R5gjX62xJ4lYB
	 rAW1mnN87oxEAVdxqrKAau3googZJcCV90fc/a80HFhrBXBvNvkZtzQfhVcy10V8LB
	 c+l6JMdTmhr/g2SmMQHlT0TKP64DybyW3NV4Rz6Zxr2RU38b+BbdRwjB06j5cJ7eBX
	 BfRlNQAFcGuzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D1369392EE35;
	Mon, 23 Nov 2026 19:10:07 +0000 (UTC)
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
Subject: Re: [PATCH v3] Bluetooth: hci_serdev: stop write_work before closing
 the
 port
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546100678.3063022.795592949676110880.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:10:06 +0000
References: <20261121155648.1151-1-enderaoelyther@gmail.com>
In-Reply-To: <20261121155648.1151-1-enderaoelyther@gmail.com>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 me@michaelmcallister.org, loic.poulain@oss.qualcomm.com,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 21 Nov 2026 23:56:48 +0800 you wrote:
> With HCI_QUIRK_NON_PERSISTENT_SETUP, hci_uart_close() closes the serdev
> port without keeping write_work off. The hci_uart_flush() call right
> before closing re-enables write_work and may replay a recorded wakeup,
> and hci_uart_tx_wakeup() queues it from any caller that passed the
> HCI_UART_PROTO_READY test, such as the serdev write_wakeup callback.
> write_work can then call ttyport_write_buf() while ttyport_close()
> releases the tty, so it writes through a released tty.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: hci_serdev: stop write_work before closing the port
    https://git.kernel.org/bluetooth/bluetooth-next/c/62fd917f6d2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


