Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299422;
	b=Ga0nngADIMeKuqYXCEfOxQusmiJxEaNSqOAXvqPjMqbkA7lREWYkBKGvibKJp+F1jsuI
	 BkosqturR+YyUkk+c5tjUBDF92La8CT2N+UJm58BJY9cns20ngDvTm0iQcbH1kjzCfkj7
	 I26xYBT9aLp4WSYzsv6dQvEvqIelRB4BEo/p4T0eRdgCJmWkxy12kI8KQ4nInSFse/+O/
	 9GhxX7dJLldfrPI9D8HYG3re0HnENYYH3ZFLrCFTYH2YDsjet18xEM61VkLojlRLkHyNW
	 TsqtgSp/CHoByJkqHnuGp7gw8NkiMRWJ2YqcHYGvvTsk3g2JLj+gWtzRIK3SMaj7GNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299422;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5tPa97UU58+P4GX8mvJe24s8i2nxa2TwTM2LMFiU0pg=;
	b=ks6FtrAGJnOvhOqw2IG/oF84DA/12GpAelVoIo+XqxDdvl1CpnDWlYHrScd1dgM+n4Bk
	 Do62Lg/1yp3ll32UJ031sV/mjLJlFvbCPnmS2oRE4l1UgMtBrE/7rLcn6RhwYWLAUGaZn
	 KWdoGZKTuUPahuw8UbvG6GSODkzjJ+ZuW3a8ORDOQYKKz1bNQyl2mVMnp+M7jfGCgghGG
	 j22biJOplQzwVjQpKvw4dBj6Fx1JfJmr42L962j9p3pItidmEPXqoffbSrlxqbe5TVOAE
	 o3q1YtSA32CslJcuywUriG6kUtpJRKaryEV+17QzDghS7mCZsU/GPVAp3yXlHtoXRqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BE2GiH8S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D32606A321
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BE2GiH8S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBC91F01824;
	Thu, 29 Oct 2026 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299422;
	bh=5tPa97UU58+P4GX8mvJe24s8i2nxa2TwTM2LMFiU0pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BE2GiH8S62K+stwBdI4iQQetdsiEdlOsuNy9l8Py5DniXn9BPVySMYG8ZPXJpt3F7
	 5H3wTPPHIaPTdgSRx8ZeA3Q6zAco3U9qCtzvcPZUw4TU7ZyJhDkCCFssenpIoE9RcB
	 meASMV2IXrmXzp8+wG7u0ldhCeHjYBQpuSLaI4j6+Hwro/vwZmbum/Ny2Sw93VQF/H
	 P40+bGyHlJaF3mKn4Uu5Wgg45uEHbiTyyXk9pfONOHnn/6hcPjh5hI3P0ODtnuxdJF
	 gA1J4EGCtwexe0DbIpeq8Q5YK0mYqRWtAWzIK2Oze2XOY+Cs2YTsfXxEaRPcFIHX5z
	 PK0hqxAvuPE5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Hiroyuki Katsura <hk590@cam.ac.uk>,
	Vincent Donnefort <vdonnefort@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: Re: [PATCH 6.6.y] KVM: arm64: Transfer the hyp stack pages out of the host stage-2
Date: Thu, 29 Oct 2026 14:43:15 -0400
Message-ID: <2026-10-29-1-daily-reply-0008-kvm-arm64-hyp-stack-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029022509.2631522-1-mkbund@amazon.com>
References: <20261029022509.2631522-1-mkbund@amazon.com>
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

> [ 38f9e4b905a0 ("arm64: kvm: Introduce nvhe stack size constants") is
>   not backported because it converts nvhe stack code in eight files to
>   NVHE_STACK_SIZE, and the hyp stack here is one page, so PAGE_SIZE
>   replaces it. ]

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
