Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE8643DED4
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125688; cv=none; b=BDKmO/PfI0WibKLKFxjmHYTv8sNPyl4liyb/MgW1ZKF7VLPPdZSTf4lSkyNfZMwBU7FJeXAc0ED9Ej6Y8SmeGC010cmWljwhuf1dHgEVkXnSYI79s0mbLxeaoMT+Jr0oVYC9yQdG5i37Rwaq1UzXlJZ25wXeDIf2if+d0HQPJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125688; c=relaxed/simple;
	bh=c2LKKRnE9e62RMo8jxTrtTEPcY5IhqXtiqGzWnW9wnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URjph1JDbc4WX0K1RgAd8eILWXX89e0rHVccW3KsokvFvSdzX9MIqsag7TE6zoEx9EyBkTbZ80AJLk7HhqGdmISvfNK2SzM6w1v7T4iHPJ3rXjIb6bdc+nzPEL/hq/mvL/AbsCfmgqxOLBaRvT2c9ZXSK5Z12n8WSA8V0ZAWwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAQc0/Aw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAQc0/Aw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C121F0089D;
	Fri, 11 Sep 2026 11:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125684;
	bh=b33qT5Neui8XMEoswOEhD/DPdp9M+0AH420sBS5jRTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fAQc0/AwW6UyvdHTQpFpecvXAurzjHUtFAM9QuEvSnMJT4VICIqgtcKNRukD5EhGl
	 AsHqW3PQ9BM3QE0P0m0diIvvDVDuGONeZoJBHt6Z+eT4xcw7pSBM3TZBqDmmKKM2c3
	 RkMeYs7V3ReHMyhp4PrSpTpk6VIjd3e69Trt8XAE9Jikic41v5oypTaGduZjOGXfHx
	 09NnCCWRnDbsQCetebNd3aoCDrYutgwkVv7LZxFT1Oy+NwZ0bnrG3NKTgUVR/RYsHl
	 ZethPgMuNxJhO5p2pa4fBqHzgfD3lW7B8GrnMccGUYAw2Fye78GBsGmOySIFLni8xd
	 WlK8AVAQ25dfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	doebel@amazon.de
Subject: Re: [PATCH 5.15.y] perf sched: Fix register_pid() overflow, strcpy, and BUG_ON
Date: Fri, 11 Sep 2026 07:20:44 -0400
Message-ID: <daily-reply-0025-re-perf-sched-register-pid-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909210503.199459-2-doebel@amazon.de>
References: <20260909210503.199459-2-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 5949d339f5ec98752d56dcd4e36f619a59d513a5 upstream.
>
> register_pid() has several issues when processing untrusted perf.data:
>
> 1. Integer overflow: (pid + 1) * sizeof(struct task_desc *) can wrap
>    to a small value on 32-bit systems when pid is large.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
