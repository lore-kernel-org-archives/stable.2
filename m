Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F02DEA68;
	Thu, 10 Sep 2026 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002137; cv=none; b=ZeJMtlzC/B3RwJlehwGGrq/MRhVu4fSZiw480+bylnf3bzgy5c5U+/UI8F0KYqOjF6bYJMktnIx7v3XcAsJh6N60KNi4051FQBKjz5gFogckyQr6SG3lf639QTDRQMIwdAfcb8CihyQ9GlR70872bRbdGtSdRmI5l3XBm17YG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002137; c=relaxed/simple;
	bh=HNFyNCSWekecqfGGYhYMt3zNLGCx+oJFKh2qWwQ4DfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3UsH46ZYCEe6AAcsZKv3Hdw2dTONwr56KGeLz/F79YpAtzgAue6UFDWYQvk8RcQHlFJXyU99uvG3bUC3ovynkIXya8khOqBsSPMshnqsA9NS/oI5taHE4y0gsuk1k05IWAkwMP2D1cmjElPbosBNIAR8NVs4uyzfB9hXQA2IPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF7x4SRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF7x4SRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A07D1F000FF;
	Thu, 10 Sep 2026 01:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002136;
	bh=gIzAHGHZOqDl7Bi5BYw494RMcXu1WDUxaQt0fNOXS80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iF7x4SRHMXn/LlzIRtqgTjiFuTu9K6F1UPA+hALqoZzSMgzFKcINcFaZIqOS/XEK3
	 CZU06Z+2tGj+lOKGUWKQAvMf+/B3AdTr6IBUSc1lgOB9kFGLjf1yoBmgj2A+x2FPmM
	 JFbgbmE6sGF+0I3zsu9fTL14FQzSX1YVxmtCKjl4Qm6/26c0+M10jhK6sBGbggorEM
	 j4Ij0SzIFKLNttS9wMV2vJAkQQt7uY6Z2oyfXy5ZaGX6J4b8vA3uHSARzb8//6qy9x
	 AlM/L4j+oaaDO3XhRN6SRTk1WYTYJHLSkBKxMsLOEEm23xgxME4T1H6Qt9ov/MyZAt
	 7i75P/qRX6Yrw==
From: SJ Park <sj@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7.2.y] mm/damon/core: skip aging from repeated aggressive merging
Date: Wed,  9 Sep 2026 18:02:09 -0700
Message-ID: <20260910010209.126591-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090918-relic-padded-3b25@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 9 Sep 2026 14:19:27 +0200 Greg KH <greg@kroah.com> wrote:
[...]
> Does not apply to the latest 7.2.y queue :(

Thank you, just rebased the patch to 7.2.5-rc1 and posted as another reply [1].

As number of stable patches for DAMON is increasing, this kind of patch
applying-order based conflict might be even more common in future.  Maybe I
could reduce this kind of issues if I could post fixed patches as single patch
series, instead of replying to this kind of individual failure report.

I was initially worried if your workflow is dependent to the guided workflow
(replying ported patch as a reply to each failure report), and hence if this
could make your job more difficult.  But I know the stable patch submission
rules are quite flexible.  And you may already have good enough automation for
such small change.s  So as long as I keep the essential stable patches rule
(use 'cherry-pick -x' option and add target branch name as patch subject tag),
that might not really make your work worse?

If that is fine, I will try that from the next time, unless only single failure
is reported on the day.

[1] https://lore.kernel.org/20260910005213.126528-1-sj@kernel.org


Thanks,
SJ

[...]
