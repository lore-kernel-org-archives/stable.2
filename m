Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15CF554094;
	Wed,  9 Sep 2026 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985627; cv=none; b=gmph63AGzUxSylps9fRVCDshq0B0F8wLcNI99xa7Ek3c4LBQaytwZHhdvunpkAJIThVG//22+wSVnF76LjlLQQ5XgjPJ4AzDleBQTdaItlpUl/XhCcTbhe240uIQDXaO0JY/URIjHcnFXR065cDXVrfT+PeqOfNzKrcjR4Ycgc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985627; c=relaxed/simple;
	bh=X18Evf2aq3cqWGTL7eTsfIoQmYERCZQdvKZ9oJySDDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BN1/ArSXKUk4SuDW5l5ngsJYRPgQXFY2c93OCs7hRHa6flkHD8Gj/gFyLEAzuFRxkPEwDkAquVoV/fDMVVDnVoHqIrLlito+s+cvQJ9F74kVepeyFMg1dt9NuRvvhYHM4fXOObGQnvrOBZV9/0NmsfX9xc2380w4ifzKkP28PRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isr8JwUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isr8JwUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AD81F00893;
	Wed,  9 Sep 2026 20:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985620;
	bh=gMDrRFVXGjAKbcpRYPpezw/eoWd6efGpgjDGfcMSne4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=isr8JwUnQh3Dwp0icF0QcvMEcJns9Dncz2yq7DJTyNFjYpjdIYQgAZOFOs1zL7YUK
	 TGkkCbYJOT01ci7+LqJ/4uLeyO0ImKj12BX23rRpzCjxn2tJ3XzDSUrPZywveyFilq
	 PhaRKXrgcYY4DHOzXAU9VM9BpBiPZHW9MH0FCJhT6O1trnA8+peuwjB9NMka8hIfmr
	 b3ZokdeH4hXJz9BxlgsfrNxUb/eG3tEadToZI+Zlx3KDD3GO6UXnNrK3XfyPdWipvk
	 hQSUYVTB2d0REpwNuUXqZs/uLkDS+BgOUp67oi188wLhDG+T/HC9s2eCgvVcGe2wNd
	 3ICYu12I72J7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Wed,  9 Sep 2026 16:26:25 -0400
Message-ID: <2026-09-09-daily-reply-0027-damon-merge-regions-test-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909034038.133054-1-sj@kernel.org>
References: <20260909034038.133054-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> KUNIT_EXPECT_EQ() does not abort the execution of test code when the
> expectation is not met.  But damon_test_merge_regions_of() code after its
> initial KUNIT_EXPECT_EQ() call assumes the expectation is met.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
