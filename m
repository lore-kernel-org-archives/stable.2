Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33313A3E68;
	Fri,  2 Oct 2026 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790964247; cv=none; b=lBK7jYcgWYkN8C8h+FWAwMdA/XUb2wrBa0nSytHJ0IeZxl0nzp/1twxPaZTYtMkE8mJphhk2MhNmhSmsucwktQB6A5wyPhhjYwnufNSqSklIJC767oJ5dnSOog/ILa/VLhFG8rWhAMpuuzhsUK4CNmlImmC6YTVzAePEz9xUW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790964247; c=relaxed/simple;
	bh=3+5SXdVssxXYhd4bnbCmX6IVleU8DvtPyKPIN/j9SKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqdZ1MagKae0Iu71YLyU/BHKzjcdMaUbKDEYtkUkl3njFqN0usIywO3SfHSYOFS4T630dtMF4ec/S2q8LemmaIXgIb8g4mI5SXfON2ljiz2RBgFdUNCkWE8KeZpowg6EZ1y5JfZ1rIQbcbU0AYzilbaf/4dbSyvS3M5w7AQxYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUwUCsHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUwUCsHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5051F000FF;
	Fri,  2 Oct 2026 18:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790964244;
	bh=KKxJu0PLcQiT2ca8a/oTPFd3rZcZIHyabzHB89pAcBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jUwUCsHxH0tmJ/n8/bXkn4jMCAusMAXGEXn7NiWj5udZvvK+BziBmR5wu+Vhp+RjD
	 nnH5vUgJ+9N7db2tuJrs75A6kpjgeh55Um92uLgSdNib9HAUJ16P90H1dOgrVYRQsK
	 b0vCmxwI2bm0GeAujrd2SJs3NwSyxzmydDreZxJjIR9VJYP5y7Ba04T/0l65tbLzqA
	 9D3UdUMZ9yiNAhz38q2Ow/6XQtbUwPdvmEMcMjrIaWlE5QBlVM4PBvwn45YxoCoeew
	 3Aj/PRm1bTzFM/E65S4YuiwUhnRYL4KsaMkTxgzM7zR3QUZIA/t6SRKc0miTOvk1ar
	 TH93VLcw5WoVw==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y v2] mm/damon/core: fix unconditionally skip last region
Date: Fri,  2 Oct 2026 11:03:59 -0700
Message-ID: <20261002180359.46078-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026-10-01-1-daily-reply-0006-re-damon-skip-last-region-v2-6-6@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  2 Oct 2026 10:19:50 -0400 Sasha Levin <sashal@kernel.org> wrote:

> > Fix this by only resetting the charge_{target,addr}_from when last region
> > is reached, only skipping when it is applied or cannot split.
> 
> I'll hold this until the damon_split_region_at() failure handling fix
> you mentioned is posted, and then take 6.12, 6.6 and 6.1 together with
> it.

Makes perfect sense to me.  I will post the fix with this patch.


Thanks,
SJ

[...]
