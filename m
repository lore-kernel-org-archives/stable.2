Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77651A9B46;
	Wed,  7 Oct 2026 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396499; cv=none; b=HcA47fzsrqlmrB62ciBN14xet4cjdKFmC11dwSHgIOFjU1NeWzOuwtp6L9dHBwaEc2ldfuseJUD0knfjiRCwNVq/OTKHXnQEAtvt+P1zYPPxouMzc8anFkNIbNPhPgSYgCjal0U5+CmocSN0I/6wT3twK3r8ioHc+RJwxTrDxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396499; c=relaxed/simple;
	bh=LTIRH2kLr3BOgw64k+T2QUT3hxTyl5tSMTKW0d3HZ4k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Llm2UMukbSpApBLQbeDmz9T+5cewJ8y/CBPtDVDD5FHC/viLhAvdwn6Bt6CDzyHB8zEgtquO9uVhzfJ0Z9uqu7vXtQaQjsEJD8Gf58F9PLf1PJ7gmAnbJP6ET3koUcgrcCa59w6+gtXj8QS32ELAUmkuzoI7NEgXwYB9JnIAHbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHaOdVER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHaOdVER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770301F00893;
	Wed,  7 Oct 2026 18:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791396498;
	bh=7LM/aMiHAful0oLbNYCa98apF114GGkzhJ1n2VrtRCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VHaOdVERBneQnWXamLowiV4uXMLVM/FK5RPmG0XRzgW5dW0+AaH//CuD2offcT/CX
	 /J7bTzVLJ8WqYct9UxFbtXzh58rQ/gAmQs5IFQMkSm9yb89Ebnq2L6jFJA46KmXpty
	 FTekTCzjS++xEV1zRKDA5e4Qd5gvCZY7NeNtINcAJ7LLojdh6G3xmeqfqLjxESUp5e
	 y1mdUguzYYKBo+VNdMu2EbPBhYtdm8OuUaJjvbIqVlB9Td+NUizmIDed2zhtv/W/eZ
	 7U+nsvHOv3HD904PFF+MeDyUkTzvBXav+VOCeEz4oixpBpevY3cxN0E6PQvtuNEPQv
	 UVj2v2UdplMpw==
Date: Wed, 07 Oct 2026 08:08:17 -1000
Message-ID: <ab3ac04626d5198f3dc5a4b1fccd5813@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Bui Viet Dung <dungvn2345@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
 Mike Snitzer <snitzer@hammerspace.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix NULL current_pwq deref in current_is_workqueue_mem_reclaim()
In-Reply-To: <20261007173324.227988-1-dungvn2345@gmail.com>
References: <20261007173324.227988-1-dungvn2345@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Hello, Dung.

The same fix was posted earlier by Pavankumar Kondeti and is now applied to
wq/for-7.3-fixes:

  https://lore.kernel.org/all/20260928-wq_mem_reclaim_fix-v1-1-0dd37125cf47@oss.qualcomm.com/

Thanks.

--
tejun
