Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055367;
	b=Z5+Ve2zpz3dIBddPpNupAl1zau1ZFSu0HMrOOubtqpyHXRcBZ8YZB0qEgz8BW6jy2nri
	 A1M8u3l187Q9/Srgggdtg14EAlfUkgJr6jVMp/vjxfBgDpzk7SyGFjOfreCEhBprFF/Ze
	 Z1iAnt/xJ4eyZDTSEmw1/7gwSWAUHYdJNGlxcjUgGe/ED7Gof54wSqP3MiWW9lTBlpVFw
	 uGoSTLpBHxU+ippZcGmENrQa40it+cYJe4JMg7oJv0EVphegp2Uq+QZJD3swKFB3xrrKW
	 L5jN6fSfD/MfPPCAgz/vaiPnsM+5rcfo0ubloaq9bDq3mPEWkEjKW26rV71F8uJx/Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055367;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1otLA+a9Ck17uJBdWOMD9aQZ7I1FL45z0Ke0U7Gcj7k=;
	b=E39jpQlRR4IJQPz1sCB7rcTjHiRah7E5+7t9NqgvsyPWqPD+5a/LgwuqvvzizM+lb3Sw
	 my86346mLJVx58lSI+w0q7lS+bbP1Kk+EifmTDOHjzmhvwrKrzxfI4beinl0lbAaRWigm
	 wfOsSe1YwanEfs1dUGTdXXUtcxhpZkRgZMmdVzKhRVRuuMeUXRuqVt7T9a/Emp8NXg8gn
	 3CKMLm4x39doNfn7Hu8LtU97n+QEwt6cndPpiF9232aBa4FEks+v1Wc+akEmIfTqTN4S4
	 BmAG80X2xDqwPNUHDBkfRZxIJTm7FPqlnRd+N7yUJWaC7PkBMr2jgC8cfVgGCErnGXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4wSkXnS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D50606A320;
	Mon, 26 Oct 2026 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4wSkXnS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E25C1F01825;
	Mon, 26 Oct 2026 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055366;
	bh=1otLA+a9Ck17uJBdWOMD9aQZ7I1FL45z0Ke0U7Gcj7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z4wSkXnSSasjyucKKu/pcwtqdTTfwU2z0R/BhMGq3RpwMSEUjaUFtpzZnDHVKI1cd
	 Iegnqi019w9RbfW6BTp+P+R9YApjVHI9SLuz7bx1+qOIkgqxUlT4gb2fmBckww35eq
	 LHSBKUHNaxZBDnvxKzuxI1Bgm12lEP/9WB4dFmS5Kn8tGJ5MCbhpWT7cyUexnu2WwA
	 qqefe2wsF9rJbXX9auxZA6RLQm7Gw4+Ca41F9xcjGFNbuwdBopCmRfBlhFbitwNTdj
	 Pe9X8rbV7UwrRwV5fbJQ9jyQoXTcHSNbd1XWi2D8ymUlAz3akS6xyg3ywBGjdmQ/zf
	 5+GhPpbAWnGMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-raid@vger.kernel.org,
	EOS - Manlio Morini <morini@eosdev.it>
Subject: Re: [5.15.y] Request to backport c567c86b90d4 (md/raid10 fstrim kernel crash)
Date: Mon, 26 Oct 2026 18:55:54 -0400
Message-ID: <2026-10-26-1-daily-reply-0003-md-io-acct-set-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <50c31a4e-9a41-46bf-9c70-ccbc1ed07b2e@eosdev.it>
References: <50c31a4e-9a41-46bf-9c70-ccbc1ed07b2e@eosdev.it>
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

> I'd like to request the backport of the following upstream commit to the
> Linux 5.15.y stable series:
>
> c567c86b90d4715081adfe5eb812141a5b6b4883
> md: move initialization and destruction of 'io_acct_set' to md.c

Queued for 5.15, thanks. The io_acct_set exit went into md_stop() and
md_free() rather than __md_stop(), since that is where 5.15 tears down the
other biosets.

-- 
Thanks,
Sasha
