Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184492;
	b=r4wtPf0QmST3Jcxl1y2ATAFmYN3HrFx39Etkrlef/AB8OTvy1V2EkZ9w7kjzdXc7FDis
	 ru5SMLQF+3TwlzLUQXNP+spQltLIFrES/eiiOA4B6tZyUuW3+xgUAw/rmdDzRmW5jjLIg
	 U/OzS/k5lrX4EYsry3Bp40UfrS8HXIIQqSmgpUn7bi109CqCk4c+ESmBkJfcIafaTqRbm
	 jsUxnemNI9z/QqDtzKm+wb4JN+XfXJSDjfW8i5GtdXUpgJxMf+uX52vfUNfPMyoB+beti
	 tfdTiFK9RaoyEaZxZjo4Vlw8YVGGsiuwBjhtmf/2DoP+k3cuLpboKgaQr8FDOPu63PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184492;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7OCudfXEDg6cig4yHI+UL63p9GsP6rZU26NzHz6BN+I=;
	b=XtA6lQbUnK6yBVYSz/Iwm1JVB+X6pn0ePtEnNOOxSBGxpawWPOcdgqA3NxNqtKG5MjDe
	 oqKJDekzwXtjIV4ww6qfcwb7HeqXlsZOX7Hj3ZxM6SLkLsUhc+vd0lYnyI0G4zf2j81uR
	 IJBzurDqKwx0MM/zUmLSKuh3NNM0zx8Ht4g9dZvebrPJgGPFy3CFf0e8MExZyEWV3kC90
	 ongenilGj1snUVD8RgtIrEoDxj83x3d2SJStdoyMi1viCjuf6SDlTUbEYTKXDFd+nLf5+
	 ald8CPxBjAeYgFPtZU2w9Y5cPqRINQPCOKWraGbgotKx+OtOYezhtUuLDBVN0icIZrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebr0IUwg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A068A6082BE2;
	Mon,  9 Nov 2026 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebr0IUwg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B7F1F008A3;
	Mon,  9 Nov 2026 00:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184492;
	bh=7OCudfXEDg6cig4yHI+UL63p9GsP6rZU26NzHz6BN+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ebr0IUwgo91kruwpo9Hk3mbBwDRDTrBS6j7Ob50y75nFR8MmrRUyk6EB47MxXB772
	 08VUMfY1hsSWTKbXCpLVubJCmAi1kNLNoDSImKenxeWhQbOL2IJmETIz2ekO3JKBn/
	 A7HKMcdwLVKBaia4SYBC3dxPViIQOo+qwWeiz2d/Yc4LvLVb44UNbTCMWQsab7WExQ
	 gvzIXHHsMeDDu1RcC7x+qY4pOsN2YvlpXgd1OG5XbybiHIN+Mwb1Yp5hnvpm264UFd
	 eoAit+l/jZS5+pYH4ecbP11wbPkbZBzVrB06jqHENA4MCR0XXgZjw3y7qAKvzmMp3q
	 sOAdv2ROJWYCg==
From: Sasha Levin <sashal@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [RFC PATCH 6.12.y 3/5] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
Date: Sun,  8 Nov 2026 19:34:37 -0500
Message-ID: <2026-11-08-1-daily-reply-0009-damon-6-12-psi@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107214525.304638-4-sj@kernel.org>
References: <20261107214525.304638-4-sj@kernel.org>
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

> When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
> delta for the feedback loop is calculated using
> damos_quota_goal->last_psi_total.

Patches 1, 2, 4 and 5 are queued for 6.12.

This one doesn't apply: 610c4438fb66 ("mm/damon/core: error
damos_commit_quota_goal() for zero target_value") is queued for 6.12 and made
damos_commit_quota_goal() return int, so the `return 0;` has to be kept. Please
rebase it on the queue and resend.

-- 
Thanks,
Sasha
