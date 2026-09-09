Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7F433E9E;
	Wed,  9 Sep 2026 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985612; cv=none; b=PXHzNBOy6M4C4oiuIvi2N8+ybOsnGFaSWSCwnzIhq6VYdbbVHSBHAGfOS2MAfvz00ce7c/00Mc5ZYS4SmrYHkDykr+tr4olYcfaYs5itRU+ixrMNj5b3yzkpFegmkUwmc78zhKVJCYOXZrRjnTwGz2uCo/rkh681b+U6luHHi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985612; c=relaxed/simple;
	bh=21pTxtd3c8J7gPSFmCfCOzvt1NTzrNY5EBCshX6gbdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iunTpyHxZk5yl3saQ58+kpda1bqiHQYzgRaT6/zhdjszkxE0jtc09WnMQ0YA8g1Glb9HoajQJtW+kDLdsf7l0RtffOllOVhSwpVmVw7l4oSzF+XR2hoZwk/N1e+oUnitJmgJ2uLNSirefchskj+0CLlK11eqquhRSbQr0AW3S1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE/pcZuN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE/pcZuN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812311F0089D;
	Wed,  9 Sep 2026 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985604;
	bh=iLIUmpQ7K4Z7Aqn4HYsMX6pWYMn6IsX+3cVABXHWyRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TE/pcZuN16TRyAUi1AAnyBoInOUfZHLOQlgPqZ8NVElVbdrN5T0i7i1zjelLiegb9
	 kr1g2x+oB5ZseSW9cji2Z0+PeJMqPDCuKA7z4FCay5VLANJlIlNN3CehhyKGG5NXka
	 IDlQb2lPOY1NLa/VzXutS5YF7mQp82D2CzpzqaXEixH9E0JBd/nUfpFh/My70tysRs
	 520wbSOl09j2cB4ykIrqyCE8R3gwnvV+OTzOu3q84UQ4/OrN+aRZ1kzSpNEna2bemE
	 sFCt4Ny11QZofN6I7Jk+8by7oNBy+Jv6EC2Kjw8XYIbEOVBHJm8wonE739yRoFSg8h
	 l4ruADnfYfN0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/core-kunit: check region count before testing in split_at()
Date: Wed,  9 Sep 2026 16:26:07 -0400
Message-ID: <2026-09-09-daily-reply-0009-damon-core-kunit-split-at-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909063631.101832-1-sj@kernel.org>
References: <20260909063631.101832-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> damon_test_split_at() test next region that is assumed to be created by
> damon_split_region_at() invocation.  But the split might fail.  In this
> case, the succeeding test may dereference invalid pointers returned by
> damon_next_region().

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
