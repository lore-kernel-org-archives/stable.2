Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079084;
	b=ChHjX4SbhSy6oJ//lel16C/U8KJQf9ibP0oWy1hCGZcCQf5FphRNPNdOHYgpgIcYXa9M
	 LumxNb3Wc0EeF43fKZ9hrwZI0ssRbgYvd2g4Wr322lItgGaOCQua6Im8GiZdzMGvsOOp4
	 WKFhI+0nOMsfojDh8RXSgOU00OTgHA6lMs4DIZuSF9DoXQlxjQgmmNaSpYNxkKgfQFCdH
	 HfyN6voXKhA9sDb/9+HdWIcLbiIaJ3BaHpklAGRSCAVsclx5t3Evqs4JHLIEJGfvZw71y
	 W6w6FNm68ndouncvmIPb2VmtgPic3iJ0axSOSQYd2r3IoPLr43n+pnD0r5wQeU2T0lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079084;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pMDXsVQlo53B/Jea2d02cSt/QDq/uqMOwjNLuSiLXBA=;
	b=mEZVYibC2RWayvhzVC4PyrlZkZCl7MlEoWWctr3cpMwSoL+il8HQVGc39N8whlzLjBna
	 CMfgILO4qqakRssO8ei4Mh5YwyO9jb7GsUrPxQe4/vfBN/Gj+Uqjl2WFfi7QvajyFWsB1
	 eTuTWJ0FpyHaFldNH9CeBfs2TuiOsgHzTf3LH79hGy4UHhB0r733Wab9w4Pc8bnM/q2iA
	 Pd0kPsjaHatkF1uA5Kar600SHDZlMuaJ3LgV+1dtsY8f5sdSGAs+FNJJDwKZwGy5lvXFS
	 C4mNjfrlgIH4yfBuLkZSyvIudEp5fqPn5tWiIVA7YxoCrDLGMXYRcZqpHhs+50kvJ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwGeSl7o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1832F606A326;
	Sat,  7 Nov 2026 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwGeSl7o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031FC1F0089F;
	Sat,  7 Nov 2026 19:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794079083;
	bh=pMDXsVQlo53B/Jea2d02cSt/QDq/uqMOwjNLuSiLXBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JwGeSl7osPilXOn4fEOKFGCmH4FoCFFT43dvV1v7/SA2WHYnE7cG9JAOP1gzTXmYo
	 /tsk+gWfXR1SCdMBypJM+XLo+vUiEGbkDHRNIGZGOyfCRy7IqGyQCEZY8J3vMNUuIt
	 r1dprwiCEtlYoBctP5HUeohOqW+HgU+hZsvJO1DpyG9Hh6SF/Ut7BhPepvVBPIMjH7
	 yO7Qh9+iIFYPiOLYINGWzzwgYU8YqNNyiLSarw7iRmhG915/0N0yl7QyO9pTtQ3LRN
	 Q1aL5zOBCD7bQYQM+ybKhGTvi14qspVRQ5fvD6DZvfPU2ZUGwJW6ZZm+40ORhCQHqm
	 Es9+O5LwkIn4A==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	kmehltretter@gmail.com,
	akpm@linux-foundation.org,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com,
	stable@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: keep the temporal tuner quota over an unmeasured PSI round" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 11:17:50 -0800
Message-ID: <20261107191751.195278-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107050853-failed-6.18-df7d9a0f8d91@kernel.org>
References: 
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

Hello,


On Sat,  7 Nov 2026 05:08:54 -0500 Sasha Levin <sashal@kernel.org> wrote:

> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

TL;DR: the patch is not needed for 6.18.y.  Please ignore this failure.

> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x df7d9a0f8d916eeea375430ae3360724afecde15
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050853-failed-6.18-df7d9a0f8d91@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'
> 
> Thanks,
> Sasha
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From df7d9a0f8d916eeea375430ae3360724afecde15 Mon Sep 17 00:00:00 2001
> From: Karl Mehltretter <kmehltretter@gmail.com>
> Date: Tue, 22 Sep 2026 22:51:37 -0700
> Subject: [PATCH] mm/damon/core: keep the temporal tuner quota over an
>  unmeasured PSI round
> 
> The patch in mm-unstable of subject "mm/damon/core: handle uninitialized
> damos_quota_goal->last_psi_total" scores a PSI quota goal without a
> previous sample as achieved.  This leaves the consist tuner's input
> unchanged, but the temporal tuner sets its quota to zero for an achieved
> goal.  A running scheme with a nonzero temporal quota therefore loses a
> charge window after a quota-goal commit.

This patch was meant to be squashed into the mm-unstable patch before being
mainlined.  But seems I failed at clearly communicating it to Andrew, and
checking it further.

This fixup is needed for only temporal tuner available kernel.  Temporal tuner
was merged on 7.1.  So, this patch is not needed for 6.18.y.

> 
> Use the effective quota to preserve the temporal tuner's previous
> goal-achievement state during an unmeasured round, as SJ suggested [1].
> Score the goal as achieved when the effective quota is zero and as not
> achieved otherwise.  A new scheme's initially zero quota stays zero, and
> the consist tuner's behavior is unchanged.
> 
> Move the PSI current-value calculation and last_psi_total update into a
> helper that takes the current PSI total.  This lets a unit test cover the
> unmeasured and measured rounds without depending on system memory
> pressure.
> 
> Link: https://lore.kernel.org/20260923055139.2982-1-sj@kernel.org
> Link: https://lore.kernel.org/damon/20260916001311.101024-1-sj@kernel.org/ [1]
> Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goal")

FWIW, the above Fixes: is the Fixes: of the mm-unstable patch that this patch
was intended to be squashed into.  Hence the above is incorrect.  Correct one
should be below:

Fixes: 29c6084658af ("mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total")
Cc: <stable@vger.kernel.org> # 7.4.x


Thanks,
SJ

[...]
