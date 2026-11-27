Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798963;
	b=AMvM8qFM898u5IdIxpCW4sRwkSDaaRnk9mUCLxGp8rVG6uEFv3Kk54HMVXMsXHyYNzb/
	 Frgb4JTiKwMofQYn2a6Luml0oNyCF0oEQNyqkdLmOIrvsK3EaV6SGyGFPmWutowFDzBX+
	 Ez+Z5hyrCxDi4dW3dO8PG705YFvqhYUwecSYaPpWbF6aXrBBcNC0y/SaDZE4pPW3SdUlh
	 s9/vaO6LVuXbIH42PeKn/LYx5hcZPjbjQdyMUJ053lhWpIlQxEf5ZBrnYc10Ch6H5eVN6
	 iS9vYGjI60H20CuJdwfkW21oU3qZmzGr5VL5+sYRtTLOMpl5R60bWwVZvL9f1qQTmNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798963;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8/1dzqCql1I27Nw6nm8V12+XdNZFk6RzA9sR8Fm3QUc=;
	b=uawV2ZudnySru+CJPKFhHXp/VLZuqc6Uuua9RB2d9kuJb2M5xPmCf8k4mOwRyzotJBNp
	 BcKpe4ysff64w5RyuCH+s6NbP/AGdkt3xj7NSjmWgPtSHtFsALERt0h1ccAnZ3kp8R63W
	 12p++0teOhQezYIT96bAPVefXEz3F/G9IHJQii9xMwA/UFeGgBlmixDDEI4WJ97gqeDW8
	 bMG03sg1sA6Dq+DB5pnOSaqVwU/AKsLeHSPsbVd6SNDhP35FotvajZ+lbvRp6ktsP0IN0
	 Bya2ZKw1i53mCBm6CxInPFTxgrQRAWP5IP1SkvYGyWHrnMJTJKnjxFZ0zgwyNLvmfug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9U7yXVG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8517606A32D;
	Fri, 27 Nov 2026 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9U7yXVG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EBB1F008A0;
	Fri, 27 Nov 2026 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798963;
	bh=8/1dzqCql1I27Nw6nm8V12+XdNZFk6RzA9sR8Fm3QUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R9U7yXVGQ5wdpZ3GzozAn6Aln+mCYLMlMIuh01iatwxaLiLmT0J7T1tDxouuP1fhy
	 5WD2KL83fYzyxOTmk+F7qF4p/XZ3aW5UvuWU37F6C5NH079+8oys2Ftu5d4AlDJny3
	 Pixzs+med/kibruxdTLLtOBKRZ6qKLoSUQocdb+EwNYXHHsfxh69xA+pGZ+R+iTZLa
	 Ev5e/pXpos6qV6LAqyLPNm3OpiPT60lLyndIfOFObkj/2TxUFV1JdLpAurLM3S7rqh
	 22GzCzsUjj/lLSkukI4kFIe3bX+6foPozJfCkvSC7gMcs14j9cE9OJn6yUrsej34Tz
	 B1aX81QXtjSAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org,
	Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>,
	Dickson Wu <dickson.wu@certik.com>
Subject: Re: [PATCH 5.10.y] bpf: Clear buf on error in __bpf_get_task_stack
Date: Fri, 27 Nov 2026 12:01:28 -0500
Message-ID: <2026-11-26-1-daily-reply-0040@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126-so1b-bpf-510-v1-1-24bed4a57fa0@certik.com>
References: <20261126-so1b-bpf-510-v1-1-24bed4a57fa0@certik.com>
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

> Adding missing buf memset for __bpf_get_task_stack fail paths.

Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
