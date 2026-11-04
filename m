Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804610;
	b=5ivd3Gp4FFm5+vglbYKdW8wTh60VAumpy2SKzYw2wP+uqSysdX7m2q3SQVI+m3BAq8QE
	 rzLhtTKpwHi1PjF3UQTsCg7an9/9JNHAQTw0TiN97SlHieQg0hfE1Y13dbwW5hIPzKx85
	 xN0IODo4/U4QTq9cQEeSkKa2ztwlklhuGtDFcp72MdLydWdmy7VJNv+4uoW3wS9tga8wk
	 oXBmOmCKoD7MgFort5oyJmykIb56BNlN+DmlhsCuDCZSG69KZnGbrAP2r0YtSyhkKrUvd
	 3NL8pmto8N8tb3XI/XtapuCY3fuizJH/wUvXG1XYD1GBlEu+pIrmLaVQhcrJx5Gqz5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804610;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Kp08sjg96eFAzXpafYQQxUWnwxKutsJ2X7Bc0agwvH0=;
	b=WU7p4uaCZ0kLJTO/UK1Kx1jdL18iLixQ8GhQPUf3aaV/7LFG/k5cDSwsLpH3/Vx5K8+9
	 pI5xEM2WZeLaai0EPHYlvYfKv17cee2QfnApCzvuKdLHTlYuGsVIh7aZxHhv1nLGgugb2
	 sW27KtuLvlH8wW4nyqYabLT7/IhgnjZYKvzzbqsen/3wTpdKNYXYxnO2FPnQsMyHe6Q8J
	 wKFaVraJoZred0iJlWKgED+6puuDOYfppMCmZ6q8d6CH/8ulBbIvyD7H0jActEe1SJs1E
	 lT35BGXqqBJCd6eujYLoaHQA9CpNW7On/5eGHtIh3LXI9231rWDPTtaxe6X1Zk+OCKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVd6r7fQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C56606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVd6r7fQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A3F1F00919;
	Wed,  4 Nov 2026 15:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804610;
	bh=Kp08sjg96eFAzXpafYQQxUWnwxKutsJ2X7Bc0agwvH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QVd6r7fQnKj9G7x8gsFhFg07vPeQ22KK/HULR9YHHFYa84+SplwIe08dNkMubar5Y
	 In4iS7CNXcIEDAC4YwvFBdAY1jZIDYgkFhQnXb5jaOVkQjgnyzgG10BUKwRwbH9jua
	 iQu4dM9BKsMX1agO73UzA9wY5aLVWRz3rTX/YKckjLCXNuMLk747JVUh3Ys+rVdGaS
	 WgdxcS90t3+X0CGlaEv2rNkafKSdb7JCYU55pvDsJmQArVkGl3nPbo5qASvtL3J/2f
	 Cd+SNJneR70RR7OI52dLqiZ8PvRVXZ2IwlUUwUv6mKUodMR1gDCgKfpeU9+SqdslVV
	 j02psYXfob5bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bp@alien8.de,
	sshaiju.lkml@gmail.com
Subject: Re: [PATCH 6.18] x86/bugs: Adapt SRSO mitigation to Zen6
Date: Wed,  4 Nov 2026 10:03:12 -0500
Message-ID: <2026-11-04-1-daily-reply-0003-re-x86-srso-zen6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103182143.27403-1-sshaiju.lkml@gmail.com>
References: <20261103182143.27403-1-sshaiju.lkml@gmail.com>
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

On 2026-11-03, "S Shaiju (AMD)" <sshaiju.lkml@gmail.com> wrote:
> Zen6 has BTB protection which isolates the different contexts
> (user/kernel, guest/host) from one another. This makes the SafeRET
> mitigation there unnecessary

This is Zen6 enablement (a new cpufeature bit, a new mitigation state and a new
sysfs string), not a fix. It has no Fixes: tag and no Cc: stable, and Zen6
already gets the correct SafeRET mitigation on 6.18 without it. 7.3 doesn't
have it either, so I won't queue it.

If it fixes a user-visible problem, please point me at it and I'll look again.

-- 
Thanks,
Sasha
