Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982974;
	b=wkcCpRAjqLW1tr2r6+TWYkbBIY1O7tzP7lc16EOnfvOoqIwWna74pRpgazqhy4sZ1APl
	 ThEowV/Gutkbk91VrV6N0FvYH2eQCZZYWTV12mosKYA9ugf3ef+iY3dO1G3OKR/mJ39K7
	 KyxvYgG6c9u9kch21GIZUEgBzenPRS64YSN/SUu0A9iuNb6TurJW6/NGeuA0PjpOHZ9rq
	 OUuI7IHW05LieYo2NP0x6hBDs/Uvrpx4aykxAzHJqErHJ3voTEanqUiozWBv9ccyioorQ
	 hsSoU0pGbnXfp0/CcfjrSyYLWacwBx/0adT5tcmbbYXPQ7NNMlBBmAr+TEQuZ7dAVqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982974;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=f7QwotMZkYXsbgTCqlK9XdCUJPdjYh2tfsZr9k1KL7k=;
	b=nfTfHLndcL723ALi5NcBCeF3sxZvV+VUTB1m7yiOs68G0QvQMsscvhKiY978EhIk0yvv
	 iL4L/ZfIaanFesOLojS57+ZWn+pJcqsPrNnXJG/O2AVM6d8NoV9aIu1kesmCv2Fq0xFxY
	 HEoJSQllF8xd5u4O2qpIBpHTMqJFCJkt1SL84oorPKJAPFnO7OAPUy3X36J4ayMo7LiEB
	 WDYXNp+AZlbo9axNXXmskwOGQWLzPS3Um1BRjR5EhwWumArJDMyK9Cd/ZHqwdSl12Q25n
	 5JV0X4e1ENMgYWHcw/TXzSSe5c0UOX1DYq0T0OF9khAeUqF6qnZxFLG6V2yTiKgefZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OflSYXy8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AF0606D80A;
	Fri,  6 Nov 2026 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OflSYXy8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4131F008A4;
	Fri,  6 Nov 2026 16:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982973;
	bh=f7QwotMZkYXsbgTCqlK9XdCUJPdjYh2tfsZr9k1KL7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OflSYXy8rHQqjplK+M2SKEYGh2EE29t3QlEFKrNOdli1TJD1b6ppHDDmRZAInBSSE
	 Tq4gWnzWqzXJlmBqSSf67HszoAyCT++bJ8Rx53voxvcx6OzvkSr1zLPAfbSUI1PFPb
	 AlIDUo+YQwUmRPyqMLPMcOvtIKEoYFT2PCW9GMaDfnFypPcwWpvgi0puq3RZhL/Zqs
	 21AokdOadmrLch8la4AsJPz1UkgqqWlt3rMQhWvn4D5hFpZ/m2XKbLAEPWOgQgd7qd
	 V5BlElriKxUdir3EC4pg5VDKav4fS90qLTdBjWRbnEhHDolbwvwsFKw8aka0gha9Lz
	 IQObSQUFyxkfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Magnus Lindholm <linmag7@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH 7.1.y 7.2.y 7.3.y] alpha: honor force_successful_syscall_return() again
Date: Fri,  6 Nov 2026 11:35:50 -0500
Message-ID: <2026-11-06-1-daily-reply-0015-alpha-force-success@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105-alpha-force-success-fix-v1-1-8c26d60c5fff@gmail.com>
References: <20261105-alpha-force-success-fix-v1-1-8c26d60c5fff@gmail.com>
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

> This fix is for 7.1.y, 7.2.y and 7.3.y only.

Queued for 7.3, thanks.

-- 
Thanks,
Sasha
