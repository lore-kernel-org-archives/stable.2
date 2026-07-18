Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4702248A8;
	Sat, 18 Jul 2026 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784337215; cv=none; b=mdnRzskzTrTV1OquPwmPk2+G6A0/IOyhQoJ0inrOsTEzNjvaESV3UuwlaVaRmUPWuXNVluFzKnvWj2lwBoDt1JwBk/gIpUFejsr7t23KSasVVbz5mp7Megj/QMMjRlsz8X8fugRxCtKANNo/2xGMwcGM3gmVJMLYCADnKFocUbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784337215; c=relaxed/simple;
	bh=+vwaWL7bPjCxBrHbdLu5xU9nM3IH1cl77O60hwzNOFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwruN7Tn4RWU63PEN7pfaptrPvykk7wldbxJGQ30rUtHz7ItBOXluvGHM9CCOneA8I79pdOC5zvUS47UCUk4PZXq8PN0xGs92jJGUp+a3g+i1CfII1Pdc/EeYCDdELT6WgD2IpLInl6GznFm4bpTKtevckEOh6QAe5+a7Nlx9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZgRX3p3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZgRX3p3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B6E1F00A3A;
	Sat, 18 Jul 2026 01:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784337214;
	bh=/W/YiWHxrSOQzbisnMj63FpwIA6fnyz9f+4A5f0FVFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EZgRX3p3twD8Mf53Na7gn9w5HhL4x1Z9CEaA8WplCyEeU5KYw7hex7LTowSQ9cUvt
	 I639bn0Mh9rBvMpcwTibzThaEgL6XoVi4jxLxcHZzeP0uTEVgDfuMbpm4ELTvhUr+C
	 nKmV8sbuLohlH5vN80ktKBJT9dhdraPVICLZBElzhfc6q53hfFpJUYBKLgHnhNWvDR
	 wTseY/yRDWxTCHlgEPaA3pLVsBcwvX+CoSVyPs/+/uFNhe0RrlchwrQaBSVI+ivqXk
	 UrLevpeIybVMOAZoj2nnjSbM3hvyl/RgU0Lbn6SsDKv4YExF7Pfo5s1zcLtbL59VL1
	 HI23ziv/BSnww==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] mm/damon: fix uninitialized DAMOS field and kunit exec expectation bugs
Date: Fri, 17 Jul 2026 18:13:21 -0700
Message-ID: <20260718011322.94001-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718001442.87129-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 17 Jul 2026 17:14:34 -0700 SJ Park <sj@kernel.org> wrote:

> Fix a few Sashiko-found unurgent bugs.  Patch 1 fixes use of
> uninitialized damos->last_applied field.  Patches 2-7 fix DAMON kunit
> tests that do invalid memory access under test failures.

Sashiko found no blocker for this series.  Sashiko sent findings to damon@
mailing list [1], and I replied to all the comments.  Please read those for
details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
