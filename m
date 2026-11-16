Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855744;
	b=AlOtPE5kmbyQgVg7WH0JZ5Me31X6fG1NqPwMEwAJxD5U9bQawRxWd14mJ0mA0TOrwHGg
	 KDt6ZE51nUfK8qZOrx8lPNVkNPsLM3zwt4TnkD0m76XVlpghs1zvRP/aovEvP4GwZ+LSa
	 Y1SKwFI+1Z85V1MqHIX73pt5n0cqqtIbwVdMXsF7s001HUEByisSGg2Bdw0SASHUsBBF7
	 yM6zb+wB+0+vW532Kq+7ImzDp3dphD3LxoBbtZ2L5eKF3Rn/RzbnXJ7FMK0rK/uJxqe5O
	 ZbWyZSbdB3I5FkcfdIecyx8a8e8RuCmmrG8ldSqvp5Tu4Gy5SFOEeZHCNGlTUYdh7dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855744;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=esrzrED9rv7bpO0h9sTGws/iaXSwv8MCk3+mq5g0fnASZzEy92R0fUwyk+cU54nPOn/n
	 8PZJoSIpKLqGffrhqbACoDIq1E66rjP6miSrVVj9I3CQN9hUDRYoualTYyuwikJBSGcgA
	 S4bxepY8W3/SJ8aPG2kTXsZt3RKCRIdRzTQATJttcAcNa7cHGyKmT65kp2D1IMJBneF/K
	 M8Yk0n9nmbDYJZ9BpoYxFnalQPOSIZ5TZuEKX8p43sUiKIJdxJLx7YKJ1W9rme/pg0ZDD
	 bI/dogWRxBtLDbRCzx17Fklrs1P9g97Yra0dsASudJmpPT6nv+q0lp7PxKf970z8+zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZiBO0w0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AB60A2608;
	Mon, 16 Nov 2026 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZiBO0w0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DA11F0092C;
	Mon, 16 Nov 2026 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855744;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fZiBO0w0LoRJkpwoeS+Ra3YUKeiqUmYYIMiAUZN4l8ygJzUxl6xd84pnFmpSwturz
	 hnp3t1bg+0dYSUv/4t3Kil1G4vCwb2hKvFDFcuPw+ePhI9kDsgrnGtLnPyrhnJyGhT
	 z7W1PeE2n/FN0NIrB6VW2TUnWm2dI8pp8DUQnN7arUH9ShzhUemoMyb/xusGTS3gGR
	 ccljuZUWUpkTT7aWfW8MLz2SA1wuVIgHXuwK9cb/DQFTeLtNbuLON44sVX/WkDsq7R
	 Ywf5rHig6zUCZSLDLzrSZHx/OFkJ6mQc9qE0BnfnTgQH0rRpL4DMH8v4coZN6uBCfd
	 1ePLpqsONsoBA==
From: netdev-bot+sinfo@kernel.org
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, jiayuan.chen@linux.dev, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Dave Watson <davejwatson@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v8] kcm: reject TLS on attached TCP sockets
Date: Mon, 16 Nov 2026 19:02:22 +0000
Message-ID: <179485574283.3291.7349043137994808253@kernel.org>
In-Reply-To: <20261116190111.3317976-1-rjethwani@purestorage.com>
References: <20261116190111.3317976-1-rjethwani@purestorage.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
