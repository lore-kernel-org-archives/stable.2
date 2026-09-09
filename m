Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417A9427F84;
	Wed,  9 Sep 2026 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985617; cv=none; b=VwAHk+3rgH+LpDEyobRliCftGj7WpyJv5KU7IbNlFclxX8SUQ/7XonQt0hapLpS4sqLbjcYHv2Jvc+HkN436JK+drUPzYVySbGvosmvZPpYlXUKCyJLEILfmpmL5Z+URFqtGMJjXF6qwJMxbuqgc4ct/IPIMw6xsrmBrqAmFsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985617; c=relaxed/simple;
	bh=QOz8oILwzIkuNI2IXSzp5g1joAugaSIqIUu43VWIh10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+r7UtjSxvmyKzA+ZgVjczPU+EKy6chGO1IbZKqb8JYqzKEyUZbZ92jN8GqDMm2PMmokc04agOvwas5e6ikWoA13GcOWkvBjqs6VCSHtjadeLX4PICegIPTLCam0L4fAh6ENzsD5XHObie+6E4w5zdO9eesrYxELDlgtRPJkpD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvfXWRXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvfXWRXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A3B1F00899;
	Wed,  9 Sep 2026 20:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985615;
	bh=zqjbqC8hHmd7gnA4RFeHpNUD/sKQZEj4QURqiD/ExKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OvfXWRXb5MlkpLb2cXjtbO4Nh4FWnCkDG2jAuYoaTxSSyLnCjA+SeaU2zpF/9vStO
	 ZAFqtl6WtLSayyogobLxwBMi42i99SMkkW8m2uOnDKwCxaF+tjAwTm4DqhWRE5A4xg
	 Zo/zu2bMD0GRIuSvOntY/wSaOtwX7Os60PIM986fMmeWAybIpSeckB6QPNN3vod3ss
	 JTEz6nziN/VZ1vsfAvjZgElqmT62aLz/4B3Tn7VaW1jUUrwwmN6tNhAnUyTb6351ZH
	 O9DlCeipTItbbAqD3Q1L0YGta8UeLzjAdJg9ZyTsXsUHKmkB7IHtXRDaQAc1JQVFwg
	 oHdQ+jJpNSN/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y] mm/damon/vaddr-kunit: check region count in three_regions test
Date: Wed,  9 Sep 2026 16:26:19 -0400
Message-ID: <2026-09-09-daily-reply-0021-damon-vaddr-kunit-three-regions-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909035105.154326-1-sj@kernel.org>
References: <20260909035105.154326-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> damon_do_test_apply_three_regions() iterates regions after
> damon_set_regions() call assuming the function would succeed at setting
> the number of regions the same to the expected one.  It might have failed.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
