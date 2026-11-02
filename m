Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617194;
	b=N1KtsczOsnAWS9c0VOwYepu++MxI//xMS4cAUGsArmIq4Ywv+arK8lQ6n19ODV7i9n67
	 C6VXc164IeLV62DogLpGzSWtmAz8w+rRfJs7ere49jvh8sPTee3XSUKw41Z45j4BejWCu
	 xqahucQelTB+OCy3e/XrB8b2zpXgfA36AlhiJ3tqbWS+CxwvialHpXZVviULuagA9KF4I
	 9T5Cy/ZtjSyBYdhy1cyDv0Zt3ZXq73o67RnS/EDdFPTfItLJOhjZAPSwH+40WO3cuQ1TC
	 DEEbzZXD2hEpaLLMSZ+bRsj+HLuXraiksAqNvI1xMkQRpIch+7e2KVDln5zfNl6rlRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617194;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=P64qZPZO4GlROidlqy/ZC4Xy8dd8ETSuahrkhJLhu0dtriQ8RLww70R86FjxiLMO1CyD
	 n0UbDIQj/6gel9Wa17rb9v3SAN0TDT83/LKlEzIZ5OjN7eEbyfd0hR3YQmmjpj6ukzKqo
	 rrHYlh3tFKn2p3s7xSErYrSwqtEkGIgtjynfYVdSdbpfKW+APv+7SEt8tRsQshmdmJcDD
	 84Pp+dCIdLh6d4nNO4CUNIugVKRacYJ2gMItBiLO8/i7fpkyl007+bTbRGz2SQewIv1cK
	 3WzF07p0Vj6yJ0ToXK0uwoqFW4KEaYz5NDkQMJAi5EYdDzFnb+04ULKZZn74pGXLINQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0+PfY5e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC96606A324;
	Mon,  2 Nov 2026 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0+PfY5e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD40B1F00A16;
	Mon,  2 Nov 2026 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793617194;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d0+PfY5eawxP1NMJaYynJyFmaaYSxb86YjOeWj2GGfa+QApM35uqCO+JlcOjWBzJ/
	 bdQ3Pfpa6nPGuBpOtsn6pZsYfDYcmqt7RirA3ArGxYgPap2nqx3riOXt87LcTyr7Ko
	 9hBwIdTb2FqCNHMGCTCPWtDVM85zXKO6ilW00F6ZokwBa+FJFkdOf7lHu6CjUB3rwh
	 rt+MRkQGgSUxVaQTYimJH5G5Q14p4CocYkjIGMnw6yfMx2gGl8CMIfB9/ThSda37E8
	 e29eu3zJKwfDDVn+K7dhmiGfbSRfNCq4EFvgqHJX3zXv8xyt/WNgNmMhnLF0XkMfVh
	 UTpsY9wRl0GgA==
From: netdev-bot+sinfo@kernel.org
To: Yingjie Wang <x-professor@outlook.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net] tcp: free saved_syn after an RCU grace period
Date: Mon, 02 Nov 2026 10:59:53 +0000
Message-ID: <179361719331.3286.3030968278177933592@kernel.org>
In-Reply-To: =?utf-8?q?=3C34f32e63b803f9f7faf0b0a5754219e48a986136=2E1793616?=
 =?utf-8?q?950=2Egit=2Ex-professor=40outlook=2Ecom=3E?=
References: =?utf-8?q?=3C34f32e63b803f9f7faf0b0a5754219e48a986136=2E17936169?=
 =?utf-8?q?50=2Egit=2Ex-professor=40outlook=2Ecom=3E?=
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
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
