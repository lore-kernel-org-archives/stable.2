Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E88495041;
	Thu,  3 Sep 2026 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443391; cv=none; b=A+ePJpVi063ZzwZgzXWr+a9Aarkk1rdU+oNn5F1fYIY5lONikaP9IaYUfvo8CnB6Ve0LK9Vr+YU+9yu/rMIGLuz6THi6hcKaT0aSMDawlWQx/AJC9Hb+AZO14gx5EM8+4u25xImFxuIOGM8+B0h6ccMnBm/C7x1IqR0czQvAtVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443391; c=relaxed/simple;
	bh=mzr2tSXvaH7QytRlE1diPlsz+ZNOf69Bgld2/cPQ4t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNugDX0lIShJAVghLZc1r6FDZ9wdHRx+NRKFB8faLUEBEb/uLBldoeJ7u68S/7konKElyeu7gzXnQbv+rAiCchJjhfo61eQq2cjLGHUwTraoMROzYu2iIiKPDoAJdhhgMz9NiN+0ClpNpzoybkPEIjR3wj5CgK0zl316cmkQ3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaeBrCsC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaeBrCsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077FC1F00ACA;
	Thu,  3 Sep 2026 13:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788443380;
	bh=N1gBpF65Vg6Gyw/Zq6rh5fI5TdbcUPlG3RhMgbn70b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FaeBrCsCT6Bl7pLBp0xGDbAO+DYJ1i8KLk0r28Fs2BQlmHWX95+u0w7z1rZFWtt9a
	 bzf22vPAdGdjddw2VNxD6l6iA8fWPC7C8ChSYOWN6yWRu4+I3RrP1PsYUuuHqkWBbq
	 QxM94vcd7FK5QCmetDCCNmZAPbD1JfYCwo23k1OHDwhUZO3j2acgBvsPfLX/1tw+Pz
	 2WP8nPz5hfbD6RcBuWJYmuUyxsrfrquTRa7a5P8Krg7mQiQlc4Mju94kRehlcNY5VA
	 n7MX0B2q3uPo/lhZV3xp5pshTus3KAZCX/mrU4i87RNYTjQTVDMQXHKXkWhGIQ+UTR
	 LpX/YBzzGg3FQ==
From: SJ Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
Date: Thu,  3 Sep 2026 06:49:32 -0700
Message-ID: <20260903134932.98268-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903084547.960584-1-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  3 Sep 2026 16:45:45 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:

> On Tue,  1 Sep 2026 17:27:22 -0700 SJ Park <sj@kernel.org> wrote:
[...]
> > This issue was discovered [1] by Sashiko.
> > 
> > [1] https://lore.kkernel.org/20260827045035.94611-1-sj@kernel.org
> 
> Hi SJ,
> 
> The fix is consistent with the other node-based quota metrics. I also 
> checked that damos_get_node_eligible_mem_bp() directly uses goal->nid 
> when calculating the current value.
> 
> One minor typo: the [1] has an extra k (kkernel should be kernel).

Nice catch, thank you Kunwu!  Andrew, could you please fix this when you pick
this series up?  Let me know if you prefer reposting the series with the fix.

> 
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Appreciate all the reviews, Kunwu!


Thanks,
SJ

[...]
