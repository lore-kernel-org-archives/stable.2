Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9740382381;
	Fri,  2 Oct 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950808; cv=none; b=QHjCda06rdL047pcvTxfdj6paNPR9h0DrTvOBbRZQtjCunDJ+XzjM0SPHFl0uBiuo8IylEKJ509fwGV//TRK/ndo6KmFx/QdQQi7vr2yQPhPlGFX1+qxXcKP/s0L+xZI7iWF++4UQBjuCnoVhemhxFaxqyioyf+PH55x/6ZKvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950808; c=relaxed/simple;
	bh=F6637lIoxTqCWLjNqNS62uXNaegqwTce7IZNpXGeX/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmHSMH+nfgUMdEt07rzxmRcCbHeeh80OJfRz7J+f4HDLs7b/KBB7mywHdLRa0f7SH1DaH3OWsrm0j9Bjch8qdpOBiyoMYPr+88Cu7EbQ4pJHxrrUQcJLmELsOs0auy3B0kozVBkOeBdqG4t//2IcdCR5ftIaHq6aVfm60G35SO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMAQU4R2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMAQU4R2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C2A1F00898;
	Fri,  2 Oct 2026 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950806;
	bh=70bYm59wPawnULmUm1UPkBUthL23ow/yFAgwQlZxiAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CMAQU4R2k+uRsz1Z/uZvewAJT0RD9X+yvjv4wdYJlgrAMXe/k9VHn2t7DPzEoNk2F
	 YxQQirRksKkMwr+138At1sMHNRaJ+X1j43cgGWzKILXVptsA0W/Ugfc9jMBPWbcA/i
	 VD+UA1f/VsxbeLF0vWtHN5hQQlw7dZ1fTNEVyAuysSGsvdICFqpS/5qFSb4h7sxpV/
	 AHLB5HNlZhOS3B9/MDs0WYlr8FNZ5LOnf4tI4O7y3LBUfrY/BMkNbQudUt/yeVoJIn
	 CrQAl3/HFClHuZcAYdVJFvNeI/1e+eaDXVZ2oODCOZdFiQwlRDyNHradwCh4m3cpCk
	 o+StC9PMkEJNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y v2] mm/damon/core: fix unconditionally skip last region
Date: Fri,  2 Oct 2026 10:19:50 -0400
Message-ID: <2026-10-01-1-daily-reply-0006-re-damon-skip-last-region-v2-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930101853.58786-1-sj@kernel.org>
References: <2026092948-moonrise-persecute-3597@gregkh> <20260930101853.58786-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix this by only resetting the charge_{target,addr}_from when last region
> is reached, only skipping when it is applied or cannot split.

I'll hold this until the damon_split_region_at() failure handling fix
you mentioned is posted, and then take 6.12, 6.6 and 6.1 together with
it.

-- 
Thanks,
Sasha
