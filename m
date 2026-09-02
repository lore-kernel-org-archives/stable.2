Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CBD1A6824;
	Wed,  2 Sep 2026 01:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311795; cv=none; b=H9wiV6XwJnwduGJXOCfekXGQIe9ycHeMDU/bKVWeg5my9XFIudNUUIZmYC8RmysZhjYsk1JWzxG+aFmhl7Pbt1TwC5+95XffPAq+U8gYVP8LaCEuZlINAsju4336VpBHJ/I6NPKJHlsq7N+2qebvs07/2SJUYtL37OMDBwwtYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311795; c=relaxed/simple;
	bh=PevI+KR9eQF1Ist90OvPl7sVPEdVYVA+UDSZTW4AZPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7gk3V21wq+FH0zZpzuY0Dq4PIe0bBJi4GKh9oh6vNSZsP0xK6POczB1pI2ruNNOelKvX8PVM4xHY6JQv5VCDs/WbL64VYtIRarbyjL6LZHf+zPhzlKMnzCZ89zBKSvbKQAYf8qWAVe4EGX4gQEPKuP0je5k1sUETBsMlQNnpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6VTk05m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6VTk05m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5557E1F000E9;
	Wed,  2 Sep 2026 01:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788311793;
	bh=3Mhxtqabf4BN/IkLfs+zcaKuZOjTdW8c4GvQzPk50rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B6VTk05mMB7XY9sH06GdL+3cstKc01C0XAWUzwKsOI+viYpXBgIWqv19h0pNBfyDS
	 yu6N3zjMGoyd8lCGBVKIACZ1ROaQQoIpSchThLqu5MBwsUhh5JBbro3HJvsyCBrQZ4
	 49AZtXRdQaAsaW0CF5AJz0LosDT+vqiJkrUiald9DrrXtJhTUcHej3czB3ApX9Uq22
	 Zg0jVQw/Nd+GKBFA8QcOFQUPwfRoxqWN92IeSculnOX7/OoNLIH6eojeFEFXoJPmPY
	 2QacL5mWp2xK3657euV5Upzqqs1Dhqy/u/4GMiVppTN0XKlSMFOP84qfpkLd1ePSW2
	 Fw02JSydlcPTg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm/damon: fix misc bugs in kunit, quota goals and sysfs refresh_ms
Date: Tue,  1 Sep 2026 18:16:20 -0700
Message-ID: <20260902011620.110326-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902002725.108635-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 17:27:19 -0700 SJ Park <sj@kernel.org> wrote:

> DAMOS quota goals commit unit test is mistakenly not testing a test case
> that was designed to test.  DAMOS quota goals and DAMON sysfs refresh_ms
> file have bugs that can produce non critical but still unexpected
> behaviors.  Fix the bugs.

Sashiko found no blocker for this series.  Sashiko sent findings to damon@
mailing list [1], and I replied to all the comments.  Please read those for
details.

Sashiko found a typo in the commit message of patch 3, though.  It should
's/QUITA/QUOTA/'.  I asked Andrew if he could fix it from his side.

[1] https://lore.kernel.org/damon/


Thanks,
SJ
