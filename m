Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB173B8BBB;
	Wed, 15 Jul 2026 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086444; cv=none; b=Uv0eGasU3NiZ9EMuUBI/eVhmui9Du71bstJzIehuUVxM9hYVjuFwn7cAwLkUr8w13XM5goNk9hYfRyxuI1zwVXqti5OOcfkWh1voR7hayHcng18jelkIjyMpXjp/NtNOvtvtlsWKK0ImckOKJvOB2SvbzcrD99Hs2gWKLlVApwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086444; c=relaxed/simple;
	bh=SAqGjEWltCWntTr9lFfdexQCFMJTv7uS02KBC6KA8EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmPv0dWFT3u237SGFIegxOvxLewseS9eSao4sRYMGOxbvOJKhPTbY/pDgXDMGfy5EjnD9a0pFtiZArPwK6Sm8VVXTNQN6VBjRHCda8iPW47hrxPc/e2ygCasOvHZDy5NIxn+ZPb2ReLna45roghVpfb+J84QcQN3MyVYgVXJ1tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeIXtBkE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeIXtBkE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E4C1F000E9;
	Wed, 15 Jul 2026 03:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784086409;
	bh=EyyAlf2/bvw8+peozXRWIsuWIdLEd+I4yooKGgPuwrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oeIXtBkE3A5Lq2mlir6pP/PdAqoOEAqfMo/wK0x4C107XHmtPGKlJfJvbPlDeAVht
	 uGvfAw2E8GxgcDo9kqBuuX9oYCaCXgRRImmxDlO8dFYQB86C0Uf9wYVS1NOgSowfF5
	 m5nLi5oOg+2vAjRUz/8y4wsB0zRcoK0VPpcfjGidXzZHhgw8X48oCZRJ1NngtIJoJh
	 tp7RvK5lLTtHDgueVMw0pcGve4dP1ZcaBW6wOUiBBSCWSuTDSpLVGQtqVP9M0Q1OhL
	 h9A4K+yzPxth537CM9GHWQ32wlZpx/JlSrtTSkzYwjViyAjYssik1I3v2jzGaiRcNh
	 1dcGOPXXqx9xg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	SeongJae Park <sjpark@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v1.1 0/6] mm/damon: unurgent fixes for infinite loop, NULL de-ref and races
Date: Tue, 14 Jul 2026 20:33:25 -0700
Message-ID: <20260715033325.109466-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260715031002.108504-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Jul 2026 20:09:55 -0700 SJ Park <sj@kernel.org> wrote:

> Sashiko found a few issues in DAMON that could cause infinite loop, NULL
> dereference and monitoring results degradation.  The first two sounds
> scary but the infinite loop happens only under unreasonable user setup.
> The NULL dereference is only in a unit test.  Monitoring results
> degradation is trivial since it is only best-effort, and those happens
> from only unlikely races.  Still those are bugs that better to fix if
> possible. Fix those.

Sashiko found no blocker for this series.  Sashiko sent findings to damon@
mailing list [1], and I replied to all the comments.  Please read those for
details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
