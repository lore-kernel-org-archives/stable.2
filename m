Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F5363087;
	Tue, 14 Jul 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039568; cv=none; b=Xz9uaoybDYEDv9thYjati/ds/e9unl50N56Rw/1xgzcXyIaZ4o19IBUZJlFdAh7YFaUSzVmQSHCz6oi7buedBevFS5GHmOwonZTGfkcrQTXdbVfxDbZZrBU76hu1619AIbnji37kuUcuya7FPrDY5oDh/HpWVAXjD56IMqv7/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039568; c=relaxed/simple;
	bh=cnThNbpOT7mEOezExLgH4EzRvvlsWUdaGxDU1BdYgMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKDLlMrmxfoTzAsdaF6Tt7+2yLBxINtzq/C/7hJgUEE8MU8HufwAA+ZCP+dZeCErDKPKIXLmeYvj2N7/+iWNQyFvzSCyJRlmOFNtwHTr9m0StOkToRbiIa43GeLhTqsIQoWGa+46JgMswUL9/q4BZ9Xe99cJIaAwU3E2SyhnRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ4dqq/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ4dqq/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689B91F000E9;
	Tue, 14 Jul 2026 14:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039562;
	bh=5/zj5P3kBIK7G1tNe4Uj26Vul5lA6c8YvgqeoVqk8Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZZ4dqq/NLYqzSBAfNqEuQPntKdDEgDfavpxCNEIReUT2xcPV9tGz8TIGmXkdJmtmm
	 nyaIZjSVagD1HUrgFxm/UBjbTlNEYIgP3rIl7n0meCQ2szIcUNjZ05f8aKXcZ86S0D
	 7ag9fFiulW78YngOCtCIvNf7WTvqyLFRunseiNJS4CYzTKUeigxoHPJAVrZOVK1Bhy
	 fSu+hxitS/iMtDtvBRaZTd8QJs+aKxwSODjhTa7lxZPi3Z6CdeZoT5d0BH7jEywOa0
	 +Cs5jPEytY5O5UGJ7R28senYzRux/PPPxGzWAJ8i/mDGmX5hcgK4/im3g5oGEeqdAF
	 66QJGXNFmnKxA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	SeongJae Park <sjpark@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/5] mm/damon: unurgent fixes for infinite loop, NULL de-ref and races
Date: Tue, 14 Jul 2026 07:32:34 -0700
Message-ID: <20260714143235.100843-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714135236.92699-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Jul 2026 06:52:28 -0700 SJ Park <sj@kernel.org> wrote:

> Sashiko found a few issues in DAMON that could cause infinite loop, NULL
> dereference and monitoring results degradation.  The first two sounds
> scary but the infinite loop happens only under unreasonable user setup.
> The NULL dereference is only in a unit test.  Monitoring results
> degradation is trivial since it is only best-effort, and those happens
> from only unlikely races.  Still those are bugs that better to fix if
> possible. Fix those.

Sashiko found one more bug that may better to be fixed together with this
series.  Also patch 5 mistakenly lacks its Fixes: tag.  I will post a new
version of this series with the fixes.  Please don't pick this series into
mm-new for now.


Thanks,
SJ

[...]
