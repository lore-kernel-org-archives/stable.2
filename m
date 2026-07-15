Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C275188596;
	Wed, 15 Jul 2026 04:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784090766; cv=none; b=HXVId/nvYSwSWGGpV/+o3uGoESD/C27MNNxdfkuqY6ws6yhfseEq8ZhN/zx/DiGQnux+qYwVcKu8EJz5Fxj261XWtSqiiQ2qrHyXRP29vMHdY88HKnRysfOhVDKisDp9oj+Ypo1620LHBEip5SqeW4TDEsrFK1ZrU2YGKT1rhB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784090766; c=relaxed/simple;
	bh=EQs7O/KsN/wK8A+H5ZylPYHQYmQjSimXgQsiXtNU6b4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D4HdSRmT4+uQIg4gZI9jlolevr0P0aUDkHAL4tnl1yrq1TSIvA3mYBzabCsQ934t7BgqPmS21B7pWCOZQDo26Ya5dT1586YSEYH+hc1Pd8FVnT3o0S1WmjPQgc6UTXyCPEMS9GNbzT+gLhMtFv0Y28K9Rr/YXI217Eiss6+X/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=q4O8mCN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="q4O8mCN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0311F000E9;
	Wed, 15 Jul 2026 04:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784090765;
	bh=yPSXgtZyZUjPzhY0+tGPbfG3fWnFA8alzR4dcKz8MY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=q4O8mCN2Wldnjn2dROG4NkiHVkge2rzmi9u30M/YOygz85Hzobi2j0PY1EBOS2f75
	 vi70A6NF+w51j7g7FpFqmM30I7/b33bWqJk8/OxKpLUoeJsckqqCxZDh9FyRENit/G
	 2LV3lx5ZSMX8q/wLIeXQU3jBZd3EuN/KTX5kh49I=
Date: Tue, 14 Jul 2026 21:46:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@davidgow.net>, Fernand Sieber <sieberf@amazon.com>,
 Leonard Foerster <foersleo@amazon.de>, Quanmin Yan
 <yanquanmin1@huawei.com>, SeongJae Park <sjpark@amazon.de>, Shakeel Butt
 <shakeel.butt@linux.dev>, damon@lists.linux.dev,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1.1 0/6] mm/damon: unurgent fixes for infinite loop,
 NULL de-ref and races
Message-Id: <20260714214604.10fc4c786277eaed523d0724@linux-foundation.org>
In-Reply-To: <20260715031002.108504-1-sj@kernel.org>
References: <20260715031002.108504-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 20:09:55 -0700 SJ Park <sj@kernel.org> wrote:

> Sashiko found a few issues in DAMON that could cause infinite loop, NULL
> dereference and monitoring results degradation.  The first two sounds
> scary but the infinite loop happens only under unreasonable user setup.
> The NULL dereference is only in a unit test.  Monitoring results
> degradation is trivial since it is only best-effort, and those happens
> from only unlikely races.  Still those are bugs that better to fix if
> possible. Fix those.

> Subject: [PATCH v1.1 0/6] ...

So... what is the significance of "1.1" here?
