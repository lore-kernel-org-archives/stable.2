Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54E3550DB7;
	Tue,  8 Sep 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879056; cv=none; b=J9CZOdSfCNPWD3pT1BXOLn0aF14J28HWXyULouzqbf0s0MzYj8wHH+Z9VWJspQauSHO9Er8C5z2u6a4VaUKmsZJ6V5y8P3yesP64/FeJLaxAHEGYzxTabekVFQctqIlrsVZMf42ozvo/aLHooGauziJ/1HnlJaXzfAwQPJt+Qso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879056; c=relaxed/simple;
	bh=EJLqXkiCWXlqQF8O31sym5aWKijcmaEqdQQbvQk5QiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulmx2tTp/a71V2BgB7SVJ2DqEUv/Kn2FxVjBiBU/JsTb58Max2LLtBJAkdooDHWo49HbQ+b4mvTi6nSo5mKUdjfr8hC0gPXK9gyTuIPTZI7kGDXc2CD294KUNLfXex04H2Mlh6iUhcbcRs44qC+yQEAq/MCmIRpQwI1iilVZEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRMevG6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRMevG6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B191F00A3A;
	Tue,  8 Sep 2026 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788879043;
	bh=1pQNrk3rJgyZaUFqdcMUHuETyCztvxyMaMetlGBU29w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aRMevG6JLVYkL0wBFdrn6ynusrO/tCacdQm5POZg/Xma+pc21b9eOr63hXqZVDX9f
	 9nT477K6WHXvIvUqT6uVuj1B7p3WRGKeVzdI6hs+E0l6jIIrkMF9jHQR070UTCAahJ
	 wZLx0jeH6LJZCeFZUcmwL0l7bnLW53+qLeHyhAUtk8AKUc7c+f9ZzWRSbpWD1g8+Qr
	 YV790KYMzuV2tfcxOxFhTO8ZTE0z+WDRbsvhBlSxJ9exPaUwCLteDLpNsZX2a6J7sN
	 xPU8xSOrnuQ0nySeg5/4X73+ayIqQxsMkHW42K+HrQ/syfaKwYG5fGZ0qKHfcdOlPI
	 PfGAbb4pZTkXQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4] mm/damon/core: allow esz to be set to zero
Date: Tue,  8 Sep 2026 07:50:35 -0700
Message-ID: <20260908145036.104970-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908135413.97570-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  8 Sep 2026 06:54:11 -0700 SJ Park <sj@kernel.org> wrote:

> From: Liew Rui Yan <aethernet65535@gmail.com>
> 
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

Sashiko found a few pre-existing issues but no blocker for this patch.


Thanks,
SJ

[...]
