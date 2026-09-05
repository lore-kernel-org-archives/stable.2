Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3F36A35C;
	Sat,  5 Sep 2026 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625117; cv=none; b=Be2PKKJlc6C+DYzm5ePUHH1eRPFng9RMCjthnZ0lJqsSlob9qdeTQU4bydQ+L2kCIjP/RxweQKdvxQ5a+RlSxcNWzBZycghzNNUFY5vwDFKFleYxWDM2e44UGaAdR8iJ3I4lazfn8LwLzyYcZ0zN8K7TYUM1HvcFQYVzAAK2Pm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625117; c=relaxed/simple;
	bh=qxlhRafRHfl0rdLfmuKP+h7eOjN1A3s+JUGYJT4w7fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1jdswIj6BI/tiXpFkdPKRxp8BhgQIetbtaobqqn+xderfSRs6s7fWkI15Ow2txj479n6FfcjYdxteKbNwyBaBbu0yfKfN7x7y4GIqblK0zhlya6WYfxs+Wp642xLIHsqEBCpy5xyBb5jCS2mIBdZqXYF1/USDSgLQ4R6ipTYZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8zgU9H0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8zgU9H0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127961F00A3D;
	Sat,  5 Sep 2026 16:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788625116;
	bh=ztJWHNndszqVgKLDx1R/A4VohrYyreeFEhhXiivVpqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i8zgU9H00aZpT70CsDofrzplGxWbwzHQdXgqfYP/hYddK7+05sSjsy0/uQ0qOdUg+
	 5x1hS1NIVbpNkhc5xBd51SDJvB/RKA929EuUuQGWIGGJ05/eQnYVfj9t2CVepYEjcD
	 aQ7MJCUS3a+CcfII222AgXhl217yNDg8HuSvMKLtKO2R+/mhBCjAhEuOXc9rLCBJ6n
	 hgp8ORGqLeIzMhWW0PYzETP9HXWpv8trvWguWjiUAf7JrPt8FTbLRlB+g+4CNBgrzu
	 jD6ISZ0S+tvoSenMT612tncv13lr2dtbWSM+CAKKSTfULK8Birn+BdUyA/+d5DgyXa
	 eYjEEB5M4gFnA==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/damon/core: allow esz to be set to zero
Date: Sat,  5 Sep 2026 09:18:27 -0700
Message-ID: <20260905161828.82068-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260905124706.3398-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Liew,

On Sat,  5 Sep 2026 20:44:58 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> When the temporal quota goal tuner determines that the goal has been
> achieved (score >= 10000), it sets esz_bp to zero so that the esz
> becomes zero.  However, damos_set_effective_quota() clamps the esz to
> min_region_sz when quota->ms is set.
> 
> This is a minor issue, the main problem is that it doesn't match the
> description in the documentation, which state that if the goal has
> already been [over-]achieved, the quota will be set to zero.
> 
> Fix this by set quota (esz) as minimum as possible.

Thank you for finding and fixing this.

> 
> Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")
> Cc: <stable@vger.kernel.org> # v7.1.x
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees



Thanks,
SJ

[...]
