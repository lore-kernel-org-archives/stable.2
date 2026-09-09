Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE2433BC1;
	Wed,  9 Sep 2026 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985621; cv=none; b=SmB9eyhkpK3azA0ojfn3TTSw7/9auOlCpFwmY1eVO+AGzDY/bQbXax9QUmmQjwn27FNm9H3A40JVI+AjpXJ+RdfIVBpyCmt8S7gtnbLKW/r3FK7I2Ahxp0wk1XI9ux0oIiHOz5S+S1l2hKUjgApG4gO8j5DtH+Q2dxB+W6M8Ryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985621; c=relaxed/simple;
	bh=F0D/KqHQGJbgkMB/TldtnBb8b5+GUShbG0d7045VeRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KObrIQWxTa8s/A3nTzT7q/NG+n5rTicLXoRuWehesSVjdzvlIXZCbfyvpTzSl8PevjSDrc+Q3ck+xWDoPjp5D1z8cqXApiqnZ+aY3PFfMVLDP6YHmNajJoIUziB0CLiUfgr7cUx5QBcl0wNWJG/+3DOszI3BaLJG/9mqzPjY+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6RHdlBY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6RHdlBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571CB1F0089D;
	Wed,  9 Sep 2026 20:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985616;
	bh=5+E7KYKIFyrcudWZXWOlsEHd6izyLsnokZ0DhhcOIBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A6RHdlBYZzWqprbT8FMx3vPD/BuyiupI0pGZIa2wW//5lKQMIHFPoZz67orSyt+PF
	 /SqTyA83ogIo4sUdzewSisgZ7iA8VtoSGbWB49oZ+9eV7r3/dKgKU7UwqamogXpZw8
	 lWPck6PiyELsJhSR6GRTxi6OrGHS716Si79CygId4Xs+C4BZGYU7BiM50oNH/RLpbq
	 srfRKbso/7a1Xx28SJ5CMbqHFwsJemEUpsThP7ADbm5NQX86N4z9PrU4f2pcVdCpQj
	 BEvcF65S54D/fBmCFk414bg9dESAjkIED/5EQr2TxnmQF3xWzQL2MK9sf0ENAbgdOd
	 7NE4CjpZXPozA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/damon/core-kunit: handle region split failure in filter_out()
Date: Wed,  9 Sep 2026 16:26:20 -0400
Message-ID: <2026-09-09-daily-reply-0022-damon-core-kunit-filter-out-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909040751.175004-1-sj@kernel.org>
References: <20260909040751.175004-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> damos_test_filter_out() test checks if damos_filter_match() of an address
> filter splits the region as expected under a given condition.  But, the
> test continued regardless of the split successes.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
