Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356054B0CBB;
	Wed, 16 Sep 2026 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557284; cv=none; b=fULmQvLQNxzLTGCA50wAPAVr736oNxJJpLq1jzW/uUwMvEIhCrbRLKPCTcODZrZ9vkFEN8hRPWFfngpstHDi6qfHyCq6e5xS4RIidKfw3Jm1MnrWlIdyXNveNRRCRRUF8krUGHOhJZCfdaBonZM5lKvPtRhCkqOfby2QqgY9AEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557284; c=relaxed/simple;
	bh=ErpIMsnziAOCfbktdoYdQ0qID5bjRfutEUyuO+0PJYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgXduayw8kOtkyFZ8K3u1trz7rjtMTHxOKz9Ac7zaN3xg46rbv1yxoVD9fW9svc9l6bDlBeQaQ/QU5x5qCIKSp0/YRN8Aa/g9C+HsZjOviu2Wrpaa/7M7Z4mCDkg7X8jgv4NynFgWQHMYNIQEXuoDcm1Zwdw4aFdb8t8LoAFPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ICBk4m4r; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ICBk4m4r"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789557260; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=ErpIMsnziAOCfbktdoYdQ0qID5bjRfutEUyuO+0PJYw=;
	b=ICBk4m4rmZOx4soLkdeDO0pn/beBru341f7cy14eM6LwkIywCFrU0XZP+os+3IccMmK1dbYHNZasAU6VP/JMR+muKGgx+FkJXlmNwHGgzwOokB3ZOR/tjqy5c9XetL04QFsUYu9oG4/9SDAa3xawiVVIiaemCbTOfXTdMfWmlN4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XB4kUmw_1789557248;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0XB4kUmw_1789557248 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 19:14:18 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: vbabka@kernel.org
Cc: akpm@linux-foundation.org,
	mgorman@techsingularity.net,
	linux-mm@kvack.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	henry.willard@oracle.com,
	david@kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: Re: [PATCH] mm/page_alloc: do not boost watermarks in kdump capture kernels
Date: Wed, 16 Sep 2026 19:14:05 +0800
Message-ID: <20260916111405.3687662-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <1a859476-36de-49a9-872f-a62f6eacb7f4@kernel.org>
References: <20260914131142.2984623-1-xiangzao@linux.alibaba.com> <1a859476-36de-49a9-872f-a62f6eacb7f4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/15/26 14:02, Vlastimil Babka wrote:
> Sounds like an oversight and we should deboost watermarks first before going
> for an oom kill? But I guess at the same time not boosting in the first
> place in kdump capture kernels makes sense and it's simpler to do.

Agreed. Deboosting before the OOM kill does look like a separate fix
worth doing, but it would change the OOM path for normal kernels too, so
this patch stays limited to the capture kernel.

> Hm while the large pageblocks on 64kb kernels are source of various
> surprises, this at least seems consistent to me. The check together with the
> clamp means we limit the boost to 1/4 of the zone regardless of pageblock
> size, right?

Yes: the check gives pageblock_nr_pages <= zone_managed_pages/4, and with
the large pageblocks here the clamp caps a single boost at one pageblock,
so watermark_boost <= pageblock_nr_pages <= zone_managed_pages/4.

> We should stop mentioning kdump capture kernels here then? They can't reach
> here anymore.

Right, capture kernels now return earlier, so the comment is stale.
I'll drop the kdump mention in a v2.

Thanks for looking at this.

Yuanhe
