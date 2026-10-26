Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055374;
	b=jMJMsEdaBfbSbWRVTamVsOowv5ikeQft/8iBtozakLt8LhBZTo5dRVDGb7YPp8qzAdPh
	 GeyXrNoA9LR+OwCwVKvXTyX425AyuIs4daLxBOrfj+yQ5odgwcK+rKgmBqrVTYO+ckbLK
	 9VbkEsCVElolHR+kFvm05SNDVKtqA5d7JWIOH0QilcKez/Pex5hp57d5chlopyIENzIw9
	 fhmeluNEjA5brdiPzNoUTzTBPy1AzPuZIPxCkcj2k9u75YTM6083yagl5ImJcFG80O6Gv
	 ss4tWt5ujXCe0oT5gkL54HPllqGiQK2wsaIMTrte+HW1bjxL+dDTQ5TlFE+pf2obguA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055374;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mgGwuSgO+LHbSNtILvRwP47fUfXrtbaHXe23L9i/K2s=;
	b=NMQHTuq9aFeeyreDJ5Wg3hzUw5ipxn3Jg78RJe4sNWWy6bk8bZ6tJWabCAG517U+vvmA
	 vLd8N3l+q45kEQLqOWC9ktvaOL7Zly/v8GLtP2u5N/x6TclW/09a6SQzwW6CDsmGqBHcz
	 KzGrA/69n4oEuyqt2qbXvB2vd28p4s8My1fb1U9Ud6nXwsT9BFqpJhCtmhg+SC8UBMs1R
	 mfA14yFQZ3AuD8vlwA//+wc9IV/6ZUlHQ1x3gJ/Av3YExi97D7rzwqJKPeMB/Cpg/8AmO
	 lQNFSZU0YaW5TyhY1050oWWzLBxcHTyGy7oPcKYD4Rjg/FQJAt49dLTX9e8EvhjXv5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/nP9CBH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B940606A32A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/nP9CBH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FC01F031E0;
	Mon, 26 Oct 2026 22:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055374;
	bh=mgGwuSgO+LHbSNtILvRwP47fUfXrtbaHXe23L9i/K2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y/nP9CBH9M44gsj1TY/WUoK9hW6hhIZJoftx5Id+VAiArIuPoyygyPYmQ+znlhZ7B
	 NrX8CcEa6Bxa+xspu9nlkMb5lMH6Xymet4BTC7S90ihZscsB1WZ3uWApjTtHXPOal+
	 keDgfjZgVQO5IPp9Dc8tXx0xd/dKDCHIETs32CeY5Qt+dtUYvX5Ci+cvXrBcQ7C/Ze
	 tVZrC+P75B2fBq1195tXn6f3l294eklGYeKCHDeo1EWn1vXZ68mdQSZ2GaVk+OPv8I
	 7XEnt+d/sYcd0GP4ExW/1cvrWe3QcFqrnqgfk179Qv211pgM2g6fZadqNKfGHSG5KI
	 /i3LATllMZByg==
From: Sasha Levin <sashal@kernel.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	stable@vger.kernel.org,
	sh_def@163.com
Cc: Sasha Levin <sashal@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 7.2.y] sched/fair: Avoid overflow in place_entity()
Date: Mon, 26 Oct 2026 18:56:00 -0400
Message-ID: <2026-10-26-1-daily-reply-0009-sched-place-entity-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026104109.1357489-1-vincent.guittot@linaro.org>
References: <20261026104109.1357489-1-vincent.guittot@linaro.org>
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

> Rewrite
>
>     lag * (load + weight) / load
>
> as
>
>     lag + lag * weight / load

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
