Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798967;
	b=xffmc1A8uz72bv+QvLCLiXs8SLZeJLM5WYpVLmWov+aqzzFDrsyGEB7wNfqK7C3H3Jfc
	 m1rsaasMI6vb2YVGClZSzXlUzZsKcru2NUzOpOHafGAnNOrzKIA/6WLxFc6Y8hZNneaUj
	 l4emcGrbIVEQ5qdxkQSfKOqd+pzCPRASiCxdw4Re3AZZAQw2jnbjdS4AN0YiBS46TPoNx
	 oLM0IS6sSdNpGsdI1Yg+cANadborzdFdAfanDQ/pux3aEOo3W+1wTX51D6S8qVDmdguxx
	 /r+Jps9VaePfk32JxC0w34Cinf2LteHDDnQ4xg3Y8L86+Hb6yaxi+zebT3nHEc8VDaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798967;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5/s13xoXIsXecT2akWz8nUo2UwFwuYxlwqlsUDPurS8=;
	b=T7zvnVLGvpifAA+85kdzAUTuupiGchP50yC+BNsHkgJ1AjFEeJBERLQIaVp7Fjm4yc7a
	 2EOENYIeG/ckaj/Fb0H/rF6kMwgXCNq5Kv8VM37OC5Hm5r/PbvJ+jJdps8n7Ih37GUrUs
	 bktlPlsJ9RyreK2eqp3psY6DEztndNzx8mAIJB7dOeiS1/cNXc1g+lXnhXnta+RmldiKF
	 lm7Kr4zCpoqj9T0OaXiChs00D4rt5gO360FyhFZ1QunJcht2c1a2JgwpNMJz78NuEBqU6
	 HDKZXI3Ees/w1sd4UhJYdAqmuEWTW6tAw79oXKhYzUoAf+ySih6rvyM6OsAcX2asSdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUEcF0JI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9368606A327;
	Fri, 27 Nov 2026 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUEcF0JI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38331F00936;
	Fri, 27 Nov 2026 17:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798967;
	bh=5/s13xoXIsXecT2akWz8nUo2UwFwuYxlwqlsUDPurS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QUEcF0JIPOKAtHeqCW21NhdlLMJWCIiT9ozEPpjmccIbzlBIf4zdyYA+B7pNMMoYU
	 nciolX8PzHtNKJ3f1sj94fup1mQ8/zYDLYrsJwvaRQOuZeWVmUfJbD+SyV6NQIxPvO
	 K0y7S61dFXb6nrkD+zmK1dw50NTJ6GinLYMDQIrfcL+hPb/tuVxqneE+b5Wq2MM0Dp
	 o0v7ffyKZ2VaWb80ZuP8LuHzsb4HOLdPmEo8ddlB69Bmcs54llR8aDTUyz24rZH4D5
	 AQnxPbTH+ppjoWGuFh+78v4Ib/XR30f89D0wHF4qyluvTyifm+WI96ezjqUr/3cCg5
	 /hI+gRyIRsLJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Til Kaiser <mail@tk154.de>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>,
	Dickson Wu <dickson.wu@certik.com>
Subject: Re: [PATCH 5.10.y v2] net: mvpp2: refill RX buffers before XDP or skb use
Date: Fri, 27 Nov 2026 12:01:31 -0500
Message-ID: <2026-11-26-1-daily-reply-0043@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126-mvpp2-5e8e-v2-1-ef63da5e986d@certik.com>
References: <20261126-mvpp2-5e8e-v2-1-ef63da5e986d@certik.com>
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

> Refill the BM pool before handing the current buffer to XDP or to the
> skb. If the allocation fails there, drop the packet and return the
> still-owned current buffer to BM, preserving the pool depth.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
