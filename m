Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670103D25D0
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701647; cv=none; b=qgOoCpUXXQUdgX/nEg4nzEyl1Tp9UaEyubCJybgWTWlE8TN9gfib3scQ6reA41XLlSeXbntXIs1ShCq3wu0vQIQXvT21tCMHR1zGN/7RL9BvnYAPO4Ho4jf9d2WADDF6ftYgOYL+HVFO49uXGK/+arGZi6z0+WYA4qF3rATj6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701647; c=relaxed/simple;
	bh=LTDjVjm5uSXAv5nmLxGvETyvMEX5qogVHVhi1yHodtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PV7bhEEKCo8ScahuSg+Oov2X3SB+EpYanPURabMZCtdby8wynU/6JwF3Ubfomdi/zrKG6+nHjdaNeSfH5cww1OurfTy0inCOEVP+JXIJqmvfsAblBNIpcjiKuFWrcXjRFUUlP//A4i/PtszEj83/gHTJHEQxBqmyiUnmNgAPTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouFjjVwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouFjjVwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CD01F00A3E;
	Sun,  6 Sep 2026 13:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701643;
	bh=y4aP2qWCg0x1kud6Jvcl0C1MdE3ZytEIsL9sx0Su9vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ouFjjVwUBPJKUMA+pdNPqPDpw4sWkhJx39EHV+LhjVCk9VZhci4PQ+i5do74i3+Mo
	 cexxC4codJwG++Y4SaCOVvdkWdk3pEtrGk2pC1+8i+/xUyvJspqXpRn1iQymuhMSmK
	 CBtfZs8gy6uUO4K2zGDOtIS5kYcDduiWhshd76G2h1PrQsvoI5Uaxvhi6pbD7zfsLq
	 9A/tGDNmpX6K9z/lUtEauqjdSiPmfl+YAvVFNHMsMFao2vHPpMKPtQGwx7p9/TRuoa
	 TpO8AJf3j+FwjaLAEBoMSd3Fmd/iend4Wc3SMsyeIk33KEDyfYUqCmwLicBk36xQxH
	 CeeBhQ8cr9w7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 6.1.y] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sun,  6 Sep 2026 09:33:09 -0400
Message-ID: <2026-09-05-daily-reply-0039-fsnotify-stale-mask-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905024611.3934633-1-yjkwon0026@snu.ac.kr>
References: <20260905024611.3934633-1-yjkwon0026@snu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When a mark gets a new event bit, fanotify and inotify may avoid
> recalculating the object mask if the cached aggregate already contains that
> bit. This is racy with a recalculation triggered by a concurrent update to
> another mark on the same connector.
>
> The concurrent scan can read the mark before the new bit is added, while

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
