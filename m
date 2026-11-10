Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287145;
	b=SxsYwdJ0MnUY7+RQ2LcXARYN6C16QVyWTaErqiLPI1pKpr6tziFSvzlfbzlhz68dU5cG
	 /hjnz28wTWQVl6t1g3lCSPwr943spjp17JwZQsew+Y6I+17dgYYbqPOMlZivxxeITW2oA
	 6M6qSc+pGd7Ms/OkpzHt3U0LQR+vpVahpwBkn672QTDWDY/maBuiJ/jaREHNhJsEXYMuk
	 bXwRUSjuBy8dcKgGH+HZ3C6l9/XRPu36X+Dtav4+ZCyWGTbKi6SxG0uYO28MReJthCWYv
	 1FQgcb+rM/DejwJHFCcVX32ZGeSJrz/Eb0wM56RR4coPOlQCU8Ssjr6bDfp2QH2+BqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287145;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=JXud/i/G594RocafvzntSmc6cPRyxN8Ntjn9zxfaaixI+APml+LUC4xjGSJ1QdvMKlBD
	 H5LSPQpYXCGKy1vwchtw0AsTRp9bDU3aWvJoiffeLhEjEmPoT597Oa1fj4yJCkYznVHf2
	 I5Zp8MCUJ16kbTgRV+K7ugfWieCr51QVpSEdCbc9glwxkKCtm6cf8W9Ilfa+CpMdjNGpV
	 jRhpgeYwV7UugpG+6mPZPXkUi/0RgeMvGiWPf8uIHZXYuCAf4E3m3jMwwwipTYjMHCLex
	 OW6Ls8anfuiLxAaA5/5/0AP3f20GSRch8WiA3prwn0WUrPb8ybrduEbm4NXbACXwywA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFsv2B1I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F60606B098;
	Tue, 10 Nov 2026 05:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFsv2B1I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9C11F0089F;
	Tue, 10 Nov 2026 05:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287144;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AFsv2B1I3QyNnV7/JQ0jSizapoJW0uKmA7uOrhNWOqhM8zAJP3SXXlJ37nEYPPYyu
	 YwSB32Hj2LreLe/NAOt/fCajjHI5LcKDN7MaqHbWMXmXqdPJ/DCDLVKMKAWTGVnKri
	 PMQByd4QZtDjsd+Q38/SN1PYGkxrOsswG4LEPACt9EM/bwCRAB9OncCe/l44C54Wrv
	 4zisxjVojRa9sQ+HqeHijLpIIWH2+mWRGeQz0M6GTfNORO83xw1q3EKvmBL3NUOqVQ
	 f9pXlYRkL805m260ZYT9n5iTNwyYkLDo/I/rGGa3kJSQAIrR6j2gFkaLrm/D03XpB/
	 hikRnxrQxt00A==
From: netdev-bot+sinfo@kernel.org
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Subject: 
 Re: [PATCH net] net: wwan: mhi_wwan_mbim: disable rx_refill work on removal
Date: Tue, 10 Nov 2026 05:05:43 +0000
Message-ID: <179428714382.488859.13396024041020604951@kernel.org>
In-Reply-To: <20261110043006.56681-1-mhun512@gmail.com>
References: <20261110043006.56681-1-mhun512@gmail.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
