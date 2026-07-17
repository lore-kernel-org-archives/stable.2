Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961E620DD51;
	Fri, 17 Jul 2026 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784250344; cv=none; b=auMXf8mgDcMh9BSpk/QdNsBQLvb1pnCmi6YkFY2MaVQLgZnygM1q79ioyo0Bvp7tJeQWMLR9BzdaMCBhtdGRk7zw19sacne3+KU+jEjbBk32wg0+ZIZcT0PG7qQI1pHXAJ2EFQxh3j/n9TGuINenhY2+2dFhe7eo1QrY1cz1fhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784250344; c=relaxed/simple;
	bh=+iH7krM+V3fHbXOuys4lhWfe5Pyuue+V6hAqRtGjiqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4K9aKAeBJvCEqgTV1g8bMr0roHXcQyfmW2xyIONsEf0+6IFawfpae+aLv22BcEH/yYWG/yRvRCUhb/pBOxWJmX9zYTGBiChwFIHKIDFjB4CZVcpQgWOFtJSAPnWoQ3uz4rrq2ZwPBC16jB4GhGH3rxLvOUkf/MT6soNJfFNTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt9MXMZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt9MXMZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B5D1F000E9;
	Fri, 17 Jul 2026 01:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784250343;
	bh=ogjg6JXEwNAVi6wkR63GVRchcCh3t5yDoHZWaPgOSMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tt9MXMZ7UaIQGJ5YgFFiAgmg2HPQANPh9gIj501W+lsWeY7HACMtll2wRe9RlReY7
	 JHu55b86htSwk3a+v1v5/nG1uMmHEBKPRBdbZkpuJLt4shx4k4U2VEiduNlz8iNsmT
	 5rgEfgeaSvwRyVsqn0OP2HpYJEpJFM0NEDzqQChuouYDmnUA4FBM1sxl5MVq35ZPGs
	 Or6EwYTPig2K3jjoyMi9dg3ZqgbsGzbFVtWQb+uN1h7DRJhft1uUINxh2F9XfjRXEv
	 znJS85XcHauSiqhyoVtN+EsyDHdKF1bsifEmQWQrSMQ163T2124iN+dgTkNMRYZA4G
	 6lKb9XC4myPEw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] mm/damon: fix uninitialized DAMOS field and kunit exec expectation bugs
Date: Thu, 16 Jul 2026 18:05:33 -0700
Message-ID: <20260717010533.120368-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717003022.119437-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 16 Jul 2026 17:30:14 -0700 SJ Park <sj@kernel.org> wrote:

> Fix a few Sashiko-found unurgent bugs.  Patch 1 fixes use of
> uninitialized damos->last_applied field.  Patches 2-7 fix DAMON kunit
> tests that do invalid memory access under test failures.

This was meant to be RFC, but I forgot adding the tag.  Andrew, please don't
merge this as is.  Sorry for confusing people.


Thanks,
SJ

[...]
