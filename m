Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393743D4EC;
	Wed,  9 Sep 2026 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985618; cv=none; b=p3mcRaiQsDupNcWkjgILqUB2egK7NKm/e/zLM/9TkZSOURKShZeRB78tB2Ch7HkMlaCdue67Ocac8A86wCbXtRZuMPJn6kkp2uTwrcc3bsGYj8Iuif4lhU/sONnF1itdgHLLuyXo48Y7SAVIjo1sG2iRI9E2MkPjyLjZNOLk3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985618; c=relaxed/simple;
	bh=S89RVXW48StKYGoKKFHPszVzBBSDmS7JyoZbffiqILs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbJQ3A8bbkCLA/FEdRjdZLlW2NNsrnuVshSHfNUkcy43r1Y0Ku117FDx9t5r6KNWokifhGsYgyCI/MkMezHGbjOBpkDXxo4sfDnrKtwGTbTU2s3z/CyLSZD/byrYw1Rm+0K2hpbof/YAOvVM/teUxya9BuhAZjWs/9xQTW9yA/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC98vD4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC98vD4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8196C1F00893;
	Wed,  9 Sep 2026 20:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985612;
	bh=EdUROkwigQ0rxrT/wjnmvFurzk9fahLCbaeb6m80n5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nC98vD4aIcOFQua+HI5w9Wsg3xVXGJvfxP5Y5rQf8vKBGfV4RuuJxHuazKzvz80qR
	 fbeHlMI16Ej9ZO0dYMgk+3ZrtlnbVvJL11vkiL8bHZlSxklUSqk3VZco/Ql/s5cGS5
	 mKDZVWSoQSqjZut4sP46ylRgQ5NbwDrsRYL0xI9xiCkqNCWOPzFoVG8sG8eIBjBHs7
	 uC0y5XCQtMpHyO646L0w8y/Gn+shVhqZ63tD3NE01QSPRYh76Cz62Vyrzruo/hjAak
	 dtVMymV7ANE9gqMNjbr52z4To1kq2ThqYrH3X9d+CIZQOUEn1RGJCI/dM0ayIOBAzl
	 raUllys+F7rRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/damon/vaddr-kunit: check region count in three_regions test
Date: Wed,  9 Sep 2026 16:26:16 -0400
Message-ID: <2026-09-09-daily-reply-0018-damon-vaddr-kunit-three-regions-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909034509.142303-1-sj@kernel.org>
References: <20260909034509.142303-1-sj@kernel.org>
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

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
