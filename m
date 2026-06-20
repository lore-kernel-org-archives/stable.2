Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D13932E5
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956510; cv=none; b=r2u1rMSlV5vfQWporSN5wQzl9xigWLJwYB+zC3tpMFPKFV95MZpfzHzdB28RcsE2Pm4WQOY/mEWWio8sRVhy5aHouEhJCW2Na8NK+2vNxEAtYb4j3ehgGJr8EHqLmoGZhPFqEOlZJZLnLHOSlpAU9y+Hv/cKIZq7XdEDeF1kdPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956510; c=relaxed/simple;
	bh=QXZmyCAn3kJqZQrtlLb+duvGFbht5wpZTNILjZn2wR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vA+CkdkoCduwqq5SBGyH4cIFdT+CZTaZ9NbrR0XNAfN8ev0lWDZNZpkpL13jV6DnIslKNROdS1Y5p828my9g3zu5qp9mjey2gOnkvCl88tUMmbSd/NY9/Jmwt0mtYOagvjEuLDyEgAoYkFy3as2XDyHbop+alIpTEr7NYUM1pw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytnlx9zi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytnlx9zi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258981F00A3A;
	Sat, 20 Jun 2026 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956508;
	bh=egcleAKw5AzHJbeXHUmgjj5sUkxMDV8ZP8FpY6GcMF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ytnlx9zito/suBubqbFm82MEGvNlZKGxt9xma0zoKK4On+rgLOUkss3cr4Miph7kR
	 qgwvJPqo2CPz0aOyeuNZHiCw9lKGCJfworRt5NI8apXzhPFfE6yVDr7Yk8n6CETcE9
	 ESXul3I0u0rsRU8+eC9oDAU8lWHjGfFQDCUYXXK7Q1J80zWPvmhewS1QaLIUv+SZCu
	 RXr5B4AfhZLCpWsS4PVIm+ej8Dzay9ZO0TRqta4+EvjRpbyYYC7eVCOAoCXdAr2wjX
	 c1tslkZq+Pyxen2OoqOVgFvX22od5WQIjqrViKzbI+Xn5j2j2BtTwILJZ6ip+BFT4F
	 TzU5XWKL9Gfhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	mathias@mongodb.com,
	peterz@infradead.org
Subject: Re: [PATCH 7.0] arm64/entry: Fix arm64-specific rseq brokenness
Date: Sat, 20 Jun 2026 07:54:55 -0400
Message-ID: <20260619.0005.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618151426.308099-1-mark.rutland@arm.com>
References: <20260618151426.308099-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 7.0] arm64/entry: Fix arm64-specific rseq brokenness

Queued for 7.0, thanks.

-- 
Thanks,
Sasha
