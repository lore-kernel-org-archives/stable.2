Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792940486;
	b=MSjH56g/iRjB0fsIjEgLhMenlrK9cY+BTiB3EVNXPpo+mNLys/lZgDcwdRjhMA/yeEgv
	 90SiGtrJW3Y+BSBKZLBKt6JMSD0OjFpZDWKJWEU1H71d+FZCK2PxtXE8GJBccUv+8r9tH
	 G01e8q6d0LhtLY9dbVEWMAJlphVyBy0v7Jku8orOceQspj7Xl791tLjhMEfZTcKYDye1X
	 Fb4snGwoRinj4pjEGs4Dg8uVQVyoPuVVv/IHS5BBDv18fsrNBQX2pU5KwvXoSz5rTYUik
	 H1oelpZA/n8K9bnyWUeyqddPxXkZ0uuKwh5lVqnkY4SkKAyuBkOPaAziUlkGCcDurZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792940486;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=oH5LL9n9hbNq1W/fQ3iGP3pKD9R0OLb9HrhuQDyblI4AWsn88P2z5n3yq9DMHGFRVRx7
	 qR3QCBQjOOri4/BO6whuR6gq5oN408n020cX3zTfmoFAcMndtu8A6yM8mz6sn1cjF53WP
	 7Za0Q5lJkXXUAgRf4powb+QrLsTsDxZRwt0k3ykyYahRBB390WpZWQSvIpMpQA34dkoU8
	 wfyP/s/5vfwiD/PSimOyqY8xuYtVBMB/V3PSQN7pXTjnscTBFwoJ6EBJAC8Fdu4xT2d94
	 dkH85msxkmJuBKDfK8Va++oQ6sHyJSy/viQT2GscgtMHWu/q4DsF/z8r0ScdX83W2uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVSq6bIJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383BC606A31A;
	Sun, 25 Oct 2026 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVSq6bIJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F12A1F01828;
	Sun, 25 Oct 2026 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792940485;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DVSq6bIJOnOz9aCFPzTP0TA98R/yja5KQ+DIhBFCShucGgSrw6ryDCaV3boTD7Kzx
	 d63DJjC8+OjIzNNecwFLxgd85I90FYfqb03/ZRyUNzXSNSMQoYq0KUMYTFybq2XNcL
	 nCKeVbu2i8h+/Vs1WQkW4+/QFiPhHjenJLRW6qqm3vuKt5k+JwQh5ehHAt6/z2rSjz
	 1ydWQJabtfUgtm5ieWCF5uy/SNSmozdB2wyrkfBrhQgJQhY4hngDqfcZ5rUaSlNVtz
	 5yaiSWcny5ipqOLFf1/aX3uEejov45yDFP/4LAZjuExN8kCKotJyo5bIRd0MQbuLeR
	 4XLOEvTBJxDpg==
From: netdev-bot+sinfo@kernel.org
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 jchapman@katalix.com, tparkin@katalix.com, gnault@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] l2tp: only return sessions of the given tunnel in
 l2tp_session_get()
Date: Sun, 25 Oct 2026 15:01:24 +0000
Message-ID: <179294048471.3327.7148108321076866901@kernel.org>
In-Reply-To: <20261025145831.2133617-1-hengyul@cs.unc.edu>
References: <20261025145831.2133617-1-hengyul@cs.unc.edu>
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
