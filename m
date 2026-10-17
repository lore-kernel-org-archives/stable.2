Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7D737C109
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206042; cv=none; b=p11NEsBvwLR8VqZ7RPtuh0kEdP9dg9roeirS7L2VzFZZCUNB5+t5lOlX9elQebcCoCAzNDSJRyVFFv+x1oGVzqYeKNeFLFpnHh3LQ804NF7DfsaqZ7RmqpVFc152naydzdF2mPexTNltFOZtwr5yLQ5G9veFxBAhDP5K36KC/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206042; c=relaxed/simple;
	bh=/g8MM7UBQo7wXDPPynRci1jLZRyd6rKUFJmoa+rsAJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGIUd2LfwPSOzVH7kKKmDnMvhTgF8X9UnfyuLsCkML5P/8wPjX0V3J19PxLT+D4NSceT1XSu4Mpyddp5gM/JfS523JugYkkqXPyNehaNb/PbyAddzWcucEt+vtNqBUZSBOEBJSxJkbkFiP6SoefD7/WdYkPg20VDMAWGLxV8ex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlbgZHKk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlbgZHKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F3B1F000C6;
	Sat, 17 Oct 2026 03:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206038;
	bh=+r2mVM6exMXaeETVHquTVwr/XL/75xbpWlK6/Fp1U6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KlbgZHKkmbaTJwL+6F/M6ONkkTNMrG25zv2f+y14G34LFvkjzUzCHHjpa6Jk1ntUV
	 bA8zHcOP35QpKjiv1QKbl6GdCpms369F8YzDAOGrcw9dWmmSDNxzXgsN3SyYICyGp3
	 /1/igiAVVgr0JHSTFhnzVfBvXyu3pMxwVBqwUu2VB48tZ5B43oWUKu+xeTY6QJVu3q
	 Lkw9GLAOJvhR4Bp1jDZ/wxULhZa2K5grf3f8KmL/Wub5bSbp/QrKi7498RvHNABMb6
	 oyV9dylAXb5t8XRieL0vs4CYGFhMnrSK8ScLEemm7aALTzXxpln3Q1DA6G20vwPM3z
	 0QHyvlFH+ItFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	nh-open-source@amazon.com,
	Federico Parola <fparola@amazon.de>
Subject: Re: [PATCH 6.18.y 2/2] kho: free phys_bits bitmaps using free_page() in __kho_abort()
Date: Fri, 16 Oct 2026 23:00:16 -0400
Message-ID: <2026-10-16-1-daily-reply-0011-kho-free-page-2of2-needs-ack-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015144529.76911-3-fparola@amazon.de>
References: <20261015144529.76911-3-fparola@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is a stable-only patch. Upstream fixed it as a side effect of
> commit 99cd2ffac697 ("kho: don't unpreserve memory during abort"), which
> removes the tracking teardown from __kho_abort() altogether. That change

Patch 1/2 is queued for 6.18. I'm holding this one until we have an Acked-by
or Reviewed-by from a KHO maintainer (Pratyush, Mike or Pasha). It is a
stable-only fix with no upstream equivalent, so I'd like one of you to look at
it first.

-- 
Thanks,
Sasha
