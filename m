Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28734472558
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789926663; cv=none; b=JPiDvsi4KiM/RGgmucbHIvknHKJMjubIxc/DaN8PfIF9+6tmMoxKirREFlUabzOdaKGxxVEHFyt3sScWeZqHUjJUTUHOZLRvKqxXC/akMTf6e8xIAt8ay/7jwXmCJvsv1Epneac3wJL1hA4nXQbHcsugNu/aO4SYWltyplQ4CVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789926663; c=relaxed/simple;
	bh=rzEBqOyezeq2Jie13kxVYV96Yo3o5McOKYDVsO6LoB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBrKTLyeVG8fwic/yzAk0itc3Vs+KIwgT1P4Ix8OTEFnXVN1Zk7BbN/oJ14sF94T9CDEi/hxjB0Uq7QLxHrGYxp4errf5fLulgTnza6DNOnUqId7pxLmr6bPj1ERO8o5MCpKi8nFK87uFPO4sLSHwjwJXDeFeYfwDMmTvDa95jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLJ94IXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLJ94IXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7751F000FF;
	Sun, 20 Sep 2026 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789926662;
	bh=rPpFvubHFY0jFBcrXUvygELhsnWBAt0VGLkzQbF+17A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BLJ94IXGNef0t6Melsv45Y08NjS2ffW+EgQiW3yoEqnHVfpKDfqEevqG6AU0Vrqma
	 7lyPoeMCrQnviR2oRQujNykE2bGRBlxkEPXoR7QmrPhxeQ/elbHlm3VvBYi5b21onD
	 QTixfOxXUlAhLKmZQrEeGob2slB2Uv+e2NUiuuAdIV+/8p4mquAWRq9jg4TpAfiwVB
	 U/fnlJD1cz4FhKbYZQiE13MmD/zHuKlyPCruNjeiJMSvjqDS0HbCArNTOrJqf7/TTD
	 wV9xyl9+UVHs4get7iOy9xnOPUL5NM3f7ZEiE9jLiy+hJv6AjBr81yZTl/29BDz/DF
	 PZh8YL9yWNwTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	Steven Barrett <steven@liquorix.net>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Suleiman Souhlal <suleiman@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	Leno Hou <lenohou@gmail.com>,
	Wei Xu <weixugc@google.com>,
	Zeng Jingxiang <linuszeng@tencent.com>,
	Kairui Song <kasong@tencent.com>,
	Chris Li <chrisl@kernel.org>,
	"T.J. Mercier" <tjmercier@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@kernel.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Yuanchu Xie <yuanchu@google.com>
Subject: Re: [6.1.y PATCH 0/2] mm: vmscan: fix dirty folios throttling on cgroup v1 for MGLRU
Date: Sun, 20 Sep 2026 13:50:41 -0400
Message-ID: <2026-09-20-daily-reply-0009-re-mglru-dirty-throttling-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919-linux-6-1-y-v1-0-577b5191263c@gmail.com>
References: <20260919-linux-6-1-y-v1-0-577b5191263c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Patch 1 wakes up flushers conditionally when a memcg is about to OOM due
> to dirty caches.  It restores the flusher wakeup that was removed by
> 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle").

The wakeup ends up before the "done:" label in lru_gen_shrink_lruvec().
6.1 has two "goto done" exits, including the !delta case this is meant
to cover, and both jump past it, so the flusher never gets woken on the
path that matters.

Tree coverage is the other problem: 13b6b6209104 ("mm: vmscan: fix dirty
folios throttling on cgroup v1 for MGLRU") is absent from 6.6, 6.12 and
6.18, and 1bc542c6a0d1 ("mm/vmscan: wake up flushers conditionally to
avoid cgroup OOM") is absent from 6.6, so 6.1 alone would make an
upgrade a regression.

Could you respin covering 6.18, 6.12, 6.6 and 6.1? 5.15 and older have
no MGLRU.

-- 
Thanks,
Sasha
