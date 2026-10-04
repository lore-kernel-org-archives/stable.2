Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE252FDC20;
	Sun,  4 Oct 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131402; cv=none; b=T1s2zWnJhNkmdtHUv13VAYia7MDjv+HLMtsuo0lkGB4sPLnMlEKONeMEIYb+CFA3apJfcb6WXOzDXtCLqZpKfJKvTjphn4nsM/NFlY9QLrK//mxYeA0jVCq8zdEn572DE2Y7ztcI+Z4zvouReInmt+b5VfO06BLPvp7gMAdVRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131402; c=relaxed/simple;
	bh=KliaJSf/Kubgbv84iSKKMro7NAMVM3nQjDKXNfBSoBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRIa2AM+iwbM+e2Hcq8AQ36cgblZOJ0u5JdVKxxLLl2E5t6qRxYZy3a9zbDfSoY/pmbUnVNAkRv6kR9auYztaTSQJXPAA40wLudyq8BCOGpQ30ALH+cCrFq8rk7vF3WQmMlT0vbMGMTqys/W+h/6W5GwudfUJWd/pcmD+Kdi1wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dH7NmgBy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH7NmgBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6B81F000FF;
	Sun,  4 Oct 2026 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131401;
	bh=97WWKyNUowiVmaJRkjk0Al/JXN2jGgBELzTH1zbyjYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dH7NmgBycpzyrZSdve1C8Fk8TXpjSh7JeCqZ+8ihWJ/HuR3oxJqwF9Oq1hdERXVWE
	 vyCYzU1ATQKgtRC+7Mmx+PDQ7iclPH8vYwLkg+5EBtCYqof275CGpRJBFmLmFz5IGJ
	 a//2TC6E5ElJ0act+1CRfkrUcatD0l/qcrIRN0KVZOLAFCQy6lYZ6Sl6jyVcpN06G1
	 Brj3skB1mAqRz7rypA/HIhAdN942xNbqDo6GN5ZrOcGpKshYNBUvWhoRA+L4TYOYLo
	 Jz3Be2L/wOr5lJeVqc3yDyFtzgeDrRndW1x64TQJJNDhXKvDkYFn8TQtdsDQnLaSmw
	 ZU9rGYoJAp7hg==
From: Sasha Levin <sashal@kernel.org>
To: ljs@kernel.org,
	rppt@kernel.org,
	peterz@infradead.org
Cc: Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	david@kernel.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	4ncienth@gmail.com,
	alexander.motin@truenas.com,
	caleb.stjohn@truenas.com,
	ameer.hamza@truenas.com
Subject: Re: [REGRESSION] secretmem: SIGBUS on memfd_secret() pages while perf record runs
Date: Sun,  4 Oct 2026 12:29:39 -0400
Message-ID: <2026-10-04-1-daily-reply-0001-secretmem-requeue@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002175651.811343-1-ameer.hamza@truenas.com>
References: <20261002175651.811343-1-ameer.hamza@truenas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Since commit 97d34aa65c29 ("mm/secretmem: properly account locked
> pages"), in v7.3-rc2 and the 6.18.52 and 7.2.5 backports, touching a
> memfd_secret() page for the first time fails with SIGBUS while the
> same user is running perf record, and read() into such a page fails
> with EFAULT.

Re-queued the secretmem accounting fix for 6.12, 6.6 and 6.1, per Lorenzo.
The perf fix will be needed on these trees once it lands.

-- 
Thanks,
Sasha
